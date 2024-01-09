Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611D9C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 09:10:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFD4D86611;
	Tue,  9 Jan 2024 10:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cQ90JFMp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5287287120; Tue,  9 Jan 2024 10:10:13 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEDDB83414
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 10:10:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pz0KNG8PABD8lZz5E813iK0RfAlGsWI18Nj1+Qpi17QCh4bfzlsMY2K5xgzT5vgA4BFK97wLv1vtynUaPqF0z2+wrb3qnlgourBn8pNoyERh5+/kODFwNCoxJn0J5HRsALn8s+H1B22wf5Gmqg8c+9O55N3aBcYEnXUboSQIDqe9PizEoNVaj8nGYa2VqHgvZ3fUBR7S/f+hu1AxSkF0qJm+ca9h36Zo0oqaiTjupB2AqNnT5kyoXyy9RIefxtv8feAzamSVAt+U+B/m8/evEqEe7UcHiQh1WXVMrTieNgCi+MQqspNXHzypjGQ75EklDsjyFV11Tsbhi8ejc8gKVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mT+8S7C3lq0xMeq/xAQXyKwmLgUb+IjLc0n5Q5FN/Vk=;
 b=USfyUmoT7jHvafNhs10ul3X4ozctKRh9Kt9wc2khvHlENm3Ls1vg+qj+9L1pKIgSw1gUfyQdJMuM1GXYvJkLHFUX7SOB1HGLpkOM0lhNujvi98Ubt9YjLXAJpo7/1J3mNiIELKIIZH/dWdgYhVBdJGkpuuHJXAJayP9D8r6jNSYGcEIUbMsqnlcCOUuDwm2MxKcBgBN9D8QZMNN4lfogfOH1oBQ3FKbHZ96oIo7WGpetc6Qvtr/li+3gd4re+JU0z8J4coysmct4BsCmzWDvHipSXU2Db9JsC2iadsvonGzcY2SOmR+PDoRrcJJ608vul1FFNtEqcmZoH1X7zYZILg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mT+8S7C3lq0xMeq/xAQXyKwmLgUb+IjLc0n5Q5FN/Vk=;
 b=cQ90JFMpgNGT9vcfFw5xYNOfJsPBIIw/miZ1krsXng+YGrL1JHXJ/LfZDnMiYc/KJNIWbttN4u+G23v/q7HpyqRwMKr1HJ29g4/xaxvBEpff5vivzyJn6jnPojB7+W3AA1XgseE+JXQwtfrZylYRpbiBpRP7DYYD2auoGr8lkzk=
Received: from SA9PR13CA0055.namprd13.prod.outlook.com (2603:10b6:806:22::30)
 by SJ0PR12MB6829.namprd12.prod.outlook.com (2603:10b6:a03:47b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 09:10:04 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:22:cafe::8e) by SA9PR13CA0055.outlook.office365.com
 (2603:10b6:806:22::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.16 via Frontend
 Transport; Tue, 9 Jan 2024 09:10:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Tue, 9 Jan 2024 09:10:03 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 9 Jan
 2024 03:09:59 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 9 Jan
 2024 01:09:58 -0800
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 9 Jan 2024 03:09:57 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: bootstage: Add test for bootstage command
Date: Tue, 9 Jan 2024 14:39:57 +0530
Message-ID: <9cded17d99c96ea34004783662e6bd366dca9852.1704791383.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|SJ0PR12MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: 95723212-25c3-4aa4-ed95-08dc10f2c42d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CalEncPKtr56psQNIczsZb1/RofNXtbbap6IPDs2zlGjw65Br3CJ62Wiae15zmk271+Ux80kF3k6YkHlzHXvjIqolTuhYXrVnZzmCp7obRGt0xHR9ppJsFagRthu5IxWERm+PTHIcXcK7C/oximBSfeEuQfodQ5sqBBRqMEIfpqSs5NmpEVb3jVXleFQ1DnDNswrd6rrv2aLIjTjSGwEiOLsZJB18hqqY5O+FiFQVNXiJdqLcuqn+5sd1yaI29959cYw1pjMOKt2otuA+wyQkp8LzVZEtcid/gI6pbEgpjEsBnhodTSTaXKvPidvmMjRoYwUsJs2MDDKcWGgklwBFxJEs97J6hBtvjDmK89FtpTjqD1sQJMBrfDRxxCvXf83jCsG4oNDrmGT1E/sRh1OCEQ1GEBD8aqHcqw7DsFWIFUvfxmEL5aRPw/yACh4e7APk28XW8JYbAZdiDlEspnnRO9A9m74shADQeJ4rYXaSgCfSWWXdtRcLysFXIuZAY33bn5shlLaL8leBw55r7pJp4R8/Ha1k6Iv4rfWzz4uNVUFzzlG8SJuWQbWPqKyd0bZcFXhupVraunVzcbzzr9F4zGNVGJew+FRHGX4e7BuxdlTjawGVXadzwa/ReRZHSxv81HzbKG5wHCnYxu8zHUjwrMZRgEDfW7Xan9wSTn8H4nKHMph2lDiNWeUFJ+rzli/g0t/gnKE32oP6JzCGC7oK8ZgK5WcqVR/sjbxXxCplhe+/GoYWykizCbLvtpzqQ8Zps6gdb7A9ACt+HCF6mfDXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(46966006)(40470700004)(36840700001)(26005)(426003)(2616005)(336012)(478600001)(47076005)(36860700001)(107886003)(2906002)(5660300002)(41300700001)(6916009)(316002)(70206006)(8676002)(4326008)(54906003)(8936002)(44832011)(70586007)(82740400003)(36756003)(86362001)(356005)(81166007)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 09:10:03.8460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95723212-25c3-4aa4-ed95-08dc10f2c42d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6829
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

Add test cases for bootstage command to print the bootstage report, to
stash the data into memory and to unstash the data from memory.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 test/py/tests/test_bootstage.py | 67 +++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 test/py/tests/test_bootstage.py

diff --git a/test/py/tests/test_bootstage.py b/test/py/tests/test_bootstage.py
new file mode 100644
index 000000000000..a9eb9f0b4a11
--- /dev/null
+++ b/test/py/tests/test_bootstage.py
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0
+# (C) Copyright 2023, Advanced Micro Devices, Inc.
+
+import pytest
+
+"""
+Test the bootstage command.
+
+It is used for checking the boot progress and timing by printing the bootstage
+report, stashes the data into memory and unstashes the data from memory.
+
+Note: This test relies on boardenv_* containing configuration values to define
+the data size, memory address, and bootstage magic address (defined in
+common/bootstage.c). Without this, bootstage stash and unstash tests will be
+automatically skipped.
+
+For example:
+env__bootstage_cmd_file = {
+    'addr': 0x200000,
+    'size': 0x1000,
+    'bootstage_magic_addr': 0xb00757a3,
+}
+"""
+
+@pytest.mark.buildconfigspec('bootstage')
+@pytest.mark.buildconfigspec('cmd_bootstage')
+def test_bootstage_report(u_boot_console):
+    output = u_boot_console.run_command('bootstage report')
+    assert 'Timer summary in microseconds' in output
+    assert 'Accumulated time:' in output
+    assert 'dm_r' in output
+
+@pytest.mark.buildconfigspec('bootstage')
+@pytest.mark.buildconfigspec('cmd_bootstage')
+@pytest.mark.buildconfigspec('bootstage_stash')
+def test_bootstage_stash(u_boot_console):
+    f = u_boot_console.config.env.get('env__bootstage_cmd_file', None)
+    if not f:
+        pytest.skip('No bootstage environment file is defined')
+
+    addr = f.get('addr')
+    size = f.get('size')
+    bootstage_magic = f.get('bootstage_magic_addr')
+    expected_text = 'dm_r'
+
+    u_boot_console.run_command('bootstage stash %x %x' % (addr, size))
+    output = u_boot_console.run_command('echo $?')
+    assert output.endswith('0')
+
+    output = u_boot_console.run_command('md %x 100' % addr)
+
+    # Check BOOTSTAGE_MAGIC address at 4th byte address
+    assert '0x' + output.split('\n')[0].split()[4] == hex(bootstage_magic)
+
+    # Check expected string in last column of output
+    output_last_col = ''.join([i.split()[-1] for i in output.split('\n')])
+    assert expected_text in output_last_col
+    return addr, size
+
+@pytest.mark.buildconfigspec('bootstage')
+@pytest.mark.buildconfigspec('cmd_bootstage')
+@pytest.mark.buildconfigspec('bootstage_stash')
+def test_bootstage_unstash(u_boot_console):
+    addr, size = test_bootstage_stash(u_boot_console)
+    u_boot_console.run_command('bootstage unstash %x %x' % (addr, size))
+    output = u_boot_console.run_command('echo $?')
+    assert output.endswith('0')
-- 
2.25.1

