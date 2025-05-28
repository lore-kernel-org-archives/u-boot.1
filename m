Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB04EC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 15:00:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDFA183010;
	Wed, 28 May 2025 17:00:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D00oEl5c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDC7383238; Wed, 28 May 2025 17:00:29 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C5AA82A8D
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 17:00:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-708d90aa8f9so39851797b3.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 08:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748444425; x=1749049225; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DZmbOgkzZSGSgSJBBsd4RuYF21HY3sBZAlz3HLDyXKw=;
 b=D00oEl5coHPyCXwxk+CkqlthwX2W+KJpfwv/PgkapaM1XD2qremcmglSoN8WoeWmCy
 5gmIsj1Ow3FUd+gJwVEgSh9R6JDi6Zye9UPA3A3JP/ppWjuXMKXDB+LkAVjQ8Qqi23s2
 G4RT09/MkDtiT8L0ZG2oGzbyn+PkPM4Uva6AfDr8nNIyNfxTiB+vyAFLm3DO1zZMMujk
 dJY8Die1kqmFeLIYTSK2t358Q0r+I72V0+ayAy30rcZtN/mQML2fa6ICYP9gvdPuw5sI
 QQD65LLBp+LjLL0sGCTi1yd/dyjXoM+1tEBhDrxLfg8zKa3I/Ip3vf/PJz3zpn/vkXjn
 bEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748444425; x=1749049225;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DZmbOgkzZSGSgSJBBsd4RuYF21HY3sBZAlz3HLDyXKw=;
 b=bcSoZ2Fd9IL2zEMCatubUkAwo9/sUP1XK0ICeL+lr/OHS6IR0dFZxL4h2ylzT1dJfw
 ShyfMeyWk8jRFRY7F5qPnDkU/iESFZsduap2NAD7olXcmdH9hmqDk3B6Ax1Ej13xXG+I
 kpxespymk9eJHPOxF4/Z6o/kZpDn8/5y0oobakkCUZcCQjrfsDHdy6sUZfl1aDVk6y38
 mIBWIRBLl4qtQbqYLp+VAsEXMNiD5Wts0LIAH/Opf4zmHZ5BpCBocjoGE9IB9vjZ+koU
 fBNlotDCI5johmdFgmhUX/q0achJw/4UnnfaCIjdYSzonTpsOHn7kci/x0zktJ9Hk7w0
 6esw==
X-Gm-Message-State: AOJu0YwFxRo3Th2Lu5XW+FNeGBW7w+7cDSZRPY/KmQfkkSA1tYYyR2aJ
 By7ZiANPM9Vay0L83uo+6ILjK7/UDhzqZd8HWQo9PJFCXh0UZ8UJflLH0iNbPtqSHS967/BuXD0
 33ChwplhWAtKnVqILPmKUwsSnUjs5XjIE2u1z6WWqgPQKK0AKPXBuUfo=
X-Gm-Gg: ASbGnctjNkWXybig4djj1hDLblgoxXgrQ01nIiPwIHHcdpYlZE5OVsCYWtitda7ZMaW
 PbsApZyj9lirMfkZvLQxDlO0yfvOOoPqh37jAox3p4C4QIfAkcctQPU6IQuJafeJut/hW10v3Rc
 Xgv/6B+h3DHsTn0K/dM5HVxt6+6inhdjKeqw==
X-Google-Smtp-Source: AGHT+IEUE3VQYNvyqof++1NmxsSOUBaOdKijGwaUO5hogUnlmyFNwIs690qLP9odoGh7XPOI1bOIF4Xrrw2lTIoikYs=
X-Received: by 2002:a05:690c:4d4a:b0:70e:7706:8250 with SMTP id
 00721157ae682-70e77068290mr109468627b3.16.1748444424293; Wed, 28 May 2025
 08:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250524120904.684977-1-sjg@chromium.org>
 <CAC_iWj+XfkWPj+R1JUc0ZPFatRtpMso-Lw+uYzcgcbuKPuV3Dw@mail.gmail.com>
 <CAFLszTho++gscP4rUUY354iyVWFyPkZeMCpa-TpX0GaWOQzQvw@mail.gmail.com>
 <CAC_iWjKjZ-Q_hreO1Z64AFBWXOHB_YB_+Au_9psecVO+ATE_Pw@mail.gmail.com>
 <CAFLszTi7M335=whLPav5P4+mhunAvs4eue780_eJZNjEG_+YAg@mail.gmail.com>
In-Reply-To: <CAFLszTi7M335=whLPav5P4+mhunAvs4eue780_eJZNjEG_+YAg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 28 May 2025 17:59:47 +0300
X-Gm-Features: AX0GCFstc5OTXLLW1Kk2mxFrzTPE56ZhEY2uEX_PJC0RsM_DnuNoYR-VB4zItYM
Message-ID: <CAC_iWjLQEtWtAh-onfq9z-3nxnzwBcAok9urh-P2F+Pxp0MosA@mail.gmail.com>
Subject: Re: [PATCH 0/3] efi_loader: Move the public cerificate back to the
 devicetree
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>, 
 Prasad Kummari <prasad.kummari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <cfsworks@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>, 
 Tom Rini <trini@konsulko.com>
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

[...]
> >
> > It is, as it is for every firmware that builds out there. EDKII does
> > the same thing.
>
> I mean that in U-Boot's case it is a published and documented
> interface, or was until a few weeks ago.

And interfaces are there to change if needed, not to mention various
people have stated it's an obvious violation of the DT spec.
This doesn't break any forward or backwards compatibility, so I really
don't see the point of tthis.

>
> >
> > >  It is how U-Boot works,
> > > so if a build systems wants to inject a key it should use that
> > > mechanism, not add a new mechanism into U-Boot's build system. If it
> > > would help to have some documentation somewhere which says this, I
> > > would be happy to send a patch to add something
> > > - QEMU is blocked from accepting devicetree additions due to another
> > > Linaro employee's refusal to accept a patch[2]
> >
> > It's not blocked. It has been NAK'ed and IMHO for a very good reason.
> >
> > >
> > > > (which btw wasn't 'rejected', you
> > > > forcefully reverted it back then with no agreements from anyone)
> > >
> > > The original series [4] was applied (I believe accidentally) against
> > > my objections. Heinrich pulled the revert [5]. I went ahead and did
> > > the QEMU patch, to help with your issue*.
> >
> > Heinrich applied the patches initially, and you send the revert, that
> > none of the patch reviewers ack'ed.
> > You reasoning back then is that the RO functionality was moot, because
> > we didn't have it. It's here now.
>
> That was one aspect of my reasoning, but of course we can copy the
> signature into protected memory, make the devicetree readonly, etc. if
> desired.

But you still haven't responded on what we will do if a previous
loader hands us the DT not to mention that making the DT RO is not
really doable easily, with all the code we have for fixing it up in
random stages.

>
> >
> > >
> > > > and
> > > > why we prefer to do it this way. tl;dr early boot loaders that pass as
> > > > a DT is a problem now.
> > > > If there's a good reason to revert it, please explain it on the commit message
> > >
> > > The reasoning hasn't changed from the discussion three years ago -
> > > please see [4]. There's also lots of discussion on your original
> > > series and my revert, e.g the cover letter. A highly relevant part of
> > > this is that devicetree is where config should be stored, so the build
> > > system has control over what is placed there.
> > >
> > > But in any case, it isn't right to send the series again, under a
> > > different name, e.g. not mentioning device tree.
> > >
> > > [..]
> > >
> > > Regards,
> > > Simon
> > >
> > > * The QEMU patch is still outstanding after three years. Could you
> > > please talk to Peter Maydell and see if you can get this resolved? I
> > > have sent it twice since, most recently in April [7] but there was not
> > > even a reply.
> >
> > Because they NAK'ed it a few years ago, and aren't willing to take it.
> > I don't think there's anything to discuss and for the record I agree
> > with the QEMU maintainers on this.
>
> Yes, I agree that discussion is unlikely to be fruitful. My point
> remains though that your series should not have been applied, given
> the previous discussion.

There are people that agreed and tested it and you are the only one
still objecting and imho for non-valid reasons.
Anyway, unless there's a very good reason to revert this, i much
prefer it over what we had.

Thanks
/Ilias

>
> This thread and the links should provide context for the future, if needed.
>
> One other thing I forgot for the record is that [8] and [9] are only
> needed due to Linaro's refusal to accept the QEMU patch or propose a
> convenient alternative.
>
> For now I've applied this series to my tree.
>
> Regards,
> Simon
>
> > > [1] https://patchwork.ozlabs.org/project/uboot/patch/20250401112729.2181793-1-ilias.apalodimas@linaro.org/
> > > [2] https://patchwork.kernel.org/project/qemu-devel/patch/20210926183410.256484-1-sjg@chromium.org/#24481799
> > > [3] https://lore.kernel.org/u-boot/CAPnjgZ2uM=n8Qo-a=DUkx5VW5Bzp5Xy8=Wgmrw8ESqUBK00YJQ@mail.gmail.com/
> > > [4] https://patchwork.ozlabs.org/project/uboot/list/?series=253693&state=*&archive=both
> > > [5] https://patchwork.ozlabs.org/project/uboot/cover/20210802144431.2396678-1-sjg@chromium.org/
> > > [6] https://patchwork.kernel.org/project/qemu-devel/patch/20250405191352.2597585-1-sjg@chromium.org/
> > > [7] https://patchwork.kernel.org/project/qemu-devel/patch/20250405191352.2597585-1-sjg@chromium.org/
> [8] https://lore.kernel.org/u-boot/20250510134253.1581164-2-sjg@chromium.org/
> [9] https://docs.u-boot.org/en/latest/develop/devicetree/dt_qemu.html
