Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAD0C54FB9
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 16:04:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16F7F874BB;
	Thu, 16 Nov 2023 17:04:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e4FKOFNE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9DC3874D0; Thu, 16 Nov 2023 17:04:42 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B0E8874B1
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 17:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9e623356d5dso142755766b.3
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 08:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700150676; x=1700755476; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k9q1oDUlChDTDh/YFjATxyw5tIvm7e5WtkeUe3G+cco=;
 b=e4FKOFNE5n6BZCdVJ/YOOtae+asSXtwXZfQb7rSnCuZfsMAYck+54xZ36stQYvQm25
 W4lAejyS5pLtoi6jsi2+cWwMb7C78MXrvQu9LwKsnDyXOyPTqCm+UiO0DadzPW5eIC3B
 HTBR26oREqccxdYU/W+eOBbw38sLSWWtBfn8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700150676; x=1700755476;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k9q1oDUlChDTDh/YFjATxyw5tIvm7e5WtkeUe3G+cco=;
 b=vNkkUSVOob2XQLpMCN/Fc//OQkyxTY2fjQnFXeINt9FRFF9YejvW2mOmoe8lLap4Kr
 71wUFbjFrKEjqpjtz78q9IHIQpP1pMjVTrddhl4XWWILY33hXvuUkvqQmdfeWbPtcTQd
 T/Tu6dTmVln7umjr1+JDi4XX83SWYWymclhgNM2XFaTVj8UClIHgDjFYultSyK1601kl
 QnJ3x1aq+cdDIukFQlfShX1yCxpaEkXvkcvRhtnSwJsMDnC27qIl9TW6Jkx1HDKPgVYe
 hOnrztVH1rLKouTBarf1jTcvYhD+Q/2H1KPes3PnDP2YyH6a/4h44bsSJoyZ+MU3qxLB
 pmLA==
X-Gm-Message-State: AOJu0Yw3hnFeQqsq8vsmLuahnqP2epAPl8SVpxinCnmgXd9vhuDBdkdt
 flVPGWu0yJlcbjfQPe4KiLdiLsuQQIHz1vsu84nmrw==
X-Google-Smtp-Source: AGHT+IFHAD3Li5mLFkFbB4g1ldg4uMp4RfdDGykPXPMmi6KxcHcZohdC7Ik9zg9IQZeCm9m8UanO1qR29m1Zzi8uUzE=
X-Received: by 2002:a17:906:2356:b0:9e0:4910:1666 with SMTP id
 m22-20020a170906235600b009e049101666mr12556067eja.35.1700150676350; Thu, 16
 Nov 2023 08:04:36 -0800 (PST)
MIME-Version: 1.0
References: <20231115183522.1.I4cbfd34d576c0ad66a74c6ec3e8024adabc73573@changeid>
 <CAHc5_t3AC7WWcJSajL6o-Kr1p92BfcWxSdCb6K-LBP980wQQNA@mail.gmail.com>
In-Reply-To: <CAHc5_t3AC7WWcJSajL6o-Kr1p92BfcWxSdCb6K-LBP980wQQNA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 16 Nov 2023 09:04:25 -0700
Message-ID: <CAPnjgZ3qgJ+6RXLuHJESkXJCxfsj465pj2HoCEWhiqQxsqfUKg@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Avoid freeing a non-allocated buffer
To: Shantur Rathore <i@shantur.com>
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

Hi Shantur,

On Thu, 16 Nov 2023 at 04:02, Shantur Rathore <i@shantur.com> wrote:
>
> Hi Simon,
>
> Thanks for the patch.
> Ater this patch, booting off USB works fine over USB disk.
> Maybe you need the same flag for dhcp as well just after dhcp_run() here
> https://github.com/u-boot/u-boot/blob/master/boot/bootmeth_efi.c#L356

[please can you avoid top-posting as it makes it had for people to read lat=
er]

There is a pending series there which I haven't got to yet.

BTW, for this patch we need a test which covers EFI on sandbox,
perhaps running the helloworld program. The current bootstd testing
does not extend into the efi_loader code, so there is really no
coverage of the code in efi_exit_boot_services() from bootstd.

Regards,
Simon


>
> Kind regards,
> Shantur
>
> On Thu, Nov 16, 2023 at 1:35=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > EFI applications can be very large and thus used to cause boot failures
> > when malloc() space was exhausted.
> >
> > A recent changed fixed this by using the kernel_addr_r environment var
> > as the address of the buffer. However, it still frees the buffer when
> > the bootflow is discarded.
> >
> > Fix this by introducing a flag to indicate whether the buffer was
> > allocated, or not.
> >
> > Note that kernel_addr_r is not the last word here. It might be better
> > to use lmb to place images. But there is a lot of refactoring to do
> > before we can remove the environment variables. The distro scripts rely
> > on them so it is safe for bootstd to do so too.
> >
> > Fixes: 6a8c2f9781c bootstd: Avoid allocating memory for the EFI file
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Reported by: Simon Glass <sjg@chromium.org>
> > Reported by: Shantur Rathore <i@shantur.com>
> > ---
> >
> >  boot/bootflow.c     | 3 ++-
> >  boot/bootmeth_efi.c | 1 +
> >  include/bootflow.h  | 5 ++++-
> >  3 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/boot/bootflow.c b/boot/bootflow.c
> > index 6922e7e0c4e7..1ea2966ae9a5 100644
> > --- a/boot/bootflow.c
> > +++ b/boot/bootflow.c
> > @@ -467,7 +467,8 @@ void bootflow_free(struct bootflow *bflow)
> >         free(bflow->name);
> >         free(bflow->subdir);
> >         free(bflow->fname);
> > -       free(bflow->buf);
> > +       if (!(bflow->flags & BOOTFLOWF_STATIC_BUF))
> > +               free(bflow->buf);
> >         free(bflow->os_name);
> >         free(bflow->fdt_fname);
> >         free(bflow->bootmeth_priv);
> > diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> > index ae936c8daa18..9ba7734911e1 100644
> > --- a/boot/bootmeth_efi.c
> > +++ b/boot/bootmeth_efi.c
> > @@ -160,6 +160,7 @@ static int efiload_read_file(struct bootflow *bflow=
, ulong addr)
> >         if (ret)
> >                 return log_msg_ret("read", ret);
> >         bflow->buf =3D map_sysmem(addr, bflow->size);
> > +       bflow->flags |=3D BOOTFLOWF_STATIC_BUF;
> >
> >         set_efi_bootdev(desc, bflow);
> >
> > diff --git a/include/bootflow.h b/include/bootflow.h
> > index 44d3741eacae..fede8f22a2b8 100644
> > --- a/include/bootflow.h
> > +++ b/include/bootflow.h
> > @@ -43,9 +43,12 @@ enum bootflow_state_t {
> >   *     and it is using the prior-stage FDT, which is the U-Boot contro=
l FDT.
> >   *     This is only possible with the EFI bootmeth (distro-efi) and on=
ly when
> >   *     CONFIG_OF_HAS_PRIOR_STAGE is enabled
> > + * @BOOTFLOWF_STATIC_BUF: Indicates that @bflow->buf is statically set=
, rather
> > + *     than being allocated by malloc().
> >   */
> >  enum bootflow_flags_t {
> >         BOOTFLOWF_USE_PRIOR_FDT =3D 1 << 0,
> > +       BOOTFLOWF_STATIC_BUF    =3D 1 << 1,
> >  };
> >
> >  /**
> > @@ -72,7 +75,7 @@ enum bootflow_flags_t {
> >   * @fname: Filename of bootflow file (allocated)
> >   * @logo: Logo to display for this bootflow (BMP format)
> >   * @logo_size: Size of the logo in bytes
> > - * @buf: Bootflow file contents (allocated)
> > + * @buf: Bootflow file contents (allocated unless @flags & BOOTFLOWF_S=
TATIC_BUF)
> >   * @size: Size of bootflow file in bytes
> >   * @err: Error number received (0 if OK)
> >   * @os_name: Name of the OS / distro being booted, or NULL if not know=
n
> > --
> > 2.43.0.rc0.421.g78406f8d94-goog
> >
