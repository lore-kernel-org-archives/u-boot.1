Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D94C02196
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 22:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8E2780737;
	Thu,  6 Feb 2025 23:22:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sMClHml9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CA4880E94; Thu,  6 Feb 2025 23:22:45 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAEF880562
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 23:22:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2f9b9c0088fso2336608a91.0
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 14:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738880561; x=1739485361; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9v6RM4m3K56M6eX53QOOB1CsUH7unx4fgsh2tJbsqUo=;
 b=sMClHml9okon11I18933nMlNugA9CxNIv3ILYwdndy/litted6vTZVLZS6JXJGztwn
 L2Pr3TzvDxfj2nT6rWjjXhuzST5pRQjcQrpJ3OPFL/1Gh3xqvFJoqH9hcMzkTgPXCSO6
 VvpyhSO55vi8x6E+lTXbGOVyiRfN4j7bdN4ij0Cj1Zbda82d0ewdwhgMfneZ5nq5dsmn
 xKfjIApKyqM5nLVp+nZf7hRbVgu1T53ViRsTVOSMwfCQeiDZpZ/VfU235fT4JXgiCpEY
 BanWPk1gx27ySVY7MYB1EjKEKqn3oL2yR527GVvS89cYUrmcpTesHyf6PC8SHX4Xrnkt
 dUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738880561; x=1739485361;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9v6RM4m3K56M6eX53QOOB1CsUH7unx4fgsh2tJbsqUo=;
 b=crVP+ofSbEtKilJYvrpgyHZ/Jjbc2gzDRQ+LyU/nT/07DwVHPRt087TbDPkIHpnEhC
 bswvg6xV/6R5UsyhYy/0W+/kRwiAWUPouZU06p4z1RUAhTYxfGOIFEG/PvIHx6qd3M4M
 /MhZBhcpPs4M9TQoeXQLMzCIIWJY4iVJ4Fqhch09ftySXZdBqielVuNXWm9zK4OjjOMv
 i0N2/Lv245pfjrWoidQFb/vsIBsdwN2zyeBme/f21vvWxsr1fCtalq4xCmiWl3K5XKwE
 N/8obyN+oQ+Onc5dqgyImBN5tdd9mZ0+PWM0J4qKI37OKhiaIWeV64nH6uleJBx8Rvt6
 wYBA==
X-Gm-Message-State: AOJu0Yzbn1l3/gMygYe1ubIA++VhbtyD5R6CHY1cX3h0SGmQ0RN3hvKP
 O7h/BuQc4gqWPKrw18nJ/8MJk6HBeGETlnakARPmZa8RhkaC9woz8gnX2W3AtKdnCYDjGCFozmm
 o2WaT4KiqI7oj3yDmHFIuKbCeuK+pNvIyf/qxpg==
X-Gm-Gg: ASbGncvmDaOCbfU+iXrBhwbW6Y+3elPw8xD5TeoQCgnkx+CWd1gOasxZlARAm/xgOg/
 fOvuLlhFpDdnY595VjvrWBDJezA7m/WMH85LFaK+0pwZg5wct3PK4sIZMh/PsqwbM50akG/TzqI
 S1iDJvAGNEMWvn7mZQDiICJxMaZ9OR
X-Google-Smtp-Source: AGHT+IHG4OUt8ZxFFnNZzEcCeOr7146YG1jPfAtFBdFSyXJainMUP+esjkjYiq3MgnXuQIMFIsli44E00T/goaxysJM=
X-Received: by 2002:a17:90b:1b01:b0:2f6:e47c:1750 with SMTP id
 98e67ed59e1d1-2fa2487f21cmr1067352a91.13.1738880561060; Thu, 06 Feb 2025
 14:22:41 -0800 (PST)
MIME-Version: 1.0
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-30-sjg@chromium.org>
 <CAEfUkUKqhf0Y9v9U9bTw0A3_odkDVpbfXLKM08qtrcdARyOsbA@mail.gmail.com>
 <CAFLszTj3-1KSRqgDyvdKFt0V9=Nt8Rksd5+j88Rp+_oAZDKxVw@mail.gmail.com>
In-Reply-To: <CAFLszTj3-1KSRqgDyvdKFt0V9=Nt8Rksd5+j88Rp+_oAZDKxVw@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 6 Feb 2025 17:22:28 -0500
X-Gm-Features: AWEUYZk_v0wi-6dkFnykw_Dl_Uz1B9pJJtOMhl_T1JM3lkMFMBMxP6mnaC--GYE
Message-ID: <CAEfUkUJXXhxLddonwyY9na+kNptBG-g9WNGHuZ9qi3YXA+O2+Q@mail.gmail.com>
Subject: Re: [PATCH 29/29] bloblist: Allow relocation at the end of the SPL
 phase
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Thu, 6 Feb 2025 at 16:28, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Raymond,
>
> On Wed, 5 Feb 2025 at 08:35, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Tue, 4 Feb 2025 at 20:57, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Where the bloblist is located in internal memory and TF-A's BL31 blob
> > > removes access to this memory, the best option seems to be to relocate
> > > the bloblist just before running TF-A.
> > >
> > > Add an option to select this behaviour and provide a relocation address.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  common/Kconfig    | 20 ++++++++++++++++++++
> > >  common/bloblist.c | 15 ++++++++++++++-
> > >  common/spl/spl.c  |  9 +++++++++
> > >  3 files changed, 43 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/common/Kconfig b/common/Kconfig
> > > index 0e8c44f3f74..962e7fd76eb 100644
> > > --- a/common/Kconfig
> > > +++ b/common/Kconfig
> > > @@ -1125,6 +1125,26 @@ config SPL_BLOBLIST_ALLOC
> > >
> > >  endchoice
> > >
> > > +config SPL_BLOBLIST_RELOC
> > > +       bool "Relocate the bloblist before existing SPL"
> > > +       depends on BLOBLIST_FIXED
> > > +       help
> > > +         Some platforms locate the bloblist in SRAM in SPL. In some cases,
> > > +         the TF-A BL31 blob removes access to SRAM, e.g. with Rockchip RK3399.
> > > +
> > > +         Enable this option to make U-Boot copy the bloblist from SRAM to SDRAM
> > > +         before leaving SPL.
> > > +
> > > +config SPL_BLOBLIST_RELOC_ADDR
> > > +       hex "Relocate the bloblist before existing SPL"
> > > +       depends on SPL_BLOBLIST_RELOC
> > > +       default BLOBLIST_ADDR
> > > +       help
> > > +         Sets the address to which the bloblist is relocated at the end of SPL.
> > > +         U-Boot proper uses this address when it starts up. Note that U-Boot
> > > +         always relocates the bloblist again as part of its own relocation
> > > +         process.
> > > +
> > >  endif # SPL_BLOBLIST
> > >
> >
> > I think the relocation you mentioned is a board-specific behaviour and
> > should not be part of common/Kconfig if only a few boards use them.
>
> Where do you suggest this code should go?
>

Can be arch/arm/mach-rockchip/rk3399 if it is general for all rk3399
or any rk3399 subdir under board if it is only board specific.

Regards,
Raymond

> Regards,
> Simon
