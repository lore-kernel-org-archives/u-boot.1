Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202BECDE000
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 18:09:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF291849C5;
	Thu, 25 Jun 2026 20:09:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="w6AaJ06e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10F86847C8; Thu, 25 Jun 2026 20:09:13 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20B3E8498B
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 20:09:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnEzT6tIAT/iCu4j6uP9oVPLT+RLoLQfit23BRJQahppDOLgvv5Qnhmtiv4Xav8fP2u+jycRYSfhXdvhIKZ8ZTYg1jkjga5pJbnxqRmgXwmR4+08QEUdI9gqjokcbH3M2ITXBTZATya/nCOy/svYFXUXf4vJZaOxSxGs7GzXKr3dkBTMSdoS+IxjwHlpF5qatMEzjWerv74t6VDtMfJ9lMSJhPN/HHKxDO7Q6c7657cYHGbn9HDlKgW7cIncWNIrI8OBT5PNCoVp79Cn/hy2jSKn+ppCpXJvBHNKTsfwljqwR1Ghso7tJ5Erad9pAZB6gWWmAPFDE59acqZHVFMnGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQwAovr+QAS7lY1hS4rhEFG52/ZZseEWy3jxRwqFKjM=;
 b=COOhYVEm7oA3MMoQfrSsg1clrcg2DHeBlttOPw9dlucL3vF2QmtHJHLZucM8lyH2D6lrgkyn8TnDICMRDEWZfQJdTDNLFyR1TDbmGuGx1hBMOuQNQBAZVN9wgsGKQoc1umxTqbFFV/7RZj95oOvmdkvaX/LS/TONgmT8GUCYSxLGlPsI9qicjCXXrq8R4IgVJDXhPfVW9mAHnDizgRM6u93aq1iAoGXvjCiEmf30BQxpiKe2Lbc4Ww0uuKyXv4uJL5dJu9KyLXmeAgPPGvajFLEeZlyKkNK70JxiRq2/kc3M6mFdNF2R+w7/Cl8s3/CzpnbpUSeiv/+5saf938PY1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQwAovr+QAS7lY1hS4rhEFG52/ZZseEWy3jxRwqFKjM=;
 b=w6AaJ06eb74VWEks/caBwXsKxKczCS00gKsHj+NGO6fjOd05Ja2XxR/uZPDTlq/CmNb+yfmAB5S/uTj7fBPcMUi/laB+lb+GPtSK35tfWHH3NjaNohccQR+LxzVgQvD7cyy6VQiVjnIst/41vrKMh/L18UV4hLsCIDcez28Fpgt0A740xbW7sQfmpttieEfYZ/hQ4jkNGW2jNMlRvhrnlBVlUL7VTis5XtD3UWI1B/hoAv8B7WSAq2yv5XY7LUzGE4Slkxng73F7fVSoX1t6R3nePZkDBCiK4hQIPPR3ZtTxQyS2VMswiN0biTTZ1aSTiiLJRhL7amBkVuBaTxoSGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by LV3PR03MB7357.namprd03.prod.outlook.com (2603:10b6:408:195::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 18:09:02 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 18:09:02 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>
Subject: [PATCH 2/4] ARM: socfpga: Add default FIT images for Arria 10 SoCDK
Date: Fri, 26 Jun 2026 02:08:24 +0800
Message-Id: <787bcf850ab229881329f0021d8ae33716d9673a.1782410782.git.dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1782410782.git.dinesh.maniyam@altera.com>
References: <cover.1782410782.git.dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0205.namprd05.prod.outlook.com
 (2603:10b6:a03:330::30) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|LV3PR03MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c4e2d5-4c25-4006-29c1-08ded2e4d5e4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|56012099006|11063799006|6133799003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: RWNq4e9FQFxdKbCGZsE7pGTceDfEiJeAo6SVlEXbQ36c7X7FQpO4aHjDk4Itm6CVJ3BXUsAl7dbvQCwCwY1yWEaIYGpFGFlCrQU35+2sFkoMrrrbnl/NCVIoJ0+ittI/8h4jaY6slIpi3sjm1hHuZcJCDNdYUpJQqIVeybOwZhuI5jq31kDmih9EHrbjt5iMPG74ScbYsbxh1n3TlK4dnDOXevykC/6pAGcd2dY3NJffCc1wPn3WdOAEpR+TUxsIyolNawwwYGo4kFccjt2ihnmjz9pO8IPERKi2oDnz7onMFppLUvEBBdQWkpfCI3kXHtrNY2xSTxT0FJdOTTL5XPv4lRrlqzaiN3JKGsGN/50nPyL4GgLcMNF78Hn//BYpmz0bs2XP+/pZdtfexv0EJgA5znFygVPTuru834LYFVZM8ErZ9dNEH7au+zw5ITqAJ0fCc7323bsIiE969TuU7akvy4ghlG5RofFNA0PzJq+dSqAvzS0ikkhhC1Tl1fcn62PFeeXuQbP/BiErN4i/42/tpxlrITA5k7K8nZ3YpatSDq8r44UiiWmhEYJZcEb+C2fz8ipPy9lzG/xOhA6NvovoM3+zDX1DCgUcxtAxWD8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lUFXNt20xV3VHKha9QiAu6roWpadlKsHKos/J57fLhthAkVljeal71ORx0WO?=
 =?us-ascii?Q?OozdZpun0ivDFQgo5vho3tnMjLVOn8F3FSGt1eYw6YmYHU6RXCG6Mc+hSs2V?=
 =?us-ascii?Q?MLuwCeyknDy8WxLZqvZPxtxZPbP4qvwi9M9JKtfLkLgLqzTiNpzcn5qADw2X?=
 =?us-ascii?Q?imyZRMhCduBuB2CRNF2RoeuiLSLMi3Fdi0FcUTdNBqFUTWjaxBrRjqBTMKEG?=
 =?us-ascii?Q?4PLicYlaDiGGCi6lKgAutBS2+DtRo+jC4hOMD4b4nUH0uaOQC5KtWFczbCGx?=
 =?us-ascii?Q?/3bwRHdcNR4zXJMKHL/G8rd56oCTivGOBzhz9KIOdnZ1+ZKTv1o7AovSbvYH?=
 =?us-ascii?Q?KQ+4wdaYzaluACA1bGppyn65JB4JCdi3ByDKCLlXDhAceR9I52UXX3PK5pyR?=
 =?us-ascii?Q?QYckE4dV+mlolsjcI+Bh00T86qK173+KQY3FYo5FoiExPUz9EPxFsqAcvhf0?=
 =?us-ascii?Q?7b5YEK+ayq80HHvmiOuwzQWxtaWZrQ1AICytb1mPeBbACucS2vkbtIx7r/41?=
 =?us-ascii?Q?sLqjv6qlZ9+3Up7QaNkP5pGaMdulHcBSRQyDchq7i0zt2grWgoaMoF6UZwpu?=
 =?us-ascii?Q?aHEv8Q7Vp4ZteUkDEIdFy/3Zf9Q6bp+HSq5YxZuvgoApSqsf9b00+O7EPV8A?=
 =?us-ascii?Q?+GoAfmnH8aVbqnjuhEFX947xj1SDW6A1iNeuLqf+7E6r2v3KCXYEeuMLPnE3?=
 =?us-ascii?Q?yrxOkF9l5+jEDPhxQy71236wHWg9QDun2zpvNJsBCflUEJKDvSxYNM/g6v39?=
 =?us-ascii?Q?dDRTxVyijvEdJrOSFZB7GzX/XtwD0p+6sDPRydnZSE5idA5WFqC8iOfYkQPV?=
 =?us-ascii?Q?H0PskZq7ApHOnmkJYPNlOHcT93kP5FKOZjCVQ1RUB4hhbs9YUb9ANx/ve6E3?=
 =?us-ascii?Q?lSuIXzea+fnku/aSxDIbWzGViJHc6GEy6jQG2SvVW8mXQ7OoZbqsU9kzCdow?=
 =?us-ascii?Q?hOMzNBsigjM2KacidS33CAQdQXfiPC2wUGxnZdG/bf4qMXD2ZDqE8aVnKM+/?=
 =?us-ascii?Q?tAD6SLiem5nW12rvWOJikTetePDZMJuyle7rRIyAx6RkNY+uWiS+ZC0DlnX5?=
 =?us-ascii?Q?hoQM7QitvSGa1oJtzTRgy/y3dwKHVwzDQO+q03R/2pOd4XzbPa3kJqnHEPyB?=
 =?us-ascii?Q?BnjURPXTcjn17w/yv4y6empBVSFVQHmT0/E9yBXCrrA+FX6LmJrAEBy4FXyH?=
 =?us-ascii?Q?ueWs/LpqBKdKHa5RG6a720jm5FT2LihqLjWvUlBzHulOu+LjA0lIdUMcIeMI?=
 =?us-ascii?Q?3cA4pFj6NZRO6gTA5VkJDrB0wGcf1dtTZexZFkxAAOCSIodh2U/6+iF2G3RN?=
 =?us-ascii?Q?v6sGSNGNxk2/J65wZI8Z+8yjTGCrszGk0z02zfAOJJL/hkYd06FtmsD0IWMc?=
 =?us-ascii?Q?iS2y5bH5tpjlDJmnptxAOoN5d+eNlBEONlEL35AFFhyD7JGaJbWo9UDNCPxJ?=
 =?us-ascii?Q?PHDloWW/8fLCoxNTNZBGbr7BLRcVzDYRko+EjicUhpiqA+FpXDZ6cWvG6xUR?=
 =?us-ascii?Q?Ahfa8MmvrzXUu+PGRF00nlqxp77bmb5L94odEyIqN0d+HbC3P0nbjsGpila3?=
 =?us-ascii?Q?qLzeWU88tE6j+a/Zh3ZFtsaXkIeYZU6LHL+hCtfRdl7piZSxoC8OHaEhrNbV?=
 =?us-ascii?Q?MxLZV/TJ2TQ8WDTcS0EXeamsqwwtT9LQWjsB8nzoBX91XsRit27ep3TcNJlC?=
 =?us-ascii?Q?5VVPLyE1UKaIaSnTeqBqAoLEBCmVQUidqoChHcFRTDaeR/0JmWKqlpU6t+WF?=
 =?us-ascii?Q?cmIDFH4dQklACGLISs88GA/aUCcDL8g=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c4e2d5-4c25-4006-29c1-08ded2e4d5e4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 18:09:01.9227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GV3arKoTeJIZpYZ/EO3L2sxV4JeJ9UEhojLogpezLhg2q0mvWpABOezIS3tNfOQAUok8dcLe3Dp6nanXYUG1f7aDfIkfTDKcqdoAbOjkaS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7357
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

This introduces default FIT images for U-Boot and the Linux kernel,
allowing a consolidated boot flow using mkimage-generated FIT binaries.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 .../altera/arria10-socdk/fit_kernel_nand.its  | 44 +++++++++++++++++++
 .../altera/arria10-socdk/fit_kernel_qspi.its  | 44 +++++++++++++++++++
 board/altera/arria10-socdk/fit_uboot.its      | 43 ++++++++++++++++++
 3 files changed, 131 insertions(+)
 create mode 100644 board/altera/arria10-socdk/fit_kernel_nand.its
 create mode 100644 board/altera/arria10-socdk/fit_kernel_qspi.its
 create mode 100644 board/altera/arria10-socdk/fit_uboot.its

diff --git a/board/altera/arria10-socdk/fit_kernel_nand.its b/board/altera/arria10-socdk/fit_kernel_nand.its
new file mode 100644
index 00000000000..f01aa67b7c4
--- /dev/null
+++ b/board/altera/arria10-socdk/fit_kernel_nand.its
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Altera Corporation
+ *
+ */
+
+/dts-v1/;
+
+/ {
+	description = "FIT image with kernel and DTB";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			description = "Linux Kernel";
+			data = /incbin/("../../../Image");
+			type = "kernel";
+			os = "linux";
+			arch = "arm";
+			compression = "none";
+			load = <0x8000>;
+			entry = <0x8000>;
+		};
+
+		fdt {
+			description = "Linux DTB";
+			data = /incbin/("../../../socfpga_arria10_socdk_nand.dtb");
+			type = "flat_dt";
+			os = "linux";
+			arch = "arm";
+			compression = "none";
+
+		};
+	};
+
+	configurations {
+		default = "conf";
+		conf {
+			description = "Linux boot configuration";
+			kernel = "kernel";
+			fdt = "fdt";
+		};
+	};
+};
diff --git a/board/altera/arria10-socdk/fit_kernel_qspi.its b/board/altera/arria10-socdk/fit_kernel_qspi.its
new file mode 100644
index 00000000000..e28b60cd0ac
--- /dev/null
+++ b/board/altera/arria10-socdk/fit_kernel_qspi.its
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Altera Corporation
+ *
+ */
+
+/dts-v1/;
+
+/ {
+	description = "FIT image with kernel and DTB";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			description = "Linux Kernel";
+			data = /incbin/("../../../Image");
+			type = "kernel";
+			os = "linux";
+			arch = "arm";
+			compression = "none";
+			load = <0x8000>;
+			entry = <0x8000>;
+		};
+
+		fdt {
+			description = "Linux DTB";
+			data = /incbin/("../../../socfpga_arria10_socdk_qspi.dtb");
+			type = "flat_dt";
+			os = "linux";
+			arch = "arm";
+			compression = "none";
+
+		};
+	};
+
+	configurations {
+		default = "conf";
+		conf {
+			description = "Linux boot configuration";
+			kernel = "kernel";
+			fdt = "fdt";
+		};
+	};
+};
diff --git a/board/altera/arria10-socdk/fit_uboot.its b/board/altera/arria10-socdk/fit_uboot.its
new file mode 100644
index 00000000000..89c8ea92568
--- /dev/null
+++ b/board/altera/arria10-socdk/fit_uboot.its
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Altera Corporation <www.altera.com>
+ *
+ */
+
+/dts-v1/;
+
+/ {
+	description = "FIT image with boot binaries";
+	#address-cells = <1>;
+
+	images {
+		uboot {
+			description = "U-Boot (32-bit)";
+			data = /incbin/("../../../u-boot-nodtb.bin");
+			type = "standalone";
+			os = "U-Boot";
+			arch = "arm";
+			compression = "none";
+			load = <0x01000040>;
+			entry = <0x01000040>;
+		};
+
+		fdt {
+			description = "U-Boot DTB";
+			data = /incbin/("../../../u-boot.dtb");
+			type = "flat_dt";
+			os = "U-Boot";
+			arch = "arm";
+			compression = "none";
+		};
+	};
+
+	configurations {
+		default = "conf";
+		conf {
+			description = "Altera Arria10 SoCDK";
+			loadables = "uboot";
+			fdt = "fdt";
+		};
+	};
+};
-- 
2.43.7

