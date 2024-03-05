Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC1BC54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 10:33:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38DE38803B;
	Tue,  5 Mar 2024 11:33:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709634806;
	bh=g7DBQVENpnzLNTdk6FBEuH0PJDCiIa2Qp9u5x6vexgM=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CRuLicf8Zoeyt7eJ9JtRg5LkdL09ZYLQGdfkMyxIbVKDQ6HS1gS4OHsQnriQnttR7
	 E3uKY7H5NjhWQeBcyBLgFJRVBlnkTm4TAxI2R+d+lLnLXblu+o54Cg3mGcYFoVojM8
	 YOyguaDVE5lCuDGW/fUg7WFRG0wVVmg45x3ZsJwGwtkZ1yZxPMrhhZ6VLtgJhHT/XX
	 xrjNuQmxGv/6yVEGIVGsqyafB+r4nGQb/3aLWRocbll26n+GK7yZx2HhUd11UU0/9t
	 7Uq2ux4AF2qftAOCPo3sCImGI2vhFjdbJwwASu/zsJtvJ9huty57Zc4Ev4r+nRG1Bd
	 O4Jdiv9VRkBfA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D1198803B; Tue,  5 Mar 2024 11:33:25 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ED948803A
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 11:33:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4TpsNG0DBbz9sPl;
 Tue,  5 Mar 2024 11:33:18 +0100 (CET)
Message-ID: <eb988adc-6ae5-4d5d-aaeb-3f08224723b4@denx.de>
Date: Tue, 5 Mar 2024 11:33:17 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v5] rng: Add Turris Mox rTWM RNG driver
Content-Language: en-US
To: Max Resch <resch.max@gmail.com>, u-boot@lists.denx.de
References: <20240215165812.635479-1-resch.max@gmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240215165812.635479-1-resch.max@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TpsNG0DBbz9sPl
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

On 2/15/24 17:57, Max Resch wrote:
> A RNG driver for Armada 3720 boards running the Turris Mox rWTM firmware
> from CZ.NIC in the secure processor.
> 
> Signed-off-by: Max Resch <resch.max@gmail.com>

Applied to u-boot-marvell/master

Thanks,
Stefan

> ---
> 
> Changes in v5:
>   - check return code turris_rwtm_rng_fill_entropy
>   - remove empty line
> 
> Changes in v4:
>   - wrongful/missing git rebase
> 
> Changes in v3:
>   - More meaningful variable names in accordance with review
> 
> Changes in v2:
>   - Removed ring buffer implementation
> 
>   drivers/rng/Kconfig           |   8 +++
>   drivers/rng/Makefile          |   1 +
>   drivers/rng/turris_rwtm_rng.c | 123 ++++++++++++++++++++++++++++++++++
>   3 files changed, 132 insertions(+)
>   create mode 100644 drivers/rng/turris_rwtm_rng.c
> 
> diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
> index a89c899568..cd72852a47 100644
> --- a/drivers/rng/Kconfig
> +++ b/drivers/rng/Kconfig
> @@ -105,4 +105,12 @@ config RNG_JH7110
>   	help
>   	  Enable True Random Number Generator in StarFive JH7110 SoCs.
>   
> +config RNG_TURRIS_RWTM
> +	bool "Turris Mox TRNG in Secure Processor"
> +	depends on DM_RNG && ARMADA_3700
> +	help
> +	  Use TRNG in Turris Mox Secure Processor Firmware. Can be used
> +	  on other Armada-3700 devices (like EspressoBin) if Secure
> +	  Firmware from CZ.NIC is used.
> +
>   endif
> diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
> index 7e64c4cdfc..ecae1a3da3 100644
> --- a/drivers/rng/Makefile
> +++ b/drivers/rng/Makefile
> @@ -17,3 +17,4 @@ obj-$(CONFIG_RNG_SMCCC_TRNG) += smccc_trng.o
>   obj-$(CONFIG_RNG_ARM_RNDR) += arm_rndr.o
>   obj-$(CONFIG_TPM_RNG) += tpm_rng.o
>   obj-$(CONFIG_RNG_JH7110) += jh7110_rng.o
> +obj-$(CONFIG_RNG_TURRIS_RWTM) += turris_rwtm_rng.o
> diff --git a/drivers/rng/turris_rwtm_rng.c b/drivers/rng/turris_rwtm_rng.c
> new file mode 100644
> index 0000000000..ca808c4579
> --- /dev/null
> +++ b/drivers/rng/turris_rwtm_rng.c
> @@ -0,0 +1,123 @@
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
> +	struct turris_rwtm_rng_priv *priv = dev_get_priv(dev);
> +	phys_addr_t phys;
> +	size_t size;
> +	int ret;
> +
> +	phys = priv->buffer;
> +
> +	while (count) {
> +		size = min_t(size_t, RNG_BUFFER_SIZE, count);
> +
> +		ret = turris_rwtm_rng_fill_entropy(phys, size);
> +		if (ret < 0)
> +			return ret;
> +
> +		memcpy(data, (void *)phys, size);
> +		count -= size;
> +		data = (u8 *)data + size;
> +	}
> +
> +	return 0;
> +}
> +
> +static int turris_rwtm_rng_probe(struct udevice *dev)
> +{
> +	struct turris_rwtm_rng_priv *priv = dev_get_priv(dev);
> +	u32 args[] = { 0 };
> +	int ret;
> +
> +	/*
> +	 * check if the random command is supported
> +	 * args[0] = 0 would copy 16 DWORDS entropy to out but we ignore them
> +	 */
> +	ret = mbox_do_cmd(MBOX_CMD_GET_RANDOM, args, ARRAY_SIZE(args), NULL, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* entropy buffer */
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
> +	struct turris_rwtm_rng_priv *priv = dev_get_priv(dev);
> +	phys_addr_t phys = priv->buffer;
> +
> +	dma_free_coherent((void *)phys);
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
> +	.name	= "turris-rwtm-rng",
> +	.id	= UCLASS_RNG,
> +	.of_match = turris_rwtm_rng_match,
> +	.ops	= &turris_rwtm_rng_ops,
> +	.probe	= turris_rwtm_rng_probe,
> +	.remove = turris_rwtm_rng_remove,
> +	.priv_auto = sizeof(struct turris_rwtm_rng_priv),
> +};

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
