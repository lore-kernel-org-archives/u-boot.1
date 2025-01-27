Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92201C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 15:23:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF4F781417;
	Mon, 27 Jan 2025 16:23:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h3fJEQf+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D84798142D; Mon, 27 Jan 2025 16:23:27 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B8CF812C8
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 16:23:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2166022c5caso71204095ad.2
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 07:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737991404; x=1738596204; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ctcoGGLDTONhwYm8K5pa/YaFYRxYhpD4gxDsnsQBa5k=;
 b=h3fJEQf+E0rys3FlnZZxrKBlqnyTufManlidOsl+ghE/JSFyhxq5zukjzDODppANqr
 jDUjcpADi8Kx2keE6pvg9d4tjzF5MbujlQSbsrOa5ygZPErdhUYn1F1dE++1d9qcX/GP
 9y2xmOq4MZcDvs3QjmB0U9JclkGky0qLBK6rqsV3/MvKFfD75upCAEllv/0xd0aAS6CR
 /qDGMUI3bghJ+6taEL+YfD0D5KqOLwJxqX3QSEbxk/VpL0nMmaGmBVikk1Y9/LynBu/R
 Ha7Iytzc7fj38gr5NETXTMqo4+2yLCBvFJMKYVIZ7xjttSMyr3DSn8o/R6gWaT9uAcKY
 0Jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737991404; x=1738596204;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ctcoGGLDTONhwYm8K5pa/YaFYRxYhpD4gxDsnsQBa5k=;
 b=SoF8Zas7azsKRofSA5EB2YcHEDIYtQUuaDve+braludE5tvQFGEMYINk0NT3hkXFc0
 +AR6OhdyFR2FPSPO9Uqru+s0nfYhc+2e5EQyJ7SRE4cenBKaVd5CS3SEZo/5mpFGo0Fo
 7JbfO4SHMi2P/sbzDjaIUhH4LqXNr1Bkz6K4iarPSTbR1Qztlb1FdZTLBOPaPPLb8EeH
 ZFc9GPAxtrc3JaCmjIGdLp5huqAoUlJ4epA/2TRw0jbu1/FzCs1BVj4NXE0VTHmoPaOQ
 gIxex5zQ7BgCAldvRcO2j3an0trKMgn2BSPiat65ELGn+YHVY8RJICvEAr4teCQYwJ+v
 5btA==
X-Gm-Message-State: AOJu0YwKlDNREseBxQuXW9H8Pwhjp1FNAuU+0YrwWV1kXRnu9siBGga0
 THqbZdWvos7tg4Y4q8DzG0VBX2sxBEyUJIx7zZNmab7FvHF1vM+dX60iTpifUeT+lkyEmQIumgs
 KL61rLjh5RioFuR+m/8yEWN2LFTSFTvKJ/+lgwg==
X-Gm-Gg: ASbGncvh73c2iCZOuvqjBxlGSFDFUfDEBcK71p33XfPrJI9/i8A/xT0bKwMENswt/Rp
 tDpi/Yjs8PqOyWnMpXYK6lSyKPxs1VWeg3JJm8R+ZLmlOgvAkcsInZxdCggbZtKj/LegoeocXzK
 Z6jo6pgtOgrXUYGhOii8E=
X-Google-Smtp-Source: AGHT+IGXtfYx5sBUxScNGkh/o1JTvsQ/rgO2oWGmGLsrr4aNYrB5OKIOTaNh2cunrRdTp2FCgKQLWEDpWeoGoZo3JZo=
X-Received: by 2002:a17:902:ce0c:b0:21c:e34:c8c3 with SMTP id
 d9443c01a7336-21c35540560mr723183435ad.24.1737991403706; Mon, 27 Jan 2025
 07:23:23 -0800 (PST)
MIME-Version: 1.0
References: <20250126184333.4058848-1-sjg@chromium.org>
 <20250126184333.4058848-2-sjg@chromium.org>
In-Reply-To: <20250126184333.4058848-2-sjg@chromium.org>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 27 Jan 2025 10:23:12 -0500
X-Gm-Features: AWEUYZkYwu9iO58ZuSmVMLUGpmmMHelC3FZ9d1IHcrdmtUZQNqupiepOQcgDiRI
Message-ID: <CAEfUkUJPVLGCoThrP3ZcLwY283FYm2CcU52XDEmguKj0mKSc3Q@mail.gmail.com>
Subject: Re: [PATCH 01/19] mbedtls: Add SHA symbols for VPL
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Simon,


On Sun, 26 Jan 2025 at 13:43, Simon Glass <sjg@chromium.org> wrote:
>
> Add some symbols for supporting SHA1 etc. for VPL.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  lib/mbedtls/Kconfig | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index 78167ffa252..81274786106 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -112,6 +112,46 @@ config SPL_MD5_LEGACY
>
>  endif # SPL
>
> +if VPL
> +
> +config VPL_SHA1_LEGACY
> +       bool "Enable SHA1 support in VPL with legacy crypto library"
> +       depends on LEGACY_CRYPTO_BASIC && VPL_SHA1
> +       help
> +         This option enables support of hashing using SHA1 algorithm
> +         with legacy crypto library.
> +
> +config VPL_SHA256_LEGACY
> +       bool "Enable SHA256 support in VPL with legacy crypto library"
> +       depends on LEGACY_CRYPTO_BASIC && VPL_SHA256
> +       help
> +         This option enables support of hashing using SHA256 algorithm
> +         with legacy crypto library.
> +
> +config VPL_SHA512_LEGACY
> +       bool "Enable SHA512 support in VPL with legacy crypto library"
> +       depends on LEGACY_CRYPTO_BASIC && VPL_SHA512
> +       help
> +         This option enables support of hashing using SHA512 algorithm
> +         with legacy crypto library.
> +
> +config VPL_SHA384_LEGACY
> +       bool "Enable SHA384 support in VPL with legacy crypto library"
> +       depends on LEGACY_CRYPTO_BASIC && VPL_SHA384
> +       select VPL_SHA512_LEGACY
> +       help
> +         This option enables support of hashing using SHA384 algorithm
> +         with legacy crypto library.
> +
> +config VPL_MD5_LEGACY
> +       bool "Enable MD5 support in VPL with legacy crypto library"
> +       depends on LEGACY_CRYPTO_BASIC && VPL_MD5
> +       help
> +         This option enables support of hashing using MD5 algorithm
> +         with legacy crypto library.
> +
> +endif # VPL
> +

Do you mind rebasing this patch on top of my series below?
https://lore.kernel.org/u-boot/20250127151657.648255-1-raymond.mao@linaro.org/

My one has refactored the entire mbedtls kconfig submenu, makefile and
default config file to adapt with XPL, so that users can have
independent config options in both U-Boot proper and XPLs.

Regards,
Raymond

>  endif # LEGACY_CRYPTO_BASIC
>
>  config LEGACY_CRYPTO_CERT
> --
> 2.43.0
>
