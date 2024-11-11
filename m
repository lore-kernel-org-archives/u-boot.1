Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CAFD12D5C
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 02:23:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4D558930D;
	Mon, 11 Nov 2024 03:23:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 255E589308; Mon, 11 Nov 2024 03:09:43 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20730.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::730])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B5D5891AC
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 03:09:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tgw3zUBP/5zuKMmaHQ/92QoMo+w/CxoB2jKX7kS2wU3YnpuMq48pmiIOUs7YLMjsfW5+67q4gaoj9bzMQvYQmt/tCO5mB4clr1ONijJy9u94bXTsRjaQbKhVI8ko/MhpIE4ePAfn6bNJ6e5E7f8TN/lE3Gxxa341ItbzYPvtK+uet2XpuIFkH2Tzn5pMHNgx5UlSx//jAJR0ANP6/fKdSBMYJD1F8wz5aeES/RbUo5g7HKoUv2T6rwfUMZLgwug0deIS236OdYqHTBEWzP0qXUgkzGU69eM8qtssjYv9JVOBnv7JHbm5tl6EPikjeiLx7vfCvCObMl1YBXTqdem8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAa90Jy6dGBdyGOmO4CaRNff3xA7cwFHF/llf2gGUYk=;
 b=QYEmajStoO0bZh15R1oI+WqToJ8BUj1Q9o7a4kNP7gB99fqx870eOagaupFoCyTjdBThjb3LAm7/2IaA3eboF2rodS887tpiiChlwI16YOXwh1dxKDvgN9wWRDtXsw6KoKOoOVF6LzWLS0zSKOdGd2/iVt2jxh09Zq5WgiQgtvE3JNxE2cmX2f4TDJOQxHfM+qHz8Aijlc/nCgAZwhrRH1tq+22P3zZiKI2+2anZ04/CL5Tl9J7WzjlvvCYaiUAvAnajqiOSV6mQY4Z8ANMFB1+sNzMrLAaS87cRVkkhhvHe5hEp96iXfCNU2f6LFVXRTB7+gyxjuK3PXRVjCi5+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1178.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.36; Mon, 11 Nov
 2024 02:09:45 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.035; Mon, 11 Nov 2024
 02:09:45 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v4 04/13] riscv: dts: jh7110: Make u-boot device trees
 adapting to upstream DT
Date: Mon, 11 Nov 2024 10:07:59 +0800
Message-ID: <20241111020808.38974-5-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241111020808.38974-1-hal.feng@starfivetech.com>
References: <20241111020808.38974-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0004.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::16) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1178:EE_
X-MS-Office365-Filtering-Correlation-Id: a2660d39-25f1-418f-3fc1-08dd01f5e94c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: SJ3vigC3KLYdEZEhFfPdqPge8TQxKp+ugQBBYcfsI9b6H5lvz80FuY9TFSsUbCNOibrtPaRLjKj4XSt161UhFSIfTN1Cfwii4EbUw+2lb08dneW+9rCacyFJNCsfdJCvNLHxUf1ZwocBbo/8geaTb+I/EOWCa+RImgg/6TWs+0THGCsIr9usKfpOYfNuX2UHwFvBUwrC+Va5AGbscnVAjYJ5PjbUB3X6sn1L/C7NBk8VcyNIWzKOjnjTluHs6iMuHbwD78yrmhvXxcpPZn5rhdg+SAKP0TZKUdpeWrUEhSTQ/+cJkxyw1yK8DoiwQ6yAYo07bjci7nBJVnOwZ7lUcp9m3hwPiAC/yWklCjTKaghfS7GDzvZcagdiJIc8Lan+YcuYeIrmAork/9eAu1UWRBVQ3vb8byPDu9m2CmPQ0JpQbuU2Yv4/8OAwUdlW3zeqMjPS1+qBmQ0gGBkVRR7qVuVz79x3BDRnTPN3CEsh1GS99EsDReIZ564j77r2/is7EbP35JHLPzMLeFQGTP56eWjwEszQ6SvjfLMx1UKkSr52jETIPWQjODZK16gKTdSZ+ZKndSZnMFH49CrtDX+UJExNRbYAYt75Enaq6xMocGfOiPNGgT2DIm9SDl+VKZBIlHAtifk1cNIHw06y5ky5SA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aGGoOsyLa/lCayn+orOup7XHUm50lqRXjTsv8coRO4bE+9cWKSdR7KQ+0QJA?=
 =?us-ascii?Q?4witv9UwLPLyNExHid4VEECpefTmb5HYb16i6SkYoIdghasYmmPRrNINnCc1?=
 =?us-ascii?Q?gOtEQyV0Z5AyjRq2NqmOXW4EGxgaBR9mbOQUF4VT63BnlVb1nNZxBrM9Wdwh?=
 =?us-ascii?Q?/x6ekNXUiLmsJ6cnsy/LPfP+u5wg6ogJ2gJvTfkhRc0yvp5dmD/kion/VcQK?=
 =?us-ascii?Q?YTyDCa5XaTkSpGuAmI+wLvPk4EzhDe8EI/AvGV4ZetmftpmtMw8ZwneRpoK7?=
 =?us-ascii?Q?v7EJo/3O/wyo0mSA8fJKZFL8XdGd+aHW2EIdZt4OHwj/wogl/Ai5n/plF0Nm?=
 =?us-ascii?Q?GXgCJsA+a6e/JIjBx75SsnZBoO5prYgK14AUgq7m+TSTOBAaf+7BgTZcaZQb?=
 =?us-ascii?Q?sXCt+bWxiXHTxrbrad8WBGWRJDSxst/n7fNJUuqS9xQWFQ2gX7cy1Ye12hhx?=
 =?us-ascii?Q?EmJSaDUeG37D8fVUyyK/ysQerhLZmAL80mZtasTmanwAlGskzNN3zFeb5mkQ?=
 =?us-ascii?Q?Ny09/OHrF1K2RQntBQkCQLe7UAyNyBdsb+9LI7d/MAbqAfTgBhzpGCXv7sQ2?=
 =?us-ascii?Q?HmgI9L48/Y+dEhoMjoea35K7I648SfldFRIC494jCyaV279bqUflu1z+dzDk?=
 =?us-ascii?Q?hkFZxSk+D0gpzd03U4yE9jo2IwYyQ5sfLgNCPQ2PRQ8LWtVC8UwGo0oK50XX?=
 =?us-ascii?Q?ywqFyrOSOGVRjuBp1FhFjHcD/fHy6IlALAfoS6gdEjDhqq0zyaloYHeMk7+e?=
 =?us-ascii?Q?BjDRt218NSSNloiBCPetdcU2ma56D/gxkp/XtYBfO65XFb3yOQJvAilcMqV4?=
 =?us-ascii?Q?+hXIGrY5I71huOi/Nv3oXCj1r71eyOWtvBNR833nALnS83f14M9cis0KwuZ0?=
 =?us-ascii?Q?EzWeLnyUi85hj4HxVjGP/L99rKdMzKH1Vy+taBIlmkgZSAtOu1gJeL+ytptK?=
 =?us-ascii?Q?WJA9i/dWTr/qXG6NsZw0PPgkCfYz6+3DWKqDoJPUpY46Tsfqs7yECgGaQUZv?=
 =?us-ascii?Q?5OF4huMG48EB1i5g15h3F63ZwqXi0vbRR6xk0gL9zJnlP8uGSTy1ENDN4ard?=
 =?us-ascii?Q?v4O8jw38VOWzk6HwzAPbl/F7rr+OA0YF3LhUJK/A5Di2F74Jzlx8teF7bSLT?=
 =?us-ascii?Q?psrfm6lYBBwn9jbofEtjIu8GGatmSz4I4iGZJQ9+f2RDBKQYL7ahJsxHkWq6?=
 =?us-ascii?Q?7Rq+nQ2y6iyaisGyh8rfkWEZAeabtMVvNFSr1Fl6MpK0vRpLPQXSFHjdeg/j?=
 =?us-ascii?Q?EqQ/kIBbpnaTjiUfsiusdthbfA3I1UZeSqMuG/oh5bUnMegLGJ1lotDsWnJ3?=
 =?us-ascii?Q?dKrGeJk6j+KGkV8+XKrqXPUbRdzQxjPanhHOdoFo+BACz0Z1FVWzZXpOlajk?=
 =?us-ascii?Q?tGKVMCwiVN11IAxyNPwT2c4JnAK6YC/LWSFjonuFxBVrVoqV8bKEvDbOyngP?=
 =?us-ascii?Q?etXEbg1ghI0mP8HF43joGcjYXe8RgOM6Auom9kKhO5dokqf7ebZWPUFbcYpW?=
 =?us-ascii?Q?IDVoacp5egcqI+6wn35svZRIyU5xxyK3q4rATLdQBrna2YstTN5xSQC3gjQ9?=
 =?us-ascii?Q?2N12atENOCAgu8s8zdLif47/3W9PVwE4VzyvHLxLVQ9dq3YBaTA5+YEj97/T?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2660d39-25f1-418f-3fc1-08dd01f5e94c
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:09:45.0101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ooH+0absVj5tTiGGfeVGpSPTi3Gq5X0YJsQSaA9QUbZZQA6PHBGU+shHscg5YBntgosyQ08RDnz38rfAO2aa3SlwvUzlnfKg+1I9+7sbAJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1178
X-Mailman-Approved-At: Mon, 11 Nov 2024 03:23:18 +0100
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

