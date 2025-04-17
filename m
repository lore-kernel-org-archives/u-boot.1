Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C804EC369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 13:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F11B83086;
	Thu, 17 Apr 2025 15:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j8YRI5bT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C3218304A; Thu, 17 Apr 2025 15:49:48 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A89D83013
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 15:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e5c7d6b96fso1449235a12.3
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 06:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744897786; x=1745502586; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vU5nQDDEKD1wQURIFCyb8KnaALyqO+XNo5kMgOeXNFM=;
 b=j8YRI5bT9pf8tpkowKJIDlaKqYEnqbnwM/fnopB8YF9ohelBrf42FKdFDCieg3wtvz
 23hk9mjZJOecwk7x4DfrLuhLlT+4VIGcNOgBAA0E0O69V7KNp21gjB7aO5rjf4Q8dUrt
 PyA1k9YEb7T4csmR9X65aHO0+1k8LoslSiU7IgLdXTOsO0HDxFVk3jrx/3jFMPsMd2Ve
 z4uVZhqXConR0HW+vJZ3cOWKykpnIb7vv7M5ytPLvgLt999PZYGq9/3raa9XI4mf50B6
 sQqS+QDhmH7s2OKM3HW1Fez4c7oj+SXVt5iaJSM+FNi+eFZ1Mud2Aomjlxj6O63Zsqs7
 14Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744897786; x=1745502586;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vU5nQDDEKD1wQURIFCyb8KnaALyqO+XNo5kMgOeXNFM=;
 b=B2NX0tV532ta2VJXuEcmx2BmIcoDWZZRYPwfrhPYCijGPgnS0/L/FhNS6xt5YuYBwk
 yGNflAe//ihCXRaTvDUQfeQPEV6ZG4k1HOvCqE60MTaE3Bg9HUPalD1B5K38eGBHxb5d
 puJsM5Wwr3cLPHQW3r/9YoYPi79FNwQVi42WmZusXP3rLmAL9pdOcDUubOLquF3NtTRc
 s1Q8xYIUi7A14XroBZbWRYXEGcKdfj1y4UfCY4piwuoJHRx3Y7sKDWkqUaCNbRCRm0Ci
 ZQwWMByt74+mwgf//7q9cq+oY4ALk85qu9IkQDzuY9r52Pl25fAUFdZGvs/LRG9kEP8m
 whVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfXu6kXcOetfuaapEiDEmYCduAzxqWOxjcP5d4MtFZgu/6LNNe2kiDg8mAlbBMh4krTOOtWf8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+APfMNjEFHO2KmQarRMybTAEFndlSKLHTF/9F5OFkUiSiqGWX
 /dtk53xovN/pQrOv+QpWTnl8zLfJ2KmHy1gQxfrcDY4Y1HocuModqUKb1gAFgcg=
X-Gm-Gg: ASbGnctTOn249jgVTvFIEhA6fSFVocCSjwZHHUJG+N5qnnomY2ImNPw13ddVTih1U/7
 HecylFqPtWQV/hPW8bwzCawFWjaUQP/75tF1ienC6Q2PqJ5q3dC1qfpzRrnKWRcKoKsFM4bF4xC
 +31ihfJolSJgBDIFOTD+suiuFb3pR86eH9R9QVMW2qpWXS0yB37HNNzC0FFOCE5X6PG5tdpCyaQ
 AutEPAgPn6oE4RXufv8KRMcO0TKKE+ZpWgGIBsmB417UqvHC2oN7QpDYsR0xv28wFMX+ledPxL2
 CYyPbxHk6FH/nYWWGk4KSA+Rt+jlqm9AospQex6RHnDs6zcWBL8Y
X-Google-Smtp-Source: AGHT+IFVnC+zze3jXVD1JbEmBRZw8HnHufOtlvxefUZI3xIgw951kCCSW42tVoME8jQi/8UO8W70AQ==
X-Received: by 2002:a17:906:c10f:b0:aca:d2f0:d291 with SMTP id
 a640c23a62f3a-acb42869f20mr635087166b.5.1744897785603; 
 Thu, 17 Apr 2025 06:49:45 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:893:de18:edbc:9b79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb4d5bc6fesm171515066b.37.2025.04.17.06.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 06:49:45 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Thu, 17 Apr 2025 15:49:12 +0200
Subject: [PATCH 2/3] board: dragonboard410c: Drop custom reduced malloc
 size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-db410c-fixes2-v1-2-76ad994da152@linaro.org>
References: <20250417-db410c-fixes2-v1-0-76ad994da152@linaro.org>
In-Reply-To: <20250417-db410c-fixes2-v1-0-76ad994da152@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Sam Day <me@samcday.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
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

At the moment, the dragonboard410c_defconfig specifies a custom
SYS_MALLOC_LEN, lower than the default for Qualcomm boards defined in
arch/arm/mach-snapdragon/Kconfig. It looks like it's too low, since
flashing larger sparse partition images using Fastboot fails with:

  FAILED (remote: 'Malloc failed for: CHUNK_TYPE_RAW')

We are not really that memory-constrained for U-Boot on DB410c, so fix
this by just dropping the custom malloc size and using the default.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 configs/dragonboard410c_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
index 449d48a3c004117b832ad620d49beb681a9bda68..6feba70b943ecafdb96de28b4bddc36095f089c6 100644
--- a/configs/dragonboard410c_defconfig
+++ b/configs/dragonboard410c_defconfig
@@ -4,7 +4,6 @@ CONFIG_COUNTER_FREQUENCY=19200000
 CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
 CONFIG_ARCH_SNAPDRAGON=y
 CONFIG_TEXT_BASE=0x8f600000
-CONFIG_SYS_MALLOC_LEN=0x802000
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x8007fff0
 CONFIG_ENV_SIZE=0x2000

-- 
2.47.2

