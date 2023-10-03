Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F27E75435
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 09:02:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4494B871E1;
	Tue,  3 Oct 2023 11:02:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fAnV7NBP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0782871DE; Tue,  3 Oct 2023 11:02:33 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71A1D871F1
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 11:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhBgG3TNT3dORapQMLwaeHMAeIo3eJP/ApjnxVqA2oupnQg8T6MOYnhdugCoESXkx22W40trv02TpNq3467FdUknSdfEJkX8vmFQUTq9MwP7AnVhyVSDPm3qGp+AShZiZBdBDKSRabsh6S8nkLaraOeDV8JAd/tyZjakriDaxVcLJTp7n0YCjH3DG2+FVG8cfikL9eAnKeOJb6WRfON3vZqm7+TbgsaA5H0ouWaXS1m99hPJMh/EWwDeYfSYz126HIKIdsTxqvt9JqDi8eCztCRGgPTIX7tuw8u4pTwlgAXFhvUAGzjgM1K0H26cMIUknIeSNE1y9nqa5CTBaNtUOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3m1E78t5B442LGf4HuUAsuy7YUSDuaLWKvvVmeggCU=;
 b=gC0WZCrxwDmyfa/DWimd2xCGu03bd2WXb/0UQ2xsC9dvhPfDzY5OrzbElb8jj32sCBr9UstWVsoYrt4BLPvP6LnMbaLrb5DkplY8vd9w7g3POVz6Kl2sH1bDe7Q4r4p9o4oFb2gtpjmr0ICxoHRCTPC5mWdRjRyn4qrLKQptBRNu2G+/GiK0HsUSnzgTPkODmV6rYd3afoV7ZpnmaZkL4vd0A0Qu/Y7ihES5nkQuJmERDFej5TzGPOciSnwjREUEBNjl7OccLcn76Pl8CFFPLelIu1zZH2RhMy8DYOja/6Drhi0UZsBHB+m3tB0qhSgnYfgOflWNZa5tS2ruZtvNbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3m1E78t5B442LGf4HuUAsuy7YUSDuaLWKvvVmeggCU=;
 b=fAnV7NBPvxyR/vOB+kBy+/dHYOrR0r4HMkGDGqt1rp0NLSB8l3D/DxrzLjNLwkOFVxEHbPuR81PW1XHJ1wyuIzMsynFUTu/mIhvHQbfv7tPmkRjYdoyQqidz76oOI4oGbEq3cwiA/oXAv0uL6uYKG0pvzzD206Oe04QqHkJlaJ4=
Received: from PR1P264CA0014.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19e::19)
 by DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Tue, 3 Oct
 2023 09:02:26 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10a6:102:19e:cafe::26) by PR1P264CA0014.outlook.office365.com
 (2603:10a6:102:19e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Tue, 3 Oct 2023 09:02:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 3 Oct 2023 09:02:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 04:02:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 04:02:10 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 3 Oct 2023 04:02:08 -0500
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>, <rfried.dev@gmail.com>,
 <v.v.mitrofanov@yadro.com>, <seanedmond@microsoft.com>,
 <emohandesi@linux.microsoft.com>
Subject: [PATCH] test/py: net: Add a TFTP put test
Date: Tue, 3 Oct 2023 14:32:08 +0530
Message-ID: <f67478ee2642e6c598da4364f84c3bec900f89c3.1696323438.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 506c3fbc-8a7a-42a5-d701-08dbc3ef75e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ji4GpCKNGuO/AgVMMJsdNELDC+Nfl5MADHWtmFDHWcJMHwecnY3CNBdrQ5IBfEUAgm0z9cqygntyBbO90oKSXWVdvBBJJDvzzr7Yk28qsfuVVZmTpPlxkrYwjh4ecKidI244gbzFFRRoo7Rdk8XtpzkM7HVZVI9m29KKoRe3IBJiekcq5ixZDb9/YLEyZ3NHQP8UPYzP2GtsIfWfpU4Z+WM+lwkr8rhC8ceTRAPdF55OGje9KcYlz7i8+GsQnrX71XJQmIFir5FV+w+sucxxWqo3mKZspOFlp6dS0ZHQm82neNR/gCsc0/CTDqqzmk82GnlXXulQzBtxkpxemxOhdDklg95VOQjOiUTvu8aUA9DEXGdVPN0viywDvV4K5xTwIWW6TqsQyWeDQ+BhbPshbZ/n4CGJd9m5ZsNdpDRO9yOWhYgPMyco6rfZgNCWbNLV4vFBK46SZG9++ydV1/bHchE3vv1sGfTleWhEo2VgELFmhGVju4xYxj9Qj2v5t90y5fpVvdyvGTGgqtzIEy2KsC/grYZriigSqfg0BJguAUGv6yaNhHiT4cwmwbjDrG6E3UNG5XY9fA1kHAkOZdkzeflc2irxgwj9VwGb0O73YDomrVZ3y+vus2aFfLjeB5wpe+wYh7Lz7zIzAEFjF+nsWY6hM0L0fQ3Mwd7xuowmtwr6w+qx1arOSSv9GGN2C3wGNcJXWaOMyrAeKRN8vGoZXK0qXOFXTX3hR8Wh1pE//wm/0wDbiac98vRPSOOu9iXb4Gpgn3Jt4CCCmdOyJBfrsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(81166007)(356005)(40480700001)(40460700003)(44832011)(5660300002)(2906002)(6916009)(4326008)(41300700001)(316002)(36756003)(8676002)(8936002)(36860700001)(70586007)(86362001)(82740400003)(47076005)(478600001)(70206006)(426003)(54906003)(26005)(336012)(2616005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 09:02:24.4832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 506c3fbc-8a7a-42a5-d701-08dbc3ef75e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231
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
 test/py/tests/test_net.py | 69 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
index cd4b4dc53cbc..f69e3ea2dbba 100644
--- a/test/py/tests/test_net.py
+++ b/test/py/tests/test_net.py
@@ -6,6 +6,7 @@
 
 import pytest
 import u_boot_utils
+import datetime
 
 """
 Note: This test relies on boardenv_* containing configuration values to define
@@ -50,6 +51,7 @@ env__net_tftp_readable_file = {
     'addr': 0x10000000,
     'size': 5058624,
     'crc32': 'c2244b26',
+    'timeout': 50000,
 }
 
 # Details regarding a file that may be read from a NFS server. This variable
@@ -260,3 +262,70 @@ def test_net_nfs(u_boot_console):
 
     output = u_boot_console.run_command('crc32 %x $filesize' % addr)
     assert expected_crc in output
+
+@pytest.mark.buildconfigspec("cmd_crc32")
+@pytest.mark.buildconfigspec("cmd_net")
+def test_net_tftpput(u_boot_console):
+    """Test the tftpput command.
+    A file is downloaded from the TFTP server and then uploaded to the TFTP
+    server, its size and its CRC32 are validated.
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

