Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EEDCDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:53:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C52F788E5F;
	Thu, 26 Sep 2024 23:53:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ix65KjR0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E1D288E99; Thu, 26 Sep 2024 23:53:40 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2850188E51
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-718e2855479so1083459b3a.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727387616; x=1727992416; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X3cdGrjyoBCZlXMdKwh8kQ0MiH0JUzKyNZjIYgTj6M0=;
 b=Ix65KjR0I4XQFChh/U+YbhgcYlgsv2ApOlU1nXLxTQazPn2BDkxCtaP/Y/28jmCx4Z
 lcQUYY1sYZRLw1lJbW7OxR1DCQ0e5Zv9juaUWvEmK9XycgU9HYQKG9sseg4Y3M7Je8JB
 9kChcKZhn7TY8UZDq8chBWHxV4VhZCT7v/hzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727387616; x=1727992416;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X3cdGrjyoBCZlXMdKwh8kQ0MiH0JUzKyNZjIYgTj6M0=;
 b=qp8sm0bGsXR5Ct28BPQvRpdKXaZz/LdNWsz+0VS3P30wvSOvU2iKQw0coG8E5Xzi3+
 gGwsS6FM8M6WzZzQ6eI8evZVm+RAgMGyU0HM2qYBCM/nm3gucMWklKfs3AoPGc9kbG37
 n2rKLktgSIBG3la8xukmJnLJOmuE/iWk00fqQaqPBt7T9cH5kDdexnWkyWSUEgLUy47i
 LClOdq+UBYwlFrGGboxoLjDiIIyO2bBZg8ludOEQDirY3a7qay2VuF5rKG9iF2KNIPBK
 qbBPzddGflRtIz8hqBP9LWpLGJg9bQJc0Ivc2oDbAYY/d1dXGKovLZZe437s05ktSQDL
 Dxkg==
X-Gm-Message-State: AOJu0YyB0PJE6YiyNi2eYesNk/WF7tTp4dzXIfXdM37+S7F3YcMouib5
 5oaTxSHzcGZo/uOHm3rTGOAhwdekpjg65pX00lSD/PpVJ9cJ4cEPffElTiw/qOpcHbetFj4JI1B
 LJg3aH/2Httx6yrKAgxKm/qqNjFJCHAl+mn08
X-Google-Smtp-Source: AGHT+IGodMSJj3AK4dcELMu52dxlcwYYmfmoxs/++juecpOh9TVr3zOFIObBEMlFFDWNKSvEMC1KKQ0oJCEJ8SMe1pY=
X-Received: by 2002:a17:903:1208:b0:20b:2eb3:97ac with SMTP id
 d9443c01a7336-20b36ad2913mr17358965ad.24.1727387616665; Thu, 26 Sep 2024
 14:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240920072444.134997-1-sjg@chromium.org>
 <20240920072444.134997-10-sjg@chromium.org>
 <CAC_iWj+NMLSAmAqiDRMsSO+SWRKu=7rSFm+BkngO0kpOwRV1JQ@mail.gmail.com>
 <CAFLszTimWzK+fZToFzH4Ez+nE62GEPnHTOf2HYcTnemv_HKojQ@mail.gmail.com>
 <CAC_iWjJ1ggBTXkSSdaM8zktf-49MFELf3AynaMjG0XK5ZkVpSw@mail.gmail.com>
In-Reply-To: <CAC_iWjJ1ggBTXkSSdaM8zktf-49MFELf3AynaMjG0XK5ZkVpSw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:53:24 +0200
Message-ID: <CAFLszTgFHR_G7nSnsmHHC4dhZ4L=MgZkkefvs6Jtja9zbY=MKw@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] armv8: Support not having separate BSS
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Richard Henderson <richard.henderson@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

Hi Ilias,

On Wed, 25 Sept 2024 at 15:40, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Wed, 25 Sept 2024 at 15:48, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Mon, 23 Sept 2024 at 11:49, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Fri, 20 Sept 2024 at 10:25, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Separate BSS is current mandatory on armv8 but this is not useful for
> > > > early boot phases. Add support for the combined BSS.
> > > >
> > > > Use an #ifdef to avoid using CONFIG_SPL_BSS_START_ADDR which is not
> > > > valid in this case.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  arch/arm/cpu/armv8/u-boot-spl.lds | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > >
> > > > diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
> > > > index 215cedd69a8..fed69644b55 100644
> > > > --- a/arch/arm/cpu/armv8/u-boot-spl.lds
> > > > +++ b/arch/arm/cpu/armv8/u-boot-spl.lds
> > > > @@ -13,8 +13,10 @@
> > > >
> > > >  MEMORY { .sram : ORIGIN = IMAGE_TEXT_BASE,
> > > >                 LENGTH = IMAGE_MAX_SIZE }
> > > > +#ifdef CONFIG_SPL_SEPARATE_BSS
> > > >  MEMORY { .sdram : ORIGIN = CONFIG_SPL_BSS_START_ADDR,
> > > >                 LENGTH = CONFIG_SPL_BSS_MAX_SIZE }
> > > > +#endif
> > > >
> > > >  OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
> > > >  OUTPUT_ARCH(aarch64)
> > > > @@ -56,12 +58,22 @@ SECTIONS
> > > >         _end = .;
> > > >         _image_binary_end = .;
> > > >
> > > > +#ifdef CONFIG_SPL_SEPARATE_BSS
> > > >         .bss : {
> > > >                 __bss_start = .;
> > > >                 *(.bss*)
> > > >                 . = ALIGN(8);
> > > >                 __bss_end = .;
> > > >         } >.sdram
> > > > +#else
> > > > +       .bss (NOLOAD) : {
> > > > +               __bss_start = .;
> > > > +               *(.bss*)
> > > > +                . = ALIGN(8);
> > > > +               __bss_end = .;
> > > > +       } >.sram
> > > > +#endif
> > >
> > > This is still going to be separate. The only difference isn't that
> > > it's not loaded. If you want to combine it with a region, you got to
> > > do something similar to what we have in armv7, where it overlaps with
> > > rel.dyn
> >
> > I don't mind about combining it with a region, But SPL doesn't have
> > relocation data, right?
> >
> > My meaning of 'separate' is as described in CONFIG_SPL_SEPARATE_BSS,
> > i.e. being kept in SDRAM.
>
> Ok, is the NOLOAD really needed? I would prefer the ifdef around .sdram/.sram
>
> In any case
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Oh I see... well the NOLOAD stops it writing zero data into the image,
as I understand it. Actually I wonder why we don't have NOLOAD for the
separate-BSS case? If we can use NOLOAD for both then we can indeed
shrink the #ifdef

>
>
> >
> > >
> > > Thanks
> > > /Ilias
> > > > +       __bss_size = __bss_end - __bss_start;
> > > >
> > > >         /DISCARD/ : { *(.rela*) }
> > > >         /DISCARD/ : { *(.dynsym) }
> > > > --
> > > > 2.43.0
> > > >

Regards,
Simon
