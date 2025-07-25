Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B368BC83F27
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 05:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6CEE8390C;
	Fri, 25 Jul 2025 07:09:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q1W5l7Eo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 464BB8391B; Fri, 25 Jul 2025 07:09:07 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61040838FA
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 07:09:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-615a4b504b2so440090eaf.1
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 22:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753420143; x=1754024943; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qGtVv8FzSwtB7llxpA2NsJQRSEo8bod+Lrhjq4C9nTU=;
 b=Q1W5l7Eo1l30TuxmE46wWo2Xk545Yn8BDBNfyFYfAhRRJJsVH4qs+Da9aZQpbnc0NA
 QHvwxaxQqdnI4MaoUFB6NY33so/fSQTKPANSrScjJyRE0ccDv944p+9OInlaKW8cnMw5
 Mau9fcG83mYO013XXOZyCQlZJ0mbBw7jsFDzb2Ys6jeGgnJkIvFKTlciInwzPc/SgmAB
 jcBpDaRcEf/A0iarEiC2xUI9oXTZFH0YhDSNV6DGLByBzP4KhO8eyHoZbCANFesR24R+
 lg8dtn1RVWXTHWqCxyT5igou9+0sHkqcvawdGgUJp2gbsv7oBHwMCTKS1C/IS5dSSY5F
 zaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753420143; x=1754024943;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qGtVv8FzSwtB7llxpA2NsJQRSEo8bod+Lrhjq4C9nTU=;
 b=cF6OKRnXfc386bQ0wGxWsa97KTsXgVT+l+epc5iadhSe1qSYEpRas7Mkp039YpxqrP
 8W2M9FcJPQISjM9ghQEQzBM6ZirL2xo+Sv1GSr3YWap7CFNpWLAjR9T7K8RsFKLAALVh
 aH89VOa4cAPDhETE3gS6LrQA7b1VodmBbB1Rl/Qsxz4z0B7u6WxbXzWaVlJ6OaxY6C3V
 hgXRbaMo3BA3C7tVO7uXQz4VX+4kcZH5wTIdzi8xj0pKnFXZc6Su8SVkK8vrVFS130g6
 VFUnkk09v77eRv9dafADmw6/Jl8NbesI6G9UmpzEgWV0t8/AfAYyiorNCQSlxr36Vw2l
 1mww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTOkCEUL+UBiJd9TZf57uuUrpzu6bPleHqXKz+NA1AaR2ky/ggofzE9X02vW5PrO7MFWSt17Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6BvG75m9sYq4Rs64HYEAQme42DEcti9ECadMTl4ncGuwO96y9
 27YK0aIYOVxAzPIosKAZJwX27uzbooo5SoCMIMsV5F40p7jSVKqeGUdmmk15tZG995wGeLAWG0H
 vuxrvymhBXc0U2XWqbf9wAIomNCfPXAg=
X-Gm-Gg: ASbGncukNrB61XbHSFbSihTrrSZj2gkg/9l2C7mB2QdhnA4IU9ZJmI2PZxKTTn3TJvO
 rAIqMZjEpZOrtpsqgBzHgmm4/BWA6OH8QTdFKBONENwIpjyhLvIXKH6Gr6LAt+OBnp0d6whHCde
 0ZWI4vFkJUXVmnpZnGlPPJNDiExRGfdCEQivbU3POgnugHIWTed5Q4TFLeCS3Hy5ItsghrmTdhk
 c4dHK0IvPozZRfFa3JcRUUwvTN6s0+733HWshkF
X-Google-Smtp-Source: AGHT+IEPHJ/nZY7VXaGo+c5laUU/qH0OUPicPi0ucJrpxJ1W1/rdWHvc76TuSCd0W9/vXufcMsfAHhsMTWTi4+BFClA=
X-Received: by 2002:a05:6808:221e:b0:40b:4208:8602 with SMTP id
 5614622812f47-42bb76d9006mr220779b6e.4.1753420143078; Thu, 24 Jul 2025
 22:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250709222926.24671-1-semen.protsenko@linaro.org>
In-Reply-To: <20250709222926.24671-1-semen.protsenko@linaro.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Fri, 25 Jul 2025 14:08:52 +0900
X-Gm-Features: Ac12FXwcd1g7VlgH7QIwRts0zzUjhTyKIileSw1JDv7MievXIDQjFYyo2Bq3zv0
Message-ID: <CALrBrZ1Si8q_zcRXDxerXshyrwyskS3mwx2ouJt7JSmxGDiQzQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] board: samsung: e850-96: Enable USB
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, Simon Glass <sjg@chromium.org>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,


2025=EB=85=84 7=EC=9B=94 10=EC=9D=BC (=EB=AA=A9) 07:29, Sam Protsenko <seme=
n.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> This series enables USB and related features on the E850-96 board. For
> now only USB gadget is enabled; USB host will be added later. Next
> features are enabled:
>   - Fastboot
>   - DFU
>   - EFI Capsule Update (not really USB related, but DFU related)
>
> All features are tested with Linux and Android partition tables, as well
> as updating 'boot0' eMMC area where E850-96 firmware reside.
>
> Sam Protsenko (9):
>   phy: samsung: Add Exynos USB DRD PHY driver
>   usb: dwc3-generic: Add Exynos850 support
>   board: samsung: e850-96: Setup serial# env var
>   board: samsung: e850-96: Add dfu_alt_info
>   board: samsung: e850-96: Add Android partitions
>   configs: e850-96: Increase malloc() pool size
>   configs: e850-96: Enable USB gadget and fastboot
>   board: samsung: e850-96: Enable EFI Capsule Update mechanism
>   doc: samsung: Describe flashing process for E850-96
>
>  MAINTAINERS                       |   1 +
>  board/samsung/e850-96/e850-96.c   |  77 ++++++
>  board/samsung/e850-96/e850-96.env |  44 ++++
>  configs/e850-96_defconfig         |  25 +-
>  doc/board/samsung/e850-96.rst     |  85 ++++++-
>  drivers/phy/Kconfig               |   9 +
>  drivers/phy/Makefile              |   1 +
>  drivers/phy/phy-exynos-usbdrd.c   | 386 ++++++++++++++++++++++++++++++
>  drivers/usb/dwc3/dwc3-generic.c   |   1 +
>  include/configs/e850-96.h         |  21 ++
>  10 files changed, 637 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/phy/phy-exynos-usbdrd.c
>
> --
> 2.39.5
>

applied to u-boot-samsung.

Thanks.
Minkyu Kang.


>
