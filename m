Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCDDCE7B13
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 14:25:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DB6F8410D;
	Fri, 14 Nov 2025 15:25:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dcDpQh5+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2C9584111; Fri, 14 Nov 2025 15:25:44 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B245E83F54
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 15:25:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-afcb7ae6ed0so310719666b.3
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763130342; x=1763735142; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZB9uYHa6o9GFIJ/G3FWmQ6cEH+zHfVaXqwczCxfTZVA=;
 b=dcDpQh5+gGwMVTIBjtkDHaxB+uzEQa4dYnA3nkmYta9ehltdQ3+32qdAdkw625tWb0
 DdwbUmgKEinqgZEeCR2bYTUisrlpSjc3my1a4Sl+2yySlboDFuxQ94xskdd4Oun39qqV
 HL0xcQW6AhG14pdVBzdzMgogQR5JjMP9YuW/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763130342; x=1763735142;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZB9uYHa6o9GFIJ/G3FWmQ6cEH+zHfVaXqwczCxfTZVA=;
 b=SZQE5sDcHiKtEi7uk+TMoPorfjtPga/yOgr/igxsUVGwFIrxAI8AwFm1BThsoBSbF+
 vkAVgufyweNMLLeXzT4z2J0oQHzRctVkQegebLudJeFjxa1dNZmyijLCofjUt7dNm/dV
 jMe8Qn2ox8MsjEj/Icsn/zXv80l8WhSsSGEIsqGVtEBBybCoPzHse878PSRnckjqgoUB
 L/FH5O1LeJfZCoxZMU2N9aIALlVN+8GMyJtuX5ep+vejy+lGOj43ZxP693rdU2EfYm9n
 ssCC/Hj6dlVVIusVpYW1ZpWuGwe7yUdSPrLT3tD4uorVauzVMNRj1yTxnjNlaBLN1CGS
 nA0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCtOlheweLQjNzlru2uiD29RkuJ9+6TqAYdxCdpJNGy/b1xe9SL2eH+D5Q3qnOpBW+HdroXPk=@lists.denx.de
X-Gm-Message-State: AOJu0Yyb3NqBSLJAuSuDGc2ks7bmmaFlPJszvvU+BgBnZNoW486CFLvL
 tRUxngN9MeU7OUKPM3vgC1Eewh10moRhSy1c3q4+5mhf9sohcT0GB5wFplYbQqRtVHU67s9s6wN
 mR8/5+QU7PUqGvB4ILFwCRf6Ej0HUqjDpRfNqCSjNICxWF2O+caA=
X-Gm-Gg: ASbGncv1mY1KTLWjfQNEtdq/Q9A4D69vHdBqQgTFyyYEKL3FH8GireDUptc7WhY18ZU
 x15v8uAPwnZAchg+YVrPXMlo7blqJZZJsbu/vBzlqfr91nWk8o24NRcQgKoFFjj8mriapRSwotz
 OREWOCM4zEogvf4W0I/6ZhVKX9oYI6/8euAJP9VYyh5rN5rHq/m+pr8nmTt0NK4pbhiUruPAoNr
 olNPldvn/ku/sOFpz5JSUqg6F2lxrhKdvNIaCp3jM6tSo51daGqS4vlNih0xNV03Ru5bA==
X-Google-Smtp-Source: AGHT+IE2ll5jSXiMbbLqql4S50WQqEND2/il+20I1NFThwh/Z+LaJxpI+yq980mafPAkaTxbCsnhemNczVhxYpMJnpY=
X-Received: by 2002:a17:907:749:b0:b72:3765:eda9 with SMTP id
 a640c23a62f3a-b736796a3ffmr360201966b.60.1763130341977; Fri, 14 Nov 2025
 06:25:41 -0800 (PST)
MIME-Version: 1.0
References: <20251112011717.360045-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTjofjQ_zmwJrGZ-sLejQ=x=-8tyqr4SBPYgt3683GVAbQ@mail.gmail.com>
 <20251113193816.GP6688@bill-the-cat>
 <CAFLszTjwpoCwCKKvJX5cZMLK480EK-=BWaFd5A6yLMrfsVWC6g@mail.gmail.com>
 <20251113200527.GQ6688@bill-the-cat>
 <CAFLszTjydNqmo=6qLv--m4fB07QzWd01XHGY3hxgTEbarJF-VA@mail.gmail.com>
 <20251113203654.GR6688@bill-the-cat>
 <385cdc16-cf73-443b-a0a1-440e233d4506@mailbox.org>
 <CAFLszThc4YC6mKp5sNsiuCFfaMNqMWJjVV27d4UkyLU4rPWY6A@mail.gmail.com>
 <20251114142359.GX6688@bill-the-cat>
In-Reply-To: <20251114142359.GX6688@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Nov 2025 07:25:30 -0700
X-Gm-Features: AWmQ_bkbZMR50yivWD0SefvsfFl5EuGUMV9VDtszChyrkzatimFmBzb7UnjVEYI
Message-ID: <CAFLszTj3Pwzfp+g_rv=AkWVCsdXBuMaB=1OrkgJcGe2gov+D-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] boot: android: Always use 8-byte aligned DT with
 libfdt
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.denx.de, Aaron Kling <webgeek1234@gmail.com>, 
 Eddie Kovsky <ekovsky@redhat.com>, George Chan <gchan9527@gmail.com>, 
 Julien Masson <jmasson@baylibre.com>,
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

Hi,

On Fri, 14 Nov 2025 at 07:24, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Nov 14, 2025 at 05:45:32AM -0700, Simon Glass wrote:
> > Hi Marek,
> >
> > On Thu, 13 Nov 2025 at 14:57, Marek Vasut <marek.vasut@mailbox.org> wrote:
> > >
> > > On 11/13/25 9:36 PM, Tom Rini wrote:
> > >
> > > Hello everyone,
> > >
> > > >>> Which is different from disagreeing with your specific feedback about
> > > >>> how we get there, to be clear.
> > > >
> > > > And again, since your feedback to this patch was "Don't?", I'm saying we
> > > > need to. But the rest of your feedback was structural on moving towards
> > > > resolving it and so I assume Marek will respond.
> > >
> > > The "blast radius" are these patches, that's all that tripped the tests:
> > >
> > >   - boot: android: Always use 8-byte aligned DT with libfdt
> > >   - test/py: android: Point fdt command to aligned addresses
> > >   - test/py: Use aligned address for overlays in 'extension' test
> > >   - sandbox: Fix DT compiler address warnings in sandbox DTs
> > >   - sandbox: Fix DT compiler pin warnings in sandbox DTs
> > >   - boot: Assure FDT is always at 8-byte aligned address
> > >   - arm: qemu: Eliminate fdt_high and initrd_high misuse
> > >   - efi_loader: Assure fitImage from capsule is used from 8-byte aligned
> > > address
> > >   - MIPS: Assure end of U-Boot is at 8-byte aligned offset
> > >
> > > Regarding last minute alignment, the problem with this android image
> > > seems to be in the android image itself, which packs in badly aligned
> > > FDT. We therefore have to copy it out and realign.
> >
> > My request is to implement these checks as part of the boot flow
> > (bootm, etc.) rather than adding memory allocations in leaf function.
> > We already support copying the FDT to a different address so we can
> > expand it and add things. Can we make use of that code?
>
> There are likely some cases where we should do the check-and-move
> elsewhere, but others such as MIPS where we shouldn't get it wrong to
> start with. I believe we've had a few other patches that also fix the
> other cases where we don't ensure correct alignment to start with, and
> really must.

I'm going to leave this to you and Marek.

Regards,
Simon
