Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6517DC5AD55
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 11:37:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72D4B606EB;
	Mon, 10 Aug 2026 11:37:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W_Udax2ha9Bx; Mon, 10 Aug 2026 11:37:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6373A6069D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786361840;
	bh=UcsTHOImWYISbHZ8p1/12CIXohnXW6yNHBqU1iodF8Q=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=URHPE1XCkSBPh/UxBpycisHBKN0aPk4FiscaJ5vZyETDNRBMLQ7Jm1xNMOHdbSxJ9
	 tzIcK2fskyBgLClqEoGJhfe3hT/viZepCEVhBpAHpwJeKDK0ron6ponUgK/jYexepg
	 a4RKkzC5+45LFwF818njGHVovYp5dOhyex4U2WhWB1SmLlkLX2FtbRgiU9Yi4iiNdh
	 hXd/NEbxxgm2d+UF6E5V3fvTYszlZf7B9D+KT3wZKt+/4IWJ4FB6fEuYnKNn54BV/C
	 qY3iFknFliSKyNL5ZsVL8qWB4sl+ehT1p/qhg+GsxvSn9NuxJIu3GFZO+KQqQ4riql
	 /NNTZQ7JfsQEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6373A6069D;
	Mon, 10 Aug 2026 11:37:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 22AAA10E
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 11:37:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 08B7D80D66
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 11:37:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oGY-fySn4Dbt for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 11:37:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A256A80D5B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A256A80D5B
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A256A80D5B
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 11:37:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=komndmB+w9oXEorN8fAovBiOb54/aqpa9sj/m8X8WSLYJQ7Zggqe/2SQ04ebLCHFK6065uonTltHu55/h2lKI9ai8tgR9VNr/QxgRD0PIOKb9TbCRWT0beDRJexGDgIwJL3mCEeTe4HHHWNjXRTAM8rd0BVj14pBK5R0JRUpFJl7tNj8dg6Yzrch4ysyXtgoKJ0VUQibzqbo09tIrM0mPT4SK0GetJ4KcyA+MMMup3cVGQkuIeqbEukcVoBdnS4x8sWZjQjIf6ovSyH5Ak5GFT3ZkwSGmqm/4QXXf/rjkimKG9vT/Jo+iu/AHDxUzZKMJaNPEnymqCj1bToEkHzxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcsTHOImWYISbHZ8p1/12CIXohnXW6yNHBqU1iodF8Q=;
 b=ZMG+aU/ckRayV4CYMwPup6hOyQwnz225yrX7qTJlVtpFJAcZy/uSdSn+FRIRnKhSlqL+2Js0S8635y6LEoAGYUcxp7VuTCOG8H/E8MAVvplu3bFK6Lb7P76U1vEyPmpv2lJskhE4tZVpsMyY21btTzApN/cv0sllERe9GU+64Xk7Do4mT4hseCUzVOZtE/GpdKlIvLL6UpcXlZuNGJEbCURRcaZt99zxHG9DTpVI19x8Ps0Ts4aj+7xAtRgqRX9erA4UKuduo5RcvYOLf9lMY0cP/SH+uhQjj07ud83eF1j7iTp3+9hRcX+HkeBh+1os/dhJwSFnDm2a1Zwws19GKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from BY5PR03CA0028.namprd03.prod.outlook.com (2603:10b6:a03:1e0::38)
 by DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 11:37:11 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::15) by BY5PR03CA0028.outlook.office365.com
 (2603:10b6:a03:1e0::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 11:37:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 11:37:10 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 06:37:08 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 10 Aug 2026 06:37:08 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] MAINTAINERS: Add missing fragment for Versal Gen 2
Date: Mon, 10 Aug 2026 13:37:01 +0200
Message-ID: <11956eca5ebd0b3626b7e2d0fa52331cbd3dc1ec.1786361819.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=807; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=upQp7/GuehzTcESYqXeHxHS5Oe2kIc2mzaUqr0ayYPU=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRVbr+nbC1/4fH2GZu7T5oZ8p3YLqkmyCvmVvPvmPfKW
 ZtrU5+97yhlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJ6NQy/A8vSd8hILdGwXu/
 5Rn1V58nSZ/qmdx45v19vjj+E+YVkzcxMtwp47/r+8fFge9sHI/hjushsxVnhn2Mv2nwf8Gk9Cn
 9xfwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|DS0PR12MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ddec47-cd1a-4993-6ad7-08def6d3b72d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: SlXF01Va1YGrtlJB1l75NnUWsK+ctSRGk8WVoaXstuL6Pr1TS44FYKft8nISu97OuFz3QOsnlM4Muun/pHxlLA29POPfx5yLf4LR3lqX54D5P6+8AYwj8bvwC5ZKAWEwdavKjIrboqVbigG1sKeEguInqWT3nPzI0WzDyhizA6nUPbPB8CUHKsAgQw09ZtLUmJPMhP1lJFGGlvqZE8sXBftIYQiKqKmqVhamXXTbv+mOOEldyhIj4qyxlgTBvWCjy0c9RDXsTSwR26AIpZBuev2GXH7Sofdhcu9xzLhYYhgDgjxkCH2lYrqFMYWPXbYB5EgAFFTy+i3FDJqjY1y2EOQ4ACtkiLewr1ZO3874xnaLjLAJVfse6FCAqYiO8HwMV2dSRMcxUAcXl9uD2dzWVb+WxAbN4rVXRn4VxhKfPN+ogMkGThxQlj1EH9sSqShtS9rPeZVCjk84O4lUaXVBdaNqAXkljTueEPEJv0TEuQ39ZqQclGcIS9AIs8SwT0+mKQ491dyNVNNc7DPOrxDGC2PfzXkPSFnBMiGbS7UzuRnKAJpPKCwGAFzco7jIT0zck6inIu5zeMql1+wVLakTkNc1LNOaWaD+D5RijHkjQ+H5R6J3hXjQ3OO+Zh0c12d2bCPKkdE/GYKZIJaqC74Brw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S07aCRWYK567EhgxJVdhfY7P8KPrjVqR3U4lq893Llm0phDsfsUbZSyoZVq1ImsRW8/wahxiLLwXBqcO0qy5EyGDi2MbzTwQ511WmnC8gNvjj+cW1Xdee1taO4lR3dGUZfSf7VNqliPUwVxvE7YdzgZbpGYfdn00snfpTvj1kQ0VuVQxIBa1WOwjm7zG0K2+Ymp5SZm8w/aZLvyJEyzuzPhmzlR4fxVqL5ppiFzPzAOQefKHq7Xs7tEkbSy5pW4olrJ+fwqxj+/R2ZwgcdNDerlB6XX9/I6V8tg/dtBlkZw7G4Ep60vlWT+WqFXxK8Q03bF1GQ2yB9S3MThehBFBZAzhGBay/TuOKbz/H1Q9BjvxZkfaLa1gA5jS3YwE1nVONfv/2yqF7vAPJZF/EMKiuko81/UP8PagexrR3g+MFpkt4xEdtGXPxghNUtGIOR72
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 11:37:10.3550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ddec47-cd1a-4993-6ad7-08def6d3b72d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcsTHOImWYISbHZ8p1/12CIXohnXW6yNHBqU1iodF8Q=;
 b=LjtIUJfTUDYYyx3aKL93R2grkJzoB3JvZzXz9UA6rVqoE2XUCa8gMG1xDJLX2lGTnh+uJT8vLvIb0DMNZPsfT2Q2Jt+rrlnYgspF2NBE2qZNnqfrWr3YTiigTZfeWpanqW2IoVBZ4exL04iXNcm1fk7KXZwL+GyRm1uJWIJoG5Y=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=LjtIUJfT
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Versal Gen 2 and especially march-versal2 is not covered by own fragment
that's why add it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e1379a6a3e7e..eb48eea55c5a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -821,6 +821,12 @@ F:	drivers/spi/cadence_ospi_versal.c
 F:	drivers/watchdog/xilinx_wwdt.c
 N:	(?<!uni)versal
 
+ARM VERSAL GEN 2
+M:	Michal Simek <michal.simek@amd.com>
+S:	Maintained
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
+F:	arch/arm/mach-versal2/
+
 ARM VERSATILE EXPRESS DRIVERS
 M:	Liviu Dudau <liviu.dudau@foss.arm.com>
 S:	Maintained
---
base-commit: 4b12b2532a904fcf1c5ed9a7b323f39717ee92e4

-- 
2.43.0

