Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0A3CD549F
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:56:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD83A86A80;
	Tue, 19 Sep 2023 09:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VFmORc+h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ECDA86AE8; Tue, 19 Sep 2023 09:56:40 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E71086A09
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-52f3ba561d9so11661848a12.1
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 00:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695110197; x=1695714997; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lXcZDfeL7QqT39M95xBZQlUOD4fiInSWwSPhNj2a7CI=;
 b=VFmORc+hffCXi2CprPlPDhJNOzKNqIejwvrMOu91j8Zn0U7zDMUy8NflvL/fxmJm5F
 ItwCBKQD4LNsiXH1ZcB+DRVIAAKYnwDc0yRjgCovmYXLBilGsTRCjY/LxQtu0CLJsubl
 7vyGm1VSFcfq37sPfGj8kVaXSsYXAecKfblNVtU75I5+wUUTvOdYc2QfgQybc7NoJEsj
 ck0aLJjh+Zs32WVmMuxRcGaxu3HmVlJsUe11ZXKO173+52s6qfXrOB81omtLuhsEBE+3
 wPfAnDmOCrfzXcJH6MWjEP9S+TY1RDbzoOaxuVSv9g4rXk0AvGIuK0H002z95kCBMXIQ
 5NyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695110197; x=1695714997;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lXcZDfeL7QqT39M95xBZQlUOD4fiInSWwSPhNj2a7CI=;
 b=bipuAFXul3TpcHHS6mv5geb3uq+WKLJtk058aokzroyh+cbb5t+XxRuuwAVX9HmRzI
 dRkqv9cFohxnXISNIU7BjZp5TCaM+tzA/34hBADgEwewaHVWRuet/VEC2e5UpE8V+7k6
 oSPA7hiBMqL6NPj4o/qVfOQL/bIZzo8VPengRd5dUI6QFesA7vWWdPVIMTdV/PYXl+/e
 Sp1ix2k2H089T4/ablE2xoYyP1KBU9ZlVB+YuLo6y4QdFbc7QYVWi7qLt7teBgqSnD2F
 7+Ssu/zAhG6DsF1dNmahXHOWzKcy/0WEn3Zs1kZKJ7T8Djh8Qa2b8zgt1GpM5J/Upu4s
 SNWQ==
X-Gm-Message-State: AOJu0YyV6hWRGhiN4JClQkRlnmanTGm1zQ6o+BQmHp221MZzOj7TkaK8
 WKiDFGjgD+u0KIBkHDu1DmyzKS1fVUEXInDugWPRmOe9iDQ=
X-Google-Smtp-Source: AGHT+IFGqK4zULEeaSRB6K01j3MZAf+ZuEm7b/RuwzVOyo97/QEUB0+XzJTsUvcmZYxW7d10eYwCvQnNx7iYY8fgrCA=
X-Received: by 2002:a05:6402:4304:b0:530:bfb6:66cd with SMTP id
 m4-20020a056402430400b00530bfb666cdmr2492371edc.7.1695110197514; Tue, 19 Sep
 2023 00:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <ZOisRZBQQJDW/Pco@smile.fi.intel.com>
 <20230825135141.3210006-1-andriy.shevchenko@linux.intel.com>
 <CAEUhbmWDcqUzcRkGzY=nHXEPakWKJyfvJgzQ2DoZam6uVssWLQ@mail.gmail.com>
In-Reply-To: <CAEUhbmWDcqUzcRkGzY=nHXEPakWKJyfvJgzQ2DoZam6uVssWLQ@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 15:56:26 +0800
Message-ID: <CAEUhbmX=7wM_h=jvP+M3FxnaD3J9-7Sc2xtw=s6bfQnO_wRuGg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] TO BE FOLDED: x86: tangier: Add FADT to the chain
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Tue, Sep 19, 2023 at 3:28=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> wrote=
:
>
> Hi Andy,
>
> On Fri, Aug 25, 2023 at 9:52=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > The Simon's patch missed the FADT to be added to the chain, hence all
> > the issues on Intel Tangier.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  arch/x86/cpu/tangier/acpi.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/x86/cpu/tangier/acpi.c b/arch/x86/cpu/tangier/acpi.c
> > index 01b30553818c..ffaa56ab6f87 100644
> > --- a/arch/x86/cpu/tangier/acpi.c
> > +++ b/arch/x86/cpu/tangier/acpi.c
> > @@ -52,6 +52,8 @@ static int tangier_write_fadt(struct acpi_ctx *ctx,
> >
> >         header->checksum =3D table_compute_checksum(fadt, header->lengt=
h);
> >
> > +       acpi_add_table(ctx, fadt);
> > +
> >         acpi_inc(ctx, sizeof(struct acpi_fadt));
> >
> >         return 0;
> > --
>
> Which commit should we squash this patch in?
>

Ah, I see this patch is already included in Simon's patch:
https://patchwork.ozlabs.org/project/uboot/patch/20230901112707.v3.1.I61008=
e563b1209243a9a7f2b66073b4737ff82d1@changeid/

I am going to apply Simon's patch unless you guys say I am looking at
the wrong patch :)

Regards,
Bin
