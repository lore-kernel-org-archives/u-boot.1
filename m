Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94ECD3B7CA
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 00:41:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E20D8976D;
	Mon, 25 Nov 2024 01:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1DF5895AC; Mon, 25 Nov 2024 01:33:39 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20705.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::705])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5029F895E4
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:33:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZ9W96Zp8wysEmy8jlsfW+uVHy9i/046vadnjpheYEPqkSg1el9Wy0uk//vAM9BJ9HvkEdh96yRWEOcmVvvvnEXYUJyb4Z8ENxKMJMS1/+7nj+bap/95o94mT/YYVkRU89dt7eaeUbPYXJsDG80X95IR+hm8RvEoxRL9lru9OPxNQDQc8aE49qz+lTZAXSB+DkMYsvWfvXF4f9/WYM8Av9q0MsrCrzjbb1NadE4OEZvglfIoi7rGjasnLwEG0+mY9ED+4M36QPXB3n1IwvXIG6wYN1SxvwqT95n2CqTXU5OqAHCxdv2uxBKDTBRV4+abVCvF8trrlh5Ce18qLoHR3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQ9FbcXeiOcxuhKS1vhXsU7uZyS9y0eSKJuaHhHHid8=;
 b=HY2IqEStEV9u1PY0H243Wz/sPYMeGf5C83kaDFg3UV0tP3oooSuowgHlY6Tj6XLvx29NL66g8S5OCf9Au9EkFIHJXDspEZutuNleH7Jd0+JzHfL3fi4ccz9Wkmsv7tezCTGG+4gQiZ6palG80mCg/+M/hFKfS90nDfkRcV3qOeIZP7PgxdLtrY9gMTWDlU6lsIb8XAo0aGdRR1l6pAWY+YQ2+wpIG/UW0TF9KwcHJBaUbdFdykN4EP/l0Ka+X2FLdTgWEe/c834XQfPGRjG0cYOXnUvM2rThHrEX2lkG8yA6l3appMu+mQ0fBTrnTq0G9Gr+Kp+ccyvPhSlqHdo7LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1244.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 00:33:53 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 00:33:53 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v6 02/11] riscv: dts: jh7110: Make u-boot device trees
 adapting to upstream DT
Date: Mon, 25 Nov 2024 08:31:56 +0800
Message-ID: <20241125003205.75327-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241125003205.75327-1-hal.feng@starfivetech.com>
References: <20241125003205.75327-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0033.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::10) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1244:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e71c60e-cdaa-4efc-1a64-08dd0ce8d6ae
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: WrAwigHdFN7SI7kTdk/uuFBq5c5SoFnpNnehwaMMXY29ZIHf1yRHSlTGnfXCd5A/II/UjrTt+/g0CX0ZvZYt4HOh0RvxzTYIj1IVHe9vLvnkAtCJ2IoFxqchAimK9J742geer1Jrx8eaOxp0Fw3ktzRrbsim6TRwOnTlG90PS0BHbNzjLmPVef5VpZoelOozW1GkDOjqLhpLbuSCY63b1H3szSlWdAHCYijlNeo2DIFjiHnBFmD7LcmSzwNtIHltWfKPe1DsNUW3eZ8/OkcM25PeRMU+6jYL9NPkueO0tHNNIjuV5nHWcL8AWUl5LY0uXLE9qmG2vNZE2zneA2eT6ZkUVgdETpbFo4CCfp/f+y77XGLaVvJVezptJB/nj3e+1dbhWOqSw26wR0NacI0veNclxDScnvlwj52/dTGvWzrlHaJ8/MUTNQHpUTQSL7LCbg90+QeuYeF0fipjsbi8lAOijvaH07MXU5qgm1vYwYgacsxE+V1S5MZLRl7Zm5f55yQhEz2U53WLRSBgA9NzXZIIx0c2QepfU1htH8ftvT/f+mSW4M970nUILMsfFqyxv9clzM1FQXKFxEHXSKzTj2Tdt3Uky5PR49j45EejXpuH35LpED6fynsIbjjRQsKeg3v/ipOwL8Jy5s0iNGu76g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iRN3vZv/JbR4pBzQiAlf9bvVL/ygfEK6QZobFzr7KqG/CPnJJIwFHacpMMD9?=
 =?us-ascii?Q?YNbcbWrrdyvMX+qmU0ImXRe9oqjYKSD4qIGc96LFJVE8siMLEh3fshiHBwBj?=
 =?us-ascii?Q?XMVRSWsxeOEAPPVGHFMPHJZyZbpkmgHB2gndWjCA87jAz4Z0e7lHZgwayRPp?=
 =?us-ascii?Q?X3JkUMDmHCam+s2dlvWnLCxxJGsDTqmaDmZGYFaiMoS9oMIw9HedrT+0nO/K?=
 =?us-ascii?Q?z1GvkNIo5o0ggCbaNUqFtU+E1jxMfMh51npeuoLQYkVPTAct4gASmI9xGOVZ?=
 =?us-ascii?Q?NN27Vhk97aIQU9TqYajQFO9u9g+T2QZkUDLGYwWAy27ZvOhoeX3BOYOuuGwu?=
 =?us-ascii?Q?OvXy9XEzyWiXQc6nIaCEx0YpwbbtnZ61HoEFEc/9dAEckLBGnQy5r5GAQy6C?=
 =?us-ascii?Q?GlGRJ2U12U5NDjxID2YwT0Xi5LEXRBYYRekg4W2eLRy2MYVD4SGZ2t/R/uY5?=
 =?us-ascii?Q?lZLFUdsKDuoSGGeqqLKe5zB5Q5EZiVi1m2vibmphqPQcjvyLs729feOavrhm?=
 =?us-ascii?Q?At42X0L7g/O3UEw0q9zg5SBqwjB7MXhTopMMzBp+cQoS2bkUnKSo4s6KNC86?=
 =?us-ascii?Q?j4/NxbaYGtau2mXwMMN3ZO8In03BT1S7WmqaALajv08qWlGLYfgGUEoIUb01?=
 =?us-ascii?Q?NP64VVC0AI9ZfdQ0oHZKXxerWLv47NbrepmAtxzEEIU9RV/UN2TBsxNP5Wbt?=
 =?us-ascii?Q?MkdyAOy0lx5egVIAZrpsFKCxWWDC5ePYK095YyYkSOT9K3dlY7hNldX82hko?=
 =?us-ascii?Q?tbocg79xIyCehPyGMm65poMGAkHhPFqA9PEZ/M+gp1UbnuaMTYE+NntRlB9g?=
 =?us-ascii?Q?TKOo8WpyNylQrC4GMofibs963zwqWXzih0tisPBdbZjv3lT6uEaYdT7uXq1L?=
 =?us-ascii?Q?KSSsSc7orLu5yK5aUJKg2zGaJpQyh0rsRgUBeqj6Ueaxt5WZpkDIpu244OWy?=
 =?us-ascii?Q?AA9ijYzKJEE/wi+XaFhMAfM13ENCjmXZzpsLwU7n9yGAuJ4XV36lhds3L3UK?=
 =?us-ascii?Q?nqyDmZr1Zpri+RwcbK20o2n/B49S7ATFeXjR5IWcs4bN144L2y8hKGS32Fsn?=
 =?us-ascii?Q?sbB1OKnfxdhiYnWi6GpzJISYxdBF0BNK+5t7+F1fM0LLoHaU60e9uf3XoKVR?=
 =?us-ascii?Q?910HUmSAIpirCAcEzD2rzqaaeMltZcXkgXuHPXjaXzUmcI2Ib1nBwhmex0h7?=
 =?us-ascii?Q?LbrZToQoBlyfm+uEdm8jqFNI3Iaix47d2gkvXOmA5E0MbUECOq4vG3Jg0QTq?=
 =?us-ascii?Q?M5E1+AGTsqeKkmzHR+Wm/V8tofYk8CTFp7cnrzFShJh/x+mUcoAA0w8OYElB?=
 =?us-ascii?Q?5ZaFw5mx2br5by5/YvyQUL9RZVYcHpjnsljrzbFiCLcp4pLH4VzwAKLILAx3?=
 =?us-ascii?Q?6uPNc91xU++vRkgtdUxAFb6134hIRb5e9RwExirA3ojSdEOFW5/LgMGTWHxS?=
 =?us-ascii?Q?CHYLIhBxynw/9Gi8r9X+2jnGQtaGDPm54P7PtisK9pXMAf9V1Hyd1nlrqwbg?=
 =?us-ascii?Q?iI+I6Ui5XpFvv7kU1D7pfPlTjaMG+2AIpXt+zSa3DXOmqZ92mSlzOAwg4zsT?=
 =?us-ascii?Q?L+kMZbEdEkwrOZJYvCyiJsa21EvDGSZpxUaa6wFJE7feXwwP5tQ78nxxBXXs?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e71c60e-cdaa-4efc-1a64-08dd0ce8d6ae
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 00:33:53.1387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bD8atAGbK784i0OdCadtey6J+WpJ2chT0/NtBRcf/0V+5qFGOneRJm4H0W5cYzAOBU3+pJAMaZlfF/JP3nMRVyH6V5V9hKyx/vfu8u+YSIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1244
X-Mailman-Approved-At: Mon, 25 Nov 2024 01:40:37 +0100
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

Tested-by: E Shattow <lucent@gmail.com>
Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi | 35 ++++++++++++++++---
 arch/riscv/dts/jh7110-u-boot.dtsi             | 34 ++++++++++++++++++
 2 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
index 3012466b30..c44553455e 100644
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
@@ -27,42 +31,62 @@
 
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
@@ -78,6 +102,9 @@
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

