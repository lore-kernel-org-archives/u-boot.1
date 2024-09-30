Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C976ECE835D
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 17:04:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C745F88FE8;
	Mon, 30 Sep 2024 19:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFF6A88F94; Mon, 30 Sep 2024 18:33:47 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2112.outbound.protection.partner.outlook.cn
 [139.219.146.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ACCD88D08
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 18:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTV27vffJFpiaC5DFjxyEwI0PkZgRb1mSHeA2xL65X9Z/BKbaqyyd1YCc/09kNevpBTm3MPgnpUZbnPURJpMBapR4OWEg9yY9aRqzdwL/O4fWHESjBAMmmx1jRtLDr8pPQzAsocznw0uoVHYnsXenyHDWHLZixlEcfa9qAi7QMy1cd6+sKTxagKMGEcZcEa3EEdmmAKvJP54nMrQix/L61u29xroA4eb780Mmglrnav88HA3fMrm0b7WjtzqWpQZBeX+tpIzwBwObnrne2+peNk46+lPxw4GKt6Ypyrj7ErnVwH9ri21Luhbjh/Uk/wMiqi1LFznNiWAOwjf3iCcmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhNSw0Hr0EE7L6fRJW7oyWQzgeU86yx9r6IQmtJoLxI=;
 b=EZphGMI2l9jGnRFiPIOm49o1bNuNsfYjEaujQkoHcsTaeclgYn4aemHtmfWbotAN/ZWqU85ICE4Eai6jLY9kfinttExsa/cRafhrXk2JmJsAtdrbe8kleglYgsvzXS6yUZePvSr4I/qnQnoKhFFwOEDjo78tlGiWijEWuXypLe1xtWU4EO1f7TtGTzvE+ARmU3cde+9yed4LFrTVx7Ty3CVI/yt6ZZ5ykZpvUpm/JHoAuydA7kvylunRkqGLYfRkwJq+9t6t5Auu19pgSBb5TDWFlWuAQ3QrmfDnB/aaeVisJ/SYg4c72qWOD8jNOi4fwHBYdsmBIb6XCoXDeC89bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1243.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 15:59:36 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 15:59:36 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v1 08/12] riscv: dts: jh7110: Move common code to the new
 jh7110-common-u-boot.dtsi
Date: Mon, 30 Sep 2024 23:59:15 +0800
Message-ID: <20240930155919.111738-9-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 35cf5113-ec0a-4a67-0d5a-08dce168e1da
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|41320700013|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: xpHQ1jieAYwC+3ddYXx34MoxaggOwd1ku++2uh3YFIgQr6tVTzQiIwZ6Wf7H4gdhJ585thzIUg2wFBq5bNwOFOaPQVaL5t9Fj8A2pRdFf3PU6nNKvS0i5nMcmGt9HFOmgQFPhYlEV1xuBDZl/eYDUsY6OzI2CI6+EAbE4XLUzQOreM2LC2bfVOlelh2g+fu7kUvzaIOQGKde3D/lgUAAslU7xvaCidiiRL/Ga418I4xPUVhFB/3iZkRdqVDzaoUXgnqPdgzY0x1gGUYrrEukedAROEdIFRaCHCcIuLK0sNip2KDNHVCU1C4GTtoMB7+yJsCQ3igmVn5DWaD8xiD+Dx3SZaaC6aZiPaLrjn4Kwty/iQOlSspduwJrIsDlsky1L9UfFEiQAgWBCPrm0fMEXQ12RXb1lgIcvdHoBgNIP8JHWbDnwOsKbDasrXauWGJAKJU+hxZPZG9K9zMeQN9AwUqJgdA9pCTRfN86vmA5SxJtXhdMNJiRMh6NpjxmakgrmThm088HuSHdYTU7BD6wOUzy9L5FKZDYfBDE37RweY8CmJCsOmi+oINjsawf5ai4Fbns5FpIGxlpHu/CKMuQ5r74/gZ/8auXCv/461vukMsk1202LoKOuFWGyrrC01pf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(41320700013)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5PudXT4D0M49Z/Ld94C0onbSIHmYyhXTKPStQICHU7y4rZsP33WpZYMdUjMA?=
 =?us-ascii?Q?ye6mKGCjb7H/pCo2IEIIioPYyHPRmV2iht4ICqJJ9+27J7nDQSub0H4PWU7t?=
 =?us-ascii?Q?OTaXdKecW+9tvDPS3ZcJNrDYsh/cXoAMRN31egTwnjdThCRFcvyjb10mvktI?=
 =?us-ascii?Q?gYaZMqn8ORaj2si1anHM1uDcruOssPRRAWOR2Zbg1sxegsKfj0yEo1iQmuTm?=
 =?us-ascii?Q?CgxXMc6NomsG77yUJ1/g8nSteWbRCE9AeYxBP8HNr6y4O1lg0fmaAdMkCIwA?=
 =?us-ascii?Q?XGvFGpy2r17DcLOAL4KO5RtoD/ikXHIfH/ZWMz7Uq2BWoxYFQSyOi5XdoCZY?=
 =?us-ascii?Q?gSUJWCFFPeImbmgMF77ZioldYlL0zPOmNbUazzqLA/+LMA3smJYl8PT+FyGS?=
 =?us-ascii?Q?H9IQWwMN/4b8o6AJY7Y7lXIDNB9GxDr8vCdrll+yLEw27D+ayRqY08N0yKDr?=
 =?us-ascii?Q?FY6uTjPyft4DYZX7j1H0eK/QgYMgiLAEoaKhey5EcqcF7phEKhk8F8YItCLL?=
 =?us-ascii?Q?FwynoVElHaWJ5eyC2tN594S4QrdeEnYbk/8ROo+8btuVsmpwHdjKB0a3DKfj?=
 =?us-ascii?Q?2p79uysRI5l4lG3cqoylL8jI0CnhBbRNrvaVE06hopO17obTdeKRQJKWiJI0?=
 =?us-ascii?Q?BXxx4dMv3eseFfq9CM2WYKYQXREWMEReNEgAfosO6sFk8guPMH38ynhox14O?=
 =?us-ascii?Q?7t4DOOmHddh9PR/+cNyffXjedGvb/GbwNawKuH5sENeiikrmfTYbZ9H3CAbb?=
 =?us-ascii?Q?DynL/ORucwW5Rf2FBqzh29PouGP45R19c6q6Ajv/9FDXoYmPKYTIhYswn9j0?=
 =?us-ascii?Q?27ZMeu6JeBCo3IJoGEPw+k7dbMWJ6i6vfI7ORoSGQGiQ3BbasLbLExUeuCnU?=
 =?us-ascii?Q?X/QmgrC9Dmx+SD9CGIn6l0Xb38B6bH/R/YhyDQX7IPkqYfeIOD1XklOPD+1M?=
 =?us-ascii?Q?m8LBPyL/pjKVt+sUIcxkSOWJOSU5/W2AQKnFj6qkLcYj29XE/Ah7bYoz9kNS?=
 =?us-ascii?Q?ObDfmnFEMie6tIKVQ/gzzZIOPKXYxCJYsZvFxlxxaCIGIPGYTJKY54j9Z5QU?=
 =?us-ascii?Q?vmBHteG1B5MOz3YNq6i8oR8oeUPwbzEr7mip3HTgQx9zInzsLWA+X8Fr5GOK?=
 =?us-ascii?Q?uHYowQ5+gel1Jf3zt89otDDWqM7TLShM306EhmEazvHctZnJT7N0UweNGUOb?=
 =?us-ascii?Q?iMLBeFVJiw1JSxiGL/p1Wac8aPTW3aXLaQVSWRo+TVjObLYVgydCCQNroSRc?=
 =?us-ascii?Q?bQzTCfqcWWsCbYCXhQhFqZrlGlkxGntesSpM6R2UZcx0HJfaDhedFzg+L9es?=
 =?us-ascii?Q?mPUzJpvUxNrFyly7tbIvlstlfwvTDWMs4REBFO2q2UdID+ZkpkoSku9OhrJ3?=
 =?us-ascii?Q?bVS/PWFzJXTOypT4oJBPFNacXjrduc1Ali8QCVAfj6IaivtB9mxZpKvRDQRn?=
 =?us-ascii?Q?pF4tRkUqmyomSXs0eUEuiVx9sycNdcseQGkTAIitQvpFPpfrFBCy6uv/NU1D?=
 =?us-ascii?Q?CtTbVHDSiVCXz6Td3frGcQu9LOHXL7XhohtSWkhe6wFp3ttcdUQtjlAAysse?=
 =?us-ascii?Q?46jwvfPcICCEINx0jJii5Oc6/KO1tep/bBJw+rgjqhJldlYEpKCB/lrYYueh?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cf5113-ec0a-4a67-0d5a-08dce168e1da
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:59:36.3131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RFmskCUZQ4eMISxnrBCsExT+szLBM905hHyd2scv12UXwjVgKvhMWTlHihvXrU1OFlEsNDIDwjDXZjJ1yZjIydavQ6Dzn0gUVvsjXDMsKe4=
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

