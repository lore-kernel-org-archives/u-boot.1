Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B66D12D5C
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 02:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A48DC89345;
	Mon, 11 Nov 2024 03:23:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B6E389308; Mon, 11 Nov 2024 03:09:46 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20730.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::730])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6DA889275
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 03:09:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n18t3GptXKhjVZgjvtZRy3/L9uf7TTOnlzl8fDdh+e1bAQXudyn5eGQ2EWW+xBNeFGI3Kc3w4GAlRwuQsu3i/ES3WFOXGg9bPVfLl7b+dx8RHaZk/+Exn83hUtLKfit/wdT3ATnTL078VBbWoyjLl+T8cmDWA27KIE9KAlT9erv/qoghvasH0VfDjUOLF4/o1Zq3369G7l0r67G8iMfuQathjgvnMbyS7OFtmZyjYF4jP6TD3LQEXBKM7mHvDjzN13ydZHhHon/TRMXe3xOba3s9lRvZKl5/rvXZO2Ud5bKMrfSRwc9LYTGt3WJk+MiZymN3FvuA5yi9WI+ATKegyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhNSw0Hr0EE7L6fRJW7oyWQzgeU86yx9r6IQmtJoLxI=;
 b=iFT0Lm3O3wgfxxxqZIALWxUNfM2AhD+TorHBIp493h4oFNEaMNu7fLUu4qaKGP3Voo1b4kao0KukcIe3ivy4vIEQHnXt3V+5Mrdma8MHnoeOpLVh1Lme3DGIKbIUrCDptFHjZLFEnA+QleOy78dJGLhVKX1k3+9zf2iVzvVd77Kb3CYppwJr9MdzZvHFvuJyV5u9hGC3s2QCQhhIg3L+OxtRruBcgZYSWedWPiSbqOTXAU3Mmy+cNkS8Pc9Aw3T+Vsbi51RCZapcrD0f/d3pQR1jhpPzCrwzMoLNmpDq4P+dg3K35lqWxFEDo1GiHl3uIi/J5MmGER6r+u4ktHu4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1178.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.36; Mon, 11 Nov
 2024 02:09:48 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.035; Mon, 11 Nov 2024
 02:09:48 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v4 07/13] riscv: dts: jh7110: Move common code to the new
 jh7110-common-u-boot.dtsi
Date: Mon, 11 Nov 2024 10:08:02 +0800
Message-ID: <20241111020808.38974-8-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: c979d345-00c9-4eb9-cead-08dd01f5eb50
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: vx1e7TTigFOe5pN6WDS5/vtgDLbD3FuI8ouutVe+fJazAR0oQ7iFa007jDC188bIiNYPw1pJAX+02PTwrjEf+JaiUsh/mwHk7+orjcJcuwGVWcYPDyYDW9xvDBjCoaZLAd2+WFXa2NGYs4AmZFH76oqbAXap4XEcIuT7cjUQv7clpwcDetcw18pDQ62yc1pCkytY6PokcIls0bUf3q5rCsEXst06n6/inQsT5s4ddN4boxgWT+hrQZxAnS77psawUC14tcsIg4qPslj1UEpYnhHkEXwivuvYJyMyauGCVgCoIi3oa1ZCylzL9abk/rWmvQ6A7cPoYUEkbI7Eiy7ych6t+92DsCuPN+Fc+DcUZP6B1cePwswsPzTppMTuaHcSiJiJbOwIRTDqb6RUt6m/AcCZfmd0dHWFBq7NTZAfLVnCyapYZPXxxpGxkiBXMjVOieKgd0JOacTE+sd+VyHPT8NAJqiCq8jnJyKlfcqodwAkjO6wRJ7adNIJtW/RFQOGrnY3horRdUOkqZuNrtyebQnE92DsFAsfl7Up0HnZa6iJJn8RCRj/D6ALuTA6qDv5E+PQkjfp4xjoJAxzm+CTAUodvq2SSjLHLVaNBWCxbVGF0ALTje9u6umTDxWeuKPApnpDZqK/4D5vdK58DRlIgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QkkcGQor8w3G3x5sGB2a5gx+Hx6dR/OFbfnoAa7M4IA1pvNTrGiQRUVfmtcZ?=
 =?us-ascii?Q?g1KKXBwEneIjK3sZNZQoOH/VxRqamRgqWVZ8NeUxnbKFfHqpgYFbVuriSObg?=
 =?us-ascii?Q?p81bekmVZ/RI0Wdu125Q2cOFzDG3zW2bPoAgPo0Yp29vGh+aU3QBDjxO7xrr?=
 =?us-ascii?Q?Me0X0e16kfy+yhLVD91oUeKobKlC8F71+9WNxN/9Vi1yikisQ5rl6W9UUpj/?=
 =?us-ascii?Q?fk3eLqRprfd8M0CK3AO13aKYFEM7AgKUpS1wVnfcsN7hju6B+FXZh1ka/nvJ?=
 =?us-ascii?Q?bWP79CgUChp6BTQ9yrkwCi59CwxZkL4JH/XYvHaNR63ntnzakoAO6e4RWnnJ?=
 =?us-ascii?Q?SbuNB6kh61iLoDFPGA/Hqs0GskMsYfWJ+ZSQ5QBGzrn7GbIZiwRHA3OH7OBH?=
 =?us-ascii?Q?VAHNCWCAj8FgNnVKapjOuaMkd+wQCkmGSEh9lGuYA5BvqUGmaGaADbxFVyZL?=
 =?us-ascii?Q?B522gTApB1TFj7v12LehezNhfiXFxV5EFTOgf7q1B3dQOB776laGex44Q1Y3?=
 =?us-ascii?Q?xnVa9TfJf8FK7Mr/s/JVhKCrzOnWNiOx8DNJjHEtDFpsCU4idbB/4DQiXtS+?=
 =?us-ascii?Q?dhLHEXyExzyUZFdIM4dQcDBy75y+SrgF5s7tXc3ldBG7Ej+r7ymBecvzIQm1?=
 =?us-ascii?Q?cc1MJeSTm/HMIePYXxnxzVDJt2dvy3v1QdWzLDbW0JvQsTyULvnFYNI6nllR?=
 =?us-ascii?Q?YmwWH1ZEA8yeyR5uBHgv9ax1JgscWavLESnR6Zgg2gZqfDfhpd3JE8FC8QJD?=
 =?us-ascii?Q?BZSJa1oyaThFEGONWpl61skqaN75NSYeKCzOOOlKugLtc2Sa7zZb4sb4FWje?=
 =?us-ascii?Q?jWnFQ4sJBjusuFom2q7+Uo04uVIimZ//iGYXN+L37rORybECH9NqymoeO1sn?=
 =?us-ascii?Q?11it8R3+MlgcmH/vPrxbrVJOqkOL1kD6M8GJ3imkl+u6jjOYxDEvr9qIsTwS?=
 =?us-ascii?Q?9EkEoPjbLDwHSh/D5KbOPWUJZoSrGJo+HW3M+MRp33b2ZMx02CIHDO6lI94/?=
 =?us-ascii?Q?rI6qgvc2O2vlCC7j3DmUxq4N4SM/fPFChbqWLB+UK3TqkYK2EP6ZVHtUrDCh?=
 =?us-ascii?Q?WXLWbDpnD06BzDT3iRpOToDbKJU9zG3sSLAEhMnGpPqLz2Pa8BAAywuK0JSu?=
 =?us-ascii?Q?woLtfnFoC0kns8J13hPyjdrZZ3WDZSDNKlqInqr2Dn/jI+OVbcBL5sNM9S14?=
 =?us-ascii?Q?l3E4pJeOSNZKhIoSZ8k11/yT2LtaOvX0htL1Mv1VGjnCvWQDnOJ1IOw99fmS?=
 =?us-ascii?Q?9BZscdZVlp7Cmo4ZIu+biDECuj71BHq/cwErQP88wWkXUF/PurUgAsuB+7Wb?=
 =?us-ascii?Q?7yH8xWEntI9SVZVgeAaNgLBZq3//S2nHMJxe4F7krJ4qrtfv1qATRJ7z/Ggt?=
 =?us-ascii?Q?0R4ahYwpK1tJuhU+UkFZS86ihjl521mktcJ3eqvN1P+2658CcmiLcGwTt8fF?=
 =?us-ascii?Q?ZNO7fMNMOxePsgClCPzS5sT9X/g8ZLScnweaLP0xvWy8M9uEbiSoixbg/GbU?=
 =?us-ascii?Q?1rLiPy5sc6bneuDQfYuv4CsdM7lrScJV0YyGDITmfuq3GLhR9kj1e5+sbLDz?=
 =?us-ascii?Q?EnnQfJg4xQBLcT3COR5AJhY/GICC6pCELGfO99fC+YjBU6xKl9TqQYb2t/ii?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c979d345-00c9-4eb9-cead-08dd01f5eb50
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:09:48.3976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25VYLPIxwy4U57hCShKN6XAst5DVPEG2VbJBT1IYLZpA1XsGY3dl5VXIcMZld4iaQ2/Nd10onew80tAK7US3b+beOhDuf4CG9bSglmCskVo=
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

