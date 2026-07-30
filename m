Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A68AC54FD2
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 09:48:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1C1C80EEE;
	Thu, 30 Jul 2026 09:48:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s2iNfJeHD51B; Thu, 30 Jul 2026 09:48:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A5C780EF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785404924;
	bh=4K3JHaINw4TdaNxNjYWNujcZYe6SrJK4IbDjavh92qY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qHvX/ykI1hd1QQKbSloI9WhA1zZNYfd2TPNmYLQqrbwp/zwIinXrnsEPoSAMtujHz
	 d9HT2f3Bshb0N7tAn8nZajnXrZLPPjiAZy0IG3rwZbB78naEOmkYxEYIS/Q/+7MrVY
	 xPrm4u1g+8fSIONQKvJ+ol/afieMUD23dfq4vFh58yisvOGKjuwhr5ksj9o9KgYEjr
	 obzoojgZ8wd1PO4rf/16lDSV2UVqb1GgTRcgTE0xXVAa7xXxpMNmrKBerEqiflnRaJ
	 CT5SvQsmxPYIWqs466CG/TXXILG2NQMYQzac+gXduLhOSkN+tDFRAZ33QfOXweVuDD
	 0V3P9XW7Drugw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A5C780EF7;
	Thu, 30 Jul 2026 09:48:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CA20A26C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:48:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BBDD6407FF
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:48:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mNFUKbUcM8GS for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 09:48:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::1;
 helo=bn1pr04cu002.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2CEC1408ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2CEC1408ED
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2CEC1408ED
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:48:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxtzFOkZUAEVgRhUgIAfis6HlxbUUTE5z05ma2IwflP8sOPri06ehonCe572Z5NX1BJDULFgHlIbysy3y9X7JHaW8m7lEMG30G7GxlF1vCQ9u9GONH/a+1KYdi/YVKA/iagIB+VNzW/s/Vx/t+oNDBieJ9IIUc5s6DGIcY5EXb7nGxTkazG2R5JbcKZCbDQbYl4L//laUBL/Z+zh2HvEvWYyKqwvpwTgmDUDIlRF3H4UZuyI/01PPoy+vdyY+4DgXf/4eSS0rLOo9pxDscR70cvDFwHrGiJZrqBEmtEnU0ik1A0nhtSzEC/VQYioRwEZDgadwE2yC7wsXwzKVl5XOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4K3JHaINw4TdaNxNjYWNujcZYe6SrJK4IbDjavh92qY=;
 b=pRw4u+KHKQQhqyww7GtisE3RUTyUV1KUsv7TF5k77VlzPgf7tWMCI1bwlggimaGe1teECHj2RUDPnILbzjlcC4MgMGhaMqv4unQqCIdnfEmWrp94f19yA1mA1nUYp2G4UqobL+LtIZaIvF16fb/Bzo+QmUXF1urVY/7W0CpjB45hyyouj94jL+I6ZKNHffrjeO2E9MN58s9WpVW7lddPhsUycB31PTFSMEY3EXUovXqxn+T7KQQa1Ktq33qPZQO9jSMeGmHHlYDtUPANlBgqz8HwGy9iPV02fqEzuwfp1VnbALkRquXldBhYEdUFgvlV4LU63Z/7kZ8ZAWaoTJ9xpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from PH7P220CA0076.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::16)
 by SAWPR12MB999291.namprd12.prod.outlook.com (2603:10b6:806:55f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 09:48:33 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::5b) by PH7P220CA0076.outlook.office365.com
 (2603:10b6:510:32c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 09:48:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 09:48:33 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 04:48:31 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 30 Jul 2026 04:48:30 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH 1/3] test: dm: free gpio in dm_test_gpio_requestf()
Date: Thu, 30 Jul 2026 15:18:15 +0530
Message-ID: <20260730094817.1937340-2-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730094817.1937340-1-pranav.sanwal@amd.com>
References: <20260730094817.1937340-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|SAWPR12MB999291:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cfd3593-7c8f-44f2-99d2-08deee1fb806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: HkhuEHYL9vauted3H80NDoaD9AxyM6D2guP16l4XIBdii56vmhfin/8jqDq9Yl24lJhEvR9JePpdfrUN7KkqJETOuxd+uda8IC57/ZO1OBLL7bAhy8BuzwW6oUU904kX+/miSZhUvVDb0MvU0qFL4YBGWAK9rU50EHbDbC9sMOaK02iwB/ViD6BaGZNjR+P4nkwOXEo0ZN7i2Y9iTV43A5KTL4pnejQSA7O3SjupXezaV9K7cjY9gV4z8xneUCGzr00EdrF/r9na/otjvKwccIBIe4GhHaPXB5xJH/CJohPXXFCGGNIDfJGWCMFcDyWFfi+IzM5Rdv0dZHBoy7vcYcQw2tmHMmJb8mabZBUjN0KZVWu74DSsETwSD9Zf79F1Pp/KpXepBiL23AniWN9A/Omyup5CWmds/pAixtATDWaihrP96or4PuK2a4LRFIfTBMDpdqmLY1gUGL2v1KztsfWqDETrfL/hAS+7WXCN/25dETZ8HSn3TL5taPXyS3fV/yH4MTt5YU1jJPSABtM+k0DaQhI62+yjEUhWtLwXd4yfYaLI7NYPxUW6ddagXuUyU6/MzTaIPTX1tmVhT5fe33bMAvl/4/lZVOxTSbjOq6moIiCrRQflMTrk9bgupXQnKkPioJQLmim9eQ51ECGbPpTT3/T1MhOt+e6ZNTySsv2QJl1Ql/lxO0ataqoMOciCL+QMG78D5R/Xdamt5v1aaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7RdVVcqBdglWYdIrvx4nMMmsh8j4nnSAhtqkwmn9ZmII4rcoaw2F51PLhwrsMg5GNe32645hxqTwd/r2i3NTJbFKvxHNym8NlDRJpgNpcYoMf3VupbHKZr00FAXMkneHYa6jVYgQa9gdnl5X51DkNJqnuim5owmdhD7Z/j3G2+tqenwT/dbtWH26MYVrrSpxRRW+gbEE2jMMU3mcY25sS7vgvnM8RIH3wjJmiV7VZ0+emvbcPveiJjQWJT5futQy6D5wBwzEjNXASJlfyWPAqGiFS+J2BeB0dkFCSO7OLX/09zInCS2ebOmR3cj/1SScafR2e4uJrgjDKqCa/AVLdJtbyHgNpdmUjUFtK7JINKkSuLoYZx/zHju42XkbY6qLFj3ruxKDvcx5xwsZR6lIUonguW7jTSdT33aOY82BAaf6fHnAvD9zNq6gFAA7MJFz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 09:48:33.1336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfd3593-7c8f-44f2-99d2-08deee1fb806
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999291
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4K3JHaINw4TdaNxNjYWNujcZYe6SrJK4IbDjavh92qY=;
 b=KGuAFocvbpvVj/f5sgvFrVS2ulxn8T5w5qYBo4e6UeeVmS83AQLT6DPLbYV19Ydlu201YJir97bR4vN+meWriiBkCxMjiqiU5AcnM+gLsislliKmXefPLUzxFZIBL3t4e1Em6DBpdYAuBu5qOeDG/wd12ekm2Gxn6U0D/SYgK7M=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=KGuAFocv
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

dm_test_gpio_requestf() requests a GPIO via gpio_requestf() but never
frees it, unlike every other test in this file. Free it before
returning.

Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---
 test/dm/gpio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/dm/gpio.c b/test/dm/gpio.c
index b45946c143c..b872dac9082 100644
--- a/test/dm/gpio.c
+++ b/test/dm/gpio.c
@@ -282,6 +282,8 @@ static int dm_test_gpio_requestf(struct unit_test_state *uts)
 	ut_assertok(gpio_get_status(dev, offset, buf, sizeof(buf)));
 	ut_asserteq_str("b5: output: 1 [x] testing 1 hi", buf);
 
+	ut_assertok(gpio_free(gpio));
+
 	return 0;
 }
 DM_TEST(dm_test_gpio_requestf, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.43.7

