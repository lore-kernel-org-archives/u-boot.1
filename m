Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A871D0E6F9
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4C6789323;
	Mon, 21 Oct 2024 13:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m2B0Rwf7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5385F890D1; Mon, 21 Oct 2024 13:39:14 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D76CB89268
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37d473c4bb6so4027216f8f.3
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510746; x=1730115546; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QHcwj0rObk3fxVh33XzqEPzdZsBSzjoKUA3Y30a3bIY=;
 b=m2B0Rwf7h2UzAu7TPB5WD3U8w+wAeChwskl9UwRU86KFgSZwvTrB0Dc1uLHk2kM6xE
 XJKYFezd+Sz/WmfB/0EB4QqhosMCIqVa9FKpstYsuMUokwZlcPxBsvJXXTtGbs0h/qPz
 ihot41Cofqj2SUPQhW1fZ6DmFH2fq2KGkAi+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510746; x=1730115546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHcwj0rObk3fxVh33XzqEPzdZsBSzjoKUA3Y30a3bIY=;
 b=YHXGLbYNQgI2/9JGKpWKsktHIdistJ05rzPPBT8Ok5znjxREIvUNcsAIkvBCJrZWme
 qndEN3ixm/M9RjeE6hMfiQQMtxxAtXdsWIOawSZaQ2KsiNK77hcF/V9uiO4v0z4gkRZi
 cAKOD1aJHW3CdiDfIB05lwzbFSAo5i8GdnzpiYbFRRfe7BSG8IeIf5dJvPiePdELxIrs
 cLMHUhxYLz5oZh5Nffuraefq7z5QECc4BdAsjqKQocjwwEszWzOQs6HPr5/l0TGHkJBC
 nBHD/0R1rs7XuCi3zvjNtEngf6XIRhmDihMkrMq0DEMZs6s/aSQRjEPBvj8vDjphbAgS
 dfeg==
X-Gm-Message-State: AOJu0YzL94ysdusAq4xGlv53gEJph7d9vS9k0L5uFiKPDUbeu+5Rl+Eg
 OR/p+lHPa+tWaY+pGIpHKsYgKLHuG4XdqsJ2ggwSJ/meQ4JZKdNmKCilGtKnbMl/JjYaMWanSpg
 iBZYL
X-Google-Smtp-Source: AGHT+IEoLBmU/pTILxEkxz5iCd65Rqi+kjrOhU7OrB+QpeMGbvRa0PCz55HRfUEZWEkZqSqgVj3cDw==
X-Received: by 2002:a5d:4d01:0:b0:37c:cc4b:d1d6 with SMTP id
 ffacd0b85a97d-37eab2e3550mr9337189f8f.27.1729510746056; 
 Mon, 21 Oct 2024 04:39:06 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ea5sm191604366b.160.2024.10.21.04.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:39:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andy Fleming <afleming@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mario Six <mario.six@gdsys.cc>, Priyanka Jain <priyanka.jain@nxp.com>,
 Stefan Roese <sr@denx.de>, Wolfgang Denk <wd@denx.de>
Subject: [PATCH v2 17/25] powerpc: Drop status-LED code
Date: Mon, 21 Oct 2024 13:38:25 +0200
Message-ID: <20241021113839.318572-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021113839.318572-1-sjg@chromium.org>
References: <20241021113839.318572-1-sjg@chromium.org>
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

