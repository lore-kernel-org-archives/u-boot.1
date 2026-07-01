Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC42C43327
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15B3584C01;
	Wed,  1 Jul 2026 13:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jfv0ADbb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7F1D84B92; Wed,  1 Jul 2026 13:58:04 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 702DE84C11
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-691c5776f35so892785a12.3
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 04:58:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782907082; cv=none;
 d=google.com; s=arc-20260327;
 b=Jozfg6Td5dzCNpVKB2mEekmdU/gTUERdAt3O7xY9TVFSolNdz74EBNLH1MtfZbh290
 yDdA+C1BoGknu96RRtrVso8hYIA0sojheWnPs6o77fd2TZUwPqbpOh1rAEzQRmDsEyvF
 y4ENKnVYuGDLGztuTyUx89Q0+6d9o0rd5aZrKhoYbck5OW6e9gH296J29dWWAiAiwVdi
 wFBMjC7e1KqwXsTqvzZuHVHI9vxprxVRyqf649SKuO6PdiRJLhII2bF/p6fX9axVm8V3
 T8ornayywMQdgrcoc7f8XK2So9+b3cQJ8kgAPAEULghgSxN1wPx7fcTzAa0oAhLMyHwu
 1Q6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bbm3tqBv42ioHe2m+sjo9zgcA7salIVKtJn7FfHCPQI=;
 fh=C2sLfhTVTzPhhUv9lXCDRFomSrjGvehGZVupNBnxihM=;
 b=fiPlMAYjse5cqz3+lGl7zChwuVg3lUYa52B9tn2f5G22qoGPIIJN8tcSIe7b/onKPd
 n4IFy7HcF4bPNu0Z8mS5auT3vPqQFstFwtYuHEHt1zM19pTPHnH+d1uHpAEGvD3oWDd7
 ZO66XVsRZKmJynjiv7hghqNK3KWzYD4awCf6gm8hqPcxbmsaMKnZDsT35oVTUp04mYoN
 SbdFS/zCYpm2JIJAquyxDjubhxgnFPfRAyaY4y/nXnUilFJt6q+bJRsPxqj3Uw7bKdo2
 rSH5ZS6PvtEO6YMh+j7OnOKbEqqS/jTlpNr8THZQwP2tQ910ovIllUadzYg/YIsvT+3W
 yzqg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782907082; x=1783511882; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bbm3tqBv42ioHe2m+sjo9zgcA7salIVKtJn7FfHCPQI=;
 b=Jfv0ADbbXZaUwFaD5eKsN5dKSCl1m2IGYl3oo0NEC1g+/66EHKkD4wDbTOHQtrzNuj
 xYBcuuB0X/qe0Yge39IYzBlAPFoEQlSC/VvQX4KNHdqPBgyFAyfUtdkXcTtNZNhiXrO8
 SsMze1U2H+ZcZBbNQpW5CHJpUBnYuxbvgOwKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782907082; x=1783511882;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bbm3tqBv42ioHe2m+sjo9zgcA7salIVKtJn7FfHCPQI=;
 b=pNBwKh6BiunHgRBelahCdZ41sVZEcVz0KhrybfCCAkqkmdevLZ73bHS4jCaJVCz5mA
 /tRXWYwqlAy9O8ybFiqLjgqFg9Mm54koudg1uv4ZHX0T3FiOnATZ9Cu7Df8W5TI0g0oX
 8VyQ2dSSjxohHNwaFwunh7txZn3vwDP8oYpxHpY0XnzEDFH4Ne9TScozTiA+v8ai5Dy2
 lXGuESnPg0AZ0TMe8uIDPp7bBEpMr50IEubiEa2UHyDkbPGzfMTjjdYzztwAW1/ur+UZ
 /kNr5bmrX0vP64g4OEWeRjtmoOsZOcX2UQx+tHEVOzzAeghoJsUYVWXa4idZAxWKRn3g
 ZaXg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrwGyylq38srBxkjJ5i9vpWsnKHp+jDzIkE+RwmyT9ESE3Yr+3rDo7S0QtB782kdSUkvW6B5ss=@lists.denx.de
X-Gm-Message-State: AOJu0Yzo1Le+Vi2IXeDV9XTFDGIdb7xjMqBj9aW9T86kDpKuo+7hYj5t
 6gumsUhBTY4yOnridv9E4M8Tv/7BzZ1gBzd7ijubzREHvDkXtFlOPUEXT3VUa7cC07oOJfwgnIO
 Q0mMex6LE/uPJMzSfv11Lp73f0HRl4HnSRSM6hsUU
X-Gm-Gg: AfdE7cl9IeB5aInn337D2zGwmrK7Tu2QQdDvu3KnI5B7mjvPJX7hcQjWRzBf1gvmEgY
 39cs24nSaTp7PVphLozfWWEOhxl0IM9GtCGsQmVQnKE22ZN3cXQleUdVb+/8ibQt7VNzn9+cdD8
 +jhmOkHUNZyLWSAwyLcoM0DxsEe9PgXYpeNzQCuIleMhJ8C4tXI9RiRAabYCkP1cOst2zFIV0Jp
 jCwrDoHqIU3qLlA2pv6QFBRZojfl9AdBsR48UbgEU2bq3OInNQzOI6m7huC8+6HRiOhoQQioA==
X-Received: by 2002:a05:6402:2110:b0:698:57cf:469f with SMTP id
 4fb4d7f45d1cf-6989f371034mr723671a12.27.1782907081860; Wed, 01 Jul 2026
 04:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260626183353.1666667-1-dario.binacchi@amarulasolutions.com>
 <3dfd02eb-fcc1-49d1-aea2-6bd20f052692@cherry.de>
 <20260626215804.GB382693@bill-the-cat>
 <CABGWkvrCJn_ABadB0AmTQ6dp=ufDi1GdSYgSP1fkwCQQM=OL9A@mail.gmail.com>
 <20260627173152.GC382693@bill-the-cat>
In-Reply-To: <20260627173152.GC382693@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Jul 2026 12:57:49 +0100
X-Gm-Features: AVVi8Cf-Lpf6NjnBovj4HeBHOPzqQtDdtig11ZKk3hywNLq2liMW4UEOBjTosIs
Message-ID: <CAFLszTj4gU-sOE5OFvqoaJ1juYVg92XBRSCwid+OiXjmOC2pAQ@mail.gmail.com>
Subject: Re: [PATCH] test: cmd: part: fix integer handling in
 setup_gpt_partitions()
To: Tom Rini <trini@konsulko.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, 27 Jun 2026 at 18:31, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Jun 27, 2026 at 07:24:24PM +0200, Dario Binacchi wrote:
> > On Fri, Jun 26, 2026 at 11:58=E2=80=AFPM Tom Rini <trini@konsulko.com> =
wrote:
> > >
> > > On Fri, Jun 26, 2026 at 08:40:36PM +0200, Quentin Schulz wrote:
> > > > Hi Dario,
> > > >
> > > > On 6/26/26 8:33 PM, Dario Binacchi wrote:
> > > > > Coverity reports an INTEGER_OVERFLOW issue because ut_asserteq() =
compares
> > > > > an unsigned int (mmc_dev_num) with ret, which can hold a negative=
 error
> > > > > code.
> > > > >
> > > >
> > > > The trick here is that ut_asserteq() takes two arguments and casts =
both as
> > > > unsigned int, hence why it complains.
> > > >
> > > > If Coverity is happy, I'm happy :)
> > > >
> > > > This looks fine to me, so:
> > > >
> > > > Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> > >
> > > Yes, were you able to push this through coverity on your own?
> >
> > No, I haven't.
> >
> > I couldn't find any documentation on how Coverity is run for U-Boot.
> > Is there a recommended way to verify Coverity fixes?
>
> There isn't, because AFAICT there's no way to do "test" builds to see if
> a change corrects the problem. And I don't have this running via CI
> because due to our codebase size, I think we'd be limited to 2 runs per
> day, at most.

Is there a paid option for this? It is hard to tell from their
website. I would really like to be able to run coverity before sending
patches, since this business of fixing it up afterwards is quite
painful and I ended up giving up. It it doesn't cost too much I could
cover the cost.

Regards,
Simon
