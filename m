Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE189C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 05:38:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 048548852F;
	Thu, 23 May 2024 07:38:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Disjpys+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC87588528; Thu, 23 May 2024 07:38:32 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E294A8853F
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 07:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-420180b5838so35672125e9.2
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 22:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716442709; x=1717047509; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pnpf4Np0JHxM6OIJ71eqBMjFlS81PlRLqk1uti0l7ho=;
 b=Disjpys+Rx5+cqNvDOKARF6TnH7X95MdrTsUZ8eH0ls7+j7py13HNL8INBa2fPpcT7
 PSlOIxeGuo9asjBVzJsulMv4uI+P7F6YgR2pzX8B4Af1f8TJrSK9JT1YuTc8NpjeUYhD
 CsQq3SvhKOl4MAw0LwohvBGEmV9AKpMXDp4Ay71/Xnf4GC1MBu/vl9MWHVjiXi7o/VES
 8OvJ+gstvfJyhRZQJY2rOl4M9QP+E0aSzN/9f/scd3L0QKPgw5TTFvYdSFE/s3uLMwDX
 xxEHFfsYemGY7Eh/aUyCn4//H8mNihmLwfTrBoFlzgPeM4pNTnPTSlZ5/mFD+0t97BiJ
 9kIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716442709; x=1717047509;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pnpf4Np0JHxM6OIJ71eqBMjFlS81PlRLqk1uti0l7ho=;
 b=Idqt/j8LRJ2TmQgRAOKc1PNEYlVwAxISWEXUNyR5g/UHYWQGHf0gcLaLewpUn0kyw7
 UzKwGcjDqsE6lIc3ffCY+Hbbb3Iyux3a0jpdQklMYuQY9XPJUS1mLI6rpMXDCp/XPRF4
 ZiRoCRWWz5LmW9oxX9Oy1W4KAU8iGj1+1zqylv5129GFJ39ft16Sxwa2dmao4Jd86OhH
 2WT+7IbtzF7TXtSTEvbGFYnYplslfrcIyp/MarB7bq0so87tnN59iCdhWj7eR41SsJHL
 Cxh+TnMyxWiGHkv/G1apgqHojmhLPG5b1V6PglqzjxC1XycibqFiKGGKHkfd9a5J8DCt
 SU1A==
X-Gm-Message-State: AOJu0YzS51yWDbWH1h021yvrq2J+PPFzRAOWAyCb18omyXV9UAs0hPN9
 Qnrl+aNJeS89VfgjkXWIWUvAOwViRe5rxIgNJ/PEn5Dg7BbCEJz0HGWTkffNh4Ce+DNIo33MuxP
 6oDl8GNr/TGkDxYbbruhsqn1ZPrQ=
X-Google-Smtp-Source: AGHT+IGUnyL9eH8MdeliGsqyq86I25kWEK6jaWUPG9xVXHFg9ZBx5UajvJpX+A/DbujA2VzhEQBirXcXKNwHjH+QTxM=
X-Received: by 2002:a05:600c:1c22:b0:421:1d8:add4 with SMTP id
 5b1f17b1804b1-42101d8af99mr8963725e9.35.1716442708807; Wed, 22 May 2024
 22:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240519150736.13203-1-seashell11234455@gmail.com>
 <20240519150736.13203-3-seashell11234455@gmail.com>
 <20240522233915.GA1990099@ofsar>
In-Reply-To: <20240522233915.GA1990099@ofsar>
From: Kongyang Liu <seashell11234455@gmail.com>
Date: Thu, 23 May 2024 13:38:16 +0800
Message-ID: <CAOKwTdroHBDH7AQA5Ryts6zAseOBA-idi=318eFrCUGn84QAfw@mail.gmail.com>
Subject: Re: [PATCH 2/4] clk: sophgo: cv1800b: Add clock controller driver for
 cv1800b SoC
To: Yixun Lan <dlan@gentoo.org>
Cc: u-boot@lists.denx.de, Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>, 
 Ian Roberts <ian.roberts@timesys.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Samuel Holland <samuel@sholland.org>, 
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
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

Yixun Lan <dlan@gentoo.org> =E4=BA=8E2024=E5=B9=B45=E6=9C=8823=E6=97=A5=E5=
=91=A8=E5=9B=9B 07:39=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Kongyang:
>
> I've got one compiling error
>
> On 23:07 Sun 19 May     , Kongyang Liu wrote:
> > Add clock controller driver for sophgo cv1800b SoC
> >
> > Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> > ---
> >
> >  drivers/clk/Kconfig              |   1 +
> >  drivers/clk/Makefile             |   1 +
> >  drivers/clk/sophgo/Kconfig       |  14 +
> >  drivers/clk/sophgo/Makefile      |   6 +
> >  drivers/clk/sophgo/clk-common.h  |  74 +++
> >  drivers/clk/sophgo/clk-cv1800b.c | 794 +++++++++++++++++++++++++++++++
> >  drivers/clk/sophgo/clk-cv1800b.h | 123 +++++
> >  drivers/clk/sophgo/clk-ip.c      | 594 +++++++++++++++++++++++
> >  drivers/clk/sophgo/clk-ip.h      | 288 +++++++++++
> >  drivers/clk/sophgo/clk-pll.c     | 284 +++++++++++
> >  drivers/clk/sophgo/clk-pll.h     |  74 +++
> >  11 files changed, 2253 insertions(+)
> >  create mode 100644 drivers/clk/sophgo/Kconfig
> >  create mode 100644 drivers/clk/sophgo/Makefile
> >  create mode 100644 drivers/clk/sophgo/clk-common.h
> >  create mode 100644 drivers/clk/sophgo/clk-cv1800b.c
> >  create mode 100644 drivers/clk/sophgo/clk-cv1800b.h
> >  create mode 100644 drivers/clk/sophgo/clk-ip.c
> >  create mode 100644 drivers/clk/sophgo/clk-ip.h
> >  create mode 100644 drivers/clk/sophgo/clk-pll.c
> >  create mode 100644 drivers/clk/sophgo/clk-pll.h
> >
>
> ...
>
> > +static ulong cv1800b_ipll_set_rate(struct clk *clk, ulong rate)
> > +{
> > +     struct cv1800b_clk_ipll *pll =3D to_clk_ipll(clk);
> > +     ulong parent_rate =3D clk_get_parent_rate(clk);
> > +     u32 pre_div, post_div, div;
> > +     u32 pre_div_sel, post_div_sel, div_sel;
> > +     ulong new_rate, best_rate =3D 0;
> > +     u32 mode, ictrl;
> > +     u32 test, val;
> > +
> > +     FOR_RANGE(pre_div, PLL_PRE_DIV)
> > +     {
> > +             FOR_RANGE(post_div, PLL_POST_DIV)
> > +             {
> > +                     FOR_RANGE(div, PLL_DIV)
> > +                     {
> > +                             new_rate =3D DIV_ROUND_DOWN_ULL(parent_ra=
te * div
>                                                                          =
 ~~~~~~
>                                                              miss a comma=
 here

I will fix it.

> > +                                                           pre_div * p=
ost_div);
> > +                             if (rate - new_rate < rate - best_rate) {
> > +                                     best_rate =3D new_rate;
> > +                                     pre_div_sel =3D pre_div;
> > +                                     post_div_sel =3D post_div;
> > +                                     div_sel =3D div;
> > +                             }
> > +                     }
> > +             }
> > +     }
> > +
> > +     FOR_RANGE(mode, PLL_MODE)
>
> --
> Yixun Lan (dlan)
> Gentoo Linux Developer
> GPG Key ID AABEFD55
