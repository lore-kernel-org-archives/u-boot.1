Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17B3C5B549
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 19:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02582828A2;
	Wed,  4 Jun 2025 21:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="fPb/HSQO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1722E82AAA; Wed,  4 Jun 2025 21:56:28 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A8F582B0E
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 21:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNmQPQH4T6cMMxZjI/HwJK/2uYOa7ghQ+l8Ney7T65B6SN6vekUtxMLYR95GpmDZsVk0w6sVYHdkdGY7sKkYVb8AFoOL+FfMgypH9JaUKapUrA6uQ2imXY/aWkh1az4Z2UHRJrxStFHUU8Fb/MeaE3f2JSKEloIzj/PtTMOqcCMeFB+LTxnbI/Bd6iaG4YUZyGfEPhlB15J4wG4uYtZ3GmxLJ+d+Kl2RUyLwVf4aHDwpxhU85ql5+gKmXJyfnI7LgL0DraA1f+VI87IOuI8pKg5NRyARDxdu+rz8LMwS0FtGMV3NkWOuyh0o3q8eNAnjOmfIqw5Iuf72NxzBj9tdfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkPgFaKTEFMLgMvAKtZ6iZUJaB12y7Z+gwMxsvA4lKE=;
 b=MpszrcffEnEME626zP8yzryuxNVeY4nvIAfrjfC4obTVsq5D0Nx1Jf7BX3I6i1tKZcCpC17nQS/514V6ZXXyqNZGS8XvYMbzkFht+gee1k6OVjBA8EORkLnY1mVEP1RHX21C54s+ilxod5J+COBweoBee4MfLiNUknALK7dMlk+IXn4xolSYmfPy8Bq4mv039lYaumIDxWG22Fzv7v63SPFLpEkUllCjAVh3jiUvwpmNKNrON7iJPT/KiVtwfLM7o3rEB2trCfdh8AR3tIYspkPzaAom2W9YMu9oKdckxT5N0svAHtjHdwPU5QvVRBS2rMyWHkfhLCMp57lq0IuqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkPgFaKTEFMLgMvAKtZ6iZUJaB12y7Z+gwMxsvA4lKE=;
 b=fPb/HSQO33XCls1hHP9xsLR6Tp4LsLflGfReBb++iYB10mcS5iHkgtQz86wLnhfbkSKaCmHJA3Tw5L5VdXWDNaO16hZ+2TAInzqsd8XrBxSQWarEAfSBn3GhnBVu9BMzifCz/I7cgFcdEZNBSuwRzW3csgmUQ7rhfJAAbTJqDgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAVPR10MB6940.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 19:56:24 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8769.025; Wed, 4 Jun 2025
 19:56:24 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 uboot-snps-arc@synopsys.com, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 08/12] arm: imx: remove unnecessary volatile qualifiers from
 "save gd" variables
Date: Wed,  4 Jun 2025 21:56:08 +0200
Message-ID: <20250604195612.2312979-9-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604195612.2312979-1-ravi@prevas.dk>
References: <20250604195612.2312979-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0116.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::33) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAVPR10MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 6414a601-8b12-4ddd-f959-08dda3a1e29e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/F+MiSC2MRgXNIGy8noOOse+7kfk/fBYfDa7GopnyZAvVtqReLky3MzCQDPX?=
 =?us-ascii?Q?YhPdXLqo+iuUYCq0GY0bZ1yOZi88BQ8g6QavLR9zOls8X29T33jaedRlJz1F?=
 =?us-ascii?Q?QOg2UXCz4Q9uQUffrf2KeZA7Qzjx6M5G2iGaIve2JCiNlkrZaeBMci7f6x5S?=
 =?us-ascii?Q?SoFNp+xnueyV5AMMKxvDVnu2xcvT72LFynPy5u057LXVwuvHfK3cyn9iXB/X?=
 =?us-ascii?Q?JA5AgZ1nfTQH7fN9iifgRMh9vlzGR/26Ysq+YXDOYVnEsTSWVlKie/PhbnB6?=
 =?us-ascii?Q?0O4SXtuhzKjd2nbeP/yBAeNlTRz4iJ41UDfU3Jjx4cVDQI2NkO3ODqtGmWvR?=
 =?us-ascii?Q?Fy4apPul7vUS52eCT4/0AOwfRpno3PzdsE3hvwIBjDXs4lds24qdxwD+1BC5?=
 =?us-ascii?Q?vFWqdIxqIf52y8sOdnKyaeK/0BGyAFJfi7VJwvxi/6lx7JCcFkFateSXrnCH?=
 =?us-ascii?Q?AyblSzpSwGBcczkqcde62Ts0BRx7YE1OZEssSlpUjYu1H/l5FpBua5MWdORT?=
 =?us-ascii?Q?yu+qdoFFDjPdHXYlAISDJjADNgrjETjGvYcxKRmLFcCf5AXoEMum/fG1Vsae?=
 =?us-ascii?Q?R4rHa9IbORkSvd/Gi8Kk4jh8cHx/l9qOsvcwfBmn4ryU7fMKICWS7hjZQvHQ?=
 =?us-ascii?Q?kJqUGhEcBk/e/TvGE5qBc+2O61cpZU6E+MYje4R3Q5hXErVWL5Pjm9grkXdu?=
 =?us-ascii?Q?60zpgu3lsONToYMCAZh1M7tg1Rsrnvps7XmWcwh6NbxvBQWCRKE8J18AeB8G?=
 =?us-ascii?Q?p+2tkeOJTM6peuIBW+UxMPoBJSaBakSvixuXAsFuTaPjASlEez6lOg8dZq06?=
 =?us-ascii?Q?Ew+m/uqimwq6haYC3//87LstmmMbZLJgCg7eZdQMoheqLNNfXFS7uVTlJuIC?=
 =?us-ascii?Q?FA3xLJcJtYSi9kPc53isM3DC1C2GKpnDVoWPDgN4wD3S1p6rvzz+dyvFPuWM?=
 =?us-ascii?Q?PFg5vhC5HX5gNzCQ+q+uqv/mvEVVuZELs7yk4bgGPflb6pwvBNhtkPBYKcC+?=
 =?us-ascii?Q?c9Z9SLD+AAD0Ud08I2QTrJf3rn9pWpFPLD0n9oBWclM3flJrnmfeS5F79eF4?=
 =?us-ascii?Q?KwHjRqy4UNCY+jtsLXHdMPYN1MMMUZePm1MLBY2Gy4nh7l5+B2p3NbPi5B/t?=
 =?us-ascii?Q?GKNJ4ZJ2uyvSfqeANyOIWYEYbR3sbGdtXjkyZhJ2yuMYdw6vcFVvPZUBIaXc?=
 =?us-ascii?Q?WycOUvPNFZ008iDt//6dq7wcdckYMacBV0zaCWMv4/agqweRVsKk8ig5Sqcn?=
 =?us-ascii?Q?U6SKj6RpicmwVxySMYCmJmyFu9Cw+LNc8pueaUQXBVnKBaM6raO2mTIrBqQO?=
 =?us-ascii?Q?ZzWlfXMCOzlNeN513YkwNykc4zI7CptfRslOCkgfd35qWtBdMjY7PCmhwBQE?=
 =?us-ascii?Q?nXv+ONHhRMQRd/gs7eMMZtgMIODOaW8TY91Or7utD8ZLggra2cdMks9iL9x2?=
 =?us-ascii?Q?4ktHzi7h62c7dHbMwrRYuUq5yT69+xJVsVcNs0QUsIHJ+bvUmNVIpQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nkt1zNIPFwmA3TQVpMrHV8CqBW4yFP+MFZ1zQ5kDTN5P3eEZqTCs5jzLmiQc?=
 =?us-ascii?Q?mZxr246v11U8/TEOQTGL9fAtFoudUi2vZRm+q1X4JJ/V2sIxhAvi36d3JC7Z?=
 =?us-ascii?Q?PQtu1pf7fvs4TasPDd6oCbJjSCEuj8ZVGFhdwP020TFpW6roBQNd/78fE93N?=
 =?us-ascii?Q?umcG0/6NtrzIL2/0y6h9hdllqjfqbvTRHwN4ad9joYlTsIQVV/rj0C1WYXo9?=
 =?us-ascii?Q?e/kqFVkmkLnF69VHlmNMyc079Ryu+7vFXFpO/fdvXYhyEjnIyfbRVGzINmDV?=
 =?us-ascii?Q?7uRHwR4VxOhJUh7FG8Vw2fuXYlQurtKWg+gIPv/bsagfgYZnZxpGK8d83tER?=
 =?us-ascii?Q?R4Au0YSG0xQIXrhkXJtRgpuvJfUO5A6eYh31ymg5S3yGgMfnFjzxMFB2XHU0?=
 =?us-ascii?Q?UNHghyvRr/v9Nc57w6iU7G03WNpnlG8nYUiTaYeAlMGMTsxlwMj2OAJEU4m0?=
 =?us-ascii?Q?umvYNZnmLvz0QYF98nY7wnUceCQAzdQfY4OqRAQFNzoEz7NYOseiOiQuIgMG?=
 =?us-ascii?Q?igQvnqrPmyDVF9KjkGb79IY15EK8Q4ZXia4Ckl2gmCxIxW3tZN7Mv7qFuC0J?=
 =?us-ascii?Q?YtmouG30tUQEoZxs6bN7mNl33qFVveC8gLknvNLNd/ycwf4qzosVh7VlWEw9?=
 =?us-ascii?Q?dm8n8XUlU/A4q/yPavz+BRXezE96jLOTDGx3Mj+/JPfxDvSBOifWCOODD29E?=
 =?us-ascii?Q?WSil/zHCPJXq8klhLln0mB3qwUtnLAqvm7mcBXo9a5LAbTbf2bj/r3znrMGv?=
 =?us-ascii?Q?ZsCkNrVpTCe0LPln5HrxvHORGGItD6wxQYHfUjxE2U7BvAkr2yK1nVCEVPuV?=
 =?us-ascii?Q?WK8vz9Pnn0zFgfU7P/D0Hll2kN1Gr1NgUits0c/JUJljrferpemv8okMSh35?=
 =?us-ascii?Q?a0+YnVkeVwWW0XYTyI9txmJyC5QPzvcbSw6tmoA69Qsc9uI3O980N7TWUBJV?=
 =?us-ascii?Q?hV/aJ59ZdLa/TagtcMEDWfVEZKVHGh/2TBgDouEZfyC7dVZZlvxNvROnhSkB?=
 =?us-ascii?Q?AQ+817mFRwvo7ZXv5VWmumxs95hwpjHy9uCQZfgmKdq8yEqyd7Kg2+szeCWB?=
 =?us-ascii?Q?5iIqppTyqAKHo88gYTWWh4BKvJmV2bW4O/L4fYMQ05dL1+qsrVw/nP+UtRkJ?=
 =?us-ascii?Q?7WFqh8BqCSLD5cxxKOohlIwGabhMznB44DHEgimv2ZiXTa6D0hHVKwV0PG51?=
 =?us-ascii?Q?JPoeqKxQAgpobjONQtoPhBmnJFL1lQ/gOi6nFoZUIaTsuKFD0NREOqMs+VQT?=
 =?us-ascii?Q?bSxJAnNv/5Rd42t92ErBAGS2jYKKK/xZAGOEFHZWgVRth0Pcc/Zo1k4iZBqM?=
 =?us-ascii?Q?JyNw8JUNHiMaRSJTIndGB6WsXrrI7eH4nP1IOBqzJO9k4kqlEY4b4Nl4EZbt?=
 =?us-ascii?Q?XjFc6JiTZHcuqBqTYo5Dh3DRot5O0DDqy1qIK953fuKyn3R4tx4vx6cJz7jf?=
 =?us-ascii?Q?P2pSusYcwlHTgYkBlebfM3Iix2ZftDEtMS/529NtKbJv7MNsBj7XZuy8l+Hr?=
 =?us-ascii?Q?fz1y4ioEL2fOEYTLQrBKcRoV3tvkv90AuuYuIJZ2NsKWOZr/CtNrcjl75pbM?=
 =?us-ascii?Q?u4aXGakLAgGTijGxetAIKQUti5/Y+FKsKVPBmMppWFzyuKGDo2C0ebfEXGn0?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6414a601-8b12-4ddd-f959-08dda3a1e29e
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:56:24.5290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S54D+vWmArhBZCkSwSDRxAd9nrRcwTtfZcT6dA+PXkPGZSwaBO9KRB9RqckfzLGecg85acq5XiSR1BZ8Pd2BZvic8f6Xvnv/GyHsu+z9J5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6940
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

Now that the global gd pointer is no longer volatile-qualified,
there's no reason for the temporary variables used for
saving/restoring it to have that qualifier.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/arm/mach-imx/hab.c           | 2 +-
 arch/arm/mach-imx/imx9/scmi/soc.c | 4 ++--
 arch/arm/mach-imx/romapi.c        | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/hab.c b/arch/arm/mach-imx/hab.c
index 600092389a3..ab5861578e5 100644
--- a/arch/arm/mach-imx/hab.c
+++ b/arch/arm/mach-imx/hab.c
@@ -74,7 +74,7 @@ static int verify_ivt_header(struct ivt_header *ivt_hdr)
 #define FSL_SIP_HAB_REPORT_STATUS	0x04
 #define FSL_SIP_HAB_FAILSAFE		0x05
 #define FSL_SIP_HAB_CHECK_TARGET	0x06
-static volatile gd_t *gd_save;
+static gd_t *gd_save;
 #endif
 
 static inline void save_gd(void)
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index d2b0455bff9..d68a1166deb 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -67,7 +67,7 @@ int mmc_get_env_dev(void)
 	u16 boot_type;
 	u8 boot_instance;
 
-	volatile gd_t *pgd = gd;
+	gd_t *pgd = gd;
 	rom_passover_t *rdata;
 
 #if IS_ENABLED(CONFIG_XPL_BUILD)
@@ -675,7 +675,7 @@ enum imx9_soc_voltage_mode soc_target_voltage_mode(void)
 #if IS_ENABLED(CONFIG_SCMI_FIRMWARE)
 enum boot_device get_boot_device(void)
 {
-	volatile gd_t *pgd = gd;
+	gd_t *pgd = gd;
 	int ret;
 	u16 boot_type;
 	u8 boot_instance;
diff --git a/arch/arm/mach-imx/romapi.c b/arch/arm/mach-imx/romapi.c
index ff0522c2d11..c6fe4d8858e 100644
--- a/arch/arm/mach-imx/romapi.c
+++ b/arch/arm/mach-imx/romapi.c
@@ -9,7 +9,7 @@ DECLARE_GLOBAL_DATA_PTR;
 u32 rom_api_download_image(u8 *dest, u32 offset, u32 size)
 {
 	u32 xor = (uintptr_t)dest ^ offset ^ size;
-	volatile gd_t *sgd = gd;
+	gd_t *sgd = gd;
 	u32 ret;
 
 	ret = g_rom_api->download_image(dest, offset, size, xor);
@@ -21,7 +21,7 @@ u32 rom_api_download_image(u8 *dest, u32 offset, u32 size)
 u32 rom_api_query_boot_infor(u32 info_type, u32 *info)
 {
 	u32 xor = info_type ^ (uintptr_t)info;
-	volatile gd_t *sgd = gd;
+	gd_t *sgd = gd;
 	u32 ret;
 
 	ret = g_rom_api->query_boot_infor(info_type, info, xor);
@@ -34,7 +34,7 @@ extern struct rom_api *g_rom_api;
 
 enum boot_device get_boot_device(void)
 {
-	volatile gd_t *pgd = gd;
+	gd_t *pgd = gd;
 	int ret;
 	u32 boot;
 	u16 boot_type;
-- 
2.49.0

