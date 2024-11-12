Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25E5D41D70
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 08:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6686089427;
	Tue, 12 Nov 2024 09:57:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qdil5IgJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56E39891B0; Tue, 12 Nov 2024 09:57:47 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4936389428
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 09:57:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIL06EGc3LpLmBcKpBwPE+4RRqJMQph7mCiIACO2Ldtd/JxOM0awLiAAydyOvlfVK0y1rAnoIPpZnb4WtfbAhfhgDniSZ9K517YW5SuTwPIKa3zbQjn+gCeBspvg0weWz55dIh2Zn1rQvFsQnevhzjq7rGvpLqqlfvkGGBR6FJKFeErohZWzd8fcW1wtQizSqWZxVPJfFwUWONkkVEQhGcflrn5LBwR+pey5g9dPk1pSxbED5L8j7u83mVujabLtod4mkY/x8S+PzXYmOwgNgrIA28ghAi2Cy1cmS/quGoW3Tec1Boyidy5zQiv2QS5xcw0ditXqwYCF9AL0XEn6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ix9KJbU2blmU47+fDoIiJ3SkDfBYku9sZEWRCHn6lw4=;
 b=YeCsYFXtPvgpqZKvqBZlI8Jb21bLN4iU6fHp/aH3cO2AIj+5H/4miob+pc3DzIix3no7vECjUGSaE0pJtj7l81JqeVxzr5LVllcb0/1prEKBeu8mVh44q/dfGHKMm/Udvt0x6lyPzoADCM5AIinTUtk64hyFRPVYQVzdcYXo7ldp2U3mH9EdNcNU4mIELC+uGTi3Hgls+Kf35uwRCrDFmPhuLYmoHEf/qSBBw/8ERckAd/frOl/ZDarE2XoW6UQ6A7n2XnuOjW6hhjrF+R6IFJrQ0+oOpI1YOfGJAZV6UMXtDHHeB+ec6rs2Jwd/Pt0KSVOJBcPulpuEzZBR/Uiyng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix9KJbU2blmU47+fDoIiJ3SkDfBYku9sZEWRCHn6lw4=;
 b=qdil5IgJyr8ISkcJtgdK1H8ixiQTCTUTPaEHjsIDKT2huyzl5KrSchlD5s6BQ2J6+BHNaISfSR3S//7HCgh5p7gjNdCK/cgxqRTRFo1A757BlO62L30N/73GpOxhTLOt6Kp5LVWeTxR27IXJuIRImvvni83NU5hXqZ1Gd/IR2Ds=
Received: from CH2PR14CA0040.namprd14.prod.outlook.com (2603:10b6:610:56::20)
 by LV3PR12MB9235.namprd12.prod.outlook.com (2603:10b6:408:1a4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 08:57:42 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::31) by CH2PR14CA0040.outlook.office365.com
 (2603:10b6:610:56::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Tue, 12 Nov 2024 08:57:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 08:57:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 02:57:40 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Nov 2024 02:57:39 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: usb: Distinguish b/w ext2/ext4 partitions
Date: Tue, 12 Nov 2024 14:27:38 +0530
Message-ID: <0581a1274f4aefadd5a3df8c503cd59f4f8935a2.1730797446.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: love.kumar@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|LV3PR12MB9235:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ecf9e7-cd42-48c4-5c71-08dd02f8110a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t7VNmAQpod9KQm+DKEBo1g+Lhj7paxsp33S8g5lkAxlIWjseDWft1zIP+XFM?=
 =?us-ascii?Q?p+CfAbLTcXbDv+fhZ9tyvYeER8hb6LkDcFvJmJzawk3u2CPR/tt3r93YtNMY?=
 =?us-ascii?Q?VqmPLzQrSsCqs59ITSJKZxhaVdu+uIGDBlV4YAB7wMtZbwugeSKDcghyYLR8?=
 =?us-ascii?Q?BC+XGvh7kABweAIwyNXpoJL1eOMflD7osH5xTrYfaBZfJhUZ44U9Gn8JszD2?=
 =?us-ascii?Q?1IOlfDOOzJ9sQLcuqr4SOnVlx5mqeoDEbcFWJogGPLMg/mUoKRPEq1Ew6N3L?=
 =?us-ascii?Q?Hfu1luah1Rjb+ix3fZtYrMF2snI+sr5GIldLC5+TcrSRr5bYhzkFNCyWGf74?=
 =?us-ascii?Q?cBDOBlmYse/XpTwr0UnEkeq4G7prl2/mWcsSCFrj/tu/llRL2XQyZJOIslGn?=
 =?us-ascii?Q?/WN3QRqlAXinRecRkWV6qPRnnPW8Tg9legufrAHrFs/6ZaA47P6cypfKv0/u?=
 =?us-ascii?Q?xqmigp+7rJXdX4gNE4m2PaMxHtvqxlAz3k0K6VYQNNtE+vuJHZWFSGsiupzd?=
 =?us-ascii?Q?x5TEHHwETjadYUvezzYK2wvIzJgvfiCQhDMpwS1ucSpOD638ZdUnXDkN8DAU?=
 =?us-ascii?Q?VQ+GKSHYt8kpetyT0X0j+M/uFYZeJZz0EYhfWewAy2SzUiwijCpZQbJ6DF3t?=
 =?us-ascii?Q?F/RcrpRJZdS9mjgA0c6H1ci7bhLpfQ7lsXgAPvA5deraBowuLPx2bXooznZv?=
 =?us-ascii?Q?1BaO8zq0vQGuT8PvIuHCBwFfaMqStlxXXxLvsd/MnUb5vHz5062EvsccKlKN?=
 =?us-ascii?Q?WjJ31p1awUe34vCwoLjmKRC65Qc8bg38t1pj8EefrZP1GclLuXH9JVF4/vv9?=
 =?us-ascii?Q?5YGL8LxItEsLbNLKNSkCM02h8KFRujKWaslk2YIAs6Zl1iGpcxxGqNC64ohK?=
 =?us-ascii?Q?Co5xyoe8hKMMTEy+y3I3JYC7L/PGhHv8cMywBSiNVGA2tZfmc10jjny7c8TG?=
 =?us-ascii?Q?CtdNqQKoRrLIWkB8776SwvbgabEeVW07UFKnk3mxkwBWFkcVMvp28EM6Xiv8?=
 =?us-ascii?Q?m4gPx1xQ4TR0HA7nLLbQGXB6V2FhUbmdRmisHphitEvT1j/pHBeCV2kuvDm8?=
 =?us-ascii?Q?ef8GWngZLW8d2D8WTlAU9ugA2uNI4jdfjlQrgrYGjxEfnkvO75nN/xWAf5BJ?=
 =?us-ascii?Q?7jGQF70O0DAYuNaTpTbdANM8lO1x57qAexxPi3XMWYkpxduwkLvnoi42FJha?=
 =?us-ascii?Q?xVNLOG9M/9ScYoZxMDQZxU3ZiO2OEL+pZrX6FERIXRgxTmCWk2eX9tAFi+Bp?=
 =?us-ascii?Q?wfHGfAD3/uSqc/oHD8aRxWQPfa3Um4cWIPV1lK+OtUsnBY8k+5e15Wt8YgSX?=
 =?us-ascii?Q?rfu4ESzzOVMVlQSHNv+AzpDAnSs7vBbywaOerGOWkdY1vwqeI39ceT5Rn3bL?=
 =?us-ascii?Q?fE+xT2o7jiahFSIhsgzxn662wBJvOKARB6qNL44i3TUwiBWIdg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 08:57:41.6577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ecf9e7-cd42-48c4-5c71-08dd02f8110a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9235
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

'usb part' command shows the partition maps and shows the partition type
by displaying number such as 0c, 83 etc. Observed that ext2 and ext4
partitions shows the same number, i.e, 83, so, using the fstype command
to distiniguish between ext2 and ext4 partitions.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 test/py/tests/test_usb.py | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/test/py/tests/test_usb.py b/test/py/tests/test_usb.py
index 2397fd3c2e7a..e1f203b5cbc9 100644
--- a/test/py/tests/test_usb.py
+++ b/test/py/tests/test_usb.py
@@ -227,7 +227,8 @@ def test_usb_part(u_boot_console):
 
             lines = output.split('\n')
             part_fat = []
-            part_ext = []
+            part_ext2 = []
+            part_ext4 = []
             for line in lines:
                 obj = re.search(r'(\d)\s+\d+\s+\d+\s+\w+\d+\w+-\d+\s+(\d+\w+)', line)
                 if obj:
@@ -239,15 +240,21 @@ def test_usb_part(u_boot_console):
                         print('Fat detected')
                         part_fat.append(part_id)
                     elif part_type == '83':
-                        print('ext detected')
-                        part_ext.append(part_id)
+                        print('ext(2/4) detected')
+                        output = u_boot_console.run_command(
+                            'fstype usb %d:%d' % i, part_id
+                        )
+                        if 'ext2' in output:
+                            part_ext2.append(part_id)
+                        elif 'ext4' in output:
+                            part_ext4.append(part_id)
                     else:
                         pytest.fail('Unsupported Filesystem on device %d' % i)
-            devices[i]['ext4'] = part_ext
-            devices[i]['ext2'] = part_ext
+            devices[i]['ext4'] = part_ext4
+            devices[i]['ext2'] = part_ext2
             devices[i]['fat'] = part_fat
 
-            if not part_ext and not part_fat:
+            if not part_ext2 and not part_ext4 and not part_fat:
                 pytest.fail('No partition detected on device %d' % i)
 
     return devices, controllers, storage_device
@@ -497,7 +504,7 @@ def test_usb_ext2load(u_boot_console):
             for part in partitions:
                 part_detect = 1
                 file, size, expected_crc32 = \
-                    usb_ext4load_ext4write(u_boot_console, 'ext4', x, part)
+                    usb_ext4load_ext4write(u_boot_console, fs, x, part)
                 addr = u_boot_utils.find_ram_base(u_boot_console)
 
                 offset = random.randrange(128, 1024, 128)
@@ -526,7 +533,7 @@ def test_usb_ls(u_boot_console):
     for x in range(0, int(storage_device)):
         if devices[x]['detected'] == 'yes':
             u_boot_console.run_command('usb dev %d' % x)
-            for fs in ['fat', 'ext4']:
+            for fs in ['fat', 'ext2', 'ext4']:
                 try:
                     partitions = devices[x][fs]
                 except:
@@ -556,7 +563,7 @@ def test_usb_load(u_boot_console):
     for x in range(0, int(storage_device)):
         if devices[x]['detected'] == 'yes':
             u_boot_console.run_command('usb dev %d' % x)
-            for fs in ['fat', 'ext4']:
+            for fs in ['fat', 'ext2', 'ext4']:
                 try:
                     partitions = devices[x][fs]
                 except:
@@ -570,7 +577,7 @@ def test_usb_load(u_boot_console):
                     if fs == 'fat':
                         file, size, expected_crc32 = \
                             usb_fatload_fatwrite(u_boot_console, fs, x, part)
-                    elif fs == 'ext4':
+                    elif fs in ['ext4', 'ext2']:
                         file, size, expected_crc32 = \
                             usb_ext4load_ext4write(u_boot_console, fs, x, part)
 
@@ -600,7 +607,7 @@ def test_usb_save(u_boot_console):
     for x in range(0, int(storage_device)):
         if devices[x]['detected'] == 'yes':
             u_boot_console.run_command('usb dev %d' % x)
-            for fs in ['fat', 'ext4']:
+            for fs in ['fat', 'ext2', 'ext4']:
                 try:
                     partitions = devices[x][fs]
                 except:
-- 
2.25.1

