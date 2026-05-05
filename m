Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199BEFF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 10:16:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C9CD84895;
	Tue,  5 May 2026 12:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ugJaKXtd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4951D84893; Tue,  5 May 2026 12:16:00 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3447846D5
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 12:15:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 274AA400AC;
 Tue,  5 May 2026 10:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199A6C2BCB4;
 Tue,  5 May 2026 10:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777976156;
 bh=ITUG6PYXsvvdCvkqTIzvGLuiIDjl5Kdk6m82x+rMAMo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ugJaKXtd0YkcuyLqBPQv/3CS6FfALoRxqGbcnA2MSHC9L2qxbfu2VhQoNQL+yqlyp
 WN3HgrxutqyXjtVWitWSTRN7KAx8lHbvs4eMLhova2GMCeO6V9/+OO9P1xVkB3puGZ
 WaZihdoABuBwftzMDV+450xeR+Sivo7xTVzeLbAmfDoTYG8L37kbGmlgzpph8ibthF
 fzRGHrsdFxsvuxwrEsis5ibyHR7METHzHeDArRwVE9qtBu2s4FkmjrkwwYnDXzDQ7u
 OB3L/omVX+zsZ3kNvRt81myVETT4Z1PsSeKxNMmZx9dMsd43WqKT8QUZAQvTVHFAVx
 Bfo2yMCpVlsww==
Date: Tue, 5 May 2026 15:45:45 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>,
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v2 01/15] Revert "dm: SMEM (Shared memory) uclass"
Message-ID: <afnDUf1IpbbNUJIy@sumit-xelite>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
 <20260504-b4-modernise-smem-v2-1-c01ec2ff3886@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-b4-modernise-smem-v2-1-c01ec2ff3886@linaro.org>
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

On Mon, May 04, 2026 at 08:57:29PM +0200, Casey Connolly wrote:
> SMEM is a highly Qualcomm specific interface, while having a dedicated
> UCLASS for it offers a nice abstraction, for things like memory layout
> parsing we need to use it before the driver model is available.
> 
> Therefore, it doesn't make sense to fit SMEM into the driver model.
> Instead let's adopt a model closer to Linux, and parse SMEM really early
> during boot (as soon as we have the FDT).
> 
> This reverts commit 7b384eccc785b596f68448b155cbda26df57fb23.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  arch/arm/Kconfig           |  1 -
>  drivers/Kconfig            |  2 --
>  drivers/Makefile           |  1 -
>  drivers/smem/Kconfig       | 25 -------------
>  drivers/smem/Makefile      |  7 ----
>  drivers/smem/smem-uclass.c | 46 ------------------------
>  include/dm/uclass-id.h     |  1 -
>  include/smem.h             | 90 ----------------------------------------------
>  8 files changed, 173 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index f624675eadf8..dadb18e0b8cd 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1141,9 +1141,8 @@ config ARCH_SNAPDRAGON
>  	select POWER_DOMAIN
>  	select GPIO_EXTRA_HEADER
>  	select MSM_SMEM
>  	select OF_CONTROL
> -	select SMEM
>  	select SPMI
>  	select BOARD_LATE_INIT
>  	select OF_BOARD
>  	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 47606ddc6c8b..aa293df37c57 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -123,10 +123,8 @@ source "drivers/scsi/Kconfig"
>  source "drivers/serial/Kconfig"
>  
>  source "drivers/sm/Kconfig"
>  
> -source "drivers/smem/Kconfig"
> -
>  source "drivers/sound/Kconfig"
>  
>  source "drivers/soc/Kconfig"
>  
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 43d0ba332818..ca3e87ffb102 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -118,9 +118,8 @@ obj-y += pwm/
>  obj-y += reset/
>  obj-y += input/
>  obj-y += iommu/
>  # SOC specific infrastructure drivers.
> -obj-y += smem/
>  obj-y += thermal/
>  obj-$(CONFIG_TEE) += tee/
>  obj-$(CONFIG_ARM_FFA_TRANSPORT) += firmware/arm-ffa/
>  obj-y += axi/
> diff --git a/drivers/smem/Kconfig b/drivers/smem/Kconfig
> deleted file mode 100644
> index e5d7dcc81b17..000000000000
> --- a/drivers/smem/Kconfig
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -menuconfig SMEM
> -	bool  "SMEM (Shared Memory mamanger) support"
> -
> -if SMEM
> -
> -config SANDBOX_SMEM
> -    bool "Sandbox Shared Memory Manager (SMEM)"
> -    depends on SANDBOX && DM
> -    help
> -      enable SMEM support for sandbox. This is an emulation of a real SMEM
> -      manager.
> -      The sandbox driver allocates a shared memory from the heap and
> -      initialzies it on start.
> -
> -config MSM_SMEM
> -    bool "Qualcomm Shared Memory Manager (SMEM)"
> -    depends on DM
> -    depends on ARCH_SNAPDRAGON || ARCH_IPQ40XX
> -    select DEVRES
> -    help
> -      Enable support for the Qualcomm Shared Memory Manager.
> -      The driver provides an interface to items in a heap shared among all
> -      processors in a Qualcomm platform.
> -
> -endif # menu "SMEM Support"
> diff --git a/drivers/smem/Makefile b/drivers/smem/Makefile
> deleted file mode 100644
> index af3e9b50883c..000000000000
> --- a/drivers/smem/Makefile
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0+
> -#
> -# Makefile for the U-Boot SMEM interface drivers
> -
> -obj-$(CONFIG_SANDBOX_SMEM) += sandbox_smem.o
> -obj-$(CONFIG_SMEM) += smem-uclass.o
> -obj-$(CONFIG_MSM_SMEM) += msm_smem.o
> diff --git a/drivers/smem/smem-uclass.c b/drivers/smem/smem-uclass.c
> deleted file mode 100644
> index 4dea5cc4bf1c..000000000000
> --- a/drivers/smem/smem-uclass.c
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Copyright (c) 2018 Ramon Fried <ramon.fried@gmail.com>
> - */
> -
> -#define LOG_CATEGORY UCLASS_SMEM
> -
> -#include <dm.h>
> -#include <smem.h>
> -
> -int smem_alloc(struct udevice *dev, unsigned int host,
> -		unsigned int item, size_t size)
> -{
> -	struct smem_ops *ops = smem_get_ops(dev);
> -
> -	if (!ops->alloc)
> -		return -ENOSYS;
> -
> -	return ops->alloc(host, item, size);
> -}
> -
> -void *smem_get(struct udevice *dev, unsigned int host,
> -		unsigned int item, size_t *size)
> -{
> -	struct smem_ops *ops = smem_get_ops(dev);
> -
> -	if (!ops->get)
> -		return NULL;
> -
> -	return ops->get(host, item, size);
> -}
> -
> -int smem_get_free_space(struct udevice *dev, unsigned int host)
> -{
> -	struct smem_ops *ops = smem_get_ops(dev);
> -
> -	if (!ops->get_free_space)
> -		return -ENOSYS;
> -
> -	return ops->get_free_space(host);
> -}
> -
> -UCLASS_DRIVER(smem) = {
> -	.id     = UCLASS_SMEM,
> -	.name       = "smem",
> -};
> diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
> index 36b5d87c304f..fe0aae2720ca 100644
> --- a/include/dm/uclass-id.h
> +++ b/include/dm/uclass-id.h
> @@ -133,9 +133,8 @@ enum uclass_id {
>  	UCLASS_SCMI_BASE,	/* Interface for SCMI Base protocol */
>  	UCLASS_SCSI,		/* SCSI device */
>  	UCLASS_SERIAL,		/* Serial UART */
>  	UCLASS_SIMPLE_BUS,	/* Bus with child devices */
> -	UCLASS_SMEM,		/* Shared memory interface */
>  	UCLASS_SOC,		/* SOC Device */
>  	UCLASS_SOUND,		/* Playing simple sounds */
>  	UCLASS_SPI,		/* SPI bus */
>  	UCLASS_SPI_FLASH,	/* SPI flash */
> diff --git a/include/smem.h b/include/smem.h
> deleted file mode 100644
> index b19c534ebc43..000000000000
> --- a/include/smem.h
> +++ /dev/null
> @@ -1,90 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * The shared memory system is an allocate-only heap structure that
> - * consists of one of more memory areas that can be accessed by the processors
> - * in the SoC.
> - *
> - * Allocation can be done globally for all processors or to an individual processor.
> - * This is controlled by the @host parameter.
> - *
> - * Allocation and management of heap can be implemented in various ways,
> - * The @item parameter should be used as an index/hash to the memory region.
> - *
> - * Copyright (c) 2018 Ramon Fried <ramon.fried@gmail.com>
> - */
> -
> -#ifndef _smemh_
> -#define _smemh_
> -
> -/* struct smem_ops: Operations for the SMEM uclass */
> -struct smem_ops {
> -	/**
> -	 * alloc() - allocate space for a smem item
> -	 *
> -	 * @host:	remote processor id, or -1 for all processors.
> -	 * @item:	smem item handle
> -	 * @size:	number of bytes to be allocated
> -	 * @return 0 if OK, -ve on error
> -	 */
> -	int (*alloc)(unsigned int host,
> -		unsigned int item, size_t size);
> -
> -	/**
> -	 * get() - Resolve ptr of size of a smem item
> -	 *
> -	 * @host:	the remote processor, of -1 for all processors.
> -	 * @item:	smem item handle
> -	 * @size:	pointer to be filled out with the size of the item
> -	 * @return	pointer on success, NULL on error
> -	 */
> -	void *(*get)(unsigned int host,
> -		unsigned int item, size_t *size);
> -
> -	/**
> -	 * get_free_space() - Get free space in smem in bytes
> -	 *
> -	 * @host:   the remote processor identifying a partition, or -1
> -	 *			for all processors.
> -	 * @return	free space, -ve on error
> -	 */
> -	int (*get_free_space)(unsigned int host);
> -};
> -
> -#define smem_get_ops(dev)	((struct smem_ops *)(dev)->driver->ops)
> -
> -/**
> - * smem_alloc() - allocate space for a smem item
> - * @host:	remote processor id, or -1
> - * @item:	smem item handle
> - * @size:	number of bytes to be allocated
> - * Return: 0 if OK, -ve on error
> - *
> - * Allocate space for a given smem item of size @size, given that the item is
> - * not yet allocated.
> - */
> -int smem_alloc(struct udevice *dev, unsigned int host, unsigned int item, size_t size);
> -
> -/**
> - * smem_get() - resolve ptr of size of a smem item
> - * @host:	the remote processor, or -1 for all processors.
> - * @item:	smem item handle
> - * @size:	pointer to be filled out with size of the item
> - * Return:	pointer on success, NULL on error
> - *
> - * Looks up smem item and returns pointer to it. Size of smem
> - * item is returned in @size.
> - */
> -void *smem_get(struct udevice *dev, unsigned int host, unsigned int item, size_t *size);
> -
> -/**
> - * smem_get_free_space() - retrieve amount of free space in a partition
> - * @host:	the remote processor identifying a partition, or -1
> - *			for all processors.
> - * Return:	size in bytes, -ve on error
> - *
> - * To be used by smem clients as a quick way to determine if any new
> - * allocations has been made.
> - */
> -int smem_get_free_space(struct udevice *dev, unsigned int host);
> -
> -#endif /* _smem_h_ */
> 
> -- 
> 2.53.0
> 
