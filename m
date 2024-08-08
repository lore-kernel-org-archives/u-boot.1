Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92B7C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 10:02:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 320CE88A93;
	Thu,  8 Aug 2024 12:02:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fc0nPEPO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5450888A63; Thu,  8 Aug 2024 12:02:25 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6416388A67
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 12:02:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.oss.09@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2eeb1ba0481so9415921fa.2
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 03:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723111334; x=1723716134; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bBEVHPhTFXMly7+LiaBUCjbyPQx4F8rAtBTII5wFO24=;
 b=fc0nPEPOXvjgIxHKSltwXQT4nNsnVIejMcnLYBa5EhZ+EBTeRk+aMbTIlRQ5yQ+LAv
 AOSkvGeC4eU8wCMawXH6CGf3v1Zsmp2bKdE2LB0wZfv2RuN3JfsAoI5cjkUUi8VvWg0v
 q4ojEtrhxTOnREDgdxXa8FMxRqZTvrYQH5KhjSlbbgMV8UMgfPJhj/x5gd/nSnGn9ONh
 hy8LyvzoSQkqKfI02+uOarN3EfWGxEN4DtRufSQ/MtH361rnxrkOFbkl+oC4ZEaLGSZZ
 I1Kx+eGFZSjDlFdowSH4BGLPAGNdw3gJkKJ7+EEacq/L01Q6OgX1tY5iERA03UKohTT7
 yWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723111334; x=1723716134;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bBEVHPhTFXMly7+LiaBUCjbyPQx4F8rAtBTII5wFO24=;
 b=m4NKKwC6rFm3KfkDF44oC6imgINoNfJNKzHz/XLSWjhK/RAZYUPnpVCiiovUQiqeqe
 OZSnknuzv2tBjFGMcLfLRYYqSYx4ZxJgquhzF7lWK+w+QOCfk0X5yJEn0xDAnvt5Nv3k
 Q6XFD3vt3sqTwyW8MHaJdedAHB2yJjOijBuYPTaJCSuKlAYxYQuWRdOuZVTukJ8zmagN
 ZXqNrSrfeKE1ZImKoi7rYE7ezupuFrQijUu4qSluHrktm1fUXsxXKfurzNIP1nHYmQbX
 bO+aD7yTvS+fPEHk+VnR2gglgZu6TrZAIzE+wITYn5qi/Cu5g0uj10ALfB1SCwK1TFiu
 URaA==
X-Gm-Message-State: AOJu0YxYaUo8awQjdHmAi6unu1oPCXvjjG8QB2clJmwqYlLqXuNNyAvi
 pMOhE2L3Bk2BMbDmakQtqx32/rj/Mau0CxgWDKZH/TXVS6SEKMDU
X-Google-Smtp-Source: AGHT+IEUYfWd+KLP+OlniWLOJwIbhRL9CwWKbiNAhYrJYYEqmKpqFuIrorHPGi+7IxBCRchx2TUY9g==
X-Received: by 2002:a2e:4942:0:b0:2ef:2f53:c300 with SMTP id
 38308e7fff4ca-2f19de47dd2mr8467931fa.28.1723111334013; 
 Thu, 08 Aug 2024 03:02:14 -0700 (PDT)
Received: from toolbox (31-10-206-125.static.upc.ch. [31.10.206.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429059cbfaesm63503715e9.42.2024.08.08.03.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 03:02:13 -0700 (PDT)
Date: Thu, 8 Aug 2024 12:02:10 +0200
From: Max Krummenacher <max.oss.09@gmail.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 dl-uboot-imx <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH] imx: imx8: fix build when CONFIG_IMX_BOOTAUX is set
Message-ID: <ZrSXoq7CEEtFMu5G@toolbox>
References: <20240807133919.4155815-1-max.oss.09@gmail.com>
 <PAXPR04MB8459DAB001E8D22E23873CB488B92@PAXPR04MB8459.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459DAB001E8D22E23873CB488B92@PAXPR04MB8459.eurprd04.prod.outlook.com>
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

Hello Peng Fan
On Thu, Aug 08, 2024 at 03:16:54AM +0000, Peng Fan wrote:
> > Subject: [PATCH] imx: imx8: fix build when CONFIG_IMX_BOOTAUX is
> > set
> > 
> > From: Max Krummenacher <max.krummenacher@toradex.com>
> > 
> > Use correct function name.
> > 
> > Fixes: e8cd1f60d964 ("imx: imx8: bootaux: Add i.MX8 M4 boot
> > support")
> > Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> > ---
> > 
> >  arch/arm/mach-imx/imx8/cpu.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-imx/imx8/cpu.c b/arch/arm/mach-
> > imx/imx8/cpu.c index accba502e492..834aca82bcfd 100644
> > --- a/arch/arm/mach-imx/imx8/cpu.c
> > +++ b/arch/arm/mach-imx/imx8/cpu.c
> > @@ -258,14 +258,14 @@ int arch_auxiliary_core_up(u32 core_id,
> > ulong boot_private_data)
> >  			return -EIO;
> >  		}
> > 
> > -		if (!power_domain_lookup_name("audio_sai0", &pd))
> > {
> > +		if (!imx8_power_domain_lookup_name("audio_sai0",
> > &pd)) {
> 
> I think need to find a proper fix to this. This API is legacy API.

The current code does call a function which does not exist. Thus the
compile fails if enabling CONFIG_IMX_BOOTAUX for a i.MX 8X and likely
always did.
I think that would merrit fixing it now rather than waiting until the
more modern API is ported into U-Boot and the code using it changed to
the new API.

Alternatively I could remove the handling of the HiFi auxiliary core
from arch_auxiliary_core_up() and returning EINVAL if someone tried to
set that core up.

Regards
Max

> 
> Thanks
> Peng
> 
> 
