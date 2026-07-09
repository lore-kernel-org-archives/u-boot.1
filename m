Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8640BC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 13:00:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E831A84B20;
	Fri, 10 Jul 2026 14:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pRr8rvbS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84B9484BBF; Fri, 10 Jul 2026 00:46:59 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35D2284B65
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 00:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6a3776acb16so232522eaf.2
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 15:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783637216; x=1784242016; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FHHefGozE/pz9Q8upl4VTajhYnzJHfRHvAOAN5SD3f8=;
 b=pRr8rvbSdiia7XE0MsJxp05Qec4BYXeDD8VYcMNOErwCYZCTXs3G+F5Lba/KvejVti
 Tg3vzCBt2yUagodW5gTFDsu4LdLJ3G5RKyGIETX+/yGqQ5mlCYTMq3apNqZLTVCHGQV8
 FCP+ZN5SsIBxKzodqmPpqIhhX9hdX8Dxz3b8m4jiUfpJC3R0UqPCi4oBb1tQmT0PBc8e
 1nhAbBkZciSDyqj0N5hiqeE477+GGvbRi3H20eP3JD6vf0gE0HYbTBC+4fOJXEmVwtCp
 9UMiNq7N358y02l4srSfeGu1gvY92N3K18eDtS3eCunJzdZ7YOyCKLGEM/NyItdnWeJ1
 9alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783637216; x=1784242016;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FHHefGozE/pz9Q8upl4VTajhYnzJHfRHvAOAN5SD3f8=;
 b=aofidHK3xLwg2iLMLb+d6r2J1ZwT+RQl7keImSnfQo3XP7X6eLcigSmfvCAqM3n/uo
 VltQk3HxUAx15EZzNR5PvEB//FCwH3h31H1wQ4m9wsfGGpztwPW1NVKJkrc+IVZkbdAc
 DK9l9DsOKZRduhNt/zb0utY+a1Bs+uBwoGi62yfISUmvb1QyTah3wXRWvnLcsmqEK3u6
 /E40Q4TvrfhhLPe4AaTJVormhH0al75dHQIo3cC2pDMIm5KZvJmD1OlpTepT+/I820kB
 c77gy3h05qV2hInGHPgcbIgiN9elXKSIKCjhk5fgx1R26odwIksJCkvlmEE+EamZZ9aC
 77zg==
X-Gm-Message-State: AOJu0YxkewNvi2r61Be1XiYeCe31Gw55TttrSoln6L8TlAotEz7fJHu/
 5VrsAFAv8v3mWgMS8pq6CXG4+mCV2pn+8h6lTRUVm8OuY2gkchUjlbfA
X-Gm-Gg: AfdE7ckIYEW9rvMOWVE+rzg1s3q2nCHb/DOcg6g7dmKueXjMMT2ahm9vcIiE4I5zYc2
 ztJU3xt08yHYxm+L3T4T1SfjuQK8a4zbBXTL9D5Q0u/KuiM5plwMJ4WKb7IbJt5yPCDl1pohJow
 fDpHPX4Vk8RJxKF7N8Mxer78AFY3TnWKX0cr+khhT5PEQcyjQBEIeUu2XoGv8VkyYwUuSCgBOHl
 EuLNHA7qZftKu9nQugm5f9VDAHnHtqgIQCds9NOEvcwJtDvWj746oGd51hx76vDSKJt8D31yXkP
 jKbsexp91isQztZ8GMqASFwuAd6JWRrq4nj+u98N1vHKclfdgQL1k6+SYrGpgmNy9SkypPSwlpO
 C1VWGZ336D8qxvCSRY29FElTGhYEOGI6EmPKzTvyRjgboPg69IV8YCes0Xmukfzd6cSz42MB8Va
 EvdAjz8WKkpoQ42AM88sN5++JmoNyQQtgfPA0t78eZE/rZtNxNPQaMo3IuY+5wf9ofA+91k849j
 VDCz690XXgIrjgOh4KaNWs84KAxOd78I9edYWvo/jTKWUDH7cVavqEZcvZvn+16
X-Received: by 2002:a05:6820:1997:b0:6a3:8667:dc7f with SMTP id
 006d021491bc7-6a38667dff1mr2157385eaf.60.1783637215854; 
 Thu, 09 Jul 2026 15:46:55 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45191643abdsm3310749fac.11.2026.07.09.15.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 15:46:55 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 09 Jul 2026 16:46:26 -0600
Subject: [PATCH v3 04/10] spl: fit: support encrypted payloads
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-submit-ce-series-v2-v3-4-5017da8c9bef@gmail.com>
References: <20260709-submit-ce-series-v2-v3-0-5017da8c9bef@gmail.com>
In-Reply-To: <20260709-submit-ce-series-v2-v3-0-5017da8c9bef@gmail.com>
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
 Jerome Forissier <jerome.forissier@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 10 Jul 2026 14:56:43 +0200
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
Changes v2 -> v3:
  - Use a shared helper for SPL decompression buffer decisions
    (suggested by Simon Glass)
  - Reject encrypted SPL FIT payloads when SPL_FIT_CIPHER is disabled
    (suggested by Simon Glass)
  - Flatten decrypt buffer selection  (suggested by Simon Glass)
  - Comment the no-copy path after direct decrypt  (suggested by Simon Glass)

Changes v1 -> v2:
  - Drop redundant SPL_FIT select  (suggested by Simon Glass)
  - Explain the IMAGE_ENABLE_DECRYPT change  (suggested by Simon Glass)
  - Explain the host tools decrypt behavior  (suggested by Simon Glass)
  - Decrypt external encrypted payloads in place  (suggested by Simon Glass)
  - Skip self-memmove after direct decrypt  (suggested by Simon Glass)
---
 boot/Kconfig         |  8 ++++++
 boot/image-fit.c     |  2 +-
 common/spl/spl_fit.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 77 insertions(+), 8 deletions(-)

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
index d89384449b3..b79ca24bc4c 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -193,6 +193,34 @@ static int get_aligned_image_size(struct spl_load_info *info, int data_size,
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
+static bool spl_image_needs_decomp(uint8_t image_comp)
+{
+	return (IS_ENABLED(CONFIG_SPL_GZIP) && image_comp == IH_COMP_GZIP) ||
+	       (IS_ENABLED(CONFIG_SPL_LZMA) && image_comp == IH_COMP_LZMA);
+}
+
 /**
  * load_simple_fit(): load the image described in a certain FIT node
  * @info:	points to information about the device to load data from
@@ -225,12 +253,15 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
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
@@ -256,6 +287,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	if (spl_decompression_enabled()) {
 		fit_image_get_comp(fit, node, &image_comp);
 		debug("%s ", genimg_get_comp_name(image_comp));
+		needs_decomp = spl_image_needs_decomp(image_comp);
 	}
 
 	if (fit_image_get_load(fit, node, &load_addr)) {
@@ -267,6 +299,14 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		load_addr = image_info->load_addr;
 	}
 
+	cipher_node = fdt_subnode_offset(fit, node, FIT_CIPHER_NODENAME);
+	if (cipher_node >= 0 && !CONFIG_IS_ENABLED(FIT_CIPHER)) {
+		printf("Can't load %s: encrypted image without SPL_FIT_CIPHER\n",
+		       fit_get_name(fit, node, NULL));
+		return -ENOSYS;
+	}
+	encrypted = cipher_node >= 0;
+
 	if (!fit_image_get_data_position(fit, node, &offset)) {
 		external_data = true;
 	} else if (!fit_image_get_data_offset(fit, node, &offset)) {
@@ -291,11 +331,12 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
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
@@ -331,10 +372,29 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		puts("OK\n");
 	}
 
+	load_ptr = map_sysmem(load_addr, length);
+	if (encrypted) {
+		void *decrypt_ptr;
+
+		if (external_data) {
+			decrypt_ptr = src;
+		} else if (needs_decomp) {
+			decrypt_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR,
+						       ARCH_DMA_MINALIGN),
+						 length);
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
@@ -352,7 +412,8 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 			return -EIO;
 		}
 		length = loadEnd - CONFIG_SYS_LOAD_ADDR;
-	} else {
+	} else if (src != load_ptr) {
+		/* Direct decrypt of an embedded image can already be in place. */
 		memmove(load_ptr, src, length);
 	}
 

-- 
2.53.0

