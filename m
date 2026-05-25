Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68371CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 13:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23A6484867;
	Mon, 25 May 2026 15:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="bwPKSvla";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A822C84713; Mon, 25 May 2026 15:52:53 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B14E8846CA
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fO8dfQ+fUWcFRc6xIEW3+imztrHg1nFrrQJPc2tAUG5b3g+VBMOkHPDKH2gr5gM2m+tcdnbZui+tUtq7BzcBeuEJfE+Juu5U6yRONogwMuDO69xuDdayIDPiuPRMt86mXs6YQJd9KI05bjyTm3pJeWJxr1oZJRR6FlIByegbt7iOIuRv1AlupmUMkB/yPQClFB6NJvDxMtnWmijEmeCrWL80h/19vuzWet2LLIPJgt2eYYndddvNEhWibMSV698E0av4yMnpA8eGfiF04zQs54Xjd9DT2+EZwsre6rUHcDk4WRIikqOlBKx3INOSDt+eYglgmx0Wmsl6g3Zl0rNigw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znmhdOLDVnyA87fsEkRXD54GXlythtxHWq/FdOHeOkU=;
 b=SFe72ljx62KveoMswKoLX5mj0ZzuZ648Fp0JdQRLLI/yNVYO1sqZQWP1HHhXc1MRSZY2mxMmErck15P/VuVlduWbZjUU0rE7Vx+LoVR8U4hqH9xu/Ngz2fRlj0NHsD5U97D+G5hKKxVoleS2jQV8mxVpBq8DhVqG9H0Kl4mcBiV8QffRDGkcJwTBCiCeporGLWeZvy/O97WAWYN6ZWaKrvmk9/Krf9sr9chhsEZWEaQunXgf9wnaW6iX1GYEzR3r9LAo5WhTxwFeIv2vbq6S0894/gue0w6BD+qqZljwdLVGnB8bXEm/H/2IQzm+8wNmWq4bzW+jh++ZAm3ltnlbFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znmhdOLDVnyA87fsEkRXD54GXlythtxHWq/FdOHeOkU=;
 b=bwPKSvla24ceG5pAHJsk/GIpJJXlocfyftgNdRGxNfswBMj1MZrKRo8d8Jos5zH8ExtdU+qkwlzxJCdDE7W4nRqP2COe4OCvAijgfuORmt//Qomlu/48/FhuVB+0wV5tO3Qd0ONu5RrQ+1bfAprpmCCWoP7QVns/VawKCyZrgrOwmXH0iANxJMBQOiDRXVhVdSAOCthOpAXZt7swqUHugWm4sorOMoJr/lAuJib1SIe0qr5MzUsTMqUjkPfaBOzgge5n3du/liwBogJ/FjdGd2ggRe+dS0VsA2+1CiL0HEFaw1HXJVD7zHRYtgAphQ6kzfFxEiY9st13C6eldNDV2g==
Received: from PR3P251CA0006.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:b5::24)
 by PR0P264MB2360.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:52:45 +0000
Received: from PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:b5:cafe::3c) by PR3P251CA0006.outlook.office365.com
 (2603:10a6:102:b5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Mon, 25
 May 2026 13:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FA.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Mon, 25 May 2026 13:52:45 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id D3C6E202C3;
 Mon, 25 May 2026 15:52:44 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v6 01/15] ecdsa: fix support of secp521r1
Date: Mon, 25 May 2026 15:52:27 +0200
Message-ID: <20260525135241.88348-2-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525135241.88348-1-philippe.reynes@softathome.com>
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FA:EE_|PR0P264MB2360:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 73c29f73-db8d-44e0-3c2a-08deba64e5fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: p2CPiABnCfJq2SYDMVmD8KLY3a197bH9Bk91UQDALDqadSqhY5uV39aNfVjnrdhaoF6r0VbohxgiitOws8STTCoDA0BXgLsXfmWo8HAvFSnYZCjxm6SxXjyGFR7cFdwiGD8pHjlXDL//tadJibtdW3scF3gekxNJqN2deWHWqVvbGYRLAUWDFJ7eWhTSqKFoZHzUgUAMvkHamluV/3uJY0RhKlCi9wiFOkIA+9jIxfjlQbAHnWFgsmxZKc9NLb5uSFpEwZesol0BN+NpM+deKZTMm5mVD0bu54VwTyLl5RucBeRj5jllhE2rMd6FYzGYSyMXLO+anHn/yu6D2vxn7V6D0T6uY37AJYvCxhOJWlVpMKzof2Kk2vrzEyF6OfXesrcPmdiUyApwnzIM27cHZ68jVyGCl3Oq1mPcw/CBqxU6HrpdseSe5+pQi1AU0ljNhTB8nBEhxWpJS3U2fIwx4VBwa8vB/cIEXujYlIa8l+kqbLedN/tndiEADmAiGzxtvnNU9Da1rmFsdY5fjqJoiqbWgisJf63bSp9SnGHyyZOFdjPEeruDXfDMbvvL9/Q014kQgxe4dz+XEPcSy7DftCJquJzyO6pZ1EClgML7m+Mnc/txQYtXDdbWBxAkuAVcR/NXvNNfhGH7PXUMnzKcD+kOFBxxIvIDKJ4E5/1Exq4KuJVQw8t80yRcc4DH3t5O4MPaG4fNQMkbIJJ+9Qrg/D6yrqblH71/coo9msLvmcg=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9Z0XfNa4nZuwSm2BH3Mr8SE4MlyAfEUci5er8Dm1YSMdK7AIckQxXiZ9AdgfwasorFVMqXqLU7StgmaYJu5nTkdrNPadVB5hg5WBdNcdfizpaxq9mCe8JObmwBxXqo9ABJHDWDAy5n7io6Cdd0jnasRdAqaMa2pKP4W4sgsFuE++Nym5X3P9UBwCKpph/C6XV1n8O75PIVdx510Kf23mjRzk4F0fqXi1MSSeyoNb24TKzsi1E54EvMsc7eScsr5D+2goRAMWb9X0ujTy7D/3A5ja7qQhtidkwQam6HfjEQwltjKYXhrz5Z1H97ZlsyJiOYLBSIL/3Xnok8xxuCgFzgifegszmLTscd4bcKSlRUiNMQxKDvXPgUR3ShiQAtbxPWy5pzPMH5Xy1ER3a2UymAuY0QgPDkrUA2r4L80cgNkdza0iNNYAkFntkYuL8f1Y
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:52:45.0555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c29f73-db8d-44e0-3c2a-08deba64e5fa
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2360
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
-v6:
- free x and y if x and y are not null
- do not free key when an error has occured

 lib/ecdsa/ecdsa-libcrypto.c | 65 +++++++++++++++++++++++++++++++++++--
 lib/ecdsa/ecdsa-verify.c    | 65 ++++++++++++++++++++++++++++++++++---
 lib/fdt-libcrypto.c         |  2 +-
 tools/image-sig-host.c      |  7 ++++
 4 files changed, 132 insertions(+), 7 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index c4bfb2cec61..89c1851b71d 100644
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
 
@@ -63,12 +83,45 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
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
+	if (key->x)
+		free((char *)key->x);
+	if (key->y)
+		free((char *)key->y);
+}
+
 static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 {
 	struct ecdsa_public_key pubkey;
@@ -89,8 +142,11 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
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
 
@@ -100,6 +156,7 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 	ec_key = EC_KEY_new_by_curve_name(nid);
 	if (!ec_key) {
 		fprintf(stderr, "Failed to allocate EC_KEY for curve %s\n", pubkey.curve_name);
+		fdt_free_key(&pubkey);
 		return -ENOMEM;
 	}
 
@@ -108,10 +165,11 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 	if (!point) {
 		fprintf(stderr, "Failed to allocate EC_POINT\n");
 		EC_KEY_free(ec_key);
+		fdt_free_key(&pubkey);
 		return -ENOMEM;
 	}
 
-	len = pubkey.size_bits / 8;
+	len = DIV_ROUND_UP(pubkey.size_bits, 8);
 
 	uint8_t buf[1 + len * 2];
 
@@ -123,6 +181,7 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 		fprintf(stderr, "Failed to convert (x,y) point to EC_POINT\n");
 		EC_POINT_free(point);
 		EC_KEY_free(ec_key);
+		fdt_free_key(&pubkey);
 		return -EINVAL;
 	}
 
@@ -130,11 +189,13 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
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
index 629b662cf6c..e58b8892b98 100644
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
@@ -50,15 +57,48 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
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
+	if (key->x)
+		free((char *)key->x);
+	if (key->y)
+		free((char *)key->y);
+}
+
 static int ecdsa_verify_hash(struct udevice *dev,
 			     const struct image_sign_info *info,
 			     const void *hash, const void *sig, uint sig_len)
@@ -76,8 +116,11 @@ static int ecdsa_verify_hash(struct udevice *dev,
 		if (ret < 0)
 			return ret;
 
-		return ops->verify(dev, &key, hash, algo->checksum_len,
-				   sig, sig_len);
+		ret = ops->verify(dev, &key, hash, algo->checksum_len,
+				  sig, sig_len);
+		fdt_free_key(&key);
+
+		return ret;
 	}
 
 	sig_node = fdt_subnode_offset(info->fdt_blob, 0, FIT_SIG_NODENAME);
@@ -93,6 +136,8 @@ static int ecdsa_verify_hash(struct udevice *dev,
 		ret = ops->verify(dev, &key, hash, algo->checksum_len,
 				  sig, sig_len);
 
+		fdt_free_key(&key);
+
 		/* On success, don't worry about remaining keys */
 		if (!ret)
 			return 0;
@@ -135,6 +180,18 @@ U_BOOT_CRYPTO_ALGO(ecdsa384) = {
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

