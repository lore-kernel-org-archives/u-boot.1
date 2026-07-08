Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB09C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6BE084AC0;
	Wed,  8 Jul 2026 19:36:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mechasystems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mechasystems.com header.i=@mechasystems.com header.b="IIyJMKm1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79546849F0; Wed,  8 Jul 2026 15:45:53 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EB5B849BA
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 15:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=mechasystems.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=advaitd@mechasystems.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-847a69ba83dso594586b3a.2
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 06:45:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783518349; cv=none;
 d=google.com; s=arc-20260327;
 b=XKCS13td8bfGzFmJuPlLWQqyJkXrkN2XBrW9H1BoTuRtXoChaLT2re2GUaOrUQ25ZU
 oP8sPLnTIfr5aRJJH2VCAaeLAGJkDFIliQk2zrItQu0KsJhA7wMqWw0QPXuUT68X9OWj
 NlhYfVk1ZuW7vzbHjcFumhO3znxpRupRcahu+gntpSl++xTawBqno08asVNn0ICFgnpq
 uxe04GiDDpdZkWl/gwGR2ylPUqgYM5NjnyKpd4gXFMzuyGb+x518uvo7fMNv1t+QQt5v
 3yTWYSvd+6OZfzR5/34CUq2XsrPfnelFYyVi8JgMVjixHcibGn4gnlW5brT8VUbUbIDh
 pWrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NDbgLXZJwZdHhCjaS2rPGcG3CqDKQSBsO6H5IGM7IXg=;
 fh=KEkhknkdNbyoW26fplXFgN8sA5BthZq3KpGIIy9YmVk=;
 b=lPfHjXqS33lHCDWkdFp6yJk3l65426Cn+ZyOpO5EnLuARTCrZ4aisiSM0qdWJ/U/WW
 ine6Gg2rk9wUKOPuusqvWrmbx8U8YCUsLwGCLU/w3gvv9OON9aT1H7zwQ8XWCsW3Dz9h
 9NKeH1t3ZiF3w09BajS5N+lSz8nDl/v0EJ3eaCgWNHEC51J2gZy7uSMRwgHk0x+M5A6P
 EtXCAKJHkQNqWqbBujFbz50eL/7GtOLtgmS/CxVQClng6HFC1DRg2RIvl6H5VmiofgfF
 nDVCstjwSwU2jZ/qwhPSs87THa1CJJ01ypBd9E+GHMsCpCpHVZ7eIvLpJXp6PBual3jk
 ykBg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mechasystems.com; s=google; t=1783518349; x=1784123149; darn=lists.denx.de; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NDbgLXZJwZdHhCjaS2rPGcG3CqDKQSBsO6H5IGM7IXg=;
 b=IIyJMKm1Pgqchh8264LduJJs3JpCZuD7p7gw25zL1qyNSW5rRfYIjEFO9uOBcZK55I
 nrNlevvz3dnP/TncaXh3oVi+yh1AY17ElAUl+gjRq8OcedZgHITVP5m0HembdGqiI4xv
 D4aqgK3MD7QO4o9kF98FM366nIxXc026wO+OQDVkgUXWtrEBV1pGaKs3s1qXCeAtvR+h
 2TJYeSpNbZwvcFJSeN/1d+r53HZaybCz3olGSHDq5AjMA9IEHETYTHywjCHmS/0Knb1E
 +GZ0LdrDJT2TcA+Kxp8b9lTOzjXCpezl0UZjqrmY7X/uA2juLfEW35sAgVltBfO51nSZ
 p3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783518349; x=1784123149;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NDbgLXZJwZdHhCjaS2rPGcG3CqDKQSBsO6H5IGM7IXg=;
 b=rtG8Q2pU+WRoB//mf5JqJsqkoPHVd0W6s53/Stag6NKZUqpjoyadRQEmglYsGRycDE
 7rZmZWGEr4U+KEOnLufxgnATfJs5fVEr+fj9wXcslIwT+p4a3VRQBrmeFXpWoGtOtKJp
 r1pWX8VBbt+d83YeAGVErm0SCusAoqtM2XbgVYGjr3x+ERUG9S0Ys+VEyAEqezZyjr+k
 rrxI3YKHW/WrYabte9LdKddT7uhHN2FwD4PYL891exJs5dA7peKmBUPPhKNUyWJF5Ldb
 2f5uqp9DPMcTHZ9F8JrqGosdxH8sG6GgXcGaQtxTFkhFzTao2Ba8CCrecO0by3VAxBh0
 naKQ==
X-Gm-Message-State: AOJu0Yw1vGi04WQ7pTM6JWYpByRZs9feEjDyBzKJEz7p/+pbz+NcERbA
 N2peP8dWvEP81bvODNJNlnaufxH1rxLHvMFmygssTsxSIs3+Ap16HwlVXVn2Dw2xoOk/TuP4aWp
 nKfGWkzufuEeDPwtXGUw3SCL4myrOnQO4fntEA2tQUQ==
X-Gm-Gg: AfdE7ckuyq5A4Xw55PoZ6GC1dUPVmLFEiBGEymdc4xsQFryhr91rXFDGW5+zH4CJ3C6
 d9Hkm9OkRuq3tYh/Ix84B3rxpSHCnDDg7sFwpKLAnzrAqhQmh/SgmDgzf5KdGnJkpqGhJKoVWMS
 S/3K0jyd4ObdiQXmarnqLdB+iwga8gaUR4h/hzQHuCwz834gnXxb1AwvljHSIzGSIk1R1acakHD
 gLxJWxi6BCbAYY1BGsGj2KNt93EltymT1Ht44aKD5Mr7HXdx+GrcCBCL3PW90Du/JoC8pZjKJg2
 8TywMqzyY9Kup9Eaj9eir4EQ43KfAw==
X-Received: by 2002:a05:6a20:d499:b0:3c0:9c18:d5a6 with SMTP id
 adf61e73a8af0-3c0bd1b22ffmr3487153637.67.1783518349495; Wed, 08 Jul 2026
 06:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260702151325.290749-1-advaitd@mechasystems.com>
 <CAPVz0n1YGYKMWo6fVHF8gXZ8_6BjHCC4WUs-BBL5__+L8Bhi3w@mail.gmail.com>
In-Reply-To: <CAPVz0n1YGYKMWo6fVHF8gXZ8_6BjHCC4WUs-BBL5__+L8Bhi3w@mail.gmail.com>
From: Advait Dhamorikar <advaitd@mechasystems.com>
Date: Wed, 8 Jul 2026 19:15:37 +0530
X-Gm-Features: AVVi8CddcIunhQYhW5c4Z1lAaNXZMi5uTjB1vPyP8HgvmuWbftttVOAe0iF0qQ8
Message-ID: <CAAPs2HSH4qz292VEcxT-knTm-CrcVXmypceq2n1XLJX4qcQKxg@mail.gmail.com>
Subject: Re: [PATCH v2] video: add ChipWealth CH13726A AMOLED panel driver
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, ag.dev.uboot@gmail.com, 
 ion@agorria.com, dario.binacchi@amarulasolutions.com, 
 michael@amarulasolutions.com, xypron.glpk@gmx.de, ravi@prevas.dk, 
 sjg@chromium.org, patrice.chotard@foss.st.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 08 Jul 2026 19:36:37 +0200
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

> Hey there! Thanks for your contribution, it is pretty solid but there
> are a few places that can be improved.
Hi Svyatoslav, thanks for your inputs!

> > +config VIDEO_AMOLED_CHIPWEALTH_CH13726A
>
> May you please rename AMOLED > PANEL

Most of the drivers say `CONFIG_VIDEO_LCD_XXXX`
Since this driver is an AMOLED I thought of using that.
There also don't seem to be any existing setups named `CONFG_VIDEO_PANEL_XXX`.
Should I still rename it to VIDEO_PANEL_CHIPWEALTH_CH13726A?

> > +static int ch13726a_dcs_write_buf(struct udevice *dev, const void *data,
> > +                                 size_t len)
> > +{
> > +       struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
> > +       int ret;
> > +
> > +       ret = mipi_dsi_dcs_write_buffer(plat->device, data, len);
> > +       if (ret < 0)
> > +               log_err("failed to write dcs sequence: %d\n", ret);
> > +
> > +       return ret;
> > +}
> > +
> > +#define dcs_write_seq(dev, cmd, seq...)                                \
> > +({                                                             \
> > +       const u8 d[] = { cmd, seq };                    \
> > +                                                               \
> > +       ch13726a_dcs_write_buf(dev, d, ARRAY_SIZE(d));          \
> > +})
> > +

> You can fold this.

I'll fold this into one single #define altogether.

> > +struct ch13726a_panel_priv {
> > +       struct udevice *reg;
> > +       struct udevice *backlight;
> > +       struct gpio_desc reset;
> > +};
>
> You are lacking supplies here: vdd1v2, vddio, vdd and avdd
>
> U-Boot can handle them so you should include control over them.

My board has the input rails permanently powered, so the current
driver doesn't request any regulators
I'll add support for the vdd, vddio, vdd1v2, and avdd supplies. Should
these be treated as
optional (-ENOENT) and guarded with CONFIG_IS_ENABLED(DM_REGULATOR)?
I couldn't find other panel drivers that consistently follow one approach,
so I'd like to match the preferred U-Boot style.

Best regards,
Advait
