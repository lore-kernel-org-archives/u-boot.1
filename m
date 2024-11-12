Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23CFD42B88
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88A6489445;
	Tue, 12 Nov 2024 15:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="DVKRKQRW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FD4D8944F; Tue, 12 Nov 2024 15:28:22 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3943D89440
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:28:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731421698; x=1732026498; i=xypron.glpk@gmx.de;
 bh=1fLMOz6dNDgq+AY7TNozSPh6OxGP5Bdwnqujzu3n8Do=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DVKRKQRWLlaOlS6oOSRyLD9IN9R3FxtI61xfhNzH+UaSqt80wnOxzj1sBejJ+SwL
 M5/1YZl4SAlgOZ42yRojDsqkhsZPrqPdNRwnhNhwVLNy9aKDN6SvfEiIf1v4wiE/Q
 uEbGDW79TwhiEM5gB7mCCobmz6p7Ibwj7qlUgyCDy1A+O8uurV7hKQTK1NyFJB/BC
 vE4aVH9Mygp251dmH2m12/QInmPmauqHHTtuPpvOyLf4FSi32Q4LqZIHqIuIWlFvz
 L4PuXo+/n69HBhtYEk/oa8URqmez0r8b9ECuCgL2GS2evVAdP3n2u4m/ipebmLjHD
 Q0Bwm6A/z52WD9zVLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhlKs-1tfoyw3D1s-00cd8w; Tue, 12
 Nov 2024 15:28:18 +0100
Message-ID: <c18f70de-9fc4-4a35-be17-bd3144664c1b@gmx.de>
Date: Tue, 12 Nov 2024 15:28:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] sandbox: efi_loader: Correct use of addresses as
 pointers
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20241112141105.640189-1-sjg@chromium.org>
 <20241112141105.640189-2-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241112141105.640189-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ai0Y1awu+zvOZR9yRc6x7is9DHCd02Ziq+EHNJME0Phk4HFpvLN
 dis193No1bZRv5mwSBmdW4lZibDch/Il+tGobTbd8n8Etd91waPlincroKNuYQrAKLfwREO
 LVOEAbm2Ff3GpyDbixox0Mffxm3blxVG8ED2KAztL5kXpbC4QH3wV/WF35d83tLyEF6ozx5
 CRI1Nq/2711ph256lb/PA==
UI-OutboundReport: notjunk:1;M01:P0:ib78Tkt5rvs=;7yD1cPt3c2wWNz8y9vj5cF+lke9
 75pt+x1R8as5nunBuGir/v8nBNKr6dMOIWLI3xmAPEh3b01geg1aA6tp3oI5SixlWMuI4O0Q7
 aiOxfcE1RCDquuIWiJV8mJ0zbQ8GGzjYGafMFKa6O9PJY2z4X+Oh2Hr1EInhYM0kG8pMlXcPE
 JcZwoySiiXG6qfxzzD1cwwN6VEvlegobi+Zmm7UKHc0unkA0PYNXCFTfZo21WHggx2LK+7Yqn
 +jPnotrDWb5QutGJeke/4/d85EP0/Kftywu6DUSaw+1DesGn9UXGClIVadx76Sm4S4YwE4spz
 rBlPrFzQLhGogSox9IJYwIYj2JWqsUH0NPJJ+q+8OlRqX0onHbWEwKZgP6HohhOuNOJxQY/Za
 hgXSs3SnKSfTAu6IIsUFTIVzw48Wpkl/HlZ0NDEm0EzzgzZLWwSLzv5hoFOj2gcofCo6pll7k
 KfVvfJ0ZQMcCNXPJQi6MRX/6GwnPfZLBN2tpxuNy4ZpWuURNnE5Uh+RSodS7fRB87ct/Q9/Xc
 LoOJK93SUDhvLPkzMpGVaQNpBHQVgRe5JICII+xdNiuToGzNKCwJ00OxZBCNp0T0BhXYWowwl
 ZPkD0oqEQy6rtQ+uodfu1jBLjVDQt7QHwbrR48EU430M+HpvONFomJn5D0HkCktQ1J3AmJI6q
 c6N+K0vHZ9po1pxrG2kwlXtq1l5NbQJVpor52po9QMq9CwvkCjKrKI+W2KeBbTIazmTI9urlZ
 leaU1ZxwFEcwVwDg8WtY0udDFyIPjMcfM5Ek7eMQ2IQgiyZnqrjlmGnDmkDP0KhJd7Hqcx2po
 eWa207Es33boYAmxgpTyRY+PSqcao6TA1lAOCYsw2M6qVftbiktu9QnRvsgDIIszmwOT3j8+y
 VJcMVWbBk7Dp1xQ==
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

On 12.11.24 15:10, Simon Glass wrote:
> The cache-flush function is incorrect which causes a crash in the
> remoteproc tests with arm64.

We should throw out all these sandbox virtual addresses where they are
not needed.

Just add the missing conversion to drivers/remoteproc/rproc-elf-loader.c.

And change flush_cache() on all architectures to use void *.

Best regards

Heinrich

>
> Fix both problems by using map_sysmem() to convert an address to a
> pointer and map_to_sysmem() to convert a pointer to an address.
>
> Also update the image-loader's cache-flushing logic.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: 3286d223fd7 ("sandbox: implement invalidate_icache_all()")
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Drop message about EFI_LOADER
>
>   arch/sandbox/cpu/cache.c              |  8 +++++++-
>   drivers/remoteproc/rproc-elf-loader.c | 18 +++++++++++-------
>   lib/efi_loader/efi_image_loader.c     |  3 ++-
>   3 files changed, 20 insertions(+), 9 deletions(-)
>
> diff --git a/arch/sandbox/cpu/cache.c b/arch/sandbox/cpu/cache.c
> index c8a5e64214b..96b3da47e8e 100644
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
> index ab1836b3f07..0b3941b7798 100644
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
> index 0ddf69a0918..bb58cf1badb 100644
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
>
>   	/*

