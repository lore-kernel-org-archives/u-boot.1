Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E57C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 04:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C714783037;
	Thu, 17 Apr 2025 06:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="WNYGZnq5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA9A782CBC; Thu, 17 Apr 2025 04:20:43 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D78A82F85
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 04:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJLIRcP8xIELsWxHgRAjsRo3NKz/wi+na/9o+bBp3/TmZl6eCH8nI10B0wQiNkrr1ChTNhvHH6RmObkMy2F0a3Jj9EB0sV/VmCQIQ7ulUV0xrr9OiQcEJbxdF5jrhpooGiaXxLnSSw5uBptailFLdPjGYsmVp6P0nppuhI2RiqyHGg2cYzFrZJAgKVmm7G1yHoUDXvmf+QYgyuINic/DmCfCPkqxhss4WEZmQ1EgOqDKibxaDZRvCCqyKIfv8+GnUkLn1peQH+zSC7okaaV3P8v/KW+yPoTENNj+oGIIhpK0PK9I3+bMy4m9PUGmDhRHD1pIjLM802eb0BBp0BfsgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vRzl8PeYtrxfft3AQvG1X3XMObrAee46aXmY5xjVPg=;
 b=Ls9F26nUFoG0RXfp/uEHfPem2kc0vanZfcp85jWD0Q5N+NtwDMXveegEiM35A5vsl6m+P6P1uIoZ57bpx7qYkGLzJ670omPFY9QKIvRedtRbAdD11A0IyDMm+cOU2FYODkfAb9943cxFo7k0kZ3ZC231rnYC6xp8skL0r6Ui2GDzYupDJHpb/ytm4SjrISnz4x/Dk8IffpkfsF9xuSfsSauLzRZIvB3QbNhewLM9rAXIrFJDN5TpD3q7evTNPEQP7KFfb4x9bsLxffjivrakwNAS+03WoUrmKsVTD6BP82zw8NrhxHmyEy3p5olGH8MzW3Bjiyu1Qg9xPNTIqM4WfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vRzl8PeYtrxfft3AQvG1X3XMObrAee46aXmY5xjVPg=;
 b=WNYGZnq5dlqtQb3E6kX3pSEbgtVSnaPYjOk+m2KgFYtP3eAddICqHxBnqiq/4fr7N1TX75HFdh4UzT5DY+gFPxTMrws/6FqJGbx72LZX3omkwi7mjoUBC5MYnKEx9OlYBSrPSTLCcB2rMV8qp/wQE5CL+NVkW0lFiocqe/LIUJFot0BBcpEENTYH/roNuji95X+JFKp9rjDKPidASSbhuMM/mCWRx/YCYkWQ2h8dCwZq09Wf4IljePCd8eiySb/q2rQOgwvyvRDoptldH9Od3J82VoVGPU9YbRqxxgbU+/tkKwtz5UB7OtUAhuxL4IwQJZQEGKtiu32SfcnmwUhn3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by PH7PR03MB7414.namprd03.prod.outlook.com (2603:10b6:510:2ef::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 02:20:38 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 02:20:38 +0000
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
Subject: [resend v4 10/12] test: cmd: Add simple test for i3c
Date: Thu, 17 Apr 2025 10:18:38 +0800
Message-Id: <20250417021840.6212-11-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250417021840.6212-1-dinesh.maniyam@altera.com>
References: <20250417021840.6212-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To SA1PR03MB6370.namprd03.prod.outlook.com
 (2603:10b6:806:1b5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6370:EE_|PH7PR03MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: e279e094-53fb-49d0-d320-08dd7d5671b6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qvOO91s+kKtKOAVpZKy9Ipd/Lx8m38JwFJJ3VVC1EfLXqPEww6rVwKrtgIFh?=
 =?us-ascii?Q?55BEmRYB/n596QAObkhNNcSf3Mlnx49C/jFmeG09sITJwKUG7hDZaJyEqjQy?=
 =?us-ascii?Q?odnsHY9EKSTljzXOmMht4uBZe3L+bhya/+aMVENMpT4fyMtwsOkh9KKyok+h?=
 =?us-ascii?Q?QCGnGz0bt+kjkICpJpu8TVuHQWzmsINzB7KNJymymfBSTo3n47JmDjkZ1Utv?=
 =?us-ascii?Q?tR9NxSqCd6Nawi73YxHsgFCEpYZJy26FUPo5UxsLB2Lrab186ERpp98fx0fK?=
 =?us-ascii?Q?wIwt/ejDzGO60Uf9cXfop6UGOaPxzKw4H+JJ5a/XuDdBXCAtnq6A2kpC3nax?=
 =?us-ascii?Q?w3zuRfnjWIulKuizTZDXhwWUsmmshsH5BU9TD8vZQ0khgzGTyGhW1q9LyLpz?=
 =?us-ascii?Q?6PSWzhWM+kzHXywH4z78eAz4AkYxe5Vey1cO1LytJrd61eFLZAJWnI5G7QEa?=
 =?us-ascii?Q?PMFBKk7rYmfwvHq06WFuUCyH73I6iBvn3tATpSHpdz6IoEda/bbEccu276ZX?=
 =?us-ascii?Q?QbRdrtwUUeIzFSUX1TA+nVEtQF1CB6bJBMlIdfIaIOIyh/1y8jt15TI8zFRD?=
 =?us-ascii?Q?J1K8vAMmrvLfXqF2/98KlI7IyK4vCAb43A1iXSomad5pnzvwLXZYQmQFV5v2?=
 =?us-ascii?Q?pOaJ6r8HAFfEfCkALMGFR5EeZthFWJxJ8kiqoXOltSIxQZ8T1JhS2ZK09q89?=
 =?us-ascii?Q?Oh9ccsgj++K4QrHrDKFxpdr2gxnBiOpa4y3v+Pp02KmTuyAGnzu2ytyqsc2/?=
 =?us-ascii?Q?egmUdS3OkqRuvDAdIAvTRm6ZPYxpfjn4v5fUoqMCPlOhQhAE3m+d+jGtd4+K?=
 =?us-ascii?Q?RRmNfsenbiF7PCYkBczzxeVQ47UYs+9EBkTml1nqUlIQC3bwN3sGSLUIBX3A?=
 =?us-ascii?Q?JOi2Zi5O/sFbKz9GdYZmD+8pSoqdzYD/pJhKccwGeCOAidnLv+B9M+P9bzBX?=
 =?us-ascii?Q?4OGGCz0GG04OQjmOnUUHpIU2snsWbBHJXwnOLTsuVSDXy/PLmvH/jtN+qJB6?=
 =?us-ascii?Q?9WRS50uH9swJIVoVURq3EGczp6fsr/XPI39nVXFgih2XwBB6nDqjlxKwL0Ki?=
 =?us-ascii?Q?TFhjQsjywYfQ1hgm2ubVBdZGcTeuSOtiU4wy7yeu5SyaD5Gp9G/LNvbbAKuc?=
 =?us-ascii?Q?+S1F5x0SUsP2AlAlGeBn+H5Mh6cxsRv/fhdDG7B56HfHdhZmk01YtVr0pi4t?=
 =?us-ascii?Q?PUJbHDnD5rWaYoVHBl4pFsDS/VtMZdxvaTPR6lhVQhk6VKs09qt5qlW3rtpt?=
 =?us-ascii?Q?LDqS11QVfVRHaE2vxMWs9z87TUMoqyivEnnqo9TQsQUhMH6gtWsweDay/KNn?=
 =?us-ascii?Q?EcifJxiBaDerz8qeF7k5dsfK9OMQGzgT+X6WxyItivM7zWDT1KMgrQkzVDlg?=
 =?us-ascii?Q?zFID+zA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CdHtQe6Y1iCWgwO2qR1H9knMjyrQdQomxXlieX4EJwgFik2RQoZ0ncZdwFOu?=
 =?us-ascii?Q?OwQzG7PU6wFNBn9HHgGNbNfocwGLFme4bw2UAN+zkPr3BEg3QQEQp5PL/oDK?=
 =?us-ascii?Q?a1KHIgTR/MXEdWlRs1A4TBXIeVLbP9vn77VGbmlb97Kw8dVnUEELTUDRzwIi?=
 =?us-ascii?Q?dmhCeYNSab12wQ4STqTXEEnJOv5zL274ZVoESbr049hCbnlXlbnPm5gCrJBy?=
 =?us-ascii?Q?QGSdNmiPMoGFEH51mstilEoM3dci4XKpBAdSFKTVpxtQ7zgozBETabRaFQ3q?=
 =?us-ascii?Q?Y3k80gMApzSuRUb6UiC+UK5Dw7AkQvExrk2AF2e/1zlwWQP3pdw07+AF/iYJ?=
 =?us-ascii?Q?VwzdToHyfYeO/d5HyXvi+Y/Ljfl+FJLtE0JH+6bdTy1ztN18FhH6Pfjo/Nqn?=
 =?us-ascii?Q?NrTIC+dQbOxg5r5k+sLYSQVs4vRskpV3/1XUoTvXgyApUdJCYqg2FgrmRfSl?=
 =?us-ascii?Q?znphRTDCaqIbJOnJN/MABwUL/SYJNFhTKH3gJi+9mtmB2m/B1ufQWWPxRfns?=
 =?us-ascii?Q?qXvlJqxdjKqtP7/0q6nfvYxxWCeRZ7xiC21VeSPG5ajI3eHF8koaRna9zOgV?=
 =?us-ascii?Q?7R8p52RsQ2W9iZhiS+3kqYMhvl7UGHQHacN9rgdu2wzQ4vd6+w8TUFijz5Yi?=
 =?us-ascii?Q?3rUwYIOAk3OSy/igH11BrZjz0Kxh6gbKFL/26xnDJwZAmwMW7BCRBjpxqIxx?=
 =?us-ascii?Q?WT/0OxiGmuG55eoKvYGvB7TJjubAkJR+/Q35jKfXFiWjGdSzI/uDqE8sYHml?=
 =?us-ascii?Q?IX4/p/yicRFmu655t+fDD+2R/mN3PM/zV5eTD4WW5nSH0fHAkWO4wd16HZB2?=
 =?us-ascii?Q?gyO2x9tjUsJ/6lL8chksNM/qU10o/AnBczcDC/Ku/YIc5IZ/fxxrAPC/+fc7?=
 =?us-ascii?Q?4K2YMg32FJkugZF/GL70zpYUlhUB2FL8WX26bOnrnA3DyyfvMTTyp26sEbM6?=
 =?us-ascii?Q?fXOC+3KTbPTdcWcF8tNoqpMBzDzLXEy1Aa9fDysXbHP2VfoZUjYgB3rj/IG5?=
 =?us-ascii?Q?8yIcdxB8326Jqt6vazZ8RGhP7S5Du2PWT/r2dYwWGm1YRDFa5c/Drs+6NOAa?=
 =?us-ascii?Q?wOZb5/FWyg9Z7wTqw3yyrJl0KxjJ1oX0ROCEdlekJAbUPUe5dDozQQrTAtfd?=
 =?us-ascii?Q?svDAiyFSXwKtO2/FN8YMqA9bXdRcDsF3mGyVAATBtmXgT+cZjyMTWIWYLiBr?=
 =?us-ascii?Q?kzY4StFgXo5oktnpJ0g0p5OtkB/Yy6a1E6axFn906WPBfUGql/waLZlFep9d?=
 =?us-ascii?Q?IjG7dCvHENB5VrwlevkmkfslaP2tEW/5o4JQ2qBODQIAH2++PTPPA86Gw0RH?=
 =?us-ascii?Q?OaAG7hbfYQv6vK6Bi8gZzwAS0UxxAJoXP6QIWHB7GQ2TlykjEg2JJmF40Do2?=
 =?us-ascii?Q?GYttEGDR8k9AXqsRu/jwHgBbE8Rd3ybNemYYYBi8eprXBIWRnvZiarfLl+Ov?=
 =?us-ascii?Q?bykn3sgU/0HeHtb1pfpFLjVQDlawMPFUS8OxpfQgRlIStW2eAJmleOz7RBqy?=
 =?us-ascii?Q?JHDl8KQ8gfdAW18vznt5jJ2yfJ8KvMB6RaBaGxQKyoV2xYDeeXxLtfrYgbGY?=
 =?us-ascii?Q?Glb4g3jWTe4q6226v/FaHBBJIJKt4O10nBYP5Ur9eLZVBA5oBst6/7XeETz0?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e279e094-53fb-49d0-d320-08dd7d5671b6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 02:20:38.7551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmK7bgrgOQsDgm1gfA+1FODnEZa6XjnJzQ+KSgucF8T+qTn3qhTehfYZInWK7gEU5nUfuTlHcP2d8M42DlOA4mv9zdezDrlHbiQ8dz1DRjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7414
X-Mailman-Approved-At: Thu, 17 Apr 2025 06:57:49 +0200
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
2.35.3

