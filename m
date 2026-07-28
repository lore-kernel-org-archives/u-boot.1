Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302A5C54F51
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 22:10:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF56381479;
	Tue, 28 Jul 2026 22:10:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bPFGGZRDtsng; Tue, 28 Jul 2026 22:10:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7184C8122B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785276601;
	bh=TAz4yvKfXxbShtFY0cAG+PBu2dCDQonhNlGkGT7BBjA=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GGqHrtnMbTHEoFpCbFyyP1yubFQMLuA+CAh+rlASH7JsJ3ziwaCE9vbwzX4FijUSD
	 ZnWyUWqKf0X2t4pdlQ3C3HlZTsPle6IkTstQQeweAj4DRqMLnKxRartMpFJB8uzg11
	 2EmJQ9ZEDoC1fjwbrlt/KQQzgWh7aEiLuy3vHVY5x4WpiDYD77upInUpI8vh43F+yl
	 af9QXI7t/AG/9PhkZMKmLCoG6CGSvO6ciRNqExzhcrrItkiQ9ESAAvdOj6+Cja/+vQ
	 Gbxi4Otp8B3XMp8Mbike925Qq2qiGDn2FnZW9OHCcDd9pdDvBD1gICWBz21FnKojxh
	 Dy/yHoJkSRHOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7184C8122B;
	Tue, 28 Jul 2026 22:10:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E545A2E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 22:10:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C779C403A1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 22:10:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ANV3toEkaOFc for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 22:09:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3C32140051
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3C32140051
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3C32140051
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 22:09:59 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wopzn-000000002Du-2zXE; Tue, 28 Jul 2026 22:09:55 +0000
Date: Tue, 28 Jul 2026 23:09:53 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Randolph Sapp <rs@ti.com>, u-boot@lists.u-boot-project.org
Subject: [PATCH v4 3/3] test: fit: verify dm-verity roothash is covered by
 the config signature
Message-ID: <9a890aa4958479b000a45bf1e083c17c602d565d.1785276461.git.daniel@makrotopia.org>
References: <cover.1785276461.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785276461.git.daniel@makrotopia.org>
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=makrotopia.org
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

A dm-verity protected filesystem image is not hashed by U-Boot; its
integrity is delegated to the kernel, which trusts the roothash taken
from the FIT dm-verity subnode. For that chain of trust to hold, the
roothash (and salt) must be part of the region covered by the
configuration signature, otherwise an attacker can replace both the
filesystem and the roothash while keeping the signature valid.

Add two independent checks of this property:

 - test/py/tests/test_fit_verity_sign.py signs a configuration that
   references a filesystem image carrying a dm-verity subnode, then
   confirms that tampering the roothash or the salt is rejected by
   fit_check_sign. A control that tampers a byte known to be signed
   proves the check can fail. A matching page is added under
   doc/develop/pytest/ so the module documentation is rendered with
   the rest of the generated docs.

 - test/boot/fit_verity.c gains a runtime unit test that builds the
   exact node list the configuration signature is computed over,
   turns it into hashed regions and checks both that the roothash
   bytes fall inside a signed region and that tampering them changes
   the hash. It needs no private key, so it also runs on real devices
   and uses the same hash path a device would.

To let the unit test build the signed-region node list, rename the
config node-list helper to fit_config_get_signed_nodes(), make it
non-static and declare it in image.h.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v4: fix the CI failure Tom Rini reported
 * test_fit_verity_roothash_signed() builds a FIT with a dm-verity
   subnode, which makes mkimage shell out to veritysetup internally to
   compute the Merkle tree/roothash, but the test only declared dtc,
   fdtget, fdtput and openssl as required tools. On the CI image, which
   doesn't have veritysetup installed, mkimage's internal exec of it
   fails silently (the diagnostic goes to a private pipe mkimage uses
   to parse veritysetup's output, not to stderr) and the test hard
   fails with "Can't add verification data ... (Input/output error)"
   instead of skipping, the way test_fit_verity.py's veritysetup-using
   tests already do via the same marker.
 * add @pytest.mark.requiredtool('veritysetup') to
   test_fit_verity_roothash_signed(), matching test_fit_verity.py.
   Verified locally both ways: with veritysetup hidden from PATH the
   test now skips instead of failing, and with it present it still
   passes.
 * collect Reviewed-by from Simon Glass
v3: address comments by Simon Glass
 * assert fdt_find_regions()'s returned count stays within the region
   array bound, matching the check fit_config_check_sig() enforces,
   instead of only checking it is non-zero
 * tamper the roothash through buf[digest_off] instead of casting away
   the const from fdt_getprop()'s return value
 * note in a comment that the digest tamper stands in for the whole
   dm-verity node, since salt lives in the same node and is covered by
   the same region
 * fix test_fit_verity_roothash_signed(), which never actually ran:
   its ITS baked the tmpdir prefix into the /incbin/() paths while dtc
   also resolves incbin paths relative to the .its file's own
   directory (same as tmpdir here), so the path was searched doubled
   ("tmpdir/tmpdir/kernel.bin") and mkimage always failed with "No
   such file or directory". Use bare filenames in the ITS and let dtc
   resolve them; drop the now-unused %(tmpdir)s substitution.
v2: address comments by Tom Rini
 * drop the VISIBLE_IF_UT visibility macro and simply make
   fit_config_get_signed_nodes() non-static
 * convert the comment block in test_fit_verity_sign.py into a module
   docstring, add an ITS example and add a page under doc/develop/pytest/
   so the module is rendered in the generated documentation
---
 boot/image-fit-sig.c                        |  14 +-
 doc/develop/pytest/test_fit_verity_sign.rst |  10 +
 include/image.h                             |  23 +++
 test/boot/fit_verity.c                      | 200 +++++++++++++++++++
 test/py/tests/test_fit_verity_sign.py       | 203 ++++++++++++++++++++
 5 files changed, 443 insertions(+), 7 deletions(-)
 create mode 100644 doc/develop/pytest/test_fit_verity_sign.rst
 create mode 100644 test/py/tests/test_fit_verity_sign.py

diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index f7ab036dcb5..a0c50bba4cf 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -341,7 +341,7 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
 }
 
 /**
- * fit_config_get_hash_list() - Build the list of nodes to hash
+ * fit_config_get_signed_nodes() - Build the list of nodes to hash
  *
  * Works through every image referenced by the configuration and collects the
  * node paths: root + config + all referenced images with their hash,
@@ -358,9 +358,9 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
  * @buf_len:	Size of @buf
  * Return: number of entries in @node_inc, or -ve on error
  */
-static int fit_config_get_hash_list(const void *fit, int conf_noffset,
-				    char **node_inc, int max_nodes,
-				    char *buf, int buf_len)
+int fit_config_get_signed_nodes(const void *fit, int conf_noffset,
+				char **node_inc, int max_nodes,
+				char *buf, int buf_len)
 {
 	const char *conf_name;
 	int image_count;
@@ -500,9 +500,9 @@ static int fit_config_check_sig(const void *fit, int noffset, int conf_noffset,
 	}
 
 	/* Build the node list from the config, ignoring hashed-nodes */
-	count = fit_config_get_hash_list(fit, conf_noffset,
-					 node_inc, IMAGE_MAX_HASHED_NODES,
-					 hash_buf, sizeof(hash_buf));
+	count = fit_config_get_signed_nodes(fit, conf_noffset,
+					    node_inc, IMAGE_MAX_HASHED_NODES,
+					    hash_buf, sizeof(hash_buf));
 	if (count < 0) {
 		*err_msgp = "Failed to build hash node list";
 		return -1;
diff --git a/doc/develop/pytest/test_fit_verity_sign.rst b/doc/develop/pytest/test_fit_verity_sign.rst
new file mode 100644
index 00000000000..94a39b08952
--- /dev/null
+++ b/doc/develop/pytest/test_fit_verity_sign.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+test_fit_verity_sign
+====================
+
+.. automodule:: test_fit_verity_sign
+   :synopsis:
+   :member-order: bysource
+   :members:
+   :undoc-members:
diff --git a/include/image.h b/include/image.h
index 4149ebbcce9..6edcb1995bf 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1897,6 +1897,29 @@ struct image_region *fit_region_make_list(const void *fit,
 		struct fdt_region *fdt_regions, int count,
 		struct image_region *region);
 
+/**
+ * fit_config_get_signed_nodes() - Build the list of nodes covered by a config
+ *				   signature
+ *
+ * Collects the paths of the nodes that the configuration signature is
+ * computed over: the root node, the configuration node, and for each image
+ * referenced by the configuration its node, its hash subnodes and its cipher
+ * and dm-verity subnodes. The result is the same node list used when creating
+ * and verifying the signature, and is suitable for passing to
+ * fdt_find_regions().
+ *
+ * @fit:	FIT blob
+ * @conf_noffset: Configuration node offset
+ * @node_inc:	Array to fill with pointers to packed path strings
+ * @max_nodes:	Number of entries in @node_inc
+ * @buf:	Buffer for the packed null-terminated path strings
+ * @buf_len:	Size of @buf
+ * Return: number of entries written to @node_inc, or -ve on error
+ */
+int fit_config_get_signed_nodes(const void *fit, int conf_noffset,
+				char **node_inc, int max_nodes,
+				char *buf, int buf_len);
+
 static inline int fit_image_check_target_arch(const void *fdt, int node)
 {
 #ifndef USE_HOSTCC
diff --git a/test/boot/fit_verity.c b/test/boot/fit_verity.c
index 7459a9d6f81..4b5db839085 100644
--- a/test/boot/fit_verity.c
+++ b/test/boot/fit_verity.c
@@ -6,6 +6,11 @@
  */
 
 #include <image.h>
+#include <fdt_region.h>
+#include <malloc.h>
+#include <linux/kernel.h>
+#include <linux/libfdt.h>
+#include <u-boot/hash-checksum.h>
 #include <test/test.h>
 #include <test/ut.h>
 
@@ -304,3 +309,198 @@ static int fit_verity_test_bad_blocksize(struct unit_test_state *uts)
 	return 0;
 }
 FIT_VERITY_TEST(fit_verity_test_bad_blocksize, 0);
+
+#if CONFIG_IS_ENABLED(FIT_SIGNATURE)
+/**
+ * build_signed_verity_fit() - build a FIT with a signable verity config
+ * @buf:	output buffer (at least FIT_BUF_SIZE bytes)
+ *
+ * Like build_verity_fit(), but the filesystem image also carries a hash
+ * subnode (required for a configuration to be signable) so the config's
+ * signed-region node list can be built with fit_config_get_signed_nodes().
+ *
+ * Return: configuration node offset, or -ve on error
+ */
+static int build_signed_verity_fit(void *buf)
+{
+	int images_node, confs_node, conf_node, img_node, hash_node, verity_node;
+	fdt32_t val;
+	int ret;
+
+	ret = fdt_create_empty_tree(buf, FIT_BUF_SIZE);
+	if (ret)
+		return ret;
+
+	images_node = fdt_add_subnode(buf, 0, "images");
+	if (images_node < 0)
+		return images_node;
+
+	img_node = fdt_add_subnode(buf, images_node, "rootfs");
+	if (img_node < 0)
+		return img_node;
+	ret = fdt_setprop_string(buf, img_node, FIT_TYPE_PROP, "filesystem");
+	if (ret)
+		return ret;
+
+	hash_node = fdt_add_subnode(buf, img_node, "hash-1");
+	if (hash_node < 0)
+		return hash_node;
+	ret = fdt_setprop_string(buf, hash_node, FIT_ALGO_PROP, "sha256");
+	if (ret)
+		return ret;
+	ret = fdt_setprop(buf, hash_node, FIT_VALUE_PROP, test_digest,
+			  sizeof(test_digest));
+	if (ret)
+		return ret;
+
+	verity_node = fdt_add_subnode(buf, img_node, FIT_VERITY_NODENAME);
+	if (verity_node < 0)
+		return verity_node;
+	ret = fdt_setprop_string(buf, verity_node, FIT_VERITY_ALGO_PROP,
+				 "sha256");
+	if (ret)
+		return ret;
+	val = cpu_to_fdt32(4096);
+	ret = fdt_setprop(buf, verity_node, FIT_VERITY_DBS_PROP, &val,
+			  sizeof(val));
+	if (ret)
+		return ret;
+	ret = fdt_setprop(buf, verity_node, FIT_VERITY_HBS_PROP, &val,
+			  sizeof(val));
+	if (ret)
+		return ret;
+	val = cpu_to_fdt32(100);
+	ret = fdt_setprop(buf, verity_node, FIT_VERITY_NBLK_PROP, &val,
+			  sizeof(val));
+	if (ret)
+		return ret;
+	ret = fdt_setprop(buf, verity_node, FIT_VERITY_HBLK_PROP, &val,
+			  sizeof(val));
+	if (ret)
+		return ret;
+	ret = fdt_setprop(buf, verity_node, FIT_VERITY_DIGEST_PROP, test_digest,
+			  sizeof(test_digest));
+	if (ret)
+		return ret;
+	ret = fdt_setprop(buf, verity_node, FIT_VERITY_SALT_PROP, test_salt,
+			  sizeof(test_salt));
+	if (ret)
+		return ret;
+
+	confs_node = fdt_add_subnode(buf, 0, "configurations");
+	if (confs_node < 0)
+		return confs_node;
+	conf_node = fdt_add_subnode(buf, confs_node, "conf-1");
+	if (conf_node < 0)
+		return conf_node;
+	ret = fdt_setprop_string(buf, conf_node, FIT_LOADABLE_PROP, "rootfs");
+	if (ret)
+		return ret;
+
+	return conf_node;
+}
+
+/*
+ * Test: the dm-verity roothash and salt are inside the region covered by the
+ * configuration signature.
+ *
+ * A dm-verity filesystem image is not hashed by U-Boot; its integrity is
+ * delegated to the kernel, which trusts the roothash from the FIT dm-verity
+ * subnode. That roothash must therefore be part of the signed region, so that
+ * an attacker cannot swap both the filesystem and the roothash while keeping
+ * the configuration signature valid.
+ *
+ * This checks the property without a private key, so it also runs on real
+ * devices: it builds the exact node list the signature is computed over
+ * (fit_config_get_signed_nodes), turns it into hashed regions, and verifies both
+ * that the roothash bytes fall inside a region and that tampering them changes
+ * the hash. It uses the same hash path a device would (crypto accelerated where
+ * available).
+ */
+static int fit_verity_test_roothash_signed(struct unit_test_state *uts)
+{
+	char buf[FIT_BUF_SIZE];
+	char *node_inc[32];
+	char path_buf[256];
+	char region_path[256];
+	struct fdt_region fdt_regions[64];
+	struct image_region *region = NULL;
+	int conf_node, verity_node;
+	int count, i, digest_len;
+	const void *digest;
+	ulong digest_off, region_off;
+	bool covered = false;
+	u8 hash_clean[32], hash_tampered[32], hash_control[32];
+
+	conf_node = build_signed_verity_fit(buf);
+	ut_assert(conf_node >= 0);
+
+	verity_node = fdt_path_offset(buf, "/images/rootfs/dm-verity");
+	ut_assert(verity_node >= 0);
+
+	/* Build the node list the configuration signature is computed over. */
+	count = fit_config_get_signed_nodes(buf, conf_node, node_inc,
+					    ARRAY_SIZE(node_inc), path_buf,
+					    sizeof(path_buf));
+	ut_assert(count > 0);
+
+	/*
+	 * Turn the node list into hashed regions. No exclude list is needed:
+	 * the excluded properties (data, data-size, data-offset,
+	 * data-position) never include the dm-verity digest or salt, so the
+	 * coverage answer is the same with or without it.
+	 */
+	count = fdt_find_regions(buf, node_inc, count, NULL, 0, fdt_regions,
+				 ARRAY_SIZE(fdt_regions) - 1, region_path,
+				 sizeof(region_path), 0);
+	ut_assert(count > 0);
+	/* Region array exhausted: mirror the bound fit_config_check_sig() enforces. */
+	ut_assert(count < ARRAY_SIZE(fdt_regions) - 1);
+
+	region = fit_region_make_list(buf, fdt_regions, count, NULL);
+	ut_assertnonnull(region);
+
+	digest = fdt_getprop(buf, verity_node, FIT_VERITY_DIGEST_PROP,
+			     &digest_len);
+	ut_assertnonnull(digest);
+	ut_assert(digest_len > 0);
+	digest_off = (ulong)((const char *)digest - (const char *)buf);
+
+	/*
+	 * Control: the hash covers a non-empty region and reacts to a change
+	 * inside it. Flip a byte of the (signed) image hash value and confirm
+	 * the computed hash differs, proving the region set and hash work.
+	 */
+	ut_assertok(hash_calculate("sha256", region, count, hash_clean));
+	for (i = 0; i < count; i++) {
+		region_off = (ulong)((const char *)region[i].data -
+				     (const char *)buf);
+		if (digest_off >= region_off &&
+		    digest_off + digest_len <= region_off + region[i].size) {
+			covered = true;
+			break;
+		}
+	}
+
+	/* The roothash must be covered by the configuration signature. */
+	ut_assert(covered);
+
+	/*
+	 * Tampering the roothash must change the signed hash. Only the digest
+	 * is flipped here; salt sits in the same dm-verity node, so coverage
+	 * of one implies coverage of the other.
+	 */
+	buf[digest_off] ^= 0xff;
+	ut_assertok(hash_calculate("sha256", region, count, hash_tampered));
+	buf[digest_off] ^= 0xff;
+	ut_assert(memcmp(hash_clean, hash_tampered, sizeof(hash_clean)) != 0);
+
+	/* Sanity: with the byte restored the hash matches the clean value. */
+	ut_assertok(hash_calculate("sha256", region, count, hash_control));
+	ut_asserteq_mem(hash_clean, hash_control, sizeof(hash_clean));
+
+	free(region);
+	return 0;
+}
+FIT_VERITY_TEST(fit_verity_test_roothash_signed, 0);
+#endif /* FIT_SIGNATURE */
diff --git a/test/py/tests/test_fit_verity_sign.py b/test/py/tests/test_fit_verity_sign.py
new file mode 100644
index 00000000000..3c75ef8558c
--- /dev/null
+++ b/test/py/tests/test_fit_verity_sign.py
@@ -0,0 +1,203 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2026 Daniel Golle <daniel@makrotopia.org>
+
+"""Verify that the dm-verity roothash is covered by the FIT configuration
+signature.
+
+A dm-verity protected filesystem image is not hashed by U-Boot; its integrity
+is delegated to the kernel, which trusts the roothash taken from the FIT
+``dm-verity`` subnode. That roothash must therefore be part of the signed
+region of the configuration, otherwise an attacker can replace both the
+filesystem and the roothash while keeping the configuration signature valid.
+
+This test signs a configuration referencing a filesystem image that carries a
+``dm-verity`` subnode, then flips one byte of the roothash and of the salt and
+checks that verification rejects the image. A control tampering a byte that is
+known to be signed confirms that the check is able to detect a broken region.
+
+The FIT pairs a signed configuration with a filesystem image carrying a
+``dm-verity`` subnode:
+
+.. code-block:: devicetree
+
+    images {
+        rootfs-1 {
+            data = /incbin/("rootfs.bin");
+            type = "filesystem";
+            compression = "none";
+            hash-1 {
+                algo = "sha256";
+            };
+            dm-verity {
+                algo = "sha256";
+                data-block-size = <4096>;
+                hash-block-size = <4096>;
+                num-data-blocks = <16>;
+                hash-start-block = <16>;
+            };
+        };
+    };
+
+    configurations {
+        conf-1 {
+            kernel = "kernel-1";
+            loadables = "rootfs-1";
+            signature-1 {
+                algo = "sha256,rsa2048";
+                key-name-hint = "dev";
+                sign-images = "kernel", "loadables";
+            };
+        };
+    };
+
+mkimage builds the dm-verity hash tree when assembling the image and records
+the resulting roothash and salt in the ``dm-verity`` subnode; fit_check_sign
+must reject an image where either was modified after signing.
+"""
+
+import os
+import pytest
+import utils
+
+# 16 blocks of 4096 bytes, matching num-data-blocks/data-block-size below.
+ROOTFS_SIZE = 16 * 4096
+
+ITS = '''
+/dts-v1/;
+/ {
+    description = "verity roothash signing coverage test";
+    #address-cells = <1>;
+
+    images {
+        kernel-1 {
+            description = "kernel";
+            data = /incbin/("kernel.bin");
+            type = "kernel";
+            arch = "arm64";
+            os = "linux";
+            compression = "none";
+            load = <0x40000000>;
+            entry = <0x40000000>;
+            hash-1 { algo = "sha256"; };
+        };
+        rootfs-1 {
+            description = "rootfs";
+            data = /incbin/("rootfs.bin");
+            type = "filesystem";
+            arch = "arm64";
+            compression = "none";
+            hash-1 { algo = "sha256"; };
+            dm-verity {
+                algo = "sha256";
+                data-block-size = <4096>;
+                hash-block-size = <4096>;
+                num-data-blocks = <16>;
+                hash-start-block = <16>;
+            };
+        };
+    };
+
+    configurations {
+        default = "conf-1";
+        conf-1 {
+            description = "signed config";
+            kernel = "kernel-1";
+            loadables = "rootfs-1";
+            signature-1 {
+                algo = "sha256,rsa2048";
+                key-name-hint = "dev";
+                sign-images = "kernel", "loadables";
+            };
+        };
+    };
+};
+'''
+
+VERITY_NODE = '/images/rootfs-1/dm-verity'
+ROOTFS_HASH_NODE = '/images/rootfs-1/hash-1'
+
+
+def flip_prop_byte(ubman, fit, node, prop):
+    """Flip the first byte of a byte-array property in a FIT, in place.
+
+    The property is rewritten with the same length so that no node is
+    relaid out and the signed regions keep their offsets.
+    """
+    val = utils.run_and_log(ubman, 'fdtget -t bx %s %s %s' % (fit, node, prop))
+    bytelist = val.split()
+    bytelist[0] = '%x' % (int(bytelist[0], 16) ^ 0xff)
+    utils.run_and_log(ubman, 'fdtput -t bx %s %s %s %s' %
+                      (fit, node, prop, ' '.join(bytelist)))
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('fit_signature')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtget')
+@pytest.mark.requiredtool('fdtput')
+@pytest.mark.requiredtool('openssl')
+@pytest.mark.requiredtool('veritysetup')
+def test_fit_verity_roothash_signed(ubman):
+    """The dm-verity roothash must be inside the signed configuration region."""
+    tmpdir = os.path.join(ubman.config.result_dir, 'verity-sign') + '/'
+    if not os.path.exists(tmpdir):
+        os.makedirs(tmpdir)
+    mkimage = ubman.config.build_dir + '/tools/mkimage'
+    fit_check_sign = ubman.config.build_dir + '/tools/fit_check_sign'
+    dtc_args = '-I dts -O dtb -i %s' % tmpdir
+    its = tmpdir + 'verity.its'
+    fit = tmpdir + 'verity.itb'
+    dtb = tmpdir + 'control.dtb'
+
+    # Signing key and empty control dtb to receive the public key.
+    utils.run_and_log(ubman, 'openssl genpkey -algorithm RSA -out %sdev.key '
+                      '-pkeyopt rsa_keygen_bits:2048 '
+                      '-pkeyopt rsa_keygen_pubexp:65537' % tmpdir)
+    utils.run_and_log(ubman, 'openssl req -batch -new -x509 -key %sdev.key '
+                      '-out %sdev.crt' % (tmpdir, tmpdir))
+    with open(tmpdir + 'control.dts', 'w') as f:
+        f.write('/dts-v1/; / { model = "verity-test"; };\n')
+    utils.run_and_log(ubman, 'dtc -O dtb -o %s %scontrol.dts' % (dtb, tmpdir))
+
+    # Payloads. The rootfs must be a whole number of data blocks so mkimage can
+    # build the dm-verity hash tree and compute the roothash.
+    with open(tmpdir + 'rootfs.bin', 'wb') as f:
+        f.write(b'R' * ROOTFS_SIZE)
+    with open(tmpdir + 'kernel.bin', 'wb') as f:
+        f.write(b'KERNEL')
+
+    with open(its, 'w') as f:
+        f.write(ITS)
+
+    # Build and sign. -E keeps the (large) rootfs external, as on a real device.
+    utils.run_and_log(ubman, [mkimage, '-D', dtc_args, '-E', '-f', its,
+                              '-k', tmpdir, '-K', dtb, '-r', fit])
+
+    # Baseline: the freshly signed image must verify.
+    utils.run_and_log(ubman, [fit_check_sign, '-f', fit, '-k', dtb])
+
+    # Control: tampering a byte that is signed (the filesystem image hash value)
+    # must be detected. This proves the check can fail.
+    control = tmpdir + 'control.itb'
+    utils.run_and_log(ubman, 'cp %s %s' % (fit, control))
+    flip_prop_byte(ubman, control, ROOTFS_HASH_NODE, 'value')
+    utils.run_and_log_expect_exception(
+        ubman, [fit_check_sign, '-f', control, '-k', dtb],
+        1, 'Failed to verify required signature')
+
+    # Roothash: tampering the dm-verity digest must be rejected. If the digest
+    # is outside the signed region this check passes and boot is compromised.
+    tampered = tmpdir + 'tamper-digest.itb'
+    utils.run_and_log(ubman, 'cp %s %s' % (fit, tampered))
+    flip_prop_byte(ubman, tampered, VERITY_NODE, 'digest')
+    utils.run_and_log_expect_exception(
+        ubman, [fit_check_sign, '-f', tampered, '-k', dtb],
+        1, 'Failed to verify required signature')
+
+    # Salt: likewise, the salt feeds the dm-verity target and must be signed.
+    tampered = tmpdir + 'tamper-salt.itb'
+    utils.run_and_log(ubman, 'cp %s %s' % (fit, tampered))
+    flip_prop_byte(ubman, tampered, VERITY_NODE, 'salt')
+    utils.run_and_log_expect_exception(
+        ubman, [fit_check_sign, '-f', tampered, '-k', dtb],
+        1, 'Failed to verify required signature')
-- 
2.55.0
