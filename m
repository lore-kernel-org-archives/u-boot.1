Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94EBC5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 07:10:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02B858852A;
	Mon, 26 Aug 2024 09:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dE97dB40";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA02888481; Mon, 26 Aug 2024 09:10:44 +0200 (CEST)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C41187A09
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 09:10:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-498e1fea1a7so1093302137.3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 00:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724656241; x=1725261041; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E5ymnVQN+su/UeJqKDIaspeoIw+e1Mu/fib3zQMWw7Q=;
 b=dE97dB40zey/1byTl3aoID0A/UcFaCLxpfo+H+X5M0T+ZQNzZM5bpA1ncyyira6438
 Ybt3aCfN5TSHDcB/2My7KlQQkYvDJ4W69AmZWcNVb+tK5ywR+JZ9Osesw+Lx+GApR/p7
 yFLfz0YIdJtWHRZuFmtE6cx/pXuG5ySNAqQowPuJ/JPZCJqJDOnhGwi1bRGcrBj5x2z4
 v23h90iJlo7+ltsZRjqMp5iXxfg7qTYTEqth64A2fen5i3S7rJHxr5qptVJAmHIkUrki
 ceZWuksCiz2CGCPZRgdyBBIw5hlfMnKQyxQRLS4f6o7kWEZfU4aLrsVyP5o+aGx3MB2r
 2juA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724656241; x=1725261041;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E5ymnVQN+su/UeJqKDIaspeoIw+e1Mu/fib3zQMWw7Q=;
 b=XytOrlAwoyu+CXVvW73xo8kuHwldD/bkdZPX5OLvRDgjkov1zuig3I/b0ta+AhlvEN
 tgLSsB/gwpWBn1iAXYj8lb/w+AjYwMMVBXN8MGKY5IzzfKfRry8RNIe+XmZzqUMKxdih
 FnxYRhKkm01cxrOK0BGmHCChlKjeQU2QweGxarLumRpxWME/oPnBQRo50tSl0Dko7G+W
 Uvuc5NnzfPEiKcWrnzCHwNEr0xncI+oaEY8AZ0g0RuBoXhUl1+Hy7c7UAOhT9rlf5tu2
 8xwlKltvlj/zhgDjRx+0piQB8CLKIywzFsAkX2KI5PtyNtxvXyUqMeu+CERfqhoTud76
 z8JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYNV1uDhv3KqcqKIErYB6qyFOqA3jjOqGmGU5CSrNOb2S6VxMAUNiAUOG+xIcrLIXebT2vNDU=@lists.denx.de
X-Gm-Message-State: AOJu0YyRQsxGdVG1XNUIjthj4BJ7r0jAXDLPwb/XcVV4+9te39HXehDn
 yMASsmaksswPclloymu4lHCGstKGW+cJt8kyUs2eyrngJykEQuCq2jreCadcjN1184UarI12AQO
 brbVK2SH3ylclhPCzw1uRc+W+A0YfgQLQeRYlfw==
X-Google-Smtp-Source: AGHT+IHUgLq7NbIhMQmgh4YMqJhvgSLve2LfVbd616gmPmSTi6SbNvYXS9yUqFyCpLxGTPsVKH3DNoTgD+rgVvZrzRk=
X-Received: by 2002:a05:6102:3710:b0:498:d1b0:210f with SMTP id
 ada2fe7eead31-498f45bd779mr7244459137.11.1724656241065; Mon, 26 Aug 2024
 00:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <7765273f-7f36-41e4-a604-1901e4fbec62@siemens.com>
 <20240813125245.ezlu6me3ljwx6dkj@margarine>
 <89f8e976-e831-4035-8cd0-ab6284846d0a@siemens.com>
 <4ec5108f-b7a4-47db-baa4-edee532c58af@siemens.com>
 <CAFA6WYMQustcwo4Es7iJQj5Lva6UiYJ-j7WgSzMjOvEHemeDcQ@mail.gmail.com>
 <4576b818-9732-45ff-a4ab-b98fc0ecf4c9@siemens.com>
In-Reply-To: <4576b818-9732-45ff-a4ab-b98fc0ecf4c9@siemens.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 26 Aug 2024 12:40:30 +0530
Message-ID: <CAFA6WYNXgJkCX9-aoL5FGchAHGdV+ikTt4+pTJP-jZ_UJG8E6Q@mail.gmail.com>
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

On Mon, 26 Aug 2024 at 12:19, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 26.08.24 08:44, Sumit Garg wrote:
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
> We are using the overlay to massage the DT presented to the OS based on
> firmware configuration.

Agree and more than that I prefer the firmware to own the overall DT
and present that to the OS.

> So, those two belong to the firmware logically,
> but - with some disclaimers, we could also try to upstream them.

For historical reasons, Linux kernel source tree has become the
defacto upstream repo for DT sources. So it's better to contribute
there and sync back in U-Boot.

-Sumit

>
> Jan
>
> --
> Siemens AG, Technology
> Linux Expert Center
>
