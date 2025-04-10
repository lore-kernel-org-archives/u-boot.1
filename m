Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0418AC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8358583A2D;
	Thu, 10 Apr 2025 10:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U3BjjfBq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2771883A32; Thu, 10 Apr 2025 10:14:25 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B369D83A2A
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QP5mY8NHld7Q58m5/NnayjbEkmoI0cdOEvizWCRq7eumtFetj+MHhzz68nhKzD8g1jGKXkvfGIvS2FrWXYW9sz+d63tfiDIXxXxbxEoOf1F1RAPHu7GokiKDeFdQgNi6+YUqbo2Jrt+nl43GfJQXCM7Udl2l66UfnNb0dmLxliEhwFJQKfvMdJvkGEEsHGaDM9vBR27O34Jxmea9BXt2+mqsT0mrzv9NHD0OnuH6XpST1DQo7NZ0fupRmq6kPtm7iafeGsliccA3z3CzR9eZHa+mf0skKZjXdCXmOGkxwVkFGXJcj29/owGti94vQk1C3ctCsSCsNUsF6g/zzCYLvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RS7/DKcBQsmR3KBDRpYr7mZLLdfchOPh/V9xw2MheM=;
 b=EPkTPDF3v8FZHx5u0PIEZX2EheUyRjW6NAgoXjQxnP8AFJnDwORBfHjfMpLrEph1A3Ipu5XRh/LaqXLihQDQKWJnxQHoaMyApeS7aAYXi5pdC4dfsppnk+LLsM8J1XKa6HsIWr7/7CJoWje/c2RSuFNYW9HYxCvfdoeznYQ4lBxMDK+cWVkTKV9o3mawsniT44twwkfb2aX2TqMDcBnnvE/bsDvumAY9UxhEhkK9reDhmZqJxekOnQ5RlFuoZxBVYnJ8ijaeE+yY4oWxwohSK9Tf8NB/CxUT9FLdZxYayaXNWMK+z8R4gpR6ExtNgi9Dm1bYLW4GAjb4fBOs/g15Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RS7/DKcBQsmR3KBDRpYr7mZLLdfchOPh/V9xw2MheM=;
 b=U3BjjfBqljxeVZ6tvjxEsLUzPbC3K3wRTmE5ffotxL1B6VZKje/fe5bUqP7xl3ASrd9pvZHvQCGEQgR+X/lmb7X3un9rnckrxfZloTppbIeCSCP3i3Wo+D2ev5GGpYvJnqhre9LqHnSx64a/YjsosGNR6Bj0+kvUwaMuYisu6A8=
Received: from PH7PR03CA0006.namprd03.prod.outlook.com (2603:10b6:510:339::25)
 by CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.24; Thu, 10 Apr
 2025 08:14:17 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::49) by PH7PR03CA0006.outlook.office365.com
 (2603:10b6:510:339::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Thu,
 10 Apr 2025 08:14:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 08:14:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 03:14:09 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Apr 2025 03:14:08 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, John Vicky Vykuntapu
 <johnvicky.vykuntapu@amd.com>, Prasad Kummari <prasad.kummari@amd.com>, "Tom
 Rini" <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: Start usb automatically via preboot on Kria
Date: Thu, 10 Apr 2025 10:14:04 +0200
Message-ID: <180c9776b03d57d8218d161924363906ef354394.1744272843.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|CY8PR12MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 79936834-1d32-4b8b-86a4-08dd7807afd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mkpk+ee6k693j7bK8omWh7stVD3Lnft6D+0EOgKqMM9mBzCmJqhrEJ+SL+Tm?=
 =?us-ascii?Q?s8+r2faHB9ysHzgf2hh3o9f5kwNYhcr8V4tJF+uDP9iEnoVVCnsPdOVp1YvC?=
 =?us-ascii?Q?l88CY+G6SOv3fX1E6aO91uZFw4E2uoQJ04WBIFOQTtFBkNNkZ1GtgnS9UPUT?=
 =?us-ascii?Q?nsG5EF/9CykFJraS8nO6oOBrLYwc5IrVZrFMmb2Up+kZ5vbi86MJsKI4bBTX?=
 =?us-ascii?Q?JyayEBsRQ6tu2nEjpFDfGPj4yrDVOHft8f/56+oS5EAasoeIWLhRN6vajD4J?=
 =?us-ascii?Q?W7BFCtX5CZF+CDj9KUNe1NKbIVNOKpfBA1g61N1dIUq+OxSiiwGNZlIG7ImQ?=
 =?us-ascii?Q?SBB7+/2+0ovKnrJudqQv9P8wA0aFCuElIEZcwlQh1GJLQKfaF3/BLS4iVKsO?=
 =?us-ascii?Q?qXuqt4bA3kvqnTeE00Z+mQhCYBe6W1mGiOuSCIJ2VNIGGi9cey0B7FCx19bS?=
 =?us-ascii?Q?d8TXdEqaW6m/7YsTL51u6DocF32Omxf9Oo3Tri/rz+5c2PdmB1aEArI/IRLL?=
 =?us-ascii?Q?wGbXBiY4Pt/mVHlJ85vI7F/m69wEiDSYy/xPosHB0wQeM/mT0FgSiZpibHNq?=
 =?us-ascii?Q?0Xq2DyepmGArJRHmuEMaPL17sB9b4UolvBfRFUGjwpj1poPPBjYHm4C/6o8h?=
 =?us-ascii?Q?MMijtLGKSXauYZxTj+6WnOVICC4pIasZrpARVSRd2qeRkEWXvxj91CW2DcWj?=
 =?us-ascii?Q?ItQ3IQ3aI7eX2nWlVgJHT5zh0G0GdkYe4780N978XtcHWZTz1kYQcQouT3GQ?=
 =?us-ascii?Q?KvWBh1Qq5WQL0YuH32g8LRSd/wcx+3jdU3Na7Ic0tOGajEYf7Luv4km39UWc?=
 =?us-ascii?Q?rN7aScLE3wTah/5JELg3DyTzlKB2DS/+Q6S0iKYxNPx59vn/Ek3/9x4z2CDT?=
 =?us-ascii?Q?5CVSqnsBQMNS1gahsDSK2Zdi9DkYwNqdPkuI3//GQQoiOMLETmh/hyDT+MSW?=
 =?us-ascii?Q?2yNPjy6qI80whx8TdhXhLiR3OC/GXhWYSjuI9vLxuB7gy6N3KCzDvXAzW3V2?=
 =?us-ascii?Q?rerMYp1SQ7lLMSMgaNfEPbWgGS25eL7zhzoLs3J2wXTT6fjMJVMNMzBxsciz?=
 =?us-ascii?Q?iShM4OINedKs1fgQCbXAmCA22qrdEWwdlRiWNzRXPwqY57k3fihHahgJFuW8?=
 =?us-ascii?Q?gFDItzlVYND+ipY4Ot6+W1g5/h0Gph8wTvQsErd9NcPEe0oUo5NrEO7TJ1BP?=
 =?us-ascii?Q?/AaDIXUDWgl+JpF70T+JVkFnPSLnN7eL5AdZBr1600Sb9BuKOL0NWwsylpBQ?=
 =?us-ascii?Q?eaUSqw2odT+5GGJ8yh7SXucHZUF1CrBLI3cRd3rJGwVdNyrBdBfF1jrljglj?=
 =?us-ascii?Q?YwV4YdL9ok5qC9gv1k9ynpsyYSf0/nZEe1hcIg6OMgf0CYpguxL7CglsZRS4?=
 =?us-ascii?Q?R0UrWKcRkYcM/Dtk3E8S+jhnsXCGDQCONYeVNNghul6lbqv1ucoCdenBy25k?=
 =?us-ascii?Q?sZ+tGiukKdObtvPari7Dr8vNV2AkfqnCbawq27Aze8WsbhHtalr/gTFdLhaz?=
 =?us-ascii?Q?ub13nGAw+lPYs1LFB1Tp4fY0qkZFE6hLtTZm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 08:14:16.5288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79936834-1d32-4b8b-86a4-08dd7807afd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067
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

From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>

U-Boot configures the USB config object which enables power for
the IP, without this the linux usb driver won't work.
So add "usb start" as part of preboot command.

Fixes: dd4a82201694 ("arm64: zynqmp: Introduce kria SOM defconfig")
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/zynqmp/zynqmp_kria.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
index 75b604a1f767..89f48c035863 100644
--- a/board/xilinx/zynqmp/zynqmp_kria.env
+++ b/board/xilinx/zynqmp/zynqmp_kria.env
@@ -42,7 +42,7 @@ script_offset_f=0x3e80000
 script_size_f=0x80000
 scriptaddr=0x20000000
 usb_boot=usb start; if usb dev ${devnum}; then devtype=usb; run scan_dev_for_boot_part; fi
-preboot=setenv boot_targets; setenv modeboot; run board_setup
+preboot=setenv boot_targets; setenv modeboot; run board_setup; usb start
 usb_pgood_delay=1000
 
 # SOM specific boot methods
-- 
2.43.0

