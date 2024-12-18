Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD880E77183
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 04:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24F7680283;
	Wed, 18 Dec 2024 05:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UDSvG/NB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E6568021A; Wed, 18 Dec 2024 05:20:06 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF88E80243
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 05:19:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWDZ2KsI4kOqfjZkLKA4oFa21IjS2qBvkqU/UY9d/+9lXIrG4zMZNeBt7SsP+JTa+3sT9NAB0yUQXAWlWxQWHmak/gs6SqOJaxxzi8fbVhvtmqk6Z/hKaHyxshl9c6G48bMXocwnKzVvtZ3zlYGIx4lHwGEjrAg9XfdstnPH6aTURzIuhaEtMScDavqRu4fjzbmOB8A51bY+rWhy1MgfpdNn5VoOd3GnntYEzfX+6EcDziyPAqiDW7HY8NTydteIaNudqDt58VNgoDSEdErMHwjg3Elgw6rmUYPwczCg4E2djnavo3pUwZ7alSVFLyWLwCzO3VeNDUWaxvsFSYOnqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0SpQlBERkRNImzrw02pl/OZazt+g146xfYFyZRuQZI=;
 b=J4hK2Afcz6oxSpei8htdHkPQy0jP8DLC3K5w/cVCQW85i+i1qQrsV+c7iM2XzE+m3bUzQcSxSGkhHQT+czJid4FwPgcmn7M35jP9THpCAeYq0Vhw56p8pYeZniGGTH68GkYNzNFywy6aKz79D8zhIdxdV5kJgdwnnVnkuLnGgfXuSEjb9DXGP/cZdityZYWBD3LtIq1dSaY7AOyumVyC2BuI2c3Hh4iv3b7u82+OHITqWuh09/8Rrihxexp3qELVprfovYhIZ0/Nxpko/HeH7nhONZ+V9aApyqp3e5gbkvMCazxgAMifMxZyJKYrr0dOQ/R+/aXvicl1G8gfT8PgVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0SpQlBERkRNImzrw02pl/OZazt+g146xfYFyZRuQZI=;
 b=UDSvG/NB4mnUl6Flt3W70btfc/Ngl5O3aeObDFX5r/se1AMXN3rz7cFOyXjhInxlS2NRjIR6g6+GjnagAhSaOnPeTSBaOgZ/HN7L2ISUUS2MN0P77cmQ4bwDDI0lh954FTJcmdaLfpF1a+Qu5XX2V8l3AR20xP89oe2JzvkcNc0=
Received: from CH2PR07CA0020.namprd07.prod.outlook.com (2603:10b6:610:20::33)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.12; Wed, 18 Dec 2024 04:19:52 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:20:cafe::3b) by CH2PR07CA0020.outlook.office365.com
 (2603:10b6:610:20::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 04:19:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 04:19:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Dec
 2024 22:19:48 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 17 Dec 2024 22:19:45 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <jens.wiklander@linaro.org>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>, <jerome.forissier@linaro.org>,
 <mkorpershoek@baylibre.com>, <akashi.tkhro@gmail.com>,
 <francis.laniel@amarulasolutions.com>, <ddrokosov@salutedevices.com>,
 <git@amd.com>
Subject: [PATCH v5 1/2] cmd: Add support for optee commands
Date: Wed, 18 Dec 2024 09:49:13 +0530
Message-ID: <20241218041914.1463666-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218041914.1463666-1-venkatesh.abbarapu@amd.com>
References: <20241218041914.1463666-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: 302916a7-1e46-45ff-d238-08dd1f1b3821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|7416014|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lU4325FG7cyjxPHTvpkv4gu98B7lGE9plwYeLofGE/DVOe9fa5b1Uk3qWzcE?=
 =?us-ascii?Q?PJiHr6g91TBYuscfmsMqmDHVAbz3KkvdRaqfowp8qw5IR6vybZeqHgsCwSK5?=
 =?us-ascii?Q?SQ8JcUV3JFnwOutEEXvZ2sXxI252wpbCgeUzbdkJdUG463WYkyffajlFUH0+?=
 =?us-ascii?Q?AH8u1Dyd/5X0L+AWBPa2n8yRWTC+zvpQF48hU8GLpqlxR1olUAwK1gLyu8wQ?=
 =?us-ascii?Q?y96gDULsEMJdRowOU3+o82+5NPR9Ovxj6rWGL4izGB3z0xFM0GkxdHVrSMhd?=
 =?us-ascii?Q?83iV1nmf3y5AdPdJfHyjuFz+taeoQFxe65KXlximuePIySCmwU6McTuxvpdJ?=
 =?us-ascii?Q?DFoqNXIM+Hm1gsZqTvov9pZygvuTScFgJ2AoKXlIl8VZfadlWihJVmPSsf7i?=
 =?us-ascii?Q?gguORLdwEz4I5d1OYMRScYYZtabFaW4x3BD4ohPwlGUCW5Cm0z+vrCpuRqfy?=
 =?us-ascii?Q?NZTOkYJLquRIwGjuTWX1i8qqf7H/pcltXMRiXkuMbel4jpV8+dcSOyl3xsCo?=
 =?us-ascii?Q?JbEB5ZPDrVr9RWX3ZIuPT/CI+Y7UQu332MlmkdYOugnFa6th8O22ikmBF/sE?=
 =?us-ascii?Q?Fi2LkPhpv07qTbSINwhxBYSt0WsJqU4MHDWv/++MeYlgC0q5GyYUl7F8ThqX?=
 =?us-ascii?Q?Kmvlrfy3DpbmVWFpFTpMmlZkO8wbAnPBop5q/mI8KiY12M+SHveifQ94DFef?=
 =?us-ascii?Q?4OwraAgkG8D9N26q9+sllUZXWi+sm0nHW0H9BwbW2wgDw1BiIONXuUM0q9Xd?=
 =?us-ascii?Q?dokV2oX21MX0y1iT+HhXbZPm0puNWauGoWY45ROaCgr54ibr7RUz7qlYxKk7?=
 =?us-ascii?Q?O/jZx34fiXYYIDzvGm/spAm2aFQlsCjcCiM7xZMQ6n3fpHT03rQOseI3QAKe?=
 =?us-ascii?Q?bT15EXC1FzROCYg0WmT3Z1aBmxlayMyCWcmrQmbM0F0b9mZonkNXvYWgWVaM?=
 =?us-ascii?Q?oN9O+XLkYOcN2WvQ/AAqt6G3PDZR01DdUXUDKPmiBdmn+OQp5XpHRDQOdqBA?=
 =?us-ascii?Q?y0xPvORFHx7MA30wQtpke/+uzflfN2H8KbrJFVxqAJePjWBZS0rNX8fbyn1w?=
 =?us-ascii?Q?+Yk3VV70oEFgzo9lbhTSmUSEM/saPotLrSqZ9xyr8/KQ4hRdfdgzJ/BUYgWa?=
 =?us-ascii?Q?AURj4uxycltAkTaHwHEQLpzjkFU5CXYz6iUKtdgGtFmlOGBwcr/a6f2pW3lY?=
 =?us-ascii?Q?M7qC4+vywR7lsq8mSuQLHjAIdfrO1y1pz79C6A35JQxS4/R76j+FZs5nBdHK?=
 =?us-ascii?Q?IWI5U4SV7PekA4F+riV/qZFlB1wk4oW3LV1iS9mY5mYDTRfKwJGt5G0svYsZ?=
 =?us-ascii?Q?cTCGnF91kk2g8T0/eKwDPfWp2pHdiEUcZsXlnhOl1KaC896uSCmnbtv1B0u0?=
 =?us-ascii?Q?H9xy6QVNEfKryJYZ8TwEOq66Ie9QWyQKCybt1TNZGcIiDBev8qR7RFckao76?=
 =?us-ascii?Q?Y/3rjGtw4aY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 04:19:52.1859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 302916a7-1e46-45ff-d238-08dd1f1b3821
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256
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
 cmd/Kconfig  |  6 +++++
 cmd/Makefile |  1 +
 cmd/optee.c  | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)
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
index 00000000000..e8d5f4ceb36
--- /dev/null
+++ b/cmd/optee.c
@@ -0,0 +1,76 @@
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

