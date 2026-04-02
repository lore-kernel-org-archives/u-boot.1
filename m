Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC12D3943C
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 15:37:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4CDB84056;
	Thu,  2 Apr 2026 17:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tGTHVfaN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAF5084056; Thu,  2 Apr 2026 17:37:32 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A88BB80212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 17:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNsVLmRdBzElTMkvaqDmzVFlxKbeMuPD00FNDvBaylYcgrbgnLKCVsYt3JWX7DAyDwpFY5xC9ivEOdtUuJkC+uDyNs3mrS3nZRL+bVT84YaG1fgnzujQ2SYE9qNVM1bp/EnqjrhKEfI/oV/Eh1hbTsQQ1wvdQfK5Y4K/T12pH7EkqAj6evn4CVKz+K+PTOzXUld8EAeYJeIS1io7JW2qeFu6X23EI+mcKNcNGfA/cfCSf02FXOXoNf8b1QZhZ397/w4mU1xG/80OL3TUoyejCMBsjaM6JOzTpb0if8igXTwgRQv6ma6EOmYp6gUa0YVSrUV24onveFy1kTSSliQrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TFJAClpuH92ckVRZSQKGvxv2/djTUpjxDRzo3IuRDs=;
 b=X6oaD5UziJKy2pIJIOiugMshjNtyKjpr7TY/l4oBlWX4ijzXLX6+jjPcfTOQXRX6plAMbU218/ecInHaiTXXHEJScwEloQZqllz2bW01HZHYdhBUJ039WBQNfWPwhiltlTzIFzJCCqusERPA0fANDdJmCHhECtF9ydAX4syqn9Q3p/7J1hTyaw8howHWRlYgfPzUsVu924b/7Qs4gDGiwU87GOJLlNpLl3XSdW8QnKibhAvTQXdv15imbMahjszbYNWrEmGHS43lSjFVFk7UH3gKlQj2zHiqMycZ4nFnDFquxa0bUq4C0uY3nrF6amjICiqvUphMP+w23jS/kVAXjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TFJAClpuH92ckVRZSQKGvxv2/djTUpjxDRzo3IuRDs=;
 b=tGTHVfaNx3YKbKHtTW9Li52WoMAre4zOLi25VlOTYvnONPOkO3RXo/saOqz6ftsjtaFdQR9zlsiqMVX19dBSyl1R6nLBmTYMKeKJaaG5XRIQSFyJFxTCj+8CqHe6RS+khlldSPq8XxM5Djy+9vEpb2SFYlDuLOvGFz3L4LkhaCU=
Received: from SJ0PR13CA0136.namprd13.prod.outlook.com (2603:10b6:a03:2c6::21)
 by DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 15:37:24 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::96) by SJ0PR13CA0136.outlook.office365.com
 (2603:10b6:a03:2c6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 15:37:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 15:37:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 2 Apr
 2026 10:37:23 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Apr
 2026 10:37:21 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 10:37:21 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: Jerome Forissier <jerome.forissier@arm.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 "Yao Zi" <me@ziyao.cc>
Subject: [PATCH v4 1/3] event: Check return value from event_notify_null()
Date: Thu, 2 Apr 2026 17:36:58 +0200
Message-ID: <f8e89783ece4070d90889b730222f09ef7b40c12.1775144215.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775144215.git.michal.simek@amd.com>
References: <cover.1775144215.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1943; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=e/ATTfThTkr0LYgVDSD0/s45WOXVXYB9VZJLx6ipyok=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSe69Xyz5NvyM1UcPLRkOTT57uQZcgzQXJ9yCPLhL1fN
 yTICW/pKGVhEONgkBVTZJnOpOOw5tu1pWLLI/Nh5rAygQxh4OIUgIl4ajIy9GeGf9+9vFo6d3Lt
 4S231I7V9m55wMdV6m+1T5qd+91cN0aGDXblx04GT+x5Xcu3542eUZGX5pVwq68rbwTH2ieaiBQ
 wAQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DS0PR12MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: b259dd74-5d24-48f7-cd9d-08de90cdbc54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: NQvx1QO8hYriClCrC0Tu9u6xsvpzkJF2xctYwtp2CCy7JYDwJDi85HB+wwLcsqOsi+70IhdCtK2B7D4yA1RSm5U9T1zBUSzP5acNyRZkBb5c1tWXTqitCBga7kisojEEw1zFgip2ApQPO/QHh/wrd5l+TZX2RyIfCNrnGfRVv5zT6aLSPb73dU10ueMP5FdopZkhXxiVCsS0yGUFQ14G7OB4zKrMz3/bGdVThLccEsAz9nyP6+7YY5AiIOtg4cGSWUPpWuv+UFTemuRNxhUNsdcRahN+NEz6IUSkVV6xGJ/rA1X9gErLoJlDqdYF/X8bZT/D0XJUVEGDly+A25opdQiEy6JvWCA1E8xxBDQfrkJSYNr8BM051UStH/YCUqzePR+wvxwRSiMQ0HNvrKHh8NhMfAK/DlynxrmdNOIDDylfwkr017YjztCHDY1GQJDy+Cy3RGIy94fl2PEbry3puIZ1Kbv3J8yIquA4kiEU9a+cqOd91dinogiHykTvBVhtILi/oHc5Jj322mTFdj1nnZNc91sgjlTipD/O+vqzfOhL0XkvZkLdiP4qMcLBzQiqM8Tl4BPsqf0q44VIWseusqo5l+yBGo6bGlXvRH7HUycDOj2Z2AmR/xCi+lGH75U/wHUzzm1+gBL8/w+VAM3wXp4TSIzzW2nqsYI29aWVyuP3wy66JxzO9IEJ6wKrTo8hxBD4qqECyw3KPfxqRr0/iG6yIG662+J9/boaETdAE+9vWNpQKSHCwdmyUYa9v77eNzsNlp3xsJqKtqASshc67A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yMt7RhuYDt3nTwEA/DbT7VXnzN5TRXw+Nab3pFj6b8MELYJAi2ZkAA+JTn84OSMGxOyAMUkyE0mBfOTd/yRTqX9v9DKfvut5JpYjXoSIJsAgWAl1GP2Ve7JuJihuSt0K0Avpo351xolcesD78aD3RGrAK0YRNO8Zhpix3O4n5ImdO3J/91BABHUeagglzm9+pBiiMWyh8TWeGaTkrsxOuGLTD6DRx+3JNRzv4lZU5xiH47zXCYCU5RtibeVvG2lJHZa5fs9aCelue8mElXlaCMWWxnG3V1T1KelF3Kk1sA3n6OfOn+Oqa8u22jlU7XTDi4oQ9+05szYmjo7lyLUBH2pweMCEIMMTilptujIcLdcFgLmdydTUs4QSy7hMepv9LYRyzCVz4U1MwSdeJUACA8S8X6/VaAs6FZYBNeYg/hxQFjbWOoJJ2yfFcfu639MD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 15:37:23.4840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b259dd74-5d24-48f7-cd9d-08de90cdbc54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320
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

event_notify_null() returns int but its return value is not
checked in run_main_loop() and in fwu_mdata tests.
Add proper error checking to all unchecked call sites.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

---

(no changes since v2)

Changes in v2:
- new patch in series

 common/board_r.c    | 6 +++++-
 test/dm/fwu_mdata.c | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index 8cf0e14679c0..5d37345ca09d 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -569,11 +569,15 @@ static int dm_announce(void)
 
 static int run_main_loop(void)
 {
+	int ret;
+
 #ifdef CONFIG_SANDBOX
 	sandbox_main_loop_init();
 #endif
 
-	event_notify_null(EVT_MAIN_LOOP);
+	ret = event_notify_null(EVT_MAIN_LOOP);
+	if (ret)
+		return ret;
 
 	/* main_loop() can return to retry autoboot, if so just run it again */
 	for (;;)
diff --git a/test/dm/fwu_mdata.c b/test/dm/fwu_mdata.c
index b7680632f95f..643b647af0a9 100644
--- a/test/dm/fwu_mdata.c
+++ b/test/dm/fwu_mdata.c
@@ -100,7 +100,7 @@ static int dm_test_fwu_mdata_read(struct unit_test_state *uts)
 	 * Trigger lib/fwu_updates/fwu.c fwu_boottime_checks()
 	 * to populate g_dev global pointer in that library.
 	 */
-	event_notify_null(EVT_MAIN_LOOP);
+	ut_assertok(event_notify_null(EVT_MAIN_LOOP));
 
 	ut_assertok(uclass_first_device_err(UCLASS_FWU_MDATA, &dev));
 	ut_assertok(fwu_init());
@@ -127,7 +127,7 @@ static int dm_test_fwu_mdata_write(struct unit_test_state *uts)
 	 * Trigger lib/fwu_updates/fwu.c fwu_boottime_checks()
 	 * to populate g_dev global pointer in that library.
 	 */
-	event_notify_null(EVT_MAIN_LOOP);
+	ut_assertok(event_notify_null(EVT_MAIN_LOOP));
 
 	ut_assertok(uclass_first_device_err(UCLASS_FWU_MDATA, &dev));
 
-- 
2.43.0

