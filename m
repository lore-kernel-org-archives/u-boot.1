Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE23D60D0B
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 02:09:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 309AC89484;
	Tue, 19 Nov 2024 03:08:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF0948926F; Tue, 19 Nov 2024 03:06:01 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20711.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::711])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0DE789442
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 03:05:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+2lHgaWSfA8oVw8JZYYiR8d2lpfjiMSNBuzporyrziZraFQ0fPzjeLEpRjbEzWrdg2asGnb8beSM0ZqamrHpjj8kb/IkRpm0iFvccOn0v2oiyzvfEenxSJlVcPK0nG9a74Vvvma6zxs1qQVydir832kccjrC2w05iw5Nep+tQX59MhfwyEXyE757B0v/V5JDSqmml5F48Vz2ktSludGiV8NS46l/Wlx9sqNli4oUrCzFdZuH1kZ5orVfNyY7aeE3E3We/KnrKRRemcqvtPntRalEEPUSHzoOavQQvutS9yrGKZ0XzT/pf8Haag6sMiMrrtkIfYkR+sRY7f8vPfu/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8m0CEZEOvzaqfXNChygsnyHBXGVL+Shx2XX9Pp2obZY=;
 b=CfDGfw+L+ObdKHmIdtwe9J7VlTYTl+ZyoqSjao6RFaWIQANdstJkXVOg0UahKx9xIAEZo+rHE03IHsxvKuEPBJlAI7L9SdUEgOtNJ56mZoX9ZNJCR5iuXIxFKMBZ5bcYfa/mGC0ciOFS9tBqsBKlR7Gc5pliUWIcQMZPc6wt4aQRX2edNxSy4fpsjlg/wF7SsySmFOaDqt2tkuYsSQHVa4D+HwwkE6aLzk4o62sfKagPPKk3Heb+DLX3KuxKMmQm12B+ycURTEhFFaYB21LzGL4NUtVv7aKrYikapnNieUWVj8Q063HCDNAIqzByUGOgB8gCT8aHHkRkmbd4TYao3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1292.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 02:06:05 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 02:06:05 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v5 04/11] riscv: dts: jh7110: Move common code to the new
 jh7110-common-u-boot.dtsi
Date: Tue, 19 Nov 2024 10:04:18 +0800
Message-ID: <20241119020425.51989-5-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241119020425.51989-1-hal.feng@starfivetech.com>
References: <20241119020425.51989-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::21) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1292:EE_
X-MS-Office365-Filtering-Correlation-Id: 68bbebd9-a5ea-408e-5138-08dd083eb98c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|41320700013|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info: S/7prslXp3gSWGBuWkcknFafSE0J2l+WFjbWqI0VoDLy1st6zz7FOmmOnkG2XOeEDtVJb3zvjcECV+BbX8Yc7SYsKT1lNzhq8290lnXotrarJviea4CqaifnLsd7WeOepgXRPz/j5fRXAHLC/o8kiXY/oPQqn2BvAo63iFDiCyFe5683HvjHnpljdL5GLWM8t1c3StclrE6otO3s0c0Q+SdjGpkajHE+J83ZXsR/Iv1sMcNTUATWQuy6KCaxzAmojEe8PpKh5s59c1IY30zqklANB2n8CUgSl6OTva0uUjs6f+lDARVm0ErUB+UOF2cqNy2Q7qDj1Y0KqoD8uMX8dTiFWdDWm+AFyjhwdEgHzx/+t8BwZWgttqK27EgZ4z/4a80vHtnx54hecjXPtORcsIhA6PLvV42oyxo+JMaHCwPiVdWXq6EJlthRgqnnOa13X3NMNNtamFQdEd6qaX41PpGnltQk4x8Utj9NytBCbkadLDvw0C6PCQv6xRcjJ8cAMOJgUNjS2YxBSUr6h3DeUFgRX2YPjOWBJlZzRtiOrsMA0uZPfqud9f44ncw9+Y7DFKntUH3Al834X8n5b9ECYU1DKZP61tlvvnKdj7oWL7lBRKfZQajJjSGE5VnAF2Q1BiCUi1tWAtvNUWsPV0g4RQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(41320700013)(52116014)(7416014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1o1RNHcmnrhPmjf3M8jpZVncxtOIXPo4NRuN9OtGLzjeuqAM/2hIv2oL+cQ4?=
 =?us-ascii?Q?uJNNvhVa71MSg4gERvyQd8+eJ3+35T8wUasQ7grvQ+KUgChg94VR+KB0VhAr?=
 =?us-ascii?Q?h5uzbEZrBDCviWG8uUKcWGJ8o6aJg+wuH7s6m8hFb1d0UAUMCwwhvxGDGksy?=
 =?us-ascii?Q?IXByZMWHYFBfru4IUqUfdjZpbn+/oC83MaNWgqtcGS/q34/AtzHHSaydWwP8?=
 =?us-ascii?Q?t2gzDugmPwFqqm8uuEN0Evla+wlyd+pMGwthYxL704iTeFo9URxh5QkePH58?=
 =?us-ascii?Q?4dMys2UxG6ldjMBQNWJuDqDMGQkxbbDkAE+hzvF+kveG8xfrbGPiDAvDDQXa?=
 =?us-ascii?Q?N1KvfDr1ludBkeY3m83do1qgIcozljepzQfqHdsXMKKIf6qha1ngcC3gxh1P?=
 =?us-ascii?Q?upz6xuJoRfGHCQRNSiXO4FSyCHGO5KS7rX7FtDw6PeW1PXokvjryp5tWCNtm?=
 =?us-ascii?Q?YCH0GJ6Kev55qlxkP+FYo3FNvA6Eibs/JJo+TJyeNp9RGUDC2gZI9LgKVvfj?=
 =?us-ascii?Q?muTRiEKrAMA7hyBRn1lhJDBohwAuQVvqBCuxEE2f4H8HCEAbxyEt7xWuU6vD?=
 =?us-ascii?Q?C3GaX3zQ3hUBW3ZP75t/kEiOXjaltRNJFyLo01JVOa5RT8NX5A0KwZ7x5Pn5?=
 =?us-ascii?Q?mR8us7vAhnvTlgWnBFiHGks7d65Sj97yxpQ6kkHfcyGB43LhLA6RP287BjPm?=
 =?us-ascii?Q?Gzjwl/4I0OZ3jPhNUCkCMMaJ3j4IPVMNwkvIWDeQgZ0DLa1uMa7b5n/iByDc?=
 =?us-ascii?Q?YNv+Szr6Nh31nI/QopILcMJ0pzdoi0ULCW9YqpHFhUEV3wZa9gMjgGxbfgDp?=
 =?us-ascii?Q?YhCAu+arMbDA6x6gc0s1AbSXYq71Dy9CNNYVDmqR/o7u5adzDGpEgp+nTPkd?=
 =?us-ascii?Q?G3hOIxMKV7WzabYT8aSGtWLWYg1GGBvVR9Z8PF1gkSpmMPeZhhlbZ5CkGL4N?=
 =?us-ascii?Q?+i7gOcirycLv2N/sWtjdPNdB2417F+voWKqK4/AKhNhXSMf+N+6IlFMsFsDI?=
 =?us-ascii?Q?v1vCgoWnarZ506HkassUePb8CXbo8o5IFbMZde39Lyuedh2aro7Y4AxSTtH/?=
 =?us-ascii?Q?2nHt4imyPPt0nO8g5Lv2pNxWkzBJcfxW6FYOEaxP4rdBLTVFfoDT9aVJC0JK?=
 =?us-ascii?Q?pcFEcQQGCiP2lYvd9HDx2JX+JzVE6K+QtK6jF2bne842l2G0DXPp321NyNTn?=
 =?us-ascii?Q?tOOiZjgugwi4wA1AqIpZ4TXud2MIUrQWFA5NdFuCLthYlCd90+R0bs7F66KB?=
 =?us-ascii?Q?3HM4DRVmtqra7XbbiG0ATWlZsUrThVeYwHVYZFFPKY/buzZARGpgFjI2kMtZ?=
 =?us-ascii?Q?nX8sgEx7+fcrY3lv/t8row5eZ8mAt1hT/IVhZH4IvHwECpP21Gj6PV8I86kA?=
 =?us-ascii?Q?2NeSzVOGDGB/xi1YyZypj7wwwBgAOGUZqkYs/fwrsR1gHSAsIsUgbqh3xf5/?=
 =?us-ascii?Q?nenfcu2Dr3lQy/Q4iAkQWFHEPhhgsA7F9PhUVEptsEuS2TUFeuAa/cwzLhQ2?=
 =?us-ascii?Q?MeILVz2are/wFFc0rAPnHLYBsDRs+hemaRQFfvJEm9ptXIfGeoebGMm836Ho?=
 =?us-ascii?Q?GM5q20nZN+HyHFTEr6mEtX1PRWPKG5Arp0umSk5cnm9BOk76MAoofQw9jMrh?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bbebd9-a5ea-408e-5138-08dd083eb98c
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 02:06:05.1662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Umvv4eHfCvVP7Y1dm0qUF51L4KcDIuwuCQFdxK5gVOg7vc/EYowVjPiBo8QkgLNSQ7CQDpyLnlLzclKs6gJV+J42ZkIIDuS1zSW32hFMoOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1292
X-Mailman-Approved-At: Tue, 19 Nov 2024 03:08:50 +0100
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
index fac9e16fb1..f4807957ae 100644
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
@@ -53,100 +12,3 @@
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

