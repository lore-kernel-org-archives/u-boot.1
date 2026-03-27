Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D80210ED66F
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 12:54:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF56B83FE9;
	Fri, 27 Mar 2026 13:54:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eRVeRvJq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 124BF8394E; Fri, 27 Mar 2026 13:54:05 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EC0B81E18
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 13:54:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXLl/pvipVhHkIuQpO9cFBc5GamqMiqWulZL4p4NoVlAM9nqUVhKkXMoigzAULd67rv+GiG/4f0cD/zH6B64gEmjI1eI/+FNopqEQ53cXLQ7Q7938olzKX0d/zdDXizHkMtTwrlXHSw5MgQlMqMtGIpG9wEtMvvG75e8R/zqEpSEgwQwDhPvgsaH7iwxesv3Fq5QZ1P8SPU2MnW+ILr9R6tXiP3UHbwm21UUuQC11Wo+emqdAqBwHawjjfS4rEeDTqiysl7tyhlvNgbiyBiKPgTI7vy1kVb32Dr4rDREYqAplcEMxreze4kyDR7fV5J8LX+GvhgtzCG1XaHyWurRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+y9bCewZECNBdfqBiHDyyQPFRgunNZPt/DSnKmweI0=;
 b=NgkdyEDM0pB7eK6ASHlkyGpOtX70jZHLilhSvxTm0u9EgsxzHGNsvlgXHOcVOYPZl84FwuGxiFAFOAPBaW81s4q422cfo8JId0kQ6fw2Y9StOHtdVwlTjSQw3zASDlHV/8Ia9FL2tThOm9XccWpB6ekDgHx5d6o6Tz55AjhZIKjTm4enAoIX5kLYKnmsaU0kJja7P7sdHxfIgEOn0doZtos6vbn6G1+owSop4k+hgr4AZOEyB/XeG3RvmkLhkXs10K93SWlJnSBxfyiUnlON9iYYq4LrD0zp63w4idperZv95rYLcTPewea+dTWhpaKiIw4W9GqvubOraLBQdojBCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+y9bCewZECNBdfqBiHDyyQPFRgunNZPt/DSnKmweI0=;
 b=eRVeRvJqgAzJpu5mqiCCOrJhSCJxb0iWtgXYsrw2QsouJGMY9WCc6DbGDV//mNmicAFRzWJ767M/BIaU+ykIEfcW/4KUtLiy4/vjqZct4JQbE1u0R4YYoWOsq0NH/Tq4F7INDg2OYIx8PSJQPQtVyjwEv3pra37AMcZe8672LR4=
Received: from BY5PR17CA0041.namprd17.prod.outlook.com (2603:10b6:a03:167::18)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 12:53:56 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:167:cafe::9d) by BY5PR17CA0041.outlook.office365.com
 (2603:10b6:a03:167::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Fri,
 27 Mar 2026 12:53:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 12:53:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 27 Mar
 2026 07:53:54 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Mar
 2026 07:53:52 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 27 Mar 2026 07:53:51 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/4] configs: amd: Enable Versal Gen 2 TPM2 driver
Date: Fri, 27 Mar 2026 18:22:58 +0530
Message-ID: <20260327125318.1037146-5-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260327125318.1037146-1-padmarao.begari@amd.com>
References: <20260327125318.1037146-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|CH3PR12MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e47ad15-bebc-4ecd-3bb5-08de8bffe843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: aaO6wOueKY9FkxZCgM9cSJjCjo8kXQtVAcyjrH/cJNbWNH7hh3z5D357ltqrYJ2HQp2IzLkYy/WBNbAuCy1+CEFxzZVdnejf7gyuXprBhE3U9GvaOtW4qXefWrXRN0lCNXD7+UYOMBbqRB0xwO66be+TrTk/3PCl6HobSXmAbrgldZLQeRmBEzymDubqzn8ggr9B3YwWf+/korNcTYQaurUEIEP+ClRkp7gduTfoYTvPT6vaGkDgP0foIidI2tP3khAai7sEQM3XVTnShIJrnkVR5BNsFAi6qKsKB+4Z+qMoIVBewv8//HUos9kSBKTQCuovYF+p5WQZqTo0Fp9r5sVJVFeKbw9vqhMOo+QmEwwJnkllhVa2pU3gUap47TsySIonhLkejz23ihkLQzgJJTbMw80E0aT1SQy0cIKxjc1bD96/zFgaPWD7bwTij87C4+OzghHYUcInefDKNfsWluo+J1ZlEPGxS8IX7cjUPhFw0o3kV2D3pi3ZzXjnR7P+L1vQ+eBCJ3il7s/ZRCx2js1FdgxJ5jp9t2oz1DZRj6v6wdD4lrRQ7GEMik/itcCXo2ptbqLsA0TJpqSWQE68qzweuQNqxwSVXD61DBw6S7p8MG5F6VBmO2VKeJCx+tgZLrdhXMmr4k3f3No6CKTDk1e4q6LxnRQX83lG4iZ8vO0gwR3w2bBtRiuuZ807fdgoHJ83Gj/jgIi+lkSUbvQ9xGvIhEsJt8sbIMvmzM0F/YpimUzzgmm8uViIi0qeiXprg4NwPsYmQNyGlBfVuh6VGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wWTbpk/Bpp0qvEQftkT/3oym1k+EqKLdletFWVf0An2TjxoCH9TokgNMqYQ5wo7DXAzXx6cInb7KtwGaNNbSja1gQ1lu73E8x4K7jbkgG/ZClUpjCNUJejzAjUmGPaS5g0tKxAcxkf+g1gKv5QEjMICN3nwmd5xc0uekWsAioys1dkKGpz1phYaZjR21bnhbZdpT3bq2cREGcN9gTLm4Rc7dfoae0iwtp2yliGe1CLPMgW37DeF8IIuPTiUwF6S+yl1MRqmIUAVJk8UnL382xzsnt4UIQ/md1j/CbnxH8QXsb2TVHr7p7x7JhmN+yz+PCCXWI9zZplQaFtHR7WhZnfpTsU1h7WmHniaHZkDz39gDcAb3FAowsPYWAjut3RejXo6dOr1LCqp44VgiA0Uob1j/q8ueMb1yQAI5WONl2QSp6Oq08XqB4dQgjCRswHG8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 12:53:56.1489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e47ad15-bebc-4ecd-3bb5-08de8bffe843
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912
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

Enable CONFIG_TPM2_VERSAL2_SMC to activate the AMD Versal Gen 2 TPM2
driver that exposes PLM XilOCP HW PCRs via TF-A SMC.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 configs/amd_versal2_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 0344089030c..ea49f748ebe 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -144,6 +144,7 @@ CONFIG_SYSRESET_PSCI=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
 CONFIG_TPM2_TIS_SPI=y
+CONFIG_TPM2_VERSAL2_SMC=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
-- 
2.34.1

