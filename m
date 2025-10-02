Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9F8CAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 16:30:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF73181D6A;
	Thu,  2 Oct 2025 18:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IPjaxkH9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D56A828A2; Thu,  2 Oct 2025 18:30:13 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA60B8004F
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 18:30:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b3d196b7eeeso202770366b.0
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 09:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759422610; x=1760027410; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yIU2CYkzoPBqnwkQKfQGC85LAG1Kw94zVJEKZMs6yAw=;
 b=IPjaxkH9h3RyC0W/BBF19ohQAOgyui2oYZeTR2WUKsrrYUJ5RseuUoaVNO50zqfRCs
 znRenGpBmmh50WLYP/iBkm01oinbivfoA1C53EZ/DLQPoVQn9298DAXX2HSwry9RHrgr
 dMMqaO0MIbC4p+ve0M2n5EFg8QTMoHYyX/9CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759422610; x=1760027410;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yIU2CYkzoPBqnwkQKfQGC85LAG1Kw94zVJEKZMs6yAw=;
 b=b9h0eh9BASFFAwZ9juo46gBmK4Fjof70hFO3PcsHptkdhNWopXs1eHo8lsLQU/MIzM
 aNMf+m5OYJFzIcph0VtD5bVgBmarwp+7htEECniWR+/CI8iTZQATqG9zvUw2wwEx/SQt
 hkawoh4QTBUoUKkhuKEMUquClW7h/UF+TD4KOt50Nn2O0SNtF99CQEZj5Ks09VsFQFfr
 ++dQFQdaMoimP76ye2mN7DBWejY1blNONk6eRqr8+zkajn0CWCGzxGSxyi/VJeyUHeqA
 E1DWS6FuLgodp/aIPkKuxf8Vq/ieGw0TSJR980AZpANnUPv1cOoEfBJR77PNinE0Sd4F
 pGzg==
X-Gm-Message-State: AOJu0YwDa2tub3to2AzMupYGU3D2n8UzIXlL7UXTYzR4mMi2sh3XI96p
 wsj3TFNWlWfV1nWMIvNlyYyYsPpnL52NBHr6sddWyHugMUvCldobqQqZZ0cYYLvWx8GH9LfbAP+
 Vbv7fge7nrII47Sbo99UtX6Yg9mYk/Mm2GNxOSxWiJSfaSsmpbzWVqQ==
X-Gm-Gg: ASbGnct+VBDYrc02d1SKbt1nEFgHakTZE+TcJwQdsr8RDms0xg0FBOM1zT91NwNzUvT
 rshCPWNhhr3qYfBXwqPskYJn8RPad1rcbaRnsd6eGbIEb39Tw5MbSBSXjaEFx/GFgNJzHSqTz9f
 hT7vf6OfLamqbVTsW6XuPs9cG9GRZqhpuYE4erLgAinma6U2YJEpyX1PvTV9Ms9q7D4GT4irrF6
 0e5Qa8xkzluZ027blp7m4nAALYfdA==
X-Google-Smtp-Source: AGHT+IGRHzsgwRkOadDR+DZoyWL6fHq3I9ukltDwbGm1rjQl4E372doF1GE5vkIFlX6j+jMnFObz1Aa84PSagEh249s=
X-Received: by 2002:a17:906:c144:b0:b40:b6a9:f704 with SMTP id
 a640c23a62f3a-b49c146e5b6mr9063166b.7.1759422610296; Thu, 02 Oct 2025
 09:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20251001203059.2828551-1-trini@konsulko.com>
In-Reply-To: <20251001203059.2828551-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Oct 2025 10:29:58 -0600
X-Gm-Features: AS18NWBoZek-yvMo1WH7-cT_mj9coc-waKXCuCragVGwB-HQFUQw4Yu71j0MLwQ
Message-ID: <CAFLszTg8BFgpeYj7Gz-9ac5TVLaJJ5fs87oSeOfurSNT6dCa3w@mail.gmail.com>
Subject: Re: [PATCH] boot: vbe: Make BOOTMETH_VBE_xxx a choice
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,

On Wed, 1 Oct 2025 at 14:33, Tom Rini <trini@konsulko.com> wrote:
>
> It is not valid to enable multiple BOOTMETH_VBE_xxx methods

Why is it not valid? That wasn't my intention.

> , so make it
> a choice as to which will be enabled, and make the default choice be the
> current default.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  boot/Kconfig | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index eff05948b3a1..f21a67b2d3ee 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -712,9 +712,12 @@ config SPL_BOOTMETH_VBE_REQUEST
>
>           This is only useful if you are booting an OS direct from SPL.
>
> +choice
> +       prompt "Method for VBE to find the correct bootdev"
> +       default BOOTMETH_VBE_SIMPLE
> +
>  config BOOTMETH_VBE_SIMPLE
>         bool "Bootdev support for VBE 'simple' method"
> -       default y
>         imply SPL_CRC8 if SPL
>         imply VPL_CRC8 if VPL
>         help
> @@ -734,6 +737,8 @@ config BOOTMETH_VBE_ABREC
>           verification step, a recovery image is booted. This method will
>           eventually provide rollback protection as well.
>
> +endchoice
> +
>  if BOOTMETH_VBE_SIMPLE
>
>  config BOOTMETH_VBE_SIMPLE_OS
> --
> 2.43.0
>

Regards,
Simon
