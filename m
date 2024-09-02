Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A162CA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 18:38:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E1118884F;
	Mon,  2 Sep 2024 20:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mO1q5BN+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B231888FB; Mon,  2 Sep 2024 20:38:28 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00D138857C
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 20:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4C+7MdTi4VG7o+H+TEpAsiT3olRE46bcJdmSxnI/zVQ8/WQQGtuYQnNEv5fu5/PYiTvtW73K3OhXnlIZwao1y5obApOLB2jyw5vG5GGTsHsZzC0pSTWa0RHmaJaMOOoW25cos0S/H3/O9LG0VdMv6379emaQHGW9R+c7a4cWCQlH4RAEBV3fKLKxGiUSHJCysoJyHuN7uzBY1pU1HG43YnrxpIn3uv9aSXYB27Lmme4v/f9lLplM1FquT25FjlVhI+P2mP9J/c3WO800eYqc+C7cpgw8YG6+B9LxDhv31ahrUuLJNQFYj3nxBHhOjP7mwK+qi4JMixWSVl0IiBpGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0fXXTkLDY0KHuTV+4Vp3OZ5XDexFuPgHCk7lBuH2FI=;
 b=vx7pUV7MaoRoobmTNmgWRRgYLSf0weN7jM0k1qtEhMPxcBAUkoPulifNX4WGGHse1ASRJ1anCiffLxACeRMrqzP4/bKNmo1YMsqxM+45Cr24QZmOJxLKC69YGThyvzdVjH7pT6siyEoseg7lccrLMQYyu0OLoC2Mp2Zv3DHYg2+tswSI2ScUo3JH8zm8972EJsZhaohcu0eoCNhMOXUwtcxHM3Q9SIOL6ncEY2EEP8a+JXfKt7y+rlf/uotXqaXLsHJWcRfatbAqKF0/bUlmnIgZhBurcFo/oc1Ek50K1eeLFPO9TwyBm+NXB/r1gBH4Chg6+KhxVvbtYwbFWCHx5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0fXXTkLDY0KHuTV+4Vp3OZ5XDexFuPgHCk7lBuH2FI=;
 b=mO1q5BN+XQ4YUMbh/DjSNm/PbGDjSwbDemUPFZebjUyXbyw6cKxkg5kofHrAhNx7Smw+c97PURLWRD0LKM0aG3mdJepmM0apLZJ+foOW54PtDz+1A2+BF8tx9t/a0xG5rKAF9tpwlLDvcVRdFhy20jYzOUDOpKa+2f6zemJGKP8=
Received: from BN0PR07CA0025.namprd07.prod.outlook.com (2603:10b6:408:141::28)
 by MN0PR12MB6343.namprd12.prod.outlook.com (2603:10b6:208:3c0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 18:38:22 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:141:cafe::81) by BN0PR07CA0025.outlook.office365.com
 (2603:10b6:408:141::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Mon, 2 Sep 2024 18:38:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7962.2 via Frontend Transport; Mon, 2 Sep 2024 18:38:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 13:38:19 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 2 Sep 2024 13:38:18 -0500
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v2] test/py: spi: Set the expected error message
Date: Tue, 3 Sep 2024 00:08:17 +0530
Message-ID: <a7d8e32cea978727b902bab5c7ca9e8cf17a0d54.1725302269.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: love.kumar@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|MN0PR12MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: a1be568c-6c32-4502-2442-08dccb7e6c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4Wd45HReHSM6NjRBO+FbE3QCzZnG9IAbtwo/IV5omug7qIvRH9q3f0HKHDGC?=
 =?us-ascii?Q?kL2sM0q6PEamQ2EhAUn6d/2N2Nu2LgxDrQK0G+PnDKExx2MBueNMznUaWp54?=
 =?us-ascii?Q?cVng1rfqtVxsVnyfYnVhgPiOtpNIWvTfv2AXzE3jJlCvxaztfpby5dQ72J8y?=
 =?us-ascii?Q?Bxz69WWlorDdUxKSiioobHh9xGN+JquFOItqOTT2YxtYJk1bF8T1ewFOBFzd?=
 =?us-ascii?Q?c32wBiURZwqgDzOwC1ChrlVfQ9MUT0uE1L28QRQWeBNChIknGgNhXwj4W0m1?=
 =?us-ascii?Q?l5vsv5b0kmGoH73E4My8KYMauZ9ZnQPvaOX7eEKiQ3ynkFZnPP96RJK/VkPQ?=
 =?us-ascii?Q?wt9JnJRXQemxwRoLSB0fdDc0aNzZV/0jJ0Na0oWfaSVJIo3rWYNsgBYBdO6l?=
 =?us-ascii?Q?mvzj0jqqCEOhB7pd9j9eCBEzU4Xfw1GhV9MomPduQ+mqcjiw/nI+hJVyofr1?=
 =?us-ascii?Q?tUr/jQcmb13qJB4OIMx8uRzCvDvvABcvfNlHEyL3R4PsrAkiulhKZ/BCKVed?=
 =?us-ascii?Q?/JFatOso1EHODg5pRQ0pxwPR1xM239DN0D8H4HcL3JyY7qL2v1EhVb2hpCHZ?=
 =?us-ascii?Q?V3UJr4p0+uBVJrlOH/lp/LLGo06pIgfbZjw4imz1Jj/Wq7MIzrZKwNQIbPXv?=
 =?us-ascii?Q?SPQxCcgSaCM8R/Xx4RtPxXMB+ICPPUfd8FEdxV/vqtQL9vf8LixdY5RXU6+1?=
 =?us-ascii?Q?MIgyZL2yY7f4byUkoH8+t8jyXGVpj5u421t8q+s6j6R3HHyz2QC+smWBrcxc?=
 =?us-ascii?Q?e8AJlUboNlotCUrhpS0I0dlbT6XU/su/HrnlDrzSCR9xLcBd7OFsBAPmu9uW?=
 =?us-ascii?Q?PGYF5d1TfOu5GX0WrM/FuK4a08mStZyB4eHqnuNctXPbBm0iCt10SJR9Sx/K?=
 =?us-ascii?Q?fOH5PHOVn32NpEzTzvhTnlH2tyXT33yiuHZtWadJbnt2IQoctr8q9+NtbdI/?=
 =?us-ascii?Q?ZYyqM+eFi3JPPhMuMt3ZSZIbeKwWY45W/yhaUntf334snHPqqnxfafPwSwZ9?=
 =?us-ascii?Q?Pmeq792TE/GvGhZdT8yqO9Xwy9lc4T/fRu+sNF4HYDlhRPeiDHE/y1wpsBY+?=
 =?us-ascii?Q?ZgxnXzp2nfWobTtoQad3ai05nuzkHnfIDsTjvGTn77bUmLY0TDUfogVG73hv?=
 =?us-ascii?Q?5AN8ESIa3kimBylXguQvSDuaBAgpKP9bp+7AwzStC7E2nWqKMgGiiy/3ZHei?=
 =?us-ascii?Q?QcBK7t2j/uFMMm9kzAVezLTR7Eq8Dih14pn8NtilXGuQtGCorvOhQBRULf3E?=
 =?us-ascii?Q?dNMl+CCqkQ5J5JX3AOadc6ndMRtWBcHGOW3IHyBav6UFM0sVFKzT/ytwJYBl?=
 =?us-ascii?Q?Thb6NPKEApNt1mZtDiGWDouI9EiKQ0s6L4yyW/bpmiTprr9Y8fJ4KsfZgz+G?=
 =?us-ascii?Q?0OpFSoy2QcFYfIkZOr03frX9YAyiX3oVsjllVNKfBPtQ7oYpp4UQCxpEqOA6?=
 =?us-ascii?Q?CGj0k1bv2gDxQUHpYuMwYpHpUkIrkOVK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 18:38:21.7409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1be568c-6c32-4502-2442-08dccb7e6c1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6343
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
when debug message ie enabled as per 899fb5aa8bec ("cmd: sf/nand: Print
and return failure when 0 length is passed"), setting it to None as
debug message is not enabled by default for testing.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
Changes in v2:
 - Updated commit message
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

