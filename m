Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09DBCD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 18:08:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0722784690;
	Mon,  4 May 2026 20:08:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bbl.ms.philips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=Philips.onmicrosoft.com header.i=@Philips.onmicrosoft.com header.b="b5Qu4TCj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4755480F0E; Mon,  4 May 2026 18:48:56 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0E5780077
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 18:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bbl.ms.philips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jhaller@bbl.ms.philips.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7DqZ3Ne+jVUzKeiWNDsRhKGTkKVTtw0cBl7EaMsVzWw5xQDfKHf/ucodZHHzwvma9F+OXcWwFkM0+CdekffXWDwPaEjIC98YCrhyWu0whV44KgpVSlw9pqGltU4x0jHqq+ZAEaeHmB9dvbIhxWMVfImeMsI9H4LPzUJpcgf3zk+qGTgpBCCy0vkDZaeapLtdLce8kXggcqcqLO6lipHRNFEfKxaMM9vQh7j2DfixmnUnUjLSGa4HtZHUJCCd/VouLAm72IU9dn5SoxHBebP/Kz03oI2jYfe5AhSTPJL+4YTn36baoulF4OP+RJCWdyPhEMDNPrXR1goWrv/OTYeAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Gs3fDXSwVIKsehVjmjc4t1pA8d95eFZfnI3LYAnFfo=;
 b=kMnhv+B8pfxmo6UiBzI3fe1IMQIjBlkKazE8ceMTdeIJvKAKjLQ/M5fUi9WtJJXaCXOCG9f6YKz7quPTTVaHrnYU3dRGyHLv3Ve36GQdF7k37t/mBasMG/J5KTlZSP0XMURVXAT4YdjzNt4yZzoWVlion5nKKTEKKoqXuEIumqui2ifpL8sJjs41Lftpye9wwS704yKMLNoUYQC5KnxdkN/UPBfwP/zZQs/5030CRK8yZKlYq8R2/r1L1BAwGDjn1/p31cWDjFllFGh8bcWlqrFe9/7bXklbmYKdTteKjz/h8KLogUWWjFsF334KXQmgMykKceZ6pNHUEYUVYqLG1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 3.248.88.141) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=bbl.ms.philips.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=bbl.ms.philips.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Gs3fDXSwVIKsehVjmjc4t1pA8d95eFZfnI3LYAnFfo=;
 b=b5Qu4TCje98LM++VdkAqzKihBzxuo/JfJDutMVEe5eT12MupdREGnwDgotUPe6FI+rZdP4U4AAjXubR1tb4+SiRIKUndJRAH8Hb++62uYa6Jhkc8O8LRfypr6f9PHHhb5kT1Ri+q3Qz1N5HtWIlHtqINtx5UUqA2okqIi4zGpWo=
Received: from AS4P190CA0029.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::19)
 by PAWP122MB0307.EURP122.PROD.OUTLOOK.COM (2603:10a6:102:3a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 16:48:50 +0000
Received: from AMS0EPF000001A3.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::b4) by AS4P190CA0029.outlook.office365.com
 (2603:10a6:20b:5d0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 16:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 3.248.88.141)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bbl.ms.philips.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 3.248.88.141 as permitted sender) receiver=protection.outlook.com; 
 client-ip=3.248.88.141; helo=ext-eur1.smtp.philips.com; pr=C
Received: from ext-eur1.smtp.philips.com (3.248.88.141) by
 AMS0EPF000001A3.mail.protection.outlook.com (10.167.16.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 16:48:50 +0000
Received: from smtprelay-eur1.philips.com ([130.138.84.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
 (Client did not present a certificate)
 by ext-eur1.smtp.philips.com with ESMTPS
 id JrqBwEZvLtKtZJwTSweRRX; Mon, 04 May 2026 18:48:50 +0200
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
 by smtprelay-eur1.philips.com with ESMTP
 id JwTRwbKshUYUNJwTSw1UQQ; Mon, 04 May 2026 18:48:50 +0200
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl2xr12.bbl.ms.philips.com (bbl2xr12.bbl.ms.philips.com
 [130.143.223.70])
 by mail.bbl.ms.philips.com (Postfix) with ESMTP id E20B41847A7
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 18:48:49 +0200 (CEST)
Received: by bbl2xr12.bbl.ms.philips.com (Postfix, from userid 1876)
 id DC8437C023A; Mon,  4 May 2026 18:48:49 +0200 (CEST)
From: julian.haller@bbl.ms.philips.com
To: u-boot@lists.denx.de
Subject: [PATCH 1/2] tools: binman: fit: support engine override via argument
Date: Mon,  4 May 2026 18:48:48 +0200
Message-ID: <20260504164849.108849-1-julian.haller@bbl.ms.philips.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A3:EE_|PAWP122MB0307:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 95b12b13-a757-4b7b-d054-08dea9fd0494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|61400799027|82310400026|36860700016|376014|18002099003|16102099003|56012099003;
X-Microsoft-Antispam-Message-Info: HgEZAtJUOax7LYTbeW6yPIXqKVpcZC1wsdCYzqP6hpbECBNC8nQNiBSQ3Npsb7/mqS+97//b1xaSXNksfIk9Uf9+btULmfaailMAUNw/yTanZYjQNZjD/npI64A8ZvuGT7mkYtDHk8K0SXKfGSB5tDe2PCTVkCGDAS4lmS72F+OSqhlla0tD34IOPv1gNZaznXmWDfyUzASQ9h21lVXT1WbQBnRhF0OTcMauUFRdSZKm+cxSgrbjPIDbf9rVJXituyMKY98rvwYCmogSA3e/w931BTJyR1+bxJEHK2uvC6sjJzwi1rgiFyu7kcuFiKqIISrzEuuQoPyhGWHVeqSjOAxS/8q5KzEDKPzY2i9Wv516e9l0uii55lrkoI+lTNioD6OVia8/FGBAnDUvnry8+LXKzi/G1GyvNfGuWSK0CCqgvUEgFcRHWRNqiVN0a52KFiRpj7f60JFP6hU7O+WMrZPuhhgOVAqN4o8yT+/ilYH5Jwz3Y3JznyZtTCdR7OLnxKkTgFNIt+EH4EBidct9cdjUVw1lACFBA41ZJVrUYlF3NXwNKC9hwD1zIHmSjq3GL4mpNCexhnGtOPl0+na/mwsDUMzAihZvmUBGGCO3G31bzgjQvb99jYKNcWv2VqfUuyYTziffepmtVO38scqx1O4F9ynpZXX4hSYzVZYJnPKCu2384Pdt34a7+WwNlMDv3bm3kBGky0At3S0koC/rs7WdsYIJM42oXr3y2Im8ECA=
X-Forefront-Antispam-Report: CIP:3.248.88.141; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ext-eur1.smtp.philips.com; PTR:ext-eur1.smtp.philips.com;
 CAT:NONE;
 SFS:(13230040)(61400799027)(82310400026)(36860700016)(376014)(18002099003)(16102099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Eeq0R4lIgQuUrwXiYp99FkSTKVErRfQ2VHJtdBLEnVHNezKnnUthc4pxIfjpDghHGV8ITYXwtKebctgeJyNg1d053UHTV7AXw4dlN6opAsg+CdG3F5dOLHcoJATlBbvKxvOfVVVHpXNVBrkqJmkqsTjBbS1mhYNdZ2JfPfCdP5sEVw7xXylIILfpk1LGy/oiz+mZxK7W3EZt6XmZK9/Paj+mwsydIz5GQA917ryFkZlgGweFG5rUBBYb1/+9rHHrPNxIZsfuec1VsGaadUpYzaneEjEy2XcErsJx/EqSH2eJaStW6SFRoys1OXGuzIk60OJ8ylzCb/pyskpwvz3U4l3R5WLyrIIgThjeEepDYDcKqouXx42GYPahNbjsiEIVqZPIIYgfI0AYmaLmVqHgTojm8roxtnlSItxb3z5HJKRwAEWUDn+8Fh+5vdSv8Ibd
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 16:48:50.1356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b12b13-a757-4b7b-d054-08dea9fd0494
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4; Ip=[3.248.88.141];
 Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP122MB0307
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

