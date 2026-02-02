Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D14ED172D2
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 05:42:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D80F183CEE;
	Mon,  2 Feb 2026 06:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tISv6jrB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E05B183D0B; Mon,  2 Feb 2026 06:42:38 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3E0C83C51
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 06:42:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4pKlNEj+pTQDVOVm3UtFKj7my+h/hLu6RRmVnrBj57/YGUK0R8xoZAaFHAIMaeYAKxJWv6qy2BxYoovbm/2VqH00jpilaENhBFv61ZF9sjTXJkPR/ZybF9NwrlGCgsLw6nVYGgCOyfoGzsA0zg6N2/vCqxij96GigzUSn1vFlrzvqYWnMxwItRKbOFCgCAw3mAmTc5wi0yjHh/SMkGHvXby6mdIrHy5Dur5oF8LbZAl9XA2OtD+3ySRew1SCYcPyKxm3O4DbzFT8j4WzKFiLI/iZfSeyDvrE0pzrIqAJY8yldnSR6fmI2leTNyuOpnKYjrSAgrWTG2EdAQRv0i09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CavDpLY4VZccocnixH+OlvaKjriZ8ph3/ue8oPZXyo4=;
 b=WgxV25c+5ayGKVk7szO5Td38uDZCKeO8eWn7pjFXMFImuJtqX4V89zDI3M5kNgU1aWxzKGWKPOp5sDVPhj+ElPwtqkVCKZkqha/HYQOHh18Ra6WEDbi0xXBDN3YWxiFp5BV/HDHnzpnaagro2hSjcfDSqIh9P5JSRiYI84qbNcnIcnSn9ssKdOaFo7UHfTKjJLZngU/XszPStYlnIY8Pg7cbkYcZaJoCkgLjHMLsE0CjbbahG6OWkON2eaQlcDZhYGUm0cKOiGzc/wZlitzuVn2ECYKYtUnTvMu+QrLjQ+Qi6+X2tn9Uj/6GLxscO5r8agcmk3U+QTwogmtni5w6cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CavDpLY4VZccocnixH+OlvaKjriZ8ph3/ue8oPZXyo4=;
 b=tISv6jrBsjUcv22JtmYRJ52GPieIE2OG/RHomPxqApSJ62gCjOE1SrFgHHehj6j/ExSnmhT1DwelCchGV4l7SgoxmB90PjWYO/oph067iBumAso6SaEABC+VHZ2FQfJt+v/8+7FI2crUzWfcznLx0Sf8C7KigBfxVZXuF7ew8Kk=
Received: from MN2PR16CA0053.namprd16.prod.outlook.com (2603:10b6:208:234::22)
 by DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Mon, 2 Feb
 2026 05:42:32 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::85) by MN2PR16CA0053.outlook.office365.com
 (2603:10b6:208:234::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 05:42:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 05:42:31 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 1 Feb
 2026 23:42:30 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 1 Feb
 2026 23:42:30 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 1 Feb 2026 23:42:30 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6125gTTc1582847;
 Sun, 1 Feb 2026 23:42:30 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 2 Feb 2026 11:12:29 +0530
Message-ID: <DG48IKMSA1IL.2D1LC7O9QABVJ@ti.com>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCH] mtd: spi-nor: ids: Add support for Puyasemi flash chips
From: Anshul Dalal <anshuld@ti.com>
To: Ssunk <ssunkkan@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Vignesh R <vigneshr@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260130110132.8018-1-ssunkkan@gmail.com>
In-Reply-To: <20260130110132.8018-1-ssunkkan@gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|DS0PR10MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d85bd7b-653d-45c1-5ce6-08de621ddc04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnJ1V2VNQnM0eVBod2pCOS9nYWRzWWpKNG5pWlZkR2FOTUorOTZFSHFJYTQ4?=
 =?utf-8?B?bnRFQkt5amRFdDFmY0I4YzZxVEh6NnkyMnNNOXNjK280M1MwSXZtVjdNZk5o?=
 =?utf-8?B?SU0rMm1EeXV5Wkh1ay92WDNqbUwxYkZGS2U3bWF5aWpvRVZlZlplM1l5N0R3?=
 =?utf-8?B?NkcwUC8vak0xbmtzOWdoeHJMdUNrd055QnJnYSszV0NKaHhRVkFrQW03VjZ1?=
 =?utf-8?B?bUVmNklYRjc5QWI4a051bFBMTnU0bDhXWUNLVDN3NjV4V2FrMHdwc3NmQWZz?=
 =?utf-8?B?MlE4UTJTbWRoZ1p2YkFSYndKeWdabnpocVkycnFmUjY0M1BIbzJGUHUrNVha?=
 =?utf-8?B?S0lId0N2bE1mcFhMUEh5dmJNWE5BYW9QNE1PMUdmODV1amlsNmpweFl6Z2JL?=
 =?utf-8?B?WkVsTEdyVHJTK0dvZjJHdjQwdkN0TjlNM3hVMWVkSmlFdHA0VFVLUjdWeExB?=
 =?utf-8?B?WTR1Q09rTTRROWtFZXB1aEljVTVMSmJYVzBBNmpua3F3eWgvR1Z1b21ubFVZ?=
 =?utf-8?B?TUx2RzdDdUJLckxQeU03Y3ZDMWtHL2JhR291SG9ZY21qUmRzOFZzcXhUa2V3?=
 =?utf-8?B?ZGFYaGJKTU9ja24zeDBQRTZWNTlFREVSSHJXNXNtZklKSHRCODE4dDBNcWc4?=
 =?utf-8?B?UGVla0R0OEUzWmN4NVQxOVV0TVpodUQ5TVVDQ3FtelRyTG5yeE82S1FCS0Fm?=
 =?utf-8?B?dmt5UHVXaTcwc01RZDVVS0ErMWpFdEF4ZXJ1OVBmeU9xaTdwT3dicWZUVzBN?=
 =?utf-8?B?aHhtWTJJa3lNRHJLR00zV1BWR3RtREdxd0VHZDczdk9SRUhEeUpxUEZCWE5E?=
 =?utf-8?B?QjNiK052UHJFTGJ0ajdvSmNST0dweGsvTm1PS1IzNWwzT2tTWFZ5dHNKT1FV?=
 =?utf-8?B?QldVVUtHVFdoeFlVYmh5aTBJOUNlYVpIakp0WTUwWGsvdnZzajdIV24xa3dl?=
 =?utf-8?B?UXRVSHJieWo5UHhKdklIbjFodUhwQ25QSFVxVW1nZVFPYzh3a05jYzRzeExV?=
 =?utf-8?B?aHhFeFMzd3M2Z3JSNGhpb0l1QXZLNHcrNHltWkthNzh1MCs1d3NlN2lIOU9o?=
 =?utf-8?B?NHR4K1dRekFDN2VqVTd1blQrelg4TUV4SUxqV3lTOVpKU1MrVWJYa2VHRVpk?=
 =?utf-8?B?TWdwTk9XdURNUDhqa2haRmw4U1orSjhUOGVsMkVJWTdmTmtWeVdDUTJVNlhl?=
 =?utf-8?B?aW5Tdmw3dVpjQUpjZ3EyamNaLzQwanpOVU53aTNCbThZeWlEM203WTlaWXhJ?=
 =?utf-8?B?ajFvVkdMTk1UWk0wUGhNa1VYYmt6cU1yT2sxWVFzUm03V1hnT29teGRsck9M?=
 =?utf-8?B?Y0VQaXBDcmJhTEliTGtsSHRDakNyMW9ZTjZWVThUK0pYcXBsaGZyeXdRZ0Jy?=
 =?utf-8?B?YlB2T3BVYkw4b3pWMml5ZWNxMXQvQUZmZGdOZDM3blZKSjhCYWpXbGp5VDd0?=
 =?utf-8?B?eklFVjlyS0M5ZWdodUVJSXVMd2I3WXpLazhYem42NmMvTzFWVkNQRlora09x?=
 =?utf-8?B?aEc0RitYdDVSVkNTaUxjSUZJbnFYMWxlOFAvL1NmN0xjRTlPTlFjZUNuREpr?=
 =?utf-8?B?Y2JEZEorcEoydWxyRTkyaEJ3WmYrRW1BVS9mOWtqRWlyQTlZMVljV1VUcWJP?=
 =?utf-8?B?bTRkWU9ra1dDcXBxMGVsY3MwVGIzN2FqVSt5dGMxZW9IZElFV1R3S1FocEJ0?=
 =?utf-8?B?R3ZlSTVqWXBXdmtSYlBoMVNocnJSL2pzNzc2cENRTUErWEMrVEpPV1Y5bXZq?=
 =?utf-8?B?R2VPQklGUmt4enNZRk9mNHJOZ01Qb0JNdmw2enNuQk5xNnNxaHZrTG82dDFX?=
 =?utf-8?B?aXBzbFd1L2drUWpyS2dWS0sxQTMxOTFqc1NtYVBVSExyWlJGTGZaRlVrOCtO?=
 =?utf-8?B?ZktXdkM0OStKcC9mTVZWbEJSeU9FYlFkVDl5SFZRQ3pjR2dMd1VobGlNMVc0?=
 =?utf-8?B?bE5PQUNxczdZSGt1WWdSejIybUVGNGpkZ2YvNUhBN1VJRkZQaEcwVzQvWDVv?=
 =?utf-8?B?M0ZPNHR4TjE3WnFHVVVIa0psRmhJTTRMSHBhLzAwekRuMTBIak4vM2VhczFw?=
 =?utf-8?B?ejhzbDlBazEwMEt1VVE1dEdXejRrclkraFhqTHJiSlM2NklkU3pCVTl6Y215?=
 =?utf-8?B?MWdKOTNKVldldkMveFhRZklpYlBZbEk1WXRTWHJwemNGVGxCam9hUzFCbkdH?=
 =?utf-8?B?blE9PQ==?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Rlkvte6RGFD2G16+0OIP2n6dt2jiYl8TjJ4HAFPowMZa0BkweU9ACCVVtn/Y6xJxeCHUTR3HjGlf0XBd6osShc/qRF/KrVFeeENjwl8MPHwDoiwe1hl5mFd8Ly7lYajalBbC9CcZsHLS+/I0bRA20H0bPS85ejXY1fhAbI4kN7Tpf+dYkbcUV8nS9qkcgwMOywB3QtG8mYAYM/uP+Q66SrzxuPGdEHGgVWyOiS3ASg3EM6ctVkbIYC6LEZQdBLp2/QCVcC69HP6QBxU0LEH1ICeAKOA8owj1e9mToyFPalrTBTOfJo5JAKQ854Id5aoczXP4O3PYTzw4exKRA4Nmqv/nTndjKKwO/8axaFfp74QtDQYBWsxaQ1xP1mOR1JdrOBd5FuqbILphcGP1d3TF6ZsYG/FsNxsOLq7c+YmFU75o+Z2+/fgtG0H2l+wgY4YP
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 05:42:31.6841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d85bd7b-653d-45c1-5ce6-08de621ddc04
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6974
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

On Fri Jan 30, 2026 at 4:31 PM IST, Ssunk wrote:
> This patch adds JEDEC IDs for Puyasemi PY25F512HB, PY25F01GHB,
> PY25F512LC, and PY25F01GLC flash parts.
>
> site: https://www.puyasemi.com

A link to the datasheets and a reference to the "Table ID Definitions"
would be helpful in cross-checking the correctness of the IDs.

>
> Signed-off-by: Ssunk <ssunkkan@gmail.com>

The patch doesn't apply cleanly, please rebase on master or next (as
appropriate) for the next revision.

> ---
>  drivers/mtd/spi/Kconfig       |  6 ++++++
>  drivers/mtd/spi/spi-nor-ids.c | 11 +++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
> index a9617c6c58..c223862a46 100644
> --- a/drivers/mtd/spi/Kconfig
> +++ b/drivers/mtd/spi/Kconfig
> @@ -217,6 +217,12 @@ config SPI_FLASH_XTX
>  	  Add support for various XTX (XTX Technology Limited)
>  	  SPI flash chips (XT25xxx).
> =20
> +config SPI_FLASH_PUYASEMI
> +	bool "PUYASEMI SPI flash support"
> +	help
> +	  Add support for various PUYASEMI (Puya Semiconductor (Shanghai) Co., =
Ltd.)
> +	  SPI flash chips (py25xxx)
> +

Can't this be included as part of the existing CONFIG_SPI_FLASH_PUYA
which was added by the commit 5c73c05f20be ("mtd: spi-nor-ids: Add Puya
Semiconductor chips description")?

Nit: Would be nice to see new configs being added in alphabetical order
in the Kconfig, though the order is not strictly followed currently :(

>  endif
> =20
>  config SPI_FLASH_USE_4K_SECTORS
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index 4b7b358eac..2e479ab8a1 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -624,6 +624,17 @@ const struct flash_info spi_nor_ids[] =3D {
>  	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPC=
ODES) },
>  	{ INFO("xt25w01g", 0x0b651B, 0, 64 * 1024, 2048,
>  	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPC=
ODES) },
> +#endif
> +#ifdef CONFIG_SPI_FLASH_PUYASEMI
> +	/* Puya Semiconductor (Shanghai) Co., Ltd */
> +	{ INFO("py25f512hb", 0x85231a, 0, 64 * 1024, 1024,
> +	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPC=
ODES) },
> +	{ INFO("py25f01ghb", 0x85231b, 0, 64 * 1024, 2048,
> +	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPC=
ODES) },
> +	{ INFO("py25f512lc", 0x85631a, 0, 64 * 1024, 1024,
> +	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPC=
ODES) },
> +	{ INFO("py25f01glc", 0x85631b, 0, 64 * 1024, 2048,
> +	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPC=
ODES) },
>  #endif
>  	{ },
>  };

