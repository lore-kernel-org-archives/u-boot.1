Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9E3CF6491
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 20:03:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84EF188DCC;
	Sat, 28 Sep 2024 22:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RNwBdT/i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2A8D88D6B; Sat, 28 Sep 2024 22:01:17 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7534488CB8
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:01:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-82aa3f65864so141369539f.2
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 13:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727553668; x=1728158468; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptvED6tTPvdHTmCEGnlXz4VwLZwjkDAp8C5cRKaPyls=;
 b=RNwBdT/ibvTA4cCWNVNMh8gW/KQyKH4H4Y1pj9xM96rqEOc1w3+0515BDBpNJgAnLH
 DhZHnHkXd57fz1NRwNwYdphDpQcv5rICrzh1pzBgAk5ldK8i3x7G7dosfvjMbicsW9oT
 iWY/vbKNDbRaRlB0GnGnz9kN7+7dbz6ndh6Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727553668; x=1728158468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ptvED6tTPvdHTmCEGnlXz4VwLZwjkDAp8C5cRKaPyls=;
 b=hPM62wx31SDKXmtUKOtq8H1pvP54agIrbr/ZZxQyl19sCWbL9UF+xQ8klnUBaOLAy+
 tFwS+IM7u69y3y5MdBoSlhF3qhjAGgbz/Hl1KBha9gohg2ZCR5uK9dTrllW8DJBjidCK
 /iVu6WwLoBuCKOnGRDnmXnNxMB0ZFQr/74i2aIeQhdW4TKZrmYLClf9GQuU1w+dIzFUG
 h6YSVAbUOk5fnKPfNMkEe3dQ2eJ0w8POHtcOJMZUEf4s30VgYjAFzZkslSSEil4IWsa+
 7e1TpMoEMD+AHJ2qe/w7scXVZGZNF5vsMxHF5/i9CD7btQQdVy1E0VpnXVF9nbNMeXg1
 zi9g==
X-Gm-Message-State: AOJu0YzAfQ6AeY5c3t61Gemw68QZioT/PdiLc8htrOiFyTOPIeCyB6An
 XYF8s7cSzgy8sF5cKDUUOFuNK2vI+64gjA3c1+HzGZ9qtcntfYLm4TAKOhftRW2J0mDXbks09Os
 jVw==
X-Google-Smtp-Source: AGHT+IGrIcnRfvpkwGnzCSQU70WRJ6TAL03Kr2oy3SiW3pUGhPqqtwAuR7PBpeIHDHQDQiC2We4JbA==
X-Received: by 2002:a92:ca0c:0:b0:3a0:533e:3c0a with SMTP id
 e9e14a558f8ab-3a345165300mr70237495ab.7.1727553668135; 
 Sat, 28 Sep 2024 13:01:08 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888835307sm1242590173.2.2024.09.28.13.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 13:01:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Nishanth Menon <nm@ti.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 21/30] xpl: Rename u_boot_first_phase to
 xpl_is_first_phase()
Date: Sat, 28 Sep 2024 14:00:21 -0600
Message-Id: <20240928200030.194546-22-sjg@chromium.org>
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

This is a better name for this function, so update it.

Tidy up the function comment to mention VPL. Use SPL_BUILD in the SPL
check, for clarity.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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
index fec5677c7a9..01057ee103e 100644
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
2.34.1

