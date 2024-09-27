Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A132DCEBF93
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 10:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA6FB890CA;
	Fri, 27 Sep 2024 12:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CrgXPfRt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99AEE890CA; Fri, 27 Sep 2024 12:57:19 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 027B9890BA
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 12:57:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cb2f272f8bso15591786d6.0
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 03:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727434636; x=1728039436; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I2EauWs1KwJhP3dTLmbcu5vAaSnEmfm57iwAV6xxE+0=;
 b=CrgXPfRtZz+dqgCTM7s5rDYnzU5x+V0bwNyNC5UdO7O6VBkGiEFQckONK0EqWLfkRE
 AW5sZfxywHNJfJhaAYpkPHb/BWxb6zGdJW9fGuZySp8QxNNAci8F1MtpPswBIFsF9L1d
 QYcdxqbCy5nrbGasC8E+hfCS08t/ylGyAozsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727434636; x=1728039436;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I2EauWs1KwJhP3dTLmbcu5vAaSnEmfm57iwAV6xxE+0=;
 b=UzKlz6V6g75o7xOFKZnIGqcSmU3vaKY414GlMbd0wZ4IN7+ojEqafd8af2oZcgOWDo
 Re9X1KXLylnPVDhSkgm0w7eAOWqY8p2e8dBkdY4iuTll/8VcdUKFesohATRnDttd3fbt
 E+GrHn397k/PdnWX3PAw4cUKYrC/3uhzHlhrm7d877KCwySxaNpYgULWt2NfgvXQxnMo
 X8Ybw43wNMQthc/qbNFRNcAStnR7kqwP7lFlwpED/n+k64FYXq3qU3Nnh+Flt9XSqJ7M
 wYGxLD+HX/scUNkc44qxi06npfcXfIhKE4lBhsGbwPFkxMGFakx3hbyH1MQqrwVzwoa6
 AuRA==
X-Gm-Message-State: AOJu0Yxm0hz6olp9AAIgsflXrNjbyDVGIzye9c2PNzKhArD7M1+mSQ1J
 vHmKmatEAotzuk+1ZhN9Yjgm6ENGlxutAudvsRaxkCdTeJYPnkPlF9Sbx+NdPATF9QFfo3ce8up
 46VrBL27hPJrl2skunWGZkjySOTVqJpJdBiEz
X-Google-Smtp-Source: AGHT+IF+rhfVHIIGPEtTFF60jg0iNfM+LWd+kok5lYqyhZWhpaWG9bdePdd4awFnjhQh+vzRDULCOg4zgLfJPieMQak=
X-Received: by 2002:a05:6214:3d8b:b0:6c7:c74f:7173 with SMTP id
 6a1803df08f44-6cb3b6819c3mr48218736d6.39.1727434635834; Fri, 27 Sep 2024
 03:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240926223814.1276764-1-sjg@chromium.org>
 <20240926223814.1276764-15-sjg@chromium.org>
 <8615c7b6-37b2-4c2f-989a-b1780310ff86@kwiboo.se>
In-Reply-To: <8615c7b6-37b2-4c2f-989a-b1780310ff86@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 27 Sep 2024 04:57:05 -0600
Message-ID: <CAFLszThovK4mDe27kjx2jBQ46De9Ty3Hg1wfFQCp2RKLp1ZyEg@mail.gmail.com>
Subject: Re: [PATCH 14/42] rockchip: Simplify check for SPL
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@denx.de>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson <seanga2@gmail.com>, 
 Tim Lunn <tim@feathertop.org>, huang lin <hl@rock-chips.com>
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

Hi Jonas,

On Thu, 26 Sept 2024 at 18:13, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2024-09-27 00:35, Simon Glass wrote:
> > Now that SPL means SPL (only) and is not defined for TPL, simplify some
> > checks for SPL.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  arch/arm/include/asm/arch-rockchip/boot0.h |  3 +--
> >  arch/arm/mach-rockchip/rk3399/rk3399.c     |  2 +-
> >  drivers/clk/rockchip/clk_rk3368.c          |  8 ++++----
> >  drivers/ram/rockchip/sdram_rk3288.c        | 10 +++++-----
> >  drivers/ram/rockchip/sdram_rk3399.c        |  2 +-
> >  drivers/ram/rockchip/sdram_rv1126.c        |  9 +++------
> >  6 files changed, 15 insertions(+), 19 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/arch-rockchip/boot0.h b/arch/arm/include/asm/arch-rockchip/boot0.h
> > index edb2a31c348..918f0495fa0 100644
> > --- a/arch/arm/include/asm/arch-rockchip/boot0.h
> > +++ b/arch/arm/include/asm/arch-rockchip/boot0.h
> > @@ -54,7 +54,6 @@ _start:
> >       ARM_VECTORS
> >  #endif
> >
> > -#if !defined(CONFIG_TPL_BUILD) && defined(CONFIG_XPL_BUILD) && \
> > -     (CONFIG_ROCKCHIP_SPL_RESERVE_IRAM > 0)
> > +#if defined(CONFIG_SPL_BUILD) && (CONFIG_ROCKCHIP_SPL_RESERVE_IRAM > 0)
>
> This was changed from SPL to XPL just to be changed back to SPL in this
> patch?, such change probably just clutter git blame, was the change to
> use XPL really necessary in the first place?
>
> Because SPL_BUILD was used together with !TPL_BUILD it is pretty obvious
> that SPL_BUILD did not need to change to XPL_BUILD in the first place.

Yes this is a bit of a corner case.

For the first patch, CONFIG_SPL_BUILD is defined for any 'SPL' build.
For the second it is defined only for SPL. So in this case, yes, it
doesn't matter. But across the whole of U-Boot, it does.

I got pretty deep down the rabbit hole on this one, and perhaps should
not have gone ahead with the 'clean-up'. So I think we can just drop
this patch. I'll look at what others might be dropped too.

Regards,
Simon
