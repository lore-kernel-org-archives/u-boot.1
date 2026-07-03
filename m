Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EAF8C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 07:59:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77ADB8490A;
	Fri,  3 Jul 2026 09:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GG09wgeG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A165684994; Fri,  3 Jul 2026 03:50:05 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 728FD84A5D
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 03:50:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-44ce674ed17so21065fac.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 18:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783043400; x=1783648200; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x/Ly28iFzeK1QD2nlT5lt2lVajOfQeKG+PDF3jdEHCo=;
 b=GG09wgeGulNMoQMoOVqcu8eZOQV02XGypmbL8oNeYGRmNRKx24bbFFl1f7dS/yO27u
 oVwMsBpLwvDzUFoVTRV9Zo8JfanfGcNaPJtXTo14XT4I5CIgQiCj56S40ce9FYSo1GMK
 viAxZuhM0E+sK7TmjK4pc6nbs9JZ44tOhmWuCpjjHB0lZ1LaF0zZ5MDVn1Zl9CIZ7Tbe
 0pqjDzcfj9cB4ynjCHyHBJSSx0X3ijfqFQBKvnnYBRMFowXh3LLd+yVTERZHOnaBFqAx
 aOo85QHXCRHjtu/Binrm4cAtY13fM4kIJ+dvq/0E6Fw/E/66W1X4s0IVJWjmiHcuur0M
 KVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783043400; x=1783648200;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x/Ly28iFzeK1QD2nlT5lt2lVajOfQeKG+PDF3jdEHCo=;
 b=THVe/0rLuY5YjYqUtF9BYmV7vF/pngSjpSodJr2mwiF3saA+LsB5rcFxVBrJUa5s4n
 Yq87SZ3w6Eujjc5IWTsh4cbwlXvQJWgOlEcd/tK11noFytXcxmtQXo7sX3oUE/jmkolk
 bMQ0AtkM6uSZH4Vo976r/Vv6pcQYy29QpPAzvDOmJLVQ4nR6eKcJCgM7Tpu5t08Egqcq
 /yiHUYthtimfdj8cWyNBmsofXAushQUoI9E58K6f+SA8aUDt3LYwSTJz7k6QUIv1Xf9P
 wPixcSQP5l22mNBcNcVOitKgBLio1qMwBSiF05tAA6njtGKScK0V7qbdH8cLpHdCgGlw
 pTow==
X-Gm-Message-State: AOJu0YzC2SBvXrLGL3RR05j0iXogVxxLmX0/uqrs80YHm+arZESvi4dW
 sIG5qKkyDJHRTXbZ1c/xCRWru9vAGZc7YCMs4gkai9c8PJtWfVRWZ7UY
X-Gm-Gg: AfdE7cmXXElAfQUgjaSyP3RypddxprXx0lYvWJYGTfKd7T/LYGaephhovZW39PG23dv
 wQEFp5mNrwawtJek5O8yf6YECLBuOpXKG/b20jkxOavV4je7Cg905Lltg3N0ZH0FHJQLDzl8F5/
 XTpAxh7XcFbR1iUzMmYNkJeg5jRZ4DARvqDMgbcIm3JgN4PkR48V7jo8iTpFxaveZemS4/Gf3vP
 a3Zf+/Sd4RMS/cQyERrku8IZb1dyflhcHrnKDfPydpKsZXarehnJ+rmw7UPznpsO00ky3I1Mpkz
 t1BoV9EwZGOQd9Uy0L9urGKXn6vcCQui4CBkfZEe3rFstXgkJNlqOGNmGA91NRaO2ZxZ/3HwR3c
 +4udM3Ty435UgBAxye7Bln8TQnOfumiIyWGuj3dRlwBuwnPRiRrsmrFL3S3vd0jpBSlwotEf6WS
 BEFzgsKRvJpxfnstex/AfnEYmt9XHWZS08LV2/0yYgikB3P55cIMFpJGAVNZKZqXuQGdKYsBIme
 6gFzvL/fREes/sLtL3WRJq9MDVE0FsNhVjHpVkWSjHS6exzD4WhSCBK2hX3bZfqUZhaGg==
X-Received: by 2002:a05:6808:1b26:b0:492:7ecb:94e6 with SMTP id
 5614622812f47-497e00ce19bmr1774042b6e.33.1783043400126; 
 Thu, 02 Jul 2026 18:50:00 -0700 (PDT)
Received: from [127.0.1.1] (97-118-25-163.hlrn.qwest.net. [97.118.25.163])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d1b43cfcsm2974888b6e.14.2026.07.02.18.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 18:49:59 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 02 Jul 2026 19:49:49 -0600
Subject: [PATCH v2 04/10] spl: fit: support encrypted payloads
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-submit-ce-series-v2-v2-4-ffda5bed58af@gmail.com>
References: <20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com>
In-Reply-To: <20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com>
To: u-boot@lists.denx.de, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Ion Agorria <ion@agorria.com>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Randolph Sapp <rs@ti.com>, 
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@gmail.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>, Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 Michael Walle <mwalle@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, E Shattow <e@freeshell.de>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Thierry Reding <treding@nvidia.com>, Francois Berder <fberder@outlook.fr>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 03 Jul 2026 09:59:22 +0200
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

SPL cannot always allocate a new output buffer while loading FIT images,
so use the caller-provided decrypt-to-buffer helper. External encrypted
images are read into scratch memory first, then decrypted in place before
the existing copy or decompression path consumes them. Embedded encrypted
images decrypt into the final load buffer, or into scratch memory when
decompression is still required.

Use IMAGE_ENABLE_DECRYPT in the common FIT image-load path so FIT cipher
support is selected by phase. Keep that path disabled for host tools,
since the target-side decrypt helper depends on the U-Boot control FDT
and runtime crypto providers.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Drop redundant SPL_FIT select  (suggested by Simon Glass)
  - Explain the IMAGE_ENABLE_DECRYPT change  (suggested by Simon Glass)
  - Explain the host tools decrypt behavior  (suggested by Simon Glass)
  - Decrypt external encrypted payloads in place  (suggested by Simon Glass)
  - Skip self-memmove after direct decrypt  (suggested by Simon Glass)
---
 boot/Kconfig         |  8 +++++++
 boot/image-fit.c     |  2 +-
 common/spl/spl_fit.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 70 insertions(+), 8 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 8e468c56176..73fc570d0c8 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -155,6 +155,14 @@ config FIT_CIPHER
 	  Enable the feature of data ciphering/unciphering in the tool mkimage
 	  and in the u-boot support of the FIT image.
 
+config SPL_FIT_CIPHER
+	bool "Enable ciphering data in SPL FIT images"
+	depends on SPL_LOAD_FIT
+	depends on SPL_DM_AES
+	help
+	  Enable unciphering of FIT image data in SPL. This allows SPL to
+	  decrypt an encrypted U-Boot proper FIT image through an AES driver.
+
 config FIT_VERITY
 	bool "dm-verity boot parameter generation from FIT metadata"
 	depends on FIT && OF_LIBFDT
diff --git a/boot/image-fit.c b/boot/image-fit.c
index a4192db5eb5..c84cbfaf4a8 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2312,7 +2312,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	}
 
 	/* Decrypt data before uncompress/move */
-	if (IS_ENABLED(CONFIG_FIT_CIPHER) && IMAGE_ENABLE_DECRYPT) {
+	if (!tools_build() && IMAGE_ENABLE_DECRYPT) {
 		puts("   Decrypting Data ... ");
 		if (fit_image_uncipher(fit, noffset, &buf, &size)) {
 			puts("Error\n");
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index d89384449b3..e5a525f6dce 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -193,6 +193,28 @@ static int get_aligned_image_size(struct spl_load_info *info, int data_size,
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
 /**
  * load_simple_fit(): load the image described in a certain FIT node
  * @info:	points to information about the device to load data from
@@ -225,12 +247,15 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
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
@@ -256,6 +281,8 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	if (spl_decompression_enabled()) {
 		fit_image_get_comp(fit, node, &image_comp);
 		debug("%s ", genimg_get_comp_name(image_comp));
+		needs_decomp = image_comp == IH_COMP_GZIP ||
+			       image_comp == IH_COMP_LZMA;
 	}
 
 	if (fit_image_get_load(fit, node, &load_addr)) {
@@ -267,6 +294,10 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		load_addr = image_info->load_addr;
 	}
 
+	if (CONFIG_IS_ENABLED(FIT_CIPHER))
+		cipher_node = fdt_subnode_offset(fit, node, FIT_CIPHER_NODENAME);
+	encrypted = cipher_node >= 0;
+
 	if (!fit_image_get_data_position(fit, node, &offset)) {
 		external_data = true;
 	} else if (!fit_image_get_data_offset(fit, node, &offset)) {
@@ -291,11 +322,12 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
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
@@ -331,10 +363,32 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
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
+			decrypt_ptr = src;
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
@@ -352,7 +406,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 			return -EIO;
 		}
 		length = loadEnd - CONFIG_SYS_LOAD_ADDR;
-	} else {
+	} else if (src != load_ptr) {
 		memmove(load_ptr, src, length);
 	}
 

-- 
2.53.0

