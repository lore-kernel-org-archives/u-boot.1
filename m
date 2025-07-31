Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59587C87FCA
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 07:07:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B53868334A;
	Thu, 31 Jul 2025 09:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bcgJZpvo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6111B833AD; Thu, 31 Jul 2025 09:07:05 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::60c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F1968318E
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 09:07:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKPspUk0m+efWqIDf+S7JnEo0aYMUJXtMxHPuu/T7YFllN4mw8dtt1j+4344wBTz7HVINU7NwhI90BUBvR7Zzt++etBLnA0ujSGXwGqOhfxgSjTjehzNU4ZvPmzmpRvQePX/rzNPXJrlao6+1TvwwSzzWXqLdxw5uiVh/VBcL/91HGm8dNJ4YwaY5QFztNmwi4yULJ47EbAS8gYgyGrMv8ngfS61lvzu7D+F20XF5U1xyUm5rjq+zan3DFqet/uMzxra5w8Xi17DdY0Uu7aeu8ToQjS6WghzShs3opxN6lsGDvnBCIDXCThZGAjtgyhuYYFcMCV/waE0cm1uzYgKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOEKViKpXeKL23oqabYaoOr2MlvnQXmEk3qBejCAeJU=;
 b=ttCym6QU8ZLVB1TLY9v3wBNewtRYCDLK0qeJkyFH6fvefmK3OJWG4YJOQHzg/ENnwTPUPP3xGF8gO/CvaC28BWBgsUxVBCxl2uS4Kf2OsVAmC+hg55JMRuejfuSrcyi2dnVa+zz/zm7FX+OOqRZ8gDI+8iW7aCHuk3PTduj5/Es14m0anq3O3yD8aPOFH5b7N4JUjkZ3b5XMdzwoO/ZQ4xVB2tAMPqtupYTdeRWBrfILHD0f+U1qi2DMdrpCfEDunc3iUNqXhU0B5d7QqUJbVeAArgPlltlFhwwBo8GMthcx3O6/hqlrfc55/yqLcOGUdX/p+oeC4XIetgi5ZhLMnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOEKViKpXeKL23oqabYaoOr2MlvnQXmEk3qBejCAeJU=;
 b=bcgJZpvoOtGVlioNe+IZebTSUJM/1HRuQwXioV+3tW/To6poEQZ0koTcOhlELMrTjfKwcZtCrwJEUmOIltRttV+fU4XSgfEObS92AsTWaCehzUSrVOs2REPzpe2k/+NrREXFeb/YauB0gPjVDwkfU49AcTH/IPLgwOdNpTIycHI=
Received: from BN8PR07CA0011.namprd07.prod.outlook.com (2603:10b6:408:ac::24)
 by SJ0PR12MB7067.namprd12.prod.outlook.com (2603:10b6:a03:4ae::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 07:06:56 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::98) by BN8PR07CA0011.outlook.office365.com
 (2603:10b6:408:ac::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.13 via Frontend Transport; Thu,
 31 Jul 2025 07:06:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Thu, 31 Jul 2025 07:06:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Jul
 2025 02:06:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Jul
 2025 02:06:53 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 31 Jul 2025 02:06:53 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Adriano Cordova <adrianox@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v2] CI: Wire mbv32 combinations
Date: Thu, 31 Jul 2025 09:06:18 +0200
Message-ID: <02e5c14552b05200ece94136db0077cbdd47738c.1753945577.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5357; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=0PCDNqGE4RV9AZZFBt0dYjWjUkVLCg4XjqF8oMCNdZU=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR0izHcTZvErSjYEbF0ZvWnmbNPdXj0rDx75eiGXvuST
 28ST4UHdJSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEDtYzMjyqZY3mjNo0LWOe
 pOHlKd4T3ypO9a+S8FaZFzH3/S2vX6yMDH88Gx/17b16+RDHWrFDJrO9C7SnnAkTXr+hI8DZ/fq
 uz5wA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|SJ0PR12MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: e6974e6d-f059-4c14-4e17-08ddd000d58c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5Bq0EjQQiUk8lf5p/o+mlXTkrRjrofelenvd9Tg33Kqb2XSJYonKZat/jvP1?=
 =?us-ascii?Q?/0VZAS9adHBn5igs3wiPjNoZ1282wIFzxrDwJLdLt5lx6YZOzjec+oyaa4BD?=
 =?us-ascii?Q?n436/B/f2D2tEGl98+lr2uvtL57pUfU8HaQv2rElGGwT1X3yUT8elcysE3lt?=
 =?us-ascii?Q?jSj5OZl1GD3P5SZw/vzT8FywxR7IRPnGGfe/m0svP/GACnwFmpO0YycGSZdm?=
 =?us-ascii?Q?sU7abNP8vosWp2+fcB+BI9bYBisk0hXFVtycNW5c/X1gOvHlcGggwIovJdAm?=
 =?us-ascii?Q?brqCTLYRpGE1olh3LTT2JtX+ab4woUVTBingaaaJUkPXVwl42j18vh9tzcla?=
 =?us-ascii?Q?qe+JRiszBHu/J/x9iKsJbbcd7pmOkmW8V1wINp+PIdnA3T0MIhCJgOurHNQb?=
 =?us-ascii?Q?dh+WRNPeIJy72D0gfa5tHrT2f0wL/pCSSErPkO3/LaYhoq9Bo4BE84ZKQzI0?=
 =?us-ascii?Q?LZoO3lyYrL8Oq3NLy7hQ7gU7ykypR2UXiUHdHCD9/+BTU743Kuk60tvR81XD?=
 =?us-ascii?Q?b9cC/UZEtwOII4+S36G4np+Skl3ul8ylIPPBaQSR9/uFRmAJco4xGP702eci?=
 =?us-ascii?Q?UyUn0wGDeqtQw7BQeWDWW8brXvVIYGwgiGGPkQOTg9GxcNwAE2xA1ExcDc4m?=
 =?us-ascii?Q?Bl5viCG6D080citnal+EQ773SupGbjjjR3uQErd1nITrXUi9VImKS/pNMAFz?=
 =?us-ascii?Q?cIWH82VwsYXwjcshS69xmE/3aOdQx2sAqiM7iXh38la8HWj6VgRHJGADiOKU?=
 =?us-ascii?Q?TX8evsnJmMpAD7z3A4+JPArtSX6rsySJqSshlLYpoOLy7D4YedCKuGujajDS?=
 =?us-ascii?Q?C4QZrJtVqiKLqT2Cyv+ywkU0Wmv6IaiRp5IHOjlhJrlCfTBbZk9TjLEESHTC?=
 =?us-ascii?Q?5cql24LKgtsS8FIxBeQZe+oli+fdBw+CuFnhdgvzQwmkoCusU7hWjiefPFEi?=
 =?us-ascii?Q?R+e6gzyEgJgs0JpEtSkk7B04clJcF84eyH99Mxcjn6x6G2jfdPCV6hPodUK0?=
 =?us-ascii?Q?D8L8gWWoQcWXmB+ySlGqa9OkmvJ/kEXb9EfHe8mXNnwQMWRWjURjLbt2ES8e?=
 =?us-ascii?Q?AHo6jR9aMP5szktdcQ3hqLvKUhharO9JBGx6ZSOaVcoX/H6QKMJ81ycKvera?=
 =?us-ascii?Q?1YH6IWX+Q/FmBlWxg4lwUEoO6W3k6G+PoBjBQwJrd75HEXSexsgAJLwhC0Ll?=
 =?us-ascii?Q?Fxi8jChDFmvUVSNmpA5OYWtgQQQhykzH5OefZPvKQFv+3YwYYqJlRYtJG+20?=
 =?us-ascii?Q?biWLvyssLfG/LP0BNsswfff/YT3uKTC5BcgsGXEy/7OegPzoZPljFn85Q643?=
 =?us-ascii?Q?s3J7DLcNUCqOUzMTnExy4XqMSsJTOd5w6i7nXE7MyX97KLyndOjV7BKSb1r0?=
 =?us-ascii?Q?E0nKGsTXr3Phn/LYAWlhxVAH0io7tV25/B9VUNdbBSMzlyCtERdfmu8Vtchk?=
 =?us-ascii?Q?SOVi/G52gBSwAmDmTFL4Dyn6f0dcOYtv7Iw+solHveGY1ygjw7rqx9mL5Mgm?=
 =?us-ascii?Q?kcivleEgUtQh0yk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 07:06:55.7354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6974e6d-f059-4c14-4e17-08ddd000d58c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7067
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

Changes in v2:
- Add missing backslash to azure pipeline

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
index 8209d2b329cb..d4bf43e7a923 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -258,11 +258,11 @@ stages:
           ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
           ln -s travis-ci /tmp/uboot-test-hooks/bin/\`hostname\`
           ln -s travis-ci /tmp/uboot-test-hooks/py/\`hostname\`
-          if [[ "\${TEST_PY_BD}" == "qemu-riscv32_spl" ]]; then
+          if [[ "\${TEST_PY_BD}" == "qemu-riscv32_spl" ]] || [[ "\${TEST_PY_BD}" == "xilinx_mbv32_smode" ]]; then
               wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
               export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/ilp32/generic/firmware/fw_dynamic.bin;
           fi
-          if [[ "\${TEST_PY_BD}" == "qemu-riscv64_spl" ]] || [[ "\${TEST_PY_BD}" == "sifive_unleashed" ]]; then
+          if [[ "\${TEST_PY_BD}" == "qemu-riscv64_spl" ]] || [[ "\${TEST_PY_BD}" == "sifive_unleashed" ]] || [[ "\${TEST_PY_BD}" == "xilinx_mbv64_smode" ]]; then
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

base-commit: 635824721664b4334a74f3911c346848125c4f05
