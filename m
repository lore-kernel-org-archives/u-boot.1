Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6799FCD98F2
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 12:57:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B73A84A63;
	Tue, 23 Jun 2026 14:55:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m999kcPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 624C184A75; Tue, 23 Jun 2026 14:55:37 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AD6184A4F
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiTOj0HQkWNGJjt9SfMGbTjqkb1t8sQoThRuURQgJkpdEzPKLWkDBr5Bl7NFVwfrnxzv1A96Pl/zWA+lzzRDdUWdMl4V4x+0OR9RrcAwnhYPZ5KubATw3i+0q/FnwJfALMsoGHwt/5IZM/MoVvz7wOWj0eWW5+HiVX4+RM6tWb3fLLHSlw1h6GPd0jYzlY4ngtMcMT/IrzP7JyYWUIEX4vHhfjZHI504wIzXZCt0r9eYjVCrP47P8z3kIieE2aRvKrz6CCcf33+fVGWiemRCH7BsF9DR9bowi4rDx8qrahv9/3xfVJ1MjS9YKKUcA7hxmBUiWQhCqYjq/qcxxWKpSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKPnRfa9lBxIqMA0veH1S9kv+PZpIGBeRQMga8z89rQ=;
 b=DNabdcrNTbA8uOUX3h3LRh5PrxntlazztqCHm/1ohbkkannpAQNNzmeuMibII+lmhq/YlZlgpggX38EK5lpSx6Frxbv2KWmu9tg8nLjp107YnzbFFUfo504vElbMKRGaX4t2jD987Nt4YmQjF5266wj4ID95MHKWcSYKhah3id+CKmX8NpzTis98XCh/eunIOSucEHY7BVcHyPygy6brmP1rUnwYo7221mAHJzw31ZWSi32FsEAN8OeoZR+kAggaPa2ap5ZRXJJ6ywPYyBJz0GnJ5/hOKDaTEaBPVL0KhQd2e9mhvicXI5EkEhhr03QRumRLFbh8skJUF9QY5Dt/kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKPnRfa9lBxIqMA0veH1S9kv+PZpIGBeRQMga8z89rQ=;
 b=m999kcPmsbqCW8Qz0iBXTiepyFXXx0ZzsqsY9vql1RoChgnwY3cRZMJvg+4O+kob/TWzCyp47Z1tJS+o1npEpEcH9f+pmSzxP43ZTEGzj1I5jH0hQ1k4/8UlYEpGSlD3BhfKEVf/zHQLza2gHDCuO4bR7TLHK1xp1YCgQO3dr7U=
Received: from CH2PR10CA0010.namprd10.prod.outlook.com (2603:10b6:610:4c::20)
 by MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 12:55:29 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::91) by CH2PR10CA0010.outlook.office365.com
 (2603:10b6:610:4c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Tue,
 23 Jun 2026 12:55:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 12:55:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:55:22 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:55:21 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 07:55:21 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 17/18] arm64: versal-net: Look up eMMC device in
 boot_targets_setup()
Date: Tue, 23 Jun 2026 14:53:42 +0200
Message-ID: <bf779dcdd30c900d7614c0fa8382cb3f4cb57c20.1782219202.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782219202.git.michal.simek@amd.com>
References: <cover.1782219202.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1017; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=wgx7O5F7GG9yCUGSDodzAfssz8enB4n38BRtIcejP8g=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRZNX6054/uXruBS3WKhf7DhXG/bAQSmHtj9rZtEWnTV
 Tys/Y+to5SFQYyDQVZMkWU6k47Dmm/Xlootj8yHmcPKBDKEgYtTACYi+IDhf/ongw0Ps/55823Y
 EzBXgj9SmNnkAbvc5M8K5xMElzO4GDD8jzO+k7PBasWEPJHds0JMd90y8diUY8OdZpu2rWFxjIg
 KEwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|MN0PR12MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d75060c-74d1-4d7b-5b08-08ded126b3df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: mCzuTWUJZUUtZENim8kxu+f0dDDie/+Y4T5gQkCR/Zb9OnMG3fRTlgeWIjrC59um6n/u05zS/uBJgi5W9XIFqLFRYpiUC06SI3oaL8LBrpNSzs7B+d1b8RWcchNe5mn110vPYseUaRRUgjn31s9/SKhWJmZtDkkHLu2ro0Jev2yG4/si24FOR5QIUkR/x4/USaB4DgYzrNyxxEAn7AElmPUIh+eefQHZBMD/zD+wHwjKjBT6dwiGSNcqcRZ3k54zuiWgxFXH3EMutQd+DV73Rjksy1JlUMtOriUwxjYWFmrUs+kTy0uTcPjE5vq9Vo+50NgeLIfDa5LnS7FFEivyrHBCz/7niyj+Jc8HIkv6y9JkLqqUQN5mfzmpDCUEAc/IGWuiF7A7j4tkLDE6RwPNvBxJF8r8MQ5n2AQZBUhSYcqKBckGsvyPj3DHdfjZDkVH9VWvqRJTT3YqyNzoTh2hENL/wZTnOp4v8LAYCMoN5qYdZWYo/cby1WZe4mwFdYgq3aDWSutbOt/IokzcMFr6/SsravnpahHqEjYNRkhxhPPESN+tGnTy/UYp4qRnkwTWBybJ31KRYknrWXLJ1mO5VzEvH+AW09MhLfq7w1C92K4g9E2lcVgPk5FXUQwGa53Uyf8+X7B3Mn1NbJw/1Jp60jEIlEDKqXV1FSuXaodq2+6V3trnBBk0RM0DNZ7sVK09PQuG++ECFQBqALcrtqwTgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G6L3LZZZV1TuxRtWJ8DCOoUm8h8BFwvhPF1GzOHVCzUMZw+DlUpeMLcPaDABNfDrIFY+T4dP2gd+8Vn34WB85OcJDZHplA0pjFPrembN7l9v1mmarXgKLT6WAWesDaM7XAPTXaPbcV88rMk0s27hmqYGybRwyTkglbyMYq08Tf7mDNbIZ8tfNmRCMmXXTG7wAX6hB3L/P6Lxa5KX3XuoKi4tHEHG4gllwOHqvpi8NLnNtY0RWGPQKZ0PLxDjZdxZ3FLWTslK0KNJguayWqLQmsKSDm45sFZxUh1kfBIYmne15jvIdUhhqtWXWYRH+iHY2jBTEsg1QHZyDgPGNCyJdm2r3XV79l0FBCB8e/qoXAzSFYkosXzI1YxPA3U+BUPldZCf+dlfS2tQJZP1FfLlVqCYZVy+1aM7bqsyEOiozhprAYzbSDcjCz4lF050o76s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:55:28.9604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d75060c-74d1-4d7b-5b08-08ded126b3df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787
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

The EMMC_MODE case set bootseq from dev_seq(dev) without ever assigning
dev, so it used an uninitialized pointer and produced a bogus device
sequence in boot_targets.

eMMC is wired to the SD1 controller (mmc@f1050000, see
versal-net-mini-emmc.dts). Look that device up like the SD cases do
before using its sequence number.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/versal-net/board.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
index 687d042d1062..9c0490cba980 100644
--- a/board/xilinx/versal-net/board.c
+++ b/board/xilinx/versal-net/board.c
@@ -145,6 +145,11 @@ static int boot_targets_setup(void)
 		break;
 	case EMMC_MODE:
 		puts("EMMC_MODE\n");
+		if (uclass_get_device_by_name(UCLASS_MMC,
+					      "mmc@f1050000", &dev)) {
+			debug("eMMC driver for eMMC device is not present\n");
+			break;
+		}
 		mode = "mmc";
 		bootseq = dev_seq(dev);
 		break;
-- 
2.43.0

