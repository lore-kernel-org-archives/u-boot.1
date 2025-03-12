Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA55C28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 10:13:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DD1C801FB;
	Wed, 12 Mar 2025 11:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="e+ZMu5K1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC8FB805D7; Wed, 12 Mar 2025 11:13:45 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C343801BE
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1741774421; x=1742379221; i=xypron.glpk@gmx.de;
 bh=/xB9dVxLuenEWOSb9mu4+ElzQLtu04aWy2rFY8F5iLU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=e+ZMu5K1QousB8+grjusVdqK/gbTFpB3z1r21P6xmAv5hRMs2C+0rsxgNvE1CyzV
 D5HasU/bjlBhfVsXv0PbDPAw7EsdglB8JMrK8/8CANSYnzbNfWC7lMCV2czbucqtz
 gSnxduGepY8ETer+RH4xJbKOoJDRxxBVBxuk1vAmvEX1BwEgwEDqzqb4SLZXEWYWy
 u4aaaNJu2Q6IUybhI9Qowkpq5RteYS/BLq1g0nDrkthzI0vKu+2fEDD6ZmOXDLaHH
 l2vMJmdDLn4p+u6mTlWjEcFuwm9z3TfBDFE6/yIYuablTk3NwxaJm4tSMEPTF8XNn
 kmDkCTAY4f4LD9fhCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEUz4-1tzSlr1z9W-006SMy; Wed, 12
 Mar 2025 11:13:41 +0100
Message-ID: <e1237408-072c-4473-aafb-ab74196a2c71@gmx.de>
Date: Wed, 12 Mar 2025 11:13:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/8] efi_loader: add a function to remove memory from
 the EFI map
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, u-boot@lists.denx.de
References: <20250312085424.1201148-1-sughosh.ganu@linaro.org>
 <20250312085424.1201148-5-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250312085424.1201148-5-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LrbQFNq0YLqN/WJ5YmH6eg04QOt4CDhqc+RfXuMHKmcL+5no4ZL
 HVFNR4hVfoekEST3NCUTbYiVv2A7UISINacniq/t/O7+SmzvG3rXc5G429Vr6SOtmzfH9LM
 naGnyb/kEJwMGaJPSNauSlRqcjou4RbyFrKmInSv7m8f8hup4k1zPVxB0OwzVOh5F/Hy/9o
 QXXq3uLPJxfK4s7o2tPqQ==
UI-OutboundReport: notjunk:1;M01:P0:t8HJ15KrL0o=;fiKx+l9a4TXMYId6+irJIMFJoLN
 ZFtZTsgauf8T4VAvd4GJKMr3PjiX8LZfR2b2lnKbsimjnH0fMpmh+Jo8DZXiv8izLy3butjJx
 FvaBMJE2ZYONXzz6Nlco51XZ31V8EmbgPdKHi7GJghEJe5jGXKit/hRYqI2wxi3ro+ozYiiX6
 iM1ndO/wL8bF65WyfDDCjH1meHV1ZfDrObcE7FFsMflrAOerrCtFrnUj+4BBt/06uC4538PFC
 Id7/Bh5C/gB6lCyd1HuJvqhjHJUtUh4bNEbpWECd3J4dE5VpnDnMNg9TqPEI6Bg5tQHKbgQu4
 9SWYzmZbYUnL9748HeXsJ0Y4iFIx+oDCg+ZXdlasaXcjaM0c7GPuOBB6OBahVJ9WepCiPFVhw
 6XzvTx5Xet+FKJWrJbqX4j6tRCpNds/2KkLIfHt9skTMLFJag+VBEI6aAGWcnk4ZbB8G3d4rY
 NeRbLH2LgiiKTA6t94C9KHftuBzDRB7Y5BF+1F43K+NML+vuaGCHzyrr7DHYYMgd12PFBilDg
 6UM8mp/Jsf7zkINwwM0S0kQJ9/OYzDn2MIQnOqdkRUpVcEccs2NTQvOt0aRTswjY4h/4Abp/s
 CElWUMvkTA2gHNZ9LxbzA9tBJON/WIZc0/reH+6vkqZiLdFt/r97ZteuckrVOlx5FPLafZlmE
 T1kpzkJSEXvwTIRkWZBa0z7QdL9EY+f9y9B7m8TbOwxmVMC6UT1qEzQy/fZe0eiIYgNG+wLic
 FM+maoP3pvOwOZdilmuj7PlD/1Gz6nbsfHo115+8o6G5AOAsdtGCrfy2hRS64iqrAamAEZV4g
 BrMWLb4YbhNWo9b21Aojogf5aTI2m44hkE84n4dxbiJp+QuyJccCKLOwr0alKS5WQtLzZ+fpk
 PROv3n4H3xt4NH+iknAo98ivlxQYyO3g4YIEq80JORuHwNshybVDHWe4pDNwjAI6ExE8SuZS0
 5PC1dxSGIMtgrbxvZoBLJA/p/dDXSrZQRlS9am2c7qOfLQU5S7HgZ/GWD9Gq/O2DH4PMESif2
 +biu71lrLIvWBJD86DLZchZ4MA9U0qjUT6/ApO3hgFBopZpW3ILtRE7QTZ3Z1LogZ6hBYwBos
 eONGzunFJ0+GqdQyv77MNjFIOYigTcmtwvJnzVKlYbNBWmrCiwr6rXjg1mbjhxae61Ps+Rsdz
 fi69ZnyDAWURrSElfREOpZLpzRryc6rfYfTtdElQJTGt1rJkPJJxfonc65N5wYUksFaAQv3q3
 P+72r9KjWiqFcdXmc4SUkCuGipdBFe5x5wBK55dSGFSRvls181S1weBgYsrCeJ1U9xGqGnQcn
 QFof0VQ49n74XsYzMEkYMrX96tPkB29VfFNhReOWMx8kF6YK5yoRx3wJFsVMuABv+5935uzL+
 um7dT4tLbOt9WuemQHIidFknwjpcGjI/hoP0D45S0i/4xI1K0nTPqy8jFcP/OhkFcmQEj8wpz
 eEJsRwv5kbEzMArwLqDj5ETwdmYk=
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
> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> With upcoming changes supporting pmem nodes, we need to remove the
> pmem area from the EFI memory map. Add a function to do that.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
> Changes since V7: None
>
>   include/efi_loader.h        | 18 ++++++++++++
>   lib/efi_loader/efi_memory.c | 56 ++++++++++++++++++++++++++-----------
>   2 files changed, 58 insertions(+), 16 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index e9c10819ba2..c20c98c6476 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -878,6 +878,24 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory=
_map_size,
>   /* Adds a range into the EFI memory map */
>   efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
>
> +/**
> + * efi_update_memory_map() - update the memory map by adding/removing p=
ages
> + *
> + * @start:			start address, must be a multiple of
> + *				EFI_PAGE_SIZE
> + * @pages:			number of pages to add
> + * @memory_type:		type of memory added
> + * @overlap_conventional:	region may only overlap free(conventional)
> + *				memory
> + * @remove:			remove memory map
> + * Return:			status code
> + */
> +efi_status_t efi_update_memory_map(u64 start, u64 pages, int memory_typ=
e,
> +				   bool overlap_conventional, bool remove);

Why do we have so many functions that are all doing nearly the same thing:

* efi_map_update_notify()
* efi_update_memory_map()
* efi_remove_memory_map()
* efi_add_memory_map_pg()

I start failing to understand when to use which. This is getting as
gruesome as LMB.

Can't we have a single exported function with a properly defined
interface to cover all use cases?

Best regards

Heinrich

> +
> +/* Remove memory from the EFI memory map */
> +efi_status_t efi_remove_memory_map(u64 start, u64 size, int memory_type=
);
> +
>   /* Called by board init to initialize the EFI drivers */
>   efi_status_t efi_driver_init(void);
>   /* Called when a block device is added */
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 6d00b186250..3fec40b6de5 100644
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
> @@ -266,12 +266,11 @@ static s64 efi_mem_carve_out(struct efi_mem_list *=
map,
>    * @memory_type:		type of memory added
>    * @overlap_conventional:	region may only overlap free(conventional)
>    *				memory
> + * @remove:			remove memory map
>    * Return:			status code
>    */
> -static
> -efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> -				   int memory_type,
> -				   bool overlap_conventional)
> +efi_status_t efi_update_memory_map(u64 start, u64 pages, int memory_typ=
e,
> +				   bool overlap_conventional, bool remove)
>   {
>   	struct efi_mem_list *lmem;
>   	struct efi_mem_list *newlist;
> @@ -279,9 +278,9 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pa=
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
> @@ -364,7 +363,10 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 p=
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
> @@ -401,7 +403,29 @@ efi_status_t efi_add_memory_map(u64 start, u64 size=
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
> @@ -502,7 +526,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_ty=
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
> @@ -823,8 +847,8 @@ static void add_u_boot_and_runtime(void)
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
> @@ -842,8 +866,8 @@ static void add_u_boot_and_runtime(void)
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
> @@ -878,11 +902,11 @@ int efi_map_update_notify(phys_addr_t addr, phys_s=
ize_t size,
>   	pages =3D efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
>   	efi_addr &=3D ~EFI_PAGE_MASK;
>
> -	status =3D efi_add_memory_map_pg(efi_addr, pages,
> +	status =3D efi_update_memory_map(efi_addr, pages,
>   				       op =3D=3D LMB_MAP_OP_RESERVE ?
>   				       EFI_BOOT_SERVICES_DATA :
>   				       EFI_CONVENTIONAL_MEMORY,
> -				       false);
> +				       false, false);
>   	if (status !=3D EFI_SUCCESS) {
>   		log_err("LMB Map notify failure %lu\n",
>   			status & ~EFI_ERROR_MASK);

