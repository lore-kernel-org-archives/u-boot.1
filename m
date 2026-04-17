Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB20F43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 13:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A873C842B7;
	Fri, 17 Apr 2026 15:02:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="bR0lBYmx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55F888422D; Fri, 17 Apr 2026 15:02:19 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 052DB84262
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 15:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNxmcIbA8ehGXs6GcB2cmvMZ/EzeHGGKgAYZhyKYGoKYMMO5xrbAdN+mZbRDekOTX79Tn4vQm7qeuPYfsDPfWzqhN0P0ew4z/Rh1KBajvDGhdfmAOk8xMwlqYCpd4t/7QgnY4dGav1QVUdTp/HFaL12Py12jFNozmFyOJrvgjQ861AfThmnkKs8M4NGwqBhQqOiLoMxmhA7ESSzLeT87HW0uJrb5xcgftEiGn3UMpoYD+cmnZ3fCXqre8xQi2HKx46DgEZ/2rpNDXjo6TuUhWEsBiPqoAr7ssVAvf9EJkHc709P4xal3r9D22fRAlY62DgLRVmz9S+I9+wTFxL0wVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHUjkzlP0mkhuvuMEAF3tRhiL3zxHnx0LHlbJiRxqT0=;
 b=EDODsbfX/b2H2MxTDfDHqjbFJhjqsCBBUtzaF5CCFvsRoocT0zIWbTnWEQ6fKLAfdfHXkdsaWEbQuBJn2qM9z2Bs++BS4CKo8iP2d2n2uxZQS03kCuhFIbz4WIbZUbNVEhPIi1Q1rl8l0xmydoMm0Y2YmKv7JAlxxeCEXZlmYMS3Feha4fDTMYh6FqgFwXnzGUIFqQMMLVUj/Mt0dFbeepQPiPJ0HJFwwnI+rt2ixjt3jer8WwmZx9/jP803a4qU2dsdD4LuMG8SvyerrMtK/6yjNr33UuI5QrWZhIt+tDlXxjKldUm3lvPg+j9o3zKyvMjv0BDX1Zn4iICJ/39uHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHUjkzlP0mkhuvuMEAF3tRhiL3zxHnx0LHlbJiRxqT0=;
 b=bR0lBYmxcGbQwyz39N/uIiaGT9FCcjh63rWHOsFrlNbzISBwXNJfUDq/CXDli+jjs4HuQ9OL0xIXmpNxlXmU5r7oqgO0PYgDHfrzgdQNS48j0ko+YdfvKc2JMtQuJQ+69rvtaI6OanfjyL7jORZxc0E4XKC225kbzjlS6QJKKkEn1+udEd6GHA48ao/Xl9E4ksZcSEYZ3TsHn/Qn1Qjxw44uJz53uOkrsageimTXfAuN+Rcys/sUPJgZb8vWCL/nJlT7bg8/fL7cTHCikP1ednaYZUGXdYpvHQfIboGmPCOxySNDjzvon/qHL33zIm+H2N3EfozMfVDWIWm9DqXCnw==
Received: from MR1P264CA0074.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3f::29)
 by MR0P264MB5225.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 13:02:10 +0000
Received: from MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f:cafe::f6) by MR1P264CA0074.outlook.office365.com
 (2603:10a6:501:3f::29) with Microsoft SMTP Server (version=TLS1_3,
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
 MR1PEPF00000D5A.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 17 Apr 2026 13:02:10 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id EA88A20EC2;
 Fri, 17 Apr 2026 15:02:09 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v4 05/14] ecdsa: fix support of secp521r1
Date: Fri, 17 Apr 2026 15:01:55 +0200
Message-ID: <20260417130204.49896-6-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417130204.49896-1-philippe.reynes@softathome.com>
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D5A:EE_|MR0P264MB5225:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f2b65dc2-5ff8-40ad-34d2-08de9c818982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: X4dOGmpCx0RGtocBe9aQOcxaj68K5onvB7rS938DN9+aeGgW1KjhlL5ik2qdhH4Z/84n2RfzqXCSS4dToG6kCuLGdfAE/pby11vT6ZwpxFeny96vD9iHmdwuhf7kO1tladFAKeaXHlPzGu0+hfqDxGGmMDeMbqgYv0Wi8Nz11nSWxTxT83qS87XThG89kIDMyRSY43mDNFyt+V7EUqeJCVRgW/oNKYDdeaHqALm+KOgT+aUXw7DmTfPs68VMHkbe6QZjoCcHP81nthwG6BOqkyALLbv3ve8n+8rz21dYGzWVslftWkAyJAd+zK+Kz+xmWdzqMpheh4hqCAy6NUXzku3BRCNzR2rkk0C3Tw2yud30iTzMBbZiFyJKWXQwTowkmo9RNz4OcFGEuwh2qBk7hi7M06ccXl3O4g3prhlTAcLGEa+KmsgsL20aIC5H4KKtSFeLvOLB3rREVe56zPBbcaQwsClSVd5gU3JXnE4tVVU0RBOOA+fcYHYHJ3vWDw7eLq7XJBsm6qOkfmIJSDH6798kRVPdkRGHN4+sFJNTNFH7x2sy4BlWf0mGEkH3Deyys2mF+6hdQRTC34J91NJ6JjNS6hPXEaHkOW5vVzYPBuGff0pTTl4Z2dxZZIYBgpOyBdhl0IZb7xmogsPsob8m4ayAZK7k2hu7W0ifpnQwvXbUE5Mi3OEdpCFMwa1KvO8q2fb3CCnczcAafiWYrV6jfeJ9WeUN/SEN/bbamUzbfBo1vtv+0QqwHgyThYrmhsn/vKzPNbe1bxXSfcSgA0vp9A==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E+6JPMnOFdrGZYFDFDe0U+iAa/gWU2py5t+uvNDyr4NCvS7QuO1dHqtOmCqawX/PY4xSxQSJQ+5V1KmYSGILAOqQLw0EGxZ8ytw8NapM7B4e41gvCwHScoHTylN39j9FA6Ojl6oXH+puHV5/1m1rjqgfVv1ASv3KRhYf7w8a6e5nkR5PJ9vNth9o5eq1li8sCUxSyDxLDBNtun0XXUEpJkyOmqESD03F98pqEARGqyntMpyXPBkuZ5UAh/lzmlvlFvMpwqXZJOitL5OvT6UNu1L7YslR/xJN6v/Z/c7SLBJtE305k+ly+YWr0Nub/vicQAFpW/RHFn6mFPoq0iDCs/byd7Ct+h5KaOPMyTr+ynJ8Av8CKlFdNSzSWrOitkBCYOBvh7yWT/BUZOPTfwCCldT/yLtEujRt56bjXA5qeFQsH5W5duW2P6C4WMq3GckA
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 13:02:10.4238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b65dc2-5ff8-40ad-34d2-08de9c818982
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB5225
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

Current implementation of ecdsa only supports key len aligned on
8 bits. But the curve secp521r1 uses a key of 521 bits which is not
aligned on 8 bits. In this commit, we update the keys management
for ecdsa to support keys that are not aligned on 8 bits.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- intitial version
v3:
- fix typo in comments
v4:
- fix commit message
- clean code with DIV_ROUND_UP-
- duplicate data before shifting
- support ecdsa521 and secp521r1
- clean code

 lib/ecdsa/ecdsa-libcrypto.c | 54 +++++++++++++++++++++++++++++--
 lib/ecdsa/ecdsa-verify.c    | 64 +++++++++++++++++++++++++++++++++----
 lib/fdt-libcrypto.c         |  2 +-
 tools/image-sig-host.c      |  7 ++++
 4 files changed, 117 insertions(+), 10 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index c4bfb2cec61..9218d06bda0 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -26,6 +26,8 @@
 #include <openssl/ec.h>
 #include <openssl/bn.h>
 
+#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
+
 /* Image signing context for openssl-libcrypto */
 struct signer {
 	EVP_PKEY *evp_key;	/* Pointer to EVP_PKEY object */
@@ -41,10 +43,26 @@ struct ecdsa_public_key {
 	int size_bits;
 };
 
+static char *memdup(char *buf, size_t size)
+{
+	char *dup;
+
+	dup = malloc(size);
+	if (dup)
+		memcpy(dup, buf, size);
+
+	return dup;
+}
+
 static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 {
+	const char *x;
+	const char *y;
 	int x_len;
 	int y_len;
+	int expected_len;
+
+	memset(key, 0, sizeof(*key));
 
 	key->curve_name = fdt_getprop(fdt, node, "ecdsa,curve", NULL);
 	if (!key->curve_name)
@@ -54,6 +72,8 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 		key->size_bits = 256;
 	else if (!strcmp(key->curve_name, "secp384r1"))
 		key->size_bits = 384;
+	else if (!strcmp(key->curve_name, "secp521r1"))
+		key->size_bits = 521;
 	else
 		return -EINVAL;
 
@@ -63,12 +83,34 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 	if (!key->x || !key->y)
 		return -EINVAL;
 
-	if (x_len != key->size_bits / 8 || y_len != key->size_bits / 8)
+	/*
+	 * The public key is stored as an array of u32, so if the key size is
+	 * not a multiple of 32 (for example 521), we may have extra bytes.
+	 * To avoid any issue later, we shift the x and y pointer to the first
+	 * useful byte.
+	 */
+	expected_len = DIV_ROUND_UP(key->size_bits, 8);
+
+	if (x_len < expected_len || y_len < expected_len)
 		return -EINVAL;
 
+	x = memdup((char *)key->x + (x_len - expected_len), expected_len);
+	key->x = (const uint8_t *)x;
+
+	y = memdup((char *)key->y + (y_len - expected_len), expected_len);
+	key->y = (const uint8_t *)y;
+
 	return 0;
 }
 
+static void fdt_free_key(struct ecdsa_public_key *key)
+{
+	if (!key)
+		return;
+	free((char *)key->x);
+	free((char *)key->y);
+}
+
 static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 {
 	struct ecdsa_public_key pubkey;
@@ -89,8 +131,11 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 		nid = NID_X9_62_prime256v1;
 	} else if (!strcmp(pubkey.curve_name, "secp384r1")) {
 		nid = NID_secp384r1;
+	} else if (!strcmp(pubkey.curve_name, "secp521r1")) {
+		nid = NID_secp521r1;
 	} else {
 		fprintf(stderr, "Unsupported curve name: '%s'\n", pubkey.curve_name);
+		fdt_free_key(&pubkey);
 		return -EINVAL;
 	}
 
@@ -100,6 +145,7 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 	ec_key = EC_KEY_new_by_curve_name(nid);
 	if (!ec_key) {
 		fprintf(stderr, "Failed to allocate EC_KEY for curve %s\n", pubkey.curve_name);
+		fdt_free_key(&pubkey);
 		return -ENOMEM;
 	}
 
@@ -108,10 +154,11 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 	if (!point) {
 		fprintf(stderr, "Failed to allocate EC_POINT\n");
 		EC_KEY_free(ec_key);
+		fdt_free_key(&pubkey);
 		return -ENOMEM;
 	}
 
-	len = pubkey.size_bits / 8;
+	len = DIV_ROUND_UP(pubkey.size_bits, 8);
 
 	uint8_t buf[1 + len * 2];
 
@@ -123,6 +170,7 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 		fprintf(stderr, "Failed to convert (x,y) point to EC_POINT\n");
 		EC_POINT_free(point);
 		EC_KEY_free(ec_key);
+		fdt_free_key(&pubkey);
 		return -EINVAL;
 	}
 
@@ -130,11 +178,13 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 		fprintf(stderr, "Failed to set EC_POINT as public key\n");
 		EC_POINT_free(point);
 		EC_KEY_free(ec_key);
+		fdt_free_key(&pubkey);
 		return -EINVAL;
 	}
 
 	fprintf(stderr, "Successfully loaded ECDSA key from FDT node %d\n", node);
 	EC_POINT_free(point);
+	fdt_free_key(&pubkey);
 	ctx->ecdsa_key = ec_key;
 
 	return 0;
diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
index 629b662cf6c..64b56bcffba 100644
--- a/lib/ecdsa/ecdsa-verify.c
+++ b/lib/ecdsa/ecdsa-verify.c
@@ -10,6 +10,7 @@
 
 #include <crypto/ecdsa-uclass.h>
 #include <dm/uclass.h>
+#include <malloc.h>
 #include <u-boot/ecdsa.h>
 
 /*
@@ -24,13 +25,19 @@ static int ecdsa_key_size(const char *curve_name)
 		return 256;
 	else if (!strcmp(curve_name, "secp384r1"))
 		return 384;
+	else if (!strcmp(curve_name, "secp521r1"))
+		return 521;
 
 	return 0;
 }
 
 static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 {
-	int x_len, y_len;
+	int expected_len, x_len, y_len;
+	const char *x;
+	const char *y;
+
+	memset(key, 0, sizeof(*key));
 
 	key->curve_name = fdt_getprop(fdt, node, "ecdsa,curve", NULL);
 	if (!key->curve_name) {
@@ -50,15 +57,37 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 	if (!key->x || !key->y)
 		return -EINVAL;
 
-	if (x_len != (key->size_bits / 8) || y_len != (key->size_bits / 8)) {
+	/*
+	 * The public key is stored as an array of u32, so if the key size is
+	 * not a multiple of 32 (for example 521), we may have extra bytes.
+	 * To avoid any issue later, we shift the x and y pointer to the first
+	 * useful byte.
+	 */
+	expected_len = DIV_ROUND_UP(key->size_bits, 8);
+
+	if (x_len < expected_len || y_len < expected_len) {
 		printf("%s: node=%d, curve@%p x@%p+%i y@%p+%i\n", __func__,
 		       node, key->curve_name, key->x, x_len, key->y, y_len);
 		return -EINVAL;
 	}
 
+	x = memdup((char *)key->x + (x_len - expected_len), expected_len);
+	key->x = (const uint8_t *)x;
+
+	y = memdup((char *)key->y + (y_len - expected_len), expected_len);
+	key->y = (const uint8_t *)y;
+
 	return 0;
 }
 
+static void fdt_free_key(struct ecdsa_public_key *key)
+{
+	if (!key)
+		return;
+	free((char *)key->x);
+	free((char *)key->y);
+}
+
 static int ecdsa_verify_hash(struct udevice *dev,
 			     const struct image_sign_info *info,
 			     const void *hash, const void *sig, uint sig_len)
@@ -73,11 +102,16 @@ static int ecdsa_verify_hash(struct udevice *dev,
 
 	if (info->required_keynode > 0) {
 		ret = fdt_get_key(&key, info->fdt_blob, info->required_keynode);
-		if (ret < 0)
+		if (ret < 0) {
+			fdt_free_key(&key);
 			return ret;
+		}
 
-		return ops->verify(dev, &key, hash, algo->checksum_len,
-				   sig, sig_len);
+		ret = ops->verify(dev, &key, hash, algo->checksum_len,
+				  sig, sig_len);
+		fdt_free_key(&key);
+
+		return ret;
 	}
 
 	sig_node = fdt_subnode_offset(info->fdt_blob, 0, FIT_SIG_NODENAME);
@@ -87,15 +121,19 @@ static int ecdsa_verify_hash(struct udevice *dev,
 	/* Try all possible keys under the "/signature" node */
 	fdt_for_each_subnode(key_node, info->fdt_blob, sig_node) {
 		ret = fdt_get_key(&key, info->fdt_blob, key_node);
-		if (ret < 0)
+		if (ret < 0) {
+			fdt_free_key(&key);
 			continue;
+		}
 
 		ret = ops->verify(dev, &key, hash, algo->checksum_len,
 				  sig, sig_len);
 
 		/* On success, don't worry about remaining keys */
-		if (!ret)
+		if (!ret) {
+			fdt_free_key(&key);
 			return 0;
+		}
 	}
 
 	return -EPERM;
@@ -135,6 +173,18 @@ U_BOOT_CRYPTO_ALGO(ecdsa384) = {
 	.verify = ecdsa_verify,
 };
 
+U_BOOT_CRYPTO_ALGO(ecdsa521) = {
+	.name = "ecdsa521",
+	.key_len = ECDSA521_BYTES,
+	.verify = ecdsa_verify,
+};
+
+U_BOOT_CRYPTO_ALGO(secp521r1) = {
+	.name = "secp521r1",
+	.key_len = ECDSA521_BYTES,
+	.verify = ecdsa_verify,
+};
+
 /*
  * uclass definition for ECDSA API
  *
diff --git a/lib/fdt-libcrypto.c b/lib/fdt-libcrypto.c
index ecb0344c8f6..090246b44e9 100644
--- a/lib/fdt-libcrypto.c
+++ b/lib/fdt-libcrypto.c
@@ -10,7 +10,7 @@
 int fdt_add_bignum(void *blob, int noffset, const char *prop_name,
 		   BIGNUM *num, int num_bits)
 {
-	int nwords = num_bits / 32;
+	int nwords = (num_bits + 31) / 32;
 	int size;
 	uint32_t *buf, *ptr;
 	BIGNUM *tmp, *big2, *big32, *big2_32;
diff --git a/tools/image-sig-host.c b/tools/image-sig-host.c
index 5285263c616..285547994ca 100644
--- a/tools/image-sig-host.c
+++ b/tools/image-sig-host.c
@@ -83,6 +83,13 @@ struct crypto_algo crypto_algos[] = {
 		.add_verify_data = ecdsa_add_verify_data,
 		.verify = ecdsa_verify,
 	},
+	{
+		.name = "ecdsa521",
+		.key_len = ECDSA521_BYTES,
+		.sign = ecdsa_sign,
+		.add_verify_data = ecdsa_add_verify_data,
+		.verify = ecdsa_verify,
+	},
 	{
 		.name = "secp521r1",
 		.key_len = ECDSA521_BYTES,
-- 
2.43.0

