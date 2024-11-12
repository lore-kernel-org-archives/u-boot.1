Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B770FD42B83
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 13:59:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86D578944F;
	Tue, 12 Nov 2024 14:59:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0r47/p/g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1366893C2; Tue, 12 Nov 2024 14:59:26 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65FC689442
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:59:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKx9jZTjak5F69c7zFjgL0qKz/lK2NuzPDf+izQvAfvYK+DqkdjBMVO9gzdPlHnrJp09QQ8d3UBdVo6FVC1naG21A4TtT8nQhCjfymuhtAZldKbCz/jESuXdbwNcKEknfcG4KzCweABFv3U+8MKjrMKj4BgBv/Aak5QV32jX6QEuRR0rcvd+p3eZwc/gqsy+uA0csj80TJGvvzbRXGW06hU/2k8Hma1K2KlF1C1h+Ur0K/1TOws0DvfHkXoN7A8VGXYWdbmVo7Ye4NHy/+nJQVWzNHicG1m/n+O8DJS4LMqoD1HSQ3EiV7SpOk+LtRrVPrU9m/tSfz4FdVpa64ifMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FT+PykFta2Ay1AO1FQ9XJFB+BPk8cseuZjcymuvZSyA=;
 b=LobCGN9MQSPkin904Md6vxLmmCiZSuXsPr8TAsV1wYmMrmAlzPa/yVhawf0/Fg1b9FOFB4wgWr2o5M9gXYx0hW60XN7CaoGXyofzzeSgGUdYQVXuww+2q4uyG9PbI21fXqhXqMgUMC3SS5/F4YkfVIk6pXnvm4wWGp24ogkAbt2nE047JKU4SvLzNwlVVvSI4O4Smw5n1olwpGe2qdHLhQJsDc7ZHQzHzfxNHikvOEn4Pf7UCI7XiRDGrhWJjdPqv5niISE5RZzNeDi2bWqUFAnJ8hA/FEcOJ2RGcBmyh0qe+ybWoOXgq8O8IE6mMcwhBJXzNoYEvUGWC4OnnulUtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FT+PykFta2Ay1AO1FQ9XJFB+BPk8cseuZjcymuvZSyA=;
 b=0r47/p/gCYzGaoYQmfh9j6DwJZ72xnc6Mz2i7Q4K68Qrh+kw/H3robqhEC2uZVSSolH07cfm+C0FuBgbCB6KN1hMKKYRrb5cLvj+TAba7WZAU5gl9E6egxaLRxOwfSCmievuUnBE96ybkJm2rLeMHUnjq5BSJWA4VbPF1dpnEdY=
Received: from MN2PR03CA0018.namprd03.prod.outlook.com (2603:10b6:208:23a::23)
 by CH3PR12MB9025.namprd12.prod.outlook.com (2603:10b6:610:129::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 13:59:02 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::2f) by MN2PR03CA0018.outlook.office365.com
 (2603:10b6:208:23a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Tue, 12 Nov 2024 13:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 13:59:01 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 07:58:58 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, John Vicky Vykuntapu
 <johnvicky.vykuntapu@amd.com>, Shubhangi Shrikrushna Mahalle
 <shubhangi.shrikrushna-mahalle@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: zynqmp: Set default RTC device at start
Date: Tue, 12 Nov 2024 14:58:48 +0100
Message-ID: <01155f1555dbd42adc618906629f5fb45754d5a4.1731419926.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=938; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=p4hVXxczq8M3gPM6ByyEIVj9LlDuWOQSvOEPvl7JGEI=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnTjeMnSa+s+ZX75Xbr2UvOvC1w5k+rCql88TrBexm2+T
 /imce7LjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRmwUMc+V963fYfznkf2Tl
 3ikzz7f6xi/yz2KYn/3wtOrZOK0Oj+9PI5yWi+qJ6BdyAQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|CH3PR12MB9025:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b78435e-3739-4b56-f3a5-08dd032229a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bAumZyyQ5vfEjF4ozYboUxoAocHCAgnpfz97xc5qJNTeN0y59hFc4ysIMG5C?=
 =?us-ascii?Q?Nq7hr9gJ51Rru+mC0NiMS4B8X0mAvSr6mi9Z4dfA6cOB/QB5A9lProOJriIz?=
 =?us-ascii?Q?ArN7NvDh3lqXwgELxmMFUUAAmSHAFpbbUqVkKjiJ9at++ofLRUCPHt4VfG7c?=
 =?us-ascii?Q?drN2fGJ9JJoZahr51UHHht8/7cqFvwoAWraNYTUrZ4LHlwiew75Ni2DEoNeS?=
 =?us-ascii?Q?8DNSQWN2l+0XxCDDZ14MN11PoW2MN/pBXZQa8SrbLQsol1Byig/c3mwu4oyS?=
 =?us-ascii?Q?3wgeHCZwYtC8vNPal1wlIdrAtADGMfn32gkSXEIFUREfyxlOJ41C6N8bpCr3?=
 =?us-ascii?Q?cUhdykl8ANi9blHwo+mX0EouDoNZd6uz5IhPuUo7GLBhUWLQulnQznKqhZu2?=
 =?us-ascii?Q?kTEM5LsU/0168heaJ4+JLUBCw8TKqwcsitjvoK06ZrCYV1d/cJyzkNomqyp+?=
 =?us-ascii?Q?mo+8PLjOeFXrlxRUd6gOLkPAfPiz5rguHrl0fBGuCmhQKV6fFJeRxlhybbdr?=
 =?us-ascii?Q?CxMsCb0dYSwg4QdyGewKE8kBs51c+73ANodX8S6o4cgfZQWLCSFowWE28Fvz?=
 =?us-ascii?Q?9bXdY60RZgLWEvS3k4WE9zz0baA7aLD4Be1uNWFFJQ0kO8YvG7MfvYAP2Yu0?=
 =?us-ascii?Q?UiSdWOqiJp0CStUs2bSmCZjrF4EtJy3fF6JuDXlSe7GXlgK6XHKQj8csL/cD?=
 =?us-ascii?Q?Pl1CF0LIDLgmdaUDeO3LiXzZ3zTOx25eKVPABHFB0RO6WMeCNQ9Vk6v8ldFT?=
 =?us-ascii?Q?8R6FvJWLSkmHliSpKp6IQqwTD6Z1OdTMGaS26J9g6Ny07QV7ISV8Gds89TIn?=
 =?us-ascii?Q?OMkZA8ZHTklpp4rURv4z3AWDNwDDhBsOdz9oQZkrX6ZQT+pM9+LzJ7eXu3ZE?=
 =?us-ascii?Q?HnkaSbBTYEQOeT5XNFuiNPn31quv+x/sP8fH9Bf/YWWXln31pR4U776yKskF?=
 =?us-ascii?Q?u5PSdTKccoSfp6mlAG2Rk/HkRcj6I9kdBduRvHH8cYiGfvASOCyh8GBv5LJN?=
 =?us-ascii?Q?tYLZEmtNOcPuNwVfTFlvyrS+R5g9cSvtdWsvQQr2QKT8bXJ+yQ7GZOvGBz/K?=
 =?us-ascii?Q?vDgh8+CdyROe6irJK/x+zMdPjRfBDvpLp8WbE+1vOuBHa9ZLCdJMFwDce0EA?=
 =?us-ascii?Q?5ci2MNOW7HEHJWD9FfYpLQJRBx0rmn28ELtLeXn8h7A3xcRFDl9ZzNRFS8yt?=
 =?us-ascii?Q?ujaji6AXSriEuCpuubH09LaEQtgtOoiLqzPpnXO8vno0M8+/eAa8rzVzKRkJ?=
 =?us-ascii?Q?RMRYT28ePJcu2pfjJZ8epd6EBl/KE73lCYVaVF6p46TKE3RJrAPC5x5GLb1n?=
 =?us-ascii?Q?6oQOtF0OtCQcikm+KDP5YXlFxwXJGZqkOCulm6pYr34OECx/UiDz7VPpm8hC?=
 =?us-ascii?Q?QQXW+4tMEKykQoPp58ve5617aGQTuC78HALqX9nHsa0bPSy7LA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 13:59:01.7948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b78435e-3739-4b56-f3a5-08dd032229a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9025
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

For RTC to start to operate there is a need to call the driver. The simple
way to do it is to set default RTC instance which will call the probe and
do basic initialization.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/zynqmp/zynqmp_kria.env | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
index 927f398c3c38..ff3a0924de7d 100644
--- a/board/xilinx/zynqmp/zynqmp_kria.env
+++ b/board/xilinx/zynqmp/zynqmp_kria.env
@@ -77,6 +77,7 @@ tpm_kv260=if test ${card1_rev} = A -o ${card1_rev} = B -o ${card1_rev} = Y -o ${
 tpm_kd240=if test ${card1_rev} = A; then run tpm_reset; fi
 
 board_setup=\
+rtc dev 0; \
 zynqmp mmio_write 0xFFCA0010 0xfff 0; \
 if test ${card1_name} = SCK-KV-G; then run kv260_setup; run tpm_kv260; fi;\
 if test ${card1_name} = SCK-KR-G; then run kr260_setup; run tpm_reset; fi;\
-- 
2.43.0

