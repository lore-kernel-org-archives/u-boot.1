Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7E3C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 17:50:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D084C876CD;
	Wed,  1 Nov 2023 18:50:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 641E2876D9; Wed,  1 Nov 2023 18:50:04 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B8645876C7
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 18:49:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A49C92F4;
 Wed,  1 Nov 2023 10:50:38 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6835D3F738;
 Wed,  1 Nov 2023 10:49:55 -0700 (PDT)
Date: Wed, 1 Nov 2023 17:49:51 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Rick Chen
 <rick@andestech.com>, Leo <ycliang@andestech.com>, Anup Patel
 <apatel@ventanamicro.com>, Xiang W <merlew4n6@gmail.com>, Chanho Park
 <chanho61.park@samsung.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 u-boot@lists.denx.de, Peter Hoyes <Peter.Hoyes@arm.com>
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
Message-ID: <20231101174951.2baa2471@donnerap.manchester.arm.com>
In-Reply-To: <5f170b50-94ac-5bf6-87d2-a3e12b8ba364@gmail.com>
References: <20231031125552.26698-1-heinrich.schuchardt@canonical.com>
 <20231101170559.680ab493@donnerap.manchester.arm.com>
 <5f170b50-94ac-5bf6-87d2-a3e12b8ba364@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 1 Nov 2023 13:16:24 -0400
Sean Anderson <seanga2@gmail.com> wrote:

Hi Sean,

> On 11/1/23 13:05, Andre Przywara wrote:
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
> > VExpress64# rng 1
> > 00000000: f3 88 b6 d4 24 da 49 ca 49 f7 9e 66 5f 12 07 b2  ....$.I.I..f_...
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
> 
> Wouldn't the right way be to detect the hardware in bind()?

Yes, that's what I thought as well and tried, but the problem is that for
those "fixed drivers" (the ones using U_BOOT_DRVINFO) returning a
failure in bind() is fatal to the boot sequence:
============
Model: FVP Base
DRAM:  2 GiB (effective 4 GiB)
No match for driver 'arm-rndr'
initcall failed at call 00000000fef3d744 (err=-19)
### ERROR ### Please RESET the board ###

That is what a proper "CPU bus" would probably solve, as I agree that
failing bind() should be the proper solution.

Cheers,
Andre

> --Sean
> 
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
> >> 	Add API documentation.
> >> v2:
> >> 	Catch exception if mseccfg.sseed=0.
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

