Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3645C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 10:30:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA67286F64;
	Wed,  3 Jan 2024 11:30:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="29RdGQs5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9DA186F8E; Wed,  3 Jan 2024 11:30:16 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D87E86EE2
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 11:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPyYCHlZbsRMbraIlWK3GD0nYZv7zdmb5ggxdHi4Duw8sKH8qB88BvxCHrNd5QQc50RDYDY97K51Fjol3zeiifIB4JHVUsZZQCfs/z2xdKSlafIWuvyO5sU0PVBYc7wUHue27ZaocQXd/+4trTLkST+Pa3BBB+5rdkMgLPfu61irL5EnOmuNrnkOoi+w29CQWPvAjF1UPStlMl2grJ87sC462IqcfQ7Ke0yowAFvchTS3vnv+LoXqJ/4UpC0YuvX/vAs1YWCnL4wIwLIvYQ16OJpuisO10MQ5GxI9+vK6Jc+8egK46cssfLLIxa2CnD4qBoK67DkkZMxLTwjp+K0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Au4biQxbUamHP+wwJJULrH++gAzAv2CDh9vllrUwUPQ=;
 b=aqvzcicdFU7kMK7UuUWnB7pXZcbG7GvUDfBv8dpmTKXwL2W5bL0eokkn30MwBNj8IwO5DfAobLHY8M5/eUG1Zmd/bWfYwe8nExmLYVkqi9K/Zn7YMglqTuqhYy/e/UcJ9buoMvHSvY6oj5foLjnpXhxxySPRMUMywR0pzGmIY8MtFgeDQcEuv55DwQ69nRK5YS2AotZ/S8qVIsGdLQmvnuFxM7/trKueZr1OzeHMN/sd9+C7lYW0y+KPk85c6Vx8e4xFrNya0/YxgFeDU/KRdpZXVPpXpnR1nWwAtKqZo+5EY76TpYl1m0KglzO6VU/0exHYLURbXlh0IgKdxlDEeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Au4biQxbUamHP+wwJJULrH++gAzAv2CDh9vllrUwUPQ=;
 b=29RdGQs5+DmZt76Fx6agO3kcq4/9QyQs5/78VQyAhg9YY2btIgC/caIZqFr0cMG6Y9vOKl90ZNrUbArOsy0NV0spKWhyd9TL/9vNBNed9AJycgxziXHqnd+imdo21JRFzbcwhFinPI3n5mskur2DjnLCqS58c0fz+SN3Rcc2Z3I=
Received: from MW4PR04CA0097.namprd04.prod.outlook.com (2603:10b6:303:83::12)
 by PH7PR12MB7965.namprd12.prod.outlook.com (2603:10b6:510:270::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 10:30:10 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::aa) by MW4PR04CA0097.outlook.office365.com
 (2603:10b6:303:83::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14 via Frontend
 Transport; Wed, 3 Jan 2024 10:30:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 10:30:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 04:30:05 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 04:29:43 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 3 Jan 2024 04:29:42 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: memtest: Add tests for mtest command
Date: Wed, 3 Jan 2024 15:59:42 +0530
Message-ID: <7912602add5224c40b81a823d803bdf1e3aa0b62.1704277765.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|PH7PR12MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: d8eacdce-3a3e-4556-70f6-08dc0c46f669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f0b3a5TyL5U2biKDM1Vqy7j4qqhpH3mCnl29D/I3YvLgWOm8ImGGs5RecrIMEfSs9RbdNZOqM4XHGaEE97Q+H37rlgJUA1u185Qin0PVmM7YVaXVN/XLvm+EhwKZB2Zvu5Tix4xtAUKf7HbNmYged6M1KPawClGP3QZrrITpdw/rEnqk0WSqKR7l7Zd/w3w2ppvU6umkfBnEQLXGsJz4KNHiEJzdZOcbvmdZrL0mA+CxQq+JX7uaJq3AZTVxpmfpNnZDjTjYsbuqoKTqPOQUKutMSxgJzhWFmw1owTTbu5CFFTR23fzJtLwKwMOMTVEdE5USCy/Ap2wHiQN4Bj8/hNRLJamyEghSPA/lBIn99mFfPDT8ECwFjawPbsMr7swzm3NXRIJytnhjJwfQEOjeeVxJo9W34gWui9TnLWljEGYpa40DY5Yva/3/eguHVtB5cIdoifsTQfN/AYGtQDKXC7BDkkbVn4ItDebGd51mAqe83bcvvKDlUT2hqtSJMec5FUCqx67QeYfVfWeDdogjCqnV3UNrPqbY0ZGDeRCMnITeNRlJ5qMB9Ia+u7QYkJgV+xyvtDy1LO8Y3yoFCHRTnth6axYmeCdyYbvHwL8PZu4mduJ8eughODepneAB2pUTqK/tbGCU9+nDJcNxV5nxkNFqcluwFAX564qRVkbbE8RAGReclJdkaLtbapJXQoOAY3uiIa5HVVBiPetQKA0Pp7naODy7MRQCb+j846WrOF2iDhhSdQqao7eUKthgCIcXWCt9XnVleYLBr1Ehi2utxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(36840700001)(40470700004)(46966006)(47076005)(107886003)(81166007)(356005)(82740400003)(36860700001)(6916009)(316002)(8936002)(54906003)(478600001)(70586007)(2906002)(5660300002)(70206006)(44832011)(8676002)(4326008)(336012)(2616005)(426003)(26005)(41300700001)(86362001)(36756003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 10:30:09.9242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8eacdce-3a3e-4556-70f6-08dc0c46f669
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7965
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

Add the following memory tests:
memtest_negative - To test mtest command by providing incorrect inputs
memtest_ddr - To test memory write-read-comparision for DDR memory

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 test/py/tests/test_memtest.py | 68 +++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 test/py/tests/test_memtest.py

diff --git a/test/py/tests/test_memtest.py b/test/py/tests/test_memtest.py
new file mode 100644
index 000000000000..0618d96f1bed
--- /dev/null
+++ b/test/py/tests/test_memtest.py
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0
+# (C) Copyright 2023, Advanced Micro Devices, Inc.
+
+import pytest
+
+"""
+Note: This test relies on boardenv_* containing configuration values to define
+the memory test parameters such as start address, memory size, pattern,
+iterations and timeout. This test will be automatically skipped without this.
+
+For example:
+
+# Setup env__memtest to set the start address of the memory range, size of the
+# memory range to test from starting address, pattern to be written to memory,
+# number of test iterations, and expected time to complete the test of mtest
+# command. start address, size, and pattern parameters value should be in hex
+# and rest of the params value should be integer.
+env__memtest = {
+    'start_addr': 0x0,
+    'size': 0x1000,
+    'pattern': 0x0,
+    'iteration': 16,
+    'timeout': 50000,
+}
+"""
+
+def get_memtest_env(u_boot_console):
+    f = u_boot_console.config.env.get("env__memtest", None)
+    if not f:
+        pytest.skip("memtest is not enabled!")
+    else:
+        start = f.get("start_addr", 0x0)
+        size = f.get("size", 0x1000)
+        pattern = f.get("pattern", 0x0)
+        iteration = f.get("iteration", 2)
+        timeout = f.get("timeout", 50000)
+        end = hex(int(start) + int(size))
+        return start, end, pattern, iteration, timeout
+
+@pytest.mark.buildconfigspec("cmd_memtest")
+def test_memtest_negative(u_boot_console):
+    """Negative testcase where end address is smaller than starting address and
+    pattern is invalid."""
+    start, end, pattern, iteration, timeout = get_memtest_env(u_boot_console)
+    expected_response = "Refusing to do empty test"
+    response = u_boot_console.run_command(
+        f"mtest 2000 1000 {pattern} {hex(iteration)}"
+    )
+    assert expected_response in response
+    output = u_boot_console.run_command("echo $?")
+    assert not output.endswith("0")
+    u_boot_console.run_command(f"mtest {start} {end} 'xyz' {hex(iteration)}")
+    output = u_boot_console.run_command("echo $?")
+    assert not output.endswith("0")
+
+@pytest.mark.buildconfigspec("cmd_memtest")
+def test_memtest_ddr(u_boot_console):
+    """Test that md reads memory as expected, and that memory can be modified
+    using the mw command."""
+    start, end, pattern, iteration, timeout = get_memtest_env(u_boot_console)
+    expected_response = f"Tested {str(iteration)} iteration(s) with 0 errors."
+    with u_boot_console.temporary_timeout(timeout):
+        response = u_boot_console.run_command(
+            f"mtest {start} {end} {pattern} {hex(iteration)}"
+        )
+        assert expected_response in response
+    output = u_boot_console.run_command("echo $?")
+    assert output.endswith("0")
-- 
2.25.1

