Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF10C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 01:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F54F84C6E;
	Thu,  2 Jul 2026 03:47:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AgwNLpPR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A75D84C78; Thu,  2 Jul 2026 03:47:54 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 892C384C15
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 03:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-69d8f70cb0cso937287eaf.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 18:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782956870; x=1783561670; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DVGxpDP7MJjGogGjGODkVUuhhIlRNCkLaiiOBE/lDuE=;
 b=AgwNLpPRuH1zXOLocH9jWg90ENBeLRHjRcj4QbJGU2Ux8jB1Enp0/JVI3eHdlkT+xS
 v4lF+OStk4e+xv671VlA089+jOabDH8+7CvpSWQZMT9b2DM64bNZ0Dz1zPCcYgiktQrD
 2EhINHfPDeUQ4GYxDTiYf9xh5G92CONNz1Od02sXxrfyNpAsVb2NqO3LMTREGZ7OGac0
 JT8fZRarTDHbl07yNpVqSIJDrBSFowRUDEVNc7dcL0tHz/+1AdQGSzzDn91JHgk7KoE+
 mjDf/l3/3sbJJIMvICuCv50KTW6CqMcarO42cgiA0J3DhpHIjcVE2GeSOJ/g9d5ccLRx
 NOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782956870; x=1783561670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DVGxpDP7MJjGogGjGODkVUuhhIlRNCkLaiiOBE/lDuE=;
 b=oJjFBt/EmrKvXClnzRMpeSu5vj/856o4Ha506iR+pI99zLWS5h/uwZZLLQsPeL+6w2
 +Xub58DyH6My+kAQYZtr3I/CS3paX1RakyscM4HGFnQsbeYpxD7fqLNenAXDJhVL6zqu
 qLCbINJVpjBBvMBuWq/glXketZGzwkUcxSB3q1TFX07oD/GbPMTdHXmuy0HYF2hx1/Zx
 jZub+RuzpPprRYWNNj4YUnyT7FhHuV7dLspjtEAwXvhjEADKdDVvsMzeGADJxmL9ujYE
 hJ0jPxsdXco9ghuSckuKbL1BiaIjunNX8dLB/AiGkvPmMaJljldgvu8OSW0gigacD7ZZ
 YxYw==
X-Gm-Message-State: AOJu0YwwFLz/RtX8+qTEUOm/tIuvA07KaulVGioC4VClJUA4BoPaYykL
 +PLpqk4+upnKRpwW8zT0U1U1FZK8dra1CQAQtLvLltu7bCxqpGiJKqvVzRirEOH1No2zuQ==
X-Gm-Gg: AfdE7clCO7Xxxpq0pVHX3elMd2DaiT2ROtgEJOrSCqV0jRS4MZBChONnVCp4QBu525q
 KNblH1wLaOEZYoRTkMI15Fa4FbuFFZF62/9PAnNUTwRirND/S/WZS2zmS9uXDKhJrtkd33PeDNb
 3YNaU/9cfr157J70KOa0xSnvHPmXKNa6FopYi7J9ggjDbh6klr3EBXUKfPhjlgpHEraHqbUlYSh
 YgZGjbVHlax+qHcjbc3fY9F6puOJzwF2voGr3xoj4YlZSOHgWfcdutYcbykOpzLD0qRed3IXHBp
 sTvpd+uZwwlIU9gbUI3HPEi8AcLMeToZjwyxEEKDAp0b9rPpptO+/Y749vZ3vWnfS7jh+XYcZBk
 udMqeO2u5NY2O/gC5iYGzIngnlnLgXuSPRmSR72NkMzdj/y+GaOU/O7oOD1sx22O5TVw3yJN8Y8
 td6dPKORomKSFLr5s/99JM+bvKHK5zHubSWpZdc8K2tlpxzEN5ulbQSUdXXXzCtWzxZl1q+xqaP
 qPLvQtCyCrco1eavhuSsb/157KWYfqLE0ZP3o28I2EvaGgmTNgQIBKBl7HF4PeU1pwwJMbPOchg
 Fx0CmRm+NYZQLDw=
X-Received: by 2002:a05:6820:4b04:b0:6a1:7953:3903 with SMTP id
 006d021491bc7-6a30d8d7d7fmr2071962eaf.59.1782956870226; 
 Wed, 01 Jul 2026 18:47:50 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (97-118-25-163.hlrn.qwest.net.
 [97.118.25.163]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a310051cfcsm1284511eaf.8.2026.07.01.18.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 18:47:49 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Johan Jonker <jbx6244@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>,
 Francesco Valla <francesco@valla.it>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>
Subject: [PATCH 4/9] spl: fit: support encrypted payloads
Date: Wed,  1 Jul 2026 19:46:54 -0600
Message-ID: <20260702014724.1534351-4-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702014724.1534351-1-james.hilliard1@gmail.com>
References: <20260702014724.1534351-1-james.hilliard1@gmail.com>
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

Add SPL_FIT_CIPHER and decrypt FIT image data before post-processing,
decompression or moving it to the final load address.

SPL cannot always allocate a new output buffer while loading FIT images, so
use the caller-provided decrypt-to-buffer helper. External encrypted images
are read into scratch memory first, then decrypted either in-place for
compressed payloads or into a non-overlapping buffer for direct loads.
Embedded encrypted images decrypt into the final load buffer or a scratch
buffer when decompression is still required.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 boot/Kconfig         |  9 +++++
 boot/image-fit.c     |  2 +-
 common/spl/spl_fit.c | 92 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 96 insertions(+), 7 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 8e468c56176..19bbeb9ad36 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -155,6 +155,15 @@ config FIT_CIPHER
 	  Enable the feature of data ciphering/unciphering in the tool mkimage
 	  and in the u-boot support of the FIT image.
 
+config SPL_FIT_CIPHER
+	bool "Enable ciphering data in SPL FIT images"
+	depends on SPL_LOAD_FIT
+	depends on SPL_DM_AES
+	select SPL_FIT
+	help
+	  Enable unciphering of FIT image data in SPL. This allows SPL to
+	  decrypt an encrypted U-Boot proper FIT image through an AES driver.
+
 config FIT_VERITY
 	bool "dm-verity boot parameter generation from FIT metadata"
 	depends on FIT && OF_LIBFDT
diff --git a/boot/image-fit.c b/boot/image-fit.c
index dac8b35f338..1d1723bdae0 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2290,7 +2290,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	}
 
 	/* Decrypt data before uncompress/move */
-	if (IS_ENABLED(CONFIG_FIT_CIPHER) && IMAGE_ENABLE_DECRYPT) {
+	if (!tools_build() && IMAGE_ENABLE_DECRYPT) {
 		puts("   Decrypting Data ... ");
 		if (fit_image_uncipher(fit, noffset, &buf, &size)) {
 			puts("Error\n");
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index d89384449b3..57975a7638f 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -16,6 +16,7 @@
 #include <sysinfo.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <limits.h>
 #include <linux/libfdt.h>
 #include <linux/printk.h>
 
@@ -193,6 +194,47 @@ static int get_aligned_image_size(struct spl_load_info *info, int data_size,
 	return ALIGN(data_size, spl_get_bl_len(info));
 }
 
+static int spl_fit_image_decrypt(const void *fit, int node, int cipher_node,
+				 void **data, size_t *size, void *dst)
+{
+	size_t dst_size;
+	int ret;
+
+	puts("   Decrypting Data ... ");
+	ret = fit_image_decrypt_data_to(fit, node, cipher_node, *data, *size,
+					dst, &dst_size);
+	if (ret) {
+		puts("Error\n");
+		return ret;
+	}
+
+	*data = dst;
+	*size = dst_size;
+
+	puts("OK\n");
+
+	return 0;
+}
+
+static bool spl_fit_ranges_overlap(ulong addr1, size_t size1,
+				   ulong addr2, size_t size2)
+{
+	ulong end1, end2;
+
+	if (!size1 || !size2)
+		return false;
+
+	end1 = addr1 + size1;
+	if (end1 < addr1)
+		end1 = ULONG_MAX;
+
+	end2 = addr2 + size2;
+	if (end2 < addr2)
+		end2 = ULONG_MAX;
+
+	return addr1 < end2 && addr2 < end1;
+}
+
 /**
  * load_simple_fit(): load the image described in a certain FIT node
  * @info:	points to information about the device to load data from
@@ -225,12 +267,15 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	const void *data;
 	const void *fit = ctx->fit;
 	bool external_data = false;
+	bool encrypted;
+	bool needs_decomp = false;
+	int cipher_node = -ENOENT;
+	int ret;
 
 	log_debug("starting\n");
 	if (CONFIG_IS_ENABLED(BOOTMETH_VBE) &&
 	    xpl_get_phase(info) != IH_PHASE_NONE) {
 		enum image_phase_t phase;
-		int ret;
 
 		ret = fit_image_get_phase(fit, node, &phase);
 		/* if the image is for any phase, let's use it */
@@ -256,6 +301,8 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	if (spl_decompression_enabled()) {
 		fit_image_get_comp(fit, node, &image_comp);
 		debug("%s ", genimg_get_comp_name(image_comp));
+		needs_decomp = image_comp == IH_COMP_GZIP ||
+			       image_comp == IH_COMP_LZMA;
 	}
 
 	if (fit_image_get_load(fit, node, &load_addr)) {
@@ -267,6 +314,10 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		load_addr = image_info->load_addr;
 	}
 
+	if (CONFIG_IS_ENABLED(FIT_CIPHER))
+		cipher_node = fdt_subnode_offset(fit, node, FIT_CIPHER_NODENAME);
+	encrypted = cipher_node >= 0;
+
 	if (!fit_image_get_data_position(fit, node, &offset)) {
 		external_data = true;
 	} else if (!fit_image_get_data_offset(fit, node, &offset)) {
@@ -291,11 +342,12 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 			return 0;
 		}
 
-		if (spl_decompression_enabled() &&
-		    (image_comp == IH_COMP_GZIP || image_comp == IH_COMP_LZMA))
-			src_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR, ARCH_DMA_MINALIGN), len);
+		if (needs_decomp || encrypted)
+			src_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR,
+						   ARCH_DMA_MINALIGN), len);
 		else
-			src_ptr = map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN), len);
+			src_ptr = map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN),
+					     len);
 		length = len;
 
 		overhead = get_aligned_image_overhead(info, offset);
@@ -331,10 +383,38 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		puts("OK\n");
 	}
 
+	load_ptr = map_sysmem(load_addr, length);
+	if (encrypted) {
+		void *decrypt_ptr;
+
+		if (needs_decomp) {
+			if (external_data)
+				decrypt_ptr = src;
+			else
+				decrypt_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR,
+							       ARCH_DMA_MINALIGN),
+							 length);
+		} else if (external_data) {
+			if (spl_fit_ranges_overlap((ulong)load_ptr, length,
+						   (ulong)src, length))
+				decrypt_ptr = map_sysmem(ALIGN((ulong)src + length,
+							       ARCH_DMA_MINALIGN),
+							 length);
+			else
+				decrypt_ptr = load_ptr;
+		} else {
+			decrypt_ptr = load_ptr;
+		}
+
+		ret = spl_fit_image_decrypt(fit, node, cipher_node, &src, &length,
+					    decrypt_ptr);
+		if (ret)
+			return ret;
+	}
+
 	if (CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS))
 		board_fit_image_post_process(fit, node, &src, &length);
 
-	load_ptr = map_sysmem(load_addr, length);
 	if (IS_ENABLED(CONFIG_SPL_GZIP) && image_comp == IH_COMP_GZIP) {
 		size = length;
 		if (gunzip(load_ptr, CONFIG_SYS_BOOTM_LEN, src, &size)) {
-- 
2.53.0

