Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F276AD3943A
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 15:37:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31227840AA;
	Thu,  2 Apr 2026 17:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="odxGeovp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07725839DF; Thu,  2 Apr 2026 17:37:39 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF37E840AA
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 17:37:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gABEi9oZ1ni3w4Ck3pDStqzOck0y/F+WaBwZNX9rv5xNOg/UJwUpO669MAhvvWfx/T7YhOGXPbCDWC2JEP4eXzW9gK5RSDQZpSu4Pj5Gaq6VAPj3vmm8t3UoNyQPXLL+PijgHQuzc2IPC7UiUStLHZuJRm+qMBYR+ZeOaXHwLESMCN0FsVqYuET3NGH6UYHL48BZH5dVOZ+KpwASKlDyVsICuHX/cNqEblUexXlQLpzY3q7UtOn2ZZvwr/zVj6LVW42/qPt2eKnG5bgG8SBZlJv44Twmq5Xq34wwWnXBP90CxmF71O+PEHKh/odVfKPU5G5dOFtkfkpmj9HQKhVtWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdQ19dtulDI8idvBo/VLAy597uFOUPEK7BwmNBIJIuY=;
 b=zJG/lXkSwy/39jT6mhfnSR0hYPU8+i3Xmo37UcbGAMosCgP0UHcrbNypFfBGlYICV/PyZne87h7ZmxW0GTS+bw7bu8uKDhjI736SFW2DULePEy5+10RBmjCICwnKg4aSy2wTBt4lTR9qeu13NCCjfssHqlFzryMQKTQZBevOEhRmxEBVVpBPZK+MmXlPjIYXkuMD6GRSSRMVabWKaVenIOEncAaLL7ZugGhLeljDlg8AN8rDZMbguuW80wgi1DqzWEHgDO13FpSnhVKPx/of2MRAxOYm33ppTx4mnGTEHBND3tfhIjy0f3Yp6CCkNnMA6hV7Mrub46dktYmjpRRSJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdQ19dtulDI8idvBo/VLAy597uFOUPEK7BwmNBIJIuY=;
 b=odxGeovpu6Csw34S/DQNq41KzFb6zLbh2EM9x9AQhJlnGz86qAx00oqSTNXvmgTrIB43KxTqayzlk5DBjmtVy2Dg5HqEye5AuFlweFoL1VawIVGQUK0CoNNIJSOaVTTp/ExDLruO3OxTPFDfH3h+t08g+ZIzqgbhPXAdowr6/LM=
Received: from SJ0PR03CA0054.namprd03.prod.outlook.com (2603:10b6:a03:33e::29)
 by SN7PR12MB6813.namprd12.prod.outlook.com (2603:10b6:806:267::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 2 Apr
 2026 15:37:32 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:33e:cafe::e9) by SJ0PR03CA0054.outlook.office365.com
 (2603:10b6:a03:33e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.20 via Frontend Transport; Thu,
 2 Apr 2026 15:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 15:37:31 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 2 Apr
 2026 10:37:31 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Apr
 2026 10:37:29 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 10:37:29 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 2/3] event: Introduce EVT_POST_PREBOOT event
Date: Thu, 2 Apr 2026 17:36:59 +0200
Message-ID: <5067efed56def5f41442d7b83b84c2963c9b263f.1775144215.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775144215.git.michal.simek@amd.com>
References: <cover.1775144215.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2061; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=cP0kvn7zDZjOjFTAWnonq0X18fO5akwJOOe1oCcgC+g=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSe69VKkuzdxuCxWTDWl0vr7pnNH4y8DAI5ToSLri6Jc
 pUSkxDpKGVhEONgkBVTZJnOpOOw5tu1pWLLI/Nh5rAygQxh4OIUgIksdmVk2H5x7psXKfPP/tXK
 mf22SfrwhKqyKC+f5V4zMqamvRb79ojhv/s7sYJlWm07bJY43lmqYbg1m9nt1NKKe3kylmk59Y6
 NjAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|SN7PR12MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e89084b-1931-486d-c9c5-08de90cdc151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: YrhUYBO7hDMZ0Ri5gA5DIVBqBXXRDwzBPOc58JpAmHKxfhYGMI3IlaQYPg+uXwna3y8YLwGnMNLHEe35tX8hcsnck3lSXkaR7FeD7FBuzbgEmDMhPKjFm4WWW+hWN40WWGUjD2+pVPP6jshW2xftXh+WqaflqZ/T3x0nncNwWwnWLAadKEvfdWmgNpYWPsEmPmjFJKM1ifHAfCkWxPbqwzVD1A+C7N0tGNjMrmATsZlGlgxuRLrFcpYs7lEgm17nePoqUq70mRH+EWVCnZ1RkzXwgnkEQuCCBFjg1THrRjUrVyccR4gaGlzxWnGPREW8mbNc5n8uERxvYlKNlb7Qcsw5u9v0Yk5z0lvqHQOQKSJk8tWaZowhda0CyUOr8hrVwwTT6l1CH86IKWPD58MHFRRLS71dApjvjQoEkIfj8HFQc7yj1JLwTw7BHeKNoDpMlDo2iMv7Dp+O5DvwrSmfYMmL7OFnGXvkaQtSFPhCrjPbeyNn8Mafc9flOiD39C1+zyVO15k/nCO44P9bpshrxDcc5PwRxonP6WLiZBdu8yj1XYWQtb+akQkszyJpjV6PwiiHHOrqjDM5Geb3zcNPgAyVoSlWYFSv/yaUQES/wdc4xGo0AA6Un1DdmRQ2TmEz8AhXGKkWbZ6IPl4mnogTPYEFDx6Ibb1DtBXCCjtV5rX6KcmD4bdTBLIG6YwcWK/ruCo9jv6U2NXdrivnFDgpRKMdnte+5vxgiVbrkVH1qylXjbPa2VY4Xvng5CxTtjH1qRZDz/1IMGb2bWFvEXTIWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F3u58ov/0YDRq2dLt0KnmpvLtEqAieff9Ewk7NsthEZdpuL4sdXUNGbLmv1ZRYzP88IKgIRg9bzl5K+s6/4/tjeprz1xOc2O9Lv1bPoeiCaG8houq3hUOCOW4SZpbXwKp04NqeogH3NzecrohJnahrADiv/hUUbq5YchRt5baac0trVL+UQSxOXqGb5thbLqNfPGbw/gdGbHe7my/jK1osRBmj57uA5ttlHSHW9cJW5TYXaLaR3enI5o4v1kusqifaCdV61jWjAtNsj0UxoTGsmjl1y0w0Xg6jWw5nEIhDPKhoa/8WbsfD2xCnDqzOAa+aRd4s6ATv6qWzd05m4MsM31P9e7cl0PsiPuFsnYjnwVRSJcfmSN2sO1EilGi/Pn08IhLqTyJL+Sj/d6nYw95xqJvEas1Iim71LcVIYww0/bbdP0yL19NZ0weMYXDN1k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 15:37:31.8358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e89084b-1931-486d-c9c5-08de90cdc151
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6813
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
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

---

(no changes since v3)

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

