Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44582FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 07:40:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83D36846A1;
	Tue,  5 May 2026 09:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0xhy1iMg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62A2B846B1; Tue,  5 May 2026 09:40:51 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80E078468B
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 09:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxHlBiODb9GqAGEScFo3jZtvjh4Phq3UVOv+gFbQpECHePq7CrXhpKewAdegtbWfEukusQiQYwXtUsryi4zDkd1fWZy6nauscHJn4U2N6PN97/lq/ix13mjf3yDHhVsYZm+SYmj7XXNQjzPA+IIQuwvTGEFluh40j/FT0GjIqEwXeI+rjq0YGd9M+I0KohRaqxSjXQzFeEvvenuSQQtgpXeAZPfFD+T3ZO3E50pNZIQ/TjmCxHN+BQAm7lpL1c3eEBxbcEgGTENAKqzjn5ri+Fs0EQQdaKxfgKiq2tnGs0CqDlLcwiykQd8ynf/FzbVXIRbt9g1BBajU1cOrmmjPgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHZKqcPIHq+/K6pgZPV27J+ZXIcGAODpkDkL4etqVKg=;
 b=nL8wJxddYZmGdeBmOWTOlEKQIt7hiXZWSiVyUj2wCUonoIdHfipUHTU9uy+bL9bB4hTL0TglFbVAODAbPatFEm/V3se4RE9nhcfaooj8DNIzsTDn+fEanxN9KBl0HJhb/Dfqcb+8Md2GpmangawxkboZvKgSQnjtlmzt9hNsRZFm64+pec9XIxlSy0EPZzkYMT7BUINWmwa1c3fElkU4UHR3XxvKAlHc1CVuAWYtI0bkxMAemoZKGKexnd8Uq4AZRPjRxUFK0KTnOotGAebKAz49Gsa3Icxsm49S+gHsXtQyJWYcQ4jy33xc9MPZhUjARs5GaBPUSFgUygV451nXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHZKqcPIHq+/K6pgZPV27J+ZXIcGAODpkDkL4etqVKg=;
 b=0xhy1iMgfoQcFWRk9u7IpEBGXegkUw5y2taMgfb9V4CDJxWsyfEd0pWjRCcoLYiBx3I2NLdrlT3k5IBKH1/fm/oRS/vQgBjWd/GBSiR/FH2phSJhC6mkbZM3qqznrcHLo6kCJN1kq+EePuSaAA5qvKSfdbY2CoMu2Bdq5GJ+N+g=
Received: from SN7PR04CA0108.namprd04.prod.outlook.com (2603:10b6:806:122::23)
 by SA1PR12MB7037.namprd12.prod.outlook.com (2603:10b6:806:24c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 07:40:38 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:122:cafe::b1) by SN7PR04CA0108.outlook.office365.com
 (2603:10b6:806:122::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 07:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 07:40:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 5 May
 2026 02:40:34 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 May
 2026 02:40:33 -0500
Received: from xhdsswai40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 5 May 2026 02:40:31 -0500
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>, <trini@konsulko.com>
Subject: [PATCH v3] test/py: nand: Add tests for NAND flash device
Date: Tue, 5 May 2026 13:10:25 +0530
Message-ID: <20260505074025.1322104-1-love.kumar@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: love.kumar@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|SA1PR12MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: d78d572f-9554-4309-3003-08deaa7999ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: yj9PEbjZgjBmL9MqlL8yEERW/jZfFVGtFc/9dVdmvM10bRMQPYEv8pUeqZm6Xeoi5TKA10dsirNBaWpuAjABzCpoOshAZ7EjvoRef30pcgrZbiNyl9h2LFYW11MB7gh2SQGHZExXjYj1PE+W1wsAgCHMessMm6088CB2w6/dhmK5Lx8UgZlpSULOKLsDxU+oEj1jC+X9XT6rLdbcedN1q2gE6EB/3B8lgeIBdDKIZ6NfEbYrBLzlI03ui7CgGR2ZmL+6sZwo5ZhOrHM7l5IahUcqimWLjksbFP8QGoD6cK0be3Vbe+eNELUvKn3p5zPaMSkWTfTlNc17jhBfSgdLkjOgtupFDfScm96txURChX2w9oOa4Q8MHRRD74c5VWRC7ZbKLoN6neR9RgtDjYYZUdT1xc9g5hQn/VtdNyCNL8w9D2jMQ5kE+hmgZ1aNokGVH9VojeNO/dVO0Sra4Jhblg7jZLn7Y2sBtSnj8WFQdSYZni7YO2fZhSesxMYZoK8Rk3ztyzm8y5lZz48qroi/uXf2myoCnFjX1gqbHrSZn2BH1RlLjMOaJ8Jx8vDQxkofb8yJV5LUi+WoSvKAjptqCZ8kGNJbjwJORU2gDG4jeIV3qZxmWrHphlXFQ9h58EFpk1aw5ZzZdr8NWKRSUheAEmh9b9/8scHvbRwToRmc4A7nZqhsAefgFxsMSohLN25Go40cDvxSd1NSFLs88NBXitCUtszc1oP7cmefLkIV0Xg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sqz9XxZKzXc2xjCh0PUok+jLFUXzj3s6Lmvu+/0oJngeKpXLrWl1jaA1HR+Cy5A0Z0avqeC2yx0LtVpsUycSmex6h7NZkQjSKYqz9xpNPC7Y34tZmvQXMPcnPzX4mnadkwcdiTnR4pgbj1cJyoFH924qwr6jDNN90y4c18KCuFbsh/xplNDHZ/5h8U5L9K06SPyXL0MgKyYgSYOawOq8TGlFQLz0Y0k28lfRmSP7uo5lK65AcuJ2Tu0BI872zVGyy9R32ArnDZGZpcjMLd/YHE/kZEvXZh49yhl3jEOrz7IDySePbfUtipyZr1jjs5WuCeVjvSmuM9mN5NhM8CoaLmzj3jNELc9LB8PlmWJc7Un85VESEYmGcF5m9TSb5xNULq/epYJz0wWw9lGDd24lCfNVyJlQ3xtDyAvcPxmwothMzB6isSH4K09dMYfu79u6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 07:40:38.2856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d78d572f-9554-4309-3003-08deaa7999ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7037
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

Add tests for nand commands to test various NAND flash operations such
as erase, write and read.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
Changes in v3:
- Use the current test/py APIs (ubman fixture and utils helpers)
- Refactor nand_pre_commands() to return a dictionary
- Accept multi-chip nand info output (e.g. "Device 0: 2x nand0")
- Add Sphinx-rendered documentation for the test
- Update copyright year

Changes in v2:
- Fix the deprecation warning issue for invalid escape sequence
---
 doc/develop/pytest/test_nand.rst |   8 ++
 test/py/tests/test_nand.py       | 237 +++++++++++++++++++++++++++++++
 2 files changed, 245 insertions(+)
 create mode 100644 doc/develop/pytest/test_nand.rst
 create mode 100644 test/py/tests/test_nand.py

diff --git a/doc/develop/pytest/test_nand.rst b/doc/develop/pytest/test_nand.rst
new file mode 100644
index 000000000000..7d16ae859e1e
--- /dev/null
+++ b/doc/develop/pytest/test_nand.rst
@@ -0,0 +1,8 @@
+test_nand
+=========
+
+.. automodule:: test_nand
+   :synopsis:
+   :member-order: bysource
+   :members:
+   :undoc-members:
diff --git a/test/py/tests/test_nand.py b/test/py/tests/test_nand.py
new file mode 100644
index 000000000000..d6086f0983ef
--- /dev/null
+++ b/test/py/tests/test_nand.py
@@ -0,0 +1,237 @@
+# SPDX-License-Identifier: GPL-2.0
+# (C) Copyright 2023-2026, Advanced Micro Devices, Inc.
+
+"""
+Note: This test relies on boardenv_* containing configuration values to define
+the nand device total size and timeout available for testing. Without this, the
+test will be automatically skipped. This test will be also skipped if the NAND
+flash device is not detected.
+
+For example:
+
+.. code-block:: python
+
+   # Setup env__nand_device_test to set the NAND flash total size and timeout.
+   env__nand_device_test = {
+       'size': '8192 MB',
+       'timeout': 100000,
+   }
+"""
+
+import pytest
+import random
+import re
+import utils
+
+def nand_pre_commands(ubman):
+    """Probe the NAND flash device and gather geometry from `nand info`.
+
+    Args:
+        ubman: A U-Boot console connection.
+
+    Returns:
+        A dictionary with the following keys:
+            page_size: NAND page size in bytes.
+            erase_size: NAND erase (sector) size in bytes.
+            sector_size: NAND erase (sector) size in KiB.
+            total_size: Usable NAND size in bytes (bad blocks subtracted).
+            timeout: Timeout in milliseconds for long-running operations.
+    """
+
+    f = ubman.config.env.get('env__nand_device_test', None)
+    if not f:
+        pytest.skip('No env file to read for NAND device test')
+
+    total_size = f.get('size', None)
+    timeout = f.get('timeout')
+
+    if not total_size:
+        pytest.skip('NAND device size not recognized')
+
+    output = ubman.run_command('nand info')
+    if not re.search(r'Device 0:\s*\S*\s*nand0', output):
+        pytest.skip('No NAND device available')
+
+    m = re.search('Page size (.+?) b', output)
+    if not m:
+        pytest.fail('NAND page size not recognized')
+    try:
+        page_size = int(m.group(1))
+    except ValueError:
+        pytest.fail('NAND page size not recognized')
+
+    m = re.search('sector size (.+?) KiB', output)
+    if not m:
+        pytest.fail('NAND erase size not recognized')
+    try:
+        erase_size = int(m.group(1))
+        sector_size = erase_size
+    except ValueError:
+        pytest.fail('NAND erase size not recognized')
+
+    erase_size *= 1024
+
+    output = ubman.run_command('nand bad')
+    if not 'bad blocks:' in output:
+        pytest.skip('No NAND device available')
+
+    count = 0
+    m = re.search(r'bad blocks:([\n\s\s\d\w]*)', output)
+    if m:
+        print(m.group(1))
+        var = m.group(1).split()
+        count = len(var)
+    print('bad blocks count= ' + str(count))
+
+    m = re.search('(.+?) MB', total_size)
+    if not m:
+        pytest.fail('NAND size not recognized')
+    try:
+        total_size = int(m.group(1))
+        total_size *= 1024 * 1024
+        print('Total size is: ' + str(total_size) + ' B')
+        total_size -= count * sector_size * 1024
+        print('New Total size is: ' + str(total_size) + ' B')
+    except ValueError:
+        pytest.fail('NAND size not recognized')
+
+    return {
+        'page_size': page_size,
+        'erase_size': erase_size,
+        'sector_size': sector_size,
+        'total_size': total_size,
+        'timeout': timeout,
+    }
+
+@pytest.mark.buildconfigspec('cmd_nand')
+@pytest.mark.buildconfigspec('cmd_bdi')
+@pytest.mark.buildconfigspec('cmd_memory')
+def test_nand_read_twice(ubman):
+    """This test reads the whole NAND flash twice, random_size till full flash
+    size, random till page size.
+    """
+
+    nand_params = nand_pre_commands(ubman)
+    page_size = nand_params['page_size']
+    total_size = nand_params['total_size']
+    expected_read = 'read: OK'
+
+    for size in (
+        random.randint(4, page_size),
+        random.randint(4, total_size),
+        total_size,
+    ):
+        addr = utils.find_ram_base(ubman)
+
+        output = ubman.run_command(
+            'nand read %x 0 %x' % (addr + total_size, size)
+        )
+        assert expected_read in output
+
+        output = ubman.run_command('crc32 %x %x' % (addr + total_size, size))
+        m = re.search('==> (.+?)', output)
+        if not m:
+            pytest.fail('CRC32 failed')
+        expected_crc32 = m.group(1)
+
+        output = ubman.run_command(
+            'nand read %x 0 %x' % (addr + total_size + 10, size)
+        )
+        assert expected_read in output
+
+        output = ubman.run_command(
+            'crc32 %x %x' % (addr + total_size + 10, size)
+        )
+        assert expected_crc32 in output
+
+@pytest.mark.buildconfigspec('cmd_nand')
+@pytest.mark.buildconfigspec('cmd_bdi')
+@pytest.mark.buildconfigspec('cmd_memory')
+def test_nand_write_twice(ubman):
+    """This test does the random writes till page size, size and full size"""
+
+    nand_params = nand_pre_commands(ubman)
+    page_size = nand_params['page_size']
+    erase_size = nand_params['erase_size']
+    total_size = nand_params['total_size']
+    expected_write = 'written: OK'
+    expected_read = 'read: OK'
+    expected_erase = '100% complete.'
+    old_size = 0
+
+    for size in (
+        random.randint(4, page_size),
+        random.randint(page_size, total_size),
+        total_size,
+    ):
+        offset = page_size
+        addr = utils.find_ram_base(ubman)
+        size = size - old_size
+        output = ubman.run_command('crc32 %x %x' % (addr + total_size, size))
+        m = re.search('==> (.+?)', output)
+        if not m:
+            pytest.fail('CRC32 failed')
+
+        expected_crc32 = m.group(1)
+
+        if old_size % page_size:
+            old_size = int(old_size / page_size + 1)
+            old_size *= page_size
+
+        if old_size + size > total_size:
+            size = total_size - old_size
+
+        eraseoffset = int(old_size / erase_size)
+        eraseoffset *= erase_size
+
+        erasesize = int(size / erase_size + 1)
+        erasesize *= erase_size
+
+        output = ubman.run_command(
+            'nand erase.spread %x %x' % (eraseoffset, erasesize)
+        )
+        assert expected_erase in output
+
+        output = ubman.run_command(
+            'nand write %x %x %x' % (addr + total_size, old_size, size)
+        )
+        assert expected_write in output
+        output = ubman.run_command(
+            'nand read %x %x %x' % (addr + total_size + offset, old_size, size)
+        )
+        assert expected_read in output
+        output = ubman.run_command(
+            'crc32 %x %x' % (addr + total_size + offset, size)
+        )
+        assert expected_crc32 in output
+        old_size = size
+
+@pytest.mark.buildconfigspec('cmd_nand')
+def test_nand_erase_block(ubman):
+    """Erase the NAND flash one erase block at a time."""
+
+    nand_params = nand_pre_commands(ubman)
+    erase_size = nand_params['erase_size']
+    total_size = nand_params['total_size']
+
+    expected_erase = '100% complete.'
+    for start in range(0, total_size, erase_size):
+        output = ubman.run_command(
+            'nand erase.spread %x %x' % (start, erase_size)
+        )
+        assert expected_erase in output
+
+@pytest.mark.buildconfigspec('cmd_nand')
+def test_nand_erase_all(ubman):
+    """Erase the entire NAND flash in a single operation."""
+
+    nand_params = nand_pre_commands(ubman)
+    total_size = nand_params['total_size']
+    timeout = nand_params['timeout']
+
+    expected_erase = '100% complete.'
+    with ubman.temporary_timeout(timeout):
+        output = ubman.run_command(
+            'nand erase.spread 0 ' + str(hex(total_size))
+        )
+        assert expected_erase in output
-- 
2.43.0

