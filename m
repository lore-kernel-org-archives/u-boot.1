Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8B5CFC264
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 03:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 778C388E89;
	Tue, 15 Oct 2024 05:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FIe0Y27j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D389288EFE; Tue, 15 Oct 2024 05:47:30 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83CF788AE7
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 05:47:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2e2c6bc4840so3483469a91.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 20:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728964047; x=1729568847; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aWrz6+b+God22Uc+ZtPtttLDAwcMitsBFmUPNGCiJgQ=;
 b=FIe0Y27j7ecqX1j9lpwc9k4PC8XlQu17zd+xrBLo2M1s3zNqHAPoxE1NObHAPX5Zpf
 Z/I1jf1tmMIKnBzBEP0kqsE2wJXlblwAMYmLcKGg7429Vp6SVXFc5XtBCDdWtgQ+qWsM
 YuL6xJ7eZI4y0sAJxWV2+1iyhjzT+jprQUjVlw3dLdwMPVgIGgPTKH2VOhBThoIOKab5
 46SucPIbKWkr7+cAuOSW+uZQaOY6iMBeetZBoc77ePohYTwUUpGs8xKbuBhrNV5s1hdp
 Ub7VVPZgeayQ9EcB3QxJ2h1rP3xsKG2iXocLCAe5xIDdt26WF2NgSl/btohW3CwRZKeH
 +9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728964047; x=1729568847;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aWrz6+b+God22Uc+ZtPtttLDAwcMitsBFmUPNGCiJgQ=;
 b=fGogVSuHZa+XuK29sffPdOXdRJnXTWZ/XH3BkZN78IwSlWP4re0Gq4nEJYHQ9feRq4
 Zdcoy4fA1ySshfdmoqrREbPFhK6JaIzVEbdR8Mw7SukuhWWIrwrZHWNuisYB6Kpz2XvM
 HNrfNNg64PjWZVJMzIfGYpeLBz5gumCFfdFuT0nru+th5K3dxo7bQxCUX3de5b+h3s6J
 QpWqSEA3yl5ZOqzpGLUzMAqLTaYn0zrSQLN4HBzw0vbyig8lDBX7Q8Hjcn8lu7h9Etxk
 ClWCDg9iA8JYuUAKNvM/Bc6CIG/gGraQO7pj5Gka9zmLzNdFQYfgSsGCbE+eQUDG4cox
 p+DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHZUv7sgargfbBtsuKHwRgtFr35wiKPSjF9wWywYmfQN2G7nC7SQxucnEdEOHKSYeK3UMb+B0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4NFk3yk33Y3YikoXidkm5sFC3jxZu0ekD0eU+b4T7V+sImRQq
 1SK9gcTrY/vBfWOJtAkjiLV9TwVZXckMosF9SGrZOBEUE/aE1W+xOXOSRp19v9GHaIMZN/PeYAo
 AsMqZdZk9Bw7bydxA2fTYdCKQDCsCL3HzMKhzOQ==
X-Google-Smtp-Source: AGHT+IG2Y0ElBWk/T5DnGnbwFqptwOL5tBZjIT6zBkvibvPPVo7buyxxWZxEHXGc1ELytMKHCqvoztow+09MixRPMxA=
X-Received: by 2002:a17:90b:4b8b:b0:2e2:9077:a3b4 with SMTP id
 98e67ed59e1d1-2e3151b8a44mr13530127a91.7.1728964046875; Mon, 14 Oct 2024
 20:47:26 -0700 (PDT)
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
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 15 Oct 2024 06:46:50 +0300
Message-ID: <CAC_iWjK4JXsTgbNHVryjkD0E+swcScn2rrsKTLedscf7dGmZTQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] cmd: Add a command to show the memory map
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
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

On Tue, 15 Oct 2024 at 00:07, Tom Rini <trini@konsulko.com> wrote:
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

Yes, +1 here.

>
> --
> Tom
