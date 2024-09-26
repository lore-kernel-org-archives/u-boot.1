Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFEDCDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:52:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E580488E58;
	Thu, 26 Sep 2024 22:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jss4spfi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47B5488E5D; Thu, 26 Sep 2024 22:52:47 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F17C88E59
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:52:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6c5acb785f2so8069746d6.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727383964; x=1727988764; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iVXalxq2eB6rPDQ9Ut88kWK5stTTVnZn9EH9dxGz/oM=;
 b=Jss4spfimuW1ML6bMNoiuF9JoSEpIP0z3UcCkSxU9qLejXuwkWj49Xk4BJI7CDYaFL
 4oaberK/7fZaSnTfVeTbyfftJ9vMVvysdJVqrtS+OB+9GypT+ffEBoOumepz6oOnU7Aw
 O4WbIeqWxvgiHH5easb+o9uAJkCTDmT3QehJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727383964; x=1727988764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iVXalxq2eB6rPDQ9Ut88kWK5stTTVnZn9EH9dxGz/oM=;
 b=CGBXZN4wP1NNs62VNm7jmJ7URCKrW7KV5F65KzWG0wTkb01RdxvnRKFYvc+EQDmuHW
 qtY/3MTnj8JZMSLQ3rHLF+EdrSeMAdQa8tMVZ326SvQq/tMbdW5AGBCLnJCbMfJKYa4f
 eqw3Jwk7a3u6cL2cOGLqLcXF/lWu3XRfH10VJaUnMm+eQoi7yoFCcrFJd+lyIm623Fdf
 /Xhcrs+Zd6IOAciemqHROpSVMznKefxx1/4F1QX9oRnhkE5ecQmoDPNPnY7cA1TWU82N
 Cum81cl5oIWk1GRpRjfx0OuEx3fBdaFD03WEaXvIEENKt1jHhmC0fjEErxCV32MMd20V
 MpUw==
X-Gm-Message-State: AOJu0YwUL2hrx0SITooWStwmgRQzX5w+d59OkpzfYYQIzMmf9ip/LOre
 fmLfZtz4trybn8TIByFiSaijl84CBCsq223UfQvBNPT2AO6DkXFtE5wQ8ZLfXe/MPyBNkn6W6Sr
 8K7HkgvA=
X-Google-Smtp-Source: AGHT+IG6qpB+ZovygVGo8BpgGAZqP72qak48dcUKyfuei9CSCCZYD8U80NJEiVtq90phGJophrB/kw==
X-Received: by 2002:a05:6214:419c:b0:6cb:3131:e287 with SMTP id
 6a1803df08f44-6cb3b636673mr11042906d6.36.1727383963939; 
 Thu, 26 Sep 2024 13:52:43 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:52:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>,
 Sam Edwards <CFSworks@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 21/27] sunxi: Drop status-LED code
Date: Thu, 26 Sep 2024 22:44:41 +0200
Message-ID: <20240926204455.963584-22-sjg@chromium.org>
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

 board/sunxi/board.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 961cdcde74d..090a619386d 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -49,7 +49,6 @@
 #include <spl.h>
 #include <sy8106a.h>
 #include <asm/setup.h>
-#include <status_led.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -550,11 +549,6 @@ void sunxi_board_init(void)
 {
 	int power_failed = 0;
 
-#ifdef CONFIG_LED_STATUS
-	if (IS_ENABLED(CONFIG_SPL_DRIVERS_MISC))
-		status_led_init();
-#endif
-
 #ifdef CONFIG_SY8106A_POWER
 	power_failed = sy8106a_set_vout1(CONFIG_SY8106A_VOUT1_VOLT);
 #endif
-- 
2.43.0

