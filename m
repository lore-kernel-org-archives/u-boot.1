Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2851EC41513
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 14:05:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15FE988302;
	Tue, 14 May 2024 16:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="aF2lmu9j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F127488306; Tue, 14 May 2024 16:04:38 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0702.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::702])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BF2888307
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 16:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enw8ChiyVOpD9jok1yqTPzpsB+Z3l5rBHUUoYr85c8ysTC8hbEg9XRwsUG1mkCU3MC5lz5OLXh7g+1s5kH3WL+AK3mOgh0Astu+WjorWDTcmUDaVCm03vkm+xkrnhI8AGtpAuNXipPkPgWeUsUhPGNiKNhPn9CRx43Cs9eCzw0Mzy0NW2RAecU4FFff8Jda/NSbSRsNhgiO9V4NbjBYllwgeBVxR+v5bpuUd38cpa8TL8ylAb9bBtQOZQer2n8wwuxqZU1clU0GCseHBrs0S8lttZcvhqTl+dySFcOXfa1ZwuerBtoQpnuotyS9G6aHiAiGUCydGeWBQzZQjnOaZXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74Saj6I/0OjrWOpWTUVYW7RQUleoZ+J0+pGeA18WZzQ=;
 b=OXd845CppkCUceh6RYcRc0+w7ZLwFWtb59LQod67JeTRQRt7lxXKuQ9F84RgydO40cglNy7dYFZ1vF4CyGXT/9c0ZwStxoUUIY2zLKFEMUuL79bNyGbYFOGZ+A1U7IEnI9+kofU0+iRn3kNRlXnTo20sD6Xj7o5MWbB2lx+8apMsk1ppnEbnnwxSgOlGiHYZ+6jIZl6SSlSatzGpfnLZi4EZV1Ci4H/wlIq1MJEtrGocpdHIdNF9xgVOok36sDWSbW0hcL8gBgbODT+516fEGGPD1q2T97O6PrFOtfNamHTSxOZC7o55QZ9uRRtMNCB0HWBFAHzOIu//VUZ/3YY+sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74Saj6I/0OjrWOpWTUVYW7RQUleoZ+J0+pGeA18WZzQ=;
 b=aF2lmu9jY45xlASp10cETP+eZ9V0sLdLxwB0AInDrMnB4PKIUw4ZIJcIAxyond8XTPNSyg7g6OzDhITSg5ZQu5o6en7b/8JIEDmOlVc2vRbGm4tJCtY71oRkHhQkjbgiuQxBRfhYnLX2aNxtQ+H//I0JC8acWA7j8umB3dP4mMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by VI1PR08MB10052.eurprd08.prod.outlook.com (2603:10a6:800:1c7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 14:04:30 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 14:04:30 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>
Subject: [PATCH 3/3] drivers: misc: Add driver to access ZynqMP efuses
Date: Tue, 14 May 2024 16:04:16 +0200
Message-Id: <20240514140416.156747-4-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240514140416.156747-1-lukas.funke-oss@weidmueller.com>
References: <20240514140416.156747-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::12) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|VI1PR08MB10052:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f2d393-1534-46b8-6dcb-08dc741ec678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|1800799015|376005|7416005|52116005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j62BOTLilT8Jp6yZZeNNKzO/oceBSAHCMaoXneD4xvS8YFT23y+DXAGmX2wU?=
 =?us-ascii?Q?QZ3aRqFa3dugH6okyx/4Rmd1zUMLVwPB1+3/dj3KcWrNerwUrTNKWl64+xjZ?=
 =?us-ascii?Q?jaY9gP3vIh0wjaiiot1ldLFo+Z2732rOKuDIp2Yz639UEkQIzg6Ubh0lRapK?=
 =?us-ascii?Q?ef5LiVb3NcZYadeign+ZMM/eyCz6Q3+0+Sey+oQIGjuj+SbZpOxe4GQc5AWE?=
 =?us-ascii?Q?tVcB0AEL0LUjz9nZucSOOqtslMqMmBg7v+F36G/1xOfvCDFUx3cGGzOFHDCe?=
 =?us-ascii?Q?jQQA3ycSFc+Wpglze/EMMd9yENOnKfoyZcWWHbMZGa7XKuIse88IaTbG4+wZ?=
 =?us-ascii?Q?GeeEZGAkbpAxDEqCJ7Zg1GS1y5B5mfasmfwLPYHcjJb/b2NybeZ46O+dHJ3s?=
 =?us-ascii?Q?3fRTurHbjYrlnTU6rDqnHAyC8/8w0hAgpdF4D4WHHGune5pEtKLpOaUwlr5C?=
 =?us-ascii?Q?jfvII7lWsaIYFUEnu+6LMi3hM/xP/ti4z0BZEt2eoA5AdBNmuQ3o+wba/wxA?=
 =?us-ascii?Q?Q0Tmei7ZbHEWwBjZz5H8ktN425Ql91Lq1mdIFCI7NUz+Uwb8jBA0rCIjjh3H?=
 =?us-ascii?Q?EZPGaWdbgj6xlzjmVIgefX4Hi9Lg4tTyKiUQ5rcFcbEP/nYr9BmvSGnsk7tR?=
 =?us-ascii?Q?cVnU+nX3s+ih+6duodkxA3N2YRe2UHKrU1JiLYxw9tsV/s1JUfEoMocJXC+T?=
 =?us-ascii?Q?MKCJVmOVIFYMzLX7v1CVQmhLtKy2iCYf59XNRKcuYol4strNtWA3ya0ZCube?=
 =?us-ascii?Q?95FrMyNXew9+D/FxnmkqBsOtEP45knAes3KQWil5Qfj8ntj9Pi5rxcj6zral?=
 =?us-ascii?Q?LHxPQNjgogQqxHGkoJLD7FPrstEg6537SkT5fJyH5ouztpu1Asqm25OF7kBi?=
 =?us-ascii?Q?O4W3c4vtsFug6dXSKHBO/pKecd0spAV4B70+FR2AKvqFXsXt15/W1eUwTEuD?=
 =?us-ascii?Q?rJUKzeTE0JFZJHNSkR3mqInlYIkZZrIsgxxxLC6UpQRXCnU5HCruBRSvBBFq?=
 =?us-ascii?Q?9rnM9Pl/PlhvSb0KHD77r6IkZpI5Xt5p3fzuGPOi2A7Faw8wdXDuXK0qoiHn?=
 =?us-ascii?Q?4lrtrTTNfBtJxTJmloO9jYQNeFPgXM94oNGA6C4ch/Fr0+wNs99QmHezD7Jn?=
 =?us-ascii?Q?mcvTCMu5YM5LS+MJzY5VaP63+bJYFw/HvQpMfo66OgUz1ClKEkfnLtSzXcZX?=
 =?us-ascii?Q?lAr/hDHQmAKiYzNhzKmKqFWAhgDXvcUwrWYQOdWjne1QXrp3hL/CDzp5f9XO?=
 =?us-ascii?Q?mHit1kAXAIdQZEyhDu1mr9CpUyYRNfHQbLA5lfv4fg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(7416005)(52116005)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4K9Bj6Tqt9VRQDDp89isUW4LnJOU5quLc2EYORc7lhyBgcsiRPPnKRTN2Wh5?=
 =?us-ascii?Q?IYx5nqBjE7Sa7v0h0hvj1Zf/MW9zeFQ9qE+ObgOMdtARfkugcMVI/o5EMlje?=
 =?us-ascii?Q?4cfoOM0AXec/aA1NFiVLZP+btNgK/Giy9Wk+2fWm+/kN0LTFCE5yFLV54idg?=
 =?us-ascii?Q?a0eLh1Hn2ENW6bUB+5maVc38rPrpDDWdDsuWryZcbLyC4EbIJkwjVTeBZRQG?=
 =?us-ascii?Q?NZuK6RStHaFkpcqqIYgQSvsOAWixQIYgCigzksXTxNgcEM/E554P9Cei2hVB?=
 =?us-ascii?Q?9obcAo2rzSexeHy8GQDDzUxsrZmx5b/XHcAwreTl6OCN/g1jMlqjC/wn40fl?=
 =?us-ascii?Q?mu+FnBxm5OQkhLpW4n309MLwKgQjipAJUNo0UXB+2O0jaVoAHx7uEoKgeIf8?=
 =?us-ascii?Q?CZqbnwAzjz2+mlUk9jVIVImK/6yvpo+15UT+7FtaJyiVKBWcTJuMIXVXbLLl?=
 =?us-ascii?Q?oZnt/JVGFhrum1gkO3tnx5w1BI1C0FlwUoEplYsOftV+n4virC+AJx5YSA4Y?=
 =?us-ascii?Q?4mMxkIwfl2N7f+9GtDM+OWvOjOtj+JNOgzXwTT7scdOIPSgG/h+1IcS3Y73i?=
 =?us-ascii?Q?4RkjDWk6gyzxJRHoEBj5DCuEVMT5y6Y7ugxRY3oA4y7N0Uu8R2AiaL0+7Pp6?=
 =?us-ascii?Q?AxH84s6E2/0q26xA3Tdq0j9NueEafIIPcifO1oXnhrEBZzC6w9uukfu639Ws?=
 =?us-ascii?Q?kS9V4w/Q1bOln+2BI5sbAGxz9druFSXJ83AVb6XvNGX3GBUS3fVgyosNECBw?=
 =?us-ascii?Q?uQtNHFusVad6mlvnTqxucuVNvfulw73364/hjLSkr3PQs93B4n3h/rNLzmU/?=
 =?us-ascii?Q?m7mm8ckVDqbbTmr+XAIrrmJU81JKoiz4OvPpOtMdUa3UU+G/6oGrEz0+BSd9?=
 =?us-ascii?Q?YtqtlQySB/CzoEaOfnE+GjA9H2hPQN2csndobtbxxdkDsPkAh19ClgPjVPKx?=
 =?us-ascii?Q?imlDqTXTxe8LU3hTe8o8/xuTglKUJ4NvRIe837VVGWEFvQeKsuXzofJxdvnz?=
 =?us-ascii?Q?Qv9cbZmsasXkhUIXOWfeUdwhRz+1SGnwVp+Mwpgx64P2bbI/Uxn1D35BKmm1?=
 =?us-ascii?Q?sHbh79mmXLbtRHL7igls9h/boBZLok9Od7g90/o+3XMwqFWSFc1uMG9FynKu?=
 =?us-ascii?Q?diuK+8Q4D0Vp72VPYu25B+YJiQtdzkilY8+K6YJkiYyoseZUxgsQzXXsbkmh?=
 =?us-ascii?Q?eWNVrSpDA1RRRS6ZY/WuTgixwvow1S3nxva/a2B5eHjq8jgOSSf3hFt0aV/e?=
 =?us-ascii?Q?v1AcH8XirJw0XeLz2oUX1SkwX38DNqyu5qcPRkxRZ582LCHM16PNx44wenTL?=
 =?us-ascii?Q?zfkH5VTLMGdUME6eGToeXP8Gy8qANU7Zn1bCVvG5cw8twqgNDuiCp26H0+0+?=
 =?us-ascii?Q?aL1Rqc68CSeDYRFVXhDSbW4yZLoSQzS5vRpQ223zFOd120pLAU9vyqlyAg11?=
 =?us-ascii?Q?0CAvcihosEIE9t88hcqFZr8N0Zxg3QicmpwHh3z+BrNaILPY8vO7ECLoXYIB?=
 =?us-ascii?Q?oafEFsekTM1mEArGAAMGfiF3SQaCXgSE3t7JhSBbYVmPW9gm5oqwt53282LT?=
 =?us-ascii?Q?eEIoQXCHNHRkxGmXgW/l3xK+muVbXZ8BKUBElbCD?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f2d393-1534-46b8-6dcb-08dc741ec678
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 14:04:30.8275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejpdE8swyY4pz0k/3577r5Zcge8EH4L/6dW/BqJneJiyhptqTwp9JC+mxt94Uv84+dEN9uKiSG6xRV9VRcvqTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10052
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Add driver to access ZynqMP efuses. This is a u-boot port of [1].

[1] https://lore.kernel.org/all/20240224114516.86365-8-srinivas.kandagatla@linaro.org/

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

 drivers/misc/Kconfig        |   8 ++
 drivers/misc/Makefile       |   1 +
 drivers/misc/zynqmp_efuse.c | 213 ++++++++++++++++++++++++++++++++++++
 3 files changed, 222 insertions(+)
 create mode 100644 drivers/misc/zynqmp_efuse.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 6009d55f400..c07f50c9a76 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -298,6 +298,14 @@ config FSL_SEC_MON
 	  Security Monitor can be transitioned on any security failures,
 	  like software violations or hardware security violations.
 
+config ZYNQMP_EFUSE
+	bool "Enable ZynqMP eFUSE Driver"
+	depends on ZYNQMP_FIRMWARE
+	help
+	  Enable access to Zynq UltraScale (ZynqMP) eFUSEs thought PMU firmware
+	  interface. ZnyqMP has 256 eFUSEs where some of them are security related
+	  and cannot be read back (i.e. AES key).
+
 choice
 	prompt "Security monitor interaction endianess"
 	depends on FSL_SEC_MON
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e53d52c47b3..68ba5648eab 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -92,3 +92,4 @@ obj-$(CONFIG_ESM_K3) += k3_esm.o
 obj-$(CONFIG_ESM_PMIC) += esm_pmic.o
 obj-$(CONFIG_SL28CPLD) += sl28cpld.o
 obj-$(CONFIG_SPL_SOCFPGA_DT_REG) += socfpga_dtreg.o
+obj-$(CONFIG_ZYNQMP_EFUSE) += zynqmp_efuse.o
diff --git a/drivers/misc/zynqmp_efuse.c b/drivers/misc/zynqmp_efuse.c
new file mode 100644
index 00000000000..0cfc42a4f39
--- /dev/null
+++ b/drivers/misc/zynqmp_efuse.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2014 - 2015 Xilinx, Inc.
+ * Michal Simek <michal.simek@amd.com>
+ *
+ * (C) Copyright 2024 Weidmueller Interface GmbH
+ * Lukas Funke <lukas.funke@weidmueller.com>
+ */
+
+#include <compiler.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <zynqmp_firmware.h>
+#include <asm/dma-mapping.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <misc.h>
+
+#define SILICON_REVISION_MASK 0xF
+#define P_USER_0_64_UPPER_MASK	0x5FFF0000
+#define P_USER_127_LOWER_4_BIT_MASK 0xF
+#define WORD_INBYTES		(4)
+#define SOC_VER_SIZE		(0x4)
+#define EFUSE_MEMORY_SIZE	(0x177)
+#define UNUSED_SPACE		(0x8)
+#define ZYNQMP_NVMEM_SIZE	(SOC_VER_SIZE + UNUSED_SPACE + \
+				 EFUSE_MEMORY_SIZE)
+#define SOC_VERSION_OFFSET	(0x0)
+#define EFUSE_START_OFFSET	(0xC)
+#define EFUSE_END_OFFSET	(0xFC)
+#define EFUSE_PUF_START_OFFSET	(0x100)
+#define EFUSE_PUF_MID_OFFSET	(0x140)
+#define EFUSE_PUF_END_OFFSET	(0x17F)
+#define EFUSE_NOT_ENABLED	(29)
+#define EFUSE_READ		(0)
+#define EFUSE_WRITE		(1)
+
+/**
+ * struct xilinx_efuse - the basic structure
+ * @src:	address of the buffer to store the data to be write/read
+ * @size:	no of words to be read/write
+ * @offset:	offset to be read/write`
+ * @flag:	0 - represents efuse read and 1- represents efuse write
+ * @pufuserfuse:0 - represents non-puf efuses, offset is used for read/write
+ *		1 - represents puf user fuse row number.
+ *
+ * this structure stores all the required details to
+ * read/write efuse memory.
+ */
+struct xilinx_efuse {
+	u64 src;
+	u32 size;
+	u32 offset;
+	u32 flag;
+	u32 pufuserfuse;
+};
+
+static int zynqmp_efuse_access(struct udevice *dev, unsigned int offset,
+			       void *val, size_t bytes, unsigned int flag,
+			       unsigned int pufflag)
+{
+	size_t words = bytes / WORD_INBYTES;
+	ulong dma_addr, dma_buf;
+	struct xilinx_efuse *efuse;
+	char *data;
+	int ret, value;
+
+	if (bytes % WORD_INBYTES != 0) {
+		dev_err(dev, "Bytes requested should be word aligned\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (pufflag == 0 && offset % WORD_INBYTES) {
+		dev_err(dev, "Offset requested should be word aligned\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (pufflag == 1 && flag == EFUSE_WRITE) {
+		memcpy(&value, val, bytes);
+		if ((offset == EFUSE_PUF_START_OFFSET ||
+		     offset == EFUSE_PUF_MID_OFFSET) &&
+		    value & P_USER_0_64_UPPER_MASK) {
+			dev_err(dev, "Only lower 4 bytes are allowed to be programmed in P_USER_0 & P_USER_64\n");
+			return -EOPNOTSUPP;
+		}
+
+		if (offset == EFUSE_PUF_END_OFFSET &&
+		    (value & P_USER_127_LOWER_4_BIT_MASK)) {
+			dev_err(dev, "Only MSB 28 bits are allowed to be programmed for P_USER_127\n");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	efuse = dma_alloc_coherent(sizeof(struct xilinx_efuse), &dma_addr);
+	if (!efuse)
+		return -ENOMEM;
+
+	data = dma_alloc_coherent(bytes, &dma_buf);
+	if (!data) {
+		dma_free_coherent(efuse);
+		return -ENOMEM;
+	}
+
+	if (flag == EFUSE_WRITE) {
+		memcpy(data, val, bytes);
+		efuse->flag = EFUSE_WRITE;
+	} else {
+		efuse->flag = EFUSE_READ;
+	}
+
+	efuse->src = dma_buf;
+	efuse->size = words;
+	efuse->offset = offset;
+	efuse->pufuserfuse = pufflag;
+
+	flush_dcache_range((ulong)efuse, (ulong)efuse +
+				   roundup(sizeof(struct xilinx_efuse), ARCH_DMA_MINALIGN));
+	flush_dcache_range((ulong)data, (ulong)data +
+				   roundup(sizeof(struct xilinx_efuse), ARCH_DMA_MINALIGN));
+
+	zynqmp_pm_efuse_access(dma_addr, (u32 *)&ret);
+	if (ret != 0) {
+		if (ret == EFUSE_NOT_ENABLED) {
+			dev_err(dev, "efuse access is not enabled\n");
+			ret = -EOPNOTSUPP;
+			goto END;
+		}
+		dev_err(dev, "Error in efuse read %x\n", ret);
+		ret = -EPERM;
+		goto END;
+	}
+
+	if (flag == EFUSE_READ)
+		memcpy(val, data, bytes);
+END:
+
+	dma_free_coherent(efuse);
+	dma_free_coherent(data);
+
+	return ret;
+}
+
+static int zynqmp_nvmem_read(struct udevice *dev, int offset,
+			     void *val, int bytes)
+{
+	int ret, pufflag = 0;
+	int idcode, version;
+
+	if (offset >= EFUSE_PUF_START_OFFSET && offset <= EFUSE_PUF_END_OFFSET)
+		pufflag = 1;
+
+	dev_dbg(dev, "reading from offset=0x%x, bytes=%d\n", offset, bytes);
+
+	switch (offset) {
+	/* Soc version offset is zero */
+	case SOC_VERSION_OFFSET:
+		if (bytes != SOC_VER_SIZE)
+			return -EOPNOTSUPP;
+
+		ret = zynqmp_pm_get_chipid((u32 *)&idcode, (u32 *)&version);
+		if (ret < 0)
+			return ret;
+
+		*(int *)val = version & SILICON_REVISION_MASK;
+		break;
+	/* Efuse offset starts from 0xc */
+	case EFUSE_START_OFFSET ... EFUSE_END_OFFSET:
+	case EFUSE_PUF_START_OFFSET ... EFUSE_PUF_END_OFFSET:
+		ret = zynqmp_efuse_access(dev, offset, val,
+					  bytes, EFUSE_READ, pufflag);
+		break;
+	default:
+		*(u32 *)val = 0xDEADBEEF;
+		ret = 0;
+		break;
+	}
+
+	return ret;
+}
+
+static int zynqmp_nvmem_write(struct udevice *dev, int offset, const void *val,
+			      int bytes)
+{
+	int pufflag = 0;
+
+	dev_dbg(dev, "writing to offset=0x%x, bytes=%d", offset, bytes);
+
+	if (offset < EFUSE_START_OFFSET || offset > EFUSE_PUF_END_OFFSET)
+		return -EOPNOTSUPP;
+
+	if (offset >= EFUSE_PUF_START_OFFSET && offset <= EFUSE_PUF_END_OFFSET)
+		pufflag = 1;
+
+	return zynqmp_efuse_access(dev, offset,
+				   (void *)val, bytes, EFUSE_WRITE, pufflag);
+}
+
+static const struct udevice_id zynqmp_efuse_match[] = {
+	{ .compatible = "xlnx,zynqmp-nvmem-fw", },
+	{ /* sentinel */ },
+};
+
+static const struct misc_ops zynqmp_efuse_ops = {
+	.read = zynqmp_nvmem_read,
+	.write = zynqmp_nvmem_write,
+};
+
+U_BOOT_DRIVER(zynqmp_efuse) = {
+	.name = "zynqmp_efuse",
+	.id = UCLASS_MISC,
+	.of_match = zynqmp_efuse_match,
+	.ops = &zynqmp_efuse_ops,
+};
-- 
2.30.2

