Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7429C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 19:58:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F51582E76;
	Mon,  7 Apr 2025 21:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SgeC62WU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C54682EAA; Mon,  7 Apr 2025 21:58:57 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 660F882CD5
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 21:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-af908bb32fdso4063814a12.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 12:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1744055932; x=1744660732;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+aTpsR/de1P4AJySEZ+na5fCHLXzxrcRezzLjqfAJo4=;
 b=SgeC62WUS6btAfCvbL3b+iIlLf7wqJnYy9wXNhWasBfG5fL8ssV4PFPNr/uxWtM7Ls
 /eu3xhfM69KMT8XqEZcGZRTIlMJtgDFZcQlHMJUFlWrhI4gqid0/SO7BHVS51T6RJuYj
 f/zyruOCvZ0dF7Olpbsd6DDaldfay3oa6oPw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744055932; x=1744660732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+aTpsR/de1P4AJySEZ+na5fCHLXzxrcRezzLjqfAJo4=;
 b=uyEYUUQwp76xKUpN9wSGeTFvBgi0yLNEznVIkIe/XVBMvVDCKaEDSw5xh42Mhot6Nw
 XVyPSs4FOqvE8kGzMmEPtEu9m+t9jzaEtf6pRPpGroyFeBs7Y1SmWtM9rVVwKZ48ygKV
 lfWtz01c+/oYkl2iUhcDtKAfxNC1kEcP3a6GimGLELi2Iy/MmutmNbHW32Jt17vXpjqK
 l6FdqXT+nhgSw3bkebl/Bf0BUX8o0j1LuTV1pm9ae1/TtFhVpKWBPHQ0RUfmf27uW7gI
 o0V+6XlroVbAy4ztllHJ51FGhzGGRdmWJLegcCpkNrJTPGspb9VLzrXwjk0A03jio2V5
 Fovw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX50NJBcg1A7VbN2WMBcFkGKiVOIU/so2pJuOvrePZBi0UeZmOigHJfeYkVmZhuh+jXoG51M98=@lists.denx.de
X-Gm-Message-State: AOJu0YyVeS4PfoCI2Gtcsx/ybPf5GKrZp858EgW919YzLm8yAu0cSePw
 VDoyC9m2emJFehkhiUANm0M04FuHeSrMWvINRCQJZzHYmF0ryISrWJ9hyTEl7x/OtycYdQNyi8e
 2TJpteVi9ugsapy+s4ziuPwP52hk0hp7VoxMFnw==
X-Gm-Gg: ASbGnctKqlA/Xbq8nrEcPPTtYVJPhBYSgmcSuEdGRsNMq0/Ycp+UJT8wbbuX+V9rdch
 0dLGPkRz0k5m5S0gJkMhDVT3vAEVfYiwPxufgYxbSEEKgPe+XIpMiTH18hVLgHtU/4afic2CwSd
 vT2efhLrna+M89syl2ypW8uRODcB0f
X-Google-Smtp-Source: AGHT+IFcQbLhRQrYleI52eYW6s8Dsk7/mQdYlhfmQcu6IyOB7fHvjrmFETwmBHmrBb7dC3IXzKnk/FRzLRZ9Q6s5DeM=
X-Received: by 2002:a17:90b:384b:b0:2fa:30e9:2051 with SMTP id
 98e67ed59e1d1-306d0be801bmr981440a91.5.1744055931888; Mon, 07 Apr 2025
 12:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250315092420.793-1-ansuelsmth@gmail.com>
 <67f42db9.050a0220.16b640.abd2@mx.google.com>
In-Reply-To: <67f42db9.050a0220.16b640.abd2@mx.google.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 7 Apr 2025 21:58:39 +0200
X-Gm-Features: ATxdqUFs3qixlF0YePSoOs_AKOQQ8z_-9hLbop1pbz954RIlVp6ZpVLUT8HZCZA
Message-ID: <CAOf5uwkU_hTEa_D+pEouXmsiQYMTNkHdr+z0boVO43BW7wkA7g@mail.gmail.com>
Subject: Re: [RESEND PATCH] clk: fix crash on clk_set_rate clean rate cache
To: Christian Marangi <ansuelsmth@gmail.com>,
 Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 Tero Kristo <t-kristo@ti.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Fabio

On Mon, Apr 7, 2025 at 9:55=E2=80=AFPM Christian Marangi <ansuelsmth@gmail.=
com>
wrote:

> On Sat, Mar 15, 2025 at 10:24:14AM +0100, Christian Marangi wrote:
> > It's currently possible to make the bootloader crash on calling
> > clk_set_rate caused by the loop in clk_clean_rate_cache.
> >
> > The loop assume that every child of the clock node are also clock
> > device but this is not always the case. For example it's common for a
> > clock to bind to a reset device or also expose a syscon if the clock
> > register map is also used to apply special configuration.
> >
> > In such case, on accessing a device as a clock, the bootloader crash. T=
o
> > correctly handle this, check if the child device is actually a clock an=
d
> > ignore otherwise.
> >
> > Fixes: 6b7fd3128f71 ("clk: fix set_rate to clean up cached rates for th=
e
> hierarchy")
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > RESEND as there was a problem with email To:
> >
> >  drivers/clk/clk-uclass.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> > index 353ae476068..8f3309d9530 100644
> > --- a/drivers/clk/clk-uclass.c
> > +++ b/drivers/clk/clk-uclass.c
> > @@ -554,6 +554,9 @@ static void clk_clean_rate_cache(struct clk *clk)
> >       clk->rate =3D 0;
> >
> >       list_for_each_entry(child_dev, &clk->dev->child_head,
> sibling_node) {
> > +             if (device_get_uclass_id(child_dev) !=3D UCLASS_CLK)
> > +                     continue;
> > +
> >               clkp =3D dev_get_clk_ptr(child_dev);
> >               clk_clean_rate_cache(clkp);
> >       }
> > --
> > 2.48.1
> >
>
> News for this trivial patch?
>
>
Can you review it and pick if needed?

Michael

> --
>         Ansuel
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
