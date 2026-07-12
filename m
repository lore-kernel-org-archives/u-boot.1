Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4ECAC43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 00:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7BA1849D2;
	Sun, 12 Jul 2026 02:33:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 070E284A3A; Sun, 12 Jul 2026 02:33:38 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08561844F6
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 02:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wii8J-000000006Z6-3NdF; Sun, 12 Jul 2026 00:33:23 +0000
Date: Sun, 12 Jul 2026 01:33:21 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Ludwig Nussel <ludwig.nussel@siemens.com>, Anton Ivanov <anton@binarly.io>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Randolph Sapp <rs@ti.com>, Francois Berder <fberder@outlook.fr>,
 u-boot@lists.denx.de
Subject: [PATCH 2/3] boot: fit: cover the dm-verity roothash with the config
 signature
Message-ID: <81cb6eed897871b3548e81ee63502b65f797c44a.1783816074.git.daniel@makrotopia.org>
References: <cover.1783816074.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783816074.git.daniel@makrotopia.org>
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

A dm-verity protected filesystem image is not hashed by U-Boot when it
is loaded; its integrity is delegated to the kernel, which validates the
filesystem on the fly against the roothash taken from the FIT dm-verity
subnode. The roothash is therefore the sole integrity anchor for the
filesystem, yet fit_config_add_hash() only added the image node, its
hash subnodes and its cipher subnode to the signed region, leaving the
dm-verity subnode (roothash, salt and block parameters) unsigned.

An attacker able to rewrite the boot medium could then replace both the
filesystem and the roothash, recompute a matching dm-verity tree and
keep the configuration signature valid, defeating verified boot for the
root filesystem.

Add the dm-verity subnode to the list of nodes covered by the
configuration signature, both when signing (tools/image-host.c) and when
verifying (boot/image-fit-sig.c), so the roothash and salt are
authenticated together with the rest of the configuration.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/image-fit-sig.c | 23 +++++++++++++++++++----
 tools/image-host.c   | 22 ++++++++++++++++++++++
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index 513ee9cc16a..c2f09885492 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -264,8 +264,8 @@ static int fit_config_add_node(const void *fit, int noffset, char **node_inc,
 /**
  * fit_config_add_hash() - Add hash nodes for one image to the node list
  *
- * Adds the image path, all its hash-* subnode paths, and its cipher
- * subnode path (if present) to the packed buffer.
+ * Adds the image path, all its hash-* subnode paths, and its cipher and
+ * dm-verity subnode paths (each if present) to the packed buffer.
  *
  * @fit:		FIT blob
  * @image_noffset:	Image node offset (e.g. /images/kernel-1)
@@ -322,6 +322,21 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
 			return ret;
 	}
 
+	/*
+	 * Add this image's dm-verity node if present. Its roothash is the
+	 * only integrity anchor for a dm-verity filesystem image, so it must
+	 * be covered by the configuration signature.
+	 */
+	noffset = fdt_subnode_offset(fit, image_noffset, FIT_VERITY_NODENAME);
+	if (noffset != -FDT_ERR_NOTFOUND) {
+		if (noffset < 0)
+			return -EIO;
+		ret = fit_config_add_node(fit, noffset, node_inc, count,
+					  max_nodes, buf, buf_used, buf_len);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -329,8 +344,8 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
  * fit_config_get_hash_list() - Build the list of nodes to hash
  *
  * Works through every image referenced by the configuration and collects the
- * node paths: root + config + all referenced images with their hash and
- * cipher subnodes.
+ * node paths: root + config + all referenced images with their hash,
+ * cipher and dm-verity subnodes.
  *
  * Properties known not to be image references (description, compatible,
  * default, load-only) are skipped, so any new image type is covered by default.
diff --git a/tools/image-host.c b/tools/image-host.c
index 8f1e7be4066..235f7643d08 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -1256,6 +1256,28 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
 			goto err_mem;
 	}
 
+	/*
+	 * Add this image's dm-verity node if present. Its roothash is the
+	 * only integrity anchor for a dm-verity filesystem image, so it must
+	 * be covered by the configuration signature.
+	 */
+	noffset = fdt_subnode_offset(fit, image_noffset,
+				     FIT_VERITY_NODENAME);
+	if (noffset != -FDT_ERR_NOTFOUND) {
+		if (noffset < 0) {
+			fprintf(stderr,
+				"Failed to get dm-verity node in configuration '%s/%s' image '%s': %s\n",
+				conf_name, sig_name, iname,
+				fdt_strerror(noffset));
+			return -EIO;
+		}
+		ret = fdt_get_path(fit, noffset, path, sizeof(path));
+		if (ret < 0)
+			goto err_path;
+		if (strlist_add(node_inc, path))
+			goto err_mem;
+	}
+
 	return 0;
 
 err_mem:
-- 
2.55.0
