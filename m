Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF56DC02198
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 00:05:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AA688083C;
	Sun,  9 Feb 2025 01:05:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DSc0vA8u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9236B807FE; Sat,  8 Feb 2025 23:40:22 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C272807FE
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 23:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5dce4a5d8a0so5312102a12.1
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 14:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739054420; x=1739659220; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GQWo2hnW8jq1ijNosvyhSPj/UwHb1EIbF6FDUoUfj28=;
 b=DSc0vA8uxhAR8GKxIMjH+toGtvs2loZGKimYxErxoJRm83gan4wy+mLEjfENFp0aAf
 KUJXQuk8M+GFx+O6B8A0P81YysHV9Y1OFUB6orKwwC5g7YPKi9IWRtBnKHCZIIA5D7l+
 kmZpsTQlAmY5yo/gdMCcZD1J8ftXxiZL/UBeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739054420; x=1739659220;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GQWo2hnW8jq1ijNosvyhSPj/UwHb1EIbF6FDUoUfj28=;
 b=HqUkt61UHLwKlzobMeSwVywAIJF0B9bshHctw/Upoz4idBDW2uza120Bo1yjVshL9y
 z80Ps+5k5yswKPeXCnZhra/3D6KwJBcHhr4gl269o/f0/GrahvQo6MLhF2pN4d1CIm48
 ZZhMoYpUoSE2xplry2NkaSdyB2N/OY1f8q5OSWpwbFiQZDqnAwLRRXKtQ09HsbmV7XV3
 PMDWwujrY1csZhLIce7qxbS1P1JplRfL0LRgHZNth3mXWHkHHlGhHybZKl4JDU11tQGa
 v6ZR1kwr3avVo6CnSyEUpfpTikOaQ48jrqrOFDitsLvkqd++MrmKqscOcgEB3Gi1JxTu
 P+vw==
X-Gm-Message-State: AOJu0Yz+hXElhW+jYlojQGWgrDwMa8j5kZXOTl8nTwRJ98cU3DtYCD2l
 ynamo7BFJ4zxleAlnfDdlLXU8Ox+3nMpa/FVIv3UQXXrwJoMawytHQ8nfcdmSWDHUMRLcneVgom
 EHD4bLCKzhjplmG6oGLWagwM3/P5U79ED4j3x
X-Gm-Gg: ASbGncuoyikYrN/GaLpZQV6P/AbceNqbxNwwoRfYacpA2Y6yvtC241PWw+eZ+pi5Mdh
 GH9EaAift/jTMN+HeRgBQyGPWjuO9GH6v0e1uHZ8jWf9wDjPArYCrgKGvhQLhJEPXuABHT8QEzA
 ==
X-Google-Smtp-Source: AGHT+IHCzTqcIPQPjCcDVzuqw28StCbXvizROOStOOztJ2Qx5Ep//sQVMQZHbthCnxoAWowSHpar6bCopPFlkum6Bmc=
X-Received: by 2002:a05:6402:5290:b0:5dc:ea7e:8c56 with SMTP id
 4fb4d7f45d1cf-5de45070792mr21755699a12.22.1739054419899; Sat, 08 Feb 2025
 14:40:19 -0800 (PST)
MIME-Version: 1.0
References: <20250208171154.1305761-1-sjg@chromium.org>
 <20250208212912.GE1233568@bill-the-cat>
In-Reply-To: <20250208212912.GE1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Feb 2025 15:40:07 -0700
X-Gm-Features: AWEUYZkzWHHSy98_ogCwM6Xt-f_i8pSn0BV6qdj2zWQYa9SYsKL8CZB2qrUofa4
Message-ID: <CAFLszTg6oqMWK05Ldrk4wFUJ7Yr0Xha_z-RJpp1ez=3R5Jdn6A@mail.gmail.com>
Subject: Re: [PATCH v2 00/29] arm: Support building as an EFI app
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Albert Aribaud <albert.u.boot@aribaud.net>, Anatolij Gustschin <agust@denx.de>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Anton Bambura <jenneron@protonmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Greg Malysa <greg.malysa@timesys.com>, Heiko Schocher <hs@denx.de>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Jonas Karlman <jonas@kwiboo.se>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Leo <ycliang@andestech.com>, "Leon M. Busch-George" <leon@georgemail.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Matthew Garrett <mgarrett@aurora.tech>, Matthias Brugger <mbrugger@suse.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Richard Weinberger <richard@nod.at>, 
 Rick Chen <rick@andestech.com>, Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 09 Feb 2025 01:05:23 +0100
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

On Sat, 8 Feb 2025 at 14:29, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Feb 08, 2025 at 10:11:20AM -0700, Simon Glass wrote:
>
> [snip]
> > Changes in v2:
> > - Depend on CONFIG_EFI_APP instead
> > - Drop change to u-boot-elf rule
> > - Mention '64-bit ARM' here, rather than just 'ARM'
> > - Drop the word 'Sadly'
> > - Mention '64-bit ARM' here, rather than just 'ARM'
> > - Add new patch to rename VENDOR_EFI to ARCH_EFI
> > - Update to use ARCH_EFI instead of VENDOR_EFI
> > - Mention '64-bit ARM' here, rather than just 'ARM'
> > - Mention '64-bit ARM' here, rather than just 'ARM'
> > - Rework the commit message to clarify the relationship to link-scripts
> > - Expand commit message to explains that EFI_APP skips relocation
> > - Mention '64-bit ARM' here, rather than just 'ARM'
> > - Document the x86 field better and add a comment for ARM too
> > - Mention '64-bit ARM' here, rather than just 'ARM'
> > - Put the EFI-app case first in setup_mon_len(), for clarity
> > - Use ARCH_EFI instead of VENDOR_EFI
> > - Merge the linker-script rules into Kconfig in this patch
> > - Drop patch 'Select the EFI linker script for the app'
>
> There's things that were mentioned for v1 that aren't in this list, did
> you miss them or disagree with them?
>

The only one I think I didn't do was ' Drop exception code'. I'm not
actually using / enabling an SPL symbol so I think you have the wrong
end of the stick.

Regards,
SImon
