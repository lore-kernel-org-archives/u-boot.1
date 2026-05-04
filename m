Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791A8FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 18:08:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 406B2846A1;
	Mon,  4 May 2026 20:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=Philips.onmicrosoft.com header.i=@Philips.onmicrosoft.com header.b="hlPC+lJa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94FBA845E3; Mon,  4 May 2026 19:27:37 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B293C80F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 19:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jhaller@bbl.ms.philips.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnwTZ/i+2d0eUpcW35WleaUbIznkVZp5YgRAs701bdcDxRFbT2Gk0IZ7oooy63KlkR2OoNsqhXv7sfQZmbXyeVgnK654y3Bp6ld753eVGqp8X+JN5VEBiqmmqSOCZMAoy97P+mmtyatGGAL92cfm9eGKAdmR/zQJk0qAg98l9Tz9hK+Gag69LUc1+56ygDMKsMkM7Pj1djYQS5cDraaSCYZG/KEAcPU2FgWm1LI2DlmtZU32AA56NT+foHBeIW1z68uwAqtxJrVxSSo/kNtru7kPBtblu9D1nnhw9Ipv/RUEqgltMk0zkwagR1jxG2P9VtWrc/hgf7toA/Z7P0Sc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Desdb6vaEviC7TV+9p57eJfeXtQfeGPDu8/0vZ52n9w=;
 b=ADF2rmaodtjqU9TNl3Z8wEVRmojDSMlUTUnK9sezAkfFfJbavoRmb36juxJjgd8UN+pJyrvczSxe5oPaeDWOZxdU6Orr466Spm8/L4JnFfJgIvLMvRQdaXcgen4YN1seYqlvjZnaUb1ddQTK8T+Qwnum2BmG3yGqvMNnMl3BxZ6B6cTijtbHGW+OWW9bgPQmmq1z3JdF+Nxnw3UpuZEUxBQjgA/R6nNOKsAr+bD/YbP6WTaRgy8I4rrQe/JCavfUGT++FFhTRBqyYyslC5JK5gorLMrJyifhC610IlNCsSNDGiT9WYnqupXg8dWukJpmLbB1ryhhKZLj0quCk7l8wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 3.248.88.141) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=bbl.ms.philips.com; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Desdb6vaEviC7TV+9p57eJfeXtQfeGPDu8/0vZ52n9w=;
 b=hlPC+lJanNeg/QWgqyGybke0fZbllweRzIfFAjsun4kXrZzkNDRGLILKMAtgzHbohcODXo+ox5m5NYfVKK3lx+vAz+46FGYK1heSucDNQ6E6Y3pFMPe0pXG2PVPMB2ldRY7LQwpkBg1fWlLeBMR5JXJQgxa38ZHg65XdLmRJC8A=
Received: from AM0PR02CA0171.eurprd02.prod.outlook.com (2603:10a6:20b:28e::8)
 by AS5P122MB0360.EURP122.PROD.OUTLOOK.COM (2603:10a6:20b:68e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 17:27:32 +0000
Received: from AM3PEPF00009B9E.eurprd04.prod.outlook.com
 (2603:10a6:20b:28e:cafe::ad) by AM0PR02CA0171.outlook.office365.com
 (2603:10a6:20b:28e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 17:27:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 3.248.88.141)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 3.248.88.141 as permitted sender) receiver=protection.outlook.com; 
 client-ip=3.248.88.141; helo=ext-eur1.smtp.philips.com; pr=C
Received: from ext-eur1.smtp.philips.com (3.248.88.141) by
 AM3PEPF00009B9E.mail.protection.outlook.com (10.167.16.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 17:27:31 +0000
Received: from smtprelay-eur1.philips.com ([130.138.84.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
 (Client did not present a certificate)
 by ext-eur1.smtp.philips.com with ESMTPS
 id JrqBwEZuztKtZJx4tweUjQ; Mon, 04 May 2026 19:27:31 +0200
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
 by smtprelay-eur1.philips.com with ESMTP
 id Jx4twbNMqUYUNJx4tw1YEV; Mon, 04 May 2026 19:27:31 +0200
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl2xr12.bbl.ms.philips.com (bbl2xr12.bbl.ms.philips.com
 [130.143.223.70])
 by mail.bbl.ms.philips.com (Postfix) with ESMTP id 635B9184855
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 19:27:31 +0200 (CEST)
Received: by bbl2xr12.bbl.ms.philips.com (Postfix, from userid 1876)
 id 58A7B7C022E; Mon,  4 May 2026 19:27:31 +0200 (CEST)
From: jhaller.oss@gmail.com
To: u-boot@lists.denx.de
Subject: [PATCH 2/2] binman: nxp_imx8mcst: disable configparser interpolation
Date: Mon,  4 May 2026 19:27:31 +0200
Message-ID: <20260504172731.156719-2-jhaller.oss@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504172731.156719-1-jhaller.oss@gmail.com>
References: <20260504172731.156719-1-jhaller.oss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9E:EE_|AS5P122MB0360:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 50ed0ab5-20db-41f2-756a-08deaa026c70
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|7093399015|82310400026|48200799018|61400799027|22082099003|56012099003|16102099003|18002099003|35450700002;
X-Microsoft-Antispam-Message-Info: yXeQeUSVeKfQmehYZSpVEwik2iNxqUkA5Kj9xItgP35Glwdwps3XTY3SSD4QJHeAKwOBzRmD1EgGF+t5dVQQKdiEBD6DKssCxuE4rhqggEgpKUtrKtqXwxTBEppfWJgi8iL2A5bhcVNy9hCN/LgT+ih26ag6qQ2HhECowKWQl/NrKpxA/MzeSRQgk6PKaVhCpsQpMuJ0EVAZts6T0ZhHwseP90lMS3zz7vQtG2RYUZcWwOLDfZXlFRxM07iNPvcHG2qLxmPvcHpYbG1IyyE37A7GsGwvMVDDzu//x9hx5+Lpbqz9FGgPuuAzx3PouTtFY80h6HbOUSrOC5xF4kOTrkrLxqhlIasgFwP4gVVJYv/KNiVLq516kaLkl7L7G6rBhTIoo63Npj8iclmeAnJvB0MTG0HKlWSJlQohCbis9urSWg//w5oRDZHzSnWWm/r34Zo2ruhfotJHI9+lu2EDZSDtu6V5uz0hlfmmoPht2G9I1dd5cQIytcO6zGivzXm/Oo5dDXuQZlVp0ic1NXSi2BO7fRqmiu6y6CMjpZ9hlhwa5Wo1OVuGppY9X1hix2mYL8jgElxIaGAc6YEwXeoU9IcSuKmOM1TXGzO6F4TQUsEjrZfRoh7HQ0Dc/yUimhs+370L8TOoMusS3oZGE2awh8EN3XyTv3dilK7tC22geoPIQgNvBGdxlYBRdmX/EPmJ4KL6WH9XMugE1QYjmKOdoGyNvClLPgSU1Ak11oC27zzFTAUVJ0CBRmv/DoxYwUXu49UoWNhvmJgVkif9vwjLbwQioJMdt1LiKlQVKjAtYAc=
X-Forefront-Antispam-Report: CIP:3.248.88.141; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ext-eur1.smtp.philips.com; PTR:ext-eur1.smtp.philips.com;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(7093399015)(82310400026)(48200799018)(61400799027)(22082099003)(56012099003)(16102099003)(18002099003)(35450700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ndQO8joUlYHqwD6M+HTH1UASDVYB5rstJf4zWaLRUwtVbw7T7cA9wh4XdppLnkpcfYPB5+LW4kIMIln3GtbUkGEkf6WRaBWjTUPnfgtQBLMcXrdelrVCy8gY/zDBKreAQmO8LWwSmi1IWUM8KS6wHb1pV+TW/3fiBP/N7QO/o4XS34KdJM3rHvEsXoJg9erMMw4MhK51mHkC+oSu0l/pEV6p7n9ZRd6KJJxOP5/vxlnIM96LOuxIA+63XSKtW+pilZ6OkLDkhAzZK/tzrudF3sI3Gf3Sf/9DgXrZ3ngTRM9WK0tQ48xSOUu7321/oVSr4gOPGkolHitWx5Fq5QuiPbp/N22D69mclH/25rcRH3cMIJxe1oorAJKEJPty6//wtr2lTZgfoz72CdhTWncLudjYY+MUvPMvYyQWQbbl2XOQIP96lJ4Ky48ec5KzjsV/
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 17:27:31.8597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ed0ab5-20db-41f2-756a-08deaa026c70
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4; Ip=[3.248.88.141];
 Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5P122MB0360
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

