Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B59C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 08:15:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86204832BF;
	Tue, 22 Jul 2025 10:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JoUwayY8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C05B4832BC; Tue, 22 Jul 2025 10:15:28 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D506832BC
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 10:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mo7Vdi7fS3A7+2yOUXOgcjUxnoFulpf/Rs6F0buf37fdzExDsjtxA8NlocVzDnnp04JZeWco4unlVTyI+ZA45dLsW+5OcwLFpmB92nf3FESuUC2zJo261o1fY+762FjZu6XgkmzclM4+BAF2DfRx3neqhgfzk9ySRABihNrO1f/rk+nBvtgFsZBwcUo9DirkEE2KfIPVajxmRTLrr2ejGsSj7ECasyiZ3t8yaQ+EyZ9S8dwOnCvb+WPBB8lJkBLzq6A3SX0OgMKFRLXgc541wpoucWnR+AMhd7n2df1/ZDL+FwnYYHMG4Z44dMO0tM+M5BiGrUHhWJHoKrF8hns/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qt5U0P7Yspb/mxTVlIPiwPxsw5I79QkOCBcxkmruwTw=;
 b=w5atP0LzISKhh1X3Nkc1wJc81y21HontjXWpyJDXG64qg0FIAsspmS87GYaFqc32su2pihLOLTI16cIS4k/RMZCkpEjra7/NIKh5xyP7cSZXeysfes6FJbTLwoP6l+Ifeg8/kdrS0wdPdFnMtIEDj91wdMIU0im7agTBTQOJHYzA5OI1Ijo5V/H76YOpqc16vhqBJNxBB2ui7iMOaYW36YymS7P0+Es3U9qj+T/ROJXl9J/Ukh7kHD+7p4MdZkmsCre8D5CBBTGOOjCWgZ/N4GoVcT9JWiMwAjFvrQ0f4thRxvhErYPjICVkIgnyLZhcov+53xUfqoXzD/6gtIXE5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qt5U0P7Yspb/mxTVlIPiwPxsw5I79QkOCBcxkmruwTw=;
 b=JoUwayY88fRsqnkUmiKuHyXq+bVJ4BuKyzuu54cS6rFIEhNW394d3EM6nO/GV21vgPTf7p9dF/aprKijcLa9pOfteYxXYqxc1704cT1BmAiiLd9G784rmt3eXRFsdeetljVbFxggp5v0SSUiIYOKBrPLgxe7F0SARBNqirX6f6A=
Received: from BN1PR12CA0018.namprd12.prod.outlook.com (2603:10b6:408:e1::23)
 by SA5PPF9D25F0C6D.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Tue, 22 Jul
 2025 08:15:20 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:e1:cafe::61) by BN1PR12CA0018.outlook.office365.com
 (2603:10b6:408:e1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 08:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 08:15:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 03:15:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 03:15:09 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 03:15:08 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] xilinx: Make XILINX_OF_BOARD_DTB_ADDR depending on OF_BOARD
 only
Date: Tue, 22 Jul 2025 10:15:05 +0200
Message-ID: <063b2e618afb05a32d66218f3631a5f23b30ea3e.1753172103.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=817; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=dNvk4l533NrBNi6UNQVjtz3cV7PRBhE1/CzfnfXW4xE=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTUe3SxLd1/bLOqZIyFsdOMp95X4or0Xrp7vKp4fGGj+
 fPgjQ2bOkpZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAip88z/E/vbmYT5WeZEb1x
 R9YkBoNb35nOW7R4vTqSL7utW9czJZyRYX2O+fG7V6petMx5z9Nx2H3OjckF0lw/EwoSJv9iaC7
 p4wYA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|SA5PPF9D25F0C6D:EE_
X-MS-Office365-Filtering-Correlation-Id: b8e4ea9a-b659-4daa-e85b-08ddc8f7e60d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zez5X+Ac7fFBFjqVXhdLoXNqpWc6Q7BxKz9AJOpDg3A+8BUJMsWwjIL/Tav4?=
 =?us-ascii?Q?4s2SywPYuUdvDFwG0xHyqCwmQlCKYJInG3nOC04UOnfYCQ9yy1plzcsjoCgb?=
 =?us-ascii?Q?waVcA0uOQOFDwJ0UUBR0VqghCVfPnwA4quiNvIZ4FwM90eExrZ7vftEfHGfd?=
 =?us-ascii?Q?Wndpbg3RAi07NradTTkghXhFyuseLjoQjqRrSZmwJedkb/rOg3y/AGJinkOv?=
 =?us-ascii?Q?CqFEF0MyG4sDKoz7dbrzNnw4S8JHYQqAqkHmVF0SI9oLaC5kQo+o2siYHxk7?=
 =?us-ascii?Q?M5XxfBmoX6IAQjn84vvAknoznLDAGHzz65E9W2OwGBVIP16x2M44DWfvPsiy?=
 =?us-ascii?Q?pzVQdtK6cq6m/8JtoC1CjbtDnSfeLzbIHuWvi2S0nwZxmUsA3JD/TIjAvAxH?=
 =?us-ascii?Q?L8YDutGWh2IRSlwPiWkBqC27nE2y2C2X+L9WUxRFJE06k/AfT8vKUpHvYdQ1?=
 =?us-ascii?Q?ns0TIPvEOeAu9dmyVXPtpanbZ7an5XaR3f4LspBadSkXbbEjNI65QLt8hiqN?=
 =?us-ascii?Q?o3oNBRJfen6g8XCyGOxMb8wvAVimwza1d33hDiwFxM6ZIKgQnNWLdIIJQZDQ?=
 =?us-ascii?Q?2Yd3TRiRtz8/31LITooytN8fgqrzADVGVkJK1/iEb2VsFHCAOZGSCiiX0GrL?=
 =?us-ascii?Q?8/wqbbehddZog0Uq2jKslxW+1YuV0VU13OJQIXQ6dovEe2Hkt95DLHYh8+wW?=
 =?us-ascii?Q?9RtogjdVowAhjUlY4rMqOxl9mxOg8NYYrnavYo5/DO8vSAlq7AC621A/IRvB?=
 =?us-ascii?Q?dq66rafDTVhJyjYDKXlDttzkTqaleyp8XSZ634ePOtOriq/bTdHxOEWInJjA?=
 =?us-ascii?Q?Y+/Q9F2rWj9uj76ynOpsZsfuZm7kqag0nUtY8gbmCdtQnn7cD2aK6LaSfe+m?=
 =?us-ascii?Q?N+BANM7j8uxwq0moVErr6S0k73pnyleIktoV1MQKmMetRyTwoGf7vVrz0TDf?=
 =?us-ascii?Q?kYYqjw7MyyBHVca32i6qg1hu32kKVJeQTi9FNWpjXh2GsE4aigIYfNc32wRF?=
 =?us-ascii?Q?uHD4pyNzlsbNaszqvy4w7nEtcfw1Qu3pe+t84qDhnRm6cPz3HM6lf8uUU/xB?=
 =?us-ascii?Q?MS5Lkj6bQb7rVXO3z5xR+v+8MwNYWDE6m3ytt00lS7sEejFFnCBVM4ihkaMN?=
 =?us-ascii?Q?9srcagKq0lEkQqUrKSCuKuAAzan0OzbP64+s8PDMshJsvCPwctkjyfiLE0Zp?=
 =?us-ascii?Q?VjjAS/DITFwBthHtz276MU7iWen7Ln45x4QcdrO2O++k+LS/OqTBnw3FcdLM?=
 =?us-ascii?Q?tD4ti3n+156+GB0HousZEqWs3WPXfrSS6i6qg9V1g9kox7p9jFaJ5r9RGn53?=
 =?us-ascii?Q?s/PM8mi606O3MXHdWJNWRH7ZWil+HkwwvApIpuaj5NcEQ4r2NkYpcAvx+OF7?=
 =?us-ascii?Q?tivZ//7cKN1Jej4iHLR8+Hm5mpjfbqxi9Bkg9a43OW/xakf3g9EZ8AQUZihB?=
 =?us-ascii?Q?pXn40xA2NK6gKasEEPK3q4sWNqrtO0lW5CoJas3qa3t1/kHc+1KS7vtIbjbO?=
 =?us-ascii?Q?1RcThJ29ZPQnU97TrJK2aD7F2geOOXurLuin?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 08:15:19.8205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e4ea9a-b659-4daa-e85b-08ddc8f7e60d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9D25F0C6D
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

board_fdt_blob_setup() is guarded by OF_BOARD already that's why make no
sense to depend also on OF_SEPARATE.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/xilinx/Kconfig b/board/xilinx/Kconfig
index f7152d6ee6d5..5c3240da0733 100644
--- a/board/xilinx/Kconfig
+++ b/board/xilinx/Kconfig
@@ -55,7 +55,7 @@ config XILINX_OF_BOARD_DTB_ADDR
 	default 0x8000 if MICROBLAZE
 	default 0x100000 if ARCH_ZYNQ || ARCH_ZYNQMP
 	default 0x83000000 if TARGET_XILINX_MBV
-	depends on OF_BOARD || OF_SEPARATE
+	depends on OF_BOARD
 	help
 	  Offset in the memory where the board configuration DTB is placed.
 
-- 
2.43.0

base-commit: aeee1434e00edddda97a66cccb61d380b798db89
branch: debian-sent3
