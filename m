Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C711076372
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 06:10:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B16284073;
	Wed,  1 Apr 2026 08:10:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ekv7XppI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74D8A8407B; Wed,  1 Apr 2026 08:10:33 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 382AC83F5B
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 08:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lu69NZkOlG4r9IWEpQwQuwAXFNfo617m3Z0gcfJEQ2PFgGm8bJj0iER7Tf3Z8nHMKqH1wTG9XIKqCM77PvaB9P0lV5dumihCfeSzRxdhzdOOqGlusCPbHCG3DKsZOFPfsHNQoutmJc7U3eM0Ox9T40yo1zDq+TNdH2Xx96lB+UMtno/OvNc7aY2Y4JO+WxJsGY/khvaDFsAnHqX+VkWpNMRQPvDysIcpLAar/3p9hZgc3dt1Y/xMuQOYZH5PaPrhcC7ePukr/GPgZ4ilrtEPWmY68AzKDEkZLwt70Nl95YFCGmwm2LPRhCLcfC07ZYVB8Z+rD1FTigT0X115R60A2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBudDjv/2o9kkR7s8fNhZZXkInb++iJnfeG7enhxeBo=;
 b=BwYAqtDkd8wM2KUQ8vR2FEU05hsgX/orqW+NcYeJqro7lX+VLMpOn7RbvcXGq7XMY+EAAEgG/QICKRfRdQSfJ9bBagsFV2ED5juY55pVL6LTPcLHKNl5SMKrgk63vMYpMgmJK5iXgPdl33kO2ZbUvHWfnVW5MYZ6uwz2mwe2xudV43Ae/DvEg00OY3fzGnFhYowq/OcY3sIU4m2xgmPJR0t6bUUJVT5bRbvhibnb5E+aUYOfvJs6Dctwhkf+uFjumpnbbupZJxPVkPzsQeXKGl4TCmJkC2dAwvZW+eI0jZx8iR1P4jdPBgTl6mtoqN4htzNpzAxGK5T5XltvUbX1oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBudDjv/2o9kkR7s8fNhZZXkInb++iJnfeG7enhxeBo=;
 b=Ekv7XppI6iqYzs//n8/CQY6UfghomE4YWXi3gHY/UEan9+Yeg05307WKEoieUBhEurICiFDoZYM6PRmEAR7Q6a2MDffB8UHaN6l8UOHMq0usBUkeDVaSdHAObFbVnI9bo9kDQGjqAIqzeZeIfCovfMwj5GOuj0kYu/viD6JOwwo=
Received: from BL1PR13CA0025.namprd13.prod.outlook.com (2603:10b6:208:256::30)
 by BL3PR12MB6643.namprd12.prod.outlook.com (2603:10b6:208:38f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 06:10:25 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:208:256:cafe::64) by BL1PR13CA0025.outlook.office365.com
 (2603:10b6:208:256::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.15 via Frontend Transport; Wed,
 1 Apr 2026 06:10:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 06:10:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 1 Apr
 2026 01:10:22 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 1 Apr
 2026 01:10:20 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 1 Apr 2026 01:10:19 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>, Daniel Schwierzeck
 <daniel.schwierzeck@gmail.com>, =?UTF-8?q?Duje=20Mihanovi=C4=87?=
 <duje@dujemihanovic.xyz>, Heiko Schocher <hs@nabladev.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, "Linus
 Walleij" <linusw@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Stefano Babic <sbabic@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Subject: [PATCH] .mailmap: Fix Jerome's entry
Date: Wed, 1 Apr 2026 08:10:15 +0200
Message-ID: <32f53e6008a389884ee406ebba1a206e73ac29af.1775023814.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=vZ35mX0023+bkasKiwKtVW7cEmdgBxvKRPMVxsSeqk8=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSe2XZSwm1Smvg0Ti1zncPh//UTBMxuG8eyHrTV5LrJ/
 m9al6dBRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAEzkeDTDf592r5chqYbyk1d5
 /lL90tHqfIVVMXb5Y+PTYe6HPx2qmcPwm6Vwr8+HAgvFuvSSPoknMmn/Iw9mdfYeKC1hn7rNd/Y
 GBgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|BL3PR12MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b19650-142d-4275-c880-08de8fb55d5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|7416014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: DgKaVBkmqLq9ITXFIDSpCUnPQXowTbXfh8zQVHZ12rVI+ve2dEPNy0FdgJxSiBAdDa1BYlShbaIZ9K/k7ZJEKLrdq9utW4TUUfvI/C5ZT8VR+cb/k96sUObq5xXTsA22TgV3fJlq9trYvkwQxnLITv6NL+YWmo+algegqBJUwrVemaVbJKIiQx/pjVaMHMoLNOLl09nbDesID3XXecrrd8fAeqDn8XeIJpDy2ubAEs5ZtXJ8tmuCxyb6UxySMIACXaHj91kAv+fejDvYGpLWuKcsLSHKytipgqdgG9YdzoCJFbgU4sU3sC3APmLyRqld3iJ/YECpqjZsG1SEojVgG61KZAb02F7Z4qNTGOqwJSKiHAW0Gxrk+Y3TgS4ihAJ5Fk8CI8WwidvUxnKSomEaWS+82AEayCDNiCg4DqnNZerg9MAEmMf6Sg8SLnO/zEZVYwGC4zf4B6ts02UptsYspN72b9wAv4uYJc/dpQi5Dlx1MiTjaBz41ABpkrcbN6G0fyLWhwHS9lSCambSkY1mYJs4bjJJKqtIskKKC/HvdBBz/fhgHNweNOd7gP6GvaZAY9JOlznxXKEHrICuOrnmwFV7XU39eBxD+qUz03ipP9uPIW20QiGdHibs/3RrNLZXBtr42rKIP2vmQzDpTVBDNu/bLWEWIXMWkGHHk0JYI9sX7+tAfKfi2eoUzA+9ISHoDLG0IErAb6ADmrj/+zYiYkmEB0OZy/94o/qcVmAWva8ErtMOOuh2gOFH9wWnHTFUTMkahJD7jn4TZprJCgsZpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(7416014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: StO6w9Gwnb4a9ZHP1whH/DLZUBFHXXmaT5xelCeU62DUuIqXT9ikdy82Mof3VLH/2WfBcvd+yyieSV2ICcd/zPG4eYr0ha+YDDtlY8psJAKx2zOV2CL//aw8o0pYrKYMjns2yXzTU0BZsU3s+maDuDQtnlATd66GgsmH5kojAkvwdXXTDGWX5t1Tzea8CUAoEaQSskCbEGj3m/0EtkZiwBrK+5A836XgH+ql2VlOvwg/nhks8o1FmP9pEB43CCEQoNPidGunKEUG0IhdD8zpJxV7Ay8/m2b3QJSz37KZnJ0Sff4XJ3NF/Qe7U8fYdPxY2ESfwt9/QLJcyd1ItguxC2y0QAULdSiOqlnzGmVO8voBwkYk83f4jSyB22bFHRa+C8eL21DYmMh2EWoaTTR75QILPFGnv9OXZmC2D4Up9C78cSmvT+NJw/eGtBKKtFHn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 06:10:25.1194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b19650-142d-4275-c880-08de8fb55d5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6643
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

When patman is used email address is composed together with both email
address from .mailmal file. Having two commit emails is not proper format.

Error:
error: unable to extract a valid address from: Jerome Forissier
<jerome.forissier@arm.comjerome@forissier.org>

Fixes: f2566c3a71a5 ("MAINTAINERS: update my email address")
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .mailmap | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 31d4970fff77..6ac4b9b9e5ef 100644
--- a/.mailmap
+++ b/.mailmap
@@ -69,7 +69,8 @@ Jagan Teki <jagannadha.sutradharudu-teki@xilinx.com>
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de> <jakob.unterwurzacher@theobroma-systems.com>
 Jay Buddhabhatti <jay.buddhabhatti@amd.com> <jay.buddhabhatti@xilinx.com>
 Jernej Skrabec <jernej.skrabec@gmail.com> <jernej.skrabec@siol.net>
-Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org> <jerome.forissier@linaro.org>
+Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org>
+Jerome Forissier <jerome.forissier@arm.com> <jerome.forissier@linaro.org>
 John Linn <john.linn@amd.com> <john.linn@xilinx.com>
 Jyotheeswar Reddy Mutthareddyvari <jyotheeswar.reddy.mutthareddyvari@amd.com> <jyothee@xilinx.com>
 Jyotheeswar Reddy Mutthareddyvari <jyotheeswar.reddy.mutthareddyvari@amd.com> <jyotheeswar.reddy.mutthareddyvari@xilinx.com>
-- 
2.43.0

base-commit: 7fec12cfc852b25785577b4871b11d5629a14a8e
branch: debian-sent3
