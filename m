Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C937DCD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 18:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77EEE846A7;
	Mon,  4 May 2026 20:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=Philips.onmicrosoft.com header.i=@Philips.onmicrosoft.com header.b="oc83+jaZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E29EF80F0E; Mon,  4 May 2026 19:27:37 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3291D83FEC
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 19:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jhaller@bbl.ms.philips.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0ySPCGX+3cDpG5LSpgU0nxip+mHL2uRYqwvsJK5+/hW9tfNKBjleEGEidWzNXh6DYY6PgA4Wh3VHuB+fA4v//7XUBMRCfIiuH0fi2K2FZVYMStii6hRAqVbid15Ncy7n1iDBImcUkejMO0MiGNHQUuC4YKNqyRkQ9eZL0Iht7GA3DQ0B/1+1bRqFHumzPki284bJVCyZsU4xEXq+Yw5cCeh7kUsexie1Ew9x3lrpHa9OF3mx1ZrZC4p8Z8jrSGF/YWFkYxOV2Otag8rS8yfCeSyu15VLo/LxpYOYpCX+u/GB8Oe4CDI8P5ybuJv7WTuQhKeRU6auQpFDLNb6d9h3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Gs3fDXSwVIKsehVjmjc4t1pA8d95eFZfnI3LYAnFfo=;
 b=JPLXIF97vvvb4RyUnJtRRJQcjNk74EdXwm+0b/Z82LJqGjAtZ+Qg0uUj3JzXx50JbO6d8lxnmhUAawkvg9sbWbxymjByzyGsFPNgyKqFQY8hDQS85Hatoevji7SK23N1X3o6cyiUL2rPaBSAN5w9p8bA2lL16xnqTEG0BnSEeAKQAEjRQVMbNrzjbsdD21W385A2gimkV60feP5iZSkfk8eOdKCfHPy9tJOV1gVPNKiyJnQeAvwNWwcBox+hYcR3DMeH1r8VeD5eHc3msescquqBygzZxCDNZjpSH3tqgKzgpPchclbMmu7cnqeXRk8/bpv+NyCQ0Bes+JPbHyxeUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 3.248.88.141) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=bbl.ms.philips.com; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Gs3fDXSwVIKsehVjmjc4t1pA8d95eFZfnI3LYAnFfo=;
 b=oc83+jaZJCJv5s7K7pnF4Ur9d1W0qSK20hYTfVdanT6Wos+wv6qten5tLT+WPRk182kwf8x3B934Q2sOfoxRjTS0oQYI3Cffgsbotr0jItLdbAegA3bnF4YhWyOhXhPaSvEc00WvsFybfybecXkwNTwhUa89H5vcekt/6Nin2og=
Received: from AS4P250CA0015.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::14)
 by AM7P122MB0232.EURP122.PROD.OUTLOOK.COM (2603:10a6:20b:185::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 17:27:32 +0000
Received: from AM3PEPF00009B9F.eurprd04.prod.outlook.com
 (2603:10a6:20b:5df:cafe::31) by AS4P250CA0015.outlook.office365.com
 (2603:10a6:20b:5df::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 17:27:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 3.248.88.141)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 3.248.88.141 as permitted sender) receiver=protection.outlook.com; 
 client-ip=3.248.88.141; helo=ext-eur1.smtp.philips.com; pr=C
Received: from ext-eur1.smtp.philips.com (3.248.88.141) by
 AM3PEPF00009B9F.mail.protection.outlook.com (10.167.16.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 17:27:31 +0000
Received: from smtprelay-eur1.philips.com ([130.138.84.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
 (Client did not present a certificate)
 by ext-eur1.smtp.philips.com with ESMTPS
 id JrqBwEZuvtKtZJx4tweUjR; Mon, 04 May 2026 19:27:31 +0200
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
 by smtprelay-eur1.philips.com with ESMTP
 id Jx4twbNMrUYUNJx4tw1YEW; Mon, 04 May 2026 19:27:31 +0200
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl2xr12.bbl.ms.philips.com (bbl2xr12.bbl.ms.philips.com
 [130.143.223.70])
 by mail.bbl.ms.philips.com (Postfix) with ESMTP id 615F41847A7
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 19:27:31 +0200 (CEST)
Received: by bbl2xr12.bbl.ms.philips.com (Postfix, from userid 1876)
 id 540957C023A; Mon,  4 May 2026 19:27:31 +0200 (CEST)
From: jhaller.oss@gmail.com
To: u-boot@lists.denx.de
Subject: [PATCH 1/2] tools: binman: fit: support engine override via argument
Date: Mon,  4 May 2026 19:27:30 +0200
Message-ID: <20260504172731.156719-1-jhaller.oss@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9F:EE_|AM7P122MB0232:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9b26ff56-f91e-4ada-8f5c-08deaa026c73
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|61400799027|82310400026|48200799018|36860700016|376014|7093399015|16102099003|18002099003|56012099003|35450700002;
X-Microsoft-Antispam-Message-Info: X6YQXSiad8KueEkyeHRmWIBrgLJYY4h3bJyN5eUF23vqQGtY+yXZtfmZPGUbr7r7U3GhJPPsLBr6idHrb0T25kWOWJOyW+f0XLp9GB9IDCKOWvDL7C9hYESFpLAzVcCyiy+rtYR6S1Iij+4P9wmGwpISpfJTeQ+RQpNO2+6GRy4A+2ge49lscvpACmsu8rS+cnPU8fl13kMKDnFYlv98ov2bUB6uplBwr0MtHfpDdDG+vraN095fD4sJ8iVr21S14AshBpi5YbH0HjUQQGs5/hSphycOVofOZFn9yh0Q7WmFNvgqaPjBa+xSMdusrwXcJ7C25ilPOIJpEaiuUmXxHyNg5R87ziJvm8drnOG9Dhjr6DAurDiJFpNAt9xcPgCZf6iLKioGHEKhUXfRk4K536amAfEUbO1F5J4g9Ya/O/fAmhilE3DoX+jX5eONEkj62P50fZ3SKT4UaSoOU+KGWh0paOUvkRkAKhaDI9oyjsKFqQBr8Bn8CwmnIAnaA5wB37Hm1rLYpN2OxQiN/2ttjWwUGuHOXRUFOiNL1VMO/Rc/irjjbuy7P0oO+OBHOzXjeqqJNaPN0yDeNtGgKkEpjpE91qv/mkvX/ezJCSO+H9Gnn3i2JYyCjpFh9f3/9ZMGS/Swt7GHvbnUZPI7CTOnFR2g0yco5aVUXoFy95zp0bP1q7k7i+3HiyJUlijiRaLoCzY9nBQUZG+yC+nqtLF8bqF8AJr0SOULtEDpqw3Iim3exvhUGtXD2NPagnVodXsXMOSKkT/6XA+px2d781uKgpN+izqR/4Dz93mTpTwahQE=
X-Forefront-Antispam-Report: CIP:3.248.88.141; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ext-eur1.smtp.philips.com; PTR:ext-eur1.smtp.philips.com;
 CAT:NONE;
 SFS:(13230040)(61400799027)(82310400026)(48200799018)(36860700016)(376014)(7093399015)(16102099003)(18002099003)(56012099003)(35450700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a6ly4nR6udXNGQlalKEJV6/xLSHEQeJtCbJdvmRKuj609jjCY8h360kZFuvkKYb+f0BmSlvbgWIsNMeWeo1IKuYrnE8mrikjPHInpsyPrEZVXoeq2KyKVLqdM/0568ZGHqL7v5jnM1tTdroWQyVZZcP+B4y4Q13z/Ph72qGbrm6qhOwBEo55654F73VRYoJOWgN8uzM5W+/4fGqZKzEEPEte3z3kxS1+35id0Na9Mv2R6yoiH3uVJjtHNVVF8PEjeNC6lRUKDc99a8D6YTFPtMnn0sc/dHvHKkPZGE9TLlwn0SbiK7Z6MUUDj0o3LYKcNLb4wds0H751pQjEk2KDb14fNyqqmryOL1QVRhhfkNhcJwTTY1sQbjwhqFzuKe/mX5fyyQnpn3HI687CVMqP9ds+BKuS1XuWA6LaT/d4O88Oc27YQyxahGjsImaIQDpx
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 17:27:31.8802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b26ff56-f91e-4ada-8f5c-08deaa026c73
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4; Ip=[3.248.88.141];
 Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P122MB0232
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

Allow overriding fit,engine and fit,engine-keydir via arguments,
enabling engine selection at build time without modifying the device
tree.

Signed-off-by: Julian Haller <julian.haller@philips.com>
---
 Makefile                  |  2 ++
 tools/binman/etype/fit.py | 13 +++----------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 49d9740327e..ffcc639382b 100644
--- a/Makefile
+++ b/Makefile
@@ -1701,6 +1701,8 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		-a vpl-dtb=$(CONFIG_VPL_OF_REAL) \
 		-a pre-load-key-path=${PRE_LOAD_KEY_PATH} \
 		-a of-spl-remove-props=$(CONFIG_OF_SPL_REMOVE_PROPS) \
+		$(if $(FIT_ENGINE),-a fit$(comma)engine=$(FIT_ENGINE)) \
+		$(if $(FIT_ENGINE_KEYDIR),-a fit$(comma)engine-keydir=$(FIT_ENGINE_KEYDIR)) \
 		$(BINMAN_$(@F))
 
 OBJCOPYFLAGS_u-boot.ldr.hex := -I binary -O ihex
diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index f28b1e6b4cb..4f429261ccf 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -646,17 +646,10 @@ class Entry_fit(Entry_section):
                              OpenSSL API, as second element of the Tuple. None
                              if no keydir to pass.
         """
-        engine = None
+        engine = self.GetArg('fit,engine', str)
         engine_keydir = None
-
-        prop = self._fit_props.get('fit,engine')
-        if prop is not None:
-            engine = prop.value
-
-            prop = self._fit_props.get('fit,engine-keydir')
-            if prop is not None:
-                engine_keydir = prop.value
-
+        if engine is not None:
+            engine_keydir = self.GetArg('fit,engine-keydir', str)
         return engine, engine_keydir
 
     def BuildSectionData(self, required):
-- 
2.43.0

