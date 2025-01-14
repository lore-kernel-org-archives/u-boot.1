Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C0DE77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 19:34:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 658778022E;
	Tue, 14 Jan 2025 20:34:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JzVL9NlF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 417E98060C; Tue, 14 Jan 2025 20:34:52 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D36268007D
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 20:34:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e461015fbd4so8473025276.2
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 11:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736883288; x=1737488088; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lEAVTsD3mW1B4c0RJt4r1vd8knWdTadRzhqx/4/w6wE=;
 b=JzVL9NlFAJKtFhJz4t1jpXOafoNYsR0Wy7miaHZJ8lyvWMtyRGYVckwCDkDZksoZnZ
 PcA/hs8QWi/jQqhG2Uxrze0pBa2te6DBYWnRgnYrXH9Z3RSyOjvRALQ/uGYt68rbEqz0
 kZikJjdO1d3yE9IkLdUWiXYzER4z/N7YqaQOc8wi6AKzyKJX7wxaUm4ffRkgJtPd2iyK
 6yCZxw5ZU7Qqqji2Brcr5JpU2ZHxu09Y/iU1RIipsiVp4Rm3n3zq2yq25vW8ZmigNQBz
 AaPqI+zr2qzEd5h8kqn+wDBgJc3Pj35mDflYdutw2It0KzG/qtVTELZSS7nFaXAEenQe
 e61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736883288; x=1737488088;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lEAVTsD3mW1B4c0RJt4r1vd8knWdTadRzhqx/4/w6wE=;
 b=fR02auOM+mKA8BtOs1Hqf7Mwkm5MLPtaMp0CGQCvjsmSSntiXjWUk4A+2WP9sasEE1
 MUHUm1RfCG9cmTHWeHmNbqeK32UYDQOYb0JZyRsgiyemG9tkcRT4QPXxpwDHGY0danZV
 3E8mR4uAynadMpJfkDgQM6wXzBGyuFT2JdHwpW4m8ojb51tXE6vIKULQWUCAxlFGn/Do
 Nvyj/jRCK5VIaHuEnfl8/GLpH5EZL7draiwgPGpC4EHtf1GonRuaK+ymK6CDWnu2gwqN
 pYpj9wOOf3eiDE793wCJiSO7AaqKp/UUY0kBTchnrD33sat8LDslGxGcel5lMN3VdI19
 /oRA==
X-Gm-Message-State: AOJu0Yy2SySeaa9kMtUB2BNZEircSkBznyIUb1p98SIVwe7A6RCYKXz8
 6iY5zOV0jGQnpFUkFP+mSVfOs58XT5YUh6jpNwDNoNWoPns3BAkcY3ThKLUCXthvYQ4g5r5ziOp
 iFFrGjLHr4Kgep9wEz5zhxpANBrDwFOHIoa16E5g6Aqwg+huaQUI=
X-Gm-Gg: ASbGncumrKDre0oRTlh23ZUt4/fVzhCDDdYEhMgjv+1fkCOWx1G2S6vqAcnCr0r60jL
 PQK8rozG7LsTag8FCT6SSXOw6u9WRvrZAIzRLwg==
X-Google-Smtp-Source: AGHT+IE3VMaqxX+h6VQ9dJlUBYfu2Kr/SZk+yOzclX0WVpxrH3vOHfcQCynaxxeccvAE4Ir7lT2xQmru9ImOikongV0=
X-Received: by 2002:a05:690c:d96:b0:6ef:4fba:8143 with SMTP id
 00721157ae682-6f531248e71mr228095137b3.18.1736883288664; Tue, 14 Jan 2025
 11:34:48 -0800 (PST)
MIME-Version: 1.0
References: <20250101195817.995321-1-sjg@chromium.org>
 <CAC_iWjKUdqGkAEXyz0LobkCgF_oX9dC1xCzz2qEWXbuOhkg=Kw@mail.gmail.com>
 <CAFLszTh3bnjisKqnDUvRCip2wdL0hJr+EM40+SbQ76h_zgg7Kg@mail.gmail.com>
 <CAFLszTiXHKdf_QUUsWpQpwv69HSGPNknkDW4JHgRUfT0r_G-aA@mail.gmail.com>
 <CAC_iWj+PwT2JmrWwrTsmHt_mGKDdhGUQgXKvzi3SCNCFxgJNRw@mail.gmail.com>
 <CAFLszThXtZjgavkzKhHbSXahONLqpT7yEYBH3bQ_1qzS=AUx+Q@mail.gmail.com>
In-Reply-To: <CAFLszThXtZjgavkzKhHbSXahONLqpT7yEYBH3bQ_1qzS=AUx+Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 14 Jan 2025 21:34:12 +0200
X-Gm-Features: AbW1kva9cBX6EeZMuQNdLbODqC1fVZjjzULcmaorC8jPvEroKsC8EEx3jLjQqfA
Message-ID: <CAC_iWjK5gOn4Ad=orCMhv4BY74U4E6AoOLR6rnYYHd9=-X7wEg@mail.gmail.com>
Subject: Re: [PATCH] bloblist: Drop BSD license
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Tue, 14 Jan 2025 at 15:15, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Tue, 14 Jan 2025 at 01:40, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Fri, 10 Jan 2025 at 16:54, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi again Ilias,
> > >
> > > On Thu, 2 Jan 2025 at 18:41, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ilias,
> > > >
> > > > On Fri, 3 Jan 2025 at 08:15, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > >
> > > > > Apologies for the formatting, replying on mobile.
> > > > >
> > > > > On Wed, Jan 1, 2025, 21:58 Simon Glass <sjg@chromium.org> wrote:
> > > > >>
> > > > >> Linaro has decided to write their own version of bloblist from scratch,
> > > > >> so there is no point in having a non-GPL license on this file. Change
> > > > >> it, to better fit with the U-Boot project.
> > > > >
> > > > >
> > > > > Apart from the commit message being wrong, it's also intentionally provoking. There was no bloblist in TF-A.
> > > > >
> > > > > The TF-A code is implementing the firmware hand-off spec [0], which Linaro participated in the creation. The U-Boot implementation was adjusted to adhere to the same spec after the TF-A code was merged.
> > > >
> > > > The U-Boot series was [1], for reference. This was mostly about using
> > > > different tags and shrinking the headers. My clear understanding was
> > > > that we were going to try to have a single codebase, which is why I
> > > > changed the license.
> > > >
> > > > So, since you have a different view of events, why did Linaro write it
> > > > from scratch? Was it to avoid having U-Boot code in TF-A? Or was the
> > > > author just unaware of the original intention?
> >
> > I am not sure I am following 'from scratch'. Firmware handoff is a doc
> > describing a list. Raymond implemented it in U-Boot and TF-A.
>
> So in your mind, Raymond implemented it in U-Boot? Have you taken a
> look at 'git log' or 'git blame'?
>
> > The right way to do this is to move the firmware handoff code to a
> > library that can be used across projects.
>
> Not always. Probably not in this case. It has quite a bit of logic
> which depends on its environment. So I think it is better to have
> 'similar' code in several projects. Certainly, writing it from scratch
> (meaning not based on existing code) is not the best approach.
>
> >
> > > It isn't relevant for
> > > > the commit message, but if you can find out I would be interested.
> > >
> > > Just following up on this as I'm not sure of the status of this patch.
> > > Can you perhaps write your own commit message with your version of
> > > what Linaro has done?
> >
> > "The non-GPL license was inadvertently added, remove it". Raymond
> > wrote that code so I don't think he minds removing the extra license.
>
> Again, please check your assertion here. I for one am very surprised
> to hear that Raymond wrote the bloblist code :-)

All of the patches carry his co-developed by or his signed off by. A
big portion of those are sent by you as well

>
> But it does help to explain why you objected to my commit message.

The reason I object to the commit message is because it's
*intentionally* misleading.
The BSD-3 clause was added by you in 6c9e3d1fc0859 with the intention
of other projects using 'bloblist'.

The actual firmware handoff code was added much later in e266d2731145.
All of the patches in that series is co-developped by Raymond. Those
were added Wed Dec 27 while the TF-A patches were merged much much
earlier. commit 3ba2c15147c in TF-A was merged Tue Jul 25

/Ilias

>
> Regards,
> Simon
