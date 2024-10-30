Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8011D6B6B7
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 17:20:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 599E08923D;
	Wed, 30 Oct 2024 18:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PQDJypBt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DDCD88F95; Wed, 30 Oct 2024 15:12:01 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 444E388D36
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 15:11:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4315eac969aso6370495e9.1
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 07:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730297519; x=1730902319; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Wx1SfVeELYmIJA52YgJpZ7Aj81nqdJ8SoYTbOfzwNBo=;
 b=PQDJypBt57e1rDTzQVBG9rGVugK6wxk6PafRdmrpkDSPTe4bqq0BXndLzvJs6vMSbC
 py9trac0a1w2TFstVNW8+mPtK+urF9y2Mzbz6MF76WBkLSIVcOFZykryGp16u3rHNB+y
 Wf/l8ZTWLP/xXTcJjUIKYP7Mr6pnJJ8QWixj9vWrDBivX0XpX97+CWSeVVhSYNN6/dnl
 yqAp9hBZXtENdQ4VX5oliORaTsLTfF/a4NWeEhosWTf2KRNbRXTgcDwqBBa524TUodnz
 TYo3J/MUN37AtXEHumuwG/D3kUDuWIoowyQl3jPP793NOMZ2BlGrKRSBeqA1dd4ETc1y
 eIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730297519; x=1730902319;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wx1SfVeELYmIJA52YgJpZ7Aj81nqdJ8SoYTbOfzwNBo=;
 b=ebajr4ldSLcEDpFWDvFC53WK3x4ygRV+HfaFiU8z2DPw9/Chi0iOG2bKepRjB+XaYB
 txdSYth+oo8/53YxoCGUSEOWaSuFg9ITVaC6Ldyzl/UJLDKq5YFPnrIwYnDJdHP4ziQR
 Xod/rieBX8XhCZ4CIpjAEuyLN3rL9OlMOXtPYmeRSgcvxCspW+tZDJ7+5JgvvCq+HXD5
 +XPNVp7nat+oCFwqKpCssAIKMP9XJqgZYBcqva/Eljmlu2EAQbClE/94pTLmR+qLqBrE
 m5xt43s8AJw2lwzxXSVZk/L12mz5ctw2L92IJS6QLlQ3y+W9rF4PfxA5dKL/iyfoy/On
 AbJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ/nwY3oY9CIh73TBhAMtp0pCXRJbQhVfrvC0X7mfu8UrszT/BG4N6Pypg5rmgyEtXS6PfRM8=@lists.denx.de
X-Gm-Message-State: AOJu0YxmeAccfiNM6TeQTGT+QSRILThBGogVSYWw+H19FpODAU3ZZfqA
 n0b5PGs+uiEzSaTDUBPmRmbDvivR7mxQRGHBRvsRiUP0UnZTQr0s4pkafw==
X-Google-Smtp-Source: AGHT+IHdaIA/vhvOt/3j1+qZn9DvbTTFxv7TQItLioQZFUvM9O0nQqQDh/edY3vaRoeX3/IL9vAcxg==
X-Received: by 2002:a05:600c:4750:b0:42c:ae4e:a96c with SMTP id
 5b1f17b1804b1-431b583b414mr52055335e9.16.1730297518586; 
 Wed, 30 Oct 2024 07:11:58 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:89e7:cc9d:3a72:92f3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b8ffecsm15436143f8f.91.2024.10.30.07.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 07:11:57 -0700 (PDT)
Date: Wed, 30 Oct 2024 15:11:56 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Heiko Schocher <hs@denx.de>
Cc: trini@konsulko.com, michal.simek@amd.com, pro@denx.de, sjg@chromium.org,
 vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] drivers: bootcount: Add ZynqMP specific bootcount
 support
Message-ID: <ZyI-rJV5K6XrNqBk@vamoirid-laptop>
References: <20241029185814.7937-1-vassilisamir@gmail.com>
 <20241029185814.7937-2-vassilisamir@gmail.com>
 <04eec966-517f-fb4b-3082-155043a853f5@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04eec966-517f-fb4b-3082-155043a853f5@denx.de>
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

On Wed, Oct 30, 2024 at 06:26:08AM +0100, Heiko Schocher wrote:
> Hello Vasileios,
> 
> On 29.10.24 19:58, Vasileios Amoiridis wrote:
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
> > +
> > +	ret = zynqmp_mmio_read(PMU_PERS_GLOB_GEN_STORAGE0, &val);
> > +	if (ret)
> > +		printf("Failed: mmio read\n");
> > +	return val;
> 
> Makes it sense to return val, when ret != 0 ? Maybe val is uninitialzed
> in this case... at least please return ret.

Hi Heiko,

I see your point. Initializing wouldn't hurt, and indeed I could return
the error value no problem!
> 
> 
> just Nitpick: Also may at least add the function name to the printf,
> that you have a chance to see on console output, that bootcount read
> gone wrong... may the zynqmp_mmio_write/read functions have already an
> error message on error?

Just by checking other usages of this function, indeed it would be
helpful to use function name and line number and then propagate the
error value all the way up.

Cheers,
Vasilis
> 
> Thanks!
> 
> bye,
> Heiko
> -- 
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
