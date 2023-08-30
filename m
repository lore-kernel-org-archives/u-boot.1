Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AE4C6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 16:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FEAE863E7;
	Wed, 30 Aug 2023 18:36:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s9F3fgRh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A492863E7; Wed, 30 Aug 2023 18:36:35 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD8C08646A
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 18:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdsJUIw8IB+jQHDPxeaaz+j5ypd8bb4tswWo1o9m4BQIIHGbTnmWUywKjGJVZkSzNNoe3sPs1NSkDzuFKFthPu8Y1p4wRaqbzEk7+s3Qn78a1ERLjpKuG/uGl4wr25cGwQVE7eobxcNX58H9HJ89yb7UKjHM4sRJKHop/Kx+9JS3d2vjgnbjBANgoFS6PxtgD6ymvN596fM5Hax6ATeNLxQGLQxbNgfvlZAuOa8G/vHaGGCCvfN6mes8glg29LTRN2WVv1YNWiJuqWIz71EAC/3+yte5Mrj4FfP8cvfJCDvZvD+YAQZOLluXUhXFyCBTV+aZLAYvWOWsM1LcBJyMXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvrZcVASN8uvaHdAQf8Zyh8jCrL/c5J8iomRkwRt61w=;
 b=FEfLLE4H2uS5foIK0hFyBNeXEbtuSBpO+Qcek69qnT3gAWTJSjONYl0LDrx2fG466LHHs4K4SLxk504GTpFXWA/0iomywTsBqkZilHfDvJMkGsYYkr5qEzsUUV2UZgUog/HO1Wy1nehpNe96Q/uRIF1qzLrG6t3ff6gkec+nROlj4U/UCWKi5z/LVnFtJoDf5hhCWsHo97TiU+bPpYQuToC2nRcK5Zvy9BFSPxIQszuOCv7XlCZA50/9k7Nb3gpITC2ZBJ7GB3+4JzcrBx1N3Yns+DmZs2eV8RdBuxUoXCMCF++yhkZIXsKmQqEj1R08mzMNA5dM56d8asTJit6h6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvrZcVASN8uvaHdAQf8Zyh8jCrL/c5J8iomRkwRt61w=;
 b=s9F3fgRhXfP/tUjKbHWeKCx2oEmMJ84vzK2fm3BYfpmKcwFHfpXTE9ESlFnkYjZpF4wCQq+hZx/wFE8J2s+NAUGGhIYJ6LyC6CW3PMUFqMO6bB5Jhw2phJNBxjuMtiLtrzU1mviF0D0FJRWpzeu7wzY1Vx181uWTswCS75W8qSQ=
Received: from DS7PR03CA0059.namprd03.prod.outlook.com (2603:10b6:5:3b5::34)
 by LV8PR12MB9334.namprd12.prod.outlook.com (2603:10b6:408:20b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 16:36:28 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:5:3b5:cafe::4e) by DS7PR03CA0059.outlook.office365.com
 (2603:10b6:5:3b5::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Wed, 30 Aug 2023 16:36:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Wed, 30 Aug 2023 16:36:27 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 11:36:25 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass
 <sjg@chromium.org>
Subject: [PATCH] test/py: tpm2: skip tpm2_startup when
 env__tpm_device_test_skip=True
Date: Wed, 30 Aug 2023 18:36:23 +0200
Message-ID: <41f932e52bdd206b1b68d5ff313fc29b794a70e7.1693413381.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=861; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Dx2hvN3ZEkrhw3blnB6BPPzN53KLTaYTUKxNcAGM+aM=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpT3BayLsktyhFcvn8m0ZP9HN41JlyQu2JUKnWwvF43+o
 sq5YWZ1RywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjIlIsM8+ym3d8zOzDKbprt
 p8+PGOzvdLpHeDLMj4gxj360yLI42+PNxZ9PNKXFb/WpAwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|LV8PR12MB9334:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f662d7e-6b30-4734-7665-08dba97741d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H7X6QBozjQe432mUVsfrimjZ6I8jWI9369/n8T+XonEeD60OQI+AmSBmlz51m3iwzLrt2vEC+XX2j4Y4hFBuiDHxfBoYeGKHvWueST5KaKlZH0cN1H/hb18xIMwlBZ3GccbnTnZOTgAQpNgoBU0tN1fh+HmGYwwVbAWIWbCqFmFyJgr5nEDY4QgWlChl3Z2lzwdossg31gcSKHYt7U5qgsOKUFK5xCbMjeWfkpdVxdTP6bnlao+teXWMNRSe6HfDaZzdn+0B6/1LdwEmOy84NkK5ssKLw0waEVEGoMjQdoA+q/EfqPm5yDJa89fhiL+/oIxYEgYADOo0UOqQU4Ux3EG02qqXzZTXCq0NykCwTaN6likyUF6UfEzD3rU5ibKLHWXJfvgacH8jk6cKglebLZ5NqlaCWS3ucLGey+CdCda89AHFA1W6rEJcSf2YAmxj68tbJRmfOsv1DCXcawGa3eDRpsTfWp3Y61FBox6hPZ0M5YoRiO/jO6s3BnL+ChwvVjVVc+NZXr6f7HPvqEn6r8sAHOXhEq2r+rOG/uDvma8xW2/v2QTtzNtzzUAm2YLMsY0+IxUyVRzdhu60TR5DlCuiEglEwuMlP15+g8JdgNm3Ty+KtQG0Li4ywZBRDy1gvcZSAkRD9xq21HRYm87sy1cUDr8x6pO3h1oHlkZ9TnluuQhTIdIFAkS63QSXKd1GpP7Ym2/QySkjXbewI98YPF8lpi+OQgGijjhC9XgTGXYvnUFoUiqg1HJhk2JyYHrUUg3L3kTp8gYYJrGlHfBAePEwli7hTStS9xFN4QDh2iNxu5sttMVcoGBj0Z58Qrcz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(1800799009)(186009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(54906003)(70206006)(70586007)(316002)(110136005)(356005)(478600001)(82740400003)(81166007)(4744005)(2906002)(86362001)(8936002)(8676002)(41300700001)(5660300002)(4326008)(44832011)(36860700001)(47076005)(26005)(16526019)(426003)(336012)(2616005)(36756003)(101420200003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 16:36:27.2870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f662d7e-6b30-4734-7665-08dba97741d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9334
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

All tpm2 tests should be possible to skip when
env__tpm_device_test_skip=True but test_tpm2_startup is missing it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 test/py/tests/test_tpm2.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
index fce689cd992d..c2579fa02c58 100644
--- a/test/py/tests/test_tpm2.py
+++ b/test/py/tests/test_tpm2.py
@@ -71,6 +71,9 @@ def test_tpm2_startup(u_boot_console):
 
     Initiate the TPM internal state machine.
     """
+    skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
+    if skip_test:
+        pytest.skip('skip TPM device test')
     u_boot_console.run_command('tpm2 startup TPM2_SU_CLEAR')
     output = u_boot_console.run_command('echo $?')
     assert output.endswith('0')
-- 
2.36.1

