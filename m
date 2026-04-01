Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0EC1076372
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 06:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43F5084099;
	Wed,  1 Apr 2026 08:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rheRnHDK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21FBF84090; Wed,  1 Apr 2026 08:04:36 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEF5584099
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 08:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxPmyStRbWQolJv8+PUtRQO1xQyPRt4C4dZ3CDAkVo5aZBTeBjGwzoFlvSEt5Gq8cqSQWOQbJyX8rQX4MZIYUtpo7BCnyybZ9jMPg2bde7Q4tw1MGuwSvpK8F3YYv97n7h+8hkw0ps1lHWWJXkYXGAzy8li3gVPrOjmYAjKyjgMYmycEFNcmq1tnFQ+YkyzttvoCsk16RE7qxeN3SMYgdwlI4rtfZAXHjBugfJlJo0h7ESw9+dgO+Gm2TbQAe5uV3/cbIprOOWQEVYfe3OIxFLD/bXncSpdJYhLIBFWtQWb/Wl4I/Yk1vtq6j/0zZXZOTyaBcd80W0FfUKCLdU5GBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1OiGqWBZktCmbBCo4ViYYvrNvysqb8tZncNw79epwE=;
 b=r8TRWbF6HC4E/hScoRtwxarmrrvfOIpi1R6qQLBWFMoyZBMFs3f+vStGn0miVRtbubPSW/p8nchqlkEvpRmm75vnLZk+GkOci4rxX5mb2HummxRCtKtzesO8YlAgFXFCAnlz8j1QKHpRprlqaP/JWA7U39F47W+mZkwsgLy52rYTbqoaK4cxHrHc5soy64wak4xVzuqbuZBtVzQ479MBccJvRgCczTLqCu5i53wDSI/BeyO/OEKCPP++OAb+boZiMITgmbJIu9Wrp+6DHZUDyjHuoZUngN8dICO+E139pCsL5RY+Ij31GWUxfEjs6obC/qz38CIF1Xwz+B3dLLMqeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1OiGqWBZktCmbBCo4ViYYvrNvysqb8tZncNw79epwE=;
 b=rheRnHDK+bZdBnaVCaiem211Ar+q6xHUo6y02bF+bJxkIXvRoOGr4HZMUs2dKPsXmVyH98NqH6W2oKg+BQ9X9OB5c5t3CoWg97fVY/gxomV+KlQ7KZ6wa0oai7HAoAgO/UASzqtwtqMRZCa9EDPBecWBwZR2t8OkueOAzVeH7pM=
Received: from CH0PR08CA0019.namprd08.prod.outlook.com (2603:10b6:610:33::24)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 06:04:27 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::fb) by CH0PR08CA0019.outlook.office365.com
 (2603:10b6:610:33::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 06:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 06:04:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 01:04:26 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 1 Apr 2026 01:04:25 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/3] event: Introduce EVT_POST_PREBOOT event
Date: Wed, 1 Apr 2026 08:03:45 +0200
Message-ID: <ae0079a2839dceef08f3324714d45fb48d5d7100.1775023421.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775023421.git.michal.simek@amd.com>
References: <cover.1775023421.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1976; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=T/cGva4hXoG7w9TnsMuwHQ2paQ0lMfy68D8biPoEpE8=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSe2RoSKeIhKfNyWp9EempEd9CZ339f7J6b8dWe+cGUs
 NaDzyKjO0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAi768x/PfvvLGVWdBy9Z03
 s7fVqey3sHHO0Zh72tX11+NtDXdXPIlk+MPVNS1q+6ES6WSeyWoS+Z8u3hVVTdPdmK60Z2nd9YQ
 VGowA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|BY5PR12MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: 0605ae7b-462f-4e8c-c919-08de8fb48817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EUiHquzeUB2rilXZrbIdOByuJ+eiVWoqp3bMfuBKyOroFDrzKHTLLU/GQYfUYtYFxuBQjR41iozfN+otQAvfAiFkCqtfjccsykxawe3AUWG3hjULo8zUJkG985z/TR3+VKFFvHF5Q2FnoeQQ7CXaX1xdU+1w6DmNayaSLjy9+9gyWKp4Zi5oQoZdZ7OwFoBwXCgj3fsbDxRN3H6LyGL1pFEaE3WyToHPxsl95wmg7h3oR0xlFFgKtvJPWtwxPhKSai2NGYGbW3F1inP0WjnjX74XQfe+bdyFUnZYle8/QCx38KiabSdnDPDigz1jyQnQYDyVKlU9H8NLNmNRWuBeYD9TMKTjvm/0AL1582Xge9WmrOuDl5FInOPudHdCsRXJQd3KuRRVlXrAyybHT1fV02xpPA+03jpHHeUNJS9FBtY2e2UaXGRA0fMMzCBR+uI8/l09pWcbIknaxU/Yvz0/w0QFYrLVJQSZJ2cfTkkUQ9btD2KXMWt524A2Fv/IpxqEo3VKFbH+W4JNRc/zqBrDSrVXTELIa//JCMbb2zjdh6tuSNZplK82zTzS4jnezmPqo6DIkaVIorB44q+CEIGd8q26EDMLrkfzCKM7mNkKD4WZN4W4niApYBx0jN8s+cBMS5QO6wI8EEqzepzPTvNzIcp9afJKTNRSfH4jHyKQip1/g5QoQDQARk+aIg0xwch4BYRojRkkA8jcQr5IZjRyeX4nuXkfzjKRDrNtMYPMb7PlwQejsPTQdH1ZbpfEhM0d1P/j3m8+AxGyhYDTs5IVZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sOvLI1hr8XgkZETd/cqB3VhkAjqxDbF8cqhjuodD3PQswg4p5zgywjZ51mYgp8FR9R8LP1Qxhxg+vE/QYeI8PGdOph8p6elU2OfxDO9YpztdO36Ns9iKG+iPKwv9KaTBvlByYCE+3viAZGMeZkxJ9j9mdI1p/MzoUngIBhBbYBYoDH9bn+JW2iifNWEmvJMYSW+NHSohWlFgW02y6Sh0O1GqR1ZU9Ka/JicyZOUJu059QX3IjQtdHbhZLbLAG413reVub82iox0Sjo3NWZ8bLNGxTyzYsRMBxtnWI8hEe2fWkqJjDkxSvKL61WVUEyCD1fDA4zfr+wubKlMNCpmYd3pR/qZZZ8xM9CfkdPMLQrFTi48MViDLyH4VNxczZL2EKdhU8f4OAZ5Kvojxj7j+Z7CA5Zq+JpIxqaEiJzLyCtnYREPQKdJqUW0523IGA4cL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 06:04:27.3054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0605ae7b-462f-4e8c-c919-08de8fb48817
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081
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

Add a new EVT_POST_PREBOOT event type which is fired in main_loop()
after the preboot command has been executed.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- add missing type_name extension

Changes in v2:
- check return value

 common/event.c  | 3 +++
 common/main.c   | 4 ++++
 include/event.h | 9 +++++++++
 3 files changed, 16 insertions(+)

diff --git a/common/event.c b/common/event.c
index 8d7513eb10b6..398e713d2f82 100644
--- a/common/event.c
+++ b/common/event.c
@@ -49,6 +49,9 @@ const char *const type_name[] = {
 	/* main loop events */
 	"main_loop",
 
+	/* post preboot events */
+	"post_preboot",
+
 	/* livetree has been built */
 	"of_live_init",
 };
diff --git a/common/main.c b/common/main.c
index b0b6e74f5d3d..4b4504557f6e 100644
--- a/common/main.c
+++ b/common/main.c
@@ -19,6 +19,7 @@
 #include <net.h>
 #include <version_string.h>
 #include <efi_loader.h>
+#include <event.h>
 
 static void run_preboot_environment_command(void)
 {
@@ -53,6 +54,9 @@ void main_loop(void)
 	if (IS_ENABLED(CONFIG_USE_PREBOOT))
 		run_preboot_environment_command();
 
+	if (event_notify_null(EVT_POST_PREBOOT))
+		return;
+
 	if (IS_ENABLED(CONFIG_UPDATE_TFTP))
 		update_tftp(0UL, NULL, NULL);
 
diff --git a/include/event.h b/include/event.h
index 1d267f1d1054..3ce5f992b04e 100644
--- a/include/event.h
+++ b/include/event.h
@@ -153,6 +153,15 @@ enum event_t {
 	 */
 	EVT_MAIN_LOOP,
 
+	/**
+	 * @EVT_POST_PREBOOT:
+	 * This event is triggered in main_loop() after the preboot command
+	 * has run, so that devices initialised by preboot (e.g. USB, UFS)
+	 * are available to event handlers. Its parameter is NULL.
+	 * A non-zero return value causes the boot to fail.
+	 */
+	EVT_POST_PREBOOT,
+
 	/**
 	 * @EVT_OF_LIVE_BUILT:
 	 * This event is triggered immediately after the live device tree has been
-- 
2.43.0

