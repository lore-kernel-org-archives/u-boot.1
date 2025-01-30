Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9A0C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 19:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7737480EBA;
	Thu, 30 Jan 2025 20:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bp241psj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 037E080EED; Thu, 30 Jan 2025 20:59:21 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B06F80EB6
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 20:59:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aaee2c5ee6eso226068466b.1
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 11:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738267158; x=1738871958; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R6/RRYz/mlN82pa6iofhzE/z6g/LdVU6fCu1YgOze7c=;
 b=bp241psjcRZTu2ljEGtwOp7zxM+cL0aLXwrBwQB0TmRGuU23xr8vbQW/yallS/2SsY
 J3hlGJdtXIf+E5UUo/V8lw5EjZvhxMSP34WL5M7ax5ZMlEzVUElepMOO2/IsvhaSqFPM
 VP5hgYPt/cjLpyq9Qd4bVOFmMaeACz0Vz4UxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738267158; x=1738871958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R6/RRYz/mlN82pa6iofhzE/z6g/LdVU6fCu1YgOze7c=;
 b=pwDgoGQy1ZxhDW8ln+Z+QdXQ+UOroXZjQzipxHTDY5XaOMd9WJe6OtCjh95mKb02Ik
 jLoSwRx+nyeCk4NwQljORi5qfWYD2qpCJFxXUweOsv1+AeNfM4KfL/JgDsmP9zQkg1uf
 nxfVuwR+cObUDmA+eP9wFLo0lm615CdRh1gWMVGzWI/taQdtNQRsAK8F8EqMK0bVwVpO
 cCaV6kdDofkjY4Gip/JHp+4odVwkCqTGqEPXVX0ou/FvMnUd12X0FLGKfWdmGcrvvnZc
 Oyf4uSNl7SdQ57JYlIG35KUIhScokKIKm5s54bWUdBcTrdv8mxi2Cldko4Wa/uXvCKq0
 WPsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSOtMC7SKCzwG6PK77GyTD0MQ5WeGgOWHuyqIgqWOq+2+LijMLhWcJMKMzEnd3Rkj+qfR7310=@lists.denx.de
X-Gm-Message-State: AOJu0YxXXw9FTxWxGi+Mvd8A/KXAbCJNAMcwHSmfhFziSkaoFt0nlJ4o
 cLKKfKCzNuVfsu+rGj0wpr0meiYHDP5fPH08kpYnOa2yI0/WySJ4IwkLIao+f5wnxAHR+CWU7Ov
 PqsfQBSlWfMQQXNzEV9UB3cpdgguvkyWL2xBb6hwsGBt54TM=
X-Gm-Gg: ASbGncsYbmXMi11hFUWaGXOEffBev6kWuCH07Wd5+Yk13zyUXxXhTnFyo+FpQ2hT9WF
 OUPyyI9v59tlfbBru1JB8GRkn4fsjRnyNz/W5IaRieM1WhBOpSBC2bQ3hjmxxB34+xFzD7Rhg5g
 ==
X-Google-Smtp-Source: AGHT+IE6E97ht2LkVK50LVSuCECBBE/3lxND6AUUmmFd809FTzQDke0gTQhtlHBVorZsrqlJCmElGOf4u+rkJCJsJ1c=
X-Received: by 2002:a17:907:c1f:b0:ab2:f5cb:c039 with SMTP id
 a640c23a62f3a-ab6cfe174edmr827146966b.54.1738267158090; Thu, 30 Jan 2025
 11:59:18 -0800 (PST)
MIME-Version: 1.0
References: <20250126184333.4058848-1-sjg@chromium.org>
 <20250126184333.4058848-2-sjg@chromium.org>
 <CAEfUkUJPVLGCoThrP3ZcLwY283FYm2CcU52XDEmguKj0mKSc3Q@mail.gmail.com>
 <20250130195540.GL1233568@bill-the-cat>
In-Reply-To: <20250130195540.GL1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 Jan 2025 12:59:06 -0700
X-Gm-Features: AWEUYZlbjwvRIWbKjUJW7yDx4aRCXf5bpaHJ24n7DJATAra4DzuOX10m3lUk__Y
Message-ID: <CAFLszThfiurKbA50EamJBALs0ho+APYkuNs9JyGnm4Ei0cffWA@mail.gmail.com>
Subject: Re: [PATCH 01/19] mbedtls: Add SHA symbols for VPL
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
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

On Thu, 30 Jan 2025 at 12:55, Tom Rini <trini@konsulko.com> wrote:
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

Sorry I didn't reply in time....I'm happy with either.

Regards,
SImon
