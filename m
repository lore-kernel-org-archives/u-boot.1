Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D7DD6DDF8
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 13:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58DB2890E4;
	Fri, 15 Nov 2024 14:08:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zlgg1AnZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5948D890FC; Fri, 15 Nov 2024 14:08:11 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D90968909F
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 14:08:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtxSvffdMl+stasHWL0vKChQmKc22VdSNaraFXYk7fVlZKoSqC0+VslYj3CGSQ1egSem3HsGk8OEWrhFc4B6fgBikvq1rSezT7jKT3zf0Tsf/++Ebhmpa9O17X7rUq/MlJwCN3se/UwF8AfnoRVIN7V+bVqMhzHBbbgeVzqO7RXF1vfcZqDVCmJ/fUPXnSxbHXyzmrnfyaB728Z/XTMBklqRvy6FLUTh6mDtlNPj8IjGJa2S7reMff7wUSbsycwhb8aPJPP6NpyhlG6ooB+WkXEEt+m/i+VCgc9t/YCFdr9lbf9/M8ejZMW1lE9RK1bJN+2crRxCD04UZlBjuZZbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9QXARustp7+UEAZ4clzkduhtcNO9y+XeGSGAWf4t5M=;
 b=gUueh0mVNnm/xbvWIUViMeyfbSMiIooCaQY1iK5o5VW6VJkwvtNwx0xR8/Ch9aRZrCGbJuFUtuISDeARmEDwg/VEu/Cio5ngGFQdPcO1ewJoVhJtuAU5ey5geT9HoJQTNlxL6Pgft9Ku0nsPEgINKtH4ZyuUdZ6HgCZL8hxjPWC98t9D3xZzYqTpP7TWt0ETc0/Z2wgWVHEsCXbvR3jn0tFH1h5slfYyb3xSmx4uNqlxQMrJdyOmNqeSuOa/cIGOtrX5m6OwngB2EEZQRtF4Vv2MthrpBOHDbxqp8UJOJ/5kuzZKU7+4NGh3Cnbh4E7GrvdisdAsi5h4gS2j7uj0Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9QXARustp7+UEAZ4clzkduhtcNO9y+XeGSGAWf4t5M=;
 b=Zlgg1AnZGWVeMCfIJZdY2P5/bXsxOEsf9KPOcjLIgNj3RYyPOVzdBzo3NbTTjJwu2iG4x5pGFwfoa9EOiuov8nKeBA1RBVc5RJ+n2dZtosqcJEgN8SY/mLSfhdX2WviojWDMgoGD6RHdjWSxxOEp/y2NDIWYWa9+2hL5g0YdPCc=
Received: from DM6PR17CA0020.namprd17.prod.outlook.com (2603:10b6:5:1b3::33)
 by SA0PR12MB7463.namprd12.prod.outlook.com (2603:10b6:806:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 13:08:04 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::29) by DM6PR17CA0020.outlook.office365.com
 (2603:10b6:5:1b3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Fri, 15 Nov 2024 13:08:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 13:08:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 07:08:02 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 15 Nov 2024 07:08:01 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <padmarao.begari@amd.com>,
 <venkatesh.abbarapu@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: spi: Rephrase the warning/error messages
Date: Fri, 15 Nov 2024 18:38:00 +0530
Message-ID: <f1492ac88159eda2c9642bd66ce1645ac43676c7.1731676061.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: love.kumar@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|SA0PR12MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a20a45f-c94d-4d4b-6ba3-08dd05768a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A7oes7ar5H7KO9VJe0xVXKvMbZYFBGq62+tISqtN/NmpyRCwpwIM322yZ3Fd?=
 =?us-ascii?Q?jVB1sAX5wEXTVXBV0pGcgnxD6gJNPLBj8ugEvoO5EHkdjYjcJkDniHNezGdw?=
 =?us-ascii?Q?PsyB0Pele6bOqLTR6tSnlmUkrll+DZazqhaWfdZ1ptfVxcaW+hQD21vJWbQl?=
 =?us-ascii?Q?FofoSeUmNRe3W+apYR/TlTXnKJQmKYniXxmGGXn7YY6taAvylihF0N+0/9UA?=
 =?us-ascii?Q?yPOIVfDQZhWr1ImcGsZIVF4JcHmL3S2HfL/NpGaxcHlN/W2yoKFmy+9HbNdo?=
 =?us-ascii?Q?6PZSQZyz2LAh7aJ94uiJXUPLbpB0/8zYSUYuURmLPBY0/wqYQDKLcI+Ph/Er?=
 =?us-ascii?Q?nWsWp+ttbtvFj/FUI6SU5eMKWmlm5OUwD6//DjCj15GHJQhgSmTPn/E352f5?=
 =?us-ascii?Q?JXymJ/2I63HWWbG38WD4PfNMV0XXipWwaTSFIycGXjXHGWOLV54nQT3tQHoq?=
 =?us-ascii?Q?eHyKLk8l40Dy9C2eNEVxOD3wi3M8+Ixc+1oyCNvkEQshj5TN9zMg+QvWNjhC?=
 =?us-ascii?Q?SUdOKvqnI9LYye/9FkbXgSWG1UMKtXmsVm4F8xzJGtGvBfgBUHZqQyRZr7dv?=
 =?us-ascii?Q?qNzdABL1cO/OaGhIGqHeEna61j+ZuGX9FfNJ/2dN0qqdIrS7+M6JxPAR2X+J?=
 =?us-ascii?Q?vyyJCSUQq7VgfvItT90wp6LHEeH0jJarHp+gtgU3LQ50yz+yzvL9mp3sYdx1?=
 =?us-ascii?Q?DLyr2x2ZadHiimbchucFnQslp86xBQKlR7C8hPLV4mhwmjKoh42PpVEHMUMz?=
 =?us-ascii?Q?MBsNPUbzIDR02gkzd8D7PkicEquLEEgDhDUKRCpWdtVr2sY2fhZrd8yQ0KBR?=
 =?us-ascii?Q?dUzMs3yvDGwVGXRG01NhwmNcdHsRR+DB0OH8q2TY/tqhHeZQ0bj6HqxONo5C?=
 =?us-ascii?Q?BEWHaJlhT9afYVU4mQgJKnVG5ezO/2IN1XdZWKMrGnuzw7WB+tPoGHtTxrmT?=
 =?us-ascii?Q?YYAcsi3vlwMhUpoCT5RtcphSmOhLZSEoSl2uNZRgpLHH4WSxXJTEhn2JiJpu?=
 =?us-ascii?Q?TaVuHYCzHJGoA976RM5au3x6Pw7ZSPwAm3Cy8DNi2NNpCWSjEEa1RNE8Cv4L?=
 =?us-ascii?Q?IV22g6QoYzIWRnE+ceJq0DDtXWETcdoTQ8BojPcdhFuuwg9EvTfyg+c1uZB2?=
 =?us-ascii?Q?EpSHkVaBP6jvl6vqTPOC2D9App0qsm8LRSMpcUViN4zHLGgiNYFLrzFTWYED?=
 =?us-ascii?Q?7YsZJaSS0162kyj+z7FUfKC3fIBumK9hOG2xUT9WGJisKRLpU8FM1+ALrdcv?=
 =?us-ascii?Q?kIG3WZ/kg48b5z20EBceAvSjuhoSWtwbokls5g/qiDlQDpqh630FUmO81gWW?=
 =?us-ascii?Q?nDafy/SEs71U5rHmYE8H6tz0LdN3RW4zMCIdTiOeyURy6xoZ0R5A0V7gUycv?=
 =?us-ascii?Q?468QrExkNK+3QaSYl1rUpeK63ktz1OmWr9KGul2GOGL70cfo0w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 13:08:04.3951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a20a45f-c94d-4d4b-6ba3-08dd05768a87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7463
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

Rephrasing the error and warning messages to be more meaningful and
clear.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 test/py/tests/test_spi.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/test/py/tests/test_spi.py b/test/py/tests/test_spi.py
index 44e54738dd09..0abdfa78b761 100644
--- a/test/py/tests/test_spi.py
+++ b/test/py/tests/test_spi.py
@@ -75,7 +75,7 @@ def get_params_spi(u_boot_console):
     ''' Get SPI device test parameters from boardenv file '''
     f = u_boot_console.config.env.get('env__spi_device_test', None)
     if not f:
-        pytest.skip('No env file to read for SPI family device test')
+        pytest.skip('No SPI test device configured')
 
     bus = f.get('bus', 0)
     cs = f.get('chip_select', 0)
@@ -84,7 +84,7 @@ def get_params_spi(u_boot_console):
     timeout = f.get('timeout', None)
 
     if not part_name:
-        pytest.skip('No env file to read SPI family flash part name')
+        pytest.skip('No SPI test device configured')
 
     return bus, cs, mode, part_name, timeout
 
@@ -92,7 +92,7 @@ def spi_find_freq_range(u_boot_console):
     '''Find out minimum and maximum frequnecies that SPI device can operate'''
     f = u_boot_console.config.env.get('env__spi_device_test', None)
     if not f:
-        pytest.skip('No env file to read for SPI family device test')
+        pytest.skip('No SPI test device configured')
 
     min_f = f.get('min_freq', None)
     max_f = f.get('max_freq', None)
@@ -116,21 +116,21 @@ def spi_pre_commands(u_boot_console, freq):
         pytest.fail('No SPI device available')
 
     if not part_name in output:
-        pytest.fail('SPI flash part name not recognized')
+        pytest.fail('Not recognized the SPI flash part name')
 
     m = re.search('page size (.+?) Bytes', output)
     if m:
         try:
             page_size = int(m.group(1))
         except ValueError:
-            pytest.fail('SPI page size not recognized')
+            pytest.fail('Not recognized the SPI page size')
 
     m = re.search('erase size (.+?) KiB', output)
     if m:
         try:
             erase_size = int(m.group(1))
         except ValueError:
-            pytest.fail('SPI erase size not recognized')
+            pytest.fail('Not recognized the SPI erase size')
 
         erase_size *= 1024
 
@@ -139,7 +139,7 @@ def spi_pre_commands(u_boot_console, freq):
         try:
             total_size = int(m.group(1))
         except ValueError:
-            pytest.fail('SPI total size not recognized')
+            pytest.fail('Not recognized the SPI total size')
 
         total_size *= 1024 * 1024
 
@@ -149,7 +149,7 @@ def spi_pre_commands(u_boot_console, freq):
             flash_part = m.group(1)
             assert flash_part == part_name
         except ValueError:
-            pytest.fail('SPI flash part not recognized')
+            pytest.fail('Not recognized the SPI flash part')
 
     global SPI_DATA
     SPI_DATA = {
@@ -574,7 +574,7 @@ def test_spi_lock_unlock(u_boot_console):
     min_f, max_f, loop = spi_find_freq_range(u_boot_console)
     flashes = u_boot_console.config.env.get('env__spi_lock_unlock', False)
     if not flashes:
-        pytest.skip('No supported flash list for lock/unlock provided')
+        pytest.skip('No SPI test device configured for lock/unlock')
 
     i = 0
     while i < loop:
-- 
2.25.1

