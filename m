Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30710C83F27
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 07:20:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E11CA83281;
	Wed, 16 Jul 2025 09:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="hVO3XJDU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F22F582E37; Wed, 16 Jul 2025 09:09:26 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7314C83192
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 09:09:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPk0J4W+Rx9onUhL+OrSXtbK0gtDZNpjGfJivnlwdUzkbnZrYIMT6zLAgPBx8M6pn8Mcx6uXMnBH2lxjer+OR5Gki8XFf8TIr2YoYIUlkexL0xj62/AApRMEmEboNkU8+cdMuROT0umN/C8OWICkB95Jm1BKPGhCjhJf6UUX8Gpx0sTx/3bVCFm7w6Kl+69QFSVA6i+/xV2RqU4AY6UtNF1srHzk1GK6DrFf/vZu73El33G5p2aCIXoyW+3up5MH4E8iwbqsGUXH2duiPdSfijd03C656lxAKulPDWs+glBREt5dhEF/rsTbooaTzDNNmKteqB9HknXWUtIxfKAh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o08cIm7qt6dSHtjS/PgpEwDxCpG8Puf2Sw6mBQoIGPk=;
 b=lNUUqMCLAjoNo0tKhWMZkI0awyYUGjjCgIG5/P63E8yNJAtwwlAKT9TVY3VKsFDglct81+cvtW4ipf80w7E/Ncdd1F09HDW8MeeEVe+hSG3ryXR96FcVSAuPD6L/nmZPtlCZH3eD1jUer1nreGOH4cDYjFP8pgg3K9Oi6SJJtHaQnOpvwz0kiEW5SnMtOMsH0oQCZ5Fc7vUqjPLkyTBlc3OsZGMfHlskgzqrmNzFzoRrFZaMbf3EjPQ7w3gq/abOXu5BjD4yNNlm5EA/TtsiNwQMr3HxJhtg3nuJJF+IC8P2S8Z0rL5A40CMx47q8kwD8os/r/rO52APn4WjgQJrbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o08cIm7qt6dSHtjS/PgpEwDxCpG8Puf2Sw6mBQoIGPk=;
 b=hVO3XJDUS/fpcl/CVJwzCVFjNbCf/K3QHsw7oyQHFth4hTgnkBcE/UtRw6Dky2B3TZqYLVWA7XLgHUJ0YlRLLSC6MvpiKdCu+1OYAy3p1vK1oxaaqsCWONBAKbwJMovcpPqV+0tZa4t+dYq2Rfvt1mH4F30ULvWjZ4gSEud/RO8om7Q2DsxO2kmctTZ7HPg5l+hcydGCIdIiPsZhRNxmyv2K82yvYNtjp1wQqLi15HfPKAr1A7YLGiOXyb1mKJbgX30roJAAAFiJBhpiSLP9UGA0ISjq13J/EphWj3s72bdWf8SOfIQQb98nnC+UkcFUeZ1ajyw8uKRx1nbe3N91Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH7PR03MB7170.namprd03.prod.outlook.com (2603:10b6:510:241::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 07:09:21 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:09:21 +0000
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
Subject: [PATCH v6 09/12] cmd: Add i3c command support.
Date: Wed, 16 Jul 2025 15:08:07 +0800
Message-Id: <20250716070810.8030-10-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250716070810.8030-1-dinesh.maniyam@altera.com>
References: <20250716070810.8030-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25)
 To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH7PR03MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d204b47-faf4-4d29-a48d-08ddc437b00b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I9eRwsCdJnX3s3DtyxeOJQfsa62XSIOcRAzkQz2b2bgqyMsH9ApEH2/NhbWp?=
 =?us-ascii?Q?nhk0fHC/WsDSjKi7hRmtnXKh0wgaLq0cxRzs/2/n9PNMM9ANT97AGrznshTi?=
 =?us-ascii?Q?jLKQlRGtwaEPYamPz8Es5s6yDoxXJb0MRTsxIQrNwa7GHRiupNqAAEikV56i?=
 =?us-ascii?Q?FmHIxKi3qXsCHgmAwz/pw6uBp20xpv5XhBojb80cMr5ZQVEEbIAztJiuqV2r?=
 =?us-ascii?Q?yXlE4Chyms0vQ5W9aahi41a34ARxp6B3a6kCBEtohE0kGBhmeDFPEdv5/taF?=
 =?us-ascii?Q?6aExfrTobCj+L2QwSJK7JbY2vr+giAN2V/SZAx4ACAgTb6Xrfzb8rxkLKTJh?=
 =?us-ascii?Q?0WicF9qix+XFcJlaYpspsCqiMFJfn7ThIT4/vnZlvGABmA6GS3eS60jepBjZ?=
 =?us-ascii?Q?BWRCex8hYXf6vD4TUCxwpOn9cnaoO0EHP4y5+d86YrO1G5eNTziMz8CS4+pW?=
 =?us-ascii?Q?VZMn60S6JrGQvfiXDUigdzZ70UddMpNdj9gJ8L+FYqMtDVwhcW37E2hoQizK?=
 =?us-ascii?Q?egydJI/lVbMdXYIXvt0qx0r7Uf4DKe+PLs98U+dujsXm9YS5sIttFgfpr4SA?=
 =?us-ascii?Q?/vzLd5yqoChoKGbZmPllFTLGHTjEN3VbwiU4O3kb9/JUxf47THNi7sBwhnBd?=
 =?us-ascii?Q?oz39RkyrxHEO6K+uj2BsfB4/WaiuNrJE6+eFb24ojezP84ovEnJj2xje4QaL?=
 =?us-ascii?Q?oumojV/cL7QadRlRr+VT/8r/FLCcLpSybnYJSfYnF47yq+YZNchy5m9MIceW?=
 =?us-ascii?Q?5/mcX+gjhsEDPoctcttYgO1/5JU98DEoKRaxV1qX7uJAuxFrLWneu3XE5XSP?=
 =?us-ascii?Q?tHacrDwv6leD8cx6yryJTfbVzX4nUcOBpkrDRYLleVwMN8BU0ooWK41sLzhG?=
 =?us-ascii?Q?4CxWV6XmRS0Bng7mU0SRRs8sgltglz3XsWLev125MJB9bp5r1HGQB20im9uY?=
 =?us-ascii?Q?o7zHBXT1qD0YRULDfzVOZzO0W2Z17QRqlTmyWxt1Xw6MgecfvxZx79tTCY5L?=
 =?us-ascii?Q?vPglfs3hQ0T1O0mzb2w5LL/7odBFswx7UhzKsE9N81BKhWBfcpXqfX6zDeRD?=
 =?us-ascii?Q?EHAcNYxBrOospeh+e7h2p6s4N8j6+xXdqyOrR2ved9YrueHh3XVZQmPLhs1o?=
 =?us-ascii?Q?Qd95GKgoUTuwxgkx3KVmfl6nmFZcIf3W59u5Jcy1PoRpqKlPk1J7r8vvnxU9?=
 =?us-ascii?Q?94iq2twvMaDduUXgpfb/NTYjK761nuoKcP20aLwOw0TFuwQRXPJ/52CSQsja?=
 =?us-ascii?Q?O6iBrWhPP+otVgaKlOHqNr+pzWkRJDI+KrrerVdPpRoIINo4pBmVjlAcFPXa?=
 =?us-ascii?Q?1S9t5xoS7NmH8dA6VO9GarfrvAdQwE7T4+s+/0pqnBs7+nc710No57W5nN08?=
 =?us-ascii?Q?Bug+0bo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m2lTlFvYjwtbFi7DY5FiSABAJO8JfT6lmBAvuUTRrhZnsipbnneqFrns3/eV?=
 =?us-ascii?Q?nDU6H0fNSgTOSsUPDQG8sTjUlS8Id+37NBm5KCnaqHJntF7O68ep0OavLeRe?=
 =?us-ascii?Q?lDt32+43YgI7zujBAN4gh1yMxpBIbxb5M8DaQ3lEl/qUIdxXdT3Byw4JHdVw?=
 =?us-ascii?Q?EYUacHX/VXPslESzSmoetXcRp+vJUg1kb8rWpOUSb6n8MMea7haB+SbARdUU?=
 =?us-ascii?Q?iMRzFt6RrfHT9WKXinfF67sObmZdoyRi/52kNFbnpspo3YKbWCL6bNPFT2jI?=
 =?us-ascii?Q?0i/HwN3WWaSsyAFKPk5y7r/5XkfESxlpTKfq7hFtn1f6ZmavC8llhZlxOIFm?=
 =?us-ascii?Q?V6E0cKjATvYKKqOImaigwHAbUN3+BPY5yvWimefmcxTOudX2uXsUcbj8IEEV?=
 =?us-ascii?Q?zkf8yIGz8bxXApbM6PlFd/mUKXcV4NMAr5kTDX7pxVqg97rEWcfyYoJC7Els?=
 =?us-ascii?Q?1v3wtL11OMz6Rl00ievFiQVN526zZqwiBoLn6oRm5rBLz6pljrIDNz01zk1X?=
 =?us-ascii?Q?ntkmImZ6S/+x+gcBk+av6xM3rl0jLG+7N52nDq7tFyBggADgSyW5DbuRyXBJ?=
 =?us-ascii?Q?LM21ogSnuBzPNnhjzqd92vU/UOEdHtU6s59OQ1+uP5yQqCxiwVAgI6kgN3Zi?=
 =?us-ascii?Q?VTVFOM6KKwVQFlsVIs26i8tqVLrSpyyLCuAbHwko56vfzfIz/KH+ncCp/pvB?=
 =?us-ascii?Q?lc9mZa7O3+A6f1x3R2jKAZvzPg8BHu5YS+hbbNuuhV7Lq7F8WHJpc8SEHF/C?=
 =?us-ascii?Q?2l85RmOW5FZwRzefLtBtNeXF3wOrdDYIrsD2EpPF8DPX6oIQzqbyvn0s+XKg?=
 =?us-ascii?Q?HvB4o1r5fuH8yNd5ggpuePVszBhyx7dmUNyhPbECMoWKkkvzVu6W1OvpaYW8?=
 =?us-ascii?Q?nR3UTlnjLiGfcXi5Gw1Dd94AgBteNhc40RYhng/lL0D9PESIUJlYsTMHodg6?=
 =?us-ascii?Q?V9I4l+Oj+TR1zvDiZOXUqn5T4BBguJrqk1vFUiREhcA1SfDQZxqAlS80hoCw?=
 =?us-ascii?Q?JoNZLD5vUEaeATIIjg5nvw+jd2hPQPDmozMlzHthqeZxmoz2qgVMcp7MDczL?=
 =?us-ascii?Q?+joTmChDMnO5Wkuy0cW6YZiP3oGkNFzffDd6mx+5IsYJ0e/bnzuxZuC6IU1H?=
 =?us-ascii?Q?FrFVIXMOX8oSOucXgN2cJOywH/aLb5hJzQWUnXGbYAl0l5YnQAqif0D3WY+c?=
 =?us-ascii?Q?E4/stHmvBlwpXPVsx1Z1pi9rHekWyQLEKyLfMI8ww0z7EHDzWLwueeF7+swJ?=
 =?us-ascii?Q?n5g2wtwtQIhw+CKGu1e4MADhzm5DryrUWPE0DfoltaLrBqIdv2ol0pWdGqJQ?=
 =?us-ascii?Q?VhCyQkInaIxr+aWLqC/+Ahaj9YLux57v/P8yIx8Tc8BYd1CoOVOQsZEXocpV?=
 =?us-ascii?Q?yBXG5BZHgZxLUb8WJ4aK7oRV+mbb8AMaQKY13TqBIFgzU6P2XorzrCo0/k+M?=
 =?us-ascii?Q?0gWeo3VOul7mrcyRYCW1JtwCVU50D5FUtxjCQp/WP5gQfWshtM+IZFJicLQl?=
 =?us-ascii?Q?Jp41/ccSCXh/9/tsxYqdOTwh32DFtU4t5y/rPUvxIK93BYl3gOsxnZPGVBEw?=
 =?us-ascii?Q?x3Y+G5YCLg3BqqeUIpUJI2E43WFS0fDvF/d59JwOweJJ3fY/ldRWSFIhjl3W?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d204b47-faf4-4d29-a48d-08ddc437b00b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:09:21.7316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6TmOEMZu03FatR7hb3ztKE7MdwivVpJ/y1xCWpAhcJqQb4PtDSM20QK5JZQWKplw/pQLpc9KndUVAe/Afm8vFpYOLUiyd+s02+ZmRWBmoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7170
X-Mailman-Approved-At: Wed, 16 Jul 2025 09:18:59 +0200
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
 cmd/Kconfig                        |   6 +
 cmd/Makefile                       |   1 +
 cmd/i3c.c                          | 271 +++++++++++++++++++++++++++++
 doc/usage/cmd/i3c.rst              | 146 ++++++++++++++++
 doc/usage/index.rst                |   1 +
 drivers/i3c/master/dw-i3c-master.c |  35 +++-
 include/dw-i3c.h                   |   2 +
 include/i3c.h                      |  28 ++-
 8 files changed, 488 insertions(+), 2 deletions(-)
 create mode 100644 cmd/i3c.c
 create mode 100644 doc/usage/cmd/i3c.rst

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 642cc1116e8..551959731f0 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1327,6 +1327,12 @@ config CMD_I2C
 	help
 	  I2C support.
 
+config CMD_I3C
+	bool "i3c"
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

