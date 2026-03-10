Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8683FEB1064
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:00:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C5F583FF5;
	Tue, 10 Mar 2026 15:59:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4VAuCQyg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FF258404D; Tue, 10 Mar 2026 15:59:53 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD6EB83FED
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 15:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3BsjeScq3TeqP6T4HWrkJQ6ZHPaatNA3wEa3KuxwugJSvujYOdKay7Y4R2FArx5lu3yy8EOVRFs72dTv0HwJY3eubh24B7rM1jqwmXtspiUBaC9m58yP446hRGTzOugfbuZiOBzfWT+s5bSmiVBV/GXLcyM4h9qbupYLu7iBHtav9ZBsfBdXk+oJvn2EIrylYtcavPI2A0VfKfcK/sU9KogMCatreagW0lML76leODFBMSHSvdwDLiIqKy+qbz0sKMGSfn32xYbsWwHAYbzV9UNZ3dndsz62yIW6BuLLlILzpACSXrkAfszCKAMexYvp/vS1rXXbcocAA085Dd6iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0KYNkLvHNy2uJArTv8WFZVLw2iZ/rQbSjah4HMXm3o=;
 b=q0hH0giZtXl9y8ay/rSbjm8cfh0v7iJBNzVq1BHzqP7u3TNstUweN6bCkA9n3+2kjdbOsA3/YU+1pj8I7k4t5JuT1lgx8JNXGZSwfNXuVREvhW+LhAm/Z+kTrpu7B7H4fiehlNxroiT9sKeUMlSjV4bsIt6u0neFLAD+DGWXFemH0U3lQxabZijcF7gwmXuy/HzqBzXsCjY0H0omxQt6slpB2MWwlcGMMUJa2ysDhMQInLgIIZO0MaRF7hnOR1vT8AflvjFqTBFU3zl8HMK5lKudx2GFZx0d31fGMz66D1ZZrcYYg2URRS1MpeyGOW7XFPZ/L3vcwRgXn2dLD03BAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0KYNkLvHNy2uJArTv8WFZVLw2iZ/rQbSjah4HMXm3o=;
 b=4VAuCQygSLqYhMZzyxEl/U4Canz0Esq58ebqCaN3X+zG4+GwuPB76TdQGsXzAtcYsqNrK2wIDwK572ELczVesK3Ytb3Ht8huILGqxUJZM9Y6SCeK4y2hrKZwnU1Po7vQUka3w1r0rah6GJchxgB9OtUR5D3QiUATPZqC7Aieeto=
Received: from BN9PR03CA0914.namprd03.prod.outlook.com (2603:10b6:408:107::19)
 by DM4PR12MB6352.namprd12.prod.outlook.com (2603:10b6:8:a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 14:59:46 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::1) by BN9PR03CA0914.outlook.office365.com
 (2603:10b6:408:107::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 14:59:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 14:59:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 10 Mar
 2026 09:59:42 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Mar
 2026 09:59:40 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 09:59:39 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: Casey Connolly <casey.connolly@linaro.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] event: Introduce EVT_POST_PREBOOT event
Date: Tue, 10 Mar 2026 15:59:27 +0100
Message-ID: <af02d5e56fa0fe48548da2a52d08710f3d7d5213.1773154765.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773154765.git.michal.simek@amd.com>
References: <cover.1773154765.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1458; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=p+mzlWFdW5qojLp9L1dkALPJv3NxjM6JIfrJi5rCTBI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRuMLwgdjyL663pseCfPfpPxC9Zuz7+V36D/+bqeIkFT
 bu+OX+e2FHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATuX6b4Q9PZ7zHvTDBFz+v
 rzmkY9wg9uvDPIWbroaapgrlkXZ5j2YwMsyJfi1oo7U5Lyb+h3/udfZnpw7c3b7n5vL5vG+cTK8
 feccCAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DM4PR12MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c3d37c5-bc4b-4e3b-e2da-08de7eb5ab00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: PmdiQavwtrtV75Ew3h74T30MfWFayZ/gawt01EOqs2mbE58NLJCPOt8IkScyRCt1sItNHEIjjLV4rIH+z83++4Gbb2ebCuufdWoDmytLAVTtE46WabGw2aBeoCd5DOFnzdmTRzxFsFtCPsnCiAH8OYSgnRkuuVOIkVjZpa18e8Sh+UvxNE2l3IEti2rE+SZdK0xq5RJPX9LAijXbFEciMUb9OqYfv9in869bgQ6QkRtrAVICMf74J1iPQA52IKT3oIBjIYkER/gbAXSYu/W/6EPogwwCqIiuFYTuuu22LjbRnSTw6KG17SKrDbp1VlxRyGiZ4NHaic+9Ft6Bnh7dhToRMOYvJZB2AJqh1LhYlSU/XejYN0GtqwupIor5cLOJaErFjsoLhDzLL84H3ojMRTYzTZQ6SDOKmXdvaYO91dRNrtvPg0k0S9O1AQJUWgrQZpP1u2JoxsP/I+/8pnzVSBf2e5WO+aEKbmCjSCo22B/fc+QVBh4gOCUQhgdcJ/pRMwatLJhBuf3QiuJY+t85OEWCptboKV0Akv4WOgPRePTud/YX5/zfeRwltMi2dSs7t2X4OQnG/vavCQHh2YTmBdxf45+GGPefWoP+7lGZOMFgUDXt3hm0l1Yb/Nw2z4rt0ck2GgQOKTNV7Azn8r4y5T+sRuoptGErahLsbd37LiLbZBIqpzMgXlXvagj1O90pol0lfUaYJvj4Rn8UCBaGA125CMnN41jfeq5a9i7Hx+vERCjl5vz8ohrHfq2OXdtF5YLzvp3yd2QWBRnw5/lV/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xpGKPDe/VNg00wsfccm34FPDy/2RLhPtKO0GzdT+ujuJwoRyOoJ0piszvIwolU69h90RY+2aJZK1jkke8H4F06M9tFxeS4LIIfnFrL7TAWjPyRawGZt5FQpZQzUTQ46znQnmghY7bSTpbbdQ4Op/3O0Cv5Ic2Uc0Q622c4l1qf/gyHrNJCliBUw5YunzpZXGvEoXIzxIJdR17qd0JJrUjws1PmUG3ZIvTl8catMtU7tiBs0OclB4Jsvy6B6jqpqhbFvfl4xQofe/J3Zx2QT0X5KdpYqNbpgNaA2g7CZ6uyoPyXawRURkM3wif1NtzFeMqE6yo6Sdt51e3NA92rdl3lTwh8mfV/P/5PNvmMvlO4uSYdMZJz6XDNwr3dRULz8h52cQr5pc9o3xH9Q/A+Frj8GP/N0jZLqIvFIh5bR199Yhky7OU8g3GtuEd8PcVCWb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 14:59:45.5883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3d37c5-bc4b-4e3b-e2da-08de7eb5ab00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6352
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
---

 common/main.c   | 3 +++
 include/event.h | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/common/main.c b/common/main.c
index b0b6e74f5d3d..e8b23f3ff293 100644
--- a/common/main.c
+++ b/common/main.c
@@ -19,6 +19,7 @@
 #include <net.h>
 #include <version_string.h>
 #include <efi_loader.h>
+#include <event.h>
 
 static void run_preboot_environment_command(void)
 {
@@ -53,6 +54,8 @@ void main_loop(void)
 	if (IS_ENABLED(CONFIG_USE_PREBOOT))
 		run_preboot_environment_command();
 
+	event_notify_null(EVT_POST_PREBOOT);
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

