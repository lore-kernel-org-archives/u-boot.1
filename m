Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56415C3DA70
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 13:42:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BADB87C7E;
	Fri, 26 Jul 2024 15:42:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="R5LDJN23";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 353828780E; Fri, 26 Jul 2024 15:42:46 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E20358780E
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 15:42:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a7aabb71bb2so245795766b.2
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 06:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1722001362; x=1722606162;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VTId9ntqA6+iOLzsg473yo25YFl+GO9KCWEO27qb2Tw=;
 b=R5LDJN23jvh9qx/oOBgJN+oKp9NKVCfLZpIXnRKTJeNr+jA1BLInZ43a4kK+px5afI
 J5MErg97b0cTKLxVeyYUfUFFvgTfjAFgjsNqaG/RPvn7fsSmvjKKYJLjab1k3ir5WLKN
 b9Fnj6JZY9fa7K8hd3vVovNvOb9VRIaXiT3qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722001362; x=1722606162;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VTId9ntqA6+iOLzsg473yo25YFl+GO9KCWEO27qb2Tw=;
 b=AYkqO+04CGZhqxP8+wdPAJGebma76IihkeXVfP+PJM4A+1LmZ2iGOLVjJW5HqBXq9C
 y4U1wSiGR5uxUJPNftMMy1HNISwxdhKWrQcm8l2PlfGHR8459F86hceV1CHfaJAGV9Vq
 vBzPrRL498CnwfoxCKxz0GAljM3Pya+J5koWTLfuIKXaXGvxjSwnyQu8X1NEPgwU57tl
 sx0oqAcXyecTSWrRoA7p4xl0YKhMLNPJWd5/0aPmOCdT+Sf81dFoJ/4CTkcqhK3qLWp1
 heXDX+cv3xEpTlhESi0erxankmIs2u6bKN0Ht2Tn0B6dh6PblKdl+Iaa8baPoDhSFvxM
 NYgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE7wDALxolsBvd8cqVh2iBEgXxqjw1bCjl8VuRUL9XiFNql6Sd6GUQXXJ8mX8QGQDi6vGqNdkSqU4J+W6nuumm6rzQ/A==
X-Gm-Message-State: AOJu0YzRknFBLrnAKLK3QaN/eRdktpGUwnkBFoKYI27TopwsOS01NXhX
 CbWKhN/9aMTWdK0oxmiNaKy7mmIE5UHxlhYBlQqpyRbJtF2nh9slVqr1np2/uxulQ9Xw91f06ld
 ls+oOweO8X8eNSEvNe08N5gWxqqB8wuSZqLWx8w==
X-Google-Smtp-Source: AGHT+IHxW3qBLSs1tC0slREkV4KqjRuaU6C5BYIHwijEhqILp5JWLKzVkG49QBwervt2bnqQDNNnR7dew98x4gltA3U=
X-Received: by 2002:a17:906:6a19:b0:a77:cacf:58b5 with SMTP id
 a640c23a62f3a-a7acb39513emr428813066b.1.1722001362243; Fri, 26 Jul 2024
 06:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240705071419.11521-1-michael@amarulasolutions.com>
 <CAPLW+4n0j+5Sz7jrAVZx068Vxy2GQVFBCcA0ovsPL-ip0R0WLw@mail.gmail.com>
 <CAOf5uwk8xjgsrVysDgEeOsr6uR5u=LYP3N2s67eBf5eqqtS_MQ@mail.gmail.com>
 <CAOf5uw=5QVsWe0thmTPjUyKFTKo98YsQZosTm0803hVGhZRZmw@mail.gmail.com>
 <CAPLW+4kHuTeCo8XBmEZeH3PzZ_jx2X0b7ypc1Mr2Vuaz_J0XBg@mail.gmail.com>
In-Reply-To: <CAPLW+4kHuTeCo8XBmEZeH3PzZ_jx2X0b7ypc1Mr2Vuaz_J0XBg@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 26 Jul 2024 15:42:31 +0200
Message-ID: <CAOf5uwmicuBz0atMYg4v7Wyu7RuBbh=B3zfRssw_M7NPR65p3A@mail.gmail.com>
Subject: Re: [PATCH V2] clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE
 present for gate and mux
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, linux-amarula@amarulasolutions.com,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Sam

On Thu, Jul 25, 2024 at 4:41=E2=80=AFAM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> On Wed, Jul 24, 2024 at 4:44=E2=80=AFAM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
>
> [snip]
>
> > > Ok , so you suggest to have something like in the core
> >
> > diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> > index 8faf5a56e1..a309108dd4 100644
> > --- a/drivers/clk/clk-uclass.c
> > +++ b/drivers/clk/clk-uclass.c
> > @@ -467,8 +467,14 @@ ulong clk_get_rate(struct clk *clk)
> >                 return 0;
> >         ops =3D clk_dev_ops(clk->dev);
> >
> > -       if (!ops->get_rate)
> > -               return -ENOSYS;
> > +       if (!ops->get_rate) {
> > +               parent =3D clk_get_parent(clk);
> > +               if (!clk_is_valid(parent))
> > +                       return -ENOSYS;
> > +               ops =3D clk_dev_ops(parent->dev);
> > +               if (!ops->get_rate)
> > +                       return -ENOSYS;
> > +       }
> >
> >         return ops->get_rate(clk);
> >  }
> >
> > You suggest to remove get_rate, set_rate function in mux and gate and
> > use some propagation in the core, am I right?
>
> Something like that, yes. But maybe instead of
>
>     if (!ops->get_rate)
>
> use something like:
>
>     while (!ops->get_rate)
>
> like I did in my patch [1] for clk_set_rate(). That while loop is
> needed to handle cases when there are multiple clocks without
> .get_rate() operation connected together (like mux or gate clocks). So
> you'd have to iterate them all up the tree to find some DIV clock
> which actually has .get_rate() defined.
>
> But at the moment I'm more concerned about .set_rate() propagation of
> course, which is really needed for my E850-96 MMC enablement series
> [2], which has already been pending on the review for a while.
>
> [1] https://lists.denx.de/pipermail/u-boot/2024-March/547719.html
> [2] https://lists.denx.de/pipermail/u-boot/2024-July/559602.html
>
> [snip]
>
> > > > implementations simple and brings the propagation logic to the actu=
al
> > > > clk API (clk_set_rate()), which in turn is able to cover all possib=
le
> > > > cases: even if some new clock types are implemented later, they wil=
l
> > > > be covered already. That also reduces some code duplication and mak=
es
> > > > it easier to control that behavior in a centralized manner. The pat=
ch
> > > > with the discussed implementation was already submitted a while ago
> > > > [2], and still pending on the review.
> > >
> > > I have seen it and because I'm extending the clk framework a bit more=
 [1]
> > > I was thinking about a more complete approach. Nothing against your
> > > patch, but just
> > > I have observed in my use case (display) that I need more from the
> > > clock framework we have
> > >
>
> I see. Do you think it'd possible for you to use my patch for
> clk_set_rate() propagation for your case, and base your patches (for
> CLK_OPS_PARENT_ENABLE, etc) on top of that? Will it cover your
> requirements?
>

If I remember how it works now we don't need the loop. Each get_clk_rate
or clk_set_rate should implement propagation in their implementation if the
CLK PARENT SET is present

Michael


> Would be also nice to hear what maintainers think about that :)
>
> Thanks!
>
> > > Michael
> > >
> > > [1] https://patchwork.amarulasolutions.com/patch/3291/
> > >
> > > >
>
> [snip]



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
