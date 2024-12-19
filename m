Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E54E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 04:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AE6A8033A;
	Thu, 19 Dec 2024 05:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y0BEYXyA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AA3F8021A; Thu, 19 Dec 2024 05:39:46 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6AAE80291
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 05:39:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QbV9nYOwYGXrTHc7AA1sgXFuez30A4Aa2nhtpyhIemoqaP69NZy1XEAxuHznxEak3eIqL4ZCY5PZzZLNBHzU1agMr4cfE8hkLDKWUXzgEZonkR2F4o4QGMNxbtfgVqBezKVJ4WvYPd3zxNxRrB4uQ5H3dHbqvY5X6xQ/LayHOoIgojcSzMJwd/UOYgjyXNjopBcVkfTHgfAbzp7THKR+bSLJOi1TFm3OxtcPMJzvNowGt6Cvv+Ro40oYYpd9cqnkwfI5yqeQqBo62LNuy5xVLMhC1c9SPq4Ec0ZwwyE2aJ1K8xY9OzpfBKmDi30EPQOMeJWXzCJ4zDlT7ezoHRNJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbGZCEt7bS+deWfSJ8F40Hp8jazCMwi+k7yML6LfizM=;
 b=LKrfqvP7AU9YrnK5JgWgGz9qhauAmdwJSAHe/tOv6TQcEpF6HuL4q0wBZzmGDPnZWVE8hLKKlWgjy5ebKLFN+eGGoyVfwlxfo14tM3arrGJRlrAODpF22+Fut4hsT/Wz1JKrPuMzlnHbwp251LcEP10zIZmnWJu0xVYAjXj4uCkcrO1qzKzrPWYgRKq3dRN8VXfCy362eY+hdMXr3rWSNCg0jFgUwIBvcBN2gu6+GVWmgvVynz69CZHNSJ/4/SFEAByjItkiNIIezG62S8r1v86SBuQaPT8BKNAjBKEQmNw39SqVGL2ZvSQKQAM2T9Vli8CJ4oNN9PBCfUEgPtGBGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbGZCEt7bS+deWfSJ8F40Hp8jazCMwi+k7yML6LfizM=;
 b=Y0BEYXyAMqPPY8nD068pgLNKrL+0UjmsvWLZalGTahmCNY4fUV3B9+Xw/T4I0QaMiy4lf4wMpDM+J3OJ02rN5E2QXIH39C8gTkD9XjNA9VHluET5CLv72wI6yLiK8PKhfTy2qLCgn4gd5rKfc9hvbROAv1CfaRE9sholjl7DHMI=
Received: from CH0PR04CA0058.namprd04.prod.outlook.com (2603:10b6:610:77::33)
 by MW4PR12MB6849.namprd12.prod.outlook.com (2603:10b6:303:20d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Thu, 19 Dec
 2024 04:39:39 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:77:cafe::19) by CH0PR04CA0058.outlook.office365.com
 (2603:10b6:610:77::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Thu,
 19 Dec 2024 04:39:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.6 via Frontend Transport; Thu, 19 Dec 2024 04:39:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 22:39:38 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 22:39:37 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Dec 2024 22:39:34 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <jens.wiklander@linaro.org>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>, <jerome.forissier@linaro.org>,
 <mkorpershoek@baylibre.com>, <akashi.tkhro@gmail.com>,
 <francis.laniel@amarulasolutions.com>, <ddrokosov@salutedevices.com>,
 <git@amd.com>
Subject: [PATCH v6 1/2] cmd: Add support for optee commands
Date: Thu, 19 Dec 2024 10:09:17 +0530
Message-ID: <20241219043918.1646095-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219043918.1646095-1-venkatesh.abbarapu@amd.com>
References: <20241219043918.1646095-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|MW4PR12MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6d8e8b-5d7a-49e0-c787-08dd1fe725e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EmVz85ig89H9kcAxXF2YKKHHeIQqbEq2VQEFR25yrXTL9iFb9xFhIKEf3bp7?=
 =?us-ascii?Q?4t6emZWdsvaytemIfSj5Qtz7jlMZkV3jay4cdJmdEpA8NjbG8fmYdhA9bT1A?=
 =?us-ascii?Q?k2Wn0jpWlXVAcS69aw4wK7jUXd2QDappuKKi6r4zw98j823nfZrgUoM3FdJz?=
 =?us-ascii?Q?0smsvP1E5/h3TvZs6MmJvwfSyHafRxkIG/wiI9OCQoN2afsBp4jbRlndA0qz?=
 =?us-ascii?Q?4+1riaRGjb+zAfyOsdG6TL0YLjg6Z3IYudkw/gsl86GHg1j0LzoVE8cBDQdx?=
 =?us-ascii?Q?T2kZu6PqQcg+2kPCG9FsG7XX90rXFoISHC8alAFOUzNc3xi6gKCYS6s0HCHA?=
 =?us-ascii?Q?umLMi3qE0QxJ+Px8djCmZi4/ll116wyA89iVXgEiyedeEQG4WnFfWdvb+7Oj?=
 =?us-ascii?Q?MMfOM9nRCKGpLdFQ+02sAk8qOhdYBbUAJw+p++sbBpBAwaGSck+Vvmak9oGK?=
 =?us-ascii?Q?wqhc2kviq2hqKgU8hPY9zcnkDfDRiU2Wgcd35luJDtfA5zmcGC0W1dVeZkUS?=
 =?us-ascii?Q?NwG7qy31Wneo3Bvy9HUX5tik5eMUoOtlanpcfb70piFMbkkssYWri8z8kPgE?=
 =?us-ascii?Q?97ZfOBW0ZQmGjQKmXKibCdRPhfYuOwx7Y9CL4JuqwMa+k1VKlQcGsXj6k2Sd?=
 =?us-ascii?Q?sSxLeNXDgxadZKOB2zeyWhdI+m4BNfcOJwQbMbG6c29O203LNc1gA8eMRHLU?=
 =?us-ascii?Q?Do6igJNFxh2YY9LsCx0E+jGstpo+MQIbmdRPtPmFPdFUNvT0d4lSbj8EEx4o?=
 =?us-ascii?Q?uX+XAY+e6brKJaaTwVlSSkr0uF0wo1r/+SyziZrbc7v/n5jjkLZDGM3CPELj?=
 =?us-ascii?Q?789UD2HAO8Ynvta8UfDl8g8IddK608XwHAPrQlPpI4OMFXxNnMx1WsLavu9b?=
 =?us-ascii?Q?aEJ6pt5p6eybqKP/vpHh+2XMAagRQBFY62yUh944kjt6AM4HwpRmru8sd+7M?=
 =?us-ascii?Q?tWGZpfxqjplZLs5NOYcY2VBihrfdptDdu8bH/nEgaI+JAFy5IIS+xCcxYoCI?=
 =?us-ascii?Q?WuYjX1EEGdWOU0IBDgZpshFR5LPIQWxJRxnHfw7N/BwLUWbBTzh0XWWv5j3g?=
 =?us-ascii?Q?SLFSsrPNPpBypNT94S8H5n6ijPjWGh9r0a0QVn9tdQmwr8aMo8kbJsAyRhzM?=
 =?us-ascii?Q?r1RhbVxeG8adRVXBXwJtVcDjVI/2PMipN6JH4z8CL5KjORVa/+4U9Yhxqp9y?=
 =?us-ascii?Q?gGxiE/gLUOvbhgQ3d17F+DcNOAgxKrJ/LeZmRxqaPOX1sL/sXEOw0kGTdM/v?=
 =?us-ascii?Q?X3tuti52S09N85lLITsBbOZuxs2QXzSRVtLLCwLFMX1ZU4x12JTMDalgCu0D?=
 =?us-ascii?Q?2qskI5xjix/+HDiXifkNKv1B7YLITL6x00wverRB2cktzyb191f2jartbM6Y?=
 =?us-ascii?Q?yvAxuAlB8qNu9C50M1jjRvlDJkCsuOixtcyRvYsCxj3N3ZrmK1+yVZlRjIKs?=
 =?us-ascii?Q?No3T1LKg3wc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 04:39:38.9001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6d8e8b-5d7a-49e0-c787-08dd1fe725e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6849
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

Add the basic 'hello world ta' command which increment
of the value passed. This provides easy test for
establishing a session with OP-TEE TA and verify.

It includes following "hello world ta" subcommands:
optee hello; default value '0' is passed and gets incremented.
optee hello <value>; value to increment via OP-TEE HELLO
WORLD TA.

To enable the OP-TEE side HELLO WORLD example please refer
https://optee.readthedocs.io/en/latest/building/gits/optee_examples/optee_examples.html

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/Kconfig  |  6 +++++
 cmd/Makefile |  1 +
 cmd/optee.c  | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)
 create mode 100644 cmd/optee.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 1d7ddb4ed36..4b33468891e 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1446,6 +1446,12 @@ config CMD_OPTEE_RPMB
 	  in the Replay Protection Memory Block partition in eMMC by
 	  using Persistent Objects in OPTEE
 
+config CMD_OPTEE
+	bool "Enable OP-TEE commands"
+	depends on OPTEE
+	help
+	 OP-TEE commands support.
+
 config CMD_MTD
 	bool "mtd"
 	depends on MTD
diff --git a/cmd/Makefile b/cmd/Makefile
index d1f369deec0..533d0f6a1be 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -118,6 +118,7 @@ obj-$(CONFIG_CMD_PAUSE) += pause.o
 obj-$(CONFIG_CMD_SLEEP) += sleep.o
 obj-$(CONFIG_CMD_MMC) += mmc.o
 obj-$(CONFIG_CMD_OPTEE_RPMB) += optee_rpmb.o
+obj-$(CONFIG_CMD_OPTEE) += optee.o
 obj-$(CONFIG_CMD_MP) += mp.o
 obj-$(CONFIG_CMD_MTD) += mtd.o
 obj-$(CONFIG_CMD_MTDPARTS) += mtdparts.o
diff --git a/cmd/optee.c b/cmd/optee.c
new file mode 100644
index 00000000000..d0d37293986
--- /dev/null
+++ b/cmd/optee.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) Copyright 2024, Advanced Micro Devices, Inc.
+ */
+#include <command.h>
+#include <errno.h>
+#include <tee.h>
+#include <vsprintf.h>
+
+#define TA_HELLO_WORLD_CMD_INC_VALUE 0
+/* This needs to match the UUID of the Hello World TA. */
+#define TA_HELLO_WORLD_UUID \
+	{ 0x8aaaf200, 0x2450, 0x11e4, \
+	{ 0xab, 0xe2, 0x00, 0x02, 0xa5, 0xd5, 0xc5, 0x1b} }
+
+static int hello_world_ta(unsigned int value)
+{
+	const struct tee_optee_ta_uuid uuid = TA_HELLO_WORLD_UUID;
+	struct tee_open_session_arg session_arg;
+	struct udevice *tee = NULL;
+	struct tee_invoke_arg arg;
+	struct tee_param param[2];
+	int rc;
+
+	tee = tee_find_device(tee, NULL, NULL, NULL);
+	if (!tee)
+		return -ENODEV;
+
+	memset(&session_arg, 0, sizeof(session_arg));
+	tee_optee_ta_uuid_to_octets(session_arg.uuid, &uuid);
+	rc = tee_open_session(tee, &session_arg, 0, NULL);
+	if (rc) {
+		printf("tee_open_session(): failed(%d)\n", rc);
+		return rc;
+	}
+
+	arg.func = TA_HELLO_WORLD_CMD_INC_VALUE;
+	arg.session = session_arg.session;
+
+	param[0].attr = TEE_PARAM_ATTR_TYPE_VALUE_INOUT;
+	param[0].u.value.a = value;
+
+	printf("Value before: 0x%x\n", (int)param[0].u.value.a);
+	printf("Calling TA\n");
+	tee_invoke_func(tee, &arg, 1, param);
+
+	printf("Value after: 0x%x\n", (int)param[0].u.value.a);
+	return tee_close_session(tee, session_arg.session);
+}
+
+static int do_optee_hello_world_ta(struct cmd_tbl *cmdtp, int flag, int argc,
+				   char * const argv[])
+{
+	int ret, value = 0;
+
+	if (strcmp(argv[1], NULL))
+		value = hextoul(argv[1], NULL);
+
+	ret = hello_world_ta(value);
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
+
+U_BOOT_LONGHELP(optee,
+	"hello [<value>]   Invoke the OP-TEE 'Hello World' TA\n");
+
+U_BOOT_CMD_WITH_SUBCMDS(optee, "OP-TEE commands", optee_help_text,
+	U_BOOT_SUBCMD_MKENT(hello, 2, 1, do_optee_hello_world_ta));
-- 
2.34.1

