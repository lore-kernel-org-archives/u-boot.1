Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B99FC48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 07:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF0C487CE8;
	Tue, 20 Feb 2024 08:41:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I84XAneN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F182C87CAB; Tue, 20 Feb 2024 08:41:51 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70F6D87F60
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 08:41:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAY15kSlJFCchsqi6C50QOBb+FfnCWpceaB7LWrbuHSqTf87BLLgiaO+jBqdpbUqP3anwA6NNRoI+spyZB/f8T69Lr7aw/rVhe0cvI7NnCZ7DwCQMQmIGEJJdBS9/wl4fCuB2vY32k91Sk/khUDq1vKlM02Ni2AYNGUg/jCk0ClakHzxy8nta9ucN+BitZSHwwqQ1f+0XRuM+U6rX+NoIYr+/4RSNAEL+QYi+ARrtIBbVWAexpIG4PTHrBgiQzGq0F6UF6H3S+w2VZ0ru1JLk87JykuCYINrvbwg3Da2mqTwWq843w+gMe5+fuTwh8m4cVmNezfxq8KT85JEnHnLIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kdu15y6IhDXM8HfPEWssGVSZIjFAJmvQ8JKFB55VFXs=;
 b=DzCs8mxJwMaGO79tz7r/a1a6afpY7A/GM76HUmuQg4NejHts0m2gRZIpo8PlmUGRIh8x0UGhn+xjyoFQjuCD4feaHFPN1WznKsEyv7SGmdi+R/p+1ualtG/WO+mXD9kBYuHN9umXdMhUtuEimYOVl31u6uNtQfunHuFBGsOZ2NxTjsYRe7NJVKegHqVr632ocOnUKaoiUOoQCxI31abHHzeCI9HCY7/tIGggBLP3BzyHMj3mDevTB59f9+r1BNWjFjsXuFciTx2kthlvloTZne4LYPhjFoVn6LbGPooexHTyrxMKIxyJc4CbSq9fi5XCHtNB2kdP7+II299a9Zb7rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kdu15y6IhDXM8HfPEWssGVSZIjFAJmvQ8JKFB55VFXs=;
 b=I84XAneNz0+cIGnmJTW2fMeV+3pgyPhRsZR+3i3fvh2PjfBBLQ8RAgGVDnRv5SjdeJa8FnCF3u1zQJzPtmRt6qyjAowpiXy2CQo9NdPFfbz/nd1pizH8ZFNiNoEh8RFjaZCr4iQi8ewzalGxAdLe4YAifxauAp5RIU/YkiJ0qT8=
Received: from CH2PR11CA0016.namprd11.prod.outlook.com (2603:10b6:610:54::26)
 by SJ1PR12MB6290.namprd12.prod.outlook.com (2603:10b6:a03:457::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 07:41:42 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::32) by CH2PR11CA0016.outlook.office365.com
 (2603:10b6:610:54::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38 via Frontend
 Transport; Tue, 20 Feb 2024 07:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 07:41:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 01:41:41 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 01:41:40 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 20 Feb 2024 01:41:39 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v3] test/py: reset: Add a test for reset command
Date: Tue, 20 Feb 2024 13:11:38 +0530
Message-ID: <4b7c5e82165b009cf8b28701ca3f1e182fbc3c09.1708414720.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|SJ1PR12MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee761b0-18db-4c63-23a7-08dc31e7611a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SgCQc/TNRx0OrkPeO5P/XRxGBHPqd94/X+z+uAu3ZJCEndbAdB3nke8Fhi6tu91Lb1kSf+oVyYd4Uhi/XCCyWpfr53DmPiNPSalvafJEvH2n10mjQOygaQba3z66RcXZROzjqB3h/Icf1CkEK8tI1MK2JFNGE4Oz4qGF6dzUimPGtX8MV+/XLJ1XCxsL2gPkVUCwcSc9mk6VbjC5oNCJG/UR43f0gGjdbMXt4lqZHaVl5519qUSYvP+0SPG7s9oODU5Lwt+aJtIRS6AwsBbYu4TxMQPAQnHHXMLuiXIU/p88SwG4MHO9dfJ7Ropx3qb/RFv/fyQs6ky9jiSLlynfFeYv6Ebf2deXgFhK9J6Vggdx/3Bv1fJPH18U1MeJdsRsb2zkZX9ZKhDY2bTtEKJMbPZU+4algZIYj9qjB1d91SJsYDFxmp8Zr7XcXdXhDZuLiMbp7XbpjsmU+YF9plsLBZuelu0Hk33QdkfmIpJv7mhKsJKTQuglRnaZp3ZPKkmleKb47K5aadRm+Kmu/gm/mCOhg2fq/8e7VCXJjf9jhkt6FLpbf4pS2eu/w+lkVuvEnIvKBVwygVJGWb8XaTp/orwGo2srBUmFlSLLTk70Gh+Ds1QgcYxlGKs14zmtkBhpuKTN7P6R36VfQ1qUMnR8xicpAYFDu+2JfrX7WEVw++4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(46966006)(40470700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 07:41:41.5452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee761b0-18db-4c63-23a7-08dc31e7611a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6290
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

Add a test for reset commands which performs resetting of CPU, It does
COLD reset by default and WARM reset with -w option.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
Changes in v2:
 - Set bootmode through boardenv if modeboot is not defined
Changes in v3:
 - Fix the issue with bad pattern found on console
---
 test/py/tests/test_reset.py | 61 +++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 test/py/tests/test_reset.py

diff --git a/test/py/tests/test_reset.py b/test/py/tests/test_reset.py
new file mode 100644
index 000000000000..0178b1dc40a3
--- /dev/null
+++ b/test/py/tests/test_reset.py
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0
+# (C) Copyright 2023, Advanced Micro Devices, Inc.
+
+"""
+Note: This test doesn't rely on boardenv_* configuration value but they can
+change test behavior.
+
+For example:
+
+# Setup env__reset_test_skip to True if reset test is not possible or desired
+# and should be skipped.
+env__reset_test_skip = True
+
+# Setup env__reset_test to set the bootmode if 'modeboot' u-boot environment
+# variable is not set. Test will be skipped if bootmode is not set in both
+# places i.e, boardenv and modeboot u-boot environment variable
+env__reset_test = {
+    'bootmode': 'qspiboot',
+}
+
+# This test will be also skipped if the bootmode is detected to JTAG.
+"""
+
+import pytest
+import test_000_version
+
+def setup_reset_env(u_boot_console):
+    if u_boot_console.config.env.get('env__reset_test_skip', False):
+        pytest.skip('reset test is not enabled')
+
+    output = u_boot_console.run_command('echo $modeboot')
+    if output:
+        bootmode = output
+    else:
+        f = u_boot_console.config.env.get('env__reset_test', None)
+        if not f:
+            pytest.skip('bootmode cannot be determined')
+        bootmode = f.get('bootmode', 'jtagboot')
+
+    if 'jtag' in bootmode:
+        pytest.skip('skipping reset test due to jtag bootmode')
+
+def test_reset(u_boot_console):
+    """Test the reset command in non-JTAG bootmode.
+    It does COLD reset, which resets CPU, DDR and peripherals
+    """
+    setup_reset_env(u_boot_console)
+    u_boot_console.run_command('reset', wait_for_reboot=True)
+
+    # Checks the u-boot command prompt's functionality after reset
+    test_000_version.test_version(u_boot_console)
+
+def test_reset_w(u_boot_console):
+    """Test the reset -w command in non-JTAG bootmode.
+    It does WARM reset, which resets CPU but keep DDR/peripherals active.
+    """
+    setup_reset_env(u_boot_console)
+    u_boot_console.run_command('reset -w', wait_for_reboot=True)
+
+    # Checks the u-boot command prompt's functionality after reset
+    test_000_version.test_version(u_boot_console)
-- 
2.25.1

