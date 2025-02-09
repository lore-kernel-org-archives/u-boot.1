Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1A4C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 16:25:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 253A080A0A;
	Sun,  9 Feb 2025 17:25:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CMooG/C6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1583A80A2A; Sun,  9 Feb 2025 17:25:00 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB76B808E6
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 17:24:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5de3c29ebaeso3938197a12.3
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 08:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739118297; x=1739723097; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+wOFGhVqNpkzgcTQJxinNFcRIUcdM8ZwdKpuxDP2sVY=;
 b=CMooG/C6p1YsdB92OgVBFBo4s+ioBdr1S+A/CH2Y8Y0INli9SWbI8tqJpE4B9kUFNp
 M65JKLOZc11+Pgm8k7wRi/bA8yyq1rpbEnXCBhEI3TVplJCLJD9NJ1mm7MNLv6/4ZJg0
 sBP7/lqnSEQulpf1AW4AgiQTYuSfjsltFHOCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739118297; x=1739723097;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+wOFGhVqNpkzgcTQJxinNFcRIUcdM8ZwdKpuxDP2sVY=;
 b=hRH68LqbnW1PyRvATxE9XnKJBVmWhUIG2IAdnQfSNxMvkdq2o64aZs+iArG+u/vQfH
 SPlGB6WpoRymrpTLGMMqahMwNPLT/vYVd9mjLN/sKgORD63Alj1HGZlNhJ6Ld1r+Q3Ez
 6OAWKNDfbw9QqCQBiXoTR8Uiv6S5FNZlD5cLiEZy2HMnM3Wr+kVtDJFjgK38CE1vYhui
 A8NukOAc4bOsNPJuRhjlB0fAfIT6AzJsTLQogVNItMMuyPLU0IYR/PFOF8IMYLPcMu6a
 0i2aIpQSDPJMAd/4E+eeB7XOnqI2w2Ekd8P1KWoRTtxGYLXPIVF5c+lT1g+A4cjZxOMv
 acwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL8paWgS+0heLnKs16TRZVLBts5fgyUtvqsChWb5M7jAKHadfTXYj7xWW8fLq6mxI21fS/ULk=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+tRSs83+HXy2nCpXve4Vuzv+v+I7+se/l6SQ1wLSAhdWM/jBx
 PiRduqU9xZYmRuY02RKFhbY8gDmN8jsuChIofyoVTTEe5F54HhOtOpgWn2TtI8x6RP+11V5/bnF
 P9jlXNlF731sLrtvvbwqB/mx+I7UNgVgqYwMo
X-Gm-Gg: ASbGncvKRC8bFILjB13LfofuHWtSH7WMfh9pkDINGS93h3abxhID1zPjyAlQ9LV+xDI
 XRK5aRevGu4blFrpxByEWHzS1twEeCFVOHSqkdp7hVuEHyCkwXoGyk0wvOL8TT/5cu/ejvV2ECQ
 ==
X-Google-Smtp-Source: AGHT+IHl0jBHSMrl+rYgLMS7WWcsd0CR6j8R0PwEDzjpwf5sKtPltkin/sZ7PfG5no7tGJJ34d3HzqeeYxndGee+wz0=
X-Received: by 2002:a05:6402:13c8:b0:5d3:d4cf:fea0 with SMTP id
 4fb4d7f45d1cf-5de4507337dmr10108434a12.21.1739118297258; Sun, 09 Feb 2025
 08:24:57 -0800 (PST)
MIME-Version: 1.0
References: <20250209115217.85250-1-heinrich.schuchardt@canonical.com>
 <20250209115217.85250-2-heinrich.schuchardt@canonical.com>
 <CAFLszTirNaX-6KfMPJ1LNHe3iU_QzATy0s1dHnfKbUw22NCP-A@mail.gmail.com>
 <83c2dc33-83a3-45eb-96e7-8c3b7ae38b88@canonical.com>
 <CAFLszThBmOvnkGLZEv+rQkS1F+4gB=yJMQ-+UShDrUbGyGP36w@mail.gmail.com>
 <55245b3e-22b0-464e-8ec5-4e3a95b88de1@canonical.com>
In-Reply-To: <55245b3e-22b0-464e-8ec5-4e3a95b88de1@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 09:24:45 -0700
X-Gm-Features: AWEUYZnK7gVt5laiSwwZ0Kp0MQvxn__iRLUiv7rrZkBXG1OK0O8R8SAJOGHOds8
Message-ID: <CAFLszTiwMeT6RS1iOF=mHbWz2brY7NKoB2AJEULcr1EqGCq+MA@mail.gmail.com>
Subject: Re: [PATCH 1/2] boot: continue in fit_find_config_node()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, 
 "Franklin Cooper Jr ." <fcooper@ti.com>, u-boot@lists.denx.de
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

On Sun, 9 Feb 2025 at 09:10, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 09.02.25 17:02, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Sun, 9 Feb 2025 at 08:53, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 09.02.25 15:29, Simon Glass wrote:
> >>> Hi Heinrich,
> >>>
> >>> On Sun, 9 Feb 2025 at 04:52, Heinrich Schuchardt
> >>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>
> >>>> If a single configuration node lacks a description, this does not rule out
> >>>> that another node with a description matches. Anyway we have the default
> >>>> configuration as a fallback.
> >>>>
> >>>> So continue if a description is missing.
> >>>>
> >>>
> >>> That field is mandatory, so we should really fail if it is missing.
> >>>
> >>> What problem are you trying to solve here?
> >>
> >> Sure the field is needed to make a configuration selectable.
> >
> > It's actually normally informational. Have you looked a
>
> If the field is informational, we should not worry if it is missing.
>
> > CONFIG_FIT_BEST_MATCH? That is how this is supposed to be done. But
> > with starfive_visionfive2 I see:
> >
> > # CONFIG_FIT_BEST_MATCH is not set
>
> How would CONFIG_FIT_BEST_MATCH match strings in the EEPROM to a FIT
> configuration?

It uses the compatible strings from the running devicetree. If you
know that it is wrong, or too generic, you could enhance
fit_conf_find_compat() to take a compatible string-list instead of an
FDT blob, then add a SYSID for reading that from your board's sysinfo
driver.

How does it work at present?

>
> >
> >>
> >> But as long as we can find a good configuration we should boot instead
> >> of leaving the user with a bricked device.
> >
> > The more likely impact is that people won't bother adding the field on RISC-V.
>
> The current runtime check is inconsistent: You will get an error if the
> first config lacks a description but may not get an error if the last
> one lacks it. And you are potentially bricking bootable devices.
>
> The right place to check is mkimage. Here you can bail out if a string
> is missing without bricking devices.

OK, I can see that the current thing is inconsistent, so I don't mind.

Regards,
Simon
