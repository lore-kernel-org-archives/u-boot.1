Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F5DC07CB1
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:08:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 441C587768;
	Mon, 27 Nov 2023 14:01:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="va2/Nso8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B88B87773; Mon, 27 Nov 2023 14:01:33 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A11387771
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:01:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50aaaf6e58fso6351854e87.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090090; x=1701694890; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JcgE/EmaHIJUPPWX7tfcGbmrQSjJUX958ngTRB2yfY8=;
 b=va2/Nso8SZpNtYseM2AcfdOhPPHQOxdUjj4VrlcfWMAn7S8YtYYf4HUsXPbgC71pfl
 dU15QQBvtbTnbBE953O0hm8HDxx4nUWZFgiO+lu+WrZ5E0f3qJ564oYiVlT8cTsTP3oY
 Yv2RGan3qVAcNGPLpDZYuvENYajM13cvBVtd8/V5We7+Wqs1AyM31TiSCIK9PODN8oQi
 NrB7NKAgn6kSwanywRGqWpGnmITllMnH4RjwawXrKN1NLt7B14kR+f1/aIPm2aQI43s7
 w8iISsoNTXAD8SdFbvlsiCe3/tPRcfympRR+NWyqQSZ57KIu4NCoBxQZY3vaTK7IPa/x
 w9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090090; x=1701694890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JcgE/EmaHIJUPPWX7tfcGbmrQSjJUX958ngTRB2yfY8=;
 b=cEXT0aSGuo3ElBiG96StVka9d2wnNZrLBOKMmrWQSeszHMrhlQgzj/Ww8NvFxDZdSw
 mb7dwUUv0lO2roFi44aO+r0k7tY58Ah5hfoWJTKTb3EHWxHi9khIHxOmSpti9fftu+BL
 COU9NgxRfMfaDSTsTY52B8YlYhe2HibgwiCvP5oTd+0tQrkVGSa8Xkb3x8jSvVCjzkOI
 IBF1ySPBOgMXRygahUvv6VtvI8tBF/9D6125tQwqoC5XYN+SsVHM9VT0zNwrLKoZcHGw
 IXwfzTnKnYC1//WAJnpxtKVT/FWh75K6ltaUHAXxw9ePynZwKgG/iDj+JIB65GiwOAJ2
 JMyA==
X-Gm-Message-State: AOJu0Yw+T4Df7KCQ/RH7n1q51QYq4heYxp0gUNNDDgSz027pQx7qVqhY
 qZyNfx6SHHjWI2XQCHn/ox6nv08btxAAgxR2gWv0Aw==
X-Google-Smtp-Source: AGHT+IEOGveE4esVbzJJlF7S6DGnhqcZg/wYOGJRrCZjSshakIP3UXM1c4oR8NnnHK0fuFAO8mpvYw==
X-Received: by 2002:a05:6512:31c3:b0:50a:a6d2:b5cd with SMTP id
 j3-20020a05651231c300b0050aa6d2b5cdmr11024543lfe.53.1701090090274; 
 Mon, 27 Nov 2023 05:01:30 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:01:30 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 35/43] configs/linkit-smart-7688_defconfig: increse size
Date: Mon, 27 Nov 2023 18:57:18 +0600
Message-Id: <20231127125726.3735-36-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

Increase allowed binary size to fit lwip code.
  limit:  0x80000 bytes
  actual: 0x84c58 bytes
  excess: 0x4c58 bytes

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 configs/linkit-smart-7688_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/linkit-smart-7688_defconfig b/configs/linkit-smart-7688_defconfig
index 0bdb4e612c..d31f1ab3e0 100644
--- a/configs/linkit-smart-7688_defconfig
+++ b/configs/linkit-smart-7688_defconfig
@@ -22,7 +22,7 @@ CONFIG_RESTORE_EXCEPTION_VECTOR_BASE=y
 # CONFIG_MIPS_BOOT_ENV_LEGACY is not set
 CONFIG_MIPS_BOOT_FDT=y
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
-CONFIG_BOARD_SIZE_LIMIT=524288
+CONFIG_BOARD_SIZE_LIMIT=552960
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-- 
2.30.2

