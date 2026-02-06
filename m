Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058D9EE20AF
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 15:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 787F7838FA;
	Fri,  6 Feb 2026 16:19:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hMoM0X4G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 882FB83A64; Fri,  6 Feb 2026 16:19:22 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6EA9836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 16:19:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMmWnjM8Sl5Jq6gfs7n2OTyLhfNo6O78xoe98nCbnuWWQHSTZhy3FDRBnpy54VuE+WmRSpcNThF3mo5X/qnDGoGFKerjoUruznTFQv/N4jwC0gqgzDiXcgW9tl5YjpI9r+6CDTJDzFXTUN9JyqZ9QAnve96H/uwWWtt/To8643ZZjs5RJmFPtyJjpQ0RMdm9kTFHR0jB3ElvrlXPXSBeCsg8cpDwsBZX2MgFoDa+ZSJkFXjn1s+5Cy4sOYjvsJKEW5X8uYqnbwiTFEu/tQv51NFDM7jp1aNd2MdZsHQ7NzDpOj0KU8tEMcKw2KmQqm7TtA7rPAmSpTcZl8wrWq3C2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiYhmCcvQgl/liDMrwBDsf743S7x9zHUo/Fw24UJ2+I=;
 b=ZTYbaiNktSHjALgxj1OY0rgLGqspnCEdy2tV5KUdGNcRmsP+LBgAY+k0KV7M3SIzSL5BZxT7tddcSgsZKP2C/Qj/7DH0tJszLjP1zLPyr9JCu7vt1DtT99SHplGRIIDjM0ov4F5/0NwvXSFDLYBORhYuhy/gigVCrsybOzO6idjVcbnegnigmDsSp3gVvuNhPpx6Im+o+sS5HxdWZbM88SZCQB0WTCLluOhvozs8H3vkrhV0JKCyBH+xUcmNkI4XqIzWQxcqehotEBx837+PxHENEvV6N4LvD7HKBNkMLKRQeNoSRzRje8ghp0NWnSzvM5CxVKufobBPjKkq72EE1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiYhmCcvQgl/liDMrwBDsf743S7x9zHUo/Fw24UJ2+I=;
 b=hMoM0X4Gmnl2JwmO6ApvHfClwWpJOe4HeZaxp1whLYU5rJsCnrTugDyHOsDX6hAHWQjCLZkucAwz20xUJHzNazTOMmfCSFIb9knHBxjjiCrvZ22H0xLDbaRYdqf7mxbx91L+tNPT/8LE9+qB3M8mrsGzITiNAc6YJI/QUQT5vcA=
Received: from SJ0PR03CA0242.namprd03.prod.outlook.com (2603:10b6:a03:3a0::7)
 by DM4PR10MB6205.namprd10.prod.outlook.com (2603:10b6:8:88::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.13; Fri, 6 Feb 2026 15:19:16 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::c3) by SJ0PR03CA0242.outlook.office365.com
 (2603:10b6:a03:3a0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 15:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 15:19:14 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 09:18:47 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 09:18:46 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Feb 2026 09:18:46 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 616FIkxw1468018;
 Fri, 6 Feb 2026 09:18:46 -0600
Date: Fri, 6 Feb 2026 09:18:46 -0600
From: Bryan Brattlof <bb@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Tom Rini
 <trini@konsulko.com>, Nishanth Menon <nm@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>, "Francesco
 Dolcini" <francesco.dolcini@toradex.com>, Garrett Giordano
 <ggiordano@phytec.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Paresh Bhagat
 <p-bhagat@ti.com>, Vitor Soares <vitor.soares@toradex.com>, Parth Pancholi
 <parth.pancholi@toradex.com>, Andrew Davis <afd@ti.com>, Gowtham Tammana
 <g-tammana@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH master] arch: arm: dts: k3: refactor common nodes to
 k3-*-r5.dtsi
Message-ID: <20260206151846.23gk5tccngjz2dhy@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260122-r5_dt_refactor-v1-1-5442a4321756@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="72ucbp6d7bl332hm"
Content-Disposition: inline
In-Reply-To: <20260122-r5_dt_refactor-v1-1-5442a4321756@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|DM4PR10MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: c4773bbb-ab74-4813-cd2d-08de659316a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzZVUFRWMCtoeU5xRGJHSy85VDRPYzZzdXdYTU1zSFlCZXpkQVlCbzVYb0lr?=
 =?utf-8?B?WklROGR6ZUUwaHFZWGFlOXA5QnByektINkRrWmlwbGhGOTJNMko3MTZteEI0?=
 =?utf-8?B?WDhiQkdLWUF1M3VwbU0zSlhMYmNxeHRKeFlPZFlzWE9kTTgrUFBsR0NHcURq?=
 =?utf-8?B?RFBOTzVtTnNWam9FVGhWcWdHWlYzY01GYW1GYWhUaWErM1VXM0NHR09hSm9w?=
 =?utf-8?B?U285YlpKMUowS2dMcW9VOVc1VVdqZFcwQ2lwMnBjTlBNVHMzTS9LZ3N4NTlt?=
 =?utf-8?B?TWpBTUlEWXpYdXhqdEEyYmM4Z2FOWlpmWG0wTVpGVkgwUWdBeVJJeWJ4UEts?=
 =?utf-8?B?NndYV0tFWmNmckR0eEwzZjU5a1BjZk5kN2YxTk51UVUzc2g2YlJPS1l0MjJS?=
 =?utf-8?B?VENDbjZmNVJSZ3RKTlVvRm81b3FrWitoTzVDTjVjemZlZlNQdjJvTldLVTBo?=
 =?utf-8?B?Z2h6RlIrQjVLL090UkJQVnM3SVJBZTk5Z1RnekZDR2lvVEoyb3k4dGNyditR?=
 =?utf-8?B?bjRRYlRjNEM2dDgwWis2MzdBTlB4cmM4b3Nvajd4cjIxY2dlaHFGRittS2Np?=
 =?utf-8?B?U3hXZHdGK0xQNVkzWUwxT2E3bGpHYVB1N0dmd0xIcFFmTmFVdTYzaEFsbUU3?=
 =?utf-8?B?RVIxYVBhNWFaa3hjQzlsN0J6RTg0VTdPL0NVSkZJUHdiOGIxckNZakp5OCtu?=
 =?utf-8?B?YStVYTI5VWNoeXpxUlUwSmRTaCszZXpCRjMzRUhFMjh1aWw2SlRrUkJVZ1Nw?=
 =?utf-8?B?QWZ1d0xvUktCTmd3Zk96NXo2YkJkRXZhM0RPSjlMTVl5WjljME52YWNnUnpR?=
 =?utf-8?B?d0dBb3dMc1kzNjZQR1pYWXR1eGY0RTBWQkFheFUvTUVKZ3BHTGhBbzNxMXhx?=
 =?utf-8?B?UlIwaDk3YlZEYUpFb25BKzZCT0lTTjdUR2lrSHNsbkZ2Qmc3VXRZR0VsM0FB?=
 =?utf-8?B?NWcyd0xEZ1c5L1E4TU9YNkYzdm5zSVNqL0NUUmRVdGMySkcwZXUwN0pXejJi?=
 =?utf-8?B?TDQ3cDlmOHFmNE5zK2xER2xrUDkwK2JjdktOM1VsVWs5SmFrc0l0d24wV2w3?=
 =?utf-8?B?MHcyL29WOXdBSlZGRUZmSkJUenh2eGp1RDdYS1E5MTdRWnlFVGRtWWpySEtH?=
 =?utf-8?B?T0NqNWxyMmxVOWVRRmkwU1gzZWdGWndFeE9OVWczRlVRb295dmRyS3JYZE5K?=
 =?utf-8?B?d3FyQnErdTNKdEE4Q2RjMXRTUUVXR1Y3Nk0xVit0clIvLytuMHRHaWFudXVn?=
 =?utf-8?B?RW8xNTg4aXMvZWNRSHd5UFdvaG0zQUNZNStvaitXNDE4ayt2ZzJ5WWM1Z3BN?=
 =?utf-8?B?bEdhUnFtOGRYNjZEWjduWXNiVk1BaFZyMTNyOTl0N2x4TlhDWFBVMklVaHR2?=
 =?utf-8?B?MWdtcEJRU2E1N05SQUI0V3RvdklLRjc4RWR5K1hGUGt4emNXR3FKak9HUVY2?=
 =?utf-8?B?eHR2eHFGSERHNzVXdVArVUlPVk50NjhMZEJ3SzRlMTQwVDlXdGt3ZmlzK3Uw?=
 =?utf-8?B?R1VLYjFVRDNhRTR0eUQxbXpONlBNK2NYd1Y5OEFRWlprV05YUjF4TG0yajI5?=
 =?utf-8?B?bithTWFqWnMxSlZDQVlYTGlNdHdPTndkT2tvUWlUQ0FZQ2U0WWdmYkIyZmQy?=
 =?utf-8?B?SDhDTXl3YzdvOWsxRm1mR0JXbFZPOFBNZmJycHl0QWJOdzJNcTFQY0pqak52?=
 =?utf-8?B?ZDRxMjVienUyMjR4NnE1aXlKazF0aUNwS1RMZlQvbnF5cXdCWDNnOU9yVTZZ?=
 =?utf-8?B?eWdVTGdDcFhjdGNGendXa29mU0FJOTVvSXU4YWQzQ0pyT1g0ejBDZmhDb21w?=
 =?utf-8?B?QW03T0FDTzVYaXUxd1NSeFRVN0tDK3FBYkxkQzVOY1J2L1hWMkZvMjVRNmZK?=
 =?utf-8?B?WkFwLzA4Sm9VUWlYWmgrZkJvS0VWcU52Y3pEZnJZTkFlR21DN2pkY1E3WjVr?=
 =?utf-8?B?YVJROVB4MmRXV09zM1VGMUQ2ZW5XcnhnaWlERVg3OFhNY296blU1bXJlWEsv?=
 =?utf-8?B?TFdiSXJQUHhjVlUvMHBKbjJZUGVDd0I5UXpaUFlTWHhybkFkL0d3YmhEMGJP?=
 =?utf-8?B?NWRWREY3M2FxWkI0Y1pPd2J0Q0NrRkR4ZEl0STZNZDJpZkI0NXJsaTUxVVBE?=
 =?utf-8?B?b3FxS3cwMjRBa3c1bWdnRFhhZTBycVNEY2N4RUVWaGpoTUR3VUZGSDArN1ha?=
 =?utf-8?B?KzM0V1g0NmtTalZLa2J5c3BrUllwMzBFcmpPNmx2NStBL1lSc1lvdU82Skkv?=
 =?utf-8?B?TWtXZUhrV2gydFNMSGZ5a2hiRkdnPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pn9idXXI315MYr9uPnqfSHJiygI/nUX6urhD8tf6GA1ClGTV09WdVb1kXVVe7zxtIiOkU5cDnwLPj+VAoZjJN7VA7EYAcXWSCrGJ9yTLwZhw89Z23avh2GpGqVBBsiwE+cpyqQ9ME7B4MLO4N58rNJ+T4NCtWayb2C7ZrDg19+yEuz//shP08Cn+LTO+VbQbpTt8x0ARsqEdcu7jOSGMBXCK2jwRvihQBOZMcd3J0BvPNSTTuXpCoYngH3v78PYlpnJDVwCVJqfjYb+tK7RPrmXUPovkbJw/7p2Yw6ZUAVjazniDNTq/mt0JAzhiw7VjkTcPKjH1Vvv3qmVTLNdJjeBDx1qrgFhxXSamd/16K/JKCHOFJhvNvk/Lr9EkJ1h1yMCgeymajL/MG8hsS54R6HJVQq2MxKaUDKQbbLvb9EWmI1nJoOkiSHH07pF/Z+pX
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 15:19:14.6416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4773bbb-ab74-4813-cd2d-08de659316a4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6205
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

--72ucbp6d7bl332hm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On January 22, 2026 thus sayeth Anshul Dalal:
> This patch refactors the nodes in each board's R5 device-tree to common
> SoC level dtsi. No functional change is intended from this patch.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan

--72ucbp6d7bl332hm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE/Oiw75B1nI0/tSm+wPir0+IT1wwFAmmGBlYACgkQwPir0+IT
1wyHQwf/W/i6xl1hqRq0F+DrcRYx4t4YbIgf+lJVKQbJrj3Z/FzZmfKm3HQ2BlGE
xLFNCIYaiB1MHKBrdWJC4T5swrhmB556eBggt/2Bs2YFD1u3ezR/jwBWK8/ZVODt
IFsViGvlYnHABesv6UxiDzX4Wd+m4ppxp1xjvq9mhazbNWM5b7T1U2h+ZUl5SfPL
ko+85s8sPrfbxgd5lndDINkb2MYoaZVLMUXCC6H9uquonTkFmkPkH4DoyhrUJh8G
WZLRq5R/POiFNURgpgLLc4aTi944g+f/aGVUJzFBTK5oFBMGv/lKqAVNUTdY/G4i
vU72YdG5Vb7C6svLpw/hMs0C2VW2UQ==
=Py/i
-----END PGP SIGNATURE-----

--72ucbp6d7bl332hm--
