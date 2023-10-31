Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F31EC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 12:52:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D2B687C76;
	Tue, 31 Oct 2023 13:52:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RUzcvSs4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDEDD87C77; Tue, 31 Oct 2023 13:52:41 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C63387B4F
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 13:52:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLqMTC/AXIrB8vwJKdnHws8218qV5tAEsNEM9Oy/JgkJcLa/UsETtmejJu2E/Z879hRA+6mAZG0V0F/JlXgKln15hIOGMh+vmRPuutDPO0PmnrEYuWoAtevTwZqBGlDYvycSvRxEnUVpzIide/nsc1SB09e3+pApEc1hX1njiMreJrvh7F9bt4FaGy3bCP0nUh/78ToQcioJrnRHAthw7MXL/S4aPfNrq2+TIIVpQ1Rr0TBA1ukdHXap1obArJkqI+aIzzbxDGWIYakHxMmu6La+7/g1mO/Zj+saoEBq5/UYGCFmXTdpgyb6ZJiz3/StL2zE+OdOQtkNR4RkNtCktg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9np4wfW3Km0OQVga98U5iVIIvT26Tusf3WSzQkYkyfk=;
 b=WfUfirJSkwlGAiCf4FdzpouE6VhEWLsQRnmSin4dsJ5tFuXFzgBYzZ+FASF0uSsk4b7z05TSF7tsVILKimg2EUl31ADfS366ZjBPIWqmMMiz/g+eay27mwI9YN+CKolNx7QInRFgpkaOf1pWain8Za8V8vcHqJPzsInRMCijWT77vXX5xs1rsWuaLB//8l+ZwmUb3KhXXWW5cIVvsm1YwHguwntrYN3xzl85sUfa46VuMLEfj4xARLOPVU5xFEQy+ZkPLU3XTP7FeNIz8UaQ+UBBcYdrO87Iu97stv4JA8yASP464iqh6T9MucyZ4bhvyhNf81kdbUAL43FyQpCrGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9np4wfW3Km0OQVga98U5iVIIvT26Tusf3WSzQkYkyfk=;
 b=RUzcvSs4t6rEWKPy+63sG8WWRjY0mC9V8xabXITNfGn2/9vYAWKHZTqPvRFC9tdpm2qdMLznXuV00PSgSRytEUYU2dpPeku89EaYkE8rA5/GQT9ArlqRqZwJoPtA9JpjOYHuXAS0ddY/NG7usRj/qbj2VRa5Jpyls5qP89Ib/9k=
Received: from SN1PR12CA0110.namprd12.prod.outlook.com (2603:10b6:802:21::45)
 by CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 12:52:34 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:802:21:cafe::5a) by SN1PR12CA0110.outlook.office365.com
 (2603:10b6:802:21::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27 via Frontend
 Transport; Tue, 31 Oct 2023 12:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Tue, 31 Oct 2023 12:52:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 07:52:32 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Tue, 31 Oct 2023 07:52:30 -0500
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>, <rfried.dev@gmail.com>,
 <v.v.mitrofanov@yadro.com>, <seanedmond@microsoft.com>,
 <emohandesi@linux.microsoft.com>
Subject: [UBOOT PATCH v2] test/py: net: Add a TFTP put test
Date: Tue, 31 Oct 2023 18:22:29 +0530
Message-ID: <cee2db4bbaf9656499f7f7dbf29b1b6738822d1a.1698756564.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|CYYPR12MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 374d705a-557a-4d14-d67f-08dbda10400b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +UGi2q5n+V/cn2HqFx94B1VO34X08ZtpknUEQyMwHKG4vlV61gNdENmDMyLxcENerD3bian7X6o+DSP6p8HURAfdIIHlexXtLgaz8mniJuE/jXOPfvYdCtcBSXV1R/0J5M04+NXfY1r1LzY3q0mtziksb49qIlEShk9GWKpCRd2hO5U1+5AnkLuH61Rw6zvERorXc/5UM3WEapBl2Xyf1UKApO1pLcuhAP/N8YbbGY8lpYg7g/wtLmEUOP8hoEuvpTqutfrsKMWeZbhmraysZchv+lRwp//Nq4tTjSRE9ANmdLf8WYE+CPLCP+FCEVCOHIXISsuflSzXwS6NSAa3Qc9UKXal6v/Buz6IO/o/yW0Otxbyq9zp0NhfztEhlMXXE8aWYn49P5qWnbeKiaA02fFMNjBcVudJ/pdPEYft0C9XEMvk/wWnC13dKHU3CCveHjyWi5vLfhzaFC+JdsL81oQSToHZ+nUhxYkdk7rJ9/jCx7cUIr42eD4omo8tybSHTAqi2494tmg9TrQloSy2cvt/4TCxA0tmi5SqEQqX0S8LuBmgZMR8DMxHwIYqjf7NEujXkGY8od/V7A3V6YkspqXgYt1T4jl2X0WZ0gHmsIyRasGYzFsTCTLEbHOWpSJGXKaIX24c36gYqlVwGqAe/mICikMGcyWtEU+f5nAFjIuM26wqr8XRnKrJA89MN8ic+wP+VUAaYM0ggyMflFX4qJBfaF8QfE/z5qVcQu6bTidIelTCSi7/o6+a/Q7TMltqAJ5NeSdpYhIHcGtGNophVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(36840700001)(46966006)(40470700004)(36860700001)(47076005)(83380400001)(2616005)(26005)(336012)(426003)(86362001)(36756003)(82740400003)(356005)(81166007)(40480700001)(478600001)(2906002)(70206006)(70586007)(5660300002)(44832011)(4326008)(41300700001)(8936002)(8676002)(40460700003)(6916009)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 12:52:33.1281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 374d705a-557a-4d14-d67f-08dbda10400b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855
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

Execute tftpput command for uploading files to a server and validate its
size & CRC32.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
Changes in v2:
- Add marking for cmd_tftpput config
---
 test/py/tests/test_net.py | 72 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
index b2241ae6a482..fbb11b640ae8 100644
--- a/test/py/tests/test_net.py
+++ b/test/py/tests/test_net.py
@@ -7,6 +7,7 @@
 import pytest
 import u_boot_utils
 import uuid
+import datetime
 
 """
 Note: This test relies on boardenv_* containing configuration values to define
@@ -51,6 +52,7 @@ env__net_tftp_readable_file = {
     'addr': 0x10000000,
     'size': 5058624,
     'crc32': 'c2244b26',
+    'timeout': 50000,
 }
 
 # Details regarding a file that may be read from a NFS server. This variable
@@ -326,3 +328,73 @@ def test_net_pxe_get(u_boot_console):
 
     assert expected_text_default in output
     assert "Config file 'default.boot' found" in output
+
+@pytest.mark.buildconfigspec("cmd_crc32")
+@pytest.mark.buildconfigspec("cmd_net")
+@pytest.mark.buildconfigspec("cmd_tftpput")
+def test_net_tftpput(u_boot_console):
+    """Test the tftpput command.
+
+    A file is downloaded from the TFTP server and then uploaded to the TFTP
+    server, its size and its CRC32 are validated.
+
+    The details of the file to download are provided by the boardenv_* file;
+    see the comment at the beginning of this file.
+    """
+
+    if not net_set_up:
+        pytest.skip("Network not initialized")
+
+    f = u_boot_console.config.env.get("env__net_tftp_readable_file", None)
+    if not f:
+        pytest.skip("No TFTP readable file to read")
+
+    addr = f.get("addr", None)
+    if not addr:
+        addr = u_boot_utils.find_ram_base(u_boot_console)
+
+    sz = f.get("size", None)
+    timeout = f.get("timeout", u_boot_console.p.timeout)
+    fn = f["fn"]
+    fnu = "_".join([datetime.datetime.now().strftime("%y%m%d%H%M%S"), fn])
+    expected_text = "Bytes transferred = "
+    if sz:
+        expected_text += "%d" % sz
+
+    with u_boot_console.temporary_timeout(timeout):
+        output = u_boot_console.run_command("tftpboot %x %s" % (addr, fn))
+
+    assert "TIMEOUT" not in output
+    assert expected_text in output
+
+    expected_tftpb_crc = f.get("crc32", None)
+
+    output = u_boot_console.run_command("crc32 $fileaddr $filesize")
+    assert expected_tftpb_crc in output
+
+    with u_boot_console.temporary_timeout(timeout):
+        output = u_boot_console.run_command(
+            "tftpput $fileaddr $filesize $serverip:%s" % (fnu)
+        )
+
+    expected_text = "Bytes transferred = "
+    if sz:
+        expected_text += "%d" % sz
+        addr = addr + sz
+    assert "TIMEOUT" not in output
+    assert "Access violation" not in output
+    assert expected_text in output
+
+    with u_boot_console.temporary_timeout(timeout):
+        output = u_boot_console.run_command("tftpboot %x %s" % (addr, fnu))
+
+    expected_text = "Bytes transferred = "
+    if sz:
+        expected_text += "%d" % sz
+    assert "TIMEOUT" not in output
+    assert expected_text in output
+
+    expected_tftpp_crc = expected_tftpb_crc
+
+    output = u_boot_console.run_command("crc32 $fileaddr $filesize")
+    assert expected_tftpp_crc in output
-- 
2.25.1

