Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E12E77186
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 03:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7500980245;
	Tue, 17 Dec 2024 04:59:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RyznUvWw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAF818021D; Tue, 17 Dec 2024 04:59:37 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C4B801F9
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 04:59:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMBwp2mSaYSQ9DcyM34TbIC7k4ueXX767dcrD0g/MtvZHjpKXIYPuqu7fHmXv9zw9bywUQmaM7RhAZjIZkkQhJZnWNUj7nL9FFLNl5hThNCN6X3ZN+T3hvX4gYH/9BdsdnS/ZfRm3N8w4WbUYEuoDKS+YdkaTe46wmmX9AOw+WC7vAFrCuhTIgy1CJpXcEqNQ65td//pSwcVquxo0b7mt8ARoZpcrfDnKF+ghRh5JxwdIvyXue74yI4qrCb7J5twWfJFkAFUlUCMx/TyAqOk6Mg0lZ/YCStu40GtctsW9Galh0jwJMy1WpZDgwckJHxyo7ifMu0oqll9aJKALhBPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MAsg0JBJVMN93sgwyKk6i3VPuEQJtm0kUtvf89VSjo=;
 b=AR3ZxnXkf2dBupK7W9y+qRU8F6/G+8mQxj41ZRKiGo+LMLhqm+MBcsw8RStCnhG3s5HBMQ+NSjWqaFRdUiXmLT2EVnSdRz2qQXSknd3jxS5SBmSX86u9RxQfYrWBHlaCiam6QdJ2qrxTj7jyC2xOO/jMDo0o3BYa3E8NBTxLpyeyL1R2wZfMg81Fslf0ul/M12oTGIfk0HFJNqdj7v515W7Mv8THP/LungrZOYN09rpUzJDduxJeyVNws2Sai7g/3N41biN136wZRKKUT1uIRqW+FXjiHX6fS9yNCkBIUW7Ca4H93roDNQSYWE9HXGDP2Wlw4srHTdUKMQbY/JM7Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MAsg0JBJVMN93sgwyKk6i3VPuEQJtm0kUtvf89VSjo=;
 b=RyznUvWwO9/qMAoLB0+4qtuOzPJyhXS+EZJA9X/C+Kq4t6pd+TfEnyAiDefyoAkbwsK6tHRhSr81/KO2lWLKorLU3E5cvioPWq39Ue9Z+B+MoSCJIjKTHHWMGK+br39K+fVsOOLG/GvufU1jcgm/iNGxdGgKYPRgR/ft8FHf4bQ=
Received: from DM6PR01CA0004.prod.exchangelabs.com (2603:10b6:5:296::9) by
 SJ2PR12MB8925.namprd12.prod.outlook.com (2603:10b6:a03:542::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.21; Tue, 17 Dec 2024 03:59:31 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::d1) by DM6PR01CA0004.outlook.office365.com
 (2603:10b6:5:296::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Tue,
 17 Dec 2024 03:59:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Tue, 17 Dec 2024 03:59:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 21:59:27 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 16 Dec 2024 21:59:24 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <jens.wiklander@linaro.org>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>, <jerome.forissier@linaro.org>,
 <mkorpershoek@baylibre.com>, <akashi.tkhro@gmail.com>,
 <francis.laniel@amarulasolutions.com>, <ddrokosov@salutedevices.com>,
 <git@amd.com>
Subject: [PATCH v4 1/2] cmd: Add support for optee commands
Date: Tue, 17 Dec 2024 09:29:13 +0530
Message-ID: <20241217035914.1297469-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217035914.1297469-1-venkatesh.abbarapu@amd.com>
References: <20241217035914.1297469-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|SJ2PR12MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: f99cbcca-4c65-4210-e07f-08dd1e4f35d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ikOpS6HdQPq7m3guXmjQ7vaO7GGCCcZfwJO58ApMRHktwEiAuJcVRi88491X?=
 =?us-ascii?Q?1BDqMsahpRTX7VVFvamalrc8AjVwo32TQDYE5dG6xI76b/Ub7HASmnw5Dg08?=
 =?us-ascii?Q?0hRiQUmq+12RWOJfE3jaEI2OlygLVlfSzSO82zfA+ebFJUGMqiBC2hpDLMT3?=
 =?us-ascii?Q?QZ83/mG5nQ49Q+rQT1JjYSo/eRoGQ0HHyn5tyPsfZCjjGgCqe+NV7vWBFfdg?=
 =?us-ascii?Q?jMl0y5LhbDQEPXI+S4SbJWSecjYCg/q2vynFM7ATRTT1vHVeQpxaEjDszC1w?=
 =?us-ascii?Q?y8gBalmjgquPInZ5nB/YOcVO/yh2xf4VapXud4yyYz3kFl3T7MSBCBgNa1Zf?=
 =?us-ascii?Q?KKG2LiyXGeexKiS0DHgsiP0hGix9ISolbq/s2MXxOA+uyEiawi1l6AQ719YZ?=
 =?us-ascii?Q?3JtCmlpQfr/E5P/0jdStlO1VZVTi84qPmUKSRPmeGlNl8aqLNtYLOvGuy5Ot?=
 =?us-ascii?Q?qzBsypbMK2sttWtpwdxDl4VruO/Ml+BnkTp78jKxT++ulLABuPHbtTg890q+?=
 =?us-ascii?Q?pYh8UXrvEynnGdNGRf3HrJhkHg0emi9CLte/Reekiv10JhooMTdpPKj2vrMt?=
 =?us-ascii?Q?jhSWi+/iZbepDIKJZ/3BbplGqsqA4bv7N3zboirZcCmxkBIM6B+XK17ksUUk?=
 =?us-ascii?Q?GAF+AlQ617yjjQ0+8MdWr7oNItJKD/fIIOxufLYgNDT6PDiCb4fHVyD0RHcB?=
 =?us-ascii?Q?cEiA9XSa2B3zpgXUXyoowefslzHS9H3upucwxcV6ndPtNd5MWOHtqg+RQQFT?=
 =?us-ascii?Q?iumjOIItbnFm49hi2lDGIR8qiECLcD1l6QV12ETDuhvB9Bt9jvS2zdDEUZDA?=
 =?us-ascii?Q?uPhyPEBssWIkp0SQGt0mJHLONkpuiZTyBHft4oSr6QmLDqHNNct7b6t6ZvaF?=
 =?us-ascii?Q?xpqD73K6f/7HwoRNs69fOu9klByUP+ToPxAApsHKpolbCg/ITbm2KZKRcNGC?=
 =?us-ascii?Q?+AP3KZZ40o8FxijAlmJ03WHTXEgB3ecz8Y3V4Yars3l4b6+LD6Gnk1cvdzAs?=
 =?us-ascii?Q?vVYOFXv6Zg5kuIa6VZV8/n5+zlaQDEGOJdmjd+E+fN3YfaDeZ7yVnWZY6iJK?=
 =?us-ascii?Q?nQ8KE0r1A/IIe6Vt/q2mqPMQ4h6brhZYXVn123EaCObRrPULkqlz+2p+ywFb?=
 =?us-ascii?Q?cp+qVEEK5XHBbOVNpSwhDuN0plJRfrfG+QTIjjvwh8nQyfKaNthUXix1CNnw?=
 =?us-ascii?Q?DhPg6jHDllXzAqRJzRYRfYH8bl9ym9UdI8fux+pIBAOfCoiHGcYZDMeD1dgr?=
 =?us-ascii?Q?TgkXxtL6/im5DTd3HZy+lqh/SB6C3wDnuU6LDoZBd/ns5FqOVeRswN3te394?=
 =?us-ascii?Q?OFn1zVYcz9peXe76EuMjGWGkbnYzI2yrwlaURW1+eA8TPka05teICpxEPxHg?=
 =?us-ascii?Q?e7bTXUJpv6e3HJn1O4gl/HByPu8XkdsOTieuffZ7P5Xg4R2rNWj8jhiW5FJ8?=
 =?us-ascii?Q?LSmagwdSmZw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 03:59:30.9581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f99cbcca-4c65-4210-e07f-08dd1e4f35d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8925
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
---
 cmd/Kconfig  |  6 ++++
 cmd/Makefile |  1 +
 cmd/optee.c  | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)
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
index 00000000000..39947c00145
--- /dev/null
+++ b/cmd/optee.c
@@ -0,0 +1,77 @@
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
+	printf("The Hello World TA is going to be called\n");
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
+	tee_invoke_func(tee, &arg, 1, param);
+
+	printf("value: 0x%x TA value: 0x%x\n", value, (int)param[0].u.value.a);
+
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
+		"- commands can be verified on OP-TEE\n\n"
+		"optee hello\n"
+		"optee hello <value>\n"
+		"\n"
+		"With:\n"
+		"\t<value>: integer value\n"
+		);
+
+U_BOOT_CMD_WITH_SUBCMDS(optee, "OP-TEE commands", optee_help_text,
+			U_BOOT_SUBCMD_MKENT(hello, 2, 1, do_optee_hello_world_ta));
-- 
2.34.1

