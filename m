Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB761C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 16:34:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDEFF87536;
	Mon,  8 Jan 2024 17:34:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D439875EB; Mon,  8 Jan 2024 17:34:26 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 622618269F
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 17:34:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AFFCC15;
 Mon,  8 Jan 2024 08:35:07 -0800 (PST)
Received: from e130802.arm.com (unknown [10.57.42.119])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8899E3F64C;
 Mon,  8 Jan 2024 08:34:14 -0800 (PST)
Date: Mon, 8 Jan 2024 16:34:21 +0000
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, sjg@chromium.org, mark.kettenis@xs4all.nl,
 Drew.Reed@arm.com, u-boot@lists.denx.de, nd@arm.com
Subject: Re: Adding EFI runtime support to the Arm's FF-A bus
Message-ID: <20240108163342.GA337806@e130802.arm.com>
References: <20231214155346.GB295924@e130802.arm.com>
 <87ttok689d.fsf@bloch.sibelius.xs4all.nl>
 <CAC_iWjKYa1_GrU3XPKqbnOf6VJxx426qTfD1WcSMkmj982ECSw@mail.gmail.com>
 <20231218165909.GA313366@e130802.arm.com>
 <20240108141256.GA236096@e130802.arm.com>
 <4244abf5-49b4-43ac-a52e-5ebc8c1aa658@gmx.de>
 <CAC_iWj+L0F7dPFitm-jjfZ=v-DttEF-CJb7_DzfsLYQviRk9Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWj+L0F7dPFitm-jjfZ=v-DttEF-CJb7_DzfsLYQviRk9Cg@mail.gmail.com>
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

Hi Ilias, Heinrich

On Mon, Jan 08, 2024 at 04:35:59PM +0200, Ilias Apalodimas wrote:
> On Mon, 8 Jan 2024 at 16:32, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 08.01.24 15:12, Abdellatif El Khlifi wrote:
> > > Happy new year Ilias,
> > >
> > > On Mon, Dec 18, 2023 at 04:59:09PM +0000, Abdellatif El Khlifi wrote:
> > >> Hi Ilias
> > >>
> > >> On Thu, Dec 14, 2023 at 09:47:13PM +0200, Ilias Apalodimas wrote:
> > >>> Hi Mark, Abdellatif
> > >>>
> > >>> On Thu, 14 Dec 2023 at 18:47, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> > >>>>
> > >>>>> Date: Thu, 14 Dec 2023 15:53:46 +0000
> > >>>>> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> > >>>>
> > >>>> Hi Abdellatif,
> > >>>>
> > >>>>> Hi guys,
> > >>>>>
> > >>>>> I'd like to ask for advice regarding adding EFI RT support to the Arm's FF-A bus
> > >>>>> in U-Boot.
> > >>>>>
> > >>>>> The objective is to enable the FF-A messaging APIs in EFI RT to be
> > >>>>> used for comms with the secure world. This will help getting/setting
> > >>>>> EFI variables through FF-A.
> > >>>>>
> > >>>>> The existing FF-A APIs in U-Boot call the DM APIs (which are not available at RT).
> > >>>>>
> > >>>>> Two possible solutions:
> > >>>>>
> > >>>>> 1/ having the entire U-Boot in RT space (as Simon stated in this discussion[1])
> > >>>>
> > >>>> I don't think this is a terribly good idea.  With this approach orders
> > >>>> of magnitude more code will be present in kernel address space one the
> > >>>> OS kernel is running and calling into the EFI runtime.  Including code
> > >>>> that may access hardware devices that are now under OS control.  It
> > >>>> will be nigh impossible to audit all that code and make sure that only
> > >>>> a safe subset of it gets called.  So...
> > >>>
> > >>> +100
> > >>> I think we should draw a line here. I mentioned it on another thread,
> > >>> but I did a shot BoF in Plumbers discussing issues like this,
> > >>> problems, and potential solutions [0] [1]. Since that talk patches for
> > >>> the kernel that 'solve' the problem for RPMBs got pulled into
> > >>> linux-next [2].
> > >>
> > >> I watched your talk. Great work, thanks :)
> > >>
> > >>> The TL;DR of that talk is that if the kernel ends up being in control
> > >>> of the hardware that stores the EFI variables, we need to find elegant
> > >>> ways to teach the kernel how to store those directly. The EFI
> > >>> requirement of an isolated flash is something that mostly came from
> > >>> the x86 world and is not a reality on the majority of embedded boards.
> > >>> I also think we should give up on Authenticated EFI variables in that
> > >>> case. We get zero guarantees unless the medium has similar properties
> > >>> to an RPMB.
> > >>> If a vendor cares about proper UEFI secure boot he can implement
> > >>> proper hardware.
> > >>>
> > >>>>
> > >>>>>
> > >>>>> 2/ Create an RT variant for the FF-A APIs needed.
> > >>>>>        These RT variant don't call the DM APIs
> > >>>>>        (e.g: ffa_mm_communicate_runtime, ffa_sync_send_receive_runtime, ...)
> > >>>>>
> > >>>>> What do you recommend please ?
> > >>>>
> > >>>> ...this is what I would recommend.  Preferably in a way that refactors
> > >>>> the code such that the low-level functionality is shared between the
> > >>>> DM and non-DM APIs.
> > >>>
> > >>> Yes. The only thing you need to keep alive is the machinery to talk to
> > >>> the secure world. The bus, flash driver etc should all be running
> > >>> isolated in there. In that case you can implement SetVariableRT as
> > >>> described the the EFI spec.
> > >>
> > >> Cool, thanks. That's my preferred solution too.
> > >>
> > >> mm_communicate() should be able to detect runtime mode so it calls ffa_mm_communicate_runtime().
> > >>
> > >> Is there a way to check whether we are in EFI runtime or not ?
> >
> > Relevant UEFI event groups for the transition to the OS are:
> >
> > EFI_EVENT_GROUP_BEFORE_EXIT_BOOT_SERVICES
> > EFI_EVENT_GROUP_EXIT_BOOT_SERVICES
> > EFI_EVENT_GROUP_VIRTUAL_ADDRESS_CHANGE
> >
> > Once EFI_EVENT_GROUP_EXIT_BOOT_SERVICES is signaled you are at runtime.
> >
> > Use CreateEventEx() to create an event for the group.

Thanks

> 
> On top of that, we are already calling
> efi_variables_boot_exit_notify() based on those events. We could reuse
> that
> 

Currently efi_variables_boot_exit_notify() isn't located in the EFI section (__efi_runtime) as shown here [1].

Should we add __efi_runtime to the prototype ?

[1]: https://github.com/u-boot/u-boot/blob/master/lib/efi_loader/efi_variable_tee.c#L945

Cheers,
Abdellatif
