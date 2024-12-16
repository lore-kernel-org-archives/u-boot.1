Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6881E77180
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 09:30:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C88498022B;
	Mon, 16 Dec 2024 10:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AOsuo3Pn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5978801F9; Mon, 16 Dec 2024 10:30:21 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0507C801CF
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 10:30:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnfUXqHaD+iSMmDvW0+mLbmFR86Z+1XCcAf8hF+0trlG2pLevuqU1AWUUl950LzeuZhWeFAdl+rjdw0GKLjJHJYOhM26nfOtAgIFa+niA8y1UnL1ncxua03aBGf4nCuI273I+ekxltl7UmtCP92pZcB/eQ7gUVUNRsWFFw+SC1voIunxTd5ZCS6opVu6TTVUKaemBuyUhByP3sNmNLDEMevbJAHfBp6uBM1Z5+egRmjX00yfhgOQ865rb+DML87ycnJfydgEyWaIgMVBAZPgksdDk2yVOSs48PKJZwskOwaePbPWIXAZX+kcPVo9MoOp2z2sz+JEnuvM9QNjCfy85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuZ1nTeQ9U18ophlvTO+LEYJzlrDGJ9zu9x6JmlnKo8=;
 b=hwH7hEvjuNqaY8j+C7/X9gU0MHIPyxgAQ4ZVvXm5E+AqC11MQjPWbcLYc16jNc45ENsD+VexNtqQrYt/tsrtKFDnmkk/atJq/C2BE5sFdppn2xC0QMPHPjgDRTEiLX5Q/0LPJyoCERSoTfEO5UScYxMwhZZfMwH5nzDxMpGU9LrxLGGiDZrPxtvCGIhx1fY7Gu4+4rYo0XcXED7wZOdJv51pwSlwIj5Cn3w72I0vUOn1dme7mrPbcOA/8FPCZqYm2fS2b18Rz9yKjKtOBbpp1PFMbxjPihyBXIZCkKA41INNKL4dKbiyuugrMiLSft1IbnM3Hy6QvKwL/qPAtIpJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuZ1nTeQ9U18ophlvTO+LEYJzlrDGJ9zu9x6JmlnKo8=;
 b=AOsuo3PnWhpQKBTjok42BvGKCjRBghCgGi+JD3el8X47Z9DQTNa9wCd0r3WQKWl3LAGnHRCELADU2NShVYHyu5HFlZSy9LQoe/Px5J7yIXlRAoHiCw55nRj7ATbfr1+OI5iJUAgwfqZeV9slFsFKQqjt81AqbwxlGZm+z+2GrRQ=
Received: from MN2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:208:134::40)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 09:30:14 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:134:cafe::6d) by MN2PR16CA0027.outlook.office365.com
 (2603:10b6:208:134::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Mon,
 16 Dec 2024 09:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 09:30:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 03:30:13 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 03:30:11 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 16 Dec 2024 03:30:08 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <jens.wiklander@linaro.org>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>, <jerome.forissier@linaro.org>,
 <mkorpershoek@baylibre.com>, <akashi.tkhro@gmail.com>,
 <francis.laniel@amarulasolutions.com>, <ddrokosov@salutedevices.com>,
 <git@amd.com>
Subject: [PATCH v3 1/2] cmd: Add support for optee commands
Date: Mon, 16 Dec 2024 14:59:57 +0530
Message-ID: <20241216092958.1230455-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216092958.1230455-1-venkatesh.abbarapu@amd.com>
References: <20241216092958.1230455-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DM6PR12MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: 5137ccec-8515-4ae8-9640-08dd1db43e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GNHH/vuMEESj8jWTIgPLmVDeQ9yscNV8WyFMOPawildCdH/Y0fCkxYbBHkk8?=
 =?us-ascii?Q?33CTknPGzcz+806aN1QulvXF9WoCCCUEdd8DUOTZb71c6FqRNZ6E9mcu31iX?=
 =?us-ascii?Q?ea6hEKJ0TJ/Zn5VV3h760gqGGPVxHjFXCktffapW5EF+m3bBFa2I7ptcIAVc?=
 =?us-ascii?Q?rbLGWu5TkHS1xkhfBdYG/EFzeu94j0O2k4uXdq6DTxt0e3TEbUHq6/+3kl7u?=
 =?us-ascii?Q?VyRpqAuXwh0bhCZpwzxAbT3XvMQXC3NVrrLTKp1rOSxzTW+86IsGEHnnAFu8?=
 =?us-ascii?Q?CcxBg3XkUY/9hXUtjM2WiibbY/WhU6/iTEI0ehjbA0AMRgyqV8siB+/tSzf1?=
 =?us-ascii?Q?70QdRKzYoo8r69wUPF7nOiUGAI+uX8HuOpnf/cSnBI3OQQBCGYt34eJjzg5s?=
 =?us-ascii?Q?3VEsL+A1/22qAWt0b6G51S/h0UWg/NElEefqXh8uRY3F8nlh8Yv4xm/sHTCC?=
 =?us-ascii?Q?SO2WGcSoT2m5gTbB1e2ZHsyNUfNy5aLu4lmbDN/PUn5qOKslGwCwkfLcI4fH?=
 =?us-ascii?Q?RTzVVUxors8yhTaUGhkfAX5K/CatEufnIXpcyxCw0jvWadOedncvHsik7SkJ?=
 =?us-ascii?Q?15mgHNyR5/C6kHnrrdWaQpP1ZFBIc6kwpCQQDXrpWim4DU1YI9bmDNADbzBK?=
 =?us-ascii?Q?exFcDx67pzXOPJ4RMHiLmI1eP5xw+dfuHisQP/nLhnsnEd0bh2DLv9s2PhXj?=
 =?us-ascii?Q?+blTtK7mNB5EMC/DQTN1FAPR8ya7qND9MWkHl2/mzQYGVKPHXaUqsbYO4h+L?=
 =?us-ascii?Q?GbNXGrhykw8clnsR6/audy204pmYV08wzljTwQVLVs5wOf/zufqn7Gl2fRuW?=
 =?us-ascii?Q?NNIe/UVce4yj0BDg2YcgaGU3M1mupdrJHSCzLD1NrZYbAFFndwUkhxFbUy3y?=
 =?us-ascii?Q?t+nLld6A7jr0qFyiAS4qosA4aRknOe2ayVRmiwAiOffNS6FnIR0FQf2WSQA4?=
 =?us-ascii?Q?fRtb2UD6MlzJos25XwUi+mqtyZsaUppZV7ek7r7DvIZjkkNyg9jlmLiYzPJR?=
 =?us-ascii?Q?lB6Jxiv2YnKeSVR0ni83fJtSE1fUmkrUVpoN2/D6CzAtXbDSXlgLbM1KRnti?=
 =?us-ascii?Q?fNL1ltY87kIJdspVfKSmisX0chy4Z3nDbANu0uJN+Buw6bMeirsQ4VoYAajv?=
 =?us-ascii?Q?9VPkIEpVoYlinNiULD39vwQNC8cjBbcBSqg1OqIELfiFMa8XWOoD12aGSQnV?=
 =?us-ascii?Q?ulJdlqng5uzi1tnC884BVYhK2LoNRQXhmsXlY29ZI1aGmZw+9ImrsM4ZT41b?=
 =?us-ascii?Q?+av7EVLSKlFVNmoL8HnHuAJo69MpBO0l1yLR1cVtXelxQpeuAZSHe7sEyLh5?=
 =?us-ascii?Q?yCH5taRWnDt41tIxcCDhNfNcv54YqlF546tshVP8nTkovf/yRYcZFWWnpcKd?=
 =?us-ascii?Q?/iEz54Pz7JNziQ2CX1cOSB1L1jbDBKausekjLAXIC1YGopQBpzNnz2DDZIbz?=
 =?us-ascii?Q?KlmjA0qb5Lo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:30:13.7031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5137ccec-8515-4ae8-9640-08dd1db43e93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186
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
 cmd/optee.c  | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+)
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
index 00000000000..618a2f8490e
--- /dev/null
+++ b/cmd/optee.c
@@ -0,0 +1,93 @@
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
+	if (rc != 0)
+		session = arg.session;
+
+	return rc;
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
+		printf("hello_world_ta_open_session failed(%d)", status);
+		return status;
+	}
+
+	arg.func = TA_HELLO_WORLD_CMD_INC_VALUE;
+	arg.session = session;
+
+	param[0].attr = TEE_PARAM_ATTR_TYPE_VALUE_INOUT;
+	param[0].u.value.a = value;
+
+	printf("TA value: 0x%x\n", (int)param[0].u.value.a);
+
+	tee_invoke_func(tee, &arg, 1, param);
+
+	printf("TA value: 0x%x\n", (int)param[0].u.value.a);
+
+	return tee_close_session(tee, session);
+}
+
+static int do_optee_hello_world_ta(struct cmd_tbl *cmdtp, int flag, int argc,
+				   char * const argv[])
+{
+	int ret;
+	int value = 0;
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

