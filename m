Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F40BC0218C
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 13:04:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A520080977;
	Fri, 24 Jan 2025 14:04:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JJ1Z4LN8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7E2B809D0; Fri, 24 Jan 2025 14:04:26 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72D6580780
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 14:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ziz8t30UNaC53ObplxmAcH4b/buPUBt/aLoHgMUQoIu46ZD0/b/nmSl8/nx6ly7LxAr8U0klvEeig1uyQVnailo0GGD6MO/tdgZgqaKuzAcSEzsFLLw+b+w4rFOHTZEXYio7tdgQhhYNKCQqp2vO7nRtZK7AgIwK+2MruNJBj1Eh0Ch7AHNt94J6RGAd3kVTxV/3qtnlJE96p39SfV2qhQyLEdYUAidj5T2SGnpD/AFzEypo3/qOENP2BRXAGHsIlD04+9eWr+VHZZIS6Pmr+BObzlyXVDVZ3ymSmSnNS/41Mwejt+UnqaB85Y5DCG1zEQglEDouLASv+1ueT0hweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6D1gLME7+DXgLetvHZ0DpPPtjHNfJ+aptbMH8qhvUU=;
 b=ImgC44En8F/mHHqPNNJ4o3+FYC7Id3i/FPyS7i3SmXaXYuXGL1ZcQPhQwuVuzSzvKJ1WzSLEhtAknXlG3BVoey/LOSGb6L1rrF8DSJUMMn6bgrFRBQ9eOJ7hIA4nqyBIl4xxK6kHE0WqmwV4WSUfpLFJfRblwg8p8qM/mSH1u4xwNSLgxcR6u4ePCVUS7sAL0DByJlLGSwyDUXQVzugV82KxrWfNzqbVambRi46IN4FSQc/1KraLSlpXM5zCzj0j57rRXlyGGIJa+rqByUvY5EN9uisN8Bds27xq47mqe4xA9oSt4Ww3DTimUGHSNJ84S7xpx78GwSllaXYHUhO3tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6D1gLME7+DXgLetvHZ0DpPPtjHNfJ+aptbMH8qhvUU=;
 b=JJ1Z4LN8m6mpFE975BztRZt3SSgpL5NTxUWkEYnnzMwBNFGPt+5idrDb53iWwCfTmziH/QoO6yDiBCeIvtbYJZNo0YXbEKCuRRchb8SrwvgDlWjUo9vD6py1LpYwG7Vuewit3LaqLKw5/EFJ51ydLOago7Tf+NqnommdOJrh3s8=
Received: from SJ0PR13CA0100.namprd13.prod.outlook.com (2603:10b6:a03:2c5::15)
 by DM4PR12MB6638.namprd12.prod.outlook.com (2603:10b6:8:b5::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.18; Fri, 24 Jan 2025 13:04:17 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::33) by SJ0PR13CA0100.outlook.office365.com
 (2603:10b6:a03:2c5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.11 via Frontend Transport; Fri,
 24 Jan 2025 13:04:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Fri, 24 Jan 2025 13:04:16 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 24 Jan
 2025 07:04:13 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, T Karthik Reddy
 <t.karthik.reddy@xilinx.com>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: Enable mkfwumdata tool for a/b update
Date: Fri, 24 Jan 2025 14:04:07 +0100
Message-ID: <6d82c9a2db30e12ea17fa125c68a555d7f070851.1737723845.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=XeORKeG9NVpZZnnU9eL03FyxiWuHRJ84PhrWsoX3uOs=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTJ/SeOfQzMkbrCu0305/XsrktFbLvPra9JN4vW+ntbf
 +Za3uueHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAie3MZ5tfe8K+7+0bbwjzc
 +cS2jtn86wPPxzDML3ZIYGEzX3VzUTTP1WD98C1G/BUGAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|DM4PR12MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: 221e33dd-2110-49f4-644d-08dd3c779bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n5y5wyLN7rFyrz+L9Z4WWQrSQxbQjMGK+ApghZ0u0J8EcoFiMMX6QYzomZb8?=
 =?us-ascii?Q?eCfiKruGcVt5yJsw8Rfd2CBUDfrLZSO+SE3Vgp+9rHdXmnriUjNI5aLQFHxW?=
 =?us-ascii?Q?y97DRmgfH7CBeBYYSvRV7Gsdv5L47pNrMDSdkmG9sktUTdynQOVOf6xaXVhh?=
 =?us-ascii?Q?ZhEqS/uBiHT+W6HSn/UF034bpJ+N+DWhqEtTeG8GmKOSNXu8BwXGpi8sWxbk?=
 =?us-ascii?Q?4aq6DCHtgFF1pC3A3Kw+iOdDBBoNi4DWMKA45VPir7T/HsT8RJJ3h+CK7gQT?=
 =?us-ascii?Q?mY02RWbLiC6sq3wgu7W9GY1Y02l+lou/br9hWVfe+5ipYVOVAyCPjFOJR5Sr?=
 =?us-ascii?Q?loVEchkCOVel5Yw9MRzvOZjGHxreaNjSvMJYnFTMxvNNlYNP0MqUTqRek6nv?=
 =?us-ascii?Q?eT3JLk9yb4EkrqfOnylCOE9yc46DUtAeB0h3i1wZ2n8QGjDyBMNc54keWWJK?=
 =?us-ascii?Q?UhAAUjJX4Ac53nLXhHUJQK6rK2IFonFbeZ8Rp/vi1YY7mu1PcoH7CpxWD5+i?=
 =?us-ascii?Q?sAQtyUi5KRmTcZlEgHz4PVea0MPpHw/K5Uc0FVtbYeign9ZhXtvgOVaf2qb8?=
 =?us-ascii?Q?G4zDcuuH7taeNQFZJWmkxj17LtINB+5gKIbVinpLNPpwxc8yjTjR3cF1rn7O?=
 =?us-ascii?Q?g7qwfRXCBKdruqzPTsui5EJnC7+rg8AKDMGnn0Gi3Q82VVGDZtfroZ0Pg63F?=
 =?us-ascii?Q?tJH9PphMYCQ2Ij2kHKdBlKV4f9gKVue43yJK+f5Ag3TRXvyeMzY9hYy2WJKq?=
 =?us-ascii?Q?RHTub7ZjEqriz6MGo3kJ3ZV1/SOeegBTdQo1NwVdayGwF1TddMII9KONpMp+?=
 =?us-ascii?Q?GWatbiY/MvPLBLr5OVPrrd/tbiKAjFb+9AlESMc/q1fELNoGv/p6XpdYQbb/?=
 =?us-ascii?Q?gVCkF94stkUkeHhejtg/5QFX9DnmFpHtC+94c8UFv+5XiwDDmRhB7n3VrKJJ?=
 =?us-ascii?Q?B+icF+N71KD28IxeNnjCSBXFTkyhy+Kpon/OE/87fyD0bk0ahNSvaGcmxJJW?=
 =?us-ascii?Q?KjHO4GWkycXD2GPMHMbt+UYU38yb3M1jfiXdSBuWmSmuiZ6pxUy5mUZ1LN+n?=
 =?us-ascii?Q?LISrohGUErERkNtMyv46l8N2OyHWc3eUY2MBj0ykv0AeKZDC0wblB0eshpBp?=
 =?us-ascii?Q?1KWGlLWp63it6O212zxLvYLlYek9IXzZn/omwRYPBUAkTfXO8oeN2gwDu+XS?=
 =?us-ascii?Q?/n0LFUzD0YC6Dh5EyeJQUoEBCqyJlWEXAjufSNSaSeUFaa8yJcsFdCGp8elu?=
 =?us-ascii?Q?MXPkTWnlurAXtZXxvrebKqWT/8AvD2ZrygGulfYldMN9BonojexfxVIWidSd?=
 =?us-ascii?Q?i5U5Tk5zlt9t/T+8PtQ2XTZjuSwdBjAUVAF+LX9BbD5Jt/IeUbojl26HSwMN?=
 =?us-ascii?Q?q3dag5h1qyyeikZEHMUEhCtJ8GkDfd4TjSFWlo2vDQ/a2+Xq37NJrjkUT0zg?=
 =?us-ascii?Q?9QjZjBYfxABUqe3k0ZYqRelLhUofvCh4MeyXUPYCvfsTupfEJSQipA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 13:04:16.7922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 221e33dd-2110-49f4-644d-08dd3c779bd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6638
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

Build mkfwumdata tool by default for building ab mdata structure.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_virt_defconfig   | 1 +
 configs/xilinx_versal_virt_defconfig | 1 +
 configs/xilinx_zynqmp_virt_defconfig | 1 +
 3 files changed, 3 insertions(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index a7d8b035a714..57a6a06df7cd 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -157,3 +157,4 @@ CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_TPM=y
 # CONFIG_OPTEE_LIB is not set
+CONFIG_TOOLS_MKFWUMDATA=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index dd6e3ca34660..70e73ac7ad45 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -171,3 +171,4 @@ CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_TPM=y
+CONFIG_TOOLS_MKFWUMDATA=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 05ead1a41b4d..c0721b65fd48 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -249,3 +249,4 @@ CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman.dtb"
 CONFIG_PANIC_HANG=y
 CONFIG_TPM=y
 CONFIG_SPL_GZIP=y
+CONFIG_TOOLS_MKFWUMDATA=y
-- 
2.43.0

