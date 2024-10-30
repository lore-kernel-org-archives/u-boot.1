Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BBED6B6B3
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 17:20:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FC4B89253;
	Wed, 30 Oct 2024 18:20:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Euy3pZwJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7354B88F83; Wed, 30 Oct 2024 15:38:42 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1502C88EDE
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 15:38:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4319399a411so52102365e9.2
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 07:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730299119; x=1730903919; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iy/7AlX8o128c5L6zVnk4oxsRZxAfNCBf5dwdW3o7ig=;
 b=Euy3pZwJWyYRFW66FF73HtKZQFQ3oP7plYt9fdKVcckpl7enYr6xIrE/tSydpJvUbH
 F2rZR+n0JGkMtX+VR/M+C/X/QO8fQ7zaRaNUGbwCrviYt3UlEBbw+oFGv3CLET9CH6nf
 lF2mp9+LrpNZ4ZprkV+g4ci573uxDzlhVvM+NALGNzRuOHIHsaJOqLEXWJBMA3gWfiXN
 f5Z5xjDQJEkUQTc4Rr92DUTVA4Pdp56j/aK5C36Byu79LjpdLoJDW4luV4IQb8V1xBq8
 Fr2repdx6mx5uNdrgSgYzQ4UzMULnrXjb4YHvhU/2j6rTDB7OTM4GW/+yoRHrdnrPw9z
 UjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730299119; x=1730903919;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iy/7AlX8o128c5L6zVnk4oxsRZxAfNCBf5dwdW3o7ig=;
 b=wCCNFZ/FN+QwF2k+S+RXHz7xo7u3J3F6iV74yM8/soyvLQy0JY6HbOE/KwYgXChotf
 iUOh5lEEFNp9nj7agbrdE0P5DYrBqpP2atG6DgsVz/rBGkGH8ftmwCznl7F1iE8RZ/o6
 fYOTkpmfyqABpEUtxmFV+a97qbv1y9vrF/xJ/7L2UrLH0uYTFGZ2hQUxRkSWhdyBlpI9
 zYCa+td2eGN0h9D5vO0Eei8jc9d91y6CcJHPqlrGih4dv3jUdistw4w2yEf080P1OVAR
 4JJLArLzT3Nd3MVVP6lrZd53weEEV9EKk6ZYAoMzR+opM3e8+2m3DISKG1KNG1SHPfQM
 3D0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmjmThDKkjo1Judf0BNBhYYhh68xN97nvNBEnonFWE11waqQk9FEaQi6KTauUp3GHEtSB3RYg=@lists.denx.de
X-Gm-Message-State: AOJu0YxBHucUmHKp4R6xO0OspEft3kh79Wl9v8OdQNvHJ1RLOGJe2Iyo
 ls9z2RMDXZSMhBhUIXuIMLKRJCqbKpU7spAK5U6NRace315WGTOi
X-Google-Smtp-Source: AGHT+IFKbZduL2kaGk2u7eAC54oJooSoPCWD+xf0xaH1wsY/BXmB9QZvSW1v+Hr6Va/2zyWqHQ33GQ==
X-Received: by 2002:adf:a2d2:0:b0:37d:4647:154e with SMTP id
 ffacd0b85a97d-380610f264fmr10836825f8f.9.1730299119298; 
 Wed, 30 Oct 2024 07:38:39 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:89e7:cc9d:3a72:92f3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b929a8sm15655772f8f.103.2024.10.30.07.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 07:38:38 -0700 (PDT)
Date: Wed, 30 Oct 2024 15:38:36 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Michal Simek <michal.simek@amd.com>
Cc: trini@konsulko.com, hs@denx.de, pro@denx.de, sjg@chromium.org,
 vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] drivers: bootcount: Add ZynqMP specific bootcount
 support
Message-ID: <ZyJE7K8Eo7A6smyT@vamoirid-laptop>
References: <20241029185814.7937-1-vassilisamir@gmail.com>
 <20241029185814.7937-2-vassilisamir@gmail.com>
 <c6ad234b-e756-4ea3-8381-63ffca1c2c5c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6ad234b-e756-4ea3-8381-63ffca1c2c5c@amd.com>
X-Mailman-Approved-At: Wed, 30 Oct 2024 18:20:04 +0100
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

On Wed, Oct 30, 2024 at 02:13:43PM +0100, Michal Simek wrote:
> 
> 
> On 10/29/24 19:58, Vasileios Amoiridis wrote:
> > From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> > 
> > Add native support of the bootcount mechanism in the ZynqMP by utilising internal
> > PMU registers. The Persistent Global Storage Registers of the Platform Management
> > Unit can keep their value during reboot cycles unless there is a POR reset, making
> > them appropriate for the bootcount mechanism.
> > 
> > Signed-off-by: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> > ---
> >   drivers/bootcount/Kconfig            |  4 ++++
> >   drivers/bootcount/Makefile           |  1 +
> >   drivers/bootcount/bootcount_zynqmp.c | 28 ++++++++++++++++++++++++++++
> >   3 files changed, 33 insertions(+)
> >   create mode 100644 drivers/bootcount/bootcount_zynqmp.c
> > 
> > diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
> > index fa6d8e7128..95b6a9541a 100644
> > --- a/drivers/bootcount/Kconfig
> > +++ b/drivers/bootcount/Kconfig
> > @@ -82,6 +82,10 @@ config BOOTCOUNT_AT91
> >   	bool "Boot counter for Atmel AT91SAM9XE"
> >   	depends on AT91SAM9XE
> > +config BOOTCOUNT_ZYNQMP
> > +	bool "Boot counter for Zynq UltraScale+ MPSoC"
> > +	depends on ARCH_ZYNQMP
> 
>
> help would help to also described where that count is stored.
> 

Hi Michal,

thanks for the review. Indeed I could add it.

> And why not to have it under DM/U_BOOT_DRIVER?
> You don't need to create compatible string for it just instantiate it.
> 
> Look at:
> 
> U_BOOT_DRVINFO(soc_xilinx_zynqmp) = {
>          .name = "soc_xilinx_zynqmp",
> };
> 

I was not fully aware of this, I could try it. Just out of curiosity, is
this the new/prefered way of adding new drivers?

> 
> > +
> >   config DM_BOOTCOUNT
> >           bool "Boot counter in a device-model device"
> >   	help
> > diff --git a/drivers/bootcount/Makefile b/drivers/bootcount/Makefile
> > index 245f879633..487adc1212 100644
> > --- a/drivers/bootcount/Makefile
> > +++ b/drivers/bootcount/Makefile
> > @@ -3,6 +3,7 @@
> >   obj-$(CONFIG_BOOTCOUNT_GENERIC)	+= bootcount.o
> >   obj-$(CONFIG_BOOTCOUNT_MEM)	+= bootcount.o
> >   obj-$(CONFIG_BOOTCOUNT_AT91)	+= bootcount_at91.o
> > +obj-$(CONFIG_BOOTCOUNT_ZYNQMP)  += bootcount_zynqmp.o
> 
> please put it to the end of CONFIG_BOOTCOUNT to have it at least in correct location
> 
> >   obj-$(CONFIG_BOOTCOUNT_AM33XX)	+= bootcount_davinci.o
> >   obj-$(CONFIG_BOOTCOUNT_RAM)	+= bootcount_ram.o
> >   obj-$(CONFIG_BOOTCOUNT_ENV)	+= bootcount_env.o
> > diff --git a/drivers/bootcount/bootcount_zynqmp.c b/drivers/bootcount/bootcount_zynqmp.c
> > new file mode 100644
> > index 0000000000..9bb801e188
> > --- /dev/null
> > +++ b/drivers/bootcount/bootcount_zynqmp.c
> > @@ -0,0 +1,28 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +// SPDX-FileCopyrightText: 2024 CERN (home.cern)
> > +
> > +#include <bootcount.h>
> > +#include <stdio.h>
> > +#include <zynqmp_firmware.h>
> > +
> > +#define PMU_PERS_GLOB_GEN_STORAGE0 0x00FFD80050
> 
> In arch/arm/mach-zynqmp/include/mach/hardware.h
> there is already structure defined and gen_storage0 is there too.
> Please use it.
> 
> Regarding this location. Exception in PMUFW is using this reg.
> It means at the end of day it is up to you if you want to use it or not.
> 

In master branch (commit 5cca0e3f6e0ff17db92476235ea1bb9cd8cbc9eb) there
is no gen_storage0 in the structure pmu_regs, only gen_storage4 and
gen_storage6. 

But in any case though, I don't use gen_storage0 which is the
Global General Storage 0 but the Persistent Global General Storage 0
which is in the in the offset 0x50 and is defined in [1]. According to
this document, only registers {4:7} are used by FSBL and other Xilinx
software products so from what I understand registers {0:3} are free to
use. If that's not the case, which one of them is free for use?

[1]: https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registers/PERS_GLOB_GEN_STORAGE0-PMU_GLOBAL-Register

> > +
> > +void bootcount_store(ulong a)
> > +{
> > +	int ret;
> > +
> > +	ret = zynqmp_mmio_write(PMU_PERS_GLOB_GEN_STORAGE0, 0xFF, a);
> > +	if (ret)
> > +		printf("Failed: mmio write\n");
> > +}
> > +
> > +ulong bootcount_load(void)
> > +{
> > +	int ret;
> > +	u32 val;
> 
> as was said val should be initialized here too.
> 

Yes indeed.

> > +
> > +	ret = zynqmp_mmio_read(PMU_PERS_GLOB_GEN_STORAGE0, &val);
> > +	if (ret)
> > +		printf("Failed: mmio read\n");
> > +	return val;
> > +}
> 
> Anyway I expect this driver to be under DM that v2 will change.
> 
> Thanks,
> Michal
> 
> 
> 

Yes, I will try and come back to you in case I don't get something.
Thanks again for the review.

Cheers,
Vasilis
