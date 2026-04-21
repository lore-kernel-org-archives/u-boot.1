Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DE3F94CB0
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 21:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE309842FC;
	Tue, 21 Apr 2026 23:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="m2GACnT8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16550842FC; Tue, 21 Apr 2026 23:10:09 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9E4D8419C
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 23:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wp5ks2N0IyhU0NMKKLMTlCMtri5j7QnHaikSnFmoKd/fm2acGkmQDZrkFbUK3EkG7S4DO4tLjmuzNQZAfYVQLHMPp4o9yDZLmjQUJ6TO5oH8EakISBoRJrUIERLE2HPDqNP+wSo+NKF3rPup+swLpvTr/iP+z/WY37RmPc9yQRjboIk0CP2wRZ72MGwSVNjkZLJC6RWyg21c6DmOdPEpN8gDjR20jWZezaOzq7bRvSvEG82iW6d/5FK/0Dfk4XVMZ0VEwqS45CmQ9WgFEq/WpYVYP8dht16bDaFfpVqr9fhFxQXfY0rk+fNyYSGsjxkv4DjSXLixobIk8GxqNs/HbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvTJku6PMIRbxkq4cbaXX+4C09UoHKoAWQrp9fCXYxc=;
 b=TS33DcpIdVIMGzWHpcvy5jBmGAJrDOunUgZMahhHbHb4oFggIQ5JQx4CH+IrcC7QFzvab+2rl22UbexyNn2gbOF+JquqQidrTg9YJH60gsStMrr/Slr1Sgtid3Yz2ihITK4z+aAvBQOgQkaNMhbEa75+t8PRk/iq1swXHuldOhATgkveONRjhspN+Azzw6ndtOZBlVidLpzOalBSIep/hW2Q9XvYQ2BnwlCN8cxCGDtNKCyXr2acNAP1cvg3PEievvjxSBc0Op/4fcmr+av7TMiD29rox3H14TrsubHxW7diOf1kD6Nfqm7sFh72QTkDat28crZ6wbweHT20A0azsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvTJku6PMIRbxkq4cbaXX+4C09UoHKoAWQrp9fCXYxc=;
 b=m2GACnT8QYKqYbYAb0Th/DKmziWERco+4X5q9XCCz7AOhfwhA9vIKpsuUB3EhnrhsHiXWNHNRNCXnPrF558dRri1XzpAVFJO9rW2iVwVsKtylPYQutgbJX46VqHqrW2Mnr16BnzHVr7nXrFPE4Ykhw9tUQddseORAt8PKj2c5R2Iky7qtpSuBRmnD3/Y4px1aP9OfYHF+bCqtHZjydW+2Ma6rRT+TgJvzlvCE9tTEYoHpuUbxFtu03QHvHD3VXT654YufB4+FQwkulmiqO/2NDVK3QN8I0+NHuolApQ1wBwdJt387ZpvLat7K163QXl7kbl1NojD4b8q+i+M7wpc2Q==
Received: from PA7P264CA0357.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:37c::22)
 by MRZP264MB3130.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Tue, 21 Apr
 2026 21:09:57 +0000
Received: from PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37c:cafe::89) by PA7P264CA0357.outlook.office365.com
 (2603:10a6:102:37c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 21:09:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FB.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Tue, 21 Apr 2026 21:09:56 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id BD06C20737;
 Tue, 21 Apr 2026 23:09:56 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v5 01/15] ecdsa: fix support of secp521r1
Date: Tue, 21 Apr 2026 23:09:40 +0200
Message-ID: <20260421210954.1170437-2-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421210954.1170437-1-philippe.reynes@softathome.com>
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FB:EE_|MRZP264MB3130:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e618216d-1d1f-446c-4a75-08de9fea5759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: C1UG7eCTDz4/kcBfFKExzpYAZnzjbL8/+dOilsRRWtywg6nYwRE4b4RKOcxCPTgDu/hxbSapBs/04yVVAnsErxjtYKfm6dFDjpGNYMTVuXzuqhjRI/bKPTgzhrMSUH1ewG/0uDT8qsF10tY36PUrHQcyrxn1Lp9NZtH25DaNeqQGPZ6SazaO4nHjSgI3eevAcbF25fXyh/SZDbpwtK8zvxwbSey6T1JKSkyLMDupp8yOBwF8VBeVYe+T/E8zWm93FmwUxNDvZMvfz28/ZJH16JngIgSbVibUfN3ZoMO2+EMikzgnw+oillbJI4Xr5mSvUyAp5gUQOxjWLM+DzIbbdXeB4iPbeV3Uh0vALUEfZMhPpvpae+oKsw77WECuPVoehRTHELdLkNqA0kMvz+JL5pgC5+1eIaOxStEIZy128J/DJZ4fk1FzihNCi1iSDljsyNYnFLRItLy2VihCwhR24Wy9+NicaS5z3HGLr1bPGr4bJG2XeCldwtF+v7hE0VMUoMwsY8qKGFgzUzxCYm2HRvSd2B0QbqZfIuoESrRIArl/jk3Py8TRQUUJ1ANSMb0lo6exen5tpxn3cN2mixyTd97MzXN7+9FZsj/z/bzE+Df5HGp4T2aiJ9gao/Y2y3laVKlLQfUG3vE3UPihP7LzbxorjGUCCF7xVPEaXnFGR6kt8d7sXpREcowxOtq8sjsCU3/EiS7Ijuyp5p/0ThmuMt0GcRXDHNX4LqAdU2N+JbPbOJVxxk0eSDIWcR8O/b0axVvOM97nFtBinJxnxeIx3w==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GEtUzWdo6CQ/3vDebMRy7cMnmaBpmrZcjRbybX1F+K0iV5nxT6kHYSell6VOcTs+Y95VYXQ0oa4uH+niGdzXcr1iz9rHKd/tLvQvsMvIF6/AMGg8ni4sUZdOcjBU2O0MmLLDpNE5cFJOkswGFgHuoNgsVtmS7fvHRJP9AKwls5GO3lEdTGxWPCF2WPfxr/p3OoVAo9/Y9JKu+EX1it9bPzXxXYi86pjH6wU9J7RvPxobo31WLIbCVbQNV0/q9u83LDnE/imouc+gHpZHEagctNGCx3WwTaGiYXrpysU38cNYAzUgv4swbKF6dcve0fcfA4lVRyE8B4h2l6W5Ynk90xSmuQ6qO/t9HN/CD/tG5yj/bAfCvsU8EXh9iHGbJjYMAFgtLMk3rg6Xt5sz0ZBwmW6Xze1FVkGHgQQ9W3K4Yraw2oprCwpF1fhWEN0xpaD0
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 21:09:56.9294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e618216d-1d1f-446c-4a75-08de9fea5759
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3130
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
v5:
- check that x and y are not null before using them
- free keys when keys not found

 lib/ecdsa/ecdsa-libcrypto.c | 63 ++++++++++++++++++++++++++++++-
 lib/ecdsa/ecdsa-verify.c    | 75 +++++++++++++++++++++++++++++++++----
 lib/fdt-libcrypto.c         |  2 +-
 tools/image-sig-host.c      |  7 ++++
 4 files changed, 137 insertions(+), 10 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index c4bfb2cec61..41590d22a51 100644
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
 
@@ -63,12 +83,43 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
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
+	if (!x) {
+		fprintf(stderr, "Cannot allocate memory for point X");
+		return -ENOMEM;
+	}
+	key->x = (const uint8_t *)x;
+
+	y = memdup((char *)key->y + (y_len - expected_len), expected_len);
+	if (!y) {
+		fprintf(stderr, "Cannot allocate memory for point Y");
+		free((char *)x);
+		return -ENOMEM;
+	}
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
@@ -89,8 +140,11 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
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
 
@@ -100,6 +154,7 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 	ec_key = EC_KEY_new_by_curve_name(nid);
 	if (!ec_key) {
 		fprintf(stderr, "Failed to allocate EC_KEY for curve %s\n", pubkey.curve_name);
+		fdt_free_key(&pubkey);
 		return -ENOMEM;
 	}
 
@@ -108,10 +163,11 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 	if (!point) {
 		fprintf(stderr, "Failed to allocate EC_POINT\n");
 		EC_KEY_free(ec_key);
+		fdt_free_key(&pubkey);
 		return -ENOMEM;
 	}
 
-	len = pubkey.size_bits / 8;
+	len = DIV_ROUND_UP(pubkey.size_bits, 8);
 
 	uint8_t buf[1 + len * 2];
 
@@ -123,6 +179,7 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 		fprintf(stderr, "Failed to convert (x,y) point to EC_POINT\n");
 		EC_POINT_free(point);
 		EC_KEY_free(ec_key);
+		fdt_free_key(&pubkey);
 		return -EINVAL;
 	}
 
@@ -130,11 +187,13 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
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
index 629b662cf6c..e503627f490 100644
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
@@ -50,15 +57,46 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
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
+	if (!x) {
+		debug("Cannot allocate memory for point X");
+		return -ENOMEM;
+	}
+	key->x = (const uint8_t *)x;
+
+	y = memdup((char *)key->y + (y_len - expected_len), expected_len);
+	if (!y) {
+		debug("Cannot allocate memory for point Y");
+		free((char *)x);
+		return -ENOMEM;
+	}
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
@@ -73,11 +111,16 @@ static int ecdsa_verify_hash(struct udevice *dev,
 
 	if (info->required_keynode > 0) {
 		ret = fdt_get_key(&key, info->fdt_blob, info->required_keynode);
-		if (ret < 0)
+		if (ret < 0) {
+			fdt_free_key(&key);
 			return ret;
+		}
+
+		ret = ops->verify(dev, &key, hash, algo->checksum_len,
+				  sig, sig_len);
+		fdt_free_key(&key);
 
-		return ops->verify(dev, &key, hash, algo->checksum_len,
-				   sig, sig_len);
+		return ret;
 	}
 
 	sig_node = fdt_subnode_offset(info->fdt_blob, 0, FIT_SIG_NODENAME);
@@ -87,15 +130,21 @@ static int ecdsa_verify_hash(struct udevice *dev,
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
+
+		fdt_free_key(&key);
 	}
 
 	return -EPERM;
@@ -135,6 +184,18 @@ U_BOOT_CRYPTO_ALGO(ecdsa384) = {
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

