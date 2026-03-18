Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8314A103E177
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 13:25:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60DE78426E;
	Wed, 18 Mar 2026 14:25:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wxPF/lfV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CECB8428C; Wed, 18 Mar 2026 14:25:51 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 239C884262
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 14:25:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGvf/GI+JBngU2Adfd1idm9M9kL8dxQlJfViFQAh3wQA8/mZOw2xa9nj+EQxvnq/pBk9P/js+sN5nF0oMY2/NHVirVU3GBDtW784pyX38qxBLP5fvy5/83DG7xXosEiz/iXLWlPsENEI1EFN5cVummHvRCw+a2G8vceChYh2Bf7/NK2+bKvZUcBTM6KJH4DxUHhCyNiBcZF9eAN2HZ0S5iZQxsPpsK0/4xAOM+fzmVp/9Tq/F3qFdvChvoBFkt03O99ajl2H2iFrbIYPMW+OLA6U4e1OojTiEHdm15hs0LSqm4uX+xMZME7VVJKgRvpADIyZUbOtUw7Ns5m6UKFZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D04YiU2rl1P3IhCJYROhoe/AWwffHegunLJG2xsx7Kg=;
 b=e98YRI1vGoBSDxaTuTGyyFgLC7aG+U9mpiSKLomnGvxlTYIQWyl82sP7Nn4uWLvGkgdbRJfNpKI9pv6I2Qpug1zJwZsAOdXToPodOYwBKyiFDchCQVcyuaBoqSdZVc+H+Hx9EV+Mig3BI/hQ5MMBYFR/PjOE05kyFzH2PqSLSQfFDmgPT9wjrR7Ts/3FVYYfAh29gBQ0TrQtI74KrQXk6wjYU6Q2qMulbmxGB5czJX/7p2lK7O2kCVq6qrcWAbem6cEdOV/Y16F5rQduUpr8fQUjjN6YLvxkPQ6nWnXZZSMLkov6s2Kn9C+x5AsdUc58WvNKp9xsrZ+Hp/Vb6/uiLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D04YiU2rl1P3IhCJYROhoe/AWwffHegunLJG2xsx7Kg=;
 b=wxPF/lfVO9OS+5uPOT5oZLZM/OzKLdJW9USmQUMdIaH3fY5jNe6CuigO5jlR2vWTmVWFo0gL1e4EOw46zZXQqoyoY5B8hHGcC8w2WOgppvHaLbkc/sLxSKu/VFNAPN/Jwqkb7nVxyj2g2ztBWoFDwVK8iM1bvK7XQsqpGB7Dz6Y=
Received: from CH0PR04CA0056.namprd04.prod.outlook.com (2603:10b6:610:77::31)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 13:25:44 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::23) by CH0PR04CA0056.outlook.office365.com
 (2603:10b6:610:77::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 13:25:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 13:25:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 08:25:41 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 08:25:40 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/3] event: Introduce EVT_POST_PREBOOT event
Date: Wed, 18 Mar 2026 14:25:10 +0100
Message-ID: <44aa0bf04c8e2517b51c37cce5069cbc24c69f16.1773840306.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773840306.git.michal.simek@amd.com>
References: <cover.1773840306.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=5jXOybyzRvApZF21EFbHA6rwARwWcpApDSHXfxMJdwQ=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTuWn7o2Xa1YMuLb48t3e1ay/KkfYm6s/7li1JTVrRP+
 vExr0Nic0cpC4MYB4OsmCLLdCYdhzXfri0VWx6ZDzOHlQlkCAMXpwBMpGkuI8PmI9L95m9Wi5Tw
 +S19dC5ZUDva/duB52dMKjPSz+q9ML7K8M+mtrslyYrnuI9C+Gz3LtOyHUI/f+00LLn6NHX3sb9
 KWUwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|SA0PR12MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad0dd2f-96e9-4c7b-dafc-08de84f1dbb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Z/g1Dd+zH+8jmt0H3f8BvT58eC92h1m3Dlrbo00/Dga8+wNUdtHTlayglwxgM8ztxmRw13BXlP+0efcsEg6vimVaBPGyxpdcwaZjRRudiIjIeRHwxuoMMfhoJf8F/4RV5eG7AzoCi3EVAKrTi+QvaENndwTFeUuzdZESNif8G3h1bAZRJRy/vAwxCbbAklm+/tVwhUkaNeJ0ivsUSr0QgfNAAFRN9aMZIIXg3B3C+vFj3atZ76lguMBIKNziEdpcV9NJ9twa6Y+eswujFJSASxGn8/Sb9IdySb66tHoq5Ete7nUXHnllQ7xpAqPUT7UNz5U0G71kr+9JXLpMhKc23fYL0vO8R18Fkjn99SBZqMhqkfCe/fUqXwjfpXvXI3SUkPPSXGBi9BxQcTiX/k2tWEzpWh/QXYR02XsQJV5V4dCRu0FpAwa6cLIOuMFz7/ZgikysgA4OgQq0T0kwCE7kLKGG8GHMc7n7HoFTeQmKrV7XKloGrbq3vCzkSKdOIClFgy9HQ213KNa6TJ5Td8EyjwCblyz14D715rQ4eDEFgvLi+IjPzZeRxCRe0khsxbxjbpTAGu1N6aMn+4xMFkjmqWFnXP47TioyIX4bnXHVcEzrikUjGMD4sGij5TAHKcSDpX+gBCiboEHor6T0fB3pMRZ3k1Ur5rW2XHWbphs4SnVwA6/KiYHuq+38Yg4tuYJJzSUyloyVPdENW+oFeVM/B150FjG8cBE43XRnkZivPeI9CXquRpiuSbCrcDzgVTuqma+8SinNYvhI/49v+1z+Vg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZgagjrkJBou8l3dkXU35m8ng3ZXCci+jLqSZgcCxQq1PQNp1hOsAfNCI/wMpTIuIiA5AlTYILdd6y9fjia7D+mkQkV5ZY01KEn6DI9XdUDilfUYjDYKrzHGbyXSn/c3cPS/zkw1Hyu9blP9lJtrQX0lfyBChk3VLP7Vb/WBSWPz9Z7uiO4d7t0Wf9fvcPJlo8C+maD7gu2h3r/UTmmm/LNlB7LT3nsQZ7K6kyYYhj7abciwI3UoBLwXlinlD5T7GoV0RAfN6ntTwUL8h5PNyvUMOYluKz23a1kIefom1lbYbcXxPb/8bpH4mWnyAlKIkqVN9cjiAo8oSzTjpV1lNdvI9X4lenhI8YJ4Lx/skewwEjX+1/p5VMDXZmj04sJAl5ZhNnT2GAxyeRVHMx89iBUevzLSOdWxp5gDhL2D2F3cEdSDQdai1DpAFALPeFB0s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 13:25:44.0335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad0dd2f-96e9-4c7b-dafc-08de84f1dbb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
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

Changes in v2:
- check return value

 common/main.c   | 4 ++++
 include/event.h | 9 +++++++++
 2 files changed, 13 insertions(+)

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

