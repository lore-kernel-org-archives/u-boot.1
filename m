Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E4EC531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61D1188A50;
	Fri, 23 Aug 2024 15:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y1pFXgCI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B07A688A25; Fri, 23 Aug 2024 15:49:17 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C737B889EF
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42809d6e719so15502665e9.3
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724420955; x=1725025755; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iFG+cepuhJetnnc/QhAyO6HKp2bGrqBgx5fNZtZoZ5U=;
 b=Y1pFXgCIbFJs4hXUavBPCQG5jx9X9njKP0dJdlhhadE3FvYbigLuVMpBxg1UtlKZ+e
 8ibG31exXRPo11kyqKAjbNQS+5f/HP8QkzaGXvPel0IUmR2bi76nOozlKNt0GyjIv/o7
 u/nfhRZ1XxQPZjUbpvvDOHxwDl3ty1uf8DhvvAq44QybemCCL2hjGeQ/L1/6Y5hYlDFV
 Ui+sCYDvqfHPZrL4vqAQvFNmG4G3pOGGGW8Yv9u/gWhG3ZirIUYAv1BXODNFXXILBC4Z
 QqsPLx9OSpzSzmzc5W1Eq+DGAXoetKHvOrkzLLbMlGOQzloTgQOxpzowUY4i6km1+S1b
 oJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724420955; x=1725025755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iFG+cepuhJetnnc/QhAyO6HKp2bGrqBgx5fNZtZoZ5U=;
 b=VQiOblIWtXHkqMLGg+ippGFrSpPv60yoha9uKAB4Oboygu5mC1aCVD+x2GXRRoQLWa
 my06YmdVGCiXUPED1h4nvegFM2VOV8m37a0mhttJJMDEy/CxwEweB67tXcKEQEYTPEBm
 iQn8eKOmhWoF56rzYwhYkbdTe99mLcl6CP78ATfKx7spAxpwwgYG4zFl63VSvaiAVQob
 FOrl0smoFdgFwF7ZHk6KHSYRWni/v34PpfH/0RFTMvkFyhAKpNuoLDsjTvOjwTjddUT3
 h3O1uku/6P6O/+5E3vCwYiqm4B9meQOlbdiRXcQR4EwXvfMSl2l+kWV7KXaJ2ZiFkAc/
 Pg3Q==
X-Gm-Message-State: AOJu0YzhJedxeBEaW+U9QJ48UpQksIhzkZIhYCJIRKsICscnO+8rFJfN
 WDNi9dVhG/XRkKQKpzREJ5PQ5vX4JGU5MeFshCx56mIkFgxJZMbTbGjuP9bbZqR5TP2/BwToGdO
 Aa45vhw==
X-Google-Smtp-Source: AGHT+IHiew9P/fBzpGcZopLG5K+MRbYWd+nmaYtfZWKJa/BNTOkoV7BeZA+y/kiizdb4tS5aPB5vug==
X-Received: by 2002:a5d:4cc2:0:b0:371:72a8:15e with SMTP id
 ffacd0b85a97d-37311855fecmr1552444f8f.16.1724420954931; 
 Fri, 23 Aug 2024 06:49:14 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:49:14 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 04/37] arm: omap2: add missing #include <netdev.h>
Date: Fri, 23 Aug 2024 15:48:08 +0200
Message-Id: <a74407230cf665355ed114f28adbef9fd7e1f80c.1724419624.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
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

emac.c implements cpu_eth_init() so it needs to pull the corresponding
header file.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 arch/arm/mach-omap2/omap3/emac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap3/emac.c b/arch/arm/mach-omap2/omap3/emac.c
index 7348e92cabd..1e30a06361d 100644
--- a/arch/arm/mach-omap2/omap3/emac.c
+++ b/arch/arm/mach-omap2/omap3/emac.c
@@ -9,6 +9,7 @@
 #include <net.h>
 #include <asm/io.h>
 #include <asm/arch/am35x_def.h>
+#include <netdev.h>
 
 /*
  * Initializes on-chip ethernet controllers.
-- 
2.40.1

