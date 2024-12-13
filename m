Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D82E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 07:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 985AD800D0;
	Fri, 13 Dec 2024 08:02:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QHNHNBgV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 812A38018E; Fri, 13 Dec 2024 08:02:09 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D167800C8
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 08:02:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zwt4ZAAMK52zUHngY6ztVB+KKAzRq/7gSoE9DSQuLZ3YNvz0Y8aXfvxbA+EiU+opYFKUcHvRi1wLAiYk5upOSbMbHH7OW/7RGKySJnH+tufbfWUIXPBTsfFKQ9dkJtGmx6OsJpxnVUxAVOrXs4Rds6kUnmi3g+tfXvhyq0iEA9d9Gv2oQtUZHgq6JN9ttMMsRZMtQo/HBh1UJYO6Nygtd4pT1nrgY3RLQ/Pb/Xtxb8CIUXk+AK84eTh7wYZoy5ewFRCwNY8LDW8+RhGb7cB31opqtNFA1rxhuCIgj9iZg4NA2jaRjlgcFJlWJ3QVCvj47cNz22o41hN/GjQQaz2slw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLhZ5ArfQYvXzKR8tr450b2EJd1abdPAVk1mqsqvjcs=;
 b=sV3N75kho1IxruxWY+rfKctWwoxJ2ijNcfNr9FIKnB88ZJD/+YCPhqmq9o/R/0+eRVD/fedId/TQGd1hXqcoOMosFp5sMs/NsQoVleLUbxl+L62ej59wZ3wY7q5H2fR2o4YBHlGEnP00/lFT6lcQxhxUQRdvVS4NTxZoJsZVgdAnR1TDeKz8vYsHlqY/q8Ss/vla4geOJHNx/bRwpsFXDY767mHcDWwQI1w2cXEJByDn/6y/LQ6EVU5wopwh8XwILbrzCuCMSx6DmhjF2vmGeGSZwU1g7ZmQcspv2U1F93kGgQ9oUojjFNVTNbFdbhaRUWQbKZDdxGrzXw0NCF1x5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLhZ5ArfQYvXzKR8tr450b2EJd1abdPAVk1mqsqvjcs=;
 b=QHNHNBgVSTdqCUY6APEHXAYcix132P0rK7bH9eKUl6zZ1F6geEahOKCUme2rTZhM3uhcam+x065VS2V2nhNqrfAOpnb+HYoDgRYyYmLCf550yTm7F8mPeKn8qyqcalNaRNcpLgRUS/PWEsknt1Gd+fynFjJp9gMA6v6qd/SUa6g=
Received: from CH2PR17CA0010.namprd17.prod.outlook.com (2603:10b6:610:53::20)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 07:02:02 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::fa) by CH2PR17CA0010.outlook.office365.com
 (2603:10b6:610:53::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Fri,
 13 Dec 2024 07:02:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 07:02:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 01:01:59 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Dec 2024 01:01:56 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <jens.wiklander@linaro.org>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>, <jerome.forissier@linaro.org>,
 <mkorpershoek@baylibre.com>, <akashi.tkhro@gmail.com>,
 <francis.laniel@amarulasolutions.com>, <ddrokosov@salutedevices.com>,
 <git@amd.com>
Subject: [PATCH] cmd: Add support for optee hello world ta command
Date: Fri, 13 Dec 2024 12:31:49 +0530
Message-ID: <20241213070149.1089009-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 896cb928-92cd-410a-5035-08dd1b440b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|7416014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LY4zamd7c4jqBQbU2+aqVUgLX0BCPSEROxXkHAuZ+AUNM8mXpS4DELJqgKIm?=
 =?us-ascii?Q?q5Loz8Q+4PVoVcFrYot4i/YfOXj2wYUL4FaKrq+UJs6oKi5xjiADL2XyLXoM?=
 =?us-ascii?Q?LNH7fFNweLCTa9a77IlY+NgaGlMVQs7hdjUntffyNY/hORyN4axJn0drIP8W?=
 =?us-ascii?Q?qasba0YTD6YrEyxjxMveb4Esf2JUZneossolkdCYzrSoN9yT9PnmreIbBaYa?=
 =?us-ascii?Q?/cnf43vSrsIn/KXdE90AvwxNXx4mWBNydfwdPelKfMK0SDsMHZ0VDY8lqC6b?=
 =?us-ascii?Q?yxko6rJfrV9KIUK9ohOr3qKrAMA1ksGhP/pLtp8fZo6c9bHHDZ5ZYRNUsSL1?=
 =?us-ascii?Q?pL+cHBhRkZ0XbA/5bquBeOJBSV1GetRlRfrR4HqsFnR8NERh+bFff6vagwGF?=
 =?us-ascii?Q?14wmMOYzzZXfV5gEwGkCJLP8o9MlTl7p0ymT9fr+6B6pMfK2VS9dqXLmh4N2?=
 =?us-ascii?Q?3ItUm5OB63oq5v25tOthDHfDqQGhKg3TaovYhoHbbO7HnjJSd1/UhbN7V0EC?=
 =?us-ascii?Q?yOt+2/s3fE/q8t/lVWh+DzWMqtuLCBNe7X3G0QhAmmGynjdjT2N7HzXKSzHg?=
 =?us-ascii?Q?Rn+A70emTkH/ZbMGqr8a/A43/AyTDPya3lB7VtGf+Ztc2DYARRBEDc9zBNfW?=
 =?us-ascii?Q?A0X7K2OUU0dGJp52m24iJsw8kR2sooGYLa8OCaVAP4/CCI4h8NzCT5hmhhXa?=
 =?us-ascii?Q?kdpHCTYlYBgqOwKuh/TZX1kOOOrxGsmAgdgnHHmJ6OAjZWSkkhTk3oSdFEcm?=
 =?us-ascii?Q?AqVsmUDhcrWrls3gf/OOZvn8AnZ5nk2YwicNId+L5OUXal+7JZDmnDFTK5l/?=
 =?us-ascii?Q?9s9ZbfJu3FbHPflVPFLxTKickzi+re0UoMTQfR9+CG8db1SVMkjYqk4Knfi2?=
 =?us-ascii?Q?Vr6tDBkyR9KF5oeTryKNpvVTIr6W9O56DPGl4F8IPGRMmOXwKZZ8BvmVRlBm?=
 =?us-ascii?Q?+zUt0v+NFsYVQriMCUWKhcPCpuYc2ei4kvmp4kNa5h8Ua1z3lDEn0XDjQ6uc?=
 =?us-ascii?Q?h4F6Nk9yDJDIrURHyIhhKvLAglII/BoImACHKYzBGEkjhkpgZMdWk3KItovF?=
 =?us-ascii?Q?QyYWLIVwdUDWrwDKTbVFOVPl/fr8tbPawCyTEbXOVzolZJeEET+cQ92PPIYe?=
 =?us-ascii?Q?SsLXf8qfPnjroZxivqE2tdM7Ywrn2qMjf5jmPDzrggTnjr0Cnaotk+6du/dA?=
 =?us-ascii?Q?WQPhrQ0ebN66fMOH6TjiiNk7xEvUnjTmerFZZ1igK1x6W2zD5cfKqQqls6NG?=
 =?us-ascii?Q?XPfqKfmvULmWkdj1LeiDvCeiU4Ha0rHOEEm9yVZNjsVc9RXeKSkH4kqFC0rk?=
 =?us-ascii?Q?8n6rDnW8QC9TNJWaIdU7FNB590qdufbGbFkZ/ULnKXrSez1adsWQpoRkSjbK?=
 =?us-ascii?Q?GyZgBfbxegSFffSglqEYOf2SUW2Jfv88ycyXYVTwD0RucfvgAQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 07:02:02.0291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 896cb928-92cd-410a-5035-08dd1b440b81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141
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

Enable "hello_world_ta" command which increments the value passed.
This provides easy test for establishing a session with OPTEE
TA and verify.

It includes following subcommands:
hello_world_ta write_value value: value to increment via OPTEE HELLO
WORLD TA.

To enable the OPTEE side HELLO WORLD example please refer
https://optee.readthedocs.io/en/latest/building/gits/optee_examples/optee_examples.html

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 cmd/Kconfig                |  8 ++++
 cmd/Makefile               |  1 +
 cmd/optee_hello_world_ta.c | 98 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)
 create mode 100644 cmd/optee_hello_world_ta.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 1d7ddb4ed36..f1f8d1b9571 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1446,6 +1446,14 @@ config CMD_OPTEE_RPMB
 	  in the Replay Protection Memory Block partition in eMMC by
 	  using Persistent Objects in OPTEE
 
+config CMD_OPTEE_HELLO_WORLD
+	bool "Enable Hello world TA"
+	depends on OPTEE
+	default y
+	help
+	 Enable the hello world ta command to test the OPTEE by passing
+	 a "value" which should increment by OPTEE TA example.
+
 config CMD_MTD
 	bool "mtd"
 	depends on MTD
diff --git a/cmd/Makefile b/cmd/Makefile
index d1f369deec0..049147a1442 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -118,6 +118,7 @@ obj-$(CONFIG_CMD_PAUSE) += pause.o
 obj-$(CONFIG_CMD_SLEEP) += sleep.o
 obj-$(CONFIG_CMD_MMC) += mmc.o
 obj-$(CONFIG_CMD_OPTEE_RPMB) += optee_rpmb.o
+obj-$(CONFIG_CMD_OPTEE_HELLO_WORLD) += optee_hello_world_ta.o
 obj-$(CONFIG_CMD_MP) += mp.o
 obj-$(CONFIG_CMD_MTD) += mtd.o
 obj-$(CONFIG_CMD_MTDPARTS) += mtdparts.o
diff --git a/cmd/optee_hello_world_ta.c b/cmd/optee_hello_world_ta.c
new file mode 100644
index 00000000000..54342b90812
--- /dev/null
+++ b/cmd/optee_hello_world_ta.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) Copyright 2024, Advanced Micro Devices, Inc.
+ */
+#include <command.h>
+#include <errno.h>
+#include <tee.h>
+#include <vsprintf.h>
+
+static struct udevice *tee;
+static u32 session;
+
+#define TA_HELLO_WORLD_CMD_INC_VALUE 0
+/* This needs to match the UUID of the Hello World TA. */
+#define TA_HELLO_WORLD_UUID \
+	{ 0x8aaaf200, 0x2450, 0x11e4, \
+	{ 0xab, 0xe2, 0x00, 0x02, 0xa5, 0xd5, 0xc5, 0x1b} }
+
+static int hello_world_ta_open_session(void)
+{
+	const struct tee_optee_ta_uuid uuid = TA_HELLO_WORLD_UUID;
+	struct tee_open_session_arg arg;
+	int rc;
+
+	tee = tee_find_device(tee, NULL, NULL, NULL);
+	if (!tee)
+		return -ENODEV;
+
+	memset(&arg, 0, sizeof(arg));
+	tee_optee_ta_uuid_to_octets(arg.uuid, &uuid);
+	rc = tee_open_session(tee, &arg, 0, NULL);
+	if (!rc)
+		session = arg.session;
+
+	return 0;
+}
+
+static int hello_world_ta(unsigned int value)
+{
+	struct tee_param param[2];
+	struct tee_invoke_arg arg;
+	int status = -EACCES;
+
+	printf("The Hello World TA is going to be called\n");
+
+	status = hello_world_ta_open_session();
+	if (status) {
+		printf("HellWorldTA: OpenSession FAILED!\n");
+		return status;
+	}
+
+	arg.func = TA_HELLO_WORLD_CMD_INC_VALUE;
+	arg.session = session;
+
+	param[0].attr = TEE_PARAM_ATTR_TYPE_VALUE_INOUT;
+	param[0].u.value.a = value;
+
+	printf("TA value: %d\n", (int)param[0].u.value.a);
+
+	tee_invoke_func(tee, &arg, 1, param);
+
+	printf("TA value: %d\n", (int)param[0].u.value.a);
+
+	tee_invoke_func(tee, &arg, 1, param);
+
+	printf("TA value: %d\n", (int)param[0].u.value.a);
+
+	status = tee_close_session(tee, session);
+
+	return status;
+}
+
+static int do_optee_hello_world_ta(struct cmd_tbl *cmdtp, int flag, int argc,
+				   char * const argv[])
+{
+	int ret;
+	int value;
+
+	if (argc != cmdtp->maxargs) {
+		debug("hello_world_ta: incorrect parameters passed\n");
+		return CMD_RET_USAGE;
+	}
+
+	value = dectoul(argv[1], NULL);
+	ret = hello_world_ta(value);
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
+
+U_BOOT_LONGHELP(optee_hello_world_ta,
+		"write_value value - Write value to increment\n"
+		"Command for testing Hello World OPTEE TA\n"
+		"pass the 'value' which needs to increment from OPTEE world\n");
+
+U_BOOT_CMD_WITH_SUBCMDS(hello_world_ta, "OPTEE hello world TA", optee_hello_world_ta_help_text,
+			U_BOOT_SUBCMD_MKENT(write_value, 2, 1, do_optee_hello_world_ta));
-- 
2.34.1

