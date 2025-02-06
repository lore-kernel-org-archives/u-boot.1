Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA35C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 11:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AEE78082A;
	Thu,  6 Feb 2025 12:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nOk/UQK4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50E7B8082A; Thu,  6 Feb 2025 12:02:16 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE566807FB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 12:02:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0WDrZre3HJOrl+yv5/NnsGkuVxKYM0UugX2Ob2ZUmk3s5TtpYJ068KMY2u66E0mbT+Yb3GjIBVVfleXG5GUYhMaYvowsOJQ/yGrZmhPYHRA+eJG2rMDDHi2WLCD9qRw3rzSdofm+bKnVaPTw1/ysHrS34fG1LBRuys1/pzWp1sn6X95H5QBoUVDvDzSpVKO0ThB1gPFaJN9zE+LcHxm57ku51BHCeygGmYrG9da6YNcYGXTjQG8By7lTBJTXXBI5np993vJqsBIfgFTb592MI1GHx1FcT+4sqT1oMyflm60L8tgPk/SIiEC79DYFE2Pcb/Zb3rdiGhbeRYQCtg4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVKKRVzVAvhhwoxd2BKYuKX7Lfv2cmcn4YezNO+qZaE=;
 b=szfyJsMLWFJYdaOK69TWFweLvwG/b1qojPX9+IfkH+avg5Q40V83XbuRDEQqz3wNbnbfevRSExBwmHCyYs8OWk9RH5dRnWdlfxqKt7b9Y0+hdUnBL575lSehto+dThieZ8BTgkTvwoHrY7OQ53aWUVghrPU0WrvUlqrV0Nxsz7+fJIWnOeKGw2zZlHbp+e007eN91hQxlYNeWlNwFi5AUcQLJN/0exdIBb35IP0O2I9o4iGMWfhTrE7LspAu6matRxRdkxKHtUNKmpFBKC3YKSfy/vVFEcWZYdRCuG1XrbcfGdua1tYevwjqizrG9ddABMwz4nkzLxHbIvwoVN3W1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVKKRVzVAvhhwoxd2BKYuKX7Lfv2cmcn4YezNO+qZaE=;
 b=nOk/UQK4LZUfxlOlh0w+15RCIbqNgYUnCVkMYj+eezPPwkNcWBLetjcsk3P++Ad6xpHCIlXhrKYfiqvFZeQAivk7dNrvlNMbgCD5aL4alcVXOVc7gNFAVKscz2Qwhuh4Fe8AAD8aZi0KvM37xLM2I4PYVEYA6O03RJo9mFG7KMc=
Received: from PH1PEPF000132F6.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::3b)
 by PH8PR12MB6820.namprd12.prod.outlook.com (2603:10b6:510:1cb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 11:02:10 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2a01:111:f403:c902::13) by PH1PEPF000132F6.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Thu,
 6 Feb 2025 11:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.2 via Frontend Transport; Thu, 6 Feb 2025 11:02:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 05:02:00 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 6 Feb 2025 05:01:59 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH] amd: versal2: Enable reset and power domain drivers
Date: Thu, 6 Feb 2025 16:31:52 +0530
Message-ID: <20250206110152.1532673-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|PH8PR12MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f285aed-14f0-4b45-cef7-08dd469db3f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5KUMH6j6LcrMGqWE9dIOMlkrQ7v5FO4NUAn29kKJIdiQZoqEb6V9rBdoBdvi?=
 =?us-ascii?Q?Ne+8Qi5GZrVvoh/LbXfPRaa3wx+bEr7bWGEcCoJARgN/isN6BYAlv7oVpi/x?=
 =?us-ascii?Q?UdBV0A3jnI0dDIUP0f0kOHJO/PWzOuXC5aey/V89nu71mP1OVCrfribz5wFX?=
 =?us-ascii?Q?/QROuOX7Kupfzz9j5LRMW75Nz9ai+gs6XXXnb5GIAvtHquZoc3fpVzgo1mC7?=
 =?us-ascii?Q?cHmoxuvzozc9nDix2tkCohN0sWUGdgDBtkGufD97jQdmlFs9FLhto436rm5P?=
 =?us-ascii?Q?IX4aRfkysdWnfV99ACBg/qmY0FbCbL/Z4x/9yA8e+Ar7ibbF/LXcKxkKAjeo?=
 =?us-ascii?Q?dqWzy6icO16GmkPdv5vjG9PZiKzbM/7S84RUqMIeh2M01f4qgk0Ul58/Ft+X?=
 =?us-ascii?Q?uK7nngRYuqix3ZSoQ8rxfZr4TeVPgL0Y1Dp7FC2DbunCRTHvJZKGBPJ86C3W?=
 =?us-ascii?Q?Gp01SMhtpONEhj+L+KRLBzqArYFmziCwxc2f2gKv+4q75UrHI+DYVGa4c8Cj?=
 =?us-ascii?Q?LgwaCCFjoN1pcQPBS1hYxQNEOevOOg83wpi2KLPxVDSP/L4QXkdf2T0T1+94?=
 =?us-ascii?Q?5iBKAzQKPAZpNxn1YvZKa8vOio5GkVLCN4ZGlBkVta9fCSRfE2mWBO/996wc?=
 =?us-ascii?Q?fWfoQn/bqSrfT75hcSAwEqVtDRs8Cvzyo32elwGPV/Vr4u4FHpt7RG0URfK8?=
 =?us-ascii?Q?ff6jLBuuEfonlUpeG4+W91zN1+KHq+9T61m5WEG/rSnYb4NHNhjSnK4N/0m+?=
 =?us-ascii?Q?K/FGTQrNmHlqXgdOJV1mTw6Iu3E/7SSQqe3ZAhEZ5Spm+YzaoXAxEO7MpDtA?=
 =?us-ascii?Q?GOJCWwaeJgkyvQfSKjccdrCIaavDCpGIv1jWxl5uH5iiQ+fuRwSZBvqXmDJd?=
 =?us-ascii?Q?IbmnIiWARMlM++kTQ0BFP7+VlVFtivVc/fdNQwaeqIHuvl0DAjGkdW48OSiQ?=
 =?us-ascii?Q?KEPes3dHPCFb3uhH5xUvvMdmWEbaJLYkWfXXEywVg8YUSryDaXzSFTYnNgae?=
 =?us-ascii?Q?KLCCjCohGo05DFho9m7FDu0pr0kbKNcHd+tve6s7E1YFTiy+yvzuXJRIAaCw?=
 =?us-ascii?Q?plygVvNgKzXjpbPks7Zyy0tNhu4UAkU4wbhgV7/yEQK6iWSG/OAa3Tsw9qQW?=
 =?us-ascii?Q?p5fwpodyQijibeG9S0vNYOo4EeXDqbwuqrb01pZAOnhsfLwtn8X7T7L7p9/6?=
 =?us-ascii?Q?SfB7e4rqVUiNfjt2pQbqAguRSt/77EHG4DjqNL6JixiAnnx2dFuZguexPxDR?=
 =?us-ascii?Q?U2GWlmxgvMnfeIbyV74X68ePUCuVHt5n2r+xJR2yepgDF1i0Ql0Eg3Z9MfxI?=
 =?us-ascii?Q?6WBdI5scX6+1oS7Jsk++S9U6HIE7o8w3VOxOSbhROVv8wUscoMdAe/ZeCltI?=
 =?us-ascii?Q?NTB3IFZabpWlAXR7ZHLdL/vWUVPNj1jnOH7kZRc57rtaaQq/zpkNmAI+agKP?=
 =?us-ascii?Q?rGe8PAhAC91P2WMncoXYG3oZwxCOwwHFBDwE8xMqqqGb+8UEoO8HfO2iSrRE?=
 =?us-ascii?Q?lIyZtlPpXVDzdhU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 11:02:09.7513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f285aed-14f0-4b45-cef7-08dd469db3f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6820
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

Enable power domain driver to request node for all the IP's that are
enabled in DT. Add CONFIG_RESET_ZYNQMP config in versal2 default
configuration to enable support for reset driver for versal2
platform.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/amd_versal2_virt_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index b4aebf3e9fb..b907ed02615 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -115,7 +115,9 @@ CONFIG_PHY_GIGE=y
 CONFIG_XILINX_AXIEMAC=y
 CONFIG_ZYNQ_GEM=y
 CONFIG_POWER_DOMAIN=y
+CONFIG_ZYNQMP_POWER_DOMAIN=y
 CONFIG_RESET_SCMI=y
+CONFIG_RESET_ZYNQMP=y
 CONFIG_SCSI=y
 CONFIG_DEBUG_UART_PL011=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
-- 
2.25.1

