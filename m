Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0E5CF6493
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 20:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9565B88CC1;
	Sat, 28 Sep 2024 22:01:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SzlllPyu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D185188DAA; Sat, 28 Sep 2024 22:01:23 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D68888A1E
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a1a3090f93so10785585ab.1
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 13:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727553675; x=1728158475; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zcPITtsUMO5L6lRAossaSaaqAcYXL4hltOZ731c5vuk=;
 b=SzlllPyuh5aV7nTnpTaFGcTPyTU1LdrTWn0wLGRsQY5zT3hkFJU8dX7hDt78vKnp5i
 NkmiKPowWYXr1LFhyM0yS2uVxeQobVjBLPH+OTE1lUvKeVbY+/0nVOPGHpdE/KSkatZW
 /CiClaeIawj2H2HA7yqg31oq8YeISIUji2C5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727553675; x=1728158475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zcPITtsUMO5L6lRAossaSaaqAcYXL4hltOZ731c5vuk=;
 b=sxk926/qCmstl2+tkT7CScqBHABXjeY9ZeLB7g+kEJZCzL1GsRCd0h1y9aXBesWCts
 3HR5+WTTL1Vx3bpotwHdrWA6oW0DeGz/c/012fMHXFdoLgOot9yDloRcrwHi8TmJJhPi
 JpRECBg8ESqKPHwMXDNlHztJU8Q0Kos66pm6RxwYaY6EIa6EAyBwmfgg+RroegP9y2mY
 hph7NUlFtXfSi4e+r2CjN6WhUq3378Sbg2HstEZ1bdcylMquRQUvAdlW3NiXV7b2bgIB
 p+BFpBE5AZibBivXfE01T7Lext5GBygV7Pol7kPaaIeCpZB+mKcNfnS1IcrbGNKKJF3z
 y9AA==
X-Gm-Message-State: AOJu0YwwTCjsPzgtDvrkDmo0xWk0YXReGBrwzD7/lBa9lFpT3Gja/glW
 1ssR3Dq6viwo/NijOReKp64q6GEgUUFXSYqXrqh5rt4xNJjsU7CTfaWTkn0iaSkp7yXpKNb5uV9
 weg==
X-Google-Smtp-Source: AGHT+IHDB9gvnxN9/fiC7NonPJNOUdbx/NIBB/K+N6V5mUH4uUFnVFDh8tMGmYSlPkxXXNhuYiy7QA==
X-Received: by 2002:a05:6e02:12ee:b0:3a0:4250:165f with SMTP id
 e9e14a558f8ab-3a344fce47emr72654275ab.0.1727553674769; 
 Sat, 28 Sep 2024 13:01:14 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888835307sm1242590173.2.2024.09.28.13.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 13:01:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 26/30] xpl: Rename spl_next_phase() and spl_prev_phase()
Date: Sat, 28 Sep 2024 14:00:26 -0600
Message-Id: <20240928200030.194546-27-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928200030.194546-1-sjg@chromium.org>
References: <20240928200030.194546-1-sjg@chromium.org>
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

(no changes since v1)

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
index f90c3f56329..d66c6cdd24a 100644
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
2.34.1

