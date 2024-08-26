Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852E2C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 11:48:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CCC28895B;
	Mon, 26 Aug 2024 13:48:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dSARh0l2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC6D18897E; Mon, 26 Aug 2024 13:48:36 +0200 (CEST)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39DF688418
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 13:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-84305a83b06so1279054241.2
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 04:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724672913; x=1725277713; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EWPflUdezkFs9RREZvqe7oHuM8Rm4+l3kIhlM9m7A40=;
 b=dSARh0l2eKWQO1/3Z88w5YhH8gPyVlgb224NfHtmpN0HxKN6Q/oZNR0/QcSTWJH/If
 pHQtHQuijJw8pUiqZcQJTduNIPQnkbAEnGeN/zIYkEHFLOEVK4ZJGecHmp6Sr1yQhJaN
 tD7ls9EPIC5oFrp42xhoG4Xci/r5Qb/8Jp6aP7DLXGVBtP2WrBjI6x2HRiWoVxzwG+GA
 wf/mZPg75V4hc8xBOWBpS7H8xbdoA9wL9BnaI94PSw9N+ZW/M3GKtv823D9jOXNLz0zF
 ZGaFGVXW66hNW8aBRVuNWLy9GfBR8lJUEbiFlbY1SiPj9GuvwdgzH7FpSlaJwAAVurb9
 cnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724672913; x=1725277713;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EWPflUdezkFs9RREZvqe7oHuM8Rm4+l3kIhlM9m7A40=;
 b=D0SwrW7DwqGDBCd530ePxCGL8cL237rlfGM9ydIgIlTwebLs3neWSbVoVKMOEZLrYq
 yAWMwAZt/xGmb1xwF8eAZ+BHXonY2HsDYc6HbTHoAG6tazjNfgJlo5zgYlcBIfjHOTuh
 vpTvCk419gr64+jnnmohwL0LIINoEBrFDT7VznZ8TExCGk0aobQVc+ILreIqUz9Rnua8
 4jWCefZk1dsNeNw14oL5v4XPPvMVQ5karvscy8XYD4cYrIrGyxMYVNNTOKdFXmErcI3G
 +mb9PLp8U4xX73OBtAu0ZtGce2iqZJgRwVx9IBusPuMGy/HuAq+iiHiVPqoabTZgulBe
 5SFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqtWs2jZmarxd7vjjGy+NmbBMdzNMtrrOcnqvXL+y1bHy10bQbKPJ8QfSPvCRs/rFB9nEwO6k=@lists.denx.de
X-Gm-Message-State: AOJu0YwrhH4TVDQwk07RX9pZ71svpxi6jA4IESadpUCp0EtHL4FBetkm
 CYtmwQ++0uHzqJRSVhWM/bWGdyB7feHlVDzs6mOD4zRVj+7+9YUwUCm1reSMSUD29FER37tJTs2
 VTrhvGFwKIvrwxN9FlGm6rwl7ukion2qtiMdMhw==
X-Google-Smtp-Source: AGHT+IGLrUXFAWOxcgF9G6lBHlrWGvhVFNKRpkU8KU1UYWmrW9X0izvD3CcT+RD6jTzXyvojSk7wvcVX64U1FnWQ/dA=
X-Received: by 2002:a05:6102:32c3:b0:493:bb36:9be9 with SMTP id
 ada2fe7eead31-498f4520145mr11729550137.1.1724672912839; Mon, 26 Aug 2024
 04:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <7765273f-7f36-41e4-a604-1901e4fbec62@siemens.com>
 <20240813125245.ezlu6me3ljwx6dkj@margarine>
 <89f8e976-e831-4035-8cd0-ab6284846d0a@siemens.com>
 <4ec5108f-b7a4-47db-baa4-edee532c58af@siemens.com>
 <CAFA6WYMQustcwo4Es7iJQj5Lva6UiYJ-j7WgSzMjOvEHemeDcQ@mail.gmail.com>
 <66cc4396.670a0220.ebd0d.a836SMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <66cc4396.670a0220.ebd0d.a836SMTPIN_ADDED_BROKEN@mx.google.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 26 Aug 2024 17:18:21 +0530
Message-ID: <CAFA6WYOgL6726=EVQyuWPqXEuf+efZyt0AOmVWQXcLq5eOUOrg@mail.gmail.com>
Subject: Re: OF_UPSTREAM vs. additional dtbs
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Jonas,

On Mon, 26 Aug 2024 at 14:27, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Sumit,
>
> On 2024-08-26 08:44, Sumit Garg wrote:
> > Hi,
> >
> > On Wed, 14 Aug 2024 at 22:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>
> >> On 14.08.24 11:41, Jan Kiszka wrote:
> >>> On 13.08.24 14:52, Nishanth Menon wrote:
> >>>> On 11:16-20240813, Jan Kiszka wrote:
> >>>>> Hi all,
> >>>>>
> >>>>> I'm trying to migrate the TI AM65x IOT2050 boards to OF_UPSTREAM but I'm
> >>>>> facing issues because I need to still build the u-boot-only overlays. It
> >>>>> is also a bit weird (but works) having to specify
> >>>>>
> >>>>> CONFIG_SPL_OF_LIST="../../../../arch/arm/dts/k3-am65-iot2050-spl"
> >>>>>
> >>>
> >>> Actually, this does NOT work: I just had a long morning debugging SPL
> >>> which no longer started because it picked the non-filtered dtb. The
> >>> filtered one ended up in a folder outside of the u-boot sources because
> >>> of all those ../ and hard-wiring to dts/upstream.
> >>>
> >>>>> for our spl dtb.
> >>>>>
> >>>>> Are there means to still build certain dtb[o] files in arch/<arch>/dts?
> >>>>> I'm a bit lost in the Makefile forest.
> >>>>>
> >>>>
> >>>> Sumit: Any suggestions?
> >>>>
> >
> > Apologies for the delayed reply. I was a bit busy with other high
> > priority stuff.
> >
> >>>
> >>> I would really like to hear some better proposals than my local
> >>> workarounds to far. They don't converge although I already patched some
> >>> core Makefile (overlays are building now).
> >>>
> >>
> >> OK, I side-stepped the spl issue by using one of our variant DTBs for
> >> spl as well - happens to work.
> >
> > That's good to know.
> >
> >>
> >> For the overlays, I need to add
> >>
> >> --- a/scripts/Makefile.dts
> >> +++ b/scripts/Makefile.dts
> >> @@ -1,5 +1,7 @@
> >>  # SPDX-License-Identifier: GPL-2.0+
> >>
> >> +include $(srctree)/config.mk
> >> +
> >>  dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
> >>
> >>  ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
> >>
> >>
> >> in order to then be able to do
> >>
> >> --- a/board/siemens/iot2050/config.mk
> >> +++ b/board/siemens/iot2050/config.mk
> >> @@ -5,4 +5,12 @@
> >>  # Authors:
> >>  #   Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> +ifneq ($(CONFIG_SPL_BUILD),y)
> >> +dtbo-list = \
> >> +       k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay \
> >> +       k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay
> >> +
> >> +dtb-y += $(patsubst %,../../../../arch/arm/dts/%.dtbo,$(dtbo-list))
> >> +endif
> >> +
> >>  flash.bin: all
> >>
> >>
> >> Does that make sense?
> >
> > A switch to OF_UPSTREAM means that we build all the DT artifacts from
> > dts/upstream/src/ directory with the only exception that we include
> > U-Boot specific overrides via *-u-boot.dtsi from arch/<arch>/dts. In
> > case of overlays, is there any reason for IOT2050 board overlays not
> > being pushed into Linux kernel repo? AFAIU, overlays are also
> > describing puggable hardware so they shouldn't be referred to as
> > "u-boot-only" overlays.
>
> I have a related issue where I would like to build board DT from
> dts/upstream, however there is also a need for a limited U-Boot specific
> DT that only is intended for initial boot so that U-Boot at runtime can
> determine what hw revision is booting and select correct DT to use for
> U-Boot proper and OS.
>
> For now I have just set the board target to use OF_UPSTREAM=n and
> instead created minimal .dts-files in arch/<arch>/dts that include the
> full .dts-file from dts/upstream.
>
> Any suggestion on how we better can support having a U-Boot only
> .dts-file together with OF_UPSTREAM=y ?

The motivation is rather to avoid any U-Boot specific DT files.
Shouldn't you be able to create a DT overlay of v2.1 board over v1.1
and push that upstream? The runtime DT choice sounds pretty similar to
how you can choose to apply the DT overlay or not with common boot DT.
Also, bundling multiple DT within U-Boot proper FIT image can be an
alternative too.

-Sumit

>
> Please see following for more details:
> https://source.denx.de/u-boot/u-boot/-/commit/a52099b4a2ae9e8cafc79268325249bcad308012
> https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/rk3566-orangepi-3b.dts
> https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/rk3566-orangepi-3b-v1.1.dts
> https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/rk3566-orangepi-3b-v2.1.dts
>
> Regards,
> Jonas
>
> >
> > -Sumit
> >
> >>
> >> Jan
> >>
> >> --
> >> Siemens AG, Technology
> >> Linux Expert Center
> >>
>
