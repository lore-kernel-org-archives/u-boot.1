Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71A3C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 13:17:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C10180C6F;
	Sat, 15 Feb 2025 14:17:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mAJP/PcT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9317280C77; Sat, 15 Feb 2025 14:17:56 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFE6C80B98
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 14:17:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-abb8045c3f3so27862566b.2
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 05:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739625473; x=1740230273; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R+JyeyrNaD2gheeG6XyniNgZOdSIlLzfVwTSyXMGXWI=;
 b=mAJP/PcTr+AquU8gPHjjqNBbCyJW7bRf+EqNsQxmy1HIdFHyrjO3Gvur2L9GudLgZH
 7WaO1poGywlAWKYYM5DJi1MZJILNUDnTTLTglNf4aG6LUKtnNLUY7ylLdQBfJB8cH0l7
 VFLB+BQwCpX4FfTof4J/8L5xohfNLjB9q9FmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739625473; x=1740230273;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R+JyeyrNaD2gheeG6XyniNgZOdSIlLzfVwTSyXMGXWI=;
 b=rBgeMl+Y+046D5SyQLOwAAWTA5rlyWrlmD+7FYTwnqBcYhYQUbLDjExqCe757OaqzW
 NnLmCWi3HTfTGo+7GKScvn+rCSgCj8J9Rd7NQxlDLjKNSzhEaDU2pT8fqvMlAXXLTASI
 HblMcrFYJawnGrY/zF8WQsmfCbLx/6LQgTYG3GtFp00vQFpFDDGC90GRMc1J8YWjA0cm
 d6I7jd0b2Qj+6LRzdfdgVdK/ka1LCvXQ4aEfOssmKelZULzPwTDWPgsn/oLeNnAINjBa
 BsRsrqoDLoBBFjwvOA5FVDJqswHpYS/cSYdfFAXsynSK1GV2srP0CeL7/XZDTxVgyWBI
 Hk4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxZltDMR2ddehYrGUBWF1ULng5/KTUNOmmf1U9TmzDenrzo8t4OfVWZnv9P8pswCCR2Hbo58s=@lists.denx.de
X-Gm-Message-State: AOJu0YzEu8NgD5EB3ToCseNzYTEKrnJhThPzIO25teKg7rmmxdL/SrLI
 KWWPVCTwFBf4DTmD9raKs9vPX+Ns5YnOSeLgT/gyZAdwuA9Gc6G1bx1WwHNcFz47y8qCnYsh/gV
 bNrmNHhB7Nfk2l2wC/LM1hCyMoqttwWPhMROJ
X-Gm-Gg: ASbGncuCCsYD9gN8j+KPvZhmK19wh2M7ozkaa3WfsMynORMnvDx+5ZBClLy/nEn+YqS
 pj8Bw30BmRcTP7Uv7IpXLzvewzuiu5gpdlFRcVLQUwCCTFiJ+VvOf1VnL90dlXzl3eAg6hJACqA
 ==
X-Google-Smtp-Source: AGHT+IG4SsbpUUmeIGNrWeN5nUXD9K1PUFAIHKJZX/Hezf7ekhGQAeiW58DPlz6lm2RpxYJKS2mN4TN+lKSWuDuD0lo=
X-Received: by 2002:a17:907:9716:b0:ab7:d77b:43b2 with SMTP id
 a640c23a62f3a-abb70c486c1mr328250366b.33.1739625473131; Sat, 15 Feb 2025
 05:17:53 -0800 (PST)
MIME-Version: 1.0
References: <20250211-has_rom-u-boot-rockchip-spi-bin-v1-0-0d77f95b6239@cherry.de>
 <CAFLszTic+bPv-JjsZ4JVz1RXQ247rmjPbGYzQhi5Z8=PC1728w@mail.gmail.com>
In-Reply-To: <CAFLszTic+bPv-JjsZ4JVz1RXQ247rmjPbGYzQhi5Z8=PC1728w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 06:17:41 -0700
X-Gm-Features: AWEUYZmB3ecZJ6u_ByFsDbZeDKcfjtKJk9ViLUoQEC-RL1rILjobhEi2uW9m5Rk
Message-ID: <CAFLszTgunKAxdNwd9sO5=0bH1zrJkhMLackQ1gOfQqyApm91Jw@mail.gmail.com>
Subject: Re: [PATCH 0/3] rockchip: remove u-boot.rom generation and use
 binaries from simple-bin in simple-bin-image
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Quentin,

On Thu, 13 Feb 2025 at 06:54, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Quentin,
>
> On Tue, 11 Feb 2025 at 03:29, Quentin Schulz <foss+uboot@0leil.net> wrote:
> >
> > This gets rid of u-boot.rom generation as that was used only on Rockchip
> > Chromebooks and their maintainer (Simon) seems to agree[1] that
> > u-boot-rockchip-spi.bin should do the job now so we don't need to
> > generate it anymore. This was agreed for RK3399 Chromebooks, I'm
> > attempting to do the same for RK3288 Chromebooks as well so we don't
> > have anything requiring that u-boot.rom anymore.
> >
> > Since HAS_ROM is only guarding this u-boot.rom generation, they are
> > removed too from the individual configs.
> >
> > Finally, this also fixes an issue reported by Naoki[2] where binman
> > would try to find symbols from proper to install in xPL binary only for
> > it to not find it as we do not generate (on Aarch64) the proper binary
> > in simple-bin-spi image node, only in simple-bin, so it cannot have
> > access to the symbol. As to why this triggered only when some seemingly
> > unrelated symbols are enabled, I do not know.
> >
> > The first two commits are cleanups. If they are controversial, they can
> > be dropped and I'll apply the same fixes for rockchip-u-boot.dtsi to
> > {rk3288,rk3399}-u-boot.dtsi binman nodes.
> >
> > Note that none of the patches were tested outside of a simple build
> > test.
>
> Are you able to run them through my lab?
>
> >
> > [1] https://lore.kernel.org/u-boot/CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com
> > [2] https://lore.kernel.org/u-boot/20250129132529.807031-3-naoki@radxa.com/
> >
> > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > ---
> > Quentin Schulz (3):
> >       rockchip: rk3399: do not generate u-boot.rom anymore
> >       rockchip: rk3288: do not generate u-boot.rom anymore
> >       rockchip: avoid rebuilding most binaries for u-boot-rockchip-spi.bin
> >
> >  arch/arm/dts/rk3288-u-boot.dtsi       | 24 ------------------------
> >  arch/arm/dts/rk3399-u-boot.dtsi       | 35 -----------------------------------
> >  arch/arm/dts/rockchip-u-boot.dtsi     | 10 ++++++++++
> >  arch/arm/mach-rockchip/rk3288/Kconfig |  5 -----
> >  arch/arm/mach-rockchip/rk3399/Kconfig |  2 --
> >  5 files changed, 10 insertions(+), 66 deletions(-)
> > ---
> > base-commit: 636fcc96c3d7e2b00c843e6da78ed3e9e3bdf4de
> > change-id: 20250211-has_rom-u-boot-rockchip-spi-bin-df31b06ad2f3
> >
> > Best regards,
> > --
> > Quentin Schulz <quentin.schulz@cherry.de>
> >
>

I'm not sure if you have tried this yet.

This series produces a SPI file but the size is not the right size
(4MB). How could we solve that?

Regards,
SImon
