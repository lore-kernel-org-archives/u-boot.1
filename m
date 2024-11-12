Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70F6D42B8C
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF9468910B;
	Tue, 12 Nov 2024 15:46:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="DfsS2Ahu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AEF589427; Tue, 12 Nov 2024 15:46:23 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43B7088F8E
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:46:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731422779; x=1732027579; i=xypron.glpk@gmx.de;
 bh=u6CDJkX0GlhJv8TeXU0uUmj+Eterkkwz/X5syv5QqvA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=DfsS2AhuyF7FCtD4hnYWxKt/bP8rI//gn8tUjE3MIYDuusa2YrI9xtwGaDOfrZXf
 w92UKx5mijMgB+VKI7q1v5Iph/pou5nWEgkAUuG4KjKa2AKeDk2oYqZRzdA1wGDS1
 /Ymi+EcQ1lX1fP2OwQRXtkMPddq9WWSHMfXFD9e32J/JQl3u3kYk4ShDhmmxnlQ/r
 QB4Uxf0bi36Jt4ezjq+j0/ccFS2FJ+1de2HuGHdtFhYXY/2L+ORNJNZso1V+zOzSj
 mV0KZe9hr1AakOv7mo3wijqs5mjbzNwinU7oCDdmOl18X/rXx899j8WskecCC1ip7
 n5WFt9txYzcJysHJYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MacOW-1tlqbJ3b4M-00nhHK; Tue, 12
 Nov 2024 15:46:19 +0100
Message-ID: <ce9883e8-4187-4365-af6c-8d1c883d0b6c@gmx.de>
Date: Tue, 12 Nov 2024 15:46:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] sandbox: efi_loader: Correct use of addresses as
 pointers
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20241112141105.640189-1-sjg@chromium.org>
 <20241112141105.640189-2-sjg@chromium.org>
 <c18f70de-9fc4-4a35-be17-bd3144664c1b@gmx.de>
Content-Language: en-US
In-Reply-To: <c18f70de-9fc4-4a35-be17-bd3144664c1b@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hI9aT63J9w5BgYAv6PJykSCRGAaNGTLFhNtPpsFNCRHdeCPlpYe
 L7epd6wxZTG+TEnnwaQQqKQUMoAEd0WMrKrAc2eQ6lWDaufgfNzr1ZhT1lgal8mhhTlygEq
 ujGeRnbB3/qp6O6ylJ3ZpRmmSogItV43HG+4cfFgWZ8qGJbpJc2Y+9BXj2PFzkvGhkZBgzO
 agfJbcHXpttdq9COKcmbw==
UI-OutboundReport: notjunk:1;M01:P0:fYjOBFgSlpE=;vr9xmWEZZP+om7mNlNyV5n5UFf2
 BEXihzjrckR+QemUXSxPs8D4Rj3pOTeXC8h0kmVj2RSXRPfZTC7vJnZ6s3JNR6iB88vmXKtAd
 5jcVn+2Dk+S1cnotxBGIQG/jRDUl82FLtAENENbPEIjjcERhLGgp66TGBiBY2qI7Wa6cQRK6f
 o5FgPkfghvL4HskaCP1tE430icWrbB9jrIjz7VESj6IOLgrhqyrezq+6y+Bu7IoIW5oY0FMR2
 uCf3HGjQCJTNdNBVr7JWS7jNc27rG8wYwSLpwU9R7mCNP0v5yPts8lnW1nlYMXXjDRq7HRftc
 poa3OcZQA73PnGFVYsUnXYfkyUzz7DB/qXxwgP2ruQ98D+rVTc3F3cQfptT227PAJXFO70RPc
 p5NqTeZ5vn6ovV6hIfZMhimbXudrYt4rMz+kL7gnqDy6lM4aE5sQJe4lTAUfclPUIAtOcfd4w
 ckHn8dUgnsmdePfGh/HJQToUE5RtTeEjKsxDQcbGKQn3NdylW4FhhvDGER5+cW198gYKmc2aG
 a3jREXA8YO5dHfT29VBlATfqYjPcIZ2z64bO/BKjiesHN1fGc+j7+Hnpl/hLIYTHrdFakj/AC
 cNVPw2fFFA0XGzu2xixIn+hLm3d6fN8ZeGzTWqHbV37leEV4sctPOfYce/W/1oEbq3iMMqYWS
 Z3eYjPqc1TSmX74kyCvyrpcY+uHyqBYW8eGzgxgjLgfjO+5ZIEfIRlQmDlu334v+2STnAEzoQ
 wC3R44edzgNZy6xWv6SeAjBrpwT2jbF7mw8Vzbj/70FTRHktk3rn8yej6xZCvjv0bQFDVvXiA
 /J2g7pMe7gMboLvulUp/0QCpoSqbNtZmY9y1RdIZRLcPRpXnEKdUm0kuNcPoGroga2tCFkKr2
 cywXJC7pz/UIrX2bDDRhkfB3aV2X6nVxrc/xNvttYRRfiMUUnzHVOm/+K
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

On 12.11.24 15:28, Heinrich Schuchardt wrote:
> On 12.11.24 15:10, Simon Glass wrote:
>> The cache-flush function is incorrect which causes a crash in the
>> remoteproc tests with arm64.
>
> We should throw out all these sandbox virtual addresses where they are
> not needed.
>
> Just add the missing conversion to drivers/remoteproc/rproc-elf-loader.c=
.
>
> And change flush_cache() on all architectures to use void *.
>
> Best regards
>
> Heinrich

There are a number of places where the flush_cache invocation currently
assumes that sandbox virtual addresses are used.

We will have to wait until the complete separation of CLI from the rest
of U-Boot to clean this up.

Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>
>>
>> Fix both problems by using map_sysmem() to convert an address to a
>> pointer and map_to_sysmem() to convert a pointer to an address.
>>
>> Also update the image-loader's cache-flushing logic.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> Fixes: 3286d223fd7 ("sandbox: implement invalidate_icache_all()")
>> ---
>>
>> (no changes since v2)
>>
>> Changes in v2:
>> - Drop message about EFI_LOADER
>>
>> =C2=A0 arch/sandbox/cpu/cache.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 +++++++-
>> =C2=A0 drivers/remoteproc/rproc-elf-loader.c | 18 +++++++++++-------
>> =C2=A0 lib/efi_loader/efi_image_loader.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 3 ++-
>> =C2=A0 3 files changed, 20 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/sandbox/cpu/cache.c b/arch/sandbox/cpu/cache.c
>> index c8a5e64214b..96b3da47e8e 100644
>> --- a/arch/sandbox/cpu/cache.c
>> +++ b/arch/sandbox/cpu/cache.c
>> @@ -4,12 +4,18 @@
>> =C2=A0=C2=A0 */
>>
>> =C2=A0 #include <cpu_func.h>
>> +#include <mapmem.h>
>> =C2=A0 #include <asm/state.h>
>>
>> =C2=A0 void flush_cache(unsigned long addr, unsigned long size)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 void *ptr;
>> +
>> +=C2=A0=C2=A0=C2=A0 ptr =3D map_sysmem(addr, size);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Clang uses (char *) parameters, GCC (=
void *) */
>> -=C2=A0=C2=A0=C2=A0 __builtin___clear_cache((void *)addr, (void *)(addr=
 + size));
>> +=C2=A0=C2=A0=C2=A0 __builtin___clear_cache(map_sysmem(addr, size), ptr=
 + size);
>> +=C2=A0=C2=A0=C2=A0 unmap_sysmem(ptr);
>> =C2=A0 }
>>
>> =C2=A0 void invalidate_icache_all(void)
>> diff --git a/drivers/remoteproc/rproc-elf-loader.c b/drivers/
>> remoteproc/rproc-elf-loader.c
>> index ab1836b3f07..0b3941b7798 100644
>> --- a/drivers/remoteproc/rproc-elf-loader.c
>> +++ b/drivers/remoteproc/rproc-elf-loader.c
>> @@ -6,6 +6,7 @@
>> =C2=A0 #include <dm.h>
>> =C2=A0 #include <elf.h>
>> =C2=A0 #include <log.h>
>> +#include <mapmem.h>
>> =C2=A0 #include <remoteproc.h>
>> =C2=A0 #include <asm/cache.h>
>> =C2=A0 #include <dm/device_compat.h>
>> @@ -180,6 +181,7 @@ int rproc_elf32_load_image(struct udevice *dev,
>> unsigned long addr, ulong size)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ehdr->e_phnum; i++, ph=
dr++) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *dst =3D (v=
oid *)(uintptr_t)phdr->p_paddr;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *src =3D (v=
oid *)addr + phdr->p_offset;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ulong dst_addr;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (phdr->p_type=
 !=3D PT_LOAD)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 continue;
>> @@ -195,10 +197,11 @@ int rproc_elf32_load_image(struct udevice *dev,
>> unsigned long addr, ulong size)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (phdr->p_file=
sz !=3D phdr->p_memsz)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 memset(dst + phdr->p_filesz, 0x00,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phdr->p_memsz - phdr->=
p_filesz);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flush_cache(rounddown((unsi=
gned long)dst, ARCH_DMA_MINALIGN),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 roundup((unsigned long)dst + phdr->p_filesz,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dst_addr =3D map_to_sysmem(=
dst);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flush_cache(rounddown(dst_a=
ddr, ARCH_DMA_MINALIGN),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 roundup(dst_addr + phdr->p_filesz,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARCH_DMA_MINALIG=
N) -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 rounddown((unsigned long)dst, ARCH_DMA_MINALIGN));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 rounddown(dst_addr, ARCH_DMA_MINALIGN));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> @@ -377,6 +380,7 @@ int rproc_elf32_load_rsc_table(struct udevice
>> *dev, ulong fw_addr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct dm_rproc_ops *ops;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Elf32_Shdr *shdr;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *src, *dst;
>> +=C2=A0=C2=A0=C2=A0 ulong dst_addr;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shdr =3D rproc_elf32_find_rsc_table(dev,=
 fw_addr, fw_size);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!shdr)
>> @@ -398,10 +402,10 @@ int rproc_elf32_load_rsc_table(struct udevice
>> *dev, ulong fw_addr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (ulong)dst, *rsc=
_size);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(dst, src, *rsc_size);
>> -=C2=A0=C2=A0=C2=A0 flush_cache(rounddown((unsigned long)dst, ARCH_DMA_=
MINALIGN),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rou=
ndup((unsigned long)dst + *rsc_size,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ARCH_DMA_MINALIGN) -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rou=
nddown((unsigned long)dst, ARCH_DMA_MINALIGN));
>> +=C2=A0=C2=A0=C2=A0 dst_addr =3D map_to_sysmem(dst);
>> +=C2=A0=C2=A0=C2=A0 flush_cache(rounddown(dst_addr, ARCH_DMA_MINALIGN),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rou=
ndup(dst_addr + *rsc_size, ARCH_DMA_MINALIGN) -
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rou=
nddown(dst_addr, ARCH_DMA_MINALIGN));
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/
>> efi_image_loader.c
>> index 0ddf69a0918..bb58cf1badb 100644
>> --- a/lib/efi_loader/efi_image_loader.c
>> +++ b/lib/efi_loader/efi_image_loader.c
>> @@ -13,6 +13,7 @@
>> =C2=A0 #include <efi_loader.h>
>> =C2=A0 #include <log.h>
>> =C2=A0 #include <malloc.h>
>> +#include <mapmem.h>
>> =C2=A0 #include <pe.h>
>> =C2=A0 #include <sort.h>
>> =C2=A0 #include <crypto/mscode.h>
>> @@ -977,7 +978,7 @@ efi_status_t efi_load_pe(struct
>> efi_loaded_image_obj *handle,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Flush cache */
>> -=C2=A0=C2=A0=C2=A0 flush_cache((ulong)efi_reloc,
>> +=C2=A0=C2=A0=C2=A0 flush_cache(map_to_sysmem(efi_reloc),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ALIGN(virt_size, EFI_CACHELINE_SIZE));
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>

