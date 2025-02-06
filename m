Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE43CC02196
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 13:08:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4AD180BAE;
	Thu,  6 Feb 2025 14:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lr6cj1Cl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 433AA80944; Thu,  6 Feb 2025 13:57:05 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2545380840
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 13:57:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso185940166b.2
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 04:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738846622; x=1739451422; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=We4HDiPMNYbCvYwxYUbUEJSg0PMU42oeXgZJinNWOQk=;
 b=Lr6cj1ClmSOs4m9ymVtR7v7bt5QG/6MBxWyZ5qhIAsXnEssrV9rE6C3qdA6+dLuZab
 G0tbdWWJcMDj3rZbRNSeignOy+ojvb6fg6kJJlOJ27iSvkimVbgOkgC5WO9CHmGFPNDu
 duZFoY2LS0AkGgTtDrrQCWBt6jMIeaLN/Su5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738846622; x=1739451422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=We4HDiPMNYbCvYwxYUbUEJSg0PMU42oeXgZJinNWOQk=;
 b=H8DyU74SXU+oCBQ7GcVw/ANo8DqW47RS75szBmpRFbaKZ7Z2ZL9Tn38sLI7pPu/24s
 dtTyoXEIsP7b4cI7MXJrptVfwdjcqnm2y519KgfW3wwKqKVuVaUh8O3/YERTNJTaN2ED
 lEYzx1YjQc+6qW/sIO8W8dWxGZNZ79jMbyi4Vn8pxU1kGXIZ3UiICXA9dH0/Bh2M9wZw
 lTT2CgUY3X6t6laBCQkCgD6/KTY8dJnzP2ohz6lCEYjRyCFnZvKj16SjIgh2290I9ExB
 OsoTmrCJtS6qU4sZWyjeMeUWRuKr7w+z9ANZ5I5sY0PwtHUw04NuEWhyngSUtActVcoh
 Ho1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsl8q45gnBRxZxHB++kLyxmIFKQlPry+eMtSckm0YhQ77kPbp6MX5K661ohFAaYrne6i4QqRw=@lists.denx.de
X-Gm-Message-State: AOJu0YyXM0o6w87jbJQsai/28Q8iv1tQqWJ4ehDPpxG/q0YYE7XTq9hY
 2Cm3Dvp5Ql3oy6+sFd3HPuiGObulUGdHQlJ58/gGdpWTihCQfEuXSht75vJZNVSYXLXEHs5pLUK
 m6lWM6+JbCgK2lfvesEqk3ff3CpjnAkzRbyD3
X-Gm-Gg: ASbGnctbjhfp630ooty7hJzlfaM1tcJI4e9+i9nIfe41YdhJcvdb9es+CXp5y/aId++
 4KF8m3/yqWxjj+mVpoPTBlfKLkUrjQfDX6dkAKIRPkvD762B7gbGlxyqcA7UZ4Rg/ywL6jXaq3Q
 ==
X-Google-Smtp-Source: AGHT+IGosU0c5zBtJ3LDyKIZ1yC3409RqeJvHDY5XjSLboGlM5JDK1cRkch3/A2qr0Kxro1hwYS1MO/wBBPb9J0ksDA=
X-Received: by 2002:a17:907:d8b:b0:aa6:b63a:4521 with SMTP id
 a640c23a62f3a-ab75e23a4ebmr667413766b.15.1738846622515; Thu, 06 Feb 2025
 04:57:02 -0800 (PST)
MIME-Version: 1.0
References: <20250203174245.1331464-1-sjg@chromium.org>
 <b3e20c80-f26e-42a5-b477-569b5182ede7@gmx.de>
In-Reply-To: <b3e20c80-f26e-42a5-b477-569b5182ede7@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 05:56:51 -0700
X-Gm-Features: AWEUYZlj2CEhsTat_C3lFhztyNtfhC1DXZpI0OY94zJiAzoozo651bZWSkeCjQA
Message-ID: <CAFLszTht+WdAW11LsuzZOz1UnGszQBf4zC=usjQbM5U8UMGBtQ@mail.gmail.com>
Subject: Re: [PATCH 00/32] arm: Support building as an EFI app
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Albert Aribaud <albert.u.boot@aribaud.net>,
 Angelo Dureghello <angelo@kernel-space.org>, 
 Anton Bambura <jenneron@protonmail.com>, Bryan Brattlof <bb@ti.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Heiko Schocher <hs@denx.de>,
 Janne Grunau <j@jannau.net>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Leo <ycliang@andestech.com>, "Leon M. Busch-George" <leon@georgemail.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahiro Yamada <masahiroy@kernel.org>, 
 Matthew Garrett <mgarrett@aurora.tech>, Matthias Brugger <mbrugger@suse.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Peter Robinson <pbrobinson@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Weinberger <richard@nod.at>, 
 Rick Chen <rick@andestech.com>, Robert Marko <robert.marko@sartura.hr>, 
 Sam Edwards <CFSworks@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 06 Feb 2025 14:07:31 +0100
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

Hi Heinrich,

On Thu, 6 Feb 2025 at 03:56, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 2/3/25 18:41, Simon Glass wrote:
> > The original x86 EFI-app was written back in 2015, about a year before
> > the EFI-loader was introduced. At that point, ARM mostly used U-Boot and
> > FIT (Flat Image Tree).
> >
> > Today, sadly, there are a few efforts to re-invent FIT poorly, to cater
> > to more primitive boot-environments than U-Boot. One justification for
> > this re-invetion has been that EDK2 did not support FIT.
> >
> > EDK2 does now support FIT but only for the firmware stage. Even then,
> > vendors tend to use their own forks, so any new features are slow to
> > make it into the market.
> >
> > EDK2 also supports the ext4 filesystem, but many devices don't include
> > that feature, so most distros make use of FAT for storing their boot
> > files. Since FAT is not journalled, it is not particularly reliable in
> > the face of reset, power failure, etc.
> >
> > As an interim measure, we can use U-Boot as an EFI app running on top of
> > whatever EDK2 fork is in use. This allows use of modern features such as
> > FIT and filesystems other than FAT. So far this only supports x86, but
> > recent ARM laptops are making use of EFI too.
> >
> > So this series adds an EFI app for 64-bit ARM.
> >
> > Note: Since U-Boot does not support EFI's GOP 'blt-only' mode, the
> > vidconsole does not operate, but it can still be used, since EDK2
> > handles drawing instead of U-Boot. As a result, the U-Boot logo is not
> > shown.
>
> Thank you Simon for going through this effort to generalize the EFI app.

You're welcome.

>
> The EFI app should build on all EFI architecture. Will you add RISC-V
> support, too?

Not in this series, but perhaps later.

Regards,
Simon
