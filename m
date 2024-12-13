Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61717E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 11:01:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10DCF80219;
	Fri, 13 Dec 2024 12:01:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d1SDCCVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B69C80274; Fri, 13 Dec 2024 12:01:01 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CB6F8010E
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 12:00:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQnfCOl6UQRStpoQRGK7iP/1Dj5bBYuTHk2azZ0rwjUWfLKNkPK6ErPxYM0a39yxD+CAhP7BnT4QZfVOIILrdYw4jkWOXvb0iuuevUgGFDmTwSb4i6/pP1C5oZSpcjBMB82NlZkKEvasD1X+/5vUOZfduyaBXyqxM4mnb1A3spmZIZrmOe1JjhBDfQUV09FHnecf4zeTRyyXvopYxFgs82we8dEojanuVqp23mOQfYhp7jyGGGVrVh8f3g3sylkPJf4F2+wWQhFzCJoa7i6vZ59khlxo0/fDQ+l9FK98vE88VTc1TYiqPcgcyMAx0SbeRrVxzOHUAR2JafDZrSUTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKINwcQzWq2QDq6mLClC0BhiMsmlh7nQxiAegk3hwwQ=;
 b=Y+oMSrja2MLLxcb1CNQ29KbRMGmLFycYwmYKpYkB1gWR45r8vAAs6nCHev+XijFfYRxPdLbr50p1iAthTPx+YGl5hU3UVxZ64Vum+/eod7UDsCxqAoiHWmEJD1kEELw6chzXJMmHP8e2sDy58rQ+J2vReegME5ESm6WOLyeg5RdWkJrpvjFIRcenlJkW8ynz+EXdX++zMxNFiqrlcIVW/Yzg5tvuFRE93yTc+vawvA/zkwwI6R7Ntt2TzAtnAQ7y1g/EwfpFrNE/MMx5SMVKxUJ6hsmaF3/JobI4FwbmuaEq9eD0TXyPDKqAMQUPEnWF2+c1LEuQ6B6+HEbu/ip7eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKINwcQzWq2QDq6mLClC0BhiMsmlh7nQxiAegk3hwwQ=;
 b=d1SDCCVh6jPVi5U/L2oijpZjoz4VUP4oH0qKf/5WQ4syfp6RHspfpEj4GGN8zsYISbqAQyf6gqe3qs2RX6xkcm267j4R3CVHLBL8v4vckPmM6SHJ0Dzj19Sb8Ul+4CEGrMXBimkEPl0v7CotHQ3c3C+XdsDTIv8j0Hm+5iRMIA8=
Received: from BYAPR03CA0033.namprd03.prod.outlook.com (2603:10b6:a02:a8::46)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 13 Dec
 2024 11:00:53 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:a02:a8:cafe::80) by BYAPR03CA0033.outlook.office365.com
 (2603:10b6:a02:a8::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.17 via Frontend Transport; Fri,
 13 Dec 2024 11:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 11:00:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 05:00:48 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Dec 2024 05:00:44 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <jens.wiklander@linaro.org>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>, <jerome.forissier@linaro.org>,
 <mkorpershoek@baylibre.com>, <akashi.tkhro@gmail.com>,
 <francis.laniel@amarulasolutions.com>, <ddrokosov@salutedevices.com>,
 <git@amd.com>
Subject: [PATCH v2 1/2] cmd: Add support for optee hello world ta command
Date: Fri, 13 Dec 2024 16:30:33 +0530
Message-ID: <20241213110034.1113036-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213110034.1113036-1-venkatesh.abbarapu@amd.com>
References: <20241213110034.1113036-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b128249-b0a9-4b01-5e14-08dd1b65693a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5kkD8jlgZUqmzZtMUK4kTatQZzjR9wbDVKu0j4WxsfcXRlq5ItNzuxwtUSL4?=
 =?us-ascii?Q?nDGBAM/UrbAYLzuN+94BFDayfWkZtrhHyX2VKOFfefhRG/YSnm5mWiEnT1SF?=
 =?us-ascii?Q?Xkh9yX81bREdouMAUSl8oPgaQkMMNf6/EYlMXk+LNUqVjRHCW8jY+QdcDtSd?=
 =?us-ascii?Q?KOwy25dM7T0pVUEoWOUzmS4To0WCjcw8RiIngGQl2ZJUZBj2EP0NJiU6tUEn?=
 =?us-ascii?Q?TCPlPSlbuNeGIl48rP7U5liJbEgfLhMvNCeMazY20PdHx6EpnLPYapdE//Vb?=
 =?us-ascii?Q?NAmqPgTDpkfbVAi38OBOwz3cmHvNws+IxkeiiHiUaWRc//2aHgbh2Ug72B9D?=
 =?us-ascii?Q?5M3/gpoQzlkc+v9zsVlAnQ2/3bFf7kzLLfMGgyRR9HgUZ9yYFJk2clO17WSF?=
 =?us-ascii?Q?tcHM8f0Zo8INzOVSkMDTKSzNUuPmbIQr36/czdV3NzdGJvqJ39SIDXPzzzlL?=
 =?us-ascii?Q?juTSK+vF3vys9RohpmdxXsaYBLdiRiwrNtgMyxQSXqO88v5mEHC1h+1u46Zd?=
 =?us-ascii?Q?5MAod2z+hHSJVQvNTbBtHkqwcJXN9JFsUOvBRx2Kp8wPFZQVzI9a9Gm+GmAp?=
 =?us-ascii?Q?yeT7xpGEZYiTW/qgdYGCT7VXwRxkkEkIt+c/jcks5VwLEz2SWeFEES3t9Xwm?=
 =?us-ascii?Q?v1cMC3W1T8ziKSMXs4HqSAVcZph/BmMGEpbP3BKott5cEruRvyJG/d10GqYm?=
 =?us-ascii?Q?62erckB61Izzur3XUxlYAJD0PYKN9LqsBWmNRanKIYxNiKRwW4ZW5U2EhDWn?=
 =?us-ascii?Q?cJYmB67to4h7djF6O+tPvp1F9mRUl3bdFZmjvjKX2p3RSqGntXVPivAZrCwo?=
 =?us-ascii?Q?gLdRcLaOptAk4ckDlWlb536CFMxD/j7/GQHMXV+6X8Ae9dQVV0alVqxc3ooV?=
 =?us-ascii?Q?vL76fqteTBesg6sBzAoFHzD5wfTThk2VTTJObD3iK4+Avum460wqtEv4Lhva?=
 =?us-ascii?Q?CEfQ3uQpiHxd2Xs+7eJgr3j+4vHBQd18brddNGiiirn5J/R4LkvWW8h/Wm3d?=
 =?us-ascii?Q?W9Uxf8AlsAS08GakVxS8tuaqN3YTBN4C2dXo5uR//Qki7DJTEkFOFxNmYsnh?=
 =?us-ascii?Q?j+/+1rhOZrEZgOLLtN+xJNNv4xTo7NVgaZ7eJtNyKt6vPO2dZUAFgpR30Z3H?=
 =?us-ascii?Q?7D6BxDvqk4npDW5AbBsy+t3qQK0WR9Hd/5zK8Y7mbSMVBI1dZzN4G69rnsCI?=
 =?us-ascii?Q?gFu5Ripsu3JaWt26vX3bx/rux3iNAJkepFMRbrJo4XM8p8GUNpmbzrsoN4xl?=
 =?us-ascii?Q?IzxI5NGXfPwdreOe7GsVBNG1mJcgr5cUYcS6S2AjYHKu/Yx1D8HLefngGcT8?=
 =?us-ascii?Q?DME277Rbq3AMVCVFyKUv0xipsWVr7fnus0NRx514defOT/DZS9wB09xz3kkQ?=
 =?us-ascii?Q?zN8c5JVUXMYwICxVPNwoXbbvErdah+f3DwAFl0LKheXKrhRMog=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 11:00:52.5995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b128249-b0a9-4b01-5e14-08dd1b65693a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
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

Enable "optee hello" command which increments the value passed.
This provides easy test for establishing a session with OP-TEE
TA and verify.

It includes following subcommands:
optee hello
optee hello <value>; value to increment via OP-TEE HELLO
WORLD TA.

To enable the OP-TEE side HELLO WORLD example please refer
https://optee.readthedocs.io/en/latest/building/gits/optee_examples/optee_examples.html

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 cmd/Kconfig                |   8 +++
 cmd/Makefile               |   1 +
 cmd/optee_hello_world_ta.c | 104 +++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)
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
index 00000000000..7c398bcad2c
--- /dev/null
+++ b/cmd/optee_hello_world_ta.c
@@ -0,0 +1,104 @@
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
+	int value = 0;
+
+	if (argc != cmdtp->maxargs && argv[1] != NULL) {
+		debug("do_optee_hello_world_ta: incorrect parameters passed\n");
+		return CMD_RET_USAGE;
+	}
+
+	if (argv[1] != NULL)
+		value = dectoul(argv[1], NULL);
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

