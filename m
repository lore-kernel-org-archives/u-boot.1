Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D773E7E633
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 13:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 535F786D90;
	Tue, 26 Sep 2023 15:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kvoctNs8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7A2586A33; Tue, 26 Sep 2023 13:38:46 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A71E786BE5
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 13:38:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9fMGsmt6mgo5EPY0EgH7mszzAS6U1ZpkaIX38UnPEY8hhIaXgSL0JvvCxCJMOrkmKu4QBUfUXsxS+Ew/w08w8cV6doK+vQz4dDQIYm6VPHrUuNh3MDM2JaHpYgwvh9vv58wKLah6l2PsxGg86Dyr8iX3f2YtkrXp5VSQ6k/0Bzz6jZ9dwyFSOub5vTmGbVYhEbKw1k7+7Olt0HNnq8Y2mzwyHA8jLwd+Rd85A+tpmW30yY28F/7mtbfqTd0DAvGLe6xoZk3UQKK8Hs1YROK+gwmN4gVi+RZxBWtmZtDYDsIsFVhhUuhn+WTi0JoKl3NhqlOjztpuBvniWpq6Z4/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gy73PfS/3l8VMnG/vBEt17qgPWbEaqV9zkqQlncrWv0=;
 b=YlEaFrx8YF+0Se7TJaJH0452UC5hQc5BwUkXT3CYvcqZNTjKczUZ8O2lKzfyGVDgnm214zK7REilTF3Iu6A8ug0mRjaFSc8ZnO6ji2B9UruchRQm07mkcbR3KiLLiEHIRGbtK07En0qkIvPNkT+a848K5om6V6EHz87QlHqZbKRbsz5bxNaMtDWHAh2YriBa9SI5oLRmxEHKT5zY/ubBLiF+QRHrJ1NMfx2RheA1b4cxij2K8p3JEz5cBMDTvVQEKg4w5d3KBrlsHl+bdzh7ACwVLqS1mdN57BGbvi4dYXkIVkcBwtpBz/SJdaGBemQ1F2nkNBSe5Vk0UV5Ju+skdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gy73PfS/3l8VMnG/vBEt17qgPWbEaqV9zkqQlncrWv0=;
 b=kvoctNs8tn4ipd//3R8ukGVCJpDBxc3kXdLPpxAHLCjJYuHF93SAld7e/h8VDPrkdqbA2YGlkmVPqdHSr/3ZhChgC1kjNLwI6LPvJf/+EARryDBFTXmEgPn4YIsBtSX4NIuX/0p9ZHU8CUQS6CKKxJHPDeW+ikMjw4smiKMAaVw=
Received: from MN2PR14CA0024.namprd14.prod.outlook.com (2603:10b6:208:23e::29)
 by DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 11:38:39 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:23e:cafe::43) by MN2PR14CA0024.outlook.office365.com
 (2603:10b6:208:23e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 11:38:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 11:38:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 06:38:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 06:38:37 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 26 Sep 2023 06:38:36 -0500
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: sleep: Add a test for the time command
Date: Tue, 26 Sep 2023 17:08:35 +0530
Message-ID: <acb9a1175427a1a7fba80f9dfe9d90278850ae90.1695728179.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd59566-fd39-4d83-eaf5-08dbbe85207b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pt+5YJgFhXtPJCnXTE/CLOnVl2mjljBQdus53e8p0otAg39ilIkFXXDL0F4ZNCXyUpFHQ9mdJzddK+TSTiqinL55vnxwe8BY5yDBozspW0ekWJefJcQGDaCchg3gdik7GDy89UqK5yzE851ToUzORfSK2S2xQRP/xuVpQP81zw7PgHint1ODIgYSa3y14OYuhT/IY29ZT7erRpxuksjODG/SzVsxcCuP8EuQm2NMRIr80izp/G6qWEsmvtf300pMLi+in9G81H/uZg5o9spIfBcs7lN7KbsaUKpZrwSjozQciLi55NlI3WW7UKaUbk63+RQdKyj7Wa2o0o2zRq5VLj5fH9Roz/RbVrTDP7uA9uRlQ7XUt/I7EGIHPDlNBdvliPbPZwA05FwrqzutUXWoXT/z9BSNso0sTKP2Db0Ai6+Tep5KMbH5xr/NkdoRRJ+w4XQSxhmp45wY4DD53Bm050KvDkkxnaCbnkoYo9YWkeLUjNT+FN9Gnp5SvsXas9RKkxUQgvFmjGXxBzImr1Yv5BlOK0rSLUE4oy+IH14aRpcGWPbPJJR0Zp9XbCqVLG8qQv0HLdU86qveZyRRLeXpHlwVtFPhHN9fettlVuI74wxCtyp9igzA7u83hGiCHfdeq4LuqcmqZYVe6hbkZJ4wzB83Y4cY5z8zGDKusQwzMUxyhkic+oBfrq57MxTa2XrGZpZYdHpVmuBLd+sjosZvYqXKG3NhkMvcXDfjvBLWtPBsCJOcqSYw1lCYAkAweSzQYD7ePLUtzUKyaukv2fDHTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(2906002)(2616005)(86362001)(40480700001)(36756003)(478600001)(8936002)(47076005)(4326008)(8676002)(83380400001)(82740400003)(41300700001)(356005)(81166007)(5660300002)(44832011)(36860700001)(316002)(26005)(6916009)(336012)(426003)(107886003)(70586007)(70206006)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 11:38:38.7508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd59566-fd39-4d83-eaf5-08dbbe85207b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672
X-Mailman-Approved-At: Tue, 26 Sep 2023 15:07:17 +0200
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
 test/py/tests/test_sleep.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/test/py/tests/test_sleep.py b/test/py/tests/test_sleep.py
index 392af29db224..388f544d07df 100644
--- a/test/py/tests/test_sleep.py
+++ b/test/py/tests/test_sleep.py
@@ -41,3 +41,23 @@ def test_sleep(u_boot_console):
     if not u_boot_console.config.gdbserver:
         # margin is hopefully enough to account for any system overhead.
         assert elapsed < (sleep_time + sleep_margin)
+
+def test_time(u_boot_console):
+    """Test the time command, and validate that it gives approximately the
+    correct amount of command execution time."""
+
+    sleep_skip = u_boot_console.config.env.get("env__sleep_accurate", True)
+    if not sleep_skip:
+        pytest.skip("sleep is not accurate")
+
+    if u_boot_console.config.buildconfig.get("config_cmd_misc", "n") != "y":
+        pytest.skip("sleep command not supported")
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

