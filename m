Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D99BC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 21:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE102801DE;
	Thu, 30 Jan 2025 22:52:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dI+Jpbdd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29ADD80842; Thu, 30 Jan 2025 22:52:12 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91A99800CF
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 22:52:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2f43d17b0e3so2292633a91.0
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 13:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738273928; x=1738878728; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yg2yXeewnWUoskr8089dUi7UHt7f7mxzY+U3NbXgguI=;
 b=dI+JpbddvIZrZb+ObrgdmzSYU7iifIZujZiWs1xQQdcJ/IeOgvf2oS+A4YlMU++k/v
 6mh64Pzl4QFl5hNoKh2e1JGUMjvWl9R9IdozABYpthlo35bb474W/c8+iMTp5iRuPbuQ
 Gon0TD0sGlWnB/hZAFExiQPJTVL6D3Yi8bq740S+h1ir8j2AUatvM+IyZnuNiCuMZ4Om
 RGjfp0yimINfeKPprXvt1UanDKFZRK9sWPwTXHS2TSgtbLCG1SMmzXGQ73XuPcAKMJoe
 BR/trWZ9Rc3IqFQVK5a6gHGAHvtiZi/bz0b3wAYPHKVaNCTux2CFzYgKydJhLNt4qsHz
 8DAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738273928; x=1738878728;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yg2yXeewnWUoskr8089dUi7UHt7f7mxzY+U3NbXgguI=;
 b=F5eQgmRop2rPPCmuHEGpW8iPHWAW3W38wtfNEb/x6XofwPtLnYN3z7BiJEASUuyH6M
 LE0YoyrTO7xCAVNro19UUdNl6VAIBn1g7rSNS57s94kaFxWCwJFTJM4eUupPlRYWexKQ
 PydvGDfBDvEwcX1Ot+4b+cqu02grCXP3WGP4vStKUqr7ffY3FZIL89DKCCjXmxifP3AI
 FmjKIFhPh1DG5dJq/Fh9PKAzcvPVUhX2qfzs3IvieRxMYwvzmR20dDHeyXQ3UeZp4h55
 LT19M4TIeA94OiDpFId/LYGRNafkpn1+XFOC0GaKYnC5EmJnp72h+des/qjtircAZVxX
 VRrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv8kBM3nZcg8P6vXiQ9iHw5DMlMHYQNAbVkluJCE9vGzhijpxQgmlcYQsVrVFXkb16ZT4QIcs=@lists.denx.de
X-Gm-Message-State: AOJu0YxF6MggxSvaR+HpMaSIpnmRl1dNVxrnhZpmXsJVgRiM0IoW9vC0
 bVUd/udoBVoQLGfgifQaufRJekGsYGIo0UIGt4C0ma/+WQI3R1JrGz9XwI8QmnGUnw/e8T//khk
 PZCPT59DYg/r7DtvhaLWaODXH4LJPY6ZrbFAJBw==
X-Gm-Gg: ASbGnct5eozjbSoWrGJn4PhXjJ5ywAUdBLd+FaRhZzUkye2XGZYepefWeNZom2jN1aO
 MODUDH+o+dvM/dhHk72EP/ApsznrkXAKCApBju6bhhBQiDzEGgVvrfGlDkljqey5KGyVQ+vf01G
 Nfqhtw3eGhQWTMq40YVTGcfClC/Ph3vA==
X-Google-Smtp-Source: AGHT+IFAbzf+g8ifBq/5VqXlam17EvAL01Tp3j3tSwF6ApxLa5J86pEvROWfz1QeJPlUjQtK2Rh/YK5K/5hSwkJ6dCY=
X-Received: by 2002:a17:90b:258c:b0:2ee:f687:6acb with SMTP id
 98e67ed59e1d1-2f83abd9998mr13190396a91.13.1738273928064; Thu, 30 Jan 2025
 13:52:08 -0800 (PST)
MIME-Version: 1.0
References: <20250126184333.4058848-1-sjg@chromium.org>
 <20250126184333.4058848-2-sjg@chromium.org>
 <CAEfUkUJPVLGCoThrP3ZcLwY283FYm2CcU52XDEmguKj0mKSc3Q@mail.gmail.com>
 <20250130195540.GL1233568@bill-the-cat>
 <CAFLszThfiurKbA50EamJBALs0ho+APYkuNs9JyGnm4Ei0cffWA@mail.gmail.com>
In-Reply-To: <CAFLszThfiurKbA50EamJBALs0ho+APYkuNs9JyGnm4Ei0cffWA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 30 Jan 2025 16:51:55 -0500
X-Gm-Features: AWEUYZlNaxSLtLeDqj6UfGGXpwp66IfIRhbtzh2j_-IUyjWxsIDEsHfHdgGluYY
Message-ID: <CAEfUkUL3m-ZxcZC+7_BJOLy=2KY71dNknZkiFRc_HPLwXw7d=w@mail.gmail.com>
Subject: Re: [PATCH 01/19] mbedtls: Add SHA symbols for VPL
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>
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

Hi Simon,

On Thu, 30 Jan 2025 at 14:59, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Thu, 30 Jan 2025 at 12:55, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Jan 27, 2025 at 10:23:12AM -0500, Raymond Mao wrote:
> > > Hi Simon,
> > >
> > >
> > > On Sun, 26 Jan 2025 at 13:43, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Add some symbols for supporting SHA1 etc. for VPL.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >  lib/mbedtls/Kconfig | 40 ++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 40 insertions(+)
> > > >
> > > > diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> > > > index 78167ffa252..81274786106 100644
> > > > --- a/lib/mbedtls/Kconfig
> > > > +++ b/lib/mbedtls/Kconfig
> > > > @@ -112,6 +112,46 @@ config SPL_MD5_LEGACY
> > > >
> > > >  endif # SPL
> > > >
> > > > +if VPL
> > > > +
> > > > +config VPL_SHA1_LEGACY
> > > > +       bool "Enable SHA1 support in VPL with legacy crypto library"
> > > > +       depends on LEGACY_CRYPTO_BASIC && VPL_SHA1
> > > > +       help
> > > > +         This option enables support of hashing using SHA1 algorithm
> > > > +         with legacy crypto library.
> > > > +
> > > > +config VPL_SHA256_LEGACY
> > > > +       bool "Enable SHA256 support in VPL with legacy crypto library"
> > > > +       depends on LEGACY_CRYPTO_BASIC && VPL_SHA256
> > > > +       help
> > > > +         This option enables support of hashing using SHA256 algorithm
> > > > +         with legacy crypto library.
> > > > +
> > > > +config VPL_SHA512_LEGACY
> > > > +       bool "Enable SHA512 support in VPL with legacy crypto library"
> > > > +       depends on LEGACY_CRYPTO_BASIC && VPL_SHA512
> > > > +       help
> > > > +         This option enables support of hashing using SHA512 algorithm
> > > > +         with legacy crypto library.
> > > > +
> > > > +config VPL_SHA384_LEGACY
> > > > +       bool "Enable SHA384 support in VPL with legacy crypto library"
> > > > +       depends on LEGACY_CRYPTO_BASIC && VPL_SHA384
> > > > +       select VPL_SHA512_LEGACY
> > > > +       help
> > > > +         This option enables support of hashing using SHA384 algorithm
> > > > +         with legacy crypto library.
> > > > +
> > > > +config VPL_MD5_LEGACY
> > > > +       bool "Enable MD5 support in VPL with legacy crypto library"
> > > > +       depends on LEGACY_CRYPTO_BASIC && VPL_MD5
> > > > +       help
> > > > +         This option enables support of hashing using MD5 algorithm
> > > > +         with legacy crypto library.
> > > > +
> > > > +endif # VPL
> > > > +
> > >
> > > Do you mind rebasing this patch on top of my series below?
> > > https://lore.kernel.org/u-boot/20250127151657.648255-1-raymond.mao@linaro.org/
> > >
> > > My one has refactored the entire mbedtls kconfig submenu, makefile and
> > > default config file to adapt with XPL, so that users can have
> > > independent config options in both U-Boot proper and XPLs.
> >
> > Actually, can you work on top of this one please Raymond? I tried yours
> > out now and it results in ~4KiB growth so something isn't right there,
> > but Simon's is fine atm. Thanks!
>
> Sorry I didn't reply in time....I'm happy with either.
>

If you are ready to merge, no worries, please go ahead and I can
rebase on yours.

Raymond


> Regards,
> SImon
