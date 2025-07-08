Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FABC8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 10:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E66B6832AD;
	Tue,  8 Jul 2025 12:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HWLyk2Xf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2246480194; Tue,  8 Jul 2025 12:03:55 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30DF280194
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 12:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a4f72cba73so3299894f8f.1
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 03:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751969032; x=1752573832; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5z565siWBMF1rwJIQprDIX8z4UErWUJ/iYorCu5nr/k=;
 b=HWLyk2XfFMHMsPQKC8MPhzrK9jmWzriVOhfkC53WQd7QSuEchkG7Y/OEhXI8F6qJKf
 07/jvqw6vfHasvGcicJjXK+NR1dGmaW8fyVGNIkTSTc5HJMoxAnSpk7ns0qfKf+fTY9w
 mzBJdYRk+lFcEKevF5zSzD3fDj9RUjNzLIHqRlr1P8S6rDFy5+BzAjE3cL+GUJuKUrcR
 ttSvVMvLCFUIrO5n71+obtExVlBRifCbtdX7exheM4GtW2MBZCEj1eWiXkFurXPPTDl5
 xULJwxp3vkMRHsp9v+IV3KmyNVJ29WLR70dqmeNf2pnHIUGdEkvVM8+6mgAS45pnbrsY
 nTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751969032; x=1752573832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5z565siWBMF1rwJIQprDIX8z4UErWUJ/iYorCu5nr/k=;
 b=hVpLnPXdM7/MqZ0219NphLhqxllzeg8it0D0NAfr6OWhgnAir1FLI61gF9RYN1AwBX
 lqwp+2gmIIz+s+mUJCdKdvT48Tnu998SKd+QIyjlySI9dZlsyQrJiS/qn4XYaGFP1dzg
 6w8VirnIxC76n1Y3ZA3rUa7rBFH2oWBK4ChleSIOncuBLwhV0e1n85PmOBv4R5Hn1+bd
 +FHTK9tN49trbUy6qzrfsSHj238cPA1z7/tTrE7Fe1ze8gg8VtuyfhVlr+juM0wb/sMs
 la53EDUVNn3LrYZhtIg9P9uOiFLZuUMU3BAzGvQ6WwMlG9MySMx2MybJY9oC7OFyGe3Y
 iYsw==
X-Gm-Message-State: AOJu0YzN8sPRxIbo3N+TKQ9LnMSHPV9neFeez1+AtfqJTm/aOiGe4FqU
 NUoOuvpE26gNYql8l3I7bitJJaXZcAk58MLvSVJK9izNnI/7vXM6iGUu9CbGoI9Tp83sNOvGW9b
 KW3KUexqvRg==
X-Gm-Gg: ASbGncvqO6kJCuxRpNUGbEgvOLAZhnk1RURU3j6t43v+AxG3jVo/0xoGqBz8V+aBZk4
 8FIqYgTFyCF/Aym8l6ZRa/ZXrbqPs7hfkRP6+zO2e6/VHxGJiApD6DSBSxdQVLz8Qy9NxiyT2UX
 SAC1SaPOL+pzwaQBayrSR3c2LEqNY/6l4tPCsMi37wIhT3plI1SiT5Ne30IOnzDX8HNYX1ddw4S
 TJtIAy5PZrOkHorPR0Aj2WRpQR2ws1scHeWR4ZyyM+uNbWR6Jz1AWeqq9ekzHZPA2Yg0uyeZLG6
 hxcmD6sZeGxRB0Ff/nYuzSYY9+uNSqqgtKvVpFiqJToubJM4bojh7MACDvB4iSIhW0CTQA==
X-Google-Smtp-Source: AGHT+IHAhzUQ3mqDES6VQaFwDBYTm9wI6GV3YPKRuLyoQrnbPiA3zYIz+9+/D/uyujEoLrt5dZ2MEw==
X-Received: by 2002:a05:6000:642:b0:3a5:5130:1c71 with SMTP id
 ffacd0b85a97d-3b5de07c950mr1841313f8f.0.1751969032257; 
 Tue, 08 Jul 2025 03:03:52 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:fc4b:50ea:edb:b51a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47225afd4sm12302261f8f.83.2025.07.08.03.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 03:03:51 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 3/4] arm: do not force -marm on some C files and allow LTO
 everywhere
Date: Tue,  8 Jul 2025 12:02:49 +0200
Message-ID: <20250708100322.2153533-4-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708100322.2153533-1-jerome.forissier@linaro.org>
References: <20250708100322.2153533-1-jerome.forissier@linaro.org>
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

Now that CP15 instructions are not inline assembly anymore, there is no
obstacle to building all C files in Thumb mode if desired, and having
LTO enabled as well.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 arch/arm/cpu/arm926ejs/Makefile | 5 -----
 arch/arm/cpu/arm926ejs/cpu.c    | 3 ++-
 arch/arm/lib/Makefile           | 8 --------
 arch/arm/mach-kirkwood/Makefile | 7 -------
 common/Makefile                 | 4 ----
 5 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/arch/arm/cpu/arm926ejs/Makefile b/arch/arm/cpu/arm926ejs/Makefile
index 1b40d901413..0021722f6f3 100644
--- a/arch/arm/cpu/arm926ejs/Makefile
+++ b/arch/arm/cpu/arm926ejs/Makefile
@@ -20,11 +20,6 @@ obj-$(CONFIG_ARCH_SUNXI) += sunxi/
 ifdef CONFIG_$(PHASE_)SYS_THUMB_BUILD
 ifndef CONFIG_HAS_THUMB2
 
-CFLAGS_cpu.o := -marm
-CFLAGS_cache.o := -marm
-CFLAGS_REMOVE_cpu.o := $(LTO_CFLAGS)
-CFLAGS_REMOVE_cache.o := $(LTO_CFLAGS)
-
 AFLAGS_REMOVE_cp15.o := -mthumb -mthumb-interwork
 
 endif
diff --git a/arch/arm/cpu/arm926ejs/cpu.c b/arch/arm/cpu/arm926ejs/cpu.c
index 9e59ff6c66f..e57f54181c4 100644
--- a/arch/arm/cpu/arm926ejs/cpu.c
+++ b/arch/arm/cpu/arm926ejs/cpu.c
@@ -29,7 +29,8 @@ static void cache_flush(void);
  *************************************************************/
 void sdelay(unsigned long loops)
 {
-	__asm__ volatile ("1:\n" "subs %0, %1, #1\n"
+	__asm__ volatile (".syntax unified\n"
+			  "1:\n" "subs %0, %1, #1\n"
 			  "bne 1b":"=r" (loops):"0"(loops));
 }
 
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 23f73dbba32..136ecf5267e 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -80,7 +80,6 @@ endif
 
 obj-y	+= cache.o
 obj-$(CONFIG_SYS_ARM_CACHE_CP15)	+= cache-cp15.o
-CFLAGS_REMOVE_cache-cp15.o := $(LTO_CFLAGS)
 # Low-level CP15 instructions (mrc p15...) cause problems with LTO
 # when they are coded as inline assembly. They are implemented
 # in their own .S file instead.
@@ -105,13 +104,6 @@ ifdef CONFIG_$(PHASE_)SYS_THUMB_BUILD
 asflags-$(CONFIG_HAS_THUMB2) += -DCONFIG_THUMB2_KERNEL
 ifndef CONFIG_HAS_THUMB2
 
-# for C files, just apend -marm, which will override previous -mthumb*
-
-ifndef CONFIG_ARM64
-CFLAGS_cache.o := -marm
-CFLAGS_cache-cp15.o := -marm
-endif
-
 # For .S, drop -mthumb* and other thumb-related options.
 # CFLAGS_REMOVE_* would not have an effet, so AFLAGS_REMOVE_*
 # was implemented and is used here.
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 9581c315af8..0da110b8d69 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -10,10 +10,3 @@ obj-y	+= cp15.o
 obj-y	+= cache.o
 obj-y	+= lowlevel.o
 obj-y	+= mpp.o
-
-# cpu.o, cpu_asm.o and cache.o contain CP15 instructions which cannot be run in
-# Thumb state, so build them for ARM state even with CONFIG_SYS_THUMB_BUILD
-
-CFLAGS_cpu.o := -marm
-CFLAGS_cpu_asm.o := -marm
-CFLAGS_cache.o := -marm
diff --git a/common/Makefile b/common/Makefile
index e589f307262..35991562a12 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -19,10 +19,6 @@ obj-y += version.o
 # # boards
 obj-y += board_f.o
 obj-y += board_r.o
-ifdef CONFIG_$(PHASE_)SYS_THUMB_BUILD
-CFLAGS_REMOVE_board_f.o := $(LTO_CFLAGS)
-CFLAGS_REMOVE_board_r.o := $(LTO_CFLAGS)
-endif
 obj-$(CONFIG_DISPLAY_BOARDINFO) += board_info.o
 obj-$(CONFIG_DISPLAY_BOARDINFO_LATE) += board_info.o
 
-- 
2.43.0

