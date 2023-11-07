Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C33C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 01:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE84A86FF7;
	Tue,  7 Nov 2023 02:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cpt9/hAS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF79787092; Tue,  7 Nov 2023 02:08:36 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2265686C56
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 02:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5079f6efd64so6360577e87.2
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 17:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699319313; x=1699924113; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jx1HgINj2ZxprKpfHnlaQwfBsc56S4d1PJRYG4QUZJc=;
 b=cpt9/hASQjJlO0Lq5L6DPkhEHTCRHkt1ai0ZbrnVsEYVKOkg2e5c9gcXOYVsSuUWqo
 GXguCtvrZ2daNhunOzK6/SaZRU0JQjCIubHd2CpSoFeipEiRseFpNO9C2oA8EHb1Xrct
 L3cF8hg1tMxy6GRzrup5DkHvtRo2zTnrvNvsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699319313; x=1699924113;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jx1HgINj2ZxprKpfHnlaQwfBsc56S4d1PJRYG4QUZJc=;
 b=vWsBHtFULRb8bJCImRtWwWEwSmwGuVR7T8gAwe5hfRdYITfAIpOGwB7PtRHeciGd+x
 lG0VuT+hACuX77DD3tOFlZn698uFLDyJje2EBY1NU9PEjMAmPSEbi4gCwVNgiMcKbR43
 ab8qVq4yw6WNDLmZUENRp4A6ud4Ks12oh2nw7vcsRgYg7+OWrNka1+o9sG5eTaVzOoBr
 5EpKBFNUq+eQZHJXrRuU7oN22kWcDrg8hgZ9rrrkU/kt0eSTEjb+6xquqOhFxhT3EYlI
 WGYCtTDNzo0a7ufQB3yF8KcF4bzVZDUShB6IC+fXz0LO5LiHCSiMzYDjGjAWwxPfrIgZ
 XAAA==
X-Gm-Message-State: AOJu0YzkLc3F3zqiLXAAa5tuFuibDCpJWZFOTknB3ZxWQR3edrQZ4WMt
 y6oCBPf+pm7WrYZ/kKaHj/yFZ/adVTuq9CynauGC2g==
X-Google-Smtp-Source: AGHT+IEn98OUu9sDtckefcFgfJlKfUhUowmBON8qi6WGF7+qNLi7WcQOrRfr4n15LTistgww8bgnuioqd5ajU91NL0I=
X-Received: by 2002:a19:6d03:0:b0:507:c763:27a5 with SMTP id
 i3-20020a196d03000000b00507c76327a5mr20213617lfc.62.1699319312918; Mon, 06
 Nov 2023 17:08:32 -0800 (PST)
MIME-Version: 1.0
References: <20231031125552.26698-1-heinrich.schuchardt@canonical.com>
 <20231101170559.680ab493@donnerap.manchester.arm.com>
 <50ff2080-5831-4963-937d-331248b59973@canonical.com>
 <CAPnjgZ1gPRQiEq8=tVCtC6wznOWXX2bLaimSwd73=74oEWAXYQ@mail.gmail.com>
 <20231104171212.3d041a4f@slackpad.lan>
 <CAPnjgZ1X8R4h24pP1zoqEADTbntm5Yo2YqfMTePVqbHoJMx_vA@mail.gmail.com>
 <20231106172601.12c36750@donnerap.manchester.arm.com>
 <CAPnjgZ1v1UfADOFDFFFD9UBo5QcRPNLBk+XLBL4JNbGy9poVJw@mail.gmail.com>
 <20231106215331.0d770df8@slackpad.lan>
In-Reply-To: <20231106215331.0d770df8@slackpad.lan>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 01:08:15 +0000
Message-ID: <CAPnjgZ2GY8o_UR-rqYOimYe1t_NV+6eAa8rZY3Eaak6vp7Vciw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
To: Andre Przywara <andre.przywara@arm.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Anup Patel <apatel@ventanamicro.com>, 
 Xiang W <merlew4n6@gmail.com>, Chanho Park <chanho61.park@samsung.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Peter Hoyes <Peter.Hoyes@arm.com>, Alexey Romanov <avromanov@salutedevices.com>,
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

Hi Andre,

On Mon, 6 Nov 2023 at 21:55, Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Mon, 6 Nov 2023 13:38:39 -0700
> Simon Glass <sjg@chromium.org> wrote:
>
> Hi Simon,
>
> > On Mon, 6 Nov 2023 at 10:26, Andre Przywara <andre.przywara@arm.com> wrote:
> > >
> > > On Sat, 4 Nov 2023 19:45:06 +0000
> > > Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > > On Sat, 4 Nov 2023 at 17:13, Andre Przywara <andre.przywara@arm.com> wrote:
> > > > >
> > > > > On Fri, 3 Nov 2023 13:38:58 -0600
> > > > > Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > > Hi Heinrich,
> > > > > >
> > > > > > On Wed, 1 Nov 2023 at 14:20, Heinrich Schuchardt
> > > > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > > > >
> > > > > > > On 11/1/23 19:05, Andre Przywara wrote:
> > > > > > > > On Tue, 31 Oct 2023 14:55:50 +0200
> > > > > > > > Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
> > > > > > > >
> > > > > > > > Hi Heinrich,
> > > > > > > >
> > > > > > > >> The Zkr ISA extension (ratified Nov 2021) introduced the seed CSR. It
> > > > > > > >> provides an interface to a physical entropy source.
> > > > > > > >>
> > > > > > > >> A RNG driver based on the seed CSR is provided. It depends on
> > > > > > > >> mseccfg.sseed being set in the SBI firmware.
> > > > > > > >
> > > > > > > > As you might have seen, I added a similar driver for the respective Arm
> > > > > > > > functionality:
> > > > > > > > https://lore.kernel.org/u-boot/20230830113230.3925868-1-andre.przywara@arm.com/
> > > > > > > >
> > > > > > > > And I see that you seem to use the same mechanism to probe and init the
> > > > > > > > driver: U_BOOT_DRVINFO and fail in probe() if the feature is not
> > > > > > > > implemented.
> > > > > > > > One downside of this approach is that the driver is always loaded (and
> > > > > > > > visible in the DM tree), even with the feature not being available.
> > > > > > > > That doesn't seem too much of a problem on the first glance, but it
> > > > > > > > occupies a device number, and any subsequent other DM_RNG devices
> > > > > > > > (like virtio-rng) typically get higher device numbers. So without
> > > > > > > > the feature, but with virtio-rng, I get:
> > > > > > > > VExpress64# rng 0
> > > > > > > > No RNG device
> > > > > >
> > > > > > Why do we get this? If the device is not there, the bind() function
> > > > > > can return -ENODEV
> > > > > >
> > > > > > I see this in U-Boot:
> > > > > >
> > > > > > U_BOOT_DRVINFO(cpu_arm_rndr) = {
> > > > > >
> > > > > > We should not use this.
> > > > >
> > > > > Agreed.
> > > > >
> > > > > > Use the devicetree.
> > > > >
> > > > > No, this is definitely not something for the DT, at least not on ARM.
> > > > > It's perfectly discoverable via the architected CPU ID registers.
> > > > > Similar to PCI and USB devices, which we don't probe via the DT as well.
> > > > >
> > > > > It's arguably not proper "driver" material per se, as I've argued before, but
> > > > > it's the simplest solution and fits in nicely otherwise.
> > > > >
> > > > > I was wondering if it might be something for UCLASS_CPU, something like
> > > > > a "CPU feature bus": to let devices register on one on the many CPU
> > > > > features (instead of compatible strings), then only bind() those
> > > > > drivers it the respective bit is set.
> > > > >
> > > > > Does that make sense? Would that be doable without boiling the ocean?
> > > > > As I don't know if we see many users apart from this.
> > > >
> > > > I have seen this so many times, where people want to avoid putting
> > > > things in the DT and then are surprised that everything is difficult,
> > > > broken and confusing. Why not just follow the rules? It is not just
> > > > about whether we can avoid it, etc. It is about how devices fit
> > > > together cohesively in the system, and how U-Boot operates.
> > >
> > > A devicetree is only for peripherals *that cannot be located by probing*.
> >
> > I have to stop you there. It absolutely is not limited to that.
>
> I am very sorry, but I - (and seemingly everyone else in the kernel DT
> community?) - seem to disagree here.

Really? Where is that even coming from? Certainly not the DT spec.


>
> > > Which are traditionally most peripherals in non-server Arm SoCs. While I
> > > do love the DT, the best DT node is the one you don't need.
> >
> > We need it in U-Boot, at least.
> >
> > I'll send a patch with a warning on U_BOOT_DRVINFO() as it seems that
> > some people did not see the header-file comment.
>
> Fair enough.
>
> > Let's just stop this discussion and instead talk about the binding we need.
>
> Alright, if that is your decision, I will send a patch to revert
> that "driver". There will never be a binding for a CPU instruction
> discoverable by the architected CPU ID register.

That statement just mystifies me. Why not just send a binding? Even
the people that complain that DT should only describe hardware will be
happy with it.

The code you sent should have been a clue that you need to know
whether the feature is present:

+       /* Check if reading seed leads to interrupt */
+       set_resume(&resume);
+       ret = setjmp(resume.jump);
+       if (ret)
+               log_debug("Exception %ld reading seed CSR\n", resume.code);
+       else
+               val = read_seed();
+       set_resume(NULL);
+       if (ret)
+               return -ENODEV;

I have never seen code like that in a driver. Please let's just have
the binding discussion with the Linux people and hopefully they will
see reason.

> I had some gripes with that "driver" in the first place, but it was so
> temptingly simple and fit in so nicely, for instance into the UEFI
> entropy service without even touching that code, that I couldn't resist
> to just try it. And it actually solved a nasty problem for us, where
> the kernel boot was stuck for minutes waiting for enough entropy to ...
> let a script create a random filename ;-)
> But we also have virtio-rng, so are not limited to the instructions.
>
> But well, I guess I will just bite the bullet and go along the proper
> route and create some RNG instruction abstraction, as sketched in that
> other email.

I don't know what that is.

In the other email I proposed a binding for this, so I hope that can
make progress.

Regards,
SImon


>
> >
> > >
> > > But as Heinrich also said: those instructions are not peripherals, they
> > > are part of an instruction set extensions, the same story as with x86's
> > > RDRAND instruction. We don't have those in ACPI or so as well, because
> > > CPUID has you covered. The same on ARM, ID_AA64ISAR0_EL1 is readable on
> > > every chip (outside of EL0), and tells you whether you have the RNDR
> > > register or not. IIUC RISC-V is slightly different here, since not all ISA
> > > extensions are covered by CSRs, hence some of them indeed listed in the DT.
> > >
> > > So a proper solution(TM) would be to split this up in architectural
> > > *instructions* and proper TRNG *devices*, maybe wrapping this up in some
> > > function that tests both. This is roughly what the kernel does, somewhat
> > > abstracted by the concept of "entropy sources", which could be TRNG
> > > devices, CPU instructions, interrupt jitter or even "instruction execution
> > > jitter"[1], with the latter two definitely not being devices really at all.
> > >
> > > But I don't know if U-Boot wants to go through the hassle of this whole
> > > framework, as we tend to implement things much easier. But a simple
> > > get_cpu_random() function, implemented per architecture, and with some
> > > kind of success flag, should be easy enough to do. Then either the users
> > > (UEFI?) explicitly call this before trying UCLASS_RNG, or we wrap this for
> > > every RNG user.
> > >
> > > Cheers,
> > > Andre
> > >
> > > > > > > > VExpress64# rng 1
> > > > > > > > 00000000: f3 88 b6 d4 24 da 49 ca 49 f7 9e 66 5f 12 07 b2  ....$.I.I..f_...
> > > > > > >
> > > > > > >
> > > > > > > Essentially in any case were you have multiple drivers for the same
> > > > > > > device using uclass_get_device(, 0, ) and uclass_find_first_device()
> > > > > > > will only give you the first bound device and not the first successfully
> > > > > > > probed device. Furthermore neither of this functions causes probing.
> > > > > > > This is not restricted to the RNG drivers but could also happen with
> > > > > > > multiple TPM drivers or multiple watchdogs.
> > > > > > >
> > > > > > > This patch is related to the problem:
> > > > > > >
> > > > > > > [PATCH v1] rng: add dm_rng_read_default() helper
> > > > > > > https://lore.kernel.org/u-boot/4e28a388-f5b1-4cf7-b0e3-b12a876d0567@gmx.de/T/#me44263ec9141e3ea65ee232aa9a411fc6201bd95
> > > > > > >
> > > > > > > We have weak function platform_get_rng_device() which should be moved to
> > > > > > > drivers/rng/rng-uclass.c.
> > > > > > >
> > > > > > > We could add a function to drivers/core/uclass.c to retrieve the first
> > > > > > > successfully probed device. Another approach would be to implement
> > > > > > > uclass_driver.post_probe() in the RNG uclass to take note of the first
> > > > > > > successfully probed device.
> > > > > > >
> > > > > > > @Simon:
> > > > > > > What would make most sense from a DM design standpoint?
> > > > > >
> > > > > > I am sure I provided feedback on this at the time, but I don't
> > > > > > remember. OK I just found it here [1]. So the problem is entirely
> > > > > > because my feedback was not addressed. Please just address it and
> > > > > > avoid this sort of mess.
> > > > >
> > > > > Yeah, Tom just merged it, but that's not Heinrich's fault ;-)
> > > > >
> > > > > > So arm_rndr should have a devicetree compatible string and be bound
> > > > > > like anything else. If for some reason the device doesn't exist in the
> > > > > > hardware, it can return -ENODEV from its bind() method.
> > > > > >
> > > > > > If you want to control which RNG device is used for booting, you could
> > > > > > add a property to /bootstd with a phandle to the device. We are trying
> > > > > > to provide a standard approach to booting in U-Boot, used by all
> > > > > > methods. Doing one-off things for particular cases is best avoided.
> > > > >
> > > > > Picking the first usable device doesn't sound much like a one-off to me.
> > > > > After all the caller (be it UEFI or the rng command) later detect that
> > > > > this is not usable. So there might be some merit to cover this more
> > > > > automatically, either in the caller, or by providing a suitable wrapper
> > > > > function?
> > > >
> > > > Or just follow the existing mechanisms which have been in U-Boot for
> > > > years. Please...!
> > > >
> > > > [..]
> > > >
> > > >
> > > > Regards,
> > > > Simon
> > > >  >
> > > > > > [1] https://patchwork.ozlabs.org/project/uboot/patch/20230830113230.3925868-1-andre.przywara@arm.com/
> > > > >
>

Regards,
SImon
