Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3F7C83F1B
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 07:21:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DF8B83290;
	Wed, 16 Jul 2025 09:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="gE3qw/Gq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16BF482E37; Wed, 16 Jul 2025 09:09:32 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C74A83192
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 09:09:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQxoL7nHxDvvb96UbHC25SiHLOsDcxttgWeUBG7RvqGOegzqHZwFfkg1VrVuxhTBgZ+vZUdp2RCrpm+ccNhIvwxkHlgRrqY1HcRXT70drNlDKQKjSDyhAkIC8QOr6PySwlU3jw6viZ6GfBacPcLxOyAVWsVt07JEMV5j28w7Wg0hBp4s6pP7Z8E5umw9M6uxYaqa7Jd/LVx0Jp+15KvE/hoMxsVLxBzaMBmGkKtrtFkLWShKusKComCONo/XWCFWhcJapwsmrMPWgUpbGMCkkSuyYwNf3EmZVzgm+VbIqAZfkY9rgETuC/bLLt/4VpaS2ZGkFniM6ril12wBtzecVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/ZGBzeVLv8oV5RJ+KThpxa60OO7rZqHqQf2ov7QSyk=;
 b=d7x66BCXIzFxtDdMg5Z9XgmW51uPHNrcvoOX4oR/4skjb0jUuZ+ANc2fDTy4/8T1mgIOcZ4IaUfNjbGh8Uo8HAyWAVWfTieS/+mGNqPnBvOB1ms1fRgEbFPX9iwNfN8HkL0CtQyd/1R9gqKWfj1vkN8vDPwRTeqCGj4bk7NJDgt0pQLy30ODJX+AjWD4pYayCK05rO2fIikjOBvgr1MCSMPO7NFk8leYj6ereXlHdW+0/fFTNqcYXl+ByejNDCp4ssavP1WZ/nL5L25gUI747By8eZbz6ye1kuFGr3cFHKzKPutmt9o/GAV8a9i0joHjnukEk/IRX5OID6DJyb4yjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/ZGBzeVLv8oV5RJ+KThpxa60OO7rZqHqQf2ov7QSyk=;
 b=gE3qw/GqihbuXFJdvQuudMTjtkE5jgHjNDxvm2k/eifuMUUoFjVU+8LqtuS5u/ktxf+Wrn4n9V1oMtG5ymn1HmtjJDf1IVo2Fdbx/xckpbaLi5YIJcN60yi3GQ3HVKndFrplulaXvREo/WBIBIAWSuOfys9ow+7IpMEAIdDs7XJ2iKmdTrQKzKHdx5fCe3Gs7vzJMi8ZqFqw7a4IpP7L8ESQ54VkMnCAFUTqTWiYP8G2h3ug5qHQIb27Tzxwq8WnTu5vUbd2HWuIH31wksXcPcXK2b+B5Mu5zDaJPnaRXCgx3EOHzDcUyam4liLECKuMgMJqvZalST9i1rWNqn+kyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH7PR03MB7170.namprd03.prod.outlook.com (2603:10b6:510:241::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 07:09:27 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:09:27 +0000
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
Subject: [PATCH v6 10/12] test: cmd: Add simple test for i3c
Date: Wed, 16 Jul 2025 15:08:08 +0800
Message-Id: <20250716070810.8030-11-dinesh.maniyam@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 265bdc6c-c630-4d90-ab29-08ddc437b37d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cBaSOzPGR6saXkIsHyerojqGMa84tt/ENre1tKp/CNujUzfYUJpnIX3ZEnty?=
 =?us-ascii?Q?WBoVHaAZ4xjPM39Z5vLBuD0M5fydXiC5tPXwJWUgURhU8WN+dh/A9khcSLHn?=
 =?us-ascii?Q?8NiH5B5CtLzIE1XilV+N9IOK8Q0s5F3/OFpPmAfwU0Bz7GcJaYxdRwEE1kfo?=
 =?us-ascii?Q?LT2jzmzUyg8CNiS1eFBpYBYix2MV3wXHWuTEO8wN+W0OfuGePWP/fmFMZrCq?=
 =?us-ascii?Q?UnkgQNJ0pffEG5gV7Kej1MPofPkKUp0jZ4aYgXhWOeo24aikEo+4P1W5nOGT?=
 =?us-ascii?Q?K1FYH+DVvrLi2FBEb1ULSn9WQEXQa2d7OeP2usFQkkc0yBbbDx9vTU6W4Kvi?=
 =?us-ascii?Q?gE/98Fi8rRELVApxY/GRSPO8hRVX9L6BvHyYLZ3mB4Mu3YrWwt71Mwqm5z2j?=
 =?us-ascii?Q?gKbwysEyISfvgzvltZ+pNTBaLDIr4+WuLiB/7Fq7vg69vAIt1eNRRuA3DWkl?=
 =?us-ascii?Q?56hcVtfH/8q24DY9b7iMW50BvDbCDlK6P+1MctiVe8kxXp4+peM03Hpqloig?=
 =?us-ascii?Q?o6uqf9TR0dqAFmrpqnaeZm9apB5BaJFmo0TYZSmB54FLjViBnYpmsYO8EJq0?=
 =?us-ascii?Q?oS7TgTVNTzpix62GcBHaVU3n7kzq2fHD+/1Zdm9DUvOUCKcUKShkCAcS2AqN?=
 =?us-ascii?Q?9qONJRljVcDuMHBfR1kEeQCA/lcIwU37BSrrfRVScc8r7MP5Zi4PlWqhhOMy?=
 =?us-ascii?Q?CJ9uNBeR6o2V04+DxiIDpd215Ca3eYx2BSTKmIx3sqB++z5kTHI9VGhsPVvc?=
 =?us-ascii?Q?o607oZhrwHbCXmA99Rhib4SPokTMQbAd90tBNSwRGCiEphk0PsE+Pn7GzE6+?=
 =?us-ascii?Q?xJBclAFJEchs/4LwNFQaEYsgaCOMm2UssS5X2O6XbLelQb+6Gkg5UU8WDMs0?=
 =?us-ascii?Q?CsNTLV0X78Z6Aedgxpvr/ANTl0+e6P53ZPvzw9ifO/maJxZftMTi2WJSkciA?=
 =?us-ascii?Q?n58OT7+98tJ6AoSZYzG7vclr+/o2QRb2/3ZUjgRLpAwMsNIKHGHvoFxlx97b?=
 =?us-ascii?Q?LkY3O++tnZx7Cw1HSCQJbqBUvlVxt/GqczE4C/VnOBQmrTRuVv5nJL8mhSRG?=
 =?us-ascii?Q?AxFmamN4rintRPX6s4qU6LcPRN4U7cZqHrrB+uCxSzRA3o5vSqZY40qYcwfa?=
 =?us-ascii?Q?mLMjPJNfVBHfbX9b2jjf1BXgJzlbvxhJ11h9ttv9HLWrmcOi4LrNzf8LLk1P?=
 =?us-ascii?Q?lPUp+7yaa8HXgikc58XPnPVqrYDxHztA+tYJNragsQJTprOML2XMr6Bslp2o?=
 =?us-ascii?Q?Q2tGHsXnt2uGg6QqPy77OcuJ7IGfmGrvH/k4n+/G2msvx6Q21gUo9GtrKCjs?=
 =?us-ascii?Q?zyqVQ8vV0D7oVLGzVcz+bTGXYlCSMiDZejby8yDsDT6VE6cqKd3nAhV5mmen?=
 =?us-ascii?Q?VM5gdY8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZYkeZUo1k0RV0+p5mLgBNU5tzbAkuIOwWzLX+pInEk6MqZZptZqhw33UmL3y?=
 =?us-ascii?Q?AtZ3jx9i6MiGz+Zpul03I4MpHfn+S6biS6Hr5jedrk7N0ypEor0cwAxuPq/+?=
 =?us-ascii?Q?Qkj2l8PNcWZpGkJpw1zZUdJYINhNaPIdwK+pK1j6GrGCYlr447ec9lKODFoE?=
 =?us-ascii?Q?f9WKMjoaccH4SevIWUe+d1BHVwWCfOYowVD6/c0KU5bcLQlxux5bivuPYE55?=
 =?us-ascii?Q?a40lmc0teoL75SxMPtCfkhrVydE9ifqXOWjVPAaZiep0J+2jzphbQrvqItAg?=
 =?us-ascii?Q?npBmOWEG5HIozTtcelApfToq76r5puTwkThrt2bSwg9f2og3xGDUTW2sazs1?=
 =?us-ascii?Q?j3H5kR6Qd49COqr2A0V7CxpZvXliMrA2KE/X/pPOV8H+fHQ0uc5WcshlzxFL?=
 =?us-ascii?Q?OJVdxruG7L3Z3elBa6S2uIfYwBCRX+DcyhrRaUdAnkOIIdgPhv6S9QW7TIgv?=
 =?us-ascii?Q?sPa8k4w80wPRRfsY7sJqq09ZgcGiYjICf/3/wTkHMhPP1wtyaU3tS0FhQtRi?=
 =?us-ascii?Q?lllBsUDQRHTfJ2RO+0umn3ygPJPPGOhe09thxOj/XMu4u8HTPgxzFf125H2F?=
 =?us-ascii?Q?F3BMfHNlJ5mxRRSpV7dl5TzAqzwezyz66hDyymhp6ETjeQcOxuRCK4NvDNBp?=
 =?us-ascii?Q?aVNs2QusBviBnY4xwe2XBE3Zyj0vzKWjs1dhT5Gc+7C1HilsW93RDb4vXOsM?=
 =?us-ascii?Q?+xRzh5FOjUzyW5mKSXjn7htmSJ+shYQPkLzHbdp8om1NMChA4P6nVPVFfLYv?=
 =?us-ascii?Q?heFgKiwew2c+L0hXx+eadg47vnh0FPg8MQY0yioZ8TseTo4F1rrnDC2VVyQU?=
 =?us-ascii?Q?5vt0ytToQVMyQUW0pcjovMHAIO9jPC9zVoNiPa8xlKgzWQzVo4lYSkpp/IKQ?=
 =?us-ascii?Q?QtLiFTsAgDhwUuhBR9gCneqZIk5Qws3IiIOiON5pBit1hHzEdwcmEJwEUr9Z?=
 =?us-ascii?Q?pos/2KZ96FkX9oUAyTuwCCu9DKHMJ6WgLk8v+Fs8+3PaFnOzODgelM/H2woT?=
 =?us-ascii?Q?eAjXYE5eZCLPJaJ4SV45iqULg1+tqmSelgn3zNojjjWYtyyeY71hZTbozCLL?=
 =?us-ascii?Q?feiDFKJNAlcaWeHBjuD47XNyWp+uEZbZ7e/CLLv9amrN9/pWnLbkAdsqx6Mq?=
 =?us-ascii?Q?FGOYDKUfTBZ+4N85SQygbbNE6UzD8YTJ3bf/4Z4+yxaV3O3osLM8tDII45vP?=
 =?us-ascii?Q?xKxBtP8DhABDXHa2tF1knWT++X/6pFbsvF7lk5tPcEDYjsCsPzBQW30rTv/t?=
 =?us-ascii?Q?f8fadOQ0qIgwjc2RObZTYLg1UOk6iiQ8/1EE0hSFOQF8NFOgwAHB+99kAn/t?=
 =?us-ascii?Q?tehNgz1esgpN5862SGmRmj0NFYxlU6k/6+/onXxuWGinc0OwzQYFDhku3Hb/?=
 =?us-ascii?Q?SuZ8PHVKSGVuRDaD+jhTHFLP6Jc3aPEHyd1xoQRM3q6PRP6tFAiMOi4MIazF?=
 =?us-ascii?Q?T65jdxdA39gIlFUU6LlE2HXyU1069U+iGEKVmImzYbUthjX2yXlzwyRScuyX?=
 =?us-ascii?Q?goclKKoP1ETAojHaqbfbBVjKIlv/Im2TRz8+XNisBkjgpVrLcBIqoVAQwmFZ?=
 =?us-ascii?Q?HrUd8zSW1Evt51uVrwtLsYNu0fzFCpH8CWEpDSvMYsbkaPENgs4jQ6RWvTye?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 265bdc6c-c630-4d90-ab29-08ddc437b37d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:09:27.3156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8d1ss6V/K2RYA+bTmSLXmEeto1VnGag1cwKoCwmPMBjkDDhmjoNi7Ei526NbUrvypH04Sw05yl32I4xNgkxtGr8bjnZdUewYX8vq5gWa28=
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
index d8a5e77402d..d1c49e2c97a 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_CMD_PWM) += pwm.o
 obj-$(CONFIG_CMD_READ) += rw.o
 obj-$(CONFIG_CMD_SETEXPR) += setexpr.o
 obj-$(CONFIG_CMD_TEMPERATURE) += temperature.o
+obj-$(CONFIG_CMD_I3C) += i3c.o
 ifdef CONFIG_NET
 obj-$(CONFIG_CMD_WGET) += wget.o
 endif
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

