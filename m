Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D7CCD98C5
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 13:06:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B440D846B0;
	Sat, 13 Jun 2026 15:06:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nVSVYT03";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C01BC83FEC; Sat, 13 Jun 2026 15:06:07 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78C008466E
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 15:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-68c32f3c6d6so1886207a12.3
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 06:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781355965; cv=none;
 d=google.com; s=arc-20240605;
 b=fLEuVC1So2WSs5yBoa9v20oyxWQwr8S6ViKNrLIn5H+OneP/gyO9rgSTjBMMpNA9fA
 gnAXDKgq20yOvxoScpjaxAgna59NLxFEb6tL/13FkWONuYRiRC002wiZdPF38yroi+LN
 kYtufkv2nCcRC9FqPZMepE+keBBLd3ZPot0f+WpQXjVvgj2UhpA/LgcZ+mxK4B3MssFv
 gXPuC/k/gTXfl29V9JyLAXmRpRmXebup6qcpBdmy6oWbATLJb4zP/JXruuYTdhsck0Ce
 eJOKIDUElShIF6dVjD4EbeFsHMFvBF+3uaEw8M8IDUnLan37HP6tnX45cTvtgfTGXuCK
 JwBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=15wyBmSxdIp1aFbkVjKhDXdoAHONoXY/vXX73+A4UdE=;
 fh=cvunnWoVq6Mi4Jz4LpMwi4dQqHZgU/SnRry9i7aNSXA=;
 b=cy3svHN/r5lMzSwedvn9ov/bhka7lHLAMeIK1CNrFE2sDlPREXj/tps1JWjRubterC
 So278EMviSWWTP9SxwKO4mUYzsTxaFMNsUX6Y5rN5h+WwdknDb2S0cdPk0tnXVALu8rm
 tNvSXDChxyI250RHbwqzi3qhEbtIDCjcDSVwA9qHHR00Y55RqTDtDmNBEi1SZsnrPYPa
 y+JpNi6dJrbCkxjyCbwrEl+KLqf4TId+y6rHPwX2eRX2c6s1Am75biVdyRAtqifJ+yyu
 eMyyu4AFbTd8JW1qb6S7C19uAM+q5shQKUtzQB/JOLuE4wqpczmb8/0AsEG/62JMh2NN
 4Ieg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781355965; x=1781960765; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=15wyBmSxdIp1aFbkVjKhDXdoAHONoXY/vXX73+A4UdE=;
 b=nVSVYT03vT46SlyN8qudezimzRetHROmjXsOn3L37tw3j9ZqqL6E2c8CzPHaWFyDTV
 mFw92Z8pbw4OHRAUZRimyn7bhmA6idfWY3+7D+wITo4Td2kzVOuF/D1Oo0z9ZY2qFp3V
 6n5DCOITLFMmk0MsoQ8AiRx4WcaUIsdBz/V00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781355965; x=1781960765;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=15wyBmSxdIp1aFbkVjKhDXdoAHONoXY/vXX73+A4UdE=;
 b=m4hTLUvDbJZwOFuJXmnP6R8jD8vMwsWlyp37NywXdtNzUK2M06e6DmV7o+bgwN+AXU
 TO7BG7NuC4qSnrcB2Lx+5sRoBdlVlOcFsFBZSLlNfIfWkM5CNQ3peYE5pyETY4Z0Jxk0
 LKu4/0Rts+pTxjm6uykABru6re7+biIaewTMpxiV/5LyzsqC8UJwArPd8B5t4vP6vBLL
 qPzEGM3ClxneqJjm0p7GyuY4U0tPGjcJoJal2MbmfC9op6sDs7zPGqe1rDt5ItsMTTYT
 DNm8HlcziWxw5lCbu/anPC9uRwYnCi63kssvhuJLuIf1GfmADBmBilbRG62ixuuPUjPa
 1Nww==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jbZOrMpRZuZrxl1wO+ob4MvDyNtnS29Dc2cdBQgk5YOpEHIc40MOBCcFMxMLXa1Vki3T5v5Y=@lists.denx.de
X-Gm-Message-State: AOJu0YxmAQZHMVeB+1GEZ4wgacFXsCADwMYg3yKwx1uEvGGHVetjj9q2
 tcN1Ifm839+893H0+xpQLQo8vmnavr9WYHhHaieViegr2dQa97RstCNQ4EoBB2bn2+b2GUGr87P
 Dm+VF68pfePoAy+JQ1whxY3/gsdKJHZyKw4nv4N64
X-Gm-Gg: Acq92OFAvt8eSLv7D6bpIzn5H6R1C3kVU14OH+5VF3JnWj4yWp92RWRvMtJcwBxThRs
 vPCPJHF5xAMmZv6XNBbsYqwAU5ZQ62tuD0lTXmMA5G3mnaFrWkaDofv6Q0wtynmrjaA71i59wnx
 BbyeX84gIIboVDJv4IZVAdf65ta9HM8JfgEzK0oJqzjQxzmtQVQDuqdTy8qDacjH21MzPkUrj2N
 zkQc4MgiIkgCT2UX9yOB/jUqub6E2YLj5YzLjR09U8NRHgNImDGefGWaDXBy/44xGeLVOPf8V8q
 oUi5FA==
X-Received: by 2002:a05:6402:3608:b0:691:af8c:7ab5 with SMTP id
 4fb4d7f45d1cf-69378a3933emr2985647a12.22.1781355964807; Sat, 13 Jun 2026
 06:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260607230519.3022520-1-sjg@chromium.org>
 <20260607230519.3022520-4-sjg@chromium.org>
 <20260607234726.GF382693@bill-the-cat> <aiZ9W3ClrZ-B31VD@ashevche-desk.local>
 <20260608140058.GG382693@bill-the-cat>
In-Reply-To: <20260608140058.GG382693@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jun 2026 07:05:52 -0600
X-Gm-Features: AVVi8CcExw0suas5PUK71J9eRW_EF5rl6EtFw04hSh41sr1OdSu1H0eAgUZGCu4
Message-ID: <CAFLszTh_W1ehvFyXq_coV8pV8ghH=5AeYR9NsmO5pFK9AKJCsw@mail.gmail.com>
Subject: Re: [PATCH 3/5] x86: edison: Align U-Boot via binman to fix the boot
To: Tom Rini <trini@konsulko.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de, 
 Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
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

On Mon, 8 Jun 2026 at 08:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jun 08, 2026 at 11:29:15AM +0300, Andy Shevchenko wrote:
> > On Sun, Jun 07, 2026 at 05:47:26PM -0600, Tom Rini wrote:
> > > On Sun, Jun 07, 2026 at 05:05:12PM -0600, Simon Glass wrote:
> > >
> > > > The mask ROM loads the OS image to 0x01100000 but enters it at
> > > > 0x01101000, so U-Boot must sit 0x1000 (4KB) into the loaded image. This
> > > > was arranged by board/intel/edison/config.mk, which prepended 4096 zero
> > > > bytes to u-boot.bin through an 'INPUTS-y += u-boot-align.bin' rule whose
> > > > recipe moved its output back over u-boot.bin.
> > > >
> > > > Commit bd3f9ee679b4 ("kbuild: Bump the build system to 6.1") stopped
> > > > that rule from running, so u-boot.bin no longer gains the 4KB prefix.
> > > > The mask ROM then jumps 4KB into U-Boot's code and the board never
> > > > starts, sitting in BootROM download mode (DnX) and cycling.
> > > >
> > > > Since the Edison image is assembled by binman, provide the gap there
> > > > instead: pad with a 'fill' of 4096 zero bytes ahead of the u-boot entry.
> > > > Drop the now-redundant alignment hack from the board config.mk.
> > > >
> > > > Fixes: bd3f9ee679b4 ("kbuild: Bump the build system to 6.1")
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > That's an unintentional behavior change we should understand why
> > > happened, and then do whatever needs to be done to fix it, so that other
> > > platforms that might have been in a similar spot can also be fixed.
> >
> > While I agree on this, the Intel Edison case gets rectified by this series in
> > terms of getting rid of the known hack as Simon mentioned. Yes, it was me who
> > invented that hack long time ago for quicker ramping up the board.
>
> That's good to know, thanks. As I agree that this is a better long-term
> solution, but for the upcoming release the right answer is to fix the
> direct regression (and so potentially other platforms, depending on root
> cause).

It has been broken for a few releases, so I don't think we have to
panic to get this into -master

I believe this series cannot affect other boards, but we are very late
for fixes.

I spend some time looking around and found MXS has the same problem.
So I'll send a new little series for both, then rebase this series on
-next

Regards,
Simon

>
> --
> Tom
