Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06E4C5DF82
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 09:27:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4AE380C53;
	Thu, 20 Aug 2026 09:27:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XSkQ_PhIPDD5; Thu, 20 Aug 2026 09:27:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787218055;
	bh=y+cbASgXzhGfROIznS98BbfmJ6LmI4K9PQhh8d4e9Ok=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UlMM/fBwEc36cOvI83x2hHKxbLjunFiQCspdJpn6hDZa8KAXpRLmwcukzxNiNCVir
	 gW4zqrTLQhAkyjwny/9P8xf8XKRhub+5inXgXUEUj3TJq5mQ+y2uH5OT3QIqb1pF5S
	 BhDMj849TtKUNIOHNQZa1Jrvj3WpM+Y+cr0q+PfXVhk1U/dsLgZciob+WkqC1vnVQW
	 hS1qLo2xAl0mcAGXyaPGDMMOSpksRLzVlCIqFABlCCMGumDDm/fLUC2UW1QNWSeggM
	 Hop69Njy0OfL7ZMYeXkoSybzuHQ8k4utrlpkwOoiluL+or9bNaPGbMWimfqGaQkfaV
	 oN93ibVjThK4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1454180C27;
	Thu, 20 Aug 2026 09:27:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FD6A263
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:27:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 819AC4059B
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:27:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1wK8-ZNfXYFs for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 09:27:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c000::1;
 helo=byapr05cu005.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=0/iivMEG
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D3343405C2
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:27:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1q85261BrHc6Q2i+pgkZi2WS4hFYn+kHZorHmkg39Hdtwl6LCDeupjHLeyDAldrJQJNUz1D5NB+P21Lv4RRyXRPGEFiyjtSDiW0XiwSOhcfTAdvTdcpX1YMbpZF5bc/R0jaH+WG3dAC7T2Bser60bcDUCJb0jc+sdL7am24/QboLAW69T2LKycMZvu0V0GHCie+wHy5PPBGXM/jaHuPUhIBI03hFSjvNKEhTF1wkyLLNModj/hN2kdWU8a5NJXAWeT6FXXZLf8xluBEGxj4beZ++S9Uo5E5Rp1Z+KKkLMVR1OvbCHmst0/KIEbWjXUwLEFu9oR1QcgoDhJvGI1koQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+cbASgXzhGfROIznS98BbfmJ6LmI4K9PQhh8d4e9Ok=;
 b=mh0gTimDdEtjpiGVbN6ez9/gHN0YrUGOrWjqNlPeZ/QYl/lfxxSd5ACCEO3GHZM0ZTt6XGmfaIALmR7sasxAlxEVM5F7EEHOV+vEIK0IYGVdWa7XbrNsmMyKeXqa6Oz7709ZXg7OzxTvD5RtHnIlrdgBbSGqMozdnJz3LNxGtrr90zdN9sw4DHDh7doEvfxCcTL/zoHcM9sQLHlhZ8YJCYb0HPoYjLAjapPVMF0IbZXrHn+a3A4okCogX9gk4Ui1hJf5LfIyIQ+Q8gRVGChrSYztPplcUAwZtHaKWJG2ZYsTsxcDAsYhk9szhNDvWXTspJUKP5+FG3bqEc8OlgZX6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+cbASgXzhGfROIznS98BbfmJ6LmI4K9PQhh8d4e9Ok=;
 b=0/iivMEGM0QxF1cClTG9lWVKHh7ZFVLdpSyG/oKwMKoeoP+4vswY9eexdk5WEvAZPskfQQXtqd25myMqM0RPAgLajvosGkTprZ8/4KX46dg186mfGFo2Ym9Ocrbw7zPquCmeOwFvKalOTVqpPJ/Wym5+On7u+7BGlrGHNxFXZ84=
Received: from BN9PR03CA0653.namprd03.prod.outlook.com (2603:10b6:408:13b::28)
 by LV3PR12MB9141.namprd12.prod.outlook.com (2603:10b6:408:1a7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 09:27:27 +0000
Received: from BN2PEPF0000A805.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::21) by BN9PR03CA0653.outlook.office365.com
 (2603:10b6:408:13b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.9 via Frontend Transport; Thu, 20
 Aug 2026 09:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A805.mail.protection.outlook.com (10.167.245.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 09:27:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 04:27:25 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 04:27:24 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/8] net: mrmac: write CURDESC after ring setup
Date: Thu, 20 Aug 2026 14:55:52 +0530
Message-ID: <20260820092623.1647844-7-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820092623.1647844-1-padmarao.begari@amd.com>
References: <20260820092623.1647844-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A805:EE_|LV3PR12MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: a1dea3d7-4c55-41bb-8547-08defe9d4004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: zO6rJ3e4u1bW3XHg7aZJCkeiQzAdu08H9eN+45aavkYczoYjgY+3oDUYFuV8wAqhAYNXqGmgYsUze9JFeI0rWrrgJwJ8skeml/Obw0cBM5Wb9PwuH3x3kSvjpqgfi3UAlN/ZTjIPf5gySdLfOEeIo/CXTmiqs/amAukSuEcSlp1dkaDUbpJP34kBLTohUkDyE+Fu8Yh8uvcNgXXAk0aTL6IrZuzZL8eUcCxoinOSPsqrAqaRpuFycOpxM655Jf+bpa7pqxbq9g6BB6nqkrAOKVKYAduQME+zPcf+dSixiUXrz7N6fIUfaq0bKeWBvUif8jpdF0jSCAgo6nm3Lnf8AdXb7UHLHC4N95XjEbDNCoeccUjOzXUeGoW+bNTDc8D1NQSE7bQ0XktUSMPQcSky7LIdVgADQ6mfI0VH6MTcpjygUMEcvNAuUkitWHm2MvXfa8VTTxuBkJ8VmNR6dLbOTStRz83LdJ8L5C449EZzm1XV8gcG4Tl5HJurz77r0QVQ66oK191BydXCcR2Te5PsCXpC/atqZsy+ltgxtC7jLosrD3N0pjnsak0pQ4MsLjn927SlCL+Y775h6sRImS1KkrGXOjlxF26/EPBMlSBSoDtrmSV2CLs4ejcb5DB48GfJFqj7jG5zGDxPVM+Z8WIid0+JdTDUthCUalH4uZEkIK6OJtJxthw6y95EMec8Qgrz2ARRh5MDsJIniI+cESUw6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jFSH7O71+gXyqFj6wqxRl3qaoyEqP+r0hLZs5jcnnhP2E3gXNXCrCYrrd1ic1acdum5o9v4+NIlYMbo15NAVPmvg433PWLc9bhBepQmpbuZCH8vS+hxlkc5vaWqPGvfkcy9QU04iKw/HxdFcx/tmWWq+oGcfLErDE2IOuNkh+XlJcG9+vqN7IvyK928eLvBSI+H2xWs1yC7iNl9lKVZOmA7KmYZ0kbLz122Y2BxVefir7C/ckNROkAVDD4EubHE+f5gnaPzcOrnU0NkgAjlufCie49jVmkLLXFRt9zh+BTI/fGg+DWcDyzPEx7r5Q5hEwCgXK71s63Uxo8BZUmoFMLTYh0wGmD+0XwWpLj/OEPhj6EFYOgotS1PdruY+8OgZkVs5C33Tg3ldXtCYS+g0fIInxapmg9QGlRU0HIoLiDqOeL8EjdrZFLQa9cBkFz3u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 09:27:27.0121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1dea3d7-4c55-41bb-8547-08defe9d4004
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A805.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9141
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The current descriptor register is written before the Rx descriptors
are filled in and flushed, so the register is programmed against a ring
that does not exist yet.

Write CURDESC after the descriptor setup and the flush_cache() calls,
so it is programmed only once the ring it refers to is complete in
memory.

The channel is halted for the whole of that window, so the old order
reads no half-built descriptor either.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/net/xilinx_axi_mrmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/xilinx_axi_mrmac.c b/drivers/net/xilinx_axi_mrmac.c
index 2c97e9576c9..45112a42758 100644
--- a/drivers/net/xilinx_axi_mrmac.c
+++ b/drivers/net/xilinx_axi_mrmac.c
@@ -179,9 +179,6 @@ static int axi_mrmac_start(struct udevice *dev)
 	/* Disable all Rx interrupts before RxBD space setup */
 	clrbits_le32(&priv->mcdma_rx->control, XMCDMA_IRQ_ALL_MASK);
 
-	/* Update current descriptor */
-	axi_mrmac_dma_write(&priv->rx_bd[0], &priv->mcdma_rx->current);
-
 	/*
 	 * Setup Rx BDs as a closed ring: every descriptor points at the next
 	 * one and the last one wraps back to the first, each with its own
@@ -213,6 +210,9 @@ static int axi_mrmac_start(struct udevice *dev)
 	 */
 	flush_cache((phys_addr_t)priv->rx_buf, RX_BUFF_TOTAL_SIZE);
 
+	/* Update current descriptor once the ring is built and flushed */
+	axi_mrmac_dma_write(&priv->rx_bd[0], &priv->mcdma_rx->current);
+
 	/* Start the hardware */
 	setbits_le32(&priv->s2mm_cmn->control, XMCDMA_CR_RUNSTOP_MASK);
 	setbits_le32(&priv->mm2s_cmn->control, XMCDMA_CR_RUNSTOP_MASK);
-- 
2.34.1

