Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D27AE6C5EE
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 03:12:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69A5E89610;
	Tue,  3 Dec 2024 04:11:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 877FA895E9; Tue,  3 Dec 2024 04:06:05 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20707.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::707])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D242189589
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 04:06:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQI8cX82GNYYSpn2gWkeW0pHlTIfoIXshfP0iOBVNaCEOvnAcBGygbW+BX2SuI+sm7UBVbpVmd84+MwDNkNhmjxQ59U7KjsKsn858gDVDsMVFbwPjC9BaAdxhuNMTflXBIxnDycaduvq73kdPCI1q33M5RQqoO7afTeOKgVx5bXew9bB8nwMaZKIpvC4OuiKccqtq/fPRcueiBZwjgQt/4aypvodtKCsaFpHMOnQd+8u1YziDUTYVlmh6somMzdJQ2Oyo8JlQlzTA5Vp59nvL/imofeMSYWu/n5Bmx7xJ9BkFfPM7rCVTRdYXmDNqmE4pHOBuR6XDkZrOYmByC0xBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kh5mgIA4ja6LO/hZJcVIRfuSdrfaw7N7xlnEsiBTlMw=;
 b=mWMFNcPW3rOXk+xGyL8rBcQTbsmv8j+40Hhc20CgRX6tb1S4vp2cUvdGdojvrYVlr497s2Wymf/hpqkgkyRkEmmlfVofrEJ7TMbZC4snU42UmSvelJz1fu1G+gCn3lzKWFa+0eit08LLymlbr8960h79YbVXYOef2J8PMNsRQMHhxP2MIyZbzC+lumIX+4Q3Q0V9C+TYyTOUZsBF1XS410JGCncqVXuQqkeu7yNU2YFuJd3Xol6jLJDikHfpKZr6XOyOa6bBlOET/sJCl6SVfGoNu98w4pD74CnhSaG5ool3r8c6mrU4rNFnyvdcgW7MvBD5OVoo7ONNN2XlgcjufQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1259.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Tue, 3 Dec
 2024 03:06:21 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8207.010; Tue, 3 Dec 2024
 03:06:21 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v7 02/12] riscv: dts: jh7110: Make u-boot device trees
 adapting to upstream DT
Date: Tue,  3 Dec 2024 11:04:20 +0800
Message-ID: <20241203030430.26089-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241203030430.26089-1-hal.feng@starfivetech.com>
References: <20241203030430.26089-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0013.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::8) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1259:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd2d949-970b-41a6-04be-08dd1347768c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|366016|41320700013|921020|38350700014;
X-Microsoft-Antispam-Message-Info: Mnn01bUWl9Oh7R/5Bzrg5AmV9z1aLizNm6Eze3wlXAwz5VY/FCh8d2cEbb76J4CyvMV9+E9QZSA8TCE+gGRwDlMNSvxSe94LwrPC5+EBzoXfUu7xbDeIAnNEsV4o450S1CV1i66OnipKRj3BGepmhW10geu9rdsyxaWYv9iQdsN5rixAq09XD+NMC9oTefZnJlRW22kCDW+s7mX4gDLF1zDDd79udvacgkXeGOaOKVLc6cdEjkibvPWrNh4IYNHA5LET2aiw1d37IFzz7+isfc12dOIsACAeOk3BIv1jMfid45JYthnWbGP7Um27m9731uaSGwdM6ISaUAircjCGcIQJGPTuN/RyXGVCwmZdHPr+T7IFZhcmz2ksHUQIyvSLlnFUCJnG9bGNQ/iXiRXxr9jV1ZgtlpoT9dWF/KSGbYVFxd+ITdZr90J6PzfjajGg9FqfCGIgqiIU5bpYVZR7b2qDP6jYZHUDiepg+E2AsSYcO5nxFPMUIOyIVrs/qtbnYGwv9TQbnR3gVSPuJ6Gs1Y8E9GWGexdCJM95N4VFhh6dMPlZCyFnfdyGGXivhmBWl/ayuIgJd2lhgbyLd9FJT9c9flbuwl8jzvFYhPRl5cHm1udhyoxrriVczRpLUXCZpgEYcbD/zFmaBuGPps5gOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(366016)(41320700013)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1A9RpyGe46D775+r+7cRMKge265boGslh2feXX/qI8erbl19snF9OuHP4rl4?=
 =?us-ascii?Q?1ywfnuZmaYDKUCSPIgdGXzZR17UQ90jPk+rQzp/M1dkG94n5L6/tcRaz19Le?=
 =?us-ascii?Q?2DvZ7BgvYzNlVFimrNGXuZMBe1AxPCpP3gaj3gPnCAQv6+NYuBFbBWLLSM/W?=
 =?us-ascii?Q?D/51A7rGv7AWuDb9x3Ec8YkPcVX4SLrvvhoe8ctS1cSvFSXiSj2QY8NAsA9k?=
 =?us-ascii?Q?gxghdyVqVxlDXq6bYL2fCwq9KX5inmsH9voA/Dy4d26zm9qUVtpF3vmy3MTi?=
 =?us-ascii?Q?ZDkkRf+cBNYcrnrQ+psET6t/ssEpZlyXUbLo74yHf0J3XQeEs7kflxPvLdi5?=
 =?us-ascii?Q?tX+fUZN+r9MTMxKLr/oG5AkfBMhIdiexl35ehE1ouAW6q+ZxJoJ8uaJwTZSp?=
 =?us-ascii?Q?gFq1FjDKXJGf+tC2oKRwP3UjmtfwoDQbrhs29Xx+bpVNoKkFhjn44pzrtjJr?=
 =?us-ascii?Q?alvI6HwE/skRFfAdXiwlgDcH0IF2wlM3jFKYbeexyhRNBxblhal3ZqEVjfhC?=
 =?us-ascii?Q?3zH+d0XAtcipORz+X1vy/faz6szitn+QzNTsMYv2CvfBKVI566Hqry5YbWe6?=
 =?us-ascii?Q?s5gAMt3nXdBVL6ygqxf8YRKlhzahPP3CjXPmm2+kqql5PbmZyKiSItA7JjPH?=
 =?us-ascii?Q?jco3cO7+4VsOGqbt5n9gZ9A5h+2ZsWHN8LrXuxdS0mapl5Kj8vuQCXmhfAwm?=
 =?us-ascii?Q?8t+tnvnYUnXek4PVcznXwcIYxoTSRHcLYKIcp2Y8LVRB9nr+UiznUxYUXlo8?=
 =?us-ascii?Q?XV4Cq5by68QsRscReVNlwJ2PxqgYer1uMVhqNXMx+u9Hd/qOnJ6bQ4oJ2Kl/?=
 =?us-ascii?Q?yF3xT+ltX3CyH3bFg/Ez0RiOE1C8ox0bjU5/lnWy/oAVQXzacFanFnS4hBg3?=
 =?us-ascii?Q?1s15IOB1n6bmCNiYdfrfYWPyjqwTHl6+sS50C8ptidsJmQ70F+7BZudXUalk?=
 =?us-ascii?Q?Q1zxqVoiL6zg3MFv747qRLMzqvw2XmKyM1S6mEa6Pnzn2Sw/84eQofpZFOWR?=
 =?us-ascii?Q?+t9UY381y0Ha9d9kWLyAeOkC14ddb8gxGL1righ1iyft8mIrD13nTNv4F2Er?=
 =?us-ascii?Q?NJhVhzAc/3F6+TzmgUZUEukaCVi6QYPLBv23ARdvgsBfg0YSSoeo0VNqeOSI?=
 =?us-ascii?Q?HJ7KVbVvS+TaFRHyb6uv6cd04TD3gP2qFty10qlkcAsPkd2w8ueUTQTJVzsc?=
 =?us-ascii?Q?RYb1Efxpdg4f9TW/+UOQV2o9t45JQYATv4ZgoxepIw0pS0uln2H4uS7ngOzG?=
 =?us-ascii?Q?I8G+TZmNTvf3m2i4GkKgELgLdRVa/wrmRmOfHELJUlIXdnDjq88Md4NrEvKt?=
 =?us-ascii?Q?tKjHJrEIH8NoUTw2c4csXLrI3lCYsCL7ZK0Qcvo1UDPVSzdi5FI4NyEvRN/l?=
 =?us-ascii?Q?/LYSoIk3FUt90gOeGqQ6CCHE2+UbwQ1z2/r4Uix4J4m1RqRa1COqrcL9cGLl?=
 =?us-ascii?Q?kATRtKBhuC7io3IoCp0YCzayxmAAjFa+Rk0JQEE2q3FLNjrFgmGzqJb88VSI?=
 =?us-ascii?Q?I1CRSw0GhVJb3jWMtGpmcP3zAqpE0bKNrzHidq+PeS9DI+guSlHiIJuTora8?=
 =?us-ascii?Q?FO+DcDA6RjuNWEcYv3S08jfYwoaz1ltdz7+X2DyS6HX52qkVYdFaGiWetm66?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd2d949-970b-41a6-04be-08dd1347768c
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 03:06:21.0153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmAxhpx/b3FJDtakfp44KaYuqG1iAHdfDZzSQFU15g1VvDODPSy/LZcdnTHGcDdh7RuKXMyE9ZimjQRPfb3NStz66XXMrllyWd7or2NuwBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1259
X-Mailman-Approved-At: Tue, 03 Dec 2024 04:11:50 +0100
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

Add u-boot features to the U-Boot device tree.

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: E Shattow <lucent@gmail.com>
Reviewed-by: E Shattow <lucent@gmail.com>
Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi | 33 +++++++++++++++---
 arch/riscv/dts/jh7110-u-boot.dtsi             | 34 +++++++++++++++++++
 2 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
index 3012466b30..7953459e67 100644
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
@@ -6,6 +6,10 @@
 #include "binman.dtsi"
 #include "jh7110-u-boot.dtsi"
 / {
+	aliases {
+		spi0 = &qspi;
+	};
+
 	chosen {
 		bootph-pre-ram;
 	};
@@ -27,6 +31,9 @@
 
 &uart0 {
 	bootph-pre-ram;
+	reg-offset = <0>;
+	current-speed = <115200>;
+	clock-frequency = <24000000>;
 };
 
 &mmc0 {
@@ -39,30 +46,45 @@
 
 &qspi {
 	bootph-pre-ram;
+	spi-max-frequency = <250000000>;
 
-	nor-flash@0 {
+	flash@0 {
 		bootph-pre-ram;
+		/delete-property/ cdns,read-delay;
+		spi-max-frequency = <100000000>;
 	};
 };
 
+&syscrg {
+	assigned-clocks = <&syscrg JH7110_SYSCLK_CPU_ROOT>,
+			  <&syscrg JH7110_SYSCLK_BUS_ROOT>,
+			  <&syscrg JH7110_SYSCLK_PERH_ROOT>,
+			  <&syscrg JH7110_SYSCLK_QSPI_REF>;
+	assigned-clock-parents = <&pllclk JH7110_PLLCLK_PLL0_OUT>,
+				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
+				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
+				 <&syscrg JH7110_SYSCLK_QSPI_REF_SRC>;
+	assigned-clock-rates = <0>, <0>, <0>, <0>;
+};
+
 &sysgpio {
 	bootph-pre-ram;
 };
 
 &mmc0_pins {
 	bootph-pre-ram;
-	mmc0-pins-rest {
+	rst-pins {
 		bootph-pre-ram;
 	};
 };
 
 &mmc1_pins {
 	bootph-pre-ram;
-	mmc1-pins0 {
+	clk-pins {
 		bootph-pre-ram;
 	};
 
-	mmc1-pins1 {
+	mmc-pins {
 		bootph-pre-ram;
 	};
 };
@@ -78,6 +100,9 @@
 	bootph-pre-ram;
 	eeprom@50 {
 		bootph-pre-ram;
+		compatible = "atmel,24c04";
+		reg = <0x50>;
+		pagesize = <16>;
 	};
 };
 
diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi b/arch/riscv/dts/jh7110-u-boot.dtsi
index 52c1d60859..21a2ab1789 100644
--- a/arch/riscv/dts/jh7110-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-u-boot.dtsi
@@ -46,6 +46,15 @@
 		};
 	};
 
+	timer {
+		compatible = "riscv,timer";
+		interrupts-extended = <&cpu0_intc 5>,
+				      <&cpu1_intc 5>,
+				      <&cpu2_intc 5>,
+				      <&cpu3_intc 5>,
+				      <&cpu4_intc 5>;
+	};
+
 	soc {
 		bootph-pre-ram;
 
@@ -73,10 +82,35 @@
 	bootph-pre-ram;
 };
 
+&gmac0_rgmii_rxin {
+	bootph-pre-ram;
+};
+
 &gmac0_rmii_refin {
 	bootph-pre-ram;
 };
 
+&gmac1_rgmii_rxin {
+	bootph-pre-ram;
+};
+
+&gmac1_rmii_refin {
+	bootph-pre-ram;
+};
+
+&stmmac_axi_setup {
+	snps,wr_osr_lmt = <4>;
+	snps,rd_osr_lmt = <4>;
+};
+
+&gmac0 {
+	snps,perfect-filter-entries = <8>;
+};
+
+&gmac1 {
+	snps,perfect-filter-entries = <8>;
+};
+
 &aoncrg {
 	bootph-pre-ram;
 };
-- 
2.43.2

