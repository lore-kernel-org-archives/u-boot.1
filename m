Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94400C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 14:26:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0957A87CD1;
	Fri, 19 Jan 2024 15:26:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pAd6xuCN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACF4887CC1; Fri, 19 Jan 2024 15:26:28 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD23987CD4
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 15:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REMREJBuO80LvZTyMNxFLJK+zr9FMuGf2zsNMDgkLyIxN+TVgqN64Xbmbex7lQQ+lC7QWFjAVAKwoftAa9PyI3/SBAELG1kpcmG3Skp5DygkKER/vKYm3w3fm/KLkCMAWbK5sYKELXXBI5MavInxnCoozUtuZzw74Rhd9VhqMvDpndJbB+RwhZG4do7OB7JINCLyYi4Ki2fzKtkLMg5m6riu7Q0Bq3N7T8rILXKTmph+c+sCDRiEkDcmS1lPp9UZXlpQ8oopXjgR1Gaga/1hkaTaBvSoYH3FHjaXbqJ/eb9RVarQex1ehRcq1JWf9GX0hxWS8x8Pn1eGwY2TGE/IsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAWnbjAkuhiZdcsBOhmVP8xJv2mnBi3WCK8KyF5/aLI=;
 b=QdE4kEBJbU0Q3nVmHdiik60gS7rqmWuUrO3vGt0zJKYy3SlAxOLBmOD0/waZfnED15vCAE83UEzYsJsg3aio8KVkU7MBgO+XuC/HF8wP2B9F/BX+NqtAG0kwQCm9HVPyxI0+w6OBhsjKEL2jvDojVCmjU8TYDlTV8iTorzUa30dLTNH+OW9V+rkzyn0Z8xc0h+xNnKaILq73G3HF1orFYcOAZUwHWUAxO/h4vC4Gua1HBmqHQvOxr51nMBDkDNAPoKtUoNE/Qatwa9XtnIAMs4dxOk5bsi4DMk2dVn/3330fsW6ZVPVHh0rOTPk5/O8ENEQxg/biunst77RDpFsC3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAWnbjAkuhiZdcsBOhmVP8xJv2mnBi3WCK8KyF5/aLI=;
 b=pAd6xuCNjKYOMitV5XgeAl53533wpqyEu/s+2CI2ueYFbOoLq+ea8+SWvnjoW9nCdPlyArc8fADA+sQQIbnf+EegnPMxlPAwjo1NnCBmxUKG8JnOydDAwk52slyghfXgNioq1BUs46BS6zTFtu1rJewFMDlenZJdx9i3+sZQJ2c=
Received: from BL0PR02CA0092.namprd02.prod.outlook.com (2603:10b6:208:51::33)
 by DM8PR12MB5448.namprd12.prod.outlook.com (2603:10b6:8:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 14:26:22 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::ce) by BL0PR02CA0092.outlook.office365.com
 (2603:10b6:208:51::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26 via Frontend
 Transport; Fri, 19 Jan 2024 14:26:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 14:26:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 08:26:21 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 19 Jan 2024 08:26:20 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: nand: Add tests for NAND flash device
Date: Fri, 19 Jan 2024 19:56:19 +0530
Message-ID: <e24fb8aa7d61923eec9901683295c65979496044.1705674029.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|DM8PR12MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d1c889a-6e85-4001-e08e-08dc18fa9c12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wIcJByOLnia7I+GUhIcaLTqi1UEAUZakU5ZMRBvP78TK0W1c8zxkB6hojN1losoVxDVg7uYnXFs1P0aHMlfBEsUNDz9pOfhxQ5QKXm66rl05rhrOCGsDMdnXXxqbJdWjuIWjSVmMDIBws7bk/ILVcSgwyACu7ty0NLvEEk2/JpyhrXTKWXjYbBxFHFyHzbp4V+q2LGM6EotJI2fHL9qhumICo2c30N1zipWAlykqaxF1R4xQ5krX0nulZonlGmd9VVKDuXovzk5snG9WslWij94yNdNJu9K65sMSssVSdQHP4W1I33iHQjLAgamBUP5FtEN2lzPqn9kPNL6Ofs5qX/2q9QYT//erAnRqT7AW6cqjoBlofzMeGXODWR8PhpnZejhHAuuoPmOVr7yDZAWIQRDx2wnKryyIS5/plHhWhsSgBdexUI5mdWWXA0icr+E7uwfSuP61SHmS85G3LZ6aWUDtaNPtcoQAo6y0YymTvfw0EHYihaFt8NR+Z2/yFOMa9ZiofjOt9HhCH0taNdjGmkp1nir2m6dVeeJzEdZ8TcTnfdnMsjiWjC44ypWA906KxgebVZMnJtuSrp+Ql5IeN1HHzkft3/FabXMn3k1aGN+RylI5oBbkZKtgjE9JMaQ3fv8U0CZrO3/AOviPdlcUeogu42rsSSn7qOREzB/aZpBiiVie+3ZtvizJCIkSihbYBO/ThO01YKAJQznE4ltlrS12AmmlESteTRyYvo+82Vs7/kFIdtaljCGJ4YecNMFagAWUH5tXPNZvDKre0uHzsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(4326008)(426003)(83380400001)(336012)(8936002)(5660300002)(47076005)(6916009)(8676002)(316002)(478600001)(70206006)(54906003)(2616005)(70586007)(44832011)(26005)(107886003)(356005)(81166007)(82740400003)(2906002)(36756003)(41300700001)(86362001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 14:26:21.8828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1c889a-6e85-4001-e08e-08dc18fa9c12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5448
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
 test/py/tests/test_nand.py | 201 +++++++++++++++++++++++++++++++++++++
 1 file changed, 201 insertions(+)
 create mode 100644 test/py/tests/test_nand.py

diff --git a/test/py/tests/test_nand.py b/test/py/tests/test_nand.py
new file mode 100644
index 000000000000..f5fd5d065cfe
--- /dev/null
+++ b/test/py/tests/test_nand.py
@@ -0,0 +1,201 @@
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
+the nand device total size and timeout available for testing. Without this, the
+test will be automatically skipped. This test will be also skipped if the NAND
+flash device is not detected.
+
+For example:
+
+# Setup env__nand_device_test to set the NAND flash total size and timeout.
+env__nand_device_test = {
+   'size': '8192 MB',
+   'timeout': 100000,
+}
+"""
+
+# Find out nand memory parameters
+def nand_pre_commands(u_boot_console):
+    f = u_boot_console.config.env.get('env__nand_device_test', None)
+    if not f:
+        pytest.skip('No env file to read for NAND device test')
+
+    total_size = f.get('size', None)
+    timeout = f.get('timeout')
+
+    if not total_size:
+        pytest.skip('NAND device size not recognized')
+
+    output = u_boot_console.run_command('nand info')
+    if not 'Device 0: nand0' in output:
+        pytest.skip('No NAND device available')
+
+    m = re.search('Page size (.+?) b', output)
+    if m:
+        try:
+            page_size = int(m.group(1))
+        except ValueError:
+            pytest.fail('NAND page size not recognized')
+
+    m = re.search('sector size (.+?) KiB', output)
+    if m:
+        try:
+            erase_size = int(m.group(1))
+            sector_size = erase_size
+        except ValueError:
+            pytest.fail('NAND erase size not recognized')
+
+        erase_size *= 1024
+
+    output = u_boot_console.run_command('nand bad')
+    if not 'bad blocks:' in output:
+        pytest.skip('No NAND device available')
+
+    count = 0
+    m = re.search('bad blocks:([\n\s\s\d\w]*)', output)
+    if m:
+        print(m.group(1))
+        var = m.group(1).split()
+        count = len(var)
+    print('bad blocks count= ' + str(count))
+
+    m = re.search('(.+?) MB', total_size)
+    if m:
+        try:
+            total_size = int(m.group(1))
+            total_size *= 1024 * 1024
+            print('Total size is: ' + str(total_size) + ' B')
+            total_size -= count * sector_size * 1024
+            print('New Total size is: ' + str(total_size) + ' B')
+        except ValueError:
+            pytest.fail('NAND size not recognized')
+
+    return page_size, erase_size, total_size, sector_size, timeout
+
+@pytest.mark.buildconfigspec('cmd_nand')
+@pytest.mark.buildconfigspec('cmd_bdi')
+@pytest.mark.buildconfigspec('cmd_memory')
+def test_nand_read_twice(u_boot_console):
+    """This test reads the whole NAND flash twice, random_size till full flash
+    size, random till page size.
+    """
+
+    page_size, erase_size, total_size, sector_size, timeout = nand_pre_commands(
+            u_boot_console)
+    expected_read = 'read: OK'
+
+    for size in random.randint(4, page_size), random.randint(4, total_size), total_size:
+        addr = u_boot_utils.find_ram_base(u_boot_console)
+
+        output = u_boot_console.run_command(
+            'nand read %x 0 %x' % (addr + total_size, size)
+        )
+        assert expected_read in output
+
+        output = u_boot_console.run_command('crc32 %x %x' % (addr + total_size, size))
+        m = re.search('==> (.+?)', output)
+        if not m:
+            pytest.fail('CRC32 failed')
+        expected_crc32 = m.group(1)
+
+        output = u_boot_console.run_command(
+            'nand read %x 0 %x' % (addr + total_size + 10, size)
+        )
+        assert expected_read in output
+
+        output = u_boot_console.run_command(
+            'crc32 %x %x' % (addr + total_size + 10, size)
+        )
+        assert expected_crc32 in output
+
+@pytest.mark.buildconfigspec('cmd_nand')
+@pytest.mark.buildconfigspec('cmd_bdi')
+@pytest.mark.buildconfigspec('cmd_memory')
+def test_nand_write_twice(u_boot_console):
+    """This test does the random writes till page size, size and full size"""
+
+    page_size, erase_size, total_size, sector_size, timeout = nand_pre_commands(
+            u_boot_console)
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
+        addr = u_boot_utils.find_ram_base(u_boot_console)
+        size = size - old_size
+        output = u_boot_console.run_command('crc32 %x %x' % (addr + total_size, size))
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
+        output = u_boot_console.run_command(
+            'nand erase.spread %x %x' % (eraseoffset, erasesize)
+        )
+        assert expected_erase in output
+
+        output = u_boot_console.run_command(
+            'nand write %x %x %x' % (addr + total_size, old_size, size)
+        )
+        assert expected_write in output
+        output = u_boot_console.run_command(
+            'nand read %x %x %x' % (addr + total_size + offset, old_size, size)
+        )
+        assert expected_read in output
+        output = u_boot_console.run_command(
+            'crc32 %x %x' % (addr + total_size + offset, size)
+        )
+        assert expected_crc32 in output
+        old_size = size
+
+@pytest.mark.buildconfigspec('cmd_nand')
+def test_nand_erase_block(u_boot_console):
+    page_size, erase_size, total_size, sector_size, timeout = nand_pre_commands(
+            u_boot_console)
+
+    expected_erase = '100% complete.'
+    for start in range(0, total_size, erase_size):
+        output = u_boot_console.run_command(
+            'nand erase.spread %x %x' % (start, erase_size)
+        )
+        assert expected_erase in output
+
+@pytest.mark.buildconfigspec('cmd_nand')
+def test_nand_erase_all(u_boot_console):
+    page_size, erase_size, total_size, sector_size, timeout = nand_pre_commands(
+            u_boot_console)
+
+    expected_erase = '100% complete.'
+    start = 0
+    with u_boot_console.temporary_timeout(timeout):
+        output = u_boot_console.run_command(
+            'nand erase.spread 0 ' + str(hex(total_size))
+        )
+        assert expected_erase in output
-- 
2.25.1

