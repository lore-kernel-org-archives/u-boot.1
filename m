Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E174F34C62
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 15:40:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F284839D5;
	Mon, 13 Apr 2026 17:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HVP0Gz3t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C86C839DF; Mon, 13 Apr 2026 17:40:47 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB79836AC
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 17:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a8fba3f769so20384195ad.2
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 08:40:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776094843; cv=none;
 d=google.com; s=arc-20240605;
 b=NQ3fCdtSHF3vEzkwMfRfZu0pacxON73s2eedp9sgTKq3K8k6oMNHrDGN2gZy24OGSV
 AXiCBZlugT5AOcBg2EZQsC53oCAFIBdy7ubUEepM5H2yVYzfgY4aiF5DZ3rGiGmofYPt
 s9nDdL/lpY8LEYy03dTI+BwkPXvREiYOi3AAJ/iOLcTqxSAHw6IWMkaC8iXqQ/54Zig7
 nwk/aT3xBbw/oSvZIIyw3/pbgIALStyoD5OP0ykgoeUH7a4qVSF3Wklqlh+GSbBg2mAp
 AK6fZIKEd7qlfYhFqrRQdyrSlVJ9d7+c3R3b/sPZGGcfXDGodZ2OYrWqxjF29P+uyHAs
 HeCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FXhGz2w9Q39HYftHfmJ6BsbrFstmBBX1vkGDqiinlW4=;
 fh=x8CHnSGD4cRa4Gb5OxW3DEd7ozMoYZsI49tbFC7/xcM=;
 b=ccmwm1j3DJ1jv4CSDXKzoVuSEDFj+z9fbm6/A3LqTIw5P2NpMzf4wucbXaWK0uIctS
 0XWRAGMmq/ydGCllxuE7rg0D2U3RHp4TTYiX9rbOcfJ7wCV9svD19fRsnjZe3TnkvTy3
 gOtQRrR9+MnoMtK8NTaNF7CMYDsYxIavp2cecc+JkLI8zYNwKII2lB2403xNExJIH4iq
 JQCTKsdFDV/UwH7X94GJAzB6jm5GXsWnA4+ZhLacYCDroH2E9Z+JygflevnuRGn/BGKD
 Udb2s3taeRRvLAlhglTdDXhs5ekdkXLVsxM6pDHLfv7AVtVlxtadm1F3JureV/Y6q7zS
 Q0Kw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776094843; x=1776699643; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FXhGz2w9Q39HYftHfmJ6BsbrFstmBBX1vkGDqiinlW4=;
 b=HVP0Gz3td51V8SF32G+up0gQoBv93Lf7RKVtIUkB1Mo0Z2uEY5dGnrc24BmWLXaILA
 8TGbvoE6FK5SW7zjD4N4cic1xcVQoJBM9CD6EEr1GVW6nB2CEV0pzEI9OJN0OR5oe2uc
 0nvsqhXvqaYYaJY325seiB/FgCFC+Z9QPmeZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776094843; x=1776699643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FXhGz2w9Q39HYftHfmJ6BsbrFstmBBX1vkGDqiinlW4=;
 b=cWYTdE3+ELVxheIP5SN8YVnYqyc8UMF3S55yD8VPGlCIw7hHIOAbcB83YqBnwami7h
 ST5WQt4XRJKets8jzjCSn+sp3MqyBvj/Mk4TQzODAK9TM//fiCQYQmFDiqN8+UsjXNE5
 ORofBKrPd2xsFmSm98fI5LO3JoHOMvBeXDBO8PfRpq9Ata8KDbMpv7ueuweArHU9MppK
 BKA3SKiq+YUNUQuQKEqyXCGi+tcDxBMBTJZ2ri3nUQLAZj/AUJke4SR/4AZ2zt/x44uO
 j/b1IvipYvTPYY3sEahR0aaLMJbiemOX+1gKBNW9XkO5zRm7y3dd0cjipmGrb38Fc5T5
 TqXw==
X-Gm-Message-State: AOJu0YyEeDiREfP6bRMixHREwuMLOemSboNWzkCxYgK9kZibDA8vAPpE
 2krsluz5Q5vgDki73sO3cOqoqDrXjpjzms5FYjn0+Jnv25yqIAcEC1/gPoBtBuXriTK8CLqjscd
 aHI+Uk6rUs3YztreoH/AVNVuXLL9DYAzR4XYUFUwP5jLtpjvZcjQ=
X-Gm-Gg: AeBDiesHJkikDjSHnLgU06BnfueSUsEhdj1OHdhXGCpEjFgMGvowoku6n6xqVF9hB6N
 9fUbJ1su5HwLoLcusfpunpYnD+ZcRTFF+wj+Qr9dGIXAYXE/g3LTsBxS6xfGKh5CY7Ge+DXyqCC
 2u1JnGdkY8BkMasCQu6MCRNotgEFWDKHZQacC7K1necMVREGZ+SzsqBMWWLgtGgV5iFKET6VUTn
 rqIr0gRDzsybn3evJF44GXttvrC2Br93+9XAN6TgiHQ2SIzCKjriF+AFCpAfCDLfrWRdhTNQDI6
 4keEjw==
X-Received: by 2002:a17:903:1207:b0:2b2:5637:1480 with SMTP id
 d9443c01a7336-2b2d5a95dacmr139959885ad.40.1776094843029; Mon, 13 Apr 2026
 08:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260412111958.943933-1-sjg@chromium.org>
 <20260413152954.GW41863@bill-the-cat>
In-Reply-To: <20260413152954.GW41863@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Apr 2026 09:40:24 -0600
X-Gm-Features: AQROBzAoNH6qaXK9RnHmzmByVFHPDmMgXbXfhxUcUfq6e-U-eG-we96qWpQxa3Y
Message-ID: <CAFLszTjcKm4sexwAACnu_sJpcQrpgN_Bry8Nh_pxZTyNeDjAgA@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] test: Add support for passing arguments to C
 unit tests
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@denx.de>
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

On Mon, 13 Apr 2026 at 09:29, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Apr 12, 2026 at 05:19:37AM -0600, Simon Glass wrote:
>
> > Some tests have two parts: a Python test which handles setup, such as
> > creating filesystem images or configuring the environment, and a C
> > test which does the bulk of the work including assertions. At present
> > there is no way to pass information between these two parts, so
> > things like paths and device names must be hard-coded in the C test.
> >
> > This tends to make people write tests in Python, but this is not ideal
> > for several reasons:
> >
> > - Python lacks access to things like return codes and has to scan the
> >   console output to figure out what happened
> > - Python lacks access to internal state, so it cannot directly check
> >   the result of an operation
> > - Python is ~100x slower due to console interaction, etc.
> > - C tests can be stepped through in gdb, which is much harder with
> >   Python driving the console
> > - C tests can exercise internal APIs directly (e.g. fs_read(),
> >   fs_size()) rather than going through the command layer, so they
> >   test more precisely what they intend to
> >
> > This series adds infrastructure for passing typed, runtime arguments
> > from Python to C unit tests, using a name=value format on the ut
> > command line.
> >
> > The series includes:
> >
> > - Regex assertion helpers for matching variable output in tests
> >
> > - A private buffer in unit_test_state for test-local temporary data
> >
> > - Argument-type definitions (string, integer, boolean) with optional
> >   flags and default values
> >
> > - A new UNIT_TEST_ARGS() macro for declaring tests with typed
> >   arguments
> >
> > - Argument parsing in the test framework, accepting name=value format
> >
> > - Updates to the ut command to pass arguments through to tests
> >
> > - Type-checked accessor macros ut_str(), ut_int(), and ut_bool()
> >   with bounds validation
> >
> > - Tests for the argument feature covering type checking, optional
> >   arguments, and argument-parsing failures
> >
> > - Documentation for the test-parameter feature
> >
> > - C-based filesystem tests as an example of the hybrid approach,
> >   with Python wrappers that pass filesystem type, image path, and
> >   expected MD5 values to the C tests
> >
> > Note: This series depends on:
> >
> >    https://patchwork.ozlabs.org/project/uboot/list/?series=496972
> >
> > Changes in v2:
> > - Correct double signoff
>
> Reposting a series this large, on the weekend, the day after v1, because
> you made a trivial mistake is bad form. You should just acknowledge that
> in the cover letter and wait for feedback.

OK I'll do that if I make this mistake again.

> And since I'm seeing over 100 emails from you this weekend, this
> matters.

Yes, I was trying to catch up on various things.

Regards,
Simon
