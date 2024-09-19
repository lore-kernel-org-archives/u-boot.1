Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A94CF3943
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20F6D8928B;
	Thu, 19 Sep 2024 16:14:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hFxNPQDY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61CC2891B3; Thu, 19 Sep 2024 16:14:28 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 281EC89266
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71923d87be4so658873b3a.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755265; x=1727360065; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VBADi8ZmTgbkmc6fdoAIwafg7+6HMLASW4FRoLggz+Q=;
 b=hFxNPQDYwpfUKkYK2MtWj1Ab+/hEQ2XVMJGB8hnJjO336+NMVgXTWttq1Ge06q4rs1
 aVmY8kd6M55cMPm2XniHBMPVr89R3IawXbc0u2adLKesPhBPFW9FgDy4sJ5glfnk49CQ
 8IeVKoDcIxfDXdrwyl7jTHka43mU2qWSLjFoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755265; x=1727360065;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VBADi8ZmTgbkmc6fdoAIwafg7+6HMLASW4FRoLggz+Q=;
 b=ZtUV5Meqhy6nW8WPelV67YeF6HkLg+l7uNMi3bTUKV1/UoKacip4t6W5Znl70lnRV7
 FQ4RLwzZxp1f4YOazpd/wriaUEk/8rk5BgA57lQ5RBxGEFz4ApVLIut/xT6WcQgkX/Po
 UIw0hAJYTpYDRGw2P+mrYDSGQWIkO9HI0hMKss5eHXgTGysI1GV30EWe5cAEdcgO+4OD
 Jl3gRSRDeNukCbOZcc8i01sSO/IrBW1Oh/JN2vdKcsGBgsQpbrgzppYDBIhYKccrFvkR
 TRVcnjNpYa0rXHpeltCNOA8T4L8b8/MTvj6kHtMGnuUXbC4KMRPhZsOOeMv0/cIopk53
 fEPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4A5TcTwkw18UdqFGpocLESn6jrbN4gwbH80ZQ9iqsGAQJ2h5OvQ4eVvWQwgxEkRlQpMaBROA=@lists.denx.de
X-Gm-Message-State: AOJu0YzDPfG9ftR+y2GKDFS7D1jhUbga1Y3wYHLfmv4G/IjSORqyK+hv
 LVP2NORIpWItttc7iCl5LazZWzIjnWcfTTOvokmkwLEqnLyYWfsRY4GSLquOASp8TR+CORADQ1L
 gupWgRXndDTbA813hZuZXG2z+dF1RReiBfdR8
X-Google-Smtp-Source: AGHT+IEwkrxd6NtfQF25avB59MrSovHzsmShIA+S77nBH6fUp5OIbjttQ/VqVYFZjhN4tjNtIpwW9687NQIFvcDyoS4=
X-Received: by 2002:a05:6a00:27a0:b0:714:20a8:d79f with SMTP id
 d2e1a72fcca58-71936a60409mr33952835b3a.14.1726755264660; Thu, 19 Sep 2024
 07:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724419624.git.jerome.forissier@linaro.org>
 <1629f6845b448edcdead09a9350f1ae2ae7a4bb6.1724419624.git.jerome.forissier@linaro.org>
 <CAFLszThJzVvHSd+dEjTSff2DUPPaQTGWeyCmHmP56Vtjr0WF-g@mail.gmail.com>
 <d2465352-66ea-400c-9216-a92ce5351475@linaro.org>
 <CAFLszThp9Ya-doN39L-uv6C_oZsw454PUiUfOZmYa7wHjoz+oA@mail.gmail.com>
 <CAC_iWjJ1aACnb2u+6+k30ATr6UAwkBQ++2syXy6xR5sSvzq4rQ@mail.gmail.com>
 <CAFLszTh-5o8hEv47+jb2od=xQxMhjOGpG0qC_PjL5XkLx5nM2w@mail.gmail.com>
 <20240904223230.GC2479150@bill-the-cat>
In-Reply-To: <20240904223230.GC2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:14:03 +0200
Message-ID: <CAFLszTj0joALRDNjoEGkt99QCACZgLiOZbMTJoJK3_JzGmtLSg@mail.gmail.com>
Subject: Re: [PATCH v9 35/37] [TESTING] Kconfig: enable NET_LWIP by default
 except for SANDBOX
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Anton Antonov <Anton.Antonov@arm.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Jonas Karlman <jonas@kwiboo.se>,
 Greg Malysa <greg.malysa@timesys.com>, Jesse Taube <mr.bossman075@gmail.com>, 
 Shengyu Qu <wiagn233@outlook.com>
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

On Thu, 5 Sept 2024 at 00:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Sep 01, 2024 at 02:09:43PM -0600, Simon Glass wrote:
> > Hi Ilias,
> >
> > On Fri, 30 Aug 2024 at 03:27, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Fri, 30 Aug 2024 at 03:59, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Jerome,
> > > >
> > > > On Thu, 29 Aug 2024 at 10:21, Jerome Forissier
> > > > <jerome.forissier@linaro.org> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 8/29/24 16:05, Simon Glass wrote:
> > > > > > Hi Jerome,
> > > > > >
> > > > > > On Fri, 23 Aug 2024 at 07:50, Jerome Forissier
> > > > > > <jerome.forissier@linaro.org> wrote:
> > > > > >>
> > > > > >> Enable NET_LWIP by default for testing purposes. SANDBOX doesn't support
> > > > > >> NET_LWIP so default to NET in this case.
> > > > > >
> > > > > > Sandbox needs to support NET_LWIP.
> > > > >
> > > > > I agree in principle, but AFAICT it is not a trivial task. Does it have to
> > > > > be done in this series or can it be dealt with later?
> > > >
> > > > Does it build OK with sandbox? We use it for almost all of our feature
> > > > development and testing, so I cannot imagine bringing this in if it
> > > > doesn't work. How did you develop this feature?
> > >
> > > sandbox is deeply rooted into the old network stack. It fakes ACK
> > > responses, handles the ping request/replies with the sandbox ethernet
> > > driver etc. I was looking on adding LWIP support for it, but it's not
> > > trivial and I don't want us to add another hacky 'glue layer'. Since
> > > LWIP is a big feature on its own -- and is working on real hardware
> > > and QEMU, we discussed adding it, so people can test and contribute
> > > fixes while we fix sandbox.
> >
> > At the very least it needs to build on sandbox.
>
> It builds with sandbox, one of my tests is to switch the global default
> to lwIP and make sure nothing blows up.
>
> > I am not sure what tests LWIP has. The U-Boot networking tests are
> > very simple on sandbox. The test provides a handler to generate a
> > packet that it wants, then does a networking operation. It should not
> > be hard to plumb that through.
> >
> > I am nervous about this going in with an intention to fix it up later...
>
> We have two flavours of tests. One is the sandbox-specific state
> machines, and the other is functional testing. This series passes
> functional testing while adding another functional test (for wget). I'm
> quite fine with having sandbox figure out lwIP be a later TODO.

OK, well let's not leave it too long. It makes tests nice and simple
to write - just a function that can parse and generate any required
packets.

Also if someone can answer my first question (what tests LWIP has)
that would help.

Regards,
Simon
