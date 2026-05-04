Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400A6CD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 18:08:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF9E78467F;
	Mon,  4 May 2026 20:08:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bbl.ms.philips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=Philips.onmicrosoft.com header.i=@Philips.onmicrosoft.com header.b="NIZ6GpW2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 398DA845E3; Mon,  4 May 2026 18:48:56 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B209D80F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 18:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bbl.ms.philips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jhaller@bbl.ms.philips.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dg4a4jL+QdaEOJgqLmBBokr/n3O7CeJkvFQrGPuQyvV5Sk7QooRE5hvyjo6JXUAGHAM7qbwcWlNgrKX2ImXn+yhlv97u6nZegzjdHrgitahtkPCsitYJvW4yXi6QEnpS7/6zuH2L4ALKmb/gxrCF6b7HtZPGaYYdul/FvEpbHepSnnxY/rZhRnatI4DZTQz8TWVinw7UJVsrvyKhWIyeRfevE06ID19Mc8zQGJeX/5PHqjC1C3otgFcLxBxv6jvJSOCThATqZusdVYvEzyXtCxSwK7nn8BTemcrBzpE0OrGtZDYB6Qc60GToDqzkKFr3u6Z0Q2Pym1q0H0VYWG7AMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Desdb6vaEviC7TV+9p57eJfeXtQfeGPDu8/0vZ52n9w=;
 b=ouWll+zjEYYrPu3+eEYQsW21yxxUu+Q5zg0YINcVTGDYZww629ebvlBYQSwXdG+IA0aoDFaNcq5iq+3DW0zjKa93ar5hWNf+7r2b/454Li6uzcGv8nHsbLPZWOOlJG4BQgDeg14vPTTqYcVSNcTu4YDPReavKDTlYObxjXqYZz6wmsJgQOv+ltQIbp512vTL7AOTEVg23yTU9fxQtcr6VAdJw87Kw4jr0rMO1tR2HmAd1V7+NzFjIGXPY/U9ec/2BQsYMyHK6Aen9wHBdo/OUy3Sz2RcHzioptFWQcKIBlqFCYkQWL8gil4ZEuvmX0Lf2qbZwRx0i4XIyhXWXhYJ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 3.248.88.141) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=bbl.ms.philips.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=bbl.ms.philips.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Desdb6vaEviC7TV+9p57eJfeXtQfeGPDu8/0vZ52n9w=;
 b=NIZ6GpW2y9FlEHioPYi2/8p1R1F57nf9Bzv9QvICFPbH7tSLOF+obc15T4XQI07vmNfasei+ki9xoz/xH0FzQib1zzfh9Igz7oVeKBP+0X3RRH9Ot7F0jZDb04ui4fL5RQPY8LuNN48W2J0icMzBg9dmCsFl788sOnF81nvZc/0=
Received: from AS9PR06CA0252.eurprd06.prod.outlook.com (2603:10a6:20b:45f::27)
 by VI1P122MB0222.EURP122.PROD.OUTLOOK.COM (2603:10a6:800:176::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 16:48:50 +0000
Received: from AMS0EPF000001B4.eurprd05.prod.outlook.com
 (2603:10a6:20b:45f:cafe::5c) by AS9PR06CA0252.outlook.office365.com
 (2603:10a6:20b:45f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 16:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 3.248.88.141)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bbl.ms.philips.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 3.248.88.141 as permitted sender) receiver=protection.outlook.com; 
 client-ip=3.248.88.141; helo=ext-eur1.smtp.philips.com; pr=C
Received: from ext-eur1.smtp.philips.com (3.248.88.141) by
 AMS0EPF000001B4.mail.protection.outlook.com (10.167.16.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 16:48:50 +0000
Received: from smtprelay-eur1.philips.com ([130.138.84.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
 (Client did not present a certificate)
 by ext-eur1.smtp.philips.com with ESMTPS
 id JrqBwEZvMtKtZJwTSweRRY; Mon, 04 May 2026 18:48:50 +0200
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
 by smtprelay-eur1.philips.com with ESMTP
 id JwTRwbKsiUYUNJwTSw1UQR; Mon, 04 May 2026 18:48:50 +0200
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl2xr12.bbl.ms.philips.com (bbl2xr12.bbl.ms.philips.com
 [130.143.223.70])
 by mail.bbl.ms.philips.com (Postfix) with ESMTP id E5597184855
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 18:48:49 +0200 (CEST)
Received: by bbl2xr12.bbl.ms.philips.com (Postfix, from userid 1876)
 id DF30D7C022E; Mon,  4 May 2026 18:48:49 +0200 (CEST)
From: julian.haller@bbl.ms.philips.com
To: u-boot@lists.denx.de
Subject: [PATCH 2/2] binman: nxp_imx8mcst: disable configparser interpolation
Date: Mon,  4 May 2026 18:48:49 +0200
Message-ID: <20260504164849.108849-2-julian.haller@bbl.ms.philips.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504164849.108849-1-julian.haller@bbl.ms.philips.com>
References: <20260504164849.108849-1-julian.haller@bbl.ms.philips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B4:EE_|VI1P122MB0222:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a3ee0cc2-646e-4bb3-5e26-08dea9fd0495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|61400799027|82310400026|36860700016|376014|18002099003|16102099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: nSYiBy3MbwL4LaLvuWdXUxeoB4+YarRFVJ/GIPsj799SKryhpCcvF7/WgzluAUOq6hfxaVq0UQIal/qRLoTdViI0R62BTtPs+oMkX1c0Ki5N5Ygpk70gnTAsxtliZIyE7YsyzDvrnyCQ9Ub7Qje8L1cZs/qFK20grtayaVO3JsaP92x3BdUYmti16FOp7BRHVCDAEGgS57Tp2JHQQzGaue1VUz95V7Q7bUga/SkddP3jEiqEs7ck3hVTjuLnIgUxJRNpArV/i+jx6LIuYn9OIZJM/t9YpCxZAX1z2IAwWMRNwffQuXpVtWtxzCxskk566A6kOa6G61+W9hhHvUL9aCdKvCExcUx8NVsZnrDgHluip3FTST6tt1MR7tMylHpy7+/C+xYe1se2J7JvNBpEC9ThtiTtpszBR2dKqWd8BdhQmZNEcrYYmudAW5a2YesCUNGAH2S8qSXJrI9LC+Vc2+vTQsGFMQW9gtHUTQa4wBOzJ55sbOyfkvSlQm/UWgFpldKUWASPd1hE6zU0rvTiuIFCZLtt2A2Fz2QP5y1g9LUchtuNlOVHo+2a1aGXjURNAgVTSsDp5OnIuVHI5mfYSMJhIIKNYknpu73hh/7JdJ6TwIaEeo6c/TpEqNHaOvo9hzjGLkPYDHnsxNsZYb5yjcu7P4aNxBMORQN9Kmwrqtb1hcXqwSmoUFuOaoCroiIWm9TqtaW9llRpnAntH9FBpTB6G1rAvy2zD5C/TlmLTKY=
X-Forefront-Antispam-Report: CIP:3.248.88.141; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ext-eur1.smtp.philips.com; PTR:ext-eur1.smtp.philips.com;
 CAT:NONE;
 SFS:(13230040)(61400799027)(82310400026)(36860700016)(376014)(18002099003)(16102099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: htnkfqYYEuZviFeg+dCeMLWr9t0OpCgdSyj9h/NX+kCF8c6ml1/o+76crdcS2VI6TN/KkiCHrmpZfz0/t7JhacwRhKOesu2JIiUQaeXkC/0uE5+fmau+uG8Z4pqAV5US0ynbhsmgJZ3SMIhHgN8nfJiyya+nLJWHkIxWLIq469+CVvgl5wHC65sOmkHsNBtaV+DHENazflVrtYolVi1Lhy5IEJbd3d/+OCM8xFTobPLpqOt/TPu5/BddFdaw950ktLp87uQDMO4y8+Vu8vuhLU3uroBrqDJxS+u8IXWEIQtUAi+hHVehUyWeqnDYk1/DCnPOoZEd4qqv4/2dWJFNSzkEr02geU52X36zE9yQK5gjT4lzTBSjSIsOtVnAI5LjtAJJKJsNLTgs1OSjmpzYoTHLp+b/scHpGmn77RUN3l1dP99LhzvyGGqTH12XwJI6
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 16:48:50.1366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ee0cc2-646e-4bb3-5e26-08dea9fd0495
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4; Ip=[3.248.88.141];
 Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P122MB0222
X-Mailman-Approved-At: Mon, 04 May 2026 20:08:33 +0200
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
Reply-To: Julian Haller <julian.haller@philips.com>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Julian Haller <julian.haller@philips.com>

ConfigParser uses %-based interpolation by default, which causes
PKCS#11 URIs containing percent-encoded characters (e.g. %20) to
fail with "invalid interpolation syntax". Disable interpolation
since the CST config format does not use this feature.

Signed-off-by: Julian Haller <julian.haller@philips.com>
---
 tools/binman/etype/nxp_imx8mcst.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
index dd9f226b751..4fa26de51a0 100644
--- a/tools/binman/etype/nxp_imx8mcst.py
+++ b/tools/binman/etype/nxp_imx8mcst.py
@@ -137,7 +137,7 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
 
         # Generate CST configuration file used to sign payload
         cfg_fname = tools.get_output_filename(f'nxp.csf-config-txt.{uniq}')
-        config = configparser.ConfigParser()
+        config = configparser.ConfigParser(interpolation=None)
         # Do not make key names lowercase
         config.optionxform = str
         # Load configuration template and modify keys of interest
-- 
2.43.0

