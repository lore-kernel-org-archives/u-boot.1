Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C347E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 13:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB7A488B0A;
	Sun,  8 Dec 2024 14:25:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F419A89502; Sun,  8 Dec 2024 10:21:18 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20706.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::706])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DB8189502
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 10:21:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SW/l/rTSc0YI7rZclaGo7BZRWSYTrzqUKDkXDPAzlwyTxjDQ7iGo6dVdKOrwFJcqHiQGxFWB0V5Ma035JeLb53I/v+CAROQt1eiaqAccWp3gufcYLkGJOO380X/axycMY8sUevTd6BANCJv7/qDD/WtCPuZKGdCUMRZDmonmxri8zdSaIzfHGI+NC3skbvWhO8AHjk7a8ADaatPSPqgJfqM/MEks8OPYo9m3zzG1BqLVv7rzSQU8HgQ+GPeTsRB0DaPMEdxyJTwEyHiXxml4Is1JWetKI4Uj2KOOeWrTx4m6QuquE3THOoo9dD9VjFGoqvM6nt4Q2zCu51KqAUuGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZAH0jCr3ds01+BCCzH8mhzYqVdJGvcKImfYC8L2xWo=;
 b=auoK7GPsVPPGSHivtU0vi9RhieN4h6T9HDvJwIl2l9ARykTwlwnAnnn9xhRPttaArM2fwfod3BbNCkbRJslbWpy2o0uvuGWWsnF8ZYRWUw9jEQ4iTRXx5TEg3k7zrHVev8j4BizcPdfXA4U2BX/1igTjKHDkbEAfWczttMY+iA53kuk2tPcHrrT9hYWP/BHsXJSk2P19v4fyAxV466Qc1KRNTt8G25y57oH9YuCqyoPuiAm8LoNeV62cKF2ktczIH/76RHrW5JEgqFJq8J7QoS75X0ND7zdX4WSyuFL9P9bvrRQaFDHaRBUaahGWglt9b39LG/+fs87LApFKpNuUcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1226.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.6; Sun, 8 Dec
 2024 09:21:34 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8230.000; Sun, 8 Dec 2024
 09:21:34 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v8 02/12] riscv: dts: jh7110: Make u-boot device trees
 adapting to upstream DT
Date: Sun,  8 Dec 2024 17:19:32 +0800
Message-ID: <20241208091942.47298-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241208091942.47298-1-hal.feng@starfivetech.com>
References: <20241208091942.47298-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0031.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::14) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1226:EE_
X-MS-Office365-Filtering-Correlation-Id: d2004e9e-33ee-42f8-33e4-08dd1769b5ec
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|41320700013|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: nzli/eTUL2IKyWAIyq92I5Xe2++fiqUttY5wMhEoM3leeV5c9PMHipeBWtlp8uNPw9E1iZ5mVFT+cEeOa0gv8Kw3rOqdPPgkU0PqvmU53i5fwMFiIopKxExq247hBCj7v33om1ULWmZz2c76gL8fq8lrA9b2qN37134O+HdVpFkZd/Fwv1SsSMi8GHw5fTcgQN0KYSQV5t/Ppj51fJJE4ymfl9+HympXDil/qxHXHwFo6LBIX9FHQFubsJLgeJtbWJ3JoD0lmOwOUUHJgJdd9p/pzJoXPQGr/5n/r1IiL/bhPnGZCJ24T7ZKEJlC3jr+Aaf1SCwNjXsvCjarB6qXHXkKrkAGjl80gayunn86qaNnpgnxs5BXlp79ZyTz6k9G01uUEPkw/HhvT9FKDqu5DDt5gqGi8lPrpwLBgOMeylUKkaUsdLHqn52hZiChCSooXzi/g3jl4j1y6++pS6KwT0h9rDqMMzs0pQBIDSHF1e+SnsM+TX6AGbi8HuereLTerHWjXYEzVaqW8B49vUa2Vgo8If7V/L8aEQE80cqIX1XtNWEXEbJ+BqlmNO3uS9tCoCALILjS+0QLkckf2wS4/3+RyPf84D3mOmclNWcUCI9i04z+w1KVzyXJxb8g8lk705Tv6ankU6CcYI0/P8Pdgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(41320700013)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KOEcCwo9T0zlc545zRVDUwj+2mbwraWwe82C8mToPqVCM2Dwcriq1yF+MaWt?=
 =?us-ascii?Q?5AVrlFEeyMwMcaE3usNmfL1K+VMslDCYmLKqVwiX/xAqU9QGarAmhl3ChbLU?=
 =?us-ascii?Q?M42ZBhQjrKKyewzpySwIIQkUonhcCDMMiARNDINsEDqtmQycyAPAEae6kz0i?=
 =?us-ascii?Q?el6zNntZx/kiQxuBML1C3gV0KtnRRpPq/yY0fShPshTFH6eznfTX8PQ3/rAw?=
 =?us-ascii?Q?Umu1a6IQ6a/5RD7PBvS9N3U5RBp23fuRl/9kRTvtDgXd/H2+14N6qNz0ae6r?=
 =?us-ascii?Q?mXDPeieUCzg5jsWFoZ93N8oKG/bd7+HwksPIPjtMsg7c8w7YYcYjg+A75AMb?=
 =?us-ascii?Q?dygw9UN7xVZDldDA0yW+wSxM/TVCTOQAV1tacqi5FSIj422dcX7wmQhkxHfO?=
 =?us-ascii?Q?WRigjUilyPMd/z/npH/OD2sSYCAwJR52xSspjin30c/RxnhojSePpm+I90js?=
 =?us-ascii?Q?edUzcHWXXTfPiLg7++mpcCerC6PbJihHmBd2kx5uM+fOIIg6jxRByURf14TR?=
 =?us-ascii?Q?CpYvxczBIuRVJufONqpkXTDZ6sdoZ/xn4s2+qNrvD2ed+ODabIv4xCyRL1QO?=
 =?us-ascii?Q?VrAGBALJW3ruP0egsAJdLV8DzPQwD0iM4xQwqRX7KTDg7ZiZoxjVi5lfDH0X?=
 =?us-ascii?Q?4B9wOBm5ic4XvNmgi9SDylBCz/NVAElh8ws1yQW4xG82RM43CgIVZtmDJes7?=
 =?us-ascii?Q?384jdqutJ9WNg+tb1E2OChWztieQVN/rYj9ebgXGRwcCKRYU2M5MOvWcAqTw?=
 =?us-ascii?Q?Y20FVA+m9r7peeYRbWRad/xzg+MGb3wl+tltDbOppwWcQkcyXxf0I7VlzwF5?=
 =?us-ascii?Q?zsfLncOhBrl1jkIMMUh+hnE7TaENCwfUG4uym0tZaR4nbyL6fwI2TPiTYems?=
 =?us-ascii?Q?hjwx1WeWNYnwWBsbrQyBA0ndCoUe2fLPzHczoljwy+xXfe/Px1qAbCDe+up8?=
 =?us-ascii?Q?bdXt34iY6PsBz0PBiqsuxtAjzlLE1jHZfII0nALn6lAb5pTSJ1pvaTXexlrB?=
 =?us-ascii?Q?5fSiG+V4KH/R+S4CCYel8s46oY7lt5jpL9FOskNlNVeqiikX2xZleFc20mNj?=
 =?us-ascii?Q?ZPKcpWPkohPBrqPv8SMZa6pq5dDh5fY+Mgnmrtme46lGJ1DsKX2sSNiM8YAa?=
 =?us-ascii?Q?LjqVgsA/iwjOz6g0SH5FifZevHUUu+aTUG61zog3Rzf3c95TsF9C0GGxRFzp?=
 =?us-ascii?Q?s2qouX7plJF9M62KM1Ao4n5fvwx3e58ZxYeaLqiKS1Hr+e6OB7q+ZQp1S9o6?=
 =?us-ascii?Q?vyvgAM9auJLHMez5B6sAEH1g1RRMEhcd/kaXjbHa+PScTEneme12JeQBEXYO?=
 =?us-ascii?Q?X1kjFBj+d93k/uExxYaJg5k4rzohgyRgHQEy5Ymi73ROfulcEkVQNPDB+a7O?=
 =?us-ascii?Q?BdhEsJ/lMc++oQDVwXcXnJLr+xALr/X2/1V1iDWdeyvM2gp6HiSvg1h7/Gg/?=
 =?us-ascii?Q?Iz+iTAzCcDfVS6cK2wu7/CjlFubnjP2c/YtGQ1c71e7LQaDWoswBzeDTqrBp?=
 =?us-ascii?Q?FSnLNgpQMCyJcXWSf2j8skIpk7fa5Ejna1CohKW0vI7oX+zgm9SSdUih7nPE?=
 =?us-ascii?Q?6MKEr97AeINKGWh+1iJ12cH1qOgvHXQf8hFEVmnrw1+9wEQJvMyIHqWPiPht?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2004e9e-33ee-42f8-33e4-08dd1769b5ec
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 09:21:34.8939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXSTkdz+x9TdyYa6C0OiURfg976vIsLBX/X1p6/gasaw3Gx7UYAqna7/+4R1lHRl8f5DDHX9XV9G+PRJYBuC9oO9F5a08LIPf8Xf1JpvqGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1226
X-Mailman-Approved-At: Sun, 08 Dec 2024 14:25:45 +0100
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
 ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi | 32 ++++++++++++++++---
 arch/riscv/dts/jh7110-u-boot.dtsi             | 25 ++++++++++++---
 2 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
index 3012466b30..45fada34d2 100644
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
@@ -40,29 +47,43 @@
 &qspi {
 	bootph-pre-ram;
 
-	nor-flash@0 {
+	flash@0 {
 		bootph-pre-ram;
+		cdns,read-delay = <2>;
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
@@ -78,6 +99,9 @@
 	bootph-pre-ram;
 	eeprom@50 {
 		bootph-pre-ram;
+		compatible = "atmel,24c04";
+		reg = <0x50>;
+		pagesize = <16>;
 	};
 };
 
diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi b/arch/riscv/dts/jh7110-u-boot.dtsi
index 52c1d60859..ce7d9e1696 100644
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
 
@@ -73,10 +82,22 @@
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
 &aoncrg {
 	bootph-pre-ram;
 };
@@ -92,7 +113,3 @@
 &sys_syscon {
 	bootph-pre-ram;
 };
-
-&S7_0 {
-	status = "okay";
-};
-- 
2.43.2

