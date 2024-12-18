Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435F5E77183
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 04:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C55FB8021A;
	Wed, 18 Dec 2024 05:20:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IcW87gBV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D9B780196; Wed, 18 Dec 2024 05:20:06 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 697BA8021A
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 05:20:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUdfbVSH9Q5xMD/+gBBVypXgem2MsJe69meVvrCXy3kxZ52GH8EVgUTE4KTd7AnrW7DPyK7hwlpoF89qlYkkPKlYvVV8QL8NIMY+0Oz+X22ebQBlcmeKSLE5XcEsMsYwLJl99zFUOEr6nVbseqCK5lQ5eqzO6GPnOkQijdv9KZfoXL/88bzuTcdwoIAu4SwkP36iHQZpgyszhNpkQWT6JEQDa/Gujxmj4/GDcmV6L7zhYS3BcfgFl7HCKpiBQ4lTFZl/pR6rBlR+CSzUp+UjbqLv/XnIUH//jnapoGXMQgqHVAUZ1XvENUDRPGUGoyYQp7qzJhekZ+b4BGQ5fysXpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3gZ9u9fnuy/to1RuilEP+nZ0EoYmKZ5jlwilBmKIf0=;
 b=YTVwq68cgJUmsOf9wglaN93Mbs+n2i2ge0qMl2TC3T2tyUWZi8V2tJ4BwyZApKa6Jw/GP4WAtYf7SZkhqzOBZFSBLE1OF2M5myix4BUt3Wed5+DM5K3cnaQ6NbYkjdgg4yIAs6odF4HtgszV6cBewBVcXzBI+HJQya4uOvXbPr2xa9caGSQ/VZ7RevAde1/KmMFJsRypcTVmhMhdS5ZOY8uBH3TpvU2DPFXxkR329BS2GGT2aiXnDT9O+0NQUOSPBVYunOzrOxuv1+XEdx/YM2sqnatjbHFj1lnfD3upuHHewoEoKGQ7Hr+dfSsIeN6kQWM89houZcBE3e9pjP2irw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3gZ9u9fnuy/to1RuilEP+nZ0EoYmKZ5jlwilBmKIf0=;
 b=IcW87gBVVw9dQvZoeupZ0kc0696AQEvi8ZkuinaKztN4YEhN6eRKPMrfRb7zbmsVF+J0QF+YmVbrJQtKtp9sMC233n9b01o/RG0msZ2a5RgUo3DahU5ZZ2oVaaDxwszzICqRRBM0Nf1TKIZTcRHoq/sqDaErfuGVkswJEQ17K8M=
Received: from CH2PR05CA0043.namprd05.prod.outlook.com (2603:10b6:610:38::20)
 by PH7PR12MB6934.namprd12.prod.outlook.com (2603:10b6:510:1b8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 04:19:56 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::75) by CH2PR05CA0043.outlook.office365.com
 (2603:10b6:610:38::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.11 via Frontend Transport; Wed,
 18 Dec 2024 04:19:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 04:19:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Dec
 2024 22:19:53 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 17 Dec 2024 22:19:50 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <jens.wiklander@linaro.org>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>, <jerome.forissier@linaro.org>,
 <mkorpershoek@baylibre.com>, <akashi.tkhro@gmail.com>,
 <francis.laniel@amarulasolutions.com>, <ddrokosov@salutedevices.com>,
 <git@amd.com>
Subject: [PATCH v5 2/2] doc: man-page for optee commands
Date: Wed, 18 Dec 2024 09:49:14 +0530
Message-ID: <20241218041914.1463666-3-venkatesh.abbarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|PH7PR12MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c3a687-eddd-47f5-9b1e-08dd1f1b3a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3e6LnFQ5cvl3WtLpPFVUj8YWbjVrKV8tUoHAoI+XUONj0YW3nyD6mO2z5EAK?=
 =?us-ascii?Q?TUKGwxKhqEsEvX5eEDF4t11IGykwdLYSr2FjiKrxRfXlASmPOI6KGpb5Xye4?=
 =?us-ascii?Q?lW3X/FO+9/t85qIAQL96Gb7/dgAYZWNXhFx3U8tg2cRQIyttb5uLHdorxaGU?=
 =?us-ascii?Q?Ve2vyyFMlfcvwEdNAi7bDaKjOj7EOr9lALHwYh9CRmyWG0qVhqwnaBrqLRel?=
 =?us-ascii?Q?5EyqDMP4WhZejve+Y9519sgIxikUjj+Qhn9ygC3GTV3ZBn/wp4wb06U3Tga+?=
 =?us-ascii?Q?d5nWKqau2CA7gTEghzdvCDfm3/UgPmVUIu/08+xUmBf+gFxHjfZLt2DvFszG?=
 =?us-ascii?Q?+B5TR79foHZJiNejWq+37//7RCrOcqdrm2SMZLGCluDJ7O4GduCK/NcUBm3U?=
 =?us-ascii?Q?D9DNesfPkwBWi75V4e6G2ri5P8mvLhsTvUqdfKWYToEqWYEDUVriW6eVguDH?=
 =?us-ascii?Q?bb7vA/dyNe24gZkKRbwvpm5gl/fMz2VT02qdnFXpNSoC8GNrSiqVfVKkh3T9?=
 =?us-ascii?Q?7mZaV6VCsa4aPjSqWbpgQdfAI0nb75jbjqHm3VQ9zsExJn9t2HRMHBs13lXW?=
 =?us-ascii?Q?mPecznqNiQLrfpmxqn27xI52xJVUkW1V4R/K0rypvw1a935Gh25ojoZg4wi9?=
 =?us-ascii?Q?HhNfT9mG6JSdGj1T6YaXJQNfwLEzmKDn2dzbGPV1hum/tH46p76E+bn+EBuB?=
 =?us-ascii?Q?ABuwO2FtPKNlskSqel9olFaeGi39kcVeRqeupXOWu8HQkwsCYR6Pd1iJrmdS?=
 =?us-ascii?Q?G5E7NE5l4+FOPrFKWa4uI2GTewpgzUwiraoMhmv+++XIEdM0yJ+bnY8vsmIj?=
 =?us-ascii?Q?fU+9OYKq7KJZJOpcR6s169al3bIdo4MtuHn84PgfUns+2nKamfkrB3MYclHH?=
 =?us-ascii?Q?dnkvyRIEjzM3pTBNFlQ6Dq5rdDSGuBh46GwsMdLGbULhyq1cb6t4GcSw7lUF?=
 =?us-ascii?Q?U6VU++mJ/IrtkHwmSXmcZxJ9JPUpuGlgQqB9ICMBxmn4VKdXA+D1I/CV60Ou?=
 =?us-ascii?Q?ibHF9HvP9N/Q+C9Zwa13vyQN4hxN/Xj0fxV8zHuf6JKcJYdLOQkEB397h7F0?=
 =?us-ascii?Q?IlNnZO8b6ILzKErhERa6sSi63H0HTV/ONQCINCi15wz/1V37+SEqm4Ihv/IE?=
 =?us-ascii?Q?uDg2jqDSR5Bk1gQjd2z5Hy6+plP8MoMWi43si9/vqNQkL3+VcWRk/Ov7MOKK?=
 =?us-ascii?Q?CYtQMreQ0PqDRYuVXcKLQROuzr2kXZz+V61nO3dAXq16/Q99gSb2LZW4iclp?=
 =?us-ascii?Q?vUtl/4/oy4PQ63RHrYuHMU35O0q9NiB+S5twWUa6DUmxIGayMol2BPBRaZ2z?=
 =?us-ascii?Q?1AgyON16p9i8eSWgf4iIl9el1rPB/ydgjs6xAt7EYzZ34xZKV5skyDEzBP9i?=
 =?us-ascii?Q?EtqGzRuEGyRrxyf6j/8ykYfcqFEN1Myyp+RFyGuu8Djzx9rj0KHLchfRdgLb?=
 =?us-ascii?Q?RuKEGGzwEOY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 04:19:55.5334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c3a687-eddd-47f5-9b1e-08dd1f1b3a20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6934
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

Provide a man-page for the optee command.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 doc/usage/cmd/optee.rst | 70 +++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst     |  1 +
 2 files changed, 71 insertions(+)
 create mode 100644 doc/usage/cmd/optee.rst

diff --git a/doc/usage/cmd/optee.rst b/doc/usage/cmd/optee.rst
new file mode 100644
index 00000000000..532d488d5e3
--- /dev/null
+++ b/doc/usage/cmd/optee.rst
@@ -0,0 +1,70 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. index::
+   single: optee (command)
+
+optee command
+=============
+
+Synopsis
+--------
+
+::
+
+    optee hello
+    optee hello <value>
+
+Description
+-----------
+
+This is an OP-TEE sanity test which invokes the "Hello World"
+Trusted Application (TA). The TA does two things:
+- It prints debug and information messages to the secure console (if logging is enabled)
+- It increments the integer value passed as a parameter and returns it """
+
+
+value
+	Integer value that the TA is expected to increment and return.
+	The default value is 0.
+
+To enable the OP-TEE Hello World example please refer
+https://optee.readthedocs.io/en/latest/building/gits/optee_examples/optee_examples.html
+
+Examples
+--------
+
+::
+
+	==> optee hello
+	D/TA:  TA_CreateEntryPoint:39 has been called
+	I/TA: Hello World!
+	Value before: 0x0
+	Calling TA
+	D/TA:  inc_value:105 has been called
+	I/TA: Got value: 0 from NW
+	I/TA: Increase value to: 1
+	Value after: 0x1
+	I/TA: Goodbye!
+	D/TA:  TA_DestroyEntryPoint:50 has been called
+
+	==> optee hello 74
+	D/TA:  TA_CreateEntryPoint:39 has been called
+	I/TA: Hello World!
+	Value before: 0x74
+	Calling TA
+	D/TA:  inc_value:105 has been called
+	I/TA: Got value: 116 from NW
+	I/TA: Increase value to: 117
+	Value after: 0x75
+	I/TA: Goodbye!
+	D/TA:  TA_DestroyEntryPoint:50 has been called
+
+Configuration
+-------------
+
+The optee command is enabled by CONFIG_OPTEE=y and CONFIG_CMD_OPTEE=y.
+
+Return value
+------------
+
+The return value $? is 0 (true) if the command succeeds, 1 (false) otherwise.
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index cb7a23f1170..4dd00f002cd 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -92,6 +92,7 @@ Shell commands
    cmd/msr
    cmd/mtest
    cmd/mtrr
+   cmd/optee
    cmd/panic
    cmd/part
    cmd/pause
-- 
2.34.1

