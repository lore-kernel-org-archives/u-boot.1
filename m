Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D18DC3600C
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 02:36:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 920CD826AD;
	Fri,  4 Apr 2025 04:36:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eSF0qsI3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BD5E8283E; Fri,  4 Apr 2025 04:36:52 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61D5E8215B
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 04:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22403cbb47fso16833415ad.0
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 19:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743734209; x=1744339009; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=j6UyIH3LeNIk/LEDt2vePTIHuctsWG730L4a2VFglEk=;
 b=eSF0qsI3kAP33nMoYqb+2xAa3ISgfSrLecN5WrdNLgkB6oA2x2G0tJ5jIywl/XIhzc
 1T1tiPSDFUokeesKasHAkEFBYJohnMvEGsmKO1FwAG7CDZ1gj9vEcjhGD0OUZN0/7/HJ
 XpJqqjbkxNOUR1y523vzMP8Vp85f947E1w51uHCdw65GDGALfKnK7hcy23vNZWlzTBrX
 jjja7PDohAI5MF/BZvWRZE8TreWqOSkctuNU1/x6IHCuFF6guS9drLUWQdeggp32oceL
 mOor44+eDiqEW4MN9YR9KK9k1J19P7SxkmAAKKeBBpBnXdIvNw5FfLDd0hcBewnQTx2r
 NtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743734209; x=1744339009;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j6UyIH3LeNIk/LEDt2vePTIHuctsWG730L4a2VFglEk=;
 b=FbBi6GUcK/3VGMxnq5apYs7wfBfnWS85l1Yuu3oU/o4CX5p2qe2kWn9V+Msz+I94go
 gAX7TF492XASM0SVyGZ8ZauF6CmOgk6fpZnIKhB8eKxusa7XQSPkeG20T2ND2mVRK1m+
 wuykyeWKDEKB+GirgkIAos+xrjD4/OJ9ljkKdgs5FJ6iIZ6nocqlvWL/QbhgBSP97bdy
 tQVkZxxcueD5SmJVtp0CdAA0pS9hoh8fF/MmBh3GWtU272Dp7Gibgeo93+BcjtYYlsAo
 lEPi68S0ALgTJP32T3NDB9mEdxbe2N3GeA46axksYUb9Rk+LH4xtjDSzBa873Hs+mNNX
 6EMw==
X-Gm-Message-State: AOJu0Yxw/g2sIsA225OWYlEHJDFShefDfcpYLb0LAjPJ+5D9uepFIq3N
 tWHwKh5h6m28Bbp2r3zTZGNF6vck2bMrFnN3mFKoedKFdc0Ot8co
X-Gm-Gg: ASbGncvROfxYjRfU1kYBWRtIdfzAQbp9SNVQhEI3kRP0Sv3qAN8mcvyakIY1y7ltrqh
 RokA3YAD+4KD22NbYmZ6NI6KFlvZOz+mjfSp2VjgQozNFBtYqgg0zXXTK7mNOnpOwBaaXp78GSv
 NT9+5pG9SzBLI4y905Y+IDINTPMql8uNpaiFeGpy74cMh07o187XvRWNwC4QrSJ22tQOXBO+XD6
 hAg4nb4RL2LzO82vggd3+zurEQ1qbm3yHFvKZ9qNbmIYstqxteqr/RE6ldT86l/2uW2hXAHpf4c
 LKZSv7DGGShqx3iMoId+W0wsGoXtp76mqIO6CpRwC5kGbbBvMLmCBa9oxfc=
X-Google-Smtp-Source: AGHT+IEKd+6coeird0ZZjdOVQ4tGzB5DfaWoCwm9h16VxVuYFZg+M0z5ANRYaCwdaJjoqOCj6zmq/w==
X-Received: by 2002:a17:903:234a:b0:227:e74a:a066 with SMTP id
 d9443c01a7336-22a8a87e97dmr19091065ad.28.1743734208713; 
 Thu, 03 Apr 2025 19:36:48 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:41db:8c39:3e63:1344])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22978670dbbsm21664595ad.209.2025.04.03.19.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 19:36:47 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: eugen.hristev@linaro.org
Cc: u-boot@lists.denx.de, trini@konsulko.com, Fabio Estevam <festevam@denx.de>
Subject: [PATCH] board: atmel: sama5d2_wlsom1_ek: Fix spurious serial output
Date: Thu,  3 Apr 2025 23:36:42 -0300
Message-Id: <20250404023642.3793338-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Fabio Estevam <festevam@denx.de>

Currently, there are always some spurious characters showing up
right before SPL banner is shown:

RomBOOT
���=������
U-Boot SPL 2025.04-rc5-00023-g9ed4e2c45f25 (Apr 03 2025 - 23:23:17 -0300)
Trying to boot from MMC1

<debug_uart>
...

Fix this problem by removing the redundant UART iomux and clock
initialization from the board code, as they are handled by DM code.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
index 04de1257eca0..a0ecc4f42a90 100644
--- a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
+++ b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
@@ -41,17 +41,8 @@ int board_late_init(void)
 #endif
 
 #ifdef CONFIG_DEBUG_UART_BOARD_INIT
-static void board_uart0_hw_init(void)
-{
-	atmel_pio4_set_c_periph(AT91_PIO_PORTB, 26, ATMEL_PIO_PUEN_MASK);	/* URXD0 */
-	atmel_pio4_set_c_periph(AT91_PIO_PORTB, 27, 0);				/* UTXD0 */
-
-	at91_periph_clk_enable(ATMEL_ID_UART0);
-}
-
 void board_debug_uart_init(void)
 {
-	board_uart0_hw_init();
 }
 #endif
 
-- 
2.34.1

