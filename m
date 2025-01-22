Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385A8C02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 13:53:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72A398083E;
	Wed, 22 Jan 2025 14:53:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yQ377WKe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED29580909; Wed, 22 Jan 2025 14:53:52 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B89E8083F
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 14:53:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXwh+buN/wDRtbiimRb/Azkl0yOxtGlZ8NeUaR93q+6JFm8/xc6vh+B7spSAF8mIn6OiVHL/bstAFFiWJttDG+71GpyIu60Y7XdjGUcTjFxqp71YWqoZfCDudZYqaMZIjza02FFO91YnuASZrvP3QupO1You1FPIg2gjDWYnTZ+33LfBG5V/6BsicK/A7pcINhAfjBBigv4I7geXjVI7XZv/+hcvLrSj4Zqpcj8CSbZm4WAzvpU4UlMq7+YaGYHn91EPIQ63+GNnOh+uSaxOZIxKuJUDLw6WETGaw/Ur4Ft8u0O5VhAirt/f5C7BHf+7IC/z53qXzqSkAuOdHLUINw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wh/OU83DPwzIQTE1LcFFg+A9WTJqn0edt8x+S40zyc4=;
 b=f/SK743AW+0ozUv0xgfwKRDCCOu5dkAJ+iIAd1vdD2IbwHNX4EAnKD/4ZEIBqkU5+qz3ugXvkMDfbmKEwlhusSErsuUttt5fKz/LFS8J8EsqC7GFrOp2J91iOItCk3eNF8PyIF2d1CZCMBb/KDGmu89U5Kdu/BV4LkocvMuRHroEjceJ/8OrgUCoCLAatMslLtmlP0ieSDVQ+Exe7X/HHs4hQBSO+YvBMe7NLiV1lpTUhgg0P7BPrNhjX3CnyPuQjWT7H7b7gJMvkk8Nx4PAiQ2LEJkcjEiQe6j/lLsCDJLlDcrVAW0c8+VuPc+dvgHYGCvyl4KtTzWAQ8SymW6MEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wh/OU83DPwzIQTE1LcFFg+A9WTJqn0edt8x+S40zyc4=;
 b=yQ377WKemmxYRpK+nyjNgggcTFnrJxWnTtR+OnoJKLMilj2NG+SWHxBwcumfudzeqEJIdjzaoKOy9eKucxn62nUEjXLzZYqWoIHmvIx5lugMyh5sIkRgDHDeXhKsqfWPO/A98jy/vwSdr5fHvkPXgmUDFgZSd71O5K9LEz2cpaI=
Received: from MW4PR03CA0043.namprd03.prod.outlook.com (2603:10b6:303:8e::18)
 by CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 13:53:45 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::46) by MW4PR03CA0043.outlook.office365.com
 (2603:10b6:303:8e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Wed,
 22 Jan 2025 13:53:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Wed, 22 Jan 2025 13:53:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 22 Jan
 2025 07:53:43 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 22 Jan 2025 07:53:41 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@amd.com>
Subject: [PATCH] spi: cadence_qspi: Add missing prototype for
 cadence_qspi_flash_reset
Date: Wed, 22 Jan 2025 19:23:34 +0530
Message-ID: <20250122135334.1201562-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|CH3PR12MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: c68fbb72-3705-4652-ba74-08dd3aec300f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7sq/HZ6QdX0HHcvfw7H14mRsLbdlURY8ZRI+E1Vf+2R3lhGvKm2UUk3/qX7o?=
 =?us-ascii?Q?f/6YNIUVzI2j8UKPa74wyaFz1wIqMg5z7WZW80vQK4MI//JYonGE/3TgRCw/?=
 =?us-ascii?Q?eZE1Q58iLfxioYlpHukA5RcHgoBPrN1lKHx6Qjt7e9JMZILVwp1YcDIp/XnD?=
 =?us-ascii?Q?eBi1rlMDZG8AcJqI1AOyodV4weUMjR6kef01oIzYaUAF91qza7uuzOtwZRpp?=
 =?us-ascii?Q?+ZHoaVe03CSg6phpHCTdf43++w9zEu/5PW6srZ9apLofhuTdJNdC+h2cyNIu?=
 =?us-ascii?Q?OkNYPhZT1r8L9UKaNwrm/J7v4g3tL0JKa4tEcAs2KqzZCoSOhpL/fxVxhEhL?=
 =?us-ascii?Q?Jtxl+GjTTMq/QrzRP9/GpKh0lL5JuV5JLKcol1pVq3VQuWESNKNDIDB055km?=
 =?us-ascii?Q?sN7Q0HLwaMTPAOG1fplL3iwwY84ocMUZ5din+jKBb6gXQeM2w5VGNqFP1Lju?=
 =?us-ascii?Q?GmYT87MEIaY3z/Q07V0UuvQ8/WT9mq4fhbYZhY2VTJmhuDAchNJhogsBldxC?=
 =?us-ascii?Q?42MNGNwIvNLJCFJqhfAmxohqED68piHLlG5iUpBZ4wXFTFI4CnvtxVj9/3CO?=
 =?us-ascii?Q?MPQPrZgHBTFJ7xjyQ/LQSskkfrsY48wlNpExRvKkHryVpmg7Tc7fCgOoAx2u?=
 =?us-ascii?Q?b8+iF5tVVbEaJfXznA1jOiu5kT32ILr8Reg/LwUxL+lRCpjElHNJ07UPsP/O?=
 =?us-ascii?Q?vNovSG4UabrGY51GrddE/65vDkNbxovpyCJyxh8IVMBCUkp/sL7itpHT1Wmh?=
 =?us-ascii?Q?kkbwKVef7y6ssfCeQiL/R0+MlJinY6MAXk3xBt8WQuHFA9YIJ2NuTqES6U1g?=
 =?us-ascii?Q?kbhdPlbxzDrOfQZqtsBM8CnRhx5XfT+a687ydu73yTaIObeWlyVXjgZnNmC8?=
 =?us-ascii?Q?/fgpvgkVCeqEaNoPs6EXgmnXG7lxGP7JoCnqbv0oqeogiACsQ/6oqVRFbL9m?=
 =?us-ascii?Q?Xnv90I/Mgx/KHIoQl9g/JHhWl4Oi6umnZ647xk2KlTnHf03fR3Cp74Fo6+Hb?=
 =?us-ascii?Q?4998vSj2aVavSIAwmpSqzUaQ9MHnYfDoI3xrV/gQme7iUsrtKdWAsdveVlxb?=
 =?us-ascii?Q?C+UVTriWa7Cb577o7H6DlAI4/xTrKGQfXHQs9qgEoQCEyxvuiQHPby2PUwSv?=
 =?us-ascii?Q?zaf0UkrkwViuzI1T6k1CppeHd+asEnS9Sf5ksNM59ev67GoKq96T4rf66Ifo?=
 =?us-ascii?Q?cd6hqAMJVsLdjcuNddkgfEdUfMlkB8zCgwByN/yOf4hvbYKcxvYm6NjTzgi9?=
 =?us-ascii?Q?30kOlngtEkChUBO9yneq3wnuJ6Q52fK235w/wCq6HW215D/n6x82Rwy6w/dC?=
 =?us-ascii?Q?pjntUteHunXmGuUZ4d+16kX2cApUFQMjnTCnW75g/EU2HS/8r6vATdV4qK+M?=
 =?us-ascii?Q?MYvCmnSf97FDL/ym9u0r2L+jmB7u6BWP+I5hlLcSpzls4Ifj65v23zwset05?=
 =?us-ascii?Q?PnTfLyIHhC2O7sczEL7O0Mx+kFC4jfAQwCYHHEXapKFl8LbvnfNaRTzY5b7O?=
 =?us-ascii?Q?FHkESJV9PpykN+E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 13:53:44.8570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c68fbb72-3705-4652-ba74-08dd3aec300f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7500
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

Add missing prototype to fix the sparse warning,
warning: no previous prototype for 'cadence_qspi_flash_reset'
[-Wmissing-prototypes].

Fixes: 6d234a79e9 ("cadence_qspi: Refactor the flash reset functionality")
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/spi/cadence_qspi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 693474a2871..1f9125cd239 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -307,7 +307,7 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 			      const struct spi_mem_op *op);
 int cadence_qspi_apb_wait_for_dma_cmplt(struct cadence_spi_priv *priv);
 int cadence_qspi_apb_exec_flash_cmd(void *reg_base, unsigned int reg);
-int cadence_qspi_versal_flash_reset(struct udevice *dev);
+int cadence_qspi_flash_reset(struct udevice *dev);
 ofnode cadence_qspi_get_subnode(struct udevice *dev);
 void cadence_qspi_apb_enable_linear_mode(bool enable);
 
-- 
2.34.1

