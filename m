Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A912FC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 11:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 192E987D70;
	Fri, 19 Apr 2024 13:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BO74pwRA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0DB087D64; Fri, 19 Apr 2024 13:35:07 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B226D880B5
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 13:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56c5d05128dso1776369a12.0
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 04:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713526504; x=1714131304; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d73BFBkRWFoRnbOyhyZ6VuH5g2wM6EPAG+iyn78pM/U=;
 b=BO74pwRAFSa0c+w18pgFg09t4rwTq6QLN94n0mZuGFpKB4WqtFPLT4Rvg1rJXArKF2
 IMEtCLM8XGva4Mot0n1+uMPmex4NDZA0GgGuJ8psl4jbrHzPxkp8Xr1UjGfrWsyIyRJ8
 USgO5sXhbCb/nckAfhhJOXBJARMNbAliiTuGK6LtOL9oaDrKkGo1ixunPynFyDpDco4C
 I/RwK8B2niQRpOCgD6X0u56ULmvNdDaWM5NBuuJstOVvBjgrVyEkLHOVwJ7kqSeqIIK/
 4YEwCwb7MisT9ZflNYDc6QEdUA4J/NDzEOOu7Uj8JB8Xu1xVq1FxaJ2Fk6WtqPcMrHgC
 KhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713526504; x=1714131304;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d73BFBkRWFoRnbOyhyZ6VuH5g2wM6EPAG+iyn78pM/U=;
 b=biXtalOtYeCvz6Vr1UfYbzaDqeN5Kpu0c7YNFnLAZntNNDQzcTE6bIbXNnwsXBAlbo
 NdyN16Yw0NsEUyfhG0K+oddXhHQ1iVY3Z1Z1iKa9aR3ZuNnsc673kJazjRDZi0hEL7A6
 vz03LsHWFSF4OiTzojIcmRpXMbTqnqoYj7B8UuwSv/WWmAVPUcbfkTCQAdSm175wFGuP
 yjXHTOP0hvga4vqZn5sVeLyZXXd0MOFAvgbURopwEaX77I83pQ9PsFea3Gb4clbeLO91
 riGrAR7yKGNlfPkAArHnCuf0pSIKNTEH8FBUPjQBBHEf38ynkSar9joB9IpkFswMQaIB
 lChA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZdInIsRBrfOdY0QhnoiLs2Qth+J4tC65v/qSp4tZrOkcI1zzjuLw7Kd6jdIGZnGAvvJGB+kQattW3/YTWbgmv1/wD2Q==
X-Gm-Message-State: AOJu0Ywg0Hrzrf5/IufEILnm7Mu/e4XwsUzkqPBUGd2rTh1S7NKxs3lx
 TPCHN7675TrW3q1n3VUaHDLWosfa8T6oHN6rCll4HtYCI2vcJWjo6huH0TqXc6XFRQC7UXCsvXU
 xcbCCGB9Hkm8Xzwh+U6e1XdoZ4Dzs+ZoPjNBnsQ==
X-Google-Smtp-Source: AGHT+IFAGgduTJGfNdXHZDZosmEvFmVCwv8KxIiWwkBf4wwQUuKRMLY/k5HRkuHerqydVkMQgB/2SDKnjcZw6MDAwAs=
X-Received: by 2002:a50:c010:0:b0:56e:e76:6478 with SMTP id
 r16-20020a50c010000000b0056e0e766478mr1255114edb.31.1713526503982; Fri, 19
 Apr 2024 04:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240112132607.GO1610741@bill-the-cat>
 <a1d7ca85-8723-4d73-8e1c-357c6aa6294f@ti.com>
 <20240120164141.GA3652023@bill-the-cat>
 <48c63fc4-9f06-4066-b206-a0a548936dcd@ti.com>
 <892b473b-5b76-4e44-af27-52d50cb24877@ti.com>
 <20240411220741.GJ2493117@bill-the-cat>
 <2406c7be-114c-4082-9c14-1cd59917b9d8@ti.com>
 <20240416170027.GQ1054907@bill-the-cat>
 <97f84067-ba36-47f6-befa-221be47a1d25@ti.com>
 <CADg8p97udLbFvbZ_FZf9Hfwg3R4=YJMNWrAtqvu97mL7vVYREQ@mail.gmail.com>
 <20240417160446.GF1054907@bill-the-cat>
 <42fd6f28-bcf6-406c-8d43-7b4f3966ebb2@ti.com>
 <CADg8p94KVFS+UUzb1K+QY8LUcZjE-DT=RSCpUbD=WyhGKZbJ0g@mail.gmail.com>
 <7c0637a5-97c7-4eed-a0d2-52b14d03dda2@ti.com>
In-Reply-To: <7c0637a5-97c7-4eed-a0d2-52b14d03dda2@ti.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 19 Apr 2024 17:04:52 +0530
Message-ID: <CADg8p96MfnnQkPkddiURuxmUHjWW2KZU9VgWwrUPH6e21vjUqQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] board: ti: am62x: Init DRAM size in R5/A53 SPL
To: Chintan Vankar <c-vankar@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 nm@ti.com, afd@ti.com, 
 vigneshr@ti.com, dannenberg@ti.com, srk@ti.com, joe.hershberger@ni.com, 
 simon.k.r.goldschmidt@gmail.com, sjg@chromium.org, marex@denx.de, 
 u-boot@lists.denx.de
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

On Fri, 19 Apr 2024 at 16:04, Chintan Vankar <c-vankar@ti.com> wrote:
>
>
>
> On 18/04/24 17:30, Sughosh Ganu wrote:
> > On Thu, 18 Apr 2024 at 16:08, Chintan Vankar <c-vankar@ti.com> wrote:
> >>
> >>
> >>
> >> On 17/04/24 21:34, Tom Rini wrote:
> >>> On Wed, Apr 17, 2024 at 05:48:31PM +0530, Sughosh Ganu wrote:
> >>>> hi Chintan,
> >>>>
> >>>> On Wed, 17 Apr 2024 at 13:21, Chintan Vankar <c-vankar@ti.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 16/04/24 22:30, Tom Rini wrote:
> >>>>>> On Tue, Apr 16, 2024 at 05:52:58PM +0530, Chintan Vankar wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> On 12/04/24 03:37, Tom Rini wrote:
> >>>>>>>> On Wed, Apr 03, 2024 at 06:18:01PM +0530, Chintan Vankar wrote:
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> On 22/01/24 10:11, Siddharth Vadapalli wrote:
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> On 20/01/24 22:11, Tom Rini wrote:
> >>>>>>>>>>> On Mon, Jan 15, 2024 at 01:42:51PM +0530, Siddharth Vadapalli wrote:
> >>>>>>>>>>>> Hello Tom,
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 12/01/24 18:56, Tom Rini wrote:
> >>>>>>>>>>
> >>>>>>>>>> ...
> >>>>>>>>>>
> >>>>>>>>>>>>> The list of conditionals in common/spl/spl.c::board_init_r() should be
> >>>>>>>>>>>>> updated and probably use SPL_NET as the option to check for.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Thank you for reviewing the patch and pointing this out. I wasn't aware of it. I
> >>>>>>>>>>>> assume that you are referring to the following change:
> >>>>>>>>>>>>
> >>>>>>>>>>>>              if (IS_ENABLED(CONFIG_SPL_OS_BOOT) || CONFIG_IS_ENABLED(HANDOFF) ||
> >>>>>>>>>>>> -           IS_ENABLED(CONFIG_SPL_ATF))
> >>>>>>>>>>>> +           IS_ENABLED(CONFIG_SPL_ATF) || IS_ENABLED(CONFIG_SPL_NET))
> >>>>>>>>>>>>                      dram_init_banksize();
> >>>>>>>>>>>>
> >>>>>>>>>>>> I shall replace the current patch with the above change in the v2 series. Since
> >>>>>>>>>>>> this is in the common section, is there a generic reason I could provide in the
> >>>>>>>>>>>> commit message rather than the existing commit message which seems to be board
> >>>>>>>>>>>> specific? Also, I hope that the above change will not cause regressions for
> >>>>>>>>>>>> other non-TI devices. Please let me know.
> >>>>>>>>>>>
> >>>>>>>>>>> Yes, that's the area, and just note that networking also requires the
> >>>>>>>>>>> DDR to be initialized.
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Thank you for confirming and providing your suggestion for the contents of the
> >>>>>>>>>> commit message.
> >>>>>>>>>>
> >>>>>>>>> Following Tom's Suggestion of adding CONFIG_SPL_NET in common/spl/spl.c
> >>>>>>>>> "dram_init_banksize()", the issue of fetching a file at SPL stage seemed
> >>>>>>>>> to be fixed. However the commit "ba20b2443c29", which sets gd->ram_top
> >>>>>>>>> for the very first time in "spl_enable_cache()" results in
> >>>>>>>>> "arch_lmb_reserve()" function reserving memory region from Stack pointer
> >>>>>>>>> at "0x81FFB820" to gd->ram_top pointing to "0x100000000". Previously
> >>>>>>>>> when gd->ram_top was zero "arch_lmb_reserve()" was noop. Now using TFTP
> >>>>>>>>> to fetch U-Boot image at SPL stage results in "tftp_init_load_addr()"
> >>>>>>>>> function call that invokes "arch_lmb_reserve()" function, which reserves
> >>>>>>>>> entire memory starting from Stack Pointer to gd->ram_top leaving no
> >>>>>>>>> space to load U-Boot image via TFTP since TFTP loads files at pre
> >>>>>>>>> configured memory address at "0x82000000".
> >>>>>>>>>
> >>>>>>>>> As a workaround for this issue, one solution we can propose is to
> >>>>>>>>> disable the checks "lmb_get_free_size()" at SPL and U-Boot stage. For
> >>>>>>>>> that we can define a new config option for LMB reserve checks as
> >>>>>>>>> "SPL_LMB". This config will be enable by default for the backword
> >>>>>>>>> compatibility and disable for our use case at SPL and U-Boot stage.
> >>>>>>>>
> >>>>>>>> The problem here is that we need LMB for booting an OS, which is
> >>>>>>>> something we'll want in SPL in non-cortex-R cases too, which means this
> >>>>>>>> platform, so that's a no-go. I think you need to dig harder and see if
> >>>>>>>> you can correct the logic somewhere so that we don't over reserve?
> >>>>>>>>
> >>>>>>> Since this issue is due to function call "lmb_init_and_reserve()"
> >>>>>>> function invoked from "tftp_init_load_addr()" function. This function
> >>>>>>> is defined by Simon in commit "a156c47e39ad", which fixes
> >>>>>>> "CVE-2018-18439" to prevent overwriting reserved memory. Simon, can you
> >>>>>>> explain why do we need to call "lmb_init_and_reserve()" function here ?
> >>>>>>
> >>>>>> This is indeed a tricky area which is why Sughosh is looking in to
> >>>>>> trying to re-work the LMB mechanic and we've had a few long threads
> >>>>>> about it as well.
> >>>>>>
> >>>>>> I've honestly forgotten the use case you have here, can you please
> >>>>>> remind us?
> >>>>>>
> >>>>> We are trying to boot AM62x using Ethernet for which we need to load
> >>>>> binary files at SPL and U-Boot stage using TFTP. To store the file we
> >>>>> need a free memory in RAM, specifically we are storing these files at
> >>>>> 0x82000000. But we are facing an issue while loading the file since
> >>>>> the memory area having an address 0x82000000 is reserved due to
> >>>>> "lmb_init_and_reserve()" function call. This function is called in
> >>>>> "tftp_init_load_addr()" function which is getting called exactly before
> >>>>> we are trying to get the free memory area by calling
> >>>>> "lmb_get_free_size()".
> >>>>
> >>>> I have no idea about your platform but I was wondering if there is any
> >>>> particular importance of the load address of 0x82000000? It looks as
> >>>> though the current location of the SP when arch_lmb_reserve() gets
> >>>> called means that the load address is getting reserved for the U-Boot
> >>>> image. Do you not have the option of loading the image at a lower
> >>>> address instead?
> >>>
> >>
> >> Sughosh,
> >>
> >> I think my explanation was not clear at:
> >> "We are trying to boot AM62x using Ethernet for which we need to load
> >> binary files at SPL and U-Boot stage using TFTP."
> >> - In Ethernet Booting we are fetching U-Boot image at SPL stage via
> >> TFTP at specified address 0x82000000. While loading U-Boot image we are
> >> getting TFTP error, since address from stack pointer till gd->ram_top is
> >> reserved due to "lmb_init_and_reserve()" function call. I want to know
> >> for which purpose this address range is reserved.
> >
> > On relocation, the U-Boot image is located typically at the top of the
> > DRAM memory used by U-Boot(ram_top). That region of memory is reserved
> > to ensure that the memory occupied by the U-Boot image does not get
> > overwritten by a LMB reservation.
> >
>
> Yes, you are correct about U-Boot relocation but we are facing an issue
> at the time of fetching U-Boot proper at SPL stage.

The arch_lmb_reserve_generic() function would reserve the memory
region from the ram_top to the current SP.  Btw, you mentioned in an
earlier reply that you are trying to load the U-Boot image at
0x82000000. From the config file it looks like that is the address of
your SPL stack in RAM. So you might be overwriting your SPL stack. I
think you can try a couple of things. One, move the SPL image above
the SPL stack, like it is with U-Boot -- I think the way things stand,
the SPL image is at a lower address than the SP. And then use a lower
address to load the U-Boot image with tftp.

-sughosh

>
> > Btw, are you facing this issue in SPL, or U-Boot proper? I built the
> > images for the am62x_evm_a53 config, and I don't see the
>
> We are getting "TFTP error" at runtime while fetching U-Boot proper at
> SPL stage while booting via "Ethernet", and we are using
> "am62x_evm_a53_ethboot_defconfig" instead of "am62x_evm_a53_defconfig".
>
> These are the extra configs we are using on top of
> "am62x_evm_a53_defconfig":
>
> CONFIG_SPL_DRIVERS_MISC=y
> CONFIG_SPL_BOARD_INIT=y
> CONFIG_SPL_DMA=y
> CONFIG_SPL_ENV_SUPPORT=y
> CONFIG_SPL_ETH=y
> CONFIG_SPL_NET=y
> CONFIG_SPL_NET_VCI_STRING="AM62X U-Boot A53 SPL"
> CONFIG_SPL_SYSCON=y
>
> > arch_lmb_reserve() function getting included in the SPL image -- both
> > the .text.arch_lmb_reserve and .text.arch_lmb_reserve_generic are part
> > of discarded sections. So I am wondering how you are observing this
> > behaviour in SPL.
> >
> > -sughosh
> >
> >>
> >>> Or using a higher address for SPL stack? You might be able to solve this
> >>> just by re-examining which addresses (and RAM size limitations) need to
> >>> be considered here.
> >>>
> >>
> >> Tom,
> >>
> >> We tried this approach of assigning a higher address for SPL stack, but
> >> it is not working as expected.
