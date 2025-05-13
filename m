Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8347CC3ABCC
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 12:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 135F682B33;
	Tue, 13 May 2025 14:28:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="XwLisu7g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 452D38091A; Tue, 13 May 2025 12:21:13 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1539B81FAB
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 12:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWy3lw5x3MOTSHRzVeHrxrKxA6oDB5z0C5d9peylzrrdSFDgpAHj7rRDbIxerYke/4ikgAFMIEcmuxIXftqorvpzxmzWBoKri+Ly8O8rBb89nYiqeqM18jS+PXGchK+gjIkXX6dOlDFrlm4Bu02WnARvISCtIpOUPw8HA66Yuqut352PyGNXHMthMXE8ssQa2A2GQYvgqwyCQWEMTuNUjajSg5MYs/M7TnGXndk/7HkYscYH1sevAqlUONO9/k/zVSNypyos7lqr5K9JBpjuXRqVRkElVPVCHa/YSQj78G3bkcidwi7b3P5A6yk/HB/QCMS2IJVQwUOA/TPwMUKoQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJmr4z9Ih75M6QdTMHfTIawHtgOlo3HCVlmyRBgsqYI=;
 b=lqwb+Kj0kcJxxSVP5rlbyVEnc1qrQha2CBZxRWa4RdfV/Sjbuq4UpgwNwro8yN2ZepSfmz1GX0fr900GWKLDUNAaX9y4ISId1Gi6mooz+Kr96WcLfOiMnyXKHxpW0WljR+DjrAnTtei31FjA76fwTH3SxLNAb1yrd9QS96cdhgWM8GFBQvOh69mxx7OnuePiP6HO7fVUcpGL7cZBqVVmgG/rSH50p5TKT0jaD7EFO7ZNJWBgdfNJVl6FRJyMEZrPAwmoPgkemon8vs0boaxi0nh4PxjnvfKjoGY5CRCbjtweOdPlygsiXBO5cM4+F1m+tNex15RVmF/iQ4yfHGz7WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJmr4z9Ih75M6QdTMHfTIawHtgOlo3HCVlmyRBgsqYI=;
 b=XwLisu7gEI6KXCXBn/Kous40uoEXijwiP1Yu/tJnUz9gakEqJnhsLX4u7UvFZ2faPKMvGAfVc/8HV3a7Ikmcem1b3+P+6NcIsPaqoB9tSlW5A7U6T8My/jG76bjWl8DDFrZGPtYMXOaaGDZBOY6t2uIlTbO3Vtj4JTjIwejv47TTbhyKaKNeRBQghwx7/NTHCXofS9ypdhJnusUfawhiFc5c+Dh1SmNw7L962OUx0kgAe5ue3xNw3im8MWZwRIdQqCli0y8yZCPge3zYW+Spb9poDjYQ6K37iN+RXz6Y9KLSZXkcPTbReIkPemTXrPbR22s5jLWmrUSQT2jqCQbFFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB3410.namprd03.prod.outlook.com (2603:10b6:406:bd::11)
 by BN8PR03MB4979.namprd03.prod.outlook.com (2603:10b6:408:db::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 10:21:08 +0000
Received: from BN7PR03MB3410.namprd03.prod.outlook.com
 ([fe80::bf20:122e:c7a8:10c]) by BN7PR03MB3410.namprd03.prod.outlook.com
 ([fe80::bf20:122e:c7a8:10c%5]) with mapi id 15.20.8722.020; Tue, 13 May 2025
 10:21:08 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
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
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v5 10/12] test: cmd: Add simple test for i3c
Date: Tue, 13 May 2025 18:19:11 +0800
Message-Id: <20250513101913.30880-11-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250513101913.30880-1-dinesh.maniyam@altera.com>
References: <20250513101913.30880-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To BN7PR03MB3410.namprd03.prod.outlook.com
 (2603:10b6:406:bd::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB3410:EE_|BN8PR03MB4979:EE_
X-MS-Office365-Filtering-Correlation-Id: 49037b05-2de1-4f7b-8e57-08dd9207e06b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JMNOZKM2qYNQZGAVuMeOlnpdXT+GuR95mqytnJ9N3qF6wsLIieQ/z4ia2d7F?=
 =?us-ascii?Q?3q2U93Zs+pgX+vV+B5p2ao5pR75K8uEpGvRmvyZdRuS2gyaSpcXLtwROGP5f?=
 =?us-ascii?Q?hk7I9or3ZbXq6xMu/zH+q9yFdUIgRPL4MME5w+q8ItUeXxxkvvDHLf7jdZ1K?=
 =?us-ascii?Q?eFswfEa5/db7jBmfoSUadTculk+fIDiupnXbdvV6mMJxt6p3V7lEtoyQTysz?=
 =?us-ascii?Q?R/Hm2vRBiQ/gBK8OFeGeWemfg9ZAz6wsXVe113Dmy4IwcuhNe0PBb2AOiWSF?=
 =?us-ascii?Q?8exhytRE06Er7MnjAVnmDGrqsEn4EMXnGUkdkXvhl9G85p4AfEKGuzaTjx7F?=
 =?us-ascii?Q?xwdprgQZ+PmyZv/C7GPfoctK3zjJFAc/O/nZVzLmzoyk/s2gv7UR/yUceW0V?=
 =?us-ascii?Q?d+rx2awfrIVQHH7T5ruKjZingY9WgoY12XO7o0kuSsWGqzrMeMvphDxzFVzw?=
 =?us-ascii?Q?72dj90eeKZYLM9N6w1PvBE+8wCt/ETnSNeRRyJoolPhfB8C2/iURenQWq4b8?=
 =?us-ascii?Q?r9u4NgPc/B2wSNJtnRg1MgHKSPH5/0i4oG1bOpIOpYxpuiVkVKpwHqmGyaXb?=
 =?us-ascii?Q?yELkqQVpiPu1T60FiSv4W73kNDKC6GnyE7OcCTtEykYs82fBJ4CCpKicbw4t?=
 =?us-ascii?Q?nV45eF18Hma/ILA0kQ3v609jLtXRMBsdsMCBYw1JqzB6aP+s6bTK9WicpCoO?=
 =?us-ascii?Q?y4ywa7GK5o1nlHNJB7Pn5j1qrcGWNWlpFh78KTvBMv2mglMDGldYrSM0FQ6M?=
 =?us-ascii?Q?yEu7fqXP9LYlFmqMR7z6Q0A6cCx4gDBuTKfO3pdVJEzw4CEZk+klTSB2+jMp?=
 =?us-ascii?Q?vTgW1rBxl1x5PUK1ZvU4X338b5+XVnjpEmbpH+QxQ3TGEJPgDJ2uRiJ8GNmO?=
 =?us-ascii?Q?tcdZOxX4/7pjIH7S1U7w7G95OFsiHEapTpnm3iq3wm4iFAsbNyNDEqF8yPui?=
 =?us-ascii?Q?+ReipW3y0thrRcNAEbTxaYQAxvUi6/3F6PcZwZ8YsZhqsm2CbLNWRiSyluTH?=
 =?us-ascii?Q?i2Liklnz9TSJvfmmVqysQJqKLgxXKN9UA2otkTtpTKI3IMjiyJyRrZAzm6EC?=
 =?us-ascii?Q?YTkUTxf+OQ/Ic00H524ACG8xTmt7MDlW8FyUOAEGe96cvCVqpiXajjTJu4zi?=
 =?us-ascii?Q?+j6bCLrd4SnIagk2z2iVlKmEJsBzyfaaSf2YQ8RzvTnfkEQZgXs1D7sqyE9X?=
 =?us-ascii?Q?u1HhbPQd96neEABsb885FxmYIVmxh1AvLzV3syG4gN0W2fuoS9pKjK4Mm8/g?=
 =?us-ascii?Q?0yI00LmjKBjzy58LpHuom96FugUkM0Cc5RyjXc/BYjv9s8iFCiSmYz2+6gth?=
 =?us-ascii?Q?kNhP8y2q6r6u/UBYMBAOxqjDggDmVCrw2diKIMm6ZKmP8AODYL+x+pXc0s1F?=
 =?us-ascii?Q?+hzOcUQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB3410.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HxL5dU8rYwRR38n4iuSzhCwHcDdtl9N8OJyYvE1Zjxb+ZSLNPa56VcVSYgAd?=
 =?us-ascii?Q?tlQa8ZnBo6de2QdqILdhoLf2PdPtl8SVTq2F6fMYplxHQ8hbhAjUymUS1lnM?=
 =?us-ascii?Q?nC8kIg/9i43c7YwFKTeXGmWDpB01sevF61f1yoiYQjCJlQR0h7RX1DeRgoDm?=
 =?us-ascii?Q?3zdlbd3AndRxjZ23xHdOdOQaKew7Qlm+HEVU5+wPfWXY634XUARHmAWbEq5q?=
 =?us-ascii?Q?QfsoJkeAM20Rq4CtnSgF2qgNPbuP1ygvBrFy2VMWtuqZCOVFaQhQE2HFvcvL?=
 =?us-ascii?Q?DFzZSleOLtnx0u8Mb7KFjcp1s+aVGeWJpa5S3eBwbO2SdLdXcoDuvzys+MZ7?=
 =?us-ascii?Q?fMxM9EBFQEHI0OWtiIw4rqrjRmWPdY7b9jt6nmJC7shCPhwlH0CJRL2Sqgew?=
 =?us-ascii?Q?6+JaEkz3HLVlZezxgkA+PSqLtgbefZfV9OiqTfesQCRtMgry8rkGpWp8etSh?=
 =?us-ascii?Q?FyQJSd1sSw2QXuURNQrCTjjsp5rE5aGFJmrMNe27Y+NjlkeFZu/XA26uchrq?=
 =?us-ascii?Q?XLWbe34IvCyVERJq8pH917csf6tER+xA9yAIN8nUcd7lIttISIm/Fuy3dmj4?=
 =?us-ascii?Q?hqYAFJIj2ydQryVc7CNp1JWvO050+os0ZZgPIkWyoQXgd7JcKdAXZw/4GIqV?=
 =?us-ascii?Q?bRvTd85glt//bm1wQFpRC0mN0ksvC8inE4+8YPX6MSW9dm8gEs1oLuleptKk?=
 =?us-ascii?Q?oC2wY3qBzxnOCE6unF2l9ZYq6BBs7qSYeitDCnjY3waEsnlxJ4g7gJkWIqMu?=
 =?us-ascii?Q?gb1+34VNE+wY3Y5xTImR8oY1OgFOtpJuzntQjHopqFOnZWMzppFa07noh6iH?=
 =?us-ascii?Q?0xCJqG88hamBFZJWaaR49g2HSIGKCfwjOuwGKjWNxoZuYTRnFe9IJ8Ker7cA?=
 =?us-ascii?Q?OlpdibSLgIJ+K//dY33JMLt0xyBsSrsX1o7OmdXzuc+waUenGctyKri4GKFZ?=
 =?us-ascii?Q?/za01otw2cf0PRR75X4ZJ+dKxQCjZxxACzr9e3g4iFgU3N31aJ8qP3+DfVgX?=
 =?us-ascii?Q?y1RBEoR1mMdVELd9vKhR5Y5U7E9Xt00l2QQZOfq3ZzD5RDeuhrP71UeSA/6+?=
 =?us-ascii?Q?nVEPqkfDklsLwaz3A1lkPhV/qqaAZiMTGZ6LSm8lrEkGVdNRfmswb1J8P004?=
 =?us-ascii?Q?PGZKEHBiv2hxTEeDsSBPN4fo7jNbsw3DrR4+5cq78pxBgqNt67/6WCebkT4z?=
 =?us-ascii?Q?E5RUX44hnfj47gMwTouHJxpwdQfQeRnrt4vI5AOS2BFwZAWsWyQyp7iD/CkE?=
 =?us-ascii?Q?DGhKP4A6LkrIjJ6Z3oLw9N1luNuhff0lN/esWXL20R7DI0Vv/HkDhsj4rvuf?=
 =?us-ascii?Q?PpfofB6CfkLuIx1Bpz2886RYFy86EwXGZmYsZGTszGB9KHfG7OiudlvCRiIh?=
 =?us-ascii?Q?753ZvH5bmIkt922QfMZJaDmswCB68Y6fwyiPxeWYT856unNa2TJb6Ts9FrUY?=
 =?us-ascii?Q?7LL2TPFtJ5HyEsOWdMdpEIE4UiuoO1GT8YXrvyX432a4LncvVvScPBLiZo62?=
 =?us-ascii?Q?U+xJi7cnO+io36ulUpPqS7rI6adIIk2VZ2zBjBLZnt+D0crrIZDtNhP9OGue?=
 =?us-ascii?Q?mU7cNH2PTLudxc1RHop7aFsgKauIAIj+M34H3YwSCLX13wLtB8Ai+xDBLyYv?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49037b05-2de1-4f7b-8e57-08dd9207e06b
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB3410.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 10:21:08.7053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXohQgtsPSM4sbqSp9C1HtmiR6OtK8D9iUtyxH4qC29GtKUyLHdHhqJF774fe6Oau65cNCRsjuzQg1rVg8XT66YrTefc6jhWfLMAQ4Zvthw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4979
X-Mailman-Approved-At: Tue, 13 May 2025 14:28:49 +0200
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
2.26.2

