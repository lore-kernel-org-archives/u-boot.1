Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCE3D2E025
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 08:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CB748929F;
	Wed, 23 Oct 2024 10:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="teiA/VIa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55851892AA; Wed, 23 Oct 2024 10:51:44 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B1A688B0B
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 10:51:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPIChNTab208pzrAKxI3xXIcNQ/XM8VjrHZw1QWe+UJ+4nFU5xRIFzLpcBnl0f28WTsCyv6mGAZm2tMbm/Brwg+31ApffgX/uE7A7xLe9aTWbX9Ruy4hO78TEzscgwbFYRDcOArZypiyMhavDNEbZuYD6aQrEjQdwsPKEBh/jlnxz5fxq7QeDBMK7jPBBHuVtZgl2LF6J1ycXSZMhwMjyS6OSe77q/oboA0Nan/blNZZ0BGRrp0tf4ZrTd7bOdWXq52hGz0JMu7R3or5fLfVF9jeBCIT9DOkXhBLEgOgEazXWZ8WsCyeo5os1kWARC9LO8gAM9qocBMsT6w98jx7Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xCBlXqXJ2hwtOrv0nABizTdKNA4W/OObrs3rargdGk=;
 b=V5pXBjzz4zpb29ELYz1oafBqo9xBZHOeDoLAfkAsiJU3t54h8KzCywPVegRStMeNfoIAtBFbkHGh6xsck4fixsOsCXs7vDrM9bVDbfzE+dsMFcNdCOgmOqiYFJBJKog1Y0Kxo4HH5BxCHL5iFvxOYADyP+IdJFFrqAsrdLVBQ8bcONYUSavUTxSmp3lKw4fIK9yCyS0AWZKLMkgI18lV10pMF07ir/8jOy1qxk7Vp8sKmubFsisVVySzqGrcnIR8px0tdtRsvTeZ7q7etlMscAkUBkSZNGGV4sTKHSPjydOX8uSXstDm0zlMVzDYJCfuhLOYHzM5kZjDWRK2mNV6ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xCBlXqXJ2hwtOrv0nABizTdKNA4W/OObrs3rargdGk=;
 b=teiA/VIaYLw3Q39wc9gfc8WcVQgeG9DE5Jxao/e2C4hGAQhOdv7d2dnEfcAXDAXVLctA3QNxgQ+A3fZYSRZt5jtNK8qAPZ2jDpr/mcqEWWemQcBDqQgeC/oEWmlytMX9IWWOBtyxyanaN+olyWOBqa0MOrHNnpsnNYqdWsNOi7A=
Received: from CH2PR05CA0011.namprd05.prod.outlook.com (2603:10b6:610::24) by
 PH0PR12MB7079.namprd12.prod.outlook.com (2603:10b6:510:21d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.17; Wed, 23 Oct 2024 08:51:36 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::9) by CH2PR05CA0011.outlook.office365.com
 (2603:10b6:610::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 08:51:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 08:51:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 03:51:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 03:51:34 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 23 Oct 2024 03:51:33 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
Subject: [PATCH] .mailmap: update e-mail address for Padmarao Begari
Date: Wed, 23 Oct 2024 14:21:27 +0530
Message-ID: <20241023085127.3450680-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|PH0PR12MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b1f863-1e33-47a9-cb02-08dcf33fe6a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5eKLahCRDPuCeXbcyNLPpSGRIqQ800l5Rpelh5F9mnOM1PpMxWTr8U7foMCk?=
 =?us-ascii?Q?0/EdhxEbPzXGyiEHPJpY83y97Nz3GAbCAiascZZgMEpAGBL8kRPT16mvbHyl?=
 =?us-ascii?Q?xOr2zy4RnDOtcSf3wLNI6HCpwGXhudbcoVM7rj3PH0GKptyzPd5ZemE1DhfH?=
 =?us-ascii?Q?+hIKBFd4gobFUj/rUPEC77CP/4RowQWSPPlvwFeDKZv/JeLEFhDnZ732hyCw?=
 =?us-ascii?Q?H+gjW+AMpSo7JfZDn4kGwBQtW7uH9JnTjCGjv+GuHtODriUlwOHGpCeVkQVE?=
 =?us-ascii?Q?RAViV3wj1ARe7o6fwUlfZ+aFiGJch2xLTji/fFagR/fYUT7WErT1Dd6nCNd4?=
 =?us-ascii?Q?KgkdCH4t0YqfFfHy5rInTrVUTTjAq04pG1I3eddjoUw9W+HAmDG1GknFGQAJ?=
 =?us-ascii?Q?1RwIz1FdfPuQ+gNHJoEYO5ido+fIn8WM9vj2SBeKE9EI3gnq3ogkf+uc2xSM?=
 =?us-ascii?Q?dyMSzOaqZBagp+2mimgnaAVHtx6WQlVxmTnSQ3QlutFZgGSiObEXkSb4PB0t?=
 =?us-ascii?Q?ZeMa2Dt0VBCJrQ1G1urg+kFV/9fpaCKD1JfBHhFs2MDs54gvbvCl4n4XfoGM?=
 =?us-ascii?Q?Lr666QcPJLM7YbkrT7B6hD+kbkLeuEXoyH6vGMTFslp707+ajnqOuxnxjfcz?=
 =?us-ascii?Q?+M7o0b8Nu4+owy0PNOX9LGvpF7jt9yBgTLEY5djdfrFZh7/lM2238GMRf6s9?=
 =?us-ascii?Q?BU/6ecxEZxJWh2UwtTRCeeMu/flvZ/g9QBhs5ZZGfYyZSZ02kfdGWIDkwtg8?=
 =?us-ascii?Q?4dnldtYXQ2vNH0TAftjFSUdbjX38Xy3p4pjJNymuGDeAxvSMbds49Cd1shl0?=
 =?us-ascii?Q?kVNf8SqI5nuDFhmQuhthNrGKq3fXhXDGOpYthXs1U+hXiC8yEyGXdPksNrsl?=
 =?us-ascii?Q?x8daRNP477ZO5ktnBV51xzS3RjZ3KUX8v6aoScgRpk7SK0p9Akjs0rIFrp9W?=
 =?us-ascii?Q?P05o8j2aXgEB07T7PE8dyhd72SkMieLE4AJWVWZ/e+Mxg6XV6nz/Wn4aMcsd?=
 =?us-ascii?Q?Y00tTyvrQkJxKDniIqZMMI0Bl+iFw13YmRXsCfIXqSWli8svDS4zOrpv0pEE?=
 =?us-ascii?Q?1oWBGJ2ZRf6phtV6I4rkymcw5VNZ+bKesQdGewHtc8shTh8lr9su+WagdxIn?=
 =?us-ascii?Q?TaZq46lepr4mRzT4KbRnxxhHAPy3mxFRyH+LOjg/rjfsfVr6UxrW9a0iX0/L?=
 =?us-ascii?Q?623ClZroAXxGIzbxdYrqB97mr4xU/PJCK4PI6NweLRAb0i6NIhzGTMH9bYaM?=
 =?us-ascii?Q?OEuTMCfDRxZ6D4IzTiY1HRL1XlkwUeAxf1YNG/KgzfUqTJULt4nsw0IbhteU?=
 =?us-ascii?Q?Pzkwgzz2Vl08vijZPHZ6FqaFvxY6i+wZvfW5mgqBBHCc0A4ukD4ZUsDfw/G/?=
 =?us-ascii?Q?QGSBFJFhHaBhvRs0XiJPmxOBQizVEg3akK2JcDuFRPnp/QyZTw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 08:51:35.7231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b1f863-1e33-47a9-cb02-08dcf33fe6a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7079
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

Update e-mail address.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 4d48349f0e..005e965b84 100644
--- a/.mailmap
+++ b/.mailmap
@@ -89,6 +89,7 @@ Neil Armstrong <neil.armstrong@linaro.org> <narmstrong@baylibre.com>
 Nicolas Saenz Julienne <nsaenz@kernel.org> <nsaenzjulienne@suse.de>
 This contributor prefers not to receive mails <noreply@example.com> <pali@kernel.org>
 This contributor prefers not to receive mails <noreply@example.com> <pali.rohar@gmail.com>
+Padmarao Begari <padmarao.begari@amd.com> <padmarao.begari@microchip.com>
 Patrice Chotard <patrice.chotard@foss.st.com> <patrice.chotard@st.com>
 Patrick Delaunay <patrick.delaunay@foss.st.com> <patrick.delaunay@st.com>
 Paul Burton <paul.burton@mips.com> <paul.burton@imgtec.com>
-- 
2.25.1

