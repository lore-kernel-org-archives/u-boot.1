Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2A6C54798
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 16:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF33487A00;
	Fri, 23 Feb 2024 17:19:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4ifIhX5+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5377487653; Fri, 23 Feb 2024 17:19:24 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9163879DB
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 17:18:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rk8xZwbvLXQY0X2ehK9eQe2lcjPNb9bYXYUH2JqIo1xqnlnvPZowmCSbIZa/YIioEpNnnvWdPzeXdg8g+cqLZGk5Ma47W2tlb8nDnetkR7/gSEPJfiqcn++H7PIXQ16Dnk8boMr18etJXBnTeLkq1O5HcObHWfqCDrjyKBXPAl5CKEcmnyEWu5KeestDi9ypoajNOwNyyG4oF/lOcJIbQ0oDR8tHi+97+C1lUOUdVtUBCq6nNsIWWCI3/cmYeZnfyqILsOuU4fBFRx11s7My1M5GVcXia9NvRQfkGC1hAZ+3OR8V8H+kiANomHao+brVcNi1TkdcwV1aKT3iLmpf9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjfFKszMbUOVM+2CQp0CNYTzQMNnrAeTKWVa53IlmDM=;
 b=J1+kzs8nyx7pMmR8LZjCNjJEDtweb5vcYYPD9nTCB3mOHGEjFpCF5yyfTWqxSYb/LmVpX1wPl3AyiBoOnYIjwwKvxwUxC8utJ1G6/X4XRs4M5GmcndCqslSiyXpG77gxEE0BFtAhuE8iKvevkyU+fgEMFUUYBxy9Xp7oIt4UvmOH+m5vx3pjxRVdk4SDSgwOxQkUrB35Mu/e212UcH3p/vu8GrL0UkkAxaEzCAPnx4DGfDL7q8wqciozkZk9ay6ig2RRauteyYp66MBi/rUla11SCXpSBQdQ3xd7XOuQpHbRYxDuVSHDtKNzhJcX1StKowiDJZQyd8lKQ6kH4JEesQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjfFKszMbUOVM+2CQp0CNYTzQMNnrAeTKWVa53IlmDM=;
 b=4ifIhX5+VqToJjMtl+driV3HlhoPXdQBhoectYIvPDqHbv6oHuCU9L8CY9khykWOzfTDs57L+zwUk+fPGOQMMy8NTR45mWSNaoE5+snmP0jRVhgFEs+7UFR1q4X5Gl6UDDNimq5QM91q+4TDODg/Ms8K/DwPi5AHhXHXSgQwLVI=
Received: from DS7PR05CA0046.namprd05.prod.outlook.com (2603:10b6:8:2f::14) by
 CY8PR12MB7611.namprd12.prod.outlook.com (2603:10b6:930:9b::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.24; Fri, 23 Feb 2024 16:18:46 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::f0) by DS7PR05CA0046.outlook.office365.com
 (2603:10b6:8:2f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14 via Frontend
 Transport; Fri, 23 Feb 2024 16:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 16:18:46 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 23 Feb
 2024 10:18:44 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, <ilias.apalodimas@linaro.org>
CC: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>, Shiji Yang
 <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: zynqmp: Do not describe u-boot.itb if SPL is disabled
Date: Fri, 23 Feb 2024 17:18:42 +0100
Message-ID: <561f9d0ee96ebb6cd674042f269f280ab68fbbac.1708705118.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=811; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=NEYM1J/9TraZhw9s8xzVixBMXjBF0uKo9DqCxTG0yQQ=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQbR+PXa5ik9rVNazj303GCZsVa/k6eJz/ZxZ1E5zWft
 j3+6OC/jlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjARBQ6GueJJ8c8unb0s2668
 6SXbxRtFTbWrlRnm500RPp/ozJez/0X6j6m1V3Y8vX66DwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CY8PR12MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 4db01ff1-01fd-4e04-85e3-08dc348b1c90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPDvphe0M1tde4OE8+Lc9MtRHAuaYzFLj0fEDZvYvmVsfVzOL4s/MzOWkQJFQhCYhJpfXgZNezJZK0uRgDlZSJLxpH4sE2aUmWx+2XFCPeiufWf2Ht9rpD2XrL+7U0r9ZNPf+igxAMxkyvqi/EW0D7FfH+KZ3NMx5z5y1ZMXUjbBHaTZnbMZx/J3L1dbmseNFkT5uuTLtGJ6zIfaO0ZEjThfBTZSmD3vQRxLANYtaTGwl2JZHoAyHj4eiy17UrL5Hzl9Pt4+2sVB0SHZ3c9vWoWG7ZqX6K4v0l862ndaSzbtz0aX45mLtwC+W47/4HSOtW7w5fdyU6pnRZRCmmLimYcpzmATDlPGN9hAJ30eHPEf1ia93VzAY+H4XzQ909bQWEzdIQin6l1y914OIgvVtMnWRu7SgXrm+yLzb8A6t1czcNrmE6//GmvoOo5oHONSHRnzn3q6RdIAgZPNwqKBjslKPtT5HmA8IBJwyv5tnNR811lA5mIWqGrMLUZcMTTi4oDjC3RdlzLU9hd1j+wE3fqwITKW4bWrI5bqoLSyCMTRpT8Fi4o3IQPR5AJLeOegAuv1y9h1RsllMjZMcGzu6EyK6TQ3h93kszKj3wqPrM+UMs9oyOkZKsxvXaoopObzhB5hSunosHRRTt05cn3k2c227WbG+a3mEUqbzZ6D09Ba4XH9/nWRXxVakMmYWz2j
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(32650700005)(36860700004)(40470700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 16:18:46.3006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db01ff1-01fd-4e04-85e3-08dc348b1c90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7611
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

There is no reason to describe u-boot.itb on system without SPL. Pretty
much this is cover all systems which are using only boot.bin which contains
all images inside.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/common/board.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 9641ed307b75..4f38b7d27684 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -43,7 +43,7 @@ struct efi_fw_image fw_images[] = {
 		.image_index = 1,
 	},
 #endif
-#if defined(XILINX_UBOOT_IMAGE_GUID)
+#if defined(XILINX_UBOOT_IMAGE_GUID) && defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
 	{
 		.image_type_id = XILINX_UBOOT_IMAGE_GUID,
 		.fw_name = u"XILINX-UBOOT",
-- 
2.36.1

