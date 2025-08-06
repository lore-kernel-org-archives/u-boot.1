Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC46BC87FCA
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 05:29:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20A60842BF;
	Wed,  6 Aug 2025 07:26:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="VpdCZ5Yp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA5B88399C; Wed,  6 Aug 2025 06:34:25 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C3AF83990
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 06:34:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiRH5y/hIp8sDwiqQfHC84fYCInOmUvRBjY+/abJCHiiksxWpRn5XzX8lFFTVUzbN1POvGtm3oKbUqfQerGZ8grKghnSgU391K0PZBXAHNlgpaXiI9wR1gjyYDLVClcHImDgmXyQ262Tzb15jtK1QW5+x2L8HP+dmt0x7T7zKSu5N1Qw+oG168q8VvmYGAwwjXsH8QrtZESo3e9CClHGp65aJUljaC+iPw9ETGWV0cKkI30RtUMz7kkMPDCrCYUoDoTH+ODv/80hPI5MfUwatu9aoqInaR3CMzVQOpd4GQjBg6JOn+N+KDUtdmXsRoZqmppuEEVi7JsYUwpTAXy9AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6gPU3bzy0VR8A9CYBt5yt/O/9DcWHaqpP/TpN07vz0=;
 b=VNvOAanZRF8rsqYcjS6RpnxmBTFHPMou3SQaJZeKZXffeSaL4ZKUmLmKbd+Up5ZfxCPx35BVIZM2F1cMNyrgcQtnma7vU7cbgZlaydquLD+Oo2JPJnDXiy8dnvmpXibyitwW5Jpc168qgKB0KpfKYcGOPervuW0EP9en/OfmJu2eCkmoryopR4czmMbkO0rbOVyKm7DGizIA8Mw4UhX4WHRcPOZXEuXT9xpnG8/OQBum7BYSWtaQBY7IFhRFwzoUgoVvOUWU0z5tDwEc6Wd/q1b59G1OudUM+jY6rKywDhbNpRYq/QptE79IQ0XX0z2vPlX+TwcGnBBow674nRMBjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6gPU3bzy0VR8A9CYBt5yt/O/9DcWHaqpP/TpN07vz0=;
 b=VpdCZ5Ypvk9QHvKyGCTarQAOj2U2z06ja6jOJ5dE+EKH5dFRP+GC+9YKX0nJnSH6JmJuLxMEXYaFnDfL8+dqBW+lfMYbfas995+WXQpLEd/ScCCXklGCFkmGZMnSEyzAXcnJMXG5L77p0Uet+lsrRLg4SL0+ovHGVfzEyhtSr0bc8mIfTeP7JgFPF17cjUi37aHq1pdFTXTzZvooVb2GpDDNGg70Cmbwbb08CYii+sST66RfxP6aYScRTZwyCNzuOjb4scPlKcKkDKVxCjGlY8+8KLpUuDyeLG6ROPUMgfrQzf/pPRAcvDs6RMUsW1KbLsXRM5lAP+m6m+DmXm86WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BY5PR03MB5202.namprd03.prod.outlook.com (2603:10b6:a03:220::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 04:34:05 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 04:34:05 +0000
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
Subject: [PATCH v8 10/12] test: cmd: Add simple test for i3c
Date: Wed,  6 Aug 2025 12:32:33 +0800
Message-Id: <20250806043235.2260-12-dinesh.maniyam@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8fe0299f-1066-4246-8c89-08ddd4a279a5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rJQf69syMP8F7UcO+2eS0qd0YnmoPKs7Lt8mRAWpgJC1nGXMF/v1tN0bB+CL?=
 =?us-ascii?Q?WC/+kGy1JaynDTvXmM2rjZV7Xz2lNufZyX0ZVWi0cdWTGUv9zfp/4UG4DPbA?=
 =?us-ascii?Q?Af71hUXZ7cB015+F9lF1M85LHCVeg7ndO+UHSKWJtrZ67iBybA3Imw5/Higx?=
 =?us-ascii?Q?EqSN8sfFBSdFGorvFR51YFv2GNaD4cH8UzY5HCnhnlZmHnR0LocnFkIvtxW8?=
 =?us-ascii?Q?gRO1MVfwO79JvfhJx9YyEPUAnQfY/GfFbO7PaJMbqC+K4eRY4qysXnU3MRUM?=
 =?us-ascii?Q?oL3m9O7LpPwMnhOEZjeywIc6uJDnhdBVSJGUPyhAdi5jMflAhs3TLXLbBX9G?=
 =?us-ascii?Q?6G6OZK2kBatYcNWRl7PsLSS0L/GYJA3DZWwTZ8DIi8pR9Jhg7M8C49bAuSIS?=
 =?us-ascii?Q?Wycs95Qt2hL6LMcSiST2BJvdGRQeNaP5sCzSJTKubPy0JInJRVwChcfmTtSf?=
 =?us-ascii?Q?Mimh5a9vHNvAFd+/lasKdqmdDz9RlZQdo39MXfFAWJMfQxjw1TA7xwnhB/SZ?=
 =?us-ascii?Q?PIweoyHF2x/kZa/aC3x7W32cPRskbvP5CfafvYkdfqBXDjMEgfx0saQiS66w?=
 =?us-ascii?Q?S9Qg+hwLCf+GyrcarMl5VKsHlLfF0LTXKEaMO6fab6OoiUS6bGxjaut5fJJT?=
 =?us-ascii?Q?Vlc+MwvoV2nriquYwx3JrZjTa8Cvn8V9BVynE8mTjvPQjMJNGc4nSZ94kUoY?=
 =?us-ascii?Q?BghTmyXT4Nhb/DjffIJhze89YwEHxkpt4vCbNaEP6hbSsnYKLAL5nNFI+AtV?=
 =?us-ascii?Q?K9QXGj0dQZNvY3sENdrSfcW6Ea5Rvb7R5nMz7QgQ+H/eFzzPTYWzcyj47r8J?=
 =?us-ascii?Q?RxwwyI2ZISs8SXwYd+E2OSlQrRuU1r2fIfDx+sqWgdLmLXKYkjrhJevfmZ5q?=
 =?us-ascii?Q?s2WUZ5GeijOCZVGq5elfLAmtPHZlNvOQ+GOFkNlvZJG8TK29QN0qpplLYMbz?=
 =?us-ascii?Q?h26awJaGDzeYOZv8hiox5cMDB/2dOKeRCRxzq5xugZbFaIzT409TWeairJkC?=
 =?us-ascii?Q?2ecCszLm52ewtmZH9B+MZC0XF6jIQUXm5JL9WcoZhkk9XoPPbmk1HEkVz3HA?=
 =?us-ascii?Q?5wkAUlLRI3nv1KcEEpEW5kWQK+3mwRwGjCJfJG1MJWTCOESN5B7G8k5glAj3?=
 =?us-ascii?Q?Mx9MFWnuYy6F9J0/IANY6Bfp3iW8q/Vy5yf/NEDbtHWW/BeIrzq41aYrX8Sn?=
 =?us-ascii?Q?uFki9ljgi1gB0h4Y2Sgf0GqOzhwBYdZ6Dw9eTDrnx6LDFK53trMZc6RFOGfg?=
 =?us-ascii?Q?jJzAnyCQreXXN1ydjnCViM6t1oLsWQyjM63PeEkTbGtRrdoQtgeeM2FwuzIj?=
 =?us-ascii?Q?90EATqxzDR6k8N0m/TjlOAZxzzVtPcBfVXSmUSZ+kRAJ6AJezpUXGci39yeE?=
 =?us-ascii?Q?fJk598JS6gPpx4suC/eLHrJoK5s/TMZyYiJo4Sfdc7JmLerzgbmI/Oz8KUHK?=
 =?us-ascii?Q?swuyQnwa0mI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mn8khf5ZUcDsCLNk89JII941wVVRixwH7GMiQDpgR3sc1pVBjKbdk35VfAUD?=
 =?us-ascii?Q?kgqUSakkgrJ7bd7lGRZ2BwVWGNRhZp0Ivpappxe6CePBiuRb4L/0BYyvaQ6N?=
 =?us-ascii?Q?fsoLrozYG5fIJzwy8UCHxGhCBAfKqmaekqlkIXfhNAQdEqNC8zp5+OY3vFXz?=
 =?us-ascii?Q?kIgxWloaqhHHRbq7MIgcw09R+aSSkJyy0ohQfr3eZsrufAoVNjHeppoTdKKv?=
 =?us-ascii?Q?vK8M4SjFIEPPpDDZ7N/6IXcelenSvVXZRZIG3ARtLsY/c6QUZodLBLHu4KSD?=
 =?us-ascii?Q?dTJKDf+Nphi9xo5lTbJ6edj8IJULfXtqtNcUV7GFwgWQnIE1XrxPTEFIDYZX?=
 =?us-ascii?Q?6xNCEfBeVnCbLzpm3HycYHRXhohqmJyL1yM8wfZM8LdUcFCcrMTK2UmyOSfM?=
 =?us-ascii?Q?2YsCFvCGsXBVXWzge/ryAy2siRjXhltp9F4/xWsci11YXHwYhPgUhx3idsnI?=
 =?us-ascii?Q?VbFltBToSByBx+32yR6Ep29njKf012BmqKLt9v0qodk7uVrosvGArQSe5/Ef?=
 =?us-ascii?Q?vBTyVrm7rmMhwR4C6IE3CeERw0EdOR00EKVQfYHp0lvSVDT0BIRqNU1DrOja?=
 =?us-ascii?Q?T7Yx+nSw+MdHa+rBq2xdGUWc1YZvsJweb0CZOtgGO7CCzOlYkZRduAkDUKmg?=
 =?us-ascii?Q?SoEEgfdyD9cZQyNdsjzjWnjh3VfH8sIrxZjpz94xpDUQj51SoB840T+omqDX?=
 =?us-ascii?Q?m9J2H1p1jvSuppWvr1sFSZQIyShXnVqLzq0iyTXhoM5kXpjIGsMC5HI5hegS?=
 =?us-ascii?Q?ra94jZHGkvZwMyDXNe4O1ft6LsMfWTkiuLmdQkX8TLLL+plYa6bzDR0wzfsJ?=
 =?us-ascii?Q?YKl5HniJR/BZT7rgO44DuAluvSpMFECjINPPuxgjx9jtWgTWdhcDQsQpK/bp?=
 =?us-ascii?Q?1fwJ3gYdLCTMsIDOZkNECIDzamhbAysHSk2gOGZbUouW0Y7cLu5bZpI8B1dC?=
 =?us-ascii?Q?L8ZwOooJO3TL4fLfrIJ5EbU+KDIWOQKAIaFO8A3tAx1W8Cg82IiCMWC0DXwB?=
 =?us-ascii?Q?5EdXwMqK22FWqPVISr/mM0WVtAazkTxKU7AvjxQif0EQxZ4RW59tFOIg9wX+?=
 =?us-ascii?Q?9K/Vk+SsfBqdwRDo6ZAwYOzjuh3+dFFSxeOVY/h0c0u1r/8Nnwq3KTtoDSyJ?=
 =?us-ascii?Q?pV+cbB+tsi3sPdd7S8bkj7pATryRrWGpNzsZpY3LAffyplhT+dCnXmERPayK?=
 =?us-ascii?Q?CrThCefLB1275kKvMGPyQZtZo6NN3xREky0yk4yrCG6KVwDo6QN7F3Yl2VSo?=
 =?us-ascii?Q?d1IFQI9Mkhx64QpNNfh2Gbl6zIQNRZKWgPsq/opr85aRSOcG4uA7MWoHn2Cg?=
 =?us-ascii?Q?OfHLbmsXXfwQKwzjANKh7GItgSIguns8YkH5eDmI/K6dMZaqMR1UMxBY9j6P?=
 =?us-ascii?Q?yWWkqhl4o/Foz7xMHuYjuxYtjqR7yIyYpobGmb/1JYwj3bQ7HB4Hj5DpB/xh?=
 =?us-ascii?Q?XbHv/hD8N49oaKq8S/EZAyPIkhgN6H0BiLhKSggrQuzClSd5nW/K1kQ9wHYx?=
 =?us-ascii?Q?awBL1GlG7B4rktOseKhbtKiLyT99qfq2r4Mmmgpelk2wH+WKYuct9bB5kUcV?=
 =?us-ascii?Q?aNF2hzPnnwvDNVJvPN7is509Cw85xn3aAY4C7NecpWZTIpQZr9ukXqSRSlCc?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe0299f-1066-4246-8c89-08ddd4a279a5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 04:34:05.0098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RV7fshtJO4CAjRJIvdQhm4PS2j9GcbBXVMnJPk7AKeKiHa6oZd0xLIjS4WyYtHLw70cs5h5q+i8kTrJU095GnktiHsfyyK4XJi3yjRZHMms=
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

Add simple test to check i3c controller defined in sandbox test DT.
Basically, this test case will check validity of the i3c controller
by probing it and perform basic commands of cmd/i3c.c

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 test/cmd/Makefile |  1 +
 test/cmd/i3c.c    | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 test/cmd/i3c.c

diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index d8a5e77402d..3592fbd6534 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_CMD_FDT) += fdt.o
 obj-$(CONFIG_CONSOLE_TRUETYPE) += font.o
 obj-$(CONFIG_CMD_HASH) += hash.o
 obj-$(CONFIG_CMD_HISTORY) += history.o
+obj-$(CONFIG_CMD_I3C) += i3c.o
 obj-$(CONFIG_CMD_LOADM) += loadm.o
 obj-$(CONFIG_CMD_MEMINFO) += meminfo.o
 obj-$(CONFIG_CMD_MEMORY) += mem_copy.o
diff --git a/test/cmd/i3c.c b/test/cmd/i3c.c
new file mode 100644
index 00000000000..04baad2a4b2
--- /dev/null
+++ b/test/cmd/i3c.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <dm.h>
+#include <dm/test.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+/* Basic test for probing i3c controller with invalid name */
+static int dm_test_i3c_cmd_probe_invalid_master(struct unit_test_state *uts)
+{
+	ut_asserteq(1, run_command("i3c any", 0));
+	ut_assert_nextline("i3c0 (i3c_sandbox)");
+	ut_assert_nextline("i3c1 (i3c_sandbox)");
+	ut_assert_nextline("i3c: Host controller not initialized: any");
+	ut_assert_console_end();
+
+	return 0;
+}
+DM_TEST(dm_test_i3c_cmd_probe_invalid_master, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_DM);
+
+/* Basic test of the i3c controller for valid name as per test DT */
+static int dm_test_i3c_cmd_probe_valid_master(struct unit_test_state *uts)
+{
+	ut_asserteq(0, run_command("i3c i3c0", 0));
+	ut_assert_nextline("i3c: Current controller: i3c0");
+	ut_assert_console_end();
+
+	ut_asserteq(0, run_command("i3c current", 0));
+	ut_assert_nextline("i3c: Current controller: i3c0");
+	ut_assert_console_end();
+
+	ut_asserteq(0, run_command("i3c i3c1", 0));
+	ut_assert_nextline("i3c: Current controller: i3c1");
+	ut_assert_console_end();
+
+	ut_asserteq(0, run_command("i3c current", 0));
+	ut_assert_nextline("i3c: Current controller: i3c1");
+	ut_assert_console_end();
+
+	ut_asserteq(0, run_command("i3c list", 0));
+	ut_assert_nextline("i3c0 (i3c_sandbox)");
+	ut_assert_nextline("i3c1 (i3c_sandbox)");
+	ut_assert_console_end();
+
+	return 0;
+}
+DM_TEST(dm_test_i3c_cmd_probe_valid_master, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_DM);
\ No newline at end of file
-- 
2.35.3

