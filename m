Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D4EC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 17:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4DDC86F20;
	Sat,  4 Nov 2023 18:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE2F486D3C; Sat,  4 Nov 2023 18:13:39 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C8E6F86D3C
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 18:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57E8D2F4;
 Sat,  4 Nov 2023 10:14:16 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63E293F703;
 Sat,  4 Nov 2023 10:13:31 -0700 (PDT)
Date: Sat, 4 Nov 2023 17:12:12 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Rick Chen
 <rick@andestech.com>, Leo <ycliang@andestech.com>, Anup Patel
 <apatel@ventanamicro.com>, Xiang W <merlew4n6@gmail.com>, Chanho Park
 <chanho61.park@samsung.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 u-boot@lists.denx.de, Peter Hoyes <Peter.Hoyes@arm.com>, Alexey Romanov
 <avromanov@salutedevices.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
Message-ID: <20231104171212.3d041a4f@slackpad.lan>
In-Reply-To: <CAPnjgZ1gPRQiEq8=tVCtC6wznOWXX2bLaimSwd73=74oEWAXYQ@mail.gmail.com>
References: <20231031125552.26698-1-heinrich.schuchardt@canonical.com>
 <20231101170559.680ab493@donnerap.manchester.arm.com>
 <50ff2080-5831-4963-937d-331248b59973@canonical.com>
 <CAPnjgZ1gPRQiEq8=tVCtC6wznOWXX2bLaimSwd73=74oEWAXYQ@mail.gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Fri, 3 Nov 2023 13:38:58 -0600
Simon Glass <sjg@chromium.org> wrote:

Hi Simon,

> Hi Heinrich,
> 
> On Wed, 1 Nov 2023 at 14:20, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 11/1/23 19:05, Andre Przywara wrote:  
> > > On Tue, 31 Oct 2023 14:55:50 +0200
> > > Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
> > >
> > > Hi Heinrich,
> > >  
> > >> The Zkr ISA extension (ratified Nov 2021) introduced the seed CSR. It
> > >> provides an interface to a physical entropy source.
> > >>
> > >> A RNG driver based on the seed CSR is provided. It depends on
> > >> mseccfg.sseed being set in the SBI firmware.  
> > >
> > > As you might have seen, I added a similar driver for the respective Arm
> > > functionality:
> > > https://lore.kernel.org/u-boot/20230830113230.3925868-1-andre.przywara@arm.com/
> > >
> > > And I see that you seem to use the same mechanism to probe and init the
> > > driver: U_BOOT_DRVINFO and fail in probe() if the feature is not
> > > implemented.
> > > One downside of this approach is that the driver is always loaded (and
> > > visible in the DM tree), even with the feature not being available.
> > > That doesn't seem too much of a problem on the first glance, but it
> > > occupies a device number, and any subsequent other DM_RNG devices
> > > (like virtio-rng) typically get higher device numbers. So without
> > > the feature, but with virtio-rng, I get:
> > > VExpress64# rng 0
> > > No RNG device  
> 
> Why do we get this? If the device is not there, the bind() function
> can return -ENODEV
> 
> I see this in U-Boot:
> 
> U_BOOT_DRVINFO(cpu_arm_rndr) = {
> 
> We should not use this.

Agreed.

> Use the devicetree.

No, this is definitely not something for the DT, at least not on ARM.
It's perfectly discoverable via the architected CPU ID registers.
Similar to PCI and USB devices, which we don't probe via the DT as well.

It's arguably not proper "driver" material per se, as I've argued before, but
it's the simplest solution and fits in nicely otherwise.

I was wondering if it might be something for UCLASS_CPU, something like
a "CPU feature bus": to let devices register on one on the many CPU
features (instead of compatible strings), then only bind() those
drivers it the respective bit is set.

Does that make sense? Would that be doable without boiling the ocean?
As I don't know if we see many users apart from this.

> > > VExpress64# rng 1
> > > 00000000: f3 88 b6 d4 24 da 49 ca 49 f7 9e 66 5f 12 07 b2  ....$.I.I..f_...  
> >
> >
> > Essentially in any case were you have multiple drivers for the same
> > device using uclass_get_device(, 0, ) and uclass_find_first_device()
> > will only give you the first bound device and not the first successfully
> > probed device. Furthermore neither of this functions causes probing.
> > This is not restricted to the RNG drivers but could also happen with
> > multiple TPM drivers or multiple watchdogs.
> >
> > This patch is related to the problem:
> >
> > [PATCH v1] rng: add dm_rng_read_default() helper
> > https://lore.kernel.org/u-boot/4e28a388-f5b1-4cf7-b0e3-b12a876d0567@gmx.de/T/#me44263ec9141e3ea65ee232aa9a411fc6201bd95
> >
> > We have weak function platform_get_rng_device() which should be moved to
> > drivers/rng/rng-uclass.c.
> >
> > We could add a function to drivers/core/uclass.c to retrieve the first
> > successfully probed device. Another approach would be to implement
> > uclass_driver.post_probe() in the RNG uclass to take note of the first
> > successfully probed device.
> >
> > @Simon:
> > What would make most sense from a DM design standpoint?  
> 
> I am sure I provided feedback on this at the time, but I don't
> remember. OK I just found it here [1]. So the problem is entirely
> because my feedback was not addressed. Please just address it and
> avoid this sort of mess.

Yeah, Tom just merged it, but that's not Heinrich's fault ;-)

> So arm_rndr should have a devicetree compatible string and be bound
> like anything else. If for some reason the device doesn't exist in the
> hardware, it can return -ENODEV from its bind() method.
> 
> If you want to control which RNG device is used for booting, you could
> add a property to /bootstd with a phandle to the device. We are trying
> to provide a standard approach to booting in U-Boot, used by all
> methods. Doing one-off things for particular cases is best avoided.

Picking the first usable device doesn't sound much like a one-off to me.
After all the caller (be it UEFI or the rng command) later detect that
this is not usable. So there might be some merit to cover this more
automatically, either in the caller, or by providing a suitable wrapper
function?

Cheers,
Andre

> > Best regards
> >
> > Heinrich
> >  
> > > ....
> > >
> > > Now the EFI code always picks RNG device 0, which means we don't get
> > > entropy in this case.
> > >
> > > Do you have any idea how to solve this?
> > > Maybe EFI tries to probe further - but that sounds arbitrary.
> > > Or we find another way for probing the device, maybe via some artificial
> > > CPU feature "bus"? There is UCLASS_CPU, but that doesn't look helpful?
> > >
> > > If anyone has any idea, I'd be grateful.
> > >
> > > Cheers,
> > > Andre
> > >  
> > >> If the seed CSR readable, is not determinable by S-mode without risking
> > >> an exception. For safe driver probing allow to resume via a longjmp
> > >> after an exception.
> > >>
> > >> As the driver depends on mseccfg.sseed=1 we should wait with merging the
> > >> driver until a decision has been taken in the RISC-V PRS TG on prescribing
> > >> this.
> > >>
> > >> Setting mseccfg.sseed=1 is queued for OpenSBI [1]. This has been discussed
> > >> in the RISC-V Boot & Runtime Services TG. Standardization has to be pursued
> > >> via the upcoming platform specification.
> > >>
> > >> A bug fix for QEMU relating to the Zkr extension is available in [2].
> > >>
> > >> A similar Linux driver has been proposed in [3].
> > >>
> > >> [1] lib: sbi: Configure seed bits when MSECCFG is readable
> > >>      https://patchwork.ozlabs.org/project/opensbi/patch/20230712083254.1585244-1-sameo@rivosinc.com/
> > >> [2] [PATCH v2 1/1] target/riscv: correct csr_ops[CSR_MSECCFG]
> > >>      https://lore.kernel.org/qemu-devel/20231030102105.19501-1-heinrich.schuchardt@canonical.com/
> > >> [3] [PATCH v4 4/4] RISC-V: Implement archrandom when Zkr is available
> > >>      https://lore.kernel.org/linux-riscv/20230712084134.1648008-5-sameo@rivosinc.com/
> > >>
> > >> v3:
> > >>      Add API documentation.
> > >> v2:
> > >>      Catch exception if mseccfg.sseed=0.
> > >>
> > >> Heinrich Schuchardt (2):
> > >>    riscv: allow resume after exception
> > >>    rng: Provide a RNG based on the RISC-V Zkr ISA extension
> > >>
> > >>   arch/riscv/lib/interrupts.c |  13 ++++
> > >>   doc/api/index.rst           |   1 +
> > >>   drivers/rng/Kconfig         |   8 +++
> > >>   drivers/rng/Makefile        |   1 +
> > >>   drivers/rng/riscv_zkr_rng.c | 116 ++++++++++++++++++++++++++++++++++++
> > >>   include/interrupt.h         |  45 ++++++++++++++
> > >>   6 files changed, 184 insertions(+)
> > >>   create mode 100644 drivers/rng/riscv_zkr_rng.c
> > >>   create mode 100644 include/interrupt.h
> > >>  
> > >  
> >  
> 
> Regards,
> Simon
> 
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20230830113230.3925868-1-andre.przywara@arm.com/

