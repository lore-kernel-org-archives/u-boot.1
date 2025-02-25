Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3CDC021B8
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 03:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BF9880805;
	Tue, 25 Feb 2025 04:28:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pW4o4f2D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B408980977; Tue, 25 Feb 2025 04:28:29 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11D7E807B1
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 04:28:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1H9ns/xcDHLyMommo6hC3tdZIpfgcapWWYXc8Wni8w7FBUdmtj3vjoMKYR7WweA3CkkLEpOhd1goFfIaRnikvQ5knYgoCUIAXfRSHo6TtnpzAtvHnuIr2Y3LilU35U5fWJE/JeRwSLltlXq4/cCmeOEB5NsK/U9+gH1Q2wBf6uj15b3N8z7apzWRQ5qgEoIz2xGGMofFKM8hyKdWOnXkrj+OU0BOrwNS+9gNVCgWsO+0nq/neZ0dxBYfjNScZTRgcDdunFzONT+4YJHD/f/u7GeiquGNigR9MZt1YRwnAD3zJyOM5UvNR1jtzz40IXRlhWxaQGpmpegNxI9Q+yh3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rjaEUdygX/FpFPBByrA8MAzi9mbZ7Gaii7vyRT9c+M=;
 b=SzhufwBqq4fX/rohSgFbkDbE2FB0ILDVF3Uc/v2GkYofg8RTb4z7Gm0A96FKSJpolSSpT96UcLBAlpUM4WTfTDinquAm9b0Ln5Ho0+o2YuBP/zrnFCqGpvWWoZ6TDKwSMHXYyluqI3CKjM54cqPViyK3KQ2LUd6+Hl8GZaS8Vjwa8D5NbSqYzNkAHLIHvE57VHRLQhr+QAvWasugLpUDfIZMrD1UeQTOFsN9evINWuTHHON0VYOUknCfb8pJPVrMq6i2Evm0A123pGN9IEXLUiEQze5lkgOfwQ1E3kanitvn4+pyUZ9ifpb0Vr5Wo3l+RTZBA6W/ZaLO/DJC15WbZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rjaEUdygX/FpFPBByrA8MAzi9mbZ7Gaii7vyRT9c+M=;
 b=pW4o4f2DuTUm0TSlQC63cZSBHXMIjUPV+3HrMtKisEmfAvX05O0F5mqSGJPe1izBTJQk+Z64F8FLz/H50P67YzB7BuZALnmaMwQ7UBy6Uxzj7ETdtl27wbHR3HDwNmuTP58jw/l1T3VJZEXFqJS1d6D2zR3VhRJXX02BhlAYqwg=
Received: from MN2PR12CA0003.namprd12.prod.outlook.com (2603:10b6:208:a8::16)
 by DS0PR12MB7851.namprd12.prod.outlook.com (2603:10b6:8:14a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 03:28:17 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:a8:cafe::2e) by MN2PR12CA0003.outlook.office365.com
 (2603:10b6:208:a8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 03:28:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 03:28:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 21:28:15 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Feb 2025 21:28:13 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <neil.armstrong@linaro.org>,
 <bhupesh.linux@gmail.com>, <n-francis@ti.com>, <git@amd.com>
Subject: [PATCH v2] amd: versal2: Add the UFS boot mode support
Date: Tue, 25 Feb 2025 08:58:06 +0530
Message-ID: <20250225032806.1842581-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|DS0PR12MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2dbdc5-19b9-44eb-d713-08dd554c71a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8oauceTm4CsLG2dpdft1n/C03ulzAlXCK9B34jMLIhy+5Ny7ghB1Xo//JOAX?=
 =?us-ascii?Q?fhbygFUe1Zz2VF+VMtnrTuk3g9HOzvgim2ypr4YXaYXTV7mxpWTYwBe4WFwC?=
 =?us-ascii?Q?WrAvBKuLapaN2/3GQYHFm0XTRyE5K/L9AOtho1sac3eifwmjBZ5Nt9WvcO2n?=
 =?us-ascii?Q?jOmir1bZEBT++HA0vBUIQnQYKEgY8x9rcqF5jM2IWg5cnrcNQURSJHJwXBIh?=
 =?us-ascii?Q?WGLGZTpl/VGL4e66IdekQM3M2s05Sa482j9vzwzQUTqtpCZR2hII3G++gjBr?=
 =?us-ascii?Q?2qocktNL5Jg4f8CWYjBL3roiQW4MyU5IiAOCZM4GdGzkQzlLG576LaqrDlo7?=
 =?us-ascii?Q?G86PjYoryHh+WnJwIWQqDdD+nAZ7U6zVNHu2Vi+aAcQ4CDnx5N9G3hZAEA/D?=
 =?us-ascii?Q?kDZZWeSpdmT8O/VAh4Uuc4TDrCW7zQB141RHvHZxKR92C7ph+X11LKR0IvH7?=
 =?us-ascii?Q?QVFH0ZtyUg0aBEFmyhjKKvYzv7xauaiQ1pR1VT4Ad0ghiaS4GjF8qBpE5KJ4?=
 =?us-ascii?Q?t0i3uhnsYbsXzlL+WHl+qiKHDIChn91IpLhKo+Z99hZeKABPcnUaxEK+LHrd?=
 =?us-ascii?Q?XteUPF/atyn/h0stjOXZ+JAZqxiItnAzzZ+rHcSatpn2T28yvjBHxBKMR0ms?=
 =?us-ascii?Q?9+VAz198Dwz0lIjqYLIy9Jos7s65rt7bLeIED4uHY8oq54MRTjTwdDQ14kZM?=
 =?us-ascii?Q?jkjEbJjmtCTGbN7ghCseKRfezGYX1kScsA4IyVRQAm8I+5r1npmJ51mz4uZC?=
 =?us-ascii?Q?2l56NYgPF7Qs5Tij8W53vt63EwW7tJLe5l13MjACIdIvzpDIzncpE/gjCrJ6?=
 =?us-ascii?Q?vyQ3Au+y2KQ6OJG47JukauLnXVTKPVafbtuo2u6gRrrkKfKFQeuCGKy4KFY2?=
 =?us-ascii?Q?txyWcYlhDrYmxCUuU8NnpW+1KYKc2ounUPI4kL8ARQDdDpTQlOdNWqYYHBDH?=
 =?us-ascii?Q?ZAw9HrixjCnR1I++A+n58gKxK3Xcfke0KyszqkA5XwVyZZULYe6SpezoV699?=
 =?us-ascii?Q?bWpmg43HfUlNaPazQlWrr1cdhiAaY9CiWKlF9BnZVgpo6R7tARvD4zjYJqfe?=
 =?us-ascii?Q?XiqPglLjglkKaH+61NuqkzIFheb0xbB26gWasEl+ZVHPIbrGORQgoHfh5G9w?=
 =?us-ascii?Q?eH05RWWTj4EC9A7slC6Mw2y3cANUyQMPts4RbDqdjApe4cDLZ9FpOIVuKH82?=
 =?us-ascii?Q?px8Ys7NdigA3NQytyP3AbPOtzojyzxKMPQ5I2lgij5UVhvqA3Mn4OozXLutO?=
 =?us-ascii?Q?Fi4YadzMnuYDqUj8chibVL0jQbG2YDOzzxv+EYKmQFZ3IiLCpi68ox0/zZtl?=
 =?us-ascii?Q?rI2FXLeDZP3amD4LpUs/SQSPZPsaWN4ROpmFdz644WYayIYIPkeo+PaDb8mj?=
 =?us-ascii?Q?27rGo1/Xnno/VGTqgn8I8Tflw6VX0LFg2A0jD9wHDcJsdBT7wt8rZDCd1KYa?=
 =?us-ascii?Q?q4mxSos/366iiwmQ9VizdTMNUEU/PEVodUUdML5h9F0Wa6u5NqwpYrMa7xeA?=
 =?us-ascii?Q?ggzvCwMqfaP9VpQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 03:28:16.8382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2dbdc5-19b9-44eb-d713-08dd554c71a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7851
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

Add the UFS boot mode support and update the boot_targets with
ufs mode. If the UFS device is not accessible from APU and
running this is detected as a warning, as the device is not
accessible.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
- Use uclass_get_device() with index 0, as we have single
UFS controller.
---
 arch/arm/mach-versal2/include/mach/hardware.h |  1 +
 board/amd/versal2/board.c                     | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/mach-versal2/include/mach/hardware.h b/arch/arm/mach-versal2/include/mach/hardware.h
index 42e3061a0ae..022c8b3c832 100644
--- a/arch/arm/mach-versal2/include/mach/hardware.h
+++ b/arch/arm/mach-versal2/include/mach/hardware.h
@@ -67,6 +67,7 @@ struct crp_regs {
 #define USB_MODE	0x00000007
 #define OSPI_MODE	0x00000008
 #define SELECTMAP_MODE	0x0000000A
+#define UFS_MODE	0x0000000B
 #define SD1_LSHFT_MODE	0x0000000E /* SD1 Level shifter */
 #define JTAG_MODE	0x00000000
 #define BOOT_MODE_USE_ALT	0x100
diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
index 5651d516a9e..220ab63c994 100644
--- a/board/amd/versal2/board.c
+++ b/board/amd/versal2/board.c
@@ -252,6 +252,16 @@ static int boot_targets_setup(void)
 		mode = "mmc";
 		bootseq = dev_seq(dev);
 		break;
+	case UFS_MODE:
+		puts("UFS_MODE\n");
+		if (uclass_get_device(UCLASS_UFS, 0, &dev)) {
+			debug("UFS driver for UFS device is not present\n");
+			break;
+		}
+		debug("ufs device found at %p\n", dev);
+
+		mode = "ufs";
+		break;
 	default:
 		printf("Invalid Boot Mode:0x%x\n", bootmode);
 		break;
-- 
2.34.1

