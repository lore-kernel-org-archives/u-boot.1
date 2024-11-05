Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE8ED1CA15
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 03:45:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AB6288FAA;
	Tue,  5 Nov 2024 04:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF0A888FA5; Tue,  5 Nov 2024 04:45:02 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 061A688F95
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 04:45:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEdW7I+Du2MWuz5Qn3xBxkpwVp3U55IzDMand6CHd6hxh4P5yBbm15uXqdcI2vN9YNwluTMVd+/dvipjJGCqPBoYTmwt+6DgVB+h6F5+F5TecLJAIw+2HXa60AksaRXZSp24yh2IP9eImkL85/DbTsw1LRy5qXdqNYy6jnNC1LI7mRdIOfuNy095r+KWG+YdDKYauXb47lb0qVs6ahY5BvvYCgD9oInCoP9sb4kZ9i/Uh5wZuRIW33RJjKh96WFZm3/6GV5tomdSbMl1XtpZj1FRjbGdgaKb4ak8B1YNk7bIO8zESK1f+9YLsYOFcWMmcLkUe5GE/EIy+Ecj4n2Wyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAa90Jy6dGBdyGOmO4CaRNff3xA7cwFHF/llf2gGUYk=;
 b=KVncXcHbHXsBj7dZLTapE6h91aXBjwguAn0TiRpJoERt7U7mJbLqlUyyL4i+kTuqBJdok1P9f+ZlIzWAseO22B5vgZDpWDl/DdKa1fkUs0o62NxopupgCn+DwU+JHNHZ0x2G5iXiD/ceCi8GegRqzi+H0KNKexsIGsj1wlprtX3jMu1eUo/7pWwkA8jomChWuB7wyg/c/r3zaXM5rNd0gRfY6jTs+DOI6EN+iit0BsbY8nlWMQ93z8Wq0sSQ7W39BEkoaEVAC7bB80ysrHNw7lGJsakQVFFOkn1H+doq4lx//Nm0vZWddOFW/tbqOuaVJdCuuR8CVYLXtSOpBDoJbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1145.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 03:45:07 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 03:45:07 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v3 04/13] riscv: dts: jh7110: Make u-boot device trees
 adapting to upstream DT
Date: Tue,  5 Nov 2024 11:43:19 +0800
Message-ID: <20241105034328.56439-5-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241105034328.56439-1-hal.feng@starfivetech.com>
References: <20241105034328.56439-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1145:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d94b34-31ea-43e8-ac61-08dcfd4c3d9e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|41320700013|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: XBeHcEnqO3odIVmtZRZYPYbVec3YiFQsARaMz0bVBf0iC/A6HBQ5u//QQflvukaqLixHTJIEYXHIhhC3VWwhn56J2B+wqJcDl35ql5Mg0LRP28KLwdhUmGJOiGlL3kUHfi+DfMuUsnfdhRQyHsdUHjRvLUw8P6iR4O+s1Uh41HcbeLcvj/pGjeFlV3H3zv4yUGrA8RrU32VNAiXbJbCxh/bb6xrF6kitl1yoTvZddbHDYBP/oRymCsGvefRPvxLFCZacXU7QMJ2qTOg3gcCFkji+UIn5MrpX8I1ly+bUsLw+ots5Er/EuA8vAhazxvJ4animZvhcTGJoArOJRsTn4/QKc/qKf1tLvMUNrrMw65Ngk3JDuDaKF9Kp7QbrBNKD36VKXHlcZmAEY8yUPtud5ElWTVGHhrWDfzY0UUecSykA0RGZaUzGujw22zbfVvO7cmqTENW0NbnqVAJ4FHYGGXrD0I/RgNuzPjHYPgllRW7H450zcckd+aMc85wNO3iwVxl/ved9+yQL3Hqiyr4KA56aAcBG5nSDlQR4b53kyRxSwXNVkoM/A9y4/4v19Q7Md4ASbDyF+oOPpC4pf8i1nuxYBMCGBVAzSeJzL7wS/nD5TD+B0xBzyDQUjcEOBkjWekhskKlsqv6daY42ePc4ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(41320700013)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Um4bIyyTmslMQ+Md0EjpzXTvzoov43Ev0d6HqRuJpGigfGbpfcZiS8XLE8vE?=
 =?us-ascii?Q?3mzFUlNymJYbcGnzbG+zwtJ4tOqol1PQ1VIoyfUDyE39rx9ixSbc8SGIJXHa?=
 =?us-ascii?Q?GdDa6dGVvbyjhU9ZqZPydlaia3OlCoT5KYdBF3XKU6qTRcSyCIDLvn3bSbRe?=
 =?us-ascii?Q?DJlQRik/J9n4kkGZUvl707idEbEhduRv7IW2rgsEM+uYQU8u6FbhukxMRiEO?=
 =?us-ascii?Q?O8F/H1I0YhyxJ8NKXDsTkBht6HahnAYdBO/bL1gVvPmlhb64c1o5GluWo1Jr?=
 =?us-ascii?Q?m8U3pU/6tJI8o2weTtv5EOvPkuRJvgyuN7Xd7KxaMQUImh2CAa6mY2ppDhLx?=
 =?us-ascii?Q?M9EPBXwdbyCLo852yeGVnZzkfvbk920uAy6c/PKxO16lChY9wJTKncvLjq73?=
 =?us-ascii?Q?cdoZov8v/cl8+Ppc5uwNBoL5dnD/jtWX6GU3YrtKoovHdX/I1ql3SInBV5zH?=
 =?us-ascii?Q?ale3u8HyQr0MPZYLOfXOspcNoOW/ULC9i8OW/f0hxRwlZsrnRm4eAhQ8Nm/J?=
 =?us-ascii?Q?Rivyrw8LPCv4LBa8fXYNcIQCs9SFzrjr7bZXKYuoMBPn4teId85uMvv0m2vM?=
 =?us-ascii?Q?PC/YFAqtqqJBZ2EIROcD4HPJ1yI3Bqopq/PZf1xBgkpgasYVl3OCrSHUHr0y?=
 =?us-ascii?Q?uCz0cDrUrbPHog6TmVD+6B33POVcoiRbPXMjXS8BA0u9mcDjXCYeTXHldY4T?=
 =?us-ascii?Q?2/xA+n44b28Rs2flPVbZBBrIzV6JzBFHzSxX0ENnxZOzr5XuoILs1QMS8mfT?=
 =?us-ascii?Q?jMIEuvxQ+6K03zombfY8yGq1CBkUyOAZtUBgDTO68JrcGKUKLVPHMlAMaoTC?=
 =?us-ascii?Q?DsTx5xFIm2V72GgOUQxbpmOC8dE+/ebTdpSeOvAmz2NHX80Qr3Atp24pQ/fF?=
 =?us-ascii?Q?BvZ1ER5Yi0Oy51zulzHTHS3DnugphOxbgc+0nfrfzoBySsh4xE6U1CngKtc6?=
 =?us-ascii?Q?3zfiKp4a7mirfSdWSjJxK1zXvbx9rRkj+b1piZ12dfsTcHnT5JXRkIVtbo7p?=
 =?us-ascii?Q?F1dpQwarnP9yWAX49QqhIPuO9+1AxKhsAXjVR0aNh1JyGiJWahOW0P591xZj?=
 =?us-ascii?Q?LrVB6n+yp3xDSoIBJYngKTid4K183g3axnUFdqa41uh+1nfYbSe2arnGLueL?=
 =?us-ascii?Q?GJhG3YHWNcJdgih66yIKM0LeP2h982/LfGeet76PrhGARsUT8rWw6zdN+3gg?=
 =?us-ascii?Q?MzF0yduGedTCnuO8P5GsynnUa3KAl0gfXwDBny9f4sUJuz06c8UUbZ8UumuV?=
 =?us-ascii?Q?UwpPpvYVQl80ZrDUAOHjTQGtDFXonDuS9e3DSJ5XV+aXTAx1t3kr+diL2PP8?=
 =?us-ascii?Q?uU2mqH7se7yo/Y6xeJSThVxVpmbAF7HkrcdihghzzdMzICpiutCpurRcelkj?=
 =?us-ascii?Q?+QgYNKHX3uzN3mMmuLRC56FUKXQ4jLERWU2tSeZDZoxpUCMz97d83yZSbFeA?=
 =?us-ascii?Q?SfA1a0t3Fg0ckfdmGmhX7Vp01IjOchdRwqSawBBrYzQwxIft9kW8K1Ylr8Zf?=
 =?us-ascii?Q?Osa6BGKelV37cxhTMPXgb2aYnAH6i0j+WJ4vJNZiAN0qHXBXuJRXcJJc+iHY?=
 =?us-ascii?Q?5SmgjaUWALyUMiAkEZujHUoKw/2EGN9I0mhCR8M7wTi0CQsk9hOeTT7y/CsN?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d94b34-31ea-43e8-ac61-08dcfd4c3d9e
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 03:45:07.3862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZIhqM8bO+qKtiZbJ9lI8q4D0FLAfsTGfQySzqjI6YOj/tKk6+TAzCO7tiPaWSX86idhtvVneOo3qnBzKa8hNL5uwgXTKnGjbPAUYP6kLBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1145
X-Mailman-Approved-At: Tue, 05 Nov 2024 04:45:33 +0100
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

