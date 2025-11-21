Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824A1CFC28C
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 16:20:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D516083966;
	Fri, 21 Nov 2025 17:20:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iMqsznBW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 221938394E; Fri, 21 Nov 2025 17:20:53 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D7488394E
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 17:20:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b73875aa527so352360266b.3
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 08:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763742050; x=1764346850; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hox807oRO3CfQKEhyfgbA0h17mGSqHIdnUfpRwSU0as=;
 b=iMqsznBW6jvI7LbnIVd1PCKsbpcy65RmoLsYtDfVghbnLN9znFAOA4NHxK+0wtPy89
 7xL7bYmIZ/xFP8d7E7WWHbEi0aP9GQg6CNaYg2VozDs6sipIRz2UPLBnJLEgKxDmIWQW
 8P3mC5JwxTls8Jva0ryZTyPX73uuY9HO3mMIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763742050; x=1764346850;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hox807oRO3CfQKEhyfgbA0h17mGSqHIdnUfpRwSU0as=;
 b=Wb9N2l2usC0nYCJdtP3rXaOnzOO5YvIcuG+vPYh3ZpnXtOccCB+i2WgR4H6YqvrZpa
 TgGmngSAmz8MY5tG7c4KD2KqysZ21ewp4FwD5HO19hArguTLfE5lmD3U/puJgyM+5x9z
 u8onXE942oexEczvmx+AqVaMFiRI3TRURp7YZUPSHrAlNFXHEXvmVZgy6hNnO2efMuID
 Am5xvNgknOn93RjKcSF/CjNYY/JzxvKPWyzl315SgGbtR3KoHPhjn6/RU1QQ2nIpe55D
 I9SfkhVGMWNa4t8zkfPUhoo5RhClRGcEXdhTy7AHdSAsSXB7vGu+NU4BOnHUQhPMUe9s
 oYBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEs5lx45NhYF2jAt2wRU0ZBxviRLf25aYpiREhWhpPmyYnBxCkedBSWtDDzvqO+M4lVIfLSJQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwHzR4mlEa1YkvoyJA1Dc7wY4xKgZ4cbIdolG0JMaLAwRyIfgcY
 n/bPdCYtiysPd7iLvl52muJ1O+sHn30Swetha9hoEc8ZQtZWqSbFGinzRPis8W6FXaIQAQDRZBl
 AdAz85XZrxsW9+HTokNYi6Au9b4y6wCAZi5Bb4UVr2wfDCm4zj2w=
X-Gm-Gg: ASbGncsfWZH/maf7MOYfntWExxUtEb9CQfU9rrXgTKieO/n/GtNX3ZwQVA35z95dupV
 zkQvobJAU8z4uqyOdlD8bJbNOR2umZNaAwWoL52ja4rhg8vU8RQ10pY5nBeJjdeRsEmYIBMELuI
 ULQz0WyYRcny45LB41S0dbVPlMuq9UkHByyjWaE6C/DPTFULUywRA1hhy290/ZM690LxtF+otOL
 XxY1yX8WHbpOg94lD3tZrP9U7XsmaWVhieJRECsF3eLTfqE/VMDAYJbjJjYYzVpniFvhgJbl5Zc
 KlAj
X-Google-Smtp-Source: AGHT+IEdi8JRbUnFQc0n98IoFzy8kVN1ITUzr9kmTpI9mOBZ5XuvRPSzQ87L5ZKDc0stmkHwLvWeA/P7uuX40pTa3zA=
X-Received: by 2002:a17:907:7248:b0:b76:23b0:7d6f with SMTP id
 a640c23a62f3a-b76718cef3amr308404466b.56.1763742050417; Fri, 21 Nov 2025
 08:20:50 -0800 (PST)
MIME-Version: 1.0
References: <20251120041526.817288-1-marek.vasut+renesas@mailbox.org>
 <6a902e2d-b1be-1ba1-5d8b-e0a07ea2aebe@nabladev.com>
 <12ddeda7-f0a6-4cc8-8728-ba979cf6cc49@mailbox.org>
 <CAFLszTghtOKZWaVZH+hYdWvwUWZUTVPZ_mqkW3MCHRH6wRN0iw@mail.gmail.com>
 <b7063159-f5d0-4f8d-be35-2e7fa5f8f750@mailbox.org>
 <CAFLszTjyXo9yh6Jzdaev9GhN8OZ4Z5xz9phgNHnKCvA0ASzbaA@mail.gmail.com>
 <60b12c96-4e63-4cf1-8c27-25eabead529c@mailbox.org>
In-Reply-To: <60b12c96-4e63-4cf1-8c27-25eabead529c@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Nov 2025 09:20:37 -0700
X-Gm-Features: AWmQ_bn-GHjo4PIwvpbgsa-2jKtcTFuWvZZcdp2HAXUsZsnvj9FCh83O8d060Nw
Message-ID: <CAFLszThg+6LdxHXOYy9x8-nat+bsspbUT8Dg_vqnmx62aO0a2g@mail.gmail.com>
Subject: Re: [PATCH] i2c: sandbox: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Fri, 21 Nov 2025 at 07:52, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 11/21/25 3:26 PM, Simon Glass wrote:
> > Hi Marek,
> >
> > On Thu, 20 Nov 2025 at 21:39, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >>
> >> On 11/21/25 12:40 AM, Simon Glass wrote:
> >>> Hi Marek,
> >>>
> >>> On Thu, 20 Nov 2025 at 04:56, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >>>>
> >>>> On 11/20/25 10:08 AM, Heiko Schocher wrote:
> >>>>
> >>>> Hello Heiko,
> >>>>
> >>>>>> diff --git a/drivers/i2c/i2c-uclass.c b/drivers/i2c/i2c-uclass.c
> >>>>>> index 380a9f8f3ad..d0e9dad7202 100644
> >>>>>> --- a/drivers/i2c/i2c-uclass.c
> >>>>>> +++ b/drivers/i2c/i2c-uclass.c
> >>>>>> @@ -749,8 +749,11 @@ static int i2c_post_probe(struct udevice *dev)
> >>>>>>     #if CONFIG_IS_ENABLED(OF_REAL)
> >>>>>>         struct dm_i2c_bus *i2c = dev_get_uclass_priv(dev);
> >>>>>> -    i2c->speed_hz = dev_read_u32_default(dev, "clock-frequency",
> >>>>>> -                         I2C_SPEED_STANDARD_RATE);
> >>>>>> +    if (!dev_has_ofnode(dev))
> >>>>>> +        i2c->speed_hz = I2C_SPEED_STANDARD_RATE;
> >>>>>> +    else
> >>>>>> +        i2c->speed_hz = dev_read_u32_default(dev, "clock-frequency",
> >>>>>> +                             I2C_SPEED_STANDARD_RATE);
> >>>>>>         return dm_i2c_set_bus_speed(dev, i2c->speed_hz);
> >>>>>>     #else
> >>>>>>
> >>>>>
> >>>>> This sounds more as a bug of dev_read_u32_default() to me and should
> >>>>> be fixed there, else we need to make this check around each call of
> >>>>> dev_read_u32_default() ...
> >>>>>
> >>>>> And looking into u-boot:/drivers/core/read.c there are more
> >>>>> candidates for such a fix (all with "default" in function name?)
> >>>>>
> >>>>> and such a fix would also make the dev_has_ofnode(dev) check in
> >>>>> i2c_child_post_bind() obsolete.
> >>>>>
> >>>>> Or may we fix the default functions in drivers/core/ofnode.c ?
> >>>> No, this was the previous implementation which is now superseded by this
> >>>> one, see [1] [2]. The goal is to fix the entry points which pass invalid
> >>>> content further into U-Boot DT handling code, so the DT validation
> >>>> happens only one, on DT input, and not again later.
> >>>
> >>> Do the libfdt functions work correctly with *any* negative numbers?
> >>
> >> Not without a full tree check (LIBFDT_ASSUME_MASK=0x00). With
> >> LIBFDT_ASSUME_MASK=0xff (what SPL uses, tree checks disabled), passing
> >> negative offset to libfdt functions would simply trigger a segfault for
> >> sandbox SPL tests.
> >>
> >>> Do
> >>> you have a pointer to the libfdt commit which changed this? All of
> >>> driver model relies on that behaviour in libfdt:
> >> With libfdt 1.7.2 , this code triggers segfault in sandbox SPL tests:
> >>
> >> 162 uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset)
> >> 163 {
> >> 164         const fdt32_t *tagp, *lenp;
> >> 165         uint32_t tag, len, sum;
> >> 166         int offset = startoffset;
> >> 167         const char *p;
> >> 168
> >> 169         *nextoffset = -FDT_ERR_TRUNCATED;
> >> 170         tagp = fdt_offset_ptr(fdt, offset, FDT_TAGSIZE);
> >> 171         if (!can_assume(VALID_DTB) && !tagp)
> >> 172                 return FDT_END; /* premature end */
> >> 173         tag = fdt32_to_cpu(*tagp);
> >>
> >> The fdt_offset_ptr() returns NULL and fdt32_to_cpu(*tagp) would
> >> dereference that NULL pointer.
> >
> > Ah, I see. So the library hasn't changed, it's just the 'assume'
> > logic. That makes sense.
> >
> > I see a few options:
> > - enable the checks for the affected board (code-size impact)
>
> Every system that enables OF_PLATDATA is affected ?
>
> > - create a new VALID_OFFSET assumption (split out from VALID_DTB)
> > which checks offsets in fdt_next_tag()
> >
> > The latter might be best. It would likely be very cheap in terms of
> > code size. In fact, I should have thought of this at the time.
> Wouldn't it be better to not misuse libfdt ?

It actually isn't a misuse. It is perfectly OK to pass an invalid
offset and libfdt has defined behaviour in that case, absent any
'assumptions' we force.

Remember, in Linux these checks are enabled. We added the 'assume'
thing to reduce code size. Here you have found a situation where it
breaks stuff, so we should back off the assumption a bit.

Regards,
Simon
