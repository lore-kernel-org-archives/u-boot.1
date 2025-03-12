Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9D0C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 20:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43AC180756;
	Wed, 12 Mar 2025 21:42:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="TwGDrKwh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F5FA807D7; Wed, 12 Mar 2025 21:42:52 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE4DA805D7
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 21:42:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D2AAE3F175
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 20:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1741812166;
 bh=6Vgesql+TkrqzO4LASj/YOZuk/OS0sa4J2JVZ7xz8CE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=TwGDrKwh4h7xFnT72aIavE52Jm4KXRxeFhMVrTK/jYniki1NhYceYLXr7k6VpeM+i
 9K2NhghHyJ6/qO6EgMeStL9aF2jVFuofPIxdTzl/cv13gvHMAnwsk63SENJVp61aHB
 XeDVLAKAtgx0+mPnD/Qbpj9PYIEn+7AuXxxhHpla0MGc8d57XQVkStsWj2P+48ZGmX
 agyLGynbfuW6r2oVXrTe/IauhG36vd5+v9aOMAp4dRIWpEwz/9AnMQhgYQmcZpvqQk
 +38VQN/lJ85QtRgs6YSp72RqeBES0dYgoZhS5iGwt2UJVYsMxYTpNnPUBn0a1afANw
 sxwna/mHnsMog==
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ab76aa0e72bso22263366b.0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 13:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741812165; x=1742416965;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Vgesql+TkrqzO4LASj/YOZuk/OS0sa4J2JVZ7xz8CE=;
 b=DmnLV+ZXnpgxWmSCSbm1loJ0YEfdg6Ireq8+8FKe93M87bioBqCqrknaw/AdKZn+9j
 +qOHGlEKV2zDdd1x0vYwhrdnwG/4d0cu/SoOsSmJm20A2EbBpF2WZi8jnu8W730wvAMx
 yM64JaZS11J2EtVIZOV8B5pzuYHuU9MTid98xOQC2Tm8jUba2kfDj114QcSumHIQx5yM
 IT46Seijfm1b8zRr1WZXMJtdtZT+vRrBumhIveR2W+pnZGz1Ws9aQqoCOOsU5Urzm9n3
 H0lndk7M/bIutwHO3M7Nc6I0nqew2WrLrWaIqF0d5++ZughqM/O7yg4LLSh2/3Giu/HM
 Wwmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKJKQZOcwRnJGgAoP4Cn6P3+6hjmwGJAh+mf831EKKyGZsOXVwxEdua51/PLpIDi8bZcus1CY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+EJJlUpYLJau3ih0pCqUyv4KiaVUB9vH4645sAp92HFSLNaov
 GHjpWkz+tvAmh6NKZHt61VbY8jKu6XxqBO8aTxz6iAdG2a98mIjVsu+1YQZpz4/mOic2xVsps7u
 mdfb29BIPfeLeUzEWx6tudHVz8JAuauIyXG6Ed4GloObjpCurzq78G2qF9MUYNHRqZ84=
X-Gm-Gg: ASbGncu2dR1FfH2RKNUCt5JEXR8WP8AWGgNH6vQ5KOfTH7sVzknptYkYoc8Vn+8EWCh
 t+nn43hfVsY+96eAqQSV/hLEVxUfV/OhweVaHVa84dHWANdcIVRKEdylEZ2U01A06Bet9j/6Wp6
 Bmu3WuSH9/urBii2MWfC4A8IK9wuy5j3UP0N78xlzmvT3GXdbzedN/rhVg9yPnPxAuxU+C/fOQs
 PtPhpf3u+9Dbs9yHmBQnTCwVfcr9cg39H60jBDWkpAGbNibx6ej86GuKwSVIXstH42zP4fbQsxN
 AdLX5ltG08XaDS9UQ3vb+oGXkngXhqlDmMsZljbEN1QAwMRcfzK3LmVmOY2DsuepR3noQzmafSz
 /Xll/xw==
X-Received: by 2002:a17:907:3606:b0:abf:61b7:4603 with SMTP id
 a640c23a62f3a-ac252718911mr780982766b.33.1741812165530; 
 Wed, 12 Mar 2025 13:42:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGamElic8KxCw8N8jQHMIxuglwG1OLqYKtANF/cvWx7gqKHtD/MiqDgAlGzSUBYqBRUlBR2Q==
X-Received: by 2002:a17:907:3606:b0:abf:61b7:4603 with SMTP id
 a640c23a62f3a-ac252718911mr780979866b.33.1741812165094; 
 Wed, 12 Mar 2025 13:42:45 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:345b:e644:8505:68cc:d761?
 ([2a02:3035:6e0:345b:e644:8505:68cc:d761])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac25ab328b6sm936221566b.124.2025.03.12.13.42.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 13:42:44 -0700 (PDT)
Message-ID: <0cc03dfd-2dda-47d8-83ad-cce8d3a3cad1@canonical.com>
Date: Wed, 12 Mar 2025 21:42:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/8] fdt: add support for adding pmem nodes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
References: <20250312085424.1201148-1-sughosh.ganu@linaro.org>
 <20250312085424.1201148-4-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250312085424.1201148-4-sughosh.ganu@linaro.org>
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
> From: Masahisa Kojima <kojima.masahisa@socionext.com>
> 
> One of the problems OS installers face, when running in EFI, is that
> the mounted ISO after calling ExitBootServices goes away. For some

A mounted ISO only goes away if it is a RAM disk. But you do not mention 
RAM disks in the first paragraph. Please, add an introductory sentence 
that this patch is about RAM disk support.

Whether the RAM disk contains an installer or a preinstalled OS or 
anything else is irrelevant for the the need of a pmem node to support 
RAM disks. If the RAM disk is partitioned (possibly as ISO9660) or is 
just a raw disk is irrelevant here, too.

> distros this is a problem since they rely on finding some core packages
> before continuing the installation. Distros have works around this --
> e.g Fedora has a special kernel command line parameter called
> inst.stage2 [0].
> 
> ACPI has NFIT and NVDIMM support to provide ramdisks to the OS, but we
> don't have anything in place for DTs. Linux and device trees have support
> for persistent memory devices. So add a function that can inject a pmem
> node in a DT, so we can use it when launhing OS installers with EFI.

Nits:

%s/launhing/launching/

> 
> [0]
> https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/installation_guide/chap-anaconda-boot-options#sect-boot-options-installer
> 
> Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V7: None
> 
>   boot/fdt_support.c    | 41 ++++++++++++++++++++++++++++++++++++++++-
>   include/fdt_support.h | 14 ++++++++++++++
>   2 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 49efeec3681..e20b9759138 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -18,6 +18,7 @@
>   #include <dm/ofnode.h>
>   #include <linux/ctype.h>
>   #include <linux/types.h>
> +#include <linux/sizes.h>
>   #include <asm/global_data.h>
>   #include <asm/unaligned.h>
>   #include <linux/libfdt.h>
> @@ -464,7 +465,6 @@ void do_fixup_by_compat_u32(void *fdt, const char *compat,
>   	do_fixup_by_compat(fdt, compat, prop, &tmp, 4, create);
>   }
>   
> -#ifdef CONFIG_ARCH_FIXUP_FDT_MEMORY
>   /*
>    * fdt_pack_reg - pack address and size array into the "reg"-suitable stream
>    */
> @@ -493,6 +493,7 @@ static int fdt_pack_reg(const void *fdt, void *buf, u64 *address, u64 *size,
>   	return p - (char *)buf;
>   }
>   
> +#ifdef CONFIG_ARCH_FIXUP_FDT_MEMORY
>   #if CONFIG_NR_DRAM_BANKS > 4
>   #define MEMORY_BANKS_MAX CONFIG_NR_DRAM_BANKS
>   #else
> @@ -2222,3 +2223,41 @@ int fdt_valid(struct fdt_header **blobp)
>   	}
>   	return 1;
>   }
> +
> +int fdt_fixup_pmem_region(void *blob, ulong addr, u32 size)
> +{
> +	u64 pmem_start[2] = { 0 };
> +	u64 pmem_size[2] = { 0 };

You never use index 1. There is no need for defining an array here.
You could use:

u64 pmem_start;
u64 pmem_size;

But better simply define the parameters addr and size of the function as 
u64 and use them directly.

> +	char pmem_node[32] = {0};

%s/pmem_node/node_name/g

Why should we the initialize the field here?

> +	int nodeoffset, len;
> +	int err;
> +	u8 tmp[4 * 16]; /* Up to 64-bit address + 64-bit size */
> +
> +	if (!IS_ALIGNED(addr, SZ_2M) || !IS_ALIGNED(addr + size, SZ_2M)) {
> +		printf("Start and end address must be 2MiB aligned\n");
> +		return -1;
> +	}
> +
> +	snprintf(pmem_node, sizeof(pmem_node), "pmem@%lx", addr);
> +	nodeoffset = fdt_find_or_add_subnode(blob, 0, pmem_node);
> +	if (nodeoffset < 0)
> +		return nodeoffset;
> +
> +	err = fdt_setprop_string(blob, nodeoffset, "compatible", "pmem-region");
> +	if (err)
> +		return err;
> +	err = fdt_setprop_empty(blob, nodeoffset, "volatile");
> +	if (err)
> +		return err;
> +	pmem_start[0] = addr;
> +	pmem_size[0] = size;
> +	len = fdt_pack_reg(blob, tmp, pmem_start, pmem_size, 1);

len = fdt_pack_reg(blob, tmp, &addr, &size, 1);

assuming that addr, size are changed to u64.

> +	err = fdt_setprop(blob, nodeoffset, "reg", tmp, len);
> +	if (err < 0) {
> +		printf("WARNING: could not set pmem %s %s.\n", "reg",
> +		       fdt_strerror(err));
> +		return err;
> +	}
> +
> +	return 0;
> +}
> diff --git a/include/fdt_support.h b/include/fdt_support.h
> index f0ad2e6b365..b72cd2920de 100644
> --- a/include/fdt_support.h
> +++ b/include/fdt_support.h
> @@ -507,4 +507,18 @@ void fdt_fixup_pstore(void *blob);
>    */
>   int fdt_kaslrseed(void *blob, bool overwrite);
>   
> +/**
> + * fdt_fixup_pmem_region() - add a pmem node on the device tree
> + *
> + * This functions adds/updates a pmem node to the device tree.
> + * Usually used with EFI installers to preserve installer
> + * images
> + *
> + * @blob:	device tree provided by caller

Calling device-tree blob and not fdt is confusing.

Best regards

Heinrich

> + * @addr:	start address of the pmem node
> + * @size:	size of the memory of the pmem node
> + * Return:	0 on success or < 0 on failure
> + */
> +int fdt_fixup_pmem_region(void *blob, ulong addr, u32 size);
> +
>   #endif /* ifndef __FDT_SUPPORT_H */

