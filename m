Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9E1C71150
	for <u-boot@archiver.kernel.org>; Sun, 15 Jun 2025 11:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 887F282C2F;
	Sun, 15 Jun 2025 13:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g/UInwhj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E11BC82C84; Sun, 15 Jun 2025 13:02:31 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3C9C82B0F
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 13:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ade326e366dso631415666b.3
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 04:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749985349; x=1750590149; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DoiHhUzqNrmhJlP8x5BsqFEuf0wrC3QPynwDy3h9xi0=;
 b=g/UInwhjsCmQjtOaHWCl9Ijt8/MTWioVOPpGyyv07wqW5XJa16bUMzSjO+GVCR9St2
 63QLle2HM7WIrEOv5ffqb7ZWQ0jIfL6XwcyInVpnAQ+WxDUvaNLh3qPMDH9OFEAlxZmM
 N4YqmzCbjTO5f3ymsHNUtDOtc9FSIMS1oNPLyx3I6Y9u3BNiemdRzFKBgbk73/aYvAvL
 y/0Nbkq7jyQJ+44/DU+UjtYlkfN7Pr8eMTcPKHWPb4Zl06x47C6gvIdguVlcco9pnk/4
 CCNXawsg2MngPwUr+PQqp23bT4g+hFS6m2OP5Sii/xArZCqgtvPI9BmLOy+hpH0izdWJ
 dcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749985349; x=1750590149;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DoiHhUzqNrmhJlP8x5BsqFEuf0wrC3QPynwDy3h9xi0=;
 b=s//6byWDCQuqcsD1ybNQQbENuRRTdPl3YNyuP1UYt0T8HNqLjvn6ZEdZPN3LIcimww
 srqlzKCENVyEk06qaKtwneaZTy/n53EP/TSKNZlR7DX3nrE+CnEcTnrwUJwCTIl8yjKx
 pFvumzdSSgrOIEzyyWLrrXXs6aZKz0eVK8sObJac4R/zjU9+yy8AmXxVp9KgUDoWmtqv
 Rxt9iAfSf4ODSxuLn5wi2Hj3/YAjiWP17p1PgpHxWya+ZvHiWy3ajILsgh3nbgwqb4TD
 88MYs5hY6B5NozO93MyHLPPCHT1CFfUX7Aowj7JWfolfQJvRuWtCDq7leAc4U/UtHSWy
 uiyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/G0Jn1U/u2w+NfmL4UflYb4G5uDvP6GecGg5G3RTKA9nbNBC29ZGBmpV5ohXi+NColk/R4/w=@lists.denx.de
X-Gm-Message-State: AOJu0YxmDvPP0cykX87NGe5i4T/+/ID7FeEgsoCs9Z28lOYXqYt9se3m
 L1AF0UTmswcxlqeXnfl6433YUcXksalArnoJT9g+Ze7TJnzt752Lz+Di+K6srZAUI34surfzZUC
 jzLtoczzuY2hjNd0ZcpOeGOMSr3L4oy4=
X-Gm-Gg: ASbGnctPXNreOQk0EksVpNj64fXTsN6wDYF2zCwHvTgH+nrPdYJ1anhVxe072TH1dqi
 d0jWWNxNv+WRmyNsmwtC4HxVfD7q9t7MfetPI7ZU6bewcTAVqGZlpTi9NA/igFhsI2lZWGJmqCu
 psPa1h8zU3wIijmg4RcivQldGIPuJOiITThqsiGTd+1XrcNlImiPlb8Xjvy4W+2pXOy2cXlox0O
 l5F
X-Google-Smtp-Source: AGHT+IFxiEASEJ/HaZ/UBtoSLf/ra4gmSsDv3LRDOG98SEE8wynGRLFAGG60WW9W8CAXl4Z5qq6BwJDdDgN6uJ26IWc=
X-Received: by 2002:a17:907:3e93:b0:ade:40cb:2515 with SMTP id
 a640c23a62f3a-adfad4f649fmr492834266b.59.1749985348990; Sun, 15 Jun 2025
 04:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250502113556.134731-1-brunosampaioleite@gmail.com>
 <20250502144031.GT1261075@bill-the-cat> <87frhj5r32.fsf@prevas.dk>
 <20250505134843.GK1261075@bill-the-cat>
 <87zffq95f7.fsf@bloch.sibelius.xs4all.nl>
 <20250505212816.GP5430@bill-the-cat>
In-Reply-To: <20250505212816.GP5430@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 15 Jun 2025 12:02:17 +0100
X-Gm-Features: AX0GCFsuZAo-n63G3W63nUXeAylW3HRNR8mvxasOrdfuJ76QO_yv5YpmWo4VtVU
Message-ID: <CALeDE9ME103UAwSu333dD=LmVQPPXtopEA6qqV=mLu9L-SnvUg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add rpi5 specific defconfig
To: Tom Rini <trini@konsulko.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, ravi@prevas.dk,
 brunosampaioleite@gmail.com, 
 u-boot@lists.denx.de, probinson@gmail.com, mbrugger@suse.com, clast@prevas.dk, 
 brule@prevas.dk
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

> > > > >> Currently rpi5 uses a generic rpi_arm64_defconfig file that builds rpi4
> > > > >> devicetree. Add a defconfig that is specific to the rpi5 building the
> > > > >> now available upstream dts for that board. The defconfig makes use of
> > > > >> defconfig including that is now available and only changes the DTS
> > > > >> related config.
> > > > >>
> > > > >> It is also necessary to add a more specific u-boot.dtsi to rpi5, since
> > > > >> due to the ARCH_BCM283X config it will try to build the
> > > > >> bcm283x-u-boot.dtsi and break.
> > > > >
> > > > > My question is, can we not adjust rpi_arm64_defconfig to be generic
> > > > > enough and not have a problem on Pi 5 due to the default device tree?
> > > >
> > > > Not really.
> > > >
> > > > What we want is to have CONFIG_DEFAULT_DEVICE_TREE to point at the
> > > > rpi5's .dts file, because we really want to build that and not some
> > > > "random" dts file that doesn't have anything to do with the hardware. I
> > > > know that kinda works for the setups where the .dtb built in U-Boot is
> > > > not used for anything, but in our case, we really do want to use the
> > > > .dtb from the U-Boot build - we inject various U-Boot specific stuff via
> > > > the EXTRA_DTSI mechanism, e.g. public key for kernel verification.
> > > >
> > > > And due to CONFIG_SYS_SOC being bcm283x, and bcm283x-u-boot.dtsi
> > > > referencing nodes that simply don't exist when building
> > > > bcm2712-rpi-5-b.dts, the build breaks.
> > > >
> > > > Perhaps the real problem is CONFIG_SYS_SOC being bcm283x for rpi5? I
> > > > don't really know why rpi4 is both bcm2711 and bcm2835 and what the
> > > > difference is, but rpi5 only seems to include a bcm2712.dtsi which does
> > > > not include further dtsi files.
> > > >
> > > > If rpi5 has nothing to do with bcm283x, then perhaps a better approach
> > > > is to ensure that CONFIG_SYS_SOC is bcm2712 when building for
> > > > rpi5. Something like adding a CONFIG_TARGET_RPI_5 choice and adding a
> > > > 'default "bcm2712" if TARGET_RPI_5' ?
> > >
> > > OK, so I guess my next question is, is rpi_arm64 useful enough in the
> > > end for Pi 3 and Pi 4? I would have expected that it doesn't matter what
> > > tree we build in to U-Boot as we would be using the one passed to us by
> > > the prior stage firmware, and then update that at run-time as needed.
> >
> > Works well enough for us on OpenBSD.  And it would be nice if
> > rpi_arm64 would work for the Pi 5 as well.
>
> But that gets back to my first question. Can we correct the code such
> that we do whatever is required at run time, as the previous stage will
> have assembled and passed a correct device tree already?

Typical RPi users want one of two things:
1) use the DT provided by the prior FW stage, this has the advantage
that the FW deals with overlays, will add configs automatically based
on HW/settings/actual device etc.
2) Use the DT provided by the Linux kernel, we have code to detect the
HW and load the right DT in that case

This is why we've never really bothered with the full RPi DT in U-Boot
because it's always a worse experience that either of the above two
options and allows a more straight forward config making support
easier. Even with the RPi5 I am still yet to to be convinced there's a
real reason this would change.

Peter
