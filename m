Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B770CDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91D8288E70;
	Thu, 26 Sep 2024 22:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ep02a5RO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9203588E7E; Thu, 26 Sep 2024 22:53:49 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 406C288E89
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6c5ab2de184so9058226d6.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727384026; x=1727988826; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oq4+LbcSKPVzLVxV1qfMCvR3xmcNLaHJREX2zC2n0hw=;
 b=ep02a5ROUUryj80NugOZP8PC0Tq2JYoJnVrYLIgbHLyCXMP19EUnwlPA+yvp0uMqKh
 /nS8dRUTYU/Vqe8lE9ZnqzIPkIzIaf9BuxZkzm9F7Xi+SQ7wdjBDlQOBnpby1p0dBwT6
 P84yGhvCLWD/8mN8WRKMKgVxZKowvIMUQFaDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727384026; x=1727988826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oq4+LbcSKPVzLVxV1qfMCvR3xmcNLaHJREX2zC2n0hw=;
 b=h6eyStDarecLGnBVfhp4LoCdpOiDpcvTfrfqiaY/WvEB/GfdsRcQrumN8DpEA2LgdR
 mlNXFG9Ru9jSV5Zj26V6gJPykhOhzMIpXPFU1VsyLPN4YWQgvX/nc2Lf0tenU0cSFwDj
 j7au+5CBXnDEW3d2TuaZZKR020ppBg+ePNLY2zfVCAtJA96RjbJ+MEbGqpHQnENkwHbN
 PKy1N5Afo2fvJ/1ExbXO27t09Xk+eWsQpj7y7F3htL2ifpMY/lsnZF4U1wAuNLIQ5pjV
 jidTaI255DxnrDVE0ld45m1VvHDl+2dL1EGW5sGQ6EnNveG/FXiPYMnQaa8m9XedZ2gc
 UpBw==
X-Gm-Message-State: AOJu0YzjB5VDg5mswJ/OFkS2pzywRV+KPmPMjiJaX6KCPaiMxrbJTflq
 5/LvrdzlEy3iVUPJVQ9fezaD2tzPG+oxKCYE/436UGYbjk/+U+zm857BxRw3NYUFg71Ellit9qg
 LopxAS0I=
X-Google-Smtp-Source: AGHT+IHVx8ti83D5t//rwlA6Jm2WoZLU209aFQ5jOxd+K58e4ugEGgtn4WhprVAyWuJNA2f/7k/h7g==
X-Received: by 2002:a05:6214:398b:b0:6c5:688a:63b4 with SMTP id
 6a1803df08f44-6cb3b67c681mr8435336d6.50.1727384025995; 
 Thu, 26 Sep 2024 13:53:45 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:53:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>
Subject: [PATCH 25/27] mpc83xx: Drop status-LED code
Date: Thu, 26 Sep 2024 22:44:45 +0200
Message-ID: <20240926204455.963584-26-sjg@chromium.org>
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

