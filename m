Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48106C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 14:26:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE7F087CBB;
	Fri, 19 Jan 2024 15:26:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aACzTZcc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EA2D87CBE; Fri, 19 Jan 2024 15:26:00 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79BD287CBA
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 15:25:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zj4cQkIuHdjfs5GAghrnJi9Z1+v0R6sGHBSkv4UjwgefuujUBUnb8va5zkzh3lQs290QCf0pyr0fK+Ynk6b5XTZfvBM6m1l6lgLWyC84sGIxjiAvNkuHmSouD0bLRl/T70fKmpWWi9boHlgTOI14V7yqVjXqcXiHoSXzcRppN1DNorR3rxnXakep51h3sbpsLtawteJz0jV5tqoJcmtXI7/dN7lMqJq/cl1I/wDqkAv4sdPS8YU9bMu3fzF5wuI/POUssMc7/o43xRJseiItT+kIakTUph+EQysSlL+mUN3zVR8FLut2fpkXHd3D0bOY7wc06zYpJiAZBTIqD85vmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FF4hx6Q4n17u9lX703T+YPxJuAAaHAyRVWpLj+KHJQ=;
 b=fxONrJ8PHj+I3645WF7L1ZbnAgiufTS32mO0AYNN7ChOjOp3KLFKvB7uX7VMmU2ZwbfI+dXa807IRgpj1w0wlXXpkG1TZV1eOfe3bKCA90Ocroc2yx9l/cUSZeJgyL+1Rk2UNlAwbe6U+ds+G0emkcZfxAg2Kl0uJvIF3w+Gcw/+c2ZlGvAfal5ek/ecbnfdFgh3MXl8S19JsOonvn+ZblFX+cUS3r5pWuD7y6PDx4euSfxRkM1nWcT2ANzbu0FvzJN2iWD0ES5nZ3YRDmjhBMERdprcK43t7gJrXu3plERCDUTZ1JqI+8JQcjY+zzgXO487CD/ErgHYg2TbtakAPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FF4hx6Q4n17u9lX703T+YPxJuAAaHAyRVWpLj+KHJQ=;
 b=aACzTZcc1QEBHZ9Dcrg1K8Cs/RDjwAFv1mcKofDH0vnJ2QDmiNPZ1k4IE42YjOOlMneAi+USE3KRK8rPSYX6rG6e8NaayQ1pHw83aDDYsszzk1HTgLvtc/hjB6ITqxLK8jMP/B//0CF7BERcQkfdnfD6iXCH6oCIRKkMXTXmb94=
Received: from BL1PR13CA0140.namprd13.prod.outlook.com (2603:10b6:208:2bb::25)
 by IA1PR12MB6355.namprd12.prod.outlook.com (2603:10b6:208:3e1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 14:25:54 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::c3) by BL1PR13CA0140.outlook.office365.com
 (2603:10b6:208:2bb::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.9 via Frontend
 Transport; Fri, 19 Jan 2024 14:25:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 14:25:53 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 08:25:53 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 19 Jan
 2024 06:25:52 -0800
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 19 Jan 2024 08:25:50 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: mmc: Add tests for MMC device
Date: Fri, 19 Jan 2024 19:55:50 +0530
Message-ID: <dd6718c22ebb1e48cd66cba196769098d040f7f0.1705667387.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|IA1PR12MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e2a1ff5-4571-4c3e-64c2-08dc18fa8b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HRViSCxV9ya7yyvZmYk2T+5h+DNACIajF9dWBJtcRt8FxS0Tfqg6t3BwNiGK89IWcovULj05HCg7oC4G0aK51DYJtb85L2AbaMG5QLayonEtETZjZWk8m/YbaEZHt872zldlglDfLyBh5aF/t8K2kqftftcyVRUAPT64yHY7N2GHL55HkGeX3RpxiBCZC4RQ44R5nD+U4g8jrJ6ay5mHx44N+abuEH/HyYjf8mZKmiNuLxuoxP/atYyC514oWla/hXkRGPTZbbv+EX8s6yKjzH1ynSckX93/nVYvQ069d24S25SgGTjsdFzaxqi7jXAUMidm55sa6j8dNDOLzDgbbZIqRFB1j+OegUijlPwKMl/IsyoOutg7vqFJmZ+hRnYRvsE4bRHacKF1LmnhLpZq83116Yr4qUIMdJ6momUiOxMO2LxZS/AUk3QMow0qGwZvb4hndg03f4YoTUwNx+CNGkisSEvMF493y8w2S4vNOuSCAm6jgfD81tYSaoc/VekOiWI+zyCR4WshN/W8lxZmRRjoC8jppBjQ2iH7IFt3gn7RfyycxTcyKP6gHRWswNdZdrElaipQsCShp8VrIVxnVJmFqhCA0pb4eaR9MMwVBtSR5Jg1mb1/TPcsNjCsW8UUeafpqCgr/1oICvRleWRToGKxEiyA34TlkuZK/f6RFzGZtzlWuTgA2Fm+dMATdg7aNDshaLF/BWHaoKBoh1oR+N10aO9jntGlvgwCQPo0o6/KRgFfHCW4TKESYuIoElzQ2RePjjhWoKv3pyaG74voyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(64100799003)(186009)(1800799012)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(36860700001)(4326008)(8676002)(8936002)(36756003)(356005)(81166007)(82740400003)(86362001)(47076005)(41300700001)(2906002)(30864003)(54906003)(5660300002)(26005)(40460700003)(40480700001)(336012)(426003)(478600001)(107886003)(83380400001)(44832011)(2616005)(316002)(6916009)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 14:25:53.6996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2a1ff5-4571-4c3e-64c2-08dc18fa8b52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6355
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

Add the test cases for mmc commands to test its various functionality
such as mmc list, dev, info, rescan, part, ls, load, and save. It also
adds different file systems cases such as fat32, ext2 and ext4.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 test/py/tests/test_mmc.py | 671 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 671 insertions(+)
 create mode 100644 test/py/tests/test_mmc.py

diff --git a/test/py/tests/test_mmc.py b/test/py/tests/test_mmc.py
new file mode 100644
index 000000000000..a96c4e8fd890
--- /dev/null
+++ b/test/py/tests/test_mmc.py
@@ -0,0 +1,671 @@
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
+change the test behavior. To test MMC file system cases (fat32, ext2, ext4),
+MMC device should be formatted and valid partitions should be created for
+different file system, otherwise it may leads to failure. This test will be
+skipped if the MMC device is not detected.
+
+For example:
+
+# Setup env__mmc_device_test_skip to not skipping the test. By default, its
+# value is set to True. Set it to False to run all tests for MMC device.
+env__mmc_device_test_skip = False
+"""
+
+mmc_set_up = False
+controllers = 0
+devices = {}
+
+def setup_mmc(u_boot_console):
+    if u_boot_console.config.env.get('env__mmc_device_test_skip', True):
+        pytest.skip('MMC device test is not enabled')
+
+@pytest.mark.buildconfigspec('cmd_mmc')
+def test_mmc_list(u_boot_console):
+    setup_mmc(u_boot_console)
+    output = u_boot_console.run_command('mmc list')
+    if 'No MMC device available' in output:
+        pytest.skip('No SD/MMC/eMMC controller available')
+
+    if 'Card did not respond to voltage select' in output:
+        pytest.skip('No SD/MMC card present')
+
+    array = output.split()
+    global devices
+    global controllers
+    controllers = int(len(array) / 2)
+    for x in range(0, controllers):
+        y = x * 2
+        devices[x] = {}
+        devices[x]['name'] = array[y]
+
+    global mmc_set_up
+    mmc_set_up = True
+
+@pytest.mark.buildconfigspec('cmd_mmc')
+def test_mmc_dev(u_boot_console):
+    if not mmc_set_up:
+        pytest.skip('No SD/MMC/eMMC controller available')
+
+    fail = 0
+    for x in range(0, controllers):
+        devices[x]['detected'] = 'yes'
+        output = u_boot_console.run_command('mmc dev %d' % x)
+
+        # Some sort of switch here
+        if 'Card did not respond to voltage select' in output:
+            fail = 1
+            devices[x]['detected'] = 'no'
+
+        if 'no mmc device at slot' in output:
+            devices[x]['detected'] = 'no'
+
+        if 'MMC: no card present' in output:
+            devices[x]['detected'] = 'no'
+
+    if fail:
+        pytest.fail('Card not present')
+
+@pytest.mark.buildconfigspec('cmd_mmc')
+def test_mmcinfo(u_boot_console):
+    if not mmc_set_up:
+        pytest.skip('No SD/MMC/eMMC controller available')
+
+    for x in range(0, controllers):
+        if devices[x]['detected'] == 'yes':
+            u_boot_console.run_command('mmc dev %d' % x)
+            output = u_boot_console.run_command('mmcinfo')
+            if 'busy timeout' in output:
+                pytest.skip('No SD/MMC/eMMC device present')
+
+            obj = re.search(r'Capacity: (\d+|\d+[\.]?\d)', output)
+            try:
+                capacity = float(obj.groups()[0])
+                print(capacity)
+                devices[x]['capacity'] = capacity
+                print('Capacity of dev %d is: %g GiB' % (x, capacity))
+            except ValueError:
+                pytest.fail('MMC capacity not recognized')
+
+@pytest.mark.buildconfigspec('cmd_mmc')
+def test_mmc_info(u_boot_console):
+    if not mmc_set_up:
+        pytest.skip('No SD/MMC/eMMC controller available')
+
+    for x in range(0, controllers):
+        if devices[x]['detected'] == 'yes':
+            u_boot_console.run_command('mmc dev %d' % x)
+
+            output = u_boot_console.run_command('mmc info')
+
+            obj = re.search(r'Capacity: (\d+|\d+[\.]?\d)', output)
+            try:
+                capacity = float(obj.groups()[0])
+                print(capacity)
+                if devices[x]['capacity'] != capacity:
+                    pytest.fail("MMC capacity doesn't match mmcinfo")
+
+            except ValueError:
+                pytest.fail('MMC capacity not recognized')
+
+@pytest.mark.buildconfigspec('cmd_mmc')
+def test_mmc_rescan(u_boot_console):
+    if not mmc_set_up:
+        pytest.skip('No SD/MMC/eMMC controller available')
+
+    if not devices:
+        pytest.skip('No devices detected')
+
+    for x in range(0, controllers):
+        if devices[x]['detected'] == 'yes':
+            u_boot_console.run_command('mmc dev %d' % x)
+            output = u_boot_console.run_command('mmc rescan')
+            if output:
+                pytest.fail('mmc rescan has something to check')
+            output = u_boot_console.run_command('echo $?')
+            assert output.endswith('0')
+
+@pytest.mark.buildconfigspec('cmd_mmc')
+def test_mmc_part(u_boot_console):
+    if not mmc_set_up:
+        pytest.skip('No SD/MMC/eMMC controller available')
+
+    if not devices:
+        pytest.skip('No devices detected')
+
+    for x in range(0, controllers):
+        if devices[x]['detected'] == 'yes':
+            u_boot_console.run_command('mmc dev %d' % x)
+            output = u_boot_console.run_command('mmc part')
+
+            lines = output.split('\n')
+            part_fat = []
+            part_ext = []
+            for line in lines:
+                obj = re.search(
+                        r'(\d)\s+\d+\s+\d+\s+\w+\d+\w+-\d+\s+(\d+\w+)', line)
+                if obj:
+                    part_id = int(obj.groups()[0])
+                    part_type = obj.groups()[1]
+                    print('part_id:%d, part_type:%s' % (part_id, part_type))
+
+                    if part_type in ['0c', '0b', '0e']:
+                        print('Fat detected')
+                        part_fat.append(part_id)
+                    elif part_type == '83':
+                        print('ext detected')
+                        part_ext.append(part_id)
+                    else:
+                        pytest.fail('Unsupported Filesystem on device %d' % x)
+            devices[x]['ext4'] = part_ext
+            devices[x]['ext2'] = part_ext
+            devices[x]['fat'] = part_fat
+
+            if not part_ext and not part_fat:
+                pytest.fail('No partition detected on device %d' % x)
+
+@pytest.mark.buildconfigspec('cmd_mmc')
+@pytest.mark.buildconfigspec('cmd_fat')
+def test_mmc_fatls_fatinfo(u_boot_console):
+    if not mmc_set_up:
+        pytest.skip('No SD/MMC/eMMC controller available')
+
+    if not devices:
+        pytest.skip('No devices detected')
+
+    part_detect = 0
+    fs = 'fat'
+    for x in range(0, controllers):
+        if devices[x]['detected'] == 'yes':
+            u_boot_console.run_command('mmc dev %d' % x)
+            try:
+                partitions = devices[x][fs]
+            except:
+                print('No %s table on this device' % fs.upper())
+                continue
+
+            for part in partitions:
+                output = u_boot_console.run_command(
+                        'fatls mmc %d:%s' % (x, part))
+                if 'Unrecognized filesystem type' in output:
+                    partitions.remove(part)
+                    pytest.fail('Unrecognized filesystem')
+
+                if not re.search(r'\d file\(s\), \d dir\(s\)', output):
+                    pytest.fail('%s read failed on device %d' % (fs.upper, x))
+                output = u_boot_console.run_command(
+                        'fatinfo mmc %d:%s' % (x, part))
+                string = 'Filesystem: %s' % fs.upper
+                if re.search(string, output):
+                    pytest.fail('%s FS failed on device %d' % (fs.upper(), x))
+                part_detect = 1
+
+    if not part_detect:
+        pytest.skip('No %s partition detected' % fs.upper())
+
+
+@pytest.mark.buildconfigspec('cmd_mmc')
+@pytest.mark.buildconfigspec('cmd_fat')
+@pytest.mark.buildconfigspec('cmd_memory')
+def test_mmc_fatload_fatwrite(u_boot_console):
+    if not mmc_set_up:
+        pytest.skip('No SD/MMC/eMMC controller available')
+
+    if not devices:
+        pytest.skip('No devices detected')
+
+    part_detect = 0
+    fs = 'fat'
+    for x in range(0, controllers):
+        if devices[x]['detected'] == 'yes':
+            u_boot_console.run_command('mmc dev %d' % x)
+            try:
+                partitions = devices[x][fs]
+            except:
+                print('No %s table on this device' % fs.upper())
+                continue
+
+            for part in partitions:
+                part_detect = 1
+                addr = u_boot_utils.find_ram_base(u_boot_console)
+                devices[x]['addr_%d' % part] = addr
+                size = random.randint(4, 1 * 1024 * 1024)
+                devices[x]['size_%d' % part] = size
+                # count CRC32
+                output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
+                m = re.search('==> (.+?)', output)
+                if not m:
+                    pytest.fail('CRC32 failed')
+                expected_crc32 = m.group(1)
+                devices[x]['expected_crc32_%d' % part] = expected_crc32
+                # do write
+                file = '%s_%d' % ('uboot_test', size)
+                devices[x]['file_%d' % part] = file
+                output = u_boot_console.run_command(
+                    '%swrite mmc %d:%s %x %s %x' % (fs, x, part, addr, file, size)
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
+                    '%sload mmc %d:%s %x %s' % (fs, x, part, addr + offset, file)
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
+@pytest.mark.buildconfigspec('cmd_mmc')
+@pytest.mark.buildconfigspec('cmd_ext4')
+def test_mmc_ext4ls(u_boot_console):
+    if not mmc_set_up:
+        pytest.skip('No SD/MMC/eMMC controller available')
+
+    if not devices:
+        pytest.skip('No devices detected')
+
+    part_detect = 0
+    fs = 'ext4'
+    for x in range(0, controllers):
+        if devices[x]['detected'] == 'yes':
+            try:
+                partitions = devices[x][fs]
+            except:
+                print('No %s table on this device' % fs.upper())
+                continue
+
+            u_boot_console.run_command('mmc dev %d' % x)
+            for part in partitions:
+                output = u_boot_console.run_command('%sls mmc %d:%s' % (fs, x, part))
+                if 'Unrecognized filesystem type' in output:
+                    partitions.remove(part)
+                    pytest.fail('Unrecognized filesystem')
+                part_detect = 1
+
+    if not part_detect:
+        pytest.skip('No %s partition detected' % fs.upper())
+
+@pytest.mark.buildconfigspec('cmd_mmc')
+@pytest.mark.buildconfigspec('cmd_ext4')
+@pytest.mark.buildconfigspec('ext4_write')
+@pytest.mark.buildconfigspec('cmd_memory')
+def test_mmc_ext4load_ext4write(u_boot_console):
+    if not mmc_set_up:
+        pytest.skip('No SD/MMC/eMMC controller available')
+
+    if not devices:
+        pytest.skip('No devices detected')
+
+    part_detect = 0
+    fs = 'ext4'
+    for x in range(0, controllers):
+        if devices[x]['detected'] == 'yes':
+            u_boot_console.run_command('mmc dev %d' % x)
+            try:
+                partitions = devices[x][fs]
+            except:
+                print('No %s table on this device' % fs.upper())
+                continue
+
+            for part in partitions:
+                part_detect = 1
+                addr = u_boot_utils.find_ram_base(u_boot_console)
+                devices[x]['addr_%d' % part] = addr
+                size = random.randint(4, 1 * 1024 * 1024)
+                devices[x]['size_%d' % part] = size
+                # count CRC32
+                output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
+                m = re.search('==> (.+?)', output)
+                if not m:
+                    pytest.fail('CRC32 failed')
+                expected_crc32 = m.group(1)
+                devices[x]['expected_crc32_%d' % part] = expected_crc32
+                # do write
+
+                file = '%s_%d' % ('uboot_test', size)
+                devices[x]['file_%d' % part] = file
+                output = u_boot_console.run_command(
+                    '%swrite mmc %d:%s %x /%s %x' % (fs, x, part, addr, file, size)
+                )
+                assert 'Unable to write' not in output
+                assert 'Error' not in output
+                assert 'overflow' not in output
+                expected_text = '%d bytes written' % size
+                assert expected_text in output
+
+                offset = random.randrange(128, 1024, 128)
+                output = u_boot_console.run_command(
+                    '%sload mmc %d:%s %x /%s' % (fs, x, part, addr + offset, file)
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
+@pytest.mark.buildconfigspec('cmd_mmc')
+@pytest.mark.buildconfigspec('cmd_ext2')
+def test_mmc_ext2ls(u_boot_console):
+    if not mmc_set_up:
+        pytest.skip('No SD/MMC/eMMC controller available')
+
+    if not devices:
+        pytest.skip('No devices detected')
+
+    part_detect = 0
+    fs = 'ext2'
+    for x in range(0, controllers):
+        if devices[x]['detected'] == 'yes':
+            u_boot_console.run_command('mmc dev %d' % x)
+            try:
+                partitions = devices[x][fs]
+            except:
+                print('No %s table on this device' % fs.upper())
+                continue
+
+            for part in partitions:
+                part_detect = 1
+                output = u_boot_console.run_command('%sls mmc %d:%s' % (fs, x, part))
+                if 'Unrecognized filesystem type' in output:
+                    partitions.remove(part)
+                    pytest.fail('Unrecognized filesystem')
+                part_detect = 1
+
+    if not part_detect:
+        pytest.skip('No %s partition detected' % fs.upper())
+
+@pytest.mark.buildconfigspec('cmd_mmc')
+@pytest.mark.buildconfigspec('cmd_ext2')
+@pytest.mark.buildconfigspec('cmd_ext4')
+@pytest.mark.buildconfigspec('ext4_write')
+@pytest.mark.buildconfigspec('cmd_memory')
+def test_mmc_ext2load(u_boot_console):
+    if not mmc_set_up:
+        pytest.skip('No SD/MMC/eMMC controller available')
+
+    if not devices:
+        pytest.skip('No devices detected')
+
+    part_detect = 0
+    fs = 'ext2'
+    for x in range(0, controllers):
+        if devices[x]['detected'] == 'yes':
+            u_boot_console.run_command('mmc dev %d' % x)
+            try:
+                partitions = devices[x][fs]
+            except:
+                print('No %s table on this device' % fs.upper())
+                continue
+
+            for part in partitions:
+                part_detect = 1
+                addr = devices[x]['addr_%d' % part]
+                size = devices[x]['size_%d' % part]
+                expected_crc32 = devices[x]['expected_crc32_%d' % part]
+                file = devices[x]['file_%d' % part]
+
+                offset = random.randrange(128, 1024, 128)
+                output = u_boot_console.run_command(
+                    '%sload mmc %d:%s %x /%s' % (fs, x, part, addr + offset, file)
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
+@pytest.mark.buildconfigspec('cmd_mmc')
+@pytest.mark.buildconfigspec('cmd_fs_generic')
+def test_mmc_ls(u_boot_console):
+    if not mmc_set_up:
+        pytest.skip('No SD/MMC/eMMC controller available')
+
+    if not devices:
+        pytest.skip('No devices detected')
+
+    part_detect = 0
+    for x in range(0, controllers):
+        if devices[x]['detected'] == 'yes':
+            u_boot_console.run_command('mmc dev %d' % x)
+            for fs in ['fat', 'ext4']:
+                try:
+                    partitions = devices[x][fs]
+                except:
+                    print('No %s table on this device' % fs.upper())
+                    continue
+
+                for part in partitions:
+                    part_detect = 1
+                    output = u_boot_console.run_command('ls mmc %d:%s' % (x, part))
+                    if re.search(r'No \w+ table on this device', output):
+                        pytest.fail(
+                            '%s: Partition table not found %d' % (fs.upper(), x)
+                        )
+
+    if not part_detect:
+        pytest.skip('No partition detected')
+
+@pytest.mark.buildconfigspec('cmd_mmc')
+@pytest.mark.buildconfigspec('cmd_fs_generic')
+def test_mmc_load(u_boot_console):
+    if not mmc_set_up:
+        pytest.skip('No SD/MMC/eMMC controller available')
+
+    if not devices:
+        pytest.skip('No devices detected')
+
+    part_detect = 0
+    for x in range(0, controllers):
+        if devices[x]['detected'] == 'yes':
+            u_boot_console.run_command('mmc dev %d' % x)
+            for fs in ['fat', 'ext4']:
+                try:
+                    partitions = devices[x][fs]
+                except:
+                    print('No %s table on this device' % fs.upper())
+                    continue
+
+                for part in partitions:
+                    part_detect = 1
+                    addr = devices[x]['addr_%d' % part]
+                    size = devices[x]['size_%d' % part]
+                    expected_crc32 = devices[x]['expected_crc32_%d' % part]
+                    file = devices[x]['file_%d' % part]
+
+                    offset = random.randrange(128, 1024, 128)
+                    output = u_boot_console.run_command(
+                        'load mmc %d:%s %x /%s' % (x, part, addr + offset, file)
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
+@pytest.mark.buildconfigspec('cmd_mmc')
+@pytest.mark.buildconfigspec('cmd_fs_generic')
+def test_mmc_save(u_boot_console):
+    if not mmc_set_up:
+        pytest.skip('No SD/MMC/eMMC controller available')
+
+    if not devices:
+        pytest.skip('No devices detected')
+
+    part_detect = 0
+    for x in range(0, controllers):
+        if devices[x]['detected'] == 'yes':
+            u_boot_console.run_command('mmc dev %d' % x)
+            for fs in ['fat', 'ext4']:
+                try:
+                    partitions = devices[x][fs]
+                except:
+                    print('No %s table on this device' % fs.upper())
+                    continue
+
+                for part in partitions:
+                    part_detect = 1
+                    addr = devices[x]['addr_%d' % part]
+                    size = 0
+                    file = devices[x]['file_%d' % part]
+
+                    offset = random.randrange(128, 1024, 128)
+                    output = u_boot_console.run_command(
+                        'save mmc %d:%s %x /%s %d'
+                        % (x, part, addr + offset, file, size)
+                    )
+                    expected_text = '%d bytes written' % size
+                    assert expected_text in output
+
+    if not part_detect:
+        pytest.skip('No partition detected')
+
+@pytest.mark.buildconfigspec('cmd_mmc')
+@pytest.mark.buildconfigspec('cmd_fat')
+@pytest.mark.buildconfigspec('cmd_memory')
+def test_mmc_fat_read_write_files(u_boot_console):
+    test_mmc_list(u_boot_console)
+    test_mmc_dev(u_boot_console)
+    test_mmcinfo(u_boot_console)
+    test_mmc_part(u_boot_console)
+    if not mmc_set_up:
+        pytest.skip('No SD/MMC/eMMC controller available')
+
+    if not devices:
+        pytest.skip('No devices detected')
+
+    part_detect = 0
+    fs = 'fat'
+
+    # Number of files to be written/read in MMC card
+    num_files = 100
+
+    for x in range(0, controllers):
+        if devices[x]['detected'] == 'yes':
+            u_boot_console.run_command('mmc dev %d' % x)
+            try:
+                partitions = devices[x][fs]
+            except:
+                print('No %s table on this device' % fs.upper())
+                continue
+
+            for part in partitions:
+                part_detect = 1
+                addr = u_boot_utils.find_ram_base(u_boot_console)
+                count_f = 0
+                addr_l = []
+                size_l = []
+                file_l = []
+                crc32_l = []
+                offset_l = []
+                addr_l.append(addr)
+
+                while count_f < num_files:
+                    size_l.append(random.randint(4, 1 * 1024 * 1024))
+
+                    # CRC32 count
+                    output = u_boot_console.run_command(
+                        'crc32 %x %x' % (addr_l[count_f], size_l[count_f])
+                    )
+                    m = re.search('==> (.+?)', output)
+                    if not m:
+                        pytest.fail('CRC32 failed')
+                    crc32_l.append(m.group(1))
+
+                    # Write operation
+                    file_l.append('%s_%d_%d' % ('uboot_test', count_f, size_l[count_f]))
+                    output = u_boot_console.run_command(
+                        '%swrite mmc %d:%s %x %s %x'
+                        % (
+                            fs,
+                            x,
+                            part,
+                            addr_l[count_f],
+                            file_l[count_f],
+                            size_l[count_f],
+                        )
+                    )
+                    assert 'Unable to write' not in output
+                    assert 'Error' not in output
+                    assert 'overflow' not in output
+                    expected_text = '%d bytes written' % size_l[count_f]
+                    assert expected_text in output
+
+                    addr_l.append(addr_l[count_f] + size_l[count_f] + 1048576)
+                    count_f += 1
+
+                count_f = 0
+                while count_f < num_files:
+                    alignment = int(
+                        u_boot_console.config.buildconfig.get(
+                            'config_sys_cacheline_size', 128
+                        )
+                    )
+                    offset_l.append(random.randrange(alignment, 1024, alignment))
+
+                    # Read operation
+                    output = u_boot_console.run_command(
+                        '%sload mmc %d:%s %x %s'
+                        % (
+                            fs,
+                            x,
+                            part,
+                            addr_l[count_f] + offset_l[count_f],
+                            file_l[count_f],
+                        )
+                    )
+                    assert 'Invalid FAT entry' not in output
+                    assert 'Unable to read file' not in output
+                    assert 'Misaligned buffer address' not in output
+                    expected_text = '%d bytes read' % size_l[count_f]
+                    assert expected_text in output
+
+                    output = u_boot_console.run_command(
+                        'crc32 %x $filesize' % (addr_l[count_f] + offset_l[count_f])
+                    )
+                    assert crc32_l[count_f] in output
+
+                    count_f += 1
+
+    if not part_detect:
+        pytest.skip('No %s partition detected' % fs.upper())
-- 
2.25.1

