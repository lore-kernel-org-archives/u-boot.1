Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C46BCA0EDA
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 12:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6E2B83236;
	Tue, 12 Aug 2025 14:39:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="HWLEdSOM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67F988331C; Tue, 12 Aug 2025 14:39:08 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20716.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::716])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 784878312A
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 14:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUAWoFbgNdWTBBxEc9MVOFbjw7dus4jNzF50QYpJLslGMFFtg5e9ve3dkGu+9e0IxeE0/Eec3YQJElcv+w4viOKgGL7aa7qb0hYY+XPdGgBOM4xYZKgH1mUzcCt80ib9NM2QePKX2DCsE+kKyFJWbab9TvPOsYAIVzSpGj7XlEVImhaPSPHRdm6LFPv+rFSEEUnYAbIBg2e5+XUMN88BO/j2mQ0ntMKBRApQRECzb+pEJXgNrJJ5UHA2LmtB8mmtZkw/Kvs5WJGCWV6xf/BdsLDS8NBO6xkHiV2c6hB4sqjQL2YvNohclu5u0CEOaqcFBU0wdXqaGECL5rn2HyYZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8uch3TKyN0rcHoLwCX3JYWcG+M0X7xJEF/606PrzYU=;
 b=H8ZNMTNOj08Xp8Gj3afA9JT6Vy2Ulj1x1+WjFpuuAZPg8m7/7MLleaJo/MAApD7QAL2x0s9yH3ai9n3+WOh9El6z8m43Q7b3iY5HEcjPTHEq3P2F8VPLYKFPP+HgFR0Af8lv2bPqAEfQR52PUH7bTDPNMimv47OTLUX5pT0GGRUUtJgFU3fkhxIur8qYGY5e96e+jTrDivJlUOvXKBeZ81BPCc0eDdzluej0Sp3bO1022CcSAoBXs+n5bkqJdFs6Cu3+78rpNUnTHavnilicwz/S9jvKkgZCFJxc+1IXOZROpEFr8kFqk4r/242y92zfrN2r8YtbjvqifPkcYS/mtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8uch3TKyN0rcHoLwCX3JYWcG+M0X7xJEF/606PrzYU=;
 b=HWLEdSOMvFlO0/VAVkGaTNHtwHM+jMU69xBA1LSGoEMQSaQ+3YFG5Idnzeh4YUg3LU09mhYGUA2utq5HM9zJB2SLHqgcKuDXwpCcZsF2kfu7xKgwN+QE80C7QNlQH0SFHgZ88iBntbYt/n9rCuSQ85q06gCHJbBhDXQ3MyRspW++CkfP25di7NedXNBKGDi42aJPCniVvnckNI7xfpmQd5QGV5PiCJK3tXbBVe2Gn01Mvww8ChA0lmm09q1fGmru46Pfi+SLfbdZue95w7R8WPp9vvPKc6GF2tIJt11zlLA0U8jw3Uc/hYz9c3SUI8rSxqvTvgBo0ypJCGIS92OrUA==
Received: from CWLP123CA0067.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:59::31)
 by VI0P195MB2649.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:253::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 12:39:02 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:59:cafe::e0) by CWLP123CA0067.outlook.office365.com
 (2603:10a6:401:59::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Tue,
 12 Aug 2025 12:39:02 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 12:39:02 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 12 Aug
 2025 14:39:01 +0200
Received: from lws-schwan.phytec.de (172.25.32.44) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 12 Aug
 2025 14:39:01 +0200
From: Martin Schwan <m.schwan@phytec.de>
Date: Tue, 12 Aug 2025 14:38:34 +0200
Subject: [PATCH] bootstd: rauc: Change global method to check any partition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250812-wip-bootmeth-rauc-flag-any-part-v1-1-9f8546e80928@phytec.de>
X-B4-Tracking: v=1; b=H4sIAMk1m2gC/x3NTQqEMAxA4atI1gZqQbFzlcFFpkYNzLQl7fwh3
 t3i8tu8t0NmFc5wa3ZQ/kiWGCq6tgG/UVgZZa4Ga2xvRjPiVxI+YiwvLhsqvT0uT1qRwh8TaUE
 3934wzrrOD1ArSXmR33W4T8dxAgfyHUtxAAAA
X-Change-ID: 20250808-wip-bootmeth-rauc-flag-any-part-9d5c609291c6
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.25.32.44]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|VI0P195MB2649:EE_
X-MS-Office365-Filtering-Correlation-Id: 76860e1b-325f-4bac-aec9-08ddd99d3783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dk0vWWQwdGVKWUhTNnV5TTBudXRJdjd3N01kcnR5emVyUHAxeWw1cXNjVmJo?=
 =?utf-8?B?U09kTVdiS29tczZIQzFsVWVIOWkreENlaUhhbUdFWFZWVlhvcThWRk04K040?=
 =?utf-8?B?Z1JQdXNWZVBGTnl4RmRQa1JNdnpPenlPSzZBQTg3STNJMHdVZHZKZTV4amZ4?=
 =?utf-8?B?RDk5enkzMzhpVlNUTzljcEdHKzFac1loTEtPeG5CclM3TDk2enRIdmkxMVho?=
 =?utf-8?B?ZGtnbjg4Y2p3TnJYd1RkeEREUVVJTzBpYTlwZnRZTVhlSnMyZk1GZzN2ZFlX?=
 =?utf-8?B?anBSMDlUMjlEZ2tzS3J1Q0liR1g2ajgzUzA1UkhIMk5zZGNtM0N4VXhZN1Yx?=
 =?utf-8?B?TlZ5WlZ0N0pJV0tSRjBaam5PRWEwOENXbGVGR2M0OTMxV0kvOW5VSzBTMUpW?=
 =?utf-8?B?a2loSURXM3NVcGRuU1ZxS0xnWVpqSmU3QlE4bndzNFZwRVlpa1ZtTW1yTGp5?=
 =?utf-8?B?SUg2N3Voc1BvQlpqdHhuYlRlam1JMks3YWNXbzNrcWF6ZDJoeHV4UmpIWXlY?=
 =?utf-8?B?TXFZbWtjWTdYUWZPKzRUS2NFVUlTT0NXWCtrdVozUDREMFk1ekdTb3pJdHd3?=
 =?utf-8?B?bER4VDVpWldPQnpWS1l1c2JwYzJhTThPOXp6QTZXU3AvU0crOGEvVDV0Smll?=
 =?utf-8?B?Ny9kZ3Q3K1NCNFVIdTNZMEdRSE9KRExFeTJENVR6OGFPRmRxRVRhc2plbVQ1?=
 =?utf-8?B?bHUxYkhIbFp4ZXU2WVF5elpxdnJIVDkwSWFEZTNMdnZWQmtxMllsOXV2RGNw?=
 =?utf-8?B?TFZvVm9oRlNtMUhQVEhYSmJ1bjNlMEt4RS9acFU3UmJXczJxaklHejJRZ3RV?=
 =?utf-8?B?UUlTUENWYmJEcmx4dmRua0lUcTZPTGRwMzkwNFNBWU8xeEZYS3dEaTd3UFlG?=
 =?utf-8?B?cVFKVWowcFdsaWhDOUNFNEVTaFNobGhIR2Rpb0doYWJIeG9sd0xWR001Q1N4?=
 =?utf-8?B?dkp0bGlZYVpIRkl6a3NYUndib2UvbU1zRzIzTVBqYUNJVXhTdGYwUDVsUE5u?=
 =?utf-8?B?cXBOdlJTR0hVSGRSekhsQk5LVE1NV2QrMTFEQzRUL2o4M1l1OGI4cGJBeFVX?=
 =?utf-8?B?SXVuWXVnT1VmV09vVGYyZ3Y4bU80NGM1OXA2bTk0dkZId3pubnE3eUwwQXJ4?=
 =?utf-8?B?RU1ibmcyRkpTSG41N2FYWjdtYm0xcXUyVmZ3Wkx5YXNDemhneEoxU29JQ3BL?=
 =?utf-8?B?ODkxMUJPYVMvRXl4US9LMjBuQ1hmcG1NcnN2N0daOFNnRURHVzRzNm9ja1pF?=
 =?utf-8?B?eG5sWG1CT29LTnEyQVV0ZmlEeWU4aVRQaFhibkJXbUtzdWRTQzV4T2FvTGxo?=
 =?utf-8?B?a1AySUpJT1NpRU1zRG9mWFdkdmlzTEh6QnplZStJVHJhTmVZYnEycmNuNUlR?=
 =?utf-8?B?ZzVsZUp1N1pqOXdaT1lhWXp2bVNQQ1J0V0I3OFdYMXQyMEc2eS91NU4xT0xj?=
 =?utf-8?B?Z1JPVEVTRjNqak5tNmpOTHcvR2xXWm03VE9uNVd5WjY5REtGRjdGUmFsbUds?=
 =?utf-8?B?Q1FUWlZud3A0RUwxT0lVMzF0dVdmZjNrRTg1SExDS1IraWR0V2w0OFVzZkVm?=
 =?utf-8?B?M3Qxc2xpWGQySmhnNG01ZmVwZmpxZ1RZdS92Q3ZJZGtFRytDMGh2Q2djNXV3?=
 =?utf-8?B?TEsvSDREeW1OTEVNRUN5V3ZLeDBFYWlWSWJPMVNkUkw5b29NMnZFSDVYdWhx?=
 =?utf-8?B?d0ZxZ1BFSW5PNGJydUcrR1l1QnZoVG9WNnlVVjBuRE1iUjVkbVd1NW02Ukcw?=
 =?utf-8?B?d2gvSlU3VkZtRmEvS0szTEFSOWpIYXlPV3ZFbjFuTXN3eFVScWhKWEdsOWpj?=
 =?utf-8?B?a2IzZ2lqc0puaUFnYW9Sb2QrK0t5QWl3cXNEUy9BRGtIbndLU1BRcXVzL2dN?=
 =?utf-8?B?QlJ5ZGFnYnZ2R2gzUGpxS3h1ZlVicGo4R2N4VDFTWGkybHdjcTdjTDJteFZQ?=
 =?utf-8?B?YlpScS9WbFRabFcvSmI3RGs1eTNpbFExN3NNeTNPY1dsZklwOEEzWXBWb2U0?=
 =?utf-8?B?a1ZxVlN2M1pTd0E3TzZMOTJ2Wk0rSmhyd09xMDlxV1dTVWswRCtNR2wvYUtL?=
 =?utf-8?Q?FPLBlU?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 12:39:02.0431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76860e1b-325f-4bac-aec9-08ddd99d3783
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P195MB2649
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

The bootmeth rauc should scan all partitions, in particular whole
devices, and not be a global method. There may exist multiple RAUC
systems on different devices and they should all be detected. This also
fixes a bug, where both a global bootflow and one using an actual,
complete device would be detected at the same time, when scanning for
valid bootflows.

Signed-off-by: Martin Schwan <m.schwan@phytec.de>
---
 boot/bootmeth_rauc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index cc6180221ed90934801ebd801a7bd1b3fc889aec..7c1a895139e8116054e6c331fc0acd967cfbc7e4 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -410,7 +410,7 @@ static int distro_rauc_bootmeth_bind(struct udevice *dev)
 	struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
 
 	plat->desc = "RAUC distro boot from MMC";
-	plat->flags = BOOTMETHF_GLOBAL;
+	plat->flags = BOOTMETHF_ANY_PART;
 
 	return 0;
 }

---
base-commit: 123cd77122a13288e1552b5d9b7c22a6f19e2e02
change-id: 20250808-wip-bootmeth-rauc-flag-any-part-9d5c609291c6

Best regards,
-- 
Martin Schwan <m.schwan@phytec.de>

