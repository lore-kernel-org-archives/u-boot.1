Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBD2C2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:31:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B783B8851C;
	Sun, 23 Jun 2024 22:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cW1vgNLP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DBE288387; Sun, 23 Jun 2024 22:30:43 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 773C8883C8
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7eba486df76so108360039f.0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174640; x=1719779440; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mfBAPrVQyw9HTglRcmtpn2r9tm3bxLQG3CM4EjSO9NI=;
 b=cW1vgNLPluYs2c2rnE7LbRUS7kzKqxUcy8bkKdjWYo/YRD50fVfXS+2hcWHklu6ByL
 LxHtijl+pqwQ5avPRGJqO3qBTIeGhxTsc78TXWm+4QnSyTsYAs0ZnOzdEXLKSVyaAPWt
 c2Kd3wpMmp6LTgnMf8T1diCFN/G0ARWLbGi7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174640; x=1719779440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mfBAPrVQyw9HTglRcmtpn2r9tm3bxLQG3CM4EjSO9NI=;
 b=wg2YIYD9lXKdi7t7gAxui9tAoxU2QMExin9bnCG4sgtQxIzEhAqFHnxRQfoL6X3UeB
 C6njkjfUKwZMyFbRjQpKkc8fa8gLVKpFSLbUMw8XGhlUEUKQDoMPZjR+ZLWIu/35Z02o
 8v2qPg51eXm+V74b+crTAsgpYp0bQPHfooT976acLpMRxYee3uS2su6t387lRQhDbOZK
 U0C4Eus4b2TRMYOYDYNvw/qneJSa4Wren6l5x12JZ0o7oCDJZ8MqM6a6f04nZEjfhnTd
 mge+hRcLuu7xc/asmjtdH9cOCsggn8jYQOsfiMwh6aCreVNvTI96uQyZ7aFCJ+Zdq3k6
 SsdQ==
X-Gm-Message-State: AOJu0YzXGkLwD5pXAvc319zE/zS1n4oJnRNzdgx+OTEkcFr3KalGhzq6
 BKjG4Rvk2N/o9GEGFttMaGv3JCBEpWZ8lmGoPp9Mx6lOZf/6GlOPziWS4fS2CIjDQuq82dcbMz7
 Fcw==
X-Google-Smtp-Source: AGHT+IHeo5Ajfx1vtwl21Yv0Uy45uPEU19AMROfA9IFTj8Uz6Xm81hYdC2EqGqQJZbJAce6cXJakbw==
X-Received: by 2002:a92:ca4e:0:b0:375:a3eb:bfcd with SMTP id
 e9e14a558f8ab-37639edb0e5mr18829955ab.8.1719174640095; 
 Sun, 23 Jun 2024 13:30:40 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110ffb6sm1627335173.58.2024.06.23.13.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:30:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Nishanth Menon <nm@ti.com>, Trevor Woerner <twoerner@gmail.com>
Subject: [PATCH 04/14] am33xx: Provide a function to set up the debug UART
Date: Sun, 23 Jun 2024 14:30:23 -0600
Message-Id: <20240623203033.1566505-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623203033.1566505-1-sjg@chromium.org>
References: <20240623203033.1566505-1-sjg@chromium.org>
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

Since commit 0dba45864b2a ("arm: Init the debug UART") the debug UART is
set up in _main() before early_system_init() is called.

Add a suitable board_debug_uart_init() function to set up the UART in
SPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/mach-omap2/am33xx/board.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index 78c1e965c9f..84a60dedd72 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -490,9 +490,6 @@ void early_system_init(void)
 	 */
 	save_omap_boot_params();
 #endif
-#ifdef CONFIG_DEBUG_UART_OMAP
-	debug_uart_init();
-#endif
 
 #ifdef CONFIG_SPL_BUILD
 	spl_early_init();
@@ -533,3 +530,18 @@ static int am33xx_dm_post_init(void)
 	return 0;
 }
 EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, am33xx_dm_post_init);
+
+#ifdef CONFIG_DEBUG_UART_BOARD_INIT
+void board_debug_uart_init(void)
+{
+	if (u_boot_first_phase()) {
+		hw_data_init();
+		set_uart_mux_conf();
+		setup_early_clocks();
+		uart_soft_reset();
+
+		/* avoid uart gibberish by allowing the clocks to settle */
+		mdelay(50);
+	}
+}
+#endif
-- 
2.34.1

