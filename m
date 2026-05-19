Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2BACD4F5E
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 14:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C435F84866;
	Tue, 19 May 2026 16:18:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rbONlSfw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2B108486B; Tue, 19 May 2026 16:18:00 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B27A084866
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:17:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-jain1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNXsN8HFtzpIxzaTJMdne5PjRbRfyfVxuIJvfmoYU1tr7cZfY8Ti7/0g4/RZG8TDPBvIcDxRglMU/ei3QM7J45SeR/SPERBKXu/ZI7fiD11k/yq6WoL70e4uejoc7dn8391ckgO4IIc/XgQlpHXTm4FbuRkuM8i+qBtLXiuazEZ1SATVdlI+Ga5lunimj6tUxHBCVfL2NwD4xg+AQBlKmlQaxP1AHY3lVa+fZhqQQIJpfW+/mKDHx8ySJqw0qsobEztaeEHuw7tzeBg0qMoKeKMMKAQnthWc5fz/YxWPS4pcCo20XXArvKYgr1WfDJ+eeJ9J2BooRsmn1nUH7QuQdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vwx+JbFjv2yyYlLXuEtHWQcqjRVK1/8zFjUgBooIPbY=;
 b=n1NqP0H8LFNnjSuyX0MxPmEr0JRyd78qf/Uv/Q8VZYrTkvFwfbl/M44N+oWv6YT6Ft2HP+xoS1UWtb9s2C3ChzIUdMQnOjyBSw/fUN7HAXKO2uzxNsj94E0oWmVyGP6sf9XQBOtUU0TSFkDuuiSja1IGIWkJxUuXWg4H63HoZpmcPphAsvxu4YHSf9knqUcAagDE51LDOMiTkuH0v3PFsQ5DvtqofBre2sZZGptyjnbfjl/w9tD7era7f5GBbU2BuAiE6JCs+Jxelptlxs63eLKZ1vuAAzKyZ84vgRkI4pB4oGy2MMnIx0itoqflLyFBLz4Gv2LAKy7MOcUot6PK0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vwx+JbFjv2yyYlLXuEtHWQcqjRVK1/8zFjUgBooIPbY=;
 b=rbONlSfwXzA4OJshFPfcw3EFEv72ojpZeqdn9zkjynpBpkIB7aIlGS1WSiygyovXewxcpNMPK87+HHrHobeRc7qQyy9mHqMt60uBtgywunhPm2z87JxXEigQbXP3QUA4B+ZWBzqqy/59/cSEA/7jDhCAHKicdFvdzXb0WThcRrs=
Received: from SJ0PR05CA0139.namprd05.prod.outlook.com (2603:10b6:a03:33d::24)
 by PH0PR10MB4791.namprd10.prod.outlook.com (2603:10b6:510:3a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 14:17:56 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::55) by SJ0PR05CA0139.outlook.office365.com
 (2603:10b6:a03:33d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.13 via Frontend Transport; Tue, 19
 May 2026 14:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 14:17:54 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 09:17:31 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 09:17:31 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 19 May 2026 09:17:31 -0500
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64JEHH0U3643846;
 Tue, 19 May 2026 09:17:29 -0500
From: Swamil Jain <s-jain1@ti.com>
To: <bb@ti.com>, <trini@konsulko.com>
CC: <devarsht@ti.com>, <anshuld@ti.com>, <praneeth@ti.com>,
 <n-francis@ti.com>, <s-jain1@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 4/4] configs: am62x_evm_a53_defconfig: Enable A53 splashscreen
 at u-boot SPL
Date: Tue, 19 May 2026 19:47:16 +0530
Message-ID: <20260519141716.1346635-5-s-jain1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519141716.1346635-1-s-jain1@ti.com>
References: <20260519141716.1346635-1-s-jain1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|PH0PR10MB4791:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b80e861-4128-4f68-0857-08deb5b16b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +pvOcNJIGwBrBwaFNHIH3t9IfXq4wbF932aYhwT/zHbGgVJ6Tc+ZeLeF+bmA6GzPI+QuPBrz0G5kxNe2OWcS0IOCj0zBYuVWmyP8yp8uoYJoRQqk7XP0CLrTus3ddj92huu9gduKe/l8taXoQyrCy+iaqKGHvUpL02noEVCv3N98YMBlk8tc3AT0bT/xugmN+2FrBHyjh8zFYpR0iaRyt8IoQSaHkd+mjhQKOkSa4vXJitIk3f1HHeipvt4MfBVrBzR4Pqm6D13Hg7NACPN5nshAt8SKHx+spM8Bj5d39AYcshzprG+cZG85OzjjpRlAkAJoSGXzG+GOOf+BWkIvvvwyIKPGdNPa9fXQlWK4yzsLCrCMKaMto0fbkVilXFzNCkhAp9tIeJoNjg4pHJ0m965mM3KMFDKwKdE10wGsJe0Jzd5/dbcjMnur0E5T2FyfWuh+0xH51pGFukZgCjLwJE2fKvE3EGxzckky/PdAuFpVhzxEHqSZJvHeoyMnCbrlc/fesjzaYaRQ2aW7OIMk0MSaYrhEjOgW5tG0w9N0lBygedTpRUPZV9trUBc6bQUkFka9hjtpGiv6I0jBNYOu5QTpZLehCqOXquZxWS/fQZ94eTgKvFmDbANZY10Q12OcrEV0+bF4pFzlRVpISN+3vOHgQ8t7wy1Mjpw2DCb9ta1CPRRVl3E+HnG92qVtRzLQaJfOsJMZX7bA9REmP1Zeo4518vt1xGqotlrC+vwoALA=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Uu6i1Xdju76v1J6Yn4NgEdYfp10UzWwVgtQi/e6U7CL40zra/q+lWePlVSKWBAWCKqIS8dy2F4U7gxiBCOnHWKGSd6akj2y97nn/GMe/KSVw0P2TH1OjTkZjIgqwr+ylVb5ZdFIBoc5Hx0ZPUwRL0fq/F2RTd9Cuptv7zO3XaedglG1yqYC4l7OoHFY9gIjuZmqiEXLZKjKHi4XLQcFoD8RfTl9ROpqScuxQCkL3TFasfAFiPpJm5akXIT5fkEGbIv1WOrknqUgAhqWfsPiVvheakLoLP90IN2dMAnOPYGmUK+S8KJpIXDRUyAe00WMnjv5uqO4POdC08FcrByzUy/7BlBP64NeGtp2lsFkkUcnEw5dSHlIimf6MZTPGZTmLVgcJKo4k7MWG3NE+Lf8SupK4V1OQbasswJRS2E1nSuhLYjqm1AVZPPBvLTt2CR5U
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 14:17:54.4174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b80e861-4128-4f68-0857-08deb5b16b31
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
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

Enable A53 splashscreen at u-boot SPL stage. SPL_MAX_SIZE is bumped up
to 0x80000 to accommodate splash related code. Include
splashscreen.config to enable splashscreen.

Signed-off-by: Swamil Jain <s-jain1@ti.com>
---
 configs/am62x_evm_a53_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index 281fa3fea15..3d472e84ecd 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -24,7 +24,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80c80000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_STACK_R=y
-CONFIG_SPL_SIZE_LIMIT=0x40000
+CONFIG_SPL_SIZE_LIMIT=0x80000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x800
 CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
@@ -141,3 +141,4 @@ CONFIG_EFI_SET_TIME=y
 
 #include <configs/k3_efi_capsule.config>
 #include <configs/am62x_a53_usbdfu.config>
+#include <configs/am62x_a53_splashscreen.config>
\ No newline at end of file
