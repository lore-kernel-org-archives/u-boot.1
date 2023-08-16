Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECC4C001E0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 11:19:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 014488679B;
	Wed, 16 Aug 2023 13:19:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Ge7l+uZq";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Y6V+AM9K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4A4D869B8; Wed, 16 Aug 2023 13:19:01 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5759807C9
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 13:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RQlyB3xSKz9sjc;
 Wed, 16 Aug 2023 13:18:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692184738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8gJWdKwsRV1n37hw9en0qb+6le4pAnzWBeq1TdmPo/8=;
 b=Ge7l+uZq6m/7uxzbYtuNDDaqC8QIgwiHbjicLQ23gWILZ80VXLohCmJTab/oW3C7Er4JUh
 icAQrL3/gMsu6cLJKnHTRKWaos/H4k+wwxaJ8t1gVWRp5Gb8wu+P3IOhxxhYZzUXLJVWZH
 VrDyoWp37CPAIgh1tIFV0H2dgv1ZWVsm0ZXyu7oYam0YSUiaXZpQuB/xxysZtS7fil/SE8
 AgKHgi8L17WdqsmIQ/JkqZuoHCTjY38uywaMjqbN8pbMqzrDz16MvGDcS2cgvq4mUMleA5
 cQXoG8/5sUg6k7vgRqEiELqy5QujBtw9K68yVCh4Sk18KrKQr3APJ4F+k9ixVg==
Message-ID: <2a74558f-1cf5-2333-a585-8871ea163e68@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692184735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8gJWdKwsRV1n37hw9en0qb+6le4pAnzWBeq1TdmPo/8=;
 b=Y6V+AM9KvQCPMXWg6GPiSgHxdmQwkJYAkXvD3v+CB7U7B4WrdNV4bqUQs8+j10hgiiyWU5
 8FQITw0j/XrmRycK4JTBvG+QXMsN80ofG3Ez3UFzve2AfeyrTLj1Osddg8aMUVW4jpYAHm
 iuXz6/M/zybD0b6vUIHi1J3PzivoAOUZ4Q5C4UsG4iAxiktMZKVeiGt1f9dFhpRJ6k4Zcn
 FHxUBlbngdNh4j69Uex08YflAYirYbB/QA+vVezdafYzD1g4kHl9svbA2F2UQmvrWQHmDO
 1zQ3mCZzwDhJR7XL2vgc2SvvsWNfW6QbF7+NuyWwzdCBToGek7WKSZHynfMd9A==
Date: Wed, 16 Aug 2023 13:18:54 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] nvmxip: add sandbox support
Content-Language: en-US
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, sjg@chromium.org
Cc: marek.vasut+renesas@mailbox.org, nd@arm.com, trini@konsulko.com,
 u-boot@lists.denx.de
References: <CAPnjgZ34z865voaKeShSJpdvWcFLbN0OEWBnus4qt0W_1P4jBw@mail.gmail.com>
 <20230816110551.86930-1-abdellatif.elkhlifi@arm.com>
 <20230816110551.86930-2-abdellatif.elkhlifi@arm.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230816110551.86930-2-abdellatif.elkhlifi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 2fcf87a07575e369ce4
X-MBO-RS-META: w84n1ft46d66kdue8wesnsb4xmuc4rx1
X-Rspamd-Queue-Id: 4RQlyB3xSKz9sjc
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

On 8/16/23 13:05, Abdellatif El Khlifi wrote:
> enable the 32-bit version of sandbox
> 
> Initially NVMXIP came with sandbox64 support.
> Let's enable sandbox support as well.
> 
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Marek Vasut <marek.vasut@mailbox.org>
> 
> ---
> 
> Changelog:
> ===============
> 
> v2:
> 
> * split into 2 commits: one for sandbox 32-bit support,
>     and one for moving PHYS_ADDR_LN* to log.h
> 
> v1: introduce the sandbox 32-bit support
> 
> arch/sandbox/dts/sandbox.dts       | 14 ++++++++++++++

Please separate DT change

>   configs/sandbox_defconfig          |  4 ++--

Config change too, separate patch that goes last.

>   drivers/mtd/nvmxip/nvmxip-uclass.c |  6 +++---
>   drivers/mtd/nvmxip/nvmxip.c        | 13 +++++++++++--
>   drivers/mtd/nvmxip/nvmxip_qspi.c   |  2 +-
>   test/dm/Makefile                   |  2 +-
>   6 files changed, 32 insertions(+), 9 deletions(-)

[...]

> --- a/drivers/mtd/nvmxip/nvmxip-uclass.c
> +++ b/drivers/mtd/nvmxip/nvmxip-uclass.c
> @@ -9,7 +9,7 @@
>   #include <common.h>
>   #include <dm.h>
>   #include <log.h>
> -#if CONFIG_IS_ENABLED(SANDBOX64)
> +#if CONFIG_IS_ENABLED(SANDBOX)
>   #include <asm/test.h>
>   #endif
>   #include <linux/bitops.h>
> @@ -39,7 +39,7 @@ static int nvmxip_post_bind(struct udevice *udev)
>   	char bdev_name[NVMXIP_BLKDEV_NAME_SZ + 1];
>   	int devnum;
>   
> -#if CONFIG_IS_ENABLED(SANDBOX64)
> +#if CONFIG_IS_ENABLED(SANDBOX)
>   	sandbox_set_enable_memio(true);

This should not be in drivers at all, this should be in tests/ , see

https://source.denx.de/u-boot/custodians/u-boot-sh/-/commit/b07772226b405d6212d4faa9329d64a09708b188

>   #endif
>   
> @@ -62,7 +62,7 @@ static int nvmxip_post_bind(struct udevice *udev)
>   		return ret;
>   	}
>   
> -	log_info("[%s]: the block device %s ready for use\n", udev->name, bdev_name);
> +	log_debug("[%s]: the block device %s ready for use\n", udev->name, bdev_name);

Unrelated change -> separate patch please.

>   	return 0;
>   }
> diff --git a/drivers/mtd/nvmxip/nvmxip.c b/drivers/mtd/nvmxip/nvmxip.c
> index a359e3b482..9191e69a40 100644
> --- a/drivers/mtd/nvmxip/nvmxip.c
> +++ b/drivers/mtd/nvmxip/nvmxip.c
> @@ -11,6 +11,7 @@
>   #include <log.h>
>   #include <mapmem.h>
>   #include <asm/io.h>
> +#include <linux/bitfield.h>
>   #include <linux/bitops.h>
>   #include <linux/errno.h>
>   #include "nvmxip.h"
> @@ -26,9 +27,17 @@
>    *
>    * Always return 0.
>    */
> -static int nvmxip_mmio_rawread(const phys_addr_t address, u64 *value)
> +static int nvmxip_mmio_rawread(const u64 *address, u64 *value)
>   {
> +#if CONFIG_IS_ENABLED(PHYS_64BIT)
>   	*value = readq(address);
> +#else
> +	u32 h_word, l_word;
> +
> +	l_word = readl(address);
> +	h_word = readl((u8 *)address + sizeof(u32));
> +	*value = FIELD_PREP(GENMASK_ULL(63, 32), h_word) | l_word;
> +#endif
>   	return 0;
>   }
>   
> @@ -67,7 +76,7 @@ static ulong nvmxip_blk_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcn
>   	/* assumption: the data is virtually contiguous */
>   
>   	for (qdata_idx = 0 ; qdata_idx < qwords ; qdata_idx++)
> -		nvmxip_mmio_rawread((phys_addr_t)(virt_blkaddr + qdata_idx), pdst++);
> +		nvmxip_mmio_rawread(virt_blkaddr + qdata_idx, pdst++);

Separate patch please, or just use this commit as part of this series:

https://source.denx.de/u-boot/custodians/u-boot-sh/-/commit/85a662e98c44921a0f5652fa4b170625424ef9a9

>   	log_debug("[%s]:     src[0]: 0x%llx , dst[0]: 0x%llx , src[-1]: 0x%llx , dst[-1]: 0x%llx\n",
>   		  dev->name,
> diff --git a/drivers/mtd/nvmxip/nvmxip_qspi.c b/drivers/mtd/nvmxip/nvmxip_qspi.c
> index 7221fd1cb4..faeb99b4ad 100644
> --- a/drivers/mtd/nvmxip/nvmxip_qspi.c
> +++ b/drivers/mtd/nvmxip/nvmxip_qspi.c
> @@ -50,7 +50,7 @@ static int nvmxip_qspi_of_to_plat(struct udevice *dev)
>   		return -EINVAL;
>   	}
>   
> -	log_debug("[%s]: XIP device base addr: 0x%llx , lba_shift: %d , lbas: %lu\n",
> +	log_debug("[%s]: XIP device base addr: " PHYS_ADDR_LN " , lba_shift: %d , lbas: %lu\n",
>   		  dev->name, plat->phys_base, plat->lba_shift, plat->lba);

Another separate patch.

>   	return 0;
> diff --git a/test/dm/Makefile b/test/dm/Makefile
> index 7ed00733c1..77172d9012 100644
> --- a/test/dm/Makefile
> +++ b/test/dm/Makefile
> @@ -18,7 +18,7 @@ obj-$(CONFIG_UT_DM) += test-uclass.o
>   obj-$(CONFIG_UT_DM) += core.o
>   obj-$(CONFIG_UT_DM) += read.o
>   obj-$(CONFIG_UT_DM) += phys2bus.o
> -ifeq ($(CONFIG_NVMXIP_QSPI)$(CONFIG_SANDBOX64),yy)
> +ifeq ($(CONFIG_NVMXIP_QSPI),y)

Separate patch.

Look here for some ideas:

https://source.denx.de/u-boot/custodians/u-boot-sh/-/commits/ci%2Ftest-sandbox64?ref_type=heads
