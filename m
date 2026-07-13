Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61044C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:22:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 572FA84B59;
	Mon, 13 Jul 2026 15:21:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aBvERE4T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0185384A4C; Mon, 13 Jul 2026 08:43:56 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92F5084A48
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 08:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7e9f5637634so1905052a34.3
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 23:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783925032; x=1784529832; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B1VOSm2B0Uo4pycsCMv3U3BY63SyX0keHiRtPUbt5Gs=;
 b=aBvERE4TogKhN7enqAEfI7gTyF/DKHJt6LWDaA74pbjX41qMqqybOYEeVO0ACo13tU
 RzPc7/Av46pvXCc07t4erA+T+w76HRB53rwUDSovsNR6E2ee3jkPXqbJZt/osi8tflr2
 0o4n3oyQD0PErw+odI+8REzPQ7graM2+BlIsQUrOC7GtYJr1BK2hDEk/OiPh5t/PYZuo
 B5UOwcLXrBf7Aw7PYjNPTIN42vFUF+E/z75LdbdEZaT3BUvFi7tCeceErSTM4Zncmnga
 iArV8SJR2LTLPGZJKL8yetgCB0Yyw/IOddop76q8V2kvWYM+iJn6HuZh3HXhy5emCGH6
 sqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783925032; x=1784529832;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B1VOSm2B0Uo4pycsCMv3U3BY63SyX0keHiRtPUbt5Gs=;
 b=f3LKwsnD9mRoC2EVCp1y1EpYqPa4iR8dVqiQ/27kDagI+pQr0HzNLM7EEc9FfZ0jjI
 oeufTGu76DfHalQptyjdml1vmZT35G+P0DNacEaORAxArjmstQMkoF06RZZv2GWlOchp
 be5um2vmAHYrh/cWpl90ZCYG8HDOv2sGnsdFcnHQEY+Dkcn5MadfLxAWHsfdWKDGHaef
 1RSJiuMQDsc/zbUlhzJo7LfrQP0a3BK/BHBPiLW51fXtsF/J6AUfhlOqvzsRFPHonPrr
 A1fzUbfCAEahRHVSwrG+b0G481yckid/ll/1qwdxcesSc5NzeOigyTrjmySRHQz0ADH+
 QIGQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GKJkbobIIGxQBM1S/BJ+bp4ZeFaSpNnDWXvbe4IFLkYuj8Mta0Ayuz8Q/IwRYy+Mbmyu6Yp4=@lists.denx.de
X-Gm-Message-State: AOJu0YwgcHknEqXBpNAkgzmGR8UACcvJ7tVnl6dbgLHKnoGZtLfKA3zV
 E8A4M9IQuPJ7vC+lvTL1EYWM5WuPeLYivalJjwwdtZwZ6W0CXveLckLz
X-Gm-Gg: AfdE7cmYop7DVCdffqLAut/saMlCcfPB00iGJqkx+fw/OpLBRysHZkseMOXSc5irgiN
 KLiEJ07xKmWAXjdNnhh3vAyV8vw3u5HVOCRnbOgKJTH4YAXkG+dby0yD2697fyv6MkqyIw/cp+2
 nuGodJBMrLXWmbsVli4/kVYcQMHlqBD3LlxNwdDtWVX6eNnXndUQjvtrqkPCS/wwF74JgrYXUNb
 0NcaULUjl9snfp7PUU3bY+hd5YDUSW+BZHzhl0U+QLXRtKLgMPmYZEJRME9455cXZNQ/6E5MugA
 Xxk0t80pk3LwoTP2UpZEYNootQxcfDh7EuP21lOleRqQhzPdKqKhW4Sl4HKskPSfnAZavULkNhF
 LvckyyeZNJhZeM99pJxYIRL/QXXrL1b1cdwx05/GNnBx/OM0TCmsEufEwrvRR4+lVCpjCbCZN87
 zPqXSY2HQbKAoISn8bv3ptCNtndFUF0E9/xpcpVdjEFhyWAlV3x09SK15TYAwM0mKEkd3fMrRqw
 IgcdSf6QTeaIhlwPXxk8BtMGJkOPUsTsPa/tsYPcQgs1u9B/Gb7EsJKOAZxoa8x
X-Received: by 2002:a05:6820:2910:b0:6a3:19a6:dc1f with SMTP id
 006d021491bc7-6a39a854c2cmr4674809eaf.33.1783925032228; 
 Sun, 12 Jul 2026 23:43:52 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916ce98dsm12538126fac.13.2026.07.12.23.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 23:43:51 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 13 Jul 2026 00:43:06 -0600
Subject: [PATCH v4 09/14] spl: fit: support encrypted payloads
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-submit-ce-series-v2-v4-9-ff7edc705b8a@gmail.com>
References: <20260713-submit-ce-series-v2-v4-0-ff7edc705b8a@gmail.com>
In-Reply-To: <20260713-submit-ce-series-v2-v4-0-ff7edc705b8a@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Francois Berder <fberder@outlook.fr>, Peng Fan <peng.fan@nxp.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Mon, 13 Jul 2026 15:20:59 +0200
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

Defer mapping the final destination until the board post-processing hook
has finalized the source and length. The direct embedded-decrypt path maps
early because the hardware needs its destination, but tracks and extends
that mapping if post-processing grows the payload. Map decompression output
for CONFIG_SYS_BOOTM_LEN rather than the compressed input length.

Use IMAGE_ENABLE_DECRYPT in the common FIT image-load path so FIT cipher
support is selected by phase. Keep that path disabled for host tools,
since the target-side decrypt helper depends on the U-Boot control FDT
and runtime crypto providers.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v3 -> v4:
  - Map the final destination after board post-processing determines size
  - Size decompression mappings for the maximum output
  - Require SPL_OF_CONTROL and clarify the SPL_FIT_CIPHER help text

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
 boot/Kconfig         |  9 ++++++
 boot/image-fit.c     |  2 +-
 common/spl/spl_fit.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 91 insertions(+), 9 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 8e468c56176..2e12a72a97b 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -155,6 +155,15 @@ config FIT_CIPHER
 	  Enable the feature of data ciphering/unciphering in the tool mkimage
 	  and in the u-boot support of the FIT image.
 
+config SPL_FIT_CIPHER
+	bool "Enable decrypting data in SPL FIT images"
+	depends on SPL_LOAD_FIT
+	depends on SPL_DM_AES
+	depends on SPL_OF_CONTROL
+	help
+	  Enable decrypting FIT image data in SPL. This allows SPL to
+	  decrypt an encrypted U-Boot proper FIT image through an AES driver.
+
 config FIT_VERITY
 	bool "dm-verity boot parameter generation from FIT metadata"
 	depends on FIT && OF_LIBFDT
diff --git a/boot/image-fit.c b/boot/image-fit.c
index 6b55316dd37..437f6ab6381 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2306,7 +2306,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	}
 
 	/* Decrypt data before uncompress/move */
-	if (IS_ENABLED(CONFIG_FIT_CIPHER) && IMAGE_ENABLE_DECRYPT) {
+	if (!tools_build() && IMAGE_ENABLE_DECRYPT) {
 		puts("   Decrypting Data ... ");
 		if (fit_image_uncipher(fit, noffset, &buf, &size)) {
 			puts("Error\n");
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index d89384449b3..961e3338d16 100644
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
@@ -218,19 +246,23 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	int len;
 	ulong size;
 	ulong load_addr;
-	void *load_ptr;
+	void *load_ptr = NULL;
+	size_t load_map_len = 0;
 	void *src;
 	ulong overhead;
 	uint8_t image_comp = -1, type = -1;
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
@@ -256,6 +288,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	if (spl_decompression_enabled()) {
 		fit_image_get_comp(fit, node, &image_comp);
 		debug("%s ", genimg_get_comp_name(image_comp));
+		needs_decomp = spl_image_needs_decomp(image_comp);
 	}
 
 	if (fit_image_get_load(fit, node, &load_addr)) {
@@ -267,6 +300,14 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
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
@@ -291,11 +332,12 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
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
@@ -331,10 +373,40 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		puts("OK\n");
 	}
 
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
+			load_map_len = length;
+			load_ptr = map_sysmem(load_addr, load_map_len);
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
+	size = needs_decomp ? CONFIG_SYS_BOOTM_LEN : length;
+	if (!load_ptr || size > load_map_len) {
+		void *old_load_ptr = load_ptr;
+
+		load_ptr = map_sysmem(load_addr, size);
+		load_map_len = size;
+		if (src == old_load_ptr)
+			src = load_ptr;
+	}
+
 	if (IS_ENABLED(CONFIG_SPL_GZIP) && image_comp == IH_COMP_GZIP) {
 		size = length;
 		if (gunzip(load_ptr, CONFIG_SYS_BOOTM_LEN, src, &size)) {
@@ -352,7 +424,8 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
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

