Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA83D11183
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 10:36:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2101284332;
	Thu, 27 Nov 2025 11:36:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HkR3vVvz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE3AB8436C; Thu, 27 Nov 2025 11:36:18 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 492EA8432D
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 11:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqK1o2RgLr6xMNOleB0WcibMm1tXosVr4MkSRpgu2GzltmccnlZo0ftsFjojbE9W/Aof/9VCN1csVSlk1oaf5zZT4RNJwGV06Q0bKYi27cF8Iok0nEitaGLdcZf7cY9dXhmhoSIYqolexhfWqaDOmyaDmgI/f+RyEmNSi5hk2RfTBBNUkoLRz0sfBk25fiSj1kc7f+8JNS7Vwsm8KteSKREbW1e0B2t7UbYNR6DgpqURHEDX9b4/qUS2rJkOOtfXHItRHIy9Zxj7iGpxyTvcj1mI8mnbQO6uQu4A2kM4KvKDjNAGQSp5j314jW1Po24sday8wmGUQEFi1V0tu6ps9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJE7XwQSh8+fWOJ5zYCq++oOg3bHFSlsBV9iAifaWQs=;
 b=rO0f1lF7g5wZ2/qYzaF6k/asAuUtfn/OxftdXK7O53nBcMnKS7op1YPkmCH6/rw/JjxjH29u6upnLNfnio8xsCWMrZ/I1C2wFkw3qebkzOc+7gvAcqdzQ6iZFM9U0K29oB/EPTtHFipDdUIONhVV4cSbB6VAttcTpKyqTgtJOcnlV7uWNddyZOkBKavUEYnR1IHFQDs6/dxgNaE7YhMS2H6Bdb3buqrSz+m/Mj7WrT4qes1bHKvkl+MVoopC9F4qjOQtVNaW471fBdmQBx7fUG6uOgYJawG+QrAeEIb7+pIU7f5CqGLeojX+iQuPStALOzit4sOryBIHAC6rQ4SHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJE7XwQSh8+fWOJ5zYCq++oOg3bHFSlsBV9iAifaWQs=;
 b=HkR3vVvzVBRDnSw0bS2FpuysiPxArxm0IqgFvJI8dxI9K9el5TicINkvoChbGe03exvAPiIzwaDQcnvSrCT1euAKeogZOQ7YRHfMXEf2XEUQt66IFJVxXhXgozmr46XmwwZah+bsiaTRDVkAu2XguziFNK4CbvKrJHPHJ+I9L0E=
Received: from BL0PR02CA0033.namprd02.prod.outlook.com (2603:10b6:207:3c::46)
 by DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 10:36:11 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:207:3c:cafe::e7) by BL0PR02CA0033.outlook.office365.com
 (2603:10b6:207:3c::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.14 via Frontend Transport; Thu,
 27 Nov 2025 10:36:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Thu, 27 Nov 2025 10:36:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 27 Nov
 2025 04:36:06 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 27 Nov 2025 02:36:05 -0800
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>, <trini@konsulko.com>
Subject: [PATCH v2] test/py: nand: Add tests for NAND flash device
Date: Thu, 27 Nov 2025 16:06:04 +0530
Message-ID: <31a29623e90b44d0a80886f8d17540a2912e7d24.1764239161.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|DM6PR12MB4108:EE_
X-MS-Office365-Filtering-Correlation-Id: d01e87ac-acd4-44bd-920b-08de2da0c83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z49Tu9CIvDCpStMp/392A+v2DURWH2Y66trKVYryAfq+ulDCkrGmJcXE9X0C?=
 =?us-ascii?Q?yJNX9n+hef28OudTUxRPzBb01y+knoAowKu70Cjx169AJC++akN4wWN/hSDn?=
 =?us-ascii?Q?23lkFtq53d9yog9aVny0clgeqp6JlOjaX1soQbKLNApZsHrkIISPrkqQ0UoG?=
 =?us-ascii?Q?+L48W4NPOHMUb1nUfDoxsevg9bPPqO7ka82QYNf8FRf0bIs0mmm0p+04jU6X?=
 =?us-ascii?Q?pOzBBDTVWTrbh6AgaDFhSJsIXk2Ab+biXERp8CL5m//rWPSJkcNZpDfnKq9y?=
 =?us-ascii?Q?Kr89T6JtSe4o0sBoJOns7hBoyOgKlm8Pb/wxhYaEt2mC1bq9SlDVIqc7GKhD?=
 =?us-ascii?Q?ehK35QwDDnNdng6rEi+LwsYgMLWfo8v8FYJor+amDgjJqOJyXy1gfe+E5V9Y?=
 =?us-ascii?Q?mdvfuIcHvaItD5rAbLzwefLKgZkAmEJGp/8f7Q9GHHT8ndv2LsqRo9L2iuoE?=
 =?us-ascii?Q?qy4Ufi54+ElbBK8vsgUB7RWUsETr6Om2i+TCjUe/pu6pp+oAWTBZE1eSUyl8?=
 =?us-ascii?Q?Lh4pmWDHzftLZH17zlHrhVMrDHEo9uds8BD/qAczGhh6kVBZW/SQG57jyPYA?=
 =?us-ascii?Q?cAamhZifbXn6wyrH0+XSJ0LbWfXsRJht/OYmYEgOez6gZkC5+8I2OtyQrfCH?=
 =?us-ascii?Q?rtKx234mpih5ndrMgnuGZRIKYgc9vv8tpcN/i0UlMNvKSzF7phTJPfjBhPcb?=
 =?us-ascii?Q?qGJJIr8ctzdMNSDyxGnjBQ5eLTe/MLOZJRiRDNG+e07WvXuPkFV5bkbWjZDK?=
 =?us-ascii?Q?oPJkDDR9aL3jaC/j8Kg1jsp3nDdLzyX5cqocuYl2JFUfUW5V0kyDYicDPFNS?=
 =?us-ascii?Q?stwLjyuIwHPXgyDLxrahU4vIF+CAykdp595wbrJPWEoODPmOnhMOjsS6ItZq?=
 =?us-ascii?Q?P1rgaIXtH3wVxHRZ1sb3uy8EeII48RbpfUJ2rInLdQZumzrxcVUrSbiC7DGN?=
 =?us-ascii?Q?aLUbJNRvAt9Huyn0IqUYXTVmXQB5JU4TTBJ3EX+GsmgO3hlmbu59dv/iMpDE?=
 =?us-ascii?Q?IE2LYv1KKsYi91BSjUnreLd9TkKI+vCdco//c9i+5UhXXsayXXQU/lTeItFp?=
 =?us-ascii?Q?/jBN7lqGzdhppnSrvcQ6Y4/tbXAQYb5CzquUU9fzjgdnb9OV7oaNJLgQ2Eex?=
 =?us-ascii?Q?hP6BHtB1wN9NpEqo0fCXt8H70ssKOcDgVYHJ0UQyhP+EXqc0kqYwWI4W4VqS?=
 =?us-ascii?Q?dw4adqBMjWUBVDyw2QcBmerCB3HOOeYqbghhWzqzMk9L6lI3dX3wgpOgzOej?=
 =?us-ascii?Q?yVaDy5abIzmZkUIrY5J7v5QvIo9QjAGm4qm9sKTfWr+J6bh9T2pqo2RqAWay?=
 =?us-ascii?Q?ftPT1dP3T9XScTuPIHTPhwqBLvTUG7wtPSzoNYje45SonrSMXBWeuggrPqU2?=
 =?us-ascii?Q?LIYZ63E5GZkMP15OOKQfucu4XJmArMzSWCagI/dfng7N/VGhITZhevxevkBO?=
 =?us-ascii?Q?c2+gqAjRmGzrn+lAu1joc72n9m5/pOnckHK0g8RvNiQKoiAuXwowZHMrO0pb?=
 =?us-ascii?Q?bD5+ni41oo2egmzZ7uOkG6nsvEuxQAT4yshzTpK8QRZEFrf9FGVikxaH/Od4?=
 =?us-ascii?Q?+yKp+C/U7X5QfZMiRXE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 10:36:11.0334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d01e87ac-acd4-44bd-920b-08de2da0c83e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4108
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
Changes in v2:
- Fix the deprecation warning issue for invalid escape sequence
---
 test/py/tests/test_nand.py | 201 +++++++++++++++++++++++++++++++++++++
 1 file changed, 201 insertions(+)
 create mode 100644 test/py/tests/test_nand.py

diff --git a/test/py/tests/test_nand.py b/test/py/tests/test_nand.py
new file mode 100644
index 000000000000..e49142cc0a31
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
+    m = re.search(r'bad blocks:([\n\s\s\d\w]*)', output)
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

