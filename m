Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DB6C02185
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:30:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B082807D7;
	Thu, 16 Jan 2025 02:28:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W6fgwD+d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A3A0807E4; Thu, 16 Jan 2025 02:28:40 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B24580214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3ce85545983so1882045ab.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736990916; x=1737595716; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMmOjEjw8NQ8/DjWs6Xosy4TTFkDXSQpWY8LzT0JuUQ=;
 b=W6fgwD+dRq5r8YG+udXiJkzQZ1zKgyFf0fy/PddEosv6fWhWNUPQE0SiDvydtNoqd7
 w8iGar+b/16Kgbj96MX1czDb9Q/3oepCtv6bmQQG/QkP7nRs5dAHk70otL+zZ2tZcuy2
 dQ+xN7okiHhWFDip5s+6tr3/ZoG2Rg2sRv8v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990916; x=1737595716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WMmOjEjw8NQ8/DjWs6Xosy4TTFkDXSQpWY8LzT0JuUQ=;
 b=I49uo/gd8L1k6SY/GTl8Vo5jc58TkPgjVcaj91JYdaN8ns3rJlFfEO1tL0hfsP8EeZ
 lvbOX+Sz8XJaBolwFZjaNbv7Wvt1cv/3Y27GfKNH0RRkSjPOw4fD6IFuazSY5KhZVVcS
 q+iD8ta2xuhlyHr0JLBcbWX1FeYfuVpZGWiM58/smcGcsfiqw9Kafb7JSET7Cr1J64KM
 VmKlJoAMo7MLiS/rwNL51fECEdD1a/9cO44MwIUilbILlDwBZFm5f8OPdXH1VLIH5SeH
 1mwczTjj5j+t+QoQlnIXQOaBMQG1BIBk+2mbjA/gD0CuDc3MX+dImX1OLARCPRqVaGfa
 Qedg==
X-Gm-Message-State: AOJu0YyvFY8wjohE32fK6va2z1AsGr4MJXTyGtXX6pM7T7yIhV2eqF9l
 f4LbJJAskUAZNA2tW46OPJiw9LEjLjFNHwKCMLcQCvReXCy2CCz0rtekgCx5lT+MxY7pTvBBgXY
 =
X-Gm-Gg: ASbGncuQjnJnbo1xCfZlI3Zo0RusG3MEWkYsrbLQXoW/hSrQYSq4Fs0chDxIio14Xm4
 8QxCFEfPW3rA1wp1i0I4g+HM2YIfijUtKhxg5JO9FeCrNwLcVTqYVWI4uvRd5KbjvQmarxrJwb1
 F2rhvrIWlWTga9eC8LMjU0gKism5X4IPiKjEyzfVJ0HznaahppYjuCBjW051VFqT73+Z1gUlxWX
 vIVT9wSe/x6eC8g1Efd+YY7gQKNAb/bVmjg+zfSx7Kdj5WDyUQuZiFKMDBZvQ4tVGvVTPJCHGeq
 icC2RFq2iM53fmZ5Ag==
X-Google-Smtp-Source: AGHT+IEL2yVClOZWP5n9NqNfSHCAKIMSi/iBtqgkC3ZoJxobaMNp7pDt5q1I4quDObM27apmJkuksg==
X-Received: by 2002:a05:6e02:16cb:b0:3ce:3657:7407 with SMTP id
 e9e14a558f8ab-3ce84a8d3c7mr43456285ab.11.1736990915761; 
 Wed, 15 Jan 2025 17:28:35 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3ce4add8570sm42587725ab.32.2025.01.15.17.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 17:28:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 21/22] vbe: Support loading SPL images
Date: Wed, 15 Jan 2025 18:27:22 -0700
Message-Id: <20250116012723.2820301-22-sjg@chromium.org>
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

VBE needs to load different images from a FIT depending on the xPL phase
in use. The IH_PHASE value is used to select the image to load.

Add the required logic to handle this. For compatibility with the
SPL-loader driver, fill out a struct spl_image_info with the details
needed to boot the next phase.

This is good enough for VBE-simple but ABrec will need the full set of
bootstd features. So add a USE_BOOTMETH define to control this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/vbe_common.c    | 85 ++++++++++++++++++++++++++++++++++++++++++--
 boot/vbe_common.h    | 14 +++++++-
 boot/vbe_simple_fw.c |  3 +-
 3 files changed, 97 insertions(+), 5 deletions(-)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index 1926e851398..2bc6c4d73ab 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -16,6 +16,11 @@
 #include <u-boot/crc.h>
 #include "vbe_common.h"
 
+binman_sym_declare(ulong, u_boot_vpl_nodtb, size);
+binman_sym_declare(ulong, u_boot_vpl_bss_pad, size);
+binman_sym_declare(ulong, u_boot_spl_nodtb, size);
+binman_sym_declare(ulong, u_boot_spl_bss_pad, size);
+
 int vbe_get_blk(const char *storage, struct udevice **blkp)
 {
 	struct blk_desc *desc;
@@ -105,17 +110,43 @@ int vbe_read_nvdata(struct udevice *blk, ulong offset, ulong size, u8 *buf)
 	return 0;
 }
 
+/**
+ * h_vbe_load_read() - Handler for reading an SPL image from a FIT
+ *
+ * See spl_load_reader for the definition
+ */
+ulong h_vbe_load_read(struct spl_load_info *load, ulong off, ulong size,
+		      void *buf)
+{
+	struct blk_desc *desc = load->priv;
+	lbaint_t sector = off >> desc->log2blksz;
+	lbaint_t count = size >> desc->log2blksz;
+	int ret;
+
+	log_debug("vbe read log2blksz %x offset %lx sector %lx count %lx\n",
+		  desc->log2blksz, (ulong)off, (long)sector, (ulong)count);
+
+	ret = blk_dread(desc, sector, count, buf);
+	log_debug("ret=%x\n", ret);
+	if (ret < 0)
+		return ret;
+
+	return ret << desc->log2blksz;
+}
+
 int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
-		 ulong *load_addrp, ulong *lenp, char **namep)
+		 struct spl_image_info *image, ulong *load_addrp, ulong *lenp,
+		 char **namep)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(u8, sbuf, MMC_MAX_BLOCK_LEN);
-	ulong size, blknum, addr, len, load_addr, num_blks;
+	ulong size, blknum, addr, len, load_addr, num_blks, spl_load_addr;
 	ulong aligned_size, fdt_load_addr, fdt_size;
 	const char *fit_uname, *fit_uname_config;
 	struct bootm_headers images = {};
 	enum image_phase_t phase;
 	struct blk_desc *desc;
 	int node, ret;
+	bool for_xpl;
 	void *buf;
 
 	desc = dev_get_uclass_plat(blk);
@@ -168,7 +199,8 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 		  gd->malloc_base + gd->malloc_limit);
 #endif
 	/* figure out the phase to load */
-	phase = IS_ENABLED(CONFIG_VPL_BUILD) ? IH_PHASE_SPL : IH_PHASE_U_BOOT;
+	phase = IS_ENABLED(CONFIG_TPL_BUILD) ? IH_PHASE_NONE :
+		IS_ENABLED(CONFIG_VPL_BUILD) ? IH_PHASE_SPL : IH_PHASE_U_BOOT;
 
 	/*
 	 * Load the image from the FIT. We ignore any load-address information
@@ -179,6 +211,20 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 	fit_uname = NULL;
 	fit_uname_config = NULL;
 	log_debug("loading FIT\n");
+
+	if (xpl_phase() == PHASE_SPL && !IS_ENABLED(CONFIG_SANDBOX)) {
+		struct spl_load_info info;
+
+		spl_load_init(&info, h_vbe_load_read, desc, desc->blksz);
+		xpl_set_phase(&info, IH_PHASE_U_BOOT);
+		log_debug("doing SPL from %s blksz %lx log2blksz %x area_offset %lx + fdt_size %lx\n",
+			  blk->name, desc->blksz, desc->log2blksz, area_offset, ALIGN(size, 4));
+		ret = spl_load_simple_fit(image, &info, area_offset, buf);
+		log_debug("spl_load_abrec_fit() ret=%d\n", ret);
+
+		return ret;
+	}
+
 	ret = fit_image_load(&images, addr, &fit_uname, &fit_uname_config,
 			     IH_ARCH_DEFAULT, image_ph(phase, IH_TYPE_FIRMWARE),
 			     BOOTSTAGE_ID_FIT_SPL_START, FIT_LOAD_IGNORED,
@@ -197,6 +243,31 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 
 	fdt_load_addr = 0;
 	fdt_size = 0;
+	if ((xpl_phase() == PHASE_TPL || xpl_phase() == PHASE_VPL) &&
+	    !IS_ENABLED(CONFIG_SANDBOX)) {
+		/* allow use of a different image from the configuration node */
+		fit_uname = NULL;
+		ret = fit_image_load(&images, addr, &fit_uname,
+				     &fit_uname_config, IH_ARCH_DEFAULT,
+				     image_ph(phase, IH_TYPE_FLATDT),
+				     BOOTSTAGE_ID_FIT_SPL_START,
+				     FIT_LOAD_IGNORED, &fdt_load_addr,
+				     &fdt_size);
+		fdt_size = ALIGN(fdt_size, desc->blksz);
+		log_debug("FDT noload to %lx size %lx\n", fdt_load_addr,
+			  fdt_size);
+	}
+
+	for_xpl = !USE_BOOTMETH && CONFIG_IS_ENABLED(RELOC_LOADER);
+	if (for_xpl) {
+		image->size = len;
+		image->fdt_size = fdt_size;
+		ret = spl_reloc_prepare(image, &spl_load_addr);
+		if (ret)
+			return log_msg_ret("spl", ret);
+	}
+	if (!IS_ENABLED(CONFIG_SANDBOX))
+		image->os = IH_OS_U_BOOT;
 
 	/* For FIT external data, read in the external data */
 	log_debug("load_addr %lx len %lx addr %lx aligned_size %lx\n",
@@ -224,6 +295,8 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 		 * to load to, then load the blocks
 		 */
 		num_blks = DIV_ROUND_UP(full_size, desc->blksz);
+		if (for_xpl)
+			base = spl_load_addr;
 		base_buf = map_sysmem(base, full_size);
 		ret = blk_read(blk, blknum, num_blks, base_buf);
 		log_debug("read foffset %lx blknum %lx full_size %lx num_blks %lx to %lx / %p: ret=%d\n",
@@ -239,6 +312,12 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 			memmove(base_buf, base_buf + extra, len);
 		}
 
+		if ((xpl_phase() == PHASE_VPL || xpl_phase() == PHASE_TPL) &&
+		    !IS_ENABLED(CONFIG_SANDBOX)) {
+			image->load_addr = spl_get_image_text_base();
+			image->entry_point = image->load_addr;
+		}
+
 		/* now the FDT */
 		if (fdt_size) {
 			fdt_offset = area_offset + fdt_load_addr - addr;
diff --git a/boot/vbe_common.h b/boot/vbe_common.h
index bfa339008e1..84117815a19 100644
--- a/boot/vbe_common.h
+++ b/boot/vbe_common.h
@@ -11,8 +11,18 @@
 
 #include <linux/types.h>
 
+struct spl_image_info;
 struct udevice;
 
+/*
+ * Controls whether we use a full bootmeth driver with VBE in this phase, or
+ * just access the information directly.
+ *
+ * For now VBE-simple uses the full bootmeth, but VBE-abrec does not, to reduce
+ * code size
+ */
+#define USE_BOOTMETH	CONFIG_IS_ENABLED(BOOTMETH_VBE_SIMPLE)
+
 enum {
 	MAX_VERSION_LEN		= 256,
 
@@ -109,6 +119,7 @@ int vbe_read_nvdata(struct udevice *blk, ulong offset, ulong size, u8 *buf);
  * @blk: Block device containing FIT
  * @area_offset: Byte offset of the VBE area in @blk containing the FIT
  * @area_size: Size of the VBE area
+ * @image: SPL image to fill in with details of the loaded image, or NULL
  * @load_addrp: If non-null, returns the address where the image was loaded
  * @lenp: If non-null, returns the size of the image loaded, in bytes
  * @namep: If non-null, returns the name of the FIT-image node that was loaded
@@ -120,6 +131,7 @@ int vbe_read_nvdata(struct udevice *blk, ulong offset, ulong size, u8 *buf);
  * FIT-parsing (see fit_image_load()).
  */
 int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
-		 ulong *load_addrp, ulong *lenp, char **namep);
+		 struct spl_image_info *image, ulong *load_addrp, ulong *lenp,
+		 char **namep);
 
 #endif /* __VBE_ABREC_H */
diff --git a/boot/vbe_simple_fw.c b/boot/vbe_simple_fw.c
index 0bf25ccad23..9da3e49a66e 100644
--- a/boot/vbe_simple_fw.c
+++ b/boot/vbe_simple_fw.c
@@ -52,7 +52,8 @@ int vbe_simple_read_bootflow_fw(struct udevice *dev, struct bootflow *bflow)
 	log_debug("blk=%s\n", blk->name);
 
 	ret = vbe_read_fit(blk, priv->area_start + priv->skip_offset,
-			   priv->area_size, &load_addr, &len, &bflow->name);
+			   priv->area_size, NULL, &load_addr, &len,
+			   &bflow->name);
 
 	/* set up the bootflow with the info we obtained */
 	bflow->blk = blk;
-- 
2.34.1

