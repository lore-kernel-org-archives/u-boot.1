Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C57C54E65
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 08:21:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C48082D2B;
	Wed, 21 May 2025 10:21:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uoPV2qba";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EC2682D33; Wed, 21 May 2025 10:21:14 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CE6582BD6
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 10:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sbellary@baylibre.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b13e0471a2dso4261300a12.2
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 01:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747815670; x=1748420470;
 darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UW/9eOmcxww1SCoN2sRjbngcwHurM2a/dMr/YjT3Pnw=;
 b=uoPV2qbaKgqrch3UmWuLLC7HbMERTGLVesIlxjWvJ5fLiXfDI6eAekYTu7ur4R9JO8
 hX3i7/5T/3ZFoFSN5AFClIDC8ZzCE4Gpg9SkzMm1C4PgWww1hFeNKO9kRV3F3fOpJk78
 hEYEBkibiRJk5P5DipeD9Alym0FaY2TyhwR/JPrKhC0s7YFSzhy/+aSMBJ7BME9EuQjV
 K3pO3fwaX9asCMfDiRPQWRiT62Z3uiiGZOlMrHLMDUwHLFmkrAeO/glh/94B+x9Gxk50
 ZLXsKIj/h71rHoDHubXQdBIkKTs4dh375ZiNFGYzOZ6zQvlWGFEQf7Q2oUoRXqiZI66d
 UaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747815670; x=1748420470;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UW/9eOmcxww1SCoN2sRjbngcwHurM2a/dMr/YjT3Pnw=;
 b=tOJ4mRZ/tQAAxJfD7ZLhwHCmqeVeEgOhZdw3czD3qodSicm0DD3ihNIL+hsoq3+2FE
 lBihev1IZnPw/wIRHIvxWuB49DzjPLSjLc0w0thopiSxTGVwkHyVAEexQKDkQuvHxROH
 1BfDeEQ+kNxBl4nL96YS6Q9ZyvWcGbC3tx5y/FGra1ugZvxgC14yO4Ofnil7Zzi1hRmA
 +5ifOB6GKTxoxTUQE6X5g6hIrcM168voo2NU6Lut/GOOGtuCkKN0+Iz5pEwgxDhBQuR2
 BjfPJB2CkHM9Mt9lIBIxSpOIIbwUmVPnb05quCZkTueRsGj+fJY4qfGwRvoOX2WC9PgZ
 rAag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXudNx+b0HSGM/kTjyJaJChBRIKYI07g8sbtij8jJg0mEnBVLbn9YvW6OdgiPCpgjxGu4EN1mM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6kwLkORJWzdcJmRqRSeTMfp9QGbXgE8PxI/c/uo+iW2ch/qJr
 olAgOZDPjojtJk+uGe7CJndvTq4abpPZdyfqPrblAbZ6kSpa/Bi+ljpeeEUENtOoBXGny1y4zag
 WQxJA
X-Gm-Gg: ASbGncv6Da22elmP9lOt2WxvVJxtXzSEOUxav2jx2PjhcEYwYvjKmLpD9rJuPhdjACF
 HZsn1S3jnHiUqSOiNliUhW3hjax9Pgo2CLnBI4Jrar6n1n4pcORi1xPXxNqk5/G+KPHFP2s4N+G
 zKaXjFD2wsew7uGrhZu8/45tlZ0l1Ozk2X4mtvSDLmtVCW2RaGUMOif6G2fzLyE1TRBrv8ozxIS
 FXCf1xE7EZVw+v9FlSSyZCjCd01X0FlfQTkl8o4qVm7zGtew6YNEZiYLPXG/g1P0scwhH7jEalj
 RhdYpLCfYutmrwOCnIBx39XEBNCZ+RlzJMVFbhArQdiNjzQxmeWhGdgqtB8G3XfwjkDNZNh3zX1
 uk5mWcqwg+h4=
X-Google-Smtp-Source: AGHT+IHVEKGaYRMNk9Zo0F+brPvMgI5+VvMa5gh41lTi2qufrTZKCM4SKohvZqbcaNUnorTLsBTs7w==
X-Received: by 2002:a17:902:dac5:b0:22f:a4aa:b82b with SMTP id
 d9443c01a7336-231de36b4ebmr273864465ad.21.1747815669717; 
 Wed, 21 May 2025 01:21:09 -0700 (PDT)
Received: from dev-linux (syn-076-088-115-008.res.spectrum.com. [76.88.115.8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2325251da10sm42924095ad.42.2025.05.21.01.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 01:21:08 -0700 (PDT)
Date: Wed, 21 May 2025 01:20:57 -0700
From: Sukrut Bellary <sbellary@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Bajjuri Praneeth <praneeth@ti.com>,
 Raghavendra Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/3] Add support for eCAP PWM and LCD pin mux
Message-ID: <aC2M6d2K+/NkP+Py@dev-linux>
References: <20250423084249.197101-1-sbellary@baylibre.com>
 <20250502213218.GA1379719@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502213218.GA1379719@bill-the-cat>
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

On Fri, May 02, 2025 at 03:32:18PM -0600, Tom Rini wrote:
> On Wed, Apr 23, 2025 at 01:42:46AM -0700, Sukrut Bellary wrote:
> 
> > This patch series adds the support for
> > 
> > 1. In am33xx SoC[1], enhanced capture (eCAP) supports auxiliary PWM (APWM).
> > This series adds the PWM driver support for the APWM feature for eCAP on
> > AM33xx. AM335X_ECAP0_IN_PWM0_OUT is used to enable the backlight.
> > 
> > 2. Fix build warning in ti-ehrpwm driver in dev_deb().
> > 
> > 3. Enable eCAP0 PWM and LCD pin muxing to support splash screen on
> > AM335x EVM[2].
> > 
> > [1] AM335x TRM - https://www.ti.com/lit/ug/spruh73q/spruh73q.pdf
> > [2] AM335x EVM - https://www.ti.com/tool/TMDXEVM3358
> > 
> > per discussion on the earlier patch series,
> > https://lore.kernel.org/all/20250319202516.3300444-1-sbellary@baylibre.com/
> > dropping the device tree changes in this series due to OF_UPSTREAM
> > conflict.
> > As we are dropping the DT patch, started with the new series instead of
> > V2.
> > 
> > This series doesn't contain defconfig changes since we don't want to
> > enable LCD, splash screen and PWM support by default.
> > Enabling splash screen and PWM support in defconfig causes u-boot crash
> > on AM335x based beaglebone black. This will be handled in a separate
> > patch.
> > 
> > Sukrut Bellary (3):
> >   pwm: ti: am33xx: Enable Auxiliary PWM using eCAP
> >   pwm: ti: am33xx: Fix build warnings in dev_dbg()
> >   board: ti: am335x: Enable eCAP0 PWM and LCD pin muxing
> > 
> >  board/ti/am335x/mux.c       |  47 +++++++++
> >  drivers/pwm/Kconfig         |   6 ++
> >  drivers/pwm/Makefile        |   1 +
> >  drivers/pwm/pwm-ti-ehrpwm.c |   2 +-
> >  drivers/pwm/pwm-tiecap.c    | 198 ++++++++++++++++++++++++++++++++++++
> >  5 files changed, 253 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/pwm/pwm-tiecap.c
> 
> This currently introduces a failure to build on am335x_evm and other
> variants of the TI EVM:
>        arm:  +   am335x_evm
> +(am335x_evm) board/ti/am335x/mux.c: In function 'enable_board_pin_mux':
> +(am335x_evm) board/ti/am335x/mux.c:435:50: error: 'lcd_pin_mux' undeclared (first use in this function); did you mean 'nand_pin_mux'?
> +(am335x_evm)   435 |                         configure_module_pin_mux(lcd_pin_mux);
> +(am335x_evm)       |                                                  ^~~~~~~~~~~
> +(am335x_evm)       |                                                  nand_pin_mux
> +(am335x_evm) board/ti/am335x/mux.c:435:50: note: each undeclared identifier is reported only once for each function it appears in
> +(am335x_evm) board/ti/am335x/mux.c:438:50: error: 'ecap_pin_mux' undeclared (first use in this function); did you mean 'nand_pin_mux'?
> +(am335x_evm)   438 |                         configure_module_pin_mux(ecap_pin_mux);
> +(am335x_evm)       |                                                  ^~~~~~~~~~~~
> +(am335x_evm) make[3]: *** [scripts/Makefile.build:256: spl/board/ti/am335x/mux.o] Error 1
> +(am335x_evm) make[2]: *** [scripts/Makefile.xpl:548: spl/board/ti/am335x] Error 2
> +(am335x_evm) make[1]: *** [Makefile:2119: spl/u-boot-spl] Error 2
> +(am335x_evm) make: *** [Makefile:177: sub-make] Error 2
>

Sorry about this.
While fixing the checkpatch warning, I overlooked the CONFIG_AM335X_LCD
not set case.
I will send v2 to fix this.

> -- 
> Tom


