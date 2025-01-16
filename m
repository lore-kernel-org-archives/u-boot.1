Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAF0C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:29:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D12080726;
	Thu, 16 Jan 2025 02:28:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mjq0XOai";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB61E8078B; Thu, 16 Jan 2025 02:28:05 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C8C80214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:28:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3ce8c069840so3093175ab.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736990880; x=1737595680; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vB7voPKXXzq40erXc5sQuwRmNcsuofk2YTzbuofBPkg=;
 b=Mjq0XOai3BU3Fnst44/SpRi5tt5b+xVFjoV9bIK92ttxHo64ERaonFZFApbaud1aYX
 7GO96z7GOH5CZVJqDlRIurtXOBKqtABcHLlseqszdZYQwoWvFUiLkNKV3hYduBkpyL+S
 ChDJcPIXkW+EHah8mHO7Ra4cMfALkk7E3B5So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990880; x=1737595680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vB7voPKXXzq40erXc5sQuwRmNcsuofk2YTzbuofBPkg=;
 b=nFgXafWLHWJ/1qROb1EYZ4MbBzXMenXaUyPn3JzuA3xqFKN07544AxKHNlY9boGotS
 hoz6cbfRZs7gbc7NSTfVCRbJaEsBUbr6hPiwJHYRkUsderULMA6ej3EW7fYaK+UivdJE
 9yMrfmax/goDWRMDNyEEYeBcs9HqvE1aXcodod23ZvlmpoZXQsihFfz5vHeYSP4W5IZJ
 jKk6WAGK5cdGuAvLaoDeQKfHKxBGmqK04zv7X2DdZEI9CnQ1dyOchftT9lpAV31hG8ri
 KF3MFsGsfcOQnAuB+vZvsIxo0+Y+tVScIsLJyX1KUq9YcVU7dNcsu7HkBzOqwQmWhTdr
 A43Q==
X-Gm-Message-State: AOJu0Yx1pkYRcTLhE8Q2nQCR3KoV9TiH2PYTrSzxK1FMlzDBgmD5KMvr
 6x6BInwZjGr1gAnyQCmwKkafotjWnvAoqn46hfAkD8UPU3Wbpubo7I6c6aPAUkDxNYJ1LkGyGhI
 =
X-Gm-Gg: ASbGncuqLcjLsk32l8vA8/+bQ3uZlbJZEpn8RUtfi2XWNQU6dbOh+QTv0LjhYtgMq9k
 02v210O63AMxn6RZ9wIGS7iDf+rOhnhpYi1Yx1OJuaF5dEFFs0lONaOrTv1M7NaDKQDS4Cuq2sP
 cP4vLxhZjUABJwAxId05nraqEHtXnpQhLNLMYepbJR/ygbxDHZJ6pkg/D7CpYP+u9I7gZrR7OBT
 /V6bQOOuhfvZFkpUoTH4Sy0NPVt7HkBEUMQdDqvVP53csjSfYyOMnM8Qei8+o9SeGaniF6PdYQY
 ZrE04Ny/fC/n+CKD2w==
X-Google-Smtp-Source: AGHT+IGYQtd1Q1+TN6dLspdJRifBzEHNNE2E1ii3REyCGOE1M+qc9di7LXROTyk+xNc2FWyv4siwOw==
X-Received: by 2002:a05:6e02:2183:b0:3ce:8aff:61a3 with SMTP id
 e9e14a558f8ab-3ce8aff6479mr40308765ab.6.1736990880294; 
 Wed, 15 Jan 2025 17:28:00 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3ce4add8570sm42587725ab.32.2025.01.15.17.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 17:27:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 09/22] vbe: Split out reading a FIT into the common file
Date: Wed, 15 Jan 2025 18:27:10 -0700
Message-Id: <20250116012723.2820301-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116012723.2820301-1-sjg@chromium.org>
References: <20250116012723.2820301-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Loading a FIT is useful for other VBE methods, such as ABrec. Create a
new function to handling reading it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Reword commit subject
- Move common code to the end of the file

 boot/vbe_common.c    | 107 +++++++++++++++++++++++++++++++++++++++++++
 boot/vbe_common.h    |  28 +++++++++++
 boot/vbe_simple_fw.c |  94 ++-----------------------------------
 3 files changed, 139 insertions(+), 90 deletions(-)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index 672878fe6fe..0105d550bdf 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -6,7 +6,11 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
+#include <bootstage.h>
+#include <dm.h>
 #include <blk.h>
+#include <image.h>
+#include <mapmem.h>
 #include <memalign.h>
 #include <spl.h>
 #include <u-boot/crc.h>
@@ -100,3 +104,106 @@ int vbe_read_nvdata(struct udevice *blk, ulong offset, ulong size, u8 *buf)
 
 	return 0;
 }
+
+int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
+		 ulong *load_addrp, ulong *lenp, char **namep)
+{
+	ALLOC_CACHE_ALIGN_BUFFER(u8, sbuf, MMC_MAX_BLOCK_LEN);
+	ulong size, blknum, addr, len, load_addr, num_blks;
+	const char *fit_uname, *fit_uname_config;
+	struct bootm_headers images = {};
+	enum image_phase_t phase;
+	struct blk_desc *desc;
+	int node, ret;
+	void *buf;
+
+	desc = dev_get_uclass_plat(blk);
+
+	/* read in one block to find the FIT size */
+	blknum =  area_offset / desc->blksz;
+	log_debug("read at %lx, blknum %lx\n", area_offset, blknum);
+	ret = blk_read(blk, blknum, 1, sbuf);
+	if (ret < 0)
+		return log_msg_ret("rd", ret);
+
+	ret = fdt_check_header(sbuf);
+	if (ret < 0)
+		return log_msg_ret("fdt", -EINVAL);
+	size = fdt_totalsize(sbuf);
+	if (size > area_size)
+		return log_msg_ret("fdt", -E2BIG);
+	log_debug("FIT size %lx\n", size);
+
+	/*
+	 * Load the FIT into the SPL memory. This is typically a FIT with
+	 * external data, so this is quite small, perhaps a few KB.
+	 */
+	addr = CONFIG_VAL(TEXT_BASE);
+	buf = map_sysmem(addr, size);
+	num_blks = DIV_ROUND_UP(size, desc->blksz);
+	log_debug("read %lx, %lx blocks to %lx / %p\n", size, num_blks, addr,
+		  buf);
+	ret = blk_read(blk, blknum, num_blks, buf);
+	if (ret < 0)
+		return log_msg_ret("rd", ret);
+
+	/* figure out the phase to load */
+	phase = IS_ENABLED(CONFIG_VPL_BUILD) ? IH_PHASE_SPL : IH_PHASE_U_BOOT;
+
+	/*
+	 * Load the image from the FIT. We ignore any load-address information
+	 * so in practice this simply locates the image in the external-data
+	 * region and returns its address and size. Since we only loaded the FIT
+	 * itself, only a part of the image will be present, at best.
+	 */
+	fit_uname = NULL;
+	fit_uname_config = NULL;
+	log_debug("loading FIT\n");
+	ret = fit_image_load(&images, addr, &fit_uname, &fit_uname_config,
+			     IH_ARCH_SANDBOX, image_ph(phase, IH_TYPE_FIRMWARE),
+			     BOOTSTAGE_ID_FIT_SPL_START, FIT_LOAD_IGNORED,
+			     &load_addr, &len);
+	if (ret < 0)
+		return log_msg_ret("ld", ret);
+	node = ret;
+	log_debug("loaded to %lx\n", load_addr);
+
+	/* For FIT external data, read in the external data */
+	if (load_addr + len > addr + size) {
+		ulong base, full_size;
+		void *base_buf;
+
+		/* Find the start address to load from */
+		base = ALIGN_DOWN(load_addr, desc->blksz);
+
+		/*
+		 * Get the total number of bytes to load, taking care of
+		 * block alignment
+		 */
+		full_size = load_addr + len - base;
+
+		/*
+		 * Get the start block number, number of blocks and the address
+		 * to load to, then load the blocks
+		 */
+		blknum = (area_offset + base - addr) / desc->blksz;
+		num_blks = DIV_ROUND_UP(full_size, desc->blksz);
+		base_buf = map_sysmem(base, full_size);
+		ret = blk_read(blk, blknum, num_blks, base_buf);
+		log_debug("read %lx %lx, %lx blocks to %lx / %p: ret=%d\n",
+			  blknum, full_size, num_blks, base, base_buf, ret);
+		if (ret < 0)
+			return log_msg_ret("rd", ret);
+	}
+	if (load_addrp)
+		*load_addrp = load_addr;
+	if (lenp)
+		*lenp = len;
+	if (namep) {
+		*namep = strdup(fdt_get_name(buf, node, NULL));
+		if (!namep)
+			return log_msg_ret("nam", -ENOMEM);
+	}
+
+	return 0;
+}
diff --git a/boot/vbe_common.h b/boot/vbe_common.h
index 37a81330325..bfa339008e1 100644
--- a/boot/vbe_common.h
+++ b/boot/vbe_common.h
@@ -94,4 +94,32 @@ int vbe_read_version(struct udevice *blk, ulong offset, char *version,
  */
 int vbe_read_nvdata(struct udevice *blk, ulong offset, ulong size, u8 *buf);
 
+/**
+ * vbe_read_fit() - Read an image from a FIT
+ *
+ * This handles most of the VBE logic for reading from a FIT. It reads the FIT
+ * metadata, decides which image to load and loads it to a suitable address,
+ * ready for jumping to the next phase of VBE.
+ *
+ * This supports transition from VPL to SPL as well as SPL to U-Boot proper. For
+ * now, TPL->VPL is not supported.
+ *
+ * Both embedded and external data are supported for the FIT
+ *
+ * @blk: Block device containing FIT
+ * @area_offset: Byte offset of the VBE area in @blk containing the FIT
+ * @area_size: Size of the VBE area
+ * @load_addrp: If non-null, returns the address where the image was loaded
+ * @lenp: If non-null, returns the size of the image loaded, in bytes
+ * @namep: If non-null, returns the name of the FIT-image node that was loaded
+ *	(allocated by this function)
+ * Return: 0 if OK, -EINVAL if the area does not contain an FDT (the underlying
+ * format for FIT), -E2BIG if the FIT extends past @area_size, -ENOMEM if there
+ * was not space to allocate the image-node name, other error if a read error
+ * occurred (see blk_read()), or something went wrong with the actually
+ * FIT-parsing (see fit_image_load()).
+ */
+int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
+		 ulong *load_addrp, ulong *lenp, char **namep);
+
 #endif /* __VBE_ABREC_H */
diff --git a/boot/vbe_simple_fw.c b/boot/vbe_simple_fw.c
index da9701f9eb9..0bf25ccad23 100644
--- a/boot/vbe_simple_fw.c
+++ b/boot/vbe_simple_fw.c
@@ -38,109 +38,23 @@
  */
 int vbe_simple_read_bootflow_fw(struct udevice *dev, struct bootflow *bflow)
 {
-	ALLOC_CACHE_ALIGN_BUFFER(u8, sbuf, MMC_MAX_BLOCK_LEN);
 	struct udevice *media = dev_get_parent(bflow->dev);
 	struct udevice *meth = bflow->method;
 	struct simple_priv *priv = dev_get_priv(meth);
-	const char *fit_uname, *fit_uname_config;
-	struct bootm_headers images = {};
-	ulong offset, size, blknum, addr, len, load_addr, num_blks;
-	enum image_phase_t phase;
-	struct blk_desc *desc;
+	ulong len, load_addr;
 	struct udevice *blk;
-	int node, ret;
-	void *buf;
+	int ret;
 
 	log_debug("media=%s\n", media->name);
 	ret = blk_get_from_parent(media, &blk);
 	if (ret)
 		return log_msg_ret("med", ret);
 	log_debug("blk=%s\n", blk->name);
-	desc = dev_get_uclass_plat(blk);
-
-	offset = priv->area_start + priv->skip_offset;
-
-	/* read in one block to find the FIT size */
-	blknum =  offset / desc->blksz;
-	log_debug("read at %lx, blknum %lx\n", offset, blknum);
-	ret = blk_read(blk, blknum, 1, sbuf);
-	if (ret < 0)
-		return log_msg_ret("rd", ret);
-
-	ret = fdt_check_header(sbuf);
-	if (ret < 0)
-		return log_msg_ret("fdt", -EINVAL);
-	size = fdt_totalsize(sbuf);
-	if (size > priv->area_size)
-		return log_msg_ret("fdt", -E2BIG);
-	log_debug("FIT size %lx\n", size);
-
-	/*
-	 * Load the FIT into the SPL memory. This is typically a FIT with
-	 * external data, so this is quite small, perhaps a few KB.
-	 */
-	addr = CONFIG_VAL(TEXT_BASE);
-	buf = map_sysmem(addr, size);
-	num_blks = DIV_ROUND_UP(size, desc->blksz);
-	log_debug("read %lx, %lx blocks to %lx / %p\n", size, num_blks, addr,
-		  buf);
-	ret = blk_read(blk, blknum, num_blks, buf);
-	if (ret < 0)
-		return log_msg_ret("rd", ret);
 
-	/* figure out the phase to load */
-	phase = IS_ENABLED(CONFIG_VPL_BUILD) ? IH_PHASE_SPL : IH_PHASE_U_BOOT;
-
-	/*
-	 * Load the image from the FIT. We ignore any load-address information
-	 * so in practice this simply locates the image in the external-data
-	 * region and returns its address and size. Since we only loaded the FIT
-	 * itself, only a part of the image will be present, at best.
-	 */
-	fit_uname = NULL;
-	fit_uname_config = NULL;
-	log_debug("loading FIT\n");
-	ret = fit_image_load(&images, addr, &fit_uname, &fit_uname_config,
-			     IH_ARCH_SANDBOX, image_ph(phase, IH_TYPE_FIRMWARE),
-			     BOOTSTAGE_ID_FIT_SPL_START, FIT_LOAD_IGNORED,
-			     &load_addr, &len);
-	if (ret < 0)
-		return log_msg_ret("ld", ret);
-	node = ret;
-	log_debug("loaded to %lx\n", load_addr);
-
-	/* For FIT external data, read in the external data */
-	if (load_addr + len > addr + size) {
-		ulong base, full_size;
-		void *base_buf;
-
-		/* Find the start address to load from */
-		base = ALIGN_DOWN(load_addr, desc->blksz);
-
-		/*
-		 * Get the total number of bytes to load, taking care of
-		 * block alignment
-		 */
-		full_size = load_addr + len - base;
-
-		/*
-		 * Get the start block number, number of blocks and the address
-		 * to load to, then load the blocks
-		 */
-		blknum = (offset + base - addr) / desc->blksz;
-		num_blks = DIV_ROUND_UP(full_size, desc->blksz);
-		base_buf = map_sysmem(base, full_size);
-		ret = blk_read(blk, blknum, num_blks, base_buf);
-		log_debug("read %lx %lx, %lx blocks to %lx / %p: ret=%d\n",
-			  blknum, full_size, num_blks, base, base_buf, ret);
-		if (ret < 0)
-			return log_msg_ret("rd", ret);
-	}
+	ret = vbe_read_fit(blk, priv->area_start + priv->skip_offset,
+			   priv->area_size, &load_addr, &len, &bflow->name);
 
 	/* set up the bootflow with the info we obtained */
-	bflow->name = strdup(fdt_get_name(buf, node, NULL));
-	if (!bflow->name)
-		return log_msg_ret("name", -ENOMEM);
 	bflow->blk = blk;
 	bflow->buf = map_sysmem(load_addr, len);
 	bflow->size = len;
-- 
2.34.1

