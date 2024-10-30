Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3932D6B6B7
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 17:21:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AB4A8926D;
	Wed, 30 Oct 2024 18:20:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QjU0Cm/i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E58D889035; Wed, 30 Oct 2024 17:04:22 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21DFD88FAB
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 17:04:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-539eb97f26aso7151554e87.2
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 09:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730304259; x=1730909059; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wxyqw6jDLd2eOH1obDVGumlTPuxOg0EfSJ8O0lsHQ48=;
 b=QjU0Cm/igFc1pg0klhdAEWnDsvT4HKfBE5nxU2c4ygGRQhS+Kkgv3h0zKuJC7WcoFp
 fUQ2xPRwFHB8PgdvfDp1/5cWR4Wk2FOZT/YJA9lyz03EWtMBXAO5IJn9gMnDaRJ37DYR
 m8NZZoSIMk3wgIbinoNK0FS5xConp+uyZRWgSjAnoFi7VlargoJN22HDVWGMb9TcORhI
 cLeSCY4oGExMrhUxJ2WVpCHqHz4k8/4JL6zbRxZkNh8BgHlROVwK8aLCl3sLERhYrLpk
 worTZcz167y4gkYzW59VSci9MrQenmrKohj57Vx6hIJdzBWVPdoB19RdhqjXIt+DJ2GE
 WnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730304259; x=1730909059;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wxyqw6jDLd2eOH1obDVGumlTPuxOg0EfSJ8O0lsHQ48=;
 b=m5C+hxE1+/Qg11Mw03l31Jjx8mq4ATmoQTAYynCDZO6lw9UQJHIV8AhftYrv2/kGbs
 i0d4IWn7a+fhzRQOWdd+Qg0JotR/aTVZXWuYcNURA/sWWQ8ObnTVTmMA41sixR8hCQgb
 G7M9fsjwLEZK6d+r0Bo2rW3EIwxRL5GoYduZEsf/817/EgVs6c+z7rs1p46km+6qgL+0
 OFpFI0WDoPF3ibm9DSrb4GeKYtQJ/9AMF3e1vaQROvxntA97/8olnEBSQnXBGS9h7ymI
 W/tdQLAwqlmsoXl6itDn7WwR93WPecr2JD32h1gm1GQj9DLJ7lV1bp7cOuYbo9GhC4L/
 ctzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3EDe3pL8hV3tupiAsNUJ3EsjYkMVeTKEPJldtYDAkGSL9/pMwCsiG+fyq86fmEC35mo3AaTI=@lists.denx.de
X-Gm-Message-State: AOJu0YzgreuobnLgnXmWRtpivzDHxj4KFAfz/ckUfu/JJ3fX4+Z22/MJ
 exFsQis4jrbx0fUsBpCXtXK3JgUw9CC5sF/+KNwZ+ZqKR2+T80fIkPE37Q==
X-Google-Smtp-Source: AGHT+IGfTJ4hPByRAxTBqxVgQuVSqx0jO6xJrZWXytPfhYg+tH3Whgir62NENbaQrX0QWJ+hHWqwWw==
X-Received: by 2002:a05:6512:3b95:b0:539:f7de:df6a with SMTP id
 2adb3069b0e04-53b86b029efmr2303387e87.52.1730304258782; 
 Wed, 30 Oct 2024 09:04:18 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:89e7:cc9d:3a72:92f3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd8e853esm25806725e9.8.2024.10.30.09.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 09:04:18 -0700 (PDT)
Date: Wed, 30 Oct 2024 17:04:16 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Michal Simek <michal.simek@amd.com>
Cc: trini@konsulko.com, hs@denx.de, pro@denx.de, sjg@chromium.org,
 vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] drivers: bootcount: Add ZynqMP specific bootcount
 support
Message-ID: <ZyJZAP9e5iRRtRM1@vamoirid-laptop>
References: <20241029185814.7937-1-vassilisamir@gmail.com>
 <20241029185814.7937-2-vassilisamir@gmail.com>
 <c6ad234b-e756-4ea3-8381-63ffca1c2c5c@amd.com>
 <ZyJE7K8Eo7A6smyT@vamoirid-laptop>
 <bf1c5738-de6a-49d5-9920-bbeb30ebd879@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf1c5738-de6a-49d5-9920-bbeb30ebd879@amd.com>
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

On Wed, Oct 30, 2024 at 04:49:10PM +0100, Michal Simek wrote:
> 
> 
> On 10/30/24 15:38, Vasileios Amoiridis wrote:
> > On Wed, Oct 30, 2024 at 02:13:43PM +0100, Michal Simek wrote:
> > > 
> > > 
> > > On 10/29/24 19:58, Vasileios Amoiridis wrote:
> > > > From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> > > > 
> > > > Add native support of the bootcount mechanism in the ZynqMP by utilising internal
> > > > PMU registers. The Persistent Global Storage Registers of the Platform Management
> > > > Unit can keep their value during reboot cycles unless there is a POR reset, making
> > > > them appropriate for the bootcount mechanism.
> > > > 
> > > > Signed-off-by: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> > > > ---
> > > >    drivers/bootcount/Kconfig            |  4 ++++
> > > >    drivers/bootcount/Makefile           |  1 +
> > > >    drivers/bootcount/bootcount_zynqmp.c | 28 ++++++++++++++++++++++++++++
> > > >    3 files changed, 33 insertions(+)
> > > >    create mode 100644 drivers/bootcount/bootcount_zynqmp.c
> > > > 
> > > > diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
> > > > index fa6d8e7128..95b6a9541a 100644
> > > > --- a/drivers/bootcount/Kconfig
> > > > +++ b/drivers/bootcount/Kconfig
> > > > @@ -82,6 +82,10 @@ config BOOTCOUNT_AT91
> > > >    	bool "Boot counter for Atmel AT91SAM9XE"
> > > >    	depends on AT91SAM9XE
> > > > +config BOOTCOUNT_ZYNQMP
> > > > +	bool "Boot counter for Zynq UltraScale+ MPSoC"
> > > > +	depends on ARCH_ZYNQMP
> > > 
> > > 
> > > help would help to also described where that count is stored.
> > > 
> > 
> > Hi Michal,
> > 
> > thanks for the review. Indeed I could add it.
> > 
> > > And why not to have it under DM/U_BOOT_DRIVER?
> > > You don't need to create compatible string for it just instantiate it.
> > > 
> > > Look at:
> > > 
> > > U_BOOT_DRVINFO(soc_xilinx_zynqmp) = {
> > >           .name = "soc_xilinx_zynqmp",
> > > };
> > > 
> > 
> > I was not fully aware of this, I could try it. Just out of curiosity, is
> > this the new/prefered way of adding new drivers?
> > 
> > > 
> > > > +
> > > >    config DM_BOOTCOUNT
> > > >            bool "Boot counter in a device-model device"
> > > >    	help
> > > > diff --git a/drivers/bootcount/Makefile b/drivers/bootcount/Makefile
> > > > index 245f879633..487adc1212 100644
> > > > --- a/drivers/bootcount/Makefile
> > > > +++ b/drivers/bootcount/Makefile
> > > > @@ -3,6 +3,7 @@
> > > >    obj-$(CONFIG_BOOTCOUNT_GENERIC)	+= bootcount.o
> > > >    obj-$(CONFIG_BOOTCOUNT_MEM)	+= bootcount.o
> > > >    obj-$(CONFIG_BOOTCOUNT_AT91)	+= bootcount_at91.o
> > > > +obj-$(CONFIG_BOOTCOUNT_ZYNQMP)  += bootcount_zynqmp.o
> > > 
> > > please put it to the end of CONFIG_BOOTCOUNT to have it at least in correct location
> > > 
> > > >    obj-$(CONFIG_BOOTCOUNT_AM33XX)	+= bootcount_davinci.o
> > > >    obj-$(CONFIG_BOOTCOUNT_RAM)	+= bootcount_ram.o
> > > >    obj-$(CONFIG_BOOTCOUNT_ENV)	+= bootcount_env.o
> > > > diff --git a/drivers/bootcount/bootcount_zynqmp.c b/drivers/bootcount/bootcount_zynqmp.c
> > > > new file mode 100644
> > > > index 0000000000..9bb801e188
> > > > --- /dev/null
> > > > +++ b/drivers/bootcount/bootcount_zynqmp.c
> > > > @@ -0,0 +1,28 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > +// SPDX-FileCopyrightText: 2024 CERN (home.cern)
> > > > +
> > > > +#include <bootcount.h>
> > > > +#include <stdio.h>
> > > > +#include <zynqmp_firmware.h>
> > > > +
> > > > +#define PMU_PERS_GLOB_GEN_STORAGE0 0x00FFD80050
> > > 
> > > In arch/arm/mach-zynqmp/include/mach/hardware.h
> > > there is already structure defined and gen_storage0 is there too.
> > > Please use it.
> > > 
> > > Regarding this location. Exception in PMUFW is using this reg.
> > > It means at the end of day it is up to you if you want to use it or not.
> > > 
> > 
> > In master branch (commit 5cca0e3f6e0ff17db92476235ea1bb9cd8cbc9eb) there
> > is no gen_storage0 in the structure pmu_regs, only gen_storage4 and
> > gen_storage6.
> 
> you are right but easy to extend that structure to have it there.
> 
> > 
> > But in any case though, I don't use gen_storage0 which is the
> > Global General Storage 0 but the Persistent Global General Storage 0
> > which is in the in the offset 0x50 and is defined in [1]. According to
> > this document, only registers {4:7} are used by FSBL and other Xilinx
> > software products so from what I understand registers {0:3} are free to
> > use. If that's not the case, which one of them is free for use?
> > 
> > [1]: https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registers/PERS_GLOB_GEN_STORAGE0-PMU_GLOBAL-Register
> 
> in embedded sw you can find this
> lib/sw_apps/zynqmp_pmufw/src/xpfw_start.S:77:           addik   r3,     r0,
> 0xffd80050
> lib/sw_apps/zynqmp_pmufw/src/xpfw_start.S:81:           addik   r3,     r0,
> 0xffd80054
> 
> And there are 2 pages which describe their usage
> 
> https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18841724/PMU+Firmware#PMUFirmware-RegistersreservedforPMUFirmware
> 
> https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18842019/Zynq+UltraScale+FSBL#ZynqUltraScale+FSBL-WhatarethememoryregionsandregistersreservedforFSBL?
> 
> But as I said I am fine if you choose one and you will use it for bootcount.
> 
> Thanks
> M
>

Ah okay I see. It was much easier to look on the UG1087 document, I
didn't think of looking somewhere else. Thanks!

In that case I would prefer to use maybe use one of the 2 registers
that are not used, like pers_gen_storage{2,3}. Would that still be
okay for you?

Cheers,
Vasilis
