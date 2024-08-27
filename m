Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D40C54734
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 10:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EF62887F3;
	Tue, 27 Aug 2024 12:39:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OpEqg4Nf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A35C188905; Tue, 27 Aug 2024 12:39:45 +0200 (CEST)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 018CB8826E
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 12:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-842f00b7352so1511036241.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 03:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724755182; x=1725359982; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VKNub7lVq8rtR9nzNDqBsAsKm4SyA8bgjM19xopO1eE=;
 b=OpEqg4Nfem5fRhJFze76zowf0do1OAsQHhGENJFYmC98uEI6Um3EYN0DF7b64Z3Gxm
 g4NAbtQ/LbwaHJzrw1dFejl5PdrcWh8aZ77qFxMLyYbNbiogk59j1oe0Akj7N3AOl6cZ
 MqCsnZ8ePtxNGyWZskLKemzNrwwSfcQp/Le033zYqxqQPaY5C2wEXXYS5VC0/wUplC3h
 yxfEJFzx9IQ1jkOnw1jKjS2omTgk9bxvlEnCJ1QLTgpVwuMNs/XdUdIOOJNkM+wOF7aZ
 4pB9L28WzVt4NJX+qSJbprCqmEh/6BPNAzwqQqsEaZSuTjdCmuhbbnrHgWmLLT2zJ7ml
 AYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724755182; x=1725359982;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VKNub7lVq8rtR9nzNDqBsAsKm4SyA8bgjM19xopO1eE=;
 b=in4pTZDfjZGED9PM85kpra1SMRRbx8hmXLDkZwXxI+u0LHD78k2XAYxTYCSl5l/KRX
 zR7ZUEZePoyVAZyw+lVwm4LjarT50w10ZMbZBzFLX0FKCj65pg5qcwFGw8zXATWSoMQE
 X+7SsjItZV8Isd73aaIOoyXGNox3wob/WKAwshByicTpRseWTMzqRuoLuX24qMt3/FEw
 MnSZaD8c7cPJ4RGMNS0b5a2Y2Jxd/EYRo0H769Czzq6XXnQacXXops/Gq1z0EVyE/ORg
 zi3oTxShvcgwnZiP6QMSlDA7deC8ASIZ9q6jbbE2ndwoKX5QSRATEJyTsBz8rOI8LUZB
 Hw7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjJySTrodeb0fIAh00hxRPYD2zVcVIkx2lNOpIr36oljLKa0YwJlA9SANbcP9mW7jcSX+CrzQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/IxtcdfIrOIB0shfwPKxgYnJxaTCTAhKXNn8z4qOBNUXABbpX
 ym8MUdIbnAfttogGvYDc6gPDRx2I4ImsQreVD0guAMl+X2mDSFwL9ja49Cic7XDObFlakdVs0wX
 W5NT66SDG6IL0QvoO4Gt+8mRm1Py5l6Z0vTWUCg==
X-Google-Smtp-Source: AGHT+IF+lX4LRLI/jnKMpf92z2Y6uHLlHPDZ9KplUdD6nYjoTwGXoZBui3B1hzEscJwKXLrVkMycLhL5yILc1RZv8c8=
X-Received: by 2002:a05:6102:b0f:b0:492:aded:1914 with SMTP id
 ada2fe7eead31-498f4b17bf6mr15281082137.10.1724755181566; Tue, 27 Aug 2024
 03:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <7765273f-7f36-41e4-a604-1901e4fbec62@siemens.com>
 <20240813125245.ezlu6me3ljwx6dkj@margarine>
 <89f8e976-e831-4035-8cd0-ab6284846d0a@siemens.com>
 <4ec5108f-b7a4-47db-baa4-edee532c58af@siemens.com>
 <CAFA6WYMQustcwo4Es7iJQj5Lva6UiYJ-j7WgSzMjOvEHemeDcQ@mail.gmail.com>
 <4576b818-9732-45ff-a4ab-b98fc0ecf4c9@siemens.com>
 <CAFA6WYNXgJkCX9-aoL5FGchAHGdV+ikTt4+pTJP-jZ_UJG8E6Q@mail.gmail.com>
 <87a9fe3e-5d9a-41e8-a8b2-4368cb727a65@siemens.com>
 <CAFA6WYMGyMAB=m-hkxs87PyHszcbQUk6+0_G0n+0-Yk8NeRXQQ@mail.gmail.com>
 <f61a8c74-9838-481e-aa1e-09fcc07f044e@siemens.com>
In-Reply-To: <f61a8c74-9838-481e-aa1e-09fcc07f044e@siemens.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 27 Aug 2024 16:09:30 +0530
Message-ID: <CAFA6WYNdS0jZ1iESfCErX92SOL2fJSRNNLZ1a_7jHoSfOUrdgw@mail.gmail.com>
Subject: Re: OF_UPSTREAM vs. additional dtbs
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nishanth Menon <nm@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 27 Aug 2024 at 15:05, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 27.08.24 09:13, Sumit Garg wrote:
> > On Mon, 26 Aug 2024 at 18:02, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>
> >> On 26.08.24 09:10, Sumit Garg wrote:
> >>> On Mon, 26 Aug 2024 at 12:19, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>>>
> >>>> On 26.08.24 08:44, Sumit Garg wrote:
> >>>>> Hi,
> >>>>>
> >>>>> On Wed, 14 Aug 2024 at 22:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>>>>>
> >>>>>> On 14.08.24 11:41, Jan Kiszka wrote:
> >>>>>>> On 13.08.24 14:52, Nishanth Menon wrote:
> >>>>>>>> On 11:16-20240813, Jan Kiszka wrote:
> >>>>>>>>> Hi all,
> >>>>>>>>>
> >>>>>>>>> I'm trying to migrate the TI AM65x IOT2050 boards to OF_UPSTREAM but I'm
> >>>>>>>>> facing issues because I need to still build the u-boot-only overlays. It
> >>>>>>>>> is also a bit weird (but works) having to specify
> >>>>>>>>>
> >>>>>>>>> CONFIG_SPL_OF_LIST="../../../../arch/arm/dts/k3-am65-iot2050-spl"
> >>>>>>>>>
> >>>>>>>
> >>>>>>> Actually, this does NOT work: I just had a long morning debugging SPL
> >>>>>>> which no longer started because it picked the non-filtered dtb. The
> >>>>>>> filtered one ended up in a folder outside of the u-boot sources because
> >>>>>>> of all those ../ and hard-wiring to dts/upstream.
> >>>>>>>
> >>>>>>>>> for our spl dtb.
> >>>>>>>>>
> >>>>>>>>> Are there means to still build certain dtb[o] files in arch/<arch>/dts?
> >>>>>>>>> I'm a bit lost in the Makefile forest.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Sumit: Any suggestions?
> >>>>>>>>
> >>>>>
> >>>>> Apologies for the delayed reply. I was a bit busy with other high
> >>>>> priority stuff.
> >>>>>
> >>>>>>>
> >>>>>>> I would really like to hear some better proposals than my local
> >>>>>>> workarounds to far. They don't converge although I already patched some
> >>>>>>> core Makefile (overlays are building now).
> >>>>>>>
> >>>>>>
> >>>>>> OK, I side-stepped the spl issue by using one of our variant DTBs for
> >>>>>> spl as well - happens to work.
> >>>>>
> >>>>> That's good to know.
> >>>>>
> >>>>>>
> >>>>>> For the overlays, I need to add
> >>>>>>
> >>>>>> --- a/scripts/Makefile.dts
> >>>>>> +++ b/scripts/Makefile.dts
> >>>>>> @@ -1,5 +1,7 @@
> >>>>>>  # SPDX-License-Identifier: GPL-2.0+
> >>>>>>
> >>>>>> +include $(srctree)/config.mk
> >>>>>> +
> >>>>>>  dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
> >>>>>>
> >>>>>>  ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
> >>>>>>
> >>>>>>
> >>>>>> in order to then be able to do
> >>>>>>
> >>>>>> --- a/board/siemens/iot2050/config.mk
> >>>>>> +++ b/board/siemens/iot2050/config.mk
> >>>>>> @@ -5,4 +5,12 @@
> >>>>>>  # Authors:
> >>>>>>  #   Jan Kiszka <jan.kiszka@siemens.com>
> >>>>>>
> >>>>>> +ifneq ($(CONFIG_SPL_BUILD),y)
> >>>>>> +dtbo-list = \
> >>>>>> +       k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay \
> >>>>>> +       k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay
> >>>>>> +
> >>>>>> +dtb-y += $(patsubst %,../../../../arch/arm/dts/%.dtbo,$(dtbo-list))
> >>>>>> +endif
> >>>>>> +
> >>>>>>  flash.bin: all
> >>>>>>
> >>>>>>
> >>>>>> Does that make sense?
> >>>>>
> >>>>> A switch to OF_UPSTREAM means that we build all the DT artifacts from
> >>>>> dts/upstream/src/ directory with the only exception that we include
> >>>>> U-Boot specific overrides via *-u-boot.dtsi from arch/<arch>/dts. In
> >>>>> case of overlays, is there any reason for IOT2050 board overlays not
> >>>>> being pushed into Linux kernel repo? AFAIU, overlays are also
> >>>>> describing puggable hardware so they shouldn't be referred to as
> >>>>> "u-boot-only" overlays.
> >>>>
> >>>> We are using the overlay to massage the DT presented to the OS based on
> >>>> firmware configuration.
> >>>
> >>> Agree and more than that I prefer the firmware to own the overall DT
> >>> and present that to the OS.
> >>>
> >>>> So, those two belong to the firmware logically,
> >>>> but - with some disclaimers, we could also try to upstream them.
> >>>
> >>> For historical reasons, Linux kernel source tree has become the
> >>> defacto upstream repo for DT sources. So it's better to contribute
> >>> there and sync back in U-Boot.
> >>
> >> Will do ASAP, hope to hit at least 6.12 then.
> >>
> >> Still, this will delay our next patches for U-Boot by many months. Also
> >> for that reason, a plan B for U-Boot local DTs should remain, no
> >> left-or-right policy.
> >
> > Yeah, the U-Boot local DTs should be used until the board is fully
> > supported by the dts/upstream directory.
> >
>
> This is not what I mean and won't help: Given the longer pipeline, it
> should remain possible to carry also local changes after switching to
> OF_UPSTREAM and while waiting for upstreaming to be done - if ever. We
> are missing middle ground.

For local changes we already have the middle ground as *-u-boot.dtsi.
Also, cherry-picking [1] from upstream rc* releases is pretty
effective in shortening that pipeline. However, building DTB artifacts
from multiple directories is going to make Makefiles messy and in turn
will be difficult to be consumed by packaging tools like binman. Your
Makefile change demonstrates it too. But if you can come up with a
cleaner solution then I will be happy to review that.

[1] https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing

-Sumit

>
> Jan
>
> --
> Siemens AG, Technology
> Linux Expert Center
>
