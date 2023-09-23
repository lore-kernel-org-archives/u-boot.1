Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B9DCE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 13:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D93A864CB;
	Sat, 23 Sep 2023 15:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="Xd0ntxSs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6089486568; Sat, 23 Sep 2023 10:54:24 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12olkn20829.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::829])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66ED586538
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 10:54:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clbcjt@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwbVQ/ENSpbtvoOUQX0iagEikd/SjRrXn4ripgGnZpVlQhSA0igaOAN9UlpHeB9IzMkukrCJtiDSrYGeS3fOOb6VtX2tH4JZ1a8FQPBQQU/qmv28MYpSQ+dmP71GOQErH6N1qVdDvo+wylffJ+7UlXJFBA9bIJsGK/Z+mAUZCsBCMRMYmoyI1WDx7ccPE1wd4/yVIltTu/sayHl2h4QaUm7rwc88SJIThQe9PjbKw5LTEUhTNSFEO6RbH25ZHuz83XvBO5SWB6KSjxlAWC4TsSAMFcvTA7dnC45qmX7FiRVHBxKFGqpPm15ljuiVehSsHnccI9j7eH1zhf2XayiP8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNFdD1FrK0BOivE3KEawJJO4czHYOEYtzpY+8HzjgGE=;
 b=E92HE5fdMa6P+CLUK+ZWqP5ShIX9jRhEvGheLtR8atlT3Nxn4P3e7v3uJcr7a4zWOntkLedi8Xreb0jfY4vWQp9xBaJkiKnl7uOLXs3Qbsjs2E+4TnVGajvPqW+1VOWCd99SpxDlD3Z6QTR0bfdyI5F9prH0Na/S3yx+dzpKdgYvY85cLdCfYiuW3arzrqbFfNhi0sZgQEV0JBbqQMS36zPhX9BMU/dxak/y36Ovhvx5dIuaN0IY+NPQd7581OBDjf1qDPN271VL9akSCkcCKg0Ex0yGTLTCW8VuKxUCIxUtsF1Xn14xKdErxu3icVXR0no9/0uYcf9UgZEgT6cyBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNFdD1FrK0BOivE3KEawJJO4czHYOEYtzpY+8HzjgGE=;
 b=Xd0ntxSs1XefAX6FEl6XEzGbSzoQYU3HmYeK2gaaxcJT5q+f+CYUf64u2W1slztCQJadXxIwRp+YYyOWH8TZ5S0CP2b3hxdXqPiCNt7lGcyxPGtt0AqXWXnEvNeZRx555lOEBfWbYVYYwXG4UEoLZw/vMsTf7DkQ8pACt6l+o3+qVdfvzU3yj7BNXciwEFNeeE7E7AYApiQrzBxHkbDo8hXWcDavogLmybPeBADkL8skElLY6kg82psEMuXhP7lMi25jzaGMo9rMM5fbFaoUrFTsV5m8liwdgdVoYO837/6ADGFmEqq5uK7CEfkt1GdMbhVEnK6/Fx5Zya+PPcjTOA==
Received: from PH0PR19MB5428.namprd19.prod.outlook.com (2603:10b6:510:fe::21)
 by PH8PR19MB7835.namprd19.prod.outlook.com (2603:10b6:510:251::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Sat, 23 Sep
 2023 08:54:20 +0000
Received: from PH0PR19MB5428.namprd19.prod.outlook.com
 ([fe80::42f3:fcc2:b66f:75fb]) by PH0PR19MB5428.namprd19.prod.outlook.com
 ([fe80::42f3:fcc2:b66f:75fb%7]) with mapi id 15.20.6813.017; Sat, 23 Sep 2023
 08:54:19 +0000
From: clbcjt@outlook.com
To: u-boot@lists.denx.de
Cc: FH0 <clbcjt@outlook.com>
Subject: [PATCH] board: LicheePi_Zero: add emac support
Date: Sat, 23 Sep 2023 16:53:49 +0800
Message-ID: <PH0PR19MB54288958D7F6329111F426BDCCFEA@PH0PR19MB5428.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [0fryEn433uALFCT8fvKOfNih/94EWdNtabA+V+Kswoc=]
X-ClientProxiedBy: SG2PR04CA0194.apcprd04.prod.outlook.com
 (2603:1096:4:14::32) To PH0PR19MB5428.namprd19.prod.outlook.com
 (2603:10b6:510:fe::21)
X-Microsoft-Original-Message-ID: <20230923085349.19338-1-clbcjt@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB5428:EE_|PH8PR19MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: fcbe8bdc-ad2c-4d9b-3c98-08dbbc12ac7a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BK9r5Xm9WPkGtKNktVSEm5cNThHY8mBZ7hm1zR7p4fHpGITkNKPZytiAoduDWbNLdjMjt8HlFHV0PVqzzXksyrtLVF2s8gSktRdczXVLI3Fhbx2ynRiqKXx45M4oJGXopPcgsXD4kIJekIf/W6qCSvZ1RI70gYmySUy2ZmCxXGjPkO8qRbJcrHoh/FGia2ifT2FLV8FWZHTov1dKqzkGCy09apKEcL5zjeXNsas/bU3MM/BMP7PYjNAz7Sdp6cW8Ss7c7FBB7TA4FDPZQ5FU4YM9Z9LkfkhPmroI2h0RE3QDrYfsUH6GUc+JGnOHE9iYMsGfJy2eIJTRpuT1e892EGb6tOJEGqchszCCTM4SIDfI/ETh/Afsdwve4E3j5dSpb7y8AMxIuvQfs5JolFcQq3eskOBQS0WzVAAEtTYgUdZb/bXxbU6ocUFsK9XwlTn+nDqF/LpzmSE/FBrhkA47MAseciP8XzsMhb6ewOmNGKy1uNKy+TYuRvIJ4sMTFTebyVS3azGsvS8CD/Qpp0hWNFyGtO5evC/h+mNgo+b3WzZ2ooh8hC/6xJFJjWvp8ktmXDw3+w2/O0pb2K0tlC460axD5POiIrKNY6MBm8fo39CGCwByoYRQSxvjkw37BmiH
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tzY5bIso9uJrFmJB5fpTb1T8Z9MRRicj6NpTwNCzWCr2WOJG8YHxSNysXZrn?=
 =?us-ascii?Q?kStgrM2DZRPKrRgmZ+N5QbTcJD+wjl+bSzoVEP+Vlz5IvZHf9VBMyH8qqsSO?=
 =?us-ascii?Q?aGOcqkRCnmCmYDOAYJqVF85S4+ifdvEuhwmGtpXjBkg2kp1j0awFiQDYNwBM?=
 =?us-ascii?Q?7yhDzWpm/qurRMOdlJUCYssDEG7AV3YvhlV3C+hUUO6Bdzd34MF88XLbf3Rl?=
 =?us-ascii?Q?/9scWuGIrfgJE2GmYmXgzPIEadhe5ZfpfEAqjgctzJrkRKSAI2MH6g5h9aiG?=
 =?us-ascii?Q?6AxM7FiQ/0lQO7tXDEK9H25Omzu0D9Omho84VSGsTUsL9pLBh3/iwcHatG88?=
 =?us-ascii?Q?gG/dk+1jEg7myRLTeOsUqlNksxgXPeEQELWOkWPTPtY1NCgaS6KKgZT8g/lf?=
 =?us-ascii?Q?a0CdTRHh2CngxrU5PB011lCNVg9bl2bdp7oSx9wzrWPYr+UhxdEaycTdOMh0?=
 =?us-ascii?Q?CMOkpSGof02+JKo0/om2pSh54g6hs/RVHJ3uJ+U1014GoBkgo8ql2YcOryuF?=
 =?us-ascii?Q?Kgjtgj2QsqmTSlgyWMMQYYEwpcxdU/tnCujFthR5Y88cyzKc4rTtJGo1UYsr?=
 =?us-ascii?Q?PvpBSaRZuliLF9Eiim2Qf+im/8/7rXScGbWk0px9YQI3I9AKulErkSKJyzTl?=
 =?us-ascii?Q?oFKO/1whlbD58GXvTpw0NvCRYeO1s12Vr2P4Hskps0Gmry3kb1oWpuN+D3LZ?=
 =?us-ascii?Q?mvq6iVqO+SJmNy4WBcVNVn9uCyqns5wFM6pR3En2p5DEj+8r2wNoKZu9gF/7?=
 =?us-ascii?Q?f7unlYgjW0WMLHfi8JOydK5YOGO6vZWAb3YR63Aq9bSl/R7LNWKqlHsPeyLu?=
 =?us-ascii?Q?+a4Qe0xu/rxyltysdP1rTaDnmInS4Ip1Qv29/Bm1K6GzVRRLu0GaDjLLJZ32?=
 =?us-ascii?Q?0fQMTPFcEckViWdxqIU5UH6hwCFPsc9kkQfB5KsneJV9C/7aKM3qeIgPh+4a?=
 =?us-ascii?Q?qM2x9MtBnxOxgopQUMlxl9NAn1oBjoVz2/7vjIyoIsLyzPtXMgqt/dSvDfQX?=
 =?us-ascii?Q?RfYQgzL0tyoBw5Ew8Z3W1LyOIv3t+wUDY7PrBZ6FAsqqnGzqA6FkmtpNwSNb?=
 =?us-ascii?Q?iK9hv5E1Q/e2EQMw28YrTt+/TWEAvZVCgnnsBYKGUzZNNv0VF1q7yp11aNem?=
 =?us-ascii?Q?LLaVPEmkzhkcDhF4u+lo/MkENY+wlRt5Zb5mSI4jpxJOxb/0gNOQYPHhzQzw?=
 =?us-ascii?Q?42s8ohP5U3aqc9WJKvnEL1BdyP3HImDHHlHE+g=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbe8bdc-ad2c-4d9b-3c98-08dbbc12ac7a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB5428.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 08:54:19.9233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB7835
X-Mailman-Approved-At: Sat, 23 Sep 2023 15:24:23 +0200
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

From: FH0 <clbcjt@outlook.com>

Signed-off-by: FH0 <clbcjt@outlook.com>
---
 arch/arm/dts/sun8i-v3s-licheepi-zero.dts | 6 ++++++
 configs/LicheePi_Zero_defconfig          | 4 +++-
 drivers/clk/sunxi/clk_v3s.c              | 6 ++++++
 drivers/net/sun8i_emac.c                 | 7 +++++++
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/sun8i-v3s-licheepi-zero.dts b/arch/arm/dts/sun8i-v3s-licheepi-zero.dts
index 2e4587d2..b3246b94 100644
--- a/arch/arm/dts/sun8i-v3s-licheepi-zero.dts
+++ b/arch/arm/dts/sun8i-v3s-licheepi-zero.dts
@@ -49,6 +49,7 @@
 	compatible = "licheepi,licheepi-zero", "allwinner,sun8i-v3s";
 
 	aliases {
+		ethernet0 = &emac;
 		serial0 = &uart0;
 	};
 
@@ -99,3 +100,8 @@
 	usb0_id_det-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
+
+&emac {
+	allwinner,leds-active-low;
+	status = "okay";
+};
diff --git a/configs/LicheePi_Zero_defconfig b/configs/LicheePi_Zero_defconfig
index 009384ea..779d5c9d 100644
--- a/configs/LicheePi_Zero_defconfig
+++ b/configs/LicheePi_Zero_defconfig
@@ -5,4 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_V3S=y
 CONFIG_DRAM_CLK=360
 # CONFIG_HAS_ARMV7_SECURE_BASE is not set
-# CONFIG_NET is not set
+CONFIG_NET=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SUN8I_EMAC=y
diff --git a/drivers/clk/sunxi/clk_v3s.c b/drivers/clk/sunxi/clk_v3s.c
index 6524c135..680a43f2 100644
--- a/drivers/clk/sunxi/clk_v3s.c
+++ b/drivers/clk/sunxi/clk_v3s.c
@@ -37,6 +37,9 @@ static struct ccu_clk_gate v3s_gates[] = {
 
 	[CLK_DE]		= GATE(0x104, BIT(31)),
 	[CLK_TCON0]		= GATE(0x118, BIT(31)),
+
+	[CLK_BUS_EMAC]  = GATE(0x060, BIT(17)),
+	[CLK_BUS_EPHY]  = GATE(0x070, BIT(0)),
 };
 
 static struct ccu_reset v3s_resets[] = {
@@ -56,6 +59,9 @@ static struct ccu_reset v3s_resets[] = {
 	[RST_BUS_UART0]		= RESET(0x2d8, BIT(16)),
 	[RST_BUS_UART1]		= RESET(0x2d8, BIT(17)),
 	[RST_BUS_UART2]		= RESET(0x2d8, BIT(18)),
+
+	[RST_BUS_EMAC]		= RESET(0x2c0, BIT(17)),
+	[RST_BUS_EPHY]		= RESET(0x2c8, BIT(2)),
 };
 
 const struct ccu_desc v3s_ccu_desc = {
diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
index 04c3274f..57e6857a 100644
--- a/drivers/net/sun8i_emac.c
+++ b/drivers/net/sun8i_emac.c
@@ -895,6 +895,11 @@ static const struct emac_variant emac_variant_h3 = {
 	.support_rmii		= true,
 };
 
+static const struct emac_variant emac_variant_v3s = {
+	.syscon_offset		= 0x30,
+	.soc_has_internal_phy	= true,
+};
+
 static const struct emac_variant emac_variant_r40 = {
 	.syscon_offset		= 0x164,
 };
@@ -914,6 +919,8 @@ static const struct udevice_id sun8i_emac_eth_ids[] = {
 	  .data = (ulong)&emac_variant_a83t },
 	{ .compatible = "allwinner,sun8i-h3-emac",
 	  .data = (ulong)&emac_variant_h3 },
+	{ .compatible = "allwinner,sun8i-v3s-emac",
+	  .data = (ulong)&emac_variant_v3s },
 	{ .compatible = "allwinner,sun8i-r40-gmac",
 	  .data = (ulong)&emac_variant_r40 },
 	{ .compatible = "allwinner,sun50i-a64-emac",
-- 
2.34.1

