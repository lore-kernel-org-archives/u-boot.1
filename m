Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30CCC54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 08:12:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C48E60AE6;
	Wed, 29 Jul 2026 08:12:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GTHUYlE5i4lq; Wed, 29 Jul 2026 08:12:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7265B60ADB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785312766;
	bh=a5HNQ/bcLuc6vQ/FesB9tR9s1TZNY7FrwFwB4FNfCAo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RVBdV7O8CQeZ4q3rEq+zjjoBxnGIgLgJRUXPrv7Gb6LtDLyBqBQtlOfCYEOjHq/gy
	 fqSC8J2B64ahxXvoNzR+ML8D3QgHImjL9aBPSrVuldAMy3EmaLFabvwWG0FbPjDFny
	 W2CESk4Dtb+VWf0q339dMytNqDZrEKkTNbvpDEK+63fW5B5uKupOUYl+JO2vsWKPot
	 PEE0tdhOsDzGSc6AGnUFQ71yKeqtHQx1AG8U3OvHaDI1aDR0Mc66bOi/SWC66zS/ub
	 wwEN6CKSbfkgS0cyMwI8tfIRdKkiuORVXIP9f0ZKw++0/d9XiWeKqHtGxfaPMgBJgh
	 J0ldXwoTb1YHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7265B60ADB;
	Wed, 29 Jul 2026 08:12:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 94FDA26C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:12:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7A8EC81110
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:12:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U0VI-B9qfeQG for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:12:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c000::1;
 helo=byapr05cu005.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 698D981140
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 698D981140
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 698D981140
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJ2EiROhAdD82qonDCCMHOtI8oBui0rqfBpVB9sh+JisOoKsXb+n6MMPp6mpXE5b+xSvhE8GpJ0P9gnC993r5W+4q7wxiJOT7BC46SixgaTWHXiUQiZF4DFvSKQpHLsXPLFrSTcs1kgvuXuWUAU2r4mU/6QcdeWcldE4+STgSFn1QQ31xoUGH4HJZ0U8W5aYwDK0BFNk2Rp8Td4rK6O3g0zWKVgNyEk7UzO95na5ig+bMDjREIpg6VFFb0BYvQJ5zXUVy7jVuzID8qDEggRsTJLUZV0I9X5e6DLtBZ9g3eupxrKs3VkUMNgqWL2E8eHKvUJWYWyR+WkrsCfJykWY7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5HNQ/bcLuc6vQ/FesB9tR9s1TZNY7FrwFwB4FNfCAo=;
 b=I028d2ibfAKI4U4Bixbb9i86xV6f4KetQuYmdprdxMnp2OToQU7yiKJtH0NVUbIrA8XHsojRq3TnPW4zYQYEg5AX9joj7Bvbkt1fG9gf/kl8PrVw6P7UivgeunuFIDh/W1SwvrVVWxtuuD7p8AMLyaWZLhLJZnc6mLlweXLBWNXqBzlqtHCjhuhxwnQTkGRFKxhL52EZ3No+BInOnFb8ykqMZE+6n0PVS2CLbgNIi/1TZEEEDyO8f9VZYapp3ZsXJcjNW8pYO9NJBKG3zJjai/nTk0nJyg6okM2bc4AdiGS2gjSAq6Wb8gpMaweBcMGiz46PFnWUDA9dxEiBxWc1yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from CH0P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::29)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 08:12:37 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::49) by CH0P221CA0006.outlook.office365.com
 (2603:10b6:610:11c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 08:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 08:12:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 03:12:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 03:12:33 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 03:12:32 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 4/5] gpio: delay: fix offset propagation in
 gpio_delay_xlate()
Date: Wed, 29 Jul 2026 13:42:17 +0530
Message-ID: <20260729081218.550465-5-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729081218.550465-1-pranav.sanwal@amd.com>
References: <20260729081218.550465-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d2a5bf-b2ef-4287-94fa-08deed4926e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|56012099006|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: CiZks1HurKojxGgpWFPHUbOPMj26ni996kRY4HJZzUolHFWRAqvVR2Ep944sUxFQhvR2xdUS4/W5O9/T6EWDF193AoE2wEi9oP2mZOsI9H8ibWDRIm+Tpkbzx9GXQCW1BvU/Bj1Mg47c/FHM/MG4Vz2iHePtrwioBvX37Amd6WC0v6iFRQB/PBu3++IOgctS9lqnP78HF+9vOgLcJfrs+POa6dGkmefMfcPtUDG+N6uT2WUB95JjQLqRHjPqlh7pE/+3zDeOMS0QNwHPtnwmNOyeVEqgCs3qt1gwogT1NGQidJNbmNsUAdw8nwmYtKl7Gh6WpeOlD9hwmgwEfsMcAdZxuXeW65qrta4CCP7ygsYDSwbmoFI2kasEObxqcJe+6JikWQc9Gy0w0I6MC8rNQXDvAhbpFl5my55UnnjhQXrYuLrsnCkSw80nKQZONI0TG1V9fyTAC/7d7hku9E1SuVvffz1SX9Hcttn1AiOcSlqERfbNCGMRIbLmo1e9pvgzAJBbtnsMzM0o7hoQY6HtUyg1dQO5lAsP0OuV9Dhdz6QFV2bvQDei3Vdutwgliisad1nhFI3eQjlDjQsqR0i9FpCkrocPQcWtQpEoeosJobRwXmnMXjRSqNlHy/1LTNqa9aTGqsnMBYavmMzpTJAb1gW6w7gqs/ZcQSdHPWaVgQAnr5AK37LQ1O5NoYcLzCb7c3pkX7x7iuKY58Bpnncaug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6G8ByQgVGfyb8TwMid6DPdf0B1/Y0IrTw44xcmNBAuUHNHvaZ3PBhSQSngoIA7rGjJi8wZtXOof37SEvO5N8OHTNqY6gpAfpia9RDAGBpnUatr8NH/RyHqm3yftwNBVjlEX7p3eczzDFSVnIQYGe5FOZZu2fR+TfcaANI3snF5c/uyibDwSUnHenk3NpzuLWYB+GS5zPGaNnTSs34m8ZjxwfFK33N6fuc4l6VGYFfawHUNEnj4LCFQqss7c67zy3pP8Ww9Jbtar+GNkUTWZp0ACqivwG3p103fhL+UoxlbC3Ngl0bsN98V61qSQcvLIegeV6Q4r++YLntUUmntwmlv+Ep4KaiTX3m1gO4LpuwGyurQK1YAk2ng656t80Sj2vIkDgKnRU09dthnYItnQE1xbwBMDFokLF7ssfu6F5z0WQLcsllM4pR6crQxzRm3nJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 08:12:37.3604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d2a5bf-b2ef-4287-94fa-08deed4926e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5HNQ/bcLuc6vQ/FesB9tR9s1TZNY7FrwFwB4FNfCAo=;
 b=LZnqUAXwzjGVHpRIR29qCvo3GSUp2OO0ktKqxNVKuhgyIRjLCUdCq/M5i76g5nFPkGwn4OAysE0IFkNrl54+ZtSOEEt5G/DuKE3Gbk25WD7g3RNLM2nfoJciMBY6Orc+XTv08wY9xFyL/BGjczc8PRs53S4cbyoDAEr9okHMhEQ=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=LZnqUAXw
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

gpio_delay_xlate() indexed priv->descs[] correctly using
args->args[0], but never propagated that same index into
desc->offset. Since gpio_desc_init() initializes offset to 0 before
xlate() runs, every consumer's returned descriptor ended up with
offset 0 regardless of which index it actually requested.

On boards where gpio-delay wraps more than one real GPIO line, this
caused every consumer past the first to silently collide with the
first consumer's already-claimed offset 0 in dm_gpio_request(), which
returns -EBUSY. The second consumer's real GPIO line was therefore
never toggled.

Fix gpio_delay_xlate() to record the requested index into
desc->offset so each consumer's descriptor is routed to the correct
underlying real GPIO.

Fixes: c866f2f197e2 ("gpio: Add GPIO delay driver")
Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v2: None.

 drivers/gpio/gpio-delay.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-delay.c b/drivers/gpio/gpio-delay.c
index 533e7d2f8ef..f6c9c7efb0b 100644
--- a/drivers/gpio/gpio-delay.c
+++ b/drivers/gpio/gpio-delay.c
@@ -77,6 +77,8 @@ static int gpio_delay_xlate(struct udevice *dev, struct gpio_desc *desc,
 	if (args->args[0] >= uc_priv->gpio_count)
 		return -EINVAL;
 
+	desc->offset = args->args[0];
+
 	struct gpio_delay_desc *d = &priv->descs[args->args[0]];
 
 	d->ramp_up_us = args->args[1];
-- 
2.43.7

