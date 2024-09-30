Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D4ECE8375
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 17:06:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81F6F89061;
	Mon, 30 Sep 2024 19:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E86088FBE; Mon, 30 Sep 2024 19:00:59 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20715.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::715])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F020B88D08
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 19:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/6G0QBTyxkCSjSbBnoIDQxuqK0Q+LRvsEvDFXs1B2LhwUwcqKb9dcESJ7YHWNVVHSB2++a/mZriJ4JzDqV2RsaIujDOd5y9spsV58H+Jsu0G1eaM2SGuyeCCkjiawHgRKPZJnEDhSFwlJ4JVJN6QGd4l+OZj6DEEn0POl5Rjqpn0lQ9B0RznPFAHzd1Zy51Z6/uKAL6J5RCLeWUqocooLfsosdvMuoM1xRQ9P8wd3jYmaR/4Jic2BQ51ZTdcO5oCW6cyE2QhxGVusPRMllso2bO4DBYZRqF0gbDPhwr+TVAw5SvYqILOOEI35lGRsIbMlMKD6EPFGYOSzoI3FP3JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAa90Jy6dGBdyGOmO4CaRNff3xA7cwFHF/llf2gGUYk=;
 b=mte3AmrBuIYpO1kY6kPmNxghHkbleyjqZnwQ/RAB8BkMZqiD2TOxEobdVC75Jz05mI27/g6S6tQryqlwwRw0nUpONi8TXgWUtjUPMtGzrQzb40W/9UffqJKHjVkcF0pCGoFRfnCDEXiDdlFvsVj+0PLc64o5OLwitwb70JXJKQ4cchQU8JNQOQTUcBN9bU5toOUOc5xhEpzL1NWN3MxrXJWmyoNHvKcav2m/ieOdGVK9E2y+LBZxVlcu+rluWBWWBdYw8ejYfURaYQGZtj3M66znYlIZY04kADkvhkbx9aOOx0Zt4QK8IbZa0T6HOGCaLw7PHgm29/HzwdVIR8tcMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1243.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 15:59:33 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 15:59:33 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v1 05/12] riscv: dts: jh7110: Make u-boot device trees
 adapting to upstream DT
Date: Mon, 30 Sep 2024 23:59:12 +0800
Message-ID: <20240930155919.111738-6-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240930155919.111738-1-hal.feng@starfivetech.com>
References: <20240930155919.111738-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1243:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f4d0a34-97ea-4a1f-a975-08dce168e011
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|41320700013|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: kJovGrY2VGj3536IG1MbxnUIW1r32w0XOp/coNv2qeX6yUztHBBctCWSmPX7SMPE8F76kfUbLpZeBS5Wdz0pM/f/osHovRc4vcWoHGr1h7ctd3vkaGnXleWtmFDNqzrG1cFj/bqpSCJ73MQIJor+Xfq9SyUZc4WsM7cmBZQN4rrZ8KNqH42blljdleYBEStl8PAqwNmUOB0rqIie4JXxrUWcuuBQXjlyxRvpDFbc3/l6XADoDsIiE2aMlBKdwKxdzo1INvZ5+Td2ov2DqmJOA5ANMa5QghKCBf/FE9kXvPBBr1BcCqAqdAi24RhVoO8mumV0zuGF5oZ2kcvjQMKAcZnfindkzmMlzsvOgvLhALhKCOcl7Zn2EsklX7gCo8wSyrraTiORBRsBWXXEkQLq9y9Dz2rKqsV/CT7t+xAsIA3cXZB61coviMJ0xoBkdc2zZG8v9+hjBXX5vU1gr9+ZzyMEXXKAFB6vAuMt3T10y5427WThPbHLz9me69RDcAdzIpLGNsrp2KgfnmorQLytMdJkotGdsvrv8toFESSNuJ4pt/0I+jsgJw7AzC1L0ULNWZldejmtvFeYKQwS3n8WnuMP8DiU6dgcCD6aZJnOrDPNtFKg906Qr5X7BUaZyZon
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(41320700013)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fz81JnvcY5A6CftoITmO3OEMWyES45EHBaiGNMKX9LWwCIwpgR/nk8sQyBVD?=
 =?us-ascii?Q?Hkv1GchV0/87DAgwLv4n7N2VzbbWXmM9C4xBwkwaEqyApg6sdjdxbXyoO/nu?=
 =?us-ascii?Q?RDtPsmTUYC/n3dbxk25q5xlWG1zYk+RYBt7miAnHGDx1DGTzT7SrdDEsP3Pt?=
 =?us-ascii?Q?VrIve0Myx5Yz3IZiOBeEAN2cmxVxKwVtZSJee3sOAJTRplAB8DaYR1kciXLi?=
 =?us-ascii?Q?21yyMvOgRfwTzfbC4oX+5XV48UlEngSOZmoaPJhhpIG9MBduQWn4pvYcaOrg?=
 =?us-ascii?Q?FO1yO0ILPq+NoCYTzCBrXcT5Gg/3L2Aq9i3G99ujZYQu/eRRK6DVBCiTyjKL?=
 =?us-ascii?Q?0GrNvVOH1HeTeMQB5DcH70TS+26dKGuJ/uydr2V7V+caHotrH8Dd+c6oNbuk?=
 =?us-ascii?Q?+NXAMslot/YUXm4eACYouTTjjx/tydLXWIUyEmdZVfCCiLiNGJ916PMv3BO9?=
 =?us-ascii?Q?3eBAPk8MexITAs/kgd9yM6/GMN4WAlxrbYRuKp53YffZqm5rPswrvXt/9V0v?=
 =?us-ascii?Q?NQQeTFtlyJycupAWTwLVgqWAfbTjgAUwki08lSIHwpMhHJSBFL3dezfoyala?=
 =?us-ascii?Q?SUP14VkRAKYdVMNTNsW8kYUZ59E97Df0Mithhf6UmOcIPAbM5NHUh0HM2z96?=
 =?us-ascii?Q?HCnoZzkl/iG/loZD3lyC7pk9IDCYTzZIaOgljmL/7GwKhP6x5LKU3/cXDTwQ?=
 =?us-ascii?Q?KsEFYEgEBLQQQSXg8f803Vsw+kpHq54GrL9VIZQYiujeBKpkEg8V4xtOxcYr?=
 =?us-ascii?Q?Bwuhzvvdtqu52f9r5fMD5gcr9xSESbeMLuH64TkPiHmCTa9Jvg5iqxw3Px8C?=
 =?us-ascii?Q?MlQ1kcpdve9ffulYaJi5FGzjYTgvPoWrEfdZj4U8G6UBJXETEcRo5Mw/9qiV?=
 =?us-ascii?Q?Hl2UQqEZPN8pQUNCIJC0i63yqMJZ+/xerosm2gwzqPt47LdoRgWSlNhNS+bb?=
 =?us-ascii?Q?UunJxq/qor+Q0FJbI3zb0uyVMxy5YgpIpb/CQcX17kANdMX8xlFxjevwdJu0?=
 =?us-ascii?Q?6GsU4gdquV0TL19IKE+08RVyxYYB1vWEg1tsZF+djaq+XQi6r6W2q5oLTI/E?=
 =?us-ascii?Q?zqw8KlldL8Bb1qS3FoBc4GY2IdgMyGNdts0t7/64sOfonPsPyv7i8AWoskGJ?=
 =?us-ascii?Q?V+oB4cx8gHbu5eVr6Pzx9a87HJE1n5Ku9s8cDwBxx2Mw9QRxEzy2mxwahMza?=
 =?us-ascii?Q?8moy+w3oA3pR1bsdz8CRji5UzwCKWF5UEdCw88i+Pj2+wHYwrYVy/zisWjnn?=
 =?us-ascii?Q?ttcDf5G0AUdLzBaYWvh1it5NUPRHu6vyIpHJ8QlsQbbr1p/6xyIK0W2NoVJI?=
 =?us-ascii?Q?7qG0M9AgXv9KtC4DgrwvTcqZ2WDJpepHZEWA1PTN5bkjmTeTH+NU/Ih1azZk?=
 =?us-ascii?Q?kvhKgHcPspV6rIF0uzeDCcRZ9xZydhXaTGpXRjGSdd6PttwDuU5byAGurhb8?=
 =?us-ascii?Q?JJyfW51pAjRhFSAT6524gVSjX8DUUtJB6CTrP6C227Krs14n9kU4+9TS/SN0?=
 =?us-ascii?Q?OfbMdqxBdWDurSF5wyqTVnG/gfIjyt0XV19O8VlHty3+uGu2R5sQj0F2g/uT?=
 =?us-ascii?Q?P3k04XfEMMEo4G8occ5JyPoofSAFZHhTLYNPj0dFZWpic+6UMFQ81Gc9qBwK?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4d0a34-97ea-4a1f-a975-08dce168e011
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:59:33.3092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGvikV9kWr+MdzvvtxjkmV9OYJ2KUjLjazS3DA2VrEymun4vQF8kWWLhW9mA/dgazDvQ2qu3DxkJ00W7S3RzY3s6ggK3W7k1Lgl9z4yg07k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1243
X-Mailman-Approved-At: Mon, 30 Sep 2024 19:03:44 +0200
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

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi | 49 +++++++++++++++++--
 arch/riscv/dts/jh7110-u-boot.dtsi             | 36 +++++++++++++-
 2 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
index 3012466b30..2b063414e5 100644
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
@@ -27,42 +31,76 @@
 
 &uart0 {
 	bootph-pre-ram;
+	reg-offset = <0>;
+	current-speed = <115200>;
+	clock-frequency = <24000000>;
 };
 
 &mmc0 {
 	bootph-pre-ram;
+	compatible = "snps,dw-mshc";
 };
 
 &mmc1 {
 	bootph-pre-ram;
+	compatible = "snps,dw-mshc";
+};
+
+&phy0 {
+	rx-internal-delay-ps = <1900>;
+};
+
+&phy1 {
+	rx-internal-delay-ps = <0>;
 };
 
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
+&aoncrg {
+	assigned-clocks = <&aoncrg JH7110_AONCLK_APB_FUNC>;
+	assigned-clock-parents = <&osc>;
+	assigned-clock-rates = <0>;
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
@@ -78,6 +116,9 @@
 	bootph-pre-ram;
 	eeprom@50 {
 		bootph-pre-ram;
+		compatible = "atmel,24c04";
+		reg = <0x50>;
+		pagesize = <16>;
 	};
 };
 
diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi b/arch/riscv/dts/jh7110-u-boot.dtsi
index 2f560e7296..21a2ab1789 100644
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
 
@@ -62,7 +71,7 @@
 				<&syscrg JH7110_SYSRST_DDR_OSC>,
 				<&syscrg JH7110_SYSRST_DDR_APB>;
 			reset-names = "axi", "osc", "apb";
-			clocks = <&syscrg JH7110_SYSCLK_PLL1_OUT>;
+			clocks = <&syscrg JH7110_PLLCLK_PLL1_OUT>;
 			clock-names = "pll1_out";
 			clock-frequency = <2133>;
 		};
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

