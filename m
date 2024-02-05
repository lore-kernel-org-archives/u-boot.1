Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C95C48295
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 13:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 193FD8798C;
	Mon,  5 Feb 2024 14:46:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="ID0OT8Pi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 809F9879C8; Mon,  5 Feb 2024 14:46:28 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7366C8798C
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 14:46:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: f0eb93d3-c42c-11ee-91e8-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id f0eb93d3-c42c-11ee-91e8-005056994fde;
 Mon, 05 Feb 2024 14:46:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=content-type:mime-version:subject:to:from:message-id:date;
 bh=6fYZPqPH3jSluujGg5EgH6pLY+k4WKDBhDRJXLZo1zY=;
 b=ID0OT8PibdkeyRNV+62fNr4tl1S7A/JFz+uFa8VGttS0K+2ZIWHAwb0yTEuon/AmwXGk0itsYTwy4
 tIGc24exUIRnsS7ZI1qZtP+8x278Tb0bpkRCU9rDkqPQ73SmZT3L5NK4qQnUyiEQJ3t/zXjKlxlJN7
 4hfTSvErevObJcjhAwvx8H7nwbs7N1Tg4KeHxQuAuDIYuGBnU6TPAGZWCz8RndK+FhAOLv2W5b/eqp
 k/gK5bo1iviJkukJVK0khO75CUM5PgXXmC/V2aIS3xMnGDOh3P+V9bq24L9ZuhMcrmt3jW/jRbZeQj
 n+MXV0H7Q3YwrFjhCtxJ+nqQLhd6mqA==
X-KPN-MID: 33|Wm1TEZnb0f4WPYwV04wuYCfWkBZOLg/TUUwb+ErE5JZRqkEaQyoK7WDqBwLgspa
 Fr3UVZeO+XCmGn1u+9Vb5WGLLvroStf7Bl8T4f0DtxrA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|MDCySOsUco1QlZCx6l+uyloTdo5VzgzLy+aErW9L/qXQgv3YCBi5pjRYraGRTWt
 BEDlTaCuxE/eQozRk7/vtvA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id f4216c2b-c42c-11ee-8c43-00505699b758;
 Mon, 05 Feb 2024 14:46:25 +0100 (CET)
Date: Mon, 05 Feb 2024 14:46:24 +0100
Message-Id: <874jenqb0v.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>
Cc: resch.max@gmail.com, u-boot@lists.denx.de, sr@denx.de
In-Reply-To: <20240205124014.6f7b1957@dellmb> (message from Marek
 =?utf-8?Q?Beh=C3=BAn?= on Mon, 5 Feb 2024 12:40:14 +0100)
Subject: Re: [PATCH v2] rng: Add Turris Mox rWTM RNG driver
References: <20240121201737.671340-1-resch.max@gmail.com>
 <20240205124014.6f7b1957@dellmb>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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

> Date: Mon, 5 Feb 2024 12:40:14 +0100
> From: Marek Behún <kabel@kernel.org>
> 
> Hello Max,
> 
> Out of curiousity, what is your use case for having these random
> numbers on this platform in U-Boot?

It means that U-Boot will implement the EFI RNG protocol.  The OpenBSD
bootloader will use that to fill an initial pool of random numbers for
the kernel.  And the Linux kernel EFI stub uses it to do kernel
address space randomization.

Cheers,

Mark

> Below are a few more things to change and then you I'll give my
> Reviewed-by tag.
> 
> On Sun, 21 Jan 2024 21:17:16 +0100
> Max Resch <resch.max@gmail.com> wrote:
> 
> > A RNG driver for Armada 3720 boards running the Turris Mox rWTM firmware
> > from CZ.NIC in the secure processor.
> > 
> > Signed-off-by: Max Resch <resch.max@gmail.com>
> > ---
> > 
> > Changes in v2:
> >  - Removed ring buffer implementation
> > 
> >  drivers/rng/Kconfig           |   8 +++
> >  drivers/rng/Makefile          |   1 +
> >  drivers/rng/turris_rwtm_rng.c | 122 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 131 insertions(+)
> >  create mode 100644 drivers/rng/turris_rwtm_rng.c
> > 
> > diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
> > index a89c899568..cd72852a47 100644
> > --- a/drivers/rng/Kconfig
> > +++ b/drivers/rng/Kconfig
> > @@ -105,4 +105,12 @@ config RNG_JH7110
> >  	help
> >  	  Enable True Random Number Generator in StarFive JH7110 SoCs.
> >  
> > +config RNG_TURRIS_RWTM
> > +	bool "Turris Mox TRNG in Secure Processor"
> > +	depends on DM_RNG && ARMADA_3700
> > +	help
> > +	  Use TRNG in Turris Mox Secure Processor Firmware. Can be used
> > +	  on other Armada-3700 devices (like EspressoBin) if Secure
> > +	  Firmware from CZ.NIC is used.
> > +
> >  endif
> > diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
> > index 7e64c4cdfc..ecae1a3da3 100644
> > --- a/drivers/rng/Makefile
> > +++ b/drivers/rng/Makefile
> > @@ -17,3 +17,4 @@ obj-$(CONFIG_RNG_SMCCC_TRNG) += smccc_trng.o
> >  obj-$(CONFIG_RNG_ARM_RNDR) += arm_rndr.o
> >  obj-$(CONFIG_TPM_RNG) += tpm_rng.o
> >  obj-$(CONFIG_RNG_JH7110) += jh7110_rng.o
> > +obj-$(CONFIG_RNG_TURRIS_RWTM) += turris_rwtm_rng.o
> > diff --git a/drivers/rng/turris_rwtm_rng.c b/drivers/rng/turris_rwtm_rng.c
> > new file mode 100644
> > index 0000000000..143fe0b47f
> > --- /dev/null
> > +++ b/drivers/rng/turris_rwtm_rng.c
> > @@ -0,0 +1,122 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
> > +/*
> > + * Copyright (c) 2024, Max Resch
> > + */
> > +
> > +#include <dm.h>
> > +#include <malloc.h>
> > +#include <rng.h>
> > +#include <asm/dma-mapping.h>
> > +#include <asm/types.h>
> > +#include <mach/mbox.h>
> > +
> > +/* size of entropy buffer */
> > +#define RNG_BUFFER_SIZE	128U
> > +
> > +struct turris_rwtm_rng_priv {
> > +	phys_addr_t buffer;
> > +};
> > +
> > +static int turris_rwtm_rng_fill_entropy(phys_addr_t entropy, size_t size)
> > +{
> > +	u32 args[3] = { 1, (u32)entropy, size };
> > +	int ret;
> > +
> > +	/* flush data cache */
> > +	flush_dcache_range(entropy, entropy + size);
> > +
> > +	/*
> > +	 * get entropy
> > +	 * args[0] = 1 copies BYTES array in args[1] of length args[2]
> > +	 */
> > +	ret = mbox_do_cmd(MBOX_CMD_GET_RANDOM, args, 3, NULL, 0);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* invalidate data cache */
> > +	invalidate_dcache_range(entropy, entropy + size);
> > +
> > +	return 0;
> > +}
> > +
> > +static int turris_rwtm_rng_random_read(struct udevice *dev, void *data, size_t count)
> > +{
> > +	phys_addr_t p;
> > +	size_t size;
> > +	int ret;
> > +
> > +	p = ((struct turris_rwtm_rng_priv *)dev_get_priv(dev))->buffer;
> 
> Please declare
> 
>   struct turris_rwtm_rng_priv *priv = dev_get_priv(dev);
>   phys_addr_t phys;
>   size_t size;
>   int ret;
> 
> and then do 
> 
>   phys = priv->buffer;
> 
> > +	while (count) {
> > +		size = min_t(size_t, RNG_BUFFER_SIZE, count);
> > +
> > +		ret = turris_rwtm_rng_fill_entropy(p, size);
> > +
> > +		memcpy(data, (void *)p, size);
> > +		count -= size;
> > +		data = (u8 *)data + size;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int turris_rwtm_rng_probe(struct udevice *dev)
> > +{
> > +	struct turris_rwtm_rng_priv *priv;
> 
>   = dev_get_priv(dev);
> 
> > +	u32 args[] = { 0 };
> > +	int ret;
> > +
> > +	/*
> > +	 * check if the random command is supported
> > +	 * args[0] = 0 would copy 16 DWORDS entropy to out but we ignore them
> > +	 */
> > +	ret = mbox_do_cmd(MBOX_CMD_GET_RANDOM, args, ARRAY_SIZE(args), NULL, 0);
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* entropy buffer */
> > +	priv = (struct turris_rwtm_rng_priv *)dev_get_priv(dev);
> no need here, do it at the beginning
> 
> 
> > +	priv->buffer = 0;
> > +
> > +	/* buffer address need to be aligned */
> > +	dma_alloc_coherent(RNG_BUFFER_SIZE, (unsigned long *)&priv->buffer);
> > +	if (!priv->buffer)
> > +		return -ENOMEM;
> > +
> > +	return 0;
> > +}
> > +
> > +static int turris_rwtm_rng_remove(struct udevice *dev)
> > +{
> > +	phys_addr_t p;
> rename this to phys, and please do it as I described above.
> 
> > +
> > +	p = ((struct turris_rwtm_rng_priv *)dev_get_priv(dev))->buffer;
> > +	dma_free_coherent((void *)p);
> > +
> > +	return 0;
> 
> Marek
> 
