Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249B0D6DDE1
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 13:37:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E017892CD;
	Fri, 15 Nov 2024 14:37:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H9CsuYmN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 329C489326; Fri, 15 Nov 2024 14:37:33 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCD5289266
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 14:37:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5cf9cd111ecso354072a12.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731677850; x=1732282650; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VVCteZcVUZ7e0Wx4ZCrsiOz0qq4qY5KhAEKlvIdNKCQ=;
 b=H9CsuYmNriDMZvi2pY8heW4fJ/7oOop4PlDsDn1OU4dqeytGaQxXjly33wRfAe/8BR
 8ZIHa6ObYum+pCdGuKxt11iQtUNFuxb1Dq7YqvABHhXAMtnLd/ANlXR/+3mpeqZmnw8c
 2jyqMZL4KBvDVa3MfcV3MtRBYJuTvbNfao/M8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731677850; x=1732282650;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VVCteZcVUZ7e0Wx4ZCrsiOz0qq4qY5KhAEKlvIdNKCQ=;
 b=D+6U+NeMMlRT1FdSoAlI5p2ubzA+Za575khyfO7RNFxHk9poHIKGlCxLEb3uRJ7FpT
 HzGaG9d/6b92SK2QoU+fFAF5BGGzThT+8IeaVbdKkrkhq6B/MoHESM2NuFeu+PXDJPvZ
 M+ZB0GUcirORljhd+FHN4JJ9So6lBoHg6YSNwl07534++5hQYDo//eMgde3I4pU5+CqQ
 zpQZaniUJIHqgLY+HwDIfki+CfiXeWYIMtE4AT+gpn+Wz9p7cEqiSt2cdg29nmvRYahG
 /KIC7def1y7qDzQjMRnA6/xlnkMW9+g4b5OVJZ1RhPe9KCzVbu9I+F92sYTG1shW19d1
 FetA==
X-Gm-Message-State: AOJu0YzUZ4tICxBXKZMlcT1JS0BUnafExR6rmyf56FlQRlIG/5bUjze9
 3MJ4EJwMsUNBlIE+rvvOdIRhnH2hoB84RRdsa81YMmu9qKLhwMAK/lShen/OZQ3LS01eyafwOxu
 qdXlO/jmXPZD64NRKF//vmi/ZB0rcwpryJgA6m5L7lTCAW3+SCA==
X-Google-Smtp-Source: AGHT+IFgx842gpUIL/YEQL9FLAT0gin8RyxSdoMj2CoEiPQyVHg1RCeNJdQoc1AfX0fbhGDTMCv/TTZHyTHmpLgMrgM=
X-Received: by 2002:a17:907:96a4:b0:a9a:9df:5580 with SMTP id
 a640c23a62f3a-aa4834276f6mr245603866b.19.1731677850180; Fri, 15 Nov 2024
 05:37:30 -0800 (PST)
MIME-Version: 1.0
References: <20241108152350.3686274-1-sjg@chromium.org>
 <20241108152350.3686274-9-sjg@chromium.org>
 <20241113024029.GH3600562@bill-the-cat>
 <CAFLszTirek2=_j15W5LCZERTs2TZXawV0o3aGO12dgDJpzTdQw@mail.gmail.com>
 <20241113222016.GZ3600562@bill-the-cat>
In-Reply-To: <20241113222016.GZ3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Nov 2024 06:37:18 -0700
Message-ID: <CAFLszTivnmnB+1p58sZ_VSZBWpL1Kt7QJ=mnnEvHZswAeEZc0g@mail.gmail.com>
Subject: Re: [PATCH 8/9] buildman: Propose a format for extra boards
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Wed, 13 Nov 2024 at 15:20, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Nov 13, 2024 at 09:03:35AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 12 Nov 2024 at 19:40, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Nov 08, 2024 at 08:23:49AM -0700, Simon Glass wrote:
> > >
> > > > It has become more common to use config fragments to extend or adjust
> > > > the functionality of boards in U-Boot.
> > > >
> > > > Propose a format for how to deal with this. It is not implemented as
> > > > yet.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > I think that the first problem is that this patch series is an
> > > inappropriate method and place to start the discussion.
> >
> > We had a discussion a year ago but it trailed off.
>
> OK. Still an inappropriate place to resurrect it.

What do you suggest? I am trying to solve the problem, not just talk
about it, so patches are often best for that.

>
> > > I also think this gets things backwards as the common case is "make",
> > > not "buildman". We need more defconfig's that are just base +
> > > fragment(s) if they're important enough to be a combination that needs
> > > to be tested and work. A board is not a time-expensive part of CI. A
> > > pytest run is, a new job itself is.
> >
> > OK, that would work too. It would also avoid the problem of combinatorial
> > explosion. But I am not seeing people actually doing that, with rare
> > exceptions.
>
> I think it's the exception, not the rule, where config fragments are not
> being put to use in a defconfig. And that's possibly because not a lot
> of people seem to know about the #include option, and then when I
> explain it exists to people the next problem is "Oh, I have to do what
> so that buildman also works?".

Are you looking for any feature in Buildman for this? This series is
intended to fix [1]

Regards,
Simon

[1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/30
