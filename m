Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A3AC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 07:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 020A587655;
	Wed,  8 Nov 2023 08:12:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zOml0sIm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEA6B876D8; Wed,  8 Nov 2023 08:12:20 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 216C087576
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 08:12:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c5210a1515so89978821fa.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 23:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699427537; x=1700032337; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eMgsygtq7h8vFJthKNJiwy/KYZ78a7tiHCpPWtw0NMs=;
 b=zOml0sIm6YU6K5ZFvZObyTM808fR6XPyO13mqUdvzNdZvdJsotKMCJvwQTJVi50p8o
 5HHPPrEe85Y3U/pdEyQpfnRsHp24SQQzcMPp6kn5QAndruLqWdjkUAhI88c/49+iOTeT
 DJdHU9tAhGUejxwdn6zd6UZUOA5m2+jC/xoNwXpnjjsFIQIJMpiSG0KEx1/wgLqU2Top
 Fi0JuZul8pjhvTJmdQchr5viud7+nENJIfy8/KOqvUQxgg8BzSnltyxV7IaFwPLendPB
 /oGZmcSamkgO0kj2a+Xz800lO6UQbHa8K9bSqLtee6GtVHTuw+lcMdOU5ghBAFstUrkj
 GsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699427537; x=1700032337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eMgsygtq7h8vFJthKNJiwy/KYZ78a7tiHCpPWtw0NMs=;
 b=UhamgyYPYEgqsEcTZsTVhcZucpeg1KtlLkXOmMF37+PVmTjYjd1/7sJsKUWX5C2FIP
 gmZ8hTu1fO2cCOI4x4XRiLPC2Os7/oY4GDqjajgCodoJTCq+qF+7VeXLRZ2bqNzF29Av
 Bi3m1WS6G+HJsA22H/zVPdJ2OePXIRDGrM0Ebx8K35BzEY2ClTsPV9Jv7uQv8VmiHrQt
 I/bRcI3/RjExCOKPRO7lobZkt6gpWKlt4gEMoGDOw15ED8v9sqLn2aBidQWWy5iHGFgn
 ZmULTacZbpZQuvl86sWpDq3FLGJUj1hM8+h52PKXu3jOdNHumvzwvhFy/KoipfrXGbeD
 zLsw==
X-Gm-Message-State: AOJu0Ywx5wl262xk2GT4ErrJJZaEr7HvpjqtodnvMcDVP3BZLP2R2+ia
 ULaAzhQW3FudCSdLj/SYo8uW2ZZrztKF+XaCdf31Qg==
X-Google-Smtp-Source: AGHT+IHutHaPQGAwrNGIYkfjwu12T7zEJXhv63d9Zi/mkxVKHGnuAft1YEA9bXR6LFIlGWmhdpXOb6njCy1oIOE/o6M=
X-Received: by 2002:a05:6512:ba2:b0:508:244a:2439 with SMTP id
 b34-20020a0565120ba200b00508244a2439mr848639lfv.66.1699427537020; Tue, 07 Nov
 2023 23:12:17 -0800 (PST)
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
 <CAPnjgZ2GY8o_UR-rqYOimYe1t_NV+6eAa8rZY3Eaak6vp7Vciw@mail.gmail.com>
 <20231107112708.4030f2e1@donnerap.manchester.arm.com>
 <CAPnjgZ1eMxbJGhxSGF1NgCELz+MOoPK0k3hsB-hzEXTo0=3szQ@mail.gmail.com>
 <20231107151248.0c6247c4@donnerap.manchester.arm.com>
 <CAPnjgZ39URROxqXwC52CZaU2BbVyJYo95S0NDJ7SxJq5VFZr4A@mail.gmail.com>
In-Reply-To: <CAPnjgZ39URROxqXwC52CZaU2BbVyJYo95S0NDJ7SxJq5VFZr4A@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 8 Nov 2023 09:11:40 +0200
Message-ID: <CAC_iWjLVzOn8D_gm-T_Fz=rP7BHLe5i3p378HZUUydwAUD8D5w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
To: Simon Glass <sjg@chromium.org>
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Anup Patel <apatel@ventanamicro.com>, 
 Xiang W <merlew4n6@gmail.com>, Chanho Park <chanho61.park@samsung.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Peter Hoyes <Peter.Hoyes@arm.com>, Alexey Romanov <avromanov@salutedevices.com>,
 Sean Anderson <sean.anderson@seco.com>
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

Hi
I am late to the party but

[...]

> > I can't help to think that you like the FDT as a well understood and
> > flexible general purpose data structure. And it can indeed be used as a
> > configuration file, especially since you have the parser in your code
> > already - the FIT image is a good example. But this is distinct from the
> > Devicetree as a hardware description.
>
> Indeed, although I don't see such a bright line between the
> hardware/software concepts. In any case, the RNG is a hardware
> feature, surely?
>
> > Would it help to separate the two use cases: to go with one DTB that is
> > strictly for hardware configuration, as described by the DT bindings in
> > the Linux kernel tree, and a *separate* DT blob that carries configuration
> > information, U-Boot specific data (like memory layout, SRAM usage, device
> > priorities, packaging information)? TF-A chose this approach: there is
> > hw-config, which is the hardware DTB, and there is fw-config, which is a
> > FDT blob as well, but describes the firmware layout and other configuration
> > information.
>
> Or we could just not do that and have a single DT :-)
>
> I wondered where that idea came from and it has been mentioned before.

Yes, that was me.  I still think this would solve a *ton* of problems
and I am willing to explore that.
The only thing I haven't thought through is DTs and limited SRAM in
the SPL, but I don't think this should be a showstopper.

Thanks
/Ilias
> TF-A should be a C library called by bootloaders, BTW.
>
> I haven't replied to everything above...I believe I have had this same
> discussion about a dozen times over the last 6 years. I did try to
> send a patch to state my POV at some point, but I think it got NAKed
> :-)
>
> Regards,
> Simon
>
>
> >
> > Cheers,
> > Andre
> >
> > > > > > > > But as Heinrich also said: those instructions are not
> > > > > > > > peripherals, they are part of an instruction set extensions,
> > > > > > > > the same story as with x86's RDRAND instruction. We don't have
> > > > > > > > those in ACPI or so as well, because CPUID has you covered.
> > > > > > > > The same on ARM, ID_AA64ISAR0_EL1 is readable on every chip
> > > > > > > > (outside of EL0), and tells you whether you have the RNDR
> > > > > > > > register or not. IIUC RISC-V is slightly different here, since
> > > > > > > > not all ISA extensions are covered by CSRs, hence some of them
> > > > > > > > indeed listed in the DT.
> > > > > > > >
> > > > > > > > So a proper solution(TM) would be to split this up in
> > > > > > > > architectural *instructions* and proper TRNG *devices*, maybe
> > > > > > > > wrapping this up in some function that tests both. This is
> > > > > > > > roughly what the kernel does, somewhat abstracted by the
> > > > > > > > concept of "entropy sources", which could be TRNG devices, CPU
> > > > > > > > instructions, interrupt jitter or even "instruction execution
> > > > > > > > jitter"[1], with the latter two definitely not being devices
> > > > > > > > really at all.
> > > > > > > >
> > > > > > > > But I don't know if U-Boot wants to go through the hassle of
> > > > > > > > this whole framework, as we tend to implement things much
> > > > > > > > easier. But a simple get_cpu_random() function, implemented
> > > > > > > > per architecture, and with some kind of success flag, should
> > > > > > > > be easy enough to do. Then either the users (UEFI?) explicitly
> > > > > > > > call this before trying UCLASS_RNG, or we wrap this for every
> > > > > > > > RNG user.
> > > > > > > >
> > > > > > > > Cheers,
> > > > > > > > Andre
> > > > > > > >
> > > > > > > > > > > > > VExpress64# rng 1
> > > > > > > > > > > > > 00000000: f3 88 b6 d4 24 da 49 ca 49 f7 9e 66 5f 12
> > > > > > > > > > > > > 07 b2  ....$.I.I..f_...
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Essentially in any case were you have multiple drivers
> > > > > > > > > > > > for the same device using uclass_get_device(, 0, ) and
> > > > > > > > > > > > uclass_find_first_device() will only give you the
> > > > > > > > > > > > first bound device and not the first successfully
> > > > > > > > > > > > probed device. Furthermore neither of this functions
> > > > > > > > > > > > causes probing. This is not restricted to the RNG
> > > > > > > > > > > > drivers but could also happen with multiple TPM
> > > > > > > > > > > > drivers or multiple watchdogs.
> > > > > > > > > > > >
> > > > > > > > > > > > This patch is related to the problem:
> > > > > > > > > > > >
> > > > > > > > > > > > [PATCH v1] rng: add dm_rng_read_default() helper
> > > > > > > > > > > > https://lore.kernel.org/u-boot/4e28a388-f5b1-4cf7-b0e3-b12a876d0567@gmx.de/T/#me44263ec9141e3ea65ee232aa9a411fc6201bd95
> > > > > > > > > > > >
> > > > > > > > > > > > We have weak function platform_get_rng_device() which
> > > > > > > > > > > > should be moved to drivers/rng/rng-uclass.c.
> > > > > > > > > > > >
> > > > > > > > > > > > We could add a function to drivers/core/uclass.c to
> > > > > > > > > > > > retrieve the first successfully probed device. Another
> > > > > > > > > > > > approach would be to implement
> > > > > > > > > > > > uclass_driver.post_probe() in the RNG uclass to take
> > > > > > > > > > > > note of the first successfully probed device.
> > > > > > > > > > > >
> > > > > > > > > > > > @Simon:
> > > > > > > > > > > > What would make most sense from a DM design
> > > > > > > > > > > > standpoint?
> > > > > > > > > > >
> > > > > > > > > > > I am sure I provided feedback on this at the time, but I
> > > > > > > > > > > don't remember. OK I just found it here [1]. So the
> > > > > > > > > > > problem is entirely because my feedback was not
> > > > > > > > > > > addressed. Please just address it and avoid this sort of
> > > > > > > > > > > mess.
> > > > > > > > > >
> > > > > > > > > > Yeah, Tom just merged it, but that's not Heinrich's fault
> > > > > > > > > > ;-)
> > > > > > > > > > > So arm_rndr should have a devicetree compatible string
> > > > > > > > > > > and be bound like anything else. If for some reason the
> > > > > > > > > > > device doesn't exist in the hardware, it can return
> > > > > > > > > > > -ENODEV from its bind() method.
> > > > > > > > > > >
> > > > > > > > > > > If you want to control which RNG device is used for
> > > > > > > > > > > booting, you could add a property to /bootstd with a
> > > > > > > > > > > phandle to the device. We are trying to provide a
> > > > > > > > > > > standard approach to booting in U-Boot, used by all
> > > > > > > > > > > methods. Doing one-off things for particular cases is
> > > > > > > > > > > best avoided.
> > > > > > > > > >
> > > > > > > > > > Picking the first usable device doesn't sound much like a
> > > > > > > > > > one-off to me. After all the caller (be it UEFI or the rng
> > > > > > > > > > command) later detect that this is not usable. So there
> > > > > > > > > > might be some merit to cover this more automatically,
> > > > > > > > > > either in the caller, or by providing a suitable wrapper
> > > > > > > > > > function?
> > > > > > > > >
> > > > > > > > > Or just follow the existing mechanisms which have been in
> > > > > > > > > U-Boot for years. Please...!
> > > > > > > > >
> > > > > > > > > [..]
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Regards,
> > > > > > > > > Simon
> > > > > > > > >  >
> > > > > > > > > > > [1]
> > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20230830113230.3925868-1-andre.przywara@arm.com/
> > > > > > > > > > >
> > > > > > > > > >
> > > > > >
> > > > >
> > > > > Regards,
> > > > > SImon
> > > >
> >
