Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358D9C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 17:23:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B597580C83;
	Sat, 15 Feb 2025 18:23:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="izuNsd3J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2488580077; Sat, 15 Feb 2025 18:23:20 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1144C80F0B
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 18:23:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5dec996069aso5574845a12.2
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 09:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739640197; x=1740244997; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gVC3rIoXtmHsAj+z05vNkOBd9paz4x7+rMXj7voN26M=;
 b=izuNsd3JRjgdILwGnZXd2I3TERle4h1UnBiYURZQLeiseNoq30ziPVZ4Y+x/HKjNn/
 isOu59SrGx9tX+WAz7Nhwajvaikgpj7jOOLYRRiefxPh4YJE8Ug6NFceEDHu5Bsj4Z0g
 Zgxd1Z5JEhrEOuldd4rruueZ6z0rJx4XsCr/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739640197; x=1740244997;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gVC3rIoXtmHsAj+z05vNkOBd9paz4x7+rMXj7voN26M=;
 b=t45ghTgNUf1R8OKrJomBzaHNxW45+t+ogV2Ik1b7YT9NBG7ktzaFu0dY0IzYy3/dBg
 Kau1O3puVYTol2gAuZaxOyWJ96NgWzwiRBdFt+DWODY/d7V9IZoJy4je1VyEvkC3DgmL
 fnw2cScZVQP8wLv7BUZao4o7ZT3H/DPRhE4hYhgwJ1MidJNb4JeBqm+QodsD8tO0CfQR
 Qgst51oEd57yp2w2qQTxcRyj5ZsOUweEKQJEj0AOwzi8rU+m3ZDicG/Mr1Sj6a9bCUY1
 4suLUhGwyJ/izIc+9k5dxPpiEouRw68zLHWrh316n67e09Afj/7Yl04Lsfq3tS78IWac
 Bm6g==
X-Gm-Message-State: AOJu0YxX7kJzZ5h+IdCBGSdNX7mvxS3hCWKWAhOkv+wVZ9ccgnmwwAOu
 18b1kGCFZup5ud3FYCSaU7+c7P8DAMap+PYI3qJP9E2EgUyv/8VdGt/tyVX0pxvc2DhZWAkvIIA
 s0XZ3qiZ+GXAkZ5T5ZX9bn2gDG4ZLJA8bf/LL
X-Gm-Gg: ASbGnctZI55lxHjfVd5chTIHOwgx1vnlxGxafikimqQHBwJUfQifQrp52JyLZ30qFz0
 Z/zZtkbXzQFRkfR1JE/8cIyC1t3KPAwy2cmWOOM2ljPYHddAFMKrTD+hiX18I+lnDtzhWYw81QA
 ==
X-Google-Smtp-Source: AGHT+IEfrVninxaKw1jOVJNvo9n/kv/H9WKDJbeOtxnP89scVQfrTwvBm/srnZQPS5HusPUOgHyTZhyz7LAsv9pTjs0=
X-Received: by 2002:a17:906:6a03:b0:ab7:b2a7:9cb8 with SMTP id
 a640c23a62f3a-abb70c79d3emr340996966b.15.1739640197428; Sat, 15 Feb 2025
 09:23:17 -0800 (PST)
MIME-Version: 1.0
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-36-sjg@chromium.org>
 <20250210143312.GB1233568@bill-the-cat>
 <CAFLszTiX-rNzEmrLOZ4PMMa9m3fHiLkchbJ=xtGh3RpZLmZ6Cw@mail.gmail.com>
 <20250211140755.GA1233568@bill-the-cat>
 <CAFLszTj+LnHXX5E1Yh8hqzu_uc2c1HeyzqCxOdAUu1XQBO0W0g@mail.gmail.com>
 <20250215145923.GR1233568@bill-the-cat>
In-Reply-To: <20250215145923.GR1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 10:23:05 -0700
X-Gm-Features: AWEUYZky46ggQMPo2cj9ZwUKg2blaWNgI9F46zUX9VAXdIMpQecOBzMp7BXuJxs
Message-ID: <CAFLszThHkXtvRCUYvBRBkfx_Tabb6wQ8mExFmLPNWrWXE3fsAg@mail.gmail.com>
Subject: Re: [PATCH v2 35/35] bloblist: Allow using a different bloblist
 address
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alex Shumsky <alexthreed@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>, 
 Levi Yun <yeoreum.yun@arm.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Stefan Roese <sr@denx.de>
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

On Sat, 15 Feb 2025 at 07:59, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Feb 15, 2025 at 04:58:24AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 11 Feb 2025 at 07:08, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Feb 11, 2025 at 06:09:03AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 10 Feb 2025 at 07:33, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sun, Feb 09, 2025 at 02:14:56PM -0700, Simon Glass wrote:
> > > > >
> > > > > > Where the bloblist is located in internal memory and TF-A's BL31 blob
> > > > > > removes access to this memory, the best option seems to be to relocate
> > > > > > the bloblist just before running TF-A.
> > > > > >
> > > > > > We can do the relocation in board-specific code, but need an option to
> > > > > > pick up the correct address within U-Boot proper.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > Changes in v2:
> > > > > > - Move the actual relocation code to a previous board-specific patch
> > > > > >
> > > > > >  common/Kconfig    | 20 ++++++++++++++++++++
> > > > > >  common/bloblist.c | 15 ++++++++++++++-
> > > > > >  2 files changed, 34 insertions(+), 1 deletion(-)
> > > > >
> > > > > I'm going to NAK this whole concept. The whole nightmare thread about
> > > > > these platforms comes from using a fixed address. We need to pass in a
> > > > > bloblist or see that one is not passed to us, via register. And then use
> > > > > that mechanism to pass the bloblist to the next phase. When we don't
> > > > > have a bloblist passed to us, we allocate one, and not at a fixed
> > > > > location.
> > > >
> > > > Well I understand that Linaro may be doing some work to head in that
> > > > direction.
> > >
> > > Are they? I don't know. I know Raymond was doing some clean up based on
> > > the idea of treating bloblist and standard passage as two separate
> > > things. Which I think is a terrible idea, despite suggesting it. But I
> > > think it's also the only way to make progress now that you've decided
> > > you can't work with them anymore.
> >
> > Can't work with who? Linaro? If you don't allow me to create patches
> > for bloblist within your tree, what am I to do?
> >
> > >
> > > > The 'piror-stage' stuff is what has made this all too hard and
> > > > confusing. We should think of things from a U-Boot perspective and
> > > > make that work. The new case can be handled by standard passage, along
> > > > the lines that Raymond suggested, i.e. just checking for it first.
> > > >
> > > > For x86 we don't need this path as there is no bloblist in TPL, i.e.
> > > > it can be placed in DRAM from the start.
> > >
> > > A fixed address is a bad API for the U-Boot case and is what makes this
> > > all so confusing. And no, we can't put it in DRAM on x86 either, that's
> > > what had coral broke until I put it back in CAR.
> > >
> > > Please explain why a fixed address is a better API than passing a known
> > > valid location via register, for the U-Boot case. I don't like it
> > > because it means that we cannot always safely check if it exists.
> > >
> > > --
> > > Tom
> >
> > Yes I would rather pass the location via register using standard
> > passage, at least on ARM, where we have a suitable protocol. For now
> > this is the only way for me to provide a series where VBE actually
> > works in the lab.
>
> I don't understand why you don't just add what U-Boot is missing then
> for passage via register.

It's too difficult for me, with all the prior-stage and OF_BLOBLIST arguments.

Regards,
Simon
