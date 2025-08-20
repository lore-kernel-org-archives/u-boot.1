Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C28BCA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 10:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4234E80FA1;
	Wed, 20 Aug 2025 12:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rbFll8Fa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79C078211F; Wed, 20 Aug 2025 12:06:18 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5038E8003E
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 12:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=treding@nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilKDVXjfsDzDflzc4exvn0AWdyA/ApEsMJtbPX464wydpkqr/L5bcn1Gro075zgWBPvzn464tVXJ02HiY6ZyE8Q1K5OukUWgLG73tZCzC638yuAcq5nlH/wMWmjWr1qKsYP7njYd+Ahz4z/sqo5kfnCrNAcblOiLZuIAbUqTltqi8vPIV3ZOw1G6W5x4c7s+BmIhJAyZ3RRnsgxG/6dkmu460czkYAzpqeNKzhyxvmbkC72qLtmanh8SPQEo8qaT56caN+GOxtz0mN6Q/xzPNJUloQ+I9eJt3vrdzr+zNO48PXlpRCtjk+RMGttPxg3e00nnqLjTTxBYjJCEuM0mKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgF7i6d24dCi0Kha4pqNC8/SuppzReG0bmXmitT08u8=;
 b=VI3qTjRvuv03yWT6Njdeid01JiJIniuZJY7W/behtL1qzH44XIkD9HG7mMA/7fDC6X1LuGe76PDyOzHpWuhWDQVdey2vS/g/t5oFbX5Si3SgbwWmPlNW1TYoNP/TV3IOCpGTltXyz8arNgyXLxst/mReyVjEq2qzrBlB9rNnDFOyJh7PH61vAwYA56iFkQm7OUaryMUz8c299JLupiaLIJ2S4o3f1ff0B1okrnv0z0Vxxgu/UbY9Rv1uvRGErUPBlyEFlVObahS6Mm3QLtq+5+LMvgsWYZgbc+yS/SJMQccNQ+6oRtistP3DyGAsZ00NGg0TTnz7yoeOZP1nTeDanQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgF7i6d24dCi0Kha4pqNC8/SuppzReG0bmXmitT08u8=;
 b=rbFll8Faj0WLEPrQLhI9NOZvUXvHkxwkFaPgJ7HEhVa1W8Ni4n0beHXJm2fs/RsvUa9MoKrY2R+mFjL2d1UhLXd960Xgvk2BfOHWW6KlHNlg6x2/xEMLOo1H3iFzvLdVgkHiLB5xi9k7rilaqIUsLddymqLoD3dSL28q9zNfdKeMTjgojFBtRzvebN9XikXHd0RclnPZW6D9eJDXZ3EGGfdk/sawZPLLYmFO3ZC6j8Sg2wzxD0vTmcDiTSwJFhcfvmPxRyLp0+ENMOgeWlpYLqyMTEY6TTd/SlXTjEJPRUk2BPpt1z/SNRqa2QrpuuXmp5Vxlchx+6JxeQwlzb9N8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) by
 SJ5PPF1C7838BF6.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Wed, 20 Aug
 2025 10:06:12 +0000
Received: from DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c]) by DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c%4]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 10:06:11 +0000
Date: Wed, 20 Aug 2025 12:06:07 +0200
From: Thierry Reding <treding@nvidia.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Tom Warren <twarren@nvidia.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] p3450: reduce size of Jetson Nano u-boot.bin
Message-ID: <mvb65rhgfd6opwxzusjrmcczmp2ovsqvsn2y4dgvnl663keqyc@56sd6lovajqv>
X-NVConfidentiality: public
References: <20250819154025.604784-1-pbrobinson@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2lcsbd7htlxpv47s"
Content-Disposition: inline
In-Reply-To: <20250819154025.604784-1-pbrobinson@gmail.com>
X-ClientProxiedBy: FR0P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::12) To DS0PR12MB8317.namprd12.prod.outlook.com
 (2603:10b6:8:f4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8317:EE_|SJ5PPF1C7838BF6:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c864a5-5b4e-4094-dc78-08dddfd130d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QX7PIg8uwihkVQgTlxlbdtLcdHnRJ+kgH6ksTnIybHGNYtTOSL2+XFgUxeu4?=
 =?us-ascii?Q?AmbAPdgJQ+7qJQrrlTgez3tg2y+sNe25RbzBGTEeHmDLebWrQmzkOpgNXy78?=
 =?us-ascii?Q?ntY6yT4y92kFtudqC7T5hhtLuEXsAEhYJxVn/YgtM/VAI1ydMYBu5giJpxRu?=
 =?us-ascii?Q?77u01bCWQ9FU50Gb6vnIigUo4syxBPOm3Iyiw4RcGfq3B/1/w6Sv7KDGsoxX?=
 =?us-ascii?Q?t9XY1EQly6sTle5tBQ+N57neOvqXB7hk0JkuSifz7pLMmLMPvlVbtmkJDV9c?=
 =?us-ascii?Q?h8PiOwXlFuDIMcWz3Xk9btjz3u7VuzTUOuSD3UeHu3BoupuB37hKL/ynQrJk?=
 =?us-ascii?Q?kZGaCX11+NmHBAzzThUIC5qnXLEITeIHkqNBdVA7kJXN8ORtbcvN7YedLU1z?=
 =?us-ascii?Q?yy3A2V7bwCUk9TweWoCRN/qu/kuRgxy9kH3msdcE8Mnl3tEz64lHzAXEeqnG?=
 =?us-ascii?Q?bvqphy8woUwqKqhgzKwL0KS3riqR15lPTskPZfTjUh4UkTbWtkGdH862otL7?=
 =?us-ascii?Q?owXe0ViTi2aMDgVKAcMROj6WySDd2wBdeQvl7xpTcWJo/qw4JFA7wJtAKS5V?=
 =?us-ascii?Q?1nbIB+7SYbGEN4tIs9CoSQekyTJuhmNANWj35GN915f2pmLGTKfaBIuL+cpu?=
 =?us-ascii?Q?uIR7ImiVUk9aZslW+6JTKdDujWtr1mVQyqlTxeA3Nijc02bO64DLlr17y30n?=
 =?us-ascii?Q?z39InjszcvPdz7nAbuYYfDt3m20UbsY2bMO79YDSWQXBRWKmxViO2w2hbfGP?=
 =?us-ascii?Q?8XTrHiXMzd1MFAItZJAW33TyqiENNuQaeIt3DsxtNh6myPdL5WO+d0FG1xHs?=
 =?us-ascii?Q?91KiYk297Z1XbYTgJYN9V0MPfF1wA3Hnaw2AI4kEmWPSwVphnXpXQei35K2g?=
 =?us-ascii?Q?45RDrlU4NNt+U9a+Y5vClGuohl1vfpPvqLwlV2W9jKwFX2KDBawNh2tfMRK9?=
 =?us-ascii?Q?oSTCDjlW85m7QB/eNR1vWM8iZDq9gT0mDMD8KvGzfh2Cqrd2UXYxQEydnYgS?=
 =?us-ascii?Q?EyOEjk8uG7quVlzAVPY9btHaXEs5j+78IIwO3ddGLe3tlKfEHAZsBsdQLUbT?=
 =?us-ascii?Q?ipeLoek6F0apoh2MvsepDjB8TTs9AjNKqu6G1rYttmlf2osIeYuIMxRiY5bC?=
 =?us-ascii?Q?NEcOiq+MmMjNIOfNmerSachAkQjHbORptGaddX199rz5WC612d7h0aUI2msN?=
 =?us-ascii?Q?TA7qgtcwcVYWl5nbA5KeAuY+zEGvC/3bbTcv2XA0JxF6l05m2I91Ho5p3Ngl?=
 =?us-ascii?Q?VROzlm+hzr97//6QAh4Byihvll77q0V+BqYNRI8QvAJhGHXYYnbM7T1q8jGn?=
 =?us-ascii?Q?33533z5rVlJnvKJULuuEbi8q/77jZehSahL6ZHjrj4uqdY8HRMT9ZRoXLhKy?=
 =?us-ascii?Q?NKdN/bgWkK+1AdHARPuGfXNA2ouH2boelhjQh7FrH6qtflaB0PzvfmthpYHq?=
 =?us-ascii?Q?G0JZ+PjSccU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PbQfUIVsXJIcOcM5iNBrC+JPYEV3z4OUsAlkIlziLOrb8lfiCb/CwG3fkiU/?=
 =?us-ascii?Q?ecpg3UBNXtVbcfs1/7MPin+lyLIRiHGTExhgi9hvsL/jUXzo4wJBr/aVUrIA?=
 =?us-ascii?Q?1CfRhgrV9R5R5hmg9LE091ERcF/czy4rwLjWVMlKMgjW9QrlnHPHhp22lCk9?=
 =?us-ascii?Q?DmZ+0BLLk/v3q7oozZOjn6d/XkJg/0Ndy0rPhdMIMdnCNQZTSCdcJPthd2eT?=
 =?us-ascii?Q?9G6T59cVpyE6ekXuKoG11iRt7UTIUS/DUPoAqlr3nHTU0f1foJcF3hbziXkU?=
 =?us-ascii?Q?YfN21GBLsISIZvRX4VxJKQoiqe5oHpKL3NCPHMcrbjFAC71yDMKMoUZyh+Te?=
 =?us-ascii?Q?LP/RKLRiM6QS+d5YkSowDFg38F+pgrP8r9BOjjkoG01PnZrCoJoLZZSzltEN?=
 =?us-ascii?Q?St0+//Wrw/HdW02i1/JHeNZ0G08CfEAX9nx2G74ctIJOFlPxT0MATusFuHOV?=
 =?us-ascii?Q?gn4OJVbgq6Bpw9Aiv5JnqM8g4ihvO5SPttlVt0V05tLhq0mH+Co/7B8qs0SC?=
 =?us-ascii?Q?VK2wxnJqWX6YA7mqUVzD6w5eT82xnXz/UzWRJRCPS5n87pMkAdNctEEGQzZv?=
 =?us-ascii?Q?Pse3TdQzgKsWiIIBLUojtztinCF5LkoX0n570ovRd0kIzBYMxZ9nLHl9fOCT?=
 =?us-ascii?Q?YkFqyz1ivdNgXayvIBcn6GjKoPlkMry3dBqWg3VqqErDGrM60eHx0ycB0jhK?=
 =?us-ascii?Q?fry9ZNFzMAFCJw6rsWEFBFOI5scu2NezbMH2oxsul1X5KDy4ddEn4MTEn1kt?=
 =?us-ascii?Q?2TRTdrigW2De6Y5W+47QIx87oXu5fPaLsK03lPD9azDFZmVYUvZr/HsrgRbx?=
 =?us-ascii?Q?FcCKsSCUeYSaogIzqh3dmfV4t/uGuzR/sihYSyWlcdrqDCeVxCZCt/nxK7j9?=
 =?us-ascii?Q?wbGGNgYNpPPfpkfAkTngTJb/ogyGil3RoxfYu074E+NcOJU3zNZZvir0AIUU?=
 =?us-ascii?Q?qqC3SOFg0INz3PZ4Z1xYxtq05BqEo20NjlYAArhh3ntqRijuTeIjb9EQHSop?=
 =?us-ascii?Q?rHuFDqdmsQEr5qNwaPVOD+hq6gcmUC1Z0TgavYkUXjyYIkiruW+H5pp7xLxB?=
 =?us-ascii?Q?KidyrfsRLEPzciLhOeoh9eJVb/t6msBluL5z0n2KMslL0Of/14evkExaa+SS?=
 =?us-ascii?Q?9ortoxEB0atLlRZuUljmg++niJ1huu+4xR/kBzC95a8WvEqd/Gaw4oxPU1KL?=
 =?us-ascii?Q?H+V8ioZ6cSdm1HXZv3x0LO6si0GpwhfD2znJNFLrdYVWxStmbXawS9SXNwTJ?=
 =?us-ascii?Q?tXfAqXr+o3Aq42gooQj1HLur1E1jheDLbmBiQ+UJWqYKRjH9XkWUy8oog6of?=
 =?us-ascii?Q?gk1Z+VfiuGSkYIRATefut01j8Lk3NSVJQJjV6qW/LXsaOoSUQj/gvUnrkYmb?=
 =?us-ascii?Q?eCUwJERBSzT0eXVi15MlHtkJf34kJyCXkUMojJF1yG3VOQTlizMaZzI2dNDr?=
 =?us-ascii?Q?VRWRv6XYFskK2htV15e3NYC5TBi7HVQwcidx06AGbm2y4it8gq974fLlXFwY?=
 =?us-ascii?Q?TfC+quBUTHBtl5eSBTTC2vdT3Jx81bL/PzmLnddxnkdL4PG02sLS+j+r/Br9?=
 =?us-ascii?Q?pNEbnUgnLgHLA7FjEoWj9zrDUUqotJafF9U3ECp5XKk5BDU1+xhN3P4HBne3?=
 =?us-ascii?Q?sCT5tnnXRNGe3JJVPO3y8jhYb1LWZAI/LG/fQ3ePAXip?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c864a5-5b4e-4094-dc78-08dddfd130d2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 10:06:11.8914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jwig+sEb84jNJAgPqE9p8PV2uxK3zYvZmi1SeuzXBkC/THDwPOFpDTnGvms3AH0mBHnXUm+h/BEbdW80UFJ1Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1C7838BF6
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--2lcsbd7htlxpv47s
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] p3450: reduce size of Jetson Nano u-boot.bin
MIME-Version: 1.0

On Tue, Aug 19, 2025 at 04:40:13PM +0100, Peter Robinson wrote:
> The Jetson Nano contains all it's firmware on a 4Mb SPI
> flash, the allocated size in that flash for U-Boot is
> 753664 bytes so we need to ensure the u-boot.bin doesn't
> exceed that else it will fail.
>=20
> Add a BOARD_SIZE_LIMIT and drop a few large, and somewhat
> esoteric, options to bring us back under that limit.
>=20
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  configs/p3450-0000_defconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--2lcsbd7htlxpv47s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmilng8ACgkQ3SOs138+
s6GQUQ//dU+YT0Ck0ZziB/pCrj/CzCTgS5cGbP0qEWNu+9Xt6obPVLK8EY2lgjlP
GCdMB/2Ms674t8NF+v+RZ9h+43BsaSnpCk3M5RRxfoBPcUjKjV/CSRKwyfvgW3y6
liWEJbfNLkE4+WbhLb4Z+e3Ro3td1ytOwsypbSRzD1Ehyae+68LuMwh+uMNmBmCq
THuXo1PK/Ieev8b2OEZ3o93n0UIQ/Fd9RdmV4TE+hz7OvGaZxkYAONEsdlXjsdtZ
vhHzeIamLKdOsvslOEV4hW0F+9L9FoH6rRdmE2oHNmP6aHUNP0v0BuqBd+4m3vzC
qkMl6KqMStKiQ3bR7RmCy4I/XGU/srIoQ7KdLSmR37wwcVfF0FQNsd6k/6HuZsfZ
c9w9MC2wG/z8Y5i46cBzuAJQN2n9eUF9BL3c0RhIkmxoQTW9kthytiLHPZAbmPmn
m30j5aKR88jtaAEYDkL2It6xpLrUwhvrpfEIUFUGkSI4aOk8qY6aLpqdzcz2IUci
geL1ZYCXV9nuawm4WHnQH7fyL4Dwe0HJ8U6FOshZqrBj4QpU01bR6h2jBnHiW4YH
jTLAN0+31jW8k5jv+Qi8ujVEZD7HorDrukp7W6VVTT2WAnmhJSvH+nMZGv+GTYjm
w3YN0H6NSDtsBHtGRsdncu1z+DmGooDtVr2peHM0W0Y0bVW6fgk=
=n7/7
-----END PGP SIGNATURE-----

--2lcsbd7htlxpv47s--
