Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F10C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 12:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FA9380EEF;
	Sat, 15 Feb 2025 13:06:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bg/JZ+cc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1364E80EFB; Sat, 15 Feb 2025 13:06:37 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACBBA80B98
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 13:06:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ab7cb1154abso397119066b.0
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739621194; x=1740225994; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=etkV20DHqGDl3ctXty8iFwyqn/ktCPjHoZRQXFOWE2E=;
 b=bg/JZ+ccdeKKMtt8o6hySmrGu3g7ayguD10qeHLzDds3QTrxRSzWzLJTGLuTyWgnEr
 VjLcu4uQxcsZq9+ixKKuHY85IaK4eairkPAGEW1hO0jr8ZqLPeS0vIxPWIv3chNuh/yw
 3pemnK3sqZUq4iQvhq0dyJDzU/xrttMoUW3xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739621194; x=1740225994;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=etkV20DHqGDl3ctXty8iFwyqn/ktCPjHoZRQXFOWE2E=;
 b=X31HvvBKIRZI3g3Rs8fqW8A/XPZHRfy9HfrpPw+mpN6PTHtPw/kRC4O7jMl5zaKEiM
 dDGVsY9kUOw3pi6r/Emq3bGs1OaYrPvS7aBSU2pMlMFumjGYFtVvVitBtvZPBPrU4CAl
 fopbj5JkT+IwatDZvEOmfGmMg+vVPWCmppY+bKuVweNwWd63UFyK/lgeXTpZoL95rmHr
 YpFD+9p22eHtLlnpM/d+uH97P2U1gRm7+8KRaOfQ6EnM4Vb2xp+KbE2edCKkCKQmuuXq
 /UY3qls5jcaTCuyIcTAs1Yz8IAb/LR5PYPzgEBaJcAbzAx0GAIO9A92iYl9ANMJtgRd/
 0DYA==
X-Gm-Message-State: AOJu0YzES0OVcOFj3Yk1jCGxCQb/C0U9cXrAKJWkXJUnXR0mVYHpGzgH
 F5K+Uhxrm+ERYbOx07OG1XMliLN65r8DRBudRDUr2VcIokvsHrb7VanPD/4j3U3aV25E4NfmAL4
 279Wy8bmjd2tutxJ+xs2owxlPkZMRfyRkRX1d
X-Gm-Gg: ASbGnctLVxdcveeY7XrSkyD2tDjxuyN66jpIa5yRigeXvl992niAAGn1tE+Cjt5AA+z
 tyqJZRFD2MJmfM9HbsXGIfymk6MI1txxCiGFuIJJdDYIp3TFa1QU7v9h4DTad8fyquknacpKWLQ
 ==
X-Google-Smtp-Source: AGHT+IHEecX/nhxKAmoE21fKtyakjtAfFiSMmbEJTKKr0x+h4K+lwCOgGD+gqzwFl2aFXn87sLntewsIB6VrnHqbPRg=
X-Received: by 2002:a05:6402:2089:b0:5de:d98c:3b4e with SMTP id
 4fb4d7f45d1cf-5e03613a297mr6663546a12.21.1739621194186; Sat, 15 Feb 2025
 04:06:34 -0800 (PST)
MIME-Version: 1.0
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-34-sjg@chromium.org>
 <20250210143305.GA1233568@bill-the-cat>
 <CAFLszTgc2GsN-O_7aq+pC_0xeJQjh-qa7EAnN1i3djp0ZO5g-w@mail.gmail.com>
 <20250211135944.GZ1233568@bill-the-cat>
In-Reply-To: <20250211135944.GZ1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 05:06:22 -0700
X-Gm-Features: AWEUYZn3_iOohux66rKePasLKcqmzXAOL-qtvmsVkDcYjdVYHM7EvWu4VNO3zno
Message-ID: <CAFLszThU+r-F_OUSM2rWVScfvgBTSCjDzxrYi5iBaBh7WNqHKQ@mail.gmail.com>
Subject: Re: [PATCH v2 33/35] RFC: Revert "bloblist: Load the bloblist from
 the previous loader"
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
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

On Tue, 11 Feb 2025 at 06:59, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Feb 11, 2025 at 06:10:54AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 10 Feb 2025 at 07:33, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Feb 09, 2025 at 02:14:54PM -0700, Simon Glass wrote:
> > >
> > > > The logic of this has become too confusing.
> > > >
> > > > The primary issue with the patch is that U-Boot needs to set up a
> > > > bloblist in the first phase where BLOBLIST is enabled. Subsequent
> > > > phases can then use that bloblist.
> > > >
> > > > But the first phase of U-Boot cannot assume that one exists.
> > > >
> > > > Reverting this commit seems like a better starting point for getting
> > > > things working for all use-cases.
> > > >
> > > > Note: The work to tidy this up is apparently underway. For this series,
> > > > a revert is the easiest path.
> > > >
> > > > This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
> > > >
> > > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  common/bloblist.c  | 64 ++++++++++++++--------------------------------
> > > >  include/bloblist.h | 10 --------
> > > >  2 files changed, 19 insertions(+), 55 deletions(-)
> > >
> > > We aren't reverting this change so if you plan to move this series out of
> > > your downstream fork you should start from that and stop posting it,
> > > that just leads to confusion.
> >
> > Who is 'we', and start from what?
>
> We, being the community, in here, the community mainline U-Boot project
> tree.
>
> > My goal with this series is to have something that actually boots on a
> > real board, so the bloblist changes are needed for that, particularly
> > as the 'vbe' board in the lab tests this on the hardware. I
> > deliberately put these two patches at the end of the series so you can
> > ignore them if you'd like.
> >
> > But for now, as I understand it, there are no users of standard
> > passage in tree, so actually it would be fine to apply them.
>
> And you can ignore all the feedback you like for your downstream fork,
> sure.
>
> Part of the feedback in this series already was "Yes, we can clean this
> up a bit more if bloblist will do its own thing instead".

So I see that Raymond's patch is a significant rewrite of what is
there today, with multiple aims and changes. I would rather add my
revert and start from a cleaner place.

- Simon
