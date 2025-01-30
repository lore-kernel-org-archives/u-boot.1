Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0D3C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 21:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D71A80842;
	Thu, 30 Jan 2025 22:49:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a5zdHBkL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A893F80EFB; Thu, 30 Jan 2025 22:49:54 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69C3580834
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 22:49:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2efded08c79so1811390a91.0
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 13:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738273789; x=1738878589; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uqZ4WtbZK76wS5QLyigViFcM5HpNMt6YWWDNSe+guLc=;
 b=a5zdHBkLLEbKQ6HIReV0oDGEz7fLLQ7HDMbaDcAI8MmlOtTL2UyLoBvaBcsIeptJlU
 Xm3RlZa4Go4Rf+d96WyzerFZ/wv+1A2nobEmUgafFdgMZiwPakxUeXT6yJmb+7oIOJsX
 gq5PWb5/vvxbQrNzx0ql5No7kqNWpQRIPtJfb8W8X+3VvxD4wuTgZwnWX5SniBZ7oxOo
 exvIVGBXgu49cuqrQxMG0znF/WU0nrNQJ/ZL1ORQZwkEsIbIQq9Xcg/NQ1KaJgQVGTgj
 pZBgEAxFWoYl9JVfEsNXOHwuUXu7F8pO/EYwjzRDaOllLyobdaVu3FcwpxB20bz4jQwO
 /pJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738273789; x=1738878589;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uqZ4WtbZK76wS5QLyigViFcM5HpNMt6YWWDNSe+guLc=;
 b=ZoJMrLj4TelWOJy+Pf7pAGXntKNPbWnpAcW8uCf0csdegMsXWisaiWEbdiuRzSHoAv
 E2m5mN0Am7iNAiiZQxPK7mvz+s81S1jPLASGx/Q3pih6zGVxs24h+iVt0iG0iVZJ4/VT
 LN/CYzfjlp3MyKLcstqYrXIsFgmHIVKrUqLgPyZ/BXtfL88JEibnDVkF9aXG/CgU82Ls
 DILepan2E7yUM+eFseq8PQg4+jUpD1TM03OQ95UuNCI7Cyg/luN6RAFyWC/u1C8QLfgQ
 3bWQYyxlzHZvIs0PFAORZC/liLTTKw3/pKYJ8csAanNUOlafchypkKD/zYfSB0ppq97v
 +LEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOSk5OjJxlIvbGAVggFU0eWMNMS/hZZC1NU85vy8os7ZqY4Foli6DuTdLAG5XwokOoPfLgoUE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw98OgOlSftXTMSM4OQEeJIiP6LAoXwMGNKEecpUO1smCK5trI1
 LIwdALX9uC8eMI0jaZAPDxU+qbt48KrFM9+M3PEWtEvlvRsXdY8k9HJmqQFqafSI57PXh3aUaFj
 b/nklYzn6OX9RYA2lDanp0NMinEkTVmgLMu84oQ==
X-Gm-Gg: ASbGnctTLeJwZoxDXZMahRhGwmpNjLkgWLVRDnDsk9Cwtj9PatUNi5crsOYx1g1d7jC
 GtxscX1nWuVIAn9UfV/9+xfSv1Y7e5cg9roiCViPynW421S+Gqibi19ZHXyZU0Zen4R6ibd/5mN
 Y0KP3kI44U1Oqy6GPWpTXcAJlkY+NhGQ==
X-Google-Smtp-Source: AGHT+IElGNlauBs+VPQxb/LnL3UBAkqJErkQ8HUcV80/twIizQlhszcmvl54jYXMRvDouDKm13DETkWaqJLgNHKGhNM=
X-Received: by 2002:a17:90b:2d47:b0:2ea:356f:51b4 with SMTP id
 98e67ed59e1d1-2f83abdf3b3mr12959687a91.13.1738273788858; Thu, 30 Jan 2025
 13:49:48 -0800 (PST)
MIME-Version: 1.0
References: <20250126184333.4058848-1-sjg@chromium.org>
 <20250126184333.4058848-2-sjg@chromium.org>
 <CAEfUkUJPVLGCoThrP3ZcLwY283FYm2CcU52XDEmguKj0mKSc3Q@mail.gmail.com>
 <20250130195540.GL1233568@bill-the-cat>
In-Reply-To: <20250130195540.GL1233568@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 30 Jan 2025 16:49:36 -0500
X-Gm-Features: AWEUYZl2NmZjUHwu5bROxHUZoRsP1743gc0EA1kmEfai84Ahn6ivOV_F0l0Lttc
Message-ID: <CAEfUkU+E9qkHo_dhEFffYj_uhrk0OFezQEchNU=yDuE2beMEXw@mail.gmail.com>
Subject: Re: [PATCH 01/19] mbedtls: Add SHA symbols for VPL
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
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

Hi Tom,

On Thu, 30 Jan 2025 at 14:55, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jan 27, 2025 at 10:23:12AM -0500, Raymond Mao wrote:
> > Hi Simon,
> >
> >
> > On Sun, 26 Jan 2025 at 13:43, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Add some symbols for supporting SHA1 etc. for VPL.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  lib/mbedtls/Kconfig | 40 ++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 40 insertions(+)
> > >
> > > diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> > > index 78167ffa252..81274786106 100644
> > > --- a/lib/mbedtls/Kconfig
> > > +++ b/lib/mbedtls/Kconfig
> > > @@ -112,6 +112,46 @@ config SPL_MD5_LEGACY
> > >
> > >  endif # SPL
> > >
> > > +if VPL
> > > +
> > > +config VPL_SHA1_LEGACY
> > > +       bool "Enable SHA1 support in VPL with legacy crypto library"
> > > +       depends on LEGACY_CRYPTO_BASIC && VPL_SHA1
> > > +       help
> > > +         This option enables support of hashing using SHA1 algorithm
> > > +         with legacy crypto library.
> > > +
> > > +config VPL_SHA256_LEGACY
> > > +       bool "Enable SHA256 support in VPL with legacy crypto library"
> > > +       depends on LEGACY_CRYPTO_BASIC && VPL_SHA256
> > > +       help
> > > +         This option enables support of hashing using SHA256 algorithm
> > > +         with legacy crypto library.
> > > +
> > > +config VPL_SHA512_LEGACY
> > > +       bool "Enable SHA512 support in VPL with legacy crypto library"
> > > +       depends on LEGACY_CRYPTO_BASIC && VPL_SHA512
> > > +       help
> > > +         This option enables support of hashing using SHA512 algorithm
> > > +         with legacy crypto library.
> > > +
> > > +config VPL_SHA384_LEGACY
> > > +       bool "Enable SHA384 support in VPL with legacy crypto library"
> > > +       depends on LEGACY_CRYPTO_BASIC && VPL_SHA384
> > > +       select VPL_SHA512_LEGACY
> > > +       help
> > > +         This option enables support of hashing using SHA384 algorithm
> > > +         with legacy crypto library.
> > > +
> > > +config VPL_MD5_LEGACY
> > > +       bool "Enable MD5 support in VPL with legacy crypto library"
> > > +       depends on LEGACY_CRYPTO_BASIC && VPL_MD5
> > > +       help
> > > +         This option enables support of hashing using MD5 algorithm
> > > +         with legacy crypto library.
> > > +
> > > +endif # VPL
> > > +
> >
> > Do you mind rebasing this patch on top of my series below?
> > https://lore.kernel.org/u-boot/20250127151657.648255-1-raymond.mao@linaro.org/
> >
> > My one has refactored the entire mbedtls kconfig submenu, makefile and
> > default config file to adapt with XPL, so that users can have
> > independent config options in both U-Boot proper and XPLs.
>
> Actually, can you work on top of this one please Raymond? I tried yours
> out now and it results in ~4KiB growth so something isn't right there,
> but Simon's is fine atm. Thanks!
>
The reason is that I set MbedTLS crypto as default when MBEDTLS_LIB is
selected, which sounds more logically reasonable.
If users enable MBEDTLS_LIB_CRYPTO_ALT at the same time with
MBEDTLS_LIB, which means using U-Boot legacy crypto as MbedTLS
alternatives, the growth should be gone.

Do you want me to select MBEDTLS_LIB_CRYPTO_ALT for qemu or should we
leave this for the user to determine?

Regards,
Raymond



> --
> Tom
