Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B77FC36010
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 14:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49D1281DDF;
	Thu, 27 Mar 2025 15:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YTLCSims";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E554C81D3B; Thu, 27 Mar 2025 14:36:20 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA54081B4B
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 14:36:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac2bdea5a38so170831066b.0
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 06:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743082578; x=1743687378; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ReX6cXoF2sKMV5K7MFlkNTlmSBfXF7NUac1V016rQbA=;
 b=YTLCSimsftRJftMlJKBJtzIbLU2s+VZp7oKBabpWasR8GZ5xtICtaKRFxO6AiV2RDz
 jpxY9S9RjZINS5pz3B1B9/34KMxOohGDt6jqiwC6iREqUbUc79DqzBCSvv+2CBDdwkmd
 gnVZTQOqKm8UBR5FVpDIMoOM4Tglc4T6T76tM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743082578; x=1743687378;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ReX6cXoF2sKMV5K7MFlkNTlmSBfXF7NUac1V016rQbA=;
 b=db46XnmvLWr1SMnyAoHPCf+TUSszyG6pjjr+dCZa7nx/3fBnC6NgHsWK+AQ5j2uNWB
 dmK8PeZzTU9mvcfdUgErh1Aa1x4icpshP3FQAF26wuQ7k1+Ss6kMn3ucuW4qHulZp7rw
 ic4au1n4U6f5jPLQDGxFN5A1TftK7zC0T9wOvgJ/v/IUWhqs5w3JQ7dgx7FkXeilJOdd
 uTNOix/j/RxdMy6dXAWG6RfJ12KoRPsGj441LPAJBrHZ1guiDwczrr8XTbuoNssEFQrJ
 X5d/GG7R0ZPKJ7MSZ3ST0ejKFQslUPYivMU32S5hg3GVnR1JlTwoyvfJT6C3IMQGMTuF
 0aNQ==
X-Gm-Message-State: AOJu0YyxYG555JnGEEU6a+fCGEembIJyiQkGk9jBLxzc8ZASzEn3QYWT
 iDYAKzEsudHlg3ppyBhLlqri/naMd1y2bxYrSNt833JB6NSUmdPv3pIbw6EZNHku3qMKxIXyAgO
 WuEJpLr9A+GhZ77NJzcL9QFQ9vI+Hu1qPbcjD
X-Gm-Gg: ASbGncva4ozmjqAs7KxINPcWnpTS/Mp3vOiqqHzceS5K/LJNcVGbSeZFqJ/BEMLK7CI
 RHzApnI31k4Bp45bEtW3ubrGAXYdq0eSA+Epz3tJTLYFKMFhwTfhJM1Uabll92FsdndZg64OxKx
 WHWEEO78RtPIhNOIMnuekfEIsDcis=
X-Google-Smtp-Source: AGHT+IFhzC4GFYhFI4f/XYdcoLtslQGF5rT2u6kfjbTabGLk7YyPUlWHok7pj3d2ZFlgDWsxr1gja0nSSzcgPTxupyI=
X-Received: by 2002:a17:906:c111:b0:ac3:154e:1386 with SMTP id
 a640c23a62f3a-ac6fae5f9c7mr349132466b.6.1743082578216; Thu, 27 Mar 2025
 06:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250215032254.4121030-1-sjg@chromium.org>
 <20250221204531.GS1233568@bill-the-cat>
In-Reply-To: <20250221204531.GS1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Mar 2025 07:36:06 -0600
X-Gm-Features: AQ5f1JoXWeGWBHwu7TSRbouNA5zBoQn1By9TAwnU4BbRo4qhTGt1TRf50huR0F4
Message-ID: <CAFLszTj3kyGwC-EY+s5g5T0dBN+7Bg3i8crySiqzGirTAFX-nA@mail.gmail.com>
Subject: Re: [PATCH v4 00/29] arm: Support building as an EFI app
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Anatolij Gustschin <agust@denx.de>, Angelo Dureghello <angelo@kernel-space.org>,
 Anton Bambura <jenneron@protonmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Greg Malysa <greg.malysa@timesys.com>,
 Janne Grunau <j@jannau.net>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Leo <ycliang@andestech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Masahiro Yamada <masahiroy@kernel.org>, Matthew Garrett <mgarrett@aurora.tech>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul Kocialkowski <contact@paulk.fr>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Weinberger <richard@nod.at>, 
 Rick Chen <rick@andestech.com>, Sam Edwards <CFSworks@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Trevor Woerner <twoerner@gmail.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 27 Mar 2025 15:07:52 +0100
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

On Fri, 21 Feb 2025 at 13:45, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Feb 14, 2025 at 08:22:21PM -0700, Simon Glass wrote:
>
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
> You did miss some of the tags I provided against v3, fwiw.

I see this is marked as 'deferred' in patchwork. I'm going to apply it
to my tree.

If you like, I could do a pull request against -next with the EFI-app updates.

Regards,
Simon
