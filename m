Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42D5C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 07:34:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B33BE82A39;
	Fri,  6 Jun 2025 09:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C10EF800C1; Fri,  6 Jun 2025 09:34:33 +0200 (CEST)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDFF981E25
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 09:34:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jamin_lin@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 6 Jun
 2025 15:34:25 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 6 Jun 2025 15:34:25 +0800
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Tom Rini <trini@konsulko.com>, Matthias Pritschet
 <matthias.pritschet@itk-engineering.de>, Anton Moryakov
 <ant.v.moryakov@gmail.com>, Joakim Tjernlund <joakim.tjernlund@infinera.com>, 
 Simon Glass <sjg@chromium.org>, open list <u-boot@lists.denx.de>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 1/1] lib: ecdsa: Add support for loading ECDSA public key
 from FDT
Date: Fri, 6 Jun 2025 15:34:21 +0800
Message-ID: <20250606073425.2688710-2-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606073425.2688710-1-jamin_lin@aspeedtech.com>
References: <20250606073425.2688710-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

This patch adds support for parsing ECDSA public keys from the device tree
blob (FDT) under the `/signature` node. The public key is expected to be
defined using:

  - ecdsa,curve (e.g., "prime256v1", "secp384r1")
  - ecdsa,x-point
  - ecdsa,y-point

The implementation introduces:
- struct ecdsa_public_key to hold parsed key fields
- fdt_get_key() to parse the curve and coordinates from the FDT
- read_key_from_fdt() to convert the parsed values into an OpenSSL EC_KEY
- load_key_from_fdt() to support loading keys using required_keynode,
  keyname hint, or fallback to scanning all subnodes under "/signature".

If "info->fdt_blob" is provided, the key is loaded from the FDT. Otherwise,
the code falls back to loading a PEM-formatted key from file as before.

This allows for ECDSA signature verification where the public key is
embedded in the FIT image device tree, useful for systems that require
signature validation without external files.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 lib/ecdsa/ecdsa-libcrypto.c | 176 +++++++++++++++++++++++++++++++++++-
 1 file changed, 175 insertions(+), 1 deletion(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index f0095e9dbcf..7415d685ee1 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -34,6 +34,112 @@ struct signer {
 	void *signature;	/* Pointer to output signature. Do not free()!*/
 };
 
+struct ecdsa_public_key {
+	const char *curve_name;
+	const uint8_t *x;
+	const uint8_t *y;
+	int size_bits;
+};
+
+static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
+{
+	int x_len;
+	int y_len;
+
+	key->curve_name = fdt_getprop(fdt, node, "ecdsa,curve", NULL);
+	if (!key->curve_name)
+		return -ENOMSG;
+
+	if (!strcmp(key->curve_name, "prime256v1"))
+		key->size_bits = 256;
+	else if (!strcmp(key->curve_name, "secp384r1"))
+		key->size_bits = 384;
+	else
+		return -EINVAL;
+
+	key->x = fdt_getprop(fdt, node, "ecdsa,x-point", &x_len);
+	key->y = fdt_getprop(fdt, node, "ecdsa,y-point", &y_len);
+
+	if (!key->x || !key->y)
+		return -EINVAL;
+
+	if (x_len != key->size_bits / 8 || y_len != key->size_bits / 8)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
+{
+	struct ecdsa_public_key pubkey;
+	const EC_GROUP *group;
+	EC_POINT *point;
+	EC_KEY *ec_key;
+	int ret;
+	int nid;
+	int len;
+
+	ret = fdt_get_key(&pubkey, fdt, node);
+	if (ret) {
+		fprintf(stderr, "Failed to parse ECDSA key from FDT node %d (ret=%d)\n", node, ret);
+		return ret;
+	}
+
+	if (!strcmp(pubkey.curve_name, "prime256v1")) {
+		nid = NID_X9_62_prime256v1;
+	} else if (!strcmp(pubkey.curve_name, "secp384r1")) {
+		nid = NID_secp384r1;
+	} else {
+		fprintf(stderr, "Unsupported curve name: '%s'\n", pubkey.curve_name);
+		return -EINVAL;
+	}
+
+	fprintf(stderr, "Loading ECDSA key: curve=%s, bits=%d\n", pubkey.curve_name,
+		pubkey.size_bits);
+
+	ec_key = EC_KEY_new_by_curve_name(nid);
+	if (!ec_key) {
+		fprintf(stderr, "Failed to allocate EC_KEY for curve %s\n", pubkey.curve_name);
+		return -ENOMEM;
+	}
+
+	group = EC_KEY_get0_group(ec_key);
+	point = EC_POINT_new(group);
+	if (!point) {
+		fprintf(stderr, "Failed to allocate EC_POINT\n");
+		EC_KEY_free(ec_key);
+		return -ENOMEM;
+	}
+
+	len = pubkey.size_bits / 8;
+
+	uint8_t buf[1 + len * 2];
+
+	/* uncompressed */
+	buf[0] = 0x04;
+	memcpy(&buf[1], pubkey.x, len);
+	memcpy(&buf[1 + len], pubkey.y, len);
+	if (!EC_POINT_oct2point(group, point, buf, sizeof(buf), NULL)) {
+		fprintf(stderr, "Failed to convert (x,y) point to EC_POINT\n");
+		EC_POINT_free(point);
+		EC_KEY_free(ec_key);
+		return -EINVAL;
+	}
+
+	if (!EC_KEY_set_public_key(ec_key, point)) {
+		fprintf(stderr, "Failed to set EC_POINT as public key\n");
+		EC_POINT_free(point);
+		EC_KEY_free(ec_key);
+		return -EINVAL;
+	}
+
+	fprintf(stderr, "Successfully loaded ECDSA key from FDT node %d\n", node);
+	EC_POINT_free(point);
+	ctx->ecdsa_key = ec_key;
+
+	return 0;
+}
+
 static int alloc_ctx(struct signer *ctx, const struct image_sign_info *info)
 {
 	memset(ctx, 0, sizeof(*ctx));
@@ -153,6 +259,72 @@ static int read_key(struct signer *ctx, const char *key_name)
 	return (ctx->ecdsa_key) ? 0 : -EINVAL;
 }
 
+static int load_key_from_fdt(struct signer *ctx, const struct image_sign_info *info)
+{
+	const void *fdt = info->fdt_blob;
+	char name[128];
+	int sig_node;
+	int key_node;
+	int key_len;
+	int ret;
+
+	if (!fdt)
+		return -EINVAL;
+
+	ret = alloc_ctx(ctx, info);
+	if (ret)
+		return ret;
+
+	sig_node = fdt_subnode_offset(fdt, 0, FIT_SIG_NODENAME);
+	if (sig_node < 0) {
+		fprintf(stderr, "No /signature node found\n");
+		return -ENOENT;
+	}
+
+	/* Case 1: explicitly specified key node */
+	if (info->required_keynode >= 0) {
+		ret = read_key_from_fdt(ctx, fdt, info->required_keynode);
+		if (ret == 0)
+			goto check_key_len;
+
+		fprintf(stderr, "Failed to load required keynode %d\n", info->required_keynode);
+		return ret;
+	}
+
+	/* Case 2: use keyname hint */
+	if (info->keyname) {
+		snprintf(name, sizeof(name), "%s", info->keyname);
+		key_node = fdt_subnode_offset(fdt, sig_node, name);
+		if (key_node >= 0) {
+			ret = read_key_from_fdt(ctx, fdt, key_node);
+			if (ret == 0)
+				goto check_key_len;
+
+			fprintf(stderr, "Key hint '%s' found but failed to load\n", info->keyname);
+		}
+	}
+
+	/* Case 3: try all subnodes */
+	fdt_for_each_subnode(key_node, fdt, sig_node) {
+		ret = read_key_from_fdt(ctx, fdt, key_node);
+		if (ret == 0)
+			goto check_key_len;
+	}
+
+	fprintf(stderr, "Failed to load any usable ECDSA key from FDT\n");
+	return -EINVAL;
+
+check_key_len:
+	key_len = ecdsa_key_size_bytes(ctx->ecdsa_key);
+	if (key_len != info->crypto->key_len) {
+		fprintf(stderr, "Expected %u-bit key, got %u-bit key\n",
+			info->crypto->key_len * 8, key_len * 8);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* Prepare a 'signer' context that's ready to sign and verify. */
 static int prepare_ctx(struct signer *ctx, const struct image_sign_info *info)
 {
@@ -161,7 +333,9 @@ static int prepare_ctx(struct signer *ctx, const struct image_sign_info *info)
 
 	memset(ctx, 0, sizeof(*ctx));
 
-	if (info->keyfile) {
+	if (info->fdt_blob) {
+		return load_key_from_fdt(ctx, info);
+	} else if (info->keyfile) {
 		snprintf(kname,  sizeof(kname), "%s", info->keyfile);
 	} else if (info->keydir && info->keyname) {
 		snprintf(kname, sizeof(kname), "%s/%s.pem", info->keydir,
-- 
2.43.0

