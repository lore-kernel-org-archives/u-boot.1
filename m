Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9C0C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 07:55:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C468988195;
	Mon, 15 Apr 2024 09:55:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WLH9pPLe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAC3888195; Mon, 15 Apr 2024 09:55:48 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94F8D88134
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 09:55:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2iBe7L6bAKaEfBWQRgJ+PVhHUvFaQg9DamMsK8LMIyAZkD2+caJecudXmKnIz0s9xGEdwk4FmuroGcCgKKnD3Yo1evmkD/ZRxWdG1Ije08H8+rSE3w4+Nx1iaUf8Rn1EUJcmI82img+g3b2jLCy5RS/xxAJaUrO6zBBNlFYfHieA11qdLrFjgJNtpjfGd7giYJ+YIemYlWfgx/0P8CJESNwOIhFVN/ol/XI+0b85ZGycJ6XDQrhjvgF/CmdAF8EgEG8EftijLIZzK69+Ec3a6VrM19baPELTXcU/o3nP0Y0yeE3sB3VBbuYSsf/R7oca1FxfBlgZer+aOTJaKvJRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+z7QOys3YI4jnhiOmIYLuxtaMLs7ZWdcXRqAF86Zaw=;
 b=kI90YPrjAvJyW0k4FGT0j138G5gqiF8AtRIvHyj8bqcHCKracB2U50eRCJzH5PTToxZuguFWB+Zm4y1wS3af7LYzyIkFZnWxURaCZ6Sc3x6onrCU8SuALvn5283n3Gf1uqtQ/NceS4BPFA+L3gENi6C41yh8je4gGbALiHL+iXwsrp9jXrJmjICnBji4+c3oqG26x/dnE19L2uJ7HwAlStHpMl6+7btsPJQbw//qjyVrLlmA2S88pBNZ2vnZu1MtSPbNdmaWI5UrJV2w5gcfmkS8Txioj1o4gaha5w93imqwG5UDskMqnGV4iPpqSAP5dUz55nO7yhghfd9eSHY1XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+z7QOys3YI4jnhiOmIYLuxtaMLs7ZWdcXRqAF86Zaw=;
 b=WLH9pPLeYY/vp4WPHNjRIYTey7SYmE4ZUi91TSV7BziRJoYNHv9BByjQ7zsZViEesIflHqgD+j4xiUVY9KCHse78I0SKcbEMsemxkqW3biwQ61ZUDaejJUNM7vj7xpnhg1cpvYz+PNDD9K8yq6kovgTvR4FzXZxS94y4tRKue0k=
Received: from BYAPR07CA0092.namprd07.prod.outlook.com (2603:10b6:a03:12b::33)
 by SA3PR12MB7829.namprd12.prod.outlook.com (2603:10b6:806:316::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 07:55:43 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:12b:cafe::23) by BYAPR07CA0092.outlook.office365.com
 (2603:10b6:a03:12b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 07:55:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 07:55:42 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 15 Apr
 2024 02:55:40 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: zynqmp: Clean up xilinx_zynqmp.h
Date: Mon, 15 Apr 2024 09:55:33 +0200
Message-ID: <fa117ac482591d3d5957af54fe99e6acc89972e3.1713167731.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=931; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=u+0+aCC3iv1sF/4dih/l74yavhTEG/sDVDEpJ4Wf734=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjSZu2X7gjUm/inWnbr46VJZb2cxHr+ypU/uNvHtdJ12Q
 ZmnQPJWRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZhIaCbDXAnmeVZ7SnXLS+Sk
 PDd8kfEL27o3h2Gu4ISLD0RtT0ubpP0IzF8QcNxQx3EqAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|SA3PR12MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 4560681e-1b1e-4bce-481d-08dc5d217328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m8E3tDCacRe7k8HWWR4rPAqqAWol28IVPefbmfOSqEgKXd8XN/3/TxNeF18/9ik6RSaGtL+VuQLSlRWz06NV8kaWNDNU5nQwKrWcMTpuDRUYcuQkUVS+LKPEKL26mJu7zwS76B5glekTIbOnm9yQCNBe1SHJTKCPJnClW2+foGMh+715dcyllcyelk4g8VTXwZCEL/3TffuwCXN3VFbse/NnWpUKwUGY5MqL08jh8APTwJ7dTn3qdkozOXou/UZgkxZYm5GYD3YFkwLujV2N3ON5YMh9P3piTsrsZlLS0iHiNpyGALA20kaBytCNpSAwNmSTc3hgfGBuP8yUvGgLFz5qD0SGw5arDM1ohdUHAvwY19/Q2NGLfOpCJYVPuOTC0GtB0+v+zvBmONMhDO8ijI46DRXbBRiJbhpFuG47Dih1DOFP7rlUAj0YQRannhqCs60vm4ozbQePvhz4XFbPcvwLy83ncjjgwz6iVy7E0wIRmmveaQOQ6M4RMRB1OjkGDMdyXk5lyfYiX0yP6oNfgu3NbH3WdblJF2YgN1G4HHaSEhWbyYcs4eaN0eePI6ogq030A8YcKpNWLO5+u4q8Bu4G3/oWbf1UHZKzvUHmtcLrBwlBiB9lJ7K7wZznNtgk3WdOab4iO12fCumz0PoR2/AdLPFDIxWWxNXT8JkqvBoicgPDuRiHOThOHr1voUbVwtywz6mz2HiAvWV0Jb/lzbph7b5UBEc5fJ/MjaWU9B610+lN4LlG1xM27etYVdz7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 07:55:42.5841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4560681e-1b1e-4bce-481d-08dc5d217328
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7829
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

Options are moving to Kconfig by running sed and comments are staying in
that's why do clean up and remove useless comments.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 include/configs/xilinx_zynqmp.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/configs/xilinx_zynqmp.h b/include/configs/xilinx_zynqmp.h
index 5bc117e19000..c5cbb76645ef 100644
--- a/include/configs/xilinx_zynqmp.h
+++ b/include/configs/xilinx_zynqmp.h
@@ -42,8 +42,6 @@
 # define PARTS_DEFAULT
 #endif
 
-/* Console I/O Buffer Size */
-
 /* Ethernet driver */
 #if defined(CONFIG_ZYNQ_GEM)
 # define PHY_ANEG_TIMEOUT       20000
@@ -204,10 +202,6 @@
 # define CFG_SYS_SPI_ARGS_SIZE	0xa0000
 #endif
 
-/* u-boot is like dtb */
-
-/* ATF is my kernel image */
-
 #ifdef CONFIG_SPL_SYS_MALLOC_SIMPLE
 # error "Disable CONFIG_SPL_SYS_MALLOC_SIMPLE. Full malloc needs to be used"
 #endif
-- 
2.44.0

