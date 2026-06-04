Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B0DCD6E75
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 18:30:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C74CF84957;
	Thu,  4 Jun 2026 20:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HUhW1TuR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4012849A3; Thu,  4 Jun 2026 20:30:15 +0200 (CEST)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5855084928
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 20:30:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-660456349d9so1414625d50.3
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 11:30:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780597809; cv=none;
 d=google.com; s=arc-20240605;
 b=DEXpQW3qqI3cAUDmf+x5o+NB3D4/nrzvLmS8g1hm0vsmfsMPHrO3NKUaGWlrOaBzO0
 Ox4ZdIOpELkr1q0wei3b13UgcCU1Jiqq27uerwYpCCHSlKE5ti9nsagSt4DpGL1b3mmN
 L3JzSFTgdZmzdo8ofxTHUvnFoNig3Q78GbMgj0V8az0L+KHQUASgSK9A/B9QYKIvbYrL
 s4sPvCBlpBSmNTyXJgH6d9eT55+CjSVnnE+bnqlptrZQAaRmEGwRXYLME2teXtYXGgFp
 j16hU/PO7Aq2CPD2J+ARs72BLzUdEp0nQ6qFNwrJp5CgUZue2YOawJWhmnbwvmkNXMKt
 dm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Kc0L6zeBAIzagsL+chhEJWGvblmqBnz5n/nmKBYkmEI=;
 fh=Ubq2n/ToFTSHUURX1fmzYQxOaEILDlPksjbqvzzOh4s=;
 b=VPo+ENFZmKbclx74vUXqIaR5EeYfPBZYsoXD2xeoNcrEFdtbMgtX221n1DQzclZkih
 S6YZk9aIEXF0EnRjkvd2toKLISqbyVp8IGh60g32GpvTelT+Lh+es7cGF4/skLPzFJCg
 QXjurEdQOf9Vo4YfCkNo2RhEGERMJGisVIdgtulqIncTVF6AtiknHtJQq8jYMrRhQMiK
 5lbahlMIial9J8JhTPIeD2ETx+iZqMqlMHAFm+J/KSpP7drbk3xDYG+xfYEPYGKbgwjE
 IC7kC+YxMaSIDNSCqybCOZ6znssCavVi5qNg6dEbp2WFCIycXdg9TchEZr1dARQmJZdO
 ALaw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780597809; x=1781202609; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Kc0L6zeBAIzagsL+chhEJWGvblmqBnz5n/nmKBYkmEI=;
 b=HUhW1TuRdQ2N5g7Ur0vmmJYqS4mxUPv0wSeb0vuBEOKhM1OUjMwkQ6eGWQFpT3hEwJ
 20/bN0Oyc4nOeOWYjyKkWqONVmRq+6Z0cYgnJyGS1aJiLKQrSN6Bh2TISU/ePusniIK8
 pQl0MLyNRSeuhXlFejsqMEvxDzLxU4eNhVHlBaiaJQ0ujcEE+b1vD8KViVdPXJqFGCU+
 r8l9OByKjSS45QBKlU58drOhsWMP9ONASTYK7V81d6ZjK/BlpOHdQgJlt3QF3l0KYmkr
 zJ+DAd+cTytdEDIPKFH1rwvm0EmrFLg0xxawZRuSKnifCwet6cWRcSvTm2TZ4mhTM6or
 x2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780597809; x=1781202609;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kc0L6zeBAIzagsL+chhEJWGvblmqBnz5n/nmKBYkmEI=;
 b=Qh6XsTuc+wxannnopX5hiGmlP/dfQf3Qf/IkpqJgHAmVdIxzKg3miMA5bEAK1j5Uyk
 UUEd8YkWgFQ4e6BhUUTxc6/mcQt3Sffa0n8YBgpAJjj5hn9KJJ7E16WH9fydxkkPnNxV
 bBmQm09Dnr8qNOVig9MeOlhlA7LZWKhgwp2xqKZI6LgzaYEBug8F20j2Apgyv+25hlRg
 xpZqQ1P2wlL+dM7fSkcK15COVniV5CkGGbl3KDaKss8o5VNoUbj7HyNlzw8x9RIrpRc9
 5mgza6CRkpP1kjczqNs8S+YLzAb5oBNsuUqYqTIU6aPJDeGEXttzb88MxC0s/eytYtgR
 DXLA==
X-Gm-Message-State: AOJu0YzTSo0+K7hIIkr0m7adlQdCTBlHOdjixIEwmYPPV3udW+Ug1Vl4
 Xy/9vkab5g15nhkEiGfH9NS7UVAmNCmbeysbehK1VzlsNMru41aWCeZlqFUmktbllmogjUNBRtL
 H1pG580W8QS3Yjrlay65eplGTXyrWTdGs1cd7L6TR+g==
X-Gm-Gg: Acq92OEuznk7NRfD7qwvU6h8uFORqJBP0xylLNl7msRp151UI8DLOPQihDBFlVKXD/w
 dPr+VgIcW3uT0g1+Ws0zmLSYYzGkYOB0rZSAiCR7PIXZn59zVl/m4VzsTLGr+cQW4/T2P+jwjre
 lfi28ya6F9k4WQ7OcrVLRTB3QFoFSuD0KYNXBj8q72aFoTY/Z43au6sCzz9oh5k/z9fbx46whta
 4QlUwsWCmwwk7ZNJa5U3BoHBtjn8YJP9doXOhRdKSoSsnVKJ3oP04YsU1wNwY8b574RuVVmRiK+
 duHfAyIz5vzx8SDi0HuInpkdu0mZ/20Q9I6uKAEX2DtiPavEmfZt0xUgiiq2B0L/gZdw4YIwYAL
 aUbp2EWS5G4sVCOc3uUnSAUu8Wo+4ibQy7m6eyLQ6aAhynKgCB4cKc4Vea9Rwx4QqUyPrcTENg+
 FdvzmgU1rymhPZNF1CIyU69g/dORz+4v17hqxcERaAmtlTKj1+hBQ6mNAGXtNJferIWl2r1GlWb
 4jqGs1DJzCA5lWRKpPGdT33WNO5Y/QONZNw6h4rsu50+LqA3mgdv7wWoVQafmqFq6ej3jAGCS2h
 G1hJVSqo5Hm6XWzJUdWBwBFi1I0wHKUh/teF6KmIBqVsjgNemJAM7sllWWAOoRLD/9DXvHwZkbY
 v7a917G+pVCznj8j0
X-Received: by 2002:a05:690e:4810:b0:660:321c:46af with SMTP id
 956f58d0204a3-660dc5859b4mr6014958d50.59.1780597808862; Thu, 04 Jun 2026
 11:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260604173330.8586-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260604173330.8586-1-marek.vasut+renesas@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 4 Jun 2026 21:29:32 +0300
X-Gm-Features: AVHnY4LqZHpVsqJZc1MUvp4mkDjqPxKB4mL6xTC21immEeObczDc16XBifxzmDk
Message-ID: <CAC_iWjLMpyk=6MdreLBgZ_bgT7pMB76fpvQpq2-13SOUjRsL7w@mail.gmail.com>
Subject: Re: [PATCH] lmb: Rename LMB_LIMIT_DMA_BELOW_4G to
 LMB_LIMIT_DMA_BELOW_RAM_TOP
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
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

Thanks for following up Marek

On Thu, 4 Jun 2026 at 20:33, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Rename LMB_LIMIT_DMA_BELOW_4G to LMB_LIMIT_DMA_BELOW_RAM_TOP
> to make the Kconfig option more descriptive. No functional
> change.
>
> Suggested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Holger Brunck <holger.brunck@hitachienergy.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sughosh Ganu <sughosh.ganu@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  lib/Kconfig | 7 ++++---
>  lib/lmb.c   | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 29911068a69..cf13ac1bdad 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1295,13 +1295,14 @@ config SPL_LMB_ARCH_MEM_MAP
>           memory map. Enable this config in such scenarios which allow
>           architectures and boards to define their own memory map.
>
> -config LMB_LIMIT_DMA_BELOW_4G
> +config LMB_LIMIT_DMA_BELOW_RAM_TOP
>         bool
>         depends on LMB
>         default y if ARCH_BCM283X
>         help
> -         Some architectures can not DMA above 4 GiB boundary,
> -         limit available memory to memory below 4 GiB boundary.
> +         Some architectures can not DMA above ram_top boundary,
> +         which is after 4 GiB or 32-bit boundary too. Limit the
> +         available memory to memory below ram_top boundary.
>
>  config PHANDLE_CHECK_SEQ
>         bool "Enable phandle check while getting sequence number"
> diff --git a/lib/lmb.c b/lib/lmb.c
> index a2aeb526e29..275d105c5aa 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -628,7 +628,7 @@ static void lmb_add_memory(void)
>
>                 if (size) {
>                         lmb_add(bd->bi_dram[i].start, size);
> -                       if (!IS_ENABLED(CONFIG_LMB_LIMIT_DMA_BELOW_4G))
> +                       if (!IS_ENABLED(CONFIG_LMB_LIMIT_DMA_BELOW_RAM_TOP))
>                                 continue;
>
>                         bank_end = bd->bi_dram[i].start + size;
> --
> 2.53.0
>
