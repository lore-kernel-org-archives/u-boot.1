Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A6EC0032E
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 21:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF57787526;
	Fri, 20 Oct 2023 23:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mg6KxF8e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9F5386F46; Fri, 20 Oct 2023 23:46:43 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E42EF87524
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 23:46:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1e993765c1bso891573fac.3
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 14:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697838396; x=1698443196; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CuKxXGX80wC1clbvUNIGZqrPlS4JX50n79XrYCQUpho=;
 b=mg6KxF8e/Xz5odcWf1nb6Bj5c0ndIcnVZ1K2bV9G8cLwpU2e7X8qPt+Ppg/wpZ/9l2
 n/gJ3kwHeWgWm5i3ypPTWelMPigss/s4nlJXvLv0Z2ECovWplgIDXUOl/R2hcqqeEVPa
 fI9PrIeLy05RCR7RgjZzPVCGUF5Y+TQDNf86pxoN53JFMBIIoPnbuAM+Afexbijhs9GA
 vW7/dF1AoPnk9u4d/HAxom5v8epo4YbIWIqfkmlgJ0LdWoyPHD753wY9RUfw+ThC7D5Q
 teUQBLTM3vygKO232G8VXHtzM3JiTHjJHZyewJVTgRaTp0RGa6KwxIZP8UqAr33MElx1
 pOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697838396; x=1698443196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CuKxXGX80wC1clbvUNIGZqrPlS4JX50n79XrYCQUpho=;
 b=l0goiCl9cNHS7ri4d5Y8mKKn+XrgiWl0YGxLwNJSL+/SwNLVfQjcAmAodo0P8ckauf
 CMbLaRc+QyGiLFhaiY+FB85NFoH14KmILB6WRt2V4KPpdMh+m717cXu5tRNFrT5hc3S1
 PalptTzj8uUsS3GlwQpFoRoVB7deMlNHWg0bJompvo5xltDNosoBfb3N5nKF6EWAnwb/
 DTL2tLOBZCcdSr9h9ni67fdWfLqSCKZY7G/lw/iL/C+5fFx35xCwhC4zyr+Efsp+jtu0
 ejD4VdDf5S0RFP3tTt4vBoL6KJ1Mzlm1TGmr0NKu7oa+SYKzyC6uJpnHuMZ+G8yiLcyn
 JmEg==
X-Gm-Message-State: AOJu0YzrRuOFX+g9o2xCoMwomS5i8YsIhS43tryCV7oKgUtMoukX0nxZ
 svkp+DFMMgQbmA1hZRmRTKxmBwa6ig982NtZLZQDCg==
X-Google-Smtp-Source: AGHT+IG3bfqy75bZXaO66j3bT6H/G8xxSgJIk0+EAkocaf0HdHbtcyq24DFz+io9PaMaH6SpktUGeQ==
X-Received: by 2002:a05:6870:2216:b0:1e9:b82e:ba29 with SMTP id
 i22-20020a056870221600b001e9b82eba29mr3581652oaf.24.1697838395985; 
 Fri, 20 Oct 2023 14:46:35 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 s5-20020a056830148500b006b9443ce478sm467654otq.27.2023.10.20.14.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 14:46:35 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH 3/3] watchdog: s5p_wdt: Include missing CPU header
Date: Fri, 20 Oct 2023 16:46:33 -0500
Message-Id: <20231020214633.30883-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231020214633.30883-1-semen.protsenko@linaro.org>
References: <20231020214633.30883-1-semen.protsenko@linaro.org>
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

s5p watchdog driver calls samsung_get_base_watchdog() function, but its
prototype is not included. That might lead to build warnings like this:

    drivers/watchdog/s5p_wdt.c: In function 'wdt_stop':
    drivers/watchdog/s5p_wdt.c:16:26:
        warning: implicit declaration of function
        'samsung_get_base_watchdog' [-Wimplicit-function-declaration]
             16 |   (struct s5p_watchdog *)samsung_get_base_watchdog();
                |                          ^~~~~~~~~~~~~~~~~~~~~~~~~

Include asm/arch/cpu.h to fix that issue.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/watchdog/s5p_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/s5p_wdt.c b/drivers/watchdog/s5p_wdt.c
index 5ad7d2609f04..80524a00101b 100644
--- a/drivers/watchdog/s5p_wdt.c
+++ b/drivers/watchdog/s5p_wdt.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <asm/io.h>
+#include <asm/arch/cpu.h>
 #include <asm/arch/watchdog.h>
 
 #define PRESCALER_VAL 255
-- 
2.39.2

