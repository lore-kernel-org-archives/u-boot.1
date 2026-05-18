Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EC1CD4F56
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 23:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBBCF847AF;
	Tue, 19 May 2026 01:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="DlZOo4EK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7385B84707; Tue, 19 May 2026 01:51:39 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FD0D846E9
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 01:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtVfmKn/eAHr/qj8NIQRBbGbHgOpJaiQxsMjW9cKvHPjytVEI72GBz2iHz5JYi0FUzh/3/vO3yDEXC+q1bHy0rLnEiryVtW/0ZGVtNJjbFxdvoF+7P+zdQvmUWfCHZRwGIxE0WkoLryNg9tm6/K9I2wcrX87DjyC2FSTwTq7Bxvv/hHvjRKV4J4tCWDokoL3SGT415WOwXkDSEzo9q9hR4dK1kNwo7s74d8T3UJlr3umb41sliyFUB0aRy36fm6fy7fr9pGzi201m2diuC053YLtwsb/bVAeB9y1GCfDbBrb8AykGELt3P09xRE/m4be5pHr+EHIoqxE+KsgdLI3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXfxKgE0OhxzU7hoXu2Iy9SKnV4W0tMYKVlXNfYnvQo=;
 b=cy9GAya9x7/LECiH/NrhGLMnlYbNk+Huhr+a4dgkltYIwGrOCw4GC8O4s/Uf/FjYqqC1iR/ox4IadWkypMdAgxc/ElOiuR+gnru+MyYeDRgv+Ks9sco3115zgFQUArk3XRdAIi2FJMh8KNBt48fyM+mLJ8K82nOB6RBa4bNDQHsd7IVyxoHgUt7A7K3so9CPFeBoO8rWfugR9I/SNZACP0VgN1LUO/yF7L4InEro/1rgDvpK52qx3By4cxB9jjkyykpig/3bEs3Sc0zXAJwYIZDN4DIeMMWEVjfIVWuHwxndfEDlid3PBrQpTx6d4ZV3r2+tK2wnzpeBOyHe+/yWVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXfxKgE0OhxzU7hoXu2Iy9SKnV4W0tMYKVlXNfYnvQo=;
 b=DlZOo4EKxIKfGc2hbwaXSV5krDXPIH15/fTvk0KonFJym8k6/M5e6ZO2+ZlYV5NAFpFQAwdkAiwXq4nn7WHkq/exJySb51fyM8N/1h4hFOa2TkCCeS/CAE9dKD94S2MFAOe5nPLCnesYg5HLZDuDlpz2jgL+adHaEBSfu7DDk1j0pz8UqVSYom1aaxWMr3Uj3Q65ovyfNzOY4OGjIZPiIPZZPfRG+wOo6BZBRwA/Dt7d5KXnsUf5ZI4edUwYZoYZM/o/K+ntpfLGp0vCb6keWjKDYb1Sx4s2aFss0oO9/jebao+r+jB5V622QB2WFqd4BxsomKOxGu0+ort1/9CuZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DB9PR08MB7794.eurprd08.prod.outlook.com (2603:10a6:10:399::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 23:51:34 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 23:51:34 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Dan Carpenter <dan.carpenter@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Anis Chali <chalianis1@gmail.com>, Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Richard Genoud <richard.genoud@bootlin.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v8 06/12] pinctrl: airoha: add shared pinctrl code
Date: Tue, 19 May 2026 02:51:09 +0300
Message-ID: <20260518235116.2664557-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518235116.2664557-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260518235116.2664557-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::6) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DB9PR08MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: b50f3e71-bebb-4060-99c1-08deb538647f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|52116014|22082099003|18002099003|56012099003|38350700014|921020|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: CzKXAMyEEwCAGsY6uAhNTM0pDTcPrh6GhAO2+xM4o5vfTReGSQGE8AEKqXtxEq98B2sjkfjbOrYlJvGs6ZGpBQgdlFViAH8NDVTg8s3HqHwYKpk1i2yl8rhlzki4ZMWly62rv//GxWZ/wNK/tWteEesn5SQYOVs6DC6oz9ap9eXJGFO0bEr91JuuRc7aVyKO8lqsnPDHP1mqTPwLjQANMf8jaPJivP9juFWcQ8nbyzWSCcDYyA5Xwbf8VCNYK/T7dsDSlBHVixSg8JcOdRiIMOHa0l/26pzD34jlyi4Q4jNceBI3eKiP2Vk+3vZ6G1Lhw4PxtJUelOGvFJmRqNEj/SSSnR0R7WrUYJL0ekqOBE0uo8ukCX5qvQ5QF/CinZucTEBYEXMzVGjegq5uej1ML984WjHds04SRJiNeWPww5vao6w5Xb59A/kJvtZ7NSuwzZrbexBG2+D/71K+/t+I3KeMWmMuYAf+0ZoUtrXFcDdDEWjWdDE1edmEHJIuE6MKI1B7ICfyT1xAjVF9Hkws5QCSheqdJBliznco7Bo7xwSITUT4Qmx+dv+08Dh0O7ark65sJCbKyCvyRiIJH1yT7kXoNRGio/2uZW2CiLOaPW6NwqDlnvtoDUI7W/MHjfR3cRxUN4WLN88lSlrBExf2SkI33+uHYAcybfmr9wGRwFmf2DwYU/fyDcfBYNr2EChtMgBwWQizFC3gmDJBVIZnNxVfnsXS7zwkdY7W15iH3vq2vr2VtlV2SYoPlU2OQURKJ+77IIMVY37tG2/nG3W6XA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014)(921020)(3023799003)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?38lUD0hqPeVccgBZYqdNO4radNrenABAjZ0BUxHHMg547Ch1BjQb19N3DKSp?=
 =?us-ascii?Q?nZNoZndz5nratzW2IEDsTf4fBdlz2NPn4HQJTkB0xsNjk07/rdGMEuA9PFmK?=
 =?us-ascii?Q?4jhFKAPBolu/bwmRVPGMA58J/TooWELNkVwIIGMXDuSpQJKTiQ4l5heXU+Fb?=
 =?us-ascii?Q?GLppFJ962r1bntUxOOQvMwOqeXES19UWcHBXLYfIpPRUlKE2WvyfQBK6fY5H?=
 =?us-ascii?Q?foeioGFj94EXHHjZf6g9zXQiC3esCCK+KzpdQXUw+wjH9EQVUca4XNiDoBjc?=
 =?us-ascii?Q?7da0uFvqUsQt0Hm3JFLORWh4RjWFd61KO3XRla36LlhDuDvdwe8ZLNByeh90?=
 =?us-ascii?Q?gmkHRZaYvAx5oiMCVjiRcPe/xXWpFbwYTeYa6KPYV3JseljWKVy5WZaR6lh1?=
 =?us-ascii?Q?TFD6zNyhZi/9F7EmUN/vdW4mm0GIwxUXA7CqVFfvC0Pv0x1GQVIBy7yT0DHu?=
 =?us-ascii?Q?zo3oK/umGgzMa+e5kJe2dtLO4LJwuoNEbuaOGZeBrYhiS2NjTqXRpC/6Nuuj?=
 =?us-ascii?Q?7DpTfhMaAoedzQBqiNQPOic+fcbI7WI2OLijvGUvGmPTAFCHFNWE93MFbaTq?=
 =?us-ascii?Q?q/sxsZw6iMpB7WzKrOJi+MHnDDOMHWS3iwNjnP6VUCQ3BokPEp+B6GdOtFcj?=
 =?us-ascii?Q?YB49PgJc/1M3IUMBVRrdifhXyCj6KIeLc9ec1oJC9LiGE3K6ofYBcVk8XiyM?=
 =?us-ascii?Q?MGo9WNFF06cz41HcbGTWHoS5nGNSFs2TxYTL0qxEYzfAWVz8AU6WLJSKrarE?=
 =?us-ascii?Q?I1QP4hQniWrXDfjGE83e1uFVA/VuNaITDpgKmeCD+JDdRxnj9S/sCv2UXuTv?=
 =?us-ascii?Q?dX7gl1Nelewt3MOhWeGxWzW8CSv5r0IrBiixn2JiUVjyViu2+Ykh1fPXXDT/?=
 =?us-ascii?Q?zy1GO49PEPAYimthVbTSQOxJIuoQ8L8kHtjliEO3h6hzPoGGIRIvWIkulwtH?=
 =?us-ascii?Q?3OXQCUqSHKnxf9ZoeLvrNg139HKrxZFd7ClB+Djw/6+Au4sqqvDk7tdQSxSs?=
 =?us-ascii?Q?913QmKDMOn/y8itWlQTB1fuJsnb/2KVFBGmEdCc2pPHAH83XXMiY1Liq5Dx8?=
 =?us-ascii?Q?JbSJAuXWCmO1mWNN+nv5mUMMXcnoJEvxTMnt/MLSqIJ7wFqZ31fPPBsbDvl5?=
 =?us-ascii?Q?EQ3A/PfmzWiwLSnSEi23uoUsRxs4KTOxftUvOlJ5C4dGhOrasF3U6lnsad2t?=
 =?us-ascii?Q?9UOf+7nB7/SHUT6NRCCMq0YwnqKo8dL4A+fPtnf9qzGqDSreDSA9LEkwvsP/?=
 =?us-ascii?Q?FKrZmFr1FbErxDMqZ1SQOLgUKyBfJS97JLqMSahCbsxTr/sQCqfcEoF6ltlG?=
 =?us-ascii?Q?mVZB2gbaJl8YcZwU27je5yAl7e9S7YeCr/SYO2AEMC93eSBPFFc9cyqMIUWV?=
 =?us-ascii?Q?DYXckUvWOtP0LvaN+HhSNdHeZ3XONUh2BaNYWFF+VEKgDmUPVHK8XjuzStYn?=
 =?us-ascii?Q?t5me2aICZnfrc3k643XwciGVSEw4bmtOmMHiBlJQMRrblgNJ+ciCBlIBdYFP?=
 =?us-ascii?Q?n5+cwSeRKAhYmlMHrsZyHwN+2Ex/yyCUbVjswO8en9Tr2uB+NxEoNS4BxCDT?=
 =?us-ascii?Q?wGFeQaVhWjMy0LTUZ0ec2qMvxZ5FrdtjhOJncmwswezyBMxuhGlvL87SawzZ?=
 =?us-ascii?Q?iUwCatUd3eK3ZS3QFhjS97Tf5FlgYTaPmMW2xrBY2MOo4CdjeemyNnMw1Xht?=
 =?us-ascii?Q?vk1DLeHJ8PfS+jleleGex1N6aHpsVbffhtU6mEuQsvB+mzQz1kbDhzo8hbF2?=
 =?us-ascii?Q?YX/QCvtKYzYn1qCIlwu+G3HE9FcjifA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b50f3e71-bebb-4060-99c1-08deb538647f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 23:51:34.3663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0L456smVGOnmXB2iSptP/8ZLIglT44vmldkiwx4RPVDXlEh4loZPc3csvRtQjY++7TmNZu0nXnoVc9K/Yg6MfJNrWfsfblgSi1rDDNZMPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7794
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

This patch introduce shared Airoha pinctrl code.
Also it sorts contents of pinctrl makefile.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/Kconfig                 |   1 +
 drivers/pinctrl/Makefile                |   1 +
 drivers/pinctrl/airoha/Kconfig          |  11 +
 drivers/pinctrl/airoha/Makefile         |   3 +
 drivers/pinctrl/airoha/airoha-common.h  | 476 ++++++++++++
 drivers/pinctrl/airoha/pinctrl-airoha.c | 927 ++++++++++++++++++++++++
 6 files changed, 1419 insertions(+)
 create mode 100644 drivers/pinctrl/airoha/Kconfig
 create mode 100644 drivers/pinctrl/airoha/Makefile
 create mode 100644 drivers/pinctrl/airoha/airoha-common.h
 create mode 100644 drivers/pinctrl/airoha/pinctrl-airoha.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 578edbf8168..46a95a1ab6b 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -405,6 +405,7 @@ config SPL_PINCTRL_ZYNQMP
 
 endif
 
+source "drivers/pinctrl/airoha/Kconfig"
 source "drivers/pinctrl/broadcom/Kconfig"
 source "drivers/pinctrl/exynos/Kconfig"
 source "drivers/pinctrl/intel/Kconfig"
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index df52c6db8c2..6c6e8b59122 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_ARCH_NPCM)			+= nuvoton/
 obj-$(CONFIG_ARCH_RENESAS)		+= renesas/
 
 obj-$(CONFIG_PINCTRL_ADI)		+= pinctrl-adi-adsp.o
+obj-$(CONFIG_PINCTRL_AIROHA)		+= airoha/
 obj-$(CONFIG_PINCTRL_APPLE)		+= pinctrl-apple.o
 obj-$(CONFIG_PINCTRL_AT91)		+= pinctrl-at91.o
 obj-$(CONFIG_PINCTRL_AT91PIO4)		+= pinctrl-at91-pio4.o
diff --git a/drivers/pinctrl/airoha/Kconfig b/drivers/pinctrl/airoha/Kconfig
new file mode 100644
index 00000000000..eb87afbb374
--- /dev/null
+++ b/drivers/pinctrl/airoha/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config PINCTRL_AIROHA
+	depends on ARCH_AIROHA
+	select PINCTRL_FULL
+	select PINCTRL_GENERIC
+	select PINMUX
+	select PINCONF
+	select REGMAP
+	select SYSCON
+	bool
diff --git a/drivers/pinctrl/airoha/Makefile b/drivers/pinctrl/airoha/Makefile
new file mode 100644
index 00000000000..a25b744dd7a
--- /dev/null
+++ b/drivers/pinctrl/airoha/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_PINCTRL_AIROHA)		+= pinctrl-airoha.o
diff --git a/drivers/pinctrl/airoha/airoha-common.h b/drivers/pinctrl/airoha/airoha-common.h
new file mode 100644
index 00000000000..1b3b5281aac
--- /dev/null
+++ b/drivers/pinctrl/airoha/airoha-common.h
@@ -0,0 +1,476 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __AIROHA_COMMON_HEADER__
+#define __AIROHA_COMMON_HEADER__
+
+#include <linux/types.h>
+#include <linux/bitops.h>
+#include <linux/bitfield.h>
+#include <linux/pinctrl/pinctrl.h>
+
+#include <dm/device.h>
+#include <dm/pinctrl.h>
+
+#define PINCTRL_PIN_GROUP(id, table)					\
+	PINCTRL_PINGROUP(id, table##_pins, ARRAY_SIZE(table##_pins))
+
+#define PINCTRL_FUNC_DESC(id, table)					\
+	{								\
+		.desc = PINCTRL_PINFUNCTION(id, table##_groups,	\
+					    ARRAY_SIZE(table##_groups)),\
+		.groups = table##_func_group,				\
+		.group_size = ARRAY_SIZE(table##_func_group),		\
+	}
+
+#define PINCTRL_CONF_DESC(p, offset, mask)				\
+	{								\
+		.pin = p,						\
+		.reg = { offset, mask },				\
+	}
+
+/* MUX */
+#define AN7581_REG_GPIO_2ND_I2C_MODE	0x0214
+#define EN7523_REG_GPIO_2ND_I2C_MODE	0x0210
+#define GPIO_MDC_IO_MASTER_MODE_MODE	BIT(14)
+#define GPIO_I2C_MASTER_MODE_MODE	BIT(13)
+#define GPIO_I2S_MODE_MASK		BIT(12)
+#define GPIO_I2C_SLAVE_MODE_MODE	BIT(11)
+#define GPIO_LAN3_LED1_MODE_MASK	BIT(10)
+#define GPIO_LAN3_LED0_MODE_MASK	BIT(9)
+#define GPIO_LAN2_LED1_MODE_MASK	BIT(8)
+#define GPIO_LAN2_LED0_MODE_MASK	BIT(7)
+#define GPIO_LAN1_LED1_MODE_MASK	BIT(6)
+#define GPIO_LAN1_LED0_MODE_MASK	BIT(5)
+#define GPIO_LAN0_LED1_MODE_MASK	BIT(4)
+#define GPIO_LAN0_LED0_MODE_MASK	BIT(3)
+#define PON_TOD_1PPS_MODE_MASK		BIT(2)
+#define GSW_TOD_1PPS_MODE_MASK		BIT(1)
+#define GPIO_2ND_I2C_MODE_MASK		BIT(0)
+#define NPU_UART_MODE_MASK		BIT(2)
+
+#define REG_GPIO_SPI_CS1_MODE		0x0218
+#define EN7523_REG_GPIO_SPI_CS1_MODE	0x0214
+
+#define GPIO_PCM_SPI_CS4_MODE_MASK		BIT(21)
+#define GPIO_PCM_SPI_CS3_MODE_MASK		BIT(20)
+#define GPIO_PCM_SPI_CS2_MODE_P156_MASK		BIT(19)
+#define GPIO_PCM_SPI_CS2_MODE_P128_MASK		BIT(18)
+#define AN7583_GPIO_PCM_SPI_CS2_MODE_MASK	BIT(18)
+#define GPIO_PCM_SPI_CS1_MODE_MASK		BIT(17)
+#define GPIO_PCM_SPI_MODE_MASK			BIT(16)
+#define GPIO_PCM2_MODE_MASK			BIT(13)
+#define GPIO_PCM1_MODE_MASK			BIT(12)
+#define GPIO_PCM_INT_MODE_MASK			BIT(9)
+#define GPIO_PCM_RESET_MODE_MASK		BIT(8)
+#define GPIO_SPI_QUAD_MODE_MASK			BIT(4)
+#define GPIO_SPI_CS4_MODE_MASK			BIT(3)
+#define GPIO_SPI_CS3_MODE_MASK			BIT(2)
+#define GPIO_SPI_CS2_MODE_MASK			BIT(1)
+#define GPIO_SPI_CS1_MODE_MASK			BIT(0)
+
+#define REG_GPIO_PON_MODE			0x021c
+#define EN7523_REG_GPIO_PON_MODE		0x0218
+#define GPIO_PARALLEL_NAND_MODE_MASK		BIT(14)
+#define GPIO_SGMII_MDIO_MODE_MASK		BIT(13)
+#define GPIO_PCIE_RESET2_MASK			BIT(12)
+#define SIPO_RCLK_MODE_MASK			BIT(11)
+#define GPIO_PCIE_RESET1_MASK			BIT(10)
+#define GPIO_PCIE_RESET0_MASK			BIT(9)
+#define GPIO_UART5_MODE_MASK			BIT(8)
+#define GPIO_UART4_MODE_MASK			BIT(7)
+#define GPIO_HSUART_CTS_RTS_MODE_MASK		BIT(6)
+#define GPIO_HSUART_MODE_MASK			BIT(5)
+#define GPIO_UART2_CTS_RTS_MODE_MASK		BIT(4)
+#define GPIO_UART2_MODE_MASK			BIT(3)
+#define GPIO_SIPO_MODE_MASK			BIT(2)
+#define GPIO_EMMC_MODE_MASK			BIT(1)
+#define GPIO_PON_MODE_MASK			BIT(0)
+
+#define REG_NPU_UART_EN			0x0224
+#define EN7523_REG_NPU_UART_EN		0x0220
+#define JTAG_UDI_EN_MASK		BIT(4)
+#define JTAG_DFD_EN_MASK		BIT(3)
+
+#define REG_FORCE_GPIO_EN		0x0228
+#define FORCE_GPIO_EN(n)		BIT(n)
+
+/* LED MAP */
+#define REG_LAN_LED0_MAPPING		0x027c
+#define REG_LAN_LED1_MAPPING		0x0280
+
+#define LAN4_LED_MAPPING_MASK		GENMASK(18, 16)
+#define LAN4_PHY_LED_MAP(_n)		FIELD_PREP_CONST(LAN4_LED_MAPPING_MASK, (_n))
+
+#define LAN3_LED_MAPPING_MASK		GENMASK(14, 12)
+#define LAN3_PHY_LED_MAP(_n)		FIELD_PREP_CONST(LAN3_LED_MAPPING_MASK, (_n))
+
+#define LAN2_LED_MAPPING_MASK		GENMASK(10, 8)
+#define LAN2_PHY_LED_MAP(_n)		FIELD_PREP_CONST(LAN2_LED_MAPPING_MASK, (_n))
+
+#define LAN1_LED_MAPPING_MASK		GENMASK(6, 4)
+#define LAN1_PHY_LED_MAP(_n)		FIELD_PREP_CONST(LAN1_LED_MAPPING_MASK, (_n))
+
+#define LAN0_LED_MAPPING_MASK		GENMASK(2, 0)
+#define LAN0_PHY_LED_MAP(_n)		FIELD_PREP_CONST(LAN0_LED_MAPPING_MASK, (_n))
+
+/* CONF */
+#define REG_I2C_SDA_E2			0x001c
+#define AN7583_I2C1_SCL_E2_MASK		BIT(16)
+#define AN7583_I2C1_SDA_E2_MASK		BIT(15)
+#define SPI_MISO_E2_MASK		BIT(14)
+#define SPI_MOSI_E2_MASK		BIT(13)
+#define SPI_CLK_E2_MASK			BIT(12)
+#define SPI_CS0_E2_MASK			BIT(11)
+#define EN7523_SPI_MISO_E2_MASK		BIT(13)
+#define EN7523_SPI_MOSI_E2_MASK		BIT(12)
+#define EN7523_SPI_CLK_E2_MASK		BIT(11)
+#define EN7523_SPI_CS0_E2_MASK		BIT(10)
+#define PCIE2_RESET_E2_MASK		BIT(10)
+#define PCIE1_RESET_E2_MASK		BIT(9)
+#define PCIE0_RESET_E2_MASK		BIT(8)
+#define AN7583_MDIO_0_E2_MASK		BIT(5)
+#define AN7583_MDC_0_E2_MASK		BIT(4)
+#define UART1_RXD_E2_MASK		BIT(3)
+#define UART1_TXD_E2_MASK		BIT(2)
+#define I2C_SCL_E2_MASK			BIT(1)
+#define I2C_SDA_E2_MASK			BIT(0)
+
+#define REG_I2C_SDA_E4			0x0020
+#define AN7583_I2C1_SCL_E4_MASK		BIT(16)
+#define AN7583_I2C1_SDA_E4_MASK		BIT(15)
+#define SPI_MISO_E4_MASK		BIT(14)
+#define SPI_MOSI_E4_MASK		BIT(13)
+#define SPI_CLK_E4_MASK			BIT(12)
+#define SPI_CS0_E4_MASK			BIT(11)
+#define EN7523_SPI_MISO_E4_MASK		BIT(13)
+#define EN7523_SPI_MOSI_E4_MASK		BIT(12)
+#define EN7523_SPI_CLK_E4_MASK		BIT(11)
+#define EN7523_SPI_CS0_E4_MASK		BIT(10)
+#define PCIE2_RESET_E4_MASK		BIT(10)
+#define PCIE1_RESET_E4_MASK		BIT(9)
+#define PCIE0_RESET_E4_MASK		BIT(8)
+#define AN7583_MDIO_0_E4_MASK		BIT(5)
+#define AN7583_MDC_0_E4_MASK		BIT(4)
+#define UART1_RXD_E4_MASK		BIT(3)
+#define UART1_TXD_E4_MASK		BIT(2)
+#define I2C_SCL_E4_MASK			BIT(1)
+#define I2C_SDA_E4_MASK			BIT(0)
+
+#define REG_GPIO_L_E2			0x0024
+#define REG_GPIO_L_E4			0x0028
+#define REG_GPIO_H_E2			0x002c
+#define REG_GPIO_H_E4			0x0030
+
+#define REG_I2C_SDA_PU			0x0044
+#define AN7583_I2C1_SCL_PU_MASK		BIT(16)
+#define AN7583_I2C1_SDA_PU_MASK		BIT(15)
+#define SPI_MISO_PU_MASK		BIT(14)
+#define SPI_MOSI_PU_MASK		BIT(13)
+#define SPI_CLK_PU_MASK			BIT(12)
+#define SPI_CS0_PU_MASK			BIT(11)
+#define EN7523_SPI_MISO_PU_MASK		BIT(13)
+#define EN7523_SPI_MOSI_PU_MASK		BIT(12)
+#define EN7523_SPI_CLK_PU_MASK		BIT(11)
+#define EN7523_SPI_CS0_PU_MASK		BIT(10)
+#define PCIE2_RESET_PU_MASK		BIT(10)
+#define PCIE1_RESET_PU_MASK		BIT(9)
+#define PCIE0_RESET_PU_MASK		BIT(8)
+#define AN7583_MDIO_0_PU_MASK		BIT(5)
+#define AN7583_MDC_0_PU_MASK		BIT(4)
+#define UART1_RXD_PU_MASK		BIT(3)
+#define UART1_TXD_PU_MASK		BIT(2)
+#define I2C_SCL_PU_MASK			BIT(1)
+#define I2C_SDA_PU_MASK			BIT(0)
+
+#define REG_I2C_SDA_PD			0x0048
+#define AN7583_I2C1_SDA_PD_MASK		BIT(16)
+#define AN7583_I2C1_SCL_PD_MASK		BIT(15)
+#define SPI_MISO_PD_MASK		BIT(14)
+#define SPI_MOSI_PD_MASK		BIT(13)
+#define SPI_CLK_PD_MASK			BIT(12)
+#define SPI_CS0_PD_MASK			BIT(11)
+#define EN7523_SPI_MISO_PD_MASK		BIT(13)
+#define EN7523_SPI_MOSI_PD_MASK		BIT(12)
+#define EN7523_SPI_CLK_PD_MASK		BIT(11)
+#define EN7523_SPI_CS0_PD_MASK		BIT(10)
+#define PCIE2_RESET_PD_MASK		BIT(10)
+#define PCIE1_RESET_PD_MASK		BIT(9)
+#define PCIE0_RESET_PD_MASK		BIT(8)
+#define AN7583_MDIO_0_PD_MASK		BIT(5)
+#define AN7583_MDC_0_PD_MASK		BIT(4)
+#define UART1_RXD_PD_MASK		BIT(3)
+#define UART1_TXD_PD_MASK		BIT(2)
+#define I2C_SCL_PD_MASK			BIT(1)
+#define I2C_SDA_PD_MASK			BIT(0)
+
+#define REG_GPIO_L_PU			0x004c
+#define REG_GPIO_L_PD			0x0050
+#define REG_GPIO_H_PU			0x0054
+#define REG_GPIO_H_PD			0x0058
+
+#define REG_PCIE_RESET_OD		0x018c
+#define PCIE2_RESET_OD_MASK		BIT(2)
+#define PCIE1_RESET_OD_MASK		BIT(1)
+#define PCIE0_RESET_OD_MASK		BIT(0)
+
+/* GPIOs */
+#define REG_GPIO_CTRL		0x0000
+#define REG_GPIO_DATA		0x0004
+#define REG_GPIO_INT		0x0008
+#define REG_GPIO_INT_EDGE	0x000c
+#define REG_GPIO_INT_LEVEL	0x0010
+#define REG_GPIO_OE		0x0014
+#define REG_GPIO_CTRL1		0x0020
+
+/* PWM MODE CONF */
+#define REG_GPIO_FLASH_MODE_CFG		0x0034
+#define GPIO15_FLASH_MODE_CFG		BIT(15)
+#define GPIO14_FLASH_MODE_CFG		BIT(14)
+#define GPIO13_FLASH_MODE_CFG		BIT(13)
+#define GPIO12_FLASH_MODE_CFG		BIT(12)
+#define GPIO11_FLASH_MODE_CFG		BIT(11)
+#define GPIO10_FLASH_MODE_CFG		BIT(10)
+#define GPIO9_FLASH_MODE_CFG		BIT(9)
+#define GPIO8_FLASH_MODE_CFG		BIT(8)
+#define GPIO7_FLASH_MODE_CFG		BIT(7)
+#define GPIO6_FLASH_MODE_CFG		BIT(6)
+#define GPIO5_FLASH_MODE_CFG		BIT(5)
+#define GPIO4_FLASH_MODE_CFG		BIT(4)
+#define GPIO3_FLASH_MODE_CFG		BIT(3)
+#define GPIO2_FLASH_MODE_CFG		BIT(2)
+#define GPIO1_FLASH_MODE_CFG		BIT(1)
+#define GPIO0_FLASH_MODE_CFG		BIT(0)
+
+#define REG_GPIO_CTRL2	0x0060
+#define REG_GPIO_CTRL3	0x0064
+
+/* PWM MODE CONF EXT */
+#define REG_GPIO_FLASH_MODE_CFG_EXT	0x0068
+#define GPIO51_FLASH_MODE_CFG		BIT(31)
+#define GPIO50_FLASH_MODE_CFG		BIT(30)
+#define GPIO49_FLASH_MODE_CFG		BIT(29)
+#define GPIO48_FLASH_MODE_CFG		BIT(28)
+#define GPIO47_FLASH_MODE_CFG		BIT(27)
+#define GPIO46_FLASH_MODE_CFG		BIT(26)
+#define GPIO45_FLASH_MODE_CFG		BIT(25)
+#define GPIO44_FLASH_MODE_CFG		BIT(24)
+#define GPIO43_FLASH_MODE_CFG		BIT(23)
+#define GPIO42_FLASH_MODE_CFG		BIT(22)
+#define GPIO41_FLASH_MODE_CFG		BIT(21)
+#define GPIO40_FLASH_MODE_CFG		BIT(20)
+#define GPIO39_FLASH_MODE_CFG		BIT(19)
+#define GPIO38_FLASH_MODE_CFG		BIT(18)
+#define GPIO37_FLASH_MODE_CFG		BIT(17)
+#define GPIO36_FLASH_MODE_CFG		BIT(16)
+#define GPIO31_FLASH_MODE_CFG		BIT(15)
+#define GPIO30_FLASH_MODE_CFG		BIT(14)
+#define GPIO29_FLASH_MODE_CFG		BIT(13)
+#define GPIO28_FLASH_MODE_CFG		BIT(12)
+#define GPIO27_FLASH_MODE_CFG		BIT(11)
+#define GPIO26_FLASH_MODE_CFG		BIT(10)
+#define GPIO25_FLASH_MODE_CFG		BIT(9)
+#define GPIO24_FLASH_MODE_CFG		BIT(8)
+#define GPIO23_FLASH_MODE_CFG		BIT(7)
+#define GPIO22_FLASH_MODE_CFG		BIT(6)
+#define GPIO21_FLASH_MODE_CFG		BIT(5)
+#define GPIO20_FLASH_MODE_CFG		BIT(4)
+#define GPIO19_FLASH_MODE_CFG		BIT(3)
+#define GPIO18_FLASH_MODE_CFG		BIT(2)
+#define GPIO17_FLASH_MODE_CFG		BIT(1)
+#define GPIO16_FLASH_MODE_CFG		BIT(0)
+
+#define REG_GPIO_DATA1			0x0070
+#define REG_GPIO_OE1			0x0078
+#define REG_GPIO_INT1			0x007c
+#define REG_GPIO_INT_EDGE1		0x0080
+#define REG_GPIO_INT_EDGE2		0x0084
+#define REG_GPIO_INT_EDGE3		0x0088
+#define REG_GPIO_INT_LEVEL1		0x008c
+#define REG_GPIO_INT_LEVEL2		0x0090
+#define REG_GPIO_INT_LEVEL3		0x0094
+
+#define AIROHA_NUM_PINS			64
+#define AIROHA_PIN_BANK_SIZE		(AIROHA_NUM_PINS / 2)
+#define AIROHA_REG_GPIOCTRL_NUM_PIN	(AIROHA_NUM_PINS / 4)
+
+/* PWM */
+#define AIROHA_PINCTRL_PWM(gpio, mux_val)		\
+	{						\
+		.name = (gpio),				\
+		.regmap[0] = {				\
+			AIROHA_FUNC_PWM_MUX,		\
+			REG_GPIO_FLASH_MODE_CFG,	\
+			(mux_val),			\
+			(mux_val)			\
+		},					\
+		.regmap_size = 1,			\
+	}						\
+
+#define AIROHA_PINCTRL_PWM_EXT(gpio, mux_val)		\
+	{						\
+		.name = (gpio),				\
+		.regmap[0] = {				\
+			AIROHA_FUNC_PWM_EXT_MUX,	\
+			REG_GPIO_FLASH_MODE_CFG_EXT,	\
+			(mux_val),			\
+			(mux_val)			\
+		},					\
+		.regmap_size = 1,			\
+	}						\
+
+#define AIROHA_PINCTRL_PHY_LED0(variant, gpio, mux_val, map_mask, map_val)	\
+	{									\
+		.name = (gpio),							\
+		.regmap[0] = {							\
+			AIROHA_FUNC_MUX,					\
+			variant##_REG_GPIO_2ND_I2C_MODE,			\
+			(mux_val),						\
+			(mux_val),						\
+		},								\
+		.regmap[1] = {							\
+			AIROHA_FUNC_MUX,					\
+			REG_LAN_LED0_MAPPING,					\
+			(map_mask),						\
+			(map_val),						\
+		},								\
+		.regmap_size = 2,						\
+	}
+
+#define AIROHA_PINCTRL_PHY_LED1(variant, gpio, mux_val, map_mask, map_val)	\
+	{									\
+		.name = (gpio),							\
+		.regmap[0] = {							\
+			AIROHA_FUNC_MUX,					\
+			variant##_REG_GPIO_2ND_I2C_MODE,			\
+			(mux_val),						\
+			(mux_val),						\
+		},								\
+		.regmap[1] = {							\
+			AIROHA_FUNC_MUX,					\
+			REG_LAN_LED1_MAPPING,					\
+			(map_mask),						\
+			(map_val),						\
+		},								\
+		.regmap_size = 2,						\
+	}
+
+#define airoha_pinctrl_get_pullup_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_get_conf((pinctrl), AIROHA_PINCTRL_CONFS_PULLUP,		\
+				(pin), (val))
+#define airoha_pinctrl_get_pulldown_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_get_conf((pinctrl), AIROHA_PINCTRL_CONFS_PULLDOWN,	\
+				(pin), (val))
+#define airoha_pinctrl_get_drive_e2_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_get_conf((pinctrl), AIROHA_PINCTRL_CONFS_DRIVE_E2,	\
+				(pin), (val))
+#define airoha_pinctrl_get_drive_e4_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_get_conf((pinctrl), AIROHA_PINCTRL_CONFS_DRIVE_E4,	\
+				(pin), (val))
+#define airoha_pinctrl_get_pcie_rst_od_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_get_conf((pinctrl), AIROHA_PINCTRL_CONFS_PCIE_RST_OD,	\
+				(pin), (val))
+#define airoha_pinctrl_set_pullup_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_set_conf((pinctrl), AIROHA_PINCTRL_CONFS_PULLUP,		\
+				(pin), (val))
+#define airoha_pinctrl_set_pulldown_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_set_conf((pinctrl), AIROHA_PINCTRL_CONFS_PULLDOWN,	\
+				(pin), (val))
+#define airoha_pinctrl_set_drive_e2_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_set_conf((pinctrl), AIROHA_PINCTRL_CONFS_DRIVE_E2,	\
+				(pin), (val))
+#define airoha_pinctrl_set_drive_e4_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_set_conf((pinctrl), AIROHA_PINCTRL_CONFS_DRIVE_E4,	\
+				(pin), (val))
+#define airoha_pinctrl_set_pcie_rst_od_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_set_conf((pinctrl), AIROHA_PINCTRL_CONFS_PCIE_RST_OD,	\
+				(pin), (val))
+
+struct airoha_pinctrl_reg {
+	u32 offset;
+	u32 mask;
+};
+
+enum airoha_pinctrl_mux_func {
+	AIROHA_FUNC_MUX,
+	AIROHA_FUNC_PWM_MUX,
+	AIROHA_FUNC_PWM_EXT_MUX,
+};
+
+struct airoha_pinctrl_func_group {
+	const char *name;
+	struct {
+		enum airoha_pinctrl_mux_func mux;
+		u32 offset;
+		u32 mask;
+		u32 val;
+	} regmap[2];
+	int regmap_size;
+};
+
+struct airoha_pinctrl_func {
+	const struct pinfunction desc;
+	const struct airoha_pinctrl_func_group *groups;
+	u8 group_size;
+};
+
+struct airoha_pinctrl_conf {
+	u32 pin;
+	struct airoha_pinctrl_reg reg;
+};
+
+struct airoha_pinctrl_gpiochip {
+	/* gpio */
+	const u32 *data;
+	const u32 *dir;
+	const u32 *out;
+	/* irq */
+	const u32 *status;
+	const u32 *level;
+	const u32 *edge;
+
+	u32 irq_type[AIROHA_NUM_PINS];
+};
+
+struct airoha_pinctrl_confs_info {
+	const struct airoha_pinctrl_conf *confs;
+	unsigned int num_confs;
+};
+
+enum airoha_pinctrl_confs_type {
+	AIROHA_PINCTRL_CONFS_PULLUP,
+	AIROHA_PINCTRL_CONFS_PULLDOWN,
+	AIROHA_PINCTRL_CONFS_DRIVE_E2,
+	AIROHA_PINCTRL_CONFS_DRIVE_E4,
+	AIROHA_PINCTRL_CONFS_PCIE_RST_OD,
+
+	AIROHA_PINCTRL_CONFS_MAX
+};
+
+struct airoha_pinctrl {
+	struct udevice *dev;
+
+	struct regmap *chip_scu;
+	struct regmap *regmap;
+
+	struct airoha_pinctrl_match_data *data;
+
+	struct airoha_pinctrl_gpiochip gpiochip;
+};
+
+struct airoha_pinctrl_match_data {
+	const int gpio_offs;
+	const int gpio_pin_cnt;
+	const struct pinctrl_pin_desc *pins;
+	const unsigned int num_pins;
+	const struct pingroup *grps;
+	const unsigned int num_grps;
+	const struct airoha_pinctrl_func *funcs;
+	const unsigned int num_funcs;
+	const struct airoha_pinctrl_confs_info confs_info[AIROHA_PINCTRL_CONFS_MAX];
+};
+
+extern const struct pinctrl_ops airoha_pinctrl_ops;
+
+int airoha_pinctrl_probe(struct udevice *dev);
+int airoha_pinctrl_bind(struct udevice *dev);
+
+#endif
diff --git a/drivers/pinctrl/airoha/pinctrl-airoha.c b/drivers/pinctrl/airoha/pinctrl-airoha.c
new file mode 100644
index 00000000000..187c0fbf670
--- /dev/null
+++ b/drivers/pinctrl/airoha/pinctrl-airoha.c
@@ -0,0 +1,927 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Author: Lorenzo Bianconi <lorenzo@kernel.org>
+ * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
+ * Author: Markus Gothe <markus.gothe@genexis.eu>
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <dm/ofnode.h>
+#include <asm-generic/gpio.h>
+#include <asm/arch/scu-regmap.h>
+#include <dt-bindings/pinctrl/mt65xx.h>
+#include <regmap.h>
+#include <syscon.h>
+
+#include "airoha-common.h"
+
+static const u32 gpio_data_regs[] = {
+	REG_GPIO_DATA,
+	REG_GPIO_DATA1
+};
+
+static const u32 gpio_out_regs[] = {
+	REG_GPIO_OE,
+	REG_GPIO_OE1
+};
+
+static const u32 gpio_dir_regs[] = {
+	REG_GPIO_CTRL,
+	REG_GPIO_CTRL1,
+	REG_GPIO_CTRL2,
+	REG_GPIO_CTRL3
+};
+
+static const u32 irq_status_regs[] = {
+	REG_GPIO_INT,
+	REG_GPIO_INT1
+};
+
+static const u32 irq_level_regs[] = {
+	REG_GPIO_INT_LEVEL,
+	REG_GPIO_INT_LEVEL1,
+	REG_GPIO_INT_LEVEL2,
+	REG_GPIO_INT_LEVEL3
+};
+
+static const u32 irq_edge_regs[] = {
+	REG_GPIO_INT_EDGE,
+	REG_GPIO_INT_EDGE1,
+	REG_GPIO_INT_EDGE2,
+	REG_GPIO_INT_EDGE3
+};
+
+static int pin_in_group(unsigned int pin, const struct pingroup *grp)
+{
+	for (int i = 0; i < grp->npins; i++) {
+		if (grp->pins[i] == pin)
+			return 1;
+	}
+
+	return 0;
+}
+
+static int pin_to_gpio(struct airoha_pinctrl *pinctrl, unsigned int pin)
+{
+	struct airoha_pinctrl_match_data *data = pinctrl->data;
+
+	if (pin < data->gpio_offs ||
+	    pin >= data->gpio_offs + data->gpio_pin_cnt)
+		return -EINVAL;
+
+	return pin - data->gpio_offs;
+}
+
+/* gpio callbacks */
+static int airoha_gpio_set(struct airoha_pinctrl *pinctrl, unsigned int gpio,
+			   int value)
+{
+	u32 offset = gpio % AIROHA_PIN_BANK_SIZE;
+	u8 index = gpio / AIROHA_PIN_BANK_SIZE;
+
+	return regmap_update_bits(pinctrl->regmap,
+				  pinctrl->gpiochip.data[index],
+				  BIT(offset), value ? BIT(offset) : 0);
+}
+
+static int airoha_gpio_get(struct airoha_pinctrl *pinctrl, unsigned int gpio)
+{
+	u32 val, pin = gpio % AIROHA_PIN_BANK_SIZE;
+	u8 index = gpio / AIROHA_PIN_BANK_SIZE;
+	int err;
+
+	err = regmap_read(pinctrl->regmap,
+			  pinctrl->gpiochip.data[index], &val);
+
+	return err ? err : !!(val & BIT(pin));
+}
+
+static int airoha_gpio_get_direction(struct airoha_pinctrl *pinctrl, unsigned int gpio)
+{
+	u32 mask, index, val;
+	int err, field_shift;
+
+	field_shift = 2 * (gpio % AIROHA_REG_GPIOCTRL_NUM_PIN);
+	mask = GENMASK(field_shift + 1, field_shift);
+	index = gpio / AIROHA_REG_GPIOCTRL_NUM_PIN;
+
+	err = regmap_read(pinctrl->regmap,
+			  pinctrl->gpiochip.dir[index], &val);
+	if (err)
+		return err;
+
+	if ((val & mask) > BIT(field_shift))
+		return -EINVAL;
+
+	return (val & mask) ? GPIOF_OUTPUT : GPIOF_INPUT;
+}
+
+static int airoha_gpio_set_direction(struct airoha_pinctrl *pinctrl,
+				     unsigned int gpio, bool input)
+{
+	u32 mask, index;
+	int err, field_shift;
+
+	/* set output enable */
+	mask = BIT(gpio % AIROHA_PIN_BANK_SIZE);
+	index = gpio / AIROHA_PIN_BANK_SIZE;
+	err = regmap_update_bits(pinctrl->regmap, pinctrl->gpiochip.out[index],
+				 mask, !input ? mask : 0);
+	if (err)
+		return err;
+
+	/* set direction */
+	field_shift = 2 * (gpio % AIROHA_REG_GPIOCTRL_NUM_PIN);
+	mask = GENMASK(field_shift + 1, field_shift);
+	index = gpio / AIROHA_REG_GPIOCTRL_NUM_PIN;
+
+	return regmap_update_bits(pinctrl->regmap,
+				  pinctrl->gpiochip.dir[index],
+				  mask, !input ? BIT(field_shift) : 0);
+}
+
+/* pinmux callbacks */
+static int airoha_pinmux_set_mux(struct airoha_pinctrl *pinctrl,
+				 unsigned int selector,
+				 unsigned int group)
+{
+	const struct airoha_pinctrl_func *func;
+	const struct pingroup *grp;
+	int i;
+
+	func = &pinctrl->data->funcs[selector];
+	grp = &pinctrl->data->grps[group];
+
+	dev_dbg(pinctrl->dev, "enable function %s group %s\n",
+		func->desc.name, grp->name);
+
+	for (i = 0; i < func->group_size; i++) {
+		const struct airoha_pinctrl_func_group *group;
+		int j;
+
+		group = &func->groups[i];
+		if (strcmp(group->name, grp->name))
+			continue;
+
+		for (j = 0; j < group->regmap_size; j++) {
+			switch (group->regmap[j].mux) {
+			case AIROHA_FUNC_PWM_EXT_MUX:
+			case AIROHA_FUNC_PWM_MUX:
+				regmap_update_bits(pinctrl->regmap,
+						   group->regmap[j].offset,
+						   group->regmap[j].mask,
+						   group->regmap[j].val);
+				break;
+			default:
+				regmap_update_bits(pinctrl->chip_scu,
+						   group->regmap[j].offset,
+						   group->regmap[j].mask,
+						   group->regmap[j].val);
+				break;
+			}
+		}
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int airoha_pinmux_set_direction(struct airoha_pinctrl *pinctrl,
+				       unsigned int p, bool input)
+{
+	int gpio;
+
+	gpio = pin_to_gpio(pinctrl, p);
+	if (gpio < 0)
+		return gpio;
+
+	return airoha_gpio_set_direction(pinctrl, gpio, input);
+}
+
+/* pinconf callbacks */
+static const struct airoha_pinctrl_reg *
+airoha_pinctrl_get_conf_reg(const struct airoha_pinctrl_conf *conf,
+			    int conf_size, int pin)
+{
+	int i;
+
+	for (i = 0; i < conf_size; i++) {
+		if (conf[i].pin == pin)
+			return &conf[i].reg;
+	}
+
+	return NULL;
+}
+
+static int airoha_pinctrl_get_conf(struct airoha_pinctrl *pinctrl,
+				   enum airoha_pinctrl_confs_type conf_type,
+				   int pin, u32 *val)
+{
+	const struct airoha_pinctrl_confs_info *confs_info;
+	const struct airoha_pinctrl_reg *reg;
+
+	confs_info = &pinctrl->data->confs_info[conf_type];
+
+	reg = airoha_pinctrl_get_conf_reg(confs_info->confs,
+					  confs_info->num_confs,
+					  pin);
+	if (!reg)
+		return -EINVAL;
+
+	if (regmap_read(pinctrl->chip_scu, reg->offset, val))
+		return -EINVAL;
+
+	*val = field_get(reg->mask, *val);
+
+	return 0;
+}
+
+static int airoha_pinctrl_set_conf(struct airoha_pinctrl *pinctrl,
+				   enum airoha_pinctrl_confs_type conf_type,
+				   int pin, u32 val)
+{
+	const struct airoha_pinctrl_confs_info *confs_info;
+	const struct airoha_pinctrl_reg *reg = NULL;
+
+	confs_info = &pinctrl->data->confs_info[conf_type];
+
+	reg = airoha_pinctrl_get_conf_reg(confs_info->confs,
+					  confs_info->num_confs,
+					  pin);
+	if (!reg)
+		return -EINVAL;
+
+	if (regmap_update_bits(pinctrl->chip_scu, reg->offset, reg->mask,
+			       field_prep(reg->mask, val)))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int airoha_pinconf_get_direction(struct airoha_pinctrl *pinctrl, u32 p)
+{
+	int gpio;
+
+	gpio = pin_to_gpio(pinctrl, p);
+	if (gpio < 0)
+		return gpio;
+
+	return airoha_gpio_get_direction(pinctrl, gpio);
+}
+
+static int airoha_pinconf_get(struct airoha_pinctrl *pinctrl,
+			      unsigned int pin, unsigned long *config)
+{
+	enum pin_config_param param = pinconf_to_config_param(*config);
+	u32 arg;
+
+	switch (param) {
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+	case PIN_CONFIG_BIAS_DISABLE:
+	case PIN_CONFIG_BIAS_PULL_UP: {
+		u32 pull_up, pull_down;
+
+		if (airoha_pinctrl_get_pullup_conf(pinctrl, pin, &pull_up) ||
+		    airoha_pinctrl_get_pulldown_conf(pinctrl, pin, &pull_down))
+			return -EINVAL;
+
+		if (param == PIN_CONFIG_BIAS_PULL_UP &&
+		    !(pull_up && !pull_down))
+			return -EINVAL;
+		else if (param == PIN_CONFIG_BIAS_PULL_DOWN &&
+			 !(pull_down && !pull_up))
+			return -EINVAL;
+		else if (pull_up || pull_down)
+			return -EINVAL;
+
+		arg = 1;
+		break;
+	}
+	case PIN_CONFIG_DRIVE_STRENGTH: {
+		u32 e2, e4;
+
+		if (airoha_pinctrl_get_drive_e2_conf(pinctrl, pin, &e2) ||
+		    airoha_pinctrl_get_drive_e4_conf(pinctrl, pin, &e4))
+			return -EINVAL;
+
+		arg = e4 << 1 | e2;
+		break;
+	}
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		if (airoha_pinctrl_get_pcie_rst_od_conf(pinctrl, pin, &arg))
+			return -EINVAL;
+		break;
+	case PIN_CONFIG_OUTPUT_ENABLE:
+	case PIN_CONFIG_INPUT_ENABLE:
+		arg = airoha_pinconf_get_direction(pinctrl, pin);
+		if ((param != PIN_CONFIG_OUTPUT_ENABLE || arg != GPIOF_OUTPUT) &&
+		    (param != PIN_CONFIG_INPUT_ENABLE || arg != GPIOF_INPUT))
+			return -EINVAL;
+
+		arg = 1;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	*config = pinconf_to_config_packed(param, arg);
+
+	return 0;
+}
+
+static int airoha_pinconf_set_pin_value(struct airoha_pinctrl *pinctrl,
+					unsigned int p, bool value)
+{
+	int gpio;
+
+	gpio = pin_to_gpio(pinctrl, p);
+	if (gpio < 0)
+		return gpio;
+
+	return airoha_gpio_set(pinctrl, gpio, value);
+}
+
+static int airoha_pinconf_set(struct airoha_pinctrl *pinctrl,
+			      unsigned int pin, unsigned long *configs,
+			      unsigned int num_configs)
+{
+	int i, err;
+
+	for (i = 0; i < num_configs; i++) {
+		u32 param = pinconf_to_config_param(configs[i]);
+		u32 arg = pinconf_to_config_argument(configs[i]);
+
+		switch (param) {
+		case PIN_CONFIG_BIAS_DISABLE:
+			err = airoha_pinctrl_set_pulldown_conf(pinctrl, pin, 0);
+			if (err)
+				return err;
+
+			err = airoha_pinctrl_set_pullup_conf(pinctrl, pin, 0);
+			if (err)
+				return err;
+
+			break;
+
+		case PIN_CONFIG_BIAS_PULL_UP:
+			err = airoha_pinctrl_set_pulldown_conf(pinctrl, pin, 0);
+			if (err)
+				return err;
+
+			err = airoha_pinctrl_set_pullup_conf(pinctrl, pin, 1);
+			if (err)
+				return err;
+
+			break;
+
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			err = airoha_pinctrl_set_pulldown_conf(pinctrl, pin, 1);
+			if (err)
+				return err;
+
+			err = airoha_pinctrl_set_pullup_conf(pinctrl, pin, 0);
+			if (err)
+				return err;
+
+			break;
+
+		case PIN_CONFIG_DRIVE_STRENGTH: {
+			u32 e2 = 0, e4 = 0;
+
+			switch (arg) {
+			case MTK_DRIVE_2mA:
+				break;
+			case MTK_DRIVE_4mA:
+				e2 = 1;
+				break;
+			case MTK_DRIVE_6mA:
+				e4 = 1;
+				break;
+			case MTK_DRIVE_8mA:
+				e2 = 1;
+				e4 = 1;
+				break;
+			default:
+				return -EINVAL;
+			}
+
+			err = airoha_pinctrl_set_drive_e2_conf(pinctrl, pin, e2);
+			if (err)
+				return err;
+
+			err = airoha_pinctrl_set_drive_e4_conf(pinctrl, pin, e4);
+			if (err)
+				return err;
+
+			break;
+		}
+		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+			err = airoha_pinctrl_set_pcie_rst_od_conf(pinctrl, pin, !!arg);
+			if (err)
+				return err;
+
+			break;
+
+		case PIN_CONFIG_OUTPUT_ENABLE:
+		case PIN_CONFIG_INPUT_ENABLE:
+		case PIN_CONFIG_OUTPUT: {
+			bool input = param == PIN_CONFIG_INPUT_ENABLE;
+
+			err = airoha_pinmux_set_direction(pinctrl, pin, input);
+			if (err)
+				return err;
+
+			if (param == PIN_CONFIG_OUTPUT) {
+				err = airoha_pinconf_set_pin_value(pinctrl,
+								   pin, !!arg);
+				if (err)
+					return err;
+			}
+
+			break;
+		}
+		default:
+			return -EOPNOTSUPP;
+		}
+	}
+
+	return 0;
+}
+
+static int airoha_pinconf_group_set(struct airoha_pinctrl *pinctrl,
+				    unsigned int group, unsigned long *configs,
+				    unsigned int num_configs)
+{
+	int i;
+
+	for (i = 0; i < pinctrl->data->grps[group].npins; i++) {
+		int err;
+
+		err = airoha_pinconf_set(pinctrl,
+					 pinctrl->data->grps[group].pins[i],
+					 configs, num_configs);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int func_grp_active(struct airoha_pinctrl *pinctrl,
+			   const struct airoha_pinctrl_func *func,
+			   const char *grp_name)
+{
+	const struct airoha_pinctrl_func_group *func_grp;
+	u32 val, match;
+	int ret;
+
+	for (int i = 0; i < func->group_size; i++) {
+		if (strcmp(func->groups[i].name, grp_name))
+			continue;
+
+		match = 0;
+		func_grp = &func->groups[i];
+		for (int j = 0; j < func_grp->regmap_size; j++) {
+			switch (func_grp->regmap[j].mux) {
+			case AIROHA_FUNC_PWM_EXT_MUX:
+			case AIROHA_FUNC_PWM_MUX:
+				ret = regmap_read(pinctrl->regmap,
+						  func_grp->regmap[j].offset,
+						  &val);
+				break;
+			default:
+				ret = regmap_read(pinctrl->chip_scu,
+						  func_grp->regmap[j].offset,
+						  &val);
+				break;
+			}
+
+			if (ret)
+				break;
+
+			if ((val & func_grp->regmap[j].mask) !=
+			    func_grp->regmap[j].val)
+				break;
+
+			match++;
+		}
+
+		return match == func->groups[i].regmap_size;
+	}
+
+	return 0;
+}
+
+/***********************
+ * gpio driver interface
+ ***********************/
+static int airoha_pinctrl_gpio_set(struct udevice *dev, unsigned int gpio,
+				   int value)
+{
+	return airoha_gpio_set(dev_get_priv(dev->parent), gpio, value);
+}
+
+static int airoha_pinctrl_gpio_get(struct udevice *dev, unsigned int gpio)
+{
+	return airoha_gpio_get(dev_get_priv(dev->parent), gpio);
+}
+
+static int airoha_pinctrl_gpio_get_direction(struct udevice *dev,
+					     unsigned int gpio)
+{
+	return airoha_gpio_get_direction(dev_get_priv(dev->parent), gpio);
+}
+
+static int airoha_pinctrl_gpio_direction_input(struct udevice *dev,
+					       unsigned int gpio)
+{
+	return airoha_gpio_set_direction(dev_get_priv(dev->parent),
+					 gpio, true);
+}
+
+static int airoha_pinctrl_gpio_direction_output(struct udevice *dev,
+						unsigned int gpio, int val)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev->parent);
+	int err;
+
+	err = airoha_gpio_set_direction(pinctrl, gpio, false);
+	if (err)
+		return err;
+
+	return airoha_gpio_set(pinctrl, gpio, val);
+}
+
+static int airoha_pinctrl_gpio_probe(struct udevice *dev)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev->parent);
+	struct gpio_dev_priv *uc_priv;
+
+	uc_priv = dev_get_uclass_priv(dev);
+	uc_priv->bank_name = "airoha";
+	uc_priv->gpio_count = pinctrl->data->gpio_pin_cnt;
+
+	return 0;
+}
+
+static int airoha_pinctrl_gpio_bind(struct udevice *dev)
+{
+	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+
+	return 0;
+}
+
+static const struct dm_gpio_ops airoha_pinctrl_gpio_ops = {
+	.set_value = airoha_pinctrl_gpio_set,
+	.get_value = airoha_pinctrl_gpio_get,
+	.get_function = airoha_pinctrl_gpio_get_direction,
+	.direction_input = airoha_pinctrl_gpio_direction_input,
+	.direction_output = airoha_pinctrl_gpio_direction_output,
+};
+
+static struct driver airoha_pinctrl_gpio_driver = {
+	.name = "airoha_pinctrl_gpio",
+	.id = UCLASS_GPIO,
+	.probe = airoha_pinctrl_gpio_probe,
+	.bind = airoha_pinctrl_gpio_bind,
+	.ops = &airoha_pinctrl_gpio_ops,
+};
+
+static int airoha_pinctrl_gpio_register(struct udevice *parent)
+{
+	struct uclass_driver *drv;
+	ofnode node;
+	int ret;
+
+	drv = lists_uclass_lookup(UCLASS_GPIO);
+	if (!drv)
+		return -ENOENT;
+
+	/*
+	 * Support upstream linux DTSI that define gpio-controller
+	 * in the root node (instead of a dedicated subnode)
+	 */
+	if (dev_read_bool(parent, "gpio-controller")) {
+		/* upstream DTSI, use current node */
+		node = dev_ofnode(parent);
+	} else {
+		/* legacy DTSI, search for gpio-controller subnode */
+		ret = -ENOENT;
+		dev_for_each_subnode(node, parent)
+			if (ofnode_read_bool(node, "gpio-controller")) {
+				ret = 0;
+				break;
+			}
+
+		if (ret)
+			return ret;
+	}
+
+	return device_bind_with_driver_data(parent,
+					    &airoha_pinctrl_gpio_driver,
+					    "airoha_pinctrl_gpio",
+					    0, node, NULL);
+}
+
+/**************************
+ * pinctrl driver interface
+ **************************/
+static int airoha_get_pins_count(struct udevice *dev)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+
+	return pinctrl->data->num_pins;
+}
+
+static const char *airoha_get_pin_name(struct udevice *dev,
+				       unsigned int selector)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+
+	return pinctrl->data->pins[selector].name;
+}
+
+static int airoha_get_groups_count(struct udevice *dev)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+
+	return pinctrl->data->num_grps;
+}
+
+static const char *airoha_get_group_name(struct udevice *dev,
+					 unsigned int selector)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+
+	return pinctrl->data->grps[selector].name;
+}
+
+static int airoha_get_funcs_count(struct udevice *dev)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+
+	return pinctrl->data->num_funcs;
+}
+
+static const char *airoha_get_func_name(struct udevice *dev,
+					unsigned int selector)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+
+	return pinctrl->data->funcs[selector].desc.name;
+}
+
+static int airoha_pinmux_group_set(struct udevice *dev,
+				   unsigned int group_selector,
+				   unsigned int func_selector)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+
+	dev_dbg(dev, "enabling %s function for pin group %s\n",
+		airoha_get_func_name(dev, func_selector),
+		airoha_get_group_name(dev, group_selector));
+
+	return airoha_pinmux_set_mux(pinctrl, func_selector, group_selector);
+}
+
+static int airoha_pinmux_set(struct udevice *dev,
+			     unsigned int pin_selector,
+			     unsigned int func_selector)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+	const struct airoha_pinctrl_match_data *data = pinctrl->data;
+	const char *pin_name;
+	unsigned int selector;
+
+	pin_name = data->pins[pin_selector].name;
+
+	/* find group matching the pin_name */
+	for (selector = 0; selector < data->num_grps; selector++) {
+		if (!strcmp(pin_name, data->grps[selector].name))
+			return airoha_pinmux_group_set(dev, selector,
+						       func_selector);
+	}
+
+	return -ENOENT;
+}
+
+static const struct pinconf_param airoha_pinconf_params[] = {
+	{ "bias-disable",     PIN_CONFIG_BIAS_DISABLE,     0 },
+	{ "bias-pull-up",     PIN_CONFIG_BIAS_PULL_UP,     1 },
+	{ "bias-pull-down",   PIN_CONFIG_BIAS_PULL_DOWN,   1 },
+	{ "drive-strength",   PIN_CONFIG_DRIVE_STRENGTH,   0 },
+	{ "drive-open-drain", PIN_CONFIG_DRIVE_OPEN_DRAIN, 0 },
+	{ "output-enable",    PIN_CONFIG_OUTPUT_ENABLE,    1 },
+	{ "input-enable",     PIN_CONFIG_INPUT_ENABLE,     1 },
+};
+
+static const char *airoha_pinconf_param_name(unsigned int param)
+{
+	for (int i = 0; i < ARRAY_SIZE(airoha_pinconf_params); i++) {
+		if (airoha_pinconf_params[i].param == param)
+			return airoha_pinconf_params[i].property;
+	}
+
+	return NULL;
+}
+
+static int airoha_pinconf_set_handler(struct udevice *dev,
+				      unsigned pin_selector,
+				      unsigned int param,
+				      unsigned int argument)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+	unsigned long configs[1] = { pinconf_to_config_packed(param, argument) };
+	unsigned int pin = pinctrl->data->pins[pin_selector].number;
+
+	dev_dbg(dev, "enabling %s=%d property for pin %s\n",
+		airoha_pinconf_param_name(param), argument,
+		airoha_get_pin_name(dev, pin_selector));
+
+	return airoha_pinconf_set(pinctrl, pin, configs,
+				  ARRAY_SIZE(configs));
+}
+
+static int airoha_pinconf_group_set_handler(struct udevice *dev,
+					    unsigned int group_selector,
+					    unsigned int param,
+					    unsigned int argument)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+	unsigned long configs[1] = { pinconf_to_config_packed(param, argument) };
+
+	dev_dbg(dev, "enabling %s=%d property for pin group %s\n",
+		airoha_pinconf_param_name(param), argument,
+		airoha_get_group_name(dev, group_selector));
+
+	return airoha_pinconf_group_set(pinctrl, group_selector,
+					configs, ARRAY_SIZE(configs));
+}
+
+static int airoha_get_pin_muxing(struct udevice *dev, unsigned int selector,
+				 char *buf, int size)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+	struct airoha_pinctrl_match_data *data = pinctrl->data;
+	const char *name, *type;
+	int ret, gpio, found = 0;
+	unsigned long config;
+	unsigned int param, pin;
+	u32 val;
+
+	pin = data->pins[selector].number;
+	for (int i = 0; i < data->num_grps; i++) {
+		if (!pin_in_group(pin, &data->grps[i]))
+			continue;
+
+		name = data->grps[i].name;
+		for (int j = 0; j < data->num_funcs; j++) {
+			if (!func_grp_active(pinctrl, &data->funcs[j], name))
+				continue;
+
+			ret = scnprintf(buf, size, "%s(%s)",
+					data->funcs[j].desc.name, name);
+			if (ret < 0)
+				return -ENOSPC;
+
+			found = 1;
+			buf += ret;
+			size -= ret;
+			break;
+		}
+
+		if (found)
+			break;
+	}
+
+	if (!found) {
+		gpio = pin_to_gpio(pinctrl, pin);
+		if (gpio < 0) {
+			/*
+			 * WARNING: non-gpio pin with unknown function.
+			 *
+			 * This should not have happened, the function group
+			 * tables are incomplete. Please fix ASAP.
+			 */
+			ret = scnprintf(buf, size, "default");
+		} else {
+			/* assume gpio */
+			val = airoha_gpio_get(pinctrl, gpio);
+			switch (airoha_gpio_get_direction(pinctrl, gpio)) {
+			case GPIOF_INPUT:
+				type = "input";
+				break;
+			case GPIOF_OUTPUT:
+				type = "output";
+				break;
+			default:
+				type = "unknown";
+				break;
+			};
+			ret = scnprintf(buf, size, "gpio%d, %s(%d)",
+					gpio, type, val);
+		}
+
+		if (ret < 0)
+			return -ENOSPC;
+
+		buf += ret;
+		size -= ret;
+	}
+
+	for (int i = 0; i < ARRAY_SIZE(airoha_pinconf_params); i++) {
+		param = airoha_pinconf_params[i].param;
+		config = pinconf_to_config_packed(param, 0);
+		ret = airoha_pinconf_get(pinctrl, pin, &config);
+		if (ret < 0)
+			continue;
+
+		name = airoha_pinconf_params[i].property;
+		switch (param) {
+		case PIN_CONFIG_BIAS_DISABLE:
+		case PIN_CONFIG_BIAS_PULL_UP:
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			ret = scnprintf(buf, size, ", %s", name);
+			break;
+
+		case PIN_CONFIG_DRIVE_STRENGTH:
+		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+			val = pinconf_to_config_argument(config);
+			ret = scnprintf(buf, size, ", %s(%d)", name, val);
+			break;
+
+		default:
+			break;
+		}
+
+		if (ret < 0)
+			return -ENOSPC;
+
+		buf += ret;
+		size -= ret;
+	}
+
+	return 0;
+}
+
+const struct pinctrl_ops airoha_pinctrl_ops = {
+	.get_pins_count		= airoha_get_pins_count,
+	.get_pin_name		= airoha_get_pin_name,
+	.get_groups_count	= airoha_get_groups_count,
+	.get_group_name		= airoha_get_group_name,
+	.get_functions_count	= airoha_get_funcs_count,
+	.get_function_name	= airoha_get_func_name,
+	.pinmux_set		= airoha_pinmux_set,
+	.pinmux_group_set	= airoha_pinmux_group_set,
+
+	.pinconf_num_params	= ARRAY_SIZE(airoha_pinconf_params),
+	.pinconf_params		= airoha_pinconf_params,
+	.pinconf_set		= airoha_pinconf_set_handler,
+	.pinconf_group_set	= airoha_pinconf_group_set_handler,
+
+	.set_state		= pinctrl_generic_set_state,
+	.get_pin_muxing		= airoha_get_pin_muxing,
+};
+
+int airoha_pinctrl_probe(struct udevice *dev)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+
+	pinctrl->dev = dev;
+	pinctrl->data = (struct airoha_pinctrl_match_data *)dev_get_driver_data(dev);
+
+	pinctrl->regmap = syscon_node_to_regmap(dev_ofnode(dev->parent));
+	if (IS_ERR(pinctrl->regmap))
+		return PTR_ERR(pinctrl->regmap);
+
+	pinctrl->chip_scu = airoha_get_chip_scu_regmap();
+	if (IS_ERR(pinctrl->chip_scu))
+		return PTR_ERR(pinctrl->chip_scu);
+
+	pinctrl->gpiochip.data   = gpio_data_regs;
+	pinctrl->gpiochip.dir    = gpio_dir_regs;
+	pinctrl->gpiochip.out    = gpio_out_regs;
+	pinctrl->gpiochip.status = irq_status_regs;
+	pinctrl->gpiochip.level  = irq_level_regs;
+	pinctrl->gpiochip.edge   = irq_edge_regs;
+
+	return 0;
+}
+
+int airoha_pinctrl_bind(struct udevice *dev)
+{
+	if (airoha_pinctrl_gpio_register(dev))
+		debug("Warning: can't bind gpio driver with device node\n");
+
+	/*
+	 * Make sure that the pinctrl driver gets probed after binding,
+	 * otherwise GPIO interface driver will not be probed as well.
+	 * GPIOs of non-probed driver can't be used.
+	 */
+	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+
+	return 0;
+}
-- 
2.53.0

