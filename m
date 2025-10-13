Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9087ACCD185
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 03:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 672C88383F;
	Mon, 13 Oct 2025 05:42:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="X501svVQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FF7C83858; Mon, 13 Oct 2025 05:42:01 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39F328383F
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 05:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tu4czyKcSoxsOV9wVhXmY2O1yiSzHL1IBtwSwa4ACRkOpaCu41lCqf6hOtYin1LfnWOhDeACh0uUpmAUPMfC8TvLCRZ5Cd6+oHzZmLORMx7IgFRSN8BrOrbx1wVpbnx5tX4vdeA6Sp9Q++yGV3khJLaBdjeMkyNyk+Yl3XuKOL7Cx/sfNU9gB5V+2wwiK/V3g+qN2Tq5qyETxJ1BoQ5YlMwIqXhd/TNUpzpM54eUvahxokp61onpxaPl011JIr20+od2fMh3Uxg7kaq5omegUODBVT+wzQerihUuOyfkoxw/P1TqC1P0mQRNjYLNs2AlZw2lOsQRuGFvTU/qxcEsXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbPqsUrc78m2mNgiWrgH3MLfbD8jBdsgi0oUc+Q3sHw=;
 b=fs766vKDqce/N15tGonGXPJLpXkObzBoyHC38fnSmvjKBJujNQjbPnwwqlUC4vTU1dn9VcVSwIj7Lx+JOziHiYW4pRcy/HcAQfo5+f+MD9LKSsNXCFZkgLMqHfTKb7C0x3WHDhsBZdkkiapWWPF9d4sSB2SsWmfJS0bbXVuSmcfNU/2IGSlL19cbBdSOcBUcCSAQzpVNZHn/mZL7ZXZhX6TjytFEEv/YHzW6y5AxYCDOwoyGDgTc78uXk8LCgiesxom9pqULNNnkGAVXj+Z1gN9BB2RgTXQZBj13qhq17NtLcFMTB9fZjhj8lG0wUvOQ/NE31ce+kaan4xl8PmnVjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbPqsUrc78m2mNgiWrgH3MLfbD8jBdsgi0oUc+Q3sHw=;
 b=X501svVQ1W0gnoTY9c8+51m5SyZf1op76Co1BeHfLUYqML18IiZrukunZX5MkZwn4W7neYjnbSY3LW47Hzzt8F4jZ9znfeTPcWRUm6GWPSy9V3V57iescb30yfw5NgCeu01O5Nt/OShRHCQM5Qtn6V2kzmn1fqdniBMC1k5e4B8zJfZ9bxDPoL8kO1p3RrDYKdw6kxfdBm0qWI13zUgJcmVX1f0Nl90YYGkFOneejBEHQAg4TKGkac71JII2vgWT6nIMygCHpfM31V1n8+WBVeJPwn8Aq3oY+UpicwabLbuXuXb7E013+eEGnHgv6RmCreY0I9Kx3e6O9jYhihLPQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by DBBPR04MB7786.eurprd04.prod.outlook.com (2603:10a6:10:1e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 03:41:56 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 03:41:56 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de,
	festevam@gmail.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
Subject: [PATCH 2/3] arm: dts: imx95-15x15-evk: Add -u-boot.dtsi for SPL and
 binman
Date: Mon, 13 Oct 2025 11:41:27 +0800
Message-Id: <20251013034128.1752157-3-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251013034128.1752157-1-ye.li@nxp.com>
References: <20251013034128.1752157-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|DBBPR04MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: c5339469-d0c8-46ea-3d7e-08de0a0a74be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|42112799006|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jS18lZ0BfGZp0bOYaeIxhToIP0uYvj01lR9JypJILwFjySBy7vOVb+/T7K3k?=
 =?us-ascii?Q?nr4uS1b2vmkI8urvZWbMny9Qqzy0Ujfba1R6GgqEZ05524jIPXwdQpE4vazh?=
 =?us-ascii?Q?R381W/Fp9k3dTzwpH2wUmvjmV6P9Q6SVJojyL/04pe9W/CqscNnQ+q5WHFTT?=
 =?us-ascii?Q?XL3LyVHUcF+DRCA5RFefebxEPYWTcwpgeERMH9Za+LClsLrc6VCtFULdpkEM?=
 =?us-ascii?Q?3dG/VXwsifWFlrpG2pTC59klwJ25DPZLEy8/ihBXUPwTUNFreTs10vEU6hcT?=
 =?us-ascii?Q?nsU1zgbQL44M6qtjs7FZsV3Mq+1S8r7jG5HzX+kuCm2jCwsYqY4uPzMp0+aT?=
 =?us-ascii?Q?93wI67F7mm11dlqT1yCjTHjNrAeDA+koudTgyKSKLpEJnInC1LH/dkO8wfSu?=
 =?us-ascii?Q?ZuZrGF+g3fMB29RZtmodsYKR4PVAiLXcDcTaeeC1Xa6V+rLYKvI3f/hcF2vS?=
 =?us-ascii?Q?K6k32ngUxkr+S0v5Ot4PZgH0MyhD0bnRBu1gjBQ5VN/6JBhNhBrN8ZmpGZkl?=
 =?us-ascii?Q?UA7OohrCO2esGYyLTsZBHNIJYJ/nvRZ8jOVr5Wr2avK4et1jNslzVHz7+rIw?=
 =?us-ascii?Q?gIPjV0xPRYhQRkZTilbYI5vaB4s90GmTOEGfEs/mKxEAbgZk9dD8Zi/WxudY?=
 =?us-ascii?Q?DljXz8310a1CJIRkv3rpljDaqcAm2mNRCtDuFCAQY8x0mE8iT7M+TQdmQ70V?=
 =?us-ascii?Q?mFkV0U9zpln6ydkVDpCXUvKurLKTo5sZLaVDDONYau4E6OfJ4u1uhbAZgUYD?=
 =?us-ascii?Q?Awuux4KYeZeP/fMyQO7NCEfgtiRLCZPkk945jGseMIMj5CDPnLjClqG3CkuN?=
 =?us-ascii?Q?sZCJeBuio806PF5b8WERhvYL++fKwvMBQvNhSlkhdveWkJ4L9Ax594srnxIU?=
 =?us-ascii?Q?dEqUYqbHQxMdz+cKixBtSrYjJ9Cl50+cDNO6LXFZQsJe4cqORtwxTSUc4UhV?=
 =?us-ascii?Q?2r7h8iaLsqAoLH8/M9TALNeWZ/iQhC717nhuZgWQuIvqd71/BfZOYFGIgjdQ?=
 =?us-ascii?Q?VQMXqipdKMlRMXIfcnlgDkeZxxSh/vgFySSlKgWHqeNo4tpDs+Wwy26TExjO?=
 =?us-ascii?Q?i6K0VNtBc+S2ot4bfJ9LzqCEtlKZoomrGJxJTSmcWm3c9lN8oKhUKF3u4ZDE?=
 =?us-ascii?Q?YmY9RYMvX5y4k7ns0l2xjc157Qf3Jwy8pmr77rN/h8KZ2Ms4Gy069bIdKhGO?=
 =?us-ascii?Q?6KjKiMOo6QwDnwowR4uE6sKpV0CPtXPtCjyaYHQsnRlcd9dLmqi6AZ6/HHs1?=
 =?us-ascii?Q?BVciPsF22QjTOqoVI9cfq6TBmu0VGUVMpQ4MzxlFQoA89CLXq5kz4ZDcOqKB?=
 =?us-ascii?Q?s1uT+kG2iJWj3HGkYGtilZfXVg1/x9pgQHHETGTKxGRZpEHFqPtda1s7Pd77?=
 =?us-ascii?Q?uAvEVADNjathyZclJt6ZtKMsJXtL+u7REmMok1jlJlshwJ/SIvlPPDLdSBmr?=
 =?us-ascii?Q?Xphgr6/ehFdWfpjY1laiMpO7g7tFihYhajafGXztM3HKC5NSwGjefEnJ3PuF?=
 =?us-ascii?Q?tj/R6G9+s9Qebn7sM7xoUCaNTnvivQAxQfFT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(42112799006)(52116014)(376014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W6FyTvnISaucV+GWqU8FpHhEvuYkRjhst+23XvPtNIZToElapH46L/3km9V5?=
 =?us-ascii?Q?3pQ2Fmu6q5x9us7z1OIyRnysdRxhrSnz8k2C5uh6CzGw6khEYt2YXgogU6Ge?=
 =?us-ascii?Q?Tl4ekmqK+u88iGpS/IUHk0UwAhq+5v7D2fJDFtbK5J+dpuSA/KS1cy9eDj/R?=
 =?us-ascii?Q?aB+BKtSx8YN4EB32uD4RnkJAoh3Gl3pVy6r+BRXRkscW3BzSesfKD4b+IMyv?=
 =?us-ascii?Q?RgLoqGSvXmLn22vToYmB4syEUr51OLY77boxlqNB/gYwFSsFNJDETok4iAUi?=
 =?us-ascii?Q?tDDdAmpEdg005Ew5UeJNKdyqbDzFpxjDLYXyjgQiXKeBlYkStplemIL7Cd0F?=
 =?us-ascii?Q?iAxV/uesyCGMBy7jcGBuNV9q5Ox5paAlEiiq/3/ooJ7gQYsf6cZl8xn8mY5m?=
 =?us-ascii?Q?0flF360MKpuruiWQruP4JLChumxtQAJN246WitFSIV74lC1W9lo4ZjnD+62U?=
 =?us-ascii?Q?Cy5LMOdRI/lvAFEFo7BtPqn7xnkdfT6hRevUBrB3pxCiQOdi8gHeZmKWTzyI?=
 =?us-ascii?Q?nt+in1W+JDJSAjIyg3+/AzXUYpHpa1hPh5XORPxUPSayq6q99h+dtcVxRo2+?=
 =?us-ascii?Q?n+3L9Fb4xC0nx+GS+90CjjHeFekirxbJerZKTFDdfAquyDTVBYQy+lkeqarJ?=
 =?us-ascii?Q?E45l5ckhwdOxxVCiYT0UlED24G/8G3tudE5iznbteJqSPAOA1YGFR6WhLjK3?=
 =?us-ascii?Q?JoA/4I9M+Op22YGceNj6iAXZGeRCTkkM4mJ8n0wcyDsAT0Gx2pNvBmtS/H6j?=
 =?us-ascii?Q?klt2LgQ6C8XLbC5lldc++nsHm+SxMwU8dTyHVIOE7yDZ97k+KJ64h7Jxjwvc?=
 =?us-ascii?Q?itex6wh3OIYe9KYLKr1N0O9+v8r1V6SRxdomPH5vkdX7tqYMbayd9iM2AUtg?=
 =?us-ascii?Q?kONrwj3qieOoALT9/+0aCGZM0JZPzh0QoaftGOQfBwSRMfbu2YWWFSoi8nlu?=
 =?us-ascii?Q?OolYWg1fJUjKwgZPfdT8lc3SqK7nAmcc8jfk0PIWGZR5giYMqWWYvxvJRMhZ?=
 =?us-ascii?Q?YLKaJ00+K9pY2C6EWUeXKjX2H40Mxecc1gVx67qgEq3j3H2HnIqU4VEALRBm?=
 =?us-ascii?Q?HkSbsng1C4wJR2Z9ADbnUb4T0xbu6f2kv6Z1QKsNGYVlWCDl3GT/LF2DeJQ3?=
 =?us-ascii?Q?Oa9vHjPcdaRcVN5kxLg9rxnUoveuFuP4Mc9m9LErqD3jbtf85QGuifxixCPw?=
 =?us-ascii?Q?EJIQ2Ak2VSnNHgD4jzEc4/NrffQx4N/P8MDhvW9heE2gxSuqIKZayD5Srg9S?=
 =?us-ascii?Q?FvlYhpP8Nw41aFGNudTAu9cQWYAIaxs8xTRHuMhJJT4O0923J2FC11viBhpv?=
 =?us-ascii?Q?BvdtYYT3nO+B3HOmS25m++uuqPyT0jlkZB/TPKlepFJIfbD+sO/4D9R9uuKT?=
 =?us-ascii?Q?OHgaCGl9Wh2du6zsVnGSVy0/EmN23Bls+VcR7Mqh3ec6FMJ11FBvoA+cNn/M?=
 =?us-ascii?Q?PSMLxzSj51/s9lp4xXihbgmhw0Y1xKLjtNfzb6t3RTBDiV6m7WJdYnBZH5SP?=
 =?us-ascii?Q?YFQqLK57FdHUUxq9I0sIPYecIxGW7MGVv+AMR3fKUOA0v8De6cUp01fv3IlH?=
 =?us-ascii?Q?5igfe5BTb0EUCfgLqQk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5339469-d0c8-46ea-3d7e-08de0a0a74be
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 03:41:56.0787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AbzdlSdjjdVaAaMqzsP8OA0cjPvAuSyn2zMuq1JFd2VFt8fPgLoG0yogIce5s7YN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7786
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

Add -u-boot.dtsi for iMX95 15x15 EVK used by SPL and binman.
iMX95 15x15 EVK uses LPDDR4X which needs dedicated DDR FW.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/dts/imx95-15x15-evk-u-boot.dtsi | 85 ++++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 arch/arm/dts/imx95-15x15-evk-u-boot.dtsi

diff --git a/arch/arm/dts/imx95-15x15-evk-u-boot.dtsi b/arch/arm/dts/imx95-15x15-evk-u-boot.dtsi
new file mode 100644
index 00000000000..514dd729be9
--- /dev/null
+++ b/arch/arm/dts/imx95-15x15-evk-u-boot.dtsi
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include "imx95-u-boot.dtsi"
+
+/ {
+	aliases {
+		pci0 = &netc_bus0;
+		pci1 = &netc_bus1;
+	};
+};
+
+&{/binman/m33-oei-ddrfw/imx-lpddr/imx-lpddr-imem} {
+	filename = "lpddr4x_imem_v202409.bin";
+};
+
+&{/binman/m33-oei-ddrfw/imx-lpddr/imx-lpddr-dmem} {
+	filename = "lpddr4x_dmem_v202409.bin";
+};
+
+&{/binman/m33-oei-ddrfw/imx-lpddr-qb/imx-lpddr-imem-qb} {
+	filename = "lpddr4x_imem_qb_v202409.bin";
+};
+
+&{/binman/m33-oei-ddrfw/imx-lpddr-qb/imx-lpddr-dmem-qb} {
+	filename = "lpddr4x_dmem_qb_v202409.bin";
+};
+
+&lpuart1 {
+	bootph-pre-ram;
+};
+
+&reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+};
+
+&wdog3 {
+	status = "disabled";
+};
+
+&pinctrl_uart1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_gpio {
+	bootph-pre-ram;
+};
+
+&pinctrl_reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
-- 
2.37.1

