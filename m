Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BF4C87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 11:25:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F8E682BA1;
	Wed, 30 Jul 2025 13:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Num4GFYK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00D7C82BA7; Wed, 30 Jul 2025 13:25:28 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDA9C80194
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 13:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXmKfj3EjMko8iwC5Ay30jdb4dLtgWUKzNPQc6CSsd7R96Lm2sKYhnnu1/5/D6SWRjZH+6XOAMQDW/aRzPPDQ+En2GJjtGd49Vn3oi70h67SpZ06JUkFkwlJ8qqIjp8akLLkYBpyn4p4LTztIv4pSpOUPj8GidfI6Q8cv101rHlHcjMNUmPhHGX01EOTh/nUo9Y7VhT4xscqSFNOQ0zMETgnZoyVqpyw9fS+fOgCH3ZQ9OEo0sy2t1F9pO62lxqYYLwOedjqd4fApjUgx8oJJ5ziLhd8LBKVrgBT1UMyCITiTkkBQbNX/YYK7bJ6KCS1MjaVlhQ12mXKC7z6xPFmig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9VrK5nA3UwGSxpnH8OfLFNRjt/Ne5dhRsbhQhwi+f0=;
 b=YEXoQfTiPuVUjTLyM1EfJCNM735eW8e7QzTHgpgAwiW1/PbFoVzZss1nFmfGRenQG79rkdLAjLIGt6t6Ofq0ZPsjU5Q/nF3POJ1r/xWkI8sJJgA+N5jJXLXMb7SSbHn2+LsAfzFIEQGf6oooFn+MG14puW77+0gzoCT1yA7fG2lGnYrH86TuPtnQ2rz1R1MWCffVWZ9I3qQ81cRQQyJxzQJtbnSXKZflbGUW3Ju82TAyMa/hTYeogRSeK3KQAq1HSo1PrABXAuEJcSYgoSY/9cS9D5IB4POEcc6PbA4a6YYg4UgM0i9OvLndDL/B9iwOrD07TSAHpTF7JHXhDE0Vaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9VrK5nA3UwGSxpnH8OfLFNRjt/Ne5dhRsbhQhwi+f0=;
 b=Num4GFYKMWFq5nyY5wNILX1S+/bOdttEzzD/yQKjqwiRd99BH40mJVQ60bTIdx1soyEaNvv7yaB/knhOm6W8kAfkmU5dzlPfM9PVZpY9ue1KxPhymgT5EWgBSvogcvgEwFcJiT5zLctqB2KCxB/uK1gX22AKxpn4azV/pTeTw4M=
Received: from CH0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:610:b0::29)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.11; Wed, 30 Jul 2025 11:25:19 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::4a) by CH0PR03CA0024.outlook.office365.com
 (2603:10b6:610:b0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 11:25:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 11:25:18 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 06:25:17 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Jul 2025 06:25:16 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Adriano Cordova <adrianox@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH] CI: Wire mbv32 combinations
Date: Wed, 30 Jul 2025 13:25:09 +0200
Message-ID: <dc52619a474c6374d43e7fb232480cab3392b00a.1753874707.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5316; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=eS/5X23En6Iifn5JkphL4IDei4yzMEEBmyErrzK4ozE=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR0MYpXOOu++XvyTsSRy7f0wqes/Gbwms9b2Dp8WtKFu
 asF5q590FHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQAT+afOyDCx+Xyq4wbmtx9q
 BB06NIKydQPb4+ZdWLzplvrdq8rykjqMDHOFI/9adBa/N52mb7Mz5l+O0S+DJQt55zKILjKf9+5
 uLiMA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|DS7PR12MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a86735-69bd-448a-43eb-08ddcf5bc3ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H9E500ldEwKUo8TRJktS0VRasjVIohxlJF7T91uVSe6WJEbDOj0KCXhLN3Ue?=
 =?us-ascii?Q?znF+u8sAH9da6DcdfHpyfx9riSi5XGc8fW4a2B9KrBYj8V/WXn5HrTe7QCID?=
 =?us-ascii?Q?UXzayyrV+bBCAgiz1SkorAA5aKPPkB2TEm81ZzaKzGSNdJAlSWc0Ua+2Lhnx?=
 =?us-ascii?Q?csOKznAIIr282yd9Gtvl5+0Mrgdb0JryFpc8g3051edVMMr2NvgKp/AqkMn0?=
 =?us-ascii?Q?GPBQtEZeoIYZx1mmjm1edOO7B/wvwq4ctKa6jrco31SRoeqlz7YVvw7EQvak?=
 =?us-ascii?Q?irVgJYyeRase2yPyOESlR7eU7SG+xeOA9TTylEoE4oAYku+zuGVs0JzaTMfP?=
 =?us-ascii?Q?CKGL8mPQYpVXxqMDTaW+EDh+JfLHlNrEHI9w45eJhEDZG2WQdeVkmsfguhtN?=
 =?us-ascii?Q?rDo0Hoi4rCh4re5vXyy9RfA9bICeB6c+mibqnClwZaflX9NwI5YOeOQrkJzw?=
 =?us-ascii?Q?RHRgBFQnzULe7l4vzFZwBiXwfGAZAvCQ0UG3CS45+pd8kZ8otSEbb0ELoFfc?=
 =?us-ascii?Q?2FZ2wuHForgQpuFcF1ieli7stDXpbsM/5sZ15rCfZYqTOCtazRkUbqsqvRft?=
 =?us-ascii?Q?LFsl2TCTXwA8MjkhyXF/P1XQ13jpAaHpTRYylnIi5qAJ7Pz6i9/XYWParqfL?=
 =?us-ascii?Q?dEYC27gHl+imxOtvylveWBpHS+VYUl5AOUZO62PEoZZR9KGRhfLLBjmuvaCZ?=
 =?us-ascii?Q?BFO3Q3aBr+A9XA5kNvsdYzmDwRO8ovFmmL5ehuUYrZ98JN8VJwjyupSK4dG5?=
 =?us-ascii?Q?Z/Qu/7Bc6q550gSgzrpFlqsA2fiCAV6Sk0QPJlT+7Yc0q0kLOG030TVrxs3h?=
 =?us-ascii?Q?S+wVcvqXkRtcojCVolvVccPLKqUCH8d5ib+w5HYmzEcOQbBkZ0X59Fq6bB2u?=
 =?us-ascii?Q?YZM/wPoWmToPEc2WWSusZBXGtiLChesFXHc3Dxi4fXZdfx7rrv/sU2iiWInk?=
 =?us-ascii?Q?qliTWXZVIaR/YXUVdlxNbTfi826Dc7uZ7cCCSl2zOxNkNcqqIwy0v3L+8RSh?=
 =?us-ascii?Q?6v6+KCPLZI8YA+8Id0TelflfbtlhT7COtXe2YhZDDxq0z1znkQvn3iGzTJR4?=
 =?us-ascii?Q?pO2oJGN0wvp/b52QuuJLyJJ6cKhSkB0F3C//Y+SLfJTG3MZcdRwBkmMmA+Rl?=
 =?us-ascii?Q?6OZRvZ3ybQpZ/tcpOzepeHAVuQ7eG6esBut6aNfsLFoLa6zdQN0xkSKurEpZ?=
 =?us-ascii?Q?NpCQVcoWxJcGu7jjLYFMx2z9iK9YsT4cbme1J6Qg+xAsjdaY+lbi151Jm0QG?=
 =?us-ascii?Q?zJu5m8OTNRXCVf9nt/7J+a5yZyJ9+1i3/3h1XOc8ksIBjAyamAxwLQk1SB58?=
 =?us-ascii?Q?054wq4vfEydSyAfjvKywOq0yutM9+ymhluoWHYSBJxyU9aQqDgDhZQmQ44S5?=
 =?us-ascii?Q?foTcV06FawTAG1jM36jqW+qPc8Yo+ODlDm8AK2HgEXv1fV3TmRzIk7tLkai+?=
 =?us-ascii?Q?vsD+cPYNU1BOpWFckHF/3WfDgxOl+rQthrOHK3P/laJbYQtwQ5NZ5WhF+YOc?=
 =?us-ascii?Q?200XSvcGjzzHklo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 11:25:18.9715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a86735-69bd-448a-43eb-08ddcf5bc3ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144
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

After upgrading to QEMU 10 by commit 1d782a3f229c ("Docker, CI: Update to
latest Ubuntu and Dockerfile") let's wire mbv32 which is the part of QEMU
to have it under regression.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

gitlab I have tested.
azure I didn't test it but did blindly all changes as they are in github
one.

This patch has be applied on the top of this series
https://lore.kernel.org/r/cover.1753182218.git.michal.simek@amd.com

---
 .azure-pipelines.yml | 20 ++++++++++++++++++--
 .gitlab-ci.yml       | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 8209d2b329cb..76a0ba097f93 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -258,11 +258,11 @@ stages:
           ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
           ln -s travis-ci /tmp/uboot-test-hooks/bin/\`hostname\`
           ln -s travis-ci /tmp/uboot-test-hooks/py/\`hostname\`
-          if [[ "\${TEST_PY_BD}" == "qemu-riscv32_spl" ]]; then
+          if [[ "\${TEST_PY_BD}" == "qemu-riscv32_spl" ]] || [[ "${TEST_PY_BD}" == "xilinx_mbv32_smode" ]]; then
               wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
               export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/ilp32/generic/firmware/fw_dynamic.bin;
           fi
-          if [[ "\${TEST_PY_BD}" == "qemu-riscv64_spl" ]] || [[ "\${TEST_PY_BD}" == "sifive_unleashed" ]]; then
+          if [[ "\${TEST_PY_BD}" == "qemu-riscv64_spl" ]] || [[ "\${TEST_PY_BD}" == "sifive_unleashed" ]] || [[ "${TEST_PY_BD}" == "xilinx_mbv64_smode" ]]; then
               wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
               export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
           fi
@@ -540,6 +540,22 @@ stages:
           TEST_PY_BD: "sifive_unleashed"
           TEST_PY_ID: "--id spi-nor_qemu"
           TEST_PY_TEST_SPEC: "not sleep"
+        xilinx_mbv32:
+          TEST_PY_BD: "xilinx_mbv32"
+          TEST_PY_ID: "--id qemu"
+          TEST_PY_TEST_SPEC: "not sleep"
+        xilinx_mbv32_smode test.py:
+          TEST_PY_BD: "xilinx_mbv32_smode"
+          TEST_PY_ID: "--id qemu"
+          TEST_PY_TEST_SPEC: "not sleep"
+        xilinx_mbv64 test.py:
+          TEST_PY_BD: "xilinx_mbv64"
+          TEST_PY_ID: "--id qemu"
+          TEST_PY_TEST_SPEC: "not sleep"
+        xilinx_mbv64_smode test.py:
+          TEST_PY_BD: "xilinx_mbv64_smode"
+          TEST_PY_ID: "--id qemu"
+          TEST_PY_TEST_SPEC: "not sleep"
         xilinx_zynq_virt:
           TEST_PY_BD: "xilinx_zynq_virt"
           TEST_PY_ID: "--id qemu"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 85401d3e09b1..b83cd1a5b232 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -43,11 +43,11 @@ stages:
     - ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
     - ln -s travis-ci /tmp/uboot-test-hooks/bin/`hostname`
     - ln -s travis-ci /tmp/uboot-test-hooks/py/`hostname`
-    - if [[ "${TEST_PY_BD}" == "qemu-riscv32_spl" ]]; then
+    - if [[ "${TEST_PY_BD}" == "qemu-riscv32_spl" ]] || [[ "${TEST_PY_BD}" == "xilinx_mbv32_smode" ]]; then
         wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
         export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/ilp32/generic/firmware/fw_dynamic.bin;
       fi
-    - if [[ "${TEST_PY_BD}" == "qemu-riscv64_spl" ]] || [[ "${TEST_PY_BD}" == "sifive_unleashed" ]]; then
+    - if [[ "${TEST_PY_BD}" == "qemu-riscv64_spl" ]] || [[ "${TEST_PY_BD}" == "sifive_unleashed" ]] || [[ "${TEST_PY_BD}" == "xilinx_mbv64_smode" ]]; then
         wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
         export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
       fi
@@ -550,6 +550,34 @@ vexpress_fvp_bloblist test.py:
     - ${DEFAULT_AMD64_TAG}
   <<: *buildman_and_testpy_dfn
 
+xilinx_mbv32 test.py:
+  variables:
+    TEST_PY_BD: "xilinx_mbv32"
+    TEST_PY_TEST_SPEC: "not sleep"
+    TEST_PY_ID: "--id qemu"
+  <<: *buildman_and_testpy_dfn
+
+xilinx_mbv32_smode test.py:
+  variables:
+    TEST_PY_BD: "xilinx_mbv32_smode"
+    TEST_PY_TEST_SPEC: "not sleep"
+    TEST_PY_ID: "--id qemu"
+  <<: *buildman_and_testpy_dfn
+
+xilinx_mbv64 test.py:
+  variables:
+    TEST_PY_BD: "xilinx_mbv64"
+    TEST_PY_TEST_SPEC: "not sleep"
+    TEST_PY_ID: "--id qemu"
+  <<: *buildman_and_testpy_dfn
+
+xilinx_mbv64_smode test.py:
+  variables:
+    TEST_PY_BD: "xilinx_mbv64_smode"
+    TEST_PY_TEST_SPEC: "not sleep"
+    TEST_PY_ID: "--id qemu"
+  <<: *buildman_and_testpy_dfn
+
 xilinx_zynq_virt test.py:
   variables:
     TEST_PY_BD: "xilinx_zynq_virt"
-- 
2.43.0

base-commit: a62ee8985df74b49cac37e7f3465ccd0460d7aca
branch: debian-sent4
