Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1B4E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 15:10:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 304B78021D;
	Thu, 19 Dec 2024 16:10:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jISdTHTM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DCED8021D; Thu, 19 Dec 2024 16:10:14 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FA0D8021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 16:10:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436341f575fso9872405e9.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 07:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734621011; x=1735225811; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fSS6JRHAidg6RCdCa3+bPQrd86kJ4x+00nSIanf0si4=;
 b=jISdTHTMC2DK1b0sjKy9vxmKAYFapJq9xqgcUXs6RrIAHHDsyNaAindciWjJrsjmC6
 OolNyq/ZxjhCyIVgbgQja1ivMBJ5fVKmLZH6AzmHVbbI2DLEPrjqK7rRe8j2LNhM4FjF
 EqfY0RACSGE6kgNvjG+Mmin5UfokvrHwZa2SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734621011; x=1735225811;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fSS6JRHAidg6RCdCa3+bPQrd86kJ4x+00nSIanf0si4=;
 b=e+rZwdXTnEXR++2pFedUfsH3FI78aROf3TRDCjPtKg4qRJXd2FflUMlvQ0qE3FO04o
 726T1iyjmoVBRfBSDsb+Z+rypv6WxYI9Fk3+0zljiWRCJn46XZh5qeKlML90Lm+/VKgC
 ixBhswo7k47iXnGvaBgpHceSxetzbsm7iXgU10WQAPZL3l4PMpxniaTYQMIpWLN3x2nO
 XTY/gStS0bPOCkCBeJk2c+YUHvv+LV5cMPt4YxnBPy8keZoGmASVA9bqlYqnQM6iHC+/
 1UjV7QaY8ZlP0EiJY3EiyS1yEKxpEn2dHqpwBqw/CWckJyf2gPtLbAJZKv+tfC09159p
 IHXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFmBWfY4Rbgf6SRT4SAGgKdUy+dFDG3O/BCq1KuUuAZl0R/giGUra0PaPDK7D/U0LCjLMDIUc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4YHYocE+H4ksoy4buIAnw4YTm2G8ja6KxQGSMkJHtt9MF7fDW
 PoO9t4YIVX18LC1PrhZqQfxEP8T6ACPajQ2OJHEf32abqxXUnVfyBiVW8zaCg7VobPL8uhd04jo
 aR3h9R0eg3/lPccUcO458tPSpMKwZ9GpJlWuI
X-Gm-Gg: ASbGncsY/CvTqileLQY3w6RYcj3LL/AaCtmhX3mH7vyK21096uGYvTT5MQ2Nd8Lw06C
 dTqVQiFkaFg7qXTDnbpE+tQRBFD9UH9/38M3HpDI=
X-Google-Smtp-Source: AGHT+IGadAhrj/5pXez246iEwwfbaxjeecUI9muy0Mt9YQxPL4pRCJ0Y/aQmm0PEBUEm4qd+wGkU47PjP69AYRYA5LM=
X-Received: by 2002:a5d:648c:0:b0:385:e4a7:df09 with SMTP id
 ffacd0b85a97d-38a19b34d45mr4329801f8f.44.1734621011541; Thu, 19 Dec 2024
 07:10:11 -0800 (PST)
MIME-Version: 1.0
References: <20241219043918.1646095-1-venkatesh.abbarapu@amd.com>
 <20241219135339.GR1505244@bill-the-cat>
In-Reply-To: <20241219135339.GR1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Dec 2024 08:09:59 -0700
Message-ID: <CAFLszTi4Dr6ZYMZYdQhTcxZ7=+ok6SHWmKLbZq394ih1OYhWnA@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] cmd: Add support for optee commands.
To: Tom Rini <trini@konsulko.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de,
 michal.simek@amd.com, 
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, 
 jerome.forissier@linaro.org, mkorpershoek@baylibre.com, 
 akashi.tkhro@gmail.com, francis.laniel@amarulasolutions.com, 
 ddrokosov@salutedevices.com, git@amd.com
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

On Thu, 19 Dec 2024 at 06:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Dec 19, 2024 at 10:09:16AM +0530, Venkatesh Yadav Abbarapu wrote:
>
> > Add the basic 'hello world ta' command which increments the value passed.
> > This provides easy test for establishing a session with OP-TEE TA and verify.
> >
> > It includes following subcommands:
> > optee hello
> > optee hello <value>; value to increment via OP-TEE HELLO WORLD TA.
>
> Neat. Since we have the ability to do something like qemu+TF-A+OP-TEE in
> CI, we should have a test written for this now, so it can be run when
> someone has the time to add it to CI. And we also run on real HW that
> uses TF-A + OP-TEE, so we can run the test on those platforms now (or,
> as soon as I update OP-TEE if needed). Thanks!

Nice. Specifically, in the sjg lab, play and rockpro64 have TEE
included in the build.

Regards,
Simon
