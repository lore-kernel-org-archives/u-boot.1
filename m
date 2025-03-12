Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12780C28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 21:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DFD9805D7;
	Wed, 12 Mar 2025 22:00:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ctPRmAwV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5747280756; Wed, 12 Mar 2025 22:00:44 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E30F58003E
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 22:00:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 901373F1F4
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 21:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1741813241;
 bh=OrH7joSpfDcGmeWuHFSMW11PKwPuDIdPeP652yXZiX8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=ctPRmAwVUytju2+0gpeSzcF3EsXeqmFCT1Ils5AuKLFUmkIAtTxVQRAcK8FD8Tbw3
 vNSDNg4Gtt3fBSOfJeXnkgWi6NiSpcoBA9TEAnIF+yHuJIXvuUHmtesOz9gwzIE9BJ
 mxG8ztBzFfdyrwseZ4MSdhIuc/+Hh/z0SMzjb8LGWa4q5gx+zq1W+MDQVc85VgE+Eq
 FrjMYOaF3tEx+aCIyMr38MwDmMwkqRKUcVrvvL7R3rsBonuN1ikZCzXgKPvaWNUDO2
 qJP9im0WCDPMlasCJi/yZRJOTrIyTm28mXiYiiOJCmLjgSevyoZuUv+VOi0ZpdGZfD
 JkYAvVHc72Feg==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cf44b66f7so1022895e9.1
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 14:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741813241; x=1742418041;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OrH7joSpfDcGmeWuHFSMW11PKwPuDIdPeP652yXZiX8=;
 b=uMUo4BuZZhOMgd7ZKpCxzbKb5m8EGz6PLyuzQBINCDJOqlG7+n8Kd4oHQvIwtDT9BL
 RPKSd0lDCrcgrynfYk45soxrTu3rrYjnaiIgFfTtme6A8drFoh91rup9XZw0yfHr5Y/F
 om55SyKQSroddppmhz0tM75WFYdoWGuG3uoehUEWfrHGvFOUozI0na7ChUIgfnfr2Ajy
 DtIiUeVSn4Y+PiX8tcglb1WSSVW39vScW+Vq5vUjAseoaSbpvaNQgXdSo8EoDcfDRcT2
 xgzZ6ca6sFUh6O2fpUJ3o4mMnFWEd9DP7tqjN1uDebsCWYA1LiXa/SnFycbsKz0EW81C
 mXUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOU+dKKug1cP58UHbwIMwfn7wJ9Dipk5Mo7LNVk4lLK5LsE+Q2NVIE5h6G5v15kY7ukzEpvYk=@lists.denx.de
X-Gm-Message-State: AOJu0YydwRYjUYMqgoxAoFR2nU7RhFahmhHbvPashav3w2yFEh9lYPdl
 WY1RuPnkgp+cDoP/WshXAOWZDdnx1zlY23sJ8SIodz8TW5J//+6Tav2GsRkcPJAFLHhJgZNO+mV
 qNKSIc6ZQKOQVRgHBQSQJk0Q8VAG1HfbKJsyMYkfi2Xz9xsinz/ftLcrByWlrbANf07E=
X-Gm-Gg: ASbGncs6STR19HXZIJINsmWbGP19J911W8rmnXhm2goqV6OSFD+VinWbnfwfUvIzMWo
 QAams0CO9cgN1teHeOb8TZcUeyxy4bh/YypHfMwD9/dT9ne4J/VTS04P9Tjoq8JzNfLHpyHX4Lw
 Wo+iNFSr3sIU0AsLsTMvLS/8vKo+cZ9fixy5vr5s7PVhTZ2ytnORR9a6siBLXbAnw75NvqUkBK8
 9rCW4gIA6IhqKTvxL0TLMKbAK2h+2bgD6CJDe/VLNPyD3oHXlXtKZY21046i4AbhbUaeWLJS0bZ
 d1hQ40WqPGWQ8wuyp30SwfXy4bRgyaPjqT0OSYdo7Ln8pPKb7xWzmZFgB8ivC6qVhyqx/0PBHGO
 t/F+/aQ==
X-Received: by 2002:a05:600c:4589:b0:43d:5ec:b2f4 with SMTP id
 5b1f17b1804b1-43d05ecc145mr71090975e9.10.1741813240844; 
 Wed, 12 Mar 2025 14:00:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHr9o3MeJ/jBnIJI4wzQ4A47U9yTnqjS+GQvkxRkZHim+utBV77TF32wGRq5KEQpU6YkkEYQ==
X-Received: by 2002:a05:600c:4589:b0:43d:5ec:b2f4 with SMTP id
 5b1f17b1804b1-43d05ecc145mr71090475e9.10.1741813238914; 
 Wed, 12 Mar 2025 14:00:38 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:345b:e644:8505:68cc:d761?
 ([2a02:3035:6e0:345b:e644:8505:68cc:d761])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a79a142sm31659355e9.33.2025.03.12.14.00.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 14:00:37 -0700 (PDT)
Message-ID: <32b11359-c517-4556-a24d-f4cb2c5c60f1@canonical.com>
Date: Wed, 12 Mar 2025 22:00:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/8] blkmap: add an attribute to preserve the mem
 mapping
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, u-boot@lists.denx.de
References: <20250312085424.1201148-1-sughosh.ganu@linaro.org>
 <20250312085424.1201148-8-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250312085424.1201148-8-sughosh.ganu@linaro.org>
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
> Some blkmap memory mapped devices might have to be relevant even after
> U-Boot passes control to the next image as part of the platform
> boot. An example of such a mapping would be an OS installer ISO image,
> information for which has to be provided to the OS kernel. Use the
> 'preserve' attribute for such mappings. The code for adding a pmem
> node to the device-tree then checks if this attribute is set, and adds
> a node only for mappings which have this attribute.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Tobias Waldekranz <tobias@waldekranz.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes since V7:
> * Fix repeated word in the commit message
> 
>   cmd/blkmap.c                  |  9 +++++++--
>   drivers/block/blkmap.c        | 12 ++++++++----
>   drivers/block/blkmap_helper.c |  2 +-
>   include/blkmap.h              |  4 +++-
>   4 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/cmd/blkmap.c b/cmd/blkmap.c
> index 164f80f1387..86a123b1cd3 100644
> --- a/cmd/blkmap.c
> +++ b/cmd/blkmap.c
> @@ -62,13 +62,18 @@ static int do_blkmap_map_mem(struct map_ctx *ctx, int argc, char *const argv[])
>   {
>   	phys_addr_t addr;
>   	int err;
> +	bool preserve = false;
>   
>   	if (argc < 2)
>   		return CMD_RET_USAGE;
>   
>   	addr = hextoul(argv[1], NULL);
>   
> -	err = blkmap_map_pmem(ctx->dev, ctx->blknr, ctx->blkcnt, addr);
> +	if (argc == 3 && !strcmp(argv[2], "preserve"))
> +		preserve = true;
> +
> +	err = blkmap_map_pmem(ctx->dev, ctx->blknr, ctx->blkcnt, addr,
> +			      preserve);
>   	if (err) {
>   		printf("Unable to map %#llx at block 0x" LBAF ": %d\n",
>   		       (unsigned long long)addr, ctx->blknr, err);
> @@ -221,7 +226,7 @@ U_BOOT_CMD_WITH_SUBCMDS(
>   	"blkmap create <label> - create device\n"
>   	"blkmap destroy <label> - destroy device\n"
>   	"blkmap map <label> <blk#> <cnt> linear <interface> <dev> <blk#> - device mapping\n"
> -	"blkmap map <label> <blk#> <cnt> mem <addr> - memory mapping\n",
> +	"blkmap map <label> <blk#> <cnt> mem <addr> [preserve] - memory mapping\n",
>   	U_BOOT_SUBCMD_MKENT(info, 2, 1, do_blkmap_common),
>   	U_BOOT_SUBCMD_MKENT(part, 2, 1, do_blkmap_common),
>   	U_BOOT_SUBCMD_MKENT(dev, 4, 1, do_blkmap_common),
> diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
> index 453510cca62..eefed615998 100644
> --- a/drivers/block/blkmap.c
> +++ b/drivers/block/blkmap.c
> @@ -19,6 +19,7 @@ struct blkmap;
>   /* Attributes of blkmap slice */
>   #define BLKMAP_SLICE_LINEAR	BIT(0)
>   #define BLKMAP_SLICE_MEM	BIT(1)

Documentation is missing here.

Cf. 
https://docs.kernel.org/doc-guide/kernel-doc.html#object-like-macro-documentation

> +#define BLKMAP_SLICE_PRESERVE	BIT(2)
>   
>   /**
>    * struct blkmap_slice - Region mapped to a blkmap
> @@ -241,7 +242,7 @@ static void blkmap_mem_destroy(struct blkmap *bm, struct blkmap_slice *bms)
>   }
>   
>   int __blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
> -		     void *addr, bool remapped)
> +		     void *addr, bool remapped, bool preserve)
>   {
>   	struct blkmap *bm = dev_get_plat(dev);
>   	struct blkmap_mem *bmm;
> @@ -266,6 +267,9 @@ int __blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>   		.remapped = remapped,
>   	};
>   
> +	if (preserve)
> +		bmm->slice.attr |= BLKMAP_SLICE_PRESERVE;
> +
>   	err = blkmap_slice_add(bm, &bmm->slice);
>   	if (err)
>   		free(bmm);
> @@ -276,11 +280,11 @@ int __blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>   int blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>   		   void *addr)
>   {
> -	return __blkmap_map_mem(dev, blknr, blkcnt, addr, false);
> +	return __blkmap_map_mem(dev, blknr, blkcnt, addr, false, false);
>   }
>   
>   int blkmap_map_pmem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
> -		    phys_addr_t paddr)
> +		    phys_addr_t paddr, bool preserve)
>   {
>   	struct blkmap *bm = dev_get_plat(dev);
>   	struct blk_desc *bd = dev_get_uclass_plat(bm->blk);
> @@ -291,7 +295,7 @@ int blkmap_map_pmem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>   	if (!addr)
>   		return -ENOMEM;
>   
> -	err = __blkmap_map_mem(dev, blknr, blkcnt, addr, true);
> +	err = __blkmap_map_mem(dev, blknr, blkcnt, addr, true, preserve);
>   	if (err)
>   		unmap_sysmem(addr);
>   
> diff --git a/drivers/block/blkmap_helper.c b/drivers/block/blkmap_helper.c
> index bfba14110d2..2f1bc28ee5d 100644
> --- a/drivers/block/blkmap_helper.c
> +++ b/drivers/block/blkmap_helper.c
> @@ -28,7 +28,7 @@ int blkmap_create_ramdisk(const char *label, ulong image_addr, ulong image_size,
>   	bm = dev_get_plat(bm_dev);
>   	desc = dev_get_uclass_plat(bm->blk);
>   	blknum = image_size >> desc->log2blksz;
> -	ret = blkmap_map_pmem(bm_dev, 0, blknum, image_addr);
> +	ret = blkmap_map_pmem(bm_dev, 0, blknum, image_addr, true);
>   	if (ret) {
>   		log_err("Unable to map %#llx at block %d : %d\n",
>   			(unsigned long long)image_addr, 0, ret);
> diff --git a/include/blkmap.h b/include/blkmap.h
> index d53095437fa..754d8671b01 100644
> --- a/include/blkmap.h
> +++ b/include/blkmap.h
> @@ -60,10 +60,12 @@ int blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>    * @blknr: Start block number of the mapping
>    * @blkcnt: Number of blocks to map
>    * @paddr: The target physical memory address of the mapping
> + * @preserve: Mapping intended to be preserved for subsequent stages,
> + *		like the OS (e.g. ISO installer)
>    * Returns: 0 on success, negative error code on failure
>    */
>   int blkmap_map_pmem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
> -		    phys_addr_t paddr);
> +		    phys_addr_t paddr, bool preserve);
>   
>   /**
>    * blkmap_from_label() - Find blkmap from label

