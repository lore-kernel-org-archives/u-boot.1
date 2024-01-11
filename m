Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E855C47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 12:42:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D299F87A8B;
	Thu, 11 Jan 2024 13:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wfvJ/KIB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A4A187885; Thu, 11 Jan 2024 13:42:39 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D85387A8B
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 13:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVXNNjjKHpYL086roFZVV0Kik5EPDpvFwqLb/WWzdCWOpJs6VuOF5xMw/LXWR1hM9mezmo6MLQ0hjVOkY/IjnNH+Y+qKaAR2AgNnLp30FMFgUnlCXYKRTriRYIouNM+jNN7CG8mIOGeMGwkWJmuaMjTZyuvJVi1mka8M+S9A+KavFz3HSgjd+BLajkTnl0puRMZeNzZ7VsqDlRlUU2kN7aWwF8IKFid22llSsBKRtWpH32PJy/QOXN7DxagwdGeUOwhLnI92bm6hwqYaSpzCGJ5J59USRDM8UdvnpUCMWhM+mZzytDSVCjhijoAO/2rGmL7dQfpno0oPrDdXfdllxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7zLCqnZlnVIod/R67O4NUwh0dbCnMcuIr3kmESMttg=;
 b=lMbk5xiGsnaNylfnRxjptwjdMKUzkdYoLqCf10xbURQuzZPfezRb637myHyaj5BpIzuVcJq8ANn9EOZF/jZ3uT3LK7b+V7jUyrJPELmq/cqSJkxF3tZSFnbkEye0qiiJ3GzPKnviGKhVBMN1tUJS11uyiBsy8kNvS5j3INV4JIdAJSz8X4Iz3NaINiAHBmdh/k8tGYVL1Eh3y5Y1oP+oTRY+znODmbD1xwBezHjVknBu8UxTZ4tguJwM3JgQVbyaFBHUsbyyyvvcliU/I4c2tdEN5zETTBO1/2p6SNhGdLIaCJv/uahhLPo9Tk6in7ni5AlHTkXT7ICPYRr3k2jNyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7zLCqnZlnVIod/R67O4NUwh0dbCnMcuIr3kmESMttg=;
 b=wfvJ/KIB3e2ne9XBHo9yc3P3RHnUHus3p1PldwHyCIvjLq29HuMlUgYIPTcpZRZD90DqiMciGFyf6Ufi2qYp+GSBwVn3hTC3ErEp47FRSM/n6Y20SdP3IXv/y5tA6sC4cmtcXmRL+oGEmKPqm6InYjCAOBQKTVG+nBGSf756O6g=
Received: from DS7PR05CA0007.namprd05.prod.outlook.com (2603:10b6:5:3b9::12)
 by PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 12:42:34 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::a) by DS7PR05CA0007.outlook.office365.com
 (2603:10b6:5:3b9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.12 via Frontend
 Transport; Thu, 11 Jan 2024 12:42:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 12:42:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 11 Jan
 2024 06:42:32 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 11 Jan 2024 06:42:31 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: saveenv: Add a test for saveenv command
Date: Thu, 11 Jan 2024 18:12:25 +0530
Message-ID: <ad2d0f038a9547ff0e6cba6a496ddec73c6a0e88.1704976608.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|PH8PR12MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 3855f3d3-6f84-4093-5ad4-08dc12a2c83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PWystBriKOXFPo5+RH5Mqs5beNnJQMotmq0LJO6W6xdmIAa/UxafyhzMgaKnVYc6BFSYy4VImF6g55YJn8Cgdh55RcWPd+TWtIBPeFGKpKL859VDfs6kcTx2iEuPagXFTp7A7TrL6KUdj8kD+lDadGawRdykPrMS7R+dV0ghngqKXDJ1kmw75O0CsvUDbzkeFVHzyy1D0vWZrIClDxkvZbFd3O0kzxzZeRPnSgsFFfi0oZp71rD3z7cPy0p7lRth4boOJY7m24BPF/qVMqjNdNcvrXDarFs2ldVmprQo8ha02be66HSt4xePYmwY6tIr3wQnTvBIAIYkP5wfvNgX95J9a9SNTvsx4FGNF5HVPthZw6rrEjH5NMSkisu5OxbZK8pxKkk6nXDBcqMu/28nFmMD8dFwAXZaL+CH5wwImxNH1ReL+B1EajjNaJmQNXRN/QKqub+gGsCM5NbVJhOcGqknpKsq4e1I5mdHaYia2ERNMEMR80TvWgrMvwq6x8AErYctK8c5og2JXN+vBEcunvt3o7o+bGdj1oFAn/2sr48W8m3okMvx/pAT9JWcrzEziWx1of5AwK0kP9IFoSxn1F77UfzYY+pypSGTiZ4lqBCe17xyCxwNSfyj1n13id/F1p0a4lvnEucdsvXTmuMLPO9vGI830DTQHHu3zOPs19ICFd1CQYMRgSrccW7ZdCLhko6zwOOw6OvRveJaAiq3P/cbcB1GbUHYKWcp9mkMsTfZwlmzSPZ2GYbVv2VU6ezSAfm2DAQaeJKdlbsHYTDxcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(336012)(426003)(478600001)(2616005)(107886003)(6666004)(26005)(86362001)(82740400003)(356005)(81166007)(36756003)(41300700001)(2906002)(36860700001)(83380400001)(5660300002)(70586007)(4326008)(47076005)(44832011)(6916009)(70206006)(54906003)(8936002)(8676002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 12:42:33.2009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3855f3d3-6f84-4093-5ad4-08dc12a2c83b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7326
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

Add test case for saveenv command in non-JTAG bootmode which saves the
u-boot environment variables in persistent storage.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 test/py/tests/test_saveenv.py | 125 ++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)
 create mode 100644 test/py/tests/test_saveenv.py

diff --git a/test/py/tests/test_saveenv.py b/test/py/tests/test_saveenv.py
new file mode 100644
index 000000000000..30d8148f8f3e
--- /dev/null
+++ b/test/py/tests/test_saveenv.py
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: GPL-2.0
+# (C) Copyright 2023, Advanced Micro Devices, Inc.
+
+"""
+Note: This test doesn't rely on boardenv_* configuration value but they can
+change test behavior.
+
+# Setup env__saveenv_test_skip to True if saveenv test is not possible or
+# desired and should be skipped.
+env__saveenv_test_skip = True
+
+# This test will be also skipped if the bootmode is detected to JTAG.
+"""
+
+import pytest
+import re
+import random
+import ipaddress
+import string
+import uuid
+
+# Setup the env
+def setup_saveenv_env(u_boot_console):
+    if u_boot_console.config.env.get('env__saveenv_test_skip', False):
+        pytest.skip('saveenv test is not enabled')
+
+    output = u_boot_console.run_command('print modeboot')
+    m = re.search('modeboot=(.+?)boot', output)
+    if not m:
+        pytest.skip('bootmode cannnot be determined')
+
+    bootmode = m.group(1)
+    if bootmode == 'jtag':
+        pytest.skip('skipping saveenv test due to jtag bootmode')
+
+# Check return code
+def ret_code(u_boot_console):
+    return u_boot_console.run_command('echo $?')
+
+# Verify env variable
+def check_env(u_boot_console, var_name, var_value):
+    if var_value:
+        output = u_boot_console.run_command(f'printenv {var_name}')
+        var_value = str(var_value)
+        if (var_value.startswith("'") and var_value.endswith("'")) or (
+            var_value.startswith('"') and var_value.endswith('"')
+        ):
+            var_value = var_value.split(var_value[-1])[1]
+        assert var_value in output
+        assert ret_code(u_boot_console).endswith('0')
+    else:
+        u_boot_console.p.send(f'printenv {var_name}\n')
+        output = u_boot_console.p.expect(['not defined'])
+        assert output == 0
+        assert ret_code(u_boot_console).endswith('1')
+
+# Set env variable
+def set_env(u_boot_console, var_name, var_value):
+    u_boot_console.run_command(f'setenv {var_name} {var_value}')
+    assert ret_code(u_boot_console).endswith('0')
+    check_env(u_boot_console, var_name, var_value)
+
+@pytest.mark.buildconfigspec('cmd_saveenv')
+def test_saveenv(u_boot_console):
+    """Test the saveenv command in non-JTAG bootmode.
+    It saves the U-Boot environment in persistent storage.
+    """
+    setup_saveenv_env(u_boot_console)
+
+    # Set env for random mac address
+    rand_mac = '%02x:%02x:%02x:%02x:%02x:%02x' % (
+        random.randint(0, 255),
+        random.randint(0, 255),
+        random.randint(0, 255),
+        random.randint(0, 255),
+        random.randint(0, 255),
+        random.randint(0, 255),
+    )
+    set_env(u_boot_console, 'mac_addr', rand_mac)
+
+    # Set env for random IPv4 address
+    rand_ipv4 = ipaddress.IPv4Address._string_from_ip_int(
+        random.randint(0, ipaddress.IPv4Address._ALL_ONES)
+    )
+    set_env(u_boot_console, 'ipv4_addr', rand_ipv4)
+
+    # Set env for random IPv6 address
+    rand_ipv6 = ipaddress.IPv6Address._string_from_ip_int(
+        random.randint(0, ipaddress.IPv6Address._ALL_ONES)
+    )
+    set_env(u_boot_console, 'ipv6_addr', rand_ipv6)
+
+    # Set env for random number
+    rand_num = random.randrange(1, 10**9)
+    set_env(u_boot_console, 'num_var', rand_num)
+
+    # Set env for uuid
+    uuid_str = uuid.uuid4().hex.lower()
+    set_env(u_boot_console, 'uuid_var', uuid_str)
+
+    # Set env for random string including special characters
+    sc = "!#%&\()*+,-./:;<=>?@[\\]^_`{|}~"
+    rand_str = ''.join(
+        random.choices(' ' + string.ascii_letters + sc + string.digits, k=300)
+    )
+    set_env(u_boot_console, 'str_var', f'"{rand_str}"')
+
+    # Set env for empty string
+    set_env(u_boot_console, 'empty_var', '')
+
+    # Save the env variables
+    u_boot_console.run_command('saveenv')
+    assert ret_code(u_boot_console).endswith('0')
+
+    # Reboot
+    u_boot_console.run_command('reset', wait_for_reboot=True)
+
+    # Verify the saved env variables
+    check_env(u_boot_console, 'mac_addr', rand_mac)
+    check_env(u_boot_console, 'ipv4_addr', rand_ipv4)
+    check_env(u_boot_console, 'ipv6_addr', rand_ipv6)
+    check_env(u_boot_console, 'num_var', rand_num)
+    check_env(u_boot_console, 'uuid_var', uuid_str)
+    check_env(u_boot_console, 'str_var', rand_str)
+    check_env(u_boot_console, 'empty_var', '')
-- 
2.25.1

