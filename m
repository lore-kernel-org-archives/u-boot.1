Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478D1C71135
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 09:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 360C482D32;
	Mon, 16 Jun 2025 11:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vTnJBI9t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBF5882D2B; Mon, 16 Jun 2025 11:45:55 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBF7682C4D
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 11:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0muZDExehuDsz/N42HcjkgiiVTdG3h+UCjiEyWHTNNe4tLW5iCZtpePf85tDrIxsRAB/s0ppIp9E9hOhMnKr4sZF0MTxL+YlO+qd9QIuFKoJGurI/RBsNphLO2YO95jcIXf/8PvK+BwjEAM5XqRwjLJwawET/NCripQo6IowVVuVWLCjhcVuyifw2TDLkHR2QwWcEo2ELBRdvrWeUE10QaA8bPYrJVvD2WfU64LfYr0TtMfCunyTt5cQhu3BhvM8ZG4lxMFHK1nES1riciLLbrqYK+ULq2dNwUZbRqt+2jJ6vlnSxnX9fBsRo8IefdMyZrwhFzHf2E6cT4aD0TIrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajgOaFX8ZfpqNuKE0jnHs0uPX5axs1NUlQWt5jlYbU4=;
 b=s8Cv5QjUWyvg227341POFdXf/81KPG6aXZXSq5vNZO1kIWFHVbzzoKQoIo8aYL1W5oSalfnQVXVf9UFBTdUm7BYaM/fxBaClMjCTOARwT+XAGU9E1m3jIHCp2ioxOA7pCpg2fWxJXUXF5ZY2ev/Kh1WKUbgdSC6bEDjHFq8JLYrqekUQ1oVIaOGJ4WVyyPsysmpen71SQl1J4BoTEbTQq+OFsXjaAQQrmhpOAxCYOsYxYNTU0fWTu+PiYPyQqhuDWpUUOX0thPN9xysd7Hu7/CZ/87HkAEXohYKLbzDo5v7GqUcAaTIyRRRonEW4eOfF5xP/tJs7cdimRtGxgXzBDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajgOaFX8ZfpqNuKE0jnHs0uPX5axs1NUlQWt5jlYbU4=;
 b=vTnJBI9tcKkma/MucYEfCpb9+VgdRP58gW0Mjc1IqV4O3lb+h251T8GwLrjkXgz89684J4DjqzKWC766xmjBYadt0Pfq+NWsPg+1+YPx0RwC6Bnudrd02qzNZlceO8cl1JvYNqf48HUrp4+m6K0ie4Lh7qYbikSG2nNMnvwrnLU=
Received: from MN2PR05CA0021.namprd05.prod.outlook.com (2603:10b6:208:c0::34)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 09:45:48 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::10) by MN2PR05CA0021.outlook.office365.com
 (2603:10b6:208:c0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Mon,
 16 Jun 2025 09:45:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 09:45:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 04:45:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 04:45:44 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 16 Jun 2025 04:45:42 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <sughosh.ganu@linaro.org>, <ilias.apalodimas@linaro.org>
Subject: [PATCH 2/2] board: xilinx: update guid based on metadata
Date: Mon, 16 Jun 2025 15:15:31 +0530
Message-ID: <20250616094531.4158505-3-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250616094531.4158505-1-padmarao.begari@amd.com>
References: <20250616094531.4158505-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: afe7aeb2-08e2-42ae-bbc8-08ddacba92f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mkdkZdQbn/hZHGqWPMk0U/8NNalsZyKqTfa9nt60vIhFK3v90MupBF/GFklc?=
 =?us-ascii?Q?dGW4TOuy1RJuK7CUwF/srrk8MKjwXb8qIjXRC7X6N6yn6z2PDt4wfjTHwsv/?=
 =?us-ascii?Q?TGBe+c/CLs39q+6oNRNwo0y1duDoItkgGicx2gGhJUtagYFijbexKG8TCml4?=
 =?us-ascii?Q?JKACtK8pFoqFHNMgQdbk4qGcgmNW75kid77MeRUSZFFQL6lKR213zF2ttVd8?=
 =?us-ascii?Q?erYK5zZwkFpmLJN+wmQD5qj86UpnBO76QSGEORwPiL+gEbW8TFfyYdKeVA7y?=
 =?us-ascii?Q?BN5d4DgdGYTwKd44fvv2cJAl2BlISiZwx8R31xf63PtTIWxfo5dbiRkCsG1C?=
 =?us-ascii?Q?aLPpTwoNZvRBF4j9oAbTeTiiUHK6osCMo+/1uOHZyp+/EBlhHTlLO4JqUogI?=
 =?us-ascii?Q?tBlXf1/MIWdBZZMye8R6tuWQiGk6ynfxSG/0oprOiz25y9MFu4gK2dL70Xqx?=
 =?us-ascii?Q?C8kDjZ+Thjfr1gI62eDvfYdgn8BIRgE3WwHzZ4K86xgX1h+Guf5Jfng1EIs1?=
 =?us-ascii?Q?xzqq1gCfSxVERUG2/w/1PF5ev73TsaVlhraf6iX3LOzHd9jkeSQjMBOJMCnL?=
 =?us-ascii?Q?uT9QykK1EbR1tjbhs3Q0NX0tfo/ypLiVHv3lhplE3c3H3lgq8D+Wein+t47Y?=
 =?us-ascii?Q?w6A/a0OiMq7e550VU9XkJPqsokKdiFQa589GOUuscLXGJ+zGS9Rma2lYtC6v?=
 =?us-ascii?Q?JFuuEXqwOuoGIU4hqv/jx4gMBRYqeUuuFBkwp2rOeQuMQ3mIgdyYDHagmdc6?=
 =?us-ascii?Q?ZFWlxhP/xv46y+3MZb7LxTh7i9S9FVRwTifpveMK0dH0GihqKSvWMkEEmhzb?=
 =?us-ascii?Q?f+xUAIVXgzPKv+V+lSmTEtTsIikeL3oxNvpNyabmoiplVyYkm7BPVQCxFYrJ?=
 =?us-ascii?Q?iq0ED9AltbF8kXxEKEw0QS+5sj4jibFZ3pzO7Lbl0o+t9rhxJbqbdkL3Fa92?=
 =?us-ascii?Q?fBiT1YunshGPHSM5Kjw/TvJXZRA8ORItESlykWwdlgGjcSiOkpG75g6HXsNT?=
 =?us-ascii?Q?+wFHoOFjkEl43D/KM8X+n+yd0rdHSp0ZTR9ZuEzn5DwvYdyB+tE3nrPJuDOR?=
 =?us-ascii?Q?s90rGbRCd2c709wrB8AHr2Y5CVdkthkaRQekCNgK+RekyY4J8KDppPKO/uCy?=
 =?us-ascii?Q?IJQ3yB4h2rGs8GRmkEanMJ44+Rrtf8yHW5+q02QgOgvTuv2GRiVEK22qmoPG?=
 =?us-ascii?Q?BxOVCEDHUMQLB9glv1NuFYMUFQYP/LN59N8+hjP4oY3825N70jSgdz09JQFB?=
 =?us-ascii?Q?rDJiOzovh6YepsFwlPLbG9p+VRjdEkpBPxTe2U5tD3debOamtwVXrwf/niLb?=
 =?us-ascii?Q?vibq7KXYGwznVkudyPMrtbukRuNa8zHa5tPtqVRDDcRw/+JfTd08LG5RdvcX?=
 =?us-ascii?Q?EVN5uQ4F8RkGmrxVbkGxU2xvKYSctQGR1jVn/AoxY+5/na3Lj2x9MwmuY2r1?=
 =?us-ascii?Q?smGpFBzGe+NmRCo60eROjo2rnPVr6qBldqknnPJSKAVXWIAhXjLAM357PWhV?=
 =?us-ascii?Q?tbKDTQ2t7HLKO064xv0pvchy1EJIHnVJW6Q8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 09:45:48.5522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afe7aeb2-08e2-42ae-bbc8-08ddacba92f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189
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

The generated GUID applies to all Xilinx platforms but is not
specific to any individual board. For FWU multi bank update,
use the image UUID (GUID) from the FWU metadata structure
rather than embedding a generated GUID into the U-Boot build.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 board/xilinx/common/board.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 8ffe7429901..3d22149d429 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -712,3 +712,16 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 }
 
 #endif
+
+#if defined(CONFIG_FWU_MULTI_BANK_UPDATE)
+int fwu_mtd_platform_hook(struct udevice *dev, struct fwu_data *data)
+{
+	struct fwu_image_entry *img_entry = &data->fwu_images[0];
+
+	/* Copy image type GUID */
+	memcpy(&fw_images[0].image_type_id, &img_entry->image_type_guid, 16);
+
+	return 0;
+}
+
+#endif
-- 
2.25.1

