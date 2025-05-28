Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70016C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 15:20:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC725832EA;
	Wed, 28 May 2025 17:20:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eR7DdCI1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F296C832F9; Wed, 28 May 2025 17:20:33 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E07BC8329C
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 17:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-604f5691bceso3158177a12.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 08:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748445631; x=1749050431; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oQV8zt/RNBoaVLYazHKxOaZbpx9Ng5NGvoZx1BJvUbg=;
 b=eR7DdCI1YNjVFGM4//GyDU9EWWXUWDIotdFrvrtMFFIZMoWmyuagLGYAcbYGPQDzSh
 cmTtk7fNbZO18k3Yv8QCNqAW2zCZTiBM8GSPk6LYPv8LrCnJw25pgKpS7ceAucoXQWZJ
 YpeKhusFJi3g+s2Jvl8IathzX8agdOMqR3y1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748445631; x=1749050431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oQV8zt/RNBoaVLYazHKxOaZbpx9Ng5NGvoZx1BJvUbg=;
 b=ertbwKzGZtLSmtDPhtI9Ryq7gPG6OuBKquWFLrnWpfYLO3jMSzaOMGhMylf6AUTp5N
 aowBqo/2TlXoqSDtzlonUj2UMxwIBG/5sUPtKVcvTDNqZrZTMKmrVC4iIoW+OUVo2aBR
 sBwWJVGHKdXHvQnEBsHdWn5zxbeeZyfG0HH1QQKxmZZ3da6tKCRGfBQxLZWwPTd5I8YT
 eqhPSyfHkqe9b6ThKJDIUb8TwSDtiu0lGfl9fCNZz6OYv1G98z4it/SFZR0xk7n9Gux9
 R6yD2d4OO399dWtrCTpkkwTsH2be30r7CTZHBuQZEnJD2nexFdJZms/vHC5OyBHg149J
 f5Lg==
X-Gm-Message-State: AOJu0Yz0+IP4ZkTkpTS12SR38I7BQtJweKguXib1B2pg9UAHinfnRTfz
 Op57zhtyi1MenOgm/U9/OLeGwPeCeC22yNFnhJX5Bv45fjIojpHxLiLA9aMD7CD3bC6TQ5d0LvV
 x8URttJyPPZ4jUicyxzGRd2DuK4lv3bhMMTzVjRc7
X-Gm-Gg: ASbGncu3Nskztl0EyRHwM0rQnQtJD9ph+fLfekRqcPgFnxQ6PVYdi0Ns0Gmq8+eXuq2
 yaPA/JfJ+NaSueiL5TE7MKU2OT9n21ho6QvZCAEpW39pxeaRzKyXj6qJK1N1nWY73DB44nk/C4R
 BEOAUwUZDeMiz7WG5oJ7li/2C9DOhuV1ERmi3FaHqfAw==
X-Google-Smtp-Source: AGHT+IF/7TNxOpTgEHIwL+XEDJAKo54DQym7hqmCvkNOmYRTjLc3Uh45w614Va+1w3fktWcZmc/04aaGXJo7pcrNYgk=
X-Received: by 2002:a05:6402:2713:b0:601:e0cf:9ed with SMTP id
 4fb4d7f45d1cf-602da2ff9c6mr14399091a12.22.1748445631214; Wed, 28 May 2025
 08:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250528082520.152391-1-sjg@chromium.org>
 <20250528140929.GR100073@bill-the-cat>
 <CAFLszTiVtyAsdqLNaGrs11TuugAhTp0Rru30=yNJoAa2RyU6YA@mail.gmail.com>
 <20250528150123.GY100073@bill-the-cat>
In-Reply-To: <20250528150123.GY100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 May 2025 16:20:19 +0100
X-Gm-Features: AX0GCFsIRUP3ZT9zPAmanGdBARByfF6ooFa1eqtUQWobgU-tql8FSxekrm4cELk
Message-ID: <CAFLszTgVE+WLjsf4cWgaCDQD47adR2RTNNNJAqPMRS7pyzWcTw@mail.gmail.com>
Subject: Re: [PATCH 00/27] x86: efi: Various app improvements to support
 bootstd
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>
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

On Wed, 28 May 2025 at 16:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, May 28, 2025 at 03:25:32PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 28 May 2025 at 15:09, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, May 28, 2025 at 02:24:26AM -0600, Simon Glass wrote:
> > >
> > > > This series makes a number of improvements to the EFI app. Mostly it
> > > > applies to x86 but the ARM version will share some improvements.
> > > >
> > > > The main updates are:
> > > > - Improve linker scripts and options to detect missing symbols and
> > > >   remove unused code
> > > > - Enable bootstd and provide a default which can find an extlinux OS on
> > > >   EFI media
> > > > - Make the 32/64-bit apps more similar in terms of features and link
> > > >   script
> > >
> > > So I give a little, and say Yes to you despite technical misgivings, and
> > > you post yet another big series that's based on your tree with already
> > > rejected changes in it. I do not feel that you are working in good
> > > faith. Please stop, and work in good faith.
> >
> > What specifically would you like me to do for the EFI app?
>
> Well, the three patches you posted and Heinrich accepted were a start.
> You need to build on that, in mainline. As again, the concept was fine,
> the introduction of more technical debt to deal with later was not.

Yes, I'm doing that. I said to Heinrich that I'd wait to see what
happened with those three patches and then do some more. They are in
CI so I'll post them soon.

But I also mentioned to Heinrich that I don't think I am the right
person to undertake all the refactoring work - moving EFI-loader code
out to lib/efi etc. I'm not a maintainer for lib/efi_loader and my
track record of getting patches in there is not good. We have the
U-Boot versus EFI memory-allocation problem and my ideas for that have
already been rejected. So at the moment I'm not planning to go that
much further in your tree, unless there is somehow a future meeting of
the minds. Perhaps Heinrich or Linaro will be able to work on it and
then we can re-unify things down the track?

Regards,
Simon
