Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5335C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 15:14:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 484C480207;
	Fri,  7 Feb 2025 16:14:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ns94YnfH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2D0C801BE; Fri,  7 Feb 2025 16:14:36 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3412880756
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 16:14:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2fa19e1d027so2175979a91.0
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 07:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738941273; x=1739546073; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XXBtAea47dpie2uRHu5dXKhIoQG0vl4CZWtSgogTy20=;
 b=Ns94YnfHOs+YrNOhnhl6Rz3TfBcWSw5v35JxN8eg9+RtYWpG55jP1Nae5TkC7x1VPY
 AHgZGLQy02B8o98zXDLmylmxMfLrwlufdz1IjlVeCgBdpXpqx8QPU+Ggn9x78Ut9TqyU
 nfceIQwRcg5YR9YsvcybPspAntoqjcXrgrciDiGrLu635DEIjMI9BZLOzGwPzD8NOjXM
 V0cco8eFpJV5OQhsYy7WOlc0hXLXTHSSbHfqdlq10stiomKFfS2eMBJq49c1v7F4xHcg
 1VlOCRWEqEE3fj9zLtxIQN2zSFHp7yzCnlpSRd75BrMK/RM8nDKAwFabzZGoCN+9hklr
 M7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738941273; x=1739546073;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XXBtAea47dpie2uRHu5dXKhIoQG0vl4CZWtSgogTy20=;
 b=OxtfGXNHKx9LzMgQ4Y7QMGbUvzvh4vvo5RXRh56f1tQcZkKKEfpQEc9FJiKhbvpXO3
 8LYd9O8AKoQwymniMLc3wUQbIW1hEl5t01KSOT/7U9VZvLUksVVLq4qlgLnvg6JZTSgc
 f0f8FIjna0/ivo+zXqv0y0rsFsoa72i3B7e4DWDSWd1ftejJ3elyRH0mgM022yPnDeJV
 zU4pspqMl51/5CQ++/qR57tvvybXPSTvMKSrES7sHofSGLAzycqc4a0GwJDPDGT6YFW6
 P5eR+BfGNrjWgUHLRXR1SYYffT7G4T9W1i6B2f8uq/AmxEl97VvDmosxNE/R7i9MbcQ/
 KV3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfZoQf+VovxNteaGw5NOz341ZLew9tIQnxsXaZ2o7X29t3yW9It4edvH2GgZ3sRAPk6Utvjac=@lists.denx.de
X-Gm-Message-State: AOJu0YwwVgCgX3EaTESxG+GU8LefsEWTu4KEGm4RcSrrq/7U3FCzdGJ5
 NmaM6LRxYSvGnnZ9/MBBN6ouQGlBdN/1sFzmmsLWEOrw5xP3BQ4MSZRQY4RDOMjNCE8rXXYbu4u
 bACWhMOPyewR8Ml4sHb948CsvU/6osEWHXO3Clw==
X-Gm-Gg: ASbGncsksrYd03ePx5f2okruCIZxZsEicnakVxhHmoNoQsUa3kFrrtp488ejvg2zwGJ
 dWQAdAdUQNbPl15EXNuHVGu3akY2zyGlyPmurSwUY4nff+ywK1I5xYCYpuOTh2J4xn3dsheNrQU
 nAR40QXBoDFtCFIAA2wxscRZthpIbr
X-Google-Smtp-Source: AGHT+IGijKBjrmS5aBtFs9hOMuDUnxJ0/O/jH0xiZRT+XNheLIU4+8sGQrBOBv4chCfd8hVso6QRVZxSZ+zJCUgVCdc=
X-Received: by 2002:a17:90b:1d52:b0:2fa:137f:5c5c with SMTP id
 98e67ed59e1d1-2fa23f44beemr5063979a91.1.1738941272619; Fri, 07 Feb 2025
 07:14:32 -0800 (PST)
MIME-Version: 1.0
References: <20250126184333.4058848-1-sjg@chromium.org>
 <20250126184333.4058848-2-sjg@chromium.org>
 <CAEfUkUJPVLGCoThrP3ZcLwY283FYm2CcU52XDEmguKj0mKSc3Q@mail.gmail.com>
 <20250130195540.GL1233568@bill-the-cat>
 <CAEfUkU+E9qkHo_dhEFffYj_uhrk0OFezQEchNU=yDuE2beMEXw@mail.gmail.com>
 <20250131000920.GM1233568@bill-the-cat>
In-Reply-To: <20250131000920.GM1233568@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 7 Feb 2025 10:14:18 -0500
X-Gm-Features: AWEUYZnJH3e3LFof9yrt75nIDiyEHjbeE6v1QDxAfWAzQBqrhHdX6cpZf-XCOg0
Message-ID: <CAEfUkUKqsQB_Of0afP_toaS5TsLLQrCxXk=3eXe5mPCVf8HO8g@mail.gmail.com>
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

On Thu, 30 Jan 2025 at 19:09, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jan 30, 2025 at 04:49:36PM -0500, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Thu, 30 Jan 2025 at 14:55, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Jan 27, 2025 at 10:23:12AM -0500, Raymond Mao wrote:
> > > > Hi Simon,
> > > >
> > > >
> > > > On Sun, 26 Jan 2025 at 13:43, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Add some symbols for supporting SHA1 etc. for VPL.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > >  lib/mbedtls/Kconfig | 40 ++++++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 40 insertions(+)
> > > > >
> > > > > diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> > > > > index 78167ffa252..81274786106 100644
> > > > > --- a/lib/mbedtls/Kconfig
> > > > > +++ b/lib/mbedtls/Kconfig
> > > > > @@ -112,6 +112,46 @@ config SPL_MD5_LEGACY
> > > > >
> > > > >  endif # SPL
> > > > >
> > > > > +if VPL
> > > > > +
> > > > > +config VPL_SHA1_LEGACY
> > > > > +       bool "Enable SHA1 support in VPL with legacy crypto library"
> > > > > +       depends on LEGACY_CRYPTO_BASIC && VPL_SHA1
> > > > > +       help
> > > > > +         This option enables support of hashing using SHA1 algorithm
> > > > > +         with legacy crypto library.
> > > > > +
> > > > > +config VPL_SHA256_LEGACY
> > > > > +       bool "Enable SHA256 support in VPL with legacy crypto library"
> > > > > +       depends on LEGACY_CRYPTO_BASIC && VPL_SHA256
> > > > > +       help
> > > > > +         This option enables support of hashing using SHA256 algorithm
> > > > > +         with legacy crypto library.
> > > > > +
> > > > > +config VPL_SHA512_LEGACY
> > > > > +       bool "Enable SHA512 support in VPL with legacy crypto library"
> > > > > +       depends on LEGACY_CRYPTO_BASIC && VPL_SHA512
> > > > > +       help
> > > > > +         This option enables support of hashing using SHA512 algorithm
> > > > > +         with legacy crypto library.
> > > > > +
> > > > > +config VPL_SHA384_LEGACY
> > > > > +       bool "Enable SHA384 support in VPL with legacy crypto library"
> > > > > +       depends on LEGACY_CRYPTO_BASIC && VPL_SHA384
> > > > > +       select VPL_SHA512_LEGACY
> > > > > +       help
> > > > > +         This option enables support of hashing using SHA384 algorithm
> > > > > +         with legacy crypto library.
> > > > > +
> > > > > +config VPL_MD5_LEGACY
> > > > > +       bool "Enable MD5 support in VPL with legacy crypto library"
> > > > > +       depends on LEGACY_CRYPTO_BASIC && VPL_MD5
> > > > > +       help
> > > > > +         This option enables support of hashing using MD5 algorithm
> > > > > +         with legacy crypto library.
> > > > > +
> > > > > +endif # VPL
> > > > > +
> > > >
> > > > Do you mind rebasing this patch on top of my series below?
> > > > https://lore.kernel.org/u-boot/20250127151657.648255-1-raymond.mao@linaro.org/
> > > >
> > > > My one has refactored the entire mbedtls kconfig submenu, makefile and
> > > > default config file to adapt with XPL, so that users can have
> > > > independent config options in both U-Boot proper and XPLs.
> > >
> > > Actually, can you work on top of this one please Raymond? I tried yours
> > > out now and it results in ~4KiB growth so something isn't right there,
> > > but Simon's is fine atm. Thanks!
> > >
> > The reason is that I set MbedTLS crypto as default when MBEDTLS_LIB is
> > selected, which sounds more logically reasonable.
> > If users enable MBEDTLS_LIB_CRYPTO_ALT at the same time with
> > MBEDTLS_LIB, which means using U-Boot legacy crypto as MbedTLS
> > alternatives, the growth should be gone.
> >
> > Do you want me to select MBEDTLS_LIB_CRYPTO_ALT for qemu or should we
> > leave this for the user to determine?
>
> No, I guess you're right, that's fine. Still better to do this on top of
> Simon's series however please, thanks.
>

I have rebased my one on Simon's and v2 was posted:
https://lore.kernel.org/u-boot/20250203220825.707590-3-raymond.mao@linaro.org/
On top of that I added the ones for TPL as well.

Regards,
Raymond



> --
> Tom
