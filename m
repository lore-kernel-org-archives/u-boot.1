Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A69C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 07:41:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B24E88AAC;
	Thu,  1 Aug 2024 09:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5trDUAD1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F4CD88655; Thu,  1 Aug 2024 09:41:38 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 628A488AAC
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 09:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UntVicU4VY2MLyec8q2M9AqkF15LLYPCwJHgdt9RZL1kn95h4USV1sLOEF99LmWnJH7Xg4Cy0e8XnsruxenkKd/SWP1sw9MbUhRugA3pwXN+EOO8iTRv6n2mLmt3muyXQycuwGMMyH6R3NLDoQdT9yxJXonpLOzAgD2o1eIbo7LxHBqHA8+w2ffUclwQty2WbQqrIhHCf3UzoEtUzbHOhA2MYM2fBBrXSd7HqMD8arxNFaMckTnVd2TL+ie8Ryzj8q8RoLAH60Yquyka6z4F2TB0vKMAdDHsOJ/8nxXAMUy2+57GQ+7xKHseU9bRYj4Pj0Wozq14qka3nDspG9rQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzuPO+RF6XYV0yHBQrhvVxQuAwVqG3OblxlzKny3MGQ=;
 b=NFw1ZKJpByyaSSyGivBODFy2EWT/YAcNCwS5/5LSnPNT8RUNY5B/fZR6Sffh4WUd9jaFJGhLaCscjla6GEU/BJoE2XHowcLWTJGKcOVVHnSvSdFqeiWXS1yddA3avkCI0cxvb459c19XQeWcigNCGi9zpzNuH7jLtBZJh5t2HhOtJFl0+m2qK1ZoxsKzbjmt+OO+J57tpqup05zXQ5Y+Up0dfzO9wtbCVOnaK4ZsePWCgZkefS6mQzUbewh/IWHpV7ZNTVTnFKYGy8fst0SAkwoqr+n+jFhxGw2n5cUFmFhTC2zUG33n8q5ZUT88xHvgEdNfltdVkwsCxse1eAOV/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzuPO+RF6XYV0yHBQrhvVxQuAwVqG3OblxlzKny3MGQ=;
 b=5trDUAD135j7SVbn2X+rGDKUIsyw6s+ZV542mxxyq7vU2uGWV1S1UO0is7EqxNXUXeX7wY8YWLf8Yyb2T2dKuuxUlDNh7P6rmO0f0nyLtav2z49C9cr6jDiTilXL8s9fq1L2+esvFBegyTYWFDH5OImkm2SuMYagbkTfQBvHcpQ=
Received: from BL0PR01CA0016.prod.exchangelabs.com (2603:10b6:208:71::29) by
 DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.22; Thu, 1 Aug 2024 07:41:30 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:71:cafe::c3) by BL0PR01CA0016.outlook.office365.com
 (2603:10b6:208:71::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Thu, 1 Aug 2024 07:41:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 07:41:30 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 02:41:28 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] i2c: pca954x: Remove pointer to GD
Date: Thu, 1 Aug 2024 09:41:25 +0200
Message-ID: <c6a515e15b855a9a53edf642f161432b5db64198.1722498084.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=619; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=FveaY5XWOwoWILAVBOl3/wRPL56zDo48/23Y54Es7g8=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrTVNmpLll6e9+IrT8sKXeWpDT4iZ98kzTjj2ap99Nfsh
 7NnSx9s6YhlYRBkYpAVU2SRtrlyZm/ljCnCFw/LwcxhZQIZwsDFKQATSS5hmJ/3/cGKqTwFrBPk
 AjZzSpbW8SzICWWYH3jj9bGpvptb2Xii527TyhM6YZq2DgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|DS0PR12MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: c690caf3-9bc8-44cb-5ad7-08dcb1fd5bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PCbhYXV1bvop6/aS1dY+YyCOYeM5+IFTW0RWselQCAHS7TxyGtwh2NkwAcOb?=
 =?us-ascii?Q?EYRdnn84bg9a82v4A4XQTb8z5Knl3H89wnRA9XQDs3XvlnzPVdGwNcLE+oT2?=
 =?us-ascii?Q?uYYtNuhvjC+6ag4CL73UjQCAjOXGU14QGL2gGGtvaW9pQsBONa+L8wKpoH+U?=
 =?us-ascii?Q?I5YM/zH8dptF5x9jploW/udbn4nLbRm5asKMELvpjhwfKMeXcgSgXoNwaBzS?=
 =?us-ascii?Q?5heMwGH46UiVsNuVvbwmbiHyq/Qt3M7EfIjViaOLcXm2hSjvVFGIQvIGoQPt?=
 =?us-ascii?Q?m2+okizuSar7rsC3iRDY7i8nDfuSJMb5BPyDxgIVYIdiQ1JytdhtqlAI7OUJ?=
 =?us-ascii?Q?Q+Ql7UYdtJWgajJUdvS83P+rt3JdKTye6rbWy0UL7+7q/Llt7BLwZtLD90aT?=
 =?us-ascii?Q?FJXKRqIKKXqjusmPCeU/X5lcl9yIh2fAq90xo7d20daevZnkAc+BB+f1k5ud?=
 =?us-ascii?Q?diKGipo6l813KYwGwM3d3jtUnikjMdWXaQTFmFXH7YFj9O/3NVfdW59VTQr0?=
 =?us-ascii?Q?hiMKyqUrweQ82DUpXQzCLAvJ1Nq6qViZm8enDCqiY82ue8gZECY+zSjaEnOg?=
 =?us-ascii?Q?R0B55WVr2fdujYecehBGavjnkElUoucAOAjqxyO9fG0Z1UwdTBdpi+1mXMg6?=
 =?us-ascii?Q?aLdH3dEUEBr9ARUHP/w0BcbuRXHyqAUvfsrQLZzre81EEEg8cIGs+TK74B8s?=
 =?us-ascii?Q?YYZueqMY4yInyi6CbYyBrHV7r0WRmYyPhpLmz+E60FdJ+jfE213mZVbC/a2B?=
 =?us-ascii?Q?CVkJbvbLqIz+FKmkfZKrY3cVrTmVtCtDebfBiQzdik7o4cyGQzIDCeVOHC1y?=
 =?us-ascii?Q?M02RuFkfTpC0HO6wGoh9F9RP49brOxqlPqCq4J1slC8+wWkyt4NRk6ccCa67?=
 =?us-ascii?Q?LRd9khvgayj3sMI9uA5t865miV4d4SFlOmeSCl3urmIln+S36NupQ/8lqg5e?=
 =?us-ascii?Q?2zwqJxyUxr77ZIZJnc9oiPeFkC4dZgSbpVdogvOc/o68gUOZ/QpJDHf6oOPA?=
 =?us-ascii?Q?FoMbIeQBW03GFeB0MFIegGRwgIPrkZx8TB3TlfXwf10lRnUV9WKk28jHN3ou?=
 =?us-ascii?Q?uUn96A4CoiGQdmZr9r8vwlEffRw0pf7pzFoRp5nbIOD0IOoU1sedYf5WV22U?=
 =?us-ascii?Q?8eMSRLiSeXcRmxtO+z/A+6ifzhVoEmKMAAbuNpIclamCBbX9MxFy7z74rVHg?=
 =?us-ascii?Q?M3rlVFE2lPX/I5nyiZvxxtD6hFMPx9b5KsuIdYw/nshyaSYp615KzWGLdQkH?=
 =?us-ascii?Q?d+80jUB/9uENkMR9UQgBCRDQoijYdEFP0J5bGJ1fDyOjPQEv2kCR1m6UGymv?=
 =?us-ascii?Q?fVt00G8OMQJbBCZ7eoNUTUCTQ2yNKqmq4i7so7QMQk8LXjDfDQ3AtGadBlfS?=
 =?us-ascii?Q?u2X/tzyBOuCGzI3v76w4xRaT5N8n80w4BndKY/WashS9ZrEmb/5DL9uluwK6?=
 =?us-ascii?Q?ImqcbiQ+0K2itURTT9kcfLJ68wHrAE5S?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 07:41:30.6372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c690caf3-9bc8-44cb-5ad7-08dcb1fd5bf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562
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

There is no reason to have any pointer to GD that's why remove it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/i2c/muxes/pca954x.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/i2c/muxes/pca954x.c b/drivers/i2c/muxes/pca954x.c
index b4e3e16a9764..795288fe2e94 100644
--- a/drivers/i2c/muxes/pca954x.c
+++ b/drivers/i2c/muxes/pca954x.c
@@ -10,12 +10,9 @@
 #include <i2c.h>
 #include <log.h>
 #include <malloc.h>
-#include <asm/global_data.h>
 
 #include <asm-generic/gpio.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 enum pca_type {
 	PCA9543,
 	PCA9544,
-- 
2.43.0

