Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FD4C47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 05:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8DE28786C;
	Thu, 11 Jan 2024 06:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DRiY2JZo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 488488792C; Thu, 11 Jan 2024 06:40:17 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD29A87847
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 06:40:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cD1BX269QnIHmfLlk4W6ApmjoEVXnuMxqXu48XyFm8mNnu2j3S1+dZVEL8wZrwuMLFN/9D9mRFK6AHomAdWZ6LiVMLBxcP3gICF6GrWoaUIaTE0em880aKiACej7EoMn5A4wD9owc+6cyjLDMDLQr+pOywcCyLmYYsvOGortQNeohoPsF1Lsnyb9MI0rxCUmMMleNcNBxfw/NKAjvnazVqNKEsEvJkp4xFqsaLOJ9446N7zf3vE/D4wSt4LiypeLS92vJAnz7kGLzPBbgslrc6Y7VdfglLwx91N0H3IeDw1Xe38fR7QGuaWvSnIe7d6iFrwEzoBFNq0hOKGJMcOcVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvM7sBWhXzVEpqzewy2OBYiYM/0ImIPePCRQo2Ek9Sg=;
 b=SdSCeL0GqP9sMkjtI0KcviFOuymaOVcjjLEx0yD+zH4NxjDibBAEmENMdJENXMJoMovpLgCiwgXXdEflVtRdgXeuphKhQTfyqa0IxbIWJkKXy3aVdYMOBur9UDAl68aTJbsqjJeOaIHdSUJp3lN/4g995/JrrC7gT138I1TKssu9RQEbv85EfDRnVl+Vb+5PsL9R4+a/TfIIZgfM+nx09malSUGfnFDMqbgpt6C4LLirIcK6N6qEXNb7OS1mnZmsMWuTI24tAOe/fobR2xcyMP85Aw1teAnd3D0XVODIZyIJgSjKgo61MbPv/sPM+DdPhinJtzf9i4tPRPcrOZH4rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvM7sBWhXzVEpqzewy2OBYiYM/0ImIPePCRQo2Ek9Sg=;
 b=DRiY2JZoMXvgQrdgNVN5p4epiZmqNvBJagG2IMb593bXB5wKyBmvDMAHrSxrR6n0IpiFfth5QfOh0TpVn2ft17fMllbvydqrmR6pUw4PLpiG1HHsTcALDSomoqp+RIpjwtXJIv1HSuEQCDTtrh382PvGJhI5sjY9kyIEu2qZ1yE=
Received: from MN2PR04CA0021.namprd04.prod.outlook.com (2603:10b6:208:d4::34)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 05:40:11 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:d4:cafe::44) by MN2PR04CA0021.outlook.office365.com
 (2603:10b6:208:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19 via Frontend
 Transport; Thu, 11 Jan 2024 05:40:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 05:40:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 23:40:09 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 23:40:03 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 10 Jan 2024 23:40:02 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: reset: Add a test for reset command
Date: Thu, 11 Jan 2024 11:10:01 +0530
Message-ID: <bef92835c3b6f0992382673a661f8390dfd4d06e.1704949216.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|CH3PR12MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: 51cf9607-d651-48a9-c8c5-08dc1267c70f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hmjv34RVZCf2WWJuVOZFv3scVDTCLV8mFdMti/SHZOcODFh9jhaOBIuagzY16VMtt4cxxITsarpwo/WD/1JKZFnMqesYFSKchLWHHQCrrpGo/oU4l3w/tHy5nIfELA6CgJsxGnO4it0i4IaAtfx8oIiRynRDvxnC9neaLzLcksPtoWned7ESLvlF8hIeeUYXvhNaZlJkTGsQL6J/GM6YJHThJLddKs/JCw9ziDnyk7BwQBp7IpIIR9QW+/66EG8O/vUcg1BIyWcZFD2Nm60nYPtXRnfCKnfzDOy4UoYlKEGXoBQS7jANnh17EppaxNL3o6S3Kv2Rerk1wXeT/cT80uA25SeXXNZhpsqqTDyMx3UsMdjFTtViC1pwVOEq+UEenbGUQ0eQAYIUn8ijNMsmSmBmpFHzeovtviKdFBOZgj/HBvQJAP2Uef7HP0q5YA7ZidKcW+KSeyxNp1Pt7zEvpgX68bKhujh8JWJuNYIFDJKCECDb5Dc2g9BU3XkIrq+jyO7RoHUB24xN/dGVac7OJDYlylwe+oHcw6fy3xZXgRKKo8bpL7QJQn/Hm9Uc5Z0W+4T1o+9vJPzA3GE7MYi4nePXuweAI5VYYj/T918ManZA6bf1KNe9YyOGWS0NErwVSinR8Ep1OsyCf8HphLlOdjihXW+RWE7B0ZPRD4OBe0V4YjbkyepkXqH4Eq7xLUkO2Jqnr/sewdfsnOB6xLVyZn0AWHhTgx0viWyLPfnWVgFHXIYRWP03VUNEz/qY1PehLDwks+N52OL/IDS927chSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(40470700004)(46966006)(36840700001)(2616005)(426003)(478600001)(336012)(107886003)(83380400001)(5660300002)(2906002)(41300700001)(4326008)(44832011)(8936002)(6916009)(47076005)(8676002)(70586007)(316002)(54906003)(70206006)(82740400003)(81166007)(86362001)(36756003)(356005)(36860700001)(26005)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 05:40:10.9930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51cf9607-d651-48a9-c8c5-08dc1267c70f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483
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

Add a test for reset commands which performs resetting of CPU, It does
COLD reset by default and WARM reset with -w option.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 test/py/tests/test_reset.py | 50 +++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 test/py/tests/test_reset.py

diff --git a/test/py/tests/test_reset.py b/test/py/tests/test_reset.py
new file mode 100644
index 000000000000..896918cd8baf
--- /dev/null
+++ b/test/py/tests/test_reset.py
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0
+# (C) Copyright 2023, Advanced Micro Devices, Inc.
+
+"""
+Note: This test doesn't rely on boardenv_* configuration value but they can
+change test behavior.
+
+# Setup env__reset_test_skip to True if reset test is not possible or desired
+# and should be skipped.
+env__reset_test_skip = True
+
+# This test will be also skipped if the bootmode is detected to JTAG.
+"""
+
+import pytest
+import re
+import test_000_version
+
+def setup_reset_env(u_boot_console):
+    if u_boot_console.config.env.get('env__reset_test_skip', False):
+        pytest.skip('reset test is not enabled')
+
+    output = u_boot_console.run_command('print modeboot')
+    m = re.search('modeboot=(.+?)boot', output)
+    if not m:
+        pytest.skip('bootmode cannnot be determined')
+
+    bootmode = m.group(1)
+    if bootmode == 'jtag':
+        pytest.skip('skipping reset test due to jtag bootmode')
+
+def test_reset(u_boot_console):
+    """Test the reset command in non-JTAG bootmode.
+    It does COLD reset, which resets CPU, DDR and peripherals
+    """
+    setup_reset_env(u_boot_console)
+    u_boot_console.run_command('reset', wait_for_reboot=True)
+
+    # Checks the u-boot command prompt's functionality after reset
+    test_000_version.test_version(u_boot_console)
+
+def test_reset_w(u_boot_console):
+    """Test the reset -w command in non-JTAG bootmode.
+    It does WARM reset, which resets CPU but keep DDR/peripherals active.
+    """
+    setup_reset_env(u_boot_console)
+    u_boot_console.run_command('reset -w', wait_for_reboot=True)
+
+    # Checks the u-boot command prompt's functionality after reset
+    test_000_version.test_version(u_boot_console)
-- 
2.25.1

