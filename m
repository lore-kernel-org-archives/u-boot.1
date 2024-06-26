Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEDCC27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 16:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6614B88578;
	Wed, 26 Jun 2024 18:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EvH1i322";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84A42884DD; Wed, 26 Jun 2024 18:00:19 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A565488578
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 18:00:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-424798859dfso55924435e9.0
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 09:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719417617; x=1720022417; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JPDTBpVZuVkaqULrtYe8FXz9i1e5MJHdje88Wa78OmY=;
 b=EvH1i322eU47SyXtl77jItWpXeSqEvTBJ1EpA4waR1x0IXbndlaSEwdQuieVUiLaY8
 pd9TbUOWTpcaRrkkOeonLYW7wZnEfQiNakroMqAoejCpTQGRQ6jkBFicFBtvR+z3tkz1
 Hli4Xr7hOu50CzNOtxOjj6oee4TjKIkWLtlCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719417617; x=1720022417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JPDTBpVZuVkaqULrtYe8FXz9i1e5MJHdje88Wa78OmY=;
 b=PhHZhsSEhX5pBP/iCtrAXTIUnpPzgtw+ht8jD8NjhvqZ3Sm2xkevQGgDVmPyyJbYCY
 jbniiGwkm6FaTYXNspa7qeEk3SYq4VXfrEoVstUvR7f9PDRCIMGY0kyW8IIiJuTiCBY4
 /4WTQmPk1DK4/ib1p6+AVSVfv1i7rMcknCtka87wjHRbJdcrlF70j6kmQ3d5JCo7pf/J
 G++pipp/jkjCmyHtzSN1rKqq5mQSKyVYtO9lTwG5fHyJI4i4dg9b820bsAPa982kz/PW
 Ay3BWaFz6zHYrc5XyIRkw3cY8x1qgdByiL/5BY6Ot7rmxwLczIWjTaP6SA2MgauZ6PSi
 eJwg==
X-Gm-Message-State: AOJu0YyNqj/RavpEh1WKTiTRE3bVWXnItZqVesbGapRZfGNvW4C2yFBW
 yZSZKZG0d+dOVpAyjCZ42UymhUY6onGcV/3kBg3lg0RR76c9pnV2DuKFDD8piUizqA14Mxpx9C8
 JpQ==
X-Google-Smtp-Source: AGHT+IF2nSMaMz6m0uC+QQD34RT/iSA0RGp4Mda0/f3h5N8mt6kBn9EjSIx0/CcCAg0Psd0c1vtYiA==
X-Received: by 2002:a05:600c:35c6:b0:421:eed3:5991 with SMTP id
 5b1f17b1804b1-4248cc593f5mr81936795e9.32.1719417617013; 
 Wed, 26 Jun 2024 09:00:17 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c827507bsm30753715e9.22.2024.06.26.09.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 09:00:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 12/16] spl: Allow ATF to work when dcache is disabled
Date: Wed, 26 Jun 2024 16:59:41 +0100
Message-Id: <20240626155945.278640-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626155945.278640-1-sjg@chromium.org>
References: <20240626155945.278640-1-sjg@chromium.org>
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

The dcache may not be enabled in SPL. Add a check to avoid trying to
use an undefined function.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 common/spl/spl_atf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
index 3bdd013a35f..9afe6456bc4 100644
--- a/common/spl/spl_atf.c
+++ b/common/spl/spl_atf.c
@@ -204,7 +204,8 @@ static void __noreturn bl31_entry(uintptr_t bl31_entry, uintptr_t bl32_entry,
 						       fdt_addr);
 
 	raw_write_daif(SPSR_EXCEPTION_MASK);
-	dcache_disable();
+	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		dcache_disable();
 
 	atf_entry(bl31_params, (void *)fdt_addr);
 }
-- 
2.34.1

