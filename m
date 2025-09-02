Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4253CA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 08:54:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 290BE83AA8;
	Tue,  2 Sep 2025 10:54:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5ErU1Vwq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5535683AA9; Tue,  2 Sep 2025 10:54:28 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 096B583AA0
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 10:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NoRu7pPIVk2nQKoH0YJ+V6FTHW6tq8N7ENlTh6aVoo/X2KJQYenVB3oNQESP8b+UEcGCjyndN9u7970q9jdYR8Xu8TVr99+ncOyXH6iG5Jg8QqFiry8XVECn/B5aRYXTs6/G6kyts9/BMH0YO2a/kno2SRW/2kj3T43jG1XL691qS/QvH22G9ffIg5d3buE6Aykh043sMHxfNhDvm80ozzaBiu0SCnb2lupIZPTOhfkAWCK1F1C4biB2UOaCoO+WrDYR1WpR/DUNGQ+5H2eyT77ZX7Y7WJhh3J/z3seyk7zaotpiAZnv9dBFj2wtkHNYLtN7WzlyN7QjU7Q55JmKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyqFYxqTDg//QEI5S3sntDQosvIIH6/xpXjUlYJ/tBc=;
 b=esCUzVYUj8kdap6bcB87Iq4d+pip6MjnBsdiW1cEoSdnGfe5x+MdtcsMFaACi0S8axaOj4f9SQHIA6O+MIDqiqboR7U0jFFuhmaPrsFKF1WBCZYZ8mpvjfTYk3YwxE/IAnrvWwBr4dm2xZRNguyypAMkO7VxcqXO/PtgeCkv3z4iD6lbymHsp2YnhdnfE93QI1RY2YL8M2fownV3p2V+8ySiuB3R7nvrsrvN6lr18ugk+yxvyjIT3SFRWbNCeLxL2/MjkcBVeiFXDCQpmaBHWorH16sG6tGWnzf+1IWTL5IMeoWw5mObyISWxod0LwFHbvLRBebMK3OVbxu2FS8gxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyqFYxqTDg//QEI5S3sntDQosvIIH6/xpXjUlYJ/tBc=;
 b=5ErU1VwqudUxoGpvSKf+aPmUXuIHxj7gbZQnktDQBzMOpQKoRnxMuInDdMBwBQ8QB9Wj1iGsah3mCrXcyDGq4UgdeRSH7hQ6/DFpr3q0rt8gy8tzw9gYqMBExuQitC44ehNDLDe8Ly0uUIhs06l0zUPiQsMEYV/VBdTw30EXAyE=
Received: from SJ0PR03CA0068.namprd03.prod.outlook.com (2603:10b6:a03:331::13)
 by MW4PR12MB7440.namprd12.prod.outlook.com (2603:10b6:303:223::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:54:22 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:331:cafe::2) by SJ0PR03CA0068.outlook.office365.com
 (2603:10b6:a03:331::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Tue,
 2 Sep 2025 08:54:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 08:54:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:54:19 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 03:54:19 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: kernel test robot <lkp@intel.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/12] arm64: zynqmp: Fix incomplete comment in
 zynqmp-sc-vn-p-b2197-00-revA.dtso
Date: Tue, 2 Sep 2025 10:53:29 +0200
Message-ID: <779be02a8f0cfa1deab86dbfe8e575ab152d43f3.1756803198.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756803198.git.michal.simek@amd.com>
References: <cover.1756803198.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=909; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=NyG+O+L8OckdBo82vUaECOGIkUaIggnQ4STXs+2JF5g=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRs29DtopMU73TRepu65sTkPbVP9vVtUko4s+yzyu++B
 sUuHtbOjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZjIjkeMDL9fP7NySJ1jICwb
 vXL1evuVUTNO8kSULfZ+tjF/HvNLs18Mf8X/1X3eZvzxut3yPy9Lim7KOvg+v9/hn7dx8qRFUdn
 HbzICAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|MW4PR12MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: f14ba4b4-8b74-418e-91e0-08dde9fe4f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?telGPMnm+dtlw1C81dHwzOhIihqRjkj03MbxXM5FOvknAHC+CGSdoZzxblHw?=
 =?us-ascii?Q?O556Ojg5nkS3AKOJDhfUVdWpBUaXXiQFVb2cE3+AU5c/jQZTR0teLd96dRmN?=
 =?us-ascii?Q?ZGvPhxIFPwjTemJrm/nscvUXT61Cz11pynR98QgGPF4WShDc0BNHZ5ERbHWn?=
 =?us-ascii?Q?H7XCzlTAg4FhnGFo+N8KgnlseECuUZtlH9ugO++TFpAVBA5rHI9TkNlYn60S?=
 =?us-ascii?Q?2CEN3Z03EIenibvLRQiNIFg37h0pI24xqLWOV0XviLDpB/TM3YBJFAw5oRwN?=
 =?us-ascii?Q?bnU4FZd9wRCtSoEa0Bt+iG8uzmq06+d8tRGOe9vSnF296SRMUalgvR/H7MDj?=
 =?us-ascii?Q?bKN25DK7QLdYQAIQJBLwT9OupR7F/eewc0R0saUv+iWcFoEeIZ44NaxBX4wH?=
 =?us-ascii?Q?aaZ985IdcM3JmDF9G36mIAQjsIjYTkycC6RovCdx4eoeDG559zyVwRzunXFI?=
 =?us-ascii?Q?7UcS6TZ2GSsu51FqkXqRSQovDEq9wOGlDZnNZBCFLG1edQ8YjZ4PbdIy/vtX?=
 =?us-ascii?Q?PkaeULtQDREsN7saks5oeGq034HU6kIZq2cVnB+FR3hRwKQAsO3jZ7LhHXvC?=
 =?us-ascii?Q?zxBrSg5Bs7S4f7zRNxSIrDwBaNNxuQjdBhlB5dfnzyWQZ2X+pluwCXyI8MG0?=
 =?us-ascii?Q?kKNbIU12GL0ji/NCsAhIQr6JyDhDdxmCDF6vWD0ovaqbzdgB9nLLvm7PurhN?=
 =?us-ascii?Q?V2jXvGyzDWNX5pcerlHRHpaAiDUabwkuZOVD6oOPF9I6WctxooUSSZANH0Nf?=
 =?us-ascii?Q?Tr9oeTLcmG1NwXCZDD0LvzjQVCBLD7ZBDzCY6dRz/YqFCoKgVHnS6FMjnfXf?=
 =?us-ascii?Q?Myu1yTU1+XMuzEjBBw/LDxDA9i0ITF4AKFlOT+9C+Q3YhAZh1X91PyTOrwkA?=
 =?us-ascii?Q?laIEg8uCwhERZbEJ7rrkN1+1mJY4guMais8+VGdWaXhr43+6JvphGIGfN2cn?=
 =?us-ascii?Q?lh75LyAa+nvbRqyLC3TzUVc4LrDvZbFVO5pyiR5INPv/ertzA5jhwkK0dWVP?=
 =?us-ascii?Q?LxceJZjbZm3mSDYge4XM2cszo8fFQt/3adWCOR1nOaFBabWxE8GZ6+neIPk7?=
 =?us-ascii?Q?wO8vFQpEsTxY6bKoXd9Rfr16W8GPpbxq+8EUdmZXb2pamlMBXoDkT5oXaDH0?=
 =?us-ascii?Q?Z6DksEHb9cN3edY6qSz2H3u3+5I9B7zLIH2/71Z/oHjU1Hx3AAzbVmFipuzF?=
 =?us-ascii?Q?LV0asSOiO4by+Nifm5UjTFM8ecuUv+5Q6B/xtyO2ismTiBpFN3HPQY3KPe8q?=
 =?us-ascii?Q?ZEtt0By+kgy9VG7DWOi1bTixpK+4yp6utNCT2J036KN1+z5tYfZ5TiJA0MAn?=
 =?us-ascii?Q?WaA75yqB5rDi8bP8cBpmZhhZ+4Br5Cfpv0UnMY34fhEobirsk31upirYFU/B?=
 =?us-ascii?Q?r8GGzV+YdL2bqIBrxp4o9jq1K8T2AudeyIrXXQ5tAk8tiURgrGK7MmT80aC6?=
 =?us-ascii?Q?P4Yu6pLv42NSzM/tZO/Ag07toqHmbH6PQiiWtl3nOMDBXU8qvX0K1E3V17KA?=
 =?us-ascii?Q?gMGyUB43x4Y1+YYWfV3ako597ezMOFLcs3Fcy59Hso9sweMw+fdqZMblSQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:54:21.9210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f14ba4b4-8b74-418e-91e0-08dde9fe4f75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7440
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

Fix comment inside comment by closing the first one properly.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501111756.IcKlG6rs-lkp@intel.com/
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso b/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
index 40436e5f47c2..ce1832127156 100644
--- a/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
+++ b/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
@@ -142,7 +142,7 @@
 	};
 
 	/* FMC eeproms at 0x50/0x51 */
-	/* via j3/j5 to 0x68 to u32/9FGV1006C
+	/* via j3/j5 to 0x68 to u32/9FGV1006C */
 
 	/* i2c_main_1 - u147 - j157 - disable translation, add 8 */
 	/* J1 - OE for u43@55 + 8 - 161,132813MHz - QSFP56G_0 */
-- 
2.43.0

