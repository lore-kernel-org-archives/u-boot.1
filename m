Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7447BCD4F26
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 07:02:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6BDF84A30;
	Tue, 23 Jun 2026 08:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Fa/VGbum";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22FD6849CE; Tue, 23 Jun 2026 04:02:56 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11622849D2
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 04:02:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kq//mAJFOREaUP4rPnG0iElJKDF+Hft//Hrmxdto9mvdgynXb2shKxQYHzqmqwdD6JHqU/6SJn3KKqn0X4b71HL5R2WbWxIcddTR43JrGK3Xd+iasOXd6n1ybBxsMA9nAgxFgeaF+EY+2n24W5V4UQIakfPgIvYd1so+5mun2nmGaGi8vp7cxwfFSaJk0TkwiopEC2C5Wlqaxcgr3NTJEiTq8uQHS46DJ0B2PhS9AaBIlpJrHPvYTiOoKD7cuk+k8DkN5y3wjaZhNaHIaDyXBiSwBf1qtpK9M+AlC0igMqPYGRc+/5kayVD0grTULGhDyMkixNIBqTWa4dmVgBBmvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gZD2GN3wctLfo2NSx78kUpJVqCnwGmi2r9IWR66gGU=;
 b=Zxp17Xc82iNu801VXwJIuLvJe1fIsraeHEb1T9pegIopwnp9k5GaJdUecj9ICkIOlY+beABjZEjt0M9AW2Gp6s4lO4d2Se2+wY3YdPECzo05lHCTO8ixLA9Wvf9n2PJgwz/T/tO1gX+iDxTGaffP1+heyIxd8kDjqUSQi66Qv9+0E1RSCcFEp654V+gVedi7QRrfvEySDkIB8EmxpbIw5Pa7Q6NThpN3dxWcN+nUXNnSzJELONsWiLhMdXu52TVxp7YF8DO3ufRzD7HjeNYYwdY1Az3RSXpQ0RPpBQZsukvSuf5XWK1Qnw6LftJnGlETvWvoMALLirFhlbZ2IExqBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gZD2GN3wctLfo2NSx78kUpJVqCnwGmi2r9IWR66gGU=;
 b=Fa/VGbumhoMCSjD9J4j4xwl1OXVQXGMoKFQ4OWXDXPuk6YIYiha8JgJdHtPt9uZw+eY0CJa/GB/+GmVaLRY7tAcScADBh5qzQqEuPIQquKwAsuEFiwmL48SH8NxTl8i9Pta63rsadVbXpxYizNqcn3GLYiGQaEXt3i1Dv5sicMIpitmafnd0Avr4kkEB/c+SDfrHayAielYCIt98QyZIGEn4H7/mLSpoGFjjkn8u9tAot8uhzQLmU1lMBJn2jrXSlVeci8k5eMxuWCsAdZf5NKOh6H/GhN5RVj2k9VQkjwTArhQJCBlRjBH8XB0n+/AloDpBZAK0s9dnWKm3E6ngQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by CH4PR03MB7627.namprd03.prod.outlook.com (2603:10b6:610:241::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 02:02:51 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 02:02:51 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v4 2/7] arm: dts: socfpga: n5x: update GMAC nodes and DT
 register settings
Date: Tue, 23 Jun 2026 10:02:16 +0800
Message-ID: <20260623020221.32362-3-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260623020221.32362-1-chen.huei.lok@altera.com>
References: <20260623020221.32362-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::34) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|CH4PR03MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 30931d3b-d905-4489-f13b-08ded0cb87af
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|3023799007|6133799003|11063799006|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: QGWyHZYgk+ek84gzMcMTZK5ibmnY8d8I2DceLK6ddC+Y1o5j+uwaHHbGu0jq2EehpBJ5YcPBtoBud45es2hUIobi7DDNJgi6eW7V6XqMzRKzvWSpxViFLtblDW1cUjzQlLFMLaiMaoZW+70zNGjQ1Qg4dPFlwIgVDvUlE3rlz+Fm4JqfqnK9Fice7VmlLPSSaRh6irJemOec0YQWvTd0cftK1GLYJ99tM7t20BE/qgiJB0Fz7i7IFhW3tiV8P36QFeib5ikt5v7vEEhNoETUodOa5Mzcex9+/PKM4/HZAKfhivvFphBlfDvCmdx+S9/BqlLiFr+IOwTbwN5w3Oyc0Evo3G96gk7qM88ta1OiwENtCajPGU/0Vhu5Nl7tGpwmUMUeiNzOGunXer+wvsxYsgpFsmYKN1bOUpGJ/yEbODvd+wO2eLllhRL65aaWOXUWTZt7/4EMKjbhYpJb1pg+EjiNQRQqpS2aKqAbRPe2JI1jLAb8R+mh4MGmhXfq/zARHWY2OsX54h8wv64eQTqFi0GFp+ITqc29HI9iiMwBLY9KqHEl46e96eS9jEumDIRYCIFSHwxRfqmX1VxDiKYZhOx/cQAzgW41oUl0p6VeSZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(3023799007)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Efk427NWuDWcSfz+X2GzZsehHoDvrF2vae9KGMKEQ0RpA8HU3jgdghHhGKB1?=
 =?us-ascii?Q?rztDZ8XQDJUnKKaq9TMCsXikA45w2ifPH325gNAB/kLbZbETpCfFvxCMgr5i?=
 =?us-ascii?Q?3RM8UL6hmJ7n8ohNmf3+1b36mTJZUmpnuNjKRV7ayOPteH026BTGzwEUHvwC?=
 =?us-ascii?Q?85tfd1PBzi7U/N2M2uR9nRYfiQBOhg3Jm7aYo6tUFu7hXYBh1hPtN1eXztQO?=
 =?us-ascii?Q?b5FxkuAlpA7nh1MZWbVSzCgGbLjHG3gwoOgSquHRh49tdeks6LxdYslwx4/b?=
 =?us-ascii?Q?e8ZOFR42/yNCuiN5VuExIN/Vz7vndEdwxaQw9NBNVDCZok1qlQvgvRWLXhhM?=
 =?us-ascii?Q?aR5WnPRrMtNItX51ThVufV7wUxhHJwDeFtqhhpW8abeK+Ek17cV4NvD9Zv3z?=
 =?us-ascii?Q?2xOtvYzkfcEK7cIxdsnkmSqNnKpUjsoOauLR6fUdlQOmmxgcDpR33jOdwK3i?=
 =?us-ascii?Q?KUs9T+xjhAEm/ikJr+zzWUPM1iGPk/u30dW0EOI0OE+Ii1UcZLE6ZIYiMU1w?=
 =?us-ascii?Q?XItjjYk2IcehJB4cyhjXDHnGzvDqyihvHmLoLMw82MqtY+uXQ28udobjaQ/V?=
 =?us-ascii?Q?nBHqMNJjlwJHtnb1R4y/LxGAXtiRBtzHVKIIRKr42AuORV/RE3ZqXapb4zY0?=
 =?us-ascii?Q?N6f8P5ZrC5XsfD3GqRx9K1q5i+IBEe0km/5YIbnJG6hh5L8bKIK6hrWo0/jc?=
 =?us-ascii?Q?J3Mt8WH91owpalqO9mO9FMr3RujQLJpgVpzr6jSMQ8ew9RQgSb/hBvtXzVoq?=
 =?us-ascii?Q?eZyYowAsDki+z7F7Jpno1emgII5vdMnt704gdEjopHWsE+SmSFpBqs4sDPLm?=
 =?us-ascii?Q?vWRl4mzrp2ef17OIWYAbkEiyCbKCaWnEjJiuM6ar1uDztspfd+G8vRoY9daj?=
 =?us-ascii?Q?vMnOd7UshZUlB9IVkYKLFYu5CIngvpEI624x1bjfWhrCa+IgWJoavQtLbPa8?=
 =?us-ascii?Q?FTw3lVPXiZLeRgGAlVeYeg6sc6q0o+8wVWTmHCU7emVPlO8dyvJ5ByzxEhBT?=
 =?us-ascii?Q?yayQoAIBm2w/IUl72esCeyQUL02PfFZt0qubKMnXJokjikttOxIfzVKTWFsD?=
 =?us-ascii?Q?mQSTVSLIy5vFxwgrlmlgX7H5q0FDuLTkZBDZba90TyN81AFMvNthJJhscL+A?=
 =?us-ascii?Q?czKEePhwfs5FsUxd1fL2N0efzaMZRqNnfwAnGSJdR57Iorwbn32MhIYzNSHf?=
 =?us-ascii?Q?31dHGdmf19FQWHNNiAdSmekal6p/ZVCd04SXEsZyRrqFY5IPj79CQvdTFFZZ?=
 =?us-ascii?Q?1AOR7ywQ19c1RiS0hogz61rKaJSrAH4Ryz120FiXwW25KUWbUgh0aJXEqf/m?=
 =?us-ascii?Q?KyM52edZ0hHnfc3IYyhqT+CbfGbthH3VmukOauB54Bs179K03TuElK55DwXu?=
 =?us-ascii?Q?crm2cFWOIKcEqcd/Hn6j+X66qLiSoo9Ly1jZrYcWz/VsXg6UEOpfUy98VpC6?=
 =?us-ascii?Q?sWKTYT6FpeoXQemMLFKs9jgxsRqdnalEIHnK/SqMB9IiLpVycqzjkg27QhS6?=
 =?us-ascii?Q?PwdhOBOwhqLls8dvObDMLsQiKtmqVh/kayHpVAPFv9uKEKqEviErmhT+YaDm?=
 =?us-ascii?Q?2fuGsUDoN+H0rXKE213NIJxHEshspyVUU+NjSC7U5Px9VWe1LfdqxmjFkugX?=
 =?us-ascii?Q?FZ45QeZJnVcmm6swtztpUSjTXyZuk3ZFO4EvQFClv5WHBPM/wiqaYO3zTzG2?=
 =?us-ascii?Q?2TJvIh5aicwQ79ZRqAk2rwcilsRUmvrmmi0vre8rQjY9/WoRn3famNXTLgiD?=
 =?us-ascii?Q?G+iH1Nr0P+Nxt/XnInHUVKC9aMUkAXE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30931d3b-d905-4489-f13b-08ded0cb87af
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 02:02:50.9510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvTYz/QlPE/8ykp7VXZnVpwJE81Ku4awCV57xzzDsJNLfYU1AruDKEnSXWC0tm0W+mXA6KF2wlK+LY1gk6x3g64iqKW5ayLu2kPDQZtQfOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7627
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:59:46 +0200
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

Enable register settings in the N5X U-Boot device tree by adding
firewall configuration nodes under the L3 interconnect firewall.
These settings disable OCRAM security at the CCU and relax MPFE
firewall restrictions required during early boot.

Update the GMAC nodes to include proper compatible,
reset-names, and clock-names properties, explicitly setting
their status.

Remove the clocks property from the QSPI node in
socfpga_n5x_socdk-u-boot.dtsi. The QSPI controller clock is obtained
via cm_get_qspi_controller_clk_hz(), so the device tree clock
reference is unnecessary.

Additionally, include socfpga_soc64_u-boot.dtsi and rename the
soc node to soc@0 in socfpga_n5x-u-boot.dtsi to align with
the common SoCFPGA DT layout.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 arch/arm/dts/socfpga_n5x-u-boot.dtsi       | 38 +++++++++++++++++++++-
 arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi |  5 +++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/socfpga_n5x-u-boot.dtsi b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
index e27a64651e1..dbfd2abfd59 100644
--- a/arch/arm/dts/socfpga_n5x-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
@@ -5,6 +5,7 @@
  * Copyright (C) 2020-2021 Intel Corporation <www.intel.com>
  */
 
+#include "socfpga_soc64_u-boot.dtsi"
 #include "socfpga_soc64_fit-u-boot.dtsi"
 #include <dt-bindings/clock/n5x-clock.h>
 
@@ -15,7 +16,7 @@
 		bootph-all;
 	};
 
-	soc {
+	soc@0 {
 		bootph-all;
 
 		ccu: cache-controller@f7000000 {
@@ -46,17 +47,29 @@
 };
 
 &gmac0 {
+	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
+	reset-names = "stmmaceth", "stmmaceth-ocp";
 	clocks = <&clkmgr N5X_EMAC0_CLK>;
+	clock-names = "stmmaceth";
+	status = "disabled";
 };
 
 &gmac1 {
+	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
+	reset-names = "stmmaceth", "stmmaceth-ocp";
 	altr,sysmgr-syscon = <&sysmgr 0x48 0>;
 	clocks = <&clkmgr N5X_EMAC1_CLK>;
+	clock-names = "stmmaceth";
+	status = "disabled";
 };
 
 &gmac2 {
+	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
+	reset-names = "stmmaceth", "stmmaceth-ocp";
 	altr,sysmgr-syscon = <&sysmgr 0x4c 0>;
 	clocks = <&clkmgr N5X_EMAC2_CLK>;
+	clock-names = "stmmaceth";
+	status = "disabled";
 };
 
 &i2c0 {
@@ -132,6 +145,29 @@
 	clocks = <&clkmgr N5X_L4_MAIN_CLK>;
 };
 
+&socfpga_l3interconnect_firewall {
+	ocram-firewall@f7100200 {
+		reg = <0xf7100200 0x00000014>;
+		intel,offset-settings =
+			/* Disable ocram security at CCU for non secure access */
+			<0x00000004 0x8000ffff 0xe007ffff>,
+			<0x00000008 0x8000ffff 0xe007ffff>,
+			<0x0000000c 0x8000ffff 0xe007ffff>,
+			<0x00000010 0x8000ffff 0xe007ffff>;
+		bootph-all;
+	};
+
+	mpfe-firewall@f8020000 {
+		reg = <0xf8020000 0x0000001c>;
+		intel,offset-settings =
+			/* Disable MPFE firewall for SMMU */
+			<0x00000000 0x00010101 0x00010101>,
+			/* Disable MPFE firewall for HMC adapter */
+			<0x00000004 0x00000001 0x00010101>;
+		bootph-all;
+	};
+};
+
 &sysmgr {
 	compatible = "altr,sys-mgr", "syscon";
 	bootph-all;
diff --git a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
index 840537c9d0b..1f7e31bcae3 100644
--- a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
@@ -44,6 +44,10 @@
 	bootph-all;
 };
 
+&gmac0 {
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 };
@@ -55,6 +59,7 @@
 };
 
 &qspi {
+	/delete-property/ clocks;
 	status = "okay";
 };
 
-- 
2.43.7

