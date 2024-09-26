Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E468CDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:51:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6B1E88E4B;
	Thu, 26 Sep 2024 22:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YYJ3e4jv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBA8988E3E; Thu, 26 Sep 2024 22:51:31 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74DB288E43
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cb399056b4so4386396d6.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727383888; x=1727988688; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3VjJ4FKevZHLcIkmt/wZwI4V2QmD0Y653BXMzov5z0Q=;
 b=YYJ3e4jv3pHa20d+pzu+XaDm4D2aVPA3nwS8DiLHa+3idWis7Ia/H7uA6vjrQPP80M
 IEoucVYTll+TE/J+bvUDVYqC9XZc0HuvOAanz+FX/aXyokgQHsudBgh/CmM1uBoTgFD5
 xYQbJ8ydkW1rBuDRbK5tDs1pAZCmpWEznt/pE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727383888; x=1727988688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3VjJ4FKevZHLcIkmt/wZwI4V2QmD0Y653BXMzov5z0Q=;
 b=Ik7iPST3X+XiBc8pMXcSLZWsn9xUkjNF+A0mGo5iIhUnPaEIew81TWAtE6QvYRlg7b
 /Jf2R9MfeMs+NHyDXUroUY3VolLF2K34ASYp11xbWapeJwP9m4BZpkYK2ZzJ09cgigLj
 SH/NPHXeZqUkkojJksMf2EFx8tMMue2jHsmLQicOeYLyk3mcsX1xVGJ4IhwA9o7YoUN0
 XNS6VXST43stIXCdS7alkruKTI6tPRJaZWY267UC2dy+TsOqzQOrWOBfexJgVF2ETjr3
 dwQI49HRmxTxcNbDj0NbmE7m42sWhPKvg2+tw0kEqhUgxBxRm7ywG1pG7mQEIXYeaeRE
 i9kg==
X-Gm-Message-State: AOJu0YyXVtDc4h2K6ebZbMpowYqSny+l3haRvtpdKZg9c1/JM5AXQmUH
 0U1IBlSxHJ6Xbf0hdZbNKAu2tDg0S2yZqcOopqQ5vVYWb1+3q3oVnvTMVv1HRW7va23sKNeD0vv
 r8+IUf+Q=
X-Google-Smtp-Source: AGHT+IGRwHDj3DX/2oKYvvXUZsIoJxS/4bVLBjV0hIudmD1C0coXhiy8eXiYeBaD2oEntQq5TZZtpA==
X-Received: by 2002:a05:6214:450f:b0:6c5:ba8f:a964 with SMTP id
 6a1803df08f44-6cb3b5c5658mr18156686d6.10.1727383888220; 
 Thu, 26 Sep 2024 13:51:28 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:51:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andy Fleming <afleming@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mario Six <mario.six@gdsys.cc>, Priyanka Jain <priyanka.jain@nxp.com>,
 Stefan Roese <sr@denx.de>, Wolfgang Denk <wd@denx.de>
Subject: [PATCH 16/27] powerpc: Drop status-LED code
Date: Thu, 26 Sep 2024 22:44:36 +0200
Message-ID: <20240926204455.963584-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926204455.963584-1-sjg@chromium.org>
References: <20240926204455.963584-1-sjg@chromium.org>
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

