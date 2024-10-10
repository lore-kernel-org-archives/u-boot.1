Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A746BCF11FE
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 15:27:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2466A8904D;
	Thu, 10 Oct 2024 17:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vwSmArXO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D03D589092; Thu, 10 Oct 2024 17:27:03 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85C7D89045
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 17:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71df8585a42so802650b3a.3
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 08:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728574020; x=1729178820; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vgK3iX6dLVw+T2tXHFBp5Zw9LH43Q9vy/tlFaz73zOg=;
 b=vwSmArXOPlswArx3HxzIaYZhRUmnb3/AOqGXtszR43df0+hr0Lry0IcftgmpRigofy
 Ablv3U+hflg3Jyf2gdS72eFwAiaf0opW+ewQBl3aZjxhhYcyzwaWsvqHv9Sx+/7y8bPi
 uccHpS+szQdwjZhOEmjUgK6SiQ+Zx9hr0SCCuFKvD/bRYXbQsTqHVdSZ+YBqw2RcwXxb
 u18v21QYIBVKA20GRTzTJk/aUDiTQ6flyosL4HdG2Yc+8Lb884OuaD+JfnE+hOqrFuUp
 ggKzQc6GwbVUPwn+FOPl9dX+Dz4+Bk4a1t28/HAMIMbXWYb2S/sz/nz4dngrKw9Wb6p8
 euzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728574020; x=1729178820;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vgK3iX6dLVw+T2tXHFBp5Zw9LH43Q9vy/tlFaz73zOg=;
 b=B543V8Oy3/jDjT5daQ57qeFKKk/DsDfTwdvQvYYgzhL7j5qSB6HxITwhTKDV3tqGyw
 ZoQqmLs/CvP6mp1t5o5SkP7KJAbfvymp+T2Xv+9LKsrY9TkSjTaVc+ljKnTH/qbmBw4v
 jU2kwW0qcgVlXypSPdTBoHHawWWCIVrv3mM7cDBsSAoR9wjaPhgpwh4GZxEXvyy1uLNl
 E8SouNUN9eOHnPVBs2UCPBcHCdDLRaKuF25n/fqVp6bjTiVyHo1OHE3/eW4A7OeCiOAz
 inuN4fRnhK3AxBfExgaSKf37+2wLbrUkE/snExFiLzxqmM0Wmg8fhhJ/4KHG8Yjkv7O+
 XAYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6Y+nVRURc2cShIB1Rid1FgSediY0S7tQcfYepiPbB+gKNRpsHTV4UICJKW+0VQnnPLxJm70Q=@lists.denx.de
X-Gm-Message-State: AOJu0Ywdgq5ZwEgyJuz9VGgrW6iFth8eMdmI/VzFmQv/TijYZwr6bEgY
 tR7nSxBX77n2yjRcegpBnN6Lo2Y96gVuVW7MnxTlgyDn2LaSM+GrEcuqFtRhshvryWjutoPqzmb
 rbmeLxojpVDGn0jbgFYpiKSZabPIpEnI1joPk1Q==
X-Google-Smtp-Source: AGHT+IHJ3ZPBwYIjf6iD58EeTfTk0IucZdHKFT6Bk/bRLK/Er2ntCp4wugiXFxKkKDe0aIDvHT3/+PbnO0hoZr27uyI=
X-Received: by 2002:a05:6a21:6e4a:b0:1d5:144b:593f with SMTP id
 adf61e73a8af0-1d8a3c20776mr9724529637.28.1728574020068; Thu, 10 Oct 2024
 08:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20241009015020.25817-1-sjg@chromium.org>
 <20241009015020.25817-7-sjg@chromium.org>
 <CAC_iWjKh7_OKKMi9K6eMaiYUN-Nxf+ZQ0NuW9BYzK3u4F0Krcg@mail.gmail.com>
 <CAFLszTjBQaoF9g0nky5mAA429gzA8QvzjxHxooDaRo1=BB+stg@mail.gmail.com>
 <20241009223907.GN14210@bill-the-cat>
 <CAC_iWjK8Bb16aLAKtmYB0Aof4CJP-AAdsMTEYvnFeMeXaiWM9w@mail.gmail.com>
 <CAFLszThoXsWuPu=b+FT0wuURR1rxTE6RWZhUhET9mHbQ+j63ZA@mail.gmail.com>
In-Reply-To: <CAFLszThoXsWuPu=b+FT0wuURR1rxTE6RWZhUhET9mHbQ+j63ZA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 10 Oct 2024 18:26:23 +0300
Message-ID: <CAC_iWjKKqsJh7yUv-kRe5WiGA02c4YU4Yj83UXVXjki+CO9X1Q@mail.gmail.com>
Subject: Re: [PATCH 6/6] cmd: Add a command to show the memory map
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>,
 Emil Kronborg <emil.kronborg@protonmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
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

Hi Simon,


On Thu, 10 Oct 2024 at 18:10, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> On Thu, 10 Oct 2024 at 06:02, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Thu, 10 Oct 2024 at 01:39, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Oct 09, 2024 at 03:14:25PM -0600, Simon Glass wrote:
> > > > Hi Ilias,
> > > >
> > > > On Wed, 9 Oct 2024 at 04:41, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > We already have a mem info command, which is pretty useless. Can't we
> > > > > reuse that ?
> > > >
> > > > I am not too keen on using that as 'info' is pretty vague. We could
> > > > perhaps create a 'mem' command with 'info' as one subcommand and 'map'
> > > > as another?
> > >
> > > Are we talking about "meminfo" which literally only prints gd->ram_size?
> > > If so, I don't think it's worth worrying about enhancing that.
> >
> > Yes, that's the one
>
> So, you mean to just delete that command and make it show the memory
> map instead? Or show the memory size at the top, before the memory
> map?

I meant the latter, but if you and Tom agree that we should leave it
as is, I don't mind adding a new command. I assume that the list above
is non exhaustive, so in the future we could expand it with lmb
reservations etc?


Thanks
/Ilias
>
> Regards,
> Simon
