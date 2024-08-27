Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D071C52D6F
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 07:13:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9829C886CC;
	Tue, 27 Aug 2024 09:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MaYA/S4U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B25EC886CC; Tue, 27 Aug 2024 09:13:55 +0200 (CEST)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72ACB8831F
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 09:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-498d0268541so2730966137.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 00:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724742832; x=1725347632; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JvpLjetmEy9aYlXGjIK1OuE7V5H2HYXTgPQz1s8K4g0=;
 b=MaYA/S4UpKfhEYs6YwABqsewQtVaaCccIuHHbuUA0gmd71jUBAWsXmFSj9c+4gLTzT
 rePs64EnCxZbfkBJmt90VXnFsL77EqOahEEPktqy+Z7hIO7qMFxIcR5lLV7mw3aWrXag
 cORcF4Htp0+FkdjHM9yGQvJuWLyamwg+xIzd/ZmS5FUqS3FL/2TST6dpAqpamCmL5i4+
 xsqEg0nFKTRd74KrE72fvEGzNRh7y9AyBpxeTHKDss6RC7r2ZuiiGRMJvHj3OgXFeWdH
 xTdqkpV8MnpbhOA2ijLYprJT7TZznHbQ8rJl/D2GKk7RcmXLwOT3Jb2k+BE3iIVKvkG2
 meyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724742832; x=1725347632;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JvpLjetmEy9aYlXGjIK1OuE7V5H2HYXTgPQz1s8K4g0=;
 b=KBVQHYMtcbNP3oUaiwCvfpli+EC65JYCLmxYMhhLz+5v5smjpwhdTcIx8wIJU6vKp2
 e6XAfPRXF1C5jLEX+nwo/IpX/SD88vAcuybWOrbWD0m62oTF0Odek3FpTUMN6wb0ljhb
 rcq4HtFp+ZIOe44DOMhKejVa2OW2MHKtobsDft+XcDMAHBZ7msrStAZzdIPRTVxkQnzm
 bdkr8gnNWIL9/+t4+4J3fnvdhh99GUrqPf3Z1GCayYYWIo1T41+UhFZQ0yrDf9e7bSe2
 3dydP9ri9cN9QBrvjxAtuET3fduRrF87EUVXJuvngmbRsI1o68ijiGpIpHlbDXH1QAnZ
 f9VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIADCuc6WAC5aVTE4YoLE1Sd9WnoDd0yS1AwtWBqrSkCNp8glWoKeODKW+nVGmDA/o4muh4pY=@lists.denx.de
X-Gm-Message-State: AOJu0YxGEVoE9UMxH3wiUgQtW0khcJojRqaNzqYM7108tMUGDpRujSDQ
 flftwGB/Hs/UptEsd0Fzuva86yT+BLWQ9K34Vrvt3guBxtKCZz/QmqN3ri+RhuF+QE71o3sCN8A
 B1eDNhW+EJ85GOObjUX2aeHs7/+B9AZgi5IR82g==
X-Google-Smtp-Source: AGHT+IH8rF2v9lEQ3Aj65iorVTNLfsR1ig+iQR6XA0v7tCaj8i6y6bn64N4JgueF75+DgH1jFKRicaX/fCR2ESY1CoY=
X-Received: by 2002:a05:6102:2ac6:b0:495:c34d:ab5d with SMTP id
 ada2fe7eead31-49a3bd27ec0mr1561545137.13.1724742832121; Tue, 27 Aug 2024
 00:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <7765273f-7f36-41e4-a604-1901e4fbec62@siemens.com>
 <20240813125245.ezlu6me3ljwx6dkj@margarine>
 <89f8e976-e831-4035-8cd0-ab6284846d0a@siemens.com>
 <4ec5108f-b7a4-47db-baa4-edee532c58af@siemens.com>
 <CAFA6WYMQustcwo4Es7iJQj5Lva6UiYJ-j7WgSzMjOvEHemeDcQ@mail.gmail.com>
 <4576b818-9732-45ff-a4ab-b98fc0ecf4c9@siemens.com>
 <CAFA6WYNXgJkCX9-aoL5FGchAHGdV+ikTt4+pTJP-jZ_UJG8E6Q@mail.gmail.com>
 <87a9fe3e-5d9a-41e8-a8b2-4368cb727a65@siemens.com>
In-Reply-To: <87a9fe3e-5d9a-41e8-a8b2-4368cb727a65@siemens.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 27 Aug 2024 12:43:41 +0530
Message-ID: <CAFA6WYMGyMAB=m-hkxs87PyHszcbQUk6+0_G0n+0-Yk8NeRXQQ@mail.gmail.com>
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

On Mon, 26 Aug 2024 at 18:02, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 26.08.24 09:10, Sumit Garg wrote:
> > On Mon, 26 Aug 2024 at 12:19, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>
> >> On 26.08.24 08:44, Sumit Garg wrote:
> >>> Hi,
> >>>
> >>> On Wed, 14 Aug 2024 at 22:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>>>
> >>>> On 14.08.24 11:41, Jan Kiszka wrote:
> >>>>> On 13.08.24 14:52, Nishanth Menon wrote:
> >>>>>> On 11:16-20240813, Jan Kiszka wrote:
> >>>>>>> Hi all,
> >>>>>>>
> >>>>>>> I'm trying to migrate the TI AM65x IOT2050 boards to OF_UPSTREAM but I'm
> >>>>>>> facing issues because I need to still build the u-boot-only overlays. It
> >>>>>>> is also a bit weird (but works) having to specify
> >>>>>>>
> >>>>>>> CONFIG_SPL_OF_LIST="../../../../arch/arm/dts/k3-am65-iot2050-spl"
> >>>>>>>
> >>>>>
> >>>>> Actually, this does NOT work: I just had a long morning debugging SPL
> >>>>> which no longer started because it picked the non-filtered dtb. The
> >>>>> filtered one ended up in a folder outside of the u-boot sources because
> >>>>> of all those ../ and hard-wiring to dts/upstream.
> >>>>>
> >>>>>>> for our spl dtb.
> >>>>>>>
> >>>>>>> Are there means to still build certain dtb[o] files in arch/<arch>/dts?
> >>>>>>> I'm a bit lost in the Makefile forest.
> >>>>>>>
> >>>>>>
> >>>>>> Sumit: Any suggestions?
> >>>>>>
> >>>
> >>> Apologies for the delayed reply. I was a bit busy with other high
> >>> priority stuff.
> >>>
> >>>>>
> >>>>> I would really like to hear some better proposals than my local
> >>>>> workarounds to far. They don't converge although I already patched some
> >>>>> core Makefile (overlays are building now).
> >>>>>
> >>>>
> >>>> OK, I side-stepped the spl issue by using one of our variant DTBs for
> >>>> spl as well - happens to work.
> >>>
> >>> That's good to know.
> >>>
> >>>>
> >>>> For the overlays, I need to add
> >>>>
> >>>> --- a/scripts/Makefile.dts
> >>>> +++ b/scripts/Makefile.dts
> >>>> @@ -1,5 +1,7 @@
> >>>>  # SPDX-License-Identifier: GPL-2.0+
> >>>>
> >>>> +include $(srctree)/config.mk
> >>>> +
> >>>>  dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
> >>>>
> >>>>  ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
> >>>>
> >>>>
> >>>> in order to then be able to do
> >>>>
> >>>> --- a/board/siemens/iot2050/config.mk
> >>>> +++ b/board/siemens/iot2050/config.mk
> >>>> @@ -5,4 +5,12 @@
> >>>>  # Authors:
> >>>>  #   Jan Kiszka <jan.kiszka@siemens.com>
> >>>>
> >>>> +ifneq ($(CONFIG_SPL_BUILD),y)
> >>>> +dtbo-list = \
> >>>> +       k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay \
> >>>> +       k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay
> >>>> +
> >>>> +dtb-y += $(patsubst %,../../../../arch/arm/dts/%.dtbo,$(dtbo-list))
> >>>> +endif
> >>>> +
> >>>>  flash.bin: all
> >>>>
> >>>>
> >>>> Does that make sense?
> >>>
> >>> A switch to OF_UPSTREAM means that we build all the DT artifacts from
> >>> dts/upstream/src/ directory with the only exception that we include
> >>> U-Boot specific overrides via *-u-boot.dtsi from arch/<arch>/dts. In
> >>> case of overlays, is there any reason for IOT2050 board overlays not
> >>> being pushed into Linux kernel repo? AFAIU, overlays are also
> >>> describing puggable hardware so they shouldn't be referred to as
> >>> "u-boot-only" overlays.
> >>
> >> We are using the overlay to massage the DT presented to the OS based on
> >> firmware configuration.
> >
> > Agree and more than that I prefer the firmware to own the overall DT
> > and present that to the OS.
> >
> >> So, those two belong to the firmware logically,
> >> but - with some disclaimers, we could also try to upstream them.
> >
> > For historical reasons, Linux kernel source tree has become the
> > defacto upstream repo for DT sources. So it's better to contribute
> > there and sync back in U-Boot.
>
> Will do ASAP, hope to hit at least 6.12 then.
>
> Still, this will delay our next patches for U-Boot by many months. Also
> for that reason, a plan B for U-Boot local DTs should remain, no
> left-or-right policy.

Yeah, the U-Boot local DTs should be used until the board is fully
supported by the dts/upstream directory.

-Sumit

>
> Jan
>
> --
> Siemens AG, Technology
> Linux Expert Center
>
