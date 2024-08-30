Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47C6CA0ECD
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 00:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2556788D28;
	Fri, 30 Aug 2024 02:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cqNoKteR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8D9788D06; Fri, 30 Aug 2024 02:59:11 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD72688D28
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 02:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6bf90d52e79so7569986d6.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 17:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724979548; x=1725584348; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uBfdnTrOd8p0+gBKK7k3054nwxTLCTvOv0qWpUJ7+AI=;
 b=cqNoKteRi7WviiLeZw6tiSFvPfnG7E36YLAmRlcduDc3oXoyksxiU1hhXnfnPI0F+0
 4qT+SXeSvS9HYkywg0w2nsNwO02W99WQeQYn7cc0xT/A0CbCNyjjftvPeUzxU4FBXxxP
 oeoe8PlpqZfs++7+I6R1JZPhz/oe6D0/BaUTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724979548; x=1725584348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uBfdnTrOd8p0+gBKK7k3054nwxTLCTvOv0qWpUJ7+AI=;
 b=NuKoonEWpxU0H+va2Eamz1ngWSB+IM5gnWq3O6SRXFVOrK+hzEOO88sogdMi7NW70u
 9IAsht4LVvj7jIiPcAeYOiSibTtAzealDzhylvH9HMdAyuVgLHL0HJGVGpkCY1F7hNJV
 dILlApWU5ce3vnB7tZSj2hjN/qojZLjgxrgLpTwfyqJvpdBO+AO3nc4emDCG1cs4dkP6
 sXoSp5PM+N/FR5RsE3yWEfn6Nj62jIBCtKfh2od0Ux87uUJofcg0pnFG8igcM+MovOYF
 dD/wDP3WTbo0tnU5GNMQ1TtE3yWWD3RZHd5OWUUTZbtG4l5LwNMFszmSghNcjJsXqiev
 7Zng==
X-Gm-Message-State: AOJu0Yw50EpE29/zWOe9LCt+It306R2oYYUU1ckvWsSrzivj8fwnEMk+
 lMb+dZAx4VK2YxqNvgSXTVr0vJGRelBpSn+6h+GUqq0CU0ZEds2U1xMpo7OHrXAv6QE4eaAnQjZ
 b3YxAR30fspIdWGxRrr7+iHei+AlNr4JYaKuO
X-Google-Smtp-Source: AGHT+IH6whnrTpVN9JGOb9dTKE+OpVlO40WLBUL5tt8FyVhdluhOrNPbbNzjI2Z9Di8b2EqNgc4luMcmk3r1JWuhoPE=
X-Received: by 2002:a05:6214:5bc9:b0:6bf:6127:98a7 with SMTP id
 6a1803df08f44-6c33e6a44c0mr44769506d6.56.1724979548528; Thu, 29 Aug 2024
 17:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724846454.git.jerome.forissier@linaro.org>
 <679e20bfd9ac3de6560e202f82452563b01fca7a.1724846454.git.jerome.forissier@linaro.org>
 <CAFLszTh87_wd-+XLe1EeXziMiu9p_rT-qfAgHg4PxGwhsAKUtQ@mail.gmail.com>
 <1c7c2e70-aa24-46b3-ac3b-47c6dc9fde3c@linaro.org>
In-Reply-To: <1c7c2e70-aa24-46b3-ac3b-47c6dc9fde3c@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 18:58:57 -0600
Message-ID: <CAFLszTgWn0NhdkdKsmwwGk2fBbHuN1sJM6Kfc3vE2M55nw-EVg@mail.gmail.com>
Subject: Re: [PATCH 05/13] net: fm: call dtsec_init_phy() only when it is
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

On Thu, 29 Aug 2024 at 10:40, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 8/29/24 16:04, Simon Glass wrote:
> > Hi Jerome,
> >
> > On Wed, 28 Aug 2024 at 06:11, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> >>
> >> dtsec_init_phy() is defined only with MII so add the proper conditional
> >> in the caller code.
> >>
> >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >> ---
> >>  drivers/net/fm/eth.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/net/fm/eth.c b/drivers/net/fm/eth.c
> >> index 19f3f0fef0..e4ec769693 100644
> >> --- a/drivers/net/fm/eth.c
> >> +++ b/drivers/net/fm/eth.c
> >> @@ -701,8 +701,10 @@ static int init_phy(struct fm_eth *fm_eth)
> >>                 supported |= SUPPORTED_2500baseX_Full;
> >>  #endif
> >>
> >> +#if defined(CONFIG_MII) || defined(CONFIG_CMD_MII) && !defined(BITBANGMII)
> >>         if (fm_eth->type == FM_ETH_1G_E)
> >>                 dtsec_init_phy(fm_eth);
> >> +#endif
> >
> > We really want to avoid #ifdefs in the code as they create different
> > build paths. Can you use if (IS_ENABLED) ?
>
> Sure.
>
> > Also BITBANGMII seems liike
> > it needs a CONFIG_ prefix.
>
> I agree. I have copied the line verbatim from line 29 because the condition
> needs to be the same. And I suspect there is another issue with the operator
> precedence. Do we want "MII || (CMD_MII && !BITBANGMII)" or
> do we rather want "(MII || CMD_MII) && !BITBANGMII"? I guess the latter.
>
> So how about:
>
> diff --git a/drivers/net/fm/eth.c b/drivers/net/fm/eth.c
> index 19f3f0fef0..22025b6a27 100644
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
> -       if (fm_eth->type == FM_ETH_1G_E)
> -               dtsec_init_phy(fm_eth);
> +       if ((IS_ENABLED(CONFIG_MII) || IS_ENABLED(CONFIG_CMD_MII)) &&
> +           !IS_ENABLED(CONFIG_BITBANGMII)) {
> +               if (fm_eth->type == FM_ETH_1G_E)
> +                       dtsec_init_phy(fm_eth);
> +       }
>

That's good

>  #ifdef CONFIG_PHYLIB
>  #ifdef CONFIG_DM_MDIO
>
>
> ???

You don't have to fix every #ifdef in every file you touch...it's just
that if you are already touching code, you might as well bring it up
to newer standards.

Regards,
Simon
