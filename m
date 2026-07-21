Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB8EC4452F
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 02:59:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15941407D8;
	Tue, 21 Jul 2026 02:59:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FQQX18f2kGzc; Tue, 21 Jul 2026 02:59:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0BF80407DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784602771;
	bh=IhiJxnktJLERcXowMjugpNLXCDDqPS7vLaznk5c1IzI=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=j/qr0LRD1nFPJrxE/MiLq+UJHF93g0SfTPUmWDUgc9t8Pr6TxDTGw4WQ4MiZa+974
	 sMkMK1aeROODgEif0JNeaUIGNEOJlsGi9aQVZ2agxUAAItnD56Ze4Fmi/6JOQ7g4ys
	 cLQjAYPefEUYBLh+HVpIV9cziyb/9keRAb1hRQmL+QZV7K5/qq4c25QBFXD59eKpC4
	 nRlf+shlwjjpOdDo93DwWFscsHXuKbSHFxWiWrtxjQMS5GGF75n87mv4v82MJIUbED
	 /8gXreSqQbQFLbRN1RYekKtyHngo0gCLLbk8B+C66mfvHDd3fHHDpVMrnHB8x3x08P
	 ZksXhi1wz9CEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BF80407DB;
	Tue, 21 Jul 2026 02:59:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 91F091331
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 02:59:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 80E3B607BC
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 02:59:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Zbq5RdCX9Ls for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 02:59:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6E034607A5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6E034607A5
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6E034607A5
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 02:59:27 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wm0KC-000000000L3-1dAu; Tue, 21 Jul 2026 02:35:16 +0000
Date: Tue, 21 Jul 2026 03:35:13 +0100
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Randolph Sapp <rs@ti.com>, Francois Berder <fberder@outlook.fr>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 2/3] boot: fit: cover the dm-verity roothash with the
 config signature
Message-ID: <cf2d647d26ea0850ead5e09fb5d683f92aee4cec.1784601041.git.daniel@makrotopia.org>
References: <cover.1784601041.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784601041.git.daniel@makrotopia.org>
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
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
From: Daniel Golle via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Daniel Golle <daniel@makrotopia.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

A dm-verity protected filesystem image is not hashed by U-Boot when it
is loaded; its integrity is delegated to the kernel, which validates the
filesystem on the fly against the roothash taken from the FIT dm-verity
subnode. The roothash is therefore the sole integrity anchor for the
filesystem, yet fit_config_add_hash() only adds the image node, its
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
Reviewed-by: Tom Rini <trini@konsulko.com>
---
v3: use present tense for the pre-patch code description, per Simon
    Glass's review; document the dm-verity subnode in the rebuilt node
    list in doc/usage/fit/signature.rst and note the signature coverage
    in doc/usage/fit/dm-verity.rst. The tools/image-host.c hunk now
    calls the patch 1 helper instead of duplicating the pattern inline
    (no functional change). Kept Tom's Reviewed-by: the functional
    change he reviewed is unchanged; the rest is doc/message wording
    and a mechanical refactor.
v2: no changes

 boot/image-fit-sig.c        | 23 +++++++++++++++++++----
 doc/usage/fit/dm-verity.rst |  5 +++++
 doc/usage/fit/signature.rst |  2 +-
 tools/image-host.c          | 21 +++++++++++++++++++++
 4 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index 3357ec92116..f7ab036dcb5 100644
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
diff --git a/doc/usage/fit/dm-verity.rst b/doc/usage/fit/dm-verity.rst
index 800a18fceae..76030c751ae 100644
--- a/doc/usage/fit/dm-verity.rst
+++ b/doc/usage/fit/dm-verity.rst
@@ -209,6 +209,11 @@ typically be obtained from its output.
 The ``digest`` and ``salt`` byte arrays correspond to the hex-encoded
 ``Root hash`` and ``Salt`` printed by ``veritysetup format``.
 
+When the configuration is signed, ``digest`` and ``salt`` are covered by
+the configuration signature (see :doc:`signature`), so the roothash
+cannot be swapped out for a matching one without invalidating the
+signature.
+
 Optional boolean properties (when present, they are collected and appended
 as dm-verity optional parameters with hyphens converted to underscores):
 
diff --git a/doc/usage/fit/signature.rst b/doc/usage/fit/signature.rst
index da08cc75c3a..64bada2f58f 100644
--- a/doc/usage/fit/signature.rst
+++ b/doc/usage/fit/signature.rst
@@ -359,7 +359,7 @@ however, U-Boot does not read 'hashed-nodes'. Instead it rebuilds the node
 list from the configuration's own image references (kernel, fdt, ramdisk,
 etc.), since 'hashed-nodes' is not itself covered by the signature. The
 rebuilt list always includes the root node, the configuration node, each
-referenced image node and its hash/cipher subnodes.
+referenced image node and its hash, cipher and dm-verity subnodes.
 
 The image is walked in order and each tag processed as follows:
 
diff --git a/tools/image-host.c b/tools/image-host.c
index fd2ef99d399..16a5ad6c22d 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -1287,6 +1287,27 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
 			return ret;
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
+		ret = fit_config_add_node(fit, noffset, node_inc, conf_name,
+					  sig_name, iname);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.55.0
