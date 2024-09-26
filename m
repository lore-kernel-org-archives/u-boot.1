Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CDCCCFA07
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:45:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 763288900E;
	Fri, 27 Sep 2024 00:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="noEilPvE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB7D188F9B; Fri, 27 Sep 2024 00:45:43 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24CA88901B
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4582fb3822eso9108871cf.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390740; x=1727995540; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6knylI6bdZVSoicYLmZ7yY67DoLnPOfgA55t9r35BUQ=;
 b=noEilPvEu55q4EBc1Bb8MGdh+cOGUBADOLraLU2qYmYoVoom5HLn+JJocBAprxwqGN
 mM2uxQ+XGKbMyJigwCcioTBGiQpZzqQweQL9v57TjiCxLDh2vZTNx+u/ZAOuvnqyyzgD
 SS7yaIN487XBYGGssekCyHRBdNJpkWY+KHdso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390740; x=1727995540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6knylI6bdZVSoicYLmZ7yY67DoLnPOfgA55t9r35BUQ=;
 b=i/honV/6X0P/iUCtsoLU1XrEEENTaZcNWNW7gsUjf3WTpRCYlVfo6bSeIY4/zWr8/l
 rTpk6Cgzk963g4DDE62qDscPDV/qKmbhTRkU+8VYCqtnbt49aZJtaZQteP6vjgdcG8QX
 WdoYdWoa49CNAIFBkp5fYztoZuXkU2nATaJMuGETa0jZ+RB8Q8GowfjRoAxFublwEmd6
 v1GQiCXULTIb8YuNLYsZCQocgthjsIOslzl34ubtVtO0UdXV8420Ds7FOFZiBQCf+uBv
 db7Es3zmboueIwqEyCFAuAEtY1id/9RzANAlXW0g3IYuUAB1sr2+8Pm8vTZbEpO1yvJi
 8ISw==
X-Gm-Message-State: AOJu0Yzh/3/nsk7xM7MRNZPwQ0hBKS8h14ds8Gp8xxOKOsTEpEEndY1u
 xX8MFiEQIidOiZIDvrFU3yJ2wM/JzRjNNBpSn6+KSawIZPwOowc9HUj3tTqKX2QVimV4P+1M0kf
 iSILg70g=
X-Google-Smtp-Source: AGHT+IGOL23KKow0thoep1SEo5QhrF9NI08GoqVgvFs+BbMcDZQuWZWiDPfy1LKkv0msUxPTkuVuxw==
X-Received: by 2002:a05:622a:652:b0:45c:9c5c:388 with SMTP id
 d75a77b69052e-45c9f22fbafmr16469581cf.25.1727390739893; 
 Thu, 26 Sep 2024 15:45:39 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:45:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Nishanth Menon <nm@ti.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 33/42] xpl: Rename u_boot_first_phase to xpl_is_first_phase()
Date: Fri, 27 Sep 2024 00:35:58 +0200
Message-ID: <20240926223814.1276764-34-sjg@chromium.org>
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

This is a better name for this function, so update it.

Tidy up the function comment to mention VPL. Use SPL_BUILD in the SPL
check, for clarity.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/mach-omap2/am33xx/board.c |  2 +-
 common/bloblist.c                  |  4 ++--
 common/spl/spl.c                   |  4 ++--
 include/spl.h                      | 16 +++++++++-------
 4 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index e720fb6b21f..4e9ad8935e3 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -526,7 +526,7 @@ EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, am33xx_dm_post_init);
 #ifdef CONFIG_DEBUG_UART_BOARD_INIT
 void board_debug_uart_init(void)
 {
-	if (u_boot_first_phase()) {
+	if (xpl_is_first_phase()) {
 		hw_data_init();
 		set_uart_mux_conf();
 		setup_early_clocks();
diff --git a/common/bloblist.c b/common/bloblist.c
index 2008ab4d25c..fb86789df42 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -504,13 +504,13 @@ int bloblist_init(void)
 	 * If U-Boot is not in the first phase, an existing bloblist must be
 	 * at a fixed address.
 	 */
-	bool from_addr = fixed && !u_boot_first_phase();
+	bool from_addr = fixed && !xpl_is_first_phase();
 	/*
 	 * If U-Boot is in the first phase that an arch custom routine should
 	 * install the bloblist passed from previous loader to this fixed
 	 * address.
 	 */
-	bool from_boot_arg = fixed && u_boot_first_phase();
+	bool from_boot_arg = fixed && xpl_is_first_phase();
 
 	if (spl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
 		from_addr = false;
diff --git a/common/spl/spl.c b/common/spl/spl.c
index dc73d3aff00..674ab35ede0 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -464,13 +464,13 @@ static int spl_common_init(bool setup_malloc)
 		gd->malloc_ptr = 0;
 	}
 #endif
-	ret = bootstage_init(u_boot_first_phase());
+	ret = bootstage_init(xpl_is_first_phase());
 	if (ret) {
 		debug("%s: Failed to set up bootstage: ret=%d\n", __func__,
 		      ret);
 		return ret;
 	}
-	if (!u_boot_first_phase()) {
+	if (!xpl_is_first_phase()) {
 		ret = bootstage_unstash_default();
 		if (ret)
 			log_debug("Failed to unstash bootstage: ret=%d\n", ret);
diff --git a/include/spl.h b/include/spl.h
index 47666eace91..c313c57f1aa 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -34,24 +34,26 @@ struct spl_boot_device;
 enum boot_device;
 
 /*
- * u_boot_first_phase() - check if this is the first U-Boot phase
+ * xpl_is_first_phase() - check if this is the first U-Boot phase
  *
- * U-Boot has up to three phases: TPL, SPL and U-Boot proper. Depending on the
- * build flags we can determine whether the current build is for the first
+ * U-Boot has up to four phases: TPL, VPL, SPL and U-Boot proper. Depending on
+ * the build flags we can determine whether the current build is for the first
  * phase of U-Boot or not. If there is no SPL, then this is U-Boot proper. If
  * there is SPL but no TPL, the the first phase is SPL. If there is TPL, then
- * it is the first phase.
+ * it is the first phase, etc.
  *
- * @returns true if this is the first phase of U-Boot
+ * Note that VPL can never be the first phase. If it exists, it is loaded from
+ * TPL
  *
+ * Return: true if this is the first phase of U-Boot
  */
-static inline bool u_boot_first_phase(void)
+static inline bool xpl_is_first_phase(void)
 {
 	if (IS_ENABLED(CONFIG_TPL)) {
 		if (IS_ENABLED(CONFIG_TPL_BUILD))
 			return true;
 	} else if (IS_ENABLED(CONFIG_SPL)) {
-		if (IS_ENABLED(CONFIG_XPL_BUILD))
+		if (IS_ENABLED(CONFIG_SPL_BUILD))
 			return true;
 	} else {
 		return true;
-- 
2.43.0

