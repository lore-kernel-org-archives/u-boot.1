Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD16C83F17
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 22:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E758783631;
	Thu, 10 Jul 2025 00:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ksqsj85r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E65E8835AE; Thu, 10 Jul 2025 00:29:35 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC3DD8360D
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 00:29:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2ea58f008e9so310972fac.0
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 15:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752100172; x=1752704972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WExysI8xFyI0y1ZwswUkk4HLs1iSkWMWcof5IoQY6Jk=;
 b=Ksqsj85rJT/xsnc7/k1jULlWOTj2lqsq681tPy6xH0VDyLe929ioRnyqfjMAW/vYsi
 NetAKlGRULH8YSYDh1X0fAnhxzD1EQDuwpKqloLCkZ0bUQF+aus9oxp8I9ODFEylCqr4
 iKP7YxAynsHVgcYG81HLJQFTBOEC4sxX8a0fKlRNkwqAK3CwpfEgvvk0PMIcxh/8pwKI
 UcYw0QXwTvRVIfYFT8AcmUMQHJCIeVAvoIGwEb6LcKLrI07qYsWNefsJIbZHd+4wV8D8
 TAuZ8XmbBv4l1ZMAk9SmjfxJf/jzVZyzoxjVQun2X5hEy6dG+5hDsPCweg6p7W9JGKmB
 nM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752100172; x=1752704972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WExysI8xFyI0y1ZwswUkk4HLs1iSkWMWcof5IoQY6Jk=;
 b=IHyt1F1O0eC1u1oHJNDpmR/df8g+niSkwk67dA7vg7EYMm3hks3x3FwyjhbRO27pAW
 UOHF/heE+F1OwbP1mqV56aCssYdcbDyolJXqtP7PjklXGxWSDkHNmJ4m7R9f5d0sadhA
 WlfT5doeYOZEac0j3DvEj78zVPGDwSBqQq9hHbuHw1WrqF4FsrRb+oi6XpjafoQy4iil
 gm/CGoNICFsDdag/H8J4tAj+ISf4jrKgxFwDng62P2iPEl9Gngm8YQDhKdxi5RSBJmDf
 RctYFHMATdssRkLd0kA005p5LcEEeMt5DRXETGC3dFWm3P/9sY9BL3lS74m3LZKXk6C7
 NhcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCj7XwOJS21/memebVNHkUhtH5A4CXNrfwEsARBaCe580oDr/pVmYDwyIOq7tMy7GqNqq/AiQ=@lists.denx.de
X-Gm-Message-State: AOJu0YycGF1ugk0DxqZXquaJSIHpweFEvXRDVgFME6sAC6mFmptoiB6K
 kxbpAg/1CodVddBKdOVRPK+5NLqTKk/D3OB+JB194APRyrwraVv7afflUL63e+k3we4=
X-Gm-Gg: ASbGncuDLFYV4EBrIx13yyTbheZmsgobQCOWEOsggY14FUrQeE8IkxKL4MSmpTvgJdn
 u7oEBvImbsk2KKVu3h4CAlIMX+joGofN+0Oser3ORzOo7pn7qR3UP1Lmc7trQzti7SKrDXI8sma
 zx67LrPA8enC+RuVgflgHVrrXc91egsBg2QbUWYQXwoflWgggXdxgKPdL6gjAavWwBHbDGVTCFa
 KDXqIzXGojUJ/aAjAMK5NGunzVbUbM0u4M2HPmIREgoJgo+/2IJQrQgmvMFSF60Vmnv6yJk71k0
 Dur8D+/lxQWECjZgS2/m5MrvIWSmhdahC2JAzvQBcab5MCkV0Nzew6nDsDElwrBZmo9xkmOe
X-Google-Smtp-Source: AGHT+IGwtfvCvdRU8JGwgiQTR1F/fH4ZZBnSAAT/rBbMwWUOgro7C2FuN6vR4h1pfCfdXfvZSyBlxQ==
X-Received: by 2002:a05:6870:529:b0:2da:843d:e530 with SMTP id
 586e51a60fabf-2ff108202f2mr341908fac.2.1752100172514; 
 Wed, 09 Jul 2025 15:29:32 -0700 (PDT)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff116d68a8sm42769fac.38.2025.07.09.15.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 15:29:32 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Minkyu Kang <mk7.kang@samsung.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Simon Glass <sjg@chromium.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, u-boot@lists.denx.de
Subject: [PATCH 6/9] configs: e850-96: Increase malloc() pool size
Date: Wed,  9 Jul 2025 17:29:23 -0500
Message-Id: <20250709222926.24671-7-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250709222926.24671-1-semen.protsenko@linaro.org>
References: <20250709222926.24671-1-semen.protsenko@linaro.org>
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

"fastboot flash" tries to malloc 8 MiB buffer after receiving data over
USB and trying to write it to eMMC. Right now only 8.12 MiB malloc is
available for E850-96 overall, which leads to this issue:

    Malloc failed for: CHUNK_TYPE_RAW

Fix it by increasing malloc pool size from 8.12 MiB up to 32 MiB, like
it's done in many other boards using fastboot.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 configs/e850-96_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index f0e9ff7c4470..375805b3e5ca 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -3,7 +3,7 @@ CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARM_SMCCC=y
 CONFIG_ARCH_EXYNOS=y
 CONFIG_TEXT_BASE=0xf8800000
-CONFIG_SYS_MALLOC_LEN=0x81f000
+CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_ARCH_EXYNOS9=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-- 
2.39.5

