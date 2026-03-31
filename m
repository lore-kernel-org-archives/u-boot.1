Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA68FFF60FF
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 10:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D91F684010;
	Tue, 31 Mar 2026 12:01:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="XuU8Anlh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF98284113; Tue, 31 Mar 2026 12:01:03 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BA0A83E7A
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 12:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/3PVbOWtUSY2jxVjmC1/HpXViKO/29oMpjriaPekMwsw/aep+mDtI3Z/4iUAnC3gijxDt1BkiMmToQHwQT5cxjaUZ9IJdN7BYxdtL4CRWtds7zDNvqW0B3Pdu/B+wX+XpRFMeCkHV0wJd4W3Xi0eijPAr6GskKmDxLndEnT4ykoEwlHR77llb+EbJVp6v/XQn6bOnQEjplx+h4E9tT35gwZmFwK4WAniotlQxJev8LVkf3tCryqhnWKcG76QrileXiI7k8jGF29tGsW8eXqWeGb8eaCjKLS4+rUfe2JoeDX/V9L1F6jfU+ZDNbAIcmB1k0pEpcX/bj9zhwbfkQQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOMqvgUCIcGM6jBRMkE4bkZBx7Nmsn+FBZNnJ4bGHaE=;
 b=ReYurV6joI1p5QXn60mbWxVOcidG99k2NnEsTuJSv6UhPa676RGeAv2Reguc4pmW/KnvS9FmcRGBTiV7PgCTYJzaQcrYJdd80Pi21ucnonOu+lMEz5NAu8EbNrezgZFT1Dn2UVRWKU7Q26bN49mD2rAUqG/SKu1v2doSJyoGGjUBTVX7B0r3Fs9dLgLhjurHmNdlEgHjLhwx35+6LjT9jx7Lxnt0WDJ8qsh6jbWNgi2ziGwOO6/Ju9/wN4VF4rjgqzc1U2bXFSmvoi5C6zChOCwARXLozlYWZKEU38MEimdZl3zfHN+jzAiNsi4YTHRAUNBZadSbPcsTyViRTy3yqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOMqvgUCIcGM6jBRMkE4bkZBx7Nmsn+FBZNnJ4bGHaE=;
 b=XuU8AnlhBFZoXTtEF9QcKVIphi5Mco/HEGdgg8LE6lpyZI/pNTfkDH94lbDWHLej2cx0M2LrSdaJwlQtNtI8bzoR+llcl0Hq09SrnZmMC5YMvFi7ZEehf5Q+8rYVNjqMGePQo7Qa2CIeOzQuuvcVD6FqUWeNt5YQPkIVIp1Ti066xPvhrIRjv7ZWywTpoz/Yi1n9BAdJXkhFcPJCHodHIlm9RTl8uNnbZqrcZcrUfFV5f5+nNoCrOPhWLpOeqcDoGWPYvksfsP/RJ1r9GYalFr4psGWSVkH9aIe2R5okRTJ31dqpjvXFrJSXTUT4A4RhAvJ9A3vr5rm7FzjNKy0D2Q==
Received: from PAZP264CA0164.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:236::18)
 by MRYP264MB6542.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:6b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 10:00:53 +0000
Received: from PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:236:cafe::8d) by PAZP264CA0164.outlook.office365.com
 (2603:10a6:102:236::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 10:00:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FB.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Tue, 31 Mar 2026 10:00:53 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id C177420931;
 Tue, 31 Mar 2026 12:00:52 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v3 05/15] ecdsa: fix support of secp521r1
Date: Tue, 31 Mar 2026 12:00:37 +0200
Message-ID: <20260331100047.34618-6-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331100047.34618-1-philippe.reynes@softathome.com>
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FB:EE_|MRYP264MB6542:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0af95ff6-c156-45de-7bcd-08de8f0c6514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Mk8fTVi4raWnfaZGRq6Rv2//UYLtQng/0vlEBERzBwotDktnB0zS0HuP++4fdtV/tUy/tB3ghaGi7RNpQX4yxuVv2lMqNnEUsZJGYNXkvoHla6SWFUZaKdl1ZFcWmjJvlC6SNsvHAR483cvNYLEPw5ZaQeNyknpex7o5UgLpeZdJZAQ56WNYFk47TF9Y3+d5lrIJ4XGp4oHKgXKjKClIQz818DvXMu//ebNiaqNfnjInzQ0eeZemNxhmrHKCX/Y9wiiCp7BpHSgHh3gLYtX/IGiL32wpuXyw+Y9DaGDEAeFXyr2Z2GaoJ6WQaKplZDews2ELriX4pWlLD7TI5BgrcDXK9/+UYH3yP3bB25GlQWsCLxH26XUMwomFL1NCZrBAlOgqNdMX6nJTTZFQM/DFbibsezvoDbFQZVLy3mvCUutn0UhqgU3D8SD7kanEEPTge5Nx5oED83bomq4k2HMor+OePNItDGszxxowI0mfIcod3XSnlWTPIegkVpc3ziq3uEVD9fVw5zVzXCX6ynJdBggY6lx39zIrCw3HbFqafsUWx2O4PMhYwftNR3Bv+FMQOase5xvILOMxyOu4Gn1PvYrA5zpmNW8j8vsAqZ6TdPjBAZjkzQdP5tujJfYOYT8nKbi4QizhFQfpSiClL+XfoLJew/hG+TOVg6NhRuiWeUIzYlhMSAkND6Dt6dPp+RgPYoRc2MaPQ8DlIjEKhPaJfTazqo7TpQnwwTv1p2mLWYAQ04NDktjmO5EeaeWI0Z1XmHmR9NlWMPIfmvlucAKC9g==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZhT3L4WVkpCMJSScY+j9shsfnVJOUOZAd8W/+WT2l3RdRbrxx+WiZ1bJnmjYLO7T3k3/OG/1j5sAws5ZKGfLMkJBwErPtun8QKJvn0cwhwDnXSnxFaH7Kx5+ef85vtplQC4uTMZcbv2ZP9uT7JdmnOF+HuQG/fTmCYGN6AXdDbgkKb9LyAdhMEQURFQ3p6a6idNSsLUYtAtRwZ/PZh7UuChrvXq175PvxcDLE9SGZTpcMuxOAmxJPW4iECP/HX7AveCpO1xkBPyJXuKBF46/IAPbgXf86MIkprC8gY3d6KU8oAi0R0uh5ZgFRbywCkJPJIYpmpXBw9VrpIlsa9qI8pljGlmxQB88YWvMc9NFiISmM/anZ1Z8hXGIAKCeJZ8PK2/MYyX6ujV2PcnwPQt23XReCaggwW5/5ymoVbCCU1EQkS3aHihaHPJ6OhOK8zE1
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:00:53.0930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af95ff6-c156-45de-7bcd-08de8f0c6514
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRYP264MB6542
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
8 bits. But the curve secp521r1 use a key of 521 bits which is not
aligned on 8 bits. In this commit, we update the key management
for ecdsa to support key of any lenght.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- intitial version
v3:
- fix typo in comments

 lib/ecdsa/ecdsa-libcrypto.c | 21 +++++++++++++++++++--
 lib/ecdsa/ecdsa-verify.c    | 24 ++++++++++++++++++++++--
 lib/fdt-libcrypto.c         |  2 +-
 tools/image-sig-host.c      |  2 +-
 4 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index c4bfb2cec61..f8ed694595c 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -45,6 +45,7 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 {
 	int x_len;
 	int y_len;
+	int expected_len;
 
 	key->curve_name = fdt_getprop(fdt, node, "ecdsa,curve", NULL);
 	if (!key->curve_name)
@@ -54,6 +55,8 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 		key->size_bits = 256;
 	else if (!strcmp(key->curve_name, "secp384r1"))
 		key->size_bits = 384;
+	else if (!strcmp(key->curve_name, "secp521r1"))
+		key->size_bits = 521;
 	else
 		return -EINVAL;
 
@@ -63,7 +66,19 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 	if (!key->x || !key->y)
 		return -EINVAL;
 
-	if (x_len != key->size_bits / 8 || y_len != key->size_bits / 8)
+	/*
+	 * The public key is stored as an array of u32, so if the key size is
+	 * not a multiple of 32 (for example 521), we may have extra bytes.
+	 * To avoid any issue later, we shift the x and y pointer to the first
+	 * useful byte.
+	 */
+	expected_len = (key->size_bits + 7) / 8;
+	if (x_len > expected_len)
+		key->x += x_len - expected_len;
+	if (y_len > expected_len)
+		key->y += y_len - expected_len;
+
+	if (x_len < expected_len || y_len < expected_len)
 		return -EINVAL;
 
 	return 0;
@@ -89,6 +104,8 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 		nid = NID_X9_62_prime256v1;
 	} else if (!strcmp(pubkey.curve_name, "secp384r1")) {
 		nid = NID_secp384r1;
+	} else if (!strcmp(pubkey.curve_name, "secp521r1")) {
+		nid = NID_secp521r1;
 	} else {
 		fprintf(stderr, "Unsupported curve name: '%s'\n", pubkey.curve_name);
 		return -EINVAL;
@@ -111,7 +128,7 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 		return -ENOMEM;
 	}
 
-	len = pubkey.size_bits / 8;
+	len = (pubkey.size_bits + 7) / 8;
 
 	uint8_t buf[1 + len * 2];
 
diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
index 629b662cf6c..b90571e9fff 100644
--- a/lib/ecdsa/ecdsa-verify.c
+++ b/lib/ecdsa/ecdsa-verify.c
@@ -24,13 +24,15 @@ static int ecdsa_key_size(const char *curve_name)
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
 
 	key->curve_name = fdt_getprop(fdt, node, "ecdsa,curve", NULL);
 	if (!key->curve_name) {
@@ -50,7 +52,19 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 	if (!key->x || !key->y)
 		return -EINVAL;
 
-	if (x_len != (key->size_bits / 8) || y_len != (key->size_bits / 8)) {
+	/*
+	 * The public key is stored as an array of u32, so if the key size is
+	 * not a multiple of 32 (for example 521), we may have extra bytes.
+	 * To avoid any issue later, we shift the x and y pointer to the first
+	 * useful byte.
+	 */
+	expected_len = (key->size_bits + 7) / 8;
+	if (x_len > expected_len)
+		key->x += x_len - expected_len;
+	if (y_len > expected_len)
+		key->y += y_len - expected_len;
+
+	if (x_len < expected_len || y_len < expected_len) {
 		printf("%s: node=%d, curve@%p x@%p+%i y@%p+%i\n", __func__,
 		       node, key->curve_name, key->x, x_len, key->y, y_len);
 		return -EINVAL;
@@ -135,6 +149,12 @@ U_BOOT_CRYPTO_ALGO(ecdsa384) = {
 	.verify = ecdsa_verify,
 };
 
+U_BOOT_CRYPTO_ALGO(ecdsa521) = {
+	.name = "ecdsa521",
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
index 5285263c616..a2272b196e7 100644
--- a/tools/image-sig-host.c
+++ b/tools/image-sig-host.c
@@ -84,7 +84,7 @@ struct crypto_algo crypto_algos[] = {
 		.verify = ecdsa_verify,
 	},
 	{
-		.name = "secp521r1",
+		.name = "ecdsa521",
 		.key_len = ECDSA521_BYTES,
 		.sign = ecdsa_sign,
 		.add_verify_data = ecdsa_add_verify_data,
-- 
2.43.0

