Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03ED0CD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 08:19:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50F9B84851;
	Thu, 28 May 2026 10:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="BvmS9OZC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0DC384851; Thu, 28 May 2026 10:19:26 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B07683FF5
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i27gkMXvrSJteuDcF3sblpICo4v+cPDI7NAgpjtXyvrtSvH1KdTDtHqHQ35SSJxXPBynuALh6djM1jbLrWRL0zVAaIG+jvMbBKz7OqAblB+8vUzURzwwh0Tc8M4csucSmRSwJbcZvFLryBC1ozPpGc/E1aqahFk6hR2Ke2wRY3pp/XLf53rHMh0uOnVfIP8KCz5EGfd6g1HcNGM89csIVZh7JL02EJcoEl13AedvrcNH0IrKQUpn2/Dm2H/W5z2Yxi6m1tCGMflsFMBhrn4zGYoAW5AiOeGWFlBDCh8fjI4rTToFR/L90o7w1Cya2vUmhRmDsv3BX9fNQ7LkzcSZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BK7Y+iqMutJ+9q5YRXUsnEnUAQuP2iMpddwSNaOS144=;
 b=AwC1TdBkaV8YgL98aWFrEfcAfDrC7LzzJ9RwdWgESn9dpgxFzjM/WoI+YNbhNInfpZbk7t2oXlNieqsxmgBjv58zOr/VWxxLQBRj2B+iMxda0/3Tks6flJEmZYGoCRIEULgWkLD5s/2r7IsEj3wTANQH4KEdkDdXArIzCvBQDl5SZ2A/0Dcr+2iUagB8IIN5fYAGxrkX5pYlhOeK1f3r9SDEZU6PzdkyXiBPQnf/oo39SFCiB+u2VoLsMlbMK5ssIscE1lQgrY0uvEznHZkrFWmlnjuFNXmNnpuyDtTzsOmlELsRUTvowVAdGU5ARlVgHqu+tVuIH8OKGF9e30UEMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BK7Y+iqMutJ+9q5YRXUsnEnUAQuP2iMpddwSNaOS144=;
 b=BvmS9OZCFWTxfmGARUxpPlbZBFe4MIkB3b0T+tjVkfyRS7AEsap3bNn7ngD7qPCwCAneopCJ0EaUweo7YAqzAuBBfr2oFTyxnidScRNWYk/NEULN6HTDWf4j26/SkDB6exXtvvB8QsFr4p4P6WtXafpeT5ohDDSYBu9EPjIdUmxb4YqFEa1NSPhAy1l+dWfftEij1QxUj12aAvfB/zsZKjKmFqTmeOX7yOUpOAnmU+fJVu0SLwKU3lDd/smErj+PiQqLhyqtw1Gw/L4UphwNlyknRHSDTTGCN/roYb0DN3AVSMzQrW4tZvUbxgj6Yp14lwjJCYuwIXBlePk53JsWZQ==
Received: from PA7P264CA0256.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:375::10)
 by PA0P264MB7234.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:57e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 08:19:18 +0000
Received: from PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:375:cafe::3f) by PA7P264CA0256.outlook.office365.com
 (2603:10a6:102:375::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Thu, 28
 May 2026 08:19:18 +0000
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
 Frontend Transport; Thu, 28 May 2026 08:19:18 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 7B46520933;
 Thu, 28 May 2026 10:19:18 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v7 01/15] ecdsa: fix support of secp521r1
Date: Thu, 28 May 2026 10:19:02 +0200
Message-ID: <20260528081916.11355-2-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528081916.11355-1-philippe.reynes@softathome.com>
References: <20260528081916.11355-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019232:EE_|PA0P264MB7234:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 939bd24f-ffea-44ba-366d-08debc91d079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KbmELU/p0Z19CCUv7611LUApAk+6KKS3XDvtRU9E5KtZYaI+XzTSYTyUsjTidGzJDuO1hskFNz1omi8UxepxOkmKv9Em6v0P0ZbN5cvOJdYEqxGEygr55Spi4vWFkzg5Eb7a1XQdzBTexJSlYkJDvUrjqjVkuonusjx0lqdS1ldGTXhCgAV6ZQRJN+zpRLpkp5inFGqa/92mghQpxdqQaAwHU2mWTRbr+8Zw+A1CkX4Rq+4z0wDWlBmjFCQfVLfOK+UMk6J7MwtKAhzXEjAdpJsUEtRtK3FF/dlNPdZ7TpltWtD5kGsfFISi/GDb9lU+kCqRAEiJT6p+Z7Lpw+7ygYJHMA8vNI+L8BOjgaw8/JIok5db+72K0tzilWlIDMuSIKDRic1Ep8W1X+2v2lvQUdBIDZU0lsG/d2ekSzDu/6aIozRqU61miO7KVX6eUsoT1Nz+QJdM+YHHCH0sqpGKX2OcJSR5jf7BTr7c9KcyEcpWjlYaiNSKkGzzHU7SgpFwhTIJ/4ieHA3cn/lqPyOHGZkqp0zzUm90UkKmHl9wiUHZwTQE98UQAmGNoCvspiZ5indBUbsbRdvqIejO9PfV+4Rgz1OgMwnutnTcjFBMdaCBj+1O+B40F5+FYdDRAOc16XjFP0IymmtGTvOVGYO0iFXPt3nJcxLZY6iNOgZvJ+wwPSFjSIoJ3LX/mRVXoqO+k6pJBg79gPw2EcSkzciXjc6iZ2s+mwl5SmT7N6l5RhY=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jT5Z00dPviMuTOwYNsEI59TjoqUe6AWPbhegKrNQYAKwBS5Xvvrdv8UCWWRRtEv0aVmYH2BVo96CgXvWo8XSeBhlsJ6umbllzz7M55gk9B4ow3tQnC2FQnd9IGH7XWdSXaXm5hzP/khXuVAP3PwBWaNEb4bMGfaD6S8TEFSTdl79ucL+O8OQoAKeUiCaG4wPm018DE5M1gAIOVRd6TGrm0tzI4F5LOsWA9ufLuS6CF4HnRQ+ea5zmhUiB2DO8hIE+w/rvnb4m9kV6GJFCVYaJYAXPqD4BjJ8GyahT7Fh4ZLThNl/6Mz+wghrjuWhIRtzki6N7Bq48OWAHZNAFX3EnhpSM6xCU7U1VIpNIoe1CfvhBxm6qpu5vMasVgb+XNiInEBx55E/c3GfOALqJmg/10ecEwm/YIhxUdMj2p2FMnbM6YRq8pCqiK3crEBTl0Vj
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:19:18.6547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 939bd24f-ffea-44ba-366d-08debc91d079
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA0P264MB7234
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

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
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
v7:
- no change

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

