Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA482C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 07:33:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BCFB889FF;
	Thu, 29 Aug 2024 09:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PCSxE0Uu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A608288360; Thu, 29 Aug 2024 09:33:25 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8A4E88B1D
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 09:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pa8nxqQrMCeJej0c+zJLGa430IsQqDi2NyCWK716pSN+FwN0GEdNlkFlDIluUz7Gkj81qkM9Ru+CNSVqJg+whuTTfI1w+z+CNCN84u6GJ6E/3cD30arXkQ/WFHXJo+VUoDnSD46OzvZ1OljyItfG2zBBPfvF6hQ7kWGEoVwhGomuIa28yGUl2Ub0n2IlwLZDp8j8cn9zvM3wWMOwlz/+KNQvK19hf29AxJLW1SzaRZ4UCrN2FmOy/N81T3FSqcilJvstiEFigGQH9kkIdNZitgrK2zCgWj11YhMnmq7KHIZcHIlZSH7lA2+MagwGDbAYVkMEkyMYwMu+yzSwH6JSpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Tz/MFGMikV9pS8KDGF9elRZ02JxRtTjnsFxp4oswS0=;
 b=eaPNHVxWlsc9KaJ7HhuRA57PevVfa05kBe0v7mcyn4htGWpii11GdFTcvAx8/dkm5imTtnsbCgOvrZSYY1R7blNOE/qVTSapcy1HtPWCLJxjFtKDGgO8H6cmqS88zQbuUkDsGwQDPrcqZmqgA0MAvFiMh2pxXsHR68Td+3wmJHAvQPWTSewbz3fV6AUCwkp+J/61KnuF7WUIvciI82vwQqKuBoLGWav/gGqWne6cBI1yaRBsI/84t/mygpajvYmX8Ho+lNVMI6jC7Mt2o+rStSVNBBqpHXdbtQ+9H0RnSFVxWOAgbbcHEiSKoUqJqluqGRbhWsztH8C+zb7kAID20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Tz/MFGMikV9pS8KDGF9elRZ02JxRtTjnsFxp4oswS0=;
 b=PCSxE0UumFctau+TnfCcX7dInURFeBcAsRiXKx+hTbJIl+5CP1+pWikT4JWRZPwCRwY6fKcX7PDiunfiwDZPh1KALoadE6ouoXm3W1avfWTM8zdKATE8HPos1fNqS5Zvw+bKerMb1XL40gUXK+4I3STeQkdtpcTI6p6RhyEoHD0=
Received: from BY5PR17CA0050.namprd17.prod.outlook.com (2603:10b6:a03:167::27)
 by SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 07:33:19 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::2f) by BY5PR17CA0050.outlook.office365.com
 (2603:10b6:a03:167::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Thu, 29 Aug 2024 07:33:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 07:33:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 Aug
 2024 02:33:15 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 29 Aug 2024 02:33:13 -0500
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: spi: Set the expected error message
Date: Thu, 29 Aug 2024 13:03:12 +0530
Message-ID: <6df888784a8f6fc4957cd870e35501f15130753a.1724916742.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: love.kumar@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|SJ2PR12MB9161:EE_
X-MS-Office365-Filtering-Correlation-Id: 1597f10e-da80-4b15-4e24-08dcc7fcdabe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nXe0hHY5EG1ZyPM68vWrCZLw2IiyYtGwQ0Ok/JWpZxqt7jB8sHyfRlUNrd6a?=
 =?us-ascii?Q?7kiSvzbf59J5Qrau2uTsDDj6gVPLY4c50X2HPjZzXbREaE4OHVUmSIvLxzoA?=
 =?us-ascii?Q?Z240ZiQ2tA6OyLwq+/vwIeWb0QD9VEQ8yzUiz2h+W/MTjA1ZngfSz92CZvpO?=
 =?us-ascii?Q?E4BAO7L67kkMAuYpUMC4/GrZhxcGxW9Dn0oMisRlNPovmFjhv8EkbVlfgTMg?=
 =?us-ascii?Q?niAFE7q58bfA4uVs72J3aXBRLsZpJhmxbGC11a8Bwsp2qRiiKuzTBRzcpQ1L?=
 =?us-ascii?Q?p8nfaHhmG4/Z+Mfhm4FWAqKtiMvgPvZkwDZky8W/CsJYdXwrFi5iQ7AGN6Bv?=
 =?us-ascii?Q?rdfS7pL6IppWnfc+B4hiDossb2vaLz3FjHyNFPgLTrwNVby1Q9OFB+Ykgu4N?=
 =?us-ascii?Q?HEfHcSCP+5Oxnt12HkZ9B30v24yqqo6CjIMdhh/3VM43qfh4m/z7x+ojlzYY?=
 =?us-ascii?Q?8ZeV+DSdBq8Fo6xr9zYCFDJGkpP+GgeaHD8U0/o98bcy8vIp6m9O84/iR6oU?=
 =?us-ascii?Q?d42NbBZ6cgp0SR5y0iiMdKwGfZ21bpVjlsi77jW99Dpy5y9nFkIGeYPv2a54?=
 =?us-ascii?Q?ZNMrTrwaFAcklAhXwcj4ASh7PZfP+wmcXoBY96QvMJuenoApPLnHAY0NIsaI?=
 =?us-ascii?Q?afv/tmSXW6s8XmpRto4xP3vfWzVZ8PTpty7kMzbCA5MHAWVhAukBTwztr1jJ?=
 =?us-ascii?Q?ZfCzoGMFQuOQKa2ngKQ+uhy8GLOdwzHiHhzJVet4lEHdkvz1aFEiNCZ1iL5R?=
 =?us-ascii?Q?rcxhnn/T0f4TSHcQlhVNN6Pm+ViwhHD87SoRtmbIx/22vUNljncVuY0IHdfH?=
 =?us-ascii?Q?/KOpNozxvLXzylj7WAg8197gVUXGLp1FLr2Tu+A3E5trjJODD9HLZY3pch9l?=
 =?us-ascii?Q?dD7pmJe/hzfin31osG0Uq/sfyedhBIDwvPjj3yj2qhVM3cufwDMdd0sNnPTW?=
 =?us-ascii?Q?3YOULREyTiD+rADUj82BTGJHv7Xl23/hVI2oimf6CiXX+LfA7zLe8y0E53SE?=
 =?us-ascii?Q?0QV3/ABB5xphBDZZiVFdDtB7zTADzTiVovxgHV9rtXN5VtT1iHGI96WZdM9Z?=
 =?us-ascii?Q?t1tzd71yHoVL4s1tU14atTM5akwU2+a7kla8tJ1IXca3tPr24P34z8UYKV1D?=
 =?us-ascii?Q?lDamyuLnEIc+VKaocITv2gjXOqRMviIM19MQi0bgD8qx9l6b4HWxeKKPNffl?=
 =?us-ascii?Q?7Ere1Nwne/c8qhzkyedw3JMFFzqRZ0JCmhGTh3AL/29SG2MxoGyUo37xKKM6?=
 =?us-ascii?Q?157PVbnzBwfo2bLuVRx42BKnaAjNxJnStoC6bKze0a2mj4rRKZk9yIHzMdIZ?=
 =?us-ascii?Q?KLLs7DRvYYtD/xVc8fInJu8wSJBxOdS9WMkrzHv8gpGLcun5Dw4+InQwgS4f?=
 =?us-ascii?Q?bXhTCSp5OujTQp1SEnD7F9ZAw3I8aqzAYbXyDdneVocNVGeaUJ5/ayNebLOn?=
 =?us-ascii?Q?5bb1Fe73Wma/zTHhZXv1C8AJv22B9b6f?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 07:33:19.2233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1597f10e-da80-4b15-4e24-08dcc7fcdabe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9161
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

If erase/write/read size is 0 then it throws the mentioned error message
when debug message ie enabled as per "899fb5aa8becc159b1eb086d8828c4e8eb28f121"
, setting it to None as debug message is not enabled by default for
testing.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 test/py/tests/test_spi.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/py/tests/test_spi.py b/test/py/tests/test_spi.py
index c81eca5fba6e..3160d58540f2 100644
--- a/test/py/tests/test_spi.py
+++ b/test/py/tests/test_spi.py
@@ -646,7 +646,7 @@ def test_spi_negative(u_boot_console):
 
         # If erase size is 0
         esize = 0
-        error_msg = 'ERROR: Invalid size 0'
+        error_msg = None
         flash_ops(
             u_boot_console, 'erase', start, esize, 0, 1, error_msg, EXPECTED_ERASE
         )
@@ -685,7 +685,7 @@ def test_spi_negative(u_boot_console):
         # if Write/Read size is 0
         offset = random.randint(0, 2)
         size = 0
-        error_msg = 'ERROR: Invalid size 0'
+        error_msg = None
         flash_ops(
             u_boot_console, 'write', offset, size, addr, 1, error_msg, EXPECTED_WRITE
         )
-- 
2.25.1

