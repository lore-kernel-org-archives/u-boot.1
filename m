Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC84CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 10:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BBD9868D0;
	Fri,  1 Sep 2023 12:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29F60868BB; Fri,  1 Sep 2023 12:00:07 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0BA2B8676C
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 12:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 287EDFEC;
 Fri,  1 Sep 2023 03:00:42 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEE3C3FBD2;
 Fri,  1 Sep 2023 03:00:02 -0700 (PDT)
Date: Fri, 1 Sep 2023 10:59:58 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Peter Hoyes <peter.hoyes@arm.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] driver: rng: Add DM_RNG interface for ARMv8.5 RNDR
 registers
Message-ID: <20230901105958.4c686dd0@donnerap.manchester.arm.com>
In-Reply-To: <CAPnjgZ3Pa4iEhCiGnvwP+XxDsShxuKTjGq=fJ9JXh9LeUn1u8A@mail.gmail.com>
References: <20230830113230.3925868-1-andre.przywara@arm.com>
 <CAPnjgZ0Q7LUe1Qf6S16RLwPPdVjhs+Z760g8CK2Zq4=vev0hFA@mail.gmail.com>
 <20230831134324.2ae66c5d@donnerap.manchester.arm.com>
 <CAPnjgZ3Pa4iEhCiGnvwP+XxDsShxuKTjGq=fJ9JXh9LeUn1u8A@mail.gmail.com>
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

On Thu, 31 Aug 2023 13:01:57 -0600
Simon Glass <sjg@chromium.org> wrote:

Hi Simon,

> On Thu, 31 Aug 2023 at 06:43, Andre Przywara <andre.przywara@arm.com> wrote:
> >
> > On Wed, 30 Aug 2023 20:49:18 -0600
> > Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Simon,
> >  
> > > On Wed, 30 Aug 2023 at 05:32, Andre Przywara <andre.przywara@arm.com> wrote:  
> > > >
> > > > The ARMv8.5 architecture extension defines architectural RNDR/RNDRRS
> > > > system registers, that provide 64 bits worth of randomness on every
> > > > read. Since it's an extension, and implementing it is optional, there is
> > > > a field in the ID_AA64ISAR0_EL1 ID register to query the availability
> > > > of those registers.
> > > >
> > > > Add a UCLASS_RNG driver that returns entropy via repeated reads from
> > > > those system registers, if the extension is implemented.
> > > > The driver always binds, but checks the availability in the probe()
> > > > routine.
> > > >
> > > > This helps systems which suffer from low boot entropy, since U-Boot can
> > > > provide entropy via the generic UEFI entropy gathering protocol to the OS,
> > > > at an early stage.
> > > >
> > > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > > ---
> > > > Hi Simon,
> > > >
> > > > not sure if this is the expected way to model a driver which autodetects
> > > > its device at runtime. It somewhat works, but always lists the bound
> > > > device, even if the registers are not supported. If I do the check in bind
> > > > instead, it fails booting when this returns -ENODEV, since it expects
> > > > the fixed device to always bind successfully, I guess?
> > > > Is there any other way of modeling this? And before you say your
> > > > favourite two letters: this is not a DT job, since it can be safely
> > > > auto-detected in an architectural way.
> > > >
> > > > Thanks,
> > > > Andre
> > > >
> > > >  arch/arm/include/asm/system.h |  1 +
> > > >  drivers/rng/Kconfig           |  6 +++
> > > >  drivers/rng/Makefile          |  1 +
> > > >  drivers/rng/arm_rndr.c        | 82 +++++++++++++++++++++++++++++++++++
> > > >  4 files changed, 90 insertions(+)
> > > >  create mode 100644 drivers/rng/arm_rndr.c  
> > >
> > > Reviewed-by: Simon Glass <sjg@chromium.org>  
> >
> > thanks!
> >  
> > > nit below
> > >  
> > > >
> > > > diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> > > > index 87d1c77e8b1..0eae857e73a 100644
> > > > --- a/arch/arm/include/asm/system.h
> > > > +++ b/arch/arm/include/asm/system.h
> > > > @@ -84,6 +84,7 @@
> > > >  #define HCR_EL2_HCD_DIS                (1 << 29) /* Hypervisor Call disabled         */
> > > >  #define HCR_EL2_AMO_EL2                (1 <<  5) /* Route SErrors to EL2             */
> > > >
> > > > +#define ID_AA64ISAR0_EL1_RNDR  (0xFUL << 60) /* RNDR random registers */
> > > >  /*
> > > >   * ID_AA64ISAR1_EL1 bits definitions
> > > >   */
> > > > diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
> > > > index 5deb5db5b71..72788d479cc 100644
> > > > --- a/drivers/rng/Kconfig
> > > > +++ b/drivers/rng/Kconfig
> > > > @@ -76,6 +76,12 @@ config RNG_SMCCC_TRNG
> > > >           Enable random number generator for platforms that support Arm
> > > >           SMCCC TRNG interface.
> > > >
> > > > +config RNG_ARM_RNDR
> > > > +       bool "Generic ARMv8.5 RNDR register"
> > > > +       depends on DM_RNG && ARM64
> > > > +       help
> > > > +         Use the ARMv8.5 RNDR register to provide random numbers.
> > > > +
> > > >  config TPM_RNG
> > > >         bool "Enable random number generator on TPM device"
> > > >         depends on TPM
> > > > diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
> > > > index 78f61051acf..572fa7a0c66 100644
> > > > --- a/drivers/rng/Makefile
> > > > +++ b/drivers/rng/Makefile
> > > > @@ -13,4 +13,5 @@ obj-$(CONFIG_RNG_STM32MP1) += stm32mp1_rng.o
> > > >  obj-$(CONFIG_RNG_ROCKCHIP) += rockchip_rng.o
> > > >  obj-$(CONFIG_RNG_IPROC200) += iproc_rng200.o
> > > >  obj-$(CONFIG_RNG_SMCCC_TRNG) += smccc_trng.o
> > > > +obj-$(CONFIG_RNG_ARM_RNDR) += arm_rndr.o
> > > >  obj-$(CONFIG_TPM_RNG) += tpm_rng.o
> > > > diff --git a/drivers/rng/arm_rndr.c b/drivers/rng/arm_rndr.c
> > > > new file mode 100644
> > > > index 00000000000..55989743eae
> > > > --- /dev/null
> > > > +++ b/drivers/rng/arm_rndr.c
> > > > @@ -0,0 +1,82 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Copyright (c) 2023, Arm Ltd.
> > > > + *
> > > > + * Use the (optional) ARMv8.5 RNDR register to provide random numbers to
> > > > + * U-Boot's UCLASS_RNG users.
> > > > + * Detection is done at runtime using the CPU ID registers.
> > > > + */
> > > > +
> > > > +#define LOG_CATEGORY UCLASS_RNG
> > > > +
> > > > +#include <common.h>
> > > > +#include <dm.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <rng.h>
> > > > +#include <asm/system.h>
> > > > +
> > > > +#define DRIVER_NAME    "arm-rndr"
> > > > +
> > > > +static bool cpu_has_rndr(void)
> > > > +{
> > > > +       uint64_t reg;
> > > > +
> > > > +       __asm__ volatile("mrs %0, ID_AA64ISAR0_EL1\n" : "=r" (reg));
> > > > +       return !!(reg & ID_AA64ISAR0_EL1_RNDR);
> > > > +}
> > > > +
> > > > +/*
> > > > + * The system register name is RNDR, but this isn't widely known among older
> > > > + * toolchains, and also triggers errors because of it being an architecture
> > > > + * extension. Since we check the availability of the register before, it's
> > > > + * fine to use here, though.
> > > > + */
> > > > +#define RNDR   "S3_3_C2_C4_0"
> > > > +
> > > > +static uint64_t read_rndr(void)
> > > > +{
> > > > +       uint64_t reg;
> > > > +
> > > > +       __asm__ volatile("mrs %0, " RNDR "\n" : "=r" (reg));
> > > > +
> > > > +       return reg;
> > > > +}
> > > > +
> > > > +static int arm_rndr_read(struct udevice *dev, void *data, size_t len)
> > > > +{
> > > > +       uint64_t random;
> > > > +
> > > > +       while (len) {
> > > > +               int tocopy = min(sizeof(uint64_t), len);
> > > > +
> > > > +               random = read_rndr();
> > > > +               memcpy(data, &random, tocopy);
> > > > +               len -= tocopy;
> > > > +               data += tocopy;
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static const struct dm_rng_ops arm_rndr_ops = {
> > > > +       .read = arm_rndr_read,
> > > > +};
> > > > +
> > > > +static int arm_rndr_probe(struct udevice *dev)
> > > > +{
> > > > +       if (!cpu_has_rndr())
> > > > +               return -ENODEV;  
> > >
> > > Can you put this in a bind() function instead, if not too expensive?  
> >
> > That's the point I was wondering about (see my message to you above, after
> > the S-o-B): it seems more natural there, but stops the boot.
> > Apparently DM expects those fixed devices (U_BOOT_DRVINFO) to always
> > succeed their bind() calls? Because if I put it in bind, I get:
> > ================
> > No match for driver 'arm-rndr'
> > initcall sequence 00000000fefc4528 failed at call 000000008801d104 (err=-19)
> > ### ERROR ### Please RESET the board ###
> > ================
> > if the feature is not available.
> > Any suggestions how to use bind and avoid that crash are highly welcome.  
> 
> An #ifdef is the only thing I can suggest.
> 
> Why not add the node to the DT?

Because the RNDR system registers are architected and perfectly
discoverable, so out of scope for a devicetree.
The registers are arguably not a device, but a CPU feature, though I found
it useful to represent them as a UCLASS_RNG device, since this ties in
neatly and automatically to the rest of U-Boot, specifically the UEFI
loader, which makes use of it to provide early entropy to the OS.

So either I leave it as it is, living with the fact that it always shows
as "bound" to the driver, even when the feature doesn't exist, or I add
extra code to the efi_rng.c's getrng() function to discover the CPU
feature there. But the latter sounds arbitrary, and would add arch
specific bits to the generic EFI code, plus would also leave out the other
UCLASS_RNG users like kaslrseed.

> > And regarding "expensive": This is reading a fixed, read-only system
> > register. There is probably nothing cheaper than that on a modern chip.  
> 
> No I meant expensive in terms of code size, but I don't think a bind()
> function matters here.

This driver mostly consists of boilerplate code, so I am not worried
about code size at all, and we are not particularly constrained in size.
The feature check itself is typically like three or four assembly
instructions.

Cheers,
Andre
