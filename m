Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF0BCAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 14:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76D3283211;
	Mon, 22 Sep 2025 16:12:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="LQLsG6e9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E736832F9; Mon, 22 Sep 2025 16:12:41 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0946382CF4
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 16:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-61feb87fe26so5615616a12.1
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 07:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1758550358; x=1759155158; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Py8tId+Jm/Q383OoHETZXEN8PHw0ud0VWf3c/UiY0v0=;
 b=LQLsG6e9n1LuywJIc96YO8tLJayrTjAqho7uzVYOtAyidV4Ab9Ur6GERH/1KbHo3S3
 H3ihLoV49DuAl8xGQ3NX8s518nhvAWSK5hiB+CDeEF96owbG9pXX8KGmwG4MHt+QYwFL
 WGkG1PwQKLuD8eEb0ZmJ8rdCjjgSkXuzQ1GSurL25Jv9t2JLSMHvDUTU5ON8wMe2lwE2
 L0qg3ZkXAcVxwV/7wLFJ9nc9P1Wins3QCPZMakOjW98sTg9rQhO7nLJ0Sk3c1M3UHC0d
 RsRlHt4IKtJP/ayPhCGyyHXGS6zdKnRfDtg5jGjTVbqB92aVZ8Xh/GQOWmeUaEY+rH6s
 U0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758550358; x=1759155158;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Py8tId+Jm/Q383OoHETZXEN8PHw0ud0VWf3c/UiY0v0=;
 b=HAX9KTpKWE8t+e2bhR8P4t6PTWYFT53K+LvgbIWKInYiR2HYDo9okVWceQ6XytU6Zp
 ltpzJ55ge6ywIQqCqu8Jk7YRUokTomJ//45/1e0C686qAzYSlpmbBB9Mo+6ePPybCUGJ
 6WES3ltQ/gYBBTr/4Nki2/CpLe5lTay44txwZhzXc1cncS1iSgoWlmDVd1BJzyQLyy1U
 RHUpFAiAPGAZM5nB47g9rsKi6HcunDy9sKn7iZF+x1vMnsBxVq7q3lSf8lNvOmnucFhA
 +EgT3GFToVn4AjHupaCxICo5yxWwD7XcLmU85EAwMAoQ3RPBaSLBi3FGtfaOlYNKFCjT
 lXRw==
X-Gm-Message-State: AOJu0Yya62URfaIRlXBS0CXT1KN92ATX1FXqOhvukSjG71MjZiZpeZnU
 CYTlMRYhRFftqATUjVBbxQ0G9i8Y8B0NyLSfUCsN4ybHqtgE032MUrlMfGo7yQ==
X-Gm-Gg: ASbGncsi6Yi/55NM7wU+5+DB1fCzgUwIeiT7JQP+tTIMxTGNVUajpJSi9IQsTDgskT3
 hKScHQKQXW0uaIwAxvds8VHpIc8z+badZ7ZxzH06PFHo1B48V3/mQKatGxaB1THnEsTHYAjp9ro
 u1ZFwluaXBTWfYiz/tUqIvF/El36EVBpgYSo6IYrqDYLmWwWndwKq8+j1VcAF7NXLnSBPwk7Azh
 z4Vf/iejVF4J9qwvlJfacxgtwh32zwM/Pb2H7qcvGon6XePVJ04akQBm3nnBTUx5OUb0r055gzW
 D+Ls7wYp+dd5R6mGL84fqM1vU3QoRFFZWKwL+iCxg1GNCynDKa61pQcMKspv1EPPWSm8ialxrUo
 VF4zCKKBXZiJMhuyo8h0KZ33VSlQJfMgcSAe6AbBs0Ba2pZrinU08KPNbOWyh9G4m8Yl0F5GBE3
 ue0nU=
X-Google-Smtp-Source: AGHT+IG3oMCTGBzLxrJq5DEmt8Lv4heuNLdctAPxtY1k7GUNi1b5dwxiv9IJmy7dbCqFeTq1qXrCqg==
X-Received: by 2002:a05:6402:234f:b0:633:57e8:ea3e with SMTP id
 4fb4d7f45d1cf-63357e8f344mr3251110a12.33.1758550357643; 
 Mon, 22 Sep 2025 07:12:37 -0700 (PDT)
Received: from development2.visionsystems.local (mail.visionsystems.de.
 [213.209.99.202]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-62fa52827bfsm9069321a12.0.2025.09.22.07.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 07:12:37 -0700 (PDT)
From: yegorslists@googlemail.com
To: u-boot@lists.denx.de
Cc: marex@denx.de,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] usb: musb-new: fix typos
Date: Mon, 22 Sep 2025 16:12:29 +0200
Message-Id: <20250922141229.5739-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
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

From: Yegor Yefremov <yegorslists@googlemail.com>

Typos found via codespell utility.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 drivers/usb/musb-new/musb_core.c   | 2 +-
 drivers/usb/musb-new/musb_gadget.c | 4 ++--
 drivers/usb/musb-new/musb_host.c   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb-new/musb_core.c b/drivers/usb/musb-new/musb_core.c
index a14b127dc37..17ec0d3acbd 100644
--- a/drivers/usb/musb-new/musb_core.c
+++ b/drivers/usb/musb-new/musb_core.c
@@ -1954,7 +1954,7 @@ musb_init_controller(struct musb_hdrc_platform_data *plat, struct device *dev,
 
 	/* The musb_platform_init() call:
 	 *   - adjusts musb->mregs and musb->isr if needed,
-	 *   - may initialize an integrated tranceiver
+	 *   - may initialize an integrated transceiver
 	 *   - initializes musb->xceiv, usually by otg_get_phy()
 	 *   - stops powering VBUS
 	 *
diff --git a/drivers/usb/musb-new/musb_gadget.c b/drivers/usb/musb-new/musb_gadget.c
index 08fac829ce7..7daff5850f1 100644
--- a/drivers/usb/musb-new/musb_gadget.c
+++ b/drivers/usb/musb-new/musb_gadget.c
@@ -728,7 +728,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	 * mode 0 only. So we do not get endpoint interrupts due to DMA
 	 * completion. We only get interrupts from DMA controller.
 	 *
-	 * We could operate in DMA mode 1 if we knew the size of the tranfer
+	 * We could operate in DMA mode 1 if we knew the size of the transfer
 	 * in advance. For mass storage class, request->length = what the host
 	 * sends, so that'd work.  But for pretty much everything else,
 	 * request->length is routinely more than what the host sends. For
@@ -1422,7 +1422,7 @@ done:
 }
 
 /*
- * Set or clear the halt bit of an endpoint. A halted enpoint won't tx/rx any
+ * Set or clear the halt bit of an endpoint. A halted endpoint won't tx/rx any
  * data but will queue requests.
  *
  * exported to ep0 code
diff --git a/drivers/usb/musb-new/musb_host.c b/drivers/usb/musb-new/musb_host.c
index 7528a53d73e..7f296d15984 100644
--- a/drivers/usb/musb-new/musb_host.c
+++ b/drivers/usb/musb-new/musb_host.c
@@ -1862,7 +1862,7 @@ static int musb_schedule(
 			head = &musb->out_bulk;
 
 		/* Enable bulk RX NAK timeout scheme when bulk requests are
-		 * multiplexed.  This scheme doen't work in high speed to full
+		 * multiplexed.  This scheme doesn't work in high speed to full
 		 * speed scenario as NAK interrupts are not coming from a
 		 * full speed device connected to a high speed device.
 		 * NAK timeout interval is 8 (128 uframe or 16ms) for HS and
-- 
2.34.1

