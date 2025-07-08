Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27997C83F09
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 13:42:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25EDA8331F;
	Tue,  8 Jul 2025 15:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QRcmntZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BADA83323; Tue,  8 Jul 2025 15:42:07 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD7D38331D
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 15:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2W+25jzoTMIPNe74kQ77dN0OxSxC+RircTRzhp9YFhtT7OXkQWhD9wYk+G5eRuzslux6vJwRJFgJPVRbmIaQGdn+lHY7CehSvViRMjT8zfT4D3274p3YgM7f3DYT47785Fdse4fTAHhcPN55NVDXNKaXeCYr06aARKl00IqI2DjetnJCRnVDfkRIKnifc03Al1+w8qHK++Nb+5enNijL/0+9k51b7iZCI1MgBQk94qsTNTDzAK7J3VqGZcJ8Y4SQcaFjqGLhohnffMRNKfJsteV/3ovbA0IkVx614rWaZdlRLzokwQxrqBzGmP8Ck//FUAbtnzrvy/Y06i1PHKeiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVBRe3chYIviy2fZFcEkvt3G65qNc5LLNm6H26Kp0bg=;
 b=gjboj2RpkfO8mOVWkS0lnLK2FWeQhH0UOg1ChXlOUlG4YofketBn14s7KRw5le0IULKRVoujxED8umxe4Xzx4YZNzlHmy9iSRdft1VgvLlw9kVKxeJeHePOr9qhJnEycCyY/nx2SMSgG/AqayKcv0EehvmEisJc7qcBX7viJWNc/ik0PQkHGwc/OjRxcH/ZmikSWOJI6rxviBBVh0KF2byXNSZgXRyxXKRY9sef12cBJA8HB9YhPrZ9ogFqmuIAL2TjZcWsufd/nT6vuft2apCQ0McXRkLMUuIth1AodlTwlg06OnrkMEyU59p4tGq0YWjOVTCUlp5zvLgnK9xb/xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVBRe3chYIviy2fZFcEkvt3G65qNc5LLNm6H26Kp0bg=;
 b=QRcmntZ4HPS1UWLonco5K437q5F24tN6QvxDs3sHY2WVmagdoqCzBGj7PlVnEU4loW2M3ojkiTUAaKUj8YYe89JrWCitQ+P+7C3tcHOgb+/w70rJmpvYBF5A9fUkzJwq99lRdBbXxcF6Zc4EJYkvuEEu3TurM4P+o4VODrWhPNE=
Received: from BN8PR15CA0022.namprd15.prod.outlook.com (2603:10b6:408:c0::35)
 by IA1PR12MB8079.namprd12.prod.outlook.com (2603:10b6:208:3fb::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 8 Jul
 2025 13:41:59 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:408:c0:cafe::66) by BN8PR15CA0022.outlook.office365.com
 (2603:10b6:408:c0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 13:41:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Tue, 8 Jul 2025 13:41:59 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 08:41:55 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 8 Jul 2025 08:41:54 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v3 0/2] xilinx: update guid with fwu metadata
Date: Tue, 8 Jul 2025 19:11:40 +0530
Message-ID: <20250708134142.327224-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|IA1PR12MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 139de123-e353-4a7b-105b-08ddbe253696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b/pxcRnEfvtUBojfYRQY8rjcfq/g0z8KlAYi7b3Uia/qiKKSqDW6dVC1YyYb?=
 =?us-ascii?Q?BDVeGLOHzdnEsT1d9CD/hb2yBmVHAOoD9HfMMVtOLbjvyKunCGLFy557EILn?=
 =?us-ascii?Q?UVEivjBTRrGLsIrrkUZMSkXov8pQQIwAC9bJWDHQr1fRpZmUvNOHaOqxPOP1?=
 =?us-ascii?Q?dFP+kK2IUwSFCzv+J9J694DX6eVVhVVYyr7qyoFmMCg8hpJ4694L30N34rdv?=
 =?us-ascii?Q?QwhGsRoYLhTR2bDfJp1jmNfuial0PJWWdiEBsOB5DObNnk//gQd3VpXpjLhv?=
 =?us-ascii?Q?w+UlZblXtRY0zn4dXBBgRgYTZnlHar9WUN68zTCMz+HS53WKcGf98ZTT4lQ9?=
 =?us-ascii?Q?0czhkhmJ6tGTgcQ88lx8wXwMJaH4R4jcfLQgqnizV4PdJJ3aqw4KBmHqyF6g?=
 =?us-ascii?Q?W6o/EfBaIaPQf7ZeglfVNOGPKS77pvUNBycTHsAtHkJRNQvgpV1QNEWREQHu?=
 =?us-ascii?Q?jtIxrRf0kSIQu481fZKsCqZlOoeY8OUtqDWC+CZl8UfqF5eS2mYLaKofITgm?=
 =?us-ascii?Q?EQAfJ7tRxBTCtf0HocA61diMWUw4bq4uJLZMe+VvguPdycYuWG5cq6eMTVG6?=
 =?us-ascii?Q?DsaGBsRtqPE+OiyhN8pJd80IqxIFDNY2zWMfYQ62ZAxHdvUC0i8iy6XTHHU6?=
 =?us-ascii?Q?IPhSmpvUkfbdEJtse+OjjZtjOP5g24OjU8FJ6kkGmuSv/DBA+M39A/z6AHRt?=
 =?us-ascii?Q?XzsWPHLUta1KOvZfyuAOxhfMKje1ghYY27BUdw/hCcEMJ605UjBVTtTKRAkN?=
 =?us-ascii?Q?TqHgVSgPLeVLSGIfxNNvJK3ZSzjRnXJWftQuaoIuPtlwU4NP1LpvciMicrRT?=
 =?us-ascii?Q?GsF/OruN9wTycYp8Ilma+9ZsugBeYfoQ4+Wo1aWUal2vaFImw3tzKXTqS0bj?=
 =?us-ascii?Q?fLcm0ZkCLdPZwBLmpXIBgnTLwZKEKT73MrJzA1ccCTk/mKbhb3gHpCr+Dcdv?=
 =?us-ascii?Q?N+OknT0HBxqkX0uodbwJ2CuFlatfrPctlcFcvtWZtqK6gOA+mmqgqx39V9PI?=
 =?us-ascii?Q?S2Nx9TwByaxxL5kAGF38T4OfPqZKCSJ/weuzXUEPNytFnYbu9XBcfej6jV4G?=
 =?us-ascii?Q?H3prHdPTfOHFXWSqFH8eoRI4+vvgHqNfRivCqTE+6du2T7VMt6aWoeN9pJu5?=
 =?us-ascii?Q?GqVKIkp6KnTkAGbTe256AwE4Ybwc5agvhY0HYjjJKUYZb6q1oaeAnbnku46g?=
 =?us-ascii?Q?UzkV+olib2z9fDSG3xAPMzmC0x+nBtfrZwWnovskuYYxZP3oWAmgWucHQO33?=
 =?us-ascii?Q?ev/Sl4svbUzjLmH+ZhxVyzP/2aV4SKxXliN3Eu+PtyMYh4iAbLju+UW/pgia?=
 =?us-ascii?Q?Le2vxmQOnubOETyqTWviGNwGCGejPjJ8UK6BXxl0/vcA2z9DahiK3IpfaBKa?=
 =?us-ascii?Q?CbcCMA+b+/9Jiu/toQKHFFwC+1uEoRZe16c9CQPg1TI6ExnZ4FeDYv5bN8vO?=
 =?us-ascii?Q?3bxP2PZWhBhQAtIPWS8FcLUB6Ce9FcVKmnRQUORSbPr9GED8cb7MkiSN8PYr?=
 =?us-ascii?Q?LJk2wthum5GKz70TNMvc3p/jQqP7/yVKw08Y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:41:59.4924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 139de123-e353-4a7b-105b-08ddbe253696
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8079
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

Introducing the fwu platform hook function from fwu
initialization to process fwu metadata information with
platform specific operation, and use image uuid(GUID)
from fwu metadata structure for fwu multi bank update.

Change in v3:
-Update Note in function
-Update function description
-Remove ENOSYS

Change in v2:
-Update commit message for FWU mdata
-Remove platform_hook() from driver, add weak and actual platform hook function

Padmarao Begari (2):
  FWU: Add platform hook support for fwu metata
  board: xilinx: update guid based on metadata

 board/xilinx/common/board.c | 26 ++++++++++++++++++++++++++
 include/fwu.h               | 11 +++++++++++
 lib/fwu_updates/fwu.c       | 18 ++++++++++++++++++
 3 files changed, 55 insertions(+)

-- 
2.25.1

