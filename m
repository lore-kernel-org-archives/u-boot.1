Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36187D21699
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 12:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACA42884D2;
	Tue, 15 Oct 2024 14:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZWsqwpXc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EC37884D2; Tue, 15 Oct 2024 14:49:14 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6347687FC7
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 14:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cbe9914487so36519636d6.1
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 05:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728996551; x=1729601351; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cE1f4hQM21oIS6hOdJ1+Pj+XGjw72Q3weaCMjRStOfA=;
 b=ZWsqwpXcwXdiOpBvKAhqC5lPvFEVp6zakf1823a31TyGlcyKQEx4DBfIdKgH0eBdsD
 qX6u5v8Qf2ov8WsqcEQ9iLcRXfwuHLYwdAvryOvp7QSfVnrtZAk37tP0tC9+Sgijf7Qr
 Bp5mOVZn8m3YUlxQ87XeGOGIsrcCUqarJ1L8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728996551; x=1729601351;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cE1f4hQM21oIS6hOdJ1+Pj+XGjw72Q3weaCMjRStOfA=;
 b=SGJoqjzDT70nSYTQBykuJTofjDEt2UYH4wcyqYQdIPLiXsoFWkxc66T5JgYcPqueZc
 xPPz6JYWSMG+8hV/X4CmMb80RxyPxU6c3T/GE/GjhtvjQNjuDXQolovYTyFrXTyADDsC
 y8+m8SA1/lW6e7FvC3TFUBhAxRvoVS8AxaW9HU+pZHBT7urVFpbgndYxPdpliT06SCZb
 CfpetWlo/cJ+B/wufCxrDHtdgh76Ha45KlRherwdBAtNo+zqWuZtIDuXk7qZInV/EHFN
 UIX9SNr/hE65ATFAIUonuU8Bm+F1NPwJbA1O9IrMDrZa0t2fJxvkBnblUSzLTytHxCHE
 tDKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy6OXkxcAEr7zpzioKjdsYN1bFOxEitISa02FpNfXMxpQneKYd3xZO5oqTH0C7fAFizFH7GxU=@lists.denx.de
X-Gm-Message-State: AOJu0YxQM7wYyRfYeHvWUKGj15WTeWqPFuNZ9RxSOlZVXew29TqdU44B
 SRs6OdQY1+U98BkaeQ/plUGDlYOAbUpCRwXb3a/WxknKZfd9z4ZZsjWiOi3AhGfP9n+U9y07rm3
 2pK2xqaM+TG+FRJV6skczrxkK5edxMNRP0Bdv
X-Google-Smtp-Source: AGHT+IH8I7WXMwmiPRa/M0yRWlJ/l/av0lh197GTpBYqyTrizrh/EIIFPe5e3n1P+2iC9IdJHGZD4gkxU2PckUepu14=
X-Received: by 2002:a05:6214:419d:b0:6cb:eca3:8e53 with SMTP id
 6a1803df08f44-6cbf0095627mr186507616d6.32.1728996551188; Tue, 15 Oct 2024
 05:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20241009015020.25817-1-sjg@chromium.org>
 <20241009015020.25817-7-sjg@chromium.org>
 <CAC_iWjKh7_OKKMi9K6eMaiYUN-Nxf+ZQ0NuW9BYzK3u4F0Krcg@mail.gmail.com>
 <CAFLszTjBQaoF9g0nky5mAA429gzA8QvzjxHxooDaRo1=BB+stg@mail.gmail.com>
 <20241009223907.GN14210@bill-the-cat>
 <CAC_iWjK8Bb16aLAKtmYB0Aof4CJP-AAdsMTEYvnFeMeXaiWM9w@mail.gmail.com>
 <CAFLszThoXsWuPu=b+FT0wuURR1rxTE6RWZhUhET9mHbQ+j63ZA@mail.gmail.com>
 <CAC_iWjKKqsJh7yUv-kRe5WiGA02c4YU4Yj83UXVXjki+CO9X1Q@mail.gmail.com>
 <CAFLszTi_CqDY2+RMRo+hJLsCtn6vQHHoeBvT8g-czL7OQAXw0g@mail.gmail.com>
 <20241014210707.GW53053@bill-the-cat>
In-Reply-To: <20241014210707.GW53053@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 15 Oct 2024 06:49:00 -0600
Message-ID: <CAFLszTigkFprX5KH3po9h+XqJ9-6_qcyCgM466srHgXMdGwoSg@mail.gmail.com>
Subject: Re: [PATCH 6/6] cmd: Add a command to show the memory map
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
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

Hi Tom,

On Mon, 14 Oct 2024 at 15:07, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 14, 2024 at 01:13:25PM -0600, Simon Glass wrote:
> > Hi Ilias,
> >
> > On Thu, 10 Oct 2024 at 09:27, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > >
> > > On Thu, 10 Oct 2024 at 18:10, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Thu, 10 Oct 2024 at 06:02, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > On Thu, 10 Oct 2024 at 01:39, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 09, 2024 at 03:14:25PM -0600, Simon Glass wrote:
> > > > > > > Hi Ilias,
> > > > > > >
> > > > > > > On Wed, 9 Oct 2024 at 04:41, Ilias Apalodimas
> > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > >
> > > > > > > > Hi Simon,
> > > > > > > >
> > > > > > > > We already have a mem info command, which is pretty useless. Can't we
> > > > > > > > reuse that ?
> > > > > > >
> > > > > > > I am not too keen on using that as 'info' is pretty vague. We could
> > > > > > > perhaps create a 'mem' command with 'info' as one subcommand and 'map'
> > > > > > > as another?
> > > > > >
> > > > > > Are we talking about "meminfo" which literally only prints gd->ram_size?
> > > > > > If so, I don't think it's worth worrying about enhancing that.
> > > > >
> > > > > Yes, that's the one
> > > >
> > > > So, you mean to just delete that command and make it show the memory
> > > > map instead? Or show the memory size at the top, before the memory
> > > > map?
> > >
> > > I meant the latter, but if you and Tom agree that we should leave it
> > > as is, I don't mind adding a new command. I assume that the list above
> > > is non exhaustive, so in the future we could expand it with lmb
> > > reservations etc?
> >
> > I sent v2 with that done. The lmb reservations aren't that useful as
> > there are no names attached.
>
> I disagree with names being needed to be useful in this dump.

I'd like to show where the kernel, FDT and ramdisk are, with actual
names for them.

Regards,
Simon


>
> --
> Tom
