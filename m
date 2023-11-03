Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F2EC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 19:40:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C54A7874C5;
	Fri,  3 Nov 2023 20:39:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R53S7qz6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EE0F87105; Fri,  3 Nov 2023 20:39:34 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65EF187232
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 20:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53dd3f169d8so3968156a12.3
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 12:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699040359; x=1699645159; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XWV38IL7KjabpiCJMHvrRan4+7EZo04vtWxOEacIMOI=;
 b=R53S7qz6xd6e7YuTQo/jYF83yJ8bEWOKrFzdlaYv/jWon7kCwRx0S9nKqY560qPJnw
 Q0zWUvSwQLMQ9SPHj20p1efioS74A4pkK0v/8ktF1XYIc2KfO3h2K7FUUcIm2HTKHOxJ
 2fnjQygQYH4yWK3/AS3vCQ9xbdTJbowGCCrJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699040359; x=1699645159;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XWV38IL7KjabpiCJMHvrRan4+7EZo04vtWxOEacIMOI=;
 b=PmwITo1v+hQZhmPsUvm+PttCgXocpxr3nbCYmxYA5uM2Cy58XW2UnXgfkl13EcTCVu
 GzuflyavU8jPq1cwrk9hDI8w9Pj0CmAvpQX38+0Pz+hZx3qbz6KoF2YaS7Ww66uPQqbx
 Iz30tl9tFaGCl/InIxhJJqqb8Z6m/ANu04e/V813gJt57sxZo8hb0t67+ylLaemOcdPT
 EeJgOrCrdSrAmOd0L4Nk3+VU4HF25IIb3ZejqjKeyX14IEMWv5iVLHP5kQHOznYHyUfM
 Wz4VE2HNhmXgBZyPyK6b4iLDxAQgIMA0xH7CqK6u++NgfDXdZ6Z1FsaTmNA0husm6eq/
 5msg==
X-Gm-Message-State: AOJu0Yx+fsOEwG/HBFVfj6SZDONTInvYxyjYxATWviELtQBbAe7kbxiy
 e1q8qU8JxY3/MPzscMaycvWBJ3+wn7izA3zKEj6jpg==
X-Google-Smtp-Source: AGHT+IFeyCM/JDhhSICyuR2YTYiVQLfAiNMOagcvkRIGeYDE0CEenvuGHPDwYJ4XzjYzZNYGekXuPNGCaSrXB3sCFfE=
X-Received: by 2002:a50:bac2:0:b0:542:db91:9531 with SMTP id
 x60-20020a50bac2000000b00542db919531mr14530830ede.27.1699040358553; Fri, 03
 Nov 2023 12:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231031125552.26698-1-heinrich.schuchardt@canonical.com>
 <20231101170559.680ab493@donnerap.manchester.arm.com>
 <50ff2080-5831-4963-937d-331248b59973@canonical.com>
In-Reply-To: <50ff2080-5831-4963-937d-331248b59973@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 3 Nov 2023 13:38:58 -0600
Message-ID: <CAPnjgZ1gPRQiEq8=tVCtC6wznOWXX2bLaimSwd73=74oEWAXYQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Andre Przywara <andre.przywara@arm.com>, Rick Chen <rick@andestech.com>, 
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

Hi Heinrich,

On Wed, 1 Nov 2023 at 14:20, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 11/1/23 19:05, Andre Przywara wrote:
> > On Tue, 31 Oct 2023 14:55:50 +0200
> > Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
> >
> > Hi Heinrich,
> >
> >> The Zkr ISA extension (ratified Nov 2021) introduced the seed CSR. It
> >> provides an interface to a physical entropy source.
> >>
> >> A RNG driver based on the seed CSR is provided. It depends on
> >> mseccfg.sseed being set in the SBI firmware.
> >
> > As you might have seen, I added a similar driver for the respective Arm
> > functionality:
> > https://lore.kernel.org/u-boot/20230830113230.3925868-1-andre.przywara@arm.com/
> >
> > And I see that you seem to use the same mechanism to probe and init the
> > driver: U_BOOT_DRVINFO and fail in probe() if the feature is not
> > implemented.
> > One downside of this approach is that the driver is always loaded (and
> > visible in the DM tree), even with the feature not being available.
> > That doesn't seem too much of a problem on the first glance, but it
> > occupies a device number, and any subsequent other DM_RNG devices
> > (like virtio-rng) typically get higher device numbers. So without
> > the feature, but with virtio-rng, I get:
> > VExpress64# rng 0
> > No RNG device

Why do we get this? If the device is not there, the bind() function
can return -ENODEV

I see this in U-Boot:

U_BOOT_DRVINFO(cpu_arm_rndr) = {

We should not use this. Use the devicetree.

> > VExpress64# rng 1
> > 00000000: f3 88 b6 d4 24 da 49 ca 49 f7 9e 66 5f 12 07 b2  ....$.I.I..f_...
>
>
> Essentially in any case were you have multiple drivers for the same
> device using uclass_get_device(, 0, ) and uclass_find_first_device()
> will only give you the first bound device and not the first successfully
> probed device. Furthermore neither of this functions causes probing.
> This is not restricted to the RNG drivers but could also happen with
> multiple TPM drivers or multiple watchdogs.
>
> This patch is related to the problem:
>
> [PATCH v1] rng: add dm_rng_read_default() helper
> https://lore.kernel.org/u-boot/4e28a388-f5b1-4cf7-b0e3-b12a876d0567@gmx.de/T/#me44263ec9141e3ea65ee232aa9a411fc6201bd95
>
> We have weak function platform_get_rng_device() which should be moved to
> drivers/rng/rng-uclass.c.
>
> We could add a function to drivers/core/uclass.c to retrieve the first
> successfully probed device. Another approach would be to implement
> uclass_driver.post_probe() in the RNG uclass to take note of the first
> successfully probed device.
>
> @Simon:
> What would make most sense from a DM design standpoint?

I am sure I provided feedback on this at the time, but I don't
remember. OK I just found it here [1]. So the problem is entirely
because my feedback was not addressed. Please just address it and
avoid this sort of mess.

So arm_rndr should have a devicetree compatible string and be bound
like anything else. If for some reason the device doesn't exist in the
hardware, it can return -ENODEV from its bind() method.

If you want to control which RNG device is used for booting, you could
add a property to /bootstd with a phandle to the device. We are trying
to provide a standard approach to booting in U-Boot, used by all
methods. Doing one-off things for particular cases is best avoided.

>
> Best regards
>
> Heinrich
>
> > ....
> >
> > Now the EFI code always picks RNG device 0, which means we don't get
> > entropy in this case.
> >
> > Do you have any idea how to solve this?
> > Maybe EFI tries to probe further - but that sounds arbitrary.
> > Or we find another way for probing the device, maybe via some artificial
> > CPU feature "bus"? There is UCLASS_CPU, but that doesn't look helpful?
> >
> > If anyone has any idea, I'd be grateful.
> >
> > Cheers,
> > Andre
> >
> >> If the seed CSR readable, is not determinable by S-mode without risking
> >> an exception. For safe driver probing allow to resume via a longjmp
> >> after an exception.
> >>
> >> As the driver depends on mseccfg.sseed=1 we should wait with merging the
> >> driver until a decision has been taken in the RISC-V PRS TG on prescribing
> >> this.
> >>
> >> Setting mseccfg.sseed=1 is queued for OpenSBI [1]. This has been discussed
> >> in the RISC-V Boot & Runtime Services TG. Standardization has to be pursued
> >> via the upcoming platform specification.
> >>
> >> A bug fix for QEMU relating to the Zkr extension is available in [2].
> >>
> >> A similar Linux driver has been proposed in [3].
> >>
> >> [1] lib: sbi: Configure seed bits when MSECCFG is readable
> >>      https://patchwork.ozlabs.org/project/opensbi/patch/20230712083254.1585244-1-sameo@rivosinc.com/
> >> [2] [PATCH v2 1/1] target/riscv: correct csr_ops[CSR_MSECCFG]
> >>      https://lore.kernel.org/qemu-devel/20231030102105.19501-1-heinrich.schuchardt@canonical.com/
> >> [3] [PATCH v4 4/4] RISC-V: Implement archrandom when Zkr is available
> >>      https://lore.kernel.org/linux-riscv/20230712084134.1648008-5-sameo@rivosinc.com/
> >>
> >> v3:
> >>      Add API documentation.
> >> v2:
> >>      Catch exception if mseccfg.sseed=0.
> >>
> >> Heinrich Schuchardt (2):
> >>    riscv: allow resume after exception
> >>    rng: Provide a RNG based on the RISC-V Zkr ISA extension
> >>
> >>   arch/riscv/lib/interrupts.c |  13 ++++
> >>   doc/api/index.rst           |   1 +
> >>   drivers/rng/Kconfig         |   8 +++
> >>   drivers/rng/Makefile        |   1 +
> >>   drivers/rng/riscv_zkr_rng.c | 116 ++++++++++++++++++++++++++++++++++++
> >>   include/interrupt.h         |  45 ++++++++++++++
> >>   6 files changed, 184 insertions(+)
> >>   create mode 100644 drivers/rng/riscv_zkr_rng.c
> >>   create mode 100644 include/interrupt.h
> >>
> >
>

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20230830113230.3925868-1-andre.przywara@arm.com/
