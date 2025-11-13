Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88718CD98D2
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 19:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0CB78401F;
	Thu, 13 Nov 2025 20:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WQLg3wlO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBAEE84027; Thu, 13 Nov 2025 20:57:46 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A66F584009
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 20:57:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-640b06fa959so2225106a12.3
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 11:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763063864; x=1763668664; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SGhfjlbDSrQFbvtosnoZKFsIbZOJPkchqf7O5FzHYj4=;
 b=WQLg3wlOovD78YCvRssfY3aoZMzQsrFAZTil0kK+LgCFOzwVVWVw4s7p3WkKDyxgNE
 T4JAb9v5fUwlgo2oqmu/PGC5mUgUSaD07kKRO7pwA7bWfUgE50Ar79XJ/1gxbE5KzZhe
 kTdv+p5l0r/3QRwNEyu5vajLrqeKZWr6IDnP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763063864; x=1763668664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGhfjlbDSrQFbvtosnoZKFsIbZOJPkchqf7O5FzHYj4=;
 b=v0/nHSogmfaglja9ZPudHNO59JdhvCXw5EfnRrppC1+3GaWG6C8ljm20IBl4pTtoeE
 mJ8cIJnqlDAx6X0FNVaHevv6mY8065wR7I5ckII0/HBxlxwqR81it6y+ZU6C3Y/A3FN7
 LghFQLQLdhW1OqGNPW8nTwBVL/uCyFunrS8yotxmeywN4iJAnoyeEBo4xDQeJeneSJb7
 Z8IWu7KWwudKPa9zJTqapElq36stmKmO67ztYQAE1F2APfMU4OHZ34YoAhofA/QRm0V0
 NKpHNbPNVFuic8hSPGassSj5WBuD2WHiEDJfnVcWpZWzZtlS708YQbKO3s/qskApSnNe
 ivTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW021JJ73cdBABftGKbOMDuvYKL64z8MoEQm8fodyBlEXygIagt/kSAWhxWq+XCxHTiqgr8Hvg=@lists.denx.de
X-Gm-Message-State: AOJu0Ywjt8JppkniM8p/CCQ7JmiVZO70mWjUWnDZJudwkdFkfoQWfFo3
 hGfb39K/aLtUmMGX965V9fxuCco3Y+3Pur3n6E5nV/84sJMJmSaygRfdxOaMQ6+eoymEq37s3g5
 azfg9QO559f0ziXHjWrSBVJwGqMtGGohKoS1MliJT
X-Gm-Gg: ASbGncvPXpiZTZVMkP4fkbL/rC1XzO/B0MsullXu8bVVRIjTC+MB+QPryLtkZREQEEX
 PhB3T3+u7e+wshUDOzNVqYXorbU2ZLoOhLS7Tf/Mm5MgdvTLUywfxlnIAKxEWZ0hf8XrltYGiFj
 ePsYCDgc/WPNRwVaI0XJbl4rTX+DKw+MxLXeQv5g3inteYUFm3tCBsGHwakiSYgrnzm3mqMnQzH
 OHwwv3Vcg9qs16DQ9jCAgq+693d4Dsi8EI+dXZUZmUAKSKeWbyK4beEvf/xF0Apphfezw==
X-Google-Smtp-Source: AGHT+IG3IU5hMBC00gR4+AVP8MtwCR7d6/KFKDNZq6kIAiaIhuFklo9tnzcqlQQRW2B7UHEwRPy+fZKyxHUIllo1trY=
X-Received: by 2002:a17:907:a089:b0:b73:5f5e:574d with SMTP id
 a640c23a62f3a-b736796a33bmr37589466b.59.1763063862545; Thu, 13 Nov 2025
 11:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20251112011717.360045-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTjofjQ_zmwJrGZ-sLejQ=x=-8tyqr4SBPYgt3683GVAbQ@mail.gmail.com>
 <20251113193816.GP6688@bill-the-cat>
In-Reply-To: <20251113193816.GP6688@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Nov 2025 12:57:30 -0700
X-Gm-Features: AWmQ_blbQTTXYdMkEgaekaeypIizFQuvIZ4K5YbqdIAyV3EMJS1gOGa5l2Oi6h0
Message-ID: <CAFLszTjwpoCwCKKvJX5cZMLK480EK-=BWaFd5A6yLMrfsVWC6g@mail.gmail.com>
Subject: Re: [PATCH 1/2] boot: android: Always use 8-byte aligned DT with
 libfdt
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Aaron Kling <webgeek1234@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>, 
 George Chan <gchan9527@gmail.com>, Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nicolas Belin <nbelin@baylibre.com>, Sam Day <me@samcday.com>
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

On Thu, 13 Nov 2025 at 12:38, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Nov 13, 2025 at 12:33:24PM -0700, Simon Glass wrote:
> > Hi Marek,
> >
> > On Tue, 11 Nov 2025 at 18:17, Marek Vasut
> > <marek.vasut+renesas@mailbox.org> wrote:
> > >
> > > Newer versions of libfdt strictly check whether the FDT blob
> > > passed to them is at 8-byte aligned offset, if it is not, then
> > > the library fails checks with -FDT_ERR_ALIGNMENT . Currently,
> > > android_image_print_dtb_contents() passed FDT directly mapped
> > > from abootimg to libfdt, and this FDT is not always aligned to
> > > 8-byte offset. Specifically, the FDTs are somewhat packed in
> > > the abootimg, therefore if the first FDT blob is e.g. 0xfd bytes
> > > long, then the next FDT blob ends up at 0xfd offset, which is
> > > not 8-byte aligned.
> > >
> > > Fix this by first extracting the header into 8-byte aligned buffer,
> > > checking only the header for validity, and then by copying the
> > > entire FDT into newly allocated 8-byte aligned buffer. While this
> > > is not efficient, it is the correct way to handle DTs, which must
> > > be at 8-byte aligned offsets. Mitigate the inefficiency for the
> > > common case by checking whether the DT might be 8-byte aligned and
> > > if it is, map it directly.
> > >
> > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > ---
> > > Cc: Aaron Kling <webgeek1234@gmail.com>
> > > Cc: Eddie Kovsky <ekovsky@redhat.com>
> > > Cc: George Chan <gchan9527@gmail.com>
> > > Cc: Julien Masson <jmasson@baylibre.com>
> > > Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> > > Cc: Nicolas Belin <nbelin@baylibre.com>
> > > Cc: Sam Day <me@samcday.com>
> > > Cc: Simon Glass <sjg@chromium.org>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > Cc: u-boot@lists.denx.de
> > > ---
> > >  boot/image-android.c | 46 +++++++++++++++++++++++++++++++++-----------
> > >  1 file changed, 35 insertions(+), 11 deletions(-)
> > >
> >
> > OK, we need to adjust mkimage etc. to handle this. Until then I think
> > we should have a way to disable the 8-byte-alignment check as it seems
> > to have an enormous blast radius :-)
>
> We can't. We really can't. Passing misaligned device trees results in,
> and has already resulted in for years:
> - Silent Linux crashes
> - When Linux doesn't crash so many of the read functions go wrong the
>   result is incomprehensible.
>
> It's something that has and continues to waste untold engineering time.
> The only reason it's not worse is that we've killed off *most* of the
> platforms that disabled device tree relocation and that's how
> misalignment happens downstream most often.

That's fine, but making the devicetree aligned for Linux is pretty
simple. We generally relocate it before booting anyway.

But that's not what I'm seeing here. It seems to be updating U-Boot to
deal with a libfdt change. That is also a worthy goal, but we need to
consider code size and where best in the stack the changes should be
made. Doing a memalign() at the last minute is just not a good idea.

Regards,
Simon
