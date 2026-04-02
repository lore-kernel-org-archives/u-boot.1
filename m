Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E77ED3943A
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 15:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A43A0839DF;
	Thu,  2 Apr 2026 17:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zFZVgB7J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 407D9840D8; Thu,  2 Apr 2026 17:37:41 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 136B580212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 17:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcHVCRgXzdNaCVkFbjRI+fhZexdkDDYOYap/B7CFvyEIs1GRd/mAj+83ujqbnYLhx6L8QIjZeL13lqvK+jXX5ZSa7tbg+VlwKxq1I1nNGzHv/2TGoRWYI+x7nyBGaelOpkjDMwyel0KWd4uOCr075vfyIhzicfFhpSJFY8d6sCkLA6hw83LJYfwTSopKyxRRHhmHqsuflV2NeiTrcF9Adqu5vC1lNjuo/P4BLTEwtLHuF6dzhvDWyjte6/1TH/GdcYy4IObXX+jpM1s+Yli6324kGO/V+7L7U9qpxD1sk8CZ0iWaugnlx5hN2nwb3IihjMUHPtJDMzZIx7v96cvr5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMMRe9faY1eztzeudNpfXSBn+UtbEOEB2Knvv7ZMbTg=;
 b=p9jqlr/K1CeZ93ggvBLSVbeKYqG9w9fZAHaqU1B+i55Te8A1qCFlIUPWLpGDGGtd8mSG08nVFw68J+VR7DRAugqst2XDNe7Ijxudlwg7AiQUtaDZajmmIIHiBT1tgM0WUL6UQ5n2ofBGAwNkPjRKVlCgPdJjRLV+XjdrugtArrX4KRMWwO4xxOuCxyfFqcCv/Z9dhKWYO5qjZ1mBST1pIGu7Cufw1Glx6ByyUFska1VijQFesq6dfWyU8a8I5xIbMpiGAvOv1BeLY72Zht2bItXDMGpOS7KzbbBnD2Pqm5bFDnctg8jbn2FGhll7q5UdSzKqIZ17TchjR9bJHLFDUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMMRe9faY1eztzeudNpfXSBn+UtbEOEB2Knvv7ZMbTg=;
 b=zFZVgB7JGM/f4tA0pTSEeGwCZOXlOtobQyZrLwgdyKoYuD6WrwP042f76e55e4NhMZurXCjnh8LKEl62DoZ6cJ6DUVnTZKJ1f3fufV+YV73DbSSWdAY42PoG5KGO/223dL9EjpEPDG86SKbe//2vGRi6w5In6WRXXs0dQ/pZ0NQ=
Received: from MW4PR03CA0074.namprd03.prod.outlook.com (2603:10b6:303:b6::19)
 by DS7PR12MB5887.namprd12.prod.outlook.com (2603:10b6:8:7a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Thu, 2 Apr 2026 15:37:35 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:303:b6:cafe::e6) by MW4PR03CA0074.outlook.office365.com
 (2603:10b6:303:b6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Thu,
 2 Apr 2026 15:37:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 15:37:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 2 Apr
 2026 10:37:34 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Apr
 2026 10:37:32 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 10:37:32 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: Kory Maincent <kory.maincent@bootlin.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v4 3/3] fwu: Move boottime checks to EVT_POST_PREBOOT
Date: Thu, 2 Apr 2026 17:37:00 +0200
Message-ID: <950bf29f73f44e8edc6b22cb7ea2d9a56cfe2872.1775144215.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775144215.git.michal.simek@amd.com>
References: <cover.1775144215.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1797; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=rRW3ORajYwBBQdvsDcHsADyk8Y4G+freyDOd87PtcFw=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSe69Xe/ub0AvdlNsJLfgnPeu/Xy7DKlPNY7LMNsw5v4
 2bZV1n9uaOUhUGMg0FWTJFlOpOOw5pv15aKLY/Mh5nDygQyhIGLUwAm8vs4w1/ZyXliLVy7Qri3
 fTq2u0P965L/Ks9Xlur5cV2NOJr5m+s3w39Hx1sndXkL1kjHerNX7225yPi2tCVhXh7PY/Ebeon
 XpLgA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|DS7PR12MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f91aa0c-3644-444b-06d7-08de90cdc335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: EH40iseWeeN5TaXWuwLiJFYenxLjkkYAX0JY6AysoCtweeETGYXv/GghGfhzgxeGDtd6TkEf4FrDRTiwu9m64Gw92bhMg+8Ihr4d/vrkDS0IUfLiQqd3EuwtpOmzooZ48FHxJCd6Hq9Cy5jSoOiHfItUin1drpggDFymbMndW6YeNBbxlzHVXrOs9ICttvh7g8ZllhJ+9b4+2zbXN4w6Hscz1K+WoY7hshqwD2QMQ66frqcI8F0x92FHrZxvWuDC8qmWbvejrJfIH76Fk2Zg87xAL+xb0/iyjyb8W5KWo+KJ8tvFoGL7SnZ/LVy3FsKgGyF8pmVGJ2IzOnTTbns9nzASzZXBJlnFuv6amhIXai4m+iVA3OjTKAElt5po5MQwwhJcuJiDEWje8v+HbSygFeKmZolw0W+UYRyuKIURHvuF7M+SpJILvKdp8vLPW0JpJIdICUpxDZ6vCusi1ejTgwxiT6iALHbbdnllVL0dMfQAKD9Ngkc3e2jIezEAhvkGyMO9log0n9thhv81PZAVzkW5QNQNkc7yrxKEkgxxYaK/ZzZ9Yo2hrhDlBfp1CeLigEx+F8TQSQrkpVzyRXTI0h3zvH9bbjdL0gNVakqhDOt2ATg/3A4uCidBqSglUAsaasyOqckz2cshrSNNdsk/mALTOfddA5V33ql9KV6aONLJhlNyv6oz9wj3KCRdLeT19dIPpl45qwYKMolz/4IhgAI8liofWRRaKsm7GmVg2469JUIVyCDwTlongbB0uprfN+NsYYnQDDMYG7tb1ZSMRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VTpHnYyjClf76JrBuId3UomFhVX0yLbSeebBrdO+rac33ZxMR/x/KThIWaFqn4N6piTKCzVBrlQX8QpqR5FAeRiUpIXQ5nPqgOhnQt8xhBFn0TfVE2GaJi684rxfF4QVLwVL/ETFh/pgDy0yM4eA4aG2TmCtREUqJzxaLHL9HRMYw9X/aUATtnFIJh0UCXwU87fMJezxIZQQmaKK6q23aYX00FZE5PIN4jd0ZcLycnPQK7FFaF1vMA4Az3JgxvCszSKw/tk6c1l3qiqkv1vP2H0wCMCPGzR8c33JXB9aDXC5laB52yi3BRhUZfVRkNdOiK6S4Y3WqTFY0LdN1egEMFnz02k+4gceF+8NOJLF0fYnhmgboCUSvecJXSpCP7Hi/5em2MCzvgDUTThhxh4sLBiWWSshk+/iQM9fz5loGLOan1NHKiiVMU4NJdwY/5it
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 15:37:34.9575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f91aa0c-3644-444b-06d7-08de90cdc335
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887
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

Switch fwu_boottime_checks() from EVT_MAIN_LOOP to EVT_POST_PREBOOT
because there is no reason to call FWU so early. FWU triggers EFI
stack initialization before all devices are visible which prevents
the EFI stack from scanning these devices and adding them to EFI
variables.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v4:
- update dm tests

 lib/fwu_updates/fwu.c | 2 +-
 test/dm/fwu_mdata.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 37c613014d18..e82600a29a40 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -796,4 +796,4 @@ static int fwu_boottime_checks(void)
 
 	return 0;
 }
-EVENT_SPY_SIMPLE(EVT_MAIN_LOOP, fwu_boottime_checks);
+EVENT_SPY_SIMPLE(EVT_POST_PREBOOT, fwu_boottime_checks);
diff --git a/test/dm/fwu_mdata.c b/test/dm/fwu_mdata.c
index 643b647af0a9..cfe543d8a236 100644
--- a/test/dm/fwu_mdata.c
+++ b/test/dm/fwu_mdata.c
@@ -100,7 +100,7 @@ static int dm_test_fwu_mdata_read(struct unit_test_state *uts)
 	 * Trigger lib/fwu_updates/fwu.c fwu_boottime_checks()
 	 * to populate g_dev global pointer in that library.
 	 */
-	ut_assertok(event_notify_null(EVT_MAIN_LOOP));
+	ut_assertok(event_notify_null(EVT_POST_PREBOOT));
 
 	ut_assertok(uclass_first_device_err(UCLASS_FWU_MDATA, &dev));
 	ut_assertok(fwu_init());
@@ -127,7 +127,7 @@ static int dm_test_fwu_mdata_write(struct unit_test_state *uts)
 	 * Trigger lib/fwu_updates/fwu.c fwu_boottime_checks()
 	 * to populate g_dev global pointer in that library.
 	 */
-	ut_assertok(event_notify_null(EVT_MAIN_LOOP));
+	ut_assertok(event_notify_null(EVT_POST_PREBOOT));
 
 	ut_assertok(uclass_first_device_err(UCLASS_FWU_MDATA, &dev));
 
-- 
2.43.0

