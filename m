Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87F2F94CB0
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 21:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2AB684329;
	Tue, 21 Apr 2026 23:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="b7djlnJW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8496842FD; Tue, 21 Apr 2026 23:10:15 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7BB2842B7
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 23:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qEsiJ97S7ohq978I7dY0KC4pBlw9TXVhfPv9LzMJmszF7QyFXVMYth3XmHRje9N8xo8KRcM9FB0jD7NDUgbooHttbARQDTpkaiogk6S8nthDY41zb++eArgClVyv8QZO6FhqcjvxX644ZZpD/G78IS+a2WKwfBQqqU2P424qwQ67WwZVaYQp39jaVnU3pgQf+/TchZ/pcLce9KYNAHbNesacb/ThSOuzjmJBeR9N+b3eGpMNoV2B7bP66vHOVlFIQwGWCkcECKeK7FQ1r4bH9atHPVPa1U+RIZCv6gPH4PCvYofkwkEvK3+2+fBdGYYjq/31p5JCbEcqcpMugA8uOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVcHIsk2xpc74VUcQdP1ry5OUI4HfVhpLzxchYhK2kc=;
 b=QmGKlOxNihinAcrEntGyzCNTH4jJKwN8wOlMTgU7MRIh5WKF9CqV3HJ2X/vystUey9scS6cBmJS+RZ4SLKAENZI2wuyriZ3Tq6DwWc8scKk9ngJJNynLYUCuE0Fl2bIoLucxx1fC+eZrNU9wZJ/7gUDZJwgBRKaRubjs+8zlvoN50SAHZ5BuM+HT7SKelYh+9YRQz6PvVPIqZ+o2xJCTIxwf6blK9KufghKMRsva1DLxjdWTfO4+K5vnsVf86DTKcITTYvkwRAhYsGW7zNiJ50XAmin2ZHEJwPAOz9o+HhoWAWf9hvYcGD7RQIUR/Gk5DZRs2+uGysBbYPAzEb8whw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVcHIsk2xpc74VUcQdP1ry5OUI4HfVhpLzxchYhK2kc=;
 b=b7djlnJWf2oPYHG0YmZwueq4QQ/m94pHwEl2+j2CcByB2ZULOLg51s49zLCZipaKnoDHouVIDJ25ME9Ip028yReOZ1vigaOF0OpBRGbiOlYT61qmlnLNHvCgli7stiE0NNjjfF1xiuRdSa4Svc+NzqwlSBaWCgMK/rMB3wSAuf9+WRfbtCiVj6EHK4ZaQ1Ep/0tJ0ZUNdUMACt8+l2MB1VvZwYwb+IUbw10FOxgIxZ9rYtbZ2cSAAjSQH8MRu8ZBtihtSEeyARfND8VmZMy8FNT48pe5F4lRy9clQ1/6tb14F+hqXrGMeyu24WRYx576WjtOFLWfGr8NnO/ox4bbAA==
Received: from MR1P264CA0140.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:51::6) by
 MR1PPF68BB94804.FRAP264.PROD.OUTLOOK.COM (2603:10a6:508:1::64f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Tue, 21 Apr
 2026 21:09:58 +0000
Received: from MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51:cafe::b4) by MR1P264CA0140.outlook.office365.com
 (2603:10a6:501:51::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 21:09:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D5A.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Tue, 21 Apr 2026 21:09:58 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id BBB3220737;
 Tue, 21 Apr 2026 23:09:57 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 10/15] tools: mkimage: pre-load: add support of ecdsa
Date: Tue, 21 Apr 2026 23:09:49 +0200
Message-ID: <20260421210954.1170437-11-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421210954.1170437-1-philippe.reynes@softathome.com>
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D5A:EE_|MR1PPF68BB94804:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 465d950b-6f32-475d-e126-08de9fea57fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: MHM/fS6baCbw+AeBz5erZqBLVibL5fx2i5p0gXRLkw/lB1x3s6oNH5s3HI2WPNARHrT4qLw4u1gu/1ideBWIsOqMWthU8qJuDdNLSrzFVgEwkNoa85wDiK/8NDAcamTaRc1kk1o79ku3tFByraWRgfp6CeKAS/fBC1TGvNc3MerA2KskiL3zvVCN9xo820fxavFr4Dy3SBq/L86ngq9ubMVC/v1weSCb4YETTmmYuR5gdsKO0ber+bYdgjRXnFIScZlbNEntJ5p4UNKxRFhDUauNJB0hT0QZU8DavKrW2pzK5znrdAbdvjQBcE5VpMrmTmEgk3yWeiFlcbVku6sqbCsShBpa5U0wpPjVPhC1facjh4k+Gi8AoHk579eQKg7hdyVJ42dcNUID0qvUbVXgjU/KnY7yT8q9qNGP/ZJJ8Re/J5QYOT47OKa3KIohFgysduIqnGJmTE38ql4DLB+CxfGFs0yrX2kps9AFPHJq/cVOFW/6jNO0BBf/WGSdYAGc0aMpI1NIZC86lEXR6ReEmCxtyZToiPFQg1FFxbf38uxpb67msGfeE6zhku5EfG8JBWIhc5zrV7KB0N0iQIc3k1WGAnCPKKiK/ut+lmim8EP5ocmS0DE0TGqCMcVi0OCxn0g3XGXl/VeZnRRwujgYjDyUZEQqq5QhRKO/cJA7VrfMdJhXUyjCIcX6gTfp/IF5IlXXZHceRBA3iuZX+LMTIJxZ0zMQYrQpFD0F1rnIVBgCGVektFsm9MUaD/xMWAggf/zsvYgFggWhZNOJ9+08oA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pswdPWH/DYHKQrXzRr6dTeNzH+7isxeat4IwCfoZ1yE/FcEPCT6Gts9tjxzU/+XuuUc+27tQVWDziTo0hXfC4Ug9VyASuT8rXKzycTZK8x6RLYTTflkLmd0c/bFp705XGjuu4TCRB9k8CCRO5li58BUAoP/mvGvUSOnx19ieaGsQXuHZP44Nm/xwO7dhPacLZjIdt3RojdSFwy2RwrEvNtqjZFi4UPDzX3GQfoMVHenkSkLEDY/vbav90Ovs3gte7GIHx549bR0nA/HKOGSlUQEE4+nxEot1WgkXRbs4dei8wsIgL5Ejcop3amS7IGM1e+IKRHf8i63amSey7pO5Qhp5pg7pJW22HRKRHzapsG5OWk54tNFWPAQkdxro8aoaeva+g+i+lIvYS9OWqhwzDX71YnrkorkOFbbRwvzmX+hPLHZSH59pgO98U5SRVj7P
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 21:09:58.0010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 465d950b-6f32-475d-e126-08de9fea57fe
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1PPF68BB94804
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

 lib/ecdsa/ecdsa-libcrypto.c | 29 +++++++++---
 tools/image-host.c          | 92 ++++++++++++++++++++++++++++++++-----
 2 files changed, 103 insertions(+), 18 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index 41590d22a51..0c7d1809a05 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -505,14 +505,9 @@ int ecdsa_verify(struct image_sign_info *info,
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
@@ -547,6 +542,26 @@ static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
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

