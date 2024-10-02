# RMS - Backend

<div align="justify"> The RMS backend has three user roles: admin, sub-admin, and users. Admins have full access, sub-admins can manage resources they have created, and users can perform regular user-level actions. User attributes include name, email, and multiple addresses (with latitude/longitude coordinates). Admins and sub-admins also have name and email attributes and can hold multiple roles. The system provides various APIs, including fetching all restaurants, fetching restaurant dishes, calculating restaurant distance from a user's address, listing sub-admins (admin only), and listing or creating users, restaurants, and dishes (admin and sub-admin, with role-based restrictions). It also includes login and logout functionality, with secure access managed by role-based permissions. JWT-based session management ensures secure authentication and authorization, providing a robust and efficient structure for user interactions. <div>

# Tech Stack Used

<ul>
  <li>Golang</li>
  <li>PostgreSQL</li>
  <li>Chi</li>
  <li>JWT</li>
</ul>
