Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6620FCDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C759088DBC;
	Thu, 26 Sep 2024 22:47:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cTMV1/gX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06DCE88DBA; Thu, 26 Sep 2024 22:47:52 +0200 (CEST)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E64F188DD4
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:47:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-49bcb3d0d6fso453891137.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727383668; x=1727988468; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l59ngf+6ydqxL5LaeXdE85b+15Aa1xrUSq4OmGEBRRU=;
 b=cTMV1/gXc/MMH0MN3xuemCXmXIKhT4Kg17mHVa0wVviUKi493W1M8cW+W652cSSnSW
 2vGHqAV4v0BJrtaNBcqqRLGOWS7coN60fL58qxyFNwB0xNQ8u7nCMZS8ThTAfUEzUQYL
 iynujsWlB2ILxGsdgISeEJDbstZc1w8638eiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727383668; x=1727988468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l59ngf+6ydqxL5LaeXdE85b+15Aa1xrUSq4OmGEBRRU=;
 b=D/x3me1kSNfhqvH9Cz14e0Gib7NidOAYa4hHEdiIJXir3ucB8aJxiVPi4+8BXMFx9x
 Koe2ygX7sS6V8SbzygFixRl9HYo4AyUSOxp/Pw3RnZCBz6cxbFDDyOEvvdqtF26nHgKI
 ShUwcOtrl/FysCKz+lcPKTut6OPG9xpzbmBNR73qZzlUyr7Pk2ueoTDFicl2xfOsus3F
 5+QplcRjP0B+Y6Gd1ocBNbILtFFRncQn89QfPjYAbXhy4z8PX/8VZd3O5NSRF3UzsVbi
 NBM0wROMW5V0fgJhCP0QjEtpMDkMmGtIKIE0P+U/wyu3RP6cVb3wFsAaPJUBNsY3MA/S
 fDeA==
X-Gm-Message-State: AOJu0Yz54l05N9aFevuApzqTSpeXsIr0nEfXW6OuHTKY7JJnpgJ2vDAh
 VE880kGiW0mWyhcYM2BVrXyHN56/dEmCfjKDUph1Xs1UwXMnSZ/nYUY4laEnOj6AItWZ3+RXhG8
 9pJ4lxzI=
X-Google-Smtp-Source: AGHT+IFqPfxvNGDH+p7+8TgHHL+8mcW3cbODQY2/3leJyOtkb7KuH7ubizdhHYllZNiG5JZzLlDr4w==
X-Received: by 2002:a05:6102:3048:b0:48f:df71:17e3 with SMTP id
 ada2fe7eead31-4a2e116c3e8mr1076274137.28.1727383668630; 
 Thu, 26 Sep 2024 13:47:48 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:47:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>
Subject: [PATCH 02/27] arm: Drop old LED support
Date: Thu, 26 Sep 2024 22:44:22 +0200
Message-ID: <20240926204455.963584-3-sjg@chromium.org>
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

This has been replaced with a new LED framework, so drop this old code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/lib/crt0.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/lib/crt0.S b/arch/arm/lib/crt0.S
index a0311438b45..3293e4df63c 100644
--- a/arch/arm/lib/crt0.S
+++ b/arch/arm/lib/crt0.S
@@ -185,10 +185,6 @@ here:
 	movne	r9, r0
 # endif
 
-#if ! defined(CONFIG_SPL_BUILD)
-	bl coloured_LED_init
-	bl red_led_on
-#endif
 	/* call board_init_r(gd_t *id, ulong dest_addr) */
 	mov     r0, r9                  /* gd_t */
 	ldr	r1, [r9, #GD_RELOCADDR]	/* dest_addr */
-- 
2.43.0

