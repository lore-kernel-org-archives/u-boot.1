Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E5EF33834
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 10:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F7E4841C8;
	Tue, 17 Mar 2026 11:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="vbNLQoVc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3E8E841D6; Tue, 17 Mar 2026 11:07:15 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96BD4841B8
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 11:07:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEpDnT8Veod7whYiRuxiAqdYt3kOkC46RINAgif5/hwiYsI49slLZ/zyPEQZRdJEcpRxTHVQLYhFiDtZ96QcxCRL9rNP6VDve6s4yJWYFGO0z0fgdouO6wMA4eJwZ5jUeQuNJjTcQr+7d6dREmLKNuT/e6ZRfcmaxz8GYD5cqa/mpuTEWvZbORamYGU9i2DEp+3QEWvOlBqjik/vbchu5vyxl9w9nIUEQc6GXcRrgJkWnj/TwcB2l6WNWP7sKFlS0nwMc7hKWac9FZLwI2UBtUbk5pcLsDDLMND5wSGcZqc5089ZbpgoIrRrO8qkjcbELy0BH8oyaPybwo1yVU4YYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNWDDZMLCyQ6szZ1XdxKhn/bkjnFOO7Sm+dmrpQQbcE=;
 b=TbioSxnQLqDDnX+5n+YFYNSQIrxHTfFiUaRZjj3yp4RcTUXJ1hgV2NloWQX8N8+dK9jHkXlFuuq9Ipuk+yERuav4HYUlfbJfjItetKpzlslFNOA0lHbUS+BVmcVRjvmkyjXZCyMxEPqYvTV/XASBGY4s6+BkYhsqDqP5Za3DlatjwIXzGBj/M4VQH1vKZNbcFq7PFwxt3ApLp+WFVKhTArHfSvLwojyA8aZ79SJzbgBcJS4wJfZEfZVht4KT+0PnM3Jg6N265UVAop0oi0gEg3NPYZ+C1k/htEwBBTo2kpcsF7YRTGP3un8gvks5/jSSlWdK2prQtVsTdVOAgcAMUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gmail.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNWDDZMLCyQ6szZ1XdxKhn/bkjnFOO7Sm+dmrpQQbcE=;
 b=vbNLQoVc0yHE7K7h1va5br/dPI4ln6EzqZB9UyaZC2YSmhZTEvlJAq1RkpZJL5i38Mg0PIrtK1qEvh86j3NUiBr4RvwXTktv6WMbGb55josweOzIADNF+oAKasWo/tR1O94MVgjlJUyKxkpm0mgWtVQGWUrV6kMfWct7+7dqivO7MtJf1NSq3qwtIGuzxVNhhGUK1bstR2kfBgneLX60yWJBIFAWcUuLWPVo3a33hAlV8H1ubK8mVhLDGe6PfueDKp3Q/Rt8R7+7dYozpnM0KmyCY2HOWrsLz4ddO7isvHys31299fKiV0RD98H245zGmpDLQZTLIIwOiW5WYCa6kw==
Received: from DU6P191CA0020.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::27)
 by PR3P195MB0699.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:26::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Tue, 17 Mar
 2026 10:07:10 +0000
Received: from DU6PEPF00009527.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::48) by DU6P191CA0020.outlook.office365.com
 (2603:10a6:10:540::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 10:07:05 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DU6PEPF00009527.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 10:07:10 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 17 Mar
 2026 11:07:10 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <m.othacehe@gmail.com>, <c.stoidner@phytec.de>, <trini@konsulko.com>,
 <primoz.fiser@norik.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 1/2] configs: phycore_am62x_a53_defconfig: Enable
 CMD_USB_MASS_STORAGE
Date: Tue, 17 Mar 2026 11:07:02 +0100
Message-ID: <20260317100703.1933040-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009527:EE_|PR3P195MB0699:EE_
X-MS-Office365-Filtering-Correlation-Id: 8257aca0-3d8a-4d44-1c58-08de840cf450
X-LD-Processed: e609157c-80e2-446d-9be3-9c99c2399d29,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: PXbumamR1l6K0OltD0ECGMyfYghF+KGkzqQEd7xVYfM7YYCkI6a1Q3gl3LgdM6eOO90bAJfgn9LfRJWq69yGEl3F8ZoLlb6mmUIPJD1evp8oHPz+t+H9djlGyWCdwcqGNcyMHcVeU9SHZWOHMc8xkrSZ9V1jaErDBT9ip058mNntx7wy5WOeu6Jgi0DJgVPcja7oegoGE/Dingd+Izdvy5DZCx2ttUfQWcMv3W8yEqaPTNV2BVR3zjFOn1+tYCNU/rCr0SWWEumMcar7re1oQ4G21Jr14kmJ864dQgT/Ca6QS2nQESHSDYwX6/fghoySx2oolO1T+RmJvURTDP0JgYQeU1W9HAdstS7DyXvzVokVjprtlAaBYR6GPdosYuL8jOVYeZVgMN+0i50ojNzrRJ0LEMiaM6slinEoPoIfFqVZ3g+h41qE21vHiaKnrMMa68sT66AWAnGTxLLvO6BQK7qf9JspaguHHkcCI2/fabY+7mspABxtx7ARRUeU0BJP2uEGKj/3XIyN3P0nAYPDcL9XNRLTCrJmBMut1a0PTI9w8TylZweb2eGK2YnwBbhno8qFb7SK5P+auhez8/NuBKml7lW4urNvPBR7HDANG8KTkqQfDbdbE+aJze3nWxs/Ac3W2pHR+cZe12Xv4sHFiMwJ4Y1FgoiyouYuDUhO9BP87skem96XhuQYomgHC3xZjAwOEu/UwPgA5A5gK8++7z9/FEIlSnLOO2n9AUlfE2sKzdGmJDG5CVwIBYACx230HzSJqyNgdath29Dm8i7udQ==
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QIg1OTYjP4r+OpR5xBqnnG5l2faOBbfLgz/bcA/x72k7NwuQ84jqrVZKeXaJIcrf6l7+D2h7pd8ZxoLUc161mH7IjHq0O4waflpTo92sC5U+gj6oOgub0HwWDjKMlH1LL3uEemyPq/bn2O/so14fPKR03iJzsBs/ZBel8yQ+mFHLD+luUq4/KsPVJtTTjtV2Xw0QEh+w7swiVOcf6PnES55CZx8LjXrApLUKpaTML8waUuDd77DZQ1BrVs/7eY5jDi/E7i2NMCZqX/w5X4QLPJ74sYkscaFYLuhmPqa5m9fX4xLr+5gPivLS8l2YwRPI8GELQHHq+FV+FdvWzmH7FBRmGlzF2CNhMgvabsx+u52Nj/dkbAOqcHukhvB/OB3XeOyo052DkX1jNVngBmrobLH4WP4ic1deORNAAYsvGuBu7q0HIHpxFwnoLzeRvTSq
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 10:07:10.5867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8257aca0-3d8a-4d44-1c58-08de840cf450
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009527.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0699
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

This allows us to expose MMC devices to the host for easy
flashing via USB.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 configs/phycore_am62x_a53_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index afed0bfafc6..5ea352a6370 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -76,6 +76,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_WDT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
-- 
2.48.1

