Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2536CFC282
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 14:26:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EEA68394E;
	Fri, 21 Nov 2025 15:26:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m6V22rAb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C19283952; Fri, 21 Nov 2025 15:26:17 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20A688382A
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 15:26:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b737c6c13e1so385399766b.3
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 06:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763735174; x=1764339974; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XbnG+rodyHHnerGIImKkZtfq+bMhJaXHasvBhghtnOc=;
 b=m6V22rAb+T0jG90m9zfPIRZrjpOF6Me8/Wph6+gAQZNGR/bB5y8bKRUL3WWUegQ2Yf
 XHhGq7ZsSkLGOM6/08Rls1jBtYRUWDhd1AIRJP6+2XAqKkHOUIXA/+5NMvCEQKHum+0a
 AlxAeKLY5B3u8YNMPrmZhg2dLIYj9UFcfSkWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763735174; x=1764339974;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XbnG+rodyHHnerGIImKkZtfq+bMhJaXHasvBhghtnOc=;
 b=HKI1HCXMxjt8SUYHHE1OYc5S4Kdzbg+CeoxMOziRSPaDZAHhuBXtbT26+IML1XVvrC
 BeBrc3pPrC0JFAIvtQIRw4CUWyk7z4zRon56FG6TKA0hr6p0R/w3rrzUupWpefke78vR
 KekZr2Jse1eP8eMA3emyqTjUFtP+29BPsrz/jaNvPif2BtPWUH6S9XL3698eFJF2pX9m
 4tAlPX30XtsEbT0s6WB+x5f+1SK433G9My3Dw7dsWm+Lf451/WdZN1wrSp2hi0jkqK3I
 7u5KEGqlnGIQsbAxMJaCaZRURAMJXEqcyC7wY1/LXKyxxR8dGQWblLNoPl03ITU+VoB4
 sicw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD1cdKCupHUyOdQWJ+79cMbTS7jTP5CA3vOsN3ZmhJuvQ8qoJb55od15S82XRu4JaT9z+pIPY=@lists.denx.de
X-Gm-Message-State: AOJu0YzvLR6SQg1b0vsJPQdXpLH3HhxTYedYH+E2QQd+p+F1f9EJC1P3
 o9HW9xhwzUift8/amJ2N5fdT8UQfixz8go55cqvqi7md4t6i6mJuC3eqrV5ovQu3zLqfDtZsxug
 BDSHcy/Y4Ub3AWhr5xVqBvrg69voGkEpBs++Ytr/+RP8Gk40LlyY=
X-Gm-Gg: ASbGncv0AOzlvK9wRgvxdTxdFxizq45J+GHOsTGTMDYRHqPqhuxUBYGUJyhdKIh8Zv4
 K6z0Oy4iO/8MOdV+lbIoGk4mab9iUtltAqFSvrCtFeKeOXKO2ITM1ttvHaNdCBQVptYkFgOA1ly
 Rd0smkStwBNWQciowBr7U6JXObGpJlZLGGNGy3sAkaipOcgi/jx1tlaje0l+QkaIK1aP0AhuzVI
 46ZbgmbDHdqgQ7FOUtNTJQAKUXDhmilVBN3dOk5/SYOHIyoys2taC2MqmjLPacok4j8ZQ==
X-Google-Smtp-Source: AGHT+IHffQ8zVmWqojr4RSTWxd+mzs7CaVAYIyQfXXiimd5ZNt8dy8t29kOSsR8bSsIAN1XZuw7FQMDMQMqS2l19xJc=
X-Received: by 2002:a17:907:3f14:b0:b76:5ef6:3b73 with SMTP id
 a640c23a62f3a-b76715723cemr228004266b.23.1763735174539; Fri, 21 Nov 2025
 06:26:14 -0800 (PST)
MIME-Version: 1.0
References: <20251120041526.817288-1-marek.vasut+renesas@mailbox.org>
 <6a902e2d-b1be-1ba1-5d8b-e0a07ea2aebe@nabladev.com>
 <12ddeda7-f0a6-4cc8-8728-ba979cf6cc49@mailbox.org>
 <CAFLszTghtOKZWaVZH+hYdWvwUWZUTVPZ_mqkW3MCHRH6wRN0iw@mail.gmail.com>
 <b7063159-f5d0-4f8d-be35-2e7fa5f8f750@mailbox.org>
In-Reply-To: <b7063159-f5d0-4f8d-be35-2e7fa5f8f750@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Nov 2025 07:26:01 -0700
X-Gm-Features: AWmQ_bl1OwNJ9vpsJvRNQl49Ck5L8GT9PgjFVYsUgUXzEWvR13EBuzyKLEe1Lrk
Message-ID: <CAFLszTjyXo9yh6Jzdaev9GhN8OZ4Z5xz9phgNHnKCvA0ASzbaA@mail.gmail.com>
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

On Thu, 20 Nov 2025 at 21:39, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 11/21/25 12:40 AM, Simon Glass wrote:
> > Hi Marek,
> >
> > On Thu, 20 Nov 2025 at 04:56, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >>
> >> On 11/20/25 10:08 AM, Heiko Schocher wrote:
> >>
> >> Hello Heiko,
> >>
> >>>> diff --git a/drivers/i2c/i2c-uclass.c b/drivers/i2c/i2c-uclass.c
> >>>> index 380a9f8f3ad..d0e9dad7202 100644
> >>>> --- a/drivers/i2c/i2c-uclass.c
> >>>> +++ b/drivers/i2c/i2c-uclass.c
> >>>> @@ -749,8 +749,11 @@ static int i2c_post_probe(struct udevice *dev)
> >>>>    #if CONFIG_IS_ENABLED(OF_REAL)
> >>>>        struct dm_i2c_bus *i2c = dev_get_uclass_priv(dev);
> >>>> -    i2c->speed_hz = dev_read_u32_default(dev, "clock-frequency",
> >>>> -                         I2C_SPEED_STANDARD_RATE);
> >>>> +    if (!dev_has_ofnode(dev))
> >>>> +        i2c->speed_hz = I2C_SPEED_STANDARD_RATE;
> >>>> +    else
> >>>> +        i2c->speed_hz = dev_read_u32_default(dev, "clock-frequency",
> >>>> +                             I2C_SPEED_STANDARD_RATE);
> >>>>        return dm_i2c_set_bus_speed(dev, i2c->speed_hz);
> >>>>    #else
> >>>>
> >>>
> >>> This sounds more as a bug of dev_read_u32_default() to me and should
> >>> be fixed there, else we need to make this check around each call of
> >>> dev_read_u32_default() ...
> >>>
> >>> And looking into u-boot:/drivers/core/read.c there are more
> >>> candidates for such a fix (all with "default" in function name?)
> >>>
> >>> and such a fix would also make the dev_has_ofnode(dev) check in
> >>> i2c_child_post_bind() obsolete.
> >>>
> >>> Or may we fix the default functions in drivers/core/ofnode.c ?
> >> No, this was the previous implementation which is now superseded by this
> >> one, see [1] [2]. The goal is to fix the entry points which pass invalid
> >> content further into U-Boot DT handling code, so the DT validation
> >> happens only one, on DT input, and not again later.
> >
> > Do the libfdt functions work correctly with *any* negative numbers?
>
> Not without a full tree check (LIBFDT_ASSUME_MASK=0x00). With
> LIBFDT_ASSUME_MASK=0xff (what SPL uses, tree checks disabled), passing
> negative offset to libfdt functions would simply trigger a segfault for
> sandbox SPL tests.
>
> > Do
> > you have a pointer to the libfdt commit which changed this? All of
> > driver model relies on that behaviour in libfdt:
> With libfdt 1.7.2 , this code triggers segfault in sandbox SPL tests:
>
> 162 uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset)
> 163 {
> 164         const fdt32_t *tagp, *lenp;
> 165         uint32_t tag, len, sum;
> 166         int offset = startoffset;
> 167         const char *p;
> 168
> 169         *nextoffset = -FDT_ERR_TRUNCATED;
> 170         tagp = fdt_offset_ptr(fdt, offset, FDT_TAGSIZE);
> 171         if (!can_assume(VALID_DTB) && !tagp)
> 172                 return FDT_END; /* premature end */
> 173         tag = fdt32_to_cpu(*tagp);
>
> The fdt_offset_ptr() returns NULL and fdt32_to_cpu(*tagp) would
> dereference that NULL pointer.

Ah, I see. So the library hasn't changed, it's just the 'assume'
logic. That makes sense.

I see a few options:
- enable the checks for the affected board (code-size impact)
- create a new VALID_OFFSET assumption (split out from VALID_DTB)
which checks offsets in fdt_next_tag()

The latter might be best. It would likely be very cheap in terms of
code size. In fact, I should have thought of this at the time.

Regards,
Simon
