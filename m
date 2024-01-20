Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA84FC47258
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 14:46:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CF9587D94;
	Sat, 20 Jan 2024 15:45:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ssjntUlP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C9E387DB4; Sat, 20 Jan 2024 15:45:56 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3491F87D94
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 15:45:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id BC77FB80688;
 Sat, 20 Jan 2024 14:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF06C433F1;
 Sat, 20 Jan 2024 14:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705761953;
 bh=/SDQUOje0QrJk8JeZ0fbnaPaLHQDKLXUFoLWU0Rq5yA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ssjntUlPCUpO2N3Q1E5vcMiyvgXaWUnfDKaL3OV9DIObU/KBPLafrXjwlTiZzvE0W
 VIdivY9pRiJxzAUppZ9YMg2E+3U/mT7Cni9wwNXeIwFFM09SuwxXSFTwdGjISUPTsD
 Z7tQG8VwpWd8H6mrr4IRk/Z6sGn1zGiw1llMou0++NztL4xNnKQG8XWDOHsYSnd1a2
 445S+4IMIWFHXEPyhytLi7yF4q7D24EHLbJv+M63YiytASP1EJ8jBU8vjhLpvmVhIb
 0niwgKgz8Fg0GQ4mZlrCPde2pMUPPRaGGNCJ+25vi3IQBDATrr/RM94gtY3Z0sNP8c
 7keKP4xZmbCgg==
Date: Sat, 20 Jan 2024 15:45:47 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Max Resch <resch.max@gmail.com>
Cc: u-boot@lists.denx.de, sr@denx.de
Subject: Re: [PATCH 1/1] add turris-rwtm-rng from CZ.NIC rWTM Firmware
Message-ID: <20240120154547.3df7196b@dellmb>
In-Reply-To: <20240120132731.35321-2-resch.max@gmail.com>
References: <20240120132731.35321-1-resch.max@gmail.com>
 <20240120132731.35321-2-resch.max@gmail.com>
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

On Sat, 20 Jan 2024 14:27:23 +0100
Max Resch <resch.max@gmail.com> wrote:

Hello Max,

please follow the conventions for commit titles and messages. Look for
example at
  git log drivers/rng
The commit title should be something like
  rng: Add Turris Mox rWTM RNG driver

> usable on all armada3700 devices with CZ.NIC firmware
> compatible with devices with default firmware (does nothing)
> based on Linux turris-mox-rwtm module

Please use capital letters and punctuation in commmit messages as in
standard english text. The commit message should be something like

  Add RNG driver for Armada 3720 boards running the Turris Mox rWTM
  firmware in the secure coprocessor.

> Signed-off-by: Max Resch <resch.max@gmail.com>
> ---
> 
>  drivers/rng/Kconfig           |   8 ++
>  drivers/rng/Makefile          |   1 +
>  drivers/rng/turris_rwtm_rng.c | 143 ++++++++++++++++++++++++++++++++++
>  3 files changed, 152 insertions(+)
>  create mode 100644 drivers/rng/turris_rwtm_rng.c
> 
> diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
> index a89c899568..f5984a9ca0 100644
> --- a/drivers/rng/Kconfig
> +++ b/drivers/rng/Kconfig
> @@ -105,4 +105,12 @@ config RNG_JH7110
>  	help
>  	  Enable True Random Number Generator in StarFive JH7110 SoCs.
>  
> +config RNG_TURRIS_RWTM
> +	bool "Turris Mox TRNG in Secure Processor"
> +	depends on DM_RNG && ARCH_MVEBU
This should depend on ARMADA_3700 instead of ARCH_MVEBU, otherwise the
mbox_do_cmd function won't be defined and link error will occur.

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
> index 0000000000..03e4fdfcaf
> --- /dev/null
> +++ b/drivers/rng/turris_rwtm_rng.c
> @@ -0,0 +1,143 @@
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
> +#define DRIVER_NAME	"turris-rwtm-rng"

No need to declare macro for driver name, just use the string literal
in the U_BOOT_DRIVER call at the end.

> +/* size of enthropy ring buffer */

Entropy is spelled without 'h'.

> +#define RNG_BUFFER_SIZE	4096U
> +
> +struct turris_rwtm_rng_priv {
> +	phys_addr_t buffer;
> +	u16 pos;

I suggest to throw away the ring implementation (no need for pos), just
do the read of sufficient bytes in the rng_read method.

No need to do ring buffering in U-Boot for performance, it just
overcomplicates it.


> +};
> +
> +static int turris_rwtm_rng_fill_enthropy(phys_addr_t enthropy, size_t size)
> +{
> +	int ret;
> +	u32 args[] = { 1, (u32)enthropy, size };

Please explicitly define array size here:
	u32 args[3] = ....

Please use reverse christmas tree for declarations whenever possible.
The longest line first. In this case

	u32 args[3] = { 1, (u32)enthropy, size };
	int ret;

> +	/* flush data cache */
> +	flush_dcache_range(enthropy, enthropy + size);
> +
> +	/*
> +	 * get enthropy
> +	 * args[0] = 1 copies BYTES array in args[1] of length args[2]
> +	 */
> +	ret = mbox_do_cmd(MBOX_CMD_GET_RANDOM, args, 3, NULL, 0);

	ret = mbox_do_cmd(MBOX_CMD_GET_RANDOM, args, ARRAY_SIZE(args),
			  NULL, 0);

> +	if (ret < 0)
> +		return ret;
> +
> +	/* invalidate data cache */
> +	invalidate_dcache_range(enthropy, enthropy + size);
> +
> +	return 0;
> +}
> +
> +static int turris_rwtm_rng_random_read(struct udevice *dev, void *data, size_t count)
> +{
> +	int ret;
> +	struct turris_rwtm_rng_priv *priv;
> +	phys_addr_t p;
> +	size_t size, copied;

reverse christmas tree

> +
> +	priv = (struct turris_rwtm_rng_priv *)dev_get_priv(dev);
> +	p = priv->buffer;
> +
> +	/* copy to ring buffer, optimize RWTM access */
> +	size = min_t(size_t, RNG_BUFFER_SIZE - priv->pos, count);
> +	copied = 0;
> +
> +	while (count) {
> +		memcpy(((u8 *)data) + copied, (void *)(p + priv->pos), size);
> +		count -= size;
> +		copied += size;
> +		priv->pos += size;
> +
> +		if (priv->pos == RNG_BUFFER_SIZE) {
> +			ret = turris_rwtm_rng_fill_enthropy(p, RNG_BUFFER_SIZE);
> +			if (ret < 0)
> +				return ret;
> +			priv->pos = 0;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int turris_rwtm_rng_probe(struct udevice *dev)
> +{
> +	int ret;
> +	struct turris_rwtm_rng_priv *priv;
> +	u32 args[] = { 0 };

reverse christmas tree, and explicit size of args array.
Alternatively if only one arg is used, you can just set
	u32 arg = 0;
and use &arg in the call to mbox_do_cmd()

> +	/*
> +	 * check if the random command is supported
> +	 * args[0] = 0 would copy 16 DWORDS to out but we ignore them
> +	 */
> +	ret = mbox_do_cmd(MBOX_CMD_GET_RANDOM, args, 1, NULL, 0);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	/* allocate ring buffer */
> +	priv = dev_get_priv(dev);
> +	priv->buffer = 0;
> +
> +	/* address need to be aligned */
> +	dma_alloc_coherent(RNG_BUFFER_SIZE, (unsigned long *)&priv->buffer);
> +	if (!priv->buffer)
> +		return -ENOMEM;
> +
> +	priv->pos = 0;
> +	memset((void *)priv->buffer, 0, RNG_BUFFER_SIZE);
> +
> +	/* fill ring buffer with enthroy */
> +	return turris_rwtm_rng_fill_enthropy(priv->buffer, RNG_BUFFER_SIZE);
> +}
> +
> +static int turris_rwtm_rng_remove(struct udevice *dev)
> +{
> +	struct turris_rwtm_rng_priv *priv;
	struct turris_rwtm_rng_priv *priv = dev_get_priv(dev);
> +
> +	priv = dev_get_priv(dev);
> +	if (!priv->buffer)

No need to check this here, this cannot happen. Remove won't be called
because if priv->buffer is zero, probe would have failed with -ENOMEM.

> +		return 0;
> +
> +	dma_free_coherent((void *)priv->buffer);
> +	priv->buffer = 0;
No need to clear priv->buffer.

> +
> +	return 0;
> +}
> +
> +static const struct dm_rng_ops turris_rwtm_rng_ops = {
> +	.read = turris_rwtm_rng_random_read,
> +};
> +
> +/*
> + * only Turris MOX firmware has the RNG but allow all probable devices to be
> + * probed the default firmware will just reject the probe
> + */
> +static const struct udevice_id turris_rwtm_rng_match[] = {
> +	{ .compatible = "cznic,turris-mox-rwtm" },
> +	{ .compatible = "marvell,armada-3700-rwtm-firmware" },
> +	{},
> +};
> +
> +U_BOOT_DRIVER(turris_rwtm_rng) = {
> +	.name	= DRIVER_NAME,
> +	.id	= UCLASS_RNG,
> +	.of_match = turris_rwtm_rng_match,
> +	.ops	= &turris_rwtm_rng_ops,
> +	.probe	= turris_rwtm_rng_probe,
> +	.remove = turris_rwtm_rng_remove,
> +	.priv_auto = sizeof(struct turris_rwtm_rng_priv),
> +};

