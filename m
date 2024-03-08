Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAF6C54E49
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 02:21:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20F3E87E40;
	Fri,  8 Mar 2024 03:19:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hcmOP8g+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 410F287DF8; Fri,  8 Mar 2024 03:19:24 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF62387D9C
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 03:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5a0a19c9bb7so987273eaf.3
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 18:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709864339; x=1710469139; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oLBC3h18FpN2sMMTDoDqO2i8qzmazm9NrP8JYEZLag0=;
 b=hcmOP8g+82Dn3+i89p6mKn7VIUkGn80hJNalo0IIUGPCqd8DJFLmZWm1tbGevbzZ5Y
 kHxdoh0Cq+3TAplN5MtWj+9Up0w1sdG6lyJ7nWYJZ4myi9LLC5WZ3D2YhSv7mkk0eTI+
 8aGLiiDxVLs09eJ4QwyK1pGcB2zO3vIVq8Wt2otRttv1IzXEDHAwb2YDK6eknOPs4axi
 n8XhCp0jJ+uBwBWTGGDRG4ediQldd3rcwUtBSXafvBJ82SpN1SMqfOfbzRmaobNgfkxb
 qjVxGW2VKvRxkzpkCWxjRQCiN3yOxRvA/81v60d1YS8NkT6Mz4YI+YewKHySL0E9q5A8
 FLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709864339; x=1710469139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oLBC3h18FpN2sMMTDoDqO2i8qzmazm9NrP8JYEZLag0=;
 b=PNzaQY1OD+0d2GpqT8ZiiW6JDRAHfcAie81OZ/LB+PM4MJ+A8rTGMWY9aQz4qESHxo
 LPG3MppJ1QYW1TAcqirxDh9IKNhS4t/gRl2E2YzF571imdbrmyMvgY5s5bW7CYFN/oAS
 H737706e9sUh9HLzvpkUSSLoU80i1K7vV4sYAdGpfhKc6NB5UTm9r2x6whe6Xth4yhLO
 2cddKCklXxFQld0t2u/4hWKq0jYK8vDMjWJ/5sWOJ4GqAx7NsW0SebT/d1PJFVuSo6rT
 YwavWfAibfdqfsL0kFwM9JsRiHjrGP9veloclt+UCXaNkg42G0A5M5E+RytoBAi4VGB0
 K1iw==
X-Gm-Message-State: AOJu0YxrGPoQISNVtF9bAu5G5yn+nEpkC+16Y6r9kq5gFXCKEzoRg8gE
 JeVNJqG9TrzVddhxYU2UqLRmzZoLxMlRIWVHp1H0z7pSHe49k1D5xeOZyfvqE9Q=
X-Google-Smtp-Source: AGHT+IHbmXhOluFGan5HYJt37FBO5NACJOg2NKNAXJGDq69aiUj0sH/zkq3B9jGdyHZ74JZBXPAP1w==
X-Received: by 2002:a05:6820:61d:b0:5a1:27ad:9b9d with SMTP id
 e29-20020a056820061d00b005a127ad9b9dmr11401877oow.1.1709864339576; 
 Thu, 07 Mar 2024 18:18:59 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 a24-20020a4a9b18000000b005a0e30d259esm3647925ook.43.2024.03.07.18.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 18:18:59 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Chanho Park <chanho61.park@samsung.com>,
 Minkyu Kang <mk7.kang@samsung.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH 0/4] clk: exynos: Prepare clocks for eMMC enablement
Date: Thu,  7 Mar 2024 20:18:54 -0600
Message-Id: <20240308021858.28249-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
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

This short series features a couple of Exynos850 clock driver fixes and
adds new clocks needed for further eMMC and SD card enablement.

Sam Protsenko (4):
  clk: exynos: Re-arrange clocks in Exynos850 CMU_TOP
  clk: exynos: Don't expose prototypes for not used functions
  clk: exynos: Fix incorrect clock lookup for non-top CMUs
  clk: exynos: Add CMU_CORE and CMU_HSI for Exynos850

 drivers/clk/exynos/clk-exynos850.c | 326 ++++++++++++++++++++++++++---
 drivers/clk/exynos/clk-pll.c       |   6 +-
 drivers/clk/exynos/clk-pll.h       |   6 +
 drivers/clk/exynos/clk.c           |  47 +++--
 drivers/clk/exynos/clk.h           |  70 +++++--
 5 files changed, 384 insertions(+), 71 deletions(-)

-- 
2.39.2

