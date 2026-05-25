Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA912CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 13:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34D478487C;
	Mon, 25 May 2026 15:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="QL6KR1j8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D21CB8486A; Mon, 25 May 2026 15:52:56 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBD5D8482E
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQ6Q6xHx+mRNZ2cAWqlIYFzWVpF/AYoIs5+rPVM/NeZasTv7HODVWicic37RGGSegS4sf9azyGnoAIJCLQ3lKPmb+MFNJrMR+y3l4LC4Kx8uMXQiSH/OJpL+x/RyM1VlbCsO0c8WHl8Zc5lKNZD78ULwkZ2DEbDqQL8cW0S3vZ3opPzvb3ikhzVrlF5awUPsjWqjHCegYkomdo1M18dY8FTO+P/tAeywvpDHTTwLfsI12VRn6nljGQa0PjoR9cWY4Yb1QZH3OTUUaS+PRZKlb/LlAyXImeeWmbo5VvcBAt9+V6wo1tscE4/tC0Tg9c2NU+eIvwWLjdQw7yHNyJHaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXfJh/TvydHU1oUryw9JvfDs/aiVSePXGp9iJF3FRXY=;
 b=KnNOT/X3lAEdCsPrlyOW7MLPM1lrWnj5+hMJNrWIPtbhIAzTRO5UPaMDtWTJLFV77rCKk4SLxujPZgIEMSqwy+2a7qYTxg0mYgf/pyTZEZOpc/6tJOEiGFzE0nEzaQA+ZO+VM617BJMdEgpwVqlnNcGqMYDZCUUoMoGsQ4wouY68BD3YXcnUB4xby2/yyEjs5RbZG7YVSfnJDAwHaOn/LlKFxQQ4hdNsJzTbSqM0HU0t+Mrzink1mPWsy4lL51Wn4TIIOO2iivLnPRHRiv7D30+ntIbksLzeRS3G3toRY+KHemP8BAfmvNxj+38kkg2GumR4YBLd3/X5x9LOmGKjfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXfJh/TvydHU1oUryw9JvfDs/aiVSePXGp9iJF3FRXY=;
 b=QL6KR1j8XLt8YVb245osN9ZZy285P8Bc+WCBgLMggKxqtAZ8kiFsXMXGrsnz5zVOrI6C2D2ZcacjgD1Iekwh3HlsxxO2bqdAAD4Ww8mHCi5tOXl9gyCdaCNbU+H2j7mRBiO2DyO06lTZzDDaiamPVF1UqaWTsGTly2v7ygyCrbQ9wJfjjC26MrhMPiOmHm2LMvrXvmgxakhZQ3swv0qikQrnIzp6IlRYa5A1JMD+Y0qZXN6vz+BmTrgN8SErLeCzT4ZYM8fgPwCnEnTrLW9ygBONcgBPjFPgbCfUmlLz3tnTcclDH4Jwp563eB8avX1UD8orp5XCM27azpin5lfOiw==
Received: from PAZP264CA0230.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:238::20)
 by MRZP264MB3036.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:52:46 +0000
Received: from PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:238:cafe::8f) by PAZP264CA0230.outlook.office365.com
 (2603:10a6:102:238::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Mon, 25
 May 2026 13:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019232.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Mon, 25 May 2026 13:52:46 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id E298820737;
 Mon, 25 May 2026 15:52:45 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 12/15] boot: pre-load: add support of ecdsa
Date: Mon, 25 May 2026 15:52:38 +0200
Message-ID: <20260525135241.88348-13-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525135241.88348-1-philippe.reynes@softathome.com>
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019232:EE_|MRZP264MB3036:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 415affee-02d0-4ed1-dcbc-08deba64e68c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: gTjYObbHwiHIFH5cp4wLeS8UOB8grr2RSYOJjGM2Q46yvQQwodF2X5zt3PHKqlGJEsR/xiqPst4YG+RaX0ivSB1ogvJkENKsUVBpMdJKrXvrbaVfytAAO2GvmUPmVfoirvsIYU3canpvxGnTVdlZowJIs2GI5flG/f5PrKWP3CwzFI4vgmQR50mGU/FvANPCj3W4HxXyRSLtA7TpsWiFzTwfeExQSEyYjR4yirZUNiKZca8UO9B+Dn5AXZgh1BRhZmxDPsYmXetugqso+ydd4u6XK4mCRb5SQZgYPQdur1/YYU89cGMr+8DGvzIrkFTgAswS3TXfw8e7SABTixMsAWrLJrwfKuhLmgvXwNYDVSAJi/sq5+PANRHZ6UXQbS87buvVSzZNhXgu/sFeyhZonkMkdzAywollEXWpdQi4lwMotvbg5S8WzxXvhtnbJJYuSWIc8llt4q1JscrzpdhtaGgu+t/jYzYnSdOiUmNBqUcmHEFWwIV5d+SprYFaW0ugzniYyu8X0NRvqMt0orzRnXkzxJUYfXRZWdjISRUjG83DrU/pr5AVPyeLqqPzmIO4kCSUxdUpVi8Lz+i/3yW4rcf2wrscUNmI9KRVByI+hMaWo5xfDbw0wC1jkqPRGxsmrTuDsupxNGuYZpELoo8zNRuEqmn49LrtF3KbRZN9s12ZdX3eJZYskLA4K8+F/52GJJPUXc9t+WfyzqgAzy7nSVe9kmrIS2Zo3Z/EBMnKOzU=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ezwQHib7T6HF0v7tHLks4u0ejRT2lDf8F2J/z3zaW8bd+ASW/wkzyV/gNZ6tbZlXrB4pU6+1lRjFOOxPLcENAGRNZpMd2tGdHRHBGDVHqckekFOIurAVldhJQWe9X0Gpjb+BUGVRblnsVM/sZpN5qvx1Q/eSzK/Q7bxJw/jTXsi9xcoF1OhEI0T/Ud0HMBuGwDkcLgfcJbsanx2v8NnMUJxm2LpoGkEZ3PMGxD+fvqPUDUV/sv9UbJs5QbWBj9q9KpzvRcGNFPGyHfVd/7FePt8XGMPt0QwRsbD0Df4tsI8MBWepU0G3SD9j5d6GW7JTuTnUCAyWCSVRCxB2OjR/498/hNOwdJptyKmdk789rhX9TmwoWbGS9+yzHV1TidxlvFgXdOv4627GxDOgp9e8uwRyoaH3elMR+oEEslcp+r1nTUjzHXIB7ss1KJCZHIxQ
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:52:46.0600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 415affee-02d0-4ed1-dcbc-08deba64e68c
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3036
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

Right now, u-boot can only boot image with a
pre-load header with rsa. We add the support
of ecdsa.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- avoid calling image_get_crypto_algo several times
v5:
- simplify the function is_ecdsa
- re-use already computed crypto in function image_pre_load_sig_setup
v6:
- no change

 boot/image-pre-load.c | 53 +++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/boot/image-pre-load.c b/boot/image-pre-load.c
index 2f851ebb28c..af72ea6d547 100644
--- a/boot/image-pre-load.c
+++ b/boot/image-pre-load.c
@@ -70,6 +70,12 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 	return 0;
 }
 #else
+
+static int is_ecdsa(struct crypto_algo *crypto)
+{
+	return crypto && !strncmp(crypto->name, "ecdsa", 5);
+}
+
 /*
  * This function gathers information about the signature check
  * that could be done before launching the image.
@@ -86,6 +92,7 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 	int key_len;
 	int node, ret = 0;
 	char *sig_info_path = NULL;
+	struct crypto_algo *crypto;
 
 	if (!info) {
 		log_err("ERROR: info is NULL for image pre-load sig check\n");
@@ -114,11 +121,24 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 		goto out;
 	}
 
-	padding_name = fdt_getprop(gd_fdt_blob(), node,
-				   IMAGE_PRE_LOAD_PROP_PADDING_NAME, NULL);
-	if (!padding_name) {
-		log_info("INFO: no padding_name provided, so using pkcs-1.5\n");
-		padding_name = "pkcs-1.5";
+	crypto = image_get_crypto_algo(algo_name);
+	if (!crypto) {
+		printf("ERROR: can't find a valid crypto algo from %s\n",
+		       (char *)algo_name);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (is_ecdsa(crypto)) {
+		padding_name = NULL;
+	} else {
+		padding_name = fdt_getprop(gd_fdt_blob(), node,
+					   IMAGE_PRE_LOAD_PROP_PADDING_NAME,
+					   NULL);
+		if (!padding_name) {
+			log_info("INFO: no padding_name provided, so using pkcs-1.5\n");
+			padding_name = "pkcs-1.5";
+		}
 	}
 
 	sig_size = fdt_getprop(gd_fdt_blob(), node,
@@ -129,12 +149,17 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 		goto out;
 	}
 
-	key = fdt_getprop(gd_fdt_blob(), node,
-			  IMAGE_PRE_LOAD_PROP_PUBLIC_KEY, &key_len);
-	if (!key) {
-		log_err("ERROR: no key for image pre-load sig check\n");
-		ret = -EINVAL;
-		goto out;
+	if (is_ecdsa(crypto)) {
+		key = NULL;
+		key_len = 0;
+	} else {
+		key = fdt_getprop(gd_fdt_blob(), node,
+				  IMAGE_PRE_LOAD_PROP_PUBLIC_KEY, &key_len);
+		if (!key) {
+			log_err("ERROR: no key for image pre-load sig check\n");
+			ret = -EINVAL;
+			goto out;
+		}
 	}
 
 	info->algo_name		= (char *)algo_name;
@@ -152,9 +177,13 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 	info->sig_info.name     = info->algo_name;
 	info->sig_info.padding  = image_get_padding_algo(info->padding_name);
 	info->sig_info.checksum = image_get_checksum_algo(info->sig_info.name);
-	info->sig_info.crypto   = image_get_crypto_algo(info->sig_info.name);
+	info->sig_info.crypto   = crypto;
 	info->sig_info.key      = info->key;
 	info->sig_info.keylen   = info->key_len;
+	if (is_ecdsa(crypto)) {
+		info->sig_info.required_keynode = node;
+		info->sig_info.fdt_blob = gd_fdt_blob();
+	}
 
  out:
 	return ret;
-- 
2.43.0

