Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB367C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 22:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 153028703A;
	Sat,  4 Nov 2023 23:58:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dF1eptv5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AC7B87087; Sat,  4 Nov 2023 23:58:39 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0B5B87034
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 23:58:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5441305cbd1so3212941a12.2
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 15:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699138716; x=1699743516; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QTWGSyajHbKkPFoXMQwXgJ63hwcmVShWXksOOjcYMxU=;
 b=dF1eptv544dIw2+o3sx8EOyu/jyeZ5L/gBw+5JxONYtXOy4wq7GcyBJK6+1Tsr42Pp
 Xo7khfeh/vGnGOpWb9ImgngnbAeicxb+Yur8dbs+Ua+OXsLaVGkAQf9mTlg1z7E4+trN
 A70WmkHnmFOC6dZrxVIqqguWmvqNjgnZRjJBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699138716; x=1699743516;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QTWGSyajHbKkPFoXMQwXgJ63hwcmVShWXksOOjcYMxU=;
 b=E5m7BDOWONKU9l32vtLur49fcoYvvW73nc1vqb7P8GEQWhHoONym5cqocRlAtHbwQC
 s/Gh2lbKpnLCwDJaf6Pr13kaj51OTO9p4c1suB1sPfApmMa2LRmvEhAo42GA0UOEUZOC
 Z30m0iHa1HE56tND2oJ5BBu/TNU5vUE5ic0+L8HancFOzQUdSfkmizBI72XwgFBytbEy
 KcPOd3dE59muHeA+EY9oI9t0OvWy51HehpvP39qe/Feu8VKePaeWGiS/pVdwcxuKgf+p
 wk2McsMXTPUP9UK2YCtjDexuR4KeYpk9u/3LviZ0EOrg4arggNbF//jscSSby2SaIdFH
 dqEA==
X-Gm-Message-State: AOJu0YzHmXms9K52fbP1IY5OMS4Vo3wr6HOLwdkK9vylmJaTl1KC6ICa
 sesU6uCZUv9gixxzz72NZ4M4Suzi3WJxglufZkkoNQ==
X-Google-Smtp-Source: AGHT+IGP0hzCB/RZVV5YTglHqicgK/ufsZYirziZX8aFsCjs0GpI8qsOmY/OELBnyX28OeWdUmByczkV8u1SADCnyCI=
X-Received: by 2002:a50:9985:0:b0:543:8548:6ea4 with SMTP id
 m5-20020a509985000000b0054385486ea4mr7660565edb.40.1699138716059; Sat, 04 Nov
 2023 15:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231031125552.26698-1-heinrich.schuchardt@canonical.com>
 <20231101170559.680ab493@donnerap.manchester.arm.com>
 <50ff2080-5831-4963-937d-331248b59973@canonical.com>
 <CAPnjgZ1gPRQiEq8=tVCtC6wznOWXX2bLaimSwd73=74oEWAXYQ@mail.gmail.com>
 <20231104171212.3d041a4f@slackpad.lan>
 <CAPnjgZ1X8R4h24pP1zoqEADTbntm5Yo2YqfMTePVqbHoJMx_vA@mail.gmail.com>
 <335552b4-f5af-4a67-8f40-e91582c18343@canonical.com>
In-Reply-To: <335552b4-f5af-4a67-8f40-e91582c18343@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 4 Nov 2023 22:58:24 +0000
Message-ID: <CAPnjgZ2k9r4=BDkEAcj=z5kk=kWyC8ne7_U21HTffdWneaJP7Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Anup Patel <apatel@ventanamicro.com>, Xiang W <merlew4n6@gmail.com>, 
 Chanho Park <chanho61.park@samsung.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 u-boot@lists.denx.de, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Alexey Romanov <avromanov@salutedevices.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>
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

Hi Heinrich,

On Sat, 4 Nov 2023 at 20:36, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 11/4/23 21:45, Simon Glass wrote:
> > Hi Andre,
> >
> > On Sat, 4 Nov 2023 at 17:13, Andre Przywara <andre.przywara@arm.com> wrote:
> >>
> >> On Fri, 3 Nov 2023 13:38:58 -0600
> >> Simon Glass <sjg@chromium.org> wrote:
> >>
> >> Hi Simon,
> >>
> >>> Hi Heinrich,
> >>>
> >>> On Wed, 1 Nov 2023 at 14:20, Heinrich Schuchardt
> >>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>
> >>>> On 11/1/23 19:05, Andre Przywara wrote:
> >>>>> On Tue, 31 Oct 2023 14:55:50 +0200
> >>>>> Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
> >>>>>
> >>>>> Hi Heinrich,
> >>>>>
> >>>>>> The Zkr ISA extension (ratified Nov 2021) introduced the seed CSR. It
> >>>>>> provides an interface to a physical entropy source.
> >>>>>>
> >>>>>> A RNG driver based on the seed CSR is provided. It depends on
> >>>>>> mseccfg.sseed being set in the SBI firmware.
> >>>>>
> >>>>> As you might have seen, I added a similar driver for the respective Arm
> >>>>> functionality:
> >>>>> https://lore.kernel.org/u-boot/20230830113230.3925868-1-andre.przywara@arm.com/
> >>>>>
> >>>>> And I see that you seem to use the same mechanism to probe and init the
> >>>>> driver: U_BOOT_DRVINFO and fail in probe() if the feature is not
> >>>>> implemented.
> >>>>> One downside of this approach is that the driver is always loaded (and
> >>>>> visible in the DM tree), even with the feature not being available.
> >>>>> That doesn't seem too much of a problem on the first glance, but it
> >>>>> occupies a device number, and any subsequent other DM_RNG devices
> >>>>> (like virtio-rng) typically get higher device numbers. So without
> >>>>> the feature, but with virtio-rng, I get:
> >>>>> VExpress64# rng 0
> >>>>> No RNG device
> >>>
> >>> Why do we get this? If the device is not there, the bind() function
> >>> can return -ENODEV
> >>>
> >>> I see this in U-Boot:
> >>>
> >>> U_BOOT_DRVINFO(cpu_arm_rndr) = {
> >>>
> >>> We should not use this.
> >>
> >> Agreed.
> >>
> >>> Use the devicetree.
> >>
> >> No, this is definitely not something for the DT, at least not on ARM.
> >> It's perfectly discoverable via the architected CPU ID registers.
> >> Similar to PCI and USB devices, which we don't probe via the DT as well.
> >>
> >> It's arguably not proper "driver" material per se, as I've argued before, but
> >> it's the simplest solution and fits in nicely otherwise.
> >>
> >> I was wondering if it might be something for UCLASS_CPU, something like
> >> a "CPU feature bus": to let devices register on one on the many CPU
> >> features (instead of compatible strings), then only bind() those
> >> drivers it the respective bit is set.
> >>
> >> Does that make sense? Would that be doable without boiling the ocean?
> >> As I don't know if we see many users apart from this.
> >
> > I have seen this so many times, where people want to avoid putting
> > things in the DT and then are surprised that everything is difficult,
> > broken and confusing. Why not just follow the rules? It is not just
> > about whether we can avoid it, etc. It is about how devices fit
> > together cohesively in the system, and how U-Boot operates.
>
> The Zkr extension isn't a device. It is an instruction set architecture
> extension. It is represented by the ISA extension strings of the
> respective harts in the device-tree.
>
> If the seed register of the hart can be accessed by U-Boot, is
> determined by bit sseed in the mseccfg register.
>
> I don't expect the encoding of RISC-V ISA extensions in device-trees to
> be changed.

Please just give up with the 'not a device' thing. Let's just say that
a device is a software concept and how we model hardware.

This 'not a device' thing is creating all sorts of problems, to no end.

Nothing is changed until someone sends a patch.

Regards,
Simon



>
> Best regards
>
> Heinrich
>
> >
> >>
> >>>>> VExpress64# rng 1
> >>>>> 00000000: f3 88 b6 d4 24 da 49 ca 49 f7 9e 66 5f 12 07 b2  ....$.I.I..f_...
> >>>>
> >>>>
> >>>> Essentially in any case were you have multiple drivers for the same
> >>>> device using uclass_get_device(, 0, ) and uclass_find_first_device()
> >>>> will only give you the first bound device and not the first successfully
> >>>> probed device. Furthermore neither of this functions causes probing.
> >>>> This is not restricted to the RNG drivers but could also happen with
> >>>> multiple TPM drivers or multiple watchdogs.
> >>>>
> >>>> This patch is related to the problem:
> >>>>
> >>>> [PATCH v1] rng: add dm_rng_read_default() helper
> >>>> https://lore.kernel.org/u-boot/4e28a388-f5b1-4cf7-b0e3-b12a876d0567@gmx.de/T/#me44263ec9141e3ea65ee232aa9a411fc6201bd95
> >>>>
> >>>> We have weak function platform_get_rng_device() which should be moved to
> >>>> drivers/rng/rng-uclass.c.
> >>>>
> >>>> We could add a function to drivers/core/uclass.c to retrieve the first
> >>>> successfully probed device. Another approach would be to implement
> >>>> uclass_driver.post_probe() in the RNG uclass to take note of the first
> >>>> successfully probed device.
> >>>>
> >>>> @Simon:
> >>>> What would make most sense from a DM design standpoint?
> >>>
> >>> I am sure I provided feedback on this at the time, but I don't
> >>> remember. OK I just found it here [1]. So the problem is entirely
> >>> because my feedback was not addressed. Please just address it and
> >>> avoid this sort of mess.
> >>
> >> Yeah, Tom just merged it, but that's not Heinrich's fault ;-)
> >>
> >>> So arm_rndr should have a devicetree compatible string and be bound
> >>> like anything else. If for some reason the device doesn't exist in the
> >>> hardware, it can return -ENODEV from its bind() method.
> >>>
> >>> If you want to control which RNG device is used for booting, you could
> >>> add a property to /bootstd with a phandle to the device. We are trying
> >>> to provide a standard approach to booting in U-Boot, used by all
> >>> methods. Doing one-off things for particular cases is best avoided.
> >>
> >> Picking the first usable device doesn't sound much like a one-off to me.
> >> After all the caller (be it UEFI or the rng command) later detect that
> >> this is not usable. So there might be some merit to cover this more
> >> automatically, either in the caller, or by providing a suitable wrapper
> >> function?
> >
> > Or just follow the existing mechanisms which have been in U-Boot for
> > years. Please...!
> >
> > [..]
> >
> >
> > Regards,
> > Simon
> >   >
> >>> [1] https://patchwork.ozlabs.org/project/uboot/patch/20230830113230.3925868-1-andre.przywara@arm.com/
> >>
>
