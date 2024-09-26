Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104FACCFA07
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:47:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99D558900A;
	Fri, 27 Sep 2024 00:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ah0J6FTh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9B6F88F9B; Fri, 27 Sep 2024 00:47:03 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99E7E8902A
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:47:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-458320b30e7so9089181cf.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390820; x=1727995620; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dh8ej0SAPoxAESPVeJnekI6PJvtogMy4iWtSEq5Jg6c=;
 b=Ah0J6FThWu3AZp8Jpy8qL0CtTKP6cXIV8d4raw7VHfIZS3dqzaT1/P1lmL2dIZH831
 RP7yEQjcV+hliIZ8JFjkCQ7DHnh8yG4oJPac8Jtp1khSRHX1OIPmVpYoajouMpB5ds9Y
 KzNT0j+hMpOmFewBzobKqk4ZcDmwCmnI56lbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390820; x=1727995620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dh8ej0SAPoxAESPVeJnekI6PJvtogMy4iWtSEq5Jg6c=;
 b=kj7ZPp8PV1hhIgbcn9MmszJMOpCV2cagCcw2SlqC+wBPgb094OmxxzmgOpXwS1Pl3K
 /nZqb1eGtjF5g2rT3/podB5juKcWxHS1BQslFQY5btsoqKncKNq0eNV0N/+T5YdqEDsO
 DKy0QHAgdNebn3jGDWCT9ksQT1aDb6r6SWUXwgXGGu7N+Nv91noWcKQuwjEGmeMHaah9
 uLHer4SSPTOgFkvS7B5UXyG/Y753Bh0pB8HpZKDI3Ni4DeM5NCPinKAqrkfYCyO26rhS
 3kLkcEm7keRjNH57hvdScrVUgxjwZ80qtz3nlesGdslrYOoBYVDEZn7lWlWC8LAzoiiI
 EJ5A==
X-Gm-Message-State: AOJu0YzIkVqVxMjLqgpucJjWPNXUWG4w31mvQ0Z6XsACN+VWMRCiLjPX
 s6hhBuhW/C4pJURoREU/uJDcME6vOE3Xzj45a5Ev7DILnoZeB/YD2TMPNIcndd9vH3WWG3brc/d
 Kk3jwe3E=
X-Google-Smtp-Source: AGHT+IFYy8A1srULU2pH/XJWxV7zlLyTCWRYcgRom9lkMqL48glzFGE4O9PhqSA44en1iXJ4620eGw==
X-Received: by 2002:ac8:5956:0:b0:457:d1e9:fc1f with SMTP id
 d75a77b69052e-45c9f2829c6mr17576821cf.40.1727390820392; 
 Thu, 26 Sep 2024 15:47:00 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:47:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 38/42] xpl: Rename spl_next_phase() and spl_prev_phase()
Date: Fri, 27 Sep 2024 00:36:03 +0200
Message-ID: <20240926223814.1276764-39-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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

Rename this to use the xpl prefix.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/sandbox/cpu/spl.c |  4 ++--
 arch/x86/lib/tpl.c     |  2 +-
 common/bloblist.c      |  2 +-
 common/spl/spl.c       | 14 +++++++-------
 include/spl.h          |  8 ++++----
 lib/fdtdec.c           |  2 +-
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
index 7497d90fb89..71d785f4c3e 100644
--- a/arch/sandbox/cpu/spl.c
+++ b/arch/sandbox/cpu/spl.c
@@ -28,7 +28,7 @@ int sandbox_find_next_phase(char *fname, int maxlen, bool use_img)
 	int ret;
 
 	cur_prefix = spl_phase_prefix(xpl_phase());
-	next_prefix = spl_phase_prefix(spl_next_phase());
+	next_prefix = spl_phase_prefix(xpl_next_phase());
 	ret = os_find_u_boot(fname, maxlen, use_img, cur_prefix, next_prefix);
 	if (ret)
 		return log_msg_ret("find", ret);
@@ -101,7 +101,7 @@ static int load_from_image(struct spl_image_info *spl_image,
 	if (!IS_ENABLED(CONFIG_SANDBOX_VPL))
 		return -ENOENT;
 
-	next_phase = spl_next_phase();
+	next_phase = xpl_next_phase();
 	pos = spl_get_image_pos();
 	size = spl_get_image_size();
 	if (pos == BINMAN_SYM_MISSING || size == BINMAN_SYM_MISSING) {
diff --git a/arch/x86/lib/tpl.c b/arch/x86/lib/tpl.c
index 7c03dea0711..0606b4a1c67 100644
--- a/arch/x86/lib/tpl.c
+++ b/arch/x86/lib/tpl.c
@@ -103,7 +103,7 @@ int spl_spi_load_image(void)
 
 void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
 {
-	debug("Jumping to %s at %lx\n", spl_phase_name(spl_next_phase()),
+	debug("Jumping to %s at %lx\n", spl_phase_name(xpl_next_phase()),
 	      (ulong)spl_image->entry_point);
 #ifdef DEBUG
 	print_buffer(spl_image->entry_point, (void *)spl_image->entry_point, 1,
diff --git a/common/bloblist.c b/common/bloblist.c
index fb86789df42..6640ad1fd69 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -512,7 +512,7 @@ int bloblist_init(void)
 	 */
 	bool from_boot_arg = fixed && xpl_is_first_phase();
 
-	if (spl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
+	if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
 		from_addr = false;
 	if (fixed)
 		addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
diff --git a/common/spl/spl.c b/common/spl/spl.c
index a0de495e529..a221b64f81d 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -176,10 +176,10 @@ ulong spl_get_image_pos(void)
 		return BINMAN_SYM_MISSING;
 
 #ifdef CONFIG_VPL
-	if (spl_next_phase() == PHASE_VPL)
+	if (xpl_next_phase() == PHASE_VPL)
 		return binman_sym(ulong, u_boot_vpl_any, image_pos);
 #endif
-	return spl_next_phase() == PHASE_SPL ?
+	return xpl_next_phase() == PHASE_SPL ?
 		binman_sym(ulong, u_boot_spl_any, image_pos) :
 		binman_sym(ulong, u_boot_any, image_pos);
 }
@@ -190,10 +190,10 @@ ulong spl_get_image_size(void)
 		return BINMAN_SYM_MISSING;
 
 #ifdef CONFIG_VPL
-	if (spl_next_phase() == PHASE_VPL)
+	if (xpl_next_phase() == PHASE_VPL)
 		return binman_sym(ulong, u_boot_vpl_any, size);
 #endif
-	return spl_next_phase() == PHASE_SPL ?
+	return xpl_next_phase() == PHASE_SPL ?
 		binman_sym(ulong, u_boot_spl_any, size) :
 		binman_sym(ulong, u_boot_any, size);
 }
@@ -201,10 +201,10 @@ ulong spl_get_image_size(void)
 ulong spl_get_image_text_base(void)
 {
 #ifdef CONFIG_VPL
-	if (spl_next_phase() == PHASE_VPL)
+	if (xpl_next_phase() == PHASE_VPL)
 		return CONFIG_VPL_TEXT_BASE;
 #endif
-	return spl_next_phase() == PHASE_SPL ? CONFIG_SPL_TEXT_BASE :
+	return xpl_next_phase() == PHASE_SPL ? CONFIG_SPL_TEXT_BASE :
 		CONFIG_TEXT_BASE;
 }
 
@@ -762,7 +762,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 
 	os = spl_image.os;
 	if (os == IH_OS_U_BOOT) {
-		debug("Jumping to %s...\n", spl_phase_name(spl_next_phase()));
+		debug("Jumping to %s...\n", spl_phase_name(xpl_next_phase()));
 	} else if (CONFIG_IS_ENABLED(ATF) && os == IH_OS_ARM_TRUSTED_FIRMWARE) {
 		debug("Jumping to U-Boot via ARM Trusted Firmware\n");
 		spl_fixup_fdt(spl_image_fdt_addr(&spl_image));
diff --git a/include/spl.h b/include/spl.h
index 3281b02d63b..dfa56e49c53 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -155,12 +155,12 @@ static inline bool is_xpl(void)
 }
 
 /**
- * spl_prev_phase() - Figure out the previous U-Boot phase
+ * xpl_prev_phase() - Figure out the previous U-Boot phase
  *
  * Return: the previous phase from this one, e.g. if called in SPL this returns
  *	PHASE_TPL, if TPL is enabled
  */
-static inline enum xpl_phase_t spl_prev_phase(void)
+static inline enum xpl_phase_t xpl_prev_phase(void)
 {
 #ifdef CONFIG_TPL_BUILD
 	return PHASE_NONE;
@@ -177,12 +177,12 @@ static inline enum xpl_phase_t spl_prev_phase(void)
 }
 
 /**
- * spl_next_phase() - Figure out the next U-Boot phase
+ * xpl_next_phase() - Figure out the next U-Boot phase
  *
  * Return: the next phase from this one, e.g. if called in TPL this returns
  *	PHASE_SPL
  */
-static inline enum xpl_phase_t spl_next_phase(void)
+static inline enum xpl_phase_t xpl_next_phase(void)
 {
 #ifdef CONFIG_TPL_BUILD
 	return IS_ENABLED(CONFIG_VPL) ? PHASE_VPL : PHASE_SPL;
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index cdc2edbd61e..b2d38795a48 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1676,7 +1676,7 @@ int fdtdec_setup(void)
 	 * not whether this phase creates one.
 	 */
 	if (CONFIG_IS_ENABLED(BLOBLIST) &&
-	    (spl_prev_phase() != PHASE_TPL ||
+	    (xpl_prev_phase() != PHASE_TPL ||
 	     !IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
 		ret = bloblist_maybe_init();
 		if (!ret) {
-- 
2.43.0

