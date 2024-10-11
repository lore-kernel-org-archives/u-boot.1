Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4818DD0D7AB
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 14:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B73489372;
	Fri, 11 Oct 2024 16:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wcx/8211";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A5A989371; Fri, 11 Oct 2024 16:50:03 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59938892F8
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 16:50:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c883459b19so2450688a12.2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 07:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728658201; x=1729263001; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3D1Mgj4wO28NX8BmZvBpzKaEtWI1ctl4ndt6FQg95iA=;
 b=wcx/8211YPQ48cBxAHpyWXox+I4T9lrzw5G3rd5E4hJWgzGejoALKd+mi3L6Ondmkm
 +6l9XTy4yAgG5GU63MCHm+P5eDjeHfFfun+OgVn2QlRplUgqM56B2kQFAaIJmntPbMhz
 RE175zzFPzXTF/nxY8Mbx1B9uzoZNvSYYd90WVYsum6aSC1IL4KzXNbhC80RmV8A0GJ5
 pJf4hy71nz4Vgs/N5Bqpjmia8Fp5qda+/IQCgmhYq4Atripuki3G/fKAD7FE5D9kL49p
 0Uh0kbP+P07O9Wix88A2DTYqHR9Oo1V7X6HkuYRpALg3in2p2e8V9fvzUjd01kNRwRps
 GNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728658201; x=1729263001;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3D1Mgj4wO28NX8BmZvBpzKaEtWI1ctl4ndt6FQg95iA=;
 b=QX4p8ZgI6ySLgmWZCkS467YGDSXy1iVjtgtHavI9/2w1jg5K603nvNnq/LJSoW7XJO
 Xix4h/iMeagc2rkbA3q7xAc23PaXVcJTDNeqjU5LdwLFpd5xhCQOxvVLrmXrRHdbWr//
 mrT6pQCuK1PjwN/tTQksNu9CUrb04AIWdas8cqlfS69Ah1k2y3tMUN5GnerpVGOv+eIS
 ZWe84nYOPk8Y3zavuRX9Vu3RTOvfAfLy5F86F0+yuzd1DYHFb4IWls6KNDL5vsScv0gf
 wiYB4IA5mr+oVzpgYC0Hh/y/gaWy9zQlww8FFCNjNXDQbuTeorAl3+ptrvKVQxM1aWt5
 T6Ag==
X-Gm-Message-State: AOJu0YxMz2ySWGVkmrEhAxJAhjKZhazllZi+lYByQ9uGaraS0Ea7vESE
 GpcOmbU4qvuUmNIYpO1OO8MUkm1utioGveBtUVrpEzANtmYuxvqOxFLbIXjbYeE=
X-Google-Smtp-Source: AGHT+IEeXVKsCj7woFVloIzVGHqgu24OIA19rLK1k0pv3GuAqEB/jWiHbUvu+XHoO7+NAWh2sYN4iQ==
X-Received: by 2002:a05:6402:348c:b0:5c8:8416:cda7 with SMTP id
 4fb4d7f45d1cf-5c948ccf04fmr1853984a12.15.1728658200750; 
 Fri, 11 Oct 2024 07:50:00 -0700 (PDT)
Received: from lino.lan ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c9372940e3sm2006113a12.81.2024.10.11.07.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 07:49:58 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 16:49:55 +0200
Subject: [PATCH v2 2/4] drivers: nand: bcmbca: Enable on BCM6846
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-bcmbca-nand-support-v2-2-1fe928e5b933@linaro.org>
References: <20241011-bcmbca-nand-support-v2-0-1fe928e5b933@linaro.org>
In-Reply-To: <20241011-bcmbca-nand-support-v2-0-1fe928e5b933@linaro.org>
To: u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0
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

The BCM6846 has the BRCMBCA NAND controller so enable
it.

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-bcmbca/bcm6846/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-bcmbca/bcm6846/Kconfig b/arch/arm/mach-bcmbca/bcm6846/Kconfig
index 229ab88dbb0d..5ef9535369ec 100644
--- a/arch/arm/mach-bcmbca/bcm6846/Kconfig
+++ b/arch/arm/mach-bcmbca/bcm6846/Kconfig
@@ -8,6 +8,9 @@ if BCM6846
 config TARGET_BCM96846
 	bool "Broadcom 6846 Reference Board"
 	depends on ARCH_BCMBCA
+	imply MTD_RAW_NAND
+	imply NAND_BRCMNAND
+	imply NAND_BRCMNAND_BCMBCA
 
 config SYS_SOC
 	default "bcm6846"

-- 
2.46.2

