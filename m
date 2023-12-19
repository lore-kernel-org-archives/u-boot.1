Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3188AC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 15:22:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 808BD8743A;
	Tue, 19 Dec 2023 16:22:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 837638747A; Tue, 19 Dec 2023 16:22:42 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B8D45871AA
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 16:22:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EFEF1FB;
 Tue, 19 Dec 2023 07:23:23 -0800 (PST)
Received: from e130802.arm.com (e130802.arm.com [10.1.29.22])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CABA3F738;
 Tue, 19 Dec 2023 07:22:37 -0800 (PST)
Date: Tue, 19 Dec 2023 15:22:28 +0000
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: sjg@chromium.org, ilias.apalodimas@linaro.org, mark.kettenis@xs4all.nl,
 Drew.Reed@arm.com, u-boot@lists.denx.de, nd@arm.com
Subject: Re: Adding EFI runtime support to the Arm's FF-A bus
Message-ID: <20231219152228.GA39032@e130802.arm.com>
References: <20231214155346.GB295924@e130802.arm.com>
 <87ttok689d.fsf@bloch.sibelius.xs4all.nl>
 <CAC_iWjKYa1_GrU3XPKqbnOf6VJxx426qTfD1WcSMkmj982ECSw@mail.gmail.com>
 <CAPnjgZ1TsFCzTd2pD3j4SoAhnJWw1qz90DfEzsU6Y-4bSkEf7A@mail.gmail.com>
 <B06FB6F5-416C-440D-BC72-070673DF3177@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B06FB6F5-416C-440D-BC72-070673DF3177@gmx.de>
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

On Mon, Dec 18, 2023 at 09:59:13PM +0100, Heinrich Schuchardt wrote:
> 
> 
> Am 18. Dezember 2023 16:01:44 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >Hi,
> >
> >On Thu, 14 Dec 2023 at 12:47, Ilias Apalodimas
> ><ilias.apalodimas@linaro.org> wrote:
> >>
> >> Hi Mark, Abdellatif
> >>
> >> On Thu, 14 Dec 2023 at 18:47, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> >> >
> >> > > Date: Thu, 14 Dec 2023 15:53:46 +0000
> >> > > From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> >> >
> >> > Hi Abdellatif,
> >> >
> >> > > Hi guys,
> >> > >
> >> > > I'd like to ask for advice regarding adding EFI RT support to the Arm's FF-A bus
> >> > > in U-Boot.
> >> > >
> >> > > The objective is to enable the FF-A messaging APIs in EFI RT to be
> >> > > used for comms with the secure world. This will help getting/setting
> >> > > EFI variables through FF-A.
> >> > >
> >> > > The existing FF-A APIs in U-Boot call the DM APIs (which are not available at RT).
> >> > >
> >> > > Two possible solutions:
> >> > >
> >> > > 1/ having the entire U-Boot in RT space (as Simon stated in this discussion[1])
> >> >
> >> > I don't think this is a terribly good idea.  With this approach orders
> >> > of magnitude more code will be present in kernel address space one the
> >> > OS kernel is running and calling into the EFI runtime.  Including code
> >> > that may access hardware devices that are now under OS control.  It
> >> > will be nigh impossible to audit all that code and make sure that only
> >> > a safe subset of it gets called.  So...
> >>
> >> +100
> >> I think we should draw a line here. I mentioned it on another thread,
> >> but I did a shot BoF in Plumbers discussing issues like this,
> >> problems, and potential solutions [0] [1]. Since that talk patches for
> >> the kernel that 'solve' the problem for RPMBs got pulled into
> >> linux-next [2].
> >> The TL;DR of that talk is that if the kernel ends up being in control
> >> of the hardware that stores the EFI variables, we need to find elegant
> >> ways to teach the kernel how to store those directly. The EFI
> >> requirement of an isolated flash is something that mostly came from
> >> the x86 world and is not a reality on the majority of embedded boards.
> >> I also think we should give up on Authenticated EFI variables in that
> >> case. We get zero guarantees unless the medium has similar properties
> >> to an RPMB.
> >> If a vendor cares about proper UEFI secure boot he can implement
> >> proper hardware.
> >
> >Just to copy in my thoughts as they are lost at this point:
> >
> >> We would need to publish a runtime interface with access to the driver
> >> API. I did ask for this when the EFI runtime support was added, but it
> >> wasn't done.
> >
> >> It would be possible to create a new 'runtime' phase of U-Boot (RPL?),
> >> separate from the others. That will be much easier once we get the XPL
> >> stuff sorted out., since adding new [hase would be fairly trivial  CPL
> >> died as another contributor had a series which went in first...then I
> >> never got back to it.
> >
> >> So for now having the entire U-Boot in runtime space seems reasonable to me.
> >
> >> I'll also mention that it would be nice to have s new-style API
> >> (replacing the old API U-Boot currently has) which uses more of a
> >> module approach. E.g. we could declare that uclass_first_device() is
> >> exported and can be called from outside U-Boot.
> >
> >>
> >> >
> >> > >
> >> > > 2/ Create an RT variant for the FF-A APIs needed.
> >> > >       These RT variant don't call the DM APIs
> >> > >       (e.g: ffa_mm_communicate_runtime, ffa_sync_send_receive_runtime, ...)
> >> > >
> >> > > What do you recommend please ?
> >> >
> >> > ...this is what I would recommend.  Preferably in a way that refactors
> >> > the code such that the low-level functionality is shared between the
> >> > DM and non-DM APIs.
> >>
> >> Yes. The only thing you need to keep alive is the machinery to talk to
> >> the secure world. The bus, flash driver etc should all be running
> >> isolated in there. In that case you can implement SetVariableRT as
> >> described the the EFI spec.
> >
> >The current approach is pretty brittle, since it relies on putting
> >some of the U-Boot code into a separate area. There is no good way to
> >know which U-Boot code should be in that area, since we don't create a
> >separate build. If a function calls one that has not been specially
> >marked, or accesses data that is not in the area, then it will crash
> >or hang.
> >
> >So, as I said, I think we need a new build, if we want to avoid all of
> >U-Boot in there. Anything else is hard to maintain.
> 
> The EFI runtime is the most security exposed part of U-Boot. We should strive to keep the attack surface small. No matter how we define the runtime (by section assignment as today or by a dedicated build) I would not want to have the driver model in the runtime.
> 
> The only drivers that are required by the EBBR are for resetting the system. ARM has PSCI as reset handler, RISC-V has SBI. These are invoked by simple ecalls.
> 
> Any runtime device drivers for variable storage should not be in the U-Boot runtime but live in the secure world (e.g. OP-TEE). FF-A is the new  ARM protocol for talking to the secure world and hence fits into the picture.
> 
> @Abdellatif 
> 
> Does an OP-TEE module for managing EFI variables via FF-A already exist?
> 

Yes, that's available in two ways:

1) The smm-gateway SP from Trusted Services (aka TS) [1] provides EFI variable service over FF-A [2]. It's not OP-TEE specific, it can run on top of any S-EL1 SPMC.
2) StMM

[1]: https://trusted-services.readthedocs.io/en/stable/deployments/secure-partitions.html#smm-gateway
[2]: https://github.com/u-boot/u-boot/blob/master/doc/arch/arm64.ffa.rst

> For QEMU?

Yes, smm-gateway is tested on QEMU through the qemuarm64-secureboot Yocto machine [1].
Also, there is an in-progress PR to add TS on QEMU support in the OP-TEE integration system [2].

[1]: https://git.yoctoproject.org/meta-arm/tree/meta-arm/conf/machine/qemuarm64-secureboot.conf , https://git.yoctoproject.org/meta-arm/tree/meta-arm/recipes-security/trusted-services/ts-uefi-test_git.bb
[2]: https://github.com/OP-TEE/build/pull/688

Cheers,
Abdellatif
