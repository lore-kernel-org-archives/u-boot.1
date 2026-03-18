Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2119103E173
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 13:26:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 981AE842CE;
	Wed, 18 Mar 2026 14:26:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Qm0VnH4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A86098428C; Wed, 18 Mar 2026 14:25:57 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 828028429E
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 14:25:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dg+qXhk0zDi5yJPZrhbcc9MFOCw/OQSc7VmUgEFcRcNOu0G98e4ZsYkbw5d+KNSTe0Jw8zudnBNiVHuEiOo8YBFjkP35IgP4tJe36Qd/sBjTv1CtJYLmXIcNh7NQ12AtD8Uf+b2PeF37MFbTj3n1NNikNLNBogHa8kwxRmxhL+xteCcA2zXt+V6rUbovIYobxbqELzbBNoGF2LZ7a/WgtgJIatVm9lFllQNBCVRaQCMtSgXWRtqkpuvSn4pmfS9VR1fO9xsvUWJ/Jx90Mk55G7BrqPk0qcXKdpNJS3JgXLDZKAPKx+In4XZHOSYFU+wKT2mc79hbAOKjMW8lMJ8gzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qh53OcAfkuB0BBJSrwM1vwETycPg3V8f69YyFiGpt8w=;
 b=Bf41Oy7gmnWBx59m+broFpWwYdqHRow4RzHRrDkgOYhkYDgZTqtVdCUcdWwFQGQA3woQMS1Rg0sGApHoVGHcVRoCc+86iuJYz0olqDdJG8UmDflwqtkyHD5DMRiuBm7gJd/pTDgciWqHvSR69L/w1K6NYs2iHbkOajk3YwHaKAvlvHPFmX3or7GjpIzklyEr9DhTF83ILcm1/Dni04x0/w9qsH7OcXm4tPZgHZiTWPuX2hhT4MPgiImRy8ohGRoYqEpOJnRivBl0YMViSGKx6lVYJIFvlal64DGZ9YewNC8FdQGZPvbxTVIh4K8DTncNMaqtmcWqLQqKw7pJO9Ww5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qh53OcAfkuB0BBJSrwM1vwETycPg3V8f69YyFiGpt8w=;
 b=2Qm0VnH40fHLyU5HDAtOUaUNjqsybk2Vm6x2zh/D0/G7zR6b9tkOBWAuBNL4s26dlNn+iATxVHybDF/bC4/CZkDHmcinhvJgWAMdwOl3Obp8QVfC2xAEZ+V5z/oovzKF2zrzNB9xBwxsnVwoAZivJqgVZDNt4B45EcsbNDiV36w=
Received: from DS7PR03CA0052.namprd03.prod.outlook.com (2603:10b6:5:3b5::27)
 by CY1PR12MB9675.namprd12.prod.outlook.com (2603:10b6:930:105::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 13:25:48 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::47) by DS7PR03CA0052.outlook.office365.com
 (2603:10b6:5:3b5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 13:25:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 13:25:48 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 08:25:38 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 08:25:37 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>, Yao Zi
 <me@ziyao.cc>
Subject: [PATCH v2 1/3] event: Check return value from event_notify_null()
Date: Wed, 18 Mar 2026 14:25:09 +0100
Message-ID: <b1f57ff8f3a45d0118e01f33280b48d92b3b2397.1773840306.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773840306.git.michal.simek@amd.com>
References: <cover.1773840306.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1813; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=qmigavnYP1/kxq6pfHPo3jnplNWgHXGJc/tP1zVOwtI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTuWn7wF7OKzcVDm51Fn7RsPPI0vUGXJdNBPbhF9cH+s
 5FGtfs0O0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAikl8Y/rvtn7Z0dV4d2xSr
 ebttba8v6OE9qR+VVnTumlnsbRehxJcM//Tdr7Wd4ihfxpkmGf7ZIvuqp8cTY/vvbAv+HF0y3zq
 gnQsA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|CY1PR12MB9675:EE_
X-MS-Office365-Filtering-Correlation-Id: 2576a49d-daef-473a-7b3a-08de84f1de31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Tt+GePSw6PsxzA9fgsGU6N+mXkQAoQzUCm+y2Dm1sqNb9aZZJfpCaW851CC+vPi9kQEUTWtqQ+69v/clFasq1I9zvrICrdPmA24xurQw2YIn3y30jUF1XBCS/wGt/JPOT29yzKXWvftDckdef/ZufXXmRXAqXC21rThLHXw83vQfoi0DglHlSZ5FGtY83jln68skfW+zxMOhVmH0PB3JFYlqFyiK9XLNN89TDiHZlVVAYMBxYOLCxkP0KrX5wJMbA6BKMdO/uE5ManzkYp4uMKoQCPZu1/prFyKgQkNaqY1iicCrklBs0NZi+H3r9IE1eVo5AzLtjHw5su0emB2/k+NlH+gGQH3Gg1cn2OQpTbWYafikpfG6rLFnJkmlvEubcqmE+mKsXue3J1jkXqVu8bylBcTSxIMNtUp1TGS3UC6A9iOJoM6VPjeWJjXE2wPP601rTwSa0GRjhMCSY/xs0H9Xc64FoYHsZfZB+9vkqJuZ/Jzh9vmvGfoAgxCLab+k3BEpNAvsMXn6K3u0LbPQwIjYFtdujNJUpDxW6l3b26pK79OshQPUZ8N3wqLGxrMPtHpCAunk5olv5cskrVLIRXsoqQGxPo1OmnPPTgWXyUbHeEhnKeeYobwlnJVSqmXsysZi2hkG/TjkFBwqlI+58LBeyeJUPjF/uoh7XF6VmUDFidFJUP1bN4jSIsyEgcuFu9K8iueDIKMtU3VADaw9R/kbXhyTYzl8BE+idrJR+Bk54VJJ5UKo4nFhYLyBeI7hATvvwUJWWWfIyj5dN9CfNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 29MJ3H8OIKjxe2P2lCXnR2BdnCGZa8Z91338DAq2leCoKc4/ySt2yozt6Iae1h0Yzd9Jbdf5AiMWQoh3y5/M9ITgucm26NgDdORzwPmSyDicWs11x74q7z92ronM6hHGYqhQ2Bp44ZRdSYCiCDyGY0fN3HYy8iCdXG4VyYg5ybOclCs6tAWtnfDYhBKAybFNy/YNC4atbVlGHnZ5BPawFFAPozP+4e9/Lw6JKSmnDlncWqvKtHJ7JcNyN0+zv26zEWBCync9o7gCw1tWRCUt5yCDLtHTcOnUj8j9rsJ2ir5SgbNzuFLjRqoruNg/L7lUq8PWcvMfxT525yGvaYauZ+S20EfmEMawPrc37p4FcxXi09E8b2Ve5IMyBvqp4mZfX4t1V6gzOp9/7bbDeAq0OtXZ7oMAUHNx0eSlhyJVaSMukma8j1ftBta0GPaAfSMS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 13:25:48.2510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2576a49d-daef-473a-7b3a-08de84f1de31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9675
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
---

Changes in v2:
- new patch in series

 common/board_r.c    | 6 +++++-
 test/dm/fwu_mdata.c | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index 76f9fc090fbe..00f29385d80a 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -579,11 +579,15 @@ static int dm_announce(void)
 
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

