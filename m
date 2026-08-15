Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5019BC5DF6D
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 13:01:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF61881397;
	Sat, 15 Aug 2026 13:01:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A19xe-d0GUrv; Sat, 15 Aug 2026 13:01:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EABB981363
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786798898;
	bh=0HjADxNZI4UChEhKCsXZoxczS5pdM5sEtdAsjhQ2pvs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B1mHzUvolhk7ijLg0uUjtBto4W0317MCucwFGaOiBbRV1YaRk3rFQIFbTg1kvx8lr
	 sw+SYQ62jveLbg7uyOr962a5A6N8K2QzTfbh/q/V/pxjVTbBMOe1ZkkJEV/uzrh+FD
	 ynMu37/cfauWbzyQEVGZdmXQQgQ1vcBVK/ERZDDOFFwPTHqu+Ioffj0Cv9boC+OjlE
	 qgwLWwvavUVd7OcMqki6jjBMROOKPlVg/uIQxaTJvCjyh2/iq6LyslsZYlDmF28ds5
	 wGP2q14LBpbul1dliRuqmPgctOU+Fn0Xq2qFJEag9OpomH+dlKCg7wC2jd10yEBXwt
	 CjbAcu0DkwfCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EABB981363;
	Sat, 15 Aug 2026 13:01:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C4F03361
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:49:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AB22D60DC7
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:49:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4tkgQA0y7Yq9 for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 05:49:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 96B1F60A50
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96B1F60A50
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Ls70P3LL
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 96B1F60A50
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:49:01 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7eb1dc6bd53so1308762a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786772940; x=1787377740;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0HjADxNZI4UChEhKCsXZoxczS5pdM5sEtdAsjhQ2pvs=;
 b=Ls70P3LL0NslFLl/0T4LCryRCg8FqUPqVfIiO1wajgxWpFY5Stq24gPOMY8pnSbaPI
 a4H0pYauGfklcymIZvLr3LI7mklSRelV18rWqSjwFfFj44XWtlIV98SDVdCSjoAIvfnz
 AN3/7DZ7btfdopjQDaAd/oN4qYNnRrD4eqJ1VAxtX8eKKCAklttwDpnVdlMXDTVIjoJ7
 Qy25B932VQMjiZu/HscjIt0ughY1hdjUCgqZ0lOQCELkiY4qQZOFin+4Ah/kwRtcZh5p
 5H6jo6ahPCh6NtfSyZaoj9/Hg1OHV2NSnfpddQjKqSLgWj3jd3pHTGVIoRjPg7RMPpaH
 V6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786772940; x=1787377740;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0HjADxNZI4UChEhKCsXZoxczS5pdM5sEtdAsjhQ2pvs=;
 b=W0Z+UeuPX7Q2d+OxdxJyQBZUXzzKfcrLrg0fi9E9E95AZmkIiUIBYbUUEvombYYOY2
 9sO2u/FQXugNqOWfIUWcd3NEGnF+WmS3sWTAKX/t2hy0tbEhsC3RExhWuAcgkNFfVcuM
 /dqavwIKc4hcD4B4xCc7JS63BG0/3Z7Vw3P5WPwd4ppvHaW2mhIYbs86UQuBxA5MBWz0
 Jqw8g2Z6GNYeXk33ETKZyr/3c6UpOxHkPYV3l/XXIlq1Q+ZWNYC1UG9M9yTfhd3kZBLt
 H9fI1hZclTWEXb+na91eLYntjXa3SYbQrmo8Z7pKERYh+blN6E8fClSdzJOnMfJG1kky
 kuig==
X-Forwarded-Encrypted: i=1;
 AHgh+RoG7gqFUbosghVJKSdkS8II9YsvCyQ8bAwB/hr9getNDU1FbRI6Fb03pFKqjKET7K8+r95SpHo=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxfaSMSYLFoI8+kwOD5GbnyZAuZZcs/dMLV4k9WhHQhUGtCEZlW
 3YY+sL4H+gjLn5P903B16HV9AWk6LvVBc7AK+WVWc9wU8GOaXRmfoKVU
X-Gm-Gg: AR+sD10vVjb6CgJtIjaxRIkWQzdHAOyz2QnhDrGNmG75NOX/bQ+zpynnn95uQnYRoFR
 2MY69p3MsYKmORg2pg21SUEES7mA6ynL8WAvPTCDy2uuuNb8QE3mEsYlWRdhZR7u02/9G6I3HbP
 dDWkFDtfB2HhSWR+2jOVLgE03F/Aj40ICLT24UZoDwQtlxkBhYd3biLejctKGd7aIdZpZxUpH17
 6NYj7AtELvV6phVKBfygouzUeWcOUuIUK4dn2pHjLzmkOZBBO53d6DbnHOTli6YSz9VbTLHpEYK
 P/66Dip1lNWkYGR5UXVlYLixOSQjwB16/RyDp9A6T3d1Cwidkeiq3kcUVZ9spNwQrQXdR2MPgTk
 nQS85sqnA9nY5wrY4ZJnxkUnP/2Jk9RMJF/bupZzaw/XftUwKYtx9PbCA8xZBknACulykWFaxTk
 /ZID2QjNQL6+aCCKnzGXz/fyBP5NYlmk0mt959umgT0Qaf++59huD/yTVCirLWUmthCIEV3KMPf
 q4fBUj3ynxeOuXlOdKvd9Vny0GZMBuWx8oFD9JN7i/7MVxa7MkvJN98xomU7bN2r7MOs8j9kAWs
 sXfTBLsywiFA5du83Q3N9pttkOziz6WyDi5EcMjhsGVmYNxEHTpPOfNl5C7P+yGAX+IvsDB58s8
 xU026L8/Z5Dy7izlI
X-Received: by 2002:a05:6830:2aa2:b0:7e6:ef1d:4aeb with SMTP id
 46e09a7af769-7f3de70ef43mr10158048a34.15.1786772940329; 
 Fri, 14 Aug 2026 22:49:00 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e86282a6sm2780166a34.18.2026.08.14.22.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 22:48:59 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 14 Aug 2026 23:48:17 -0600
Subject: [PATCH v8 10/15] spl: fit: support encrypted payloads
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-submit-ce-series-v2-v8-10-fe9212431a94@gmail.com>
References: <20260814-submit-ce-series-v2-v8-0-fe9212431a94@gmail.com>
In-Reply-To: <20260814-submit-ce-series-v2-v8-0-fe9212431a94@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 u-boot@lists.u-boot-project.org
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
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
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>, 
 Raymond Mao <raymondmaoca@gmail.com>, Yao Zi <me@ziyao.cc>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sat, 15 Aug 2026 13:01:17 +0000
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
  - Comment the no-copy path after direct decrypt
    (suggested by Simon Glass)

Changes v1 -> v2:
  - Drop redundant SPL_FIT select  (suggested by Simon Glass)
  - Explain the IMAGE_ENABLE_DECRYPT change  (suggested by Simon Glass)
  - Explain the host tools decrypt behavior  (suggested by Simon Glass)
  - Decrypt external encrypted payloads in place
    (suggested by Simon Glass)
  - Skip self-memmove after direct decrypt  (suggested by Simon Glass)
---
 boot/Kconfig         |  9 ++++++
 boot/image-fit.c     |  2 +-
 common/spl/spl_fit.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 91 insertions(+), 9 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index c67dc0ba493..11b7c7cf017 100644
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
index 24ce9c83c7c..9d6db5cb418 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2350,7 +2350,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	}
 
 	/* Decrypt data before uncompress/move */
-	if (IS_ENABLED(CONFIG_FIT_CIPHER) && IMAGE_ENABLE_DECRYPT) {
+	if (!tools_build() && IMAGE_ENABLE_DECRYPT) {
 		puts("   Decrypting Data ... ");
 		if (fit_image_uncipher(fit, noffset, images->verify,
 				       &buf, &size)) {
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 18bff7b8d4a..553b81299b7 100644
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
@@ -221,19 +249,23 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
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
@@ -259,6 +291,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	if (spl_decompression_enabled()) {
 		fit_image_get_comp(fit, node, &image_comp);
 		debug("%s ", genimg_get_comp_name(image_comp));
+		needs_decomp = spl_image_needs_decomp(image_comp);
 	}
 
 	if (fit_image_get_load(fit, node, &load_addr)) {
@@ -270,6 +303,14 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
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
@@ -311,11 +352,12 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		if ((ulong)len > max_size)
 			goto too_big;
 
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
@@ -360,10 +402,40 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
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
@@ -381,7 +453,8 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
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

