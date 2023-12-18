Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14EDC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 16:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC6768718A;
	Mon, 18 Dec 2023 17:59:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA7DE8718A; Mon, 18 Dec 2023 17:59:22 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6C989870D4
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 17:59:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9775C2F4;
 Mon, 18 Dec 2023 09:00:01 -0800 (PST)
Received: from e130802.arm.com (unknown [10.57.4.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 514FF3F5A1;
 Mon, 18 Dec 2023 08:59:15 -0800 (PST)
Date: Mon, 18 Dec 2023 16:59:09 +0000
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, sjg@chromium.org, mark.kettenis@xs4all.nl,
 Drew.Reed@arm.com, u-boot@lists.denx.de, nd@arm.com
Subject: Re: Adding EFI runtime support to the Arm's FF-A bus
Message-ID: <20231218165909.GA313366@e130802.arm.com>
References: <20231214155346.GB295924@e130802.arm.com>
 <87ttok689d.fsf@bloch.sibelius.xs4all.nl>
 <CAC_iWjKYa1_GrU3XPKqbnOf6VJxx426qTfD1WcSMkmj982ECSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_iWjKYa1_GrU3XPKqbnOf6VJxx426qTfD1WcSMkmj982ECSw@mail.gmail.com>
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

Hi Ilias

On Thu, Dec 14, 2023 at 09:47:13PM +0200, Ilias Apalodimas wrote:
> Hi Mark, Abdellatif
> 
> On Thu, 14 Dec 2023 at 18:47, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> >
> > > Date: Thu, 14 Dec 2023 15:53:46 +0000
> > > From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> >
> > Hi Abdellatif,
> >
> > > Hi guys,
> > >
> > > I'd like to ask for advice regarding adding EFI RT support to the Arm's FF-A bus
> > > in U-Boot.
> > >
> > > The objective is to enable the FF-A messaging APIs in EFI RT to be
> > > used for comms with the secure world. This will help getting/setting
> > > EFI variables through FF-A.
> > >
> > > The existing FF-A APIs in U-Boot call the DM APIs (which are not available at RT).
> > >
> > > Two possible solutions:
> > >
> > > 1/ having the entire U-Boot in RT space (as Simon stated in this discussion[1])
> >
> > I don't think this is a terribly good idea.  With this approach orders
> > of magnitude more code will be present in kernel address space one the
> > OS kernel is running and calling into the EFI runtime.  Including code
> > that may access hardware devices that are now under OS control.  It
> > will be nigh impossible to audit all that code and make sure that only
> > a safe subset of it gets called.  So...
> 
> +100
> I think we should draw a line here. I mentioned it on another thread,
> but I did a shot BoF in Plumbers discussing issues like this,
> problems, and potential solutions [0] [1]. Since that talk patches for
> the kernel that 'solve' the problem for RPMBs got pulled into
> linux-next [2].

I watched your talk. Great work, thanks :)

> The TL;DR of that talk is that if the kernel ends up being in control
> of the hardware that stores the EFI variables, we need to find elegant
> ways to teach the kernel how to store those directly. The EFI
> requirement of an isolated flash is something that mostly came from
> the x86 world and is not a reality on the majority of embedded boards.
> I also think we should give up on Authenticated EFI variables in that
> case. We get zero guarantees unless the medium has similar properties
> to an RPMB.
> If a vendor cares about proper UEFI secure boot he can implement
> proper hardware.
> 
> >
> > >
> > > 2/ Create an RT variant for the FF-A APIs needed.
> > >       These RT variant don't call the DM APIs
> > >       (e.g: ffa_mm_communicate_runtime, ffa_sync_send_receive_runtime, ...)
> > >
> > > What do you recommend please ?
> >
> > ...this is what I would recommend.  Preferably in a way that refactors
> > the code such that the low-level functionality is shared between the
> > DM and non-DM APIs.
> 
> Yes. The only thing you need to keep alive is the machinery to talk to
> the secure world. The bus, flash driver etc should all be running
> isolated in there. In that case you can implement SetVariableRT as
> described the the EFI spec.

Cool, thanks. That's my preferred solution too.

mm_communicate() should be able to detect runtime mode so it calls ffa_mm_communicate_runtime().

Is there a way to check whether we are in EFI runtime or not ?

Suggested changes (pseudo-code):

__efi_runtime mm_communicate () {
#if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
if (RT) { /* NEW */
        ret = ffa_mm_communicate_runtime(comm_buf, dsize); /* NEW */
} else {
    mm_comms = get_mm_comms();
    if (mm_comms == MM_COMMS_FFA)
        ret = ffa_mm_communicate(comm_buf, dsize);
    else
        ret = optee_mm_communicate(comm_buf, dsize);
}
#else
...
#endif

Existing code:  https://github.com/u-boot/u-boot/blob/master/lib/efi_loader/efi_variable_tee.c#L417

Cheers,
Abdellatif
