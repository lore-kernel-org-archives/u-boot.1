Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236E7C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 00:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DDAE801DE;
	Fri,  7 Feb 2025 01:49:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vq7Nj7nS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C479280562; Fri,  7 Feb 2025 01:49:39 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2C558003E
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 01:49:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ab70043cd05so294925566b.0
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 16:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738889375; x=1739494175; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O2UHFmvy7VM2rMEpG1kic+7GjUDD0TqdPveCULZKmfw=;
 b=Vq7Nj7nSsJz8IasLEpGtdUIHSp5H07M2UfSQpQ9//sMCSWaP7C9QtJzoKXn2EqnKD6
 05PLZ/tFDpfnoCpVZi7w97i+uuTJUSFCVjymtNRR6YICqMjdfcAxE3fiavFm5i6BWXvP
 XARQ620sMVwRUvRKdmLq7iaoMT4DHV0Z/AOfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738889375; x=1739494175;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O2UHFmvy7VM2rMEpG1kic+7GjUDD0TqdPveCULZKmfw=;
 b=hE7miQ/a94napshtoij9uDA8FbiJeLaUfV5vVOP56E5hjBoC1j48oVgbHdGXzHfX1b
 fFyWfIyPTd/o7iSstjZKxVbfFykgoR/Rts076QUs06IQPLqRWR4TmI13d0N+IB7vlhaC
 3aiQYO9KOGlZo86dyTegKLa6017VPFInggfKIq50ltGSP0OhhdKlrYhg7NkKrHfhR8hA
 hlrFNIedz/Ed+bUUBe17fs+YZ0Ao1ejlheduKGPdmL1wFnUNVT00dP6M9kbEDxfxczo7
 zquG6MC761GsZnIxdLbGT01oyxg02YYVTDtVHAqrAsGP6fDwruTvEMcSsMNLKbHj6ias
 +yfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUajkcr34QaPYKiIlfccIx5ymu0GS9+w56/uSIPYg5skIgTTDdVVEKJRS2hR1s+B1/kYhOaa8o=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+WINpVcF4YWYBhz63qqqN5DqZYXxzEaJT0GNXbjWa5/8f4jII
 ja7U6SZckBd/YWwgskvdGp9C0eLFjm+l9BvP0O0WNBe0Uul7IxTAQ12QDUhcvPzrtUuOcBgFdB6
 tbHBM76ttVfwmvC0qtRRLdbvzKX5ZOCgnHoeRwjOVSEs7ls0=
X-Gm-Gg: ASbGnctIw4REX11BdyUHgoAfjU+Sw3Fs/CDNBhLG5Pdn6qQFxURJr+Xyhbd8KVKbOHm
 HjfvNJtH9YEhUb4mdIZQHcZFZw4uqxClokW3ytqQbNrrqJbhhctSxU+Xrm6IcjqqPuhs2rPrbbw
 ==
X-Google-Smtp-Source: AGHT+IG1kaIFwYh+aauEK0eYdYuBYDSCogOK42LF8pMfV9D39YQF6nBbzOROuQmGL8alLypc1O0cDcsXpD4XHx4eARI=
X-Received: by 2002:a17:907:3e06:b0:ab7:5d25:88e1 with SMTP id
 a640c23a62f3a-ab789b2a2a1mr94833966b.9.1738889375372; Thu, 06 Feb 2025
 16:49:35 -0800 (PST)
MIME-Version: 1.0
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-29-sjg@chromium.org>
 <CAEfUkUKoe+1LQaqOUb8_1M5yy8ELr=jG66+wRd1b3Oq5BB2bSA@mail.gmail.com>
 <CAFLszTg=UDJUdjCPsyMBjZ3r_r9dNyWYiXNrmhm8mxgEbQoaOg@mail.gmail.com>
 <CAEfUkUL7H5twRqZZBcfEHuExwtHFUrT9h7NV-3T0jx0c0SBEbw@mail.gmail.com>
 <CAFLszThvDjXTDdm7FiGZSBbtDv0px509x2jjn5WX++5Ck4PtOQ@mail.gmail.com>
 <20250207002006.GT1233568@bill-the-cat>
In-Reply-To: <20250207002006.GT1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 17:49:23 -0700
X-Gm-Features: AWEUYZlxgMov1Lfs4yl8qthSEMGwIg8-L2lwuYt1yr5vijshiB8SVcuIG7buGZo
Message-ID: <CAFLszTjr2vDy9M=N_LSyVAoJJ7iX29aNg1_deY2y0SDZ6L0ZKg@mail.gmail.com>
Subject: Re: [PATCH 28/29] Revert "bloblist: Load the bloblist from the
 previous loader"
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Levi Yun <yeoreum.yun@arm.com>, Patrick Rudolph <patrick.rudolph@9elements.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Thu, 6 Feb 2025 at 17:20, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Feb 06, 2025 at 05:09:41PM -0700, Simon Glass wrote:
> > Hi Raymond,
> >
> > On Thu, 6 Feb 2025 at 15:35, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Thu, 6 Feb 2025 at 10:41, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Raymond,
> > > >
> > > > On Wed, 5 Feb 2025 at 08:25, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > >
> > > > > +CC Ilias,
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Tue, 4 Feb 2025 at 20:57, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > The logic of this has become too confusing.
> > > > > >
> > > > > > The primary issue with the patch is that U-Boot needs to set up a
> > > > > > bloblist in the first phase where BLOBLIST is enabled. Subsequent
> > > > > > phases can then use that bloblist.
> > > > > >
> > > > > > But the first phase of U-Boot cannot assume that one exists.
> > > > > >
> > > > > > Reverting this commit seems like a better starting point for getting
> > > > > > things working for all use-cases.
> > > > > >
> > > > > > This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
> > > > > >
> > > > > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > >
> > > > > If my understanding is correct, you want to add some logic to control
> > > > > when the U-Boot should or should not get the bloblist from the
> > > > > existing register argument.
> > > > > But xferlist_from_boot_arg() should be called when a valid register
> > > > > argument is there, I didn't see this in your patch.
> > > > > Maybe you plan to do this with other patch series, but simply
> > > > > reverting this results in a breaking of handoff policy and the
> > > > > firmware handoff won't work.
> > > >
> > > > Yes, I certainly did not want to revert it, but the current code is
> > > > too hard to understand and I did not look at it at the time it went
> > > > in. I've had three tries at working with what you have here, but each
> > > > turns to spaghetti.
> > > >
> > >
> > > Still not very clear on what concerns you have and what is the way you
> > > want to go.
> > > The logic is straight forward, when U-Boot has a previous loader and
> > > the registers pass in valid arguments - It indicates handoff should be
> > > done using the transfer list.
> > > Other kconfig options decide whether to use the passed in address
> > > directly or copy to a predefined address.
> > > But in either way, xferlist_from_boot_arg() is doing the right thing
> > > to get the transfer list from the register if it exists and is valid.
> > > I don't see a reason for removing it.
> >
> > Here is the initial code:
> > >>>>
> > bool from_addr = fixed && !xpl_is_first_phase();
> > /*
> > * If U-Boot is in the first phase that an arch custom routine should
> > * install the bloblist passed from previous loader to this fixed
> > * address.
> > */
> > bool from_boot_arg = fixed && xpl_is_first_phase();
> >
> > if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
> >    from_addr = false;
> > <<<<
> >
> > and by the way, that is my tree. In -next it is even worse:
> > >>>>
> > /*
> > * If U-Boot is not in the first phase, an existing bloblist must be
> > * at a fixed address.
> > */
> > bool from_addr = fixed && !xpl_is_first_phase();
> > /*
> > * If U-Boot is in the first phase that an arch custom routine should
> > * install the bloblist passed from previous loader to this fixed
> > * address.
> > */
> > bool from_boot_arg = fixed && xpl_is_first_phase();
> >
> > if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
> > from_addr = false;
> > if (fixed)
> > addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
> >       CONFIG_BLOBLIST_ADDR);
> > size = CONFIG_BLOBLIST_SIZE;
> >
> > if (from_boot_arg)
> > ret = xferlist_from_boot_arg(addr, size);
> > else if (from_addr)
> > ret = bloblist_check(addr, size);
> > <<<<
> >
> > I want to update it so that TPL creates a bloblist and passes it
> > through the following phases, ending up at U-Boot.
> >
> > To my mind, if CONFIG_IS_ENABLED(BLOBLIST), then we should check the
> > registers and always accept standard passage. If not, we should
> > either:
> > - create a bloblist (if this *is* the first phase with
> > CONFIG_IS_ENABLED(BLOBLIST))
> > - use an existing bloblistl, which must exist (if not)
> >
> > I just don't think the existing logic is a good starting point as it
> > is too confusing.
> >
> > Perhaps, putting it another way, what do you like about the current
> > code (either version)?
>
> We need to untie the check for and create logic. And we need to add code
> so that U-Boot can pass from one phase to the next without a fixed
> address. That should help simplify this logic and move towards being
> able to just drop the fixed case entirely.

Well, if you want me to do this, I can, but it needs to start with
this revert. If someone else is going to do it, I'll cheer from the
sidelines.

Regards,
SImon
