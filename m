Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9E9CD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BDDB84972;
	Mon,  1 Jun 2026 15:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="FID0EKo7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56A12848D7; Mon,  1 Jun 2026 15:43:24 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF77C84910
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHRAGCOAv1Je4H+LzfRqMgNKrLbg5k8VC3R+VL97g7jymoF8B/ROcWMhq49sVMij+OASYwwVVuy1vqBppxZtWaB85ymGQjAI66xSUHc31xJZqxT6jVRmUua8+B9AKbbbt7F97l3Gz0Gh9Jm0kv0jeUYcj2Y4EGW/+jc5RHbeSMOGZiUQKA5GiNpOuilVsaToefgppvWxWPiJRBv/w8oXqnP12WYfZeJLy7XLMnc1iL1gD2RTSVbtk7feATAI4Km0hMZnzMGX/5qh8wKLOT2RG0KRnQ63WEyLGRheYqzScSkrIuWjRMw7yYYPKfeOWs6Mn356Cbv/tp3TA3D+ddxH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EZTDp5Za5/SpTDQs1DhFDSU7a/jHg2TFCKkLxFjxqY=;
 b=e92byn/Cgduzte0scP6wiEc5hTz91hOd4vdPCWAKQt2Nt9pqqQmV++WOOkJRpN/V62BN9MbWZsGhJKzt7tXiyvPeGbsC5uSL3EmK1KAbrZ9Y8g5Uz1yMp3/LJyFn0mxjJFJsIXZE1n+tkQa10UF5hKQBZomixVIKiDc8gV38U+NgmwpLR/iRlNSsJeZ7W5fBHAbgvO9ur5brDPVn+Ms/uaG570O4VM0l9XjgRU+0LLZLuv0j1XC2HMW315qGP0PfFMVMqmFem3B0GHKNvBTxS2cOt6llcyjM4My+rcklc5cviGr7Gj67BEtLWE6GpVrbqCAXrKC4y1cIA5LEOL8wDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EZTDp5Za5/SpTDQs1DhFDSU7a/jHg2TFCKkLxFjxqY=;
 b=FID0EKo71djjwPPDnX6KaknpXHLW79TUj7na4fmELT0kD0yiKv/FjZBqnxpXiMJALBIUQXmZRNF+yHhN2blgn3YiwSC06M3vcjqHq0A+/km3N6yOvuMQE1cea9o9Vf++gTIxdbSVYcnO6PP27DsqOoB4X7l3iLoBKQG/tfcZXNIiJgw9+iuYIYRa0zfGSINMt0cWTEHUUDqH+hmty/cNPCCldZvCOcUepJ2nnmsFmntUj4Brlv3uWgTAmGqSdLOvfd4qFS4hcHvhm2hWSDS3vgYproTtbOM88ImIaVNefci1yKAfuXIMEEijVBS0Wt3NQ6YYavCCZ+OFBuGCyzYCUg==
Received: from PA7P264CA0447.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:398::11)
 by PAZP264MB2749.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 13:43:16 +0000
Received: from PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:398:cafe::9f) by PA7P264CA0447.outlook.office365.com
 (2603:10a6:102:398::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 13:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FA.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Mon, 1 Jun 2026 13:43:16 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.66.192])
 by proxy.softathome.com (Postfix) with ESMTPSA id 8DFD321420;
 Mon,  1 Jun 2026 15:43:15 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v8 10/15] tools: mkimage: pre-load: add support of ecdsa
Date: Mon,  1 Jun 2026 15:43:05 +0200
Message-ID: <20260601134310.2452454-11-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601134310.2452454-1-philippe.reynes@softathome.com>
References: <20260601134310.2452454-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FA:EE_|PAZP264MB2749:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ff6cb1b8-191e-43d4-3ac4-08debfe3bbc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|22082099003|18002099003|56012099006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: HfkKhOuNpMEfhZ9dQGpF/VaYilfG1w45P2bU7drpARiwknOxqh+CHUBEs6jPOir2jTROYZXXsPmtDMAAOUGIJTEZtXOq/UJuHCDRnI4nvWbkmuJQCJRcB7JA4Wf6DrerEiu2hi5ZuSdPcfd7eyl5T7Mxk2v9sBTDG5L72d0FWDwE8yibDaWU2O8nsnsWHNR8zNdMRxcn9YRC4+jtNSrtt0Ae998zlshKy633H9glP5Q8SE3lQBJSyW+PfkZJBtEsnm1BRD49Z/upMNKAcrcWR8D4VVep38WZkpO0o5m+C/5EIEKG/C6HaXOsAmAS8KuVaHwYCCSlsYljA/YXKyWsabrjl1HMQfTTvwC80lyBCcaNuau6/DWk9XXOgP/yKkb5rdnxqLt8XRi+htj8NwEwSz9oyvQAhHxjVXVYV+zcVuf2DigoA59c46d55iXBaHJlOF5l1Q2zn/eplvNtPbG64VmYUHl+4Wow67pd17VSOP79a19LKh2LStLbGui0Eg945hJxEKN6c63LIdoyQCZYPwRjOwzuWZtpd35Tt+KXk8Y6jWnSwOEVQ11vVCel6a+B6vctsgWBnMPU3kB7lKL/srHyZ6A2D7i3YGDg110CGH4b7N8jyvPuLdQ8ZoRZH+dOa01D6UEkWKxyWuHazGo3stJktrgEPmrMvfAZscNd4Ls6VFGDfS2NFnbvjvuOtNeG9oHWMJcdts77RE3CM2NkXsBGjQ2nwnyqsVaZ47iXJQU=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(18002099003)(56012099006)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZlRdRfZ61iQnPfKkREZXQSu1E9v5ForqRvVBSd/npZ5Fdvld0VkD1rLiyfIucdEDcSOiEVub10oWgEaFASD3CalyHj2oqFioxjLGRO/M7owgX5CsUkiuRP4wDTNGy5YjoQ5CNIW+wn4+i5eb1P7ZrRr5IkzfBjWzHJGD9CW9hDljbKOYBgPxacQafaTRxobkKxspxfDEiwktRKVbfCRP4PEjB+lXSCnQ7hgElR4MSCQ7X2dQOeO8QKuWzy8o8lahv6gStNkoSXR2OxnY3nnDg2F9YTS/uxj+F1/YVFV4863/x1cyzPnx9B7jz3Bhax1llWj3RkR1cI5+/SOD80OwRYJaK7bgiAgKV3lGG/DROUK64iLwU6bIgAXGVBDtoWq3THnqOp+IMpvnWR4jtHoZLXRj5gAnKkRbPTKK0fS04FACtQ45ERhGKAe4mo6WifR+
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:43:16.1663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6cb1b8-191e-43d4-3ac4-08debfe3bbc2
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2749
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

Right now, mkimage can only create pre-load header
using rsa. We add the support of ecdsa.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- use pre_load_noffset (do not compute it again)
- release memory allocated with strdup
- clean code
v5:
- check checksum and algo before using them
v6:
- no change
v7:
- no change
v8:
- no change

 lib/ecdsa/ecdsa-libcrypto.c | 29 +++++++++---
 tools/image-host.c          | 92 ++++++++++++++++++++++++++++++++-----
 2 files changed, 103 insertions(+), 18 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index b3fc75fac48..5e69782424c 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -517,14 +517,9 @@ int ecdsa_verify(struct image_sign_info *info,
 	return ret;
 }
 
-static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
-		  struct image_sign_info *info)
+static int search_key_node(void *fdt, const char *key_node_name)
 {
-	int signature_node, key_node, ret, key_bits;
-	const char *curve_name;
-	const EC_GROUP *group;
-	const EC_POINT *point;
-	BIGNUM *x, *y;
+	int signature_node, key_node;
 
 	signature_node = fdt_subnode_offset(fdt, 0, FIT_SIG_NODENAME);
 	if (signature_node == -FDT_ERR_NOTFOUND) {
@@ -559,6 +554,26 @@ static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
 		return key_node;
 	}
 
+	return key_node;
+}
+
+static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
+		  struct image_sign_info *info)
+{
+	int key_node, ret, key_bits;
+	const char *curve_name;
+	const EC_GROUP *group;
+	const EC_POINT *point;
+	BIGNUM *x, *y;
+
+	if (info->required_keynode >= 0) {
+		key_node = info->required_keynode;
+	} else {
+		key_node = search_key_node(fdt, key_node_name);
+		if (key_node < 0)
+			return key_node;
+	}
+
 	group = EC_KEY_get0_group(ctx->ecdsa_key);
 	key_bits = EC_GROUP_order_bits(group);
 	curve_name = OBJ_nid2sn(EC_GROUP_get_curve_name(group));
diff --git a/tools/image-host.c b/tools/image-host.c
index f5681d6c1f9..ae35a75d5a6 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -13,6 +13,7 @@
 #include <fdt_region.h>
 #include <image.h>
 #include <version.h>
+#include <u-boot/ecdsa.h>
 
 #if CONFIG_IS_ENABLED(FIT_SIGNATURE)
 #include <openssl/pem.h>
@@ -1245,13 +1246,74 @@ err_cert:
 	return ret;
 }
 
+static int fit_pre_load_data_key_rsa(const char *keydir, void *keydest,
+				     int pre_load_noffset, const void *key_name)
+{
+	unsigned char *pubkey = NULL;
+	int ret, pubkey_len;
+
+	/* Read public key */
+	ret = read_pub_key(keydir, key_name, &pubkey, &pubkey_len);
+	if (ret < 0)
+		goto out;
+
+	/* Add the public key to the device tree */
+	ret = fdt_setprop(keydest, pre_load_noffset, "public-key",
+			  pubkey, pubkey_len);
+	if (ret)
+		fprintf(stderr, "Can't set public-key in node %s (ret = %d)\n",
+			IMAGE_PRE_LOAD_PATH, ret);
+ out:
+	return ret;
+}
+
+static int fit_pre_load_data_key_ecdsa(const char *keydir, void *keydest,
+				       int pre_load_noffset, const void *key_name,
+				       const void *algo_name)
+{
+	struct image_sign_info info;
+	int node, ret = 0;
+
+	memset(&info, 0, sizeof(info));
+	info.keydir = keydir;
+	info.keyname = strdup(key_name);
+	info.name = strdup(algo_name);
+	info.checksum = image_get_checksum_algo(algo_name);
+	if (!info.checksum) {
+		fprintf(stderr, "Can't find valid checksum from %s\n",
+			(char *)algo_name);
+		ret = -EINVAL;
+		goto out;
+	}
+	info.crypto = image_get_crypto_algo(algo_name);
+	if (!info.crypto) {
+		fprintf(stderr, "Can't find valid crypto from %s\n",
+			(char *)algo_name);
+		ret = -EINVAL;
+		goto out;
+	}
+	info.required_keynode = pre_load_noffset;
+
+	node = ecdsa_add_verify_data(&info, keydest);
+	if (node < 0) {
+		fprintf(stderr, "Can't add verify data: err = %d\n", node);
+		ret = -EIO;
+	}
+
+ out:
+	free((void *)info.keyname);
+	free((void *)info.name);
+
+	return ret;
+}
+
 int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
 {
 	int pre_load_noffset;
 	const void *algo_name;
 	const void *key_name;
-	unsigned char *pubkey = NULL;
-	int ret, pubkey_len;
+	char *name;
+	int ret;
 
 	if (!keydir || !keydest || !fit)
 		return 0;
@@ -1278,17 +1340,25 @@ int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
 		goto out;
 	}
 
-	/* Read public key */
-	ret = read_pub_key(keydir, key_name, &pubkey, &pubkey_len);
-	if (ret < 0)
+	/* Is it a RSA or an ECDSA key */
+	name = strchr((const char *)algo_name, ',');
+	if (!name) {
+		fprintf(stderr, "The name of the algo is invalid: %s\n",
+			(char *)algo_name);
+		ret = -EINVAL;
 		goto out;
+	}
+	name += 1;
 
-	/* Add the public key to the device tree */
-	ret = fdt_setprop(keydest, pre_load_noffset, "public-key",
-			  pubkey, pubkey_len);
-	if (ret)
-		fprintf(stderr, "Can't set public-key in node %s (ret = %d)\n",
-			IMAGE_PRE_LOAD_PATH, ret);
+	if (!strncmp(name, "rsa", 3)) {
+		ret = fit_pre_load_data_key_rsa(keydir, keydest, pre_load_noffset, key_name);
+	} else if (!strncmp(name, "ecdsa", 5)) {
+		ret = fit_pre_load_data_key_ecdsa(keydir, keydest, pre_load_noffset,
+						  key_name, algo_name);
+	} else {
+		fprintf(stderr, "The algo %s is not supported\n", (char *)algo_name);
+		ret = -EINVAL;
+	}
 
  out:
 	return ret;
-- 
2.43.0

