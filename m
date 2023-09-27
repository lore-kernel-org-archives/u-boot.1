Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A9AE810D9
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 12:24:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C659386DC3;
	Wed, 27 Sep 2023 14:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YlwI1Fsz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E3E686BFA; Wed, 27 Sep 2023 07:04:38 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC92586AEA
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 07:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEiBY4kxm/oIJ86MG5vqI+xYfKJ3TroONhWtgjqDvav0wS1/7VT7hikBXOzi/7o9vCNseQWnRv4ko8Y0q31vMYq2Qd5Mo3tTzPV1pYRgVFMGiQcjPC0UCNbFXOSAUyKKUGKXSPU6v/aRCGWmaDwl+ehgm44KCvUwGmPrPgWIfiojnICZhd8dA1HIBmoWMREK0LNvtzfBjDIdd8E5LhX3X6+oY7n2AjqCSjiNy2NflhPKx/Bq9qbYzqR4VsZHXSFelwDEz0ohbUnvkjkY6W6nR7JWihHfshyydTjrjODGhfgcv/yWZvF1OBOGFHSN0qnZIOKhAjoPil8nLXXD62wYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxLzpZQ2MtclFDjyzHAE68cp5+MK7UenUliKMsOxIhE=;
 b=KNldzjGbxcpfKoEnUZnze7d/pF9kUCcEVdexJ7N90I8HJhBDJr6l8VdNrSbucMPdibh1/EgSJWXJilXlKdilNrIkMRsl1uoAWMbDVOziGox6Gm8Y/tjT4LiYDS3YuV58z/7xtVBrg1Kc7F7Qaz5nxyU3rB9E8owskurriLjljStoZ0WQV6soCFcqjMXqXo5vw09YQ/VlYjmh2PZe5wQKXIlOnEl/gXCtb2RxrJ6kpceme/1dOzTl5IqtH2zKaiorEhy83+XYcjmc1yC1JQehnkLeaw9eQiwmdFhjT32Dqzod1Is6RUnXwF3PZvWbSi+m/2cZn7P4P/RnPAYAUhiYwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxLzpZQ2MtclFDjyzHAE68cp5+MK7UenUliKMsOxIhE=;
 b=YlwI1FsziZhrXZKPWSGpIgKhy6LbVSvGQRRgz8pDg7ATAtXeq+kXf+kzvOXdzY876iVKpAYe0Uysqzf0OYvarLDx+UGantowvrvd5/UpBaTMYCUBPUT1PL1XsK0x2mYio04ew40kBtCqN2Re80vzYTMmiKE0Xy05YD3vUJbwyds=
Received: from SA0PR11CA0070.namprd11.prod.outlook.com (2603:10b6:806:d2::15)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 27 Sep
 2023 05:04:32 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:d2:cafe::64) by SA0PR11CA0070.outlook.office365.com
 (2603:10b6:806:d2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 05:04:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 05:04:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 00:04:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 00:04:30 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 00:04:29 -0500
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v2] test/py: sleep: Add a test for the time command
Date: Wed, 27 Sep 2023 10:33:55 +0530
Message-ID: <cf9865c45df7acb15759dc88698b63cd1b8b7f32.1695790713.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|SN7PR12MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a02fbc-cc84-42dd-44db-08dbbf173c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: scOmdYDoDq1kMElggZ5tMbmlpuPvc2gY2yEvBlY9XvoomhE1+dPbrh2gzBWyIPH3QMasz95L4LnQDa9//kwzFhQYm/b+zZUAZxO7b+P4B/Mq0v/k2iSYWdGRTERCyZ6sRtBlgwijU9agwvf0yYyyliHju0GbCQIuud1FfXpZLCVJrJR9lBq3ogfvikrAPU8N/wyAfHVC6UygzPZmEyPMaxseLr+oVN4bRC794itxD9iRSNGtlObZiJfqxoQ5Oz96hD6r8MBhaW1Y4vhuE/Iu0felKl8jVBCfJxyRe8LY0gS3WPvLPUmQqOVgC8zRb9UcmiztjttflizhcsVjCc7n0Pd7+qhtG/rVr3NWbQtP7j+8/aDT0hpRf8KcRTEJBodaBL3RDKmUHfyA+G6SnbI55Hz3rp75kflInaTHw9RZe+qYrb7iZUjmEMSxBJlq+hVlzW9WQN2AaJxKJ1Jd9C2kX0Pv2wWFoJTWGgq1WOsHmgntnFgnn2kVni5oSbGUmB9s/s/QpwcjdZ6nq54XXIIWUqDbY8VtuqA47eF4T50OVB3Lyx5z6zOlccSpTgSYWziVY5YWGT7n9h4TGSq7bZPDecYdDLOIjeqc2zhB5CUseBqKRnqp/ghv6nDjWd3m+S6jZrtK7YwwoKyVbEQhPVw6IFu5I4bkxzNlbSeLekHeDf9q+9FFEBqVHbhVmwqle22KFxyZA2gtdLXYLwE94JDnylrnvzi/HJp1DqtRT8bu9DJ0hW9tqB1twl19M7CNMlib+5lBqlNkFnCnRn+HyEXDfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(426003)(316002)(70586007)(6916009)(54906003)(8676002)(107886003)(41300700001)(40460700003)(356005)(336012)(47076005)(83380400001)(36756003)(478600001)(81166007)(86362001)(40480700001)(82740400003)(2616005)(6666004)(8936002)(70206006)(26005)(4326008)(36860700001)(2906002)(5660300002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 05:04:31.7184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a02fbc-cc84-42dd-44db-08dbbf173c2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129
X-Mailman-Approved-At: Wed, 27 Sep 2023 14:24:03 +0200
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

Execute "time <sleep cmd>", and validate that it gives the approximately
the correct amount of command execution time.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---

Changes in v2:
- Used @pytest.mark.buildconfigspec('')
---
 test/py/tests/test_sleep.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/test/py/tests/test_sleep.py b/test/py/tests/test_sleep.py
index 392af29db224..66a57434bff7 100644
--- a/test/py/tests/test_sleep.py
+++ b/test/py/tests/test_sleep.py
@@ -41,3 +41,21 @@ def test_sleep(u_boot_console):
     if not u_boot_console.config.gdbserver:
         # margin is hopefully enough to account for any system overhead.
         assert elapsed < (sleep_time + sleep_margin)
+
+@pytest.mark.buildconfigspec("cmd_misc")
+def test_time(u_boot_console):
+    """Test the time command, and validate that it gives approximately the
+    correct amount of command execution time."""
+
+    sleep_skip = u_boot_console.config.env.get("env__sleep_accurate", True)
+    if not sleep_skip:
+        pytest.skip("sleep is not accurate")
+
+    sleep_time = u_boot_console.config.env.get("env__sleep_time", 10)
+    sleep_margin = u_boot_console.config.env.get("env__sleep_margin", 0.25)
+    output = u_boot_console.run_command("time sleep %d" % sleep_time)
+    execute_time = float(output.split()[1])
+    assert sleep_time >= (execute_time - 0.01)
+    if not u_boot_console.config.gdbserver:
+        # margin is hopefully enough to account for any system overhead.
+        assert sleep_time < (execute_time + sleep_margin)
-- 
2.25.1

