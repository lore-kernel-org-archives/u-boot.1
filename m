Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A87FE7717F
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 13:26:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0A1B895A7;
	Sun,  8 Dec 2024 14:25:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E88F89529; Sun,  8 Dec 2024 10:21:21 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20706.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::706])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B7F48952E
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 10:21:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEIAzmmWvD15sRBRaNzpStSRjVwlZyD0YnAu7+1KeNfjlbwaCshYHF+DoR5Nw1SX0SpEdOY3gV2OLDZd7IHPmdFqLNbZwL6kALjiz85zRZWqUwGxEh6TpINpexxBaHJTymUDvHk6ywhJoWp4BbVBPRE5PUzcTsLjh4tIhOAMGDWl/5Aye3rqoCByO0gjlhn9YMO2y0HfTE18wAXUe/T/B15koh6bjsJYud9W+Oo0L8uQXIYf0u8qED0m0Axg8gny92ng++obYAuH7mg7ZMO2nxRnsIwiq7iypHQTJhCkRh4sA+hR/kODyTDVNbSGBa9x8JsZbC6DyXzB6pmq9tpc9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRTE7cB2DzFcIQf5p+pv+rgW74O9cAjSNANU9SIMAgQ=;
 b=gZgJXhLfI8x3CJr7EQD0FnEfrTGGL+lFGaT+T/4b1iSo1PUEqpKamLiX8EOoR5fLeNiYOpp+JkiPw0GMurplcCSvp+Sr2167ik/9KETaht5Mv7KcfzqU77IdxMqBnurLXsFNsvMh4QtLlbgfWfJ9ZoK/Msw+rJtnM3Rg1yEljbKeH3EFZonHT8GYx5qeLkoE2VHM/bIHCVjUDoB21NMUOW1E+Soi1duTzQ19Pb4o1FGY+ikjz2Wg4s7RQuL8j8mJXfcBp5ddsDT/LB2iDtpdGpmkngNy2Ogu57Q94DsUzP2Y+TE1rPm1x8oT7jbUjgN4vyJumrP04+3aHENRnvKUMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1226.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.6; Sun, 8 Dec
 2024 09:21:38 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8230.000; Sun, 8 Dec 2024
 09:21:38 +0000
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
Subject: [PATCH v8 05/12] riscv: dts: jh7110: Move common code to the new
 jh7110-common-u-boot.dtsi
Date: Sun,  8 Dec 2024 17:19:35 +0800
Message-ID: <20241208091942.47298-6-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: f904e102-2afb-43e9-b6ad-08dd1769b83f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|41320700013|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: qK+MiW9VkP/mDcKJ3IoiawFYtTNzE9cVEJqycZ/Jt2dME4QNXCBq6zercxV+tLiM8DGEFbrnhoxg4miiTWrt8ZrYmPUSuGFgs54O87NNzHrThHMV7GyRIIYTJNQWKYVlznq2YDgm7S4VTeN3kTJigGsp722Nsn+QANz09YPdS192jpMA7YE5/gnEX9eLSCVEhiSlfzvoc2IrO1Zb9ZAEbiUQDxd9BYdZrZVxFTKuclGl3kGPNI49Yme0NefEVJXToybN3m29+9WBH3bL36BKmMm+jjqkwTw6gkXx5mVGJvi7gfY7a+YFjCQI8n07oQCh/PhtT89YDAwCHDAacthEQHCW24cpZO0igUY5CI21YoQv7Mfj3ii23CS7DbEGB6828xbyQKun6ZNExbL54vzmq+vjJifotq6SKuQIldlRtw3wDWOGEKdDjw4ZUi9iioTZND1zuiLf/ClPvFn+j1CR1P/EbkhpOHgIt0sCo0htduBGAQy4od27hGz8yyUKGNv8e8jLseFeN5FScISRUWOmO+SFySO+Yzuf6GoIULJesLjLGHAEY5dRycy6FbKzQqcJGQpcx9Ijx7DhA4H7Tk/z/knWvDKmTOFB8VPHa2nuGKNMeLbqnIW79oYcsvPT8W7mBZJEeGFdIRVW+iEw69VhYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(41320700013)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LnJHvhxcwp14Sd7FaK8kdbIlLb4bq2P76rO8z6YD6mbSPSbYuHvLXTdsPrvH?=
 =?us-ascii?Q?4Qq1TAPt4yZzzURXcI5QVioOLF9NpzXAh70xtrdXqcL5hsQFsFjrY27HCnQl?=
 =?us-ascii?Q?tVPyyVuW7jFzJGEai0jAT9Tx5ovYsK1ZQBhffpacUR9nAC2zjv7drtnx83Oy?=
 =?us-ascii?Q?flYvfrKmMW7gGGvGvHn7BrM61u3KeNksZL5HsjoBiC/yLiyTd60SS1u4s5Zj?=
 =?us-ascii?Q?x06xH6PspBuDfYmWC9LFe6E+ZOR49/7Ubxbg0JEiRu6icXOwoiEl7vZJleSL?=
 =?us-ascii?Q?jYq24QoSQLfAS8wZR44EHDZOXMJjBldG8zMu3TspSYtsw3dWZWUjPySsgX3J?=
 =?us-ascii?Q?7/8vv1ogjiYHxZ1KsjBnCs4109UaNCjkILMoKFuRzd2PnpVvuvbrS6998sAK?=
 =?us-ascii?Q?RziiLi30PVOE6bLkQNio7lpLcnSk7O4418DxgJK3ITVVS6Eg3lxced97bp5d?=
 =?us-ascii?Q?x8pP9NdMyvfaqdZgyeCGtpGFbPLVbRY2S43Ys/kIN+3MQ198PHldrzmiSJAm?=
 =?us-ascii?Q?+i2mrL8fSrIFfUjLPl6Jy+tHXROei6IYg7EYhwFazIyfuEd/hvXluZU1n+6W?=
 =?us-ascii?Q?eTF5px3Zqc+5dGFlWLMvwSQ5bf1PSHRoMVsiaegjamqJMjdrQ2QvkHqsNsnr?=
 =?us-ascii?Q?mnlrJb6C02xXe6tYng4SMySnW8Z6mK/FWocIKb+uOMiaoGlWQyDEHsnTdKM2?=
 =?us-ascii?Q?MVQvRMa3mEyMrdBRBpfZOJ1tf7tLEIuN2xCioTqXdkXrQuH3C63xTZOQQ33q?=
 =?us-ascii?Q?+IsKm5QkLvvGcnxosBHCEw4wTCXPM1LDzRkQhOpS26/NcEIi3VYJMjzB9Ti5?=
 =?us-ascii?Q?tZT3fvKtYrs9p0yHN1LkBZnXc4h+KAYaMh16V4qXkVepko6jNWMpXG3eEJHR?=
 =?us-ascii?Q?A5UiwH3hZ4rhBfe9va8vHlHtk+oZCp4khcZyNQaPjWyQ1+OeepjLTqb/yazl?=
 =?us-ascii?Q?Eu8rMHgiQeX18Kx5HmvwGfgi9rxR7lwurkvH/QLF3gI8yj7PtkdknCFD2+Vi?=
 =?us-ascii?Q?t4VrFScnVRbTv6q1bJc50rREYCfgOUGWCUew2yBsMplDiKHiIa+k2RJxMDtD?=
 =?us-ascii?Q?smgKPZ6ijSCp4nvzscrKEDILgK901hDh6lkkbYXDs1P5ZuDlDF+7Jhrsc+tV?=
 =?us-ascii?Q?y8qoqgUeGdcVdeWOFy5OWGTWTvuVw7L+RJDfVX5mqkI/VHETiKuNNN8T2Xdb?=
 =?us-ascii?Q?Nj0cuqckF1EO23KBoOMVdYrNdbFxjJnkyhO3uNHOke55kXcKj9CpYfDoByap?=
 =?us-ascii?Q?9wAFsBwWicolBTzXFz4MAFJVfrkXWoW8XizoEvzznGoIsHpS8dmv4YlAM5T3?=
 =?us-ascii?Q?xhSRsrSZWYw0MG+EvshEJZKW7oLLk9VogRI6pPggTXorhh38NrOCYNEzPw8m?=
 =?us-ascii?Q?FVl99U3wGRNUXkfJelL4vpFOCEu3lhRwYSG5oKFR7odTmQkP0eLm4kOgOZOZ?=
 =?us-ascii?Q?d3EK8jqDM2Pe/PpKA8nh1bd409p+ljfXmWUQ5fTQEI9g2RPcRp+VZhT5uC5o?=
 =?us-ascii?Q?C9ZOvBwip6E0zUlo83Sn898B3xKuDzV3qWRCLcQDiegnEeKYLw8ATCvveZvA?=
 =?us-ascii?Q?Pfq3oEbJwMS4+4kMXRVDPR9XlRiKhTm5VZ7gKO4CizWCGUqv1SPniO9e8Twb?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f904e102-2afb-43e9-b6ad-08dd1769b83f
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 09:21:38.7798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4KrPuAFLoQJKzUENF5wxsu214WGd391uoEyceV/IbKwvblYu8ZIrmJxA3pCF80PTcXt1TN8K2cY7qp9JWJ/1fHWEtiGk1RvlXstQn+A5Fk=
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

To support JH7110 based boards besides v1.3B,
add a common dtsi and add common code to it.

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: E Shattow <lucent@gmail.com>
Reviewed-by: E Shattow <lucent@gmail.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/dts/jh7110-common-u-boot.dtsi      | 141 ++++++++++++++++++
 ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi | 137 +----------------
 2 files changed, 142 insertions(+), 136 deletions(-)
 create mode 100644 arch/riscv/dts/jh7110-common-u-boot.dtsi

diff --git a/arch/riscv/dts/jh7110-common-u-boot.dtsi b/arch/riscv/dts/jh7110-common-u-boot.dtsi
new file mode 100644
index 0000000000..45fada34d2
--- /dev/null
+++ b/arch/riscv/dts/jh7110-common-u-boot.dtsi
@@ -0,0 +1,141 @@
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
+};
+
+&mmc1 {
+	bootph-pre-ram;
+};
+
+&qspi {
+	bootph-pre-ram;
+
+	flash@0 {
+		bootph-pre-ram;
+		cdns,read-delay = <2>;
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
index 45fada34d2..e6bc6630dc 100644
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
@@ -3,139 +3,4 @@
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
-};
-
-&mmc1 {
-	bootph-pre-ram;
-};
-
-&qspi {
-	bootph-pre-ram;
-
-	flash@0 {
-		bootph-pre-ram;
-		cdns,read-delay = <2>;
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

