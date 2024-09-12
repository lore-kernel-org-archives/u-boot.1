Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E23EE57FB
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3367A88E0F;
	Thu, 12 Sep 2024 03:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dAhoNqVY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7B8188E04; Thu, 12 Sep 2024 03:01:22 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BBC388E0F
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71781f42f75so294900b3a.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102879; x=1726707679; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Gf5EQiCmriS8giBBP/T9/9IFh6MmSWA9BuRUM2f5VD8=;
 b=dAhoNqVYB4aHDg43IQvr4z1DK7k/J1wgF1XCkt4TSZdPaDZD8yd9xfCPIR2OdYiKpa
 GHas16EyaHElfaoop81FkTD8pJrRlfUX+LxcINYuWKa5pKdZ56JQX5+zqQ0/58fec9EQ
 opuYMkaFBlEl0/br/PqKKQN5n6dHJSQfnP8bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102879; x=1726707679;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gf5EQiCmriS8giBBP/T9/9IFh6MmSWA9BuRUM2f5VD8=;
 b=IhwdY1/g7r+uKmy7ijKOpdTf0zciVmfkm+px2KiA5hFv0Yj+sojxhcHhUWdsEEz4xz
 8lxWc+aABCGBuvetIGO6BR/bB2qT77mxu5U9Jnyfit8v7qmBnbvvAgWcSxGFqM2J+Sue
 AA8p8Rz2V4x7N12VHlhzbR4CRBBc8AU5zRsEo74eyj6/iYEqg652VuaJH8H1R1U+PPU7
 d4SMqy4LVrzfO24gXd14LYuMdXIImQTT+UUtRVVeOc8d6etH+03Hi7GBTUh4uxUAF1Hv
 sJwzfhZHvIKnlQcCpOnVUKqWUARChT3jycIGgFdeMJiW35uxCBF9oR4rukV8dMBOhAo1
 9Ppw==
X-Gm-Message-State: AOJu0YyU/5dr6btHxvM7hB9J8SfEq0vlXUt41GZe+UDcTZ7mhdI74CKf
 qfR+NrCAhZgavlq/IMCUFvQnks7H4KvxOcX7TdJa15kjLjFDIiAgLaK0pGudLXBQQ+PPFz1NMpr
 A+eBIQu1JfFW0VFitrG88WDsorjZxUXAi+Wtj
X-Google-Smtp-Source: AGHT+IEvXIuL2yhP5ER8fVkJrJHiW5Qcq2UCbHZCJ9RcknjbJ+tIZPSf0ytLHEf8SoqlZb6PRvW+JzlKZsqOF44FMZE=
X-Received: by 2002:a05:6a00:4b16:b0:704:2563:5079 with SMTP id
 d2e1a72fcca58-71926211ddemr1784956b3a.27.1726102878647; Wed, 11 Sep 2024
 18:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1726048404.git.jerome.forissier@linaro.org>
 <b7c378d570e12b0d619e291953deb2b333b16966.1726048404.git.jerome.forissier@linaro.org>
In-Reply-To: <b7c378d570e12b0d619e291953deb2b333b16966.1726048404.git.jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 19:01:03 -0600
Message-ID: <CAFLszTievnwczV9ULQNcgp=JAah0EQ3ng5_rYFJWLYhWZBRrOQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/15] net: fm: call dtsec_init_phy() only when it is
 defined
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Jerome,

On Wed, 11 Sept 2024 at 03:59, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> dtsec_init_phy() is defined only with MII so add the proper conditional
> in the caller code.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  drivers/net/fm/eth.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

>
> diff --git a/drivers/net/fm/eth.c b/drivers/net/fm/eth.c
> index 19f3f0fef07..63fe4b2d33c 100644
> --- a/drivers/net/fm/eth.c
> +++ b/drivers/net/fm/eth.c
> @@ -26,7 +26,8 @@
>
>  #include "fm.h"
>
> -#if defined(CONFIG_MII) || defined(CONFIG_CMD_MII) && !defined(BITBANGMII)
> +#if ((defined(CONFIG_MII) || defined(CONFIG_CMD_MII)) && \
> +     !defined(CONFIG_BITBANGMII))
>
>  #define TBIANA_SETTINGS (TBIANA_ASYMMETRIC_PAUSE | TBIANA_SYMMETRIC_PAUSE | \
>                          TBIANA_FULL_DUPLEX)
> @@ -701,8 +702,11 @@ static int init_phy(struct fm_eth *fm_eth)
>                 supported |= SUPPORTED_2500baseX_Full;
>  #endif
>
> +#if (CONFIG_IS_ENABLED(MII) || CONFIG_IS_ENABLED(CMD_MII)) && \
> +       !CONFIG_IS_ENABLED(BITBANGMII)
>         if (fm_eth->type == FM_ETH_1G_E)
>                 dtsec_init_phy(fm_eth);
> +#endif

Ugly! I wonder if we need a special Kconfig for this function?

>
>  #ifdef CONFIG_PHYLIB
>  #ifdef CONFIG_DM_MDIO
> --
> 2.40.1
>

Regards,
Simon
