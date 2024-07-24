Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCA3C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 11:07:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FE82887F5;
	Wed, 24 Jul 2024 13:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zgs5QnEB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC24188826; Wed, 24 Jul 2024 13:07:11 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C23528875F
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 13:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cc85w3qmIpDX0hdgIzu6Oo8euW4s7vjuPlTigH/7hANt7fDFGeTQaSCVMWI5lvagV84oQ8HCkV93xL4b7wqgQZn85fxtCzZ/mK8OYQsk0tZN5EEK/TyNFtA26FLIekE66hYQHSvKNt4qimx3hK+vS1pT8YnmYFV4zrmC/4H8lqNSK2TytFQ8OJQY5HxAbXW56OwYZwTetNZb0QNldFCdDbf2FwMoQ+5mygFXyHtDIEy8lzNud7iRO6tQ4dv2AxCHpBN0EeoFO/DUF5T3o5tIFUA9ZW5FAM2EvQ0jkgvFPBEEPLIKE8wQKsMeQLlvHKHPj+bVzQQBHXCvSONPVrPlJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArWsa7kESiUkDba+i8rHQlROUfofJPXi6sEh12wucc4=;
 b=A43xLqcNKP3P8EW/zMZUONpTwgrjcc5rxZFaKcxqj3SnqY65ufo4bCXcaYI+y4pUzjoQQUs4PCSMGO3ZWLLSyJqMw/sfeJHEHyrJbBphROZG6JZF8ql8Fo2IIHnrfZO5ioBM71mjbOCMU7TP86gOoTRkx1w8dLT/TbfLQjusfYjo7wSPRHDCY1MEudxZCskPnc+piUJNZMMfk3QzSWr5UC332NQ5Ft5nSyk5D/VllXj4dp5y6F3L/DRjij3FP1YsaWeMHWsQ4qj6ZdUK4skoGPPrQPgSprjUU3iamY2kDW7GXptM3jrv4x7EccBsK08kdNOVyAxnII7IWtHJGjvMUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArWsa7kESiUkDba+i8rHQlROUfofJPXi6sEh12wucc4=;
 b=Zgs5QnEBYV2wMOHSc611dsXx7YfGy2qN79y0HdWlSm6x3h+dHI073x/Zw+1vnPCOC9wnmh+DHCHO0yX8HAcRdIq7KEXKsfg5MkHs9OyQDwsgBcWeZ524/plCZDv6r9n41nqd+eaTd6H7dw0louwhNj+Cj54JMV3KKdHCbR4kjHQ=
Received: from SA0PR11CA0032.namprd11.prod.outlook.com (2603:10b6:806:d0::7)
 by DS7PR12MB5789.namprd12.prod.outlook.com (2603:10b6:8:74::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 11:07:04 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:d0:cafe::81) by SA0PR11CA0032.outlook.office365.com
 (2603:10b6:806:d0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Wed, 24 Jul 2024 11:06:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 24 Jul 2024 11:06:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 24 Jul
 2024 06:06:55 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 24 Jul 2024 06:06:54 -0500
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v2] test/py: spi: Add tests for SPI flash device
Date: Wed, 24 Jul 2024 16:36:53 +0530
Message-ID: <a68bffff608d11f4249ede9e51226f9ec917da59.1721819159.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: love.kumar@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|DS7PR12MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b34e8a-8071-4de3-2bee-08dcabd0bc05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nCr+AOwsY+UZj6WYDzPcbV15E+skXZnWR+HrUULXYfQqB+cRzxbZrYZbckP3?=
 =?us-ascii?Q?PNtsbWmV2eb2INSZJq01/S57et8aAFuYLh07/iiAYDPQcMEjTksqU8gHRUKP?=
 =?us-ascii?Q?WqNJ/h4Y4ElqywdL9PPhFf/oyWdDFoG5zFbiNtrsCbblulrAcS5Pa9OUa8mo?=
 =?us-ascii?Q?f6TwXxS2q8R3zNOGMrbT4DtkuBBX4/IBMbCW3lK8z+pgm2ufH8X1F9VxySa3?=
 =?us-ascii?Q?JNOAAJIC1srJ9oMTKYlT7oPU+PaXZa2sRfPwVL7kJoQ6zeVy6N64nHcqj3/6?=
 =?us-ascii?Q?t0DZuJZlK+VWJ8jHDmqS2pJWFfR2bRtbFekF6TwiwUM+MJxAwgjFZQA0fngj?=
 =?us-ascii?Q?cD2Qw0aQOgrd5u9EUY/MitrPLI/zvdL/oUjh4R2mrJ9s9hsRTXuknKeqecRl?=
 =?us-ascii?Q?PeeCt8MVFZcT6SfAU+gT9nyUm8Nqs89cDAloafSkZ8AHJ5f9z0fs/ubb5IAo?=
 =?us-ascii?Q?ER1jQmahM5AuNadD87nf378TUN3CKAikNs610vpUQBq11LNUei8am8HpGor8?=
 =?us-ascii?Q?e2VOBA5FNI0Q25DrcABrn94vtE3UxfxNnK+00Ppj4CiE5zBuGTRT4TAVj9jN?=
 =?us-ascii?Q?hqlBMCrqZb81t+aMPGkKkAIO8o6OGulMlzSplQgNvq5dys40jDTo4fSATvQp?=
 =?us-ascii?Q?ymcrFqkKnUCMpZiWkfy+jOGTVae4CkCoF4nJ/hY64TAOgAHlFd47gSmyYJ5G?=
 =?us-ascii?Q?QH7F5FIKfDdYydX9nUHLNWpMfYXpUTQCzr5cUB8w1/EPona6eanRIuW83S74?=
 =?us-ascii?Q?+l9Ft6KpJA4thUNA/iC+icYrdxNuLUIaZ5N5QxJ8cYPARt4YSAEuqeFzNO7s?=
 =?us-ascii?Q?uyk6EKFW7dV23lTtKcgQDBf9CY+vLtqdtbm33Kds0Xc13k0Sd7WCHiCgZmGu?=
 =?us-ascii?Q?fiRtqhcvbEm3Ksrks39udScqY9FMgwTO6GiJIOog2uMbHfYYF7DAb4L+zJyn?=
 =?us-ascii?Q?kXnY7H/FpXnnOUw6umVq61AMSaRaTtkYOxkDjMAZF1T4vhlLUdg9lQRa3bix?=
 =?us-ascii?Q?YvmlOY+zCC1KH24dZ87I2mEwIQ5bnz4Amglfwib7IccsWzTdmgCB4CB55y5/?=
 =?us-ascii?Q?50KH48WgzLhD4mFrzkZeOTdBzyraLUaeNsGk7OCAP/tPOQwXbFJzwi1FLPvG?=
 =?us-ascii?Q?PgJb+DYZoINuRFHgOySfQQ6HzaNw4Hps0U87EkzjHWvo02TRjtlAlDHEm7Lg?=
 =?us-ascii?Q?moCXT8B8a+eL1PIw5LhVJu86Yb4ILyvqtCYKoK6UFDukIhIvPPZvrogV+Unu?=
 =?us-ascii?Q?wjGmPeWhffe95iAvnjtW7kMl0WqLgOmSuJbWWyEdCHu9OVLHh2BTKZvmChFD?=
 =?us-ascii?Q?0uH5w/2ZXlozXZLCaWR/q82zPl4f/1QB7lO4Nglth2tnpq4fZqKQnQKVYs+1?=
 =?us-ascii?Q?4sbA5+w1be6CwIobt39MpXnh5HCDrPgQzOt+fUhJ3BdH86F4WleSJlSyzKsl?=
 =?us-ascii?Q?5hDv+B/ZkSedB7Eeg5PukfAkqwisvcPQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 11:06:57.3270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b34e8a-8071-4de3-2bee-08dcabd0bc05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5789
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
Changes in v2:
 - Fix the pylint errors
 - Re-order/organize the tests
---
 test/py/tests/test_spi.py | 680 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 680 insertions(+)
 create mode 100644 test/py/tests/test_spi.py

diff --git a/test/py/tests/test_spi.py b/test/py/tests/test_spi.py
new file mode 100644
index 000000000000..4774b4151b4e
--- /dev/null
+++ b/test/py/tests/test_spi.py
@@ -0,0 +1,680 @@
+# SPDX-License-Identifier: GPL-2.0
+# (C) Copyright 2024, Advanced Micro Devices, Inc.
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
+It also relies on configuration values for supported flashes for lock and
+unlock cases for SPI family flash. It will run lock-unlock cases only for the
+supported flash parts.
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
+    'iteration': 5,
+}
+
+env__spi_lock_unlock = {
+    'supported_flash': 'mt25qu512a, n25q00a, n25q512ax3',
+}
+"""
+
+import random
+import re
+import pytest
+import u_boot_utils
+
+SPI_DATA = {}
+EXPECTED_ERASE = 'Erased: OK'
+EXPECTED_WRITE = 'Written: OK'
+EXPECTED_READ = 'Read: OK'
+EXPECTED_ERASE_ERRORS = [
+    'Erase operation failed',
+    'Attempted to modify a protected sector',
+    'Erased: ERROR',
+    'is protected and cannot be erased',
+    'ERROR: flash area is locked',
+]
+EXPECTED_WRITE_ERRORS = [
+    'ERROR: flash area is locked',
+    'Program operation failed',
+    'Attempted to modify a protected sector',
+    'Written: ERROR',
+]
+
+def get_params_spi(u_boot_console):
+    ''' Get SPI device test parameters from boardenv file '''
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
+def spi_find_freq_range(u_boot_console):
+    '''Find out minimum and maximum frequnecies that SPI device can operate'''
+    f = u_boot_console.config.env.get('env__spi_device_test', None)
+    if not f:
+        pytest.skip('No env file to read for SPI family device test')
+
+    min_f = f.get('min_freq', None)
+    max_f = f.get('max_freq', None)
+    iterations = f.get('iteration', 1)
+
+    if not min_f:
+        min_f = 0
+    if not max_f:
+        max_f = 0
+
+    max_f = max(max_f, min_f)
+
+    return min_f, max_f, iterations
+
+def spi_pre_commands(u_boot_console, freq):
+    ''' Find out SPI family flash memory parameters '''
+    bus, cs, mode, part_name, timeout = get_params_spi(u_boot_console)
+
+    output = u_boot_console.run_command(f'sf probe {bus}:{cs} {freq} {mode}')
+    if not 'SF: Detected' in output:
+        pytest.fail('No SPI device available')
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
+        except ValueError:
+            pytest.fail('SPI flash part not recognized')
+
+    global SPI_DATA
+    SPI_DATA = {
+        'page_size': page_size,
+        'erase_size': erase_size,
+        'total_size': total_size,
+        'flash_part': flash_part,
+        'timeout': timeout,
+    }
+
+def get_page_size():
+    ''' Get the SPI page size from spi data '''
+    return SPI_DATA['page_size']
+
+def get_erase_size():
+    ''' Get the SPI erase size from spi data '''
+    return SPI_DATA['erase_size']
+
+def get_total_size():
+    ''' Get the SPI total size from spi data '''
+    return SPI_DATA['total_size']
+
+def get_flash_part():
+    ''' Get the SPI flash part name from spi data '''
+    return SPI_DATA['flash_part']
+
+def get_timeout():
+    ''' Get the SPI timeout from spi data '''
+    return SPI_DATA['timeout']
+
+def spi_erase_block(u_boot_console, erase_size, total_size):
+    ''' Erase SPI flash memory block wise '''
+    for start in range(0, total_size, erase_size):
+        output = u_boot_console.run_command(f'sf erase {hex(start)} {hex(erase_size)}')
+        assert EXPECTED_ERASE in output
+
+@pytest.mark.buildconfigspec('cmd_sf')
+def test_spi_erase_block(u_boot_console):
+    ''' Test case to check SPI erase functionality by erasing memory regions
+    block-wise '''
+
+    min_f, max_f, loop = spi_find_freq_range(u_boot_console)
+    i = 0
+    while i < loop:
+        spi_pre_commands(u_boot_console, random.randint(min_f, max_f))
+        spi_erase_block(u_boot_console, get_erase_size(), get_total_size())
+        i = i + 1
+
+def spi_write_twice(u_boot_console, page_size, erase_size, total_size, timeout):
+    ''' Random write till page size, random till size and full size '''
+    addr = u_boot_utils.find_ram_base(u_boot_console)
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
+        output = u_boot_console.run_command(f'crc32 {hex(addr + total_size)} {hex(size)}')
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
+        with u_boot_console.temporary_timeout(timeout):
+            output = u_boot_console.run_command(
+                f'sf erase {hex(eraseoffset)} {hex(erasesize)}'
+            )
+            assert EXPECTED_ERASE in output
+
+        with u_boot_console.temporary_timeout(timeout):
+            output = u_boot_console.run_command(
+                f'sf write {hex(addr + total_size)} {hex(old_size)} {hex(size)}'
+            )
+            assert EXPECTED_WRITE in output
+        with u_boot_console.temporary_timeout(timeout):
+            output = u_boot_console.run_command(
+                f'sf read {hex(addr + total_size + offset)} {hex(old_size)} {hex(size)}'
+            )
+            assert EXPECTED_READ in output
+        output = u_boot_console.run_command(
+            f'crc32 {hex(addr + total_size + offset)} {hex(size)}'
+        )
+        assert expected_crc32 in output
+        old_size = size
+
+@pytest.mark.buildconfigspec('cmd_bdi')
+@pytest.mark.buildconfigspec('cmd_sf')
+@pytest.mark.buildconfigspec('cmd_memory')
+def test_spi_write_twice(u_boot_console):
+    ''' Test to write data with random size twice for SPI '''
+    min_f, max_f, loop = spi_find_freq_range(u_boot_console)
+    i = 0
+    while i < loop:
+        spi_pre_commands(u_boot_console, random.randint(min_f, max_f))
+        spi_write_twice(
+            u_boot_console,
+            get_page_size(),
+            get_erase_size(),
+            get_total_size(),
+            get_timeout()
+        )
+        i = i + 1
+
+def spi_write_continues(u_boot_console, page_size, erase_size, total_size, timeout):
+    ''' Write with random size of data to continue SPI write case '''
+    spi_erase_block(u_boot_console, erase_size, total_size)
+    addr = u_boot_utils.find_ram_base(u_boot_console)
+
+    output = u_boot_console.run_command(f'crc32 {hex(addr + 0x10000)} {hex(total_size)}')
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
+                f'sf write {hex(addr + 0x10000 + old_size)} {hex(old_size)} {hex(size)}'
+            )
+            assert EXPECTED_WRITE in output
+        old_size += size
+
+    with u_boot_console.temporary_timeout(timeout):
+        output = u_boot_console.run_command(
+            f'sf read {hex(addr + 0x10000 + total_size)} 0 {hex(total_size)}'
+        )
+        assert EXPECTED_READ in output
+
+    output = u_boot_console.run_command(
+        f'crc32 {hex(addr + 0x10000 + total_size)} {hex(total_size)}'
+    )
+    assert expected_crc32 in output
+
+@pytest.mark.buildconfigspec('cmd_bdi')
+@pytest.mark.buildconfigspec('cmd_sf')
+@pytest.mark.buildconfigspec('cmd_memory')
+def test_spi_write_continues(u_boot_console):
+    ''' Test to write more random size data for SPI '''
+    min_f, max_f, loop = spi_find_freq_range(u_boot_console)
+    i = 0
+    while i < loop:
+        spi_pre_commands(u_boot_console, random.randint(min_f, max_f))
+        spi_write_twice(
+            u_boot_console,
+            get_page_size(),
+            get_erase_size(),
+            get_total_size(),
+            get_timeout(),
+        )
+        i = i + 1
+
+def spi_read_twice(u_boot_console, page_size, total_size, timeout):
+    ''' Read the whole SPI flash twice, random_size till full flash size,
+    random till page size '''
+    for size in random.randint(4, page_size), random.randint(4, total_size), total_size:
+        addr = u_boot_utils.find_ram_base(u_boot_console)
+        size = size & ~3
+        with u_boot_console.temporary_timeout(timeout):
+            output = u_boot_console.run_command(
+                f'sf read {hex(addr + total_size)} 0 {hex(size)}'
+            )
+            assert EXPECTED_READ in output
+        output = u_boot_console.run_command(f'crc32 {hex(addr + total_size)} {hex(size)}')
+        m = re.search('==> (.+?)$', output)
+        if not m:
+            pytest.fail('CRC32 failed')
+        expected_crc32 = m.group(1)
+        with u_boot_console.temporary_timeout(timeout):
+            output = u_boot_console.run_command(
+                f'sf read {hex(addr + total_size + 10)} 0 {hex(size)}'
+            )
+            assert EXPECTED_READ in output
+        output = u_boot_console.run_command(
+            f'crc32 {hex(addr + total_size + 10)} {hex(size)}'
+        )
+        assert expected_crc32 in output
+
+@pytest.mark.buildconfigspec('cmd_sf')
+@pytest.mark.buildconfigspec('cmd_bdi')
+@pytest.mark.buildconfigspec('cmd_memory')
+def test_spi_read_twice(u_boot_console):
+    ''' Test to read random data twice from SPI '''
+    min_f, max_f, loop = spi_find_freq_range(u_boot_console)
+    i = 0
+    while i < loop:
+        spi_pre_commands(u_boot_console, random.randint(min_f, max_f))
+        spi_read_twice(u_boot_console, get_page_size(), get_total_size(), get_timeout())
+        i = i + 1
+
+def spi_erase_all(u_boot_console, total_size, timeout):
+    ''' Erase the full chip SPI '''
+    start = 0
+    with u_boot_console.temporary_timeout(timeout):
+        output = u_boot_console.run_command(f'sf erase {start} {hex(total_size)}')
+        assert EXPECTED_ERASE in output
+
+@pytest.mark.buildconfigspec('cmd_sf')
+def test_spi_erase_all(u_boot_console):
+    ''' Test to check full chip erase for SPI '''
+    min_f, max_f, loop = spi_find_freq_range(u_boot_console)
+    i = 0
+    while i < loop:
+        spi_pre_commands(u_boot_console, random.randint(min_f, max_f))
+        spi_erase_all(u_boot_console, get_total_size(), get_timeout())
+        i = i + 1
+
+def flash_ops(
+    u_boot_console, ops, start, size, offset=0, exp_ret=0, exp_str='', not_exp_str=''
+):
+    ''' Flash operations: erase, write and read '''
+
+    f = u_boot_console.config.env.get('env__spi_device_test', None)
+    if not f:
+        timeout = 1000000
+
+    timeout = f.get('timeout', 1000000)
+
+    if ops == 'erase':
+        with u_boot_console.temporary_timeout(timeout):
+            output = u_boot_console.run_command(f'sf erase {hex(start)} {hex(size)}')
+    else:
+        with u_boot_console.temporary_timeout(timeout):
+            output = u_boot_console.run_command(
+                f'sf {ops} {hex(offset)} {hex(start)} {hex(size)}'
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
+def spi_unlock_exit(u_boot_console, addr, size):
+    ''' Unlock the flash before making it fail '''
+    u_boot_console.run_command(f'sf protect unlock {hex(addr)} {hex(size)}')
+    assert False, 'FAIL: Flash lock is unable to protect the data!'
+
+def find_prot_region(lock_addr, lock_size):
+    ''' Get the protected and un-protected region of flash '''
+    total_size = get_total_size()
+    erase_size = get_erase_size()
+
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
+    return prot_start, prot_size, unprot_start, unprot_size
+
+def protect_ops(u_boot_console, lock_addr, lock_size, ops="unlock"):
+    ''' Run the command to lock or Unlock the flash '''
+    u_boot_console.run_command(f'sf protect {ops} {hex(lock_addr)} {hex(lock_size)}')
+    output = u_boot_console.run_command('echo $?')
+    if ops == "lock" and not output.endswith('0'):
+        u_boot_console.run_command(f'sf protect unlock {hex(lock_addr)} {hex(lock_size)}')
+        assert False, "sf protect lock command exits with non-zero return code"
+    assert output.endswith('0')
+
+def erase_write_ops(u_boot_console, start, size):
+    ''' Basic erase and write operation for flash '''
+    addr = u_boot_utils.find_ram_base(u_boot_console)
+    flash_ops(u_boot_console, 'erase', start, size, 0, 0, EXPECTED_ERASE)
+    flash_ops(u_boot_console, 'write', start, size, addr, 0, EXPECTED_WRITE)
+
+def spi_lock_unlock(u_boot_console, lock_addr, lock_size):
+    ''' Lock unlock operations for SPI family flash '''
+    addr = u_boot_utils.find_ram_base(u_boot_console)
+    erase_size = get_erase_size()
+
+    # Find the protected/un-protected region
+    prot_start, prot_size, unprot_start, unprot_size = find_prot_region(lock_addr, lock_size)
+
+    # Check erase/write operation before locking
+    erase_write_ops(u_boot_console, prot_start, prot_size)
+
+    # Locking the flash
+    protect_ops(u_boot_console, lock_addr, lock_size, 'lock')
+
+    # Check erase/write operation after locking
+    output, ret_code = flash_ops(u_boot_console, 'erase', prot_start, prot_size, 0, -1)
+    if not any(error in output for error in EXPECTED_ERASE_ERRORS) or ret_code.endswith(
+        '0'
+    ):
+        spi_unlock_exit(u_boot_console, lock_addr, lock_size)
+
+    output, ret_code = flash_ops(
+        u_boot_console, 'write', prot_start, prot_size, addr, -1
+    )
+    if not any(error in output for error in EXPECTED_WRITE_ERRORS) or ret_code.endswith(
+        '0'
+    ):
+        spi_unlock_exit(u_boot_console, lock_addr, lock_size)
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
+    if not any(error in output for error in EXPECTED_ERASE_ERRORS) or ret_code.endswith(
+        '0'
+    ):
+        spi_unlock_exit(u_boot_console, lock_addr, lock_size)
+
+    output, ret_code = flash_ops(
+        u_boot_console, 'write', sect_lock_start, sect_write_size, addr, -1
+    )
+    if not any(error in output for error in EXPECTED_WRITE_ERRORS) or ret_code.endswith(
+        '0'
+    ):
+        spi_unlock_exit(u_boot_console, lock_addr, lock_size)
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
+        if EXPECTED_ERASE not in output or ret_code.endswith('1'):
+            spi_unlock_exit(u_boot_console, lock_addr, lock_size)
+
+        output, ret_code = flash_ops(
+            u_boot_console, 'write', sect_unlock_start, sect_write_size, addr, -1
+        )
+        if EXPECTED_WRITE not in output or ret_code.endswith('1'):
+            spi_unlock_exit(u_boot_console, lock_addr, lock_size)
+
+    # Unlocking the flash
+    protect_ops(u_boot_console, lock_addr, lock_size, 'unlock')
+
+    # Check erase/write operation after un-locking
+    erase_write_ops(u_boot_console, prot_start, prot_size)
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
+        u_boot_console, 'erase', sect_lock_start, sect_lock_size, 0, 0, EXPECTED_ERASE
+    )
+    flash_ops(
+        u_boot_console,
+        'write',
+        sect_lock_start,
+        sect_write_size,
+        addr,
+        0,
+        EXPECTED_WRITE,
+    )
+
+@pytest.mark.buildconfigspec('cmd_bdi')
+@pytest.mark.buildconfigspec('cmd_sf')
+@pytest.mark.buildconfigspec('cmd_memory')
+def test_spi_lock_unlock(u_boot_console):
+    ''' Test to check the lock-unlock functionality for SPI family flash '''
+    min_f, max_f, loop = spi_find_freq_range(u_boot_console)
+    flashes = u_boot_console.config.env.get('env__spi_lock_unlock', False)
+    if not flashes:
+        pytest.skip('No supported flash list for lock/unlock provided')
+
+    i = 0
+    while i < loop:
+        spi_pre_commands(u_boot_console, random.randint(min_f, max_f))
+        total_size = get_total_size()
+        flash_part = get_flash_part()
+
+        flashes_list = flashes.get('supported_flash', None).split(',')
+        flashes_list = [x.strip() for x in flashes_list]
+        if flash_part not in flashes_list:
+            pytest.skip('Detected flash does not support lock/unlock')
+
+        # For lower half of memory
+        lock_addr = random.randint(0, (total_size // 2) - 1)
+        lock_size = random.randint(1, ((total_size // 2) - lock_addr))
+        spi_lock_unlock(u_boot_console, lock_addr, lock_size)
+
+        # For upper half of memory
+        lock_addr = random.randint((total_size // 2), total_size - 1)
+        lock_size = random.randint(1, (total_size - lock_addr))
+        spi_lock_unlock(u_boot_console, lock_addr, lock_size)
+
+        # For entire flash
+        lock_addr = random.randint(0, total_size - 1)
+        lock_size = random.randint(1, (total_size - lock_addr))
+        spi_lock_unlock(u_boot_console, lock_addr, lock_size)
+
+        i = i + 1
+
+@pytest.mark.buildconfigspec('cmd_bdi')
+@pytest.mark.buildconfigspec('cmd_sf')
+@pytest.mark.buildconfigspec('cmd_memory')
+def test_spi_negative(u_boot_console):
+    ''' Negative tests for SPI '''
+    min_f, max_f, loop = spi_find_freq_range(u_boot_console)
+    spi_pre_commands(u_boot_console, random.randint(min_f, max_f))
+    total_size = get_total_size()
+    erase_size = get_erase_size()
+    page_size = get_page_size()
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
+            u_boot_console, 'erase', start, esize, 0, 1, error_msg, EXPECTED_ERASE
+        )
+
+        # If eraseoffset exceeds beyond flash size
+        eoffset = random.randint(total_size, (total_size + int(0x1000000)))
+        error_msg = 'Offset exceeds device limit'
+        flash_ops(
+            u_boot_console, 'erase', eoffset, esize, 0, 1, error_msg, EXPECTED_ERASE
+        )
+
+        # If erasesize exceeds beyond flash size
+        esize = random.randint((total_size - start), (total_size + int(0x1000000)))
+        error_msg = 'ERROR: attempting erase past flash size'
+        flash_ops(
+            u_boot_console, 'erase', start, esize, 0, 1, error_msg, EXPECTED_ERASE
+        )
+
+        # If erase size is 0
+        esize = 0
+        error_msg = 'ERROR: Invalid size 0'
+        flash_ops(
+            u_boot_console, 'erase', start, esize, 0, 1, error_msg, EXPECTED_ERASE
+        )
+
+        # If erasesize is less than flash's page size
+        esize = random.randint(0, page_size)
+        start = random.randint(0, (total_size - page_size))
+        error_msg = 'Erased: ERROR'
+        flash_ops(
+            u_boot_console, 'erase', start, esize, 0, 1, error_msg, EXPECTED_ERASE
+        )
+
+        # Write/Read negative test
+        # if Write/Read size exceeds beyond flash size
+        offset = random.randint(0, total_size)
+        size = random.randint((total_size - offset), (total_size + int(0x1000000)))
+        error_msg = 'Size exceeds partition or device limit'
+        flash_ops(
+            u_boot_console, 'write', offset, size, addr, 1, error_msg, EXPECTED_WRITE
+        )
+        flash_ops(
+            u_boot_console, 'read', offset, size, addr, 1, error_msg, EXPECTED_READ
+        )
+
+        # if Write/Read offset exceeds beyond flash size
+        offset = random.randint(total_size, (total_size + int(0x1000000)))
+        size = random.randint(0, total_size)
+        error_msg = 'Offset exceeds device limit'
+        flash_ops(
+            u_boot_console, 'write', offset, size, addr, 1, error_msg, EXPECTED_WRITE
+        )
+        flash_ops(
+            u_boot_console, 'read', offset, size, addr, 1, error_msg, EXPECTED_READ
+        )
+
+        # if Write/Read size is 0
+        offset = random.randint(0, 2)
+        size = 0
+        error_msg = 'ERROR: Invalid size 0'
+        flash_ops(
+            u_boot_console, 'write', offset, size, addr, 1, error_msg, EXPECTED_WRITE
+        )
+        flash_ops(
+            u_boot_console, 'read', offset, size, addr, 1, error_msg, EXPECTED_READ
+        )
+
+        i = i + 1
-- 
2.25.1

