Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518E9C83F21
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 02:50:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31EA586567;
	Thu, 31 Aug 2023 04:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OAmI1XHG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83EBE86550; Thu, 31 Aug 2023 04:50:04 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98CE68656C
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 04:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-52bca2e8563so331752a12.2
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 19:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693450199; x=1694054999; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dtTYUs9itjqCyqqwdvstXYgFRI/tvlJDlKREbFnw14c=;
 b=OAmI1XHGlb8QqXaOuUZ84CuIATnBSXK6osLyjoCdq/vij1toMyI0PUCLWR3jw0OvwD
 PPNdhhGrGaf/Q3MXgWgDMlWrZpwC7WUbmETbai6CA+0oxwieS/tGILixaCuY7gabu1JQ
 3Ba7jwTXAcQfMSfNrXg2x9+/gcdn10+DBBz2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693450199; x=1694054999;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dtTYUs9itjqCyqqwdvstXYgFRI/tvlJDlKREbFnw14c=;
 b=exWjJcrYGDNwVjGZN7fEJQIwV62SwW3gmKyJDTxZ0zc3zDlcE6XyZed0sCGsOJM+kN
 3VUl18VwuTDjPs+nNqHl1idX0uSO9uD+y1ssnVKyU0dUT5eL7Ft8Sj9HX4Q8kMDg2R7J
 OfL0i7qqsHs5+a3scSgwd1F4Jk6OBiyvGOpQ1sYjZOD9RA5hrDiDAgi/oov+hiPzr+33
 LTqRJetJnLGaXO9hQ8tqsV0svXBdJRM5rmkV59CQZ0P0LyRuuKa4w2icZHtvIxbju37m
 Jh01HJGX5L7eeYWuvJKGTlCEBWBatzt62sNCKdqqxR0c56tOq8x6AyVj5B6SeucPu5b4
 Hv0A==
X-Gm-Message-State: AOJu0YxRemmlpA7U6Q1jqjPcGmGQmVxbgf7GcldtbkBFkVaLVomz2LGG
 PSq5xIfB5Dy24Q6Y4mCPxB7aZdPzLx2qaG4NktNjtw==
X-Google-Smtp-Source: AGHT+IFoPVqiD6XrsEoeBiHvRpATBiJ+4pYg+gzJ7lROLOn261zyzrjaG88xxFg3ZNhy1A1zgW9tDUwgKxEaemZvVug=
X-Received: by 2002:a05:6402:5156:b0:523:bfec:490f with SMTP id
 n22-20020a056402515600b00523bfec490fmr3287281edd.0.1693450198966; Wed, 30 Aug
 2023 19:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230830113230.3925868-1-andre.przywara@arm.com>
In-Reply-To: <20230830113230.3925868-1-andre.przywara@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Aug 2023 20:49:18 -0600
Message-ID: <CAPnjgZ0Q7LUe1Qf6S16RLwPPdVjhs+Z760g8CK2Zq4=vev0hFA@mail.gmail.com>
Subject: Re: [PATCH] driver: rng: Add DM_RNG interface for ARMv8.5 RNDR
 registers
To: andre.przywara@arm.com
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

On Wed, 30 Aug 2023 at 05:32, Andre Przywara <andre.przywara@arm.com> wrote:
>
> The ARMv8.5 architecture extension defines architectural RNDR/RNDRRS
> system registers, that provide 64 bits worth of randomness on every
> read. Since it's an extension, and implementing it is optional, there is
> a field in the ID_AA64ISAR0_EL1 ID register to query the availability
> of those registers.
>
> Add a UCLASS_RNG driver that returns entropy via repeated reads from
> those system registers, if the extension is implemented.
> The driver always binds, but checks the availability in the probe()
> routine.
>
> This helps systems which suffer from low boot entropy, since U-Boot can
> provide entropy via the generic UEFI entropy gathering protocol to the OS,
> at an early stage.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Hi Simon,
>
> not sure if this is the expected way to model a driver which autodetects
> its device at runtime. It somewhat works, but always lists the bound
> device, even if the registers are not supported. If I do the check in bind
> instead, it fails booting when this returns -ENODEV, since it expects
> the fixed device to always bind successfully, I guess?
> Is there any other way of modeling this? And before you say your
> favourite two letters: this is not a DT job, since it can be safely
> auto-detected in an architectural way.
>
> Thanks,
> Andre
>
>  arch/arm/include/asm/system.h |  1 +
>  drivers/rng/Kconfig           |  6 +++
>  drivers/rng/Makefile          |  1 +
>  drivers/rng/arm_rndr.c        | 82 +++++++++++++++++++++++++++++++++++
>  4 files changed, 90 insertions(+)
>  create mode 100644 drivers/rng/arm_rndr.c

Reviewed-by: Simon Glass <sjg@chromium.org>

nit below

>
> diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> index 87d1c77e8b1..0eae857e73a 100644
> --- a/arch/arm/include/asm/system.h
> +++ b/arch/arm/include/asm/system.h
> @@ -84,6 +84,7 @@
>  #define HCR_EL2_HCD_DIS                (1 << 29) /* Hypervisor Call disabled         */
>  #define HCR_EL2_AMO_EL2                (1 <<  5) /* Route SErrors to EL2             */
>
> +#define ID_AA64ISAR0_EL1_RNDR  (0xFUL << 60) /* RNDR random registers */
>  /*
>   * ID_AA64ISAR1_EL1 bits definitions
>   */
> diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
> index 5deb5db5b71..72788d479cc 100644
> --- a/drivers/rng/Kconfig
> +++ b/drivers/rng/Kconfig
> @@ -76,6 +76,12 @@ config RNG_SMCCC_TRNG
>           Enable random number generator for platforms that support Arm
>           SMCCC TRNG interface.
>
> +config RNG_ARM_RNDR
> +       bool "Generic ARMv8.5 RNDR register"
> +       depends on DM_RNG && ARM64
> +       help
> +         Use the ARMv8.5 RNDR register to provide random numbers.
> +
>  config TPM_RNG
>         bool "Enable random number generator on TPM device"
>         depends on TPM
> diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
> index 78f61051acf..572fa7a0c66 100644
> --- a/drivers/rng/Makefile
> +++ b/drivers/rng/Makefile
> @@ -13,4 +13,5 @@ obj-$(CONFIG_RNG_STM32MP1) += stm32mp1_rng.o
>  obj-$(CONFIG_RNG_ROCKCHIP) += rockchip_rng.o
>  obj-$(CONFIG_RNG_IPROC200) += iproc_rng200.o
>  obj-$(CONFIG_RNG_SMCCC_TRNG) += smccc_trng.o
> +obj-$(CONFIG_RNG_ARM_RNDR) += arm_rndr.o
>  obj-$(CONFIG_TPM_RNG) += tpm_rng.o
> diff --git a/drivers/rng/arm_rndr.c b/drivers/rng/arm_rndr.c
> new file mode 100644
> index 00000000000..55989743eae
> --- /dev/null
> +++ b/drivers/rng/arm_rndr.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023, Arm Ltd.
> + *
> + * Use the (optional) ARMv8.5 RNDR register to provide random numbers to
> + * U-Boot's UCLASS_RNG users.
> + * Detection is done at runtime using the CPU ID registers.
> + */
> +
> +#define LOG_CATEGORY UCLASS_RNG
> +
> +#include <common.h>
> +#include <dm.h>
> +#include <linux/kernel.h>
> +#include <rng.h>
> +#include <asm/system.h>
> +
> +#define DRIVER_NAME    "arm-rndr"
> +
> +static bool cpu_has_rndr(void)
> +{
> +       uint64_t reg;
> +
> +       __asm__ volatile("mrs %0, ID_AA64ISAR0_EL1\n" : "=r" (reg));
> +       return !!(reg & ID_AA64ISAR0_EL1_RNDR);
> +}
> +
> +/*
> + * The system register name is RNDR, but this isn't widely known among older
> + * toolchains, and also triggers errors because of it being an architecture
> + * extension. Since we check the availability of the register before, it's
> + * fine to use here, though.
> + */
> +#define RNDR   "S3_3_C2_C4_0"
> +
> +static uint64_t read_rndr(void)
> +{
> +       uint64_t reg;
> +
> +       __asm__ volatile("mrs %0, " RNDR "\n" : "=r" (reg));
> +
> +       return reg;
> +}
> +
> +static int arm_rndr_read(struct udevice *dev, void *data, size_t len)
> +{
> +       uint64_t random;
> +
> +       while (len) {
> +               int tocopy = min(sizeof(uint64_t), len);
> +
> +               random = read_rndr();
> +               memcpy(data, &random, tocopy);
> +               len -= tocopy;
> +               data += tocopy;
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct dm_rng_ops arm_rndr_ops = {
> +       .read = arm_rndr_read,
> +};
> +
> +static int arm_rndr_probe(struct udevice *dev)
> +{
> +       if (!cpu_has_rndr())
> +               return -ENODEV;

Can you put this in a bind() function instead, if not too expensive?

> +
> +       return 0;
> +}
> +
> +U_BOOT_DRIVER(arm_rndr) = {
> +       .name = DRIVER_NAME,
> +       .id = UCLASS_RNG,
> +       .ops = &arm_rndr_ops,
> +       .probe = arm_rndr_probe,
> +};
> +
> +U_BOOT_DRVINFO(cpu_arm_rndr) = {
> +       .name = DRIVER_NAME,
> +};
> --
> 2.25.1
>

Regards,
Simon
