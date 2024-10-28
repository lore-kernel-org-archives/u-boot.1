Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14A2D13590
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 02:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6BF38902E;
	Mon, 28 Oct 2024 03:00:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B4B78901D; Mon, 28 Oct 2024 02:59:17 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2072c.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::72c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4405088FD6
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 02:59:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvYChIOFBfiUcG/2JNI3IuUaNvmlCKwV0Bi+311tGPvr4sGjL5XahkY8Yaw92P8x+FUn4hI+V2ZY4kS/f6KrnPeDzrpHg5FFFKe3wuM/0E2BC5O4hxmefL33LFbrtTJJGJ1Qk5LsfPpn/Yffp2cCeTqvDW9AgbbCUlMOwQw6ivmZZHcvE4RK3Z9CeqQn9frYlyTIGFcM9ol0wmJommOdh63i3ljXmVlkkMtk3e87kh0jTThq3yNYSBqnh5Ob6LfMCl5BTw9kzeXC/cZ2HCAkuk3/99HgRN5qC7LKzwcv2nKXm2UFohhqBtJ0JdFzeM6OfDkHDHx1jJIZ0Xv/tO4XJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhNSw0Hr0EE7L6fRJW7oyWQzgeU86yx9r6IQmtJoLxI=;
 b=i9+Tr+O8Awz6xhrNnlGUo5euiKWlKIRtkB7dQ2iPGGpkN5lpL/jZGOcNbNBi6PJZZsoBKbWg8iNQcDFk5z/69GZJcBVZAnoOgDUBBGa9OuIgIBRPASTI3alqrXkv3HMJ/ysxpGzFq2kFM4BBcatGwoXaV5YjdY00IaS59wiYzvu0xGqI64Sv7AZcV7lY8Em98wwMzhfRGPdbO7l5iP6dpHPLgaGkxZlrTp31ttohcWO3wo8YFStGHhuypMMrBjGFvJsD2tq6pREN3loGtB6TUAodV7sNxAiEGmLjadxY1de/ntArXi02lMRGnzPNmi89ETFmwQ2iYaPXISUi0JZWLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1211.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.34; Mon, 28 Oct
 2024 01:59:13 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8069.031; Mon, 28 Oct 2024
 01:59:13 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v2 08/14] riscv: dts: jh7110: Move common code to the new
 jh7110-common-u-boot.dtsi
Date: Mon, 28 Oct 2024 09:58:41 +0800
Message-ID: <20241028015847.42344-9-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241028015847.42344-1-hal.feng@starfivetech.com>
References: <20241028015847.42344-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0069.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::36) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1211:EE_
X-MS-Office365-Filtering-Correlation-Id: b95b0556-c560-4047-0b69-08dcf6f41f28
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|366016|41320700013|38350700014; 
X-Microsoft-Antispam-Message-Info: o3Bj6R3LndaeuQpKSoSstibu8CTscIScIZxNVGv1zLxpC9Gf/41AWraM6M+Jk2BKiwawPgtflH5n750vPxKQ6x1E7heGPr/JSbyHuOZFXysxfjR2Bj0i/9/b9J9Lbv+VrldrgpJyCfesx9uRrogLXDFHOqKl+NVlHo8gP19kMu3I5fzGVqK26q7R90qJIclZb/B9e6nBTp71oPclEdrdNgOUsrr/U2DzmGmeEA97o5nHGILSr2lemrEEVsJ5XDuVhQvdAQpa8aAmj8pSEIY1xMsoDWEx8uhU9oDu05G0BFvnnXslV6DBj6GoOBWX1aUB9jLcWRaGdxpCWTo3ccSMA2xVWRqt92+9yfpwUaLi/WDkcMCo+N3cagxVg/KGRQ6fgYEtZwzAK0r51Tal637G547/WDI3h4jRhdaJLvMMT4Vet30K6jZWwXpUQE0JHJoqfgc+OduZjOOu0hJFJ+oFz1CihgvXNZ8W90MPHfE6JmKtPeFUEDvAOT5sYwUcGWn+kVcu0MjAu9Ce82wJN+NaK44xC2yoN/VUnH/10ifC5dkPgxR1jLUA1DzVuNcB3ztLboUO95CiwqyUMwp5SkfeDjNpxzMT+X8rtTYswskA7NGCV5SUwefjDdY9MMkqlptR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(41320700013)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8zj/oWRmSPKAZ7DqZiwzKlMnkaCp8XMKsWqfkDGSNdy2OOPOyq4bhxhAKShA?=
 =?us-ascii?Q?foTOJFmVkuvyDabkiHEsVQAh7VkracQE0WW9RxEXDDi/RAfDumPe9YckLJ7U?=
 =?us-ascii?Q?ES/iLEdJaF/xsW8ALAtJlD34RgnBbIb15MyxuvSChjBUmtsdB/fyh6TZ5hXp?=
 =?us-ascii?Q?/LtxRlyM5tTGzCrdFeKdtvJ17rQacrXjzejk+iuo0wrYGAAkeB01L9NeJp7b?=
 =?us-ascii?Q?KysEpqy+EJEaEJ1A1u7Zw+YHhxVE64tvY4OilrqbR+seabd467lg5XIrmSGp?=
 =?us-ascii?Q?0QIU2PQLkxbqMw+IfyhOFE3CCR2gP9NYyzQhRaQJdZfAMbtzhBlfBkV68ryw?=
 =?us-ascii?Q?bJUaZ7ZbKuKdBVrxRAir0P62BG47GznA0pbkjft4DL1QvM5Zq/eqH7IF9Ivq?=
 =?us-ascii?Q?UZso5AFvN5Ap8G3DiSAJphPLKPS/SHjBAf1Zwj3tHbBD13yX7kAXFXwNRooz?=
 =?us-ascii?Q?PC4CTI/9rXG5mR+r3zAcBYid01ceVvJIt+JMrCiLSA4aRWVkkBI8zvVNCzpT?=
 =?us-ascii?Q?4YT68QpeTCjqIRJOM/nrWYyJ+5/z/t5uD9oG+sxZKw046to6oSnzKqG82J9j?=
 =?us-ascii?Q?inLtrP82/gBK/vnNtUnCWdS9ZBi/Yqp8poVrcJF6+pNm+LLJtXu/YFnhXOtf?=
 =?us-ascii?Q?EToSWMSw3YGWL0+swS1mG+WTr1fFlUiraip8/4jrZ5iYkbAHvD06JpsoZdVI?=
 =?us-ascii?Q?ryTHzW2mDcgqovYs8qnJEit7SgmtrHvfTK9EXHeyaDAGKop1llUtXYRcNnP3?=
 =?us-ascii?Q?hBn3UqnUOLm0WCdg698qsykA9ZYFZDDj3L5TU1OkA0SYYG6iB50WBGjh6T9m?=
 =?us-ascii?Q?tOjw+zHCvhHAYKPg7r90HvhfxzSsBa9zQOXYB5jQZS6pNZwDtwJL9rXACFPR?=
 =?us-ascii?Q?IUu0m+mAXNWh7yA06sGPCxoxVnh4bnCNeQHFSVktf1oU4W9lFXLf94oIEjbc?=
 =?us-ascii?Q?49x23mb8+C/Y/URI41ACQnGvwcIwny66GywBPTr+4027YLg2byhnds5+hOQQ?=
 =?us-ascii?Q?SmJsUHWoF0suX4z+vns3DHiQ2QKwEow3nvWKhJkbNntEQNDqzK4IJawNHv4e?=
 =?us-ascii?Q?Mkg6gNaCKKINJ4G76y4fpt8HXuc8KB4cxhN+hvdShDaOKPYLW7apTzjls4wg?=
 =?us-ascii?Q?ilcqUOYEHM156i7zynZRLvq7W2c/dilUV0QKjKEZeUbdQErHPmF/1vtlD+S9?=
 =?us-ascii?Q?Bm9MoeMEaEnUWj6ewaZmsq3rQau6mJSqbcCTAwKBtam/rE3qDkYS1XtQ8LHO?=
 =?us-ascii?Q?AWeEf8yAJtoN4YD6nJ/7K71L3/PM6mb9gxXn26JemUGIE5QniVK0WPj3gxhw?=
 =?us-ascii?Q?lSrHsq632By4vQz1lqhEWB6rRU9K2yPHKus3y50r7CgCBRq9y5ppX7VDyDGC?=
 =?us-ascii?Q?b1BF4qfNhaaIdiQN5pPpk7FE94aj/+MzYaF9wQUO2MjpOBowzL8LuJi6DgiV?=
 =?us-ascii?Q?RyuRjKGN6Q/T/AMTl9jHwK5HV10fZ5LOdCkYukj+P5hTD/P1UJ/AINWHWdK/?=
 =?us-ascii?Q?8OyLpbHP4eH51WSjDQFJ8yJ/ooAqMgJ17TpnpVuiUfNSt2z14Mb0lEkxjK3f?=
 =?us-ascii?Q?LYchINTRAAhzIIW8bHgYNgpcLv/7p80BsS28msPfONRfkhD+6X2TRZwaxjta?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b95b0556-c560-4047-0b69-08dcf6f41f28
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 01:59:13.6132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmpXek+xl7qvg8QQve052LQ2zSRBySIzz8R5dSTlUJ8kFWFbZOGh7/DVMkUeDZ49DbDsjcQ9EbN3/yTau+puM480Y3KAsbdM9LCtzgmJoGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1211
X-Mailman-Approved-At: Mon, 28 Oct 2024 03:00:01 +0100
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

To support JH7110 based boards besides v1.3B,
add a common dtsi and add common code to it.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/dts/jh7110-common-u-boot.dtsi      | 150 ++++++++++++++++++
 ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi | 146 +----------------
 2 files changed, 151 insertions(+), 145 deletions(-)
 create mode 100644 arch/riscv/dts/jh7110-common-u-boot.dtsi

diff --git a/arch/riscv/dts/jh7110-common-u-boot.dtsi b/arch/riscv/dts/jh7110-common-u-boot.dtsi
new file mode 100644
index 0000000000..cfd3c04aec
--- /dev/null
+++ b/arch/riscv/dts/jh7110-common-u-boot.dtsi
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ */
+
+#include "binman.dtsi"
+#include "jh7110-u-boot.dtsi"
+/ {
+	aliases {
+		spi0 = &qspi;
+	};
+
+	chosen {
+		bootph-pre-ram;
+	};
+
+	firmware {
+		spi0 = &qspi;
+		bootph-pre-ram;
+	};
+
+	config {
+		bootph-pre-ram;
+		u-boot,spl-payload-offset = <0x100000>;
+	};
+
+	memory@40000000 {
+		bootph-pre-ram;
+	};
+};
+
+&uart0 {
+	bootph-pre-ram;
+	reg-offset = <0>;
+	current-speed = <115200>;
+	clock-frequency = <24000000>;
+};
+
+&mmc0 {
+	bootph-pre-ram;
+	compatible = "snps,dw-mshc";
+};
+
+&mmc1 {
+	bootph-pre-ram;
+	compatible = "snps,dw-mshc";
+};
+
+&qspi {
+	bootph-pre-ram;
+	spi-max-frequency = <250000000>;
+
+	flash@0 {
+		bootph-pre-ram;
+		/delete-property/ cdns,read-delay;
+		spi-max-frequency = <100000000>;
+	};
+};
+
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
+&sysgpio {
+	bootph-pre-ram;
+};
+
+&mmc0_pins {
+	bootph-pre-ram;
+	rst-pins {
+		bootph-pre-ram;
+	};
+};
+
+&mmc1_pins {
+	bootph-pre-ram;
+	clk-pins {
+		bootph-pre-ram;
+	};
+
+	mmc-pins {
+		bootph-pre-ram;
+	};
+};
+
+&i2c5_pins {
+	bootph-pre-ram;
+	i2c-pins {
+		bootph-pre-ram;
+	};
+};
+
+&i2c5 {
+	bootph-pre-ram;
+	eeprom@50 {
+		bootph-pre-ram;
+		compatible = "atmel,24c04";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+};
+
+&binman {
+	itb {
+		fit {
+			images {
+				fdt-1 {
+					description = "NAME";
+					load = <0x40400000>;
+					compression = "none";
+
+					uboot_fdt_blob: blob-ext {
+						filename = "u-boot.dtb";
+					};
+				};
+			};
+
+			configurations {
+				conf-1 {
+					fdt = "fdt-1";
+				};
+			};
+		};
+	};
+
+	spl-img {
+		filename = "spl/u-boot-spl.bin.normal.out";
+
+		mkimage {
+			args = "-T sfspl";
+
+			u-boot-spl {
+			};
+		};
+	};
+};
diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
index 2b063414e5..f4807957ae 100644
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
@@ -3,48 +3,7 @@
  * Copyright (C) 2023 StarFive Technology Co., Ltd.
  */
 
-#include "binman.dtsi"
-#include "jh7110-u-boot.dtsi"
-/ {
-	aliases {
-		spi0 = &qspi;
-	};
-
-	chosen {
-		bootph-pre-ram;
-	};
-
-	firmware {
-		spi0 = &qspi;
-		bootph-pre-ram;
-	};
-
-	config {
-		bootph-pre-ram;
-		u-boot,spl-payload-offset = <0x100000>;
-	};
-
-	memory@40000000 {
-		bootph-pre-ram;
-	};
-};
-
-&uart0 {
-	bootph-pre-ram;
-	reg-offset = <0>;
-	current-speed = <115200>;
-	clock-frequency = <24000000>;
-};
-
-&mmc0 {
-	bootph-pre-ram;
-	compatible = "snps,dw-mshc";
-};
-
-&mmc1 {
-	bootph-pre-ram;
-	compatible = "snps,dw-mshc";
-};
+#include "jh7110-common-u-boot.dtsi"
 
 &phy0 {
 	rx-internal-delay-ps = <1900>;
@@ -53,106 +12,3 @@
 &phy1 {
 	rx-internal-delay-ps = <0>;
 };
-
-&qspi {
-	bootph-pre-ram;
-	spi-max-frequency = <250000000>;
-
-	flash@0 {
-		bootph-pre-ram;
-		/delete-property/ cdns,read-delay;
-		spi-max-frequency = <100000000>;
-	};
-};
-
-&syscrg {
-	assigned-clocks = <&syscrg JH7110_SYSCLK_CPU_ROOT>,
-			  <&syscrg JH7110_SYSCLK_BUS_ROOT>,
-			  <&syscrg JH7110_SYSCLK_PERH_ROOT>,
-			  <&syscrg JH7110_SYSCLK_QSPI_REF>;
-	assigned-clock-parents = <&pllclk JH7110_PLLCLK_PLL0_OUT>,
-				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
-				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
-				 <&syscrg JH7110_SYSCLK_QSPI_REF_SRC>;
-	assigned-clock-rates = <0>, <0>, <0>, <0>;
-};
-
-&aoncrg {
-	assigned-clocks = <&aoncrg JH7110_AONCLK_APB_FUNC>;
-	assigned-clock-parents = <&osc>;
-	assigned-clock-rates = <0>;
-};
-
-&sysgpio {
-	bootph-pre-ram;
-};
-
-&mmc0_pins {
-	bootph-pre-ram;
-	rst-pins {
-		bootph-pre-ram;
-	};
-};
-
-&mmc1_pins {
-	bootph-pre-ram;
-	clk-pins {
-		bootph-pre-ram;
-	};
-
-	mmc-pins {
-		bootph-pre-ram;
-	};
-};
-
-&i2c5_pins {
-	bootph-pre-ram;
-	i2c-pins {
-		bootph-pre-ram;
-	};
-};
-
-&i2c5 {
-	bootph-pre-ram;
-	eeprom@50 {
-		bootph-pre-ram;
-		compatible = "atmel,24c04";
-		reg = <0x50>;
-		pagesize = <16>;
-	};
-};
-
-&binman {
-	itb {
-		fit {
-			images {
-				fdt-1 {
-					description = "NAME";
-					load = <0x40400000>;
-					compression = "none";
-
-					uboot_fdt_blob: blob-ext {
-						filename = "u-boot.dtb";
-					};
-				};
-			};
-
-			configurations {
-				conf-1 {
-					fdt = "fdt-1";
-				};
-			};
-		};
-	};
-
-	spl-img {
-		filename = "spl/u-boot-spl.bin.normal.out";
-
-		mkimage {
-			args = "-T sfspl";
-
-			u-boot-spl {
-			};
-		};
-	};
-};
-- 
2.43.2

