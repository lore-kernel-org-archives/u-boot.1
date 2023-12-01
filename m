Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8402EC4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 18:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF00D876FF;
	Fri,  1 Dec 2023 19:44:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C8Cc7CiR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C10DE8749E; Fri,  1 Dec 2023 19:44:34 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A21BB87710
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 19:44:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-548f0b7ab11so3001987a12.1
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 10:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701456271; x=1702061071; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LcAUufy3HXLz8SXuY9uCWxgwcSq3fmMZJa3fXoUGJwc=;
 b=C8Cc7CiRZwXfaVMsk/hcGNl4IiJ2L0jV41IvFUJEn5lxPZWa6ZooC6tGC6OAi4I4Pd
 M1DkVzCUTIX2v+yz/ijvGv5Tc6yZmDSPuSPLj8ySUtrY4MphaFLSEut/nITh51P5i39b
 jpFAlFy2h20m7gMhBvJgzsxOHOa9nJlwz+edY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701456271; x=1702061071;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LcAUufy3HXLz8SXuY9uCWxgwcSq3fmMZJa3fXoUGJwc=;
 b=wFnLkmfpWHF329czU8jQYS2tu9dw5/XKWdsqtiER4Ne6UpcL5qQ0i3/FDRX2ih72x7
 aOh5Fqii4nSE4k9lMsyDett3kifaHKjqTdxSouuZ8dfElL4YYVf7OUsrQHzuu1ghgp06
 XDr0ho2jCY7wHm3+LJMDJEruKVMnlPJYVB4omTR4TgH7aEG1i4a7nmLik9ivVrb+xIjD
 1t86VhwZ34YG4/gSQR2LfMetLb7vOV0/xM3lYwWQSn9qD9mMLqWJSXUmbFHrP/H+wYeu
 fs3+CMiWa9YcjdloZObFKEVGTMQs0Jzlee5pqZiiJ4royIrbAsaT94xM1IoRiwmN6viW
 Wv3g==
X-Gm-Message-State: AOJu0YyS5UOkLLNUhSP98NA9LfZODyuYWfkD1tqPjfeCnMDfHoF96oRl
 pVnI2z8ds1SmR438aZgOAHtvwWQP+1sZ9Q506CyBdA==
X-Google-Smtp-Source: AGHT+IFwTEsF9XLJ4zEzqxR9+oPe6+tFCGtmdukKv6z3QKK8fXNIhuSW3xfC0YP+QD27Yn1bCPAm0jpDhUnva+1IQVg=
X-Received: by 2002:a17:906:2dcf:b0:a04:edd6:dea7 with SMTP id
 h15-20020a1709062dcf00b00a04edd6dea7mr962161eji.7.1701456270980; Fri, 01 Dec
 2023 10:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20231126220836.374956-1-i@shantur.com>
 <20231126220836.374956-4-i@shantur.com>
In-Reply-To: <20231126220836.374956-4-i@shantur.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Dec 2023 11:44:18 -0700
Message-ID: <CAPnjgZ2W2maVN14usKHHdyTKyzriP_=iJYpYBvycRxR5zDZW2g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] defconfig: rockpro64: Enable SF EFI var store
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>
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

Hi Shantur,

On Sun, 26 Nov 2023 at 15:09, Shantur Rathore <i@shantur.com> wrote:
>
> RockPro64 uses SPI Flash for storing env, also use it store
> EFI variables.
>
> Signed-off-by: Shantur Rathore <i@shantur.com>
> ---
>
>  configs/rockpro64-rk3399_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
> index 4cd6b76665..f550f2ae43 100644
> --- a/configs/rockpro64-rk3399_defconfig
> +++ b/configs/rockpro64-rk3399_defconfig
> @@ -8,6 +8,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>  CONFIG_ENV_SIZE=0x8000
>  CONFIG_ENV_OFFSET=0x3F8000
> +CONFIG_EFI_VARIABLE_SF_STORE=y
> +CONFIG_EFI_VARIABLE_SF_OFFSET=0x7D0000

Can we use this offset in binman when creating the SPI-flash image?

>  CONFIG_DEFAULT_DEVICE_TREE="rk3399-rockpro64"
>  CONFIG_DM_RESET=y
>  CONFIG_ROCKCHIP_RK3399=y
> --
> 2.40.1
>

Regards,
Simon
