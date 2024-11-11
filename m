Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49610D12D7F
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 07:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CCB188D61;
	Mon, 11 Nov 2024 08:47:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Nugkv7A7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA29888DB5; Mon, 11 Nov 2024 08:47:00 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8837F88A0A
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 08:46:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731311217; x=1731916017; i=xypron.glpk@gmx.de;
 bh=juwacjPz5aLEVr8hVfFzhBDcwRQV+Qd1AY+brtdQCt8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Nugkv7A71by1cBJyzkb/ZkUsxn5rMMzjmK9ulw7Ur7m9rHscwOd+uzxrrGH9MyiO
 K/8wxIOY3+0NDwLVwBuLjh3Go3jnVHLFCU+PdMSisiYJiUwQ7lHCcuiibYjUPJ7lb
 uofQ2ze1BZTU78xTYtkuxadywJSesjgMEcpqPq7mxysW5VQLodCiBJrfdLSN0Mith
 tae5fJzKukaF3X8Orlm5bkbtclqffdKbvYxWnguZoVfYmEo1+8mopP9w4H791/DTe
 yJUze3qlFyYvaAEahsvCL9m6rQmyKZbwaM08911DoTj3JY21Ozla9Vw+fOKM0dPBk
 Se4ZxBsTSSYSXbKfIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MaJ3t-1tFdu13tNV-00IlEu; Mon, 11
 Nov 2024 08:46:57 +0100
Message-ID: <1b4cc312-3a54-4816-87db-f026b9060c2d@gmx.de>
Date: Mon, 11 Nov 2024 08:46:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] efi_loader: add a function to remove memory from the
 EFI map
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
References: <20241025111411.165904-1-sughosh.ganu@linaro.org>
 <20241025111411.165904-3-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241025111411.165904-3-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SiZcdr98Xqus2DrIxFSL/crIb1Q4CtEos2ULG9IEKjVKjv9jY9j
 cCx8kc7fjyvfXXYEsQp6X4NEg9TD9UqsTUdsb3SF9RPpoZan5V4ujzp3sLAIuPm9wqmyKsF
 wRd0NZq7uV0VYxcFIZtjKrm2zfT4Dp/H2kZ//YMq3fV6j7xoJ88JhE94JgGKi8b8lneTntM
 yq6y4ZHoA3HtqiImz7cZg==
UI-OutboundReport: notjunk:1;M01:P0:FyFs+4+L0xc=;TL2V2PSpiJfN08XeV7UqZTysVQz
 CLm9YHhqx/ya7sFpfGHrxWg2PELkQOeP4yHBJ68eH/LuEfvZPgKIXYPgD4o014mNzmDRUfffg
 RA0h81yLbdgJdnUNuewEKAL9cOT+BlcOnWvKQ/lv/QcmQPB0iNO+vd/hMX15Hfeh47yUzUe6r
 KYtbNhSXPD20EowT3er/+AhNZdoMEAX1gt89/kTNa/3jcIBYojflKz5UK6wZoR9cKElEkGPL+
 M6UzP7hvhGOBEAPDjqeEBgyUCfrBl5hdVsafa2Zog8rS4bH5hWB5WWcNQcZJI3x1WToLfEsxe
 KxlrCh62U1GrWkSydEahwMeY39/6+iL2t7d2zcsiWmDj2mpzk2nK3nTcgEJXqx4HUGzg/VJww
 5BXALgBzKM3I/oULfuTu/X5C22toirUm3Gk+ApW3ERoLGjT/02Z0fTCXlkFpAbY4FbeZQQmnF
 vQAOWnafZvWW2W4aH/Gh2ny5LtRIYqS5yNMnSh4DwAi7dgFiwjjgH+R6KR/tPTS9zZoIkQUAZ
 NLa8wYkRrinNGRgqu82C4VL6XbzodsCD0FUKkR4L8iAQFtKK2+uCBhz+YFanIdYGr0kPFt2Up
 X2oevFzmmcBtGcEKETP4iX1pFBbY3aj5JUdRup1hAw8WgrF3via8Y248aIN+vXXkF2VzTI5Uq
 WCvSyQ+TpD9lWwEQW/hvbCJBI8z1Ak6XXXoqrFla3CSl+Wl6wftKrl8L6OQa7Gm/S9hIvWaqg
 +OBIpWhwuP7wlM9Jiq8uPSeiOgHJoiad44816++aBavX7o3N3fYFd/vDhBkccemSIFu46R9JB
 y1fI+6/nW9Ia+licCLjl1/gA==
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

On 10/25/24 13:14, Sughosh Ganu wrote:
> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> With upcoming changes supporting pmem nodes, we need to ommit the

Nits:
%s/ommit/remove/

> pmem area rfom the EFI memory map. Add a function to do that

%s/rfom/from/
%s/that/that./

>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>

The patch is not applicable. Please, rebase on origin/master.

In the medium term we should get rid of the double book keeping. The
memory map should be generated on the fly from LMB data.

Best regards

Heinrich

> ---
>   include/efi_loader.h        | 11 +++++---
>   lib/efi_loader/efi_memory.c | 51 +++++++++++++++++++++++++++----------
>   lib/lmb.c                   |  4 +--
>   3 files changed, 47 insertions(+), 19 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 291eca5c07..d450e304c6 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -786,7 +786,7 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_=
map_size,
>   efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
>
>   /**
> - * efi_add_memory_map_pg() - add pages to the memory map
> + * efi_update_memory_map() - update the memory map by adding/removing p=
ages
>    *
>    * @start:			start address, must be a multiple of
>    *				EFI_PAGE_SIZE
> @@ -794,11 +794,14 @@ efi_status_t efi_add_memory_map(u64 start, u64 siz=
e, int memory_type);
>    * @memory_type:		type of memory added
>    * @overlap_conventional:	region may only overlap free(conventional)
>    *				memory
> + * @remove:			remove memory map
>    * Return:			status code
>    */
> -efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> -				   int memory_type,
> -				   bool overlap_conventional);
> +efi_status_t efi_update_memory_map(u64 start, u64 pages, int memory_typ=
e,
> +				   bool overlap_conventional, bool remove);
> +
> +/* Remove memory from the EFI memory map */
> +efi_status_t efi_remove_memory_map(u64 start, u64 size, int memory_type=
);
>
>   /* Called by board init to initialize the EFI drivers */
>   efi_status_t efi_driver_init(void);
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 3d742fa191..cb93bfa55f 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -258,7 +258,7 @@ static s64 efi_mem_carve_out(struct efi_mem_list *ma=
p,
>   }
>
>   /**
> - * efi_add_memory_map_pg() - add pages to the memory map
> + * efi_update_memory_map() - update the memory map by adding/removing p=
ages
>    *
>    * @start:			start address, must be a multiple of
>    *				EFI_PAGE_SIZE
> @@ -266,11 +266,11 @@ static s64 efi_mem_carve_out(struct efi_mem_list *=
map,
>    * @memory_type:		type of memory added
>    * @overlap_conventional:	region may only overlap free(conventional)
>    *				memory
> + * @remove:			remove memory map
>    * Return:			status code
>    */
> -efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> -				   int memory_type,
> -				   bool overlap_conventional)
> +efi_status_t efi_update_memory_map(u64 start, u64 pages, int memory_typ=
e,
> +				   bool overlap_conventional, bool remove)
>   {
>   	struct efi_mem_list *lmem;
>   	struct efi_mem_list *newlist;
> @@ -278,9 +278,9 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pa=
ges,
>   	uint64_t carved_pages =3D 0;
>   	struct efi_event *evt;
>
> -	EFI_PRINT("%s: 0x%llx 0x%llx %d %s\n", __func__,
> +	EFI_PRINT("%s: 0x%llx 0x%llx %d %s %s\n", __func__,
>   		  start, pages, memory_type, overlap_conventional ?
> -		  "yes" : "no");
> +		  "yes" : "no", remove ? "remove" : "add");
>
>   	if (memory_type >=3D EFI_MAX_MEMORY_TYPE)
>   		return EFI_INVALID_PARAMETER;
> @@ -363,7 +363,10 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 p=
ages,
>   	}
>
>   	/* Add our new map */
> -        list_add_tail(&newlist->link, &efi_mem);
> +	if (!remove)
> +		list_add_tail(&newlist->link, &efi_mem);
> +	else
> +		free(newlist);
>
>   	/* And make sure memory is listed in descending order */
>   	efi_mem_sort();
> @@ -400,7 +403,29 @@ efi_status_t efi_add_memory_map(u64 start, u64 size=
, int memory_type)
>   	pages =3D efi_size_in_pages(size + (start & EFI_PAGE_MASK));
>   	start &=3D ~EFI_PAGE_MASK;
>
> -	return efi_add_memory_map_pg(start, pages, memory_type, false);
> +	return efi_update_memory_map(start, pages, memory_type, false, false);
> +}
> +
> +/**
> + * efi_remove_memory_map() - remove memory area to the memory map
> + *
> + * @start:		start address of the memory area
> + * @size:		length in bytes of the memory area
> + * @memory_type:	type of memory removed
> + *
> + * Return:		status code
> + *
> + * This function automatically aligns the start and size of the memory =
area
> + * to EFI_PAGE_SIZE.
> + */
> +efi_status_t efi_remove_memory_map(u64 start, u64 size, int memory_type=
)
> +{
> +	u64 pages;
> +
> +	pages =3D efi_size_in_pages(size + (start & EFI_PAGE_MASK));
> +	start &=3D ~EFI_PAGE_MASK;
> +
> +	return efi_update_memory_map(start, pages, memory_type, false, true);
>   }
>
>   /**
> @@ -500,7 +525,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_ty=
pe type,
>
>   	addr =3D (u64)(uintptr_t)map_sysmem(addr, 0);
>   	/* Reserve that map in our memory maps */
> -	ret =3D efi_add_memory_map_pg(addr, pages, memory_type, true);
> +	ret =3D efi_update_memory_map(addr, pages, memory_type, true, false);
>   	if (ret !=3D EFI_SUCCESS)
>   		/* Map would overlap, bail out */
>   		return  EFI_OUT_OF_RESOURCES;
> @@ -542,8 +567,8 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uin=
tn_t pages)
>   	if (status)
>   		return EFI_NOT_FOUND;
>
> -	ret =3D efi_add_memory_map_pg(memory, pages, EFI_CONVENTIONAL_MEMORY,
> -				    false);
> +	ret =3D efi_update_memory_map(memory, pages, EFI_CONVENTIONAL_MEMORY,
> +				    false, false);
>   	if (ret !=3D EFI_SUCCESS)
>   		return EFI_NOT_FOUND;
>
> @@ -828,8 +853,8 @@ static void add_u_boot_and_runtime(void)
>   	runtime_end =3D (uintptr_t)__efi_runtime_stop;
>   	runtime_end =3D (runtime_end + runtime_mask) & ~runtime_mask;
>   	runtime_pages =3D (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
> -	efi_add_memory_map_pg(runtime_start, runtime_pages,
> -			      EFI_RUNTIME_SERVICES_CODE, false);
> +	efi_update_memory_map(runtime_start, runtime_pages,
> +			      EFI_RUNTIME_SERVICES_CODE, false, false);
>   }
>
>   int efi_memory_init(void)
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 7e90f17876..05f3cd093d 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -55,11 +55,11 @@ static int __maybe_unused lmb_map_update_notify(phys=
_addr_t addr,
>   	pages =3D efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
>   	efi_addr &=3D ~EFI_PAGE_MASK;
>
> -	status =3D efi_add_memory_map_pg(efi_addr, pages,
> +	status =3D efi_update_memory_map(efi_addr, pages,
>   				       op =3D=3D MAP_OP_RESERVE ?
>   				       EFI_BOOT_SERVICES_DATA :
>   				       EFI_CONVENTIONAL_MEMORY,
> -				       false);
> +				       false, false);
>   	if (status !=3D EFI_SUCCESS) {
>   		log_err("%s: LMB Map notify failure %lu\n", __func__,
>   			status & ~EFI_ERROR_MASK);

