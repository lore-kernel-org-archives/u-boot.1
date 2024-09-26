Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F05CDE03F
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:43:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93A4988E1F;
	Fri, 27 Sep 2024 00:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kV/d09bQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AA69889AA; Fri, 27 Sep 2024 00:43:20 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 085A088FEE
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6cb2aaf4a73so11442806d6.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390594; x=1727995394; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7bmFrjVceaa9EGbUmHR0EqKoYF1u9DWDilLma9WPI5A=;
 b=kV/d09bQ5qTx5hb9YwYrGtp58zJKNrwhWeAw1yjfSQ2RiHw0kzgVEwb2/s99aZprqG
 K76Ay5D5WNDNLMdT2+qiaK1r9Koo96LYtEuVPOwaGsfFiGAtF4Tvz400KMWZHM6D+mlX
 cQr/uNh2BzyRwUD723UQQTfwqIFBmp9ac6Azk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390594; x=1727995394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7bmFrjVceaa9EGbUmHR0EqKoYF1u9DWDilLma9WPI5A=;
 b=J3EeYhsUIG6kY5SSUxg8x2Ol1+ZuS2ncGEOKmcsQeMgToVcBExzwpMz32ok1y1uI78
 HsWP9huNgw5URazZaHcl3brbpb2w7raDUJRwfIJ2ZFVyiahPSEkGGcO603G8mRI1TfbV
 tj+cgNjk2t5hkCIh2qGnWqWCrFlRrot/jSe40GgmaIm9+Gl9EZ67Sde5sIghxi+ze1Gr
 aegCexzMV6oStDM09P+VX1WFHnVe9IP9fEisH3xFrgaLXZovkjSvEXXOWibftH7jIIWv
 P56I4svI3nzGj3pGlw8X8H8FIetwB4MZJ0IwAnEaL7x+9crngDBGZm9IOzAexBlIUX+R
 JYng==
X-Gm-Message-State: AOJu0YwgMWsPr/M44NRVk2pBOuF2jRAgf7CT7EdRqV0v/CKI9vF2roIo
 Pm7KKs5hMeZYDY4Lkn07FpuWfJuNejc1aP3PFKYiwxwuAAlxFIFxHOP8Gfb7NkId3mOdPvho7Cd
 beYUMgWA=
X-Google-Smtp-Source: AGHT+IFDCZwmu6lVnLIvS+Gt2ppLXxIZTkYAqgDu/o0DxSMELy3xQ6x1migg3W/1dGNudtWhpOtFKQ==
X-Received: by 2002:a05:622a:190a:b0:456:8633:43e9 with SMTP id
 d75a77b69052e-45c9f2a482amr18088671cf.52.1727390593813; 
 Thu, 26 Sep 2024 15:43:13 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:43:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andy Fleming <afleming@gmail.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Mario Six <mario.six@gdsys.cc>, Priyanka Jain <priyanka.jain@nxp.com>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Wolfgang Denk <wd@denx.de>
Subject: [PATCH 22/42] powerpc: Correct check for SPL
Date: Fri, 27 Sep 2024 00:35:47 +0200
Message-ID: <20240926223814.1276764-23-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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

This variable does not exist so the condition will never be met. Fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/powerpc/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index b218ae2b91c..64ac4930b62 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -44,5 +44,5 @@ obj-y	+= traps.o
 endif # not minimal
 
 ifdef CONFIG_XPL_BUILD
-obj-$(CONFIG_$(SPL_TPL)_FRAMEWORK) += spl.o
+obj-$(CONFIG_$(SPL_TPL_)FRAMEWORK) += spl.o
 endif
-- 
2.43.0

