Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C89C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 10:01:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4525987B7F;
	Fri, 19 Jan 2024 11:01:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FgzUjlTP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F75B87A18; Fri, 19 Jan 2024 11:01:43 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 363E987730
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 11:01:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJxBgRjS35Xpnkqj+hOYnz+SK1tfOuDEAihNPIc+TSWb3XcQ8orsaIuCJ7w7pf68cEftYGAE6OIDbH4mgNmUMF983TAfHlm9XaSpgzeCq1umqEFr9qJFMmjjST1UGkH2gfNnE6j1M3tKCjZXe6ui8EMY0jiyW5FAD6AQDBo7aMBgKqs3PZzvgEOQ7Xy5lI7xsjmoMm9LoAnCljnUOO7TPjRg8RRJUyNg9FA/O3OHBxQaTDNKc9KEWd+zDaonY+zIwkeQ/QR7OzHTDBaJbqS1uEFyfmP/6HAh/NBbjglKpprUgVjehfyVsShc3NRm0Ad724P6KAe1SU6eS5B0F0oFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsWwLB9KX90QUQHmwONcqNaEbgkXehz+nQ7C1vZLJfY=;
 b=doHNDaqE7bskJ4g5WPwPsr/ZsFjHjlljKhccMMtQZyDaiGlOd6LXm7zQXyoB2g7VAtCfXYPzCjYaenWIGZoSSH6VT+LrJgCXDwdMi7UeO5esDT0FT9TqVQagUbIe/F6v8XDggHAbb8uT93ffpWa/m5xeFuFZAwI26k227u5k6ORomqwMIj9iV4/WwkR/0xEjAchqnWRhrKG0gfXzCHE1YJex1uJeVbMjejEkBP3RE3FheBI1VIvyQ1xTar1xfQY6KaLXJvL0Y0dKsUZiRRm9qV+T4cr6M1jVNnGguOF9tWabOZLO+unbzjYAK5tH3TMqRh71MqbnOga4QU/fanKFVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsWwLB9KX90QUQHmwONcqNaEbgkXehz+nQ7C1vZLJfY=;
 b=FgzUjlTPcV0ivxXtxnIeXSRWmJMxL768dYnzZfpVUrNrfxPK6osSTcSa/WoAwrdiRto5lQ7dkyCxXwJjkLvoLitwy+Odorx0FS47qBrUJjISH6OAg9crJXf5KIUgGlewbwhjh/nPoQHerEQcOOwjqyRA9gTbXnppkGyZwJNnIN0=
Received: from BL1PR13CA0392.namprd13.prod.outlook.com (2603:10b6:208:2c2::7)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 10:01:35 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::e3) by BL1PR13CA0392.outlook.office365.com
 (2603:10b6:208:2c2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.9 via Frontend
 Transport; Fri, 19 Jan 2024 10:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 10:01:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 04:01:31 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 19 Jan 2024 04:01:30 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: secure: Add secure tests for Zynq & ZynqMP
Date: Fri, 19 Jan 2024 15:31:29 +0530
Message-ID: <6e28de8a3ea437ff04cacb2cb389cec44bb033e3.1705655604.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 4308c3c2-d131-4374-c18a-08dc18d59ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wSFdHHr+sk1RRoxrkO6MNJgGMOkosbGbbJxrydnyWiK7tof3fm+J4M6qS5get2EZP6AbFaTmxUD2pxcssXQO5+p7AxqRL1gFszGxSuwHJG/Q/Z/MZqLq/hzwzzc7oyETq7TckCY1Ly1v3+deBMAP0NSdbQw6jxIquaXLc8HzQOqcRCNuY2QDYWbvHwr8ineM1p8lyKsbCNBKxyjQbZpUqJ3vmWt3pRjv1weCdKmNC5GaGMPoJubFSPKYxphU2uv6ApP4zVgwCqLt0eG7v5Sqk2zmIfRBPqm/4bAZNB5Abj+hlJ2rvxpMvwqDgwYp7EUPcT4p4RgYhR4scCJt7k8U8bW5hq3B4U9nx5EMS+E6+dkn36A03/Ywx7RO6ThHmXgpCgMP0UyKQUxP54MqOTWUXqmj46SS0LEMdjymoukfowBi2E6XcJtdSYpHYOzycwxBpKTTLXA7fwRw8/ko8DmoDWh0L9dVU2H1F3JS1JECbIT/2uZEkGy5RQZK0Ad2flG+3+d2NwXD2vV6jIvZan20f68/calwsb9uAIyQwWxqhNj8HQ5jHhP+SFJWuOSpG0o8TY6R/z9jRrb4DJ/57iUq953c1uHlR1hAoWS2uWk54VL9YNVv7p9CCyWw5HbYwJy6zzZ22Wlz846ECp63y1irfRUKrYKZBXhag0t+yVG4Ckr1TfJp/E9VVVH0QdWHHe3drAlF7pqQBEwNEyr6QE9tUYl2kJ/8aXIhxQOPLBB3eK0NHkGHxt0WT0cj2fQfdPI6fM9YzYQRNQhGWjYoHTywog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(82310400011)(64100799003)(451199024)(1800799012)(186009)(40470700004)(36840700001)(46966006)(4326008)(2906002)(41300700001)(36756003)(36860700001)(30864003)(86362001)(81166007)(356005)(82740400003)(316002)(70586007)(54906003)(70206006)(478600001)(6916009)(8676002)(83380400001)(8936002)(47076005)(5660300002)(426003)(336012)(26005)(107886003)(2616005)(44832011)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 10:01:35.1339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4308c3c2-d131-4374-c18a-08dc18d59ed7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125
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

Add test cases to verify the different type of secure boot images loaded
at DDR location for AMD's ZynqMP SoC. It also adds tests authentication
and decryption functionality using AES and RSA features for Zynq.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 test/py/tests/test_zynq_secure.py   | 190 ++++++++++++++++++++++++++++
 test/py/tests/test_zynqmp_secure.py | 104 +++++++++++++++
 2 files changed, 294 insertions(+)
 create mode 100644 test/py/tests/test_zynq_secure.py
 create mode 100644 test/py/tests/test_zynqmp_secure.py

diff --git a/test/py/tests/test_zynq_secure.py b/test/py/tests/test_zynq_secure.py
new file mode 100644
index 000000000000..0ee5aebc484a
--- /dev/null
+++ b/test/py/tests/test_zynq_secure.py
@@ -0,0 +1,190 @@
+# SPDX-License-Identifier: GPL-2.0
+# (C) Copyright 2023, Advanced Micro Devices, Inc.
+
+import pytest
+import re
+import u_boot_utils
+import test_net
+
+"""
+This test verifies different type of secure boot images to authentication and
+decryption using AES and RSA features for AMD's Zynq SoC.
+
+Note: This test relies on boardenv_* containing configuration values to define
+the network available and files to be used for testing. Without this, this test
+will be automatically skipped. It also relies on dhcp or setup_static net test
+to support tftp to load files from a TFTP server.
+
+For example:
+
+# Details regarding the files that may be read from a TFTP server and addresses
+# and size for aes and rsa cases respectively. This variable may be omitted or
+# set to None if zynqmp secure testing is not possible or desired.
+env__zynq_aes_readable_file = {
+    'fn': 'zynq_aes_image.bin',
+    'fnbit': 'zynq_aes_bit.bin',
+    'fnpbit': 'zynq_aes_par_bit.bin',
+    'srcaddr': 0x1000000,
+    'dstaddr': 0x2000000,
+    'dstlen': 0x1000000,
+}
+
+env__zynq_rsa_readable_file = {
+    'fn': 'zynq_rsa_image.bin',
+    'fninvalid': 'zynq_rsa_image_invalid.bin',
+    'srcaddr': 0x1000000,
+}
+"""
+
+def zynq_secure_pre_commands(u_boot_console):
+    output = u_boot_console.run_command('print modeboot')
+    if not 'modeboot=' in output:
+        pytest.skip('bootmode cannnot be determined')
+    m = re.search('modeboot=(.+?)boot', output)
+    if not m:
+        pytest.skip('bootmode cannnot be determined')
+    bootmode = m.group(1)
+    if bootmode == 'jtag':
+        pytest.skip('skipping due to jtag bootmode')
+
+@pytest.mark.buildconfigspec('cmd_zynq_aes')
+def test_zynq_aes_image(u_boot_console):
+    f = u_boot_console.config.env.get('env__zynq_aes_readable_file', None)
+    if not f:
+        pytest.skip('No TFTP readable file for zynq secure aes case to read')
+
+    dstaddr = f.get('dstaddr', None)
+    if not dstaddr:
+        pytest.skip('No dstaddr specified in env file to read')
+
+    dstsize = f.get('dstlen', None)
+    if not dstsize:
+        pytest.skip('No dstlen specified in env file to read')
+
+    zynq_secure_pre_commands(u_boot_console)
+    test_net.test_net_dhcp(u_boot_console)
+    if not test_net.net_set_up:
+        test_net.test_net_setup_static(u_boot_console)
+
+    srcaddr = f.get('srcaddr', None)
+    if not srcaddr:
+        addr = u_boot_utils.find_ram_base(u_boot_console)
+
+    expected_tftp = 'Bytes transferred = '
+    fn = f['fn']
+    output = u_boot_console.run_command('tftpboot %x %s' % (srcaddr, fn))
+    assert expected_tftp in output
+
+    expected_op = 'zynq aes [operation type] <srcaddr>'
+    output = u_boot_console.run_command(
+        'zynq aes %x $filesize %x %x' % (srcaddr, dstaddr, dstsize)
+    )
+    assert expected_op not in output
+    output = u_boot_console.run_command('echo $?')
+    assert output.endswith('0')
+
+@pytest.mark.buildconfigspec('cmd_zynq_aes')
+def test_zynq_aes_bitstream(u_boot_console):
+    f = u_boot_console.config.env.get('env__zynq_aes_readable_file', None)
+    if not f:
+        pytest.skip('No TFTP readable file for zynq secure aes case to read')
+
+    zynq_secure_pre_commands(u_boot_console)
+    test_net.test_net_dhcp(u_boot_console)
+    if not test_net.net_set_up:
+        test_net.test_net_setup_static(u_boot_console)
+
+    srcaddr = f.get('srcaddr', None)
+    if not srcaddr:
+        addr = u_boot_utils.find_ram_base(u_boot_console)
+
+    expected_tftp = 'Bytes transferred = '
+    fn = f['fnbit']
+    output = u_boot_console.run_command('tftpboot %x %s' % (srcaddr, fn))
+    assert expected_tftp in output
+
+    expected_op = 'zynq aes [operation type] <srcaddr>'
+    output = u_boot_console.run_command(
+        'zynq aes load %x $filesize' % (srcaddr)
+    )
+    assert expected_op not in output
+    output = u_boot_console.run_command('echo $?')
+    assert output.endswith('0')
+
+@pytest.mark.buildconfigspec('cmd_zynq_aes')
+def test_zynq_aes_partial_bitstream(u_boot_console):
+    f = u_boot_console.config.env.get('env__zynq_aes_readable_file', None)
+    if not f:
+        pytest.skip('No TFTP readable file for zynq secure aes case to read')
+
+    zynq_secure_pre_commands(u_boot_console)
+    test_net.test_net_dhcp(u_boot_console)
+    if not test_net.net_set_up:
+        test_net.test_net_setup_static(u_boot_console)
+
+    srcaddr = f.get('srcaddr', None)
+    if not srcaddr:
+        addr = u_boot_utils.find_ram_base(u_boot_console)
+
+    expected_tftp = 'Bytes transferred = '
+    fn = f['fnpbit']
+    output = u_boot_console.run_command('tftpboot %x %s' % (srcaddr, fn))
+    assert expected_tftp in output
+
+    expected_op = 'zynq aes [operation type] <srcaddr>'
+    output = u_boot_console.run_command('zynq aes loadp %x $filesize' % (srcaddr))
+    assert expected_op not in output
+    output = u_boot_console.run_command('echo $?')
+    assert output.endswith('0')
+
+@pytest.mark.buildconfigspec('cmd_zynq_rsa')
+def test_zynq_rsa_image(u_boot_console):
+    f = u_boot_console.config.env.get('env__zynq_rsa_readable_file', None)
+    if not f:
+        pytest.skip('No TFTP readable file for zynq secure rsa case to read')
+
+    zynq_secure_pre_commands(u_boot_console)
+    test_net.test_net_dhcp(u_boot_console)
+    if not test_net.net_set_up:
+        test_net.test_net_setup_static(u_boot_console)
+
+    srcaddr = f.get('srcaddr', None)
+    if not srcaddr:
+        addr = u_boot_utils.find_ram_base(u_boot_console)
+
+    expected_tftp = 'Bytes transferred = '
+    fn = f['fn']
+    output = u_boot_console.run_command('tftpboot %x %s' % (srcaddr, fn))
+    assert expected_tftp in output
+
+    expected_op = 'zynq rsa <baseaddr>'
+    output = u_boot_console.run_command('zynq rsa %x ' % (srcaddr))
+    assert expected_op not in output
+    output = u_boot_console.run_command('echo $?')
+    assert output.endswith('0')
+
+@pytest.mark.buildconfigspec('cmd_zynq_rsa')
+def test_zynq_rsa_image_invalid(u_boot_console):
+    f = u_boot_console.config.env.get('env__zynq_rsa_readable_file', None)
+    if not f:
+        pytest.skip('No TFTP readable file for zynq secure rsa case to read')
+
+    zynq_secure_pre_commands(u_boot_console)
+    test_net.test_net_dhcp(u_boot_console)
+    if not test_net.net_set_up:
+        test_net.test_net_setup_static(u_boot_console)
+
+    srcaddr = f.get('srcaddr', None)
+    if not srcaddr:
+        addr = u_boot_utils.find_ram_base(u_boot_console)
+
+    expected_tftp = 'Bytes transferred = '
+    fninvalid = f['fninvalid']
+    output = u_boot_console.run_command('tftpboot %x %s' % (srcaddr, fninvalid))
+    assert expected_tftp in output
+
+    expected_op = 'zynq rsa <baseaddr>'
+    output = u_boot_console.run_command('zynq rsa %x ' % (srcaddr))
+    assert expected_op in output
+    output = u_boot_console.run_command('echo $?')
+    assert not output.endswith('0')
diff --git a/test/py/tests/test_zynqmp_secure.py b/test/py/tests/test_zynqmp_secure.py
new file mode 100644
index 000000000000..570bd2439c17
--- /dev/null
+++ b/test/py/tests/test_zynqmp_secure.py
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: GPL-2.0
+# (C) Copyright 2023, Advanced Micro Devices, Inc.
+
+import pytest
+import re
+import u_boot_utils
+import test_net
+
+"""
+This test verifies different type of secure boot images loaded at the DDR for
+AMD's ZynqMP SoC.
+
+Note: This test relies on boardenv_* containing configuration values to define
+the files to be used for testing. Without this, this test will be automatically
+skipped. It also relies on dhcp or setup_static net test to support tftp to
+load files from a TFTP server.
+
+For example:
+
+# Details regarding the files that may be read from a TFTP server. This
+# variable may be omitted or set to None if zynqmp secure testing is not
+# possible or desired.
+env__zynqmp_secure_readable_file = {
+    'fn': 'auth_bhdr_ppk1.bin',
+    'enckupfn': 'auth_bhdr_enc_kup_load.bin',
+    'addr': 0x1000000,
+    'keyaddr': 0x100000,
+    'keyfn': 'aes.txt',
+}
+"""
+
+@pytest.mark.buildconfigspec('cmd_zynqmp')
+def test_zynqmp_secure_boot_image(u_boot_console):
+    """This test verifies secure boot image at the DDR address for
+    authentication only case.
+    """
+
+    f = u_boot_console.config.env.get('env__zynqmp_secure_readable_file', None)
+    if not f:
+        pytest.skip('No TFTP readable file for zynqmp secure cases to read')
+
+    test_net.test_net_dhcp(u_boot_console)
+    if not test_net.net_set_up:
+        test_net.test_net_setup_static(u_boot_console)
+
+    addr = f.get('addr', None)
+    if not addr:
+        addr = u_boot_utils.find_ram_base(u_boot_console)
+
+    expected_tftp = 'Bytes transferred = '
+    fn = f['fn']
+    output = u_boot_console.run_command('tftpboot %x %s' % (addr, fn))
+    assert expected_tftp in output
+
+    output = u_boot_console.run_command('zynqmp secure %x $filesize' % (addr))
+    assert 'Verified image at' in output
+    ver_addr = re.search(r'Verified image at 0x(.+)', output).group(1)
+    output = u_boot_console.run_command('echo $?')
+    assert output.endswith('0')
+    output = u_boot_console.run_command('print zynqmp_verified_img_addr')
+    assert f'zynqmp_verified_img_addr={ver_addr}' in output
+    assert 'Error' not in output
+
+
+@pytest.mark.buildconfigspec('cmd_zynqmp')
+def test_zynqmp_secure_boot_img_kup(u_boot_console):
+    """This test verifies secure boot image at the DDR address for encryption
+    with kup key case.
+    """
+
+    f = u_boot_console.config.env.get('env__zynqmp_secure_readable_file', None)
+    if not f:
+        pytest.skip('No TFTP readable file for zynqmp secure cases to read')
+
+    test_net.test_net_dhcp(u_boot_console)
+    if not test_net.net_set_up:
+        test_net.test_net_setup_static(u_boot_console)
+
+    keyaddr = f.get('keyaddr', None)
+    if not keyaddr:
+        addr = u_boot_utils.find_ram_base(u_boot_console)
+    expected_tftp = 'Bytes transferred = '
+    keyfn = f['keyfn']
+    output = u_boot_console.run_command('tftpboot %x %s' % (keyaddr, keyfn))
+    assert expected_tftp in output
+
+    addr = f.get('addr', None)
+    if not addr:
+        addr = u_boot_utils.find_ram_base(u_boot_console)
+    expected_tftp = 'Bytes transferred = '
+    fn = f['enckupfn']
+    output = u_boot_console.run_command('tftpboot %x %s' % (addr, fn))
+    assert expected_tftp in output
+
+    output = u_boot_console.run_command(
+        'zynqmp secure %x $filesize %x' % (addr, keyaddr)
+    )
+    assert 'Verified image at' in output
+    ver_addr = re.search(r'Verified image at 0x(.+)', output).group(1)
+    output = u_boot_console.run_command('echo $?')
+    assert output.endswith('0')
+    output = u_boot_console.run_command('print zynqmp_verified_img_addr')
+    assert f'zynqmp_verified_img_addr={ver_addr}' in output
+    assert 'Error' not in output
-- 
2.25.1

