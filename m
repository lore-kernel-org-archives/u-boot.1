Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC514CDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C550188EA8;
	Thu, 26 Sep 2024 23:34:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ed9Zp4dT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7C3B88EE2; Thu, 26 Sep 2024 23:34:06 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82CCB88E1F
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cb2d2a7d48so9481816d6.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727386443; x=1727991243; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VoICOLfHdwPJ3Vwx2GTl7y3ibwwvLwirgbyIHuryBU4=;
 b=ed9Zp4dTvGVFkAAH5PJTmSHKbUrqluVGOOh8b6n1U1cUMRjrTJKhMezCqazM6QXEH1
 7NJz53s5xAPW7GZgohQvzTGhluAcnwoB0SC9q9zPmmWpFLdZSyWwSDYSTvHHzgixitGO
 k+g+nwQBdXFl5bzkZZvgkX/DWXZQW7wVcnXYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727386443; x=1727991243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VoICOLfHdwPJ3Vwx2GTl7y3ibwwvLwirgbyIHuryBU4=;
 b=w3ghbMa+yd0lHeEhjQ7hlDIR50uKABDj95tB8OZFX4p4wjYI6YDwCsKE/C+Yv1IwNM
 Dr6t6Ll6520WWZF4tOgT+kGMAcB3fssQKvoBvlxLclaAYEeKz7OgMKgctG0X0fn1Zi5q
 loVDuVG80CcwkK8plAsDiZ/DMfBtOBvh5rAI7/aqFxWLXjClbCnUElPQ0QDJw6uEk2ru
 mLeeMXLJf2/lF5bQ+Lr/kInzOs6nuL/VzskzYRfYx8g/a1cHjMJCIpvOdjNiF9wuvp0U
 l/wQY0X2HgIgWzLyfiuB8ggRULBGAKlE3oJJ0nXrbcXDcCTIyCiiTG8AGQ35relxcIKr
 zj1g==
X-Gm-Message-State: AOJu0YxNTGR/ZfpSAYUuId9RbK2Ytkn/QDSksEzcLR+3pO/yIWZBXlYL
 THfAcfz2uDBhebCEdKH8p7Qbl53RLq9VXC1fdhPkzPwHEpCX7S1nlEtHAtNsHhAcmYhGmUKwDJ+
 /rxUvIAaiEwc4IN9eekUG9AdHyO8F19qlQoQRvE/p+xAyTRe/ZVKYXXA=
X-Google-Smtp-Source: AGHT+IH5WTAzIJ0Uapw4sC2DG+L9QEZbEjKWzAm4yIShPvH2klRWhshAxSbszvfbb9b/6r7TRasjzGj5DmsGk5Wiue0=
X-Received: by 2002:ad4:4f47:0:b0:6cb:3bc0:c2c5 with SMTP id
 6a1803df08f44-6cb3bc0c33bmr8106426d6.53.1727386443370; Thu, 26 Sep 2024
 14:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240925125622.197915-1-sjg@chromium.org>
 <20240925125622.197915-12-sjg@chromium.org>
 <20240926040710.GI4252@bill-the-cat>
In-Reply-To: <20240926040710.GI4252@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:33:52 +0200
Message-ID: <CAFLszTjEpHJE4Zf9hZ_5HQw8adouQ9et3Y+y7LcDe1YKj6ah+w@mail.gmail.com>
Subject: Re: [PATCH 11/19] spl: Support jumping to VPL from TPL
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson <seanga2@gmail.com>
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

Hi Tom,

On Thu, 26 Sept 2024 at 06:07, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Sep 25, 2024 at 02:55:37PM +0200, Simon Glass wrote:
> > Use spl_get_image_pos() to obtain the image position to jump to. Add
> > the symbols used for VPL so that the correct image can be loaded.
> >
> > Use the functions provided for accessing these symbols and add a few
> > comments too.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  common/spl/spl.c | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > index d01e9861f88..623e486c210 100644
> > --- a/common/spl/spl.c
> > +++ b/common/spl/spl.c
> > @@ -50,15 +50,19 @@ u32 *boot_params_ptr = NULL;
> >
> >  #if CONFIG_IS_ENABLED(BINMAN_UBOOT_SYMBOLS)
> >  /* See spl.h for information about this */
> > +#if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD) && !defined(CONFIG_VPL_BUILD)
> >  binman_sym_declare(ulong, u_boot_any, image_pos);
> >  binman_sym_declare(ulong, u_boot_any, size);
> > +#endif
> >
> > -#ifdef CONFIG_TPL
> > +#if defined(CONFIG_TPL)
> > +/* TPL jumps straight to SPL */
> >  binman_sym_declare(ulong, u_boot_spl_any, image_pos);
> >  binman_sym_declare(ulong, u_boot_spl_any, size);
> >  #endif
> >
> >  #ifdef CONFIG_VPL
> > +/* TPL jumps to VPL */
> >  binman_sym_declare(ulong, u_boot_vpl_any, image_pos);
> >  binman_sym_declare(ulong, u_boot_vpl_any, size);
> >  #endif
>
> So I see on a64-olinuxino and others a size reduction here, as those
> symbols aren't included now. Do we have something in the tooling to
> ensure that we aren't now referencing / dereferencing invalid links?

Yes I noticed that on some other boards. I dug into it a bit and
decided that the symbol was being declared when it didn't need to be.
If the symbol were used but not declared, we get an error.

Regards,
Simon
