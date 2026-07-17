Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B93FC44520
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 12:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72B1A84DF8;
	Fri, 17 Jul 2026 14:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="U4hcIATK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2392F84E09; Fri, 17 Jul 2026 14:31:47 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6EDB84DAA
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 14:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.delaunay@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfo/Pv94f9lLpC2NyY/I7mme6GFvosUjWMe1fl8lYv4inqbE1+4wDOfoojPA/wt3rMxRnR7oR2rN+vrjFyubR9y0lnnjwZslKOPveV3cEIC0f4eC/SdAnKeDokojnkSRtqFjXOXzDWytDfbyacuhfJUdDYDNOoE0JsEcOK/yBiNS7McRcJft6Og0zv8+JqPXNkLzHEuiklvgMUKwjGZHsncBPcXpmfvR2j7IBsmm7Cr+s2ivOaKvQdcrICBgy8lUKqkaMAMZPJj4A6QysO0onk5nV0kCmt+BltSyGuQYGq2Ad59PUdH4x2kzHO/jzswZGHX/UoBxDE/LjM3gD6trXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hs9Y0CylBr4EaODZ7pbc9GrKHcHUnRtmbLT3tlCEuQI=;
 b=LEgxKUPcqNl3PWERbsINNwbjo5tcN7PvZjd5+zlOrxUiDotomItcC2zURlNZrQ8vyb1nee6aIfaqJP6EaizgkNHUfFEqYHnhQdZmNxlVSoiIhiigrYG8cZAZce8QTMYH5B+taYvla5l8snu6BzJdKkZKYioZO8isKUgvCzLZHYF4UFBYXF9OdGnOlDy0cNddWk7CktpF1LLjSJgFg4fFR+aF+JwPIafcXZiHg4WCMspqSeLA0TlHYDGU1JYeQ0f2GbV31WMzxnk7ziZ2YnJUEQwVVPQ61nH7+93KF+niHSmN+AUmVUjdAXIk2f6ArKXYoRWki/8Dyxik+oAGayD8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hs9Y0CylBr4EaODZ7pbc9GrKHcHUnRtmbLT3tlCEuQI=;
 b=U4hcIATKPLWORlWZPQwI7w4iEGKuo7Hs/ul5XDWnt1AU22p/jyXiSN60z6xmvzP2RPbm4P2lArXvsiLHDnFC90yp4NP4iSsmaygojVyaLsShbkAgBR4ox9XN85U4HmckmzoLDA3q/T6eafo24wDGG5aQInrhwZHVL3iCGsmMdGpy6R1FJcdGz5S4k/dbSaF9UcRA25UHXMuJbbY53rqbUdWpA4BU2eApeu3sSxUi9IfwG7Iwpss5X/ZNgeswfDiT5Q/rhHjOJBYDi+iTC6M/Mu3rrVkZ4uw1seauHjGk99tllo/6WcHHpXdkG0kQoCKLmJDoIhrMdq3AAKhLQI8RCw==
Received: from AS4P192CA0028.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::13)
 by FRWPR10MB9324.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:177::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 12:31:41 +0000
Received: from AM4PEPF00027A5D.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::86) by AS4P192CA0028.outlook.office365.com
 (2603:10a6:20b:5e1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 12:31:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM4PEPF00027A5D.mail.protection.outlook.com (10.167.16.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 12:31:40 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 17 Jul
 2026 14:36:16 +0200
Received: from localhost (10.48.87.227) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 17 Jul
 2026 14:31:40 +0200
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Tom Rini <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] ARM: stm32mp2: fix TAMP_FWU_BOOT_IDX_MASK/OFFSET definition
Date: Fri, 17 Jul 2026 14:31:32 +0200
Message-ID: <20260717143131.1.I2460c17ad1978f8c5c5e85a6ba56cfd46ed975cf@changeid>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.227]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5D:EE_|FRWPR10MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6ee572-ba00-4cf0-19c9-08dee3ff5aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: OXSVJNAQJJ2sY4w+UUPfCllz55FsuhSSVT3X5OUVtJgLv7H+qASuNr6EolbmEahJNrybxMwD7Xq8QFxeKi4ihHyabgfp0mAaHODjyuk70voiDKokgy1+CfN2IdkhAFh034pAn8PzsLfdW/t3xVDqd6MySngL55CjgJU3k5s2u0qIJdRRK6azQIhTfGMV3AB9LE+I4wlYS/ez/dm4MBI406sDV3JQ72K2zwGU20HuFo8WIjyNkOO4dre4Nb5Rf7uZUnF+mPgQ1ITLiCP/QpLnBSHsnSCzBNEbQYmgMz6THAHNGeFuJLtAsmmP/P/+alRLOk1D5aWlg754nHj/9Kc2z9nFIOxGdMM+nP88OX95/Ow/sNogcBRdWX6o4p6n5qKp0/xhOMZ5bOC7KulSBO087kJ26+c3uF3G6M0CwYR+Ch4dMQZmvuE6p44efWQEM05HFaGFlmCSA568uEVQGhhRC4b8mvl7Pqvl5qApVU/4YtnW/vqH6sgQIpwjHrujHq/bt8/7j0WvIga+uB+L9vPpvzRBPC6kKQht3EMO8CJO+UHH8wocIC+4Z//HYd29IRoktMLLN1GX+suwzahNgV6CgXeymApwWoq2ppgfM2jvVVHnNoHhHUIRDrdtRAgLb9gDSkSYdW03PZ8ECOJprWFyHchq1aTptV4/CmBs1r/O4DAK6bYikWI43Zo2Gz/+EOXZ4dqfq+vg3uAMg63B86H1nQ==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sxssrTEcIB6Ab0mPiGnWFRkNMNGxoy9FvkigjUdtYEbpGeWPw1fI5yoNH5YWkNrRC8fSEjnyeXDygwbHsulGI/OxhNLast6nXjGKeHtZsArWMwy/ZlfWeeyZ9AfPCEgpJD0wSV+m5Tx/B+FYil3HxrcemUc7O99myBehQJtOe4uPQgjOO6ft7Ua5zKGHxRIpr+e9881ijcLQ2+dEpTBjHNfJLCmOut7nS6Az2imr22luX/I0Lc07YIEtCt5mQR6Y1Wha2r20Sz08obn2GpyopV/WkUaJzPUBVAlHFNcapmcKoV1BfBT/yIwBTAdtSHxPzq7VvW6w4my1T5ft26KtX/FxjC9aeBudAWg85wMhoLNhxACDnAUo9sCqmxTcWSdCm6XQHiyuFOUy1ZOpLphOqfL3881dNDFGaaBLddP71N2YkTsSj2ymei111yOdOc+o
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 12:31:40.9772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6ee572-ba00-4cf0-19c9-08dee3ff5aad
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9324
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

Move the definition of TAMP_FWU_BOOT_IDX_MASK and
TAMP_FWU_BOOT_IDX_OFFSET outside of config check for
CONFIG_STM32MP15X and CONFIG_STM32MP13X.

This patch solves a STM32MP2 compilation issue in
board/st/common/stm32mp_fwu.c when CONFIG_FWU_MULTI_BANK_UPDATE
is activated.

Fixes: 5166658ac605 ("ARM: stm32mp2: Factorize TAMP_FWU_BOOT_IDX_MASK/OFFSET definition")
Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 arch/arm/mach-stm32mp/include/mach/stm32.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-stm32mp/include/mach/stm32.h b/arch/arm/mach-stm32mp/include/mach/stm32.h
index 42e3735847a5..dfbd4f436294 100644
--- a/arch/arm/mach-stm32mp/include/mach/stm32.h
+++ b/arch/arm/mach-stm32mp/include/mach/stm32.h
@@ -67,6 +67,9 @@ enum forced_boot_mode {
 	BOOT_UMS_MMC2 = 0x12,
 };
 
+#define TAMP_FWU_BOOT_IDX_MASK		GENMASK(3, 0)
+#define TAMP_FWU_BOOT_IDX_OFFSET	0
+
 #endif
 
 /*
@@ -135,9 +138,6 @@ enum forced_boot_mode {
 /* TAMP registers */
 #define TAMP_BACKUP_REGISTER(x)		(STM32_TAMP_BASE + 0x100 + 4 * x)
 
-#define TAMP_FWU_BOOT_IDX_MASK		GENMASK(3, 0)
-#define TAMP_FWU_BOOT_IDX_OFFSET	0
-
 #ifdef CONFIG_STM32MP15X
 #define TAMP_BACKUP_MAGIC_NUMBER	TAMP_BACKUP_REGISTER(4)
 #define TAMP_BACKUP_BRANCH_ADDRESS	TAMP_BACKUP_REGISTER(5)
---
base-commit: 96c308b8d2a6a1496c0a7366db9a7becf42d2454
branch: dfgdfgdf

-- 
2.43.0

