Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0029D41D6F
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 08:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ABD68931D;
	Tue, 12 Nov 2024 09:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FqphcKOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEF2A893AD; Tue, 12 Nov 2024 09:57:36 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::613])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE7B7891B0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 09:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gf4e1bI9j6v0527nJHZ1EqR/1B60wuJkMYl87kkVVxJ744CGd0NO6M/KMaLtb72Z7wItGKlENbCVY5BCVZMjmOOP5hiKL4uUATw5LPTk7GcQlMgPNljob5oAqQrBIj2c0mtXqLszxAfOgQ0tFown6B6HkQbQOeynuYmb40Bchzxgp0Wid3VAap5pbZ3yalRN+hOJuohOH8TPFeyMV1/uIpdDpI+MSiG73drjh7Emu0FpVtyU4nuKy45wZ6baUUoVugc+BJ4Z/7RCLbS8WeEUnlBmQSGYqDIfxKsejn5AsdLC2f83/x8yhd6VyHiPPzK5xKreSwdg5mAC7gcjQqR4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YRT69c8NUMsAXgN1IQF09khJV8r10Taj0W83Jy2+1k=;
 b=p02owgJ9WUQ6M86PwZUPqyjpPVvEJ6LD9IElM1s93wUuys/SdKnP+eMh3jeUwxeoec/16+5bxgWdP7JqVgfOkWSgaLAiWhe80kCgA8tBRvjubywDE3KzglC4uLl7UBorcMk3TrKFPW36rQR7Ab/z50Migygf1u9GXRsKjznp3d/cmBWXX6/66Qe2ZVj+vz6Y6Ael3qY72WxGxoEVqNxEkplJoq+4tsMdboA7icdC9YAYGFO+ZkbqjPgQlqKr28DYBmzd9HkCsed02l/XPfudXTKMKbLyEfv3kSLN95q5tk3RNJR27qwpP8czEKliQBkVeYQCGWs43lYm4Ah34xENVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YRT69c8NUMsAXgN1IQF09khJV8r10Taj0W83Jy2+1k=;
 b=FqphcKOv1gaxWeVX3DggBSNQIbEGvSksVLpCKnCesfWqU24YW/zI+uJL+WE1Mtb00yTkNrxIfSxFHEUBOmg1te2CUDHc420aaqVOaO8N92zZFHAYP+BTMJy4LqVFp7VTbFc/Nk8Cug3E0pKJy1LJ9uJInkCIYJcGlBsdFG4tFFU=
Received: from BL1PR13CA0230.namprd13.prod.outlook.com (2603:10b6:208:2bf::25)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Tue, 12 Nov
 2024 08:57:30 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2bf:cafe::db) by BL1PR13CA0230.outlook.office365.com
 (2603:10b6:208:2bf::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.15 via Frontend
 Transport; Tue, 12 Nov 2024 08:57:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 08:57:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 02:57:28 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Nov 2024 02:57:27 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: mmc: Distinguish b/w ext2/ext4 partitions
Date: Tue, 12 Nov 2024 14:27:27 +0530
Message-ID: <6cdcaf03750eec78ad7e577edbe81c3e50350aa4.1730797426.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: love.kumar@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 32983105-b589-462b-00b6-08dd02f80a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SKvRzgl+GXGOYdQx+VTCmbAChawlzCR8tr+qB+DN4s9Mb5P5aIMGb8JeEw2c?=
 =?us-ascii?Q?7g3CgOhzB3a2Suy93DIUBf1cwbGYmmUs+cV2D6cQSBknkhx7HUPvm8Pbwhj5?=
 =?us-ascii?Q?bFaMafg4Ny3vdSBWlIrUzOjttMgq7sO+nfCl82RAEo4KYIG52xsJNJFV/Uzh?=
 =?us-ascii?Q?k02F+LEkAwC5BvZbcHYYT2s96Vn7N3iCswK5yh6nT823Zs603+noNtFImgsk?=
 =?us-ascii?Q?Be5iCZKMbWzF01oEsBtK04imJPin0cl6TlTFZrgaGVNgIrVDSl4b16AGISs1?=
 =?us-ascii?Q?Fj8DZTReH0XsZgBd0zYSDBJVAc+IjMItALhD5xUXau/u/k/bGexHqR9hJma5?=
 =?us-ascii?Q?E4E6dujxDDK4wHQXmouFdFYS3S3Z5AX3Htsh8Il92a/5UePSC+MWQXGTMIAL?=
 =?us-ascii?Q?vofOWOKhwjuiEMWULS0oMh3WSig9gvFfZYey8Q7BEc4qlkzEH0TG9sesrolo?=
 =?us-ascii?Q?jo+wTNa0DFhnwE6MYNhui1sWFH1a59Ds1GaSlepLHjYmReLofUr2TMVBfSwE?=
 =?us-ascii?Q?wYp29U4xeb4CcIU+FfQt3KCTOHYLqsxS0G27ajhaRG7ENdglceb6FM17NMdg?=
 =?us-ascii?Q?Fv1h1rNmzrFyhws/E/1OIcgPZEl8vE9cSoiQGQI+bmLPXaZOQ4WSU3A1flCp?=
 =?us-ascii?Q?vDgRnHO62g7qKllzgovKkgT6XsSbrX3wu6RgQRbtuWsOaKHijWrEVAFC0oo4?=
 =?us-ascii?Q?QT16xSxJRzwC1lFEOsMLSn2SDt+V5zBFdlZd4Wffdp4ci2suDv6i3ixPuLK7?=
 =?us-ascii?Q?Rz1z1jnumIubRRknbi5kKZ4M0Ll286HeEQ/cOoJE2xvB933q3crAeGpY1Z4D?=
 =?us-ascii?Q?ZCY7dZ/zwaF9yz/x725rtPh+Qg1MQSHzruBopCSODBtrh04sFPQQlkFyePxr?=
 =?us-ascii?Q?FyGYfulI0u/GGEOi6qRg3hqipO3ISJNmNZ4DJuG56dJSkieNduRqI90a8A/6?=
 =?us-ascii?Q?coy3VzMbHU3uZA6Jx98UgYlf1kgLMogHX0a6ZNhZQRBbAE+3CiufJ0k9F49B?=
 =?us-ascii?Q?7lmxFH2coJC8/78Q2gIx6ClvKeXfN3QSuT/JsRORMNvSUyxc1QdDgev5z9Uj?=
 =?us-ascii?Q?giZnOZ1PWMtqTKQ81AMz6mO+wb8fzmZQxpVeRPJ7iW/u3A1iFO4vy3nL8mXH?=
 =?us-ascii?Q?X7HPYl0k/VtV/Esqfj+UHvOalB1yRRGe/znHHzKebyHHLn6hhlHDXFMMGjMd?=
 =?us-ascii?Q?7krO/EJsXAm1w/eFOTzc7bUmaxI6grnhx8YrEfjgho6tIKzEUnq+Hz/JZB9t?=
 =?us-ascii?Q?BMZgw5TmUmGaVM96hWFfLSuwifKIA+3QoEgnLZOdKKF3ZuC962tn1j6Wpq2k?=
 =?us-ascii?Q?ihZINTg9nv/aRhVrvQOHzJMUcYnu8eaCi5bDwIlTl+1j8nsCDs9IQY3DlGLZ?=
 =?us-ascii?Q?cR2z8SRji3bJ79HOMgpnm8XEsJQkyAhLUnGZ3Stk96aeyYldlw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 08:57:30.5914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32983105-b589-462b-00b6-08dd02f80a6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129
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

'mmc part' command shows the partition maps and shows the partition type
by displaying number such as 0c, 83 etc. Observed that ext2 and ext4
partitions shows the same number, i.e, 83, so, using the fstype command
to distiniguish between ext2 and ext4 partitions.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 test/py/tests/test_mmc.py | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/test/py/tests/test_mmc.py b/test/py/tests/test_mmc.py
index a96c4e8fd890..1193f4a95737 100644
--- a/test/py/tests/test_mmc.py
+++ b/test/py/tests/test_mmc.py
@@ -148,7 +148,8 @@ def test_mmc_part(u_boot_console):
 
             lines = output.split('\n')
             part_fat = []
-            part_ext = []
+            part_ext2 = []
+            part_ext4 = []
             for line in lines:
                 obj = re.search(
                         r'(\d)\s+\d+\s+\d+\s+\w+\d+\w+-\d+\s+(\d+\w+)', line)
@@ -161,15 +162,21 @@ def test_mmc_part(u_boot_console):
                         print('Fat detected')
                         part_fat.append(part_id)
                     elif part_type == '83':
-                        print('ext detected')
-                        part_ext.append(part_id)
+                        print('ext(2/4) detected')
+                        output = u_boot_console.run_command(
+                            'fstype mmc %d:%d' % x, part_id
+                        )
+                        if 'ext2' in output:
+                            part_ext2.append(part_id)
+                        elif 'ext4' in output:
+                            part_ext4.append(part_id)
                     else:
                         pytest.fail('Unsupported Filesystem on device %d' % x)
-            devices[x]['ext4'] = part_ext
-            devices[x]['ext2'] = part_ext
+            devices[x]['ext4'] = part_ext4
+            devices[x]['ext2'] = part_ext2
             devices[x]['fat'] = part_fat
 
-            if not part_ext and not part_fat:
+            if not part_ext2 and not part_ext4 and not part_fat:
                 pytest.fail('No partition detected on device %d' % x)
 
 @pytest.mark.buildconfigspec('cmd_mmc')
@@ -463,7 +470,7 @@ def test_mmc_ls(u_boot_console):
     for x in range(0, controllers):
         if devices[x]['detected'] == 'yes':
             u_boot_console.run_command('mmc dev %d' % x)
-            for fs in ['fat', 'ext4']:
+            for fs in ['fat', 'ext4', 'ext2']:
                 try:
                     partitions = devices[x][fs]
                 except:
@@ -494,7 +501,7 @@ def test_mmc_load(u_boot_console):
     for x in range(0, controllers):
         if devices[x]['detected'] == 'yes':
             u_boot_console.run_command('mmc dev %d' % x)
-            for fs in ['fat', 'ext4']:
+            for fs in ['fat', 'ext4', 'ext2']:
                 try:
                     partitions = devices[x][fs]
                 except:
@@ -536,7 +543,7 @@ def test_mmc_save(u_boot_console):
     for x in range(0, controllers):
         if devices[x]['detected'] == 'yes':
             u_boot_console.run_command('mmc dev %d' % x)
-            for fs in ['fat', 'ext4']:
+            for fs in ['fat', 'ext4', 'ext2']:
                 try:
                     partitions = devices[x][fs]
                 except:
-- 
2.25.1

