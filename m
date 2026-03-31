Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA52FF60EF
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 10:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 128C4840D8;
	Tue, 31 Mar 2026 12:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="WpngS7YL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADEA88412A; Tue, 31 Mar 2026 12:01:04 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B96988407B
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 12:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkSvLs5zDWk23I3Fg3JKUXrrrJwZGMpQIY0m5CY//9/N5b5DiINobJfrRMjHIrC4mdMd6Wctvllduo7CgILSGsRpe07O61E9iulGu4V6zzfqjkT6MtiTEKdz0bKE7V6//ca4oRZo9Yl4StcyibunpmrscCz7qHLP4T3rt6IUQA4gEhvK+H/URqv7O81KIye1SXlVeHUacGZ4AvvV4C65uWfkU2f+Xo0Qb1JR1lbov5m4mbpzhkz5M13xBh4FNF7oaG6fdRuJJIVgKH3babC+iM50WNlJwQ1+UtZOp+Hl4fD+Yh9x6xZDrkz/yH7wGhwzP0dU6t0zrRgjMRra9cXvqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7DbG3Fd4O2ACksdxW8xHxywWg/lo2jtBCkbhzMxBJc=;
 b=gh3y4ynPxaadem87hbHzmD294G+FvENtPL331/iPHAtwKnXBGZfI9yNlLo5XxcWx0J5Jr8OCLdXns/VO7YkJkxkqMRFlyrjZxnXUhAayFHMKlGTFlcyeyC8UHLvD8XO1UlPymlWYtu0mBybMpbRIEfA3zwcsL9l5NR+eeQlk3q3IkcS7ho+v7+g9+s8gdSrFaV1n+zaKUTJbU2tzjbNCfBQMkJjNa2p9zqS3Xo0ajAqJUGcMwvUfC0GksS5xK4Sr18pNowngXMuqhl/3UOBGhItsJ9Qb3OKVr3HBSwnhdKljFvtLmhj9GmmAprNPtmtZ+x5kC0iLWosbmsFDh6A5Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7DbG3Fd4O2ACksdxW8xHxywWg/lo2jtBCkbhzMxBJc=;
 b=WpngS7YLpJ/AyqZwmnjoAzZ0dPOYXgs27ZFglUvHiOlRXEBjaXlbZtTYk8J0PwzX00FyBAJG82fBGroahgZPSP2G/9O0MOl7b/kRG9QzH0l2zH5iGRXreqRFYJH2U6LsN0h1PQgeDOcTc72kLQ3dTkKiaOxmnarxraqW7X1BrApC1FlHdp0HHgTSthVWF9i5jMiMG36ebrWh8EPa4+hh6157kDoCAE4y2p4z5RY1abs/k3y4WpoOfBVbqitBkbeMdxq7tZ/yRKoygtI3Maifg7a+ypG9zG+XxUT64bR84WqtdKntkU0wJxGkOKeJDSay5welf9mhklH3MrJQTN+eag==
Received: from PR3P192CA0023.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::28)
 by PASP264MB5856.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:499::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 10:00:54 +0000
Received: from PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:56:cafe::25) by PR3P192CA0023.outlook.office365.com
 (2603:10a6:102:56::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 10:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B8.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Tue, 31 Mar 2026 10:00:53 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id 1C236201AE;
 Tue, 31 Mar 2026 12:00:53 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v3 09/15] tools: mkimage: pre-load: add support of ecdsa
Date: Tue, 31 Mar 2026 12:00:41 +0200
Message-ID: <20260331100047.34618-10-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331100047.34618-1-philippe.reynes@softathome.com>
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B8:EE_|PASP264MB5856:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 61a4f131-60b9-4122-5887-08de8f0c6523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: wDhlfloZ4chdVA1DLRtFCuDo0LgLGX0e3w5GGli9PbVijpO8LD2hDQ8rI7kc+oVDfmT+q2+Di9RpJYQLYY08EXKmByheHjhFCScc47ToYRzctl7KM/IVyG9kNzBWTHcnz7wK8wLAX+2l0GyBuEqkiRvMWkP/vHTyfvAg2NnJosMixMuoBILiCfWLZ1qjuOLkG3lzlTzcEGIwXN7q2Mv33CftMwZJz6Yv7V7931gEofg0QsqNGj4JsaIDQedw1RMi4bcxTdPi/Y22BUjF9ru1Dtxx248mRq9kYCUrgJfuTCPy9W0Wn+vcFBmEk2cdFqsTsM7BBT5bxKiMXH2t2U/49Nb1c3LwWGrhsK2Filvif3mdtREhaBjB/3/z8/xNBd9PkIyoX8vbNVD9UjOrXWcW9Ck8aNIBy0q/fjGrWS2HJv6rY2MTs1Iux0BcBVQWUP3fcXfKCPYaypdP4tDhMKp4UhEOowaY5R53jEM94oWMRyxcNtk+miDIZfSTjfFqlaQvtm4BBKxDlS28o/ujRdNJAn7DhXzxcfzdhLrdj63b1oroizRzcQstGQyaIHt8vyr+TMKuvdwvajaoYybFhL6Q2luu0qOrUTpgcJyoy0bvRuapna99vcTadpDCU+hGjZFN+t/oApYgTN4p43sIMcan+LAhaz2e/KoHLhmKbfw0qqC8WHIKxJC194KW3t7bBsSAPDb7mn4HTBWVOsSAEbxQq7X5zF/KvDudNblaTUrW3I6V+9CS7vndQmV+J4lOytWPpmzPXcVWkgaSRuaO+Cs+vA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6KRBxrQnUG4H2zEUNYAlKbaPs9GPhJ83s7UzxGQoLVdSpSDEPI5VTRZKmE1L393Tb9/Urace3EEAANxCoTAY9fym4cSxY/ATHKE97TgDL5BXPGb1s9Czqlsrxj811NNwMnYA2zm4mYL0KZjEGGT5fUa0qO6WluF8WLgPEIrl7yXgHwZMdvfRm0d6nYX/eF09XF+vN2ujEI+ZMG3dh8Ky+AZYEVPynEIR7kbC/FBOkqp4jFAk4wJtUarsmre36/VPAMZFaBdehH0O9tzjIdUCt2IJ3q3VJ0649I2zkIvzVN8hvKbj7OSIwJWKHpHeQGIMbkD6sSNTdA3JjLjp50OmxtggiQO0hGOkW3SXUFL+mjKX0ttywlbrGobmIfeVM7fak4rAcok9kpP23ybZd9ApDj1oRUQ6X95YzkISznF3rJJxhbdFuWQJVbfla1YE0zRm
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:00:53.2287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a4f131-60b9-4122-5887-08de8f0c6523
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5856
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

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version

 lib/ecdsa/ecdsa-libcrypto.c | 29 ++++++++++----
 tools/image-host.c          | 78 +++++++++++++++++++++++++++++++------
 2 files changed, 88 insertions(+), 19 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index f8ed694595c..ff396ef9987 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -463,14 +463,9 @@ int ecdsa_verify(struct image_sign_info *info,
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
@@ -505,6 +500,26 @@ static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
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
+	if (info->required_keynode > 0) {
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
index 8b550af0dc1..9e7f756a276 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -13,6 +13,7 @@
 #include <fdt_region.h>
 #include <image.h>
 #include <version.h>
+#include <u-boot/ecdsa.h>
 
 #if CONFIG_IS_ENABLED(FIT_SIGNATURE)
 #include <openssl/pem.h>
@@ -1244,13 +1245,62 @@ err_cert:
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
+	int keynode;
+
+	memset(&info, 0, sizeof(info));
+	info.keydir = keydir;
+	info.keyname = strdup(key_name);
+	info.name = strdup(algo_name);
+	info.checksum = image_get_checksum_algo(algo_name);
+	info.crypto = image_get_crypto_algo(algo_name);
+
+	keynode = fdt_path_offset(keydest, IMAGE_PRE_LOAD_PATH);
+	if (keynode < 0) {
+		fprintf(stderr, "Cannot select keys key_node: %s\n",
+			fdt_strerror(keynode));
+		return keynode;
+	}
+
+	info.required_keynode = keynode;
+
+	ecdsa_add_verify_data(&info, keydest);
+
+	return 0;
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
@@ -1277,17 +1327,21 @@ int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
 		goto out;
 	}
 
-	/* Read public key */
-	ret = read_pub_key(keydir, key_name, &pubkey, &pubkey_len);
-	if (ret < 0)
-		goto out;
+	/* Is it a RSA or an ECDSA key */
+	name = strchr((const char *)algo_name, ',');
+	if (!name)
+		return -EINVAL;
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

