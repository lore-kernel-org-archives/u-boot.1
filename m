Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6FDC021A1
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 15:05:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4626088906;
	Sat, 14 Sep 2024 17:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="VisaWBaC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E40D889E2; Sat, 14 Sep 2024 17:05:06 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C52488881
 for <u-boot@lists.denx.de>; Sat, 14 Sep 2024 17:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1726326299; x=1726931099; i=xypron.glpk@gmx.de;
 bh=JqQu+2s5bxAM3dp0KY5QYxN2seZQBGcvaLfAIGwZB9c=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=VisaWBaCvDpkAGbyRyx4LZ6a8H/ZX52zm1fgAQyO27jMCkIZfZ7CbLoquL1RMALC
 zaTWoXcRuqVBLAYpQzIzzTeSRLuUJV3mkwO157QJUpWtz55g2/bgLNsiNOZhWH+Wr
 KV6l+OQdaaKNRTAUZXZSu79QLq9xihjlOu6Go6YZYRVskUCPsmSx1Cx2tKdLwdZZo
 qiVdqYL5/Zgh9m0Abs4h4VdFyGdRi+NpifCZtJ8YH3eszdiAxV6hEhzotFx3g8L+k
 XtNBg0FoWS18k9an5Y2xGEOXT03Q5ZWxiy0k1AqMYEcCaDYj98PzTwieDGhRR0UCr
 tjIzbP1d3drShEc9/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJE6L-1saRNo2cyx-00WjnT; Sat, 14
 Sep 2024 17:04:59 +0200
Message-ID: <78cbfbf1-91b9-49ad-9b14-962183ee52be@gmx.de>
Date: Sat, 14 Sep 2024 17:04:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] efi: memory: use the lmb API's for allocating and
 freeing memory
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-4-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240905082811.1585467-4-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lrbty/d/bUjPKFPheCLoNxhvyyn3YDSHaIPsJ2/Xdy6FxPZj6/L
 H2LBkOWtaH/ys9ptyNWPvBH6qUHbD6LkVinq1yOMfi6DNsICyGzvMTVzTmvqGR09/o4KCDB
 gzGpvfzcTrbIWNUEbLT57hlcSwKQHmv2aU4GJ6+s6S0wfZCkOCqTVG+O25QZHSziPhn47Jx
 O1+cBWFssYIw2ZmqhZT3g==
UI-OutboundReport: notjunk:1;M01:P0:nihPe3DI6Xc=;icvcVY/Nsh4n49DPZiQxeV5Symd
 1tgXaglXgNe0btwJLj5tlazkCbCMXbhXfZ9n5GtqwBIfWLtX97B9cjcn01qjbshBqq/rAeVby
 dpBr91Op3xGDx52gkFXMjZvrlwT1GV3dQwnNKat1TUpCHXtd3qPijjGpXVjQFN+zFMjm1Cwx9
 JvpD0vP9v7GkmV0Lyj+2PUd1GSVLfex7j5y/PlfjY8eqeyeOuxkFl5KIkZrZOuoh+tBXbBbnb
 D6ffCR/SiUXu4ei13v5gwcWO6qN/43vLBcPkpRxdfKT2CBVtFcRfZSOlHIY5P/BRg8C7GrFSC
 HDaTYX31g8MTTAbahP66h8gF3/4m6sm3L2f7ncDTek8lBNgvCEBtcOF5aNUzozdPnOd6kWjKI
 pMLo+tvGLFkVuNCF0X6WnuaLjQmEBNx9kau0gtKXKLyWggOGDjXFDsfs34IN+/YcH3t5SJ85i
 MuhYYm1v+E71kFKTr7YQdAOcEBD5jp+6TfY7QNcnwcE9SqX85+0XkmPB/a9C6AEdKsax0nzEK
 lWdt3d6PpEluR5XFan92nX+2jmVwowVN5KN3kKfCgsdrsNQScn5VQyW/vI23kFsD+a3CIoFK9
 sTjDV1W3tNGyTQa8KW2dr4mBl14NYzeokbw7uWEUQM3ZP57+PGJr1ywQ+cQQVB3v3IHPLgy/t
 HxjHxUZaPEHgILOMT79vimhOXgDHhGoiiQAMSE2qrTcJjx4DhOSAoycgz12sN3rjiPWI4ZlHx
 2jkJOowNpPbP/wmRBg2+fmpZJyZwZUz+5S6NCEz89X7Rvcel9bKTz1azC34CtDI7Dtj/ygDjv
 qRQNF9P3QtJwurc/p/PqMLZg==
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

On 9/5/24 10:27, Sughosh Ganu wrote:
> Use the LMB API's for allocating and freeing up memory. With this, the
> LMB module becomes the common backend for managing non U-Boot image
> memory that might be requested by other modules.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   lib/efi_loader/Kconfig      |  1 +
>   lib/efi_loader/efi_memory.c | 74 ++++++++++---------------------------
>   2 files changed, 21 insertions(+), 54 deletions(-)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 6ffefa9103..911d4c6bbe 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -18,6 +18,7 @@ config EFI_LOADER
>   	select DM_EVENT
>   	select EVENT_DYNAMIC
>   	select LIB_UUID
> +	select LMB
>   	imply PARTITION_UUIDS
>   	select REGEX
>   	imply FAT
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index c6f1dd0945..90e07ed6a2 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -9,6 +9,7 @@
>
>   #include <efi_loader.h>
>   #include <init.h>
> +#include <lmb.h>
>   #include <log.h>
>   #include <malloc.h>
>   #include <mapmem.h>
> @@ -432,53 +433,6 @@ static efi_status_t efi_check_allocated(u64 addr, b=
ool must_be_allocated)
>   	return EFI_NOT_FOUND;
>   }
>
> -/**
> - * efi_find_free_memory() - find free memory pages
> - *
> - * @len:	size of memory area needed
> - * @max_addr:	highest address to allocate
> - * Return:	pointer to free memory area or 0
> - */
> -static uint64_t efi_find_free_memory(uint64_t len, uint64_t max_addr)
> -{
> -	struct efi_mem_list *lmem;
> -
> -	/*
> -	 * Prealign input max address, so we simplify our matching
> -	 * logic below and can just reuse it as return pointer.
> -	 */
> -	max_addr &=3D ~EFI_PAGE_MASK;
> -
> -	list_for_each_entry(lmem, &efi_mem, link) {
> -		struct efi_mem_desc *desc =3D &lmem->desc;
> -		uint64_t desc_len =3D desc->num_pages << EFI_PAGE_SHIFT;
> -		uint64_t desc_end =3D desc->physical_start + desc_len;
> -		uint64_t curmax =3D min(max_addr, desc_end);
> -		uint64_t ret =3D curmax - len;
> -
> -		/* We only take memory from free RAM */
> -		if (desc->type !=3D EFI_CONVENTIONAL_MEMORY)
> -			continue;
> -
> -		/* Out of bounds for max_addr */
> -		if ((ret + len) > max_addr)
> -			continue;
> -
> -		/* Out of bounds for upper map limit */
> -		if ((ret + len) > desc_end)
> -			continue;
> -
> -		/* Out of bounds for lower map limit */
> -		if (ret < desc->physical_start)
> -			continue;
> -
> -		/* Return the highest address in this map within bounds */
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
>   /**
>    * efi_allocate_pages - allocate memory pages
>    *
> @@ -493,6 +447,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_ty=
pe type,
>   				efi_uintn_t pages, uint64_t *memory)
>   {
>   	u64 len;
> +	uint flags;
>   	efi_status_t ret;
>   	uint64_t addr;
>
> @@ -508,33 +463,35 @@ efi_status_t efi_allocate_pages(enum efi_allocate_=
type type,
>   	    (len >> EFI_PAGE_SHIFT) !=3D (u64)pages)
>   		return EFI_OUT_OF_RESOURCES;
>
> +	flags =3D LMB_NOOVERWRITE | LMB_NONOTIFY;

In the EFI context we should use LMB notification to notify the
EFI_EVENT_GROUP_MEMORY_MAP_CHANGE event and update the memory map.

See chapter 7.1.2 EFI_BOOT_SERVICES.CreateEventEx() in the UEFI
specification.

>   	switch (type) {
>   	case EFI_ALLOCATE_ANY_PAGES:
>   		/* Any page */
> -		addr =3D efi_find_free_memory(len, -1ULL);
> +		addr =3D (u64)lmb_alloc_flags(len, EFI_PAGE_SIZE, flags);

On ARM64 we must ensure that "all 4KiB pages in the 64KiB page ... use
identical ARM Memory Page Attributes". I cannot see how LMB implements thi=
s.

See chapter 2.3.6 AArch64 Platforms in the UEFI specification.

If you pass the EFI memory type to LMB and store it there, we can avoid
duplication of the memory map and we can implement the 64 KiB pages
logic in LMB.

Best regards

Heinrich

>   		if (!addr)
>   			return EFI_OUT_OF_RESOURCES;
>   		break;
>   	case EFI_ALLOCATE_MAX_ADDRESS:
>   		/* Max address */
> -		addr =3D efi_find_free_memory(len, *memory);
> +		addr =3D (u64)lmb_alloc_base_flags(len, EFI_PAGE_SIZE, *memory,
> +						 flags);
>   		if (!addr)
>   			return EFI_OUT_OF_RESOURCES;
>   		break;
>   	case EFI_ALLOCATE_ADDRESS:
>   		if (*memory & EFI_PAGE_MASK)
>   			return EFI_NOT_FOUND;
> -		/* Exact address, reserve it. The addr is already in *memory. */
> -		ret =3D efi_check_allocated(*memory, false);
> -		if (ret !=3D EFI_SUCCESS)
> -			return EFI_NOT_FOUND;
> -		addr =3D *memory;
> +
> +		addr =3D (u64)lmb_alloc_addr_flags(*memory, len, flags);
> +		if (!addr)
> +			return EFI_OUT_OF_RESOURCES;
>   		break;
>   	default:
>   		/* UEFI doesn't specify other allocation types */
>   		return EFI_INVALID_PARAMETER;
>   	}
>
> +	addr =3D (u64)(uintptr_t)map_sysmem(addr, 0);
>   	/* Reserve that map in our memory maps */
>   	ret =3D efi_add_memory_map_pg(addr, pages, memory_type, true);
>   	if (ret !=3D EFI_SUCCESS)
> @@ -555,6 +512,9 @@ efi_status_t efi_allocate_pages(enum efi_allocate_ty=
pe type,
>    */
>   efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
>   {
> +	u64 len;
> +	uint flags;
> +	long status;
>   	efi_status_t ret;
>
>   	ret =3D efi_check_allocated(memory, true);
> @@ -568,6 +528,12 @@ efi_status_t efi_free_pages(uint64_t memory, efi_ui=
ntn_t pages)
>   		return EFI_INVALID_PARAMETER;
>   	}
>
> +	flags =3D LMB_NOOVERWRITE | LMB_NONOTIFY;
> +	len =3D (u64)pages << EFI_PAGE_SHIFT;
> +	status =3D lmb_free_flags(memory, len, flags);
> +	if (status)
> +		return EFI_NOT_FOUND;
> +
>   	ret =3D efi_add_memory_map_pg(memory, pages, EFI_CONVENTIONAL_MEMORY,
>   				    false);
>   	if (ret !=3D EFI_SUCCESS)

