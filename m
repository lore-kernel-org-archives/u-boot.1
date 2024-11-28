Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703D4D70DEB
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:11:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 040198949D;
	Thu, 28 Nov 2024 20:11:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U6xs0Q7w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30BB189D0A; Thu, 28 Nov 2024 20:11:11 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7845F89D18
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:11:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa53a971480so147677166b.1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821067; x=1733425867; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fckHG/mVz0XolDT6msnNt4VmiXuPAw5FTkTJDbryiMU=;
 b=U6xs0Q7wvdkKzHEXE2Pv0TCrRbglgLXdGLduA5PmqzLrX5r6qxnu8sBdrl+co3xpsh
 0uuTR4iD8QVg47Zct80qNPP2K/r8/wVG281sQFFqZGmqlD0Z7xCYiuMeemOeZeZV79f1
 TqX0c0POQt2RypKrDOxtoz8wiVhnb3s4YFxHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821067; x=1733425867;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fckHG/mVz0XolDT6msnNt4VmiXuPAw5FTkTJDbryiMU=;
 b=sdwQHgNnZuPFm6mhenHEg12rmoN8exseslQEpA1zppxcAmeIEsZ/8kxRG3gSSYEO4P
 7h73Mnw9Bz8q5G3CYB7qntf1SUIMmLAvIIs20dTxaWZA+TnYMmO54vhdJph8PeXW3Xhz
 S6ulVSBkk3Vy1YsNrX6di2e1JxGXfRbsgCibXvoy5TR0Xq3dCthFmhnBgnqFmupAoARW
 Uak+WUc9DKBUOMfBSIt5CB64iyd1rw00tPd2QrzTugE4ECiOaIFfD2CQBEGFnB1Dyo2E
 eZ5b/ZzCaaxt/8lUBcaPRGZETsOIFCGLZB3UUAsqEcwxAoxckS5n3QgAc4v3inpx/tEW
 C70Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBqfxPRsBXfvUtpDvABbOCnMGCkLYsWZNIFm+Tfe9lbJqitWGzohhpO/VJTquRepFgC+LkX/Q=@lists.denx.de
X-Gm-Message-State: AOJu0YycPzDKxyn2EPmghLNIKmTskIwd69Os1qlc6Ot5pBqv6dfLyGDI
 i9XvBM4PjzWcy2Vl9wgr3IsnaRDdYFVgZkP5Q1vhcxfBdVCigpR2dgTy9GmP8/6nURc+5U4aoJQ
 D6WVJhuQP6rDqJRtU+LjnsMcx4kjcBjt0XRJl
X-Gm-Gg: ASbGncvSHZLfnjg0Wj1Tjqu9JRamG524yZ0bwIr4cgLH6ZDtNL4E/NV7o6rsh12cLu6
 4ko2+SjExNKO76UyLRY6xKLqUwpevPO0=
X-Google-Smtp-Source: AGHT+IG2ZsqhPbsb3cb0D0WhRcGt2Yf1YSrT8TK7Jms2QwtQzaNq8B3De8MF3hnEXJRvb6dmSR8ERZ/52Oh5Xs47IxQ=
X-Received: by 2002:a17:906:3143:b0:a9a:6d7:9c4 with SMTP id
 a640c23a62f3a-aa580ef31b5mr621336366b.12.1732821066998; Thu, 28 Nov 2024
 11:11:06 -0800 (PST)
MIME-Version: 1.0
References: <20241128154727.771871-1-sjg@chromium.org>
 <20241128154727.771871-4-sjg@chromium.org>
 <f97773e8-e734-45b4-a5ac-074856dc6acf@gmx.de>
In-Reply-To: <f97773e8-e734-45b4-a5ac-074856dc6acf@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Nov 2024 12:10:51 -0700
Message-ID: <CAFLszTgxqEVZ-ooLqvPkm44GyzCfTtOWjmoLQZrLpq1tyqMuUw@mail.gmail.com>
Subject: Re: [PATCH v2 03/28] efi_loader: Drop extra brackets in
 efi_mem_carve_out()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Thu, 28 Nov 2024 at 09:55, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 28.11.24 16:47, Simon Glass wrote:
> > Simplify a few expressions in this function.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   lib/efi_loader/efi_memory.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index f1154f73e05..3b1c7528e92 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -206,11 +206,11 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
> >                            (carve_desc->num_pages << EFI_PAGE_SHIFT);
> >
> >       /* check whether we're overlapping */
> > -     if ((carve_end <= map_start) || (carve_start >= map_end))
> > +     if (carve_end <= map_start || carve_start >= map_end)
>
> As operator precedence is not always easy to remember, some people like
> Alex and some static code analysis tools prefer parentheses.

It seems silly to have brackets in this case. It just makes the code
harder to read and checkpatch doesn't like it.

>
> >               return EFI_CARVE_NO_OVERLAP;
> >
> >       /* We're overlapping with non-RAM, warn the caller if desired */
> > -     if (overlap_conventional && (map_desc->type != EFI_CONVENTIONAL_MEMORY))
> > +     if (overlap_conventional && map_desc->type != EFI_CONVENTIONAL_MEMORY)
>
> ditto

ditto

>
> We should get rid of this code as it duplicates what we already have in
> LMB and generate the UEFI memory map from from LMB.

OK, please send a patch.

>
> >               return EFI_CARVE_OVERLAPS_NONRAM;
> >
> >       /* Sanitize carve_start and carve_end to lie within our bounds */
>

Regards,
Simon
