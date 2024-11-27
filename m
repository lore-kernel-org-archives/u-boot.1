Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6202AD6ACFC
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 18:40:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A42EC895BD;
	Wed, 27 Nov 2024 19:40:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gtbzi7pI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74B6A897EF; Wed, 27 Nov 2024 19:40:09 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D1028958D
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 19:40:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732732805; x=1733337605; i=xypron.glpk@gmx.de;
 bh=7gJDFFcXUdnZN8zEqflZ7Yfyfwkaif+rEyYaaVE5lxs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gtbzi7pIoE1rPQZfK8iuzmudHxHQ8FdQ5gezsouShzF8OTSioeENVYKwsaKDPM0a
 Nd3RgZxsVDQ6KLbOX1oaQ62CDrqOiMIGY+bqF08a+6W3qtCyHDc6Vs5tzausJ3Qun
 5A5QFzRuFfui501+joKhLDvYlpD/ctU1zcyVme+eUesi0hK0K3sLwl/xyGf+9hN5T
 Vgjok4K4ryJegd3ryYemwXm40pt6izpVX+ynLjZF1ovEbWzbSD5J7+/1VW5LrUuV1
 5+UWqxHzFV5WxIWjZsmY+uIiKofSiuzLqJWFXnp80CdCXagFaf6W0BVyMbFfJUgZf
 2TYD5Q/OPtbE/g7CQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSc1L-1t9Opg27I1-00LInq; Wed, 27
 Nov 2024 19:40:05 +0100
Message-ID: <55538d09-dd9f-424e-9600-a7d94172e216@gmx.de>
Date: Wed, 27 Nov 2024 19:40:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 01/12] sandbox: efi_loader: Correct use of addresses as
 pointers
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20241127172247.1488685-1-trini@konsulko.com>
 <20241127172247.1488685-2-trini@konsulko.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241127172247.1488685-2-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:814q5saz/mTOfj+y3TWppvzgrKyNTCgM/Asv8bYS6z1v5WPl3Ej
 R5cEi26sPqM05T7pldDu/rP6elJGS5JkvO4miu3hPDH/itie5OKUasxVJR3UiPiK6C7/8ya
 MuKIuwwL9kTRU6Lz35ltRah4bpGY4icAA8+3i5s0WymPC6V/cu5iwmcg00i+jwkDQnMC+MY
 XTayPHrJfsXoEh+yHKlWw==
UI-OutboundReport: notjunk:1;M01:P0:QlHaDHSLHs0=;HdzyyqpqVYJ1y4kx6iMAS9/BVSi
 Du78M96/NUiSvX0rBEIrmR4vFGStKIp/+Va+RZe6K8B9DQ6LzaqwMre9vzqv3Z8pPlKupg64m
 dw0eYY4FLVvMK/ZDw+0IMEUqw6UhPk6GB7OX03ZaFdQhXv2ZDUdwZtaTDo3nwES3RCWI2HWkj
 cJ5b45rClLwtOytWBhuufuJk9WnnWkrcRWel6HBT5OXiyP+cAUVpeI5maNBzbEgC0b9r/5sI2
 QZlMiFLKLkHpZ0OIMi18fDLt4iX5u/+YZPGRZ57Gw1AKBIxoC1KOZcn3yVD2IFhDLaMvoorsK
 ealw1wTXgjAts1T0kwbgTc3M7ctsLHIue0rysliecAXnbHKutqI4cIIw0NoNHGFxRHba1qnLf
 QhbfATtoX20ODBJRSS6lrljveCtcnJ9bn635hRSzzizZPdErgb51QXByYyxd2qrdi7h6j2c9r
 giQ58buMAsVdiRZ6x0RBhAPjf6I3SP7/QXvzngMAR9NWjhP4P6InfXHpc0aVK7lOBoNtQxwD/
 boz9FbKaPQt5CIotSBVLJJjd8yEa3J6f8jUb1YKo9ofvhLL5KdWf68S3XYSSmbZVsQNVZ+f/O
 E1OZoeCOiyLMK2rJQvl/D+avXNcO1SN2J0HdD5eEBwdStiast+QmC2jLhAU6rildIg/WFGCcP
 dxy0YDamsOKX7I++ogfRN+QsfLj07QBrEStdD8mssj1ZAwYKQwsRaFMNAjebgTirCbXMAUXG5
 bhxHTlkw4CeXcY+IO/SVTfwqCnVskEVA9fUBQz4dC5BNkVEb/rA331hylngfJZ3S+Ty+He71W
 tBwg35VU9qSc5l+9YWecL7ozTurqKD8o7Hc+WfHdYXFGCzFVA1LEY9CqJGV58UNeKxgpjSqFf
 U+REYzjxx+mrorXFHM6S4HuTIkHxVDKU1rMccIIVPpkDQBh4G8lotrjL9J9VweVCfl716EoYl
 BVqhNwDdT/3bpJyX50Msh+sbZIgUg3bwSLSR+f9JZ4bGzgtp2j6gKfzxDD16sWZOcPZ0cdSo2
 N1q+sq5HDb/zRuxTGX5gV38MjARxzT03dMk1uYH191oOZBcw5PR1365WLFLh4oD6+/6MmKhGB
 oxJz7DTd+Uc9j8Xa02egfKL6w9VUr1
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

On 27.11.24 18:17, Tom Rini wrote:
> From: Simon Glass <sjg@chromium.org>
>
> The cache-flush function is incorrect which causes a crash in the
> remoteproc tests with arm64.
>
> Fix both problems by using map_sysmem() to convert an address to a
> pointer and map_to_sysmem() to convert a pointer to an address.
>
> Also update the image-loader's cache-flushing logic.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: 3286d223fd7 ("sandbox: implement invalidate_icache_all()")
> Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> Changes in v6:
> - Re-introduce
>
> Changes in v2:
> - Drop message about EFI_LOADER
>
>   arch/sandbox/cpu/cache.c              |  8 +++++++-
>   drivers/remoteproc/rproc-elf-loader.c | 18 +++++++++++-------
>   lib/efi_loader/efi_image_loader.c     |  3 ++-
>   3 files changed, 20 insertions(+), 9 deletions(-)
> ---
>   arch/sandbox/cpu/cache.c              |  8 +++++++-
>   drivers/remoteproc/rproc-elf-loader.c | 18 +++++++++++-------
>   lib/efi_loader/efi_image_loader.c     |  3 ++-
>   3 files changed, 20 insertions(+), 9 deletions(-)
>
> diff --git a/arch/sandbox/cpu/cache.c b/arch/sandbox/cpu/cache.c
> index c8a5e64214b6..96b3da47e8ed 100644
> --- a/arch/sandbox/cpu/cache.c
> +++ b/arch/sandbox/cpu/cache.c
> @@ -4,12 +4,18 @@
>    */
>
>   #include <cpu_func.h>
> +#include <mapmem.h>
>   #include <asm/state.h>
>
>   void flush_cache(unsigned long addr, unsigned long size)
>   {
> +	void *ptr;
> +
> +	ptr =3D map_sysmem(addr, size);
> +
>   	/* Clang uses (char *) parameters, GCC (void *) */
> -	__builtin___clear_cache((void *)addr, (void *)(addr + size));
> +	__builtin___clear_cache(map_sysmem(addr, size), ptr + size);
> +	unmap_sysmem(ptr);
>   }
>
>   void invalidate_icache_all(void)
> diff --git a/drivers/remoteproc/rproc-elf-loader.c b/drivers/remoteproc/=
rproc-elf-loader.c
> index ab1836b3f078..0b3941b7798d 100644
> --- a/drivers/remoteproc/rproc-elf-loader.c
> +++ b/drivers/remoteproc/rproc-elf-loader.c
> @@ -6,6 +6,7 @@
>   #include <dm.h>
>   #include <elf.h>
>   #include <log.h>
> +#include <mapmem.h>
>   #include <remoteproc.h>
>   #include <asm/cache.h>
>   #include <dm/device_compat.h>
> @@ -180,6 +181,7 @@ int rproc_elf32_load_image(struct udevice *dev, unsi=
gned long addr, ulong size)
>   	for (i =3D 0; i < ehdr->e_phnum; i++, phdr++) {
>   		void *dst =3D (void *)(uintptr_t)phdr->p_paddr;
>   		void *src =3D (void *)addr + phdr->p_offset;
> +		ulong dst_addr;
>
>   		if (phdr->p_type !=3D PT_LOAD)
>   			continue;
> @@ -195,10 +197,11 @@ int rproc_elf32_load_image(struct udevice *dev, un=
signed long addr, ulong size)
>   		if (phdr->p_filesz !=3D phdr->p_memsz)
>   			memset(dst + phdr->p_filesz, 0x00,
>   			       phdr->p_memsz - phdr->p_filesz);
> -		flush_cache(rounddown((unsigned long)dst, ARCH_DMA_MINALIGN),
> -			    roundup((unsigned long)dst + phdr->p_filesz,
> +		dst_addr =3D map_to_sysmem(dst);
> +		flush_cache(rounddown(dst_addr, ARCH_DMA_MINALIGN),
> +			    roundup(dst_addr + phdr->p_filesz,
>   				    ARCH_DMA_MINALIGN) -
> -			    rounddown((unsigned long)dst, ARCH_DMA_MINALIGN));
> +			    rounddown(dst_addr, ARCH_DMA_MINALIGN));
>   	}
>
>   	return 0;
> @@ -377,6 +380,7 @@ int rproc_elf32_load_rsc_table(struct udevice *dev, =
ulong fw_addr,
>   	const struct dm_rproc_ops *ops;
>   	Elf32_Shdr *shdr;
>   	void *src, *dst;
> +	ulong dst_addr;
>
>   	shdr =3D rproc_elf32_find_rsc_table(dev, fw_addr, fw_size);
>   	if (!shdr)
> @@ -398,10 +402,10 @@ int rproc_elf32_load_rsc_table(struct udevice *dev=
, ulong fw_addr,
>   		(ulong)dst, *rsc_size);
>
>   	memcpy(dst, src, *rsc_size);
> -	flush_cache(rounddown((unsigned long)dst, ARCH_DMA_MINALIGN),
> -		    roundup((unsigned long)dst + *rsc_size,
> -			    ARCH_DMA_MINALIGN) -
> -		    rounddown((unsigned long)dst, ARCH_DMA_MINALIGN));
> +	dst_addr =3D map_to_sysmem(dst);
> +	flush_cache(rounddown(dst_addr, ARCH_DMA_MINALIGN),
> +		    roundup(dst_addr + *rsc_size, ARCH_DMA_MINALIGN) -
> +		    rounddown(dst_addr, ARCH_DMA_MINALIGN));
>
>   	return 0;
>   }
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_imag=
e_loader.c
> index 0ddf69a09183..bb58cf1badb7 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -13,6 +13,7 @@
>   #include <efi_loader.h>
>   #include <log.h>
>   #include <malloc.h>
> +#include <mapmem.h>
>   #include <pe.h>
>   #include <sort.h>
>   #include <crypto/mscode.h>
> @@ -977,7 +978,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj=
 *handle,
>   	}
>
>   	/* Flush cache */
> -	flush_cache((ulong)efi_reloc,
> +	flush_cache(map_to_sysmem(efi_reloc),
>   		    ALIGN(virt_size, EFI_CACHELINE_SIZE));

It would be nice if we could be consistent:

include/cpu_func.h:66:
void flush_cache(unsigned long addr, unsigned long size);

arch/arc/lib/cache.c:773:
void flush_cache(unsigned long start, unsigned long size)

arch/sandbox/cpu/cache.c:9:
void flush_cache(unsigned long addr, unsigned long size)

Here sandbox calls __builtin___clear_cache() which needs a pointer.

The correct thing would be to change the signature of flush_cache to

flush_cache(void *addr, size_t size)

in all locations and do away with ulong here.

NAK to this patch.

Best regards

Heinrich

>
>   	/*

