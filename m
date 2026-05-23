Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D509ACD5BB0
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 00:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D5AD848EE;
	Sat, 23 May 2026 02:08:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IuOvxSRk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6478C8490A; Sat, 23 May 2026 02:08:41 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D048848D2
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 02:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bd85ebb368fso1161499666b.1
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 17:08:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779494918; cv=none;
 d=google.com; s=arc-20240605;
 b=htimqrSxgPohkGIQhvaGUbvpPt4dByhJgydpWpEAiaGjPim9UYnjbBgxdDfZjHvseT
 3ktUGuWrffl1HEQ835eUFQKz8hDBJWfCUYRXPKEtflIr5SAmkr4jxPJFxOtpMntbGU2E
 CEo+WCa3Ld5DGVAvMwElLi1O83I5p4U2TI9YnqOFldx1yp+OH7Tnfz0d1c1stZfZaDc+
 gIMvlUc3/aoITQqgoEISxXzua19Jy3J8aoqr0xxJL7A7AdzRsgytUGDD+bNfwlUrL+sC
 NBMqZIlgjZDV6pKY/1+qdtDOJd7HJJEw1IfkpvFHdlOYLYRXyaV98QKJJIQBeVKAkVPs
 uB9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Yqyz/waCKIiHBOPSYQfxHOBOIioHQDRYFIp49+5u2ag=;
 fh=5x0gVdprp6hStv+jkzyxKk8UURzxqUSavfUNEiJLv4g=;
 b=QoUZ2KHRI4AMI37Oq9kTk6+RxADFoCVUV0T7mFFTIjHdBcnZnRBzBFM+BmQbcBX5Lg
 RBJlL8WA3xm1NERZHmr22dRQ08z7DKh6XP1gdUdFfUHYPYsZR1QJ2s90GRKJuYaGhyOj
 9arvO7ctTegwVQsbqliGA94qHi57GjIJqhoNOXZ16RsL6f+nVYRHD9iejyi8k6koMdzj
 n52Iy3JrgYo+db4xLFhNMz13+XlI1cR6V34ZFas/Cubo1Efcq3sMo6C4Vaw9gV6+NSQ/
 O/XCPXHgQiCrmP7Oet6IKe9uKQxmMyy61AGLwDZKOOYso0Qf+n7a/zCJ0JOEHY+Uu6/q
 aCvQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779494918; x=1780099718; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yqyz/waCKIiHBOPSYQfxHOBOIioHQDRYFIp49+5u2ag=;
 b=IuOvxSRk5f9A4rbohBGnyh41oMGk5DUk5QAARZuPV3XVPv2Tde6WbdrhjoWv3sZ3Kb
 WMcj4gtQp0OZM73x70mcR1XklyoYFy0NQ3trErOpv83pETKGAWk1vSpLNixC2G7sRcXk
 TaqGrZZSQuR2gtZOfLiILAnSJ2qKfPWffc7Z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779494918; x=1780099718;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yqyz/waCKIiHBOPSYQfxHOBOIioHQDRYFIp49+5u2ag=;
 b=nqg/YIt6lglwQNQXl2ty9mYmV/Bb2jK+/eW24rZr9vsDVUxvJ0Jir5OOGhIk6Fw+px
 RKDXAI/fWY8X05N16AM/jkTWr86n2BQVm9Hw91/hqtvUP5iNffqWzcGoVc2lPeJa+or7
 Lltn8dXNXAfWqiXJ3W4zL0X8sSM+tHosHSDjBPLVw6y99e43qcLPuhuGjcdS70zP3kFU
 J/S6b8dRFCwFiaDOu7Hr/HdF6tw/Z+9whVihfm4rVEcTGad2PFMYLuH+NI4fFvtFslLc
 8Wk/9TeLtdf9ZuKMMj1ahQkdWGV3FaRrZAUWw/XpAHo+kXxZcZfOxImVR2zr4xP6JDB5
 lyXw==
X-Gm-Message-State: AOJu0YxHW0O90WTX1/4OhFGEmjVjs36+/2aMea6iTAG+kkV4+YsaBSn5
 Og7hohQ3+d2RxioQbvgdziHV1QDAsng6T4Zx6Me7+Rp13kS4YE0KdZDeH+4irLkZlKQtXcwzWQL
 nIrrhIq7L6SDbiX5ofF6eP+TCDYBEiIEUFGgQWySa
X-Gm-Gg: Acq92OFBemLXU6Xm7w50VJmg8ueScFjiuwdayo2p+CdRV3j5HhBcxG2IRkL6L0m044E
 l47SNJpFJudRffHOm3R1Jo4zVNFIxuN/ao8WgEnaxR+l0Lg+TZ+Fk4diBGLnjT1yRyXaMA6WnVz
 By5+78mz8TVaXYe2HrhUF7NBARVcZsrJKE++lTL4SK4o9q6o5Mcyh+LRBwF3ugHmXmUjn5di97s
 /G6xtOI2Goy1RVT32dkQnMCJLRfvO+toyFq/pBTvBmE/9pzUBR/0Xw0ZdpiZqFXmtesfV5EFmH+
 wknAWTQFE7vrIYIw
X-Received: by 2002:a17:907:1dec:b0:bdc:fafe:bf66 with SMTP id
 a640c23a62f3a-bdd263c9230mr290695366b.33.1779494918385; Fri, 22 May 2026
 17:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260520201218.3752042-1-sjg@chromium.org>
 <20260522170328.GU1858239@bill-the-cat>
In-Reply-To: <20260522170328.GU1858239@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 May 2026 18:08:25 -0600
X-Gm-Features: AVHnY4KmnHdqqDs1EGv_fAXUQ6iYEZtESuKaf5buX7qRq-G2161ojcK5YJuZMgk
Message-ID: <CAFLszTiWxGPwP3AXmFE=J0fF41+9_N6hCc_fqc=Z-u1oYUe4sA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Convert env export and import to use getopt()
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Sean Anderson <seanga2@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Fri, 22 May 2026 at 11:03, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, May 20, 2026 at 02:12:12PM -0600, Simon Glass wrote:
>
> > U-Boot has had a getopt() implementation for over five years but it is
> > not used much; most commands hand-roll their own argv loops to spot
> > -x style flags. The env export and env import sub-commands have the
> > gnarliest of these parsers in nvedit.c
> >
> > Each one walks every -prefixed argv element by hand, opens an inner
> > loop to split grouped flags and tracks a counter to catch a repeated
> > format flag.
> >
> > This short series converts both sub-commands to getopt(). The mutex
> > check for the format flags is done after the option loop, since it is
> > a per-command rule rather than an option-parsing rule, and the trailing
> > positional list is read straight out of argv from gs.index onwards.
> >
> > There is no functional change. getopt() stops at the first non-option,
> > just as the hand-rolled loops did, so options still have to appear
> > before the positional arguments.
> >
> > Each command gains a 'select GETOPT' so the parser is linked in on
> > boards that do not already enable it.
> >
> > For firefly-rk3399:
> >
> >   03: cmd: nvedit: Use getopt() in env export
> >      aarch64: (for 1/1 boards) all -45.0 rodata +27.0 text -72.0
> >   04: cmd: nvedit: Use getopt() in env import
> >      aarch64: (for 1/1 boards) all -27.0 rodata -55.0 text +28.0
> >
> >
> > Simon Glass (2):
> >   cmd: nvedit: Use getopt() in env export
> >   cmd: nvedit: Use getopt() in env import
> >
> >  cmd/Kconfig  |   2 +
> >  cmd/nvedit.c | 186 +++++++++++++++++++++++----------------------------
> >  env/common.c |   2 +-
> >  3 files changed, 85 insertions(+), 105 deletions(-)
>
> For the record, here's a link to v2:
> https://lore.kernel.org/u-boot/20260519233207.2765755-1-sjg@chromium.org/
> And here's the full size change for firefly-rk3399:
> Summary of 3 commits for 1 boards (1 thread, 12 jobs per thread)
> 01: arm: Fix typo in linker script
>    aarch64:  w+   firefly-rk3399
> +(firefly-rk3399) Image 'simple-bin' is missing external blobs and is non-functional: atf-bl31
> +(firefly-rk3399)
> +(firefly-rk3399) /binman/simple-bin/fit/images/@atf-SEQ/atf-bl31 (atf-bl31):
> +(firefly-rk3399)    See the documentation for your board. You may need to build ARM Trusted
> +(firefly-rk3399)    Firmware and build with BL31=/path/to/bl31.bin
> +(firefly-rk3399) Image 'simple-bin' is missing optional external blobs but is still functional: tee-os
> +(firefly-rk3399) /binman/simple-bin/fit/images/@tee-SEQ/tee-os (tee-os):
> +(firefly-rk3399)    See the documentation for your board. You may need to build Open Portable
> +(firefly-rk3399)    Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin
> +(firefly-rk3399) Some images are invalid
> 02: cmd: nvedit: Use getopt() in env export
>    aarch64: (for 1/1 boards) all +883.0 rodata +199.0 text +684.0
>             firefly-rk3399 : all +883 rodata +199 text +684
>                u-boot: add: 5/0, grow: 0/-2 bytes: 1184/-500 (684)
>                  function                                   old     new   delta
>                  __getopt                                     -     520    +520
>                  static.bdinfo_print_all                      -     324    +324
>                  print_eth                                    -     236    +236
>                  print_bi_dram                                -      92     +92
>                  getopt_init_state                            -      12     +12
>                  do_env_export                              548     476     -72
>                  do_bdinfo                                  588     160    -428
> 03: cmd: nvedit: Use getopt() in env import
>    aarch64: (for 1/1 boards) all -27.0 rodata -55.0 text +28.0
>             firefly-rk3399 : all -27 rodata -55 text +28
>                u-boot: add: 0/0, grow: 1/0 bytes: 28/0 (28)
>                  function                                   old     new   delta
>                  do_env_import                              668     696     +28
>
> And so this is why I'm just deferring this until someone has the time to
> pick up and address the underlying problems with this potential
> migration that have been raised in the previous iterations.

That is actually what I am trying to do.

Just to restate, the main question to resolve is whether we are OK
with ~1K of growth in order to have any sort of getopt(). I did find a
way to shave ~200 bytes off it (v2 series), but it is still growth. We
could migrate the less common commands first, to avoid that growth for
most boards, which that seems a little sneaky. Better to decide
whether to use getopt() or not.

If you are asking whether someone can write a getopt() which fits in
500 bytes or less, I don't believe so, but you never know.

This v3 series is mostly about showing that we can likely avoid
(additional) growth for each command which converts.

I won't send it for now, but I did try passing the getopt struct to
each command (instead of argc/argv). That does reduce code size for
each command by about 10-20 bytes, so if we converted all the commands
we would likely break even in the end.

Regards,
Simon
