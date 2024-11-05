Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C11D1269F
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 12:47:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C59918919E;
	Tue,  5 Nov 2024 13:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bDDamcua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7E5A88FDE; Tue,  5 Nov 2024 09:47:52 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DB0988E63
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 09:47:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5ceccffadfdso3034739a12.2
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 00:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730796470; x=1731401270; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Nh1cs0hKlDoF6y/fLlT7OCzg3WDAnvZ9MQNJQ4w+gsk=;
 b=bDDamcuaqsCLbdP7TCHI5s928BWmWVgLamN0s6C9HGEchpnGmCpZui9Z1LOfBGj3kh
 MC1rCe8VgSgFH5assvksQmngLYwJXopAu20i0UWc01nVH3ffTIwNu1alczPcCzxw9dC3
 WNWVvn67S+W1w1dpmzmFpOVgtfp0rUG2KoTD0iurcxas0s74u9/5MXBCNM0ckIjJpJrH
 8yaKtIqcTJOy5HlerdLaCB+bGY8BxD0SglZhC+rPsNCNlM80YLGlqLbNbmM/4mGxcBD5
 CRHJKPG5ztgitLHYgkW1TZHBKgPyyewbvm4FWSwJ3Lp+zUzFiqZoHH2awbjSLwDeB5Gb
 luZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730796470; x=1731401270;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nh1cs0hKlDoF6y/fLlT7OCzg3WDAnvZ9MQNJQ4w+gsk=;
 b=VYy8j2va4SZ+1rO4EZL9f3YtfOU8xpg/XRCAzucKaocKVcPPksJ9rreKmV230YrPDh
 5cHPfnna02ngrozojz0piqY3MpYR/rVUU+pTbi3aN9xObnI5KZV9Wo3K7KAf0rPL+we0
 SRuN8L5P0lPMNVGxa3dXsntCBxlmkZE0nwxu5KC8JwRrmwpWHLXyWkJpSGTZ5Ab4RkgW
 X5Vlw5/pAMRXeIzx03dDR6ShG4MdMKg0MviJOThDYFdxy0am2FIuJeM+b/lFkBklHLem
 hIs7T+fYatvKmAZVIyFyhc0fKVO5DME9dFqxa/lBKvmTDWCXcI4N7yBbS2u+kcPlrz75
 3W1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyp5l8D8swlL2Zg/ec1uOf+knTQRgnWhEh3uYVlmegbwJg3gClDdAF2OME4STtWJKVHSowkgc=@lists.denx.de
X-Gm-Message-State: AOJu0YyZlW1D7+eXbvomB3AYR3k4ys1SFNiHK8MdJd0H65aVVAkvh38a
 dbcX7N9+bZY74i1fHZlqTxUsz9/1s5JFbZx5g9FIn71Ba+xCLQQk
X-Google-Smtp-Source: AGHT+IEWVC76ihOstj6tnpStlvY6CCKDuu2kkj/W3Wl8VYGwoVunODpw8J6Qo+lYJDJCatvyx4T3Uw==
X-Received: by 2002:a17:907:2d12:b0:a99:cedd:4612 with SMTP id
 a640c23a62f3a-a9e508e703fmr1876607366b.22.1730796469679; 
 Tue, 05 Nov 2024 00:47:49 -0800 (PST)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:61c2:fa6e:7930:6c92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb16a2ec7sm102468466b.22.2024.11.05.00.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 00:47:49 -0800 (PST)
Date: Tue, 5 Nov 2024 09:47:47 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Heiko Schocher <hs@denx.de>
Cc: trini@konsulko.com, michal.simek@amd.com, pro@denx.de, sjg@chromium.org,
 vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] drivers: bootcount: Add ZynqMP specific bootcount
 support
Message-ID: <Zynbs3zXf4UrXpSY@vamoirid-laptop>
References: <20241105074917.546887-1-vassilisamir@gmail.com>
 <20241105074917.546887-2-vassilisamir@gmail.com>
 <a9283eeb-b186-e0a0-b9db-d77048ea0fb3@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9283eeb-b186-e0a0-b9db-d77048ea0fb3@denx.de>
X-Mailman-Approved-At: Tue, 05 Nov 2024 13:47:04 +0100
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

On Tue, Nov 05, 2024 at 09:36:45AM +0100, Heiko Schocher wrote:
> Hello Amoiridis,
> 
> On 05.11.24 08:49, Vasileios Amoiridis wrote:
> > From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> > 
> > Add native support of the bootcount mechanism in the ZynqMP by
> > utilising internal PMU registers. The Persistent Global Storage
> > Registers of the Platform Management Unit can keep their value
> > during reboot cycles unless there is a POR reset, making them
> > appropriate for the bootcount mechanism.
> > 
> > Signed-off-by: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> > ---
> >   MAINTAINERS                                  |  1 +
> >   arch/arm/mach-zynqmp/include/mach/hardware.h |  2 +
> >   drivers/bootcount/Kconfig                    |  6 +++
> >   drivers/bootcount/Makefile                   |  1 +
> >   drivers/bootcount/bootcount_zynqmp.c         | 47 ++++++++++++++++++++
> >   5 files changed, 57 insertions(+)
> >   create mode 100644 drivers/bootcount/bootcount_zynqmp.c
> 
> Please add a history of changes you did, see:
> 
> https://docs.u-boot.org/en/latest/develop/sending_patches.html#sending-updated-patch-versions
> 
> Hint: I prefer to use patman for this.
> 

Ah this got lost because of the rebase... In any case, a bit too
late, v1 is here [1].

[1]: https://lore.kernel.org/u-boot/20241029185814.7937-1-vassilisamir@gmail.com/

> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0399ed1dbf..bc27a514e8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -860,6 +860,7 @@ M:	Michal Simek <michal.simek@amd.com>
> >   S:	Maintained
> >   T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
> >   F:	arch/arm/mach-zynqmp/
> > +F:	drivers/bootcount/bootcount_zynqmp.c
> >   F:	drivers/clk/clk_zynqmp.c
> >   F:	driver/firmware/firmware-zynqmp.c
> >   F:	drivers/fpga/zynqpl.c
> > diff --git a/arch/arm/mach-zynqmp/include/mach/hardware.h b/arch/arm/mach-zynqmp/include/mach/hardware.h
> > index 49e449ebd6..3c372bd6dc 100644
> > --- a/arch/arm/mach-zynqmp/include/mach/hardware.h
> > +++ b/arch/arm/mach-zynqmp/include/mach/hardware.h
> > @@ -188,6 +188,8 @@ struct pmu_regs {
> >   	u32 gen_storage4; /* 0x40 */
> >   	u32 reserved1[1];
> >   	u32 gen_storage6; /* 0x48 */
> > +	u32 reserved2[3];
> > +	u32 pers_gen_storage2; /* 0x58 */
> >   };
> >   #define pmu_base ((struct pmu_regs *)ZYNQMP_PMU_BASEADDR)
> > diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
> > index fa6d8e7128..f91074d5b4 100644
> > --- a/drivers/bootcount/Kconfig
> > +++ b/drivers/bootcount/Kconfig
> > @@ -164,6 +164,12 @@ config DM_BOOTCOUNT_SYSCON
> >   	  Accessing the backend is done using the regmap interface.
> > +config DM_BOOTCOUNT_ZYNQMP
> > +	bool "Support ZynqMP PMUFW as a backing store for bootcount"
> > +	help
> > +	  Enable support for the bootcount API by utilising the Persistent
> > +	  Global General Storage Register 2 of the PMU.
> > +
> >   endmenu
> >   endif
> > diff --git a/drivers/bootcount/Makefile b/drivers/bootcount/Makefile
> > index 245f879633..0cf79e428d 100644
> > --- a/drivers/bootcount/Makefile
> > +++ b/drivers/bootcount/Makefile
> > @@ -16,3 +16,4 @@ obj-$(CONFIG_DM_BOOTCOUNT_I2C_EEPROM)	+= i2c-eeprom.o
> >   obj-$(CONFIG_DM_BOOTCOUNT_I2C)	+= bootcount_dm_i2c.o
> >   obj-$(CONFIG_DM_BOOTCOUNT_SPI_FLASH)	+= spi-flash.o
> >   obj-$(CONFIG_DM_BOOTCOUNT_SYSCON) += bootcount_syscon.o
> > +obj-$(CONFIG_DM_BOOTCOUNT_ZYNQMP)	+= bootcount_zynqmp.o
> > diff --git a/drivers/bootcount/bootcount_zynqmp.c b/drivers/bootcount/bootcount_zynqmp.c
> > new file mode 100644
> > index 0000000000..060bbdbae9
> > --- /dev/null
> > +++ b/drivers/bootcount/bootcount_zynqmp.c
> > @@ -0,0 +1,47 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +// SPDX-FileCopyrightText: 2024 CERN (home.cern)
> > +
> > +#include <asm/arch/hardware.h>
> > +#include <bootcount.h>
> > +#include <dm.h>
> > +#include <dm/platdata.h>
> > +#include <stdio.h>
> > +#include <zynqmp_firmware.h>
> > +
> > +static int bootcount_zynqmp_set(struct udevice *dev, const u32 val)
> > +{
> > +	int ret;
> > +
> > +	ret = zynqmp_mmio_write((ulong)&pmu_base->pers_gen_storage2, 0xFF, val);
> > +	if (ret)
> > +		pr_info("%s mio write fail\n", __func__);
> 
> Nitpick: I think you do not need "mio" ...
>

Even the read/write is redundant in my opinion since the name of
the function is printed but in other cases 
(i.e drivers/clk/clk_zynqmp.c) I saw it used like this.

> > +
> > +	return ret;
> > +}
> > +
> > +static int bootcount_zynqmp_get(struct udevice *dev, u32 *val)
> > +{
> > +	int ret;
> > +
> > +	*val = 0;
> > +	ret = zynqmp_mmio_read((ulong)&pmu_base->pers_gen_storage2, val);
> > +	if (ret)
> > +		pr_info("%s mio write fail\n", __func__);
> 
> Here too... remove mio and s/write/read
>

Will fix that in v3, thanks!

> > +
> > +	return ret;
> > +}
> > +
> > +U_BOOT_DRVINFO(bootcount_zynqmp) = {
> > +	.name = "bootcount_zynqmp",
> > +};
> > +
> > +static const struct bootcount_ops bootcount_zynqmp_ops = {
> > +	.get = bootcount_zynqmp_get,
> > +	.set = bootcount_zynqmp_set,
> > +};
> > +
> > +U_BOOT_DRIVER(bootcount_zynqmp) = {
> > +	.name = "bootcount_zynqmp",
> > +	.id = UCLASS_BOOTCOUNT,
> > +	.ops = &bootcount_zynqmp_ops,
> > +};
> > 
> 
> Thanks! Beside of the nitpicks
> 
> Reviewed-by: Heiko Schocher <hs@denx.de>
> 
> bye,
> Heiko

Thank you for your time!

Cheers,
Vasilis
> -- 
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
