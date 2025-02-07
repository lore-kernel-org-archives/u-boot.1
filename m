Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B7AC02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 00:50:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 281768091A;
	Fri,  7 Feb 2025 01:50:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NP8x6pOF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AA1D8083F; Fri,  7 Feb 2025 01:50:00 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F759809D4
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 01:49:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5dcd9c38f66so5042983a12.1
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 16:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738889396; x=1739494196; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hyBmwjtxWlNKC/iszENU9Vmozs/Hr+Z0BP7hQ8RxNyY=;
 b=NP8x6pOF2kB+rx076u0At99R3Z5E7cxYxllpY+1rVHnejX7rJi5FaxS0senpLgqIo4
 NheWTgO0wfq2k64/z0diUg5yhscHmG2XUA4r5kGN/x5Dnd8grX7vjwZTpVZ3TIBF5zqw
 7cqposZPHqJSDZGDDdwWje5xdOhWTyHPJ2fSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738889396; x=1739494196;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hyBmwjtxWlNKC/iszENU9Vmozs/Hr+Z0BP7hQ8RxNyY=;
 b=DZ2hMqKtIKsmV6LHlB72u1NYmn0ucNA01zq+VXdtyJSbuuIqA8QuoEhyM26u83PIMH
 66aWjd54HzQuaaWMjFglIfZjw+8GOo2ocwP3mtxFpmqMECq9ii/bCCFsJZ6qlmWy1f6K
 S+s4m2Dpxf3u09z9ZeRIwjuUhXBwjONRlc1MdZW4E7hkDU7q3MNEas/vCxl3V9p9Fe3J
 8Cw0tXZYTu9FwQI0ZhH16QOFnc3ukx2aA+klhYwsO3MIDdPVNZS4XJ97kUJZeK0/BOFk
 lM0nNWImKA9G2wqS2ha/ysGcUfa574b+2EczaECA5pGe78VVEoUBSjTGkxXKvbeHAI2e
 oGVQ==
X-Gm-Message-State: AOJu0YywX+ms2x5IJAP5Nd/LslYkGpRlkY7ihGcMSqCkcnv0MEXhhQxp
 pX+aji4Y540qNMrdD4QM+iRg7Xp62XrMC3qf+0SlovvBbzaVPJuSOgT34HzjxWrHeQZtaYKomcS
 5JD3yLE6AspRN2mH5JO06HGF361T5vzn6eRYx9dijHvXxqAY=
X-Gm-Gg: ASbGncsOLgPyQTULv9nXMYdA5T/SUuEE3F8FpnkVK3KYj2E0y8ny1cVi+VqyHYndgyd
 VW6UNUKNgsWzTGNxdOy6jvAYVjXSqYQlvjJIISCAWITGPTtI59qYEejXms5Wz9pCh8VQ/+Urh+Q
 ==
X-Google-Smtp-Source: AGHT+IE21qrp/pCLPEZ6LVCtItoaenmHxHYFGwuck96V3E/Oiol4zdH6cikWuIXHLmQXolFSkvn+EOGiBSDBZyivfO4=
X-Received: by 2002:a17:907:1b25:b0:ab7:843c:2cbb with SMTP id
 a640c23a62f3a-ab789b14057mr87146466b.11.1738889395858; Thu, 06 Feb 2025
 16:49:55 -0800 (PST)
MIME-Version: 1.0
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-22-sjg@chromium.org>
 <20250203200937.GL1233568@bill-the-cat>
 <CAFLszTgO-nErzRg4FnM3rGCeHgfsAKCui3p9OhqP1YipyyN3=A@mail.gmail.com>
 <20250204020008.GB1233568@bill-the-cat>
 <CAFLszThqpfGF1pgAy4GP0Yt+jZsKdYwC0bRcnnsy0WduAYBEXw@mail.gmail.com>
 <20250206170745.GG1233568@bill-the-cat>
 <CAFLszTiJ_zB4_dCJNjOAbXtfBmM2KxbHXxiw4gpRMMsJdOM2hg@mail.gmail.com>
 <20250206232206.GP1233568@bill-the-cat>
In-Reply-To: <20250206232206.GP1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 17:49:43 -0700
X-Gm-Features: AWEUYZkZ3CDsm4_9g0SaAYqy6C6I_yfgWKky4psto9aWImFBNZbXmmuJ_E0htCg
Message-ID: <CAFLszTjGDidhi+FDfGi36mgLUNbPQ+TskgUyF7znhDC+H7MDzQ@mail.gmail.com>
Subject: Re: [PATCH 21/32] efi: arm: Drop exception code when running as an
 EFI app
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
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

On Thu, 6 Feb 2025 at 16:22, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Feb 06, 2025 at 02:27:13PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 6 Feb 2025 at 10:08, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Feb 06, 2025 at 05:33:06AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 3 Feb 2025 at 19:00, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Feb 03, 2025 at 05:38:52PM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 3 Feb 2025 at 13:09, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Mon, Feb 03, 2025 at 10:42:14AM -0700, Simon Glass wrote:
> > > > > > >
> > > > > > > > This code cannot be used since EFI is in charge of managing exceptions.
> > > > > > > > Drop it.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > >  arch/arm/cpu/armv8/Makefile | 2 +-
> > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > >
> > > > > > > Why is SPL on in this case?
> > > > > >
> > > > > > SPL is enabled by a specific Kconfig option, which seems to have
> > > > > > exceptions but not exception levels. That seemed to match what the EFI
> > > > > > app wants, for now.
> > > > >
> > > > > OK, so why aren't you turning off SPL? You're not using SPL at all,
> > > > > right?
> > > >
> > > > Not using SPL, but using the same code as SPL happens to use.
> > >
> > > But is CONFIG_SPL enabled, or not? It shouldn't be if I follow you.
> >
> > No, it isn't enabled. But we do want that exceptions.o both for the
> > EFI app and for whatever boards use SPL.
>
> Um. Isn't that the opposite of what your commit message says?

Would it be clearer if I said 'exception-level code'?

> And the
> Makefile snippet today is:
> ifdef CONFIG_XPL_BUILD
> obj-$(CONFIG_ARMV8_SPL_EXCEPTION_VECTORS) += exceptions.o

^^^ this is the line that I want enabled for the EFI app

> else
> obj-y   += exceptions.o
> obj-y   += exception_level.o
> endif
>

Regards,
Simon
