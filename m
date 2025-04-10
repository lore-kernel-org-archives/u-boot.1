Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0444C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:31:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E97ED83A47;
	Thu, 10 Apr 2025 10:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bkvPWPpq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFDEA83A4F; Thu, 10 Apr 2025 10:31:10 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBA5883A3D
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:31:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEQCmo8AHsnGdfY5JD9+JJ2lFnGDVMKb2MdJGIjbDXRfwYXGQhykKa92lIYC0bzk5hCkhN+P1xYAk89df1yN6S4n3lwYvHnqWzVkcc0+2S5Hh54omwdOLHvYYtIMMXC6dU5cxABgf1EbzFmXgrBXBDcS6Jw+L5wig5F4grV4Jb8Io7F5P2f4S9VMVwmfJynCo6KfxGJ2izrc2px+IzreoF54YMvrJuaJAkyh1EPA9w8ClxJpnv0SanlJspZpfa5hR9yxmRu6W+1ltdzuvYLDpMSNi5leuUBau2Cmk+nc0VqPDTlzSqKTl43oJXUDYYH8UcM00nrSSTxt6UScnpSwog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfEvSY5/lreTrVpt4Azp0Cd3pmxIc8BJ1Z1fsnmqIjk=;
 b=G/nxAc3rN/0UdMxgP2Hz0WDGGUYRhIJLuYri7UM1fjfRjiTBEceEwULBkIHvg1t9F+mG6t4M2ESsiYbKbmZtQaYB/ntryYHH3gkI6KXFl3fg8U8VPNgIf1Ifg/HUVe0sWGpdhC09ITiI2rnwrkCJxFY2jcKlmo9vxAufQbl7omN7Tru8NKcjyaIi8Je4VouYQhFYo7XSFptkTg/mnkn8yRTdLD99d6gghgGM1wMPKi0krLCHavLOfDD8yGDxHdTyCllm6c3e0O88B1AplII9DY9ctx+8aHrX5lOaMrhHs2k8a9/Nz9gkLokvOXblDzyBhE5NMpq4ZhTAtCoRrflYWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfEvSY5/lreTrVpt4Azp0Cd3pmxIc8BJ1Z1fsnmqIjk=;
 b=bkvPWPpqY1hw7yeztZEweOKRLZlnbbcI++DYfUE1JJseA7FBEfC2Pzq05w144fi5AC6W8lZBDehLd7p/vixTGQeEdF2yp7XfL3BIMAO/nWUtThqAWBOOxozFJp1Szhmii5g995oSnM8mAGaHJKRNDv7oijjx8HzHGkzGXmdAF7g=
Received: from BL6PEPF0001640F.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:16) by PH0PR12MB5680.namprd12.prod.outlook.com
 (2603:10b6:510:146::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Thu, 10 Apr
 2025 08:31:05 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2a01:111:f403:f901::7) by BL6PEPF0001640F.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.22 via Frontend Transport; Thu,
 10 Apr 2025 08:31:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 08:31:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 03:31:03 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Apr 2025 03:31:03 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] arm64: versal2: Add ufs distro boot command
Date: Thu, 10 Apr 2025 10:30:54 +0200
Message-ID: <c0e6737ae4119963afc8ea19b49b998a013d06c4.1744273853.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744273853.git.michal.simek@amd.com>
References: <cover.1744273853.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|PH0PR12MB5680:EE_
X-MS-Office365-Filtering-Correlation-Id: 6669b1f8-864b-409d-276d-08dd780a090d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aFmWp9nEdTijl+bTaJvUebdPBTuIAYNH+hZCY46NatKwJ1EUpFHFjUj5PxCB?=
 =?us-ascii?Q?yP+RguadjVmWc+VMGkHfmA3dTkB8sraFb8BI3GEBw8c3pXSKn+Yqs777Es+P?=
 =?us-ascii?Q?CkMakjuCdZR49Xp5gd4GOIZMsWlctzEYF1oNU1HV7UD6Xrn07Y5SudU82Rc5?=
 =?us-ascii?Q?X6N3BOeVzLhybwvqlt87z98Gs2EbA3HMwRxGg02T0mILbt0yyiehREiXhyqq?=
 =?us-ascii?Q?LU+x48YM/3U3SFUTFdODC6nvrV1KmjDAWmY45TcWZhYJqnyeJKERbCY2Mzdr?=
 =?us-ascii?Q?OasOxNMliiYOTw4ueBuL5Fe4xhLHd3Fqm0ynA+GRiwuR8CblmcDD+wEWpMfc?=
 =?us-ascii?Q?B8rKZbev0C3ofh3a+k8qXC6bCGm7bMg77+S+96XvZu3MXNtVkF+rAThBnffM?=
 =?us-ascii?Q?MRXV0++c94tOfFNVrl+Hp8/8SwuHhjHCLMj2/62m2k54GZgt6//WJTw4/obd?=
 =?us-ascii?Q?GliueGJVdl5sv0IIIe0aNtWsThoKxCuRMQEm29rb/4tdBwFhNYeda8tfL+cx?=
 =?us-ascii?Q?9NQc4FFUmVYa04ZiZhSWAyhm6d5qMIq7dmwNyn6WyeGolZJgJeu06OAGNCbr?=
 =?us-ascii?Q?p2+Vy3o+WWiu4beQBFzYYbQKdv+c9Mo7Dbe3TEZTHL8MF/s9FrWCn1TpzbPd?=
 =?us-ascii?Q?fYkP6cSiAWFWC9WRiTXi/UPXg00UAZDDa2x4BNXq6ithYWoTfkOO9m/Gj6/v?=
 =?us-ascii?Q?7Jc3KPjQ37IT02klZtbYUfnPBvHaJZiAGgqDddHlpGIkUQatvmlrjWRhvEjt?=
 =?us-ascii?Q?En4Iqu1u0MTDgBuYsh3BarQ5LY1tE3DQ84d8+bDz4rGXs/qPM8MpbB5bfRoC?=
 =?us-ascii?Q?+rxKs+ETQILBz9ex5ggROoBPZqB8vftS6Z2sRGo6TriF6/3nmMF499Z0w0c2?=
 =?us-ascii?Q?d2+wduVoK9FJXBMzaPNxVw/rnHHFErKA6npiYW22WSFw2lsW/YRGv2LS7/Du?=
 =?us-ascii?Q?oDYck4yPtngrSRHDRoC+ah5Q2BRR6+NdCBXulf15n3dGeNesdg5KUyYi4GcI?=
 =?us-ascii?Q?8VyuOasLEW/EY+I9U22I3pcLDIDkgxYRoe83gZc5F0DSV7WxZ+b3OJSY3Nh2?=
 =?us-ascii?Q?VeKc/Pc5IEb2PW0nBQL2gfwjwAZ+Ijhlxe8b+zZa1kZI8ElKxt5J6vLU5QMQ?=
 =?us-ascii?Q?xu1BsRiJLHzVdUMYgOVi+oykG+MnQUqsKVFCM9MkNKLRhNDxJF5crKnl50wL?=
 =?us-ascii?Q?hRQV2OmnoSqeh6zdrNZykWdKth1c6CvPfUIQ/6aTDt5poc3Yi7nONcF9loDk?=
 =?us-ascii?Q?Urz/rDhAPje0WnzMXqGpMh1/vVrEr5PfuAn3GAqzt//0VS+UqOMxs4eeBlxH?=
 =?us-ascii?Q?os2FUioa3khO1xE6jpXFiljEgwiZMa8uX4gBT0tmkx545WXGv8ZBkUCa7/jm?=
 =?us-ascii?Q?Wi6rVp25ZI5HP+Xv59h/kgWZsVwrahY5fzD8QDOBU1NG8hGSvzsxBPZYn7QW?=
 =?us-ascii?Q?Y1V3EQL/yqqYAiSOvurhu2qgCZLMmi7CTPs8Mvy9Y3a0rFYlOcdk6kYP69pv?=
 =?us-ascii?Q?tRN2T33nYE4u7Hk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 08:31:05.2872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6669b1f8-864b-409d-276d-08dd780a090d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5680
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

Adding support for the ufs distro boot command.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 include/configs/amd_versal2.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/configs/amd_versal2.h b/include/configs/amd_versal2.h
index 6a40bbdf3a72..e937375ca6e7 100644
--- a/include/configs/amd_versal2.h
+++ b/include/configs/amd_versal2.h
@@ -105,6 +105,14 @@
 #define BOOTENV_DEV_NAME_JTAG(devtypeu, devtypel, instance) \
 	"jtag "
 
+#define BOOT_TARGET_DEVICES_UFS(func)	func(UFS, ufs, 0)
+
+#define BOOTENV_DEV_UFS(devtypeu, devtypel, instance) \
+	"bootcmd_" #devtypel "=" #devtypel " init " #instance "; scsi scan;\0"
+
+#define BOOTENV_DEV_NAME_UFS(devtypeu, devtypel, instance) \
+	"ufs "
+
 #define BOOT_TARGET_DEVICES_DFU_USB(func)  func(DFU_USB, dfu_usb, 0)
 
 #define BOOTENV_DEV_DFU_USB(devtypeu, devtypel, instance) \
@@ -120,6 +128,7 @@
 #define BOOT_TARGET_DEVICES(func) \
 	BOOT_TARGET_DEVICES_JTAG(func) \
 	BOOT_TARGET_DEVICES_MMC(func) \
+	BOOT_TARGET_DEVICES_UFS(func) \
 	BOOT_TARGET_DEVICES_XSPI(func) \
 	BOOT_TARGET_DEVICES_DFU_USB(func) \
 	BOOT_TARGET_DEVICES_PXE(func) \
-- 
2.43.0

