Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CC8CFD316
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49662892B1;
	Fri, 11 Oct 2024 12:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xbFg9he0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE786892B8; Fri, 11 Oct 2024 12:18:59 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CE8A89155
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7e9f98f2147so1132737a12.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728641936; x=1729246736; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HVLpa+7rhJHDWsslaX55HKJebo3m2WvM/kD+yViEGl8=;
 b=xbFg9he0ICZTpZHWw/Nn2Z6YfHDsgCAGYu7QNEHXwMTGlLBkqEguK3jcFfi5vWnCzP
 oCpvmoHE/wHH2nleWFoCHtitA2TOrEwgJyY9zH2W2CfcLq0EVD5z1V/Dsbh8LXR6Oq48
 xZYcDv/8QX1376GXn5vqutwRGTIcEMfKcSbz4zBe3lI1AZW5IHfnyzC/2P1adr672PoV
 ho9zGtw0yBfjyOCkmGgG11o3Mmmmc1SFuftgXn7f0vPfkFppluMQxh+UT3MQ5/qOf0az
 dyW1PNeyoftiAHRGdOFStLgr8tsj9gOQdDdQpctPzsloAmU6dKkUpeFt96jgnW0dbfAM
 2+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728641936; x=1729246736;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HVLpa+7rhJHDWsslaX55HKJebo3m2WvM/kD+yViEGl8=;
 b=SDNioKhIobMZZBujYI+X+Nkl3MjDoCN1tf8M5mSamb5oaeJjfh+HTrmeN3zhyNgTZw
 5Y1laBIkYVR57LTm8F0JKhSFmgJWPOoa8xOTUYI5QEL2Ux0SZwJBZ2Q8tusMd6rjIyyq
 bdBZlOdjSfkp6ki7gApmVUmlZQiu73yz+aAA7HPtRb2dko9gXj3G7g1HSzSDDNYp7dHR
 oFPqu8ZQpk2gv3g8MJ7slTTG2ZS4TwdzWyWhFREYIgZqKkb0TXj1SFx7uhyQdgPM4dnr
 V4QTFylwIu2ucZndWxavadAVjqsD0j5SlI3CnqnfAGJoA1VA9D0+g/YZHrVC+pTFAgc0
 04kg==
X-Gm-Message-State: AOJu0YyabHdacK152/mLdVNp44YZfih9/LxuBqbCuaivwunQ2KAB8Xuy
 SF/kKhGgarErfvl7nc4pPN5+CEWt5oO317aCIeocwPH0nJwYRBpE8l6QvqXHQWW3mF9h1eUVibf
 EkBTkAAVyW2ynQNbbFPLcR83LOjsLtCR8Thypyw==
X-Google-Smtp-Source: AGHT+IHye1X3pFUaN9a6Tu4f174cGaTQeODzYsjD5eAcww+XZUWQq30OmFwqAvwRCxhektcM7Md9C8EGmgxDBKijnsc=
X-Received: by 2002:a17:90b:2242:b0:2c9:a3ca:cc98 with SMTP id
 98e67ed59e1d1-2e2f09ee70fmr3000071a91.7.1728641935981; Fri, 11 Oct 2024
 03:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20241008181435.1753814-1-sughosh.ganu@linaro.org>
 <20241008181435.1753814-3-sughosh.ganu@linaro.org>
In-Reply-To: <20241008181435.1753814-3-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 11 Oct 2024 13:18:20 +0300
Message-ID: <CAC_iWjKfPVRSwcinmTUv1QtrFpfgqY5fNH2BNXumx817Nw2yiQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] lmb: add a flag to allow suppressing memory map
 change notification
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

Hi Sughosh

On Tue, 8 Oct 2024 at 21:14, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add a flag LMB_NONOTIFY that can be passed to the LMB API's for
> reserving memory. This will then result in no notification being sent
> from the LMB module for the changes to the LMB's memory map.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: None
>
>  include/lmb.h | 1 +
>  lib/lmb.c     | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/lmb.h b/include/lmb.h
> index 0e8426f4379..a76262d520d 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -23,6 +23,7 @@ enum lmb_flags {
>         LMB_NONE                = 0,
>         LMB_NOMAP               = BIT(1),
>         LMB_NOOVERWRITE         = BIT(2),
> +       LMB_NONOTIFY            = BIT(3),

I haven't gone through the rest of the series yet, but if if we remove
the notification event why we would we want the flag?
The LMB will directly update the mappings no?

Thanks
/Ilias
>  };
>
>  /**
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 0763f6174c1..a4886db4c45 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -30,7 +30,7 @@ static struct lmb lmb;
>  static void lmb_print_region_flags(enum lmb_flags flags)
>  {
>         u64 bitpos;
> -       const char *flag_str[] = { "none", "no-map", "no-overwrite" };
> +       const char *flag_str[] = { "none", "no-map", "no-overwrite", "no-notify" };
>
>         do {
>                 bitpos = flags ? fls(flags) - 1 : 0;
> --
> 2.34.1
>
