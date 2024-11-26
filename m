Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2402D3B7CA
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 09:39:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58F248969B;
	Tue, 26 Nov 2024 10:39:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="G5UheLv9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D03A68969C; Tue, 26 Nov 2024 10:39:41 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8615488815
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 10:39:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732613972; x=1733218772; i=xypron.glpk@gmx.de;
 bh=qeS5w6+9AczW0z9sWXgZWzcFfFVYZVXD05Dgm/CMXLA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=G5UheLv9X/jZQVB1LPOMuZ+dfjMIC4src+YsSEeUFkgL0pEa33sjbJfZBbFny/l3
 3NbMPUzi6ljb1D4aF4Y/GdR5QYP8fSElx7qKRSYnUt9lc58RI6zEKnKtqZSrP5vwY
 QRxjDpDtmfHgXlErIWayaLmFDZyQJilBVbV8HIiOncC9SFo204QcKeMr3SI6rEjHa
 PDRKh4GBL5RGTfmQppjGuES6/CgYPef77ZYCYhElXIOp07pGg+uZKpVkJGBORyNp+
 Q1MSmEMc79FNEyJ/Op/ie4/9wnHKcEPZEubtXpMYZzY81AZ2CDqhIxDARXBuSaits
 MVgPEOjUZ1hfO93HJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0XCw-1tagAy2cYG-011L9q; Tue, 26
 Nov 2024 10:39:32 +0100
Message-ID: <5976a08e-a242-4665-85e6-410f48776229@gmx.de>
Date: Tue, 26 Nov 2024 10:39:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] efi_loader: Use the enum for memory type
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Janne Grunau <j@jannau.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-7-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241125204456.1525752-7-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+0XA8LBukJIVSocS4bmQVKet7m38aZkIzA7TXE0sMdcAMp5sh5O
 EerH7wAUMGpVHXrVX7j0o3Q3sR8wcconqye+rzNpmvTUrJRLCks/O3kejaTYFbutsTbUULM
 5WpNSDZMiqDY7fevuxI4Zv8Mlg1nMeN/eRSfboNZgbMLH4UfS6kIVYCFDEzF9G0KM6EHG9t
 HTiJ/pLD16b0AY3pUw+Yg==
UI-OutboundReport: notjunk:1;M01:P0:i1IFkJbl2BU=;nO7gMQdgVPVLNq07uNjL/aA38+F
 ChgwgKVR3d4NGJ1ii7w2eqw2Ppm14ehOGKJVHXZsE0Jm+bhZa9r1iNE+wD2JGSYBBOS5Ao03G
 6d2rD1qC/Vg4/Aq2p8MkItN/lcj4AvQUL/pOjCi8pf9pn7ekQW4wDr1WQiZn3tIHFFcsOY6pD
 Aw1U//ZCfdOhfB08U4tMObxyPtUhPp/Uvpa9A9iBK88xq5PWNO/bOUKfSsUzBiHH/Twr4+Osy
 IDrvzts0YG5vThVmigUN83gdadmmqWSSJMVlo4yEEIsJQ8O4Nf4zOIU1+/Te3Ke1h88fUOT2m
 +IkwxUGH2WyNFp+7WJneTLeKuQ7Ur59Dc57RT3w6EuFNc9l2SSc8FbIXKxq4PAmVAUqW+vth7
 vK6/4GTW6ItgTdl1gC5dYQTSdUS9EmlM7vM1L4iy2xx/tDMC6oYSoD34VvjBkFVDKW/pJ92Rx
 IdsTjpUioYuvDOMorA+0E2qb5Esp9CqloV/vTbNhLwWT0LISiDt5K7BJ08xDz6P0gDvogL23m
 AlI7udzpJdmrdSBgzkBYqgsOSaVnXnq1fBjtT5jvXEoJR2zwsgdtcBKnhKsqyPJuXQ+qYMhSn
 wV2WsLwe8Oya62XmQ+M+gWEXDn7Uto4I+ulDn2QoPOLTE6vi4FcawsiDe9s9Ey+6qtepsAGKZ
 8mYDRBnFmGjRYwPmAaeVIcKS36kDzQCLS6v9X2iqJTjbWoqcY6nHiXMCET0jZLbQPw53ejHrM
 9UUt/YFWfRMauc9Tn2g8eQTSem95uxeBqPe+AKRLw2JMgJ0HQ2p6hVlnK0lsKp6ms8+kaD07e
 AugP1jUpLS7BkkHYq+BokRYLatXXMiBnhLLBTqxDyO1lv+u1KStirLLH9XyZwvm3DOttqSVuM
 bSj8Yl4uD7dtnnlL8gDXJMHjzVdTYUUOCqrbDUj3/0XzUfxtVO1dm/ENq
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

On 25.11.24 21:44, Simon Glass wrote:
> Rather than an integer, it is better to use the enum provided, when
> referring to an EFI memory-type. Update existing uses.

The C standard provides no definition of the size of the integer used to
implement enums. It could use u8, u16, u32, or u64.

As EFI applications may be compiled using a different compiler we need
to control the width used for passing parameters in the API interface.

We should have used u32 instead of int here. We could use a typedef for
more verbosity though that is frowned upon in U-Boot.

Best regards

Heinrich

>
> Call the value 'mem_type' consistently. Fix up one instance of
> upper-case hex.
>
> Fix up the calls in struct efi_boot_services so that they use the same
> enum, adding the missing parameter names and enum efi_allocate_type.
>
> While we are here, rename the 'memory' parameter to 'memoryp' so that it
> is clear it is a return value.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   include/efi_api.h                |  6 ++++--
>   include/efi_loader.h             | 28 ++++++++++++++-------------
>   lib/efi_loader/efi_boottime.c    | 13 +++++++------
>   lib/efi_loader/efi_device_path.c |  4 ++--
>   lib/efi_loader/efi_memory.c      | 33 ++++++++++++++++----------------
>   5 files changed, 45 insertions(+), 39 deletions(-)
>
> diff --git a/include/efi_api.h b/include/efi_api.h
> index f07d074f93b..1260df0cd58 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -69,8 +69,10 @@ struct efi_boot_services {
>   	efi_status_t (EFIAPI *raise_tpl)(efi_uintn_t new_tpl);
>   	void (EFIAPI *restore_tpl)(efi_uintn_t old_tpl);
>
> -	efi_status_t (EFIAPI *allocate_pages)(int, int, efi_uintn_t,
> -					      efi_physical_addr_t *);
> +	efi_status_t (EFIAPI *allocate_pages)(enum efi_allocate_type type,
> +					      enum efi_memory_type mem_type,
> +					      efi_uintn_t pages,
> +					      efi_physical_addr_t *memoryp);
>   	efi_status_t (EFIAPI *free_pages)(efi_physical_addr_t, efi_uintn_t);
>   	efi_status_t (EFIAPI *get_memory_map)(efi_uintn_t *memory_map_size,
>   					      struct efi_mem_desc *desc,
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index ff7adc1e2a2..0ef4c6f7dea 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -773,24 +773,25 @@ void *efi_alloc(size_t len);
>    * efi_alloc_aligned_pages() - allocate aligned memory pages
>    *
>    * @len:		len in bytes
> - * @memory_type:	usage type of the allocated memory
> + * @mem_type:		usage type of the allocated memory
>    * @align:		alignment in bytes
>    * Return:		aligned memory or NULL
>    */
> -void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align);
> +void *efi_alloc_aligned_pages(u64 len, enum efi_memory_type mem_type,
> +			      size_t align);
>
>   /**
>    * efi_allocate_pages - allocate memory pages
>    *
>    * @type:		type of allocation to be performed
> - * @memory_type:	usage type of the allocated memory
> + * @mem_type:		usage type of the allocated memory
>    * @pages:		number of pages to be allocated
> - * @memory:		returns a pointer to the allocated memory
> + * @memoryp:		returns a pointer to the allocated memory
>    * Return:		status code
>    */
>   efi_status_t efi_allocate_pages(enum efi_allocate_type type,
> -				enum efi_memory_type memory_type,
> -				efi_uintn_t pages, uint64_t *memory);
> +				enum efi_memory_type mem_type,
> +				efi_uintn_t pages, uint64_t *memoryp);
>
>   /**
>    * efi_free_pages() - free memory pages
> @@ -804,12 +805,12 @@ efi_status_t efi_free_pages(uint64_t memory, efi_u=
intn_t pages);
>   /**
>    * efi_allocate_pool - allocate memory from pool
>    *
> - * @pool_type:	type of the pool from which memory is to be allocated
> + * @mem_type:	memory type of the pool from which memory is to be alloca=
ted
>    * @size:	number of bytes to be allocated
>    * @buffer:	allocated memory
>    * Return:	status code
>    */
> -efi_status_t efi_allocate_pool(enum efi_memory_type pool_type,
> +efi_status_t efi_allocate_pool(enum efi_memory_type mem_type,
>   			       efi_uintn_t size, void **buffer);
>
>   /**
> @@ -834,10 +835,11 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memor=
y_map_size,
>    * efi_add_memory_map() - Add a range into the EFI memory map
>    * @start: start address, must be a multiple of EFI_PAGE_SIZE
>    * @size: Size, in bytes
> - * @memory_type: EFI type of memory added
> + * @mem_type: EFI type of memory added
>    * Return: status code
>    */
> -efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
> +efi_status_t efi_add_memory_map(u64 start, u64 size,
> +				enum efi_memory_type mem_type);
>
>   /**
>    * efi_add_memory_map_pg() - add pages to the memory map
> @@ -845,13 +847,13 @@ efi_status_t efi_add_memory_map(u64 start, u64 siz=
e, int memory_type);
>    * @start:			start address, must be a multiple of
>    *				EFI_PAGE_SIZE
>    * @pages:			number of pages to add
> - * @memory_type:		EFI type of memory added
> + * @mem_type:		EFI type of memory added
>    * @overlap_conventional:	region may only overlap free(conventional)
>    *				memory
>    * Return:			status code
>    */
>   efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> -				   int memory_type,
> +				   enum efi_memory_type mem_type,
>   				   bool overlap_conventional);
>
>   /* Called by board init to initialize the EFI drivers */
> @@ -910,7 +912,7 @@ struct efi_device_path *efi_dp_part_node(struct blk_=
desc *desc, int part);
>   struct efi_device_path *efi_dp_from_file(const struct efi_device_path =
*dp,
>   					 const char *path);
>   struct efi_device_path *efi_dp_from_eth(void);
> -struct efi_device_path *efi_dp_from_mem(uint32_t mem_type,
> +struct efi_device_path *efi_dp_from_mem(enum efi_memory_type mem_type,
>   					uint64_t start_address,
>   					size_t size);
>   /* Determine the last device path node that is not the end node. */
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime=
.c
> index 90437e3e401..efd9577c9d0 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -414,9 +414,9 @@ static void EFIAPI efi_restore_tpl(efi_uintn_t old_t=
pl)
>   /**
>    * efi_allocate_pages_ext() - allocate memory pages
>    * @type:        type of allocation to be performed
> - * @memory_type: usage type of the allocated memory
> + * @mem_type:    usage type of the allocated memory
>    * @pages:       number of pages to be allocated
> - * @memory:      allocated memory
> + * @memoryp:     allocated memory
>    *
>    * This function implements the AllocatePages service.
>    *
> @@ -425,14 +425,15 @@ static void EFIAPI efi_restore_tpl(efi_uintn_t old=
_tpl)
>    *
>    * Return: status code
>    */
> -static efi_status_t EFIAPI efi_allocate_pages_ext(int type, int memory_=
type,
> +static efi_status_t EFIAPI efi_allocate_pages_ext(enum efi_allocate_typ=
e type,
> +						  enum efi_memory_type mem_type,
>   						  efi_uintn_t pages,
> -						  uint64_t *memory)
> +						  uint64_t *memoryp)
>   {
>   	efi_status_t r;
>
> -	EFI_ENTRY("%d, %d, 0x%zx, %p", type, memory_type, pages, memory);
> -	r =3D efi_allocate_pages(type, memory_type, pages, memory);
> +	EFI_ENTRY("%d, %d, 0x%zx, %p", type, mem_type, pages, memoryp);
> +	r =3D efi_allocate_pages(type, mem_type, pages, memoryp);
>   	return EFI_EXIT(r);
>   }
>
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_devic=
e_path.c
> index ee387e1dfd4..9c8cd35b97b 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -975,7 +975,7 @@ struct efi_device_path __maybe_unused *efi_dp_from_e=
th(void)
>   }
>
>   /* Construct a device-path for memory-mapped image */
> -struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
> +struct efi_device_path *efi_dp_from_mem(enum efi_memory_type mem_type,
>   					uint64_t start_address,
>   					size_t size)
>   {
> @@ -990,7 +990,7 @@ struct efi_device_path *efi_dp_from_mem(uint32_t mem=
ory_type,
>   	mdp->dp.type =3D DEVICE_PATH_TYPE_HARDWARE_DEVICE;
>   	mdp->dp.sub_type =3D DEVICE_PATH_SUB_TYPE_MEMORY;
>   	mdp->dp.length =3D sizeof(*mdp);
> -	mdp->memory_type =3D memory_type;
> +	mdp->memory_type =3D mem_type;
>   	mdp->start_address =3D start_address;
>   	mdp->end_address =3D start_address + size;
>   	buf =3D &mdp[1];
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 7c8d9485094..2c46915e5b9 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -258,7 +258,7 @@ static s64 efi_mem_carve_out(struct efi_mem_list *ma=
p,
>   }
>
>   efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> -				   int memory_type,
> +				   enum efi_memory_type mem_type,
>   				   bool overlap_conventional)
>   {
>   	struct efi_mem_list *lmem;
> @@ -268,10 +268,10 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 =
pages,
>   	struct efi_event *evt;
>
>   	EFI_PRINT("%s: 0x%llx 0x%llx %d %s\n", __func__,
> -		  start, pages, memory_type, overlap_conventional ?
> +		  start, pages, mem_type, overlap_conventional ?
>   		  "yes" : "no");
>
> -	if (memory_type >=3D EFI_MAX_MEMORY_TYPE)
> +	if (mem_type >=3D EFI_MAX_MEMORY_TYPE)
>   		return EFI_INVALID_PARAMETER;
>
>   	if (!pages)
> @@ -281,12 +281,12 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 =
pages,
>   	newlist =3D calloc(1, sizeof(*newlist));
>   	if (!newlist)
>   		return EFI_OUT_OF_RESOURCES;
> -	newlist->desc.type =3D memory_type;
> +	newlist->desc.type =3D mem_type;
>   	newlist->desc.physical_start =3D start;
>   	newlist->desc.virtual_start =3D start;
>   	newlist->desc.num_pages =3D pages;
>
> -	switch (memory_type) {
> +	switch (mem_type) {
>   	case EFI_RUNTIME_SERVICES_CODE:
>   	case EFI_RUNTIME_SERVICES_DATA:
>   		newlist->desc.attribute =3D EFI_MEMORY_WB | EFI_MEMORY_RUNTIME;
> @@ -370,14 +370,15 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 =
pages,
>   	return EFI_SUCCESS;
>   }
>
> -efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type)
> +efi_status_t efi_add_memory_map(u64 start, u64 size,
> +				enum efi_memory_type mem_type)
>   {
>   	u64 pages;
>
>   	pages =3D efi_size_in_pages(size + (start & EFI_PAGE_MASK));
>   	start &=3D ~EFI_PAGE_MASK;
>
> -	return efi_add_memory_map_pg(start, pages, memory_type, false);
> +	return efi_add_memory_map_pg(start, pages, mem_type, false);
>   }
>
>   /**
> @@ -416,7 +417,7 @@ static efi_status_t efi_check_allocated(u64 addr, bo=
ol must_be_allocated)
>   }
>
>   efi_status_t efi_allocate_pages(enum efi_allocate_type type,
> -				enum efi_memory_type memory_type,
> +				enum efi_memory_type mem_type,
>   				efi_uintn_t pages, uint64_t *memory)
>   {
>   	u64 efi_addr, len;
> @@ -425,8 +426,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_ty=
pe type,
>   	phys_addr_t addr;
>
>   	/* Check import parameters */
> -	if (memory_type >=3D EFI_PERSISTENT_MEMORY_TYPE &&
> -	    memory_type <=3D 0x6FFFFFFF)
> +	if (mem_type >=3D EFI_PERSISTENT_MEMORY_TYPE && mem_type <=3D 0x6fffff=
ff)
>   		return EFI_INVALID_PARAMETER;
>   	if (!memory)
>   		return EFI_INVALID_PARAMETER;
> @@ -469,7 +469,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_ty=
pe type,
>
>   	efi_addr =3D (u64)(uintptr_t)map_sysmem(addr, 0);
>   	/* Reserve that map in our memory maps */
> -	ret =3D efi_add_memory_map_pg(efi_addr, pages, memory_type, true);
> +	ret =3D efi_add_memory_map_pg(efi_addr, pages, mem_type, true);
>   	if (ret !=3D EFI_SUCCESS) {
>   		/* Map would overlap, bail out */
>   		lmb_free_flags(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
> @@ -522,7 +522,8 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uin=
tn_t pages)
>   	return ret;
>   }
>
> -void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
> +void *efi_alloc_aligned_pages(u64 len, enum efi_memory_type mem_type,
> +			      size_t align)
>   {
>   	u64 req_pages =3D efi_size_in_pages(len);
>   	u64 true_pages =3D req_pages + efi_size_in_pages(align) - 1;
> @@ -540,12 +541,12 @@ void *efi_alloc_aligned_pages(u64 len, int memory_=
type, size_t align)
>   		return NULL;
>
>   	if (align < EFI_PAGE_SIZE) {
> -		r =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, memory_type,
> +		r =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, mem_type,
>   				       req_pages, &mem);
>   		return (r =3D=3D EFI_SUCCESS) ? (void *)(uintptr_t)mem : NULL;
>   	}
>
> -	r =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, memory_type,
> +	r =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, mem_type,
>   			       true_pages, &mem);
>   	if (r !=3D EFI_SUCCESS)
>   		return NULL;
> @@ -566,7 +567,7 @@ void *efi_alloc_aligned_pages(u64 len, int memory_ty=
pe, size_t align)
>   	return (void *)(uintptr_t)aligned_mem;
>   }
>
> -efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uint=
n_t size, void **buffer)
> +efi_status_t efi_allocate_pool(enum efi_memory_type mem_type, efi_uintn=
_t size, void **buffer)
>   {
>   	efi_status_t r;
>   	u64 addr;
> @@ -582,7 +583,7 @@ efi_status_t efi_allocate_pool(enum efi_memory_type =
pool_type, efi_uintn_t size,
>   		return EFI_SUCCESS;
>   	}
>
> -	r =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, pool_type, num_pages,
> +	r =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, mem_type, num_pages,
>   			       &addr);
>   	if (r =3D=3D EFI_SUCCESS) {
>   		alloc =3D (struct efi_pool_allocation *)(uintptr_t)addr;

