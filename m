Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437D4CDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D58E988E36;
	Thu, 26 Sep 2024 22:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G4ddaaNc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C08788E26; Thu, 26 Sep 2024 22:51:16 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7951588DFD
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cb259e2eafso12769536d6.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727383873; x=1727988673; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e62M61pubBx7DypN3K+XxgktP7P7ihcbzf6lC02l+Is=;
 b=G4ddaaNcFXDGCuUtf/TSMVIfjqOcmuCOcxAZdxSj+h4ZArfTBEgI3dU2wKPYLzU0GG
 EI+EAdfl/wdhwnv/nESSsoPI5lk5wxT5GhNRcxcBYHmCm9aLEoVFLg1PqzRwnwKnLKb/
 mpBDMLVlYdwVV1bap8P6hRAoQYNKAOadairVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727383873; x=1727988673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e62M61pubBx7DypN3K+XxgktP7P7ihcbzf6lC02l+Is=;
 b=IwhvyndwiJmkkwJ8hAGIGXxpm6xMrBLdGBnMZlHF8FChuhqCkIAMX62sNGzfNSwmOC
 BpKqi1HRG3mRAkCGbN3SfVldLvV93msyuru6xUGx2tbJ57slNeyf9kYDQBuj7orSSj7k
 iEt1y5HdsqqrmnDDnmnVw52NhyZ8HwbXmm1BTiIgEGea6kFT2h1Zmz+fUN1CZ7A/Gy1y
 cS+GF/4r1ipQqX0MN7J0X+Y2VkaOUUfhj32UcRAmBTam/DIwNKZOwRZ/iUNkCxGDjSuY
 DoGR7txZP8+rKHEObbf260EtpLDQ0jP4QdGbmSpfwL31RQ2m2LjrDZ2Di/b5yPV2av/q
 gqAQ==
X-Gm-Message-State: AOJu0YwxQ8lGKsdYsmXgeNXl5RgBMdqFFO8pmAzby1GDioXqWsLWMU3E
 2Y6I1j8TNGq5clOBDKj5dzT0RC+dWSFkLQdC2W75K+KV08Lmw5LLW91lNLk9H6iatTu5NNUp9CE
 yOnloJIA=
X-Google-Smtp-Source: AGHT+IHBSplzAUcg11+MR6FLlMpfnZUpXaNH7NyGVpw3zVrTBexYlDl11GTQ8yRUR44xSQZXs1xU2Q==
X-Received: by 2002:a05:6214:5508:b0:6cb:260d:794e with SMTP id
 6a1803df08f44-6cb3b42f24emr16971336d6.22.1727383873174; 
 Thu, 26 Sep 2024 13:51:13 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:51:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alison Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Angelo Dureghello <angelo@sysam.it>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 15/27] m68k: Drop unused status_led.h header file
Date: Thu, 26 Sep 2024 22:44:35 +0200
Message-ID: <20240926204455.963584-16-sjg@chromium.org>
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

This header file is not used, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/m68k/lib/bootm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/m68k/lib/bootm.c b/arch/m68k/lib/bootm.c
index 3dcff8076e3..1fa112f8dbf 100644
--- a/arch/m68k/lib/bootm.c
+++ b/arch/m68k/lib/bootm.c
@@ -15,9 +15,6 @@
 #include <bzlib.h>
 #include <watchdog.h>
 #include <asm/byteorder.h>
-#ifdef CONFIG_SHOW_BOOT_PROGRESS
-# include <status_led.h>
-#endif
 
 DECLARE_GLOBAL_DATA_PTR;
 
-- 
2.43.0

