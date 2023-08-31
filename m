Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86763C83F3C
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 19:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD4A4867C3;
	Thu, 31 Aug 2023 21:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WaSLxbMo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E4F586523; Thu, 31 Aug 2023 21:03:08 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0599186703
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 21:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5925e580e87so12943567b3.1
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 12:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693508581; x=1694113381; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LBKdvk2/17etSrjtPD3uEcMIDYgGq2yQqaXQRzDeCuI=;
 b=WaSLxbMojpbjDq6iM5f35rPEUM6C+lvbhjeoNqssFf/cXAViJB7ICeJdNMI9m5OXXZ
 nYg+F4t3QplEhc7NM7xI6oaAYigw2H4U0mRlUm8kjPJI5q/YN21SvyrKpfkY/DtjvAK6
 bFUBbT1qFTM7OrdmIXf7W0NND5zF3oGCAU2hM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693508581; x=1694113381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LBKdvk2/17etSrjtPD3uEcMIDYgGq2yQqaXQRzDeCuI=;
 b=K05JJ2ufWWicn0J2d1iWqRRPYY9GRS7fYprsW73nfZeO1Zlsb4NBkp7tMUvQrujeHa
 AOU/GsoWkrbY/oji8xUdk1apGpz97joWrZrMxmCasBUjKr5/BGfZTBmpcToncSDAZwgR
 bE3EUJyecPu4AiHQcP2Jf3CjZ56nI3Tzyb18mtnX8AxAqB/2+GdtJsbQ36Nvclm7FkPz
 USlF+BrmjU6zWaR1lT3X94UqwvAzGFbHTruAl3+xY0c6IV63tp3ZlPGnj89F77+XxvaY
 L5O7pyT0HLFEDlSZ06TNZvhIUKfNiH5nVJTHWyKork0DqEPL7NG4jk2DzQzhqdFzaFO4
 qlQg==
X-Gm-Message-State: AOJu0Yz9NORjMXgHmeH0OcMlC3dmziSX+myWHRA4Yaet1NQCP4cHqku4
 UPVjkFk3bMivzhdzxvMs0+/ga8N/bC3IHSLmYZpa1w==
X-Google-Smtp-Source: AGHT+IG511WstnwnSvfr+M8eSyNatfWt5famOm7KYnHhn6zApzcIZ0xBZdcr2ekoIaIPC4CeBBGKFpmx82Gx+0m8gWU=
X-Received: by 2002:a25:26c9:0:b0:d11:c89:4256 with SMTP id
 m192-20020a2526c9000000b00d110c894256mr620272ybm.31.1693508581410; Thu, 31
 Aug 2023 12:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230830113230.3925868-1-andre.przywara@arm.com>
 <CAPnjgZ0Q7LUe1Qf6S16RLwPPdVjhs+Z760g8CK2Zq4=vev0hFA@mail.gmail.com>
 <20230831134324.2ae66c5d@donnerap.manchester.arm.com>
In-Reply-To: <20230831134324.2ae66c5d@donnerap.manchester.arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Aug 2023 13:01:57 -0600
Message-ID: <CAPnjgZ3Pa4iEhCiGnvwP+XxDsShxuKTjGq=fJ9JXh9LeUn1u8A@mail.gmail.com>
Subject: Re: [PATCH] driver: rng: Add DM_RNG interface for ARMv8.5 RNDR
 registers
To: Andre Przywara <andre.przywara@arm.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Peter Hoyes <peter.hoyes@arm.com>, u-boot@lists.denx.de
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

On Thu, 31 Aug 2023 at 06:43, Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Wed, 30 Aug 2023 20:49:18 -0600
> Simon Glass <sjg@chromium.org> wrote:
>
> Hi Simon,
>
> > On Wed, 30 Aug 2023 at 05:32, Andre Przywara <andre.przywara@arm.com> wrote:
> > >
> > > The ARMv8.5 architecture extension defines architectural RNDR/RNDRRS
> > > system registers, that provide 64 bits worth of randomness on every
> > > read. Since it's an extension, and implementing it is optional, there is
> > > a field in the ID_AA64ISAR0_EL1 ID register to query the availability
> > > of those registers.
> > >
> > > Add a UCLASS_RNG driver that returns entropy via repeated reads from
> > > those system registers, if the extension is implemented.
> > > The driver always binds, but checks the availability in the probe()
> > > routine.
> > >
> > > This helps systems which suffer from low boot entropy, since U-Boot can
> > > provide entropy via the generic UEFI entropy gathering protocol to the OS,
> > > at an early stage.
> > >
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > ---
> > > Hi Simon,
> > >
> > > not sure if this is the expected way to model a driver which autodetects
> > > its device at runtime. It somewhat works, but always lists the bound
> > > device, even if the registers are not supported. If I do the check in bind
> > > instead, it fails booting when this returns -ENODEV, since it expects
> > > the fixed device to always bind successfully, I guess?
> > > Is there any other way of modeling this? And before you say your
> > > favourite two letters: this is not a DT job, since it can be safely
> > > auto-detected in an architectural way.
> > >
> > > Thanks,
> > > Andre
> > >
> > >  arch/arm/include/asm/system.h |  1 +
> > >  drivers/rng/Kconfig           |  6 +++
> > >  drivers/rng/Makefile          |  1 +
> > >  drivers/rng/arm_rndr.c        | 82 +++++++++++++++++++++++++++++++++++
> > >  4 files changed, 90 insertions(+)
> > >  create mode 100644 drivers/rng/arm_rndr.c
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
>
> thanks!
>
> > nit below
> >
> > >
> > > diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> > > index 87d1c77e8b1..0eae857e73a 100644
> > > --- a/arch/arm/include/asm/system.h
> > > +++ b/arch/arm/include/asm/system.h
> > > @@ -84,6 +84,7 @@
> > >  #define HCR_EL2_HCD_DIS                (1 << 29) /* Hypervisor Call disabled         */
> > >  #define HCR_EL2_AMO_EL2                (1 <<  5) /* Route SErrors to EL2             */
> > >
> > > +#define ID_AA64ISAR0_EL1_RNDR  (0xFUL << 60) /* RNDR random registers */
> > >  /*
> > >   * ID_AA64ISAR1_EL1 bits definitions
> > >   */
> > > diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
> > > index 5deb5db5b71..72788d479cc 100644
> > > --- a/drivers/rng/Kconfig
> > > +++ b/drivers/rng/Kconfig
> > > @@ -76,6 +76,12 @@ config RNG_SMCCC_TRNG
> > >           Enable random number generator for platforms that support Arm
> > >           SMCCC TRNG interface.
> > >
> > > +config RNG_ARM_RNDR
> > > +       bool "Generic ARMv8.5 RNDR register"
> > > +       depends on DM_RNG && ARM64
> > > +       help
> > > +         Use the ARMv8.5 RNDR register to provide random numbers.
> > > +
> > >  config TPM_RNG
> > >         bool "Enable random number generator on TPM device"
> > >         depends on TPM
> > > diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
> > > index 78f61051acf..572fa7a0c66 100644
> > > --- a/drivers/rng/Makefile
> > > +++ b/drivers/rng/Makefile
> > > @@ -13,4 +13,5 @@ obj-$(CONFIG_RNG_STM32MP1) += stm32mp1_rng.o
> > >  obj-$(CONFIG_RNG_ROCKCHIP) += rockchip_rng.o
> > >  obj-$(CONFIG_RNG_IPROC200) += iproc_rng200.o
> > >  obj-$(CONFIG_RNG_SMCCC_TRNG) += smccc_trng.o
> > > +obj-$(CONFIG_RNG_ARM_RNDR) += arm_rndr.o
> > >  obj-$(CONFIG_TPM_RNG) += tpm_rng.o
> > > diff --git a/drivers/rng/arm_rndr.c b/drivers/rng/arm_rndr.c
> > > new file mode 100644
> > > index 00000000000..55989743eae
> > > --- /dev/null
> > > +++ b/drivers/rng/arm_rndr.c
> > > @@ -0,0 +1,82 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2023, Arm Ltd.
> > > + *
> > > + * Use the (optional) ARMv8.5 RNDR register to provide random numbers to
> > > + * U-Boot's UCLASS_RNG users.
> > > + * Detection is done at runtime using the CPU ID registers.
> > > + */
> > > +
> > > +#define LOG_CATEGORY UCLASS_RNG
> > > +
> > > +#include <common.h>
> > > +#include <dm.h>
> > > +#include <linux/kernel.h>
> > > +#include <rng.h>
> > > +#include <asm/system.h>
> > > +
> > > +#define DRIVER_NAME    "arm-rndr"
> > > +
> > > +static bool cpu_has_rndr(void)
> > > +{
> > > +       uint64_t reg;
> > > +
> > > +       __asm__ volatile("mrs %0, ID_AA64ISAR0_EL1\n" : "=r" (reg));
> > > +       return !!(reg & ID_AA64ISAR0_EL1_RNDR);
> > > +}
> > > +
> > > +/*
> > > + * The system register name is RNDR, but this isn't widely known among older
> > > + * toolchains, and also triggers errors because of it being an architecture
> > > + * extension. Since we check the availability of the register before, it's
> > > + * fine to use here, though.
> > > + */
> > > +#define RNDR   "S3_3_C2_C4_0"
> > > +
> > > +static uint64_t read_rndr(void)
> > > +{
> > > +       uint64_t reg;
> > > +
> > > +       __asm__ volatile("mrs %0, " RNDR "\n" : "=r" (reg));
> > > +
> > > +       return reg;
> > > +}
> > > +
> > > +static int arm_rndr_read(struct udevice *dev, void *data, size_t len)
> > > +{
> > > +       uint64_t random;
> > > +
> > > +       while (len) {
> > > +               int tocopy = min(sizeof(uint64_t), len);
> > > +
> > > +               random = read_rndr();
> > > +               memcpy(data, &random, tocopy);
> > > +               len -= tocopy;
> > > +               data += tocopy;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static const struct dm_rng_ops arm_rndr_ops = {
> > > +       .read = arm_rndr_read,
> > > +};
> > > +
> > > +static int arm_rndr_probe(struct udevice *dev)
> > > +{
> > > +       if (!cpu_has_rndr())
> > > +               return -ENODEV;
> >
> > Can you put this in a bind() function instead, if not too expensive?
>
> That's the point I was wondering about (see my message to you above, after
> the S-o-B): it seems more natural there, but stops the boot.
> Apparently DM expects those fixed devices (U_BOOT_DRVINFO) to always
> succeed their bind() calls? Because if I put it in bind, I get:
> ================
> No match for driver 'arm-rndr'
> initcall sequence 00000000fefc4528 failed at call 000000008801d104 (err=-19)
> ### ERROR ### Please RESET the board ###
> ================
> if the feature is not available.
> Any suggestions how to use bind and avoid that crash are highly welcome.

An #ifdef is the only thing I can suggest.

Why not add the node to the DT?

>
> And regarding "expensive": This is reading a fixed, read-only system
> register. There is probably nothing cheaper than that on a modern chip.

No I meant expensive in terms of code size, but I don't think a bind()
function matters here.
[..]
Regards,
Simon
