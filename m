Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDB1CD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 07:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5378484671;
	Tue, 26 May 2026 09:38:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v1kK+t/I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1D64846A5; Tue, 26 May 2026 09:38:05 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7469383EF9
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:38:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnradANtK0WNXBglzv9luSKtaULSVYzRozdTJwHshKn4OkQLTovqiUzilTsYhEiSZGOQps0GMsp4BmX/ZwBJKQGk71kiC7G+iPMrj2wgt5Y11DKc28U/do7GjTjLSli2XCaegJ6LHcgMd4ipJxsmY9gZY3IVPsZaNm12cRQTvMjapjHJ9YFHG58kxNiMpta6YQ2cbVuzvwWhXilwo8Is4Te5iEAuVtsYorOJITylLAhcdYYe+ZRYsM95eWceBX1AXJLSWyvclK86Ufn64bmv/xwigdIHaunGNdCR4AYXZE+f5KU4KxRKfViSpAEH2ggH7sxTZrG5/DfRI+SuJq1+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K55wDBH23itdaidQl0Pl1s7jToi3DGZH+gwWLwQO/Hc=;
 b=iYsFCgUk0qKDACO3FgdQobtu764G+tElE7hHmdWCCdW8aBf4PClu7msrHJoB2CwyIdpqouw4YBKFoKDWiX6A1GuqwzeO/jVWW3QCGv+Um82FpdE3HCDcNZsksQs4fp0glcQGqq5u2m8MNx/DEUfs8okiM4Mzo0rDTSgbNI6jt6wnxuupzwYsddyQdqnKzaOeSTMpNYrr/Pvxsy7GwAYI1rCbCZqw+k0zvtgCHe3QKQ96vfX30fvoE5ZOI2Ag1WMR+nyR66DGNwlhmHTquvivsTAhQOU0jC+/K75wz4uZ1xcKNTkj9V+DavivO1g+lKhxgK/DRrv9GDd9Kwb8egeLWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K55wDBH23itdaidQl0Pl1s7jToi3DGZH+gwWLwQO/Hc=;
 b=v1kK+t/Ih28rhWyr+FqdruShfYMTfpTNUMHb39NASwBBUqW+sqCNgg+d5din5o1H6SrUISeT9lYGqOMuefqDRB7RqubFMpb+DX54lzKXWiXzONwX+piDCo8fy+Xz66WCsp763KONTYlhfPS04Z6hp5OaxKBrUCG+ovGohBAtx5c=
Received: from DS1PR03CA0004.namprd03.prod.outlook.com (2603:10b6:8:450::12)
 by MW4PR12MB7439.namprd12.prod.outlook.com (2603:10b6:303:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 07:37:54 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:8:450:cafe::8e) by DS1PR03CA0004.outlook.office365.com
 (2603:10b6:8:450::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:37:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:37:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 26 May
 2026 02:37:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 May
 2026 02:37:51 -0500
Received: from xhdsswai40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:37:50 -0500
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>, <trini@konsulko.com>,
 <sjg@chromium.org>
Subject: [PATCH] test/py: mtd: Add tests for mtd command
Date: Tue, 26 May 2026 13:07:49 +0530
Message-ID: <20260526073749.89059-1-love.kumar@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: love.kumar@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|MW4PR12MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: dd1c2cb7-d8b5-4b1a-7f35-08debaf9b28d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|5023799004|6133799003|11063799006|3023799007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: aT5S4wToydhZmbdYb/qL3Ta/tho9NNdqAJT6Be4yAFObHOt+iR4i8HuwYFsnNOkWkpwVs+JkHSaDAFWPEHUqydBa5Hvu9dGxDNtIXyhxeqSmGhKNgRQCoAr6Y1pBPkOiY5QUB6a2zGf2qUaMRR6uUKw2mv5T6ySbmmwKU6vZmoaZ812OIraF7xdmICmCwCOZiM8G8jE4GXwxLHlR/swmushQU0Ar2Cmu+KzW4Jtz5m3CnAdLgNQ7xS/zoS3biNQ0O1l2xzABUjdC8hQZ7s9FH2u1cXxau8FczOsYHi2jk6Du2KrToBGNxHe+9p5TPIvOiYNeYIxzRmPo7g1F6DUdUG0QVhPItXUk9xNu9nsKKuDDYbSorQC9Wy3odSb+5RDxoKhO8m1Z03i7UnjZaLO3nxScqUsr35TPDKr9ihARuLUym+P/riATmEvzLXyd1Pep7j1Us2t69XliGMAVhbq/IFN9HhRS0BYBEqE7LkJ/ecmCszo4cRnalnktqX7qUJReik1kBCW3EJIqSveuKY7bqgyte3rvy6mDyX884a51UbmHucdu0bi78W2pAgY6cLBbKJJNJ7sTcyIPAxpPaD08nUIABc8ajQuPN9442agbW0tCWtyqLc7zhXT8hn0LInqdmDInQ3LpfJMKfz/nli1RZKL10jJx+/E4+2pJ4mSMm88DPOc6IjPJwbirFhNl3tX2Wt9U9H06yfQupZwUlXBOOBc9gfPzELLvt6bRDexbD1w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(5023799004)(6133799003)(11063799006)(3023799007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KFhFCyR+SRVYEydAp5hFM3bMzXLokCdoZLpHIk+as7ZnARskbup5F16PKNwo5mwwPekRDfmPdOWSNJ3pYNYgtBTaAYMtPPsLmtYaDiXdOSdYEhvkItDj9hSCM7upMks2ceOe9zNY6brLv/eqIt+YT85qcyY2AWJK7rjbjNt555NXoLTg+bRMVlydlPlbqPdkl3CAxVwZkf+RAZ4RYnb2cO1MhDJ18kWV71/y2E3hGwSawVnVRVce9e9QcCHmsGdk3/nYIIurPi6/6JQYuJlOaTxU3VPX2idEiETPv2N9ahC86o48xepV5sr0sORSSOONEm4pnUE9xL/JeYIgBn/ydHBcre8aGOJqhGfSUMis+++MfqG5cyhA49ndBbVlpPLdqnIEz2J2ZG7XZtl4wdEUb1BgSp2xpyRAB1njxxUbZb8K4KNupU2UB+jXR1Ap7Ngy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:37:53.7551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1c2cb7-d8b5-4b1a-7f35-08debaf9b28d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7439
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

Add test cases for mtd commands to verify list, erase, write, read
and dump operations on NOR flash and binary-file data integrity.
This test relies on boardenv_* configurations to run it for single or
multiple MTD partitions.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 doc/develop/pytest/test_mtd.rst |  10 +
 test/py/tests/test_mtd.py       | 648 ++++++++++++++++++++++++++++++++
 2 files changed, 658 insertions(+)
 create mode 100644 doc/develop/pytest/test_mtd.rst
 create mode 100644 test/py/tests/test_mtd.py

diff --git a/doc/develop/pytest/test_mtd.rst b/doc/develop/pytest/test_mtd.rst
new file mode 100644
index 000000000000..70d469af5caa
--- /dev/null
+++ b/doc/develop/pytest/test_mtd.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+test_mtd
+========
+
+.. automodule:: test_mtd
+   :synopsis:
+   :member-order: bysource
+   :members:
+   :undoc-members:
diff --git a/test/py/tests/test_mtd.py b/test/py/tests/test_mtd.py
new file mode 100644
index 000000000000..947eba7426c6
--- /dev/null
+++ b/test/py/tests/test_mtd.py
@@ -0,0 +1,648 @@
+# SPDX-License-Identifier: GPL-2.0
+# (C) Copyright 2026, Advanced Micro Devices, Inc.
+
+"""
+Note: This test relies on boardenv_* containing configuration values to
+define one or more MTD partitions on which to exercise the 'mtd' U-Boot
+command. The test reads env__mtd_partitions itself and loops over every
+entry. Without this configuration the test is automatically skipped.
+
+It exercises the 'mtd' subcommands (list, erase, write, read, dump) and
+a binary-file data integrity round-trip (tftp + write + read + cmp.b).
+The suite works for single and stacked flash configurations. Partitions
+whose detected MTD type is not 'NOR flash' are logged and skipped
+per-partition.
+
+For Example:
+
+# List of MTD partitions to test. partition_name is the MTD partition
+# name passed to every 'mtd' subcommand; flash_part_name is optional
+# and, when set, is verified against 'SF: Detected <name>' lines in
+# 'mtd list' output.
+#
+# partition_name      - MTD partition name (required)
+# flash_part_name     - expected flash chip name (optional)
+# expected_size       - partition size in bytes (optional cross-check)
+# expected_erasesize  - erase-block size in bytes (optional cross-check)
+# writeable           - bool; if False only non-destructive tests run
+# timeout             - per-partition command timeout for long ops
+env__mtd_partitions = [
+    {
+        'partition_name': 'qspi-fsbl-uboot',
+        'flash_part_name': 'mt25qu512a',
+        'expected_size': 0x1000000,
+        'expected_erasesize': 0x10000,
+        'writeable': True,
+    },
+    {
+        'partition_name': 'rootfs_b',
+        'flash_part_name': 'mt25qu512a',
+        'expected_size': 0x1000000,
+        'writeable': True,
+    },
+    {
+        'partition_name': 'rootfs_a-rootfs_c-concat',
+        'flash_part_name': 'mt25qu512a',
+        'expected_size': 0x6000000,
+        'writeable': True,
+    },
+]
+
+# Binary-file data integrity test configuration. When set,
+# test_mtd_bin_integrity fetches the file over TFTP once, then writes
+# it to every writeable partition large enough to hold it and verifies
+# byte-for-byte equality via 'cmp.b'. When unset, that test is skipped.
+#
+# bin_file      - TFTP filename of the binary blob
+# bin_size      - byte size of the binary blob
+# tftp_addr     - RAM address used as the TFTP destination and source
+#                 for 'mtd write'
+# readback_addr - RAM address used to read the data back from flash
+env__mtd_bin_test = {
+    'bin_file': 'BOOT_SINGLE.BIN',
+    'tftp_addr': 0x200000,
+    'bin_size': 0x1E3300,
+    'readback_addr': 0x5000000,
+}
+
+# Optional. If omitted, tests use the defaults shown below.
+#   iteration       - randomized iteration count per test (default 3)
+#   default_timeout - default per-command timeout in milliseconds
+#                     (default 1000000)
+env__mtd_test_settings = {
+    'iteration': 3,
+    'default_timeout': 1000000,
+}
+"""
+
+import random
+import re
+import pytest
+import test_net
+import utils
+
+MTD_LIST_HEADER = 'List of MTD devices:'
+SF_DETECTED = 'SF: Detected'
+SUPPORTED_TYPE = 'NOR flash'
+EXPECTED_ERASE = 'eraseblock(s)'
+EXPECTED_WRITE = 'Writing'
+WRITE_FAILURE = 'Failure while writing'
+EXPECTED_READ = 'Reading'
+READ_FAILURE = 'Failure while reading'
+EXPECTED_DUMP = 'Dump'
+EXPECTED_COMPARE = 'were the same'
+TFTP_DONE = 'Bytes transferred = '
+
+DEFAULT_TIMEOUT = 1000000
+DEFAULT_ITERATION = 3
+
+def parse_mtd_list(output):
+    """Parse 'mtd list' output into a dict keyed by device name.
+
+    Each value has 'type', 'block_size', 'min_io' and a 'partitions'
+    dict mapping name -> (start, end) for the device-level span and
+    any nested partition lines.
+    """
+    devices = {}
+    current = None
+    for line in output.splitlines():
+        match = re.match(r'^\* (\S+)\s*$', line)
+        if match:
+            current = match.group(1)
+            devices[current] = {
+                'type': None,
+                'block_size': 0,
+                'min_io': 0,
+                'partitions': {},
+            }
+            continue
+        if current is None:
+            continue
+        match = re.match(r'^\s*- type: (.+?)\s*$', line)
+        if match:
+            devices[current]['type'] = match.group(1)
+            continue
+        match = re.match(r'^\s*- block size: (0x[0-9a-f]+) bytes\s*$', line)
+        if match:
+            devices[current]['block_size'] = int(match.group(1), 16)
+            continue
+        match = re.match(r'^\s*- min I/O: (0x[0-9a-f]+) bytes\s*$', line)
+        if match:
+            devices[current]['min_io'] = int(match.group(1), 16)
+            continue
+        match = re.search(r'0x([0-9a-f]+)-0x([0-9a-f]+) : "([^"]+)"', line)
+        if match:
+            start = int(match.group(1), 16)
+            end = int(match.group(2), 16)
+            name = match.group(3)
+            devices[current]['partitions'][name] = (start, end)
+    return devices
+
+def parse_flash_parts(output):
+    """Return the list of flash names from 'SF: Detected <name>' lines."""
+    return re.findall(rf'{SF_DETECTED} (\S+) with', output)
+
+def find_part_info(parsed, partition_name):
+    """Look up a partition across all parsed devices.
+
+    Returns (dev_info, start, end) or (None, None, None) if not found.
+    """
+    for dev_info in parsed.values():
+        if partition_name in dev_info['partitions']:
+            start, end = dev_info['partitions'][partition_name]
+            return dev_info, start, end
+    return None, None, None
+
+def get_iterations(ubman):
+    """Per-test iteration count from env__mtd_test_settings (default 3)."""
+    settings = ubman.config.env.get('env__mtd_test_settings', {})
+    return settings.get('iteration', DEFAULT_ITERATION)
+
+def get_default_timeout(ubman):
+    """Default command timeout in ms from env__mtd_test_settings.
+
+    Defaults to DEFAULT_TIMEOUT (1000000) if unset.
+    """
+    settings = ubman.config.env.get('env__mtd_test_settings', {})
+    return settings.get('default_timeout', DEFAULT_TIMEOUT)
+
+def mtd_prepare(ubman, config):
+    """Probe an MTD partition and return a parameter dict.
+
+    Returns None (after logging via ubman.log.info) if the partition
+    is not present or its detected type is not 'NOR flash'. A missing
+    partition_name in the config triggers pytest.fail.
+    """
+    partition_name = config.get('partition_name')
+    if not partition_name:
+        pytest.fail(
+            "env__mtd_partitions entry missing required key "
+            "'partition_name'"
+        )
+
+    output = do_list(ubman)
+    parsed = parse_mtd_list(output)
+    if not parsed:
+        pytest.fail(f'mtd list returned no devices; output was:\n{output}')
+
+    dev_info, start, end = find_part_info(parsed, partition_name)
+    if dev_info is None:
+        ubman.log.info(f'skip {partition_name!r}: not present in mtd list')
+        return None
+
+    mtd_type = dev_info['type']
+    if mtd_type != SUPPORTED_TYPE:
+        ubman.log.info(
+            f'skip {partition_name!r}: type {mtd_type!r} unsupported '
+            f'(only {SUPPORTED_TYPE!r} is supported)'
+        )
+        return None
+
+    size = end - start
+    erasesize = dev_info['block_size']
+    writesize = dev_info['min_io']
+    if erasesize == 0 or writesize == 0:
+        pytest.fail(
+            f'mtd list reported invalid geometry for {partition_name!r}: '
+            f'erasesize={erasesize:#x} writesize={writesize:#x}'
+        )
+
+    expected_size = config.get('expected_size')
+    if expected_size and expected_size != size:
+        pytest.fail(
+            f'Size mismatch for {partition_name!r}: expected '
+            f'{expected_size:#x}, got {size:#x}'
+        )
+    expected_erasesize = config.get('expected_erasesize')
+    if expected_erasesize and expected_erasesize != erasesize:
+        pytest.fail(
+            f'Erase size mismatch for {partition_name!r}: expected '
+            f'{expected_erasesize:#x}, got {erasesize:#x}'
+        )
+
+    return {
+        'name': partition_name,
+        'size': size,
+        'start': start,
+        'erasesize': erasesize,
+        'writesize': writesize,
+        'type': mtd_type,
+        'ram_base': utils.find_ram_base(ubman),
+        'timeout': config.get('timeout', get_default_timeout(ubman)),
+        'writeable': config.get('writeable', False),
+        'flash_part_name': config.get('flash_part_name'),
+    }
+
+def rand_aligned_offset(size, align):
+    """Random offset that is a multiple of 'align' inside [0, size-align]."""
+    if size <= align:
+        return 0
+    return random.randrange(0, size - align + 1, align)
+
+def rand_aligned_range(part, kind):
+    """Random aligned (offset, length) inside the partition.
+
+    kind is 'erase' (erase-block aligned) or 'io' (page aligned). The
+    caller must have verified the partition holds at least one unit.
+    """
+    if kind == 'erase':
+        align = part['erasesize']
+    elif kind == 'io':
+        align = max(part['writesize'], 1)
+    else:
+        raise ValueError(f'Unknown alignment kind: {kind!r}')
+
+    size = part['size']
+    off = rand_aligned_offset(size, align)
+    remaining = size - off
+    if remaining <= align:
+        length = align
+    else:
+        length = random.randrange(align, remaining + 1, align)
+    return off, length
+
+def run_op(ubman, part, cmd, exp_str=None, not_exp_str=None, exp_rc=0):
+    """Run a U-Boot command and check its output and return code.
+
+    exp_str / not_exp_str (when not None) must / must not appear in the
+    output. exp_rc is the expected echo $? value; pass -1 to skip the
+    rc check. 'part' provides the timeout; pass None to use the default.
+    Returns (output, rc_string).
+    """
+    timeout = part['timeout'] if part else DEFAULT_TIMEOUT
+    with ubman.temporary_timeout(timeout):
+        output = ubman.run_command(cmd)
+    if exp_str is not None:
+        assert exp_str in output, (
+            f'Expected {exp_str!r} in output of {cmd!r}, got:\n{output}'
+        )
+    if not_exp_str is not None:
+        assert not_exp_str not in output, (
+            f'Unexpected {not_exp_str!r} in output of {cmd!r}'
+        )
+    rc_str = ubman.run_command('echo $?')
+    if exp_rc >= 0:
+        assert rc_str.endswith(str(exp_rc)), (
+            f'Expected rc {exp_rc} for {cmd!r}, got {rc_str!r}'
+        )
+    return output, rc_str
+
+def do_list(ubman):
+    """Run 'mtd list' and return the raw output."""
+    timeout = get_default_timeout(ubman)
+    with ubman.temporary_timeout(timeout):
+        output = ubman.run_command('mtd list')
+    assert MTD_LIST_HEADER in output, (
+        f'Expected {MTD_LIST_HEADER!r} in mtd list output, got:\n{output}'
+    )
+    return output
+
+def do_erase(ubman, part, off, size, exp_rc=0):
+    """Run 'mtd erase <name> <off> <size>'. off/size must be aligned."""
+    cmd = f'mtd erase {part["name"]} {off:#x} {size:#x}'
+    exp = EXPECTED_ERASE if exp_rc == 0 else None
+    return run_op(ubman, part, cmd, exp_str=exp, exp_rc=exp_rc)
+
+def do_write(ubman, part, addr, off, size, exp_rc=0):
+    """Run 'mtd write <name> <addr> <off> <size>'."""
+    cmd = f'mtd write {part["name"]} {addr:#x} {off:#x} {size:#x}'
+    exp = EXPECTED_WRITE if exp_rc == 0 else None
+    not_exp = WRITE_FAILURE if exp_rc == 0 else None
+    return run_op(
+        ubman, part, cmd, exp_str=exp, not_exp_str=not_exp, exp_rc=exp_rc,
+    )
+
+def do_read(ubman, part, addr, off, size, exp_rc=0):
+    """Run 'mtd read <name> <addr> <off> <size>'."""
+    cmd = f'mtd read {part["name"]} {addr:#x} {off:#x} {size:#x}'
+    exp = EXPECTED_READ if exp_rc == 0 else None
+    not_exp = READ_FAILURE if exp_rc == 0 else None
+    return run_op(
+        ubman, part, cmd, exp_str=exp, not_exp_str=not_exp, exp_rc=exp_rc,
+    )
+
+def do_dump(ubman, part, off=None, size=None):
+    """Run 'mtd dump' and verify a hex dump line is produced."""
+    cmd = f'mtd dump {part["name"]}'
+    if off is not None:
+        cmd += f' {off:#x}'
+        if size is not None:
+            cmd += f' {size:#x}'
+    output, _ = run_op(ubman, part, cmd, exp_str=EXPECTED_DUMP)
+    assert re.search(
+        r'0x[0-9a-f]{8}:\s+(?:[0-9a-f]{2}\s+){8,}', output
+    ), (
+        f'Expected hex dump line, got:\n{output}'
+    )
+    return output
+
+def round_trip_verify(ubman, part, off, size, pattern=None):
+    """Erase, write a RAM pattern, read it back, and CRC-compare.
+
+    The source pattern goes to part['ram_base'] and the readback area
+    is part['ram_base'] + part['size'] so the two never overlap. Both
+    off and size must be erase-block aligned. Returns the source CRC.
+    """
+    src = part['ram_base']
+    dst = part['ram_base'] + part['size']
+    if pattern is None:
+        pattern = random.randint(1, 0xfe)
+    ubman.run_command(f'mw.b {src:#x} {pattern:#x} {size:#x}')
+    src_crc = utils.crc32(ubman, src, size)
+    do_erase(ubman, part, off, size)
+    do_write(ubman, part, src, off, size)
+    do_read(ubman, part, dst, off, size)
+    dst_crc = utils.crc32(ubman, dst, size)
+    assert src_crc == dst_crc, (
+        f'CRC mismatch after round-trip on {part["name"]!r}: '
+        f'src={src_crc} dst={dst_crc} off={off:#x} size={size:#x}'
+    )
+    return src_crc
+
+def setup_network(ubman):
+    """Bring up the network (try DHCP, fall back to static), or skip."""
+    test_net.test_net_dhcp(ubman)
+    if not test_net.net_set_up:
+        test_net.test_net_setup_static(ubman)
+    if not test_net.net_set_up:
+        pytest.skip('Network setup failed; cannot fetch binary file')
+
+def get_configs(ubman):
+    """Return env__mtd_partitions or skip the test if not configured."""
+    configs = ubman.config.env.get('env__mtd_partitions', None)
+    if not configs:
+        pytest.skip('No MTD partitions configured')
+    return configs
+
+@pytest.mark.buildconfigspec('cmd_mtd')
+def test_mtd_list(ubman):
+    """Verify 'mtd list' shows every partition and expected flash part."""
+    configs = get_configs(ubman)
+    output = do_list(ubman)
+    parsed = parse_mtd_list(output)
+    detected_flash = parse_flash_parts(output)
+
+    for config in configs:
+        partition_name = config.get('partition_name')
+        if not partition_name:
+            pytest.fail(
+                "env__mtd_partitions entry missing 'partition_name'"
+            )
+        dev_info, start, end = find_part_info(parsed, partition_name)
+        assert dev_info is not None, (
+            f'Partition {partition_name!r} not in mtd list output:\n'
+            f'{output}'
+        )
+        expected_erasesize = config.get('expected_erasesize')
+        if expected_erasesize:
+            assert dev_info['block_size'] == expected_erasesize, (
+                f'Erase size mismatch for {partition_name!r}: '
+                f'expected {expected_erasesize:#x}, got '
+                f'{dev_info["block_size"]:#x}'
+            )
+        expected_size = config.get('expected_size')
+        if expected_size:
+            assert (end - start) == expected_size, (
+                f'Size mismatch for {partition_name!r}: expected '
+                f'{expected_size:#x}, got {end - start:#x}'
+            )
+        flash_part_name = config.get('flash_part_name')
+        if flash_part_name:
+            assert flash_part_name in detected_flash, (
+                f'Expected flash part {flash_part_name!r} not found '
+                f'in SF: Detected lines: {detected_flash}'
+            )
+
+@pytest.mark.buildconfigspec('cmd_mtd')
+@pytest.mark.buildconfigspec('cmd_bdi')
+def test_mtd_erase_block(ubman):
+    """Erase random aligned ranges in every writeable partition."""
+    configs = get_configs(ubman)
+    ran_any = False
+    for config in configs:
+        part = mtd_prepare(ubman, config)
+        if part is None:
+            continue
+        if not part['writeable']:
+            ubman.log.info(f'skip {part["name"]!r}: not marked writeable')
+            continue
+        if part['size'] < part['erasesize']:
+            ubman.log.info(
+                f'skip {part["name"]!r}: smaller than one erase block'
+            )
+            continue
+        for _ in range(get_iterations(ubman)):
+            off, size = rand_aligned_range(part, 'erase')
+            do_erase(ubman, part, off, size)
+        ran_any = True
+    if not ran_any:
+        pytest.skip('No writeable partition large enough for this test')
+
+@pytest.mark.buildconfigspec('cmd_mtd')
+def test_mtd_erase_all(ubman):
+    """Erase every writeable partition in full."""
+    configs = get_configs(ubman)
+    ran_any = False
+    for config in configs:
+        part = mtd_prepare(ubman, config)
+        if part is None:
+            continue
+        if not part['writeable']:
+            ubman.log.info(f'skip {part["name"]!r}: not marked writeable')
+            continue
+        if part['size'] < part['erasesize']:
+            ubman.log.info(
+                f'skip {part["name"]!r}: smaller than one erase block'
+            )
+            continue
+        # Round down to whole erase blocks: partition size is not
+        # guaranteed to be a multiple of the erase block.
+        full = (part['size'] // part['erasesize']) * part['erasesize']
+        for _ in range(get_iterations(ubman)):
+            do_erase(ubman, part, 0, full)
+        ran_any = True
+    if not ran_any:
+        pytest.skip('No writeable partition large enough for this test')
+
+@pytest.mark.buildconfigspec('cmd_mtd')
+@pytest.mark.buildconfigspec('cmd_bdi')
+@pytest.mark.buildconfigspec('cmd_memory')
+@pytest.mark.buildconfigspec('cmd_crc32')
+def test_mtd_write_read_random(ubman):
+    """Round-trip a random pattern at random aligned ranges."""
+    configs = get_configs(ubman)
+    ran_any = False
+    for config in configs:
+        part = mtd_prepare(ubman, config)
+        if part is None:
+            continue
+        if not part['writeable']:
+            ubman.log.info(f'skip {part["name"]!r}: not marked writeable')
+            continue
+        if part['size'] < part['erasesize']:
+            ubman.log.info(
+                f'skip {part["name"]!r}: smaller than one erase block'
+            )
+            continue
+        for _ in range(get_iterations(ubman)):
+            off, size = rand_aligned_range(part, 'erase')
+            round_trip_verify(ubman, part, off, size)
+        ran_any = True
+    if not ran_any:
+        pytest.skip('No writeable partition large enough for this test')
+
+@pytest.mark.buildconfigspec('cmd_mtd')
+@pytest.mark.buildconfigspec('cmd_bdi')
+@pytest.mark.buildconfigspec('cmd_memory')
+@pytest.mark.buildconfigspec('cmd_crc32')
+def test_mtd_write_twice(ubman):
+    """Round-trip small, medium, full, and a partition-midpoint write."""
+    configs = get_configs(ubman)
+    ran_any = False
+    for config in configs:
+        part = mtd_prepare(ubman, config)
+        if part is None:
+            continue
+        if not part['writeable']:
+            ubman.log.info(f'skip {part["name"]!r}: not marked writeable')
+            continue
+        if part['size'] < part['erasesize']:
+            ubman.log.info(
+                f'skip {part["name"]!r}: smaller than one erase block'
+            )
+            continue
+        erasesize = part['erasesize']
+        full = (part['size'] // erasesize) * erasesize
+        mid_upper = max(erasesize + 1, full // 2)
+        sizes = [
+            erasesize,
+            random.randrange(erasesize, mid_upper + 1, erasesize),
+            full,
+        ]
+        for chunk in sizes:
+            round_trip_verify(ubman, part, 0, chunk)
+
+        # Write a short region centred on the partition midpoint. For
+        # concat partitions this straddles the inner boundary.
+        op_size = min(erasesize * 4, full)
+        op_size = (op_size // erasesize) * erasesize
+        half = (op_size // 2 // erasesize) * erasesize
+        if half == 0:
+            half = erasesize
+        midpoint = (full // 2 // erasesize) * erasesize
+        straddle_off = max(midpoint - half, 0)
+        if op_size >= erasesize and straddle_off + op_size <= full:
+            round_trip_verify(ubman, part, straddle_off, op_size)
+        ran_any = True
+    if not ran_any:
+        pytest.skip('No writeable partition large enough for this test')
+
+@pytest.mark.buildconfigspec('cmd_mtd')
+def test_mtd_dump(ubman):
+    """Verify 'mtd dump' produces a hex dump (default + explicit size)."""
+    configs = get_configs(ubman)
+    ran_any = False
+    for config in configs:
+        part = mtd_prepare(ubman, config)
+        if part is None:
+            continue
+        align = max(part['writesize'], 1)
+        units_total = part['size'] // align
+        if units_total == 0:
+            ubman.log.info(
+                f'skip {part["name"]!r}: smaller than one I/O unit'
+            )
+            continue
+
+        # Default-size dump: writesize bytes from a random aligned
+        # offset.
+        off = rand_aligned_offset(part['size'], align)
+        do_dump(ubman, part, off=off)
+
+        # Explicit-size dump: 1..4 aligned units, with the offset
+        # picked after the size so off + size stays within the
+        # partition.
+        units = random.randint(1, min(4, units_total))
+        size = units * align
+        off = random.randint(0, units_total - units) * align
+        do_dump(ubman, part, off=off, size=size)
+        ran_any = True
+    if not ran_any:
+        pytest.skip('No partition available for dump')
+
+@pytest.mark.buildconfigspec('cmd_mtd')
+@pytest.mark.buildconfigspec('cmd_bdi')
+@pytest.mark.buildconfigspec('cmd_memory')
+@pytest.mark.buildconfigspec('net_legacy', 'net_lwip')
+def test_mtd_bin_integrity(ubman):
+    """Write a binary blob to flash and byte-compare it back.
+
+    Fetches the binary over TFTP once, then writes it to every
+    writeable partition that is large enough to hold it. Each write
+    is followed by reading the data back into a different RAM region
+    and comparing byte-for-byte via 'cmp.b'.
+    """
+    bin_cfg = ubman.config.env.get('env__mtd_bin_test')
+    if not bin_cfg:
+        pytest.skip('No env__mtd_bin_test configured')
+    configs = get_configs(ubman)
+
+    bin_file = bin_cfg.get('bin_file')
+    bin_size = bin_cfg.get('bin_size')
+    tftp_addr = bin_cfg.get('tftp_addr')
+    readback_addr = bin_cfg.get('readback_addr')
+    missing = [
+        key for key, val in (
+            ('bin_file', bin_file),
+            ('bin_size', bin_size),
+            ('tftp_addr', tftp_addr),
+            ('readback_addr', readback_addr),
+        ) if val is None
+    ]
+    if missing:
+        pytest.fail(f'env__mtd_bin_test missing required keys: {missing}')
+
+    setup_network(ubman)
+    cmd = f'tftpb {tftp_addr:#x} {bin_file}'
+    with ubman.temporary_timeout(get_default_timeout(ubman)):
+        output = ubman.run_command(cmd)
+    if 'TIMEOUT' in output:
+        pytest.fail(f'TFTP timed out fetching {bin_file!r}')
+    if TFTP_DONE not in output:
+        pytest.fail(
+            f'TFTP of {bin_file!r} did not complete, output:\n{output}'
+        )
+
+    ran_any = False
+    for config in configs:
+        part = mtd_prepare(ubman, config)
+        if part is None:
+            continue
+        if not part['writeable']:
+            ubman.log.info(f'skip {part["name"]!r}: not marked writeable')
+            continue
+        erasesize = part['erasesize']
+        erase_size = ((bin_size + erasesize - 1) // erasesize) * erasesize
+        if erase_size > part['size']:
+            ubman.log.info(
+                f'skip {part["name"]!r}: binary ({bin_size:#x}) does '
+                f'not fit in partition ({part["size"]:#x})'
+            )
+            continue
+
+        do_erase(ubman, part, 0, erase_size)
+        do_write(ubman, part, tftp_addr, 0, bin_size)
+        # Wipe the readback area so a stale match cannot pass as success.
+        ubman.run_command(f'mw.b {readback_addr:#x} 0x00 {bin_size:#x}')
+        do_read(ubman, part, readback_addr, 0, bin_size)
+        cmp_cmd = f'cmp.b {tftp_addr:#x} {readback_addr:#x} {bin_size:#x}'
+        cmp_out = ubman.run_command(cmp_cmd)
+        assert EXPECTED_COMPARE in cmp_out, (
+            f'Binary mismatch on {part["name"]!r}: cmp.b reported '
+            f'{cmp_out!r}'
+        )
+        ran_any = True
+    if not ran_any:
+        pytest.skip(
+            'No writeable partition large enough for the binary file'
+        )
-- 
2.23.0

