Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CEFF43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 13:02:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 063ED84297;
	Fri, 17 Apr 2026 15:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="pjRmfIgD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 049D084310; Fri, 17 Apr 2026 15:02:17 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 041A984297
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 15:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjq49x6UNa1JMlymXIWzZ9C2Q8qxGIE0U8n4I1YXw6+F/7t4Xx9agRQD0OzxkxIFhvutLu89GROn2t8UwxyO9dICpXBR1CXh585N7gIyzy6J0RJcFZboEkEpexvXnW7gdzh9Z8HMQsLq25RqxpVqKSoKPMiUuc9xsGNwcuPt0aIoicAbmn0MgRR543Od+cUdMVlU9PFoNqGRs6LAq4CnbuhiLMc8WJgjIRnSqhs1Kr84Iegrbg774+2ZG17zFciMVluKXQ06TvN8TF/RiOdKjqYKgs1gRr4ha6O8rNxDd7+8pyVzDWVaw/qshb7TDgX2aHbO4SMxkSDr8+XIsOGT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vL61mFZcXUwPeXL8UYtu8gOuiyvgKCqJCamFOWv7wlk=;
 b=x+95CMX0MbFLw3WxUQCmyT0cjEu7NhFQ6RAJ0dzFDg5Rpy1sJQ+m9+OgWG4CQL8564sWcUE5aHLFq9s84OGQnVdZ+Dn2j1AYb6+XCKnfV/ECNOULnIaut1/yzwTBkVY5iQ0nenv/q4jMms3+grjhgtQRRJZXEiL16CETSAaYXl0U/X9wevWdWnGVgBAe/E/MicuIXJP3zwf8m9qRb7mAQocQ4Hy0n3Z+PLs/4jPEgo0MDPP5GctI1AANWGHzqKPyM1GSYQhnRzBBOHaU5VyeqWNylbRAqfgq/7oVxAUtDzmYZWQRZ9I8aT981FgohiywVvJFzmhFxta6smH6Mgk3gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vL61mFZcXUwPeXL8UYtu8gOuiyvgKCqJCamFOWv7wlk=;
 b=pjRmfIgD5RqqFZXF8zyxUTJUY8xyOLdeSy7fQ9FPtUMavwvC2P285yr+eTk0j4RhXmw8bsjZqjZ9s3oKFpMWwjzr6jg65L08o3DTwKfLymV8bJsZ7yS77RFm6fg5C2NTzTLmzTdHOu6X4KxdbMvqfDCUgOx3F030fTe30a4BMH1bJmf+WNYRBgTqmwoPHC3xSAfRinJfY/ICjstvq0Z4EoKp6GxBd4mGDDkTkb35n1dYUeAc5k6o7t0wncBEhlG1ni9221gSRb+8IHeQcwKNW2VBYDtQXb7RSqZcsSBeMtewFpMf6n59dmO06/5moH+IE7UeTRM3fVnsdj10g/0hjQ==
Received: from PA7P264CA0513.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3da::24)
 by PR0P264MB2773.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 13:02:10 +0000
Received: from PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3da:cafe::6) by PA7P264CA0513.outlook.office365.com
 (2603:10a6:102:3da::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 13:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B8.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 17 Apr 2026 13:02:10 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id 8232220AC1;
 Fri, 17 Apr 2026 15:02:10 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v4 11/14] boot: pre-load: add support of ecdsa
Date: Fri, 17 Apr 2026 15:02:01 +0200
Message-ID: <20260417130204.49896-12-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417130204.49896-1-philippe.reynes@softathome.com>
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B8:EE_|PR0P264MB2773:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d83fc168-469c-4881-a687-08de9c8189a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: SrOHxEisRqjKWCJ3qusRxxEyurbxmaY1DAt9MGLgGN4eVyhYPpv7bOOl4FKqhvR0RqXJnOMAMwraJ227OsNsTdl3kmZSmkHoFVDMrkybyZ6DciK7xxuUlIMGZF/MZZ+g+noY13mKf2O7OOLIwI/LGj0+vtfxnBSlLrH7mcRZ3bSz0aThCrwE7VWZCOALIDpfGvRJMpZUsnE4LpAjRqEkMZ3G6Dv81gbgr/hxES+Kt/Yi/VO4cMK4U+axQP5GhFJc9XBUId8P4jFp4O3paNVtW6wENPC0lyW4l4EOxBmFZMyLWB5s1XhdvOAR3HBGI8lgRakJLAK2cw445KHWGGgEJ3xAUJgcDIyUoDDy6BpMMUShhfBgJhHmCzMUhyxTKakeCeZUKzvyQZKUw7nh1pOFKjScWZs4W0ibLdrA00D7K30FdMQYWBI+QqjH1a5x3p8X07g37uUgXFdMtVGWR2nqL1iKhEHStnODeQx3tcxuX8SnKkPfnAbUhukwV8xnY8qbVZi8FQl9+f5FOhon2RzweY9iouB47YGUTpFlurcwxmcQBZuw9bVUuNnsoG4pcNHu3okNi12F9wRSn4Bn/E+1ncSUXsvTtRec7DdJQhCC5J2x0pUh6tonjRjUx9vrgiBiWdi6e/gClyn+tJWpU2EVu6qtZ1CeMTsRtebISVeiujzPoTCKJhHD6STTZfJ98Y43JG25aa6yjQNqVCvKtFizy1nUhAS0+PHwde8/jTJKPFDRCAKq1ih8sKcQx15r0UaXyEof5yUjfC8nPd5jDDrWbQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j0GvflSWt1YjfW9TqITU00QUKmY2/ndij5uFH0uLr53w3FUZgwLr6rBstO8kXwVL+w5mMDoOhbqeu/Y22GakwWknkNDIBH4oeTQ9mpuaMG/F9mPmYCyvPNpd8I2ir9KtAuPFLTSo4DUkG3flVPxXf9FC80TKiV539HVpHVJdHH2bjcRQA+5EM8FyfMvi4uGvCSXQoyd02byV4lAvELqqnRQL47psrQthgrxzOPWNQ6IGRD1YTn9z+hjbcfXsbc7b3eE18PC1VFji0yGHTy/O3vbhnN0bGsGjMRAhDfh/Zbq9PVXhfw884Mxsx+2cXnLX9ZPvK1FMN5FSvfKcNAoeM2sYcbRNWm4zCZA5UNsYi9I0yc20Iu/derLDd2dbqE1qnJXq6Nx2N6FyVjKIdqkwq7iSfzdhmJDj97EWg9OymDUGhrl2T49194aOyfdLdqz1
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 13:02:10.6455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d83fc168-469c-4881-a687-08de9c8189a1
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2773
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

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- avoid calling image_get_crypto_algo several times


 boot/image-pre-load.c | 56 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 11 deletions(-)

diff --git a/boot/image-pre-load.c b/boot/image-pre-load.c
index 2f851ebb28c..8298471cd50 100644
--- a/boot/image-pre-load.c
+++ b/boot/image-pre-load.c
@@ -70,6 +70,17 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 	return 0;
 }
 #else
+
+static int is_ecdsa(struct crypto_algo *crypto)
+{
+	int ret = 0;
+
+	if (crypto && !strncmp(crypto->name, "ecdsa", strlen("ecdsa")))
+		ret = 1;
+
+	return ret;
+}
+
 /*
  * This function gathers information about the signature check
  * that could be done before launching the image.
@@ -86,6 +97,7 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 	int key_len;
 	int node, ret = 0;
 	char *sig_info_path = NULL;
+	struct crypto_algo *crypto;
 
 	if (!info) {
 		log_err("ERROR: info is NULL for image pre-load sig check\n");
@@ -114,11 +126,24 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
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
@@ -129,12 +154,17 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
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
@@ -155,6 +185,10 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 	info->sig_info.crypto   = image_get_crypto_algo(info->sig_info.name);
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

