Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCD6C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 14:37:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C8DC87CC4;
	Fri, 19 Jan 2024 15:37:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WNNtAyRt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA25787CCF; Fri, 19 Jan 2024 15:37:30 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 421F387CC1
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 15:37:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYBXrntqHdMdw4U3dmhYXbGp2GcNFxQSUwRDoo3D1PrvGusSX+cxnWZCbjkcO0n806mB+XtuNiWhewsp6DaAPz+o7s+l6t6U4jGFlGuUpVtY2sLEEJNlExKz+SF1zjrFmL5q6Vb9GTjqO7jaQLxNyYVG9vPb2WJmBse57wuqduve0sSxIcMR2ZLlWj5YJXHFzDa0ldnJaJr27qj5LF9+F20XJgi4UYIe/vrq9XLHmuW5CygOV2x9lCDo/OcLJflapIL7kRID8EkLPZliyHSAx9yIpWITnoSss8h3w/3wFY2m5mfKjB1bp43afCaBs2cVPXsTiGXfd3EFFTy5Cqe4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZktnwFtrS8m5h/HWi8o9WurrwlAibSeTmaFWEDmMT8=;
 b=PY1ir2mHeDaq+2jYnQF0FEFmKg4Ku+bfqbfZy3IEp06GUdBqVfH5qNkogT6TrLjAKxK+3Xb4RV2GI0ibcgWyYafK0QK9DMv7ouB6JSE/sY/C/sTyHrMTD7LTZNGfD5LchgHt5R74nnOcRjX7daygovsdrQ4zDhwrE2wh8VKn6jTPcl64jLg+iIj8HlnN82E/uTMcJ048L5Q2rbWoRUtLL64hwMEPBAHi7WMVO/pk3H8J84LkhomPDKlMEPLKlfwcUSxpOTsU5nNmPg8G5TLfnLoed17Df1SrdyWvZHbDuLfqnBEkVoZGNDl+vAkFfT4lWDlkSmv+XQNF9hhubS3PGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZktnwFtrS8m5h/HWi8o9WurrwlAibSeTmaFWEDmMT8=;
 b=WNNtAyRt5SDubxrEKm3LHs1mBqadhRdbK9Wz0d0nBXEX04xWwyxz21mUs1g7O6f18B/HtZQLWlJuSqYsbNAZE+RHNtqNAfyVkqjhPVS7QQBUkV9isIHbZ/bk1ASOWuJLgYlxoBwe/d+lSPA2ctYlk0elZ3GVI3Ooiny3DDM9vCs=
Received: from CH0PR03CA0059.namprd03.prod.outlook.com (2603:10b6:610:b3::34)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Fri, 19 Jan
 2024 14:37:23 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::3b) by CH0PR03CA0059.outlook.office365.com
 (2603:10b6:610:b3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Fri, 19 Jan 2024 14:37:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 14:37:23 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 08:37:22 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 08:37:15 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 19 Jan 2024 08:37:14 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: scsi: Add test for scsi commands
Date: Fri, 19 Jan 2024 20:07:13 +0530
Message-ID: <3f58ca31c93ba7fa3e0981035b251a5ebcb150ec.1705663831.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: e008d480-41dd-4f47-67fd-08dc18fc2646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yg2H/SpXFuX66kdzuZGboF0K58XqRCx8gY5Q3xg1PIowCs7XLZ7cquv7Mka68P6UwnA5mJf65nhpwsS+4d9fln+zVLpIRlCPC9nFCU2FOBtEA5J9L4rGZ24UZxcz4NMx+w7nM7I2Jo1z03O5nxpfVwbbZAtbZ3XpEombu9r4tAza8Avbg2k6rawbzLHZl0J3kJUEdpW/u8lAWsDOOtKhXWlBOCi8ulAcLZYgbyffl14qyZ9Dvy76eKdATiCtw4KN6mQWm2QFuDeQK1Pr5w8lW0zwBVC4aS4VrhCaVb/lv8hyD2E483TDOqNkwbvu1JdU9dAHqC+PzRVyoiJqtVkhLyXQuinZXxY1NEl0XRw6rlGZMyhWB2tipWOfZM2aO9HnyrR0lcuAvsPiVm2/7gLTp+fFCkUr7V+tWwB6CnP9FzKTaZhwcupw8u18h+HF4Per/mOJsbaJBSxKJBPZRSfWehQc+ePw/bPUlKvWCQ8n4wafH0MXsVG/Jw6dYqYiLGP7vP+Weaj5/H98H5vcMXCiXwx+j5E3s7TZDoEB2MRCsVoj10q2CqBJa/lGAIMNyKxkV5EzvZGGZk0O0NDIZWf7+UEvust528aMvYsmigykQpV2z7Ab6p6WaKXFVFyWofnVC08EVN4m0kKFVpUKiQUNLuxRo/bcMbxKLRlRSN6sAe6x6PWTSzl+wyrwU2OG7bfygaVO7In7GUIQtN9JcVOa+xOiqJ9eiYdGJZzo6u15O/UUgfHkYJYWWK12cskqTqh5jPJnoeOwSYZeS+bgu05fxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(82310400011)(1800799012)(64100799003)(451199024)(186009)(46966006)(36840700001)(40470700004)(41300700001)(5660300002)(8936002)(2906002)(70206006)(40460700003)(40480700001)(6916009)(70586007)(478600001)(54906003)(316002)(8676002)(47076005)(336012)(26005)(426003)(2616005)(44832011)(107886003)(4326008)(356005)(82740400003)(86362001)(36860700001)(81166007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 14:37:23.1803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e008d480-41dd-4f47-67fd-08dc18fc2646
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983
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

Add a following test cases for scsi commands:
scsi_reset - To reset SCSI controller
scsi_info - To show available SCSI devices
scsi_scan - To (re-)scan SCSI bus
scsi_device - To show or set surrent device
scsi_part - To print partition table of selected SCSI device

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 test/py/tests/test_scsi.py | 92 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 test/py/tests/test_scsi.py

diff --git a/test/py/tests/test_scsi.py b/test/py/tests/test_scsi.py
new file mode 100644
index 000000000000..be2e283e7d25
--- /dev/null
+++ b/test/py/tests/test_scsi.py
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: GPL-2.0
+# (C) Copyright 2023, Advanced Micro Devices, Inc.
+
+import pytest
+
+"""
+Note: This test relies on boardenv_* containing configuration values to define
+the SCSI device number, type and capacity. This test will be automatically
+skipped without this.
+
+For example:
+
+# Setup env__scsi_device_test to set the SCSI device number/slot, the type of
+device, and the device capacity in MB.
+env__scsi_device_test = {
+    'dev_num': 0,
+    'device_type': 'Hard Disk',
+    'device_capacity': '476940.0 MB',
+}
+"""
+
+def scsi_setup(u_boot_console):
+    f = u_boot_console.config.env.get('env__scsi_device_test', None)
+    if not f:
+        pytest.skip('No SCSI device to test')
+
+    dev_num = f.get('dev_num', None)
+    if not isinstance(dev_num, int):
+        pytest.skip('No device number specified in env file to read')
+
+    dev_type = f.get('device_type')
+    if not dev_type:
+        pytest.skip('No device type specified in env file to read')
+
+    dev_size = f.get('device_capacity')
+    if not dev_size:
+        pytest.skip('No device capacity specified in env file to read')
+
+    return dev_num, dev_type, dev_size
+
+@pytest.mark.buildconfigspec('cmd_scsi')
+def test_scsi_reset(u_boot_console):
+    dev_num, dev_type, dev_size = scsi_setup(u_boot_console)
+    output = u_boot_console.run_command('scsi reset')
+    assert f'Device {dev_num}:' in output
+    assert f'Type: {dev_type}' in output
+    assert f'Capacity: {dev_size}' in output
+    output = u_boot_console.run_command('echo $?')
+    assert output.endswith('0')
+
+@pytest.mark.buildconfigspec('cmd_scsi')
+def test_scsi_info(u_boot_console):
+    dev_num, dev_type, dev_size = scsi_setup(u_boot_console)
+    output = u_boot_console.run_command('scsi info')
+    assert f'Device {dev_num}:' in output
+    assert f'Type: {dev_type}' in output
+    assert f'Capacity: {dev_size}' in output
+    output = u_boot_console.run_command('echo $?')
+    assert output.endswith('0')
+
+@pytest.mark.buildconfigspec('cmd_scsi')
+def test_scsi_scan(u_boot_console):
+    dev_num, dev_type, dev_size = scsi_setup(u_boot_console)
+    output = u_boot_console.run_command('scsi scan')
+    assert f'Device {dev_num}:' in output
+    assert f'Type: {dev_type}' in output
+    assert f'Capacity: {dev_size}' in output
+    output = u_boot_console.run_command('echo $?')
+    assert output.endswith('0')
+
+@pytest.mark.buildconfigspec('cmd_scsi')
+def test_scsi_dev(u_boot_console):
+    dev_num, dev_type, dev_size = scsi_setup(u_boot_console)
+    output = u_boot_console.run_command('scsi device')
+    assert 'no scsi devices available' not in output
+    assert f'device {dev_num}:' in output
+    assert f'Type: {dev_type}' in output
+    assert f'Capacity: {dev_size}' in output
+    output = u_boot_console.run_command('echo $?')
+    assert output.endswith('0')
+    output = u_boot_console.run_command('scsi device %d' % dev_num)
+    assert 'is now current device' in output
+    output = u_boot_console.run_command('echo $?')
+    assert output.endswith('0')
+
+@pytest.mark.buildconfigspec('cmd_scsi')
+def test_scsi_part(u_boot_console):
+    test_scsi_dev(u_boot_console)
+    output = u_boot_console.run_command('scsi part')
+    assert 'Partition Map for SCSI device' in output
+    output = u_boot_console.run_command('echo $?')
+    assert output.endswith('0')
-- 
2.25.1

