Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307CBC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 21:08:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89421800B6;
	Wed, 12 Mar 2025 22:08:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="NIE+Cho5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7951805D7; Wed, 12 Mar 2025 22:08:43 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E1198003E
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 22:08:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6001E3F2B2
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 21:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1741813720;
 bh=DFJTieNzkq9V1qSmEC8ixYBcFl4MNKSAj5+zi/OOoVk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=NIE+Cho5T+Dl9NwLXVWkuD9ryG3v8csW0kqVCBuIxUUGH630+KRWSjGmBGMDU3PT1
 lRAfK1HVdd/Zx4rhgwIvPB2MIwYfZCdeSQoNZubLmYeAzmnBtfzSAepMrFAOx5MSY0
 4AZ5+YQ+qx4G6UWbeMtW9MzboPvuoM4ptPF6bjcXe/TiR5xtbCkctkYdcYCAKghHuD
 yI1Yf6oudRQIwzcdBOAFtm08xhJhe9pziytNT17lNTGMvBJZIe5LeYzOua1IpFuXe/
 fUp7gWa9udIqCSNDGFySeObzgwy/Wi1BHlodQY9HttvhbaLNeN2Rj+CBKdEbStDz/U
 oVxFsVko2uZWw==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43947a0919aso1564305e9.0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 14:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741813720; x=1742418520;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DFJTieNzkq9V1qSmEC8ixYBcFl4MNKSAj5+zi/OOoVk=;
 b=TbwS/8MrL4K+oF8NvojyGPepeT1m6sS4d6IncSu0IbIadZ9tXq1ncBiPxW9XXSo8Hv
 2gfIauQHdgnJJKsQ/Dz0vZ8ZJy0sHROlQN/y5/jrjcpxd+vSQNj8Bmsyf4F5AJbKChKq
 cVMzYi1TicrwgKXeEPAYm2uoEAM2PHsdZQXZ2yJicXv9jaSoBgMiaTzfcto6JBX2R6K5
 z/PzHqi7QNtU0J9OrAkiTe145h209uxESPWD8meRGb2CrjA/mcqW3VZAHYcY0JctZ+z3
 V11xeRtOr6tGgO2+t1QzKiDs7G7oPtT4P0eBpDfd168E+YWGZmN5pRC/q/8lbjvSAwPr
 Eykw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOl165WxOxWxFMs7uHV6ZZtF41MQxq0dAeWud6GMoiVhb3ewvol1CzHLsnUVHqBt8KC7TwZ8U=@lists.denx.de
X-Gm-Message-State: AOJu0YzIhsECKc/qMPBUuRlrk2KM1SBw2QVQN+Ll9B800HRHeHX5POkI
 2GX4trdvNWecvrD6uO1rnsf9Bljx94+455R+FX4S8wk6I3MgDba4FDW5fUfTLu1CUm6/b5JWypT
 D2aPhboVkkyXZ2Oe4hxxhmPtnf9E8r+4N04WLE77jv0PcR4FhMNyUe15I1LTqHGzvl4wAyyWiqC
 Y=
X-Gm-Gg: ASbGncsbThh8WWHZ6AiPQfoA/1yFlwqofk04QbQcpSbbSlYnGuFuUv4W7MamkyRnXao
 6lQRH9gYRLDfR5vBJrf0B/iPgqRW5kyuCOtvI1RE1nzE8ReQ+GFubogCxNcUW4xZ2bjGyMoGDhq
 FHhX3NI5yHzpoghxs6hgcEU3ya51jzNuw0P1lPc0/jQrJ7A28PgFOLP+CujPQ4kik2Ob8fzq993
 nY83zAUY5AtYvrPGU2UGxEAQ7jJJTt1FN/RRxcmXQa4f97rnZU9GktTE2w0qtO5W83T1pE5UWCk
 XaRaUzj/x+NjO6Hjb3f8djg/kpgMPSq9gCGWNceO0I2oERqPqm13X4iFBPATYvD4xHtAUECztrQ
 srl6Uzg==
X-Received: by 2002:a05:600c:1e8c:b0:43c:fc0c:7f33 with SMTP id
 5b1f17b1804b1-43cfc0c92bcmr132609745e9.2.1741813719811; 
 Wed, 12 Mar 2025 14:08:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl8SyLUZk7AKGEG8a0JxMw2axzfu6Cq3d+gwmRGUXbo/Dq4AZzDaTIj9FweT4tx2od1ejd8g==
X-Received: by 2002:a05:600c:1e8c:b0:43c:fc0c:7f33 with SMTP id
 5b1f17b1804b1-43cfc0c92bcmr132609575e9.2.1741813719368; 
 Wed, 12 Mar 2025 14:08:39 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:345b:e644:8505:68cc:d761?
 ([2a02:3035:6e0:345b:e644:8505:68cc:d761])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a731270sm32570825e9.5.2025.03.12.14.08.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 14:08:38 -0700 (PDT)
Message-ID: <ab576278-e196-4def-8cd4-5c828259cbc5@canonical.com>
Date: Wed, 12 Mar 2025 22:08:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/8] blkmap: pass information on ISO image to the OS
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, u-boot@lists.denx.de
References: <20250312085424.1201148-1-sughosh.ganu@linaro.org>
 <20250312085424.1201148-9-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250312085424.1201148-9-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 12.03.25 09:54, Sughosh Ganu wrote:
> The EFI HTTP boot puts the ISO installer image at some location in
> memory. Information about this image has to be passed on to the OS
> kernel, which is done by adding a persistent memory(pmem) node to the
> devicetree(DT) that is passed to the OS. The OS kernel then gets
> information about the presence of this ISO image and proceeds with the
> installation.
> 
> In U-Boot, this ISO image gets mounted as a memory mapped blkmap
> device slice, with the 'preserve' attribute. Add a helper function
> which iterates through all such slices, and invokes a callback. The
> callback adds the pmem node to the DT and removes the corresponding
> memory region from the EFI memory map. Invoke this helper function as
> part of the DT fixup which happens before booting the OS.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
> Changes since V7:
> * Fix checkpatch errors in blkmap.c and efi_helper.c
> 
>   boot/image-fdt.c            |  7 ++++++
>   drivers/block/blkmap.c      | 44 +++++++++++++++++++++++++++++++++++++
>   include/blkmap.h            | 17 ++++++++++++++
>   include/efi.h               | 13 +++++++++++
>   lib/efi_loader/efi_helper.c | 39 ++++++++++++++++++++++++++++++++
>   5 files changed, 120 insertions(+)
> 
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index 9d1598b1a93..8f718ad29f6 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -11,6 +11,7 @@
>   #include <command.h>
>   #include <fdt_support.h>
>   #include <fdtdec.h>
> +#include <efi.h>
>   #include <env.h>
>   #include <errno.h>
>   #include <image.h>
> @@ -649,6 +650,12 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
>   	if (!ft_verify_fdt(blob))
>   		goto err;
>   
> +	if (CONFIG_IS_ENABLED(BLKMAP) && CONFIG_IS_ENABLED(EFI_LOADER)) {
> +		fdt_ret = fdt_efi_pmem_setup(blob);
> +		if (fdt_ret)
> +			goto err;
> +	}
> +
>   	/* after here we are using a livetree */
>   	if (!of_live_active() && CONFIG_IS_ENABLED(EVENT)) {
>   		struct event_ft_fixup fixup;
> diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
> index eefed615998..5f7602d0405 100644
> --- a/drivers/block/blkmap.c
> +++ b/drivers/block/blkmap.c
> @@ -498,6 +498,50 @@ err:
>   	return err;
>   }
>   

Please, add the missing documentation.
https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation

> +static bool blkmap_mem_preserve_slice(struct blkmap_slice *bms)
> +{
> +	return (bms->attr & (BLKMAP_SLICE_MEM | BLKMAP_SLICE_PRESERVE)) ==
> +		(BLKMAP_SLICE_MEM | BLKMAP_SLICE_PRESERVE);
> +}
> +
> +int blkmap_get_preserved_pmem_slice(int (*cb)(void *ctx, ulong addr,
> +					      u32 size), void *ctx)
> +{
> +	int ret;
> +	u32 size;
> +	ulong addr;
> +	struct udevice *dev;
> +	struct uclass *uc;
> +	struct blkmap *bm;
> +	struct blkmap_mem *bmm;
> +	struct blkmap_slice *bms;
> +	struct blk_desc *bd;
> +
> +	if (!cb) {
> +		log_debug("%s: No callback passed to the function\n", __func__);
> +		return 0;
> +	}
> +
> +	uclass_id_foreach_dev(UCLASS_BLKMAP, dev, uc) {
> +		bm = dev_get_plat(dev);
> +		bd = dev_get_uclass_plat(bm->blk);
> +
> +		list_for_each_entry(bms, &bm->slices, node) {
> +			if (!blkmap_mem_preserve_slice(bms))
> +				continue;
> +
> +			bmm = container_of(bms, struct blkmap_mem, slice);
> +			addr = (ulong)(uintptr_t)bmm->addr;
> +			size = (u32)bms->blkcnt << bd->log2blksz;
> +			ret = cb(ctx, addr, size);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   int blkmap_destroy(struct udevice *dev)
>   {
>   	int err;
> diff --git a/include/blkmap.h b/include/blkmap.h
> index 754d8671b01..30ce80c0ad1 100644
> --- a/include/blkmap.h
> +++ b/include/blkmap.h
> @@ -7,6 +7,7 @@
>   #ifndef _BLKMAP_H
>   #define _BLKMAP_H
>   
> +#include <blk.h>
>   #include <dm/lists.h>
>   
>   /**
> @@ -104,4 +105,20 @@ int blkmap_destroy(struct udevice *dev);
>   int blkmap_create_ramdisk(const char *label, ulong image_addr, ulong image_size,
>   			  struct udevice **devp);
>   
> +/**
> + * blkmap_get_preserved_pmem_slice() - Look for memory mapped preserved slice
> + * @cb: Callback function to call for the blkmap slice

Please, describe in sufficient detail for a developer who has to 
implement such a callback function what information should be provided 
by the function.

All arguments of cb and its return value need to be described.

Best regards

Heinrich

> + * @ctx: Argument to be passed to the callback function
> + *
> + * The function is used to iterate through all the blkmap slices, looking
> + * specifically for memory mapped blkmap mapping which has been
> + * created with the preserve attribute. The function looks for such slices
> + * with the relevant attributes and then calls the callback function which
> + * then does additional configuration as needed.
> + *
> + * Return: 0 on success, negative error on failure
> + */
> +int blkmap_get_preserved_pmem_slice(int (*cb)(void *ctx, ulong addr,
> +					      u32 size), void *ctx);
> +
>   #endif	/* _BLKMAP_H */
> diff --git a/include/efi.h b/include/efi.h
> index d005cb6181e..f9bbb175c3a 100644
> --- a/include/efi.h
> +++ b/include/efi.h
> @@ -705,4 +705,17 @@ static inline bool efi_use_host_arch(void)
>    */
>   int efi_get_pxe_arch(void);
>   
> +/**
> + * fdt_efi_pmem_setup() - Pmem setup in DT and EFI memory map
> + * @fdt: Devicetree to add the pmem nodes to
> + *
> + * Iterate through all the blkmap devices, look for BLKMAP_MEM devices,
> + * and add pmem nodes corresponding to the blkmap slice to the
> + * devicetree along with removing the corresponding region from the
> + * EFI memory map.
> + *
> + * Returns: 0 on success, negative error on failure
> + */
> +int fdt_efi_pmem_setup(void *fdt);
> +
>   #endif /* _LINUX_EFI_H */
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index 37e5859741f..62772a0d747 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -5,6 +5,7 @@
>   
>   #define LOG_CATEGORY LOGC_EFI
>   
> +#include <blkmap.h>
>   #include <bootm.h>
>   #include <env.h>
>   #include <image.h>
> @@ -680,3 +681,41 @@ out:
>   
>   	return ret;
>   }
> +
> +/**
> + * pmem_node_efi_memmap_setup() - Add pmem node and tweak EFI memmap
> + * @fdt: The devicetree to which pmem node is added
> + * @addr: start address of the pmem node
> + * @size: size of the memory of the pmem node
> + *
> + * The function adds the pmem node to the device-tree along with removing
> + * the corresponding region from the EFI memory map. Used primarily to
> + * pass the information of a RAM based ISO image to the OS.
> + *
> + * Return: 0 on success, -ve value on error
> + */
> +static int pmem_node_efi_memmap_setup(void *fdt, ulong addr, u32 size)
> +{
> +	int ret;
> +	efi_status_t status;
> +
> +	ret = fdt_fixup_pmem_region(fdt, addr, size);
> +	if (ret) {
> +		log_err("Failed to setup pmem node for addr %#lx, size %#x, err %d\n",
> +			addr, size, ret);
> +		return ret;
> +	}
> +
> +	status = efi_remove_memory_map(addr, size,
> +				       EFI_CONVENTIONAL_MEMORY);
> +	if (status != EFI_SUCCESS)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +int fdt_efi_pmem_setup(void *fdt)
> +{
> +	return blkmap_get_preserved_pmem_slice(pmem_node_efi_memmap_setup,
> +					       fdt);
> +}

