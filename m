Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F0DE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 04:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5347080202;
	Tue, 17 Dec 2024 05:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kfM5jrMV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3653E80224; Tue, 17 Dec 2024 05:00:50 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEEC0801F9
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 05:00:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLnBOevGjHexbas/Rny7Hj1TNnk6sUbZEhFMGE55mWyBGt1BDZo74e3KyC7YLPQKJ9sYEGFSYE1DAloZ75ozHZzh2uj0T5Qd7XsRdMWMjgC/z9s1MVmX7ZSZx7azMYaWYhwKKRUF1lS+0T6Yyn/Y8SXokfpixl1/5cpUglIBJOqMchGskktXrEKwfJiq0rqI98l+1+LsLs4k2IcsGAjgvY/WosnynKl8GYI0oZuSR5OWWRedkFF8G5xIHs/MoBXfO6vyurCZtGECrlnqu2bB+aSK8kbsh4DyqI4agwBvDXCHf4SBOsf9RwFTJ8/IkFNbnk+i9BvKe8cnm7dR0Ioz8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoWPNzXDQ+G01fw8ezTPwMJwWgn9CNvfOFTUhpfctwo=;
 b=Rn6AJ6rMLNCz4km4kSzdxDwupoRWBjlmA8KzNSZh2Bk4FzhFz2rGTednofvR5R/dT910q4O1az3seFDJRsYhBd8OOFcvnH0Drx0dvamdqe2sgwI+G5Am/SJMcfIPYOFCAaPD4iuzEMqoQ9BxrdTqK+8i/ycneuSjlTDeoaoCyDfqM2Hia0EDZn7lBTA4kbQkpRw2ryvORtakIEr2xMD7LZ++x9DvRBCLVn/8mDmgx2nPciC34E85KgPCRuN4WrterU86v5HVr+4jbsBbPMVVBx0zbSajqP3KzTpk/nN7BdlGPfZdeStXlJE7K2sE2B4glvG7VmABFgaXoE+n+IiHLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoWPNzXDQ+G01fw8ezTPwMJwWgn9CNvfOFTUhpfctwo=;
 b=kfM5jrMVvjW5HiUmgGC793e9T5vskCHMOk9ZznlWt4AhLM7+VMhwOdkEMGyhZAG/4aJK2CSA9nPSkaA+CBwhUZWs1P7pL/ZRdFQLwbke7Uyx6gVaEFTf4DaJzD4jqVmA8SvCIa8XEY0kLZIloQ+MasuhPd3oEctmsdv4jjGYERQ=
Received: from CH0PR03CA0422.namprd03.prod.outlook.com (2603:10b6:610:10e::19)
 by DM4PR12MB5891.namprd12.prod.outlook.com (2603:10b6:8:67::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 04:00:44 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::29) by CH0PR03CA0422.outlook.office365.com
 (2603:10b6:610:10e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Tue,
 17 Dec 2024 04:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Tue, 17 Dec 2024 04:00:43 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 22:00:16 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 21:59:31 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 16 Dec 2024 21:59:28 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <jens.wiklander@linaro.org>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>, <jerome.forissier@linaro.org>,
 <mkorpershoek@baylibre.com>, <akashi.tkhro@gmail.com>,
 <francis.laniel@amarulasolutions.com>, <ddrokosov@salutedevices.com>,
 <git@amd.com>
Subject: [PATCH v4 2/2] doc: man-page for optee commands
Date: Tue, 17 Dec 2024 09:29:14 +0530
Message-ID: <20241217035914.1297469-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217035914.1297469-1-venkatesh.abbarapu@amd.com>
References: <20241217035914.1297469-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|DM4PR12MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: a79d6043-a37a-4f91-59d3-08dd1e4f6148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|7416014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/OGRssKLwB2dnf8xXch+x/sZuMC72dywaX8SRRapzpLVH0ea48FM339D/qZk?=
 =?us-ascii?Q?5a1lBjHgCK2EJzHxD+mlpSRf+YJrjPqi5KkV5FLVE11PjA3hcGgm6DZB1DxF?=
 =?us-ascii?Q?2/wQwJdDlr4bv70KeCYrOS2JRJBrxvakgYuq4esJ0+H/PEqcLCqGPOQGzZyV?=
 =?us-ascii?Q?FYJwOpDgSvHVRR/nUVYYo4D8EkLZFAjTxWzB1HC7YUPKmveQezBPulpt0AfJ?=
 =?us-ascii?Q?J/K2UdR6qWBWxNjal+gTVUbtjzyyZHGjwLdTl9wyYAt8fO1E9ZTChW49J6Ln?=
 =?us-ascii?Q?qPWv1jumghBCOGP7z5+tlyvhi4TFBt/Ci/i2l3ZewD2RW/rpNiy4NOAYVi9A?=
 =?us-ascii?Q?3ArKbXiTMbrUhJ7+Sq60RxCDL/xx2ChD1Hrc6T4ozsppV2k3cOulFd3DCL0m?=
 =?us-ascii?Q?F3gX7sTw76UR8gdhjZMtNDtiJkgc9urks+GKyBZDDT65+DWCVr2zCxqIZc1Q?=
 =?us-ascii?Q?GBbX4KqqLS6knAXn+DBWcv+nC1d3nYCHwbC8Az9ampwt08uutrpBR/zfTf7u?=
 =?us-ascii?Q?8R7sGZbrkP765KSmCZ/X1RqjKledDsIWl98ZypfQwlZ9Dlatc5Ws54v9uLZB?=
 =?us-ascii?Q?4vOeuSLpy0VMbZRQQLONth4tY2Hs/JnOy/vknwycVPJOxrMTE26aa65S9ewD?=
 =?us-ascii?Q?aWZbKfpJBBZ9YpiMWOWJzc0WHU5cG4GyXFLhqAIY6eAx1nd7oK4BkZgPuSCD?=
 =?us-ascii?Q?AmTPgDggiGBnop5eYYEgSzw5LyzW6O6yLcl//i+mRgKd39EmSnSNEdWef6z3?=
 =?us-ascii?Q?L19bt9+uJ6uHbIfkjbtdNEGGL7TNhwuA6PeYRqtFh9ldmGw1nJrg2XYIQnoY?=
 =?us-ascii?Q?/PL+LOYPI8T8ZRcmR80Ad1rkg8sGcC/W6Vbi4/fpZa/V8M64yR8o97KtaYm6?=
 =?us-ascii?Q?7osHogx2tBrIf9q98S6vgUU48PLz+oGMwCpHymtRd3lBAL7ebZqIpCIJ71J4?=
 =?us-ascii?Q?R57KbwTkXZODFDXqwi+6oE0KgBKG4NIph0l5lxQBI0ChKksR/ThgQrt9qvSJ?=
 =?us-ascii?Q?tcJFDubpZ32IgQkH1tqAOTdPoGvMgE5QNYVz04OjJEg0tfH8me9otmRdTiyG?=
 =?us-ascii?Q?NQ280rbLxH28PtCznfczPgmtsZJMuaIlksm85CNKmtascB5yK862gE56uTuH?=
 =?us-ascii?Q?v9xWYTPW6FH2knKGk9TU1uRp/XeOqCb2E7K7mK7+tlKSq/KTmTFZD5hcniRk?=
 =?us-ascii?Q?GDDwgX0apWQHZ/DYFeB8muMKVzBToS9sbTGGbphspDdUeEh0PUlXJ/LhB5AI?=
 =?us-ascii?Q?bWBsUVXnX1KQ02ZTH16mgrgMTrqWlGPZcwKFZzhL7wvwBrZZYI7boDHeKZtc?=
 =?us-ascii?Q?2NWWDbg+ZNudjddu2nPyxspf1tcyCC7SNRosKRzb8pNLQKOY3ZYgHB/QpgKH?=
 =?us-ascii?Q?oO1TekHUuqQBmrTtXQP9P3YZ9N525HkhW0IQaUrOHOa0euQWzggjjvQGrBhh?=
 =?us-ascii?Q?EW0OXhCwni0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 04:00:43.9078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a79d6043-a37a-4f91-59d3-08dd1e4f6148
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5891
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
---
 doc/usage/cmd/optee.rst | 66 +++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst     |  1 +
 2 files changed, 67 insertions(+)
 create mode 100644 doc/usage/cmd/optee.rst

diff --git a/doc/usage/cmd/optee.rst b/doc/usage/cmd/optee.rst
new file mode 100644
index 00000000000..53e36853742
--- /dev/null
+++ b/doc/usage/cmd/optee.rst
@@ -0,0 +1,66 @@
+.. SPDX-License-Identifier: GPL-2.0+
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
+This is a very simple optee hello command which is going to
+increment an integer value.
+
+value
+	value to be passed which is going to increment
+
+To enable the OP-TEE OS side HELLO WORLD example please refer
+https://optee.readthedocs.io/en/latest/building/gits/optee_examples/optee_examples.html
+
+Examples
+--------
+
+::
+
+	==> optee hello
+	The Hello World TA is going to be called
+	D/TA:  TA_CreateEntryPoint:39 has been called
+	I/TA: Hello World!
+	TA value: 0x0
+	D/TA:  inc_value:105 has been called
+	I/TA: Got value: 0 from NW
+	I/TA: Increase value to: 1
+	TA value: 0x1
+	I/TA: Goodbye!
+	D/TA:  TA_DestroyEntryPoint:50 has been called
+
+	===> optee hello 74
+	The Hello World TA is going to be called
+	D/TA:  TA_CreateEntryPoint:39 has been called
+	I/TA: Hello World!
+	TA value: 0x74
+	D/TA:  inc_value:105 has been called
+	I/TA: Got value: 116 from NW
+	I/TA: Increase value to: 117
+	TA value: 0x75
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

