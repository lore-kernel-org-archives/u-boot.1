Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A34C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 12:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8626E800B6;
	Mon, 20 Jan 2025 13:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="W/kQgw6U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C37AE805C5; Mon, 20 Jan 2025 13:36:52 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F6F780077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:36:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1737376602; x=1737981402; i=xypron.glpk@gmx.de;
 bh=ifBYmHcj/JpJfqIEmpIPhHWC6MiLEAVClpLSH5lUWAc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=W/kQgw6URPsnIPdQ4FI/FJ0cUqeGtNfSfWWnl9HGarZuT4+5q9ZIj+0kGuzm4ZdY
 3M1xQZosnHDadEZ77b7AsfRkbemDk6S7pM2n+5LeXo/A3y26V5fM5wOcO6w4gd6Mt
 urh388Z6hHICjFT82GhTlj/OXwQ1sTin17nnow+C4RH4UWefzgBaIBPa3ojOrhc36
 pEU+D4EPjC/vB0S5e2HpbqEB5HxD2SVufLvgM6k96Q8Ypeqe7iFZDhnV1r5Sowuf8
 p72bIke7KIkXZuPaRHPg58Sg68gFf/I6YKMtMVvUOCDTZf+Yomd00vhzIYcMlNkMz
 4QwCaSrz7BwtnSQz8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([46.114.108.173]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH9Y-1sxVWo0zVM-00btMj; Mon, 20
 Jan 2025 13:36:42 +0100
Message-ID: <a0c7303b-5969-4b05-9213-7dfdce31ed80@gmx.de>
Date: Mon, 20 Jan 2025 13:36:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] efi_loader: add a function to remove memory from
 the EFI map
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng@tinylab.org>,
 u-boot@lists.denx.de
References: <20250120105045.1281262-1-sughosh.ganu@linaro.org>
 <20250120105045.1281262-3-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250120105045.1281262-3-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7KQsHu6YapbZ94wbtd4ewog5+BKRgmvMrLhmN0byFkq8x8GTl/m
 o4hZrixEHpPrcUhTe/Y3j9nwzXxUtDGXzYyhfbMVApAToi3JZGyDmY8L98cVLfk375FozMJ
 XqYHzNCGRZUyrBhpWwad46k/T7P/KgNzNekLm6z/Jh+Iujv8uQ7zFPwywBm83UmyKUA5Gq0
 88QBdvKUlONwJZMszLSWg==
UI-OutboundReport: notjunk:1;M01:P0:Y2puHBbyH6E=;QD8QaoKLpPNtM36meMwoDVxh+fJ
 6V3dpGadqBjGGy86WUKo0AdrruXk17eBymcnHWhs0rzjBdNjHH+rWvspBiaKPhw7FR4NXMDne
 ATvsZ63Oi7v/mAD7PQvZjNCUHommRwn4jfeMRJNxZ0/PIMR/h7sybkKqUoa1x36oWts0h2vDF
 /tsW7ZlEc97plV2bHdau1hRjFaYdtXWil920KzkfnI5bjjRRzJgrN4AbHi4AG+ywHC7UvdVhu
 7aqiZRwJSXGiN+YdZoc6NotrFsOxyWQPzKklgJe+PSh6+qXjFaKvTxWCovDpl1HXGh6WuKXrN
 NDRB5h5AwDhGUz9O8KaaEzA6pHXHtDLxhAFRTV5/xmli8d8cIuRUH3P+bpLdNCs5+ges4OeLO
 7ZFlpMr/SkO9VF/HOnmA7Z7mwhQ+8cnzRQwX2/CEtwHgWo187uklWf2KtK8pxvhCVbwfNkcgt
 fZFZx656LCArXJOGgkc1w1KMIDCkQyZR7hPXjawSsNTeqjL80cT2HDvD5U9uiLoBHYljLONJf
 Hl1De0EWAiD6HvDefsgT3xgYItTcBG19WjtHgETCYbioNwRO8dCbrJMNoOUyinIw5rk1ctESD
 MrnrbLLZG30fC9KmJpkKl6Urmf9MU4g/EQbzHeZeBPD+JHBVXlEZiR2h/ZJkhegFarKCKOyl4
 QZfX9rWQ6JOPnfIisqUJeBCG2mOwyGCJ6UB9ZnORwSWhYhwxkuAOcl4XTAWrpqhlQMVc3idcO
 E9LnPBwEdHuyh2dhKThEXsQt2e5baO0ixEzYqwG8/DVV11H1E+c9zf7rw4oh50WWYCFtXwjZf
 dLbTloVOUWh2+wKWA2tqxxZuUxpuYszVzqfPwDq171K6LOVnSYrVKen6JkaY/jBT47fcb2EGE
 GvOi3rJ5gWuIX3QZZXmwDroqM86B7DnV4SZeAbf+LCkPYDMyTi8G77G3GQx0zJtyn9PF3+YIJ
 KPMD/OZNG247wZ2hYd/I3tHnnEsq/FsD++hNy7I1cXjTzE2dgIDXDdmhKrseET5F+5Vs7LT+r
 JcSQbwRrsuhS1+q/wbJNMOhWWBlVR8ZfwDFYCsmMSGq6NzOPOj5DDZU5fwe4qTTIslLrzcLJj
 EWMPV5sE763D3v3zxrgjPy+DdzPJhotWGhj66YTU22QsJEzGPhGCg7XRm35IKp4GQqsxKA+mX
 7QPprLZ6BNjOOwa0FnmaojcNeR13IC9IQxAk+I8VnEg==
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

On 20.01.25 11:50, Sughosh Ganu wrote:
> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> With upcoming changes supporting pmem nodes, we need to remove the
> pmem area from the EFI memory map. Add a function to do that.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
> Changes since V2: None
>
>   include/efi_loader.h        | 11 +++++---
>   lib/efi_loader/efi_memory.c | 51 +++++++++++++++++++++++++++----------
>   lib/lmb.c                   |  4 +--
>   3 files changed, 47 insertions(+), 19 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 0d858c1e12e..944794e1637 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -831,7 +831,7 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_=
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
> @@ -839,11 +839,14 @@ efi_status_t efi_add_memory_map(u64 start, u64 siz=
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
> index 1212772471e..2362995abf6 100644
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
> @@ -501,7 +526,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_ty=
pe type,
>
>   	efi_addr =3D (u64)(uintptr_t)map_sysmem(addr, 0);
>   	/* Reserve that map in our memory maps */
> -	ret =3D efi_add_memory_map_pg(efi_addr, pages, memory_type, true);
> +	ret =3D efi_update_memory_map(efi_addr, pages, memory_type, true, fals=
e);
>   	if (ret !=3D EFI_SUCCESS) {
>   		/* Map would overlap, bail out */
>   		lmb_free_flags(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
> @@ -822,8 +847,8 @@ static void add_u_boot_and_runtime(void)
>   		       uboot_stack_size) & ~EFI_PAGE_MASK;
>   	uboot_pages =3D ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
>   		       uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
> -	efi_add_memory_map_pg(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE=
,
> -			      false);
> +	efi_update_memory_map(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE=
,
> +			      false, false);
>   #if defined(__aarch64__)
>   	/*
>   	 * Runtime Services must be 64KiB aligned according to the
> @@ -841,8 +866,8 @@ static void add_u_boot_and_runtime(void)
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
> index 7ca44591e1d..d5aea1ed8fe 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -455,11 +455,11 @@ static int lmb_map_update_notify(phys_addr_t addr,=
 phys_size_t size, u8 op,
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

