Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92165CF6498
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 01:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54F6F88F63;
	Mon, 30 Sep 2024 03:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hrQGz4Gv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DBC788EF7; Mon, 30 Sep 2024 03:51:04 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12B4E88E1B
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-82cd869453eso135127939f.0
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661019; x=1728265819; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/JpRt6yBhYpY1EpfqR3g4IXA66Q2MB64XuGZuEbk3o=;
 b=hrQGz4GvcbOkcAfqGwl6zV2hFaEn6ZZGQdbGPthOQWGjvFW8mJEDvu7To+9XFzJ69l
 xvOKZfgR/r28GevFUMGfTP41s1c01aj/hhse8wvi+Y3UgGQCvIlfmkMpIXyLF5knxbVd
 tfPZRTrWUkouMxbyR+JcAIKtGtuUyq1Y0B/TM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661019; x=1728265819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2/JpRt6yBhYpY1EpfqR3g4IXA66Q2MB64XuGZuEbk3o=;
 b=Usg9o+ztsY2nxXJYGA20WuXgxHnInAP3La10BHn2L8DJ3PTXRWO2mfBrohijV2BaRu
 QLKbykQciYqmiOZEfBUdQ9WlrVejVRYCM3qQdsZMsvhLjMgcRFY77fzJstowM+3fIOzo
 PX7wq1SXBiBf9APb7iJtbIlBxARY/Hrm/Qa3cUgHDB0O8R9L05fjliSFGC0xwoLOF1Xb
 ZLRZwHBeiJ0LyYYESa1N3tK+lbmBxPTRVcf6ywe10Tmyu7WC1CAl1gpWd0ToM/9Z6113
 raeXj8I0L1R4nZOFW+SOsc6fRgSnvBtFG0ThiHPGtvXEwKEy+rDzZPJF4HWdMQTzGaW7
 74zw==
X-Gm-Message-State: AOJu0YwzMzyyat9xJ0ADCRsY36Hv/GbdbOHUqVnG71Q1DMM7YvxM3rNg
 l5d2oxaPFCaRRB/1AdqdCRt2e1GHRsv4EFkuxRv/QvxqHxMBzkrp3jEi2nTcSd7hOia+vQgQ1en
 /pQ==
X-Google-Smtp-Source: AGHT+IHqvGd/4ccyGxss2wq0oEcW3WSgNT3O5x9MPzbn5JwyP/aZ1TdM2iCE4Ahjpqv/i4WCvtWRNA==
X-Received: by 2002:a92:cd88:0:b0:3a1:d180:15b4 with SMTP id
 e9e14a558f8ab-3a3451b4bbamr67442745ab.23.1727661018612; 
 Sun, 29 Sep 2024 18:50:18 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:18 -0700 (PDT)
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
Subject: [PATCH v3 11/33] xpl: Rename u_boot_first_phase to
 xpl_is_first_phase()
Date: Sun, 29 Sep 2024 19:49:34 -0600
Message-Id: <20240930014956.1434060-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
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

Tidy up the function comment to mention VPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Don't update to use SPL_BUILD in the SPL check

 arch/arm/mach-omap2/am33xx/board.c |  2 +-
 common/bloblist.c                  |  4 ++--
 common/spl/spl.c                   |  4 ++--
 include/spl.h                      | 14 ++++++++------
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index abdc1e40335..548d6b7cfe4 100644
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
index c13b2b8f714..9c3bba48251 100644
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
index de808ccd413..fa87d865f5f 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -34,18 +34,20 @@ struct spl_boot_device;
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
-- 
2.34.1

