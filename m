Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2A8C5DF85
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 15:34:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 904C860831;
	Thu, 20 Aug 2026 15:34:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jLgJyJx0m8yb; Thu, 20 Aug 2026 15:34:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787240078;
	bh=CAZeIt96goUQsGbTwPV9yXc/m3Jmx1xTk6qxScU5iyM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qxSBPVsI8nOSBMGGBm4NPI/XUvYL3KKh7V/bQbOJnV23UnAkDLKKJvRQKUcD3u2ap
	 Tg9DAseRh46eVHQWY4fnUWgwJUNMGmQlBO8u55J7RTBv+j+j+7oDAccHHm59oDpv8t
	 N5wPW220mryoeWfJxCgIkk7h47dzdyZQ9cVp3jqpsnj3NrLiP7Y/RC7LTods0DMaM0
	 AV+RlCPUSejEvYSIDn/VUP80eS+c6JP5sHKoeFOc6SXLsMGMctD9FV4CW0Z6Sw2lTc
	 k7bwoKpM8oVdSeNtvLlyJOvdfmG5gRYyw0B+YJ4iPAY/+3dTdGYqKSSQkoSxuyr20x
	 +TorI0li6Js0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5759A60779;
	Thu, 20 Aug 2026 15:34:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E47240B
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6FDB9407A2
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:34:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wBMuOwOY9eVG for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 15:34:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::1;
 helo=bn1pr04cu002.outbound.protection.outlook.com;
 envelope-from=akshay.belsare@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Drm9GC5w
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B7DA640799
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:34:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHqQ82l2/5Ov/6bTw+GKgAGUJ+GO1+tO0GARmaB4H2kzJJqQhS05VBv7gxardBkNG4f7KdjHLboslzIk/fGlTk5hJxUXbImHfxX7AxK3sRT5yNyqMrafgl8AO2AY/MHttx7Hw0h2uZB+G1O/jVxUq2+dpu99K7GTXSNECdLJBs6zRQHWUqIzj1EwIXXW4+UXuIvJkheH/XeKlQIV/aefLddnWMbc8sVlJatT8sHvly6NoaPCHtWBPDnH10i7QHljGv2PDF7siP/HVH1DdXwLDlr+8peYczP8Odh1pMVIc/CT11yTs5VLc9jaaqi4pZZ3Z05bJVqWXT5Ax+fD1tAvQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAZeIt96goUQsGbTwPV9yXc/m3Jmx1xTk6qxScU5iyM=;
 b=QPjwmKxhAZCr6ClAma1jceA+NxPooI16JVwdrNOBDFiQ/9QrctJSn5lowCNIeLnw7iS5vYRFpYRweXb1S5AIaB/X3KuBWyjr4PHw5DBVPLwqNaS3kIHc/uKET+dz9B7q1vZaNyRySCY5ycKMKy2OeM3r6iMiGhORTnc3VvWyArgW5tcpibjFlQzdHX54wmyRGrMYmJaa9IpektOJo+SVErsu34l91zHdqQJ+iBYNXDpQIyQ3DOBNhzPoWmU79aT9ACuvF6l79YJ16gPK1j47ZqoxLv5VF2uAgPX0E/t9ogbqg/d3PgME0Smpm5ma4QePuKvLQzxn2LKwCfzSAOTRzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAZeIt96goUQsGbTwPV9yXc/m3Jmx1xTk6qxScU5iyM=;
 b=Drm9GC5w6wGR7OkiDn450EWHiKznE2dWo8y7pN3d9ySStNjJ1mUPDJ40TZUKBiYQus6PH+EoQEoLlKDcwpMGew9+a6Fs1ukOcXn1dN6kCDwmEFQq8UrZTOCaPf67vSfb/SlbotZ3ufdXaQeG6+4AMcH/vv3lhJp98K9vnMDRh48=
Received: from BN9PR03CA0159.namprd03.prod.outlook.com (2603:10b6:408:f4::14)
 by IA0PR12MB8974.namprd12.prod.outlook.com (2603:10b6:208:488::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 15:34:31 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::58) by BN9PR03CA0159.outlook.office365.com
 (2603:10b6:408:f4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Thu,
 20 Aug 2026 15:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 15:34:31 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 10:34:27 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 20 Aug 2026 10:34:25 -0500
From: Akshay Belsare <akshay.belsare@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Akshay Belsare
 <akshay.belsare@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] board: xilinx: zynqmp: use reset assert helper in
 reset_cpu()
Date: Thu, 20 Aug 2026 21:02:39 +0530
Message-ID: <20260820153258.261076-3-akshay.belsare@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820153258.261076-1-akshay.belsare@amd.com>
References: <20260820153258.261076-1-akshay.belsare@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|IA0PR12MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e393909-691f-471e-68b4-08defed08780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|10067099003|56012099006|6133799003|5023799004|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: +Yn4QWtmGxDuYBobjxN5OygQKIbTn1r/cVBOlYqzyGJBDnN3iZJX8LJ3JsiWfapCSDWcJ77eWblfIWSlQHHwanuB4hxkIbCns3uyo0fWKd7Asb4T4Y81Rotp7F69tuqYZhUtH15BpNdZ7pjcwdesF7wz2LpH/Vu5zMKC3WTjhDkBtMG2Bo3DVSjRRR8c118iRkuMjLf3whdcDVUZwZHDu6gpSYVEpg0nDQpu0N6CmXsr2XMA9QSHF+pxSFSQNThnDhupDPp/PhAOlhmJgmmxVep+VMlMmgz1ONTMugWHCy5C7Yq6VdLQdrrR98aOS8yZLCHCh+KlSNg8/nzWAFSwWtI0VTX4eEW74bPZPZQae/Ib2gZL+UqVVHqhKzrSvvzWnEbXEU50jIaDDNYVq5bkYlxdkpFe9po9F9ge+f3YG17bCspxmrNAOwMSa3iTs3NnfJDgdyakS7kVF/KjFCK8ils139CKmOTYtkY1zgPKbT4H/lcvpYaSJDBJ+3M8/yf89X8+2zTzoGfxjkp3RcpJD9ZMoIa+hflFQlCp1iuw5eQRgsed0lW7y4BrnEOB6L+ZnA+E/5YLBXewPJcW25lMItgQDzuV/yx0Zolke0dOAdYZ58N1KSCdnmunSozO1zH9LC2N1XapfHGwBkGIej2STpoNCejAytKhOHwmq4/kOtl/odBR1W4Le673JFrezWCyk4QTZ++cZ6u1U9jT7NmM6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(10067099003)(56012099006)(6133799003)(5023799004)(22082099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZRuUx36txahL1aiBbqO8y5iRnh2n5RBxtUfA7mE9QwNGjy5mquzh0R47uM6pvhy6GUglcm2ZrSoqSz+onpeHrMUFRwn+JqcoWCjwV8O7rtg+5ypltbOhSwl6jRZpkgci1K7I8YbFcMfdKiWpWsTQX2XEDFBxmEu1IUgjh/ytNgQmNQAt5NKim/0KwFGz7h+sC12+YKyeEBGHPptqK6w1Hq4DIJzlJXJ1xy6QIq84Y/Ejpc/FaCCRY/U01zLVb+F0T1wicO/SKTLi9Q6A7QeCHfZFNl8tAxpAxoFO9VIbGjO6gInEZM0ByhRzt1s9zILoQbwp1XZH41cnrH9uFTFALPgLRz3H9PyiKA3PSCpcRYbNqbQCrvf9WpkxrQ0OnWagoSqX/mcytcSP78TiYHdVxeeUr68TnShIzdFQY+pMGtEt0XrICIWE8Sf5jHexbdwA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 15:34:31.2745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e393909-691f-471e-68b4-08defed08780
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8974
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

reset_cpu() currently invokes xilinx_pm_request(PM_RESET_ASSERT, ...)
directly to assert a system reset. Switch it to use
zynqmp_pm_reset_assert(), matching the approach used by
reset-zynqmp.c and centralizing the firmware interaction behind a
common helper.
 
Keep the IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE) early return unchanged so
the reset path continues to compile out when firmware support is not
enabled.

Signed-off-by: Akshay Belsare <akshay.belsare@amd.com>
---
 board/xilinx/zynqmp/zynqmp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index 5d13881f3ec..c7464b493c5 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -288,13 +288,12 @@ void reset_cpu(void)
 		return;
 	}
 
-	/* In case of !CONFIG_ZYNQMP_FIRMWARE the call to 'xilinx_pm_request()'
+	/* In case of !CONFIG_ZYNQMP_FIRMWARE the call to 'zynqmp_pm_reset_assert()'
 	 * will be removed by the compiler due to the early return.
-	 * If CONFIG_ZYNQMP_FIRMWARE is defined in SPL 'xilinx_pm_request()'
+	 * If CONFIG_ZYNQMP_FIRMWARE is defined in SPL 'zynqmp_pm_reset_assert()'
 	 * will send command over IPI and requires pmufw to be present.
 	 */
-	xilinx_pm_request(PM_RESET_ASSERT, ZYNQMP_PM_RESET_SOFT,
-			  PM_RESET_ACTION_ASSERT, 0, 0, 0, 0, NULL);
+	zynqmp_pm_reset_assert(ZYNQMP_PM_RESET_SOFT, PM_RESET_ACTION_ASSERT);
 }
 #endif
 
-- 
2.34.1

