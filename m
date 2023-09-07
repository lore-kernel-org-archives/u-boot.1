Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3802DEB8FDE
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 12:21:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46133863ED;
	Thu,  7 Sep 2023 14:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GEp2DJnS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCB1886591; Thu,  7 Sep 2023 14:21:36 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3841F8620C
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 14:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-502153ae36cso1390753e87.3
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 05:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694089293; x=1694694093; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qj5JzootHB+WT27wyWw9LZN1UqSGHU8dA0pvUZuKoyE=;
 b=GEp2DJnSxdYNfHFYYwIQiUnDPFF/a+hb67KT5kAkMzRwEWT7GGF9p64kO7ZPO1TuYI
 aVGgQWpPwMyRUJQGbNBC/L+Jo5kZa+/NhY5ZxY9ippYnX8BAXblM1cyAchHtZSzhyEHq
 fRyH+gUCjVGZbAppMzTwN2SudZYono3FXN4BY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694089293; x=1694694093;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qj5JzootHB+WT27wyWw9LZN1UqSGHU8dA0pvUZuKoyE=;
 b=JNMCYouwPel48T3/qA5tU44JaWfuP/Rt9+3m6wI04M+7AU0I0Do1P33txLQsKGGi/6
 LTEaC/oAlrhhG8jvakt1I2p6Ni9m4IWtietw7ohgMzTnctjqRrPTh+xTR3CAmN5a4h2O
 U77hQRLf7mUko+m5sjRUR7C0RdEV1Bb/j50CP3NM+BhUhjGp/NkfJtbPpq3ad0ay4UJn
 ASqMvVYUFYHblZe04W9bTCiJrBHkCikwksZgha6vhEL5K+SiBmM//HkH9tXTuU+GkOUC
 uMhnxJ3gGESZVFwDYC4x2H25CjEVTok7cUOjGbvDw5oN1FijbfhixVR/yV42WWOnrXQB
 10iw==
X-Gm-Message-State: AOJu0YzMoZ5Zw3MPowHs/RuDTFUvGJtzfa2/E8zShqGwpCD9e18n0rlQ
 tBrGO4SShTLKq/QDCX+SksP/I4BuyRAm4U+WBgIoFw==
X-Google-Smtp-Source: AGHT+IGcWMDlhRL6jKymPfhYBQMYESsfRyFFqifd69zjLs5WQmg1EnMw6WdyKKMEDWUWzypGAMBZNJbWcaO7XRWgSFk=
X-Received: by 2002:a19:501a:0:b0:500:9d32:8deb with SMTP id
 e26-20020a19501a000000b005009d328debmr4500102lfb.51.1694089293129; Thu, 07
 Sep 2023 05:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230823184746.842091-1-sjg@chromium.org>
 <20230823184746.842091-8-sjg@chromium.org>
 <6f1ea3e9-7284-22d3-e2ee-071523b7dbac@gmx.de>
 <CAPnjgZ3i9EDe3CyU64WRpE+oR0-xS2iffQR=2hVBZRzA2KkC6Q@mail.gmail.com>
 <2058DF5A-619E-4B47-A80E-4B5C56FC3573@gmx.de>
 <CAEUhbmWvEXvB6UmtsvHe5M13dMqS2BQF6Q-fdapYDVh3ROG73A@mail.gmail.com>
In-Reply-To: <CAEUhbmWvEXvB6UmtsvHe5M13dMqS2BQF6Q-fdapYDVh3ROG73A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Sep 2023 06:21:15 -0600
Message-ID: <CAPnjgZ1cwU5mwRFWCy58-SRYhE50wryPowP+WzDJ=9f78PCCDw@mail.gmail.com>
Subject: Re: [PATCH 7/8] spl: x86: Avoid starting up PCI automatically in SPL
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Qu Wenruo <wqu@suse.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Bin,

On Mon, 4 Sept 2023 at 03:20, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Simon,
>
> On Thu, Aug 24, 2023 at 10:11=E2=80=AFAM Heinrich Schuchardt <xypron.glpk=
@gmx.de> wrote:
> >
> >
> >
> > Am 24. August 2023 01:57:55 MESZ schrieb Simon Glass <sjg@chromium.org>=
:
> > >Hi Heinrich,
> > >
> > >On Wed, 23 Aug 2023 at 14:19, Heinrich Schuchardt <xypron.glpk@gmx.de>=
 wrote:
> > >>
> > >> On 8/23/23 20:47, Simon Glass wrote:
> > >> > For x86 platforms, PCI is core to their operation and is managed i=
n
> > >> > arch-specific code. Each platform has its own way of doing this. F=
or TPL
> > >> > and some SPL implementations, the full driver model PCI is not use=
d.
> > >> >
> > >> > A recent change enabled full PCI in TPL/SPL for all boards. This b=
reaks
> > >> > some x86 boards, so adjust it to skip that for x86.
> > >>
> > >> Could you, please, give some more detail?
> > >>
> > >> * Which boards are broken?
> > >
> > >For example, chromebook_samus and chromebook_samus_tpl
> > >
> > >> * Don't these boards have a pci_init() function?
> > >
> > >Yes, the same one you are calling.
> > >
> > >> * In what way does calling pci_init() lead to a failure?
> > >
> > >It probes and sets up PCI devices and uses a lot of pre-alloc RAM.
> > >
> > >>
> > >> It would be preferable to have all architectures and boards use the =
same
> > >> high level API. Excluding x86 here looks more like a (necessary) hac=
k
> > >> than like a target state.
> > >
> > >Fair enough, but on x86 we access PCI long before driver model is up.
> > >Generally we don't fully enumerate it in SPL as it is expensive. It is
> > >also pointless, since U-Boot proper does it again later.
> > >
> > >Regards,
> > >Simon
> > >
> >
> > Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >
>
> To address Heinrich's concern, how about you turn off CONFIG_SPL_PCI
> in chromebook_samus and chromebook_samus_tpl?

I dug into this a bit more...the root cause is that we are turning off
CAR so the driver model tables are no-longer available. Accessing them
causes a hang.

I will send a v2 which adds a flag to indicate this.

Regards,
Simon
