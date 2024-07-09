Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30A8C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 04:22:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D12587EEE;
	Tue,  9 Jul 2024 06:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3ZsAze//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98693882E2; Tue,  9 Jul 2024 06:22:42 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B84E87C7E
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 06:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O47RLr88HRL45I/P4uy/95hFK5BbFA0PpKCudcytYlB6l5yh/pYTdFgwemWJp77QEDNyvucZtG4ePFFM3blVF4jdkTVfIY4wNDMOyirILhGC2Jfg9eNIH3OnvxCAO/VOv+MaygpiNnZ5nIFo7jmiT7qPUQZ+TN6treN3tRETjUUOwulOeISrq/X9Y6F8En69nnLcr04OEja9raDH88XAweqEV9kxnBINL8UW/uZ5AZ9rZi6NY6ktsKsfFPVkzzUtm3GZrDohlQlmDSa34cjPmV9V/4OXHv8K3SRHl6psDLlFvnrbyKbLcvZbOwpFhi4/Mo2KJkAp5SlPIctbpz9bJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRhHKZGp/aeJjciFRbJ5e+NJfGp+tvmdx/+9XT92RwY=;
 b=eddXOkqdGaseGMvNskeMeafaNfQflSQRYLwEKFWvdk7oaXu0+wAMlUrD+ibhz5FZY6+ute2JUMYtjzCYEni9UBKmZPtfgxVIZs2fwrCA3wG8ILRZ7lY3RmQkpdsr3QYVcqHa4+Ogjz8EMC75zqCf2IcVnZ1b3a2hgZHvcZijKeO6CXAiOAir6NaKvMCOXo4fSz6FmseHqSFpV9JHbwY1F39cIDnSTIJ9XwgIQj8hn6JofLRcJKctlYKUEB2VAdY2X5j8+eDe25BbmBgWMBZ4mPb+E4ZtbqLiGKqmRP5v6JRWS4u+kfQyW+W/BJRogPOwQncsHwtNdHDZuEv2Pn3p2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRhHKZGp/aeJjciFRbJ5e+NJfGp+tvmdx/+9XT92RwY=;
 b=3ZsAze//KLu5LYlnwPHTOSDm7a2KPKKChOmngmcPRkau1dwS/qjYvXQ9TB2/0K5/AcfRNfve9Gb/jm4+zQ4TISWoqd9xIJYX7xbmGoz3RyOqwWYJ3iekZXjbq4isXNwldHtAl+4Wq5dlSb0cGWnE6qvFG2xneG0ZQCkwaUVZhLg=
Received: from PH7P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::8)
 by LV3PR12MB9259.namprd12.prod.outlook.com (2603:10b6:408:1b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 04:22:37 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::a2) by PH7P223CA0007.outlook.office365.com
 (2603:10b6:510:338::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Tue, 9 Jul 2024 04:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 04:22:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 23:22:35 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 23:22:34 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 8 Jul 2024 23:22:31 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>, <git@xilinx.com>,
 <jagan@amarulasolutions.com>, <n-francis@ti.com>, <d-gole@ti.com>, "Prasad
 Kummari" <prasad.kummari@amd.com>
Subject: [PATCH] xilinx: Enable the NFS command for zynqmp_kria
Date: Tue, 9 Jul 2024 09:52:33 +0530
Message-ID: <20240709042232.860395-1-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|LV3PR12MB9259:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c4e3cc-2967-489f-8730-08dc9fcec2f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JWn80H3PMnhvjjmTGmscUrkK4iwHAbFCFPZluDo5jmjiZ8DFzHjmxSenStpH?=
 =?us-ascii?Q?d9aNEgwxqq9kbu7GVxmalRI0nZ84714UkDa6ZukYKJHq5VpY2wi3a+Yum9mQ?=
 =?us-ascii?Q?Luoasae5m6pStwyVw9FpaotIUCay6fXKFmmW8SXJCdPeW7C4f6n3ravalIxy?=
 =?us-ascii?Q?q8KIgOECO0/PWkQbCC7i+HpKIx4lgLbBiQwxDPn/gnHn1dO8/fqRt6GVYCY8?=
 =?us-ascii?Q?h3omXl90ZZMbdhmd4fGReNmZWPSr5klmRfyPX1fyhe87asRIHwtYqWbrEBZF?=
 =?us-ascii?Q?C5kZAbt/krHXhdMGzshbNFq7cOvSjQQhoxtB04ie9AP7iIncmClVudEL4zOH?=
 =?us-ascii?Q?bYhQQPsqLBFoYnH5PK1rAXxv9MjoOmmK5exLLZ608U/deSSJywUZb4/YfRKG?=
 =?us-ascii?Q?H5WUIW2xJO/tMh2mCr0C4nFlrQ3qnI7emF7roHKcbFuFT0fKkvo9vtWMnk/b?=
 =?us-ascii?Q?ZDW2J92rbM/ZhzgOEvfWy7w2Y50ZoTKaHu7ZUgaK5hQwHXz2K4Oud7Vhxyzs?=
 =?us-ascii?Q?yZAKejW32WQyH6kdap7tSBly+s2jtasjGpSVeIHbAdbK9BwTHO8IiJvJm14v?=
 =?us-ascii?Q?bFKJu8528IiHV5axay07QfsaGgCTKBNDhmUAS5zranE0ShS1aKVMngubvpvm?=
 =?us-ascii?Q?QZafiO+SuRsy8yugAROw+1pg1xqNLmva3MxQ/oMAGXC1occ8zd9cWOiHvwKt?=
 =?us-ascii?Q?wG8Yw7T/GCHnfZq7wYDINP7QRuKwiaOqlXayGmw1Aj5J/iVGnCuLlZ+hdpSQ?=
 =?us-ascii?Q?pSZg7ifWonPA9yDtn/dwa1UII/840xru+9cOVX7Q+U21n1ex90In4TAZB4OV?=
 =?us-ascii?Q?C8716pJMe35GBWTgyOHUxZunV5omXhH/Q6Y4kp5cFzSCcXfdrF2SYPuCBrW0?=
 =?us-ascii?Q?wgDJCUCKrvPv2M3/FhGMdINUIWq835iwcSiUR/LFBWFhB7xIZCh2vb1Nel0F?=
 =?us-ascii?Q?7GT71iAXqiUneQ1WdpC3PBFq+85Fj2yjreX1LRTrfCzvi/IjdiuMEpc55iL4?=
 =?us-ascii?Q?6sjrHmJp7gKoNXqPcu4ra6AG5E7LVxF758BjNzMglFSSEfm7aC0wSfXBqiMi?=
 =?us-ascii?Q?QbUZAKZO5H1KoeYFSJg41wKgyfdwkOXGvWv8v+oN8408CfOq1ACvQ0lEmNTf?=
 =?us-ascii?Q?X1p4TYQwl8AoqIPw2LYjQObTVR20MNQAItzSIpDFhcDKvHUHbD0jdxTCmycp?=
 =?us-ascii?Q?LOJUscQg7ibqxgIVoppzR3viSlhw2RfaxXIeeIGR9Vi6ulpA/aq0b1JrKgHP?=
 =?us-ascii?Q?UDxV3csUUZ/hf7nKuV6URpiEhdMrcGwaKY8/KG29ONid8s6SkQYqWbW88hfv?=
 =?us-ascii?Q?l2lgATX+F2l0eGNRrEFKOW6m+N8DiNW53flglfNvvwOWS/y2sZum0I7cD6LT?=
 =?us-ascii?Q?mPXa0W8hkv1UkVS+ge02QDAVj5puQsDQR5AJsWOlH0JSowjaeq9UgSFjrR7G?=
 =?us-ascii?Q?GitJDn31+lygAhIVU7eSvndoCriDIAkA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 04:22:35.9542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c4e3cc-2967-489f-8730-08dc9fcec2f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9259
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

Enabled the default utilization of the NFS command on ZynqMP Kria
platforms to facilitate booting images through the network using
the NFS protocol.

Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
 configs/xilinx_zynqmp_kria_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 58e88b25fd..4c66c536d0 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -81,6 +81,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_BOOTP_MAY_FAIL=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_NFS=y
 CONFIG_CMD_BMP=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
-- 
2.25.1

