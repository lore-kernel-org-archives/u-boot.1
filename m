Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D843E75455
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 13:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B1CC8634D;
	Tue,  3 Oct 2023 15:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5IJ2Qp3v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 345288721A; Tue,  3 Oct 2023 15:12:56 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AE0786D20
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 15:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYIFONuxCxz2gbd9NDlf2UFp6465U4EHUv5f8ctk/bJ9lUOlQEqV2AJBLmLCeIQHnGmBglaiUppUe/COo7w1BC7oHuyd34g8qut/wCu0S46bEM2lZT3zjxpxRYlmrARFb2VN59rdygVmnum4Hum9yNfdS3OpcnEeACRiwcQix3soM7bc8q3YQgi19/I8fKpr6ussQCTzrSEuHwnTM1BlL0wUxjiffHNgqHS2Av++PsC5plIIdV2Kg6olByZ7zSZn3tkyNwBMWxdVwUgHjeGhA4w7UkIGJV+4D8ETt0WJuq++U2ueI4IkfL4ATbwYztH41xVlHE3fANOPY8OVlsWOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmVBzow8akbOBOCInU5dN3/0CyxnB0LM/lughRUT2QI=;
 b=ZrdfAxkmifa2mf5YRt2EjgjnZj62sJgJBBrwIXREb7rNfu5PPsenzemGiGn+LMBjfqsjpc62XYoC3cxF4PJtIHKA73v7MyO7xmIPkJujKGVLPtf+V+TXscpCUsHE4BhqIgUYHmugmK2bONS3Z4aInU7HlWtUDoj34tEMBvwuHkp0pl6zVEvOzoDIfBTokuRFnLnFr5ZSAZtGjOTj0ce6zYlUHwLKnp7L7tGoVigN2fPQfKaj80KpQz5mwB20OdXZ8u5KxiZf7nYb0gdRNHXODpnhyI2yopXNgFMmNQx361hFiNIwQ0Mr0FZ+uTkz13YE1Yb9yvArdems1QdHfNyiTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmVBzow8akbOBOCInU5dN3/0CyxnB0LM/lughRUT2QI=;
 b=5IJ2Qp3vk86mo4Dgf16JyUgGA9xbDpa4DW81evloTWqh346uNQ/dhXigm2a22dQEWv9lwbVyTLNkOZBvcs9k1JNapSp/JTPbTEb0h8rl5bUefdUZ2R7DP9aHoCZSPwHYKPp4fs1Dzb0EY9MMxbtoLuzpZN58fpIZb2eNZ2SGUOo=
Received: from CH0PR03CA0201.namprd03.prod.outlook.com (2603:10b6:610:e4::26)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 3 Oct
 2023 13:12:51 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:610:e4:cafe::da) by CH0PR03CA0201.outlook.office365.com
 (2603:10b6:610:e4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Tue, 3 Oct 2023 13:12:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 13:12:50 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 08:12:49 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 06:12:49 -0700
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 3 Oct 2023 08:12:47 -0500
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>, <rfried.dev@gmail.com>,
 <v.v.mitrofanov@yadro.com>, <seanedmond@microsoft.com>,
 <emohandesi@linux.microsoft.com>
Subject: [PATCH] test/py: net: Add a test for 'pxe get' command
Date: Tue, 3 Oct 2023 18:42:46 +0530
Message-ID: <b5d263cf61282b158052ba87bde1fb4a227c0bb7.1696338593.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|IA1PR12MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d528812-7ba6-4700-5730-08dbc41271f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vkp17hdLNZOnzVWhiOkyGucfrcEnlJMY2EtYiIr4b2melmUzkmzweL0KUEJCPLkKqCwVA5/y38GnnYa+O8GuK3AgOxkxBQAfwc0jV93fbzNU6+qptnMazBeot007coBVz0GSmQKEiMbNuEQ1PXK4XgkA1L9FAKqarbO6MjrgY8XsL+t83DsykIz4Xap6a8YEdJjsOdBcVcIMROce8/YT2dmGBD8OHEgInfqCI6RT2fTjjFzZ7kdX3kAu4D38i6IjOFdVQCSwq6pPJEl+xa+m5uWoQxwgF/BnkMzot5yV3FLLmjRu2vJO7uBIwVkfYJGxkIWYOJNSz4FX6G1T3ftZBRVnTqeEfVlL9ejbrIVKsIEye0S1YAUR+HQs6qPhjah1RhicLg8aNpyQDnhCdl7geBIKMxjwfZ1draYMFXZgPx8BHAmgTAkaAcSHb/Cnjf6m+d1nQmU0rfP7ovBkOLISDICq9nNcqsxU5swxnDLMI99iXajuOH8Zz4sZYTY04pHpaipMiCB4MDRNCn6bgDVZXntYuAIkYmq0H3qAsNBZywkvR1A6D+QnUkNZAx4hGszdRB9s6uW1IHOunBuKUeI+ojrOABgFnIlRmpvE7fJ2BuuWPELq3ORJkvU2K8XhDJRSwMObBlX6/Up+UvsFfsBD83MDfd7CTF0i79uo034t1U29naMjz7y+ucbq4JX4qfr8CWjNXcdLbVqWniI7xAUeeulVdd9DcY9x3DjhRQJ69AVg1nWdhZ3K1p+JjbrkBOpQDEqn7pGUmjYDt2pzl+Jv0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(451199024)(64100799003)(82310400011)(1800799009)(186009)(40470700004)(36840700001)(46966006)(2616005)(70586007)(40460700003)(41300700001)(356005)(6916009)(2906002)(336012)(44832011)(40480700001)(316002)(5660300002)(36756003)(81166007)(83380400001)(8936002)(8676002)(70206006)(4326008)(426003)(86362001)(26005)(54906003)(66574015)(47076005)(82740400003)(36860700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 13:12:50.1435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d528812-7ba6-4700-5730-08dbc41271f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543
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

Execute the 'pxe get' command to download a pxe configuration file from
the TFTP server and validate its interpretation.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 test/py/tests/test_net.py | 66 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
index cd4b4dc53cbc..b2241ae6a482 100644
--- a/test/py/tests/test_net.py
+++ b/test/py/tests/test_net.py
@@ -6,6 +6,7 @@
 
 import pytest
 import u_boot_utils
+import uuid
 
 """
 Note: This test relies on boardenv_* containing configuration values to define
@@ -61,6 +62,16 @@ env__net_nfs_readable_file = {
     'crc32': 'c2244b26',
 }
 
+# Details regarding a file that may be read from a TFTP server. This variable
+# may be omitted or set to None if PXE testing is not possible or desired.
+env__net_pxe_readable_file = {
+    'fn': 'default',
+    'addr': 0x2000000,
+    'size': 74,
+    'timeout': 50000,
+    'pattern': 'Linux',
+}
+
 # True if a router advertisement service is connected to the network, and should
 # be tested. If router advertisement testing is not possible or desired, this
 variable may be omitted or set to False.
@@ -260,3 +271,58 @@ def test_net_nfs(u_boot_console):
 
     output = u_boot_console.run_command('crc32 %x $filesize' % addr)
     assert expected_crc in output
+
+@pytest.mark.buildconfigspec("cmd_net")
+@pytest.mark.buildconfigspec("cmd_pxe")
+def test_net_pxe_get(u_boot_console):
+    """Test the pxe get command.
+
+    A pxe configuration file is downloaded from the TFTP server and interpreted
+    to boot the images mentioned in pxe configuration file.
+
+    The details of the file to download are provided by the boardenv_* file;
+    see the comment at the beginning of this file.
+    """
+
+    if not net_set_up:
+        pytest.skip("Network not initialized")
+
+    test_net_setup_static(u_boot_console)
+
+    f = u_boot_console.config.env.get("env__net_pxe_readable_file", None)
+    if not f:
+        pytest.skip("No PXE readable file to read")
+
+    addr = f.get("addr", None)
+    timeout = f.get("timeout", u_boot_console.p.timeout)
+
+    pxeuuid = uuid.uuid1()
+    u_boot_console.run_command(f"setenv pxeuuid {pxeuuid}")
+    expected_text_uuid = f"Retrieving file: pxelinux.cfg/{pxeuuid}"
+
+    ethaddr = u_boot_console.run_command("echo $ethaddr")
+    ethaddr = ethaddr.replace(':', '-')
+    expected_text_ethaddr = f"Retrieving file: pxelinux.cfg/01-{ethaddr}"
+
+    ip = u_boot_console.run_command("echo $ipaddr")
+    ip = ip.split('.')
+    ipaddr_file = "".join(['%02x' % int(x) for x in ip]).upper()
+    expected_text_ipaddr = f"Retrieving file: pxelinux.cfg/{ipaddr_file}"
+    expected_text_default = f"Retrieving file: pxelinux.cfg/default"
+
+    with u_boot_console.temporary_timeout(timeout):
+        output = u_boot_console.run_command("pxe get")
+
+    assert "TIMEOUT" not in output
+    assert expected_text_uuid in output
+    assert expected_text_ethaddr in output
+    assert expected_text_ipaddr in output
+
+    i = 1
+    for i in range(0, len(ipaddr_file) - 1):
+        expected_text_ip = f"Retrieving file: pxelinux.cfg/{ipaddr_file[:-i]}"
+        assert expected_text_ip in output
+        i += 1
+
+    assert expected_text_default in output
+    assert "Config file 'default.boot' found" in output
-- 
2.25.1

