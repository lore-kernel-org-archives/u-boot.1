Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D94FC5913
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 09:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6530583C54;
	Thu, 26 Feb 2026 10:28:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JPynsObd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6037D83E63; Thu, 26 Feb 2026 10:28:13 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4479583AA9
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 10:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eq2kAqFz/l3Q/Vxi2dpSJvsr4xgyIVTPJMzirRmW7ygOVTY5SVliRYugYsh6xDyLNfOu3sRZhrpRkE5zgW+aMm4soKVy4IGmTs9+gi3u0AET3mEEYu5i1vjJkYVtJW7MOy9tO2wVdJb5RfMUXSVwvTpVqG9c3w+yrfoAApN+yCtpTEn0qljvZrQfxPBneLUB2c0w6IGrN2HgHu5Jdk7uls8zDfToY28LCnGu2r0PzBY1kPRXgb3GClnTN1MtYDTv4hWoh62EJ0EfPWzjJbkcygSN1RewKXtRJxFLWdfIlqH3pdThgB7WP0P+PL2vREFaGErSOxniKFCPbQ6MADhOFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIAnn+n+myw8Qff168KzoPmwygpfuHzqB9BD8MDQr0s=;
 b=oJOQyH70u7Ihvn+XzZ5XJXQ5/u/GxMTa+MSzjSNpbPc2gS5MiNPJYCOtbWldy9xAHijdz+9W2Fto7/+CyRI5v3j44uqqI3q9zbNnV8i7WtbgOnDHNg5PTPbQ3PaM7JwP1e6MerYjM0pc/h6L7ckcbpMGidxg0PBvKd/XZeszsN54BLXUI8p4ffdKdeWesRWtid5Et4SujOl+PcFTRacIJMz8K1gKe3RjDudcEqaxxxf0uTZ3yc06K0Z0UMTcCrBE7KYfQwE4uB+yUBl4wqeg2EN81qz2Ah1bTsiP/m2v94DizQupK2zpdpwNnwpLf3o12GXJIzVkS5TUmO1g1LtYWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIAnn+n+myw8Qff168KzoPmwygpfuHzqB9BD8MDQr0s=;
 b=JPynsObdDxNEANqwpYKcdjDHS9jqxPSgNHR3yf7F++AMH1YwIfWPXHXNxMQS/95GtOKD7eHmPoAj8Zp31fiChTYQ25HH59lrLhkceh/GXYRmAoGmItqmjDnndR/f5mc3QEUutU/AH4AF47L62YQ4E0Y4WH5F6KjNE0niOrVOvjc=
Received: from BN9PR03CA0420.namprd03.prod.outlook.com (2603:10b6:408:111::35)
 by LV8PR12MB9270.namprd12.prod.outlook.com (2603:10b6:408:205::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Thu, 26 Feb
 2026 09:28:07 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:111:cafe::5c) by BN9PR03CA0420.outlook.office365.com
 (2603:10b6:408:111::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 09:28:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 09:28:07 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Feb
 2026 03:28:05 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Feb
 2026 01:28:04 -0800
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 26 Feb 2026 03:28:04 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Prasad Kummari
 <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: versal2: Enable GIC600 support
Date: Thu, 26 Feb 2026 10:28:01 +0100
Message-ID: <e3135eee33282281572fbc960aa45b5d0f355158.1772098079.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=731; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=nYSIKzoEBe+k3kcnKI/pUyhGqy0aKcPBe8kBAFGiQ7I=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQuEFIS58rgcnJ90WD3Nft7nHrunY9/16/MvJqy6Jigu
 3+Ygp5iRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAEzkWRvDP02rSWtqqxhWhSrN
 0MqRvlZi7Sjz9MSWb+3H321hVzKQ0mFk2LvzQy/3yZDynhO31sq0LeqWVTvDZCM3v5ZD755Jlfl
 kfgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|LV8PR12MB9270:EE_
X-MS-Office365-Filtering-Correlation-Id: a5bb4d3f-4856-4ef4-5348-08de751959a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: CVORcUGCaLKih5wg4rtBGguMJipTic9WJNZoi5XIzt1bLT4A7tM/owXYrTl53UUvv8Jv8Ef1RBE0TY2yI6JDfrpqFFNwkRPmnMWIpwW6/5bCoqb12Mo2Gox7AF1B8CACp4kL+32bnlyiFQWz1O7MA2A2sWyWJ+hkblhHqu6YkiBij+4jCB8HTutxLBHmnBFXIChVWmSEQ0g+ge+cba4zVAoIUWcRD7SPA5GUpY3YvSjojyiyz9IKs/EFsoOVwahK9ZWjCmmpXjWahvJQhEfDVFzMBgyArkBGb0N0DUYlo1e0W5KGfOoUBADJRCEbmuHVxXWTc20gRbsHi9qRrmeBu1oAJ9iCsbv6fmvPDZOp/1l4h1sSDWDbDvzSNFFdR3GthqnQYqUS6NyKRgvPz17QknWIVN1sQt52Q4xR43Z//+nsB6T+dQdATPCH/aKKdzc9ptyJCIYfAL/ZQmOXQu74sLlmrxt3F5qUHHlvUtf0aJ5eavue62mIfw5d5KQxfkeY66EztnV6D7UOCgOrtbgcvNtJ/pCgykUxK6mpHQkAItcgjDOV1heWf08eFPoNOJOFui0jq8uzBNrN4W4bfngBXK0v0+MAHVQFkGXDnADKfSO2N7vqIgHLm0tHjFCNyRMwVayvrDtDRIHWvXbr5JGgT/U9RVdUysyF8KO8fzFMm2qwN3oTMXhIPUtsZ27q1aIr5JOkFkvMxxaF4SHcnhwlsnFtgxqBBZsLJ9YI2kGvNOulk6D0CS7+UCRKPz51azUth8aKy6jR0cOZSk0lA8XfUO646f9jxoYoI0wjFxqnodzvCasTpN4YjUeQpgMFiUzTL+idFq4+uGpDMttACokbJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Wcvpzff2ppn3lBTqm5WKfsQLdh76YhqhTFAPaRrdxVRZA2vN8X49ez3RueoDXV71k629Yo+0AyYTNc76hc8niCEkDbtOyL8X1vMbwIGOA7Apji87Z3bqYfFCyzAH8erP6gzahqWJZ4dEJf4eCYsxcCavvMqDQ9OsSe146ILN2JboZHdPWdYHPhMbPzG61GQlViAdBIgeiBQdzt4OEnz9jMX9uSjXV0mgYFr/PQ4MlVY4OaRSGYq+yFhixS/G+vvbqW/v5uq89DUQzND3/yDmczbvSBKTUcavoQS/1BnYAHsE0XTtV7mQjZI6byOaesVC8KtRQ1OSbyk9ZePAsdU5zPxOYP8h77moQIvm9gtP5rMfuladkuJDNNseWheYVtMegWw6Rxa2wTncLfWh3AocG8/Pv7/hOocVScVUVc22Y7V0jW777TxlkOeo+kez2KI0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 09:28:07.1311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5bb4d3f-4856-4ef4-5348-08de751959a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9270
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

From: Padmarao Begari <padmarao.begari@amd.com>

Add and enable the GIC600 support configuration by default for
Versal Gen 2.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-versal2/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-versal2/Kconfig b/arch/arm/mach-versal2/Kconfig
index 2a595151d6fa..d1d8cbb815f6 100644
--- a/arch/arm/mach-versal2/Kconfig
+++ b/arch/arm/mach-versal2/Kconfig
@@ -43,6 +43,9 @@ config SYS_MEM_RSVD_FOR_MMU
 config GICV3
 	def_bool y
 
+config GICV3_SUPPORT_GIC600
+	def_bool y
+
 config SYS_MALLOC_LEN
 	default 0x2000000
 
-- 
2.43.0

base-commit: da5461e758daf9c39c59b644e9abbe49e746229c
branch: debian-sent3
