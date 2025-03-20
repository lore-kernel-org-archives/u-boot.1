Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6114DC35FFF
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 03:43:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41B06819B1;
	Thu, 20 Mar 2025 04:43:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UwObSrep";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5475F81D27; Thu, 20 Mar 2025 04:43:53 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C094A81C84
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 04:43:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac298c8fa50so66201466b.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 20:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742442228; x=1743047028; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ecbFJeof4ApnLOrbzIzK3nRHO3LRF5flQtAX2c7nSaQ=;
 b=UwObSrepTovkcKlkUskcYK4xZqSnPJDRz64F7Vap/vRQd2Nw7o0PAf1GUGRGcmBthX
 fFNSVCveK4tz3yfx4MKpetNj0n3/oR+2SkHrEu8OMqVdy0yZVrllK3IHIks+n1NomWah
 2mvSvMzeE9YC5ESu01W6p6l0Bp2MPKP6Qg/I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742442228; x=1743047028;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ecbFJeof4ApnLOrbzIzK3nRHO3LRF5flQtAX2c7nSaQ=;
 b=QJEmXAUdNtK9em9TY0l8mIEnRvmSa0Ncg7lt3dzBHhzwYygG6mEUhveRVYFTk730CH
 nWhzP7KDeIDUa13bYgYMce23ltifdK+4SCnBKGYBuQaMIeZUG3XfvBVTZn5gMvhU4YnK
 aIyAuOiswm7qYSfQaA8e5sIng6gcrwB+xIaIURpQjBJXYgVPyYY6o5GAbBaqtfl0Z+kH
 RsFVOBeVWD/6rv1AcwiK9AMuWoV8cGDAjSKrPoKkuL+nH2ctVXbcsBitPhOQqqM5e3JR
 T4xCY1cU+k0TPS4fe2TSy7hmqUMm93viO+tUylXEzeB6TFReA846goFlny8J0O5WD2jv
 DnbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXApT0ST0QDXMWP7xt/7oRNtGe6unnFT6ynx3U9johLo5clOCPplRaM2OrNVQAg83uEeaLeRAU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/6UGvluLU5QnnnhTovrl170gUpG5B+ULYfumV7nKszEFG0FDy
 KzoH5xGt1UoiOtwgzVJ16pjGoCrH3xv5o9RyCq7LMm50GUV3BhCFH+17pODvW9k9vwY5u/b7jaY
 ZR8T/41sdUGIkEz0Bo0o2r/LstCgmEjVsbrMH
X-Gm-Gg: ASbGncsHZZxv/v936TwrpF2tIepL52gQtPC/v0hi9jDTuy7msXfH/Fet7ClW8CK8J3Q
 FKNIR+tT1abkxNNzr67edNP9o9/lABe5oKsS0S9HbdPPj6GhmYN0Mc32o0iOYx7xm5AnwMYuGOq
 HUlfPCmNUMCD0S/4huP6tHEYMbCT4=
X-Google-Smtp-Source: AGHT+IG9/+QtsFO66jamHb7xghh+7oEbl+cGRUxSvpuvBJcbnXFD0g5k9mmNTBoFNBp85npJOaPNBahwLbY0DwKFZf4=
X-Received: by 2002:a17:907:9487:b0:ac2:9c7d:e144 with SMTP id
 a640c23a62f3a-ac3b7f1d7efmr528509266b.40.1742442228156; Wed, 19 Mar 2025
 20:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-39-sjg@chromium.org>
 <20250318140400.GX2640854@bill-the-cat>
 <CAFLszTgCZSydxeNoeVGrR9SF7-_9pZjU+NBGXVDgXG6WzYyCYA@mail.gmail.com>
 <20250318155256.GA2640854@bill-the-cat>
 <CAFLszTjC47nk3FmEyHw13zaaWwdcEavk3JY5iewKWF65iVqHiA@mail.gmail.com>
 <20250319154047.GM2640854@bill-the-cat>
In-Reply-To: <20250319154047.GM2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Mar 2025 03:43:36 +0000
X-Gm-Features: AQ5f1JpF8aoFKhk_87wycxZLw9GenJPwz_3C81M9dH-8CJttbYXoxphYuEXfYwU
Message-ID: <CAFLszThVHKU+nZhmp5ysNxqTnLJ8AMX8E8eO2zvBhDQTZ5LYNw@mail.gmail.com>
Subject: Re: [PATCH v5 38/46] boot: Consider non-bootable partitions
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Bin Meng <bmeng.cn@gmail.com>, Guillaume La Roque <glaroque@baylibre.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Wed, 19 Mar 2025 at 16:40, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Mar 19, 2025 at 03:03:49PM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 18 Mar 2025 at 16:53, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Mar 18, 2025 at 03:24:02PM +0000, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 18 Mar 2025 at 15:04, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, Mar 15, 2025 at 02:25:58PM +0000, Simon Glass wrote:
> > > > >
> > > > > > Any 'bootable' flag in a DOS partition causes boostd to only scan
> > > > > > bootable partitions for that media. This can mean that extlinux.conf
> > > > > > files on the root disk are missed.
> > > > > >
> > > > > > Put this logic behind a flag and update the documentation.
> > > > > >
> > > > > > For now, the flag is enabled, to preserve existing behaviour. Future
> > > > > > work may provide a command (or some other mechanism) to control this.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >
> > > > > Isn't this backwards as the existing behavior (prior to bootstd) was to
> > > > > scan and use these files, and so that's the behavior we need to preserve
> > > > > by default.
> > > >
> > > > Not so far as I know, but I've already spent too much time trying to
> > > > decode those scripts.
> > > >
> > > > If you look at scan_dev_for_boot_part, that is what I was trying to
> > > > replicate with bootstd.
> > >
> > > The feedback from the community call where this was brought up was that
> > > it used to work and now didn't, I thought. Heinrich, I think you had one
> > > of the cases here (something about RISC-V and multiple distros?) or am I
> > > misremembering?
> >
> > OK let's see if Heinrich chimes in.
> >
> > Are there notes for the call? It would help me if they could all be in
> > a shared document, like we used to use[1].
>
> Yes, they're in email.

What subject should I search for to find them? I looked for 'community
call' and a few other things, but cannot find them.

Regards,
Simon
