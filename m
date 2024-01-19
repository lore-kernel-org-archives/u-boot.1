Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0688DC47DD3
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 14:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 623E387CC4;
	Fri, 19 Jan 2024 15:26:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="af0qFlPe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E36D87CCB; Fri, 19 Jan 2024 15:26:14 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE5ED87CC1
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 15:26:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhS7CZBTjd5JBp082BsBbb/bCRA5Fqj/eR+UCjtDJKmVpFtYzDwCq5v4ztrFirGxkoT16Nv2yDS+8gyg4Yp2Ok5IEKy5sfXmAMw3WlmXvrg0u+EfsizYTRmp3/XoCmwvraFkEYVrOHACc7GgO5bSMhbMypVylEsERfmtg9jJCbhA5mP5r2t8faWpLy71pINi2B1PXq45Dga94l19ODLvg60lfSwTfiaAozwTTeOQ0eD7vGD0qKicycDjuwU5mQhhuNV3vzWNguhhtu3oo/OCyPOTmp+ryPCe++bPE0DTLD4eU1vSI7yEQGc7CHOIV9L05wMcMFz3xN/i+HaLfe9OCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7xIYaZzD5uQn3zXnce98wotf2fLMFIwxh70qVr3cFI=;
 b=W1R0vsbiAO71KT5sOaF5RGzAEkqCN1J4zISRL9/mhVmipFbt4oYXi/cnsz8rJFX8FaA9xDHxzjUd8Mxagf+pSQeXQLJSwFscH1WQAGJTDupzW22qX20RlLCkDuVxbjIc5bjGLA43HXeXWIZydlxXm2RiiTM6Tv4d4elT1yuz5+bJaUhEAQOBjR9v/nDNCW+4ml7YPtJg5xDnNZCEL3whq5Hq4x//a+N+sS3jTBi9jNgg8oQppoPpfllxLMQFyVIXxAPWDZ40ONV8y+mQesUgfe2dh3Y0QFn8uglNytl67vJTuI76f1vagRS1jEw9oskhsGWGam1zycgUGv0b/e+Ulw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7xIYaZzD5uQn3zXnce98wotf2fLMFIwxh70qVr3cFI=;
 b=af0qFlPe9p6BFuEY2BfRGjH0CjcdCfw/RXKChljKDrhdJrec8BMdTPWDrqj5SydJBQhdZKFGrGKcIc1FUeScVxJIDzG4PkBpAohqFpLwTua6AxaftG/3CZjZwLxr51Jbddf6SZtAs6q6IfdEnXliQ4+aEs2ST+Sbb64hqLoEnMI=
Received: from SJ0PR03CA0296.namprd03.prod.outlook.com (2603:10b6:a03:39e::31)
 by SN7PR12MB7203.namprd12.prod.outlook.com (2603:10b6:806:2aa::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Fri, 19 Jan
 2024 14:26:06 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::13) by SJ0PR03CA0296.outlook.office365.com
 (2603:10b6:a03:39e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26 via Frontend
 Transport; Fri, 19 Jan 2024 14:26:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 14:26:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 08:26:04 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 08:26:04 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 19 Jan 2024 08:26:02 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: usb: Add tests for USB device
Date: Fri, 19 Jan 2024 19:56:02 +0530
Message-ID: <5b52177849019cb9a9847c987032343c0dc280d7.1705665742.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|SN7PR12MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 086f249d-b7ab-4aaf-d4c1-08dc18fa9261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3VCUOnGjm++m+xtc2FXC/hV3jRPWrTXz9SlymtNtUpFvyIQy/Nf7d9TsW3zfsdG2q1z+gV2EVdIhFDSaDlTTLMtnCqDPNRMwZRwF+rXZA/jl0XTD94LtY04RTiSAXGgxgBdxlxYQzX7qKBp/syoZFPbntfSO65m3tc9BYDSCX3vjqOxwXVmmyUZ8haoYErbUn55mrzAVkPcHHuFVCKPeRlbqGpUq3jZE9TXwlRWbyzh+/sk18SF++np/A68MZ/XkVq9IcFCGImFnddHm29Pia564/C0VWtvEx5Rj4aI0TrpheoZLUVrvIV1IHVeWdpgUG3pLXLebi7iSDToIhiRVIHfoHHjAs3kOf8ut+f+ByR25jAnSDUjhPK4ISzMKvtDQ+Eu0WMjKgwQYC1axS5+TE0I2GX++zdFec4WU6qpT/4wjjhq82/MXrZa9rx67EHIVi66kXGKn1jLhHUqEN3YdyEInMIRNjI3uzoeM6QGAVysaDxRrIPX+h9ra8+HXkwRnM+Okq2GmJmlYhgYos0ejD3XNpi3cQ13LL+IR8gf+TN03eq2Pn+gVXS35zfhMbgVPmqphbSLJV85lxdQJ4c3uLl9ft3q58ZadxRQ4rS3p5dk28N1TMXmCLNgHe+rTZzX2LiuGaM+PHvu445XeeosQ8MSFq9Kqq2Wp6Q785pzhm65oSQfJSWBFuDb8VNhATz9BiHEF29H09E+2y/ahwjhBdcjLmBI16aKJBIV+vuaOJvzG4V5mE7dW0pYeAXIHbj+eekzvfpxIyQwH4M67iQLNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(64100799003)(1800799012)(186009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(83380400001)(426003)(4326008)(30864003)(478600001)(107886003)(5660300002)(316002)(8936002)(336012)(6916009)(54906003)(70206006)(26005)(2616005)(70586007)(36860700001)(356005)(44832011)(36756003)(82740400003)(2906002)(81166007)(47076005)(8676002)(41300700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 14:26:05.5293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 086f249d-b7ab-4aaf-d4c1-08dc18fa9261
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7203
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

Add the test cases for usb commands to test its various functionality
such as start, stop, reset, info, tree, storage, dev, part, ls, load,
and save. It also adds different file systems cases such as fat32, ext2
and ext4.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 test/py/tests/test_usb.py | 626 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 626 insertions(+)
 create mode 100644 test/py/tests/test_usb.py

diff --git a/test/py/tests/test_usb.py b/test/py/tests/test_usb.py
new file mode 100644
index 000000000000..fb3d20f0826b
--- /dev/null
+++ b/test/py/tests/test_usb.py
@@ -0,0 +1,626 @@
+# SPDX-License-Identifier: GPL-2.0
+# (C) Copyright 2023, Advanced Micro Devices, Inc.
+
+import pytest
+import random
+import re
+import u_boot_utils
+
+"""
+Note: This test doesn't rely on boardenv_* configuration values but it can
+change the test behavior. To test USB file system cases (fat32, ext2, ext4),
+USB device should be formatted and valid partitions should be created for
+different file system, otherwise it may leads to failure. This test will be
+skipped if the USB device is not detected.
+
+For example:
+
+# Setup env__usb_device_test_skip to not skipping the test. By default, its
+# value is set to True. Set it to False to run all tests for USB device.
+env__usb_device_test_skip = False
+"""
+
+def setup_usb(u_boot_console):
+    if u_boot_console.config.env.get('env__usb_device_test_skip', True):
+        pytest.skip('USB device test is not enabled')
+
+@pytest.mark.buildconfigspec('cmd_usb')
+def test_usb_start(u_boot_console):
+    setup_usb(u_boot_console)
+    output = u_boot_console.run_command('usb start')
+
+    # if output is empty, usb start may already run as part of preboot command
+    # re-start the usb, in that case
+    if not output:
+        u_boot_console.run_command('usb stop')
+        output = u_boot_console.run_command('usb start')
+
+    if 'No USB device found' in output:
+        pytest.skip('No USB controller available')
+
+    if 'Card did not respond to voltage select' in output:
+        pytest.skip('No USB device present')
+
+    controllers = 0
+    storage_device = 0
+    obj = re.search(r'\d USB Device\(s\) found', output)
+    controllers = int(obj.group()[0])
+
+    if not controllers:
+        pytest.skip('No USB device present')
+
+    obj = re.search(r'\d Storage Device\(s\) found', output)
+    storage_device = int(obj.group()[0])
+
+    if not storage_device:
+        pytest.skip('No USB storage device present')
+
+    assert 'USB init failed' not in output
+    assert 'starting USB...' in output
+
+    if 'Starting the controller' in output:
+        assert 'USB XHCI' in output
+
+    output = u_boot_console.run_command('echo $?')
+    assert output.endswith('0')
+    return controllers, storage_device
+
+@pytest.mark.buildconfigspec('cmd_usb')
+def test_usb_stop(u_boot_console):
+    setup_usb(u_boot_console)
+    output = u_boot_console.run_command('usb stop')
+    assert 'stopping USB..' in output
+
+    output = u_boot_console.run_command('echo $?')
+    assert output.endswith('0')
+
+    output = u_boot_console.run_command('usb dev')
+    assert "USB is stopped. Please issue 'usb start' first." in output
+
+@pytest.mark.buildconfigspec('cmd_usb')
+def test_usb_reset(u_boot_console):
+    setup_usb(u_boot_console)
+    output = u_boot_console.run_command('usb reset')
+
+    if 'No USB device found' in output:
+        pytest.skip('No USB controller available')
+
+    if 'Card did not respond to voltage select' in output:
+        pytest.skip('No USB device present')
+
+    obj = re.search(r'\d USB Device\(s\) found', output)
+    usb_dev_num = int(obj.group()[0])
+
+    if not usb_dev_num:
+        pytest.skip('No USB device present')
+
+    obj = re.search(r'\d Storage Device\(s\) found', output)
+    usb_stor_num = int(obj.group()[0])
+
+    if not usb_stor_num:
+        pytest.skip('No USB storage device present')
+
+    assert 'BUG' not in output
+    assert 'USB init failed' not in output
+    assert 'resetting USB...' in output
+
+    if 'Starting the controller' in output:
+        assert 'USB XHCI' in output
+
+    output = u_boot_console.run_command('echo $?')
+    assert output.endswith('0')
+
+@pytest.mark.buildconfigspec('cmd_usb')
+def test_usb_info(u_boot_console):
+    controllers, storage_device = test_usb_start(u_boot_console)
+    output = u_boot_console.run_command('usb info')
+
+    num_controller = len(re.findall(': Hub,', output))
+    num_mass_storage = len(re.findall(': Mass Storage,', output))
+
+    assert num_controller == controllers - 1
+    assert num_mass_storage == storage_device
+
+    output = u_boot_console.run_command('echo $?')
+    assert output.endswith('0')
+
+    for i in range(0, storage_device + controllers - 1):
+        output = u_boot_console.run_command('usb info %d' % i)
+        num_controller = len(re.findall(': Hub,', output))
+        num_mass_storage = len(re.findall(': Mass Storage,', output))
+        assert num_controller + num_mass_storage == 1
+        assert 'No device available' not in output
+        output = u_boot_console.run_command('echo $?')
+        assert output.endswith('0')
+
+@pytest.mark.buildconfigspec('cmd_usb')
+def test_usb_tree(u_boot_console):
+    controllers, storage_device = test_usb_start(u_boot_console)
+    output = u_boot_console.run_command('usb tree')
+
+    num_controller = len(re.findall('Hub', output))
+    num_mass_storage = len(re.findall('Mass Storage', output))
+
+    assert num_controller == controllers - 1
+    assert num_mass_storage == storage_device
+
+    output = u_boot_console.run_command('echo $?')
+    assert output.endswith('0')
+
+@pytest.mark.buildconfigspec('cmd_usb')
+@pytest.mark.buildconfigspec('usb_storage')
+def test_usb_storage(u_boot_console):
+    controllers, storage_device = test_usb_start(u_boot_console)
+    output = u_boot_console.run_command('usb storage')
+
+    obj = re.findall(r'Capacity: (\d+|\d+[\.]?\d)', output)
+    devices = {}
+
+    for key in range(int(storage_device)):
+        devices[key] = {}
+
+    for x in range(int(storage_device)):
+        try:
+            capacity = float(obj[x].split()[0])
+            devices[x]['capacity'] = capacity
+            print('USB storage device %d capacity is: %g MB' % (x, capacity))
+        except ValueError:
+            pytest.fail('USB storage device capacity not recognized')
+
+    output = u_boot_console.run_command('echo $?')
+    assert output.endswith('0')
+
+@pytest.mark.buildconfigspec('cmd_usb')
+def test_usb_dev(u_boot_console):
+    controllers, storage_device = test_usb_start(u_boot_console)
+    output = u_boot_console.run_command('usb dev')
+
+    assert 'no usb devices available' not in output
+
+    output = u_boot_console.run_command('echo $?')
+    assert output.endswith('0')
+
+    devices = {}
+
+    for key in range(int(storage_device)):
+        devices[key] = {}
+
+    fail = 0
+    for x in range(0, storage_device):
+        devices[x]['detected'] = 'yes'
+        output = u_boot_console.run_command('usb dev %d' % x)
+
+        if 'Card did not respond to voltage select' in output:
+            fail = 1
+            devices[x]['detected'] = 'no'
+
+        if 'No USB device found' in output:
+            devices[x]['detected'] = 'no'
+
+        if 'unknown device' in output:
+            devices[x]['detected'] = 'no'
+
+        assert 'is now current device' in output
+        output = u_boot_console.run_command('echo $?')
+        assert output.endswith('0')
+
+    if fail:
+        pytest.fail('USB device not present')
+
+    return devices, controllers, storage_device
+
+@pytest.mark.buildconfigspec('cmd_usb')
+def test_usb_part(u_boot_console):
+    devices, controllers, storage_device = test_usb_dev(u_boot_console)
+    if not devices:
+        pytest.skip('No devices detected')
+
+    u_boot_console.run_command('usb part')
+
+    output = u_boot_console.run_command('echo $?')
+    assert output.endswith('0')
+
+    for i in range(0, storage_device):
+        if devices[i]['detected'] == 'yes':
+            u_boot_console.run_command('usb dev %d' % i)
+            output = u_boot_console.run_command('usb part')
+
+            lines = output.split('\n')
+            part_fat = []
+            part_ext = []
+            for line in lines:
+                obj = re.search(r'(\d)\s+\d+\s+\d+\s+\w+\d+\w+-\d+\s+(\d+\w+)', line)
+                if obj:
+                    part_id = int(obj.groups()[0])
+                    part_type = obj.groups()[1]
+                    print('part_id:%d, part_type:%s' % (part_id, part_type))
+
+                    if part_type == '0c' or part_type == '0b' or part_type == '0e':
+                        print('Fat detected')
+                        part_fat.append(part_id)
+                    elif part_type == '83':
+                        print('ext detected')
+                        part_ext.append(part_id)
+                    else:
+                        pytest.fail('Unsupported Filesystem on device %d' % i)
+            devices[i]['ext4'] = part_ext
+            devices[i]['ext2'] = part_ext
+            devices[i]['fat'] = part_fat
+
+            if not part_ext and not part_fat:
+                pytest.fail('No partition detected on device %d' % i)
+
+    return devices, controllers, storage_device
+
+@pytest.mark.buildconfigspec('cmd_usb')
+@pytest.mark.buildconfigspec('cmd_fat')
+def test_usb_fatls_fatinfo(u_boot_console):
+    devices, controllers, storage_device = test_usb_part(u_boot_console)
+    if not devices:
+        pytest.skip('No devices detected')
+
+    part_detect = 0
+    fs = 'fat'
+    for x in range(0, int(storage_device)):
+        if devices[x]['detected'] == 'yes':
+            u_boot_console.run_command('usb dev %d' % x)
+            try:
+                partitions = devices[x][fs]
+            except:
+                print('No %s table on this device' % fs.upper())
+                continue
+
+            for part in partitions:
+                output = u_boot_console.run_command('fatls usb %d:%s' % (x, part))
+                if 'Unrecognized filesystem type' in output:
+                    partitions.remove(part)
+                    pytest.fail('Unrecognized filesystem')
+
+                if not re.search(r'\d file\(s\), \d dir\(s\)', output):
+                    pytest.fail('%s read failed on device %d' % (fs.upper, x))
+
+                output = u_boot_console.run_command('fatinfo usb %d:%s' % (x, part))
+                string = 'Filesystem: %s' % fs.upper
+                if re.search(string, output):
+                    pytest.fail('%s FS failed on device %d' % (fs.upper(), x))
+                part_detect = 1
+
+    if not part_detect:
+        pytest.skip('No %s partition detected' % fs.upper())
+
+@pytest.mark.buildconfigspec('cmd_usb')
+@pytest.mark.buildconfigspec('cmd_fat')
+@pytest.mark.buildconfigspec('cmd_memory')
+def test_usb_fatload_fatwrite(u_boot_console):
+    devices, controllers, storage_device = test_usb_part(u_boot_console)
+    if not devices:
+        pytest.skip('No devices detected')
+
+    part_detect = 0
+    fs = 'fat'
+    for x in range(0, int(storage_device)):
+        if devices[x]['detected'] == 'yes':
+            u_boot_console.run_command('usb dev %d' % x)
+            try:
+                partitions = devices[x][fs]
+            except:
+                print('No %s table on this device' % fs.upper())
+                continue
+
+            for part in partitions:
+                part_detect = 1
+                addr = u_boot_utils.find_ram_base(u_boot_console)
+                size = random.randint(4, 1 * 1024 * 1024)
+                output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
+                m = re.search('==> (.+?)', output)
+                if not m:
+                    pytest.fail('CRC32 failed')
+                expected_crc32 = m.group(1)
+
+                file = '%s_%d' % ('uboot_test', size)
+                output = u_boot_console.run_command(
+                    '%swrite usb %d:%s %x %s %x' % (fs, x, part, addr, file, size)
+                )
+                assert 'Unable to write' not in output
+                assert 'Error' not in output
+                assert 'overflow' not in output
+                expected_text = '%d bytes written' % size
+                assert expected_text in output
+
+                alignment = int(
+                    u_boot_console.config.buildconfig.get(
+                        'config_sys_cacheline_size', 128
+                    )
+                )
+                offset = random.randrange(alignment, 1024, alignment)
+                output = u_boot_console.run_command(
+                    '%sload usb %d:%s %x %s' % (fs, x, part, addr + offset, file)
+                )
+                assert 'Invalid FAT entry' not in output
+                assert 'Unable to read file' not in output
+                assert 'Misaligned buffer address' not in output
+                expected_text = '%d bytes read' % size
+                assert expected_text in output
+
+                output = u_boot_console.run_command(
+                    'crc32 %x $filesize' % (addr + offset)
+                )
+                assert expected_crc32 in output
+
+    if not part_detect:
+        pytest.skip('No %s partition detected' % fs.upper())
+
+    return file, size
+
+@pytest.mark.buildconfigspec('cmd_usb')
+@pytest.mark.buildconfigspec('cmd_ext4')
+def test_usb_ext4ls(u_boot_console):
+    devices, controllers, storage_device = test_usb_part(u_boot_console)
+    if not devices:
+        pytest.skip('No devices detected')
+
+    part_detect = 0
+    fs = 'ext4'
+    for x in range(0, int(storage_device)):
+        if devices[x]['detected'] == 'yes':
+            try:
+                partitions = devices[x][fs]
+            except:
+                print('No %s table on this device' % fs.upper())
+                continue
+
+            u_boot_console.run_command('usb dev %d' % x)
+            for part in partitions:
+                output = u_boot_console.run_command('%sls usb %d:%s' % (fs, x, part))
+                if 'Unrecognized filesystem type' in output:
+                    partitions.remove(part)
+                    pytest.fail('Unrecognized filesystem')
+                part_detect = 1
+
+    if not part_detect:
+        pytest.skip('No %s partition detected' % fs.upper())
+
+@pytest.mark.buildconfigspec('cmd_usb')
+@pytest.mark.buildconfigspec('cmd_ext4')
+@pytest.mark.buildconfigspec('ext4_write')
+@pytest.mark.buildconfigspec('cmd_memory')
+def test_usb_ext4load_ext4write(u_boot_console):
+    devices, controllers, storage_device = test_usb_part(u_boot_console)
+    if not devices:
+        pytest.skip('No devices detected')
+
+    part_detect = 0
+    fs = 'ext4'
+    for x in range(0, int(storage_device)):
+        if devices[x]['detected'] == 'yes':
+            u_boot_console.run_command('usb dev %d' % x)
+            try:
+                partitions = devices[x][fs]
+            except:
+                print('No %s table on this device' % fs.upper())
+                continue
+
+            for part in partitions:
+                part_detect = 1
+                addr = u_boot_utils.find_ram_base(u_boot_console)
+                size = random.randint(4, 1 * 1024 * 1024)
+                output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
+                m = re.search('==> (.+?)', output)
+                if not m:
+                    pytest.fail('CRC32 failed')
+                expected_crc32 = m.group(1)
+                file = '%s_%d' % ('uboot_test', size)
+
+                output = u_boot_console.run_command(
+                    '%swrite usb %d:%s %x /%s %x' % (fs, x, part, addr, file, size)
+                )
+                assert 'Unable to write' not in output
+                assert 'Error' not in output
+                assert 'overflow' not in output
+                expected_text = '%d bytes written' % size
+                assert expected_text in output
+
+                offset = random.randrange(128, 1024, 128)
+                output = u_boot_console.run_command(
+                    '%sload usb %d:%s %x /%s' % (fs, x, part, addr + offset, file)
+                )
+                expected_text = '%d bytes read' % size
+                assert expected_text in output
+
+                output = u_boot_console.run_command(
+                    'crc32 %x $filesize' % (addr + offset)
+                )
+                assert expected_crc32 in output
+
+    if not part_detect:
+        pytest.skip('No %s partition detected' % fs.upper())
+
+    return file, size
+
+@pytest.mark.buildconfigspec('cmd_usb')
+@pytest.mark.buildconfigspec('cmd_ext2')
+def test_usb_ext2ls(u_boot_console):
+    devices, controllers, storage_device = test_usb_part(u_boot_console)
+    if not devices:
+        pytest.skip('No devices detected')
+
+    part_detect = 0
+    fs = 'ext2'
+    for x in range(0, int(storage_device)):
+        if devices[x]['detected'] == 'yes':
+            u_boot_console.run_command('usb dev %d' % x)
+            try:
+                partitions = devices[x][fs]
+            except:
+                print('No %s table on this device' % fs.upper())
+                continue
+
+            for part in partitions:
+                part_detect = 1
+                output = u_boot_console.run_command('%sls usb %d:%s' % (fs, x, part))
+                if 'Unrecognized filesystem type' in output:
+                    partitions.remove(part)
+                    pytest.fail('Unrecognized filesystem')
+                part_detect = 1
+
+    if not part_detect:
+        pytest.skip('No %s partition detected' % fs.upper())
+
+@pytest.mark.buildconfigspec('cmd_usb')
+@pytest.mark.buildconfigspec('cmd_ext2')
+@pytest.mark.buildconfigspec('cmd_ext4')
+@pytest.mark.buildconfigspec('ext4_write')
+@pytest.mark.buildconfigspec('cmd_memory')
+def test_usb_ext2load(u_boot_console):
+    devices, controllers, storage_device = test_usb_part(u_boot_console)
+    file, size = test_usb_ext4load_ext4write(u_boot_console)
+
+    if not devices:
+        pytest.skip('No devices detected')
+
+    part_detect = 0
+    fs = 'ext2'
+    for x in range(0, int(storage_device)):
+        if devices[x]['detected'] == 'yes':
+            u_boot_console.run_command('usb dev %d' % x)
+            try:
+                partitions = devices[x][fs]
+            except:
+                print('No %s table on this device' % fs.upper())
+                continue
+
+            for part in partitions:
+                part_detect = 1
+                addr = u_boot_utils.find_ram_base(u_boot_console)
+                output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
+                m = re.search('==> (.+?)', output)
+                if not m:
+                    pytest.fail('CRC32 failed')
+                expected_crc32 = m.group(1)
+
+                offset = random.randrange(128, 1024, 128)
+                output = u_boot_console.run_command(
+                    '%sload usb %d:%s %x /%s' % (fs, x, part, addr + offset, file)
+                )
+                expected_text = '%d bytes read' % size
+                assert expected_text in output
+
+                output = u_boot_console.run_command(
+                    'crc32 %x $filesize' % (addr + offset)
+                )
+                assert expected_crc32 in output
+
+    if not part_detect:
+        pytest.skip('No %s partition detected' % fs.upper())
+
+@pytest.mark.buildconfigspec('cmd_usb')
+@pytest.mark.buildconfigspec('cmd_fs_generic')
+def test_usb_ls(u_boot_console):
+    devices, controllers, storage_device = test_usb_part(u_boot_console)
+    if not devices:
+        pytest.skip('No devices detected')
+
+    part_detect = 0
+    for x in range(0, int(storage_device)):
+        if devices[x]['detected'] == 'yes':
+            u_boot_console.run_command('usb dev %d' % x)
+            for fs in ['fat', 'ext4']:
+                try:
+                    partitions = devices[x][fs]
+                except:
+                    print('No %s table on this device' % fs.upper())
+                    continue
+
+                for part in partitions:
+                    part_detect = 1
+                    output = u_boot_console.run_command('ls usb %d:%s' % (x, part))
+                    if re.search(r'No \w+ table on this device', output):
+                        pytest.fail(
+                            '%s: Partition table not found %d' % (fs.upper(), x)
+                        )
+
+    if not part_detect:
+        pytest.skip('No partition detected')
+
+@pytest.mark.buildconfigspec('cmd_usb')
+@pytest.mark.buildconfigspec('cmd_fs_generic')
+def test_usb_load(u_boot_console):
+    devices, controllers, storage_device = test_usb_part(u_boot_console)
+    if not devices:
+        pytest.skip('No devices detected')
+
+    part_detect = 0
+    for x in range(0, int(storage_device)):
+        if devices[x]['detected'] == 'yes':
+            u_boot_console.run_command('usb dev %d' % x)
+            for fs in ['fat', 'ext4']:
+                try:
+                    partitions = devices[x][fs]
+                except:
+                    print('No %s table on this device' % fs.upper())
+                    continue
+
+                for part in partitions:
+                    part_detect = 1
+                    addr = u_boot_utils.find_ram_base(u_boot_console)
+
+                    if fs == 'fat':
+                        file, size = test_usb_fatload_fatwrite(u_boot_console)
+                    elif fs == 'ext4':
+                        file, size = test_usb_ext4load_ext4write(u_boot_console)
+
+                    output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
+                    m = re.search('==> (.+?)', output)
+                    if not m:
+                        pytest.fail('CRC32 failed')
+                    expected_crc32 = m.group(1)
+
+                    offset = random.randrange(128, 1024, 128)
+                    output = u_boot_console.run_command(
+                        'load usb %d:%s %x /%s' % (x, part, addr + offset, file)
+                    )
+                    expected_text = '%d bytes read' % size
+                    assert expected_text in output
+
+                    output = u_boot_console.run_command(
+                        'crc32 %x $filesize' % (addr + offset)
+                    )
+                    assert expected_crc32 in output
+
+    if not part_detect:
+        pytest.skip('No partition detected')
+
+@pytest.mark.buildconfigspec('cmd_usb')
+@pytest.mark.buildconfigspec('cmd_fs_generic')
+def test_usb_save(u_boot_console):
+    devices, controllers, storage_device = test_usb_part(u_boot_console)
+    if not devices:
+        pytest.skip('No devices detected')
+
+    part_detect = 0
+    for x in range(0, int(storage_device)):
+        if devices[x]['detected'] == 'yes':
+            u_boot_console.run_command('usb dev %d' % x)
+            for fs in ['fat', 'ext4']:
+                try:
+                    partitions = devices[x][fs]
+                except:
+                    print('No %s table on this device' % fs.upper())
+                    continue
+
+                for part in partitions:
+                    part_detect = 1
+                    addr = u_boot_utils.find_ram_base(u_boot_console)
+                    size = random.randint(4, 1 * 1024 * 1024)
+                    file = '%s_%d' % ('uboot_test', size)
+
+                    offset = random.randrange(128, 1024, 128)
+                    output = u_boot_console.run_command(
+                        'save usb %d:%s %x /%s %x'
+                        % (x, part, addr + offset, file, size)
+                    )
+                    expected_text = '%d bytes written' % size
+                    assert expected_text in output
+
+    if not part_detect:
+        pytest.skip('No partition detected')
-- 
2.25.1

