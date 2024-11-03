Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB7AE67819
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE55288C86;
	Sun,  3 Nov 2024 01:38:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n9I55pMh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3EC18930D; Sun,  3 Nov 2024 01:38:39 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9663489157
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:38:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20cb47387ceso29994725ad.1
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730594315; x=1731199115; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZzOaX3V6RF9iODDAdcA59OWl/P+shVJvLGGKdn0P6k=;
 b=n9I55pMhEQwc7ZzgvQLc81WlX1rCRv/LNUn9A0fSp8nMh4B2E2Vd08n5UK8Qps+x0y
 FdI4Jbj59Z0AEMyz3g/7Rc5oLCJtMdE7qW+jGivrryCcAhUSWCCvX09b2mMsGLY/hKgw
 GcgByz192Trp8cqhAWsATTjc2Dta1aiVG0l7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730594315; x=1731199115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fZzOaX3V6RF9iODDAdcA59OWl/P+shVJvLGGKdn0P6k=;
 b=FesQ/jkiN/IOO0sDQWRCgnYcrOLfwA/oTQTjGEAzcY9bzwTlJcNPO4vuTeNsrx5zkB
 X/LXdoDicHns/LEBA7D4K9y9jL28f+9IWZpGyoD96CPAsfWOHbXTb5W8gumZMrZL8B32
 F6U6kImDpwQvnU4iw1mwyPizm8U1b6suapVV1b1KFE1lRXgEHA5JxTuR80lOdLFS+GC0
 WLZ0xWknfF6BhkTRo+hK/MTsuK9gtKduCTc87dnB4RY5BwFQ6klSdm0InBLi8ZoQGyFK
 Hed4sPoKX6ooqblHFSmWV5or+M5kA8nn4mQYJPVfoYfzYJts0v3XtJAe4Ch5dVGqfz0u
 79Pw==
X-Gm-Message-State: AOJu0Yz7bPrkIlkQGrXr+VRl7e/W0IDmD1oF7ASDczqC1/7w/FyJBy/F
 0PfZRZod6JaMxDDQhQdV/BjCv/rKvXOcNAyG1P4Q04j4dWp5nrvImqAFgaJXklkEbAKP9xh7YRJ
 ULQ==
X-Google-Smtp-Source: AGHT+IG/ctB8f7abcWxSRSdaGtsNjWdacsUHphiSGPbi20YRhZEc4SCX4/2r2E5qpG6ELm6LEcAl1g==
X-Received: by 2002:a17:902:db0f:b0:20c:cf39:fe3c with SMTP id
 d9443c01a7336-210c6c34824mr388085745ad.41.1730594315503; 
 Sat, 02 Nov 2024 17:38:35 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a63f2sm38987995ad.168.2024.11.02.17.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:38:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>
Subject: [PATCH v3 22/25] mpc83xx: Drop status-LED code
Date: Sat,  2 Nov 2024 18:33:14 -0600
Message-ID: <20241103003322.626036-23-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241103003322.626036-1-sjg@chromium.org>
References: <20241103003322.626036-1-sjg@chromium.org>
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

This is not used anymore, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/timer/mpc83xx_timer.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/timer/mpc83xx_timer.c b/drivers/timer/mpc83xx_timer.c
index 9da74479aaa..aefc18898e9 100644
--- a/drivers/timer/mpc83xx_timer.c
+++ b/drivers/timer/mpc83xx_timer.c
@@ -9,7 +9,6 @@
 #include <dm.h>
 #include <irq_func.h>
 #include <log.h>
-#include <status_led.h>
 #include <sysinfo.h>
 #include <time.h>
 #include <timer.h>
@@ -178,10 +177,6 @@ void timer_interrupt(struct pt_regs *regs)
 	if (CFG_SYS_WATCHDOG_FREQ && (priv->timestamp % (CFG_SYS_WATCHDOG_FREQ)) == 0)
 		schedule();
 #endif    /* CONFIG_WATCHDOG || CONFIG_HW_WATCHDOG */
-
-#ifdef CONFIG_LED_STATUS
-	status_led_tick(priv->timestamp);
-#endif /* CONFIG_LED_STATUS */
 }
 
 void wait_ticks(ulong ticks)
-- 
2.43.0

