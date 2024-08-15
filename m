Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A80FC3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 21:11:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FF2588ABE;
	Thu, 15 Aug 2024 23:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="atEhUllY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A04688B1B; Thu, 15 Aug 2024 23:11:18 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CA82871C9
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 23:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7c3e0a3c444so931358a12.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 14:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723756273; x=1724361073; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XCHmZlXoQWN4/WtZEIjrtCPWCRE4ovIfmK9jW/BVWsk=;
 b=atEhUllYZanuSgbqrmFSDF88EZ41X4CebTRdFM/XEJ/C7Gqn60Wzv6O0yCJGZkA+E8
 bMjcb/wjQqGZtoMG0ncAfKwzvx/L4iLRj6qcNjGkyUcOp7cWtAiO4pJXf0mEd6Ee05kM
 w1ESb4rj1nZcMHPVHTkU9p+OYxZD3a0wTA5q9F6OuUMpOSBed3p/CeiXWgfg8dWWFftp
 x6AyJkr5uwwX7QN6Nmt9x8Af+OY9ghDRI7x6+9Sg6V1PjkehPsGrdZv4UK5T+DjiAalj
 tpRZjBLnXJLGEw5XSNGfUsnMBNXiNuGcdxuEbLxjKtxtYwlRowxtTeHhUB5tcrqfQSZB
 Rclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723756273; x=1724361073;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XCHmZlXoQWN4/WtZEIjrtCPWCRE4ovIfmK9jW/BVWsk=;
 b=Dxg09DP7uhDLtGb65DrNA0hcIqyCXX8Phw5FPyrzS4M+kF6F7XzL5a7w2UslNj9tMB
 +GzVaX1B0Rs3Lllia6vC/EOsxO1MNr8P27gkErcWj2ALkm88IEynV5eZPEk85XT+Ouj3
 v+k763KuCtSvrkMckgQGkUn2Uu54KBIlyWK9jXkdYlTaFtGAuDCTlJkJxFqu7jITvkzQ
 Yhfz5OP2V//YpZTnMoSyn8n0shV1P9DNU0qqeJ8+ubg6n9FU3CT9hyoM+wBVXLitWaru
 5n/tRtOtbPtz/kMFipJkB8c9WfdizqoM0mz5KjKtqJvspm9dwWVEUyEFQqyfju15D6bv
 LZPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSwQKkhWKex3EMj57buvn6DxQjM6tPQPHsVSzyvg4/8NPTXfUNgMcOub4S/TB3Ltg9d1I/pZ6x9UxbTMAkZNXl0XCNKw==
X-Gm-Message-State: AOJu0YwB74ebk7EK1QCDAdeb3hfelqi/fKRsMC4ex/paLb+5e0n49Ygo
 GzouNFGofO5RqEdhY12D9GceFSGw62R+1NvxggKQAzMmJQJulngjYtJTIZgLzwJkrFyMHV2+0Sn
 LHzKLtC4369+6Zgv7y94hvYDq68CH88K5+nBvUW2+GxgM0vQo
X-Google-Smtp-Source: AGHT+IEMutxghVQ3vVBZGuj6/dwaqFofLW+x2HAzjLA3mgljts1grNxLGPDPnHHa5YwwUkmpURKsJDm6hi+g57D0lLk=
X-Received: by 2002:a17:90a:43a2:b0:2d3:ca71:dbb3 with SMTP id
 98e67ed59e1d1-2d3ca71e1b8mr4843774a91.17.1723756272606; Thu, 15 Aug 2024
 14:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240814134518.82692-1-ilias.apalodimas@linaro.org>
 <CAFLszTjrBL-GonZKqp3Ab5vQPMZ+BZu8V21y4z0qBCGuH64uJw@mail.gmail.com>
In-Reply-To: <CAFLszTjrBL-GonZKqp3Ab5vQPMZ+BZu8V21y4z0qBCGuH64uJw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 16 Aug 2024 00:11:00 +0300
Message-ID: <CAC_iWjKF0DMfJza-ojYXPg_tHL14DTdK+GzhxhEX3etpaNiK8Q@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: clean up the efi configuration status
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anton Antonov <Anton.Antonov@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Shengyu Qu <wiagn233@outlook.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Greg Malysa <greg.malysa@timesys.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Sean Anderson <sean.anderson@seco.com>, Anand Moon <linux.amoon@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Eddie James <eajames@linux.ibm.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Thu, Aug 15, 2024, 23:33 Simon Glass <sjg@chromium.org> wrote:

> Hi Ilias,
>
> On Wed, 14 Aug 2024 at 07:45, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > The EFI_LOADER and EFI config options are randomly scattered under lib/
> > making it cumbersome to navigate and enable options, unless you really
> > know what you are doing. On top of that the existing options are in
> > random order instead of a logical one.
> >
> > So let's move things around a bit and present two enties for the
>
> entries
>
> > EFI_LOADER and EFI options in the main config screen.
> > While at it add menus for Capsules, Protocols, and Services in the
> > EFI_LOADER so people can find their way around easier
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  Kconfig                |   4 +
> >  lib/Kconfig            |   2 -
> >  lib/efi/Kconfig        |   5 +
> >  lib/efi_loader/Kconfig | 202 +++++++++++++++++++++++------------------
> >  4 files changed, 123 insertions(+), 90 deletions(-)
> >
> > diff --git a/Kconfig b/Kconfig
> > index 82df59f176ec..62c5441e3576 100644
> > --- a/Kconfig
> > +++ b/Kconfig
> > @@ -756,3 +756,7 @@ source "lib/Kconfig"
> >  source "test/Kconfig"
> >
> >  source "tools/Kconfig"
> > +
> > +source "lib/efi_loader/Kconfig"
> > +
>
> This should be included from boot/Kconfig as it relates to booting.
>

Hmm why? Booting is one of the things efi does. I prefer having it on the
main menu since it's a pointer to the entire spec, protocols, services etc



> The EFI app thing should perhaps be under there too...I'm not sure.
>

I was toying around with the idea as well. But eventually I decided this
needs it's own entry since it's about building U-Boot as a pe/coff. I don't
mind changing this though.

Thanks
Ilias

>
> Regards,
> Simon
>
