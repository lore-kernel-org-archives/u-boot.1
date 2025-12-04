Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DEAD1D89F
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 09:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A18283F69;
	Thu,  4 Dec 2025 10:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BaVw8l4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CF5D83F82; Thu,  4 Dec 2025 10:48:24 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B979283F32
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 10:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aL1nWxEKw0JrLb5LMWybCdF7/ZDIh0kF7WIBjXexPDtzGjxTXGStYPg597XJe7nMGtw8c8ld92ic7NlaIhgCm6Auv64tHe3gSBYSLDjIoAJUGQsvg/WjUZ+Z1a2QRjtQCOU+pLiJcsQuzdjabpcHI6IyJv/vNjJKLT9RvCSBjFqFTOSkavhM+vfyLqCnYT02bNUrqgZkE4pvwLGjRKLC52bL7G806AfU1HxwcsNZxx/+PIoDHAVu29fNP493aMVQrzEd1ULQ9V6HlHEp+VMnxfcG3bJlPQczTd9SoxB39ErIu6Es7q0P7DZDz9vcMH4rS/Nhlfbo+eXTjmvjElKUPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/HPG+4gRBvrLJdwoUq41ViVhFJKPgwXUPtQITbpJp0=;
 b=fIbXTuIUVpQ22zRexQsePBoeOxzg2vbslYSUAXCI9MHi2ZjTd0xWfhT0+p2vwPS0ZiHBflj9+3LpLa8I39Gmo5dtO/RL9krqwC13nX8RJrrmv9clp2Es/Gboyc07ySdx9DbRJ+bcqvCPjC5Y9b2ALPXjnP3A7xBwiqkrnfkh3F1TfKdFfIJ7ibbgegSXxkWP6ytCnaLHBBi3NgQ+ndsP8sGaCP4k45Xo9x4QFcKmHz4LstvUdpBFa7ydpMsKfmLhUfwSKAzh2jXDFG6gkbK+8WAX+eeHxLOHJtvs7FDNArvyL6dFeXYy92x8yD2w8aOF8hE+dMsD/rTqzKrwNm9WKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/HPG+4gRBvrLJdwoUq41ViVhFJKPgwXUPtQITbpJp0=;
 b=BaVw8l4B5SCRfcv7YxSHl38ZcPjpSqaxeCEeb8sdJKEXxxeyNvv85xE6BdSXy/XHzPklbhlCCFa+rFieRv0YIWp1y6F7REGDP7cF0xFwgGzPS8OmK0k4zgiWWk/XE6ZK7LbO3ajQfbMdrk8cnQAQTupzYuCOfucc7pl6YoJHEEA=
Received: from SJ0PR03CA0346.namprd03.prod.outlook.com (2603:10b6:a03:39c::21)
 by CY1PR12MB9699.namprd12.prod.outlook.com (2603:10b6:930:108::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 09:48:18 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::57) by SJ0PR03CA0346.outlook.office365.com
 (2603:10b6:a03:39c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Thu, 4
 Dec 2025 09:48:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 09:48:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 4 Dec
 2025 03:48:12 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 4 Dec 2025 01:48:10 -0800
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <ilias.apalodimas@linaro.org>
CC: <git@amd.com>, <michal.simek@amd.com>, <john.toomey@amd.com>
Subject: [RFC PATCH] efi_loader: disk: Add print to show ESP device
Date: Thu, 4 Dec 2025 15:17:58 +0530
Message-ID: <20251204094758.2800428-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|CY1PR12MB9699:EE_
X-MS-Office365-Filtering-Correlation-Id: 912dd9f8-9d14-4664-4b4a-08de331a4105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?loW4UBC9T0PIsQ9BXy/CQm0o8B9/MeTCRwMGU2ENLJw1zzzP0md90gj7yb1b?=
 =?us-ascii?Q?7OqAAdJ5MF1bfaQzvgIrt8ACObOSHenyrfo3TYvITqBqPbsiGuYvCHan3+vo?=
 =?us-ascii?Q?TdmFkvVB4uVyFwEakIlaBRqP1gEy+SprMo4Xj8Ga7J4EXRj6GT8HtYbSqiQL?=
 =?us-ascii?Q?aB2uhQWDTbw5KXe3Sy5PLZiMqF2/YDbsfuGdfUah6KG1NG+/mjkzrR7ywGCy?=
 =?us-ascii?Q?QKE46GEatDKw7eRm3wcK8BVTFWQ+g5yrVzkyKoGzPVMFyKwtDWkYJS5YrWob?=
 =?us-ascii?Q?JHCfRWHYWOQGfqgZz5j7A0f92ncHO9rXtX2TH2xSw6E0ghm415QfY5HX39R5?=
 =?us-ascii?Q?NbNNVBGHkfDj0k4Bb9NwY+KM6QPTKJdAGonzHuPl8Jvsq6cAO+l2b3mlLyx7?=
 =?us-ascii?Q?WzmjMfS1dq3Q/pJM6/lhi97VYm8eFQBmg71PPXhHI4dCMIm5ZqR3UBbRimyy?=
 =?us-ascii?Q?pE5OYuWYG9h1YfTXvi078jQaDC3c4ztnP2csPKbCHkAyY7MRqjSePQLMmnyi?=
 =?us-ascii?Q?CJeVBzHrxEB8qFJX14bzTDKXR6A7FBjDLUtDFKE5AhZg/h/wEpRhG34n9d6Z?=
 =?us-ascii?Q?2Am/0v4MmizLEj8SXVrjS+2BKrmkjJRmRMIxD/kkWNM9Ej+YB6o6I73SIX4D?=
 =?us-ascii?Q?Sp7KlM4pHxlw3pCJVIdv4GBebIXIu8NtPYfdl46kwY/QOu3vtZ/yoQr8gYU8?=
 =?us-ascii?Q?ZFjbDRF6qW4DO5Jixr+hBZIm8OIabWV/jiAURZC8jmOMtL2D0pAZ8n3Ly1/W?=
 =?us-ascii?Q?7OTcFsRCuw2+tYiJsx7AZGt9xDcBuHWoHXb9SBXW0We51dYEY9JOKSI6ePVe?=
 =?us-ascii?Q?2zPoKjjvnE/jRLa3Bk9TeOptKU3u6O7e76cV5Wx5mMhbP6Oo2f4/2Fq8CJ+k?=
 =?us-ascii?Q?IqzUpeim2iNwOK4NKx51c1P0XRfXYt4Y5bN1+zoIMcqrhnDKfqrj/M8Ig5/b?=
 =?us-ascii?Q?XtFslLdktu3M/MTqGFiOA8eotJCYJPk8O7Kk3uGVwetYHejAhh/UWKbxHhBQ?=
 =?us-ascii?Q?Qsmr9yGDQ6WtdYVUjUVQelmDk24ekQQrN0YulP3s7DRUoCV7lCEhYxmyAlLp?=
 =?us-ascii?Q?AWPgMz87Ep+BSqN9cRN75ZSimtiT6QJ2bfLQBC3Jrq6dCHlP57R6jeizb9KM?=
 =?us-ascii?Q?ohrXA5jZpAjutSdcKMpGY9UvzgJ8kBtNSTMsYxWohD9+EDJKhbG1SisJE5Hb?=
 =?us-ascii?Q?oY6ukB1MupKKJQ+vprLPBK5WyHK2bV+T/ghugSAT22PEc9AKcNKqz7Bb9EIY?=
 =?us-ascii?Q?KXyEhOMhi8EaBpleP11YVW9l/K6z9YoVp2nSd0+HqgG1yEsuSqumfeIFHm4r?=
 =?us-ascii?Q?+aKnNpH/LfcEwbTN7/qncijb+URAkG2XZycp3R6C9kS0Ow65Fsh7c0EmGU1W?=
 =?us-ascii?Q?3M7NMG1YAqbNXCrqZ9xqW4EhxMi70wFPyhXWKxz13kMAQ0/b9xSLQMX7YE49?=
 =?us-ascii?Q?QcBbz+6jjgxuO/pJ3VAGY2SBq6RV4PjFvI3xI20R/1/D32qjsmEMbm6vRzzc?=
 =?us-ascii?Q?yCfvLrq9I73PBP4v6tIDKpLbnEBEPTqGJy4u0KWwDGd7Zfw5wQupexdbrUav?=
 =?us-ascii?Q?QUxgWt2FZazzSL/BnpY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 09:48:18.5067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 912dd9f8-9d14-4664-4b4a-08de331a4105
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9699
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

Print a message for debug purposes when an EFI System Partition
(ESP) is detected on the device to indicate how many devices are
detected. Only one ESP device is used for capsule update; if
multiple ESP devices are found, it may indicate corruption in UEFI
variables. This is for informational purposes only, as the number
of removable media connected to a given board cannot be controlled.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 lib/efi_loader/efi_disk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index 130c4db9606..8391de1527c 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -565,6 +565,11 @@ static efi_status_t efi_disk_add_dev(
 		  diskobj->media.removable_media,
 		  diskobj->media.last_block);
 
+	if (part_info && part_info->bootable & PART_EFI_SYSTEM_PARTITION)
+		printf("EFI system partition: %s %x:%x\n",
+		       blk_get_uclass_name(desc->uclass_id),
+		       desc->devnum, part);
+
 	/* Store first EFI system partition */
 	if (part && efi_system_partition.uclass_id == UCLASS_INVALID) {
 		if (part_info &&
-- 
2.34.1

