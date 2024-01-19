Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDC8C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 14:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6FFC87BFD;
	Fri, 19 Jan 2024 15:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jkOrkXLC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6910287CAA; Fri, 19 Jan 2024 15:37:04 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A97D387BB5
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 15:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X//T7Q8olsFDJHBlODPzXS+B0g27FDQmH/IPOokfYlh/KAdBFFc0Zew7XiE/0MsfSBT8FhKoRCEt4NdIilt6WrhIGbN2y8zwzpF4TECQ8naRkaG11GlKZ29ak1VYL0WSs8Gdo35fbua4g7AMvPSdWbPtSWJZY0pJLFNmj/PIhRRfBD1g7zAnKgz+baS3RKspl6uYGsfGLX52/xCLvUuyOtZ56Aw96JaOP/h38u/NvbjHvSI1ex3q0Hk1vyhlh7IeZcfhuU68ZL1kahQAjLylGgjdp1SgrCfdPLRyHevrIvvd+k6xyHwCpqKMmc2QH1D0+nwYWYI005AcqC2ZMQ04kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hLp7q7GEQaQFzNBQX6XWwVg9ukqekYwKrYiP+fduwk=;
 b=A+OVkf3290sSYKcrD/t8Upjlkey/R6de+ANVl6YwaId2iBOnkNhgxbe+ZVciAlEgAXUL/1L/Q+oepvngRM2IOCgtfCnyeU5Ci0Fs0eCYT9Q927/aZfWoOOHXBG0W0eDd3s/Ia5+cBEB0s9nbh7VR/MwME4ncH6ks1uWnM4+P/oTv8iTkG+odgPCih+pQEoGee1PfYQvYhiBfxX3SjsyH9EP05KI1U6Y3MPnLHW6RtcjHzC9nTaXnR1d0VFNrR3rFOlpehdk3vtYPmL+iQUXYL+cQOFqlgyo/H678Z7IV9mBWc2FLlmSVSodnieKFClMaWo0u5q82fpqdRYOTGQ4sOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hLp7q7GEQaQFzNBQX6XWwVg9ukqekYwKrYiP+fduwk=;
 b=jkOrkXLCnAlRw0+R3DUiE41ELtRcNPZ+4cJ7yrM+CmPiLcSbZ0eNZ67VC8uvNPWW1rZH/ZCx5j4hEFmQq4IDOzCWvrnNSlSL7w5TjAWw2YX5F+zsThfZnasUnhvZUeNoCMCJS+v7TaVPaAsJGX3Z5J0ca7Xt1BmQJbbTl8VNPmg=
Received: from DM6PR08CA0019.namprd08.prod.outlook.com (2603:10b6:5:80::32) by
 SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.24; Fri, 19 Jan 2024 14:36:57 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:80:cafe::f2) by DM6PR08CA0019.outlook.office365.com
 (2603:10b6:5:80::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Fri, 19 Jan 2024 14:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 14:36:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 08:36:57 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 08:36:56 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 19 Jan 2024 08:36:55 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: spi: Add tests for SPI flash device
Date: Fri, 19 Jan 2024 20:06:54 +0530
Message-ID: <b769de202357f13b1fcf43de81a3c5a36d3fc610.1705674984.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a630065-ce40-47d4-a435-08dc18fc170c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jtys/VUauYDejRsM+3OX02eHUb/fmoJXIVq/LQcdrEXQ50Q3YFJkVSLbokyLKU6zost2VEnoovJiFSec9S9wrtweNSVeAHCXLZxnGXYCu3MpN9XPT+4QNmt+17WZStFmgTkJhAPGMk7rOL8kVsLogrpXJhDC1ro9l5ubYG6oIOz5QejErsrA0+LGy+vwtFMFWEr9u6jJHrsCSK1RNfxvoUitehsJjeGa3YMblvqVUG0uCS4AjlSuCBfH18F1WX4byWljuWxlaExVL6xOKtOFgLUTYIC90MzUR9w9WjNZ9HmQjY0qczriV3zTFU0CnPk65kT2aq7iMHOZyYKscxo2S1uroU+r8yS0wpwWqjNf/3gM4+6K1W0HVvt72INsdxiBnqujpnQYmbv2A1yEBvcG9xwpW7eKO8jTds98Z7Ebe59qzNu5YUglEbwIBtJmd4B0yWtEuv8w9Vry8kOewNEHGq3/ZD5XxUhq5YpMq05mB463AHyt+5fRZ05f2yRKy7FZyvq5LP6x1xHxCh1nyJXvkaAxxFvx0XmfQuvp+sc/rcIsVnoclTnroPc+ZpN4xzelNA4hT5S5nWSvNafHGIoDatPpG/vdnnd7LUKgIK5aFwl1AJjwlP5k7+jClN3ZwbI7K10hNRHy3uvHNWH/7ekwToj3PpGLJQgM44wQLDjyycaGHO7fBq40Bp3RwHYct1PmxAC3YR5ipgTigimLZOTHp2sQRPn2KrlBJ6HPbOTsjC3CzrybCZVup8pU8SW2cw/DABD+TFOErAWtDKacaUYiGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799012)(186009)(40470700004)(46966006)(36840700001)(83380400001)(2616005)(107886003)(40480700001)(40460700003)(26005)(478600001)(336012)(5660300002)(86362001)(426003)(54906003)(316002)(6916009)(70206006)(70586007)(8936002)(8676002)(4326008)(47076005)(36860700001)(82740400003)(30864003)(36756003)(356005)(81166007)(44832011)(2906002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 14:36:57.6516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a630065-ce40-47d4-a435-08dc18fc170c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412
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

Add test cases for sf commands to verify various SPI flash operations
such as erase, write and read. It also adds qspi lock unlock cases.
This test relies on boardenv_* configurations to run it for different
SPI flash family such as single SPI, QSPI, and OSPI.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 test/py/tests/test_spi.py | 626 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 626 insertions(+)
 create mode 100644 test/py/tests/test_spi.py

diff --git a/test/py/tests/test_spi.py b/test/py/tests/test_spi.py
new file mode 100644
index 000000000000..a0b5c075b6ce
--- /dev/null
+++ b/test/py/tests/test_spi.py
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
+Note: This test relies on boardenv_* containing configuration values to define
+spi minimum and maximum frequnecies at which the flash part can operate on and
+these tests run at 5 different spi frequnecy randomised values in the range.
+It also defines the SPI bus number containing the SPI-flash chip, SPI
+chip-select, SPI mode, SPI flash part name and timeout parameters. If minimum
+and maximum frequency is not defined, it will run on freq 0 by default.
+
+Without the boardenv_* configuration, this test will be automatically skipped.
+
+It also relies on configuration values for supported flashes for qspi lock and
+unlock cases. It will run qspi lock-unlock cases only for the supported flash
+parts.
+
+Example:
+env__spi_device_test = {
+    'bus': 0,
+    'chip_select': 0,
+    'min_freq': 10000000,
+    'max_freq': 100000000,
+    'mode': 0,
+    'part_name': 'n25q00a',
+    'timeout': 100000,
+}
+
+env__qspi_lock_unlock = {
+    'supported_flash': 'mt25qu512a, n25q00a, n25q512ax3',
+}
+"""
+
+def setup_spi(u_boot_console):
+    f = u_boot_console.config.env.get('env__spi_device_test', None)
+    if not f:
+        pytest.skip('No env file to read for SPI family device test')
+
+    bus = f.get('bus', 0)
+    cs = f.get('chip_select', 0)
+    mode = f.get('mode', 0)
+    part_name = f.get('part_name', None)
+    timeout = f.get('timeout', None)
+
+    if not part_name:
+        pytest.skip('No env file to read SPI family flash part name')
+
+    return bus, cs, mode, part_name, timeout
+
+# Find out minimum and maximum frequnecies that SPI device can operate
+def spi_find_freq_range(u_boot_console):
+    f = u_boot_console.config.env.get('env__spi_device_test', None)
+    if not f:
+        pytest.skip('No env file to read for SPI family device test')
+
+    min_f = f.get('min_freq', None)
+    max_f = f.get('max_freq', None)
+
+    if not min_f:
+        min_f = 0
+    if not max_f:
+        max_f = 0
+    if max_f < min_f:
+        max_f = min_f
+
+    if min_f == 0 and max_f == 0:
+        iterations = 1
+    else:
+        iterations = 5
+
+    return min_f, max_f, iterations
+
+# Find out SPI family flash memory parameters
+def spi_pre_commands(u_boot_console, freq):
+    bus, cs, mode, part_name, timeout = setup_spi(u_boot_console)
+
+    output = u_boot_console.run_command(f'sf probe {bus}:{cs} {freq} {mode}')
+    if not 'SF: Detected' in output:
+        pytest.skip('No SPI device available')
+
+    if not part_name in output:
+        pytest.fail('SPI flash part name not recognized')
+
+    m = re.search('page size (.+?) Bytes', output)
+    if m:
+        try:
+            page_size = int(m.group(1))
+        except ValueError:
+            pytest.fail('SPI page size not recognized')
+
+    m = re.search('erase size (.+?) KiB', output)
+    if m:
+        try:
+            erase_size = int(m.group(1))
+        except ValueError:
+            pytest.fail('SPI erase size not recognized')
+
+        erase_size *= 1024
+
+    m = re.search('total (.+?) MiB', output)
+    if m:
+        try:
+            global total_size
+            total_size = int(m.group(1))
+        except ValueError:
+            pytest.fail('SPI total size not recognized')
+
+        total_size *= 1024 * 1024
+
+    m = re.search('Detected (.+?) with', output)
+    if m:
+        try:
+            flash_part = m.group(1)
+            assert flash_part == part_name
+        except:
+            pytest.fail('SPI flash part not recognized')
+
+    return page_size, erase_size, total_size, flash_part, timeout
+
+# Read the whole SPI flash twice, random_size till full flash size, random
+# till page size
+def spi_read_twice(u_boot_console, page_size, total_size, timeout):
+    expected_read = 'Read: OK'
+
+    for size in random.randint(4, page_size), random.randint(4, total_size), total_size:
+        addr = u_boot_utils.find_ram_base(u_boot_console)
+        size = size & ~3
+        with u_boot_console.temporary_timeout(timeout):
+            output = u_boot_console.run_command(
+                'sf read %x 0 %x' % (addr + total_size, size)
+            )
+            assert expected_read in output
+        output = u_boot_console.run_command('crc32 %x %x' % (addr + total_size, size))
+        m = re.search('==> (.+?)$', output)
+        if not m:
+            pytest.fail('CRC32 failed')
+        expected_crc32 = m.group(1)
+        with u_boot_console.temporary_timeout(timeout):
+            output = u_boot_console.run_command(
+                'sf read %x 0 %x' % (addr + total_size + 10, size)
+            )
+            assert expected_read in output
+        output = u_boot_console.run_command(
+            'crc32 %x %x' % (addr + total_size + 10, size)
+        )
+        assert expected_crc32 in output
+
+@pytest.mark.buildconfigspec('cmd_sf')
+@pytest.mark.buildconfigspec('cmd_bdi')
+@pytest.mark.buildconfigspec('cmd_memory')
+def test_spi_read_twice(u_boot_console):
+    min_f, max_f, loop = spi_find_freq_range(u_boot_console)
+    i = 0
+    while i < loop:
+        page_size, erase_size, total_size, flash_part, timeout = spi_pre_commands(
+                u_boot_console, random.randint(min_f, max_f))
+        spi_read_twice(u_boot_console, page_size, total_size, timeout)
+        i = i + 1
+
+# This test check crossing boundary for dual/parallel configurations
+def spi_erase_block(u_boot_console, erase_size, total_size):
+    expected_erase = 'Erased: OK'
+    for start in range(0, total_size, erase_size):
+        output = u_boot_console.run_command('sf erase %x %x' % (start, erase_size))
+        assert expected_erase in output
+
+@pytest.mark.buildconfigspec('cmd_sf')
+def test_spi_erase_block(u_boot_console):
+    min_f, max_f, loop = spi_find_freq_range(u_boot_console)
+    i = 0
+    while i < loop:
+        page_size, erase_size, total_size, flash_part, timeout = spi_pre_commands(
+                u_boot_console, random.randint(min_f, max_f))
+        spi_erase_block(u_boot_console, erase_size, total_size)
+        i = i + 1
+
+# Random write till page size, random till size and full size
+def spi_write_twice(u_boot_console, page_size, erase_size, total_size, timeout):
+    addr = u_boot_utils.find_ram_base(u_boot_console)
+    expected_write = 'Written: OK'
+    expected_read = 'Read: OK'
+    expected_erase = 'Erased: OK'
+
+    old_size = 0
+    for size in (
+        random.randint(4, page_size),
+        random.randint(page_size, total_size),
+        total_size,
+    ):
+        offset = random.randint(4, page_size)
+        offset = offset & ~3
+        size = size & ~3
+        size = size - old_size
+        output = u_boot_console.run_command('crc32 %x %x' % (addr + total_size, size))
+        m = re.search('==> (.+?)$', output)
+        if not m:
+            pytest.fail('CRC32 failed')
+
+        expected_crc32 = m.group(1)
+        if old_size % page_size:
+            old_size = int(old_size / page_size)
+            old_size *= page_size
+
+        if size % erase_size:
+            erasesize = int(size / erase_size + 1)
+            erasesize *= erase_size
+
+        eraseoffset = int(old_size / erase_size)
+        eraseoffset *= erase_size
+
+        timeout = 100000000
+        start = 0
+        with u_boot_console.temporary_timeout(timeout):
+            output = u_boot_console.run_command(
+                'sf erase %x %x' % (eraseoffset, erasesize)
+            )
+            assert expected_erase in output
+
+        with u_boot_console.temporary_timeout(timeout):
+            output = u_boot_console.run_command(
+                'sf write %x %x %x' % (addr + total_size, old_size, size)
+            )
+            assert expected_write in output
+        with u_boot_console.temporary_timeout(timeout):
+            output = u_boot_console.run_command(
+                'sf read %x %x %x' % (addr + total_size + offset, old_size, size)
+            )
+            assert expected_read in output
+        output = u_boot_console.run_command(
+            'crc32 %x %x' % (addr + total_size + offset, size)
+        )
+        assert expected_crc32 in output
+        old_size = size
+
+@pytest.mark.buildconfigspec('cmd_bdi')
+@pytest.mark.buildconfigspec('cmd_sf')
+@pytest.mark.buildconfigspec('cmd_memory')
+def test_spi_write_twice(u_boot_console):
+    min_f, max_f, loop = spi_find_freq_range(u_boot_console)
+    i = 0
+    while i < loop:
+        page_size, erase_size, total_size, flash_part, timeout = spi_pre_commands(
+                u_boot_console, random.randint(min_f, max_f))
+        spi_write_twice(u_boot_console, page_size, erase_size, total_size, timeout)
+        i = i + 1
+
+def spi_write_continues(u_boot_console, page_size, total_size, timeout):
+    spi_erase_block(u_boot_console)
+    expected_write = 'Written: OK'
+    expected_read = 'Read: OK'
+    addr = u_boot_utils.find_ram_base(u_boot_console)
+
+    output = u_boot_console.run_command('crc32 %x %x' % (addr + 0x10000, total_size))
+    m = re.search('==> (.+?)$', output)
+    if not m:
+        pytest.fail('CRC32 failed')
+    expected_crc32 = m.group(1)
+
+    old_size = 0
+    for size in (
+        random.randint(4, page_size),
+        random.randint(page_size, total_size),
+        total_size,
+    ):
+        size = size & ~3
+        size = size - old_size
+        with u_boot_console.temporary_timeout(timeout):
+            output = u_boot_console.run_command(
+                'sf write %x %x %x' % (addr + 0x10000 + old_size, old_size, size)
+            )
+            assert expected_write in output
+        old_size += size
+
+    with u_boot_console.temporary_timeout(timeout):
+        output = u_boot_console.run_command(
+            'sf read %x %x %x' % (addr + 0x10000 + total_size, 0, total_size)
+        )
+        assert expected_read in output
+
+    output = u_boot_console.run_command(
+        'crc32 %x %x' % (addr + 0x10000 + total_size, total_size)
+    )
+    assert expected_crc32 in output
+
+@pytest.mark.buildconfigspec('cmd_bdi')
+@pytest.mark.buildconfigspec('cmd_sf')
+@pytest.mark.buildconfigspec('cmd_memory')
+def test_spi_write_continues(u_boot_console):
+    min_f, max_f, loop = spi_find_freq_range(u_boot_console)
+    i = 0
+    while i < loop:
+        page_size, erase_size, total_size, flash_part, timeout = spi_pre_commands(
+                u_boot_console, random.randint(min_f, max_f))
+        spi_write_continues(u_boot_console, page_size, total_size, timeout)
+        i = i + 1
+
+def spi_erase_all(u_boot_console, total_size, timeout):
+    expected_erase = 'Erased: OK'
+    start = 0
+    with u_boot_console.temporary_timeout(timeout):
+        output = u_boot_console.run_command('sf erase 0 ' + str(hex(total_size)))
+        assert expected_erase in output
+
+@pytest.mark.buildconfigspec('cmd_sf')
+def test_spi_erase_all(u_boot_console):
+    min_f, max_f, loop = spi_find_freq_range(u_boot_console)
+    i = 0
+    while i < loop:
+        page_size, erase_size, total_size, flash_part, timeout = spi_pre_commands(
+                u_boot_console, random.randint(min_f, max_f))
+        spi_erase_all(u_boot_console, total_size, timeout)
+        i = i + 1
+
+# Flash operations: erase/write/read
+def flash_ops(
+    u_boot_console, ops, start, size, offset=0, exp_ret=0, exp_str='', not_exp_str=''
+):
+
+    f = u_boot_console.config.env.get('env__spi_device_test', None)
+    if not f:
+        timeout = 1000000
+
+    timeout = f.get('timeout', 1000000)
+
+    if ops == 'erase':
+        with u_boot_console.temporary_timeout(timeout):
+            output = u_boot_console.run_command('sf erase %x %x' % (start, size))
+    else:
+        with u_boot_console.temporary_timeout(timeout):
+            output = u_boot_console.run_command(
+                'sf %s %x %x %x' % (ops, offset, start, size)
+            )
+
+    if exp_str:
+        assert exp_str in output
+    if not_exp_str:
+        assert not_exp_str not in output
+
+    ret_code = u_boot_console.run_command('echo $?')
+    if exp_ret >= 0:
+        assert ret_code.endswith(str(exp_ret))
+
+    return output, ret_code
+
+# Unlock the flash before making it fail
+def qspi_unlock_exit(u_boot_console, addr, size):
+    u_boot_console.run_command('sf protect unlock %x %x' % (addr, size))
+    assert False, 'FAIL: Flash lock is unable to protect the data!'
+
+# QSPI lock-unlock operations
+def qspi_lock_unlock(u_boot_console, lock_addr, lock_size):
+    addr = u_boot_utils.find_ram_base(u_boot_console)
+    expected_erase = 'Erased: OK'
+    expected_write = 'Written: OK'
+    expected_erase_errors = [
+        'Erase operation failed',
+        'Attempted to modify a protected sector',
+        'Erased: ERROR',
+        'is protected and cannot be erased',
+        'ERROR: flash area is locked',
+    ]
+    expected_write_errors = [
+        'ERROR: flash area is locked',
+        'Program operation failed',
+        'Attempted to modify a protected sector',
+        'Written: ERROR',
+    ]
+
+    # Find the protected/un-protected region
+    if lock_addr < (total_size // 2):
+        sect_num = (lock_addr + lock_size) // erase_size
+        x = 1
+        while x < sect_num:
+            x *= 2
+        prot_start = 0
+        prot_size = x * erase_size
+        unprot_start = prot_start + prot_size
+        unprot_size = total_size - unprot_start
+    else:
+        sect_num = (total_size - lock_addr) // erase_size
+        x = 1
+        while x < sect_num:
+            x *= 2
+        prot_start = total_size - (x * erase_size)
+        prot_size = total_size - prot_start
+        unprot_start = 0
+        unprot_size = prot_start
+
+    # Check erase/write operation before locking
+    flash_ops(u_boot_console, 'erase', prot_start, prot_size, 0, 0, expected_erase)
+    flash_ops(u_boot_console, 'write', prot_start, prot_size, addr, 0, expected_write)
+
+    # Locking the flash
+    u_boot_console.run_command('sf protect lock %x %x' % (lock_addr, lock_size))
+    output = u_boot_console.run_command('echo $?')
+    assert output.endswith('0')
+
+    # Check erase/write operation after locking
+    output, ret_code = flash_ops(u_boot_console, 'erase', prot_start, prot_size, 0, -1)
+    if not any(error in output for error in expected_erase_errors) or ret_code.endswith(
+        '0'
+    ):
+        qspi_unlock_exit(u_boot_console, lock_addr, lock_size)
+
+    output, ret_code = flash_ops(
+        u_boot_console, 'write', prot_start, prot_size, addr, -1
+    )
+    if not any(error in output for error in expected_write_errors) or ret_code.endswith(
+        '0'
+    ):
+        qspi_unlock_exit(u_boot_console, lock_addr, lock_size)
+
+    # Check locked sectors
+    sect_lock_start = random.randrange(prot_start, (prot_start + prot_size), erase_size)
+    if prot_size > erase_size:
+        sect_lock_size = random.randrange(
+            erase_size, (prot_start + prot_size - sect_lock_start), erase_size
+        )
+    else:
+        sect_lock_size = erase_size
+    sect_write_size = random.randint(1, sect_lock_size)
+
+    output, ret_code = flash_ops(
+        u_boot_console, 'erase', sect_lock_start, sect_lock_size, 0, -1
+    )
+    if not any(error in output for error in expected_erase_errors) or ret_code.endswith(
+        '0'
+    ):
+        qspi_unlock_exit(u_boot_console, lock_addr, lock_size)
+
+    output, ret_code = flash_ops(
+        u_boot_console, 'write', sect_lock_start, sect_write_size, addr, -1
+    )
+    if not any(error in output for error in expected_write_errors) or ret_code.endswith(
+        '0'
+    ):
+        qspi_unlock_exit(u_boot_console, lock_addr, lock_size)
+
+    # Check unlocked sectors
+    if unprot_size != 0:
+        sect_unlock_start = random.randrange(
+            unprot_start, (unprot_start + unprot_size), erase_size
+        )
+        if unprot_size > erase_size:
+            sect_unlock_size = random.randrange(
+                erase_size, (unprot_start + unprot_size - sect_unlock_start), erase_size
+            )
+        else:
+            sect_unlock_size = erase_size
+        sect_write_size = random.randint(1, sect_unlock_size)
+
+        output, ret_code = flash_ops(
+            u_boot_console, 'erase', sect_unlock_start, sect_unlock_size, 0, -1
+        )
+        if expected_erase not in output or ret_code.endswith('1'):
+            qspi_unlock_exit(u_boot_console, lock_addr, lock_size)
+
+        output, ret_code = flash_ops(
+            u_boot_console, 'write', sect_unlock_start, sect_write_size, addr, -1
+        )
+        if expected_write not in output or ret_code.endswith('1'):
+            qspi_unlock_exit(u_boot_console, lock_addr, lock_size)
+
+    # Unlocking the flash
+    u_boot_console.run_command('sf protect unlock %x %x' % (lock_addr, lock_size))
+    output = u_boot_console.run_command('echo $?')
+    assert output.endswith('0')
+
+    # Check erase/write operation after un-locking
+    flash_ops(u_boot_console, 'erase', prot_start, prot_size, 0, 0, expected_erase)
+    flash_ops(u_boot_console, 'write', prot_start, prot_size, addr, 0, expected_write)
+
+    # Check previous locked sectors
+    sect_lock_start = random.randrange(prot_start, (prot_start + prot_size), erase_size)
+    if prot_size > erase_size:
+        sect_lock_size = random.randrange(
+            erase_size, (prot_start + prot_size - sect_lock_start), erase_size
+        )
+    else:
+        sect_lock_size = erase_size
+    sect_write_size = random.randint(1, sect_lock_size)
+
+    flash_ops(
+        u_boot_console, 'erase', sect_lock_start, sect_lock_size, 0, 0, expected_erase
+    )
+    flash_ops(
+        u_boot_console,
+        'write',
+        sect_lock_start,
+        sect_write_size,
+        addr,
+        0,
+        expected_write,
+    )
+
+@pytest.mark.buildconfigspec('cmd_bdi')
+@pytest.mark.buildconfigspec('cmd_sf')
+@pytest.mark.buildconfigspec('cmd_memory')
+def test_qspi_lock_unlock(u_boot_console):
+    min_f, max_f, loop = spi_find_freq_range(u_boot_console)
+    flashes = u_boot_console.config.env.get('env__qspi_lock_unlock', False)
+    if not flashes:
+        pytest.skip('No supported flash list for lock/unlock provided')
+
+    i = 0
+    while i < loop:
+        page_size, erase_size, total_size, flash_part, timeout = spi_pre_commands(
+                u_boot_console, random.randint(min_f, max_f))
+
+        flashes_list = flashes.get('supported_flash', None).split(',')
+        flashes_list = [x.strip() for x in flashes_list]
+        if flash_part not in flashes_list:
+            pytest.skip('Detected flash does not support lock/unlock')
+
+        # For lower half of memory
+        lock_addr = random.randint(0, (total_size // 2) - 1)
+        lock_size = random.randint(1, ((total_size // 2) - lock_addr))
+        qspi_lock_unlock(u_boot_console, lock_addr, lock_size)
+
+        # For upper half of memory
+        lock_addr = random.randint((total_size // 2), total_size - 1)
+        lock_size = random.randint(1, (total_size - lock_addr))
+        qspi_lock_unlock(u_boot_console, lock_addr, lock_size)
+
+        # For entire flash
+        lock_addr = random.randint(0, total_size - 1)
+        lock_size = random.randint(1, (total_size - lock_addr))
+        qspi_lock_unlock(u_boot_console, lock_addr, lock_size)
+
+        i = i + 1
+
+@pytest.mark.buildconfigspec('cmd_bdi')
+@pytest.mark.buildconfigspec('cmd_sf')
+@pytest.mark.buildconfigspec('cmd_memory')
+def test_spi_negative(u_boot_console):
+    expected_erase = 'Erased: OK'
+    expected_write = 'Written: OK'
+    expected_read = 'Read: OK'
+    min_f, max_f, loop = spi_find_freq_range(u_boot_console)
+    page_size, erase_size, total_size, flash_part, timeout = spi_pre_commands(
+            u_boot_console, random.randint(min_f, max_f))
+    addr = u_boot_utils.find_ram_base(u_boot_console)
+    i = 0
+    while i < loop:
+        # Erase negative test
+        start = random.randint(0, total_size)
+        esize = erase_size
+
+        # If erasesize is not multiple of flash's erase size
+        while esize % erase_size == 0:
+            esize = random.randint(0, total_size - start)
+
+        error_msg = 'Erased: ERROR'
+        flash_ops(
+            u_boot_console, 'erase', start, esize, 0, 1, error_msg, expected_erase
+        )
+
+        # If eraseoffset exceeds beyond flash size
+        eoffset = random.randint(total_size, (total_size + int(0x1000000)))
+        error_msg = 'Offset exceeds device limit'
+        flash_ops(
+            u_boot_console, 'erase', eoffset, esize, 0, 1, error_msg, expected_erase
+        )
+
+        # If erasesize exceeds beyond flash size
+        esize = random.randint((total_size - start), (total_size + int(0x1000000)))
+        error_msg = 'ERROR: attempting erase past flash size'
+        flash_ops(
+            u_boot_console, 'erase', start, esize, 0, 1, error_msg, expected_erase
+        )
+
+        # If erase size is 0
+        esize = 0
+        error_msg = 'ERROR: Invalid size 0'
+        flash_ops(
+            u_boot_console, 'erase', start, esize, 0, 1, error_msg, expected_erase
+        )
+
+        # If erasesize is less than flash's page size
+        esize = random.randint(0, page_size)
+        start = random.randint(0, (total_size - page_size))
+        error_msg = 'Erased: ERROR'
+        flash_ops(
+            u_boot_console, 'erase', start, esize, 0, 1, error_msg, expected_erase
+        )
+
+        # Write/Read negative test
+        # if Write/Read size exceeds beyond flash size
+        offset = random.randint(0, total_size)
+        size = random.randint((total_size - offset), (total_size + int(0x1000000)))
+        error_msg = 'Size exceeds partition or device limit'
+        flash_ops(
+            u_boot_console, 'write', offset, size, addr, 1, error_msg, expected_write
+        )
+        flash_ops(
+            u_boot_console, 'read', offset, size, addr, 1, error_msg, expected_read
+        )
+
+        # if Write/Read offset exceeds beyond flash size
+        offset = random.randint(total_size, (total_size + int(0x1000000)))
+        size = random.randint(0, total_size)
+        error_msg = 'Offset exceeds device limit'
+        flash_ops(
+            u_boot_console, 'write', offset, size, addr, 1, error_msg, expected_write
+        )
+        flash_ops(
+            u_boot_console, 'read', offset, size, addr, 1, error_msg, expected_read
+        )
+
+        # if Write/Read size is 0
+        offset = random.randint(0, 2)
+        size = 0
+        error_msg = 'ERROR: Invalid size 0'
+        flash_ops(
+            u_boot_console, 'write', offset, size, addr, 1, error_msg, expected_write
+        )
+        flash_ops(
+            u_boot_console, 'read', offset, size, addr, 1, error_msg, expected_read
+        )
+
+        i = i + 1
-- 
2.25.1

