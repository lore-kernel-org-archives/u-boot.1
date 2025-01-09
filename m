Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B42E77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 12:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5813380714;
	Thu,  9 Jan 2025 13:31:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QleteA7y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C64C280704; Thu,  9 Jan 2025 13:31:23 +0100 (CET)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D38D80619
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 13:31:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-4afed12283eso656111137.1
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 04:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736425878; x=1737030678; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wF5K/Beq8EQBuJPqMd8lDc5q0liPhy5jrIzOX64EXJY=;
 b=QleteA7yfAkV8eaUUtRRMsbcLMqyaF2Sar6T+EF8HcqsJdmIEeNHqIgVI+QRAnTFgs
 rH60DwY/zn9WvG3ViuZ6iO9bfV7+q3Cwoxo50USGS5KU/VINkXJgLRHs+/r5hPApixX1
 sSRwKfz58PXWcZObQI2Lliz+wY7aNqDoACeOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736425878; x=1737030678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wF5K/Beq8EQBuJPqMd8lDc5q0liPhy5jrIzOX64EXJY=;
 b=vRUo7BVafHIMw+qYSd7Uv5u6APJ1FqCIcqMX6DdBiMs53PhOFkXxDOTRCGU1Ajlzki
 QLkqIgPrUeKgpNN8ZA1TPEMfdU9mtAh+JG4+kg8Rs8UvYzG+OyKTdeBIw0rMBq9hTE4k
 8ZnK0gf7r4wPW9IQfwaFKu+o0Y9psViorhfQ3uXTa0yNJEjSJmchs008IWcEWzNA9Rja
 i95PCsF6f0huTcRLo8ZtctQdsACzwyDpAsjaYRn2fk3BPeKbDR1kURC+pfY9BdAZvyrP
 z9A2TSsPUlxXySlATwPusCFa8Ds4xtqWeTUOoIgFhz46+rOQefpjYZolAaTzdzoElDK1
 S+ZA==
X-Gm-Message-State: AOJu0YzhqV7cQVT+hvClyHAQzn+JbE5/OJQSAQwQNOGmL2FR02CaRsAd
 aasq5u3Yc0Pfs73xpbZ0COoKfgmlDAvM6ovcr0+agzZy4Pd/BC3Y/PQdMHOdxz8A/MZkS9xUuu4
 =
X-Gm-Gg: ASbGncvjs0l9HqQAIF2VoJCDNRi+P24CN/zreouWs+O1Hv26rrYsDoqMaogrdE+5RIJ
 qjjM2XBdcxq3ZczMOgi6gkpHJ3m6qkvORWPx55GOh0tgQrSgLqPAIpeeem2MjXxQbVysXQaioXm
 P+jYyzyWIrXBx/kFeM5CPl6PJtrXlF0IzU6QAbVgJyVnbL8iujAcwBU4jJFAOnCEi0uHsjc/yiV
 8cHry5nIsLbNJCKbGyC7Ck2bNHSkwX5QK8SmR0Yo7b1kMhsZYS9McUuBxZQIKFqM1d9meZgCYD6
 7Mvi6lFzXjLY08eJsA==
X-Google-Smtp-Source: AGHT+IEX6orRTsEMRjLj2ZnGckzHfYL9EQ+Ir55CidVP/VxnUJtVr/GjBcDtslXJafP1dqzcgBQQvA==
X-Received: by 2002:a05:6e02:3201:b0:3a7:4e3e:d03a with SMTP id
 e9e14a558f8ab-3ce3a8e1e77mr46470495ab.22.1736425866846; 
 Thu, 09 Jan 2025 04:31:06 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm281678173.20.2025.01.09.04.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 04:31:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 14/15] vbe: Support loading SPL images
Date: Thu,  9 Jan 2025 05:30:09 -0700
Message-Id: <20250109123010.4005298-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109123010.4005298-1-sjg@chromium.org>
References: <20250109123010.4005298-1-sjg@chromium.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/vbe_common.c    | 85 ++++++++++++++++++++++++++++++++++++++++++--
 boot/vbe_common.h    |  4 ++-
 boot/vbe_simple_fw.c |  3 +-
 3 files changed, 87 insertions(+), 5 deletions(-)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index 46b39cf8910..799f33d9ffa 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -18,17 +18,48 @@
 #include <u-boot/crc.h>
 #include "vbe_common.h"
 
+binman_sym_declare(ulong, u_boot_vpl_nodtb, size);
+binman_sym_declare(ulong, u_boot_vpl_bss_pad, size);
+binman_sym_declare(ulong, u_boot_spl_nodtb, size);
+binman_sym_declare(ulong, u_boot_spl_bss_pad, size);
+
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
@@ -81,7 +112,8 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 		  gd->malloc_base + gd->malloc_limit);
 #endif
 	/* figure out the phase to load */
-	phase = IS_ENABLED(CONFIG_VPL_BUILD) ? IH_PHASE_SPL : IH_PHASE_U_BOOT;
+	phase = IS_ENABLED(CONFIG_TPL_BUILD) ? IH_PHASE_NONE :
+		IS_ENABLED(CONFIG_VPL_BUILD) ? IH_PHASE_SPL : IH_PHASE_U_BOOT;
 
 	/*
 	 * Load the image from the FIT. We ignore any load-address information
@@ -92,6 +124,20 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
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
@@ -110,6 +156,31 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 
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
@@ -137,6 +208,8 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 		 * to load to, then load the blocks
 		 */
 		num_blks = DIV_ROUND_UP(full_size, desc->blksz);
+		if (for_xpl)
+			base = spl_load_addr;
 		base_buf = map_sysmem(base, full_size);
 		ret = blk_read(blk, blknum, num_blks, base_buf);
 		log_debug("read foffset %lx blknum %lx full_size %lx num_blks %lx to %lx / %p: ret=%d\n",
@@ -152,6 +225,12 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
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
index 403391ff1ea..98b7aff0b5d 100644
--- a/boot/vbe_common.h
+++ b/boot/vbe_common.h
@@ -155,6 +155,7 @@ int vbe_get_blk(const char *storage, struct udevice **blkp);
  * @blk: Block device containing FIT
  * @area_offset: Byte offset of the VBE area in @blk containing the FIT
  * @area_size: Size of the VBE area
+ * @image: SPL image to fill in with details of the loaded image, or NULL
  * @load_addrp: If non-null, returns the address where the image was loaded
  * @lenp: If non-null, returns the size of the image loaded, in bytes
  * @namep: If non-null, returns the name of the FIT-image node that was loaded
@@ -166,6 +167,7 @@ int vbe_get_blk(const char *storage, struct udevice **blkp);
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

