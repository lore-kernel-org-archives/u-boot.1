Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B8BE6C5F5
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 03:12:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17B1B89624;
	Tue,  3 Dec 2024 04:11:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF72B89610; Tue,  3 Dec 2024 04:06:06 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20707.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::707])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD377895F2
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 04:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqpGK6qR4nxzi5uDbymgr1rOGbfl0IVPCrs+oIftcHOzEWlhrtm8SonjqC7tKHKSx2dTyJBYBGVQXAF9Y9N+eXxwierrpHOAA5noF4TWKo48SQopcAiJ0GYnHmljgER73uxsv8z7KMJ/6x2lZGt/UxfH2bZB3vGwUGTIBCKLZg1Q8szd90fipgxeSZcmrbyLVOLrnVAoDy8+bePEVN0fN8YXUs7hkNTBLvEFn6/1rPe4HZHMsYd9FGAfBjAEo45n+VYdEO3/oA2UAnNqQqDRTDLcrwmY3I2L3zmn5nheqXhD2dsrcTaFc+ojdDSiaAiG8gTksZPt3LuesNPeD6kq7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wR5RK2vRO3EI164i5HQGn0RyIpgJJDn7xbmn/adoyq4=;
 b=GLlZC0e67PgY9wodfgaG5pdAagHkcsKOtHXlzSLGBpmLOUycTpZUFvOczNmKn1kzwlvIsjAQJPVZkATfCXLTAbSqVdJHz/7XwKlmQHKkFbzTmhOrD2mvY+cyiA0Tr22r/YcBt0uUk0U/xSYHs2CnvZ0kK0ztDV+W3vklP+aZ9N1Swhb7KTxsxt8YRsKIwC1yDBjEwYVYY5ZlCwu3JM/J4h01Tca9iF6TAyNVp77NowVxVr94YBrM7mUik248vw/ImzpN//4kuRX5G3AjTthunf5oGLRVRjk4ZT5SzXPfVWge94FC2+UWVO5mHGz/ZuXz80eaFmkAQRLcoiB2pgRglg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1259.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Tue, 3 Dec
 2024 03:06:24 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8207.010; Tue, 3 Dec 2024
 03:06:24 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v7 05/12] riscv: dts: jh7110: Move common code to the new
 jh7110-common-u-boot.dtsi
Date: Tue,  3 Dec 2024 11:04:23 +0800
Message-ID: <20241203030430.26089-6-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 189a8b38-76c4-4208-cf11-08dd1347785b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|366016|41320700013|921020|38350700014;
X-Microsoft-Antispam-Message-Info: 4ecqrAQfAFgWm1bfMlR0vHhQXIxtoBCYQzBiVax9IbaQvo2o/caWE6uKIv6+iOgVICfAOg4j+yn+1XY7yhz8BgHOEvH4C/Dgo2pqMsUbyzV1LdbQTi38AM6hT8lFBsENEUpd5F2q2++/gVzw+k5EG6RnJe+sqx7O/v+NhNDVmRQWIealrDajAxd+LFdEeArq9Q6VN+mqfjthj9cshIJ1AFBHrWd/64RCFk/VTFnCgEHCyEwVOsFJkic+pQ4/hUohWuyOdJkyaNuzNitni4QbfNRHkh7vZQgtW4q6/SPVGTbL/fGCAGqHe9yRvkyQtwi0ayVEJWkSHHQytyUCGYorSmrTpsiKRH5+vieM1LiMhlfQAjs0siaAMZY/YDGS8mV9j5waqCkJD3d1EBKMrdja13TaJXU/aYGZ/jxh8xz+2LYUF76/0NfU8opormlC2yDbCeUYaWG9MsHcmWZfa05iS7mr8rY63wQ5XGSuVtBirdnEP2lRv04C4UDwAtnbNd5XaBXxv8HoR0MjTYlEYKCcQF4oZ5aYXkz0BNAdduFamkEn/Je87Qb5YBOe0/wcd0M9qEEcRkgc8zn0MxbkLdETWoILLWWIb+TTLTtCv48+Kt/paA0zJmeArIEOUjU7zZzkNnRg/HDL6fVR+RbIXUC1Fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(366016)(41320700013)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H8YtCbh75XC46LOa2s8bLm2OKPi9kVnPHZOR1fmdq3flOdQUIbHqaHY48Owp?=
 =?us-ascii?Q?5Gb+lf8AHPY2It8VQM72op1gLNLI2wBkPUaif8SdJAPjXkBOZzlvW/7IifsM?=
 =?us-ascii?Q?gHwXxNJtLTBLPGQTBGUpk05ww6vCCXmFxSlxrYoIG5L1CEg1Hevk7CUBqORy?=
 =?us-ascii?Q?cx9KgfpD+Iq3hClGwXCmY1kaR9Pi+W/dOOJ+fmHg9JGI74C4hAfeN2SCQx1S?=
 =?us-ascii?Q?hJ4jd51jqrIWexSquqv/XcgPHOCnpYzKrqHTBXajyAUtNY+MDDGp26mM1Net?=
 =?us-ascii?Q?MOYeecLbyjptQMRyGiC6UhXJXjybbF16070+tZA0JxAg7BZiWThHR+0VEezu?=
 =?us-ascii?Q?XYdVB10LRr0Wa7DLGWhbQ/y/l1BIobZC+FVdkRnxoVT2YyZFl23o86XqhyNp?=
 =?us-ascii?Q?g5pubK+9wDYKZC1VgVnx0tiLPMpxHVncrkPrXOSPFAMXAhUy1+IWA7tEAsNi?=
 =?us-ascii?Q?Xc1xVX14JwxQbaM/EfQ87Jq19l86FVtV1KxgtlN4iruGzNaX+D5fX1rVksde?=
 =?us-ascii?Q?++QYjqFuQ2xSO82EFiCrvuQBkTQxG/I5vlEkZWKiOjH/gumXhMXmIn4hliro?=
 =?us-ascii?Q?7+3cfnfu5TZbFZ9rG9kPfceWhLyrlBakWgyqDjpINebdyMDp/KOuDuQQIZRQ?=
 =?us-ascii?Q?ECbc7iIz93nEtk0lZlZQtn0zIUcrKLcNlVIBwijIrcZNKp/Xn8LgnZerH3dt?=
 =?us-ascii?Q?MavMuKfQWkW/hCgbhJkZCN9Hf3wpwvOYfqK9QZ4CvdeyhaJkrXIBl8SjdPqB?=
 =?us-ascii?Q?8RtNT5kbSt+4vvLGgSq7ejjtnZ0w7lMZNVMnigOXSDdt35xn3LAJAwC4/TKh?=
 =?us-ascii?Q?OnEEdO3yJBZfzlCMs3+OqhP1BS6kbh6H9M/6qVY8pqMOK7kHEJPPXPgAhPib?=
 =?us-ascii?Q?V65n0pRRuXuzStKgV7YZ3OkMTvC9ESQxZfZegNzSlTERoYDNgNLupjp2BT7Z?=
 =?us-ascii?Q?54NiRoRk+rk6tgohiOYmLNNSGLuvq/OepJePdTj2j+Hni//zmBkTEHz59aBI?=
 =?us-ascii?Q?WBVWPZXGH+9RW21uIzPErZXudRn/hfqmJ8vxqhtI0alfB9dF/plwDpLUN+Yb?=
 =?us-ascii?Q?COsbG+HVTf3Bs+Mp3L8hs6xHYJgCNvS/takn/KXGojuTANZlgUeXlLaDhCdF?=
 =?us-ascii?Q?Xb5Fd3Tr/wK+sYzhLJQlnvY4obbsKffIPpfCMul1AGGTbJBNIcOQzvrSMVqK?=
 =?us-ascii?Q?vV1M5yTUAd0vGSxe8P1GTLCh6cv5Wv0RyWuwocC1AhZmnTbhhyGKpls+t24D?=
 =?us-ascii?Q?TeixNaDwQX0NEHoLcuex26KisBGEe0N8+LUQcJEiHdYnsYee4sjJ7yIVYyj7?=
 =?us-ascii?Q?yksMyfI5X3VaiaTfR4VTbmMYX99v0JZq/AukdhF9/CTBk/RoF75W9GrmW0l7?=
 =?us-ascii?Q?dIRJY19C3oVF6kG1KffW6hXUsttnQlyJzrvY8yDPWv7V5ghIfYHQVAMa/HgK?=
 =?us-ascii?Q?fzEhPoln7CnzNCFuvyVgajrWYVkC9weIgYkloLWRvhA8j8dCeRL9vaBwu6AV?=
 =?us-ascii?Q?CePVEWFySvbIe5AaDlP9AloIO0/o1dsLOFzr+923pWQiYoQ7ulXFzAUqsjj5?=
 =?us-ascii?Q?+wPg6N4XadI6Dn/8u7BhQcoiiHrAd8Gw9QABq4wUcfbdlD4QCpyXtXiCuA8c?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189a8b38-76c4-4208-cf11-08dd1347785b
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 03:06:24.0505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9xra9YrvjhEuGT7/C1ZL+us1evz/A66I0jn7FUnmu7ZC3e6qO+ApA1GDcoZwa4YnDZ2cgGn7nQkFxymK+RGXI2kP69N6eN4J4PxTWrpXoI=
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

To support JH7110 based boards besides v1.3B,
add a common dtsi and add common code to it.

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: E Shattow <lucent@gmail.com>
Reviewed-by: E Shattow <lucent@gmail.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/dts/jh7110-common-u-boot.dtsi      | 142 ++++++++++++++++++
 ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi | 138 +----------------
 2 files changed, 143 insertions(+), 137 deletions(-)
 create mode 100644 arch/riscv/dts/jh7110-common-u-boot.dtsi

diff --git a/arch/riscv/dts/jh7110-common-u-boot.dtsi b/arch/riscv/dts/jh7110-common-u-boot.dtsi
new file mode 100644
index 0000000000..7953459e67
--- /dev/null
+++ b/arch/riscv/dts/jh7110-common-u-boot.dtsi
@@ -0,0 +1,142 @@
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
index 7953459e67..e6bc6630dc 100644
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
@@ -3,140 +3,4 @@
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

