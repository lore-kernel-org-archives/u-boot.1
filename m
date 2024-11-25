Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF45D3B7CB
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 00:41:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 092E3899BE;
	Mon, 25 Nov 2024 01:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10854895E6; Mon, 25 Nov 2024 01:33:41 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20705.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::705])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC07B895E7
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:33:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFdxq62Yn5hfvDBr0RiBkA4jSX2SYfIHEymmV/QsUYYR8NYZxeUMOc3xK0V1oQ39RaJr4M232EbLzF68Cj81MXneS0blkb3RzOEGUpjvDebKy9B4eBHILWw0LJZ0+sH5aUQBayndN/tQRGeA3LSusdrQlzItNFZHucVtknT5xKJGvDccE1CdWQvPP0ufFjrTs+RxSUL6cIo+D0Xv2+CcTqAfzLIwlMDWiBCDlbgvZ9vKBLVE+Iz/et3PQdgpJ8Gwo7WnnurtusBBBj97f5GgAtsp9RrH4nrULkARdFr6CYepKBoCIxvw59jNCzlqH+xx3ZGtl2vK0ig0ewSWMWXnlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3+NOafU3Qne3mAwm6vtdEOllorip6EGEtZqjWk4H28=;
 b=fbRvEhZ4RWYMLIW5j/3Zd24PZgnxvbfGto6AJYAHahfZvWpm/rjw+R6cxvMupkHvRWck9PEdViyE9/E0OCDdhyiKouBoTIa7umJjWUjZUril33NcNgFlPnYxytnfThtLu4/+Q0SPlKY//nsRUROI5sUthNeDGJrmrajfFimZjCzuty/jjx+ipq7Ceb/kICuPJMN4SmEZkaLxtwIRatE15fuEyAVX2RkworpwNRjzzMBNhPYLhvCogXLdXantmT2UJYGbhWSpnHExRNuN3kikw0TAzQ9uhyd63FXtoqIWZ+luFp2XJi5n6XfNueYxFYnA73quwrDlOSVg3IS9j2+P5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1244.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 00:33:55 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 00:33:55 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v6 04/11] riscv: dts: jh7110: Move common code to the new
 jh7110-common-u-boot.dtsi
Date: Mon, 25 Nov 2024 08:31:58 +0800
Message-ID: <20241125003205.75327-5-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0a20f140-ec6d-4d03-1bd0-08dd0ce8d7fe
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: XBCC+0FvP3rdXmLbBeTsRZ2zTyS7BCpXDkMhQkauiFc/ddgGD3DZEqPeRq2fVk/ISKspDG+osfvgH8voz1Og+6lQJ3gjIgC04pfNz5nrVp1a81yAj0pll1TuxwIMEaZI4hYBe5zKB6+xNYovBE/x3ThGTnPE81Tda+luRUwFk+tzXk3JugA3hONYq/U9nefnZbClKMh/yjrNk91BqdiSCGquOZy6qdnD06G6GUS1DAQGxEr8kahboNRWhGLM4JrNi0zvyNnA/Y1CTChDRsqKi3OItYiRb4yd46g4AVtLiOl43NoS3BNxT8/LV9gJeM0hLXOFFJJSB4VQ8/SjAEsj8J3fcLBgX2ThlsbPpdAtPsHQtUGNBhQgqFV5HZOJTKSsoeAeXshi8oJAv2yJ2mXP+So2nZp+CbS1FsEPuvGcYgIK4oDIx7kJWdW4TPXh3useuwGmFI8EAnxAfMJFY0VlRCPcepIEBj1DfQJHMG8FyrePeYpaFXUOM2A0JUt2cMTqS3HZyYsJ1KzGUamDsHVRJX36mN/v+e1pwC89jwinqn4FLvqAYpq+IQ/s05AJdrukJE2ewut044LSuIrYmXtPITRCYHG/cIeNor3dUSSgv+jMhJQW/CIMVWad9aPOgSOc6e75vZWieZR9SgMfJI8c5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M2YGgJoaJh2IMXd8KIHECEthm8/svdgD+6TzhIIHIlOYBLnQE7GwqYOACwT7?=
 =?us-ascii?Q?jcPcRT+02EZl89YsSO3Cqpxb7t99KgFk20Y3Oz3togD0WpBm3SrM1f9ybj9a?=
 =?us-ascii?Q?+I/M3uz5FlBpQaif505bLiAEtTqHYMiHtsX+HHedXry3r/p4XsgF54ftXmAJ?=
 =?us-ascii?Q?x4c+8uTXRfvXzU67afWxhM72UZ4Y8qNK3odQwZmAG39jHsnfWUTzQSGLVRtq?=
 =?us-ascii?Q?w/ek+qjjzURGe7bVK7fH3WNrkl9ZChGjIHTD/XEYCBjsTkMMcD6yoh2ab2Oy?=
 =?us-ascii?Q?TGILs6Q9brW0SXDuW45McFEuFU/dtdgeKY4UxxTX1RrLLxCvgPsmfiEvwdqa?=
 =?us-ascii?Q?4PceUwQdoascJETreoeC3hSp2RUPWsNtO5iEkh1Wxl2nfOkD6ijgCs4TrET4?=
 =?us-ascii?Q?+FdPZ7+93aG/82o83E/D+Y6Qq6vGmRq6rW9n2Gyq1ebYYOSz9burLSGeHk4G?=
 =?us-ascii?Q?g1gWsvkilOb6s3eAQA/EZqgbUxFdatzWJFZ9hMvbHr3BrqHIuOK1JoYq+o+T?=
 =?us-ascii?Q?FIulLIC8Eqv64fQ/PAg5pTtPhhRsd/U/zMINZ1id0b7ScIzn7lLy7XBtFo6+?=
 =?us-ascii?Q?LofHLwjL3Nz3olncQz+2c1cMZTnI2p/EHeLwseuDqAs/ajt1skergbOVJqJb?=
 =?us-ascii?Q?OfrpXIcxPOQ+Kn3jfyH3kFefcNOnT7Jy7P65QsGfk5dUIOJ3065RCW3aFx0M?=
 =?us-ascii?Q?QQlEZVi43+0aOOH3rdjgdqwYZDD91h5ES5vSnSU8PEg/7N0epdom5NT18G4V?=
 =?us-ascii?Q?JPQuaAdhDa6SRalXO38TbmxamE1gVPdp+XPb36dzHY0RqnTA/BJnZQ5ndN99?=
 =?us-ascii?Q?hzdjalUL+nqaXLzKGU0AUvql4Vr72fPwpYIwpynLZ8a9nOtSDjCIp5TN30+h?=
 =?us-ascii?Q?Zbv9UUVUmFaNbSrzNsR9OD+uTIfjRQBJoAQp1HlC8CKOYCh13Gdn05jczIBp?=
 =?us-ascii?Q?UbbhUjVh8nhARnrw7orMynIqTO8mpoQDTxxEodjXHQPmXDJYrxTo8CTHRSbI?=
 =?us-ascii?Q?JFtkAdQg8eCtD7ePMGPUkjxlX53MVE1nZY1FLlnCaliLulNz8k3jCYYi/tfE?=
 =?us-ascii?Q?9ofhh8e0TIKhmZWTZgZvaqcMlL6o5NGKVyXIA+4x8lTI7NSjP3nytjOYBD7e?=
 =?us-ascii?Q?X0osh6HL6CuxBHwGF4hMHLphRjxK9ENoFsXHm1/T/wZ4ifpJoB9FKxqRFvfD?=
 =?us-ascii?Q?RKnZZB2tbuKBRKwSYxInsX/d6IKY1fzpxrMWV34z/XyjRfC/BIP07Rsclmay?=
 =?us-ascii?Q?e4oTdgJqTebEaFphAKp9Ui1c5/WWfWEoyqCZW35Lx6GWsWc8j9vc9ZU03i8S?=
 =?us-ascii?Q?SDXt4rMZkntNauAXCqtn/QMMbZCyUw3rsaCz+cp9Dd0YDXQHOU3DW8F/4+bk?=
 =?us-ascii?Q?x5utKLoRIwwpzI8UmT/GB/kuOec79bLZMgbB8pqMt+YiVlY0t8MTFJwyHzda?=
 =?us-ascii?Q?SO3Q3pyrLSJxMNqkFJaFUiRBR4cLd0ZxvFZeiARe58GhQhrV7Kf7eBsQxVaF?=
 =?us-ascii?Q?QmHgozpRegLjE7wouRLmPzjhocQN+fE8Fl1TxohH0AdvDjA6fGY7AiT4wcJk?=
 =?us-ascii?Q?72bt+ZNjk+sWaYxZWSZgj3rk7LyK2oq/Sf0XDNTF7jSunbuQrHYD+1d0uHHJ?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a20f140-ec6d-4d03-1bd0-08dd0ce8d7fe
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 00:33:55.3245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5yOHke22lur3WJFsrkjndRzP7f7I+1Ky/y7hSVWVygG7Hzm+sf5J9HbeQrtwWVuf/fc4BbkE9WGEnLIfET8tTwXd2UJDZYJXG+jOXWDHb8=
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

To support JH7110 based boards besides v1.3B,
add a common dtsi and add common code to it.

Tested-by: E Shattow <lucent@gmail.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/dts/jh7110-common-u-boot.dtsi      | 144 ++++++++++++++++++
 ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi | 140 +----------------
 2 files changed, 145 insertions(+), 139 deletions(-)
 create mode 100644 arch/riscv/dts/jh7110-common-u-boot.dtsi

diff --git a/arch/riscv/dts/jh7110-common-u-boot.dtsi b/arch/riscv/dts/jh7110-common-u-boot.dtsi
new file mode 100644
index 0000000000..c44553455e
--- /dev/null
+++ b/arch/riscv/dts/jh7110-common-u-boot.dtsi
@@ -0,0 +1,144 @@
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
index c44553455e..e6bc6630dc 100644
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
@@ -3,142 +3,4 @@
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
+#include "jh7110-common-u-boot.dtsi"
-- 
2.43.2

