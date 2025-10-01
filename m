Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08ACCCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 12:01:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 723D7834D4;
	Wed,  1 Oct 2025 14:01:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="tGsp/QgZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A55BB83526; Wed,  1 Oct 2025 14:01:18 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81DBC8349B
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 14:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=treding@nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXopTS2lTntuxJWTOvSc304GvnmwYo0rFoK88/5Ttu9N0w3cvfd/Z63ng5gSjpvBoapuQ/U0K05PnNRMqX+tzo3085MA/cXgkBYI8DUlJYYkiQ9PRUIaLHF1ESZaHkE/TGscnZyNZtCD1c/sT0iKmaxuaFZ1uedQnIsy4psqBoKdDwYt8DrJ3LzW6KzaYa7PWQ3WJ9t86zRSbdPyZS+HfevldjdENwCgSNUdCOKRqZPNLj79qjxGG2XoPGysy3iYhYTqQ0q0rAGtauScOzvJAv/4lm6q+Jx5H7Sb8moD7xjBqi2C/UCttNqIVGOrdwGJjAojXqZ73LdXRJVsGl5OjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsA+vw9vAcJlan0tAN6GlSQ8ugObztoT2rOT7mkLEmc=;
 b=Pj3/eOr5KCsTCj/HCJxRT2fPxm7lz72tTjWzCi6d7e2j6HED+iL+Cwv9Ci2Bw2oz8Z33lsnZL1RsIabCisPhhsrVLcbrp0i7gjUGL3VtBKesSw40uw/g+8t1Rz1MDGPVk7+kdyMyjbRaGRNgX4i6bRDYxQ2KQUKUP4x2Op/7iZ0KowSsXSKZbNZdLmJvuVz+tVCiBF6QJ0o1kNqy6/9uWIyOMPxdsJfssHah9GLz/ijETqAWBaUqJG5NQ20LWLz5gGM2wu9fQfxE5mJ7zFWaBHA4dxLFnDvyKhCfhjQ7+6WC4f8Qq+9CxkzMPFj3saDm536AFI9aIeqZUjdCIv5dOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsA+vw9vAcJlan0tAN6GlSQ8ugObztoT2rOT7mkLEmc=;
 b=tGsp/QgZExhOIP70udWbSBwkC8x5n+TK/4TJ5V/EXrie2tbMEYEhz19a8Ptp9/yhMrn8o+FbqyNKCKNebLcXr6Ob+IQJhmsJxYKK6uf/SBCoLKwXkAsJh81z+QafzLGPr6C2ZY5pf0P81fZ2R2ELI3SCDT2ZyftWIlZoaO1zXlhzY2QgYhzrw3+7NqfKVg3jqhCwSg2XbMs5W8+IA7OFCjpdQ4aA2Ndvm+8jtoT7IFApYD9BFex5BXISxOyy3CJEZ0V8IPWxJTFiawOfKB8YWwEcYlvyX4IPjOKlA/a47TZsCoC4U/QGgBzk0/JyCiM0TI2GkrKqtrNmp92XiGlxXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) by
 SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 12:01:12 +0000
Received: from DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c]) by DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c%6]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 12:01:12 +0000
Date: Wed, 1 Oct 2025 14:01:06 +0200
From: Thierry Reding <treding@nvidia.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/2] video: tegra: Incorrect operator used
Message-ID: <k6m7uhwvzrkuunc2kvl7ga5t3uuhiglhtuwcdvj6djjm4xbvz7@5xfefjkhov2u>
X-NVConfidentiality: public
References: <20251001-video_tegra-v1-0-faaf48dad062@linaro.org>
 <20251001-video_tegra-v1-2-faaf48dad062@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vrsjguv24rzwixb7"
Content-Disposition: inline
In-Reply-To: <20251001-video_tegra-v1-2-faaf48dad062@linaro.org>
X-ClientProxiedBy: FR4P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::6) To DS0PR12MB8317.namprd12.prod.outlook.com
 (2603:10b6:8:f4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8317:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df8dd16-f5b3-407c-bc20-08de00e2372b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PwDw7imQ5ggl6TWc6SOnB/MPvRVMhJESJ/kCcUqEOR8P+Gl3+61w+kCWe3pq?=
 =?us-ascii?Q?gUMSu0zEBqbQzkhWGXKr1ICPaq9n0b2c0H8JfQl7QawBbu96qHDuZpc8l5uS?=
 =?us-ascii?Q?nqyN9xR5BH7dFIvQhvP5upWYP16OWR1gEaj7lNjCYrJWgxDAgHeUNqTX7lKy?=
 =?us-ascii?Q?ldPytzLhrvlOeo3fMsmBU+1hyrqI6prZPfaM34uPI5wWCVmP2cotNgMqIYd8?=
 =?us-ascii?Q?hCRELmdvELS1t3DHp9XlMSzGLacP7xbvCkpxd27aE2lO8ej3/qy5obBhEzfF?=
 =?us-ascii?Q?dj/NVPpKJ0d1bA0VHxy9mauzobhRCerDAlefUwXxBfd1l7xeElTS4wWgf/s1?=
 =?us-ascii?Q?GNm6WmfNhLa+YxB3BqHy7SdAT2tuKBVr6IuRmWzYc46+Y9jtTP5CLXbebqFm?=
 =?us-ascii?Q?dZK1Q+Xg9UgSThoWKNEf3qbWCnsE7/z08xVXmE8a1zFsvUmzT8FybAFJcj/i?=
 =?us-ascii?Q?rlCSS/0w0LTMNUHh9XcZJ6Gat7xn6eYVqyAGIEgrKGiM3EYpnPe5wcxcT/+M?=
 =?us-ascii?Q?tG91WJHZW6nqDKrxRMQ/8DXPg3keTZEaOLPVJOx9QDDkCdevzLHEQLpCFOYz?=
 =?us-ascii?Q?HYf3vQIVyOB/onfFSmgmq0i4CjGlF1fliy8JGdRFVCBTg+TAINMyrGt7yQBp?=
 =?us-ascii?Q?Uo2I4Ibqd2A1YQi3q8xuvxVsq+IUIaKMu/kJmOAbYBJ4jJksbBUuNs+FypF1?=
 =?us-ascii?Q?PLGF69czSPro3NXLWxS2kyJtRcmQUD2yVN4DXg4ZOacZu+Coe0KxhDccF3Sp?=
 =?us-ascii?Q?dEEd/U/goyL7v1dNBYznxhds7DtYhvnlq+87a03tv0bioqPPurJ+ei4zxsZz?=
 =?us-ascii?Q?tw+AlfUAMR7BNXQ77NG/1ucNEoRAMRM7TqwBtW03h3urXbZpnuKLErOhDQac?=
 =?us-ascii?Q?lMvHMhpKgL72svy33rKvU6mbR0zyI1Fc5XjJkGAYoCqb4zfqM9Q5JMFKSAaw?=
 =?us-ascii?Q?rYHGFt3R6dmM3cGEw7R12e6vcvImvxIFLqC53gH9wj7ZLJm3vf38N6EwTdke?=
 =?us-ascii?Q?Aoghidja00owX+MLbAbRUkVoacfIXL2geO0csZshPXVeXv5Yc1U3MXSQhCfd?=
 =?us-ascii?Q?32lbUCSFlf5j41O4NMT5P5CINKYYDOTMU8okG0+S463qARuIJgRu+PuA6ehL?=
 =?us-ascii?Q?+AxzjqXuMaQTUMmwTM9phXyYVMMXC3y3GIKfExeu5v3aUA+d+oTwvtMEVJJ/?=
 =?us-ascii?Q?eAv+ubSKma+ORAbzt154ab9n5Dzl4B8eHUJB7mxjfxrQI79qpTaHPpt/Mb5H?=
 =?us-ascii?Q?JCOvqjnWeAkcc5TIAoe6TyuF8VfWsjrOC/Wq4S0wfNCUn78nlSnxEI6NQI5U?=
 =?us-ascii?Q?Zup5Lumw7ZcOeSCXsrsJbOs6P5uHQWEkxFRBrFUfgn69IuMkGW5iryFa7XXB?=
 =?us-ascii?Q?py4JaUVaphIL18AEixa7AR8ybESB32qOv1jqlZwNoFwWHy8RhB2oHn2FM4Cv?=
 =?us-ascii?Q?5XIxl9QnX/ApGpOHzGTnoKJE1d2iXdZV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RpfPW40BoEmBhM4aoOeq5/q2ITTJjLzFEnCJYZguyFeXmK0ClPSV/olhb7Rd?=
 =?us-ascii?Q?LQLmz0u7LviRzYOV7t8YDivfWJDKCvlkP4kv/RUmiE9KbmkoCC3ktkMNaYgJ?=
 =?us-ascii?Q?gSylnjByqCPgqT6dIMgwpGV3CSoE8+JbQ3gqJF3gwAW4fqW9haLzbyYuDqj2?=
 =?us-ascii?Q?zDngaR8QylTSwGJKAljOimNPtSy5AZjzau1gmZfzWrc9sbBBlsjkUWGOQ+jZ?=
 =?us-ascii?Q?vKVrQMDeKiZMY/DRlmAJV1aXIUNfOWa87AoKeW1Ka5aqSeuggPiH966ZZbRL?=
 =?us-ascii?Q?TDWv+xE7Kks4ocuUvPfEdI3cnzOsk5Z1iFWGKV76R71rHZTetx+U4IW2Sgv+?=
 =?us-ascii?Q?jzoXtcci8EhXdVARjgQqqjK+smDGlSkcAQUZSucZPeQUL6ykfjcoZ8f5L1nK?=
 =?us-ascii?Q?BTpNlYJY5FClX8ivk4H21iR8yNxfiKhACd4uypU9a9IaLapyUTAioTvigxKa?=
 =?us-ascii?Q?dncEOweqmdDhWDnavFkl5uX2qsjHOF/V31DK/lenzby8JSk/okJsnSymw+Kq?=
 =?us-ascii?Q?quIeAoXQxB/TQcU4NrIKjcV2t1r4xvJd86SkF4FOPpnxz2oFoUbQMQB/SqtS?=
 =?us-ascii?Q?iYNVlIphVNnj24aK9Sidw587ixdXecoB76jJa0Z7GBOVrSjn97F5DOFsej3d?=
 =?us-ascii?Q?nhx/7hIMDvuJG7xDCUjKNVSVvGd3VS84Ycxc4pnW1jdUtJH/AdXts1kDAR8H?=
 =?us-ascii?Q?gpJe5K49wn6R64WrFfkUNuAVcalKqE1MmCFJQp0mGpepZeVfBxLsIiMyHhNz?=
 =?us-ascii?Q?T7IZpxcYiASAiF5fclXOZnwg/y/Ocps/kT7FUz6jeCabs7c35dNOEyC+9e2h?=
 =?us-ascii?Q?cAlTz1FFFVSMjiGWa1kc/KIkNTLz5Xb6Pm4mPuc984EQ65pWquQmL1E135P3?=
 =?us-ascii?Q?gnPgYjnoIrBp2cU1Edd2eroe1PSnMje0e3Pm3tqXMt7peuWsohS4MNEYCm3T?=
 =?us-ascii?Q?K2WvKX9rW6mcWEiC2XjYcWH5uL+17nKZNNxm9k4qc4nsSVRaEDad9B8pKBs2?=
 =?us-ascii?Q?UkJ++46CeaqTUwtZx+tmYJivwxSEU7NBwyzInw93WzfiMwjULuIiEI7b+X+p?=
 =?us-ascii?Q?cwArHSr3AFx0El2+QNpXlzmVYLp6Nlcv8rnoYiGX+FfGLsFsBoDnp/S+4axi?=
 =?us-ascii?Q?pOqItTb/TmV+6MIkb30tfPUEax1oetTu7h8yAAP1ax2gNE/YLyzFTQBU2iDi?=
 =?us-ascii?Q?60qaqEWPMFoYYYr1R2dEI6WZlNTVL4G+ufm6dV52/O4HvXtaeicYeSSx48t4?=
 =?us-ascii?Q?cu5rSz4uNztTzN0zoLQeiSL7H2qnz0QCJ92AfVhkN0g7Ig+36ybCxYawIV7l?=
 =?us-ascii?Q?4RwgX2egJYzhdAPJMqc9r+ovKaUYoHUNnOiZbZkmD5uM0WLcq8BL3iRKQ0s6?=
 =?us-ascii?Q?0Zf8myF8VTaLhDBC+QzBpJDJ00p5zGtygdCpizZFtfL0PFr0v09A8SiqNxAE?=
 =?us-ascii?Q?icjcUbs7tTC6S/Lmf9cDgi/eFBgMvLa9L9Gyfi7BTeC9F6+dEnw3T33UhEs3?=
 =?us-ascii?Q?Dl20cOpd1pmXE5HHx2WFZdB47641h0XvAIQoxEIf89AvcBIiJqWoNj2mpDT/?=
 =?us-ascii?Q?Q3Sym0sAM0CZRpF44zXpPv2eUeKb1DWD/I36NvJkcUrwqtlY3rCm58FZYPme?=
 =?us-ascii?Q?UCL1waktbggP+bfuatF146qsPk4WkFRdSwAwR5Y2rBt1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df8dd16-f5b3-407c-bc20-08de00e2372b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 12:01:12.3166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTvAhe6MC/LBkAsQDr3e3adebHWzPAeKcNL2gTcNA9hVUF1CmBJxopYoTmyJzOirgj6V4/7ndwWiLUW4H8O0Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
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

--vrsjguv24rzwixb7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] video: tegra: Incorrect operator used
MIME-Version: 1.0

On Wed, Oct 01, 2025 at 12:55:37PM +0100, Andrew Goodbody wrote:
> Combining two bits into a mask requires the use of the binary 'or'
> operator not the logical one. Correct it.
>=20
> This issue was found by Smatch.
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/video/tegra/tegra124/sor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--vrsjguv24rzwixb7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmjdGAIACgkQ3SOs138+
s6F15xAAqZ5uPESf+9ojBQjyhVFc//KwsppabIwNlRVmYPKwH3fU1UA3PEu2Bv92
4x2yFrG+3jJdLD4G2jbmxMU0k+Hlz3lzD10eEgExgvh5jopbgVipwATj6hoWNLOS
hL8DX6HZgkgVd7GNrfJBKT31KUL0Gxtj2jY56XYkKV37abkdJJAKVSngLDSStGEw
2qGDZ+18XoJizbxqqT0Qnx0d7EoemSWF6t6Zl5mbG1QhG3sDN0w1B+bNhXNv/+MA
7zkPJjXXkMsjE+rT7R5Jq0UgzMvEQisazmRu2st2+K4hyvXTjuFs3WuHtdAvrtK1
fiFNWWzTE2HdwDL+42jN3PpMCXyhG/gFpZ2paiAscsu1UwTZf+vEvcNf+q+UzeAD
VS9uGi7quUQ2WkaSoSiho8cEkKRDwmTvUjBUGOFaIlknNK4smrR1cOxHvvT/1Up2
SzVPhdn4uSkBYGy2KI5Y8PbN+PqwAvH7Prvz/rmcMFkphZDpFBbVqge+t9VLksBN
mjPjLZtHJJjLE2Ujihg8AYPiaGX0x5DuTHcESVx+/BndGWOaOo+vB/Bv/SONPQjs
5KRp9YjM8s7Bcg8GzH7LMKTzwCZzXrBe2AcoAynKzpv4GPVzLgET3ASFM3FecIFu
z4UiL31UQpsHfsrchBT6jZAsEIjOsHP/f/kBLpLIXT9chZbTHzg=
=aL5D
-----END PGP SIGNATURE-----

--vrsjguv24rzwixb7--
