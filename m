Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E109C28B30
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 05:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEADB81C84;
	Fri, 14 Mar 2025 06:36:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Si35SKku";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E895580F9C; Fri, 14 Mar 2025 05:10:46 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C61A1808A2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 05:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lY2uanISX3MuqWki3FG5vMTuQBBXC3NHh/DUWm0XZsQzjoFEMuhAdjXPV7hQqNNq2mYtY2WKvjHIQVCHNSIIy67jpbGCOdIck9io4schQh0QNIF0Vhs4Ox0VqaTHG1KxLfiRSXIN0QA5UZlLsbypLaepCjIikECPyqboPdijKXwYRc+t3t6ytM+wbW6jrsVqrbCbL6XCn2kWjx+muRAxOQ36vW/yRhLFoKZtRNKFgjCYaON5E2Ybys/T9Xrlam/G/L6s/wFa7draY/9Mck98eOyeS/xlVInOiNwHYt/wchFcroq5ooJbJKGzzMjLOFIzaarEzU6w51Y3UnAN+uWyzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiSxTXYGeddoXVY3fvahtbdiCHwCvE2YC8WI3Mg4R2w=;
 b=utbcKHFUT7fTfawSS8xRJJLDM/hgGdMiB68Yq0XBvDJw/LgNK8H4aeMrCi0UTKeQ5rJBDBLAgofm/vAiNbYKnU+JU+RL3E7TnKrmUKzYkJWGk54FSINyqveuzHFUMwHT/JHMOa1kUcn7R2mlzkvhpETXAzRXlM+9bY7i4zz3hMakqbpRPhwSzkiRkAo8XPQDML7mYoDXBcW08VkY1inwjqx2Bd1pLw3b7tK4FptKOVfUtMt75M45U3Ot8tkFEjId/U6xWOLSkN1OYVgtwEzDL+bm5/fdTycIhCgeeAYnf8QSdXgAnfq70O9VVQJRDfkOIZbzRodSk+NCXdJpMNpm+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiSxTXYGeddoXVY3fvahtbdiCHwCvE2YC8WI3Mg4R2w=;
 b=Si35SKkuTiREoToA+f51E1ttq1VqNXTv6Nso1waUe88H1H15BwRAL5nP5E5ikTLMLZLDlLV45RrKduzOQ2zxZzIi89sLxWbuY/mC6xGgkCLFkelP7wmK+QwzWsDTok/SX7liLqhzA5o5qSAaDp0bmyLMdApATDyoPrCfqWyMJQUw4/yyYoG7hMgXxrUig0oYJStEzYa1jnE0M0jQEKw76rgRZdcqBqclRz99KSXNRE6max/ld3K+9PSfenh+pRFOHNbllJWdCBEL3HL2HO1AixLNxbGmb+mu55zxVThSiok33yXyBAv5NACV/6MsxJO5M72m1+7WFnX+D+tM8dX11w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB4387.namprd03.prod.outlook.com (2603:10b6:408:3b::30)
 by SJ0PR03MB5757.namprd03.prod.outlook.com (2603:10b6:a03:2d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 04:10:42 +0000
Received: from BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874]) by BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 04:10:42 +0000
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
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: [resend v2 11/13] test: cmd: Add simple test for i3c
Date: Fri, 14 Mar 2025 12:09:00 +0800
Message-Id: <20250314040902.43621-12-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250314040902.43621-1-dinesh.maniyam@altera.com>
References: <20250314040902.43621-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::9) To BN7PR03MB4387.namprd03.prod.outlook.com
 (2603:10b6:408:3b::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB4387:EE_|SJ0PR03MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 9806de2c-9680-466d-a839-08dd62ae2fe5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zovEqfSAptC/6G+R6OKkHFig7fSFl7tOjWFIOCPx3gNzUFzfZDEvUVCoXu6O?=
 =?us-ascii?Q?notu+mKkkb91amWaj78Vc7gbPFYyuB5O30z93D/hz1wQXp8atHJyavRi5qvz?=
 =?us-ascii?Q?VpUtpIud1byO0JqPgtcSgI6MC1Wx4/YWbWRHFZMpB8Tejg+fFBFyyV/PLrTv?=
 =?us-ascii?Q?biLXKDrDMyaVsBLvNQPEA6AC2x1w4BiE3FO0zhzLRCNq2PTvINwzV73ptQaq?=
 =?us-ascii?Q?1t68GYxeg6Wj4yVOol+HMua8jEWL50VDmlaoOyj9eEPpsQgFfuCKoRQDHqBK?=
 =?us-ascii?Q?AXfO/NqtAjgs4Gv1P5YHVRr1zfGykk7KB0L1RUVuy3vncG8nWOv2JPbfEbKT?=
 =?us-ascii?Q?e1/f5TY05WYj7E7D3v60T5FdrJb4cwRBwPc0j+r79ZFjCgBtk3GnIFPb60ou?=
 =?us-ascii?Q?6IbRo/GPnD5+kiEJh0RWQwD91eOI8sS8fAm7h+dSph6qXHoZMWQh9EsMQohG?=
 =?us-ascii?Q?ZTZrLPRM+c+7xOpRDUKbj0kjgVm7rlnacfkLgqXdHeIGJCLxu+l0ySGzf1qE?=
 =?us-ascii?Q?uXAYFoKLiTJX+LLt9lUT7cu8kyrlGWUnfCT+wt+bK7zuB2Oku+B9obzdvpCo?=
 =?us-ascii?Q?JE/y6lwypLFvKcR/eeOWJ3dQz75ll/vBgcKEN9ln0ADjH6GqA1sTO5TnjcXZ?=
 =?us-ascii?Q?T7YVre0priX9cWO2bNS+aAtuTXKnCLH7NziWCcoCTAhlrnzRRXR4tsSmwkHX?=
 =?us-ascii?Q?2Fxo/uvXRT7DRtZOlIkxli71y5vE3zDq7JVEDkeZLGwZKXc1igSpXB2EolRD?=
 =?us-ascii?Q?mI0mUbWBXxWUK0xMBX3udq3eADDMl3CSQEyfm9O2q726kYsIr+ML/d6h+a6Z?=
 =?us-ascii?Q?t2gFEdzd2zn7dbxv5r0OvbPszE6Fuzpqg9dCgH4XAjOCXcSsfjxHnk8zt64l?=
 =?us-ascii?Q?nOkv/XTjKBKx3fq9XB5UL1brRZT37CpLEjmTApN0A+r4GR9xbMh8UBcPWkta?=
 =?us-ascii?Q?6A918hnnqZA2Rs0Zo8HPHuNtD+MUyxSFk4a3C8Yt53SY07mTLi0jvhHqcL4V?=
 =?us-ascii?Q?RCsw7fniZPw5K8nqaIC7hpD9TPSi0TZ86GTRUpTt04PNSkcO6tnOhBg320Ft?=
 =?us-ascii?Q?Ldc8sFMQArNk3r84CheL91ulWB5VtOyUi6a9CyurHe4DRA7zthvrRGp+SojL?=
 =?us-ascii?Q?sBc8BZZNi7pg0ObE7diHrRqqOGHkduMDSev8iZBTougZQoOkoYgrhg7kedL7?=
 =?us-ascii?Q?5wMzSPgEEoITsRgaRynB2JIVBGlPsog2yCj/CzQ528dxzsJSypmXDH79hnyi?=
 =?us-ascii?Q?MD+0+jFjOhXcbSHaHUA/nNfawvrsrzT7+/o8whK72JyMmg1WU4QSp8KiBuS3?=
 =?us-ascii?Q?C784UOVHRE8Lg86jXY+Kbbq5rVswsynmuMsxIqW8IMXbVg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB4387.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5ffA2zM+A52x1SfmSdg5eQeW02lb8ojBmXH+wzxXzcH2JjIxvgOj6qCoCFMM?=
 =?us-ascii?Q?1gxuF/xS1GvDwP8wwGq29LRdHthe4h5Fm33lrrabADNtFzJZFH676UELvI3w?=
 =?us-ascii?Q?lVPsOf87XBtK6tC2HjtYXFhrTJe+VJS0deV/vjse/tzXOoyGAgJGD1ZcfXak?=
 =?us-ascii?Q?cnf9rJiS6TGlpSKmc5aSvMHbIZc0C1dKKm1ggkiDthAG/0deLrlLBvgf5O0m?=
 =?us-ascii?Q?u6uyHulLDnOrkS1olSqMqQ4QS/fOv/Luk6PrH8J0v6xASqSoxqF3f/pWTEf3?=
 =?us-ascii?Q?k3t0T+OQOt8PJv6PjyHuQAjaTL9O2N4zZiFYHgRE+1zsuPOf7x0sODaeluwi?=
 =?us-ascii?Q?AnS+YYDSDsw7xqv8uFGNjbxPA0TNbkCrsJBsSjsa/0Li2YAvTJ7tQ6+bdk4k?=
 =?us-ascii?Q?g3P0H9+kQlO1L9jPVUB4LMYw6Ktgbe4PD90kNhOMn+tVLbG7jmeAdN1YQbPx?=
 =?us-ascii?Q?/Zh1ZqANpjR62uDe5WAr57T4SKWbJnMfQKecb6MIvALKSyrQCwVrLoXWb6rX?=
 =?us-ascii?Q?y6MZZdyga4uOcnIgw5xC44ZXzpSeBzJqLqr6ZRVOicVEK17ZXJ2w44XLGMf+?=
 =?us-ascii?Q?EtHVtYJisSU167csmjvwiLsInyrxBEvRW/Er65pXKjNfa6SEqVtMSEoXQaqO?=
 =?us-ascii?Q?q8B8e2yFw4vIi7Ue1CiGJe7jfPWz5htPhPxrT3SXnvci5hZDcYOjVOgXbd7J?=
 =?us-ascii?Q?6d1JNNOqMnwX4phE7R1qP54ICMh5ti/K5oem5kV5PafD8t5riXGFsBvbBCyb?=
 =?us-ascii?Q?NLfAWEYxZiRTDU7FxEflwEzmtNt0SygCe8fTIdhNOkv6XbOP01NgoLCF1akV?=
 =?us-ascii?Q?u0KzyAyIHikIq5695XokAYPzqUTIgV0kQD1+7mpNqzYJNPyIB9ekHpWht1MS?=
 =?us-ascii?Q?SOxaBKoMb1BPzwKOijvYUGByaqConHhdiMhn22hwjZkSNqu7GI4+tQMQ3QJZ?=
 =?us-ascii?Q?u3ltD8Y0nFhMfi86LFSFQq8BJUm0ZOr7VYvXwH/EctCF3Fqdh6HAVoNCqnSA?=
 =?us-ascii?Q?Ao8IMmdMqk78tysWbQttUTKbVOu3g85GC6ZCoT9Y1sta9WnSq+LV6dchBs38?=
 =?us-ascii?Q?mVnL3yZWAJriRZJQP8qmCmeBENRa/wdBbFGL7qvvyn+EH4KmVgKM6Hfg0nvf?=
 =?us-ascii?Q?qI4MGuwDChfWkHO6jNoRw7T+QGf7ZovcbJPzvn90oB1sjxh1E2+O1nAAx99a?=
 =?us-ascii?Q?VmutxgrpfQUrA5lYG5g1HKh3UDh2iosLrZAi/APfa1EBcP2jGyPOBYxYNglm?=
 =?us-ascii?Q?VQkxNvDzyeRzUnbCNREWC4W1SG0EJT4fnKvO+QIk6VF+pYdKP3tPCDBJDZpp?=
 =?us-ascii?Q?2mIZCWAA09YZlT3nFhfo0G7fEa/y233l6LWY2TZKWChliVKjlO3FHffNdDZi?=
 =?us-ascii?Q?RvT5/htF276Shztxf3bGUfqSWBldHU/KMxKswnc6mH4IOp+DsEP+aY6gI065?=
 =?us-ascii?Q?cQjt2ZahP538wgq9rmfiMWCRexrxrixtKM2YEtSzW67VZMXSMLbaMdEBr8KW?=
 =?us-ascii?Q?HIhwMkjwRqWio3KEMuvogcZecT0SnVm6l5MDp/Jiug7xBE3UbwyQbfk8HyKP?=
 =?us-ascii?Q?Smu0XWFdPyKV9a6rvMCCE0sMXMobjjYtIvMctKsXCvA2YJl8caAJlDDHFk0F?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9806de2c-9680-466d-a839-08dd62ae2fe5
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4387.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 04:10:42.6381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTsfwciFqhWei+b7hP9ipsIUjeox1ekQuN1iCo0FgUgp0KqI7yOMdfamn/XlbXKfFj/GOAzskuLgAx0JnRtF6Yb+g9S6VU9mAlx6mtcRXVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5757
X-Mailman-Approved-At: Fri, 14 Mar 2025 06:36:33 +0100
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
 test/cmd/i3c.c    | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100755 test/cmd/i3c.c

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
new file mode 100755
index 00000000000..471dfacd5c7
--- /dev/null
+++ b/test/cmd/i3c.c
@@ -0,0 +1,52 @@
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
+DECLARE_GLOBAL_DATA_PTR;
+
+/* Basic test for probing i3c controller with invalid name */
+static int dm_test_i3c_cmd_probe_invalid_master(struct unit_test_state *uts)
+{
+	ut_asserteq(1, run_command("i3c any", 0));
+	ut_assert_nextline("i3c0 (i3c_sandbox)");
+	ut_assert_nextline("i3c1 (i3c_sandbox)");
+	ut_assert_nextline("i3c master controller is not initialized: any");
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
+	ut_assert_nextline("current dev: i3c0");
+	ut_assert_console_end();
+
+	ut_asserteq(0, run_command("i3c current", 0));
+	ut_assert_nextline("current dev: i3c0");
+	ut_assert_console_end();
+
+	ut_asserteq(0, run_command("i3c i3c1", 0));
+	ut_assert_nextline("current dev: i3c1");
+	ut_assert_console_end();
+
+	ut_asserteq(0, run_command("i3c current", 0));
+	ut_assert_nextline("current dev: i3c1");
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
-- 
2.26.2

