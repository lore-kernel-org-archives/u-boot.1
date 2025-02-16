Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3250EC02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 14:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4CDF80F18;
	Sun, 16 Feb 2025 15:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iI+8s95F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3DB980F12; Sun, 16 Feb 2025 15:10:42 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7468D808B6
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 15:10:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ab7ee6f54faso415366266b.2
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 06:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739715040; x=1740319840; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=83STfA3OcGyXKVuUmbifdu234ldE/sMpeWT8Fqd2xVU=;
 b=iI+8s95FdF/T9Tr6F6thD3gxrPyWslw3/bAVytUVWXRZUq3OjgqV5KbPKYW6IQ6Upy
 Fiu+G66Mk18r126fA+lDrg7Fg9OGily1L57yRLZsBUtiEtq7u/sejPM2mn7/WPf4hEMk
 Am9VaIWXZIGQE/nsTemhwCLJr0aa5uSTD5e40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739715040; x=1740319840;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=83STfA3OcGyXKVuUmbifdu234ldE/sMpeWT8Fqd2xVU=;
 b=bALNMZ0cClt2I2Fz/0Ugl5QZIf5cPDyxH4Oomy7HeNQVpyWi5E56lG/Wqos83qKrpa
 JSEPN9zK4Tnr9G3NPn3fh0JqZlTyxz91i40tFIfMM9BaQl5Z73wwNzv7C06xYrzMHZse
 XZn2395fwpkH7RSkdLVYhWk7sXDOILjRVSI/RzkxCvLWDIX72GMfudRea492NcyG5flC
 MiuBHOwkrmnfmZOVeTW06PrO5cTopOgy499itU9YNmq5RFTkvWZ3ipawRxM95s6FgNIU
 Ud052EIwTqsSLoAGEaNiqYdntEGjKJrFPo+zjq4JOogyIcJVPQc7dZgP8TTASEDm6iWA
 r4VQ==
X-Gm-Message-State: AOJu0YwAUdvWCxjQ7cfiHGZPQbtAUSOHwSNkYb7VFOY7AmmbsrQZvO16
 xv9f0IUMxS6iAPTQP1Lg5TOEtE1XmWyysCIvNmaYMGAhHOJOyjPV8qcB3XAjfuru37pR5SfyhOu
 R+xH7R2Mvn/smhglwQ/iDm8Oq1/AY/Ch/o/Zu
X-Gm-Gg: ASbGnctN8Pd8DCjDNLXplZENpZXKCCRggSjdx3XGHln2cLiwfSC/RXXsTwTnJxJSM9D
 cnJabYuDACuGVJbCYQ5KgwLDaKQD0XbJJeu8gdTLirS/JMspwDhTDy9L+sT7R8EeFeRmP26SiCQ
 ==
X-Google-Smtp-Source: AGHT+IHzs+Mu67MKQxY3GyN9Pwr3kxa4dFachhiGJIwArXzHDjQ+wyyQpFgxOhL54qXa8SfQK2RcvffZRopYFPJPgJA=
X-Received: by 2002:a05:6402:1ecd:b0:5df:6a:54ea with SMTP id
 4fb4d7f45d1cf-5e03602f764mr18386903a12.11.1739715039778; Sun, 16 Feb 2025
 06:10:39 -0800 (PST)
MIME-Version: 1.0
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-36-sjg@chromium.org>
 <20250210143312.GB1233568@bill-the-cat>
 <CAFLszTiX-rNzEmrLOZ4PMMa9m3fHiLkchbJ=xtGh3RpZLmZ6Cw@mail.gmail.com>
 <20250211140755.GA1233568@bill-the-cat>
 <CAFLszTj+LnHXX5E1Yh8hqzu_uc2c1HeyzqCxOdAUu1XQBO0W0g@mail.gmail.com>
 <20250215145923.GR1233568@bill-the-cat>
 <CAFLszThHkXtvRCUYvBRBkfx_Tabb6wQ8mExFmLPNWrWXE3fsAg@mail.gmail.com>
 <20250215182804.GV1233568@bill-the-cat>
In-Reply-To: <20250215182804.GV1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 16 Feb 2025 07:10:28 -0700
X-Gm-Features: AWEUYZk7zGp_sjcGYxipLQBvZDl_BjcwFvNRIkHskHgRlr7V8yc_o0ynWwL-Jq8
Message-ID: <CAFLszThWFEJ_HAFvXyP1mmJWBWtmS-80KLd2hp0X+_dqNXsCyw@mail.gmail.com>
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

On Sat, 15 Feb 2025 at 11:28, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Feb 15, 2025 at 10:23:05AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 15 Feb 2025 at 07:59, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Feb 15, 2025 at 04:58:24AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 11 Feb 2025 at 07:08, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Feb 11, 2025 at 06:09:03AM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 10 Feb 2025 at 07:33, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Sun, Feb 09, 2025 at 02:14:56PM -0700, Simon Glass wrote:
> > > > > > >
> > > > > > > > Where the bloblist is located in internal memory and TF-A's BL31 blob
> > > > > > > > removes access to this memory, the best option seems to be to relocate
> > > > > > > > the bloblist just before running TF-A.
> > > > > > > >
> > > > > > > > We can do the relocation in board-specific code, but need an option to
> > > > > > > > pick up the correct address within U-Boot proper.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > Changes in v2:
> > > > > > > > - Move the actual relocation code to a previous board-specific patch
> > > > > > > >
> > > > > > > >  common/Kconfig    | 20 ++++++++++++++++++++
> > > > > > > >  common/bloblist.c | 15 ++++++++++++++-
> > > > > > > >  2 files changed, 34 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > I'm going to NAK this whole concept. The whole nightmare thread about
> > > > > > > these platforms comes from using a fixed address. We need to pass in a
> > > > > > > bloblist or see that one is not passed to us, via register. And then use
> > > > > > > that mechanism to pass the bloblist to the next phase. When we don't
> > > > > > > have a bloblist passed to us, we allocate one, and not at a fixed
> > > > > > > location.
> > > > > >
> > > > > > Well I understand that Linaro may be doing some work to head in that
> > > > > > direction.
> > > > >
> > > > > Are they? I don't know. I know Raymond was doing some clean up based on
> > > > > the idea of treating bloblist and standard passage as two separate
> > > > > things. Which I think is a terrible idea, despite suggesting it. But I
> > > > > think it's also the only way to make progress now that you've decided
> > > > > you can't work with them anymore.
> > > >
> > > > Can't work with who? Linaro? If you don't allow me to create patches
> > > > for bloblist within your tree, what am I to do?
> > > >
> > > > >
> > > > > > The 'piror-stage' stuff is what has made this all too hard and
> > > > > > confusing. We should think of things from a U-Boot perspective and
> > > > > > make that work. The new case can be handled by standard passage, along
> > > > > > the lines that Raymond suggested, i.e. just checking for it first.
> > > > > >
> > > > > > For x86 we don't need this path as there is no bloblist in TPL, i.e.
> > > > > > it can be placed in DRAM from the start.
> > > > >
> > > > > A fixed address is a bad API for the U-Boot case and is what makes this
> > > > > all so confusing. And no, we can't put it in DRAM on x86 either, that's
> > > > > what had coral broke until I put it back in CAR.
> > > > >
> > > > > Please explain why a fixed address is a better API than passing a known
> > > > > valid location via register, for the U-Boot case. I don't like it
> > > > > because it means that we cannot always safely check if it exists.
> > > > >
> > > > > --
> > > > > Tom
> > > >
> > > > Yes I would rather pass the location via register using standard
> > > > passage, at least on ARM, where we have a suitable protocol. For now
> > > > this is the only way for me to provide a series where VBE actually
> > > > works in the lab.
> > >
> > > I don't understand why you don't just add what U-Boot is missing then
> > > for passage via register.
> >
> > It's too difficult for me, with all the prior-stage and OF_BLOBLIST arguments.
>
> I'm not sure what to tell you then. I don't want BLOBLIST (which is not
> standard passage anymore, to appease you) using fixed addresses because
> that's a bad design and I'm sorry I missed that part originally. I swear
> I thought it was just temporary or only a starting point.

Well this was 7 years ago, long before I even came up with standard
passage[2] where I see that I naively relicensed bloblist because I
thought ARM/Linaro might use the code.

We still don't have a solution for x86, of course, the main user of
bloblist today.

Regards,
SImon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20180926215520.87168-4-sjg@chromium.org/
[2] https://lore.kernel.org/u-boot/20211101011734.1614781-1-sjg@chromium.org/
