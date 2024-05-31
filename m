Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3B4C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 06:51:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E39278829B;
	Fri, 31 May 2024 08:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mQ3/i9Uc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8245488783; Fri, 31 May 2024 08:51:11 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D076B88270
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 08:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f62fae8c1aso6604295ad.3
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 23:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717138267; x=1717743067; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j3Z6o1q8FPsL2CH32O1xnmgvinKXcC30K0341iHMR0o=;
 b=mQ3/i9Uc0BkSvpcgedA8GcvEJx07D6gFuTXjX1wNOa4b3qVvr5GmVW7WQONHxzMBkE
 yt/tb2NamO30xm0LUe0g7bfPTa0+t8vUlzokjUGlG2b3NGS5J73HpSi7EeATioYI4byd
 WOGMVhNn4Rdbgvlqknc4Vt04/zGe9RdN2yRBmKGSl6HHUEhNjAmM6zZjusajwuWkZnju
 KDQ6FuhzjpvJTMLekqrOmS4VceLspuV91yaKf0Nk1q2HcIojU32mH32KBzhZGEN7+sW5
 6L20Bthpi4vK5JmqFrZT0TFzJCciZMD0+EJH84EhmbDgJBRYIY1y/Gmz+ClsZOwMEe7J
 N86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717138267; x=1717743067;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j3Z6o1q8FPsL2CH32O1xnmgvinKXcC30K0341iHMR0o=;
 b=vko0GLTl0kXzoX/s98/COvRgejBOedFq8ZftaOBIARtWvLHhpkTo1PcnzK7JUH8B+k
 FM92HKWsVl0wRipkR7JNYiAyF3WLzztubgc9m6IYD3BEHO7KGNiXKdquWUyXve3jM+Zt
 HKHpC54uTHFE3v+pw4NDXqbNgcGhZZzsuDxZDaM7L4zd5HmpNTaez5h1PSZHNxA9sbCZ
 mu6BJbz17tUKRFYNk0y2S23kr8oHVIyK/H1O8Aok3Jq0f0yN2uWUSe12nkJL73Nqgjhh
 Hg1uD7LgqsNEADrRlXiENfD3pADnYy64ds0VWe3Klh3xpcIwT1jH6qX45sGJNHvRZAkW
 spPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2Q529DQpLN6ykKR2QT7Lqw5pl8Hip8lCu3OfaqS6qbrg8NcG3pUJ+bgE2UtnP8S8CzCiXTSClknL1/tf344ja0ocpcw==
X-Gm-Message-State: AOJu0YyuewhT4lrHwV9eTGk3v5EuDOEzgD1YPgaYb6QOs95dpF2QujWv
 y4SU9nVLRoeNkKZ2i6S7BMxwJN4s01pTXjSmtmhPd63bYcaPGAVdQzYy5KN44apTOIuAMzTys2I
 7ttD5a+P4M0iV921okP6vPBbra6EBjA==
X-Google-Smtp-Source: AGHT+IGQ2hpyTJ3Rd6GfRE7B5m5ZMItYZIWJuh1mGELRP8mhIGtPiSPPazYzS2D5yyFTztOm5DHZvgvzu3yTxa9jQZo=
X-Received: by 2002:a17:90a:f98d:b0:2bd:dce4:8f90 with SMTP id
 98e67ed59e1d1-2c1dc560445mr907947a91.6.1717138267214; Thu, 30 May 2024
 23:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240525211836.15511-1-semen.protsenko@linaro.org>
In-Reply-To: <20240525211836.15511-1-semen.protsenko@linaro.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Fri, 31 May 2024 15:50:55 +0900
Message-ID: <CALrBrZ18e4k0EGk6dBBR73yXcRgdrs3CYUx-pQb1nzSZzCCsOA@mail.gmail.com>
Subject: Re: [PATCH v2] arm: exynos: Migrate E850-96 board to OF_UPSTREAM
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Sun, 26 May 2024 at 06:18, Sam Protsenko <semen.protsenko@linaro.org>
wrote:

> Use upstream device tree files and bindings. To do so:
>  - imply (enable) OF_UPSTREAM option for E850-96 target
>  - point DEFAULT_DEVICE_TREE in E850-96 config to upstream dts
>  - remove now not needed local dts files, binding docs and headers
>  - update MAINTAINERS and board/samsung/e850-96/MAINTAINERS
>    correspondingly
>
> Upstream device tree files for Exynos850 SoC and E850-96 board are
> pretty much the same as local (removed) ones, so the conversion is
> rather straightforward and painless in this case. The appended dts file
> (arch/arm/dts/exynos850-e850-96-u-boot.dtsi) stays unchanged.
>
> The only remaining local dt-bindings doc for E850-96 board is
> exynos-pmu.yaml. It wasn't removed as it's quite different from Linux
> kernel version. Particularly U-Boot local version of exynos-pmu.yaml
> describes "samsung,uart-debug-1" property, which is not present in Linux
> kernel binding. Later it might be upstreamed to Linux kernel, and once
> it's done the U-Boot exynos-pmu.yaml binding can be removed.
>
> No functional change.
>
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - Updated board/samsung/e850-96/MAINTAINERS (removed board dts entry)
>   - Added "Acked-by" tag by Sumit Garg
>
>  MAINTAINERS                                   |   7 +-
>  arch/arm/dts/Makefile                         |   1 -
>  arch/arm/dts/exynos850-e850-96.dts            | 273 ------
>  arch/arm/dts/exynos850-pinctrl.dtsi           | 663 --------------
>  arch/arm/dts/exynos850.dtsi                   | 809 ------------------
>  arch/arm/mach-exynos/Kconfig                  |   1 +
>  board/samsung/e850-96/MAINTAINERS             |   1 -
>  configs/e850-96_defconfig                     |   2 +-
>  .../clock/samsung,exynos850-clock.yaml        | 307 -------
>  .../soc/samsung/exynos-usi.yaml               | 162 ----
>  include/dt-bindings/clock/exynos850.h         | 337 --------
>  include/dt-bindings/soc/samsung,exynos-usi.h  |  17 -
>  12 files changed, 3 insertions(+), 2577 deletions(-)
>  delete mode 100644 arch/arm/dts/exynos850-e850-96.dts
>  delete mode 100644 arch/arm/dts/exynos850-pinctrl.dtsi
>  delete mode 100644 arch/arm/dts/exynos850.dtsi
>  delete mode 100644
> doc/device-tree-bindings/clock/samsung,exynos850-clock.yaml
>  delete mode 100644 doc/device-tree-bindings/soc/samsung/exynos-usi.yaml
>  delete mode 100644 include/dt-bindings/clock/exynos850.h
>  delete mode 100644 include/dt-bindings/soc/samsung,exynos-usi.h
>
>
>
applied to u-boot-samsung.

Thanks,
Minkyu Kang.
