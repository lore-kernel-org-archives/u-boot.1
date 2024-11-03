Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0A3E67819
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:37:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60E428880B;
	Sun,  3 Nov 2024 01:37:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y460WEBs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A90C88C86; Sun,  3 Nov 2024 01:37:31 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45FF8887D1
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:37:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20c714cd9c8so31825925ad.0
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730594247; x=1731199047; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QHcwj0rObk3fxVh33XzqEPzdZsBSzjoKUA3Y30a3bIY=;
 b=Y460WEBshNevHK0bqxUzXX+Xcr+Jv5AqLXNbGUCrgfdin4SwoHce5AjOo78RvScR/3
 +WfYwLlNagvLQXsEujfUlT0DL+EVLwSgu0Zj9mv4Rf5tRKu9UeTirH5Sg3azdaSONZDr
 WvT57DLgaDiFOg7tJ9nm1ZTgfwLVCiM/6QfQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730594247; x=1731199047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHcwj0rObk3fxVh33XzqEPzdZsBSzjoKUA3Y30a3bIY=;
 b=C30PcLcysEOLwlD8x/HKhkddtyyJjguOn9eSHyKi3ehw+I3SWRLDIW0g8CyU3/4VjJ
 MiVEuAIG7wfr3UK2MWtZC0jEGxjl93Wi6LMwm36jndkeqjJzu+MFIIf/Wyqti5DowvMT
 xAy53e5uqB/MjMRq+oW8fqEZy6zVzxUhRD8Z3VjVTripBcIUJOLgGgvwZ3r+n6i2E0YS
 jLYkbefOBk70qZkvor7B7S0LY8i1rdwurd6fEC5TCIx2ZWHzbINNEhhLsBKqVR865qQj
 lu+v32i6mtgxGImGjSRc+gq5b8UcJEfD66s4AbUjJYUc4qz5sOIg5PnfqX8HcdKonReo
 Ckig==
X-Gm-Message-State: AOJu0Yyr2yOscOBcuTN7Kz8cKnRiXqY74A1UR2rTJST3bVtEiIyYsH/k
 /lh/JSTgWY/VMt5BHibHtt5YDQHFI5HdHyXZ14JWSO8yNMPN8vU7DDCAfHcAvuwpAkMW1zGQ6mi
 6zA==
X-Google-Smtp-Source: AGHT+IE9uohMwwpdzPYikLK/+0kyHT4PvfvCh0FFZDfTtbQk6IDE5kxjAYuspXrdcJXjZvwTccS4Bw==
X-Received: by 2002:a17:903:187:b0:211:31ac:89eb with SMTP id
 d9443c01a7336-21131ac8e59mr49756525ad.11.1730594246763; 
 Sat, 02 Nov 2024 17:37:26 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a63f2sm38987995ad.168.2024.11.02.17.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:37:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andy Fleming <afleming@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mario Six <mario.six@gdsys.cc>, Priyanka Jain <priyanka.jain@nxp.com>,
 Stefan Roese <sr@denx.de>, Wolfgang Denk <wd@denx.de>
Subject: [PATCH v3 16/25] powerpc: Drop status-LED code
Date: Sat,  2 Nov 2024 18:33:08 -0600
Message-ID: <20241103003322.626036-17-sjg@chromium.org>
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

 arch/powerpc/lib/interrupts.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/lib/interrupts.c b/arch/powerpc/lib/interrupts.c
index 46208ae4c71..a2e7101a9d1 100644
--- a/arch/powerpc/lib/interrupts.c
+++ b/arch/powerpc/lib/interrupts.c
@@ -11,9 +11,6 @@
 #include <irq_func.h>
 #include <asm/processor.h>
 #include <watchdog.h>
-#ifdef CONFIG_LED_STATUS
-#include <status_led.h>
-#endif
 #include <asm/ptrace.h>
 
 #ifndef CONFIG_MPC83XX_TIMER
@@ -83,9 +80,6 @@ void timer_interrupt(struct pt_regs *regs)
 		schedule();
 #endif    /* CONFIG_WATCHDOG || CONFIG_HW_WATCHDOG */
 
-#ifdef CONFIG_LED_STATUS
-	status_led_tick(timestamp);
-#endif /* CONFIG_LED_STATUS */
 }
 
 ulong get_timer (ulong base)
-- 
2.43.0

