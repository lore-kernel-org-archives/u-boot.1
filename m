Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A53D6D227
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 19:13:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62F5C8956D;
	Wed, 27 Nov 2024 20:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="bJKmhwYb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E90489666; Wed, 27 Nov 2024 20:13:39 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B486F8951C
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 20:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732734815; x=1733339615; i=xypron.glpk@gmx.de;
 bh=EQUBnzuB31zyrI+8MWY44afeQBUARaawWxq4AxhcPMQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=bJKmhwYbKP1Fu9Aqsrk4kxSb4y3pgmbm6m298WtWJ5bi2CWVkKX6xV+jiUS313O/
 c3U6UUiQCtcs25Z1rWtcrHRe3DF6X3j+oPfT0QYDP7xuP9QPm6uwLXMSjiBs0m3Qx
 WJnB3E8yGruO9toNwiuexn08w8aoaGDVCgzZwyAPjl+NwDdMOXB9In1d1I+6On5TM
 kTHFA0AJ8P6LP7WusW4/ibDqYTOdHgQj6rUMVFP4fw8MySlCYoP784Mfi8djysbRw
 9ESiYlzPhEgfpVrMUUcAE16ZfLb5GMkLe25/0E4inrQkz2rYhfPvot8d1r/7AqlDZ
 f6IBoFaKMHkuguf41w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHXFr-1tTHeI14k5-005oOG; Wed, 27
 Nov 2024 20:13:35 +0100
Message-ID: <278b7201-fd62-4096-97a6-32b965a46c36@gmx.de>
Date: Wed, 27 Nov 2024 20:13:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 01/12] sandbox: efi_loader: Correct use of addresses as
 pointers
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20241127172247.1488685-1-trini@konsulko.com>
 <20241127172247.1488685-2-trini@konsulko.com>
 <55538d09-dd9f-424e-9600-a7d94172e216@gmx.de>
 <20241127185152.GA3600562@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241127185152.GA3600562@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7H8P7YIopuqUtOMgtmz77dEs1kkxfcVCTU+kSnZfceiXzA7hD93
 ZQCHzAXc//XuzvUtTZbaD2BqnRrtcf/StI8G0zPPHMxiJ9FM3Z3Hi0ZuwjrDgSKTeKQJLyM
 b1pztSFazg77D1dSI9NWctRBmfYXD7ba9PXvbXMtPY+TxWyOdxcuRns00E0j8HQEcu3p4LI
 AUN3+L9zyVLTKIPV0wIZQ==
UI-OutboundReport: notjunk:1;M01:P0:DR/Ri0gupwA=;asrK19WNXNj15UkIP4Fba+n8yl+
 ynP+6sVjw/xHHuoXVX8srEGVLKYsuab7B9v34ndiW6SrPa0vY9nJfzFRQZS/hPWgRBH9PFAlq
 loGtX4T3QN4YWjIj4r/J5fOLhW6+kY/ww9Iq7iJbzbzM9wy0rjfZINUVAtggz8mAHOz43JTBD
 muMmmWiQRGdeWWeqrgrP3RzBg8S7b5OqzDQFiaPqRjYiPkTtV2uwv3E4bzmGUFNV0sv3QQFVK
 8jcz2VumeoCNyDVWS4UbUWNVr/LN3vectjSi89ckflM6iS2ecm4vAo2dd2sMAe8qTzurFIDPR
 jBIPmUrLHyWkFtwe46yKIY+lFVPPE7TA2weBbOx39B36KHBq9+RQ+WocMEiny/XQZuP4GgPEo
 gkab8HxsvV0IOhxdEapHmxU/cnMxGmRWbLb2wntwOoZYMHvxgzPOtd55Fb3bhILUbJt5H0X1k
 LrLqAScgcGgH874LZwzBniPNKokml2s4ARSBUIs1wMPD6VduuliKfvwMwYC6iCJeBIvQQHuYZ
 Kw7sghkoAOjSe0KUOpc827XXZu3zUmDz9JOzutsHvzXOp/DeLlUpGqrteZidn8y04EAlaP69d
 AaSTnolbcEA1P/GmkNEQlokdnz95ZqKqfXyuBaGsfRNE7fD6CDv1NCzrR2MR9g0OpaXkYLvbH
 uqPkRz5iI17hfNDT+9HVIt/PwYOBww+qNfhPuYhcVcsyyGNuRweK6Wghw9I+HYdRpZ+08gWxY
 jxcrKMf4Sy/KX0xQVON5rtELS5g/9F0Fh5UiTK249Pg4AL6JHoP2T2MHBmzYco4CraCeeyLXo
 LgM+4s1yLuN2nousrKq++bXNfLScAbGrxKteMm7WIMO5t5I/CQiNJfvOR3OJUL7G2I6g9bb8B
 jSyaSiG/wwOp/nnmH8yXDl4/2PnV3jkDCuOiaSt1kE6B+gBZnuwtmVVqtU0IKyEUd5LXWChsW
 N5oIwe8EvzCFb0ntRlW0akrdBHyYN1HfwqGcf5q8Syy4YSnPzbDaygTUHtSbPg0gqsb9UZjir
 JYQ++oF+Z2yJLu9/+PS5P0BsOQmlfyzfQSV9NsFG3Pn0q9wMEZPxwgISD8ETArUiMaFNDlaw5
 m8ZD0U0YiTI7iGNt3ckuPhNpPjl6xV
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

On 27.11.24 19:51, Tom Rini wrote:
> On Wed, Nov 27, 2024 at 07:40:05PM +0100, Heinrich Schuchardt wrote:
>> On 27.11.24 18:17, Tom Rini wrote:
>>> From: Simon Glass <sjg@chromium.org>
>>>
>>> The cache-flush function is incorrect which causes a crash in the
>>> remoteproc tests with arm64.
>>>
>>> Fix both problems by using map_sysmem() to convert an address to a
>>> pointer and map_to_sysmem() to convert a pointer to an address.
>>>
>>> Also update the image-loader's cache-flushing logic.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> Fixes: 3286d223fd7 ("sandbox: implement invalidate_icache_all()")
>>> Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>
>>> Changes in v6:
>>> - Re-introduce
>>>
>>> Changes in v2:
>>> - Drop message about EFI_LOADER
>>>
>>>    arch/sandbox/cpu/cache.c              |  8 +++++++-
>>>    drivers/remoteproc/rproc-elf-loader.c | 18 +++++++++++-------
>>>    lib/efi_loader/efi_image_loader.c     |  3 ++-
>>>    3 files changed, 20 insertions(+), 9 deletions(-)
>>> ---
>>>    arch/sandbox/cpu/cache.c              |  8 +++++++-
>>>    drivers/remoteproc/rproc-elf-loader.c | 18 +++++++++++-------
>>>    lib/efi_loader/efi_image_loader.c     |  3 ++-
>>>    3 files changed, 20 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/sandbox/cpu/cache.c b/arch/sandbox/cpu/cache.c
>>> index c8a5e64214b6..96b3da47e8ed 100644
>>> --- a/arch/sandbox/cpu/cache.c
>>> +++ b/arch/sandbox/cpu/cache.c
>>> @@ -4,12 +4,18 @@
>>>     */
>>>
>>>    #include <cpu_func.h>
>>> +#include <mapmem.h>
>>>    #include <asm/state.h>
>>>
>>>    void flush_cache(unsigned long addr, unsigned long size)
>>>    {
>>> +	void *ptr;
>>> +
>>> +	ptr =3D map_sysmem(addr, size);
>>> +
>>>    	/* Clang uses (char *) parameters, GCC (void *) */
>>> -	__builtin___clear_cache((void *)addr, (void *)(addr + size));
>>> +	__builtin___clear_cache(map_sysmem(addr, size), ptr + size);
>>> +	unmap_sysmem(ptr);
>>>    }
>>>
>>>    void invalidate_icache_all(void)
>>> diff --git a/drivers/remoteproc/rproc-elf-loader.c b/drivers/remotepro=
c/rproc-elf-loader.c
>>> index ab1836b3f078..0b3941b7798d 100644
>>> --- a/drivers/remoteproc/rproc-elf-loader.c
>>> +++ b/drivers/remoteproc/rproc-elf-loader.c
>>> @@ -6,6 +6,7 @@
>>>    #include <dm.h>
>>>    #include <elf.h>
>>>    #include <log.h>
>>> +#include <mapmem.h>
>>>    #include <remoteproc.h>
>>>    #include <asm/cache.h>
>>>    #include <dm/device_compat.h>
>>> @@ -180,6 +181,7 @@ int rproc_elf32_load_image(struct udevice *dev, un=
signed long addr, ulong size)
>>>    	for (i =3D 0; i < ehdr->e_phnum; i++, phdr++) {
>>>    		void *dst =3D (void *)(uintptr_t)phdr->p_paddr;
>>>    		void *src =3D (void *)addr + phdr->p_offset;
>>> +		ulong dst_addr;
>>>
>>>    		if (phdr->p_type !=3D PT_LOAD)
>>>    			continue;
>>> @@ -195,10 +197,11 @@ int rproc_elf32_load_image(struct udevice *dev, =
unsigned long addr, ulong size)
>>>    		if (phdr->p_filesz !=3D phdr->p_memsz)
>>>    			memset(dst + phdr->p_filesz, 0x00,
>>>    			       phdr->p_memsz - phdr->p_filesz);
>>> -		flush_cache(rounddown((unsigned long)dst, ARCH_DMA_MINALIGN),
>>> -			    roundup((unsigned long)dst + phdr->p_filesz,
>>> +		dst_addr =3D map_to_sysmem(dst);
>>> +		flush_cache(rounddown(dst_addr, ARCH_DMA_MINALIGN),
>>> +			    roundup(dst_addr + phdr->p_filesz,
>>>    				    ARCH_DMA_MINALIGN) -
>>> -			    rounddown((unsigned long)dst, ARCH_DMA_MINALIGN));
>>> +			    rounddown(dst_addr, ARCH_DMA_MINALIGN));
>>>    	}
>>>
>>>    	return 0;
>>> @@ -377,6 +380,7 @@ int rproc_elf32_load_rsc_table(struct udevice *dev=
, ulong fw_addr,
>>>    	const struct dm_rproc_ops *ops;
>>>    	Elf32_Shdr *shdr;
>>>    	void *src, *dst;
>>> +	ulong dst_addr;
>>>
>>>    	shdr =3D rproc_elf32_find_rsc_table(dev, fw_addr, fw_size);
>>>    	if (!shdr)
>>> @@ -398,10 +402,10 @@ int rproc_elf32_load_rsc_table(struct udevice *d=
ev, ulong fw_addr,
>>>    		(ulong)dst, *rsc_size);
>>>
>>>    	memcpy(dst, src, *rsc_size);
>>> -	flush_cache(rounddown((unsigned long)dst, ARCH_DMA_MINALIGN),
>>> -		    roundup((unsigned long)dst + *rsc_size,
>>> -			    ARCH_DMA_MINALIGN) -
>>> -		    rounddown((unsigned long)dst, ARCH_DMA_MINALIGN));
>>> +	dst_addr =3D map_to_sysmem(dst);
>>> +	flush_cache(rounddown(dst_addr, ARCH_DMA_MINALIGN),
>>> +		    roundup(dst_addr + *rsc_size, ARCH_DMA_MINALIGN) -
>>> +		    rounddown(dst_addr, ARCH_DMA_MINALIGN));
>>>
>>>    	return 0;
>>>    }
>>> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_im=
age_loader.c
>>> index 0ddf69a09183..bb58cf1badb7 100644
>>> --- a/lib/efi_loader/efi_image_loader.c
>>> +++ b/lib/efi_loader/efi_image_loader.c
>>> @@ -13,6 +13,7 @@
>>>    #include <efi_loader.h>
>>>    #include <log.h>
>>>    #include <malloc.h>
>>> +#include <mapmem.h>
>>>    #include <pe.h>
>>>    #include <sort.h>
>>>    #include <crypto/mscode.h>
>>> @@ -977,7 +978,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_o=
bj *handle,
>>>    	}
>>>
>>>    	/* Flush cache */
>>> -	flush_cache((ulong)efi_reloc,
>>> +	flush_cache(map_to_sysmem(efi_reloc),
>>>    		    ALIGN(virt_size, EFI_CACHELINE_SIZE));
>>
>> It would be nice if we could be consistent:
>>
>> include/cpu_func.h:66:
>> void flush_cache(unsigned long addr, unsigned long size);
>>
>> arch/arc/lib/cache.c:773:
>> void flush_cache(unsigned long start, unsigned long size)
>>
>> arch/sandbox/cpu/cache.c:9:
>> void flush_cache(unsigned long addr, unsigned long size)
>>
>> Here sandbox calls __builtin___clear_cache() which needs a pointer.
>>
>> The correct thing would be to change the signature of flush_cache to
>>
>> flush_cache(void *addr, size_t size)
>>
>> in all locations and do away with ulong here.
>>
>> NAK to this patch.
>
> I'm going to refer you back to yourself when Acked-by'ing this:
> https://patchwork.ozlabs.org/project/uboot/patch/20241112141105.640189-2=
-sjg@chromium.org/#3412975
>
> And I'm not even sure that re-working changing this to void* instead is
> a good idea.
>

Looking at
boot/bootm.c:647:       flush_cache(flush_start, ALIGN(load_end,
ARCH_DMA_MINALIGN) - flush_start);

where flush_start is derived the struct image_info field load. Would you
be able to tell if flush_start is a sandbox virtual address or a
pointer? I would not as struct image_info is not documented.

The sandbox implementation assumes that it is a pointer but elsewhere we
use ulong for sandbox virtual addresses (phys_addr_t).

For me this patch starts at the wrong end.

We should first properly describe the parameters of flush_cache(). Then
we can check if the code aligns with this.

Best regards

Heinrich
