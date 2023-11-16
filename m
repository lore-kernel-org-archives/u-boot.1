Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F631C47071
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 16:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06427874D8;
	Thu, 16 Nov 2023 17:45:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="iQBkeTot";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B50E874F4; Thu, 16 Nov 2023 17:45:21 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CA2C87441
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 17:45:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9d10972e63eso151920866b.2
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 08:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700153115; x=1700757915;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D+vPKp3V7eteig0GJ9EHKE5UlIUhCICQC/gkhR2sDrk=;
 b=iQBkeTotKyLLiFa4EUa4khWTdRYJAOBqTXRGnamLaaSJhzZAu6B3hUHqBpOQcidaWz
 yBE3puW3ZWpfOrbufXwnGkWPieFtpRrqbDU427p41tL4GF93GBvfkcPKZHK/WcjzTSKV
 Suu+WBG8+I+G3+ZpIDfeLDGgVTWwS5i6SXILYIBTtbyh0tVWyB96g6BnLJJV1fBeBFoZ
 bw1xfg3AgTWHTUX7dL5YvwgAyILQ5JsyFCYv7pxWIRZ7clLUywGhsl5vgKRQfehpDduj
 rDPt53OB4aAGGg6aaBeYIxoD612GpPad9lskZtnGrwGyZUp1VGOKiKjDW2IToA4zK+pg
 n1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700153115; x=1700757915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D+vPKp3V7eteig0GJ9EHKE5UlIUhCICQC/gkhR2sDrk=;
 b=hNjfgJI1ZBx7Ub2RAEqgtnUzeCgqYGEQ9H79MXRyW6rLnR4TaYltvrv+vB4M8ZXoxH
 oAyd2/iwwb0Iv40l4NJJA0qWKxZ/rRnt3QBYt8PRrHDK0LjOyHmqYDvR5ozpZfQIe5+n
 UVyLv0F0udGCa1nNzD8mkZ0BAsSCbOBGH8ffRfeQzLzUgWHUJo6dq445Jv3yy8jnv5xQ
 y78YXHLkQC0A7aoP5ok7TeG15r2eZNcL17syS7UTYz7s0LN1j0vTjJj/ueI3hVwNOap3
 VRkWV1t7ikWPG9IVkWnVb55Xd78LOWU6bLbcVVZYOmeOwtdd98P33tpV8KizIpPk1gCI
 4kjQ==
X-Gm-Message-State: AOJu0YwnOhLMt0Zi9MFJDfwOu0j1SOM/ylEvTPnbY1Hrzlsveq5Cm0w0
 EbkBgdyAmqSjb31yREH3Ur7iXQPm82DxHOG4WcZOZg==
X-Google-Smtp-Source: AGHT+IGUcULOtHwb1SBk9lRV+0eaO3tqEsveSChW6hg8GdwA0VOBotoxrZLWgD3yyqUA76F3NupzdA==
X-Received: by 2002:a17:907:c02:b0:9e8:698f:a43a with SMTP id
 ga2-20020a1709070c0200b009e8698fa43amr11270173ejc.69.1700153115234; 
 Thu, 16 Nov 2023 08:45:15 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com.
 [209.85.208.50]) by smtp.gmail.com with ESMTPSA id
 x20-20020a170906299400b009e60387c630sm8551709eje.220.2023.11.16.08.45.14
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 08:45:14 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-54394328f65so1464548a12.3
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 08:45:14 -0800 (PST)
X-Received: by 2002:a05:6402:3d9:b0:53f:731a:e513 with SMTP id
 t25-20020a05640203d900b0053f731ae513mr11631322edw.25.1700153114439; Thu, 16
 Nov 2023 08:45:14 -0800 (PST)
MIME-Version: 1.0
References: <20231115183522.1.I4cbfd34d576c0ad66a74c6ec3e8024adabc73573@changeid>
 <CAHc5_t3AC7WWcJSajL6o-Kr1p92BfcWxSdCb6K-LBP980wQQNA@mail.gmail.com>
 <CAPnjgZ3qgJ+6RXLuHJESkXJCxfsj465pj2HoCEWhiqQxsqfUKg@mail.gmail.com>
In-Reply-To: <CAPnjgZ3qgJ+6RXLuHJESkXJCxfsj465pj2HoCEWhiqQxsqfUKg@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Thu, 16 Nov 2023 16:45:03 +0000
X-Gmail-Original-Message-ID: <CAHc5_t1fn6PNrsoTa_H7sRrEdP1xUVR8+gt0myE1kq2Vy9gd7w@mail.gmail.com>
Message-ID: <CAHc5_t1fn6PNrsoTa_H7sRrEdP1xUVR8+gt0myE1kq2Vy9gd7w@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Avoid freeing a non-allocated buffer
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Simon,


> [please can you avoid top-posting as it makes it had for people to read l=
ater]
>

Sure thing.

> There is a pending series there which I haven't got to yet.
>
I can add that change to my bootmeth_efi dhcp fixes patch series if you wan=
t.

> BTW, for this patch we need a test which covers EFI on sandbox,
> perhaps running the helloworld program. The current bootstd testing
> does not extend into the efi_loader code, so there is really no
> coverage of the code in efi_exit_boot_services() from bootstd.

I am not sure how sandbox works.
I was able to test my setup which was crashing and was fixed after
these changes.

Regard,
Shantur

>
> Regards,
> Simon
>
>
> >
> > Kind regards,
> > Shantur
> >
> > On Thu, Nov 16, 2023 at 1:35=E2=80=AFAM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > EFI applications can be very large and thus used to cause boot failur=
es
> > > when malloc() space was exhausted.
> > >
> > > A recent changed fixed this by using the kernel_addr_r environment va=
r
> > > as the address of the buffer. However, it still frees the buffer when
> > > the bootflow is discarded.
> > >
> > > Fix this by introducing a flag to indicate whether the buffer was
> > > allocated, or not.
> > >
> > > Note that kernel_addr_r is not the last word here. It might be better
> > > to use lmb to place images. But there is a lot of refactoring to do
> > > before we can remove the environment variables. The distro scripts re=
ly
> > > on them so it is safe for bootstd to do so too.
> > >
> > > Fixes: 6a8c2f9781c bootstd: Avoid allocating memory for the EFI file
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Reported by: Simon Glass <sjg@chromium.org>
> > > Reported by: Shantur Rathore <i@shantur.com>
> > > ---
> > >
> > >  boot/bootflow.c     | 3 ++-
> > >  boot/bootmeth_efi.c | 1 +
> > >  include/bootflow.h  | 5 ++++-
> > >  3 files changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/boot/bootflow.c b/boot/bootflow.c
> > > index 6922e7e0c4e7..1ea2966ae9a5 100644
> > > --- a/boot/bootflow.c
> > > +++ b/boot/bootflow.c
> > > @@ -467,7 +467,8 @@ void bootflow_free(struct bootflow *bflow)
> > >         free(bflow->name);
> > >         free(bflow->subdir);
> > >         free(bflow->fname);
> > > -       free(bflow->buf);
> > > +       if (!(bflow->flags & BOOTFLOWF_STATIC_BUF))
> > > +               free(bflow->buf);
> > >         free(bflow->os_name);
> > >         free(bflow->fdt_fname);
> > >         free(bflow->bootmeth_priv);
> > > diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> > > index ae936c8daa18..9ba7734911e1 100644
> > > --- a/boot/bootmeth_efi.c
> > > +++ b/boot/bootmeth_efi.c
> > > @@ -160,6 +160,7 @@ static int efiload_read_file(struct bootflow *bfl=
ow, ulong addr)
> > >         if (ret)
> > >                 return log_msg_ret("read", ret);
> > >         bflow->buf =3D map_sysmem(addr, bflow->size);
> > > +       bflow->flags |=3D BOOTFLOWF_STATIC_BUF;
> > >
> > >         set_efi_bootdev(desc, bflow);
> > >
> > > diff --git a/include/bootflow.h b/include/bootflow.h
> > > index 44d3741eacae..fede8f22a2b8 100644
> > > --- a/include/bootflow.h
> > > +++ b/include/bootflow.h
> > > @@ -43,9 +43,12 @@ enum bootflow_state_t {
> > >   *     and it is using the prior-stage FDT, which is the U-Boot cont=
rol FDT.
> > >   *     This is only possible with the EFI bootmeth (distro-efi) and =
only when
> > >   *     CONFIG_OF_HAS_PRIOR_STAGE is enabled
> > > + * @BOOTFLOWF_STATIC_BUF: Indicates that @bflow->buf is statically s=
et, rather
> > > + *     than being allocated by malloc().
> > >   */
> > >  enum bootflow_flags_t {
> > >         BOOTFLOWF_USE_PRIOR_FDT =3D 1 << 0,
> > > +       BOOTFLOWF_STATIC_BUF    =3D 1 << 1,
> > >  };
> > >
> > >  /**
> > > @@ -72,7 +75,7 @@ enum bootflow_flags_t {
> > >   * @fname: Filename of bootflow file (allocated)
> > >   * @logo: Logo to display for this bootflow (BMP format)
> > >   * @logo_size: Size of the logo in bytes
> > > - * @buf: Bootflow file contents (allocated)
> > > + * @buf: Bootflow file contents (allocated unless @flags & BOOTFLOWF=
_STATIC_BUF)
> > >   * @size: Size of bootflow file in bytes
> > >   * @err: Error number received (0 if OK)
> > >   * @os_name: Name of the OS / distro being booted, or NULL if not kn=
own
> > > --
> > > 2.43.0.rc0.421.g78406f8d94-goog
> > >
