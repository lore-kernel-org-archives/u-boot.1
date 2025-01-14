Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88021E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 13:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F72A805CD;
	Tue, 14 Jan 2025 14:15:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h7ZVQ9Oz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19F7E80657; Tue, 14 Jan 2025 14:15:09 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07C958022E
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 14:15:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d647d5df90so9213125a12.2
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 05:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736860506; x=1737465306; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=evEDUKwZzh5CsbUiafYtcWy9N/LieO4NpgDy/C5e3rw=;
 b=h7ZVQ9OzdKfOtfg1zBkwxOBOOSZfoqKFz6dRBAOsuXIf231me8Ng4YsEyMzZfh2zHw
 a+CJSA4nDJcPAcE5LNOgIezMivImWAcO8GpS+am1SXTNFWy8w9PlYZhFXf8XH+6xH+gl
 LxG3Vz9P6C/162SrSZeq6tubhKSXygox07//o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736860506; x=1737465306;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=evEDUKwZzh5CsbUiafYtcWy9N/LieO4NpgDy/C5e3rw=;
 b=NfKz9NE6gMgvpjz2ObTFpdYezoTGk1MRbhPS/lmgK3ABkZnWjwjipQb5cxS4c9Gtbs
 q2k5hG/6TKHBl0Fz7vDm5knjonLliMFmF8F2zafyknVzBFg9izjnJ8DbpMGMKOJy4VKZ
 I5vc8PkjssUz2WzLWmLnqYii/z0tS4XVoZCZ1ewmCSHQhW17S9hmKTSu8K9KVnt6MXTA
 dVmtRENG5qGxA5Mse5LMCmdVASp2eqczLPqJ24j45j5tsBknLONX6NwjfdBC+oxSDEqg
 32Vb8PF4yP3xJdpHQZsUm58/k3/mQuoH6S+PfTs/59Cq83nwCusPnhGiyAhwq4Y/KELo
 njZA==
X-Gm-Message-State: AOJu0YwhccenX4Z9qOHOh9ZEk01Fw10KuUXyNMZiX/HDQDFZE1bF4T2g
 hybriabmEYYEGIZAQ7lTSZUKuh2+MfQpqsRg7ZR14hsiUpi4EGqIBmbY03RqWDmKSkvd5rE4SlW
 m2Feuu+yAQga9q0xsErQGR29t//X+33gkOsoP
X-Gm-Gg: ASbGncu8YEcHf31Fg+XFa8auE9uJcoa7xMCBW5AwhhCLm33cnlIu9JREfOB1T/88gbg
 7/EHXRy90khtoGgbzp9X3dTiqBU5bqks7FoQgS2A=
X-Google-Smtp-Source: AGHT+IHlV561IO+JKbZvNEsUudeinovD2C50l549hAFtxYJzhQrO3ZNatQIc+CSuQ2KogN6aRbCaTZz6abhdinfrTVU=
X-Received: by 2002:a17:907:c0d:b0:aaf:1183:ec2c with SMTP id
 a640c23a62f3a-ab2ab6bfc89mr2055445666b.5.1736860506463; Tue, 14 Jan 2025
 05:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20250101195817.995321-1-sjg@chromium.org>
 <CAC_iWjKUdqGkAEXyz0LobkCgF_oX9dC1xCzz2qEWXbuOhkg=Kw@mail.gmail.com>
 <CAFLszTh3bnjisKqnDUvRCip2wdL0hJr+EM40+SbQ76h_zgg7Kg@mail.gmail.com>
 <CAFLszTiXHKdf_QUUsWpQpwv69HSGPNknkDW4JHgRUfT0r_G-aA@mail.gmail.com>
 <CAC_iWj+PwT2JmrWwrTsmHt_mGKDdhGUQgXKvzi3SCNCFxgJNRw@mail.gmail.com>
In-Reply-To: <CAC_iWj+PwT2JmrWwrTsmHt_mGKDdhGUQgXKvzi3SCNCFxgJNRw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Jan 2025 06:14:55 -0700
X-Gm-Features: AbW1kvYQbwxwNfI_Dtv2zNwekZPNXQhuvMh8JoObRCzrh5fSGWycFYQs5damKzc
Message-ID: <CAFLszThXtZjgavkzKhHbSXahONLqpT7yEYBH3bQ_1qzS=AUx+Q@mail.gmail.com>
Subject: Re: [PATCH] bloblist: Drop BSD license
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Tue, 14 Jan 2025 at 01:40, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Fri, 10 Jan 2025 at 16:54, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi again Ilias,
> >
> > On Thu, 2 Jan 2025 at 18:41, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Fri, 3 Jan 2025 at 08:15, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > >
> > > > Apologies for the formatting, replying on mobile.
> > > >
> > > > On Wed, Jan 1, 2025, 21:58 Simon Glass <sjg@chromium.org> wrote:
> > > >>
> > > >> Linaro has decided to write their own version of bloblist from scratch,
> > > >> so there is no point in having a non-GPL license on this file. Change
> > > >> it, to better fit with the U-Boot project.
> > > >
> > > >
> > > > Apart from the commit message being wrong, it's also intentionally provoking. There was no bloblist in TF-A.
> > > >
> > > > The TF-A code is implementing the firmware hand-off spec [0], which Linaro participated in the creation. The U-Boot implementation was adjusted to adhere to the same spec after the TF-A code was merged.
> > >
> > > The U-Boot series was [1], for reference. This was mostly about using
> > > different tags and shrinking the headers. My clear understanding was
> > > that we were going to try to have a single codebase, which is why I
> > > changed the license.
> > >
> > > So, since you have a different view of events, why did Linaro write it
> > > from scratch? Was it to avoid having U-Boot code in TF-A? Or was the
> > > author just unaware of the original intention?
>
> I am not sure I am following 'from scratch'. Firmware handoff is a doc
> describing a list. Raymond implemented it in U-Boot and TF-A.

So in your mind, Raymond implemented it in U-Boot? Have you taken a
look at 'git log' or 'git blame'?

> The right way to do this is to move the firmware handoff code to a
> library that can be used across projects.

Not always. Probably not in this case. It has quite a bit of logic
which depends on its environment. So I think it is better to have
'similar' code in several projects. Certainly, writing it from scratch
(meaning not based on existing code) is not the best approach.

>
> > It isn't relevant for
> > > the commit message, but if you can find out I would be interested.
> >
> > Just following up on this as I'm not sure of the status of this patch.
> > Can you perhaps write your own commit message with your version of
> > what Linaro has done?
>
> "The non-GPL license was inadvertently added, remove it". Raymond
> wrote that code so I don't think he minds removing the extra license.

Again, please check your assertion here. I for one am very surprised
to hear that Raymond wrote the bloblist code :-)

But it does help to explain why you objected to my commit message.

Regards,
Simon
