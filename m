Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757F5C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 07:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EE2F87655;
	Wed,  8 Nov 2023 08:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XU7iv3Yr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E58808767E; Wed,  8 Nov 2023 08:10:45 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::608])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D285387576
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 08:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9krEoHdghbDRv/A05rhurY1/la9XO6j8ZaQKJQiT0vThfeIewfAffSaxe/XUDl3ub6f0RpO1nMPzaCc+v3pYs0QzrO4UxyMb2BpTs8+WQLFqefWubF5vwmCIHSftztTUq1cV/aUgWf0/JraAX6axyMGpoRTDNGdPrUfciN5XM8VGz6z4vet1KlsyG622ZlQ4Ly2LGvVWL8FhY/wkVJ0InXRwbXPwrr/LCOPt4S+SxqHffYsefCVPMfqhlqqgLe2BD+6E7mh6nIpE+ItjRP+FQ00LUAJ+omn7qJBXtup9MtzDdmNkmztTdo53AwGpp9g0JwADKee22Yk2wv4CpR9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mw3QcVNWId1chdCvnKn/nuvrYwI/QggtBMbod5RedHY=;
 b=GQumiSml48q/NTuiu7SgMlTgnnRTtvra4JgBZaluDgBbPrV2zdIU2ufVajxPctLWG8w1gt0k1mucnW4SjSPvgol9ZhsBj5KoFGVTUC3UlTXgKQ2ysi+JMhf8hK0DgMdSW11TrYawtU94q7zmcwO1vrclb5/y83eA3KjUEw2FWsnwABqvG6DLygCYnPFI0xmdd6SpKibWefZA65V0je+5//Rsaa4b9Z5EFsyr10j02vqWkFmUGXJolvXBIeXeO9gwhA5m08zWNh3bTKKz/LyP7FTnAGaxtEjtYsn0oQGu/zC2eYaVKYfwyDLdS+DgKBzNBAlGn9svUZcDS78WYXdQrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mw3QcVNWId1chdCvnKn/nuvrYwI/QggtBMbod5RedHY=;
 b=XU7iv3Yrm4+5PLHFzbB0yzlGYWCzPQKrNJIpWlLWe8CVp8IbEESEcS/wH6E+hwmoYxZq9gpGkBV22jwPNvEA+N+H8FXBXyvYTTVvmnzgLKciHbVu0/xCmBjEmR8qYrgI+fdtnU8QzLREsGcGP4QXxg499TI3J6A0vMB6TS4j6eY=
Received: from MW4PR03CA0350.namprd03.prod.outlook.com (2603:10b6:303:dc::25)
 by DS0PR12MB9347.namprd12.prod.outlook.com (2603:10b6:8:193::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 07:10:39 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:dc:cafe::67) by MW4PR03CA0350.outlook.office365.com
 (2603:10b6:303:dc::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 07:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.0 via Frontend Transport; Wed, 8 Nov 2023 07:10:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 01:10:37 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 01:10:33 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Wed, 8 Nov 2023 01:10:31 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>, <rfried.dev@gmail.com>,
 <v.v.mitrofanov@yadro.com>, <seanedmond@microsoft.com>,
 <emohandesi@linux.microsoft.com>
Subject: [UBOOT PATCH v3] test/py: net: Add a TFTP put test
Date: Wed, 8 Nov 2023 12:40:31 +0530
Message-ID: <9410fb15f6a4bb50ef4c5934fbb2dbf22fbe51c4.1699427321.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|DS0PR12MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: 46a91605-14b1-47d0-25a3-08dbe029cfe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jn7IQNWl70ltFs/53sP/Yjgwj4mE5Mrj6g3KLWeit5sFUhmoGox8IszpDGOjjgoRbYpf7SMY9MH+4oyxccJf3ToiprM5s1RfHswGbOEwnJS+OFv690luetSmpKJAMrFHFc+z7UsnnwtQmCtdIUVZYfg5D4LKFA4+e2S9CK4E9EhdUy+ks0WSnFFAKj8Ic9VowNspfWsdhG3k5oiZunE2+zEYaFqnLKdfE64BNG9QXOQ1Hi4t+wdgzT4Ri9OlNsNUc7ekLkF/d5k8D99n+Mvtj8r1rJxXtQBoDvfRdq+RymY9jDcf955wkeomTY/07Mg5FnrUYW/ag3qx1YIZ9Rw+aZRdJn0gN09ewtNIvvbO835Dj09bZOiEUdCUU5xqj54KbCzLJIZL/BU8k0+7X0r1dfaGVBBrOcR5CXELDt11ary+t2rckBGETD3EJqNh21reF626VnPhdn6TzFrHnB+guf1ipbqiYdqmEMZb7HXSgGiVpi2bjrRRvr8/OWgV1iKXlpm2LySZ4Xr7Ra6fcRh/U6+zKsz2mNvEQ5464DFBY3f3BBhdc9D7/j+wqvKvojj11p5hK/EiymkxKHzlIQStbl/cGoNiAUk+/RVCWWLoPSH/sdFKAeR+ee0z4rsNMaBCDANNe9CS12P1vRN3/LWlp8K3XiVJ/tDGp5ptKdj2M9xpYb8jiaHs+ozC7zvija6SEuNqe7aDdtqJ1eDhVYmuhEPLMkZCRDAH2zExoh0kZ1AC2r+YZ0G1NhGygjdpmE6tzNHK6QGIRlZe9A4AdtUl9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(40480700001)(356005)(8676002)(4326008)(41300700001)(81166007)(5660300002)(83380400001)(36860700001)(86362001)(47076005)(40460700003)(336012)(70586007)(426003)(82740400003)(70206006)(44832011)(8936002)(2616005)(6916009)(54906003)(316002)(478600001)(26005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 07:10:38.7938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a91605-14b1-47d0-25a3-08dbe029cfe9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347
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

Chnages in v3:
- Add filename to upload as part of env file
---
 test/py/tests/test_net.py | 71 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
index b2241ae6a482..2495608786de 100644
--- a/test/py/tests/test_net.py
+++ b/test/py/tests/test_net.py
@@ -7,6 +7,7 @@
 import pytest
 import u_boot_utils
 import uuid
+import datetime
 
 """
 Note: This test relies on boardenv_* containing configuration values to define
@@ -51,6 +52,8 @@ env__net_tftp_readable_file = {
     'addr': 0x10000000,
     'size': 5058624,
     'crc32': 'c2244b26',
+    'timeout': 50000,
+    'fnu': 'ubtest-upload.bin',
 }
 
 # Details regarding a file that may be read from a NFS server. This variable
@@ -326,3 +329,71 @@ def test_net_pxe_get(u_boot_console):
 
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
+    fnu = f.get("fnu", "_".join([datetime.datetime.now().strftime("%y%m%d%H%M%S"), fn]))
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
+    output = u_boot_console.run_command("crc32 $fileaddr $filesize")
+    assert expected_tftpb_crc in output
-- 
2.25.1

