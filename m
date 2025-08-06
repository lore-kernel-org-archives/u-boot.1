Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFD0C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 05:29:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9A2B842AD;
	Wed,  6 Aug 2025 07:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="B4rcnNCh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CBDF83987; Wed,  6 Aug 2025 06:34:18 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32E8B83989
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 06:34:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIwvTf64+gTo9oVrTwYWgrJqd7Jo5mCu546o0w1yk/AAJ18D2fqDtZ+15dUZBxmZrvDkbeALSw+9GMdpIfWd1pUdeWsRDNI55P9kih+nH29UKdl+XYjkqkJAckibfZnFKqXT3DCCGPekehM59ieVKOUemXaSGbdouhWf9R/XqpuPNPHThTl1fHIUK18xWq4wsSTQi5o4eni1TbGlyxtThKbmBwjNMrzDzIH66y3noB6QcIjqwIfUwgRagZz8JI3xGIRpLO8gifJYOoXGUBkWOQEreqJwkNVzYOegCOlucsa26jIysWtceym12pXxmmkXyXLRdep1bgOFOu8mjmMJ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjTESo/Mz7HeTb28vjK89UnJ12vRllxCC8rrnI5ieXQ=;
 b=uB4dYWkoUAZZVuabqRnXmyQEOdn1FA9JJodkxbZGNkD7RS5+IxPEsi0GQsLwowcd/HvYUHZwDJV477/XJwED6ucl/x4CKhqogQFv1zJ2hXmwEVAnZRVsSB8RtT0ZkBm5mh9ghsSnNVQxTNVluY/BHAnFQ7GgD4xZ/Gj6Qjn7Is20j6xC+9cLsLA+zXw+t5Wo/WERIrPFwyf7lKuei2h0uFvHkT5yu26oiWbOScAq4foYtH4v8WqFGQMMp8nHLOvUcWv2AZf4GZuLm0goXc8/uKZFF5g4HxZUW7v/2cgUkPOFameyEgc+g4mi7hcVM9RKNoROh6W9lruj1dMwqUVrog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjTESo/Mz7HeTb28vjK89UnJ12vRllxCC8rrnI5ieXQ=;
 b=B4rcnNChGpWohALOPzpiHMwyf7JTCnkJQuv7laN0ym1XkpTDMK3Ye9iDwPs7s81L0J5UE9ysbYYUziAT3qM96+XxDRdyDfQyAxK86vTa/ke7f8hXY26XuPUsGEcKtyofPOnMLJYj9jhd31rt//ibiwmTgZf2ZNR60BcKKwr0dWU6wzp9XFAt0UgobU2XM39tJ5IWRa2oJw6VV/xzv0EBX+V73OZI7nXfgsA1EAPohn1N4nk3K3lUHr/AiQM0mlouJqhrA+y+vldM/QxGpRecF0ovwU+hFWuqSYkdi528UVYOeklZdLS0cFgvWTC36QNliGqN2pI2uScXHSGOzAqt7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BY5PR03MB5202.namprd03.prod.outlook.com (2603:10b6:a03:220::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 04:33:59 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 04:33:59 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v8 09/12] cmd: Add i3c command support.
Date: Wed,  6 Aug 2025 12:32:32 +0800
Message-Id: <20250806043235.2260-11-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250806043235.2260-1-dinesh.maniyam@altera.com>
References: <20250806043235.2260-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:40::32) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BY5PR03MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aeadb1e-8311-4940-13a9-08ddd4a27637
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AWcnDQY/k2OqmAA0qDocYau7yQkLvWtgKBIpYCkCZOXVLJkuHqW93cKXWuny?=
 =?us-ascii?Q?viF2b3kulG+HXE7gc66wS0YKdOH3PJOimNK0jEk371IKi5Ccow8FZKWRuYv0?=
 =?us-ascii?Q?2TrqqOHjYHPixDjsDBTDXt3YGL84iURC5ESTL+r6XGyp45tEWbjjx4EX1o8n?=
 =?us-ascii?Q?sOIIyhvIsgL7zyNO6JzZw1lr/LozS0eM95T/V2T4li/KVS0Ml9iGMSoFMOJs?=
 =?us-ascii?Q?oCIOwoTcFcvOddZw5kMAj1hF07oA1obVZnx4pL6CNgzm25HBIR9M2sgMP7CL?=
 =?us-ascii?Q?y2WCItj2UOauvNxvZcp0QgbGPGatUZwTSEQ1VhIOCTzxvn5DL6uwAaWIn5e8?=
 =?us-ascii?Q?4cYttqZlxD+p5cX75umbliHX37h2+MBjwHlk3btKTjxpDCHZ/m6xX/+CK4dt?=
 =?us-ascii?Q?wnYcoIxhqnF8/nhEb2VD+ATKUrBcHqNiusBKqSlBi3bsHTro6wawSoVUp+J7?=
 =?us-ascii?Q?LGidzeAl9U5G2Ry6hRpmfckDhnu2jvu+/1CiWVBJ5SdJq+cjToMPMrpBKdjw?=
 =?us-ascii?Q?SNj3ob2Fw/8sTNMeH/HiU3VHVjx6t9QOOYGiGnCudhatLF6T8jz9ZSD3l1Vt?=
 =?us-ascii?Q?2vKcCPaavFgRmVi8Ew+pXoK7lUooqBFGmazSz8LvLropWxM39uEl40MREE2U?=
 =?us-ascii?Q?BMEuBvuISCfF+GIH3FJQYPCkXS10CCuS+vH0zveL1AjrlS0X+nLw/aRKyrFl?=
 =?us-ascii?Q?OJQKag+xjYp7UnFmK+/KSpajDm4NXvIIAQDLBPHMho0sRZn255UCBYTra8Sv?=
 =?us-ascii?Q?o2dutYVTbftuOoiW36xtaLpSGCgTfPN3vp3TEJezWpztZxB9PaiCp4HabcGy?=
 =?us-ascii?Q?NKcrcZumZeiTwgP+DWOfCcPz59Hkd2p4cQQflB7+tt/G29pbL52nrBtGpcEP?=
 =?us-ascii?Q?y3DnY/eSc4DyJqTkp1tY2EpuN/2I3KxO0SX2/mHT7vrFVs6oCxixbCnwJEGb?=
 =?us-ascii?Q?nldPDcuVquFjo0HlZyWIOLHoZL8POj353qQ5Wa8kj1h6eWUW1lLYA0i5SdqC?=
 =?us-ascii?Q?LLhnbF/RAYezXXheYVc1Y3HNB5wD6+bW0E+MOAu1GyokTkvDhiw9pNkuRjuD?=
 =?us-ascii?Q?vAMOaBbU0pG2x5cvToD7uBkr/CAGm7aVikJvCoxMbSG+KjWYHkr5yB/Lr+8c?=
 =?us-ascii?Q?79gMt8acGMNzRG0mBWGirpoKQ3M+Uqla1hQ/Hei8jyRgJcg5faj2fwNdOasN?=
 =?us-ascii?Q?QIVcOYlGnIVA49REVcvhU2gEw5+WryNozETjzDG7cQe3w3jYWpO2qzG+01ZW?=
 =?us-ascii?Q?9Yf3Jt9yesr5MQMbdbx6qOc8mbIPEH0yLEgKmUq0onWASmquRKtVT9K3mfdO?=
 =?us-ascii?Q?pir/Q5Sl4xxe7T6i2MXoQjAGRHZfCCPTdTmZfdqVslb0UVGGL3mMEsl4JsXM?=
 =?us-ascii?Q?hI4VRBwKtmR0LoS0Te7J/V5tBwWFVfEAm4JrKAZ5Jl7uI1ImYX6HUzwGjgVt?=
 =?us-ascii?Q?3Gfte4owZFk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6guwCJSt1DbEruWtWG7eH9uWyRMCe1s8q5u7CvNAlNPfaeAMTPiGsUKnpHZx?=
 =?us-ascii?Q?XXVpIczpp5xBE4sOFERv7T1cXFDzM9skMlvVtwidapeA8/VaU/IO4s/+wivH?=
 =?us-ascii?Q?hgWePx3RkYaxRs/qbnVKfUpQC06/Fc+mloXM92ffC7YQZOnzZPEin4bOZbDF?=
 =?us-ascii?Q?xR+WRtLoMKlLYYbif516yymAyzuT3avOh7D28CNIGZTg49JYMcM4e34vbA6z?=
 =?us-ascii?Q?4PrbTH8jRZk2VMJwIcyY3eDI+bHEqCqoCTy2ohjixaX3yDJrBymRfb5Wz2Fu?=
 =?us-ascii?Q?3XTHMjdElv/Pi4tTHW11ae2Y75hxLIazPiy7E78SJmbJZh3jYHdCD4/13frq?=
 =?us-ascii?Q?ITZMQd8XfvpZhDp5WDEViHqCxUSqmIDPpdm00jSGtoMhKguLaFZSk6o1i38b?=
 =?us-ascii?Q?9GTP/QedruQ0aQ1kyyDpmlxwQ3LYFVTR2SslozGdXDbToiSfbEG9qtD+khkx?=
 =?us-ascii?Q?wUB7U/gvnaNhXJQjn56DObKwUO1nI/xno3NUvG1j5hAyWSQ6sTwYYmhwhVAT?=
 =?us-ascii?Q?o/adHzLOr0X9xktAvLJ93VYVghYMI7gNkC8NmKYO7jOPhoBo3UskM/uRLzn8?=
 =?us-ascii?Q?HI6MV73xHvzEI0yHD2VUR6MUGl3ZZBjidCiHiUnIKyBLz8mkSxbxgnHcpB+Y?=
 =?us-ascii?Q?zmCEKewS1uEzGOotiuQsoR6wvJY4QkAHjrESkUZPDx+gedXn5mD7EY56U2Bh?=
 =?us-ascii?Q?0XRMAoimnktL/T7GgsJSeSdEFUpLlRUux9ZZlExGuUaDnU88Qeb0EN/WTxE4?=
 =?us-ascii?Q?QtwUuTsJglBu03V0bxtNxAXGHJhKzVNhdbKg1sKL2Go6NflKQDPIU+t2TW7U?=
 =?us-ascii?Q?mqcaMk2v1v/Rgkhv+1RcVvm0qFvplXVoroxHvsRQYAUzmp8gucP01xLLY6C3?=
 =?us-ascii?Q?DqWZ/4GXAyg9PwUTF8jFgAqWWR7VEl6sHkyTAz7x73DU8cwk+gvQ12587yLj?=
 =?us-ascii?Q?JhwVslYrkn3ICpb6JIxh72MBH1jhG+Ge7JTViyzw6xemNiGu+7gu4g9I13Rt?=
 =?us-ascii?Q?9uoc441eVks3wmPXb8CnggNTGaxPAsKIZKVXtyHJFz9M9V+ChmIo5W8Sy2Rb?=
 =?us-ascii?Q?BH3ZbMos+6NMGWFMtL2DM6JByWr+BS6rvkmWhe3B09WRLyjXjTLyEWfImXwy?=
 =?us-ascii?Q?PxaCj68Pvo0PpiBrdUJUHmedFvwdkJ1V31sZEW8cUh/JnbnPia4VL6gEzEls?=
 =?us-ascii?Q?bGHdvLdwr9pKQ6O8hJrjQdIgSxJaRu/h52klcbxFrJOQdSsZZ0d5fqVa8TVW?=
 =?us-ascii?Q?vUarh9pGcilJWqfKlusIXqRpPNUdNIPeYekhihp9OcyTprseSFPkHKJR6ggX?=
 =?us-ascii?Q?MHo2JHGd4fNWygmxA4tsR7IdgZrNd/oirvBB/ri+JUP44aKEyv3X39Ax35lY?=
 =?us-ascii?Q?HrdEv3SGKyX3lHFbnSSq0hT9XNexryQ1bIreGGUoCc7W67rT460SkansqtVu?=
 =?us-ascii?Q?g/MkA7pr/p3J/mAgt7uDxOHOmeNE+hPrdkwf8lcmRVXxoZ/eiZIQi0oRDQPr?=
 =?us-ascii?Q?T77/L+94UrMSWLwFFjuOqiqb0ezc4Fip07edNdkmNO0URVjV6u9OKe9jPraN?=
 =?us-ascii?Q?+GSa8MvCbMeYH2oX5SWAol2OzKGRpVA+FKbpC2JTPUJO9cuWhze8kIWekvKF?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aeadb1e-8311-4940-13a9-08ddd4a27637
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 04:33:59.2956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uh26gXedw0wL/gLZI2JrqfjP4hFD4JegOBbQTrVpL2IK2kwAI2G+XPkjLn7nSv3PD6R1VCu0A8aHo3xMJPdVvAbkYqzD/W81gYiWiclh4rA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5202
X-Mailman-Approved-At: Wed, 06 Aug 2025 07:25:39 +0200
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

Add i3c command file to support select, get i3c device
target list, read and write operation.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 cmd/Kconfig                        |   7 +
 cmd/Makefile                       |   1 +
 cmd/i3c.c                          | 271 +++++++++++++++++++++++++++++
 doc/usage/cmd/i3c.rst              | 146 ++++++++++++++++
 doc/usage/index.rst                |   1 +
 drivers/i3c/master/dw-i3c-master.c |  35 +++-
 include/dw-i3c.h                   |   2 +
 include/i3c.h                      |  28 ++-
 8 files changed, 489 insertions(+), 2 deletions(-)
 create mode 100644 cmd/i3c.c
 create mode 100644 doc/usage/cmd/i3c.rst

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 642cc1116e8..f5e235ff1c8 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1327,6 +1327,13 @@ config CMD_I2C
 	help
 	  I2C support.
 
+config CMD_I3C
+	bool "i3c"
+	depends on I3C
+	help
+	  Enable command to list i3c devices connected to the i3c controller
+	  and perform read and write on the connected i3c devices.
+
 config CMD_W1
 	depends on W1
 	default y if W1
diff --git a/cmd/Makefile b/cmd/Makefile
index 8410be576bb..082470fa104 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_CMD_GPIO) += gpio.o
 obj-$(CONFIG_CMD_HISTORY) += history.o
 obj-$(CONFIG_CMD_HVC) += smccc.o
 obj-$(CONFIG_CMD_I2C) += i2c.o
+obj-$(CONFIG_CMD_I3C) += i3c.o
 obj-$(CONFIG_CMD_IOTRACE) += iotrace.o
 obj-$(CONFIG_CMD_HASH) += hash.o
 obj-$(CONFIG_CMD_IDE) += ide.o disk.o
diff --git a/cmd/i3c.c b/cmd/i3c.c
new file mode 100644
index 00000000000..08957f4d447
--- /dev/null
+++ b/cmd/i3c.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <bootretry.h>
+#include <cli.h>
+#include <command.h>
+#include <console.h>
+#include <dm.h>
+#include <dw-i3c.h>
+#include <edid.h>
+#include <errno.h>
+#include <hexdump.h>
+#include <log.h>
+#include <malloc.h>
+#include <asm/byteorder.h>
+#include <linux/compiler.h>
+#include <linux/delay.h>
+#include <u-boot/crc.h>
+#include <linux/i3c/master.h>
+#include <linux/printk.h>
+#include <linux/types.h>
+
+static struct udevice *currdev;
+static struct udevice *prevdev;
+static struct dw_i3c_master *master;
+
+static void low_to_high_bytes(void *data, size_t size)
+{
+	u8 *byte_data = data;
+	size_t start = 0;
+	size_t end = size - 1;
+
+	while (start < end) {
+		u8 temp = byte_data[start];
+
+		byte_data[start] = byte_data[end];
+		byte_data[end] = temp;
+		start++;
+		end--;
+	}
+}
+
+static int handle_i3c_select(const char *name)
+{
+	struct uclass *uc;
+	struct udevice *dev_list;
+	int ret = uclass_get_device_by_name(UCLASS_I3C, name, &currdev);
+
+	if (ret) {
+		currdev = prevdev;
+		if (!currdev) {
+			ret = uclass_get(UCLASS_I3C, &uc);
+			if (ret)
+				return CMD_RET_FAILURE;
+
+			uclass_foreach_dev(dev_list, uc)
+				printf("%s (%s)\n", dev_list->name, dev_list->driver->name);
+
+			printf("i3c: Host controller not initialized: %s\n", name);
+			return CMD_RET_FAILURE;
+		}
+	} else {
+		master = dev_get_priv(currdev);
+		printf("i3c: Current controller: %s\n", currdev->name);
+		prevdev = currdev;
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+static int handle_i3c_list(void)
+{
+	struct uclass *uc;
+	struct udevice *dev_list;
+	int ret = uclass_get(UCLASS_I3C, &uc);
+
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	uclass_foreach_dev(dev_list, uc)
+		printf("%s (%s)\n", dev_list->name, dev_list->driver->name);
+
+	return CMD_RET_SUCCESS;
+}
+
+static int handle_i3c_current(void)
+{
+	if (!currdev)
+		printf("i3c: No current controller selected\n");
+	else
+		printf("i3c: Current controller: %s\n", currdev->name);
+
+	return CMD_RET_SUCCESS;
+}
+
+static int handle_i3c_device_list(void)
+{
+	if (!master) {
+		printf("i3c: No controller active\n");
+		return CMD_RET_FAILURE;
+	}
+
+	for (int i = 0; i < master->num_i3cdevs; i++) {
+		struct i3c_device_info *info = &master->i3cdev[i]->info;
+
+		printf("Device %d:\n", i);
+		printf("  Static Address  : 0x%02X\n", info->static_addr);
+		printf("  Dynamic Address : 0x%X\n", info->dyn_addr);
+		printf("  PID             : %016llx\n", info->pid);
+		printf("  BCR             : 0x%X\n", info->bcr);
+		printf("  DCR             : 0x%X\n", info->dcr);
+		printf("  Max Read DS     : 0x%X\n", info->max_read_ds);
+		printf("  Max Write DS    : 0x%X\n", info->max_write_ds);
+		printf("\n");
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+static int handle_i3c_write(int argc, char *const argv[])
+{
+	u32 mem_addr, num_bytes, dev_num_val;
+	u8 device_num;
+	u8 *data;
+	int ret;
+
+	if (argc < 5)
+		return CMD_RET_USAGE;
+
+	if (!currdev) {
+		printf("i3c: No I3C controller selected\n");
+		return CMD_RET_FAILURE;
+	}
+
+	mem_addr = hextoul(argv[2], NULL);
+	num_bytes = hextoul(argv[3], NULL);
+	dev_num_val = hextoul(argv[4], NULL);
+
+	if (num_bytes == 0 || num_bytes > 4) {
+		printf("i3c: Length must be between 1 and 4\n");
+		return CMD_RET_USAGE;
+	}
+
+	if (dev_num_val > 0xFF) {
+		printf("i3c: Device number 0x%x exceeds valid u8 range\n", dev_num_val);
+		return CMD_RET_USAGE;
+	}
+
+	device_num = dev_num_val;
+	data = malloc(num_bytes);
+
+	if (!data) {
+		printf("i3c: Memory allocation failed\n");
+		return -ENOMEM;
+	}
+
+	memcpy(data, (void *)(uintptr_t)mem_addr, num_bytes);
+	low_to_high_bytes(data, num_bytes);
+
+	ret = dm_i3c_write(currdev, device_num, data, num_bytes);
+
+	if (ret)
+		printf("i3c: Write failed: %d\n", ret);
+
+	free(data);
+	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
+}
+
+static int handle_i3c_read(int argc, char *const argv[])
+{
+	u32 mem_addr, read_len, dev_num_val;
+	u8 device_num;
+	u8 *rdata;
+	int ret;
+
+	if (argc < 5)
+		return CMD_RET_USAGE;
+
+	if (!currdev) {
+		printf("i3c: No I3C controller selected\n");
+		return CMD_RET_FAILURE;
+	}
+
+	mem_addr = hextoul(argv[2], NULL);
+	read_len = hextoul(argv[3], NULL);
+	dev_num_val = hextoul(argv[4], NULL);
+
+	if (read_len == 0) {
+		printf("i3c: Read length must be greater than 0\n");
+		return CMD_RET_USAGE;
+	}
+
+	if (dev_num_val > 0xFF) {
+		printf("i3c: Device number 0x%x exceeds valid u8 range\n", dev_num_val);
+		return CMD_RET_USAGE;
+	}
+
+	device_num = dev_num_val;
+	rdata = malloc(read_len);
+
+	if (!rdata) {
+		printf("i3c: Memory allocation failed\n");
+		return -ENOMEM;
+	}
+
+	ret = dm_i3c_read(currdev, device_num, rdata, read_len);
+
+	if (ret) {
+		printf("i3c: Read failed: %d\n", ret);
+		free(rdata);
+		return CMD_RET_FAILURE;
+	}
+
+	memcpy((void *)(uintptr_t)mem_addr, rdata, read_len);
+	print_hex_dump("i3c read: ", DUMP_PREFIX_OFFSET, 16, 1,
+		       (void *)(uintptr_t)mem_addr, read_len, false);
+
+	free(rdata);
+	return CMD_RET_SUCCESS;
+}
+
+static bool is_i3c_subcommand(const char *cmd)
+{
+	return !strcmp(cmd, "write") ||
+	       !strcmp(cmd, "read") ||
+	       !strcmp(cmd, "device_list") ||
+	       !strcmp(cmd, "list") ||
+	       !strcmp(cmd, "current");
+}
+
+static int do_i3c(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	const char *subcmd = argv[1];
+
+	if (!is_i3c_subcommand(subcmd))
+		return handle_i3c_select(subcmd);
+
+	if (!currdev) {
+		printf("i3c: No I3C controller selected\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (!strcmp(subcmd, "list"))
+		return handle_i3c_list();
+	else if (!strcmp(subcmd, "current"))
+		return handle_i3c_current();
+	else if (!strcmp(subcmd, "device_list"))
+		return handle_i3c_device_list();
+	else if (!strcmp(subcmd, "write"))
+		return handle_i3c_write(argc, argv);
+	else if (!strcmp(subcmd, "read"))
+		return handle_i3c_read(argc, argv);
+
+	return CMD_RET_USAGE;
+}
+
+U_BOOT_CMD(
+	i3c, 5, 1, do_i3c,
+	"access the system i3c",
+	"i3c write <mem_addr> <length> <device_number> - write from memory to device\n"
+	"i3c read <mem_addr> <length> <device_number> - read from device to memory\n"
+	"i3c device_list - List valid target devices\n"
+	"i3c <host_controller> - Select i3c controller\n"
+	"i3c list - List all available i3c controllers\n"
+	"i3c current - Show current i3c controller"
+);
diff --git a/doc/usage/cmd/i3c.rst b/doc/usage/cmd/i3c.rst
new file mode 100644
index 00000000000..922fa3ea37c
--- /dev/null
+++ b/doc/usage/cmd/i3c.rst
@@ -0,0 +1,146 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. index::
+   single: i3c (command)
+
+i3c command
+===========
+
+Synopsis
+--------
+
+::
+
+    i3c <host_controller>
+    i3c current
+    i3c list
+    i3c device_list
+    i3c write <mem_addr> <length> <device_number>
+    i3c read <mem_addr> <length> <device_number>
+
+Description
+-----------
+
+The ``i3c`` command is used to probe the i3c host controller and perform
+read and write operations on the connected i3c devices.
+
+i3c current
+------------
+
+Display the currently selected i3c host controller.
+
+i3c list
+---------
+
+List all the i3c hosts defined in the device-tree.
+
+i3c device_list
+----------------
+
+List all the i3c devices' device number, static address, dynamic address,
+PID, BCR, DCR, Max Write Speed, and Max Read Speed of the probed i3c host
+controller.
+
+i3c write
+----------
+
+Perform a write operation from memory to the connected i3c device. The data
+is read from a specified memory address and written to the selected i3c
+device, which is identified by its device number.
+
+You need to provide the memory address (``mem_addr``), the length of data
+to be written (``length``), and the device number (``device_number``). The
+data in memory will be transferred to the device in the specified order.
+
+i3c read
+---------
+
+Perform a read operation from the connected i3c device to memory. The data
+is read from the selected i3c device and stored at the specified memory
+address. You need to provide the memory address (``mem_addr``), the length
+of data to be read (``length``), and the device number (``device_number``).
+
+The device will send the requested data, which is then written to the memory
+location you specified. This operation allows you to retrieve information
+from the device and use it in your application. The data is read in the
+order specified and can be multiple bytes.
+
+host_controller
+    The name of the i3c host controller defined in the device-tree.
+
+length
+    The size of the data to be read or written.
+
+device_number
+    The device number in the driver model of the device connected to the i3c
+    host controller.
+
+mem_addr
+    The start address in memory from which to read or write the data.
+
+Examples
+--------
+
+Probe the ``i3c0`` controller::
+
+    => i3c i3c0
+
+Display the current i3c host controller::
+
+    => i3c current
+
+Check the device number and PID of the connected devices::
+
+    => i3c device_list
+
+Perform write operations on the connected i3c device (device 0) from memory::
+
+    => i3c write 0x1000 4 0
+
+    This command reads 4 bytes of data from memory starting at address
+    ``0x1000`` and writes them to device 0, which is identified by its device
+    number in the driver model. Example data from memory could look like this:
+
+    ```
+    Data at 0x1000: 0xAA 0xBB 0xCC 0xDD
+    ```
+
+    The bytes `0xAA`, `0xBB`, `0xCC`, and `0xDD` will be written to device 0.
+
+Perform a read operation from device 0 to memory (multiple bytes)::
+
+    => i3c read 0x1000 4 0
+
+    This command reads 4 bytes of data from device 0 and writes them to
+    memory starting at address ``0x1000``.
+
+    Example output after reading 4 bytes from device 0:
+
+    ```
+    i3c Read:
+    00000000  AA BB CC DD
+    ```
+
+    The bytes `0xAA`, `0xBB`, `0xCC`, and `0xDD` are read from device 0
+    and written to memory at address `0x1000`.
+
+Configuration
+-------------
+
+The ``i3c`` command is only available if CONFIG_CMD_I3C=y.
+
+Return value
+------------
+
+If the command succeeds, the return value ``$?`` is set to 0. If an error
+occurs, the return value ``$?`` is set to 1.
+
+Note
+----
+
+When specifying the data to be written to the i3c device (for example, with
+the ``i3c write`` command), the data can be provided in either uppercase
+or lowercase hexadecimal format. Both are valid and will be processed
+correctly. Similarly, when reading data with ``i3c read``, the data will be
+retrieved in the specified length and can include multiple bytes, all
+formatted in the same way.
\ No newline at end of file
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index bf2335dc8f0..718b606b162 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -80,6 +80,7 @@ Shell commands
    cmd/if
    cmd/itest
    cmd/imxtract
+   cmd/i3c
    cmd/load
    cmd/loadb
    cmd/loadm
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 6d3d2ab5e71..d96eb9b134e 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -674,8 +674,11 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 	newdevs &= ~olddevs;
 
 	for (pos = 0; pos < master->maxdevs; pos++) {
-		if (newdevs & BIT(pos))
+		if (newdevs & BIT(pos)) {
 			i3c_master_add_i3c_dev_locked(m, master->addrs[pos]);
+			master->i3cdev[pos] = m->this;
+			master->num_i3cdevs++;
+		}
 	}
 
 	dw_i3c_master_free_xfer(xfer);
@@ -1010,8 +1013,38 @@ err_assert_rst:
 	return ret;
 }
 
+static int dw_i3c_master_priv_read(struct udevice *dev, u32 dev_number,
+				   u8 *buf, u32 buf_size)
+{
+	struct dw_i3c_master *master = dev_get_priv(dev);
+	struct i3c_dev_desc *i3cdev = master->i3cdev[dev_number];
+	struct i3c_priv_xfer i3c_xfers;
+
+	i3c_xfers.data.in = buf;
+	i3c_xfers.len = buf_size;
+	i3c_xfers.rnw = I3C_MSG_READ;
+
+	return dw_i3c_master_priv_xfers(i3cdev, &i3c_xfers, 1);
+}
+
+static int dw_i3c_master_priv_write(struct udevice *dev, u32 dev_number,
+				    u8 *buf, u32 buf_size)
+{
+	struct dw_i3c_master *master = dev_get_priv(dev);
+	struct i3c_dev_desc *i3cdev = master->i3cdev[dev_number];
+	struct i3c_priv_xfer i3c_xfers;
+
+	i3c_xfers.data.out = buf;
+	i3c_xfers.len = buf_size;
+	i3c_xfers.rnw = I3C_MSG_WRITE;
+
+	return dw_i3c_master_priv_xfers(i3cdev, &i3c_xfers, 1);
+}
+
 static const struct dm_i3c_ops dw_i3c_ops = {
 	.i3c_xfers = dw_i3c_master_priv_xfers,
+	.read = dw_i3c_master_priv_read,
+	.write = dw_i3c_master_priv_write,
 };
 
 static const struct udevice_id dw_i3c_ids[] = {
diff --git a/include/dw-i3c.h b/include/dw-i3c.h
index 42c37d6dfa2..c652de77404 100644
--- a/include/dw-i3c.h
+++ b/include/dw-i3c.h
@@ -241,6 +241,8 @@ struct dw_i3c_master {
 	char type[5];
 	u8 addrs[MAX_DEVS];
 	bool first_broadcast;
+	struct i3c_dev_desc *i3cdev[I3C_BUS_MAX_DEVS];
+	u16 num_i3cdevs;
 };
 
 struct dw_i3c_i2c_dev_data {
diff --git a/include/i3c.h b/include/i3c.h
index 59c787c21db..e19c22a8852 100644
--- a/include/i3c.h
+++ b/include/i3c.h
@@ -25,6 +25,32 @@ struct dm_i3c_ops {
 	int (*i3c_xfers)(struct i3c_dev_desc *dev,
 			 struct i3c_priv_xfer *xfers,
 			 u32 nxfers);
+
+/**
+ * @read: Perform I3C read transaction.
+ *
+ * @dev: Chip to read from
+ * @dev_number: The target device number from the driver model.
+ * @buf: Place to put data
+ * @num_bytes: Number of bytes to read.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+	int (*read)(struct udevice *dev, u32 dev_number,
+		    u8 *buf, u32 num_bytes);
+
+/**
+ * @write: Perform I3C write transaction.
+ *
+ * @dev: Chip to write to
+ * @dev_number: The target device number from the driver model.
+ * @buf: Buffer containing data to write
+ * @num_bytes: Number of bytes to write.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+	int (*write)(struct udevice *dev, u32 dev_number,
+		     u8 *buf, u32 num_bytes);
 };
 
 /**
@@ -64,4 +90,4 @@ int dm_i3c_write(struct udevice *dev, u32 dev_number,
  * Return: 0 on success, negative error code on failure.
  */
 int dm_i3c_read(struct udevice *dev, u32 dev_number,
-		u8 *buf, u32 num_bytes);
\ No newline at end of file
+		u8 *buf, u32 num_bytes);
-- 
2.35.3

