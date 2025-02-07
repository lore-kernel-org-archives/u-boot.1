Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F97C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 00:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8521280F30;
	Fri,  7 Feb 2025 01:10:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NVLj95mn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 890C580F42; Fri,  7 Feb 2025 01:10:15 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F95280BA8
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 01:10:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5dce3c28889so3273707a12.0
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 16:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738887013; x=1739491813; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LlHw/lQ/HYt6ppIlFHGx8dCl5eJ8+u7kRG+3dbgbTO4=;
 b=NVLj95mnEK11jntKgTEPmDfqsNuSG9cQ2tGBq92rpAxdfBdinGBTfsK5ioYxTZG/KI
 39sCi2o3d4CSiBO0AESLKeC65n1CmGrNBIAhnz9VVPD0/RrvuhnLsGTE3B8WwflImjvf
 lQKBuUOozNKnykhSc8KsOvbtPQ8gb1+Aa/d3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738887013; x=1739491813;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LlHw/lQ/HYt6ppIlFHGx8dCl5eJ8+u7kRG+3dbgbTO4=;
 b=GmA1cgZJdQcA+HW/BM7AGl1O6Lgf/d0hVno/Q61OWFjVyMAGyPe+iXkX2/Z8nHwCnB
 ugNOrO5Efa6o6LQNgX78irwRDLhj2jf9Ah6HZAj2Aj5hCKZIvg0BHojliFhq9BBa0S7J
 MOJ2/9URR7UEEy8lpkrZNPDGMOyF8F6vEYXtKlnOQTwx1ledjCABiPl7mJfnTk4C/TGA
 HR4P65d4M1qdAD6Oqmnan2OWJcu9yaczhdkHmDN0RxjrHJH0j1qQzR/IUmV/7lcNOYiH
 UP0WqwwAl6Ies6nCNj5q2CeP43Pmutlre3cunoj7TcbXOLrsB+mc76xEQBeoFqYeckLE
 /1uw==
X-Gm-Message-State: AOJu0Yz75aqCdJOyG2iv2kNVpD+oldM3nLs6xEdzXZpzisSJZ8TkkVpl
 ujrQb9nBp96sT69cAytNAxxs5i60uFc69/E8JRnsDYvvx5b7x19A2MP3y2cXeoMo5XHNhB3EdyT
 qiAVklyKzrOOfPBvUpDEauAQC4gNa5+G1JEQG
X-Gm-Gg: ASbGncvXOJnaBhcJTMnWo57QnbwQnv5lj/9R8T8PRWtQgCssHOtmrKmaa4AgIMMEdfF
 osQAl0CCeIrfzCYc74ukjux/WZjt3N+YXUxaldVQ+dTDJWFo/aKvNLhtix6nnq1kGk32yzrUe3g
 ==
X-Google-Smtp-Source: AGHT+IFnEnUOZjSTmJ3ZxyjUZkSYOV+O/2POvi5IXuIZawfOtEyt0hgJNG7c7nsRdJMThF3P71NKvgIiaG8v4g5ZkuI=
X-Received: by 2002:a17:907:3f0f:b0:ab7:6b66:66f9 with SMTP id
 a640c23a62f3a-ab789a9bd05mr93704666b.10.1738887012987; Thu, 06 Feb 2025
 16:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-30-sjg@chromium.org>
 <CAEfUkUKqhf0Y9v9U9bTw0A3_odkDVpbfXLKM08qtrcdARyOsbA@mail.gmail.com>
 <CAFLszTj3-1KSRqgDyvdKFt0V9=Nt8Rksd5+j88Rp+_oAZDKxVw@mail.gmail.com>
 <CAEfUkUJXXhxLddonwyY9na+kNptBG-g9WNGHuZ9qi3YXA+O2+Q@mail.gmail.com>
In-Reply-To: <CAEfUkUJXXhxLddonwyY9na+kNptBG-g9WNGHuZ9qi3YXA+O2+Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 17:09:53 -0700
X-Gm-Features: AWEUYZnvWhfVa_wFBjPStnufbIHVRlsieSrkRYP4rX3jFFxlJ07wrNh_M9l4VYc
Message-ID: <CAFLszThmhvYajOxu98q7esCjwZXJK5xXyOcYOP18RsmWQiXj1A@mail.gmail.com>
Subject: Re: [PATCH 29/29] bloblist: Allow relocation at the end of the SPL
 phase
To: Raymond Mao <raymond.mao@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alex Shumsky <alexthreed@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>, 
 Levi Yun <yeoreum.yun@arm.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson <seanga2@gmail.com>,
 Stefan Roese <sr@denx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Raymond,

On Thu, 6 Feb 2025 at 15:22, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> On Thu, 6 Feb 2025 at 16:28, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Raymond,
> >
> > On Wed, 5 Feb 2025 at 08:35, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Tue, 4 Feb 2025 at 20:57, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Where the bloblist is located in internal memory and TF-A's BL31 blob
> > > > removes access to this memory, the best option seems to be to relocate
> > > > the bloblist just before running TF-A.
> > > >
> > > > Add an option to select this behaviour and provide a relocation address.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >  common/Kconfig    | 20 ++++++++++++++++++++
> > > >  common/bloblist.c | 15 ++++++++++++++-
> > > >  common/spl/spl.c  |  9 +++++++++
> > > >  3 files changed, 43 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/common/Kconfig b/common/Kconfig
> > > > index 0e8c44f3f74..962e7fd76eb 100644
> > > > --- a/common/Kconfig
> > > > +++ b/common/Kconfig
> > > > @@ -1125,6 +1125,26 @@ config SPL_BLOBLIST_ALLOC
> > > >
> > > >  endchoice
> > > >
> > > > +config SPL_BLOBLIST_RELOC
> > > > +       bool "Relocate the bloblist before existing SPL"
> > > > +       depends on BLOBLIST_FIXED
> > > > +       help
> > > > +         Some platforms locate the bloblist in SRAM in SPL. In some cases,
> > > > +         the TF-A BL31 blob removes access to SRAM, e.g. with Rockchip RK3399.
> > > > +
> > > > +         Enable this option to make U-Boot copy the bloblist from SRAM to SDRAM
> > > > +         before leaving SPL.
> > > > +
> > > > +config SPL_BLOBLIST_RELOC_ADDR
> > > > +       hex "Relocate the bloblist before existing SPL"
> > > > +       depends on SPL_BLOBLIST_RELOC
> > > > +       default BLOBLIST_ADDR
> > > > +       help
> > > > +         Sets the address to which the bloblist is relocated at the end of SPL.
> > > > +         U-Boot proper uses this address when it starts up. Note that U-Boot
> > > > +         always relocates the bloblist again as part of its own relocation
> > > > +         process.
> > > > +
> > > >  endif # SPL_BLOBLIST
> > > >
> > >
> > > I think the relocation you mentioned is a board-specific behaviour and
> > > should not be part of common/Kconfig if only a few boards use them.
> >
> > Where do you suggest this code should go?
> >
>
> Can be arch/arm/mach-rockchip/rk3399 if it is general for all rk3399
> or any rk3399 subdir under board if it is only board specific.

OK I'll take a look. I agree this is a pretty strange problem.

Regards,
SImon
