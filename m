Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFF6CDE02F
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 12:33:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 302CF890C6;
	Fri, 27 Sep 2024 14:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HgNkOMhy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 254BB890DB; Fri, 27 Sep 2024 14:33:18 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8CB4890BB
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 14:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2e0af6e5da9so1047549a91.2
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 05:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727440394; x=1728045194; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yBWX1XFDUXK2HhEwYuSFPuqQX0v4/YIxOEyzY4KbNek=;
 b=HgNkOMhy/4qnqW8WngG9nrHkFYtQec49Y+FM3iyb+fPHibAkOhF8L75sY5vEOX9ABj
 v2AdTL8Wucpa6td30fDii5UJ1MbBoOyJhdd97Xs/bYlPPudAlKOu4sf4YjHT87erQo3U
 1/N4ZqA7VeUG7ygxc1ZSjU7KGO1EdU5gOZyrLdQIAIjR7JcL8TpgR5yuVBVB78Yr95LK
 e3q1LmoSFb9tN67SZiruOHqX4Eq5HaYGu1ni2Y5kj8mq66zD8XbDewVD1hbp6vdnJhqd
 8XxLWswZ04lKCBEigRXzxztb+vJ2v9+HQfcQR+W7dS4cOtYiVevf7cybmLl+lTo5UTak
 UYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727440394; x=1728045194;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yBWX1XFDUXK2HhEwYuSFPuqQX0v4/YIxOEyzY4KbNek=;
 b=sW7QSkjJ24icILHo05cGPdS93dczKLGnqB7aYl//Z1G4Lbr6IUYJuljVDQf0/RVxfC
 HebcG4Af5yFgC+CmSDjs+WJwmwdJasA+w2VoZEw0dD9axf5quudQwHqiNvnhQk7HYpDS
 QDVBHFQz/DsXbU1f/m+BiEtIi6MJbIYdE5JJChhWhIjipkOYZ4+LJ4FPNtKmJglPFx8j
 BQ69eAZmi01dwpEADF5sYPh+v87PF2mRuTnCicD0BDovB5OE1YgArQQ3HpYxRft5ndTI
 dAfKo8/797Iwz/oHnfS0o6ccN0+qL+w+FQ6w/BrlXfqWECRAb/T8s6RNEGpVRavDWd4G
 8NFw==
X-Gm-Message-State: AOJu0Yyk3JRNn4v6GluWWU0YmzrzFss8BxFcI91NzOfXi8CiUie82PNe
 Nhy8sogpl+qYgwKoWJXxDwi6NkZyIjwk8IS3nnvCZFz0tnWnkA6F4vA6uojbYEbqmtqvwpfaQpP
 MvkNHnmZnEDPDw2FPqbvKXN49XVnQ22xsXetgwA==
X-Google-Smtp-Source: AGHT+IF1ogLG0q9J774edAtSfCRLz0u7qzDDuIFzNImFn/WBwMmeTC31fmvFkGtEW+wnaaxu4GYJv5cpPHY4lS3ybJ0=
X-Received: by 2002:a17:90a:898f:b0:2d3:db53:5577 with SMTP id
 98e67ed59e1d1-2e0b8ec65a9mr3394605a91.36.1727440394193; Fri, 27 Sep 2024
 05:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240920072444.134997-1-sjg@chromium.org>
 <20240920072444.134997-10-sjg@chromium.org>
 <CAC_iWj+NMLSAmAqiDRMsSO+SWRKu=7rSFm+BkngO0kpOwRV1JQ@mail.gmail.com>
 <CAFLszTimWzK+fZToFzH4Ez+nE62GEPnHTOf2HYcTnemv_HKojQ@mail.gmail.com>
 <CAC_iWjJ1ggBTXkSSdaM8zktf-49MFELf3AynaMjG0XK5ZkVpSw@mail.gmail.com>
 <CAFLszTgFHR_G7nSnsmHHC4dhZ4L=MgZkkefvs6Jtja9zbY=MKw@mail.gmail.com>
In-Reply-To: <CAFLszTgFHR_G7nSnsmHHC4dhZ4L=MgZkkefvs6Jtja9zbY=MKw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 27 Sep 2024 15:32:36 +0300
Message-ID: <CAC_iWjJveHpzOuRgMuEUt+6kYdmkPZB7P5k+2m8MSv4hQ7-yWw@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] armv8: Support not having separate BSS
To: Simon Glass <sjg@chromium.org>
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

On Fri, 27 Sept 2024 at 00:53, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Wed, 25 Sept 2024 at 15:40, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Wed, 25 Sept 2024 at 15:48, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Mon, 23 Sept 2024 at 11:49, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Fri, 20 Sept 2024 at 10:25, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Separate BSS is current mandatory on armv8 but this is not useful for
> > > > > early boot phases. Add support for the combined BSS.
> > > > >
> > > > > Use an #ifdef to avoid using CONFIG_SPL_BSS_START_ADDR which is not
> > > > > valid in this case.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > (no changes since v1)
> > > > >
> > > > >  arch/arm/cpu/armv8/u-boot-spl.lds | 12 ++++++++++++
> > > > >  1 file changed, 12 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
> > > > > index 215cedd69a8..fed69644b55 100644
> > > > > --- a/arch/arm/cpu/armv8/u-boot-spl.lds
> > > > > +++ b/arch/arm/cpu/armv8/u-boot-spl.lds
> > > > > @@ -13,8 +13,10 @@
> > > > >
> > > > >  MEMORY { .sram : ORIGIN = IMAGE_TEXT_BASE,
> > > > >                 LENGTH = IMAGE_MAX_SIZE }
> > > > > +#ifdef CONFIG_SPL_SEPARATE_BSS
> > > > >  MEMORY { .sdram : ORIGIN = CONFIG_SPL_BSS_START_ADDR,
> > > > >                 LENGTH = CONFIG_SPL_BSS_MAX_SIZE }
> > > > > +#endif
> > > > >
> > > > >  OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
> > > > >  OUTPUT_ARCH(aarch64)
> > > > > @@ -56,12 +58,22 @@ SECTIONS
> > > > >         _end = .;
> > > > >         _image_binary_end = .;
> > > > >
> > > > > +#ifdef CONFIG_SPL_SEPARATE_BSS
> > > > >         .bss : {
> > > > >                 __bss_start = .;
> > > > >                 *(.bss*)
> > > > >                 . = ALIGN(8);
> > > > >                 __bss_end = .;
> > > > >         } >.sdram
> > > > > +#else
> > > > > +       .bss (NOLOAD) : {
> > > > > +               __bss_start = .;
> > > > > +               *(.bss*)
> > > > > +                . = ALIGN(8);
> > > > > +               __bss_end = .;
> > > > > +       } >.sram
> > > > > +#endif
> > > >
> > > > This is still going to be separate. The only difference isn't that
> > > > it's not loaded. If you want to combine it with a region, you got to
> > > > do something similar to what we have in armv7, where it overlaps with
> > > > rel.dyn
> > >
> > > I don't mind about combining it with a region, But SPL doesn't have
> > > relocation data, right?
> > >
> > > My meaning of 'separate' is as described in CONFIG_SPL_SEPARATE_BSS,
> > > i.e. being kept in SDRAM.
> >
> > Ok, is the NOLOAD really needed? I would prefer the ifdef around .sdram/.sram
> >
> > In any case
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> Oh I see... well the NOLOAD stops it writing zero data into the image,
> as I understand it.

It doesn't load that section into memory.

>  Actually I wonder why we don't have NOLOAD for the
> separate-BSS case? If we can use NOLOAD for both then we can indeed
> shrink the #ifdef

If .bss is zero'ed out properly (which I think it is) we can use NOLOAD on both

Thanks
/Ilias
>
> >
> >
> > >
> > > >
> > > > Thanks
> > > > /Ilias
> > > > > +       __bss_size = __bss_end - __bss_start;
> > > > >
> > > > >         /DISCARD/ : { *(.rela*) }
> > > > >         /DISCARD/ : { *(.dynsym) }
> > > > > --
> > > > > 2.43.0
> > > > >
>
> Regards,
> Simon
