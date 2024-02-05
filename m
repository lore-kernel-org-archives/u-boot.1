Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A54C4828D
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 11:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EA4787811;
	Mon,  5 Feb 2024 12:40:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P9hvshJA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03487878CB; Mon,  5 Feb 2024 12:40:24 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6120A86D38
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 12:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AE31361001;
 Mon,  5 Feb 2024 11:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897E2C433F1;
 Mon,  5 Feb 2024 11:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707133218;
 bh=yzSKd2xPLwQYqV4s+8XhGEZgmj5zRpSFTXhnYKzbomM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=P9hvshJAgAlzGFd0t58nTwySG7G0OW7wVU2/7KdmbRNDJ1H4CLD804FjIm3f8jSdx
 npsepsOY2nM3UjGZ+4qgn0k5ss/sSnX1Ka7PrrY6K02EJL4bVUM/z+TiQesKE92sCA
 dDhIBsbvb1i5ZssfVbjtC/c8VNjU1aJTaVSizM1Bf78mazHKquPh8dlS/2PTKgaGWZ
 8KPT4S1CtEHX8gDhLEAlNdFfIUtSseqn+1/iebQf/jxS/6u52o1ZHTaFcnZa2wdIbF
 JhY0dt04l6e5gNdUlr1P1pBuLGQfzo3258oS25ovKy7cf0mjWG3Hmc76mYHygq4pKT
 HdwKOqb9FalIg==
Date: Mon, 5 Feb 2024 12:40:14 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Max Resch <resch.max@gmail.com>
Cc: u-boot@lists.denx.de, sr@denx.de
Subject: Re: [PATCH v2] rng: Add Turris Mox rWTM RNG driver
Message-ID: <20240205124014.6f7b1957@dellmb>
In-Reply-To: <20240121201737.671340-1-resch.max@gmail.com>
References: <20240121201737.671340-1-resch.max@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.39; x86_64-pc-linux-gnu)
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

Hello Max,

Out of curiousity, what is your use case for having these random
numbers on this platform in U-Boot?

Below are a few more things to change and then you I'll give my
Reviewed-by tag.

On Sun, 21 Jan 2024 21:17:16 +0100
Max Resch <resch.max@gmail.com> wrote:

> A RNG driver for Armada 3720 boards running the Turris Mox rWTM firmware
> from CZ.NIC in the secure processor.
> 
> Signed-off-by: Max Resch <resch.max@gmail.com>
> ---
> 
> Changes in v2:
>  - Removed ring buffer implementation
> 
>  drivers/rng/Kconfig           |   8 +++
>  drivers/rng/Makefile          |   1 +
>  drivers/rng/turris_rwtm_rng.c | 122 ++++++++++++++++++++++++++++++++++
>  3 files changed, 131 insertions(+)
>  create mode 100644 drivers/rng/turris_rwtm_rng.c
> 
> diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
> index a89c899568..cd72852a47 100644
> --- a/drivers/rng/Kconfig
> +++ b/drivers/rng/Kconfig
> @@ -105,4 +105,12 @@ config RNG_JH7110
>  	help
>  	  Enable True Random Number Generator in StarFive JH7110 SoCs.
>  
> +config RNG_TURRIS_RWTM
> +	bool "Turris Mox TRNG in Secure Processor"
> +	depends on DM_RNG && ARMADA_3700
> +	help
> +	  Use TRNG in Turris Mox Secure Processor Firmware. Can be used
> +	  on other Armada-3700 devices (like EspressoBin) if Secure
> +	  Firmware from CZ.NIC is used.
> +
>  endif
> diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
> index 7e64c4cdfc..ecae1a3da3 100644
> --- a/drivers/rng/Makefile
> +++ b/drivers/rng/Makefile
> @@ -17,3 +17,4 @@ obj-$(CONFIG_RNG_SMCCC_TRNG) += smccc_trng.o
>  obj-$(CONFIG_RNG_ARM_RNDR) += arm_rndr.o
>  obj-$(CONFIG_TPM_RNG) += tpm_rng.o
>  obj-$(CONFIG_RNG_JH7110) += jh7110_rng.o
> +obj-$(CONFIG_RNG_TURRIS_RWTM) += turris_rwtm_rng.o
> diff --git a/drivers/rng/turris_rwtm_rng.c b/drivers/rng/turris_rwtm_rng.c
> new file mode 100644
> index 0000000000..143fe0b47f
> --- /dev/null
> +++ b/drivers/rng/turris_rwtm_rng.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
> +/*
> + * Copyright (c) 2024, Max Resch
> + */
> +
> +#include <dm.h>
> +#include <malloc.h>
> +#include <rng.h>
> +#include <asm/dma-mapping.h>
> +#include <asm/types.h>
> +#include <mach/mbox.h>
> +
> +/* size of entropy buffer */
> +#define RNG_BUFFER_SIZE	128U
> +
> +struct turris_rwtm_rng_priv {
> +	phys_addr_t buffer;
> +};
> +
> +static int turris_rwtm_rng_fill_entropy(phys_addr_t entropy, size_t size)
> +{
> +	u32 args[3] = { 1, (u32)entropy, size };
> +	int ret;
> +
> +	/* flush data cache */
> +	flush_dcache_range(entropy, entropy + size);
> +
> +	/*
> +	 * get entropy
> +	 * args[0] = 1 copies BYTES array in args[1] of length args[2]
> +	 */
> +	ret = mbox_do_cmd(MBOX_CMD_GET_RANDOM, args, 3, NULL, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* invalidate data cache */
> +	invalidate_dcache_range(entropy, entropy + size);
> +
> +	return 0;
> +}
> +
> +static int turris_rwtm_rng_random_read(struct udevice *dev, void *data, size_t count)
> +{
> +	phys_addr_t p;
> +	size_t size;
> +	int ret;
> +
> +	p = ((struct turris_rwtm_rng_priv *)dev_get_priv(dev))->buffer;

Please declare

  struct turris_rwtm_rng_priv *priv = dev_get_priv(dev);
  phys_addr_t phys;
  size_t size;
  int ret;

and then do 

  phys = priv->buffer;

> +	while (count) {
> +		size = min_t(size_t, RNG_BUFFER_SIZE, count);
> +
> +		ret = turris_rwtm_rng_fill_entropy(p, size);
> +
> +		memcpy(data, (void *)p, size);
> +		count -= size;
> +		data = (u8 *)data + size;
> +	}
> +
> +	return 0;
> +}
> +
> +static int turris_rwtm_rng_probe(struct udevice *dev)
> +{
> +	struct turris_rwtm_rng_priv *priv;

  = dev_get_priv(dev);

> +	u32 args[] = { 0 };
> +	int ret;
> +
> +	/*
> +	 * check if the random command is supported
> +	 * args[0] = 0 would copy 16 DWORDS entropy to out but we ignore them
> +	 */
> +	ret = mbox_do_cmd(MBOX_CMD_GET_RANDOM, args, ARRAY_SIZE(args), NULL, 0);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	/* entropy buffer */
> +	priv = (struct turris_rwtm_rng_priv *)dev_get_priv(dev);
no need here, do it at the beginning


> +	priv->buffer = 0;
> +
> +	/* buffer address need to be aligned */
> +	dma_alloc_coherent(RNG_BUFFER_SIZE, (unsigned long *)&priv->buffer);
> +	if (!priv->buffer)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static int turris_rwtm_rng_remove(struct udevice *dev)
> +{
> +	phys_addr_t p;
rename this to phys, and please do it as I described above.

> +
> +	p = ((struct turris_rwtm_rng_priv *)dev_get_priv(dev))->buffer;
> +	dma_free_coherent((void *)p);
> +
> +	return 0;

Marek
