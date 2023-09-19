Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F97CE79A8
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 19:58:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B515186BC2;
	Tue, 19 Sep 2023 21:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DvXZp04r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA17586BD7; Tue, 19 Sep 2023 21:58:43 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E75A86BC0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 21:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-52c4d3ff424so7605810a12.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 12:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695153521; x=1695758321; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZ0cQftc1G9mK3xVsABb6lO/aoSldFNteeY0wAJX3zE=;
 b=DvXZp04reg/QBHJbIJI5e2Uva19aJi7FL+q/xmhG4ZGbFDVefwMdbeUwQoH9ref4yU
 BbqGhY2WEI3G0n94NYQcl7whWYWpiPJL1r6F7SbGeSb+oEqeHeDNAK1A9mwtBbXxfUz1
 nD9fd2OEiujcvQvf9r/Wj48pqnV+K9xXKvNBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695153521; x=1695758321;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZ0cQftc1G9mK3xVsABb6lO/aoSldFNteeY0wAJX3zE=;
 b=MUrGCWKNUMfI3qsgLTR6u4n6PmxEN1sz+xCyZwz6b/p8Ir/ODQvAQAFObvDTHNRVnv
 C8LTvFrJFEQF6VgU+mBZkul5A3aJtsx9njQDeS4KwH8XGjFj93ApiFEhuPumuHB2hg3C
 bpa0Z/R6QRS7aZmvdvb/JaIniYIi7l+4w+BkWI5nxodW4gXosFiRANlWTtgGLOzqCT0B
 LJmq8YUZxQctpETapD44wN5AczlA63Sv+/SgIokjf/8abcDT7rSHsfopUjwM9d/uapPs
 OXKJhPS0A22gG4GlTxyQbPWBrm8vTK5sXS0EO+4vQ3Dz5OUIVzGp5seG1G3O0nXdS/Jl
 gyyA==
X-Gm-Message-State: AOJu0YzoEUO55zQ4TdvYWm4NEvWU6jQjkGc59n7bcD2rnDy+3savu6xL
 FY96SMSFsj2lxkHIhMk9jIxpknzpRPS3nDJu9Ky0G3Ql+8OVZBsu0yI=
X-Google-Smtp-Source: AGHT+IEuKFROmfC0mZQK4UtHxpCiDmG+XSyATmglZ3BF6MN4ERhj0sd60wNp5jefdMdXQZmQvSJlfgsGIIczNoYqtG8=
X-Received: by 2002:aa7:dbd1:0:b0:530:d6c5:7e79 with SMTP id
 v17-20020aa7dbd1000000b00530d6c57e79mr384096edt.32.1695153520755; Tue, 19 Sep
 2023 12:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <ZOisRZBQQJDW/Pco@smile.fi.intel.com>
 <20230825135141.3210006-1-andriy.shevchenko@linux.intel.com>
 <CAEUhbmWDcqUzcRkGzY=nHXEPakWKJyfvJgzQ2DoZam6uVssWLQ@mail.gmail.com>
 <CAEUhbmX=7wM_h=jvP+M3FxnaD3J9-7Sc2xtw=s6bfQnO_wRuGg@mail.gmail.com>
In-Reply-To: <CAEUhbmX=7wM_h=jvP+M3FxnaD3J9-7Sc2xtw=s6bfQnO_wRuGg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Sep 2023 13:58:22 -0600
Message-ID: <CAPnjgZ2WaNtcPk7KOKOJ04Hv9YhipLGLgXQDDrKaOGYYf9v7og@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] TO BE FOLDED: x86: tangier: Add FADT to the chain
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
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

Hi Bin,

On Tue, 19 Sept 2023 at 01:56, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Tue, Sep 19, 2023 at 3:28=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> wro=
te:
> >
> > Hi Andy,
> >
> > On Fri, Aug 25, 2023 at 9:52=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > The Simon's patch missed the FADT to be added to the chain, hence all
> > > the issues on Intel Tangier.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  arch/x86/cpu/tangier/acpi.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/arch/x86/cpu/tangier/acpi.c b/arch/x86/cpu/tangier/acpi.=
c
> > > index 01b30553818c..ffaa56ab6f87 100644
> > > --- a/arch/x86/cpu/tangier/acpi.c
> > > +++ b/arch/x86/cpu/tangier/acpi.c
> > > @@ -52,6 +52,8 @@ static int tangier_write_fadt(struct acpi_ctx *ctx,
> > >
> > >         header->checksum =3D table_compute_checksum(fadt, header->len=
gth);
> > >
> > > +       acpi_add_table(ctx, fadt);
> > > +
> > >         acpi_inc(ctx, sizeof(struct acpi_fadt));
> > >
> > >         return 0;
> > > --
> >
> > Which commit should we squash this patch in?
> >
>
> Ah, I see this patch is already included in Simon's patch:
> https://patchwork.ozlabs.org/project/uboot/patch/20230901112707.v3.1.I610=
08e563b1209243a9a7f2b66073b4737ff82d1@changeid/
>
> I am going to apply Simon's patch unless you guys say I am looking at
> the wrong patch :)

Yes, that's it.

Regards,
Simon
