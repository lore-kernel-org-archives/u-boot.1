Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BDFE64AB4
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 14:33:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 474D2895C7;
	Tue,  3 Dec 2024 15:33:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="FGOKXTP7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CABB3893CB; Tue,  3 Dec 2024 15:33:13 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47FDF89328
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 15:33:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733236380; x=1733841180; i=xypron.glpk@gmx.de;
 bh=oJ9ID/40+1CoQy+4+EcX+ZzU0dwUJ5IbQduRMZo/1yM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=FGOKXTP7Ljjt5JJ9y48QLHyNOQhU+HwYkRAxamZfCDIcm6AxxhWsbPGH6AYVsDQZ
 NNX6eO/bjKqmgLAYKULValcwgGwlswSvCy0ZzoCs5XUgJJ8cAkrPrI53GLgmKnUH4
 Vs6jRvQKiYEynsnFsB3V6Rjp0svgeuRPBGsiyXgVkO4atyzayjmH0UyGEpL9pRqN0
 6Wbh7fjfi+t3PVupl+/NC2QsEiBDkHJ08y1nXI5J2hqWniKodOx7yTtBU+/3sUq+R
 +9VfCAdOwzguMpppXrYujg7Ivmkj3tP1O7fcI+9Pnjl1MGA3Z3hHaA6vqjHw/LMF3
 kRdwGITD5VEUUtfapA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbzuB-1tnhAp04AJ-00cAYa; Tue, 03
 Dec 2024 15:33:00 +0100
Message-ID: <20c4487c-f908-40ef-be05-1ac7eb7e8be6@gmx.de>
Date: Tue, 3 Dec 2024 15:32:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/25] efi_loader: Use the enum for memory type
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Janne Grunau <j@jannau.net>,
 Moritz Fischer <moritzf@google.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241201152505.1666789-1-sjg@chromium.org>
 <20241201152505.1666789-10-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241201152505.1666789-10-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FuB9SpxtsnLUc/YvZ04Ndj9naafiSVrhi5idt3jw0Mwzd5hA07h
 hscNtXHds9nG9JocxtDud2a1mGSauWJFPZkwc4qEy8xWA2GyrjvT+ql26Dp+BcB4bnRTjNU
 a6nG8TAc9Zl21uCfnqy1jJQaABXEK1IuCFUEwRE9vexwpFBHpSwuEu4Y14lrFk9/C2+5LgH
 QZP+wyt012fHTm663LZvA==
UI-OutboundReport: notjunk:1;M01:P0:z0KBbbTn1FM=;hbZ5PusaCzGRwHlBngDM5Qd6CQy
 OZEeNBs4Kkkcy4gNTIcmmHJ0PJale/YCAFwuNufnIiiNi4v8ZTCzprhwJjqOF4fwBqydTtLDv
 7+LLAaRtL+mFtlCbZvzR0EvExdzYkqGE7mm8vPbbsWndorM216FbiWvaSVqqf18Wy0aP7mqb9
 Kd6zV6Gmbt3yz8y4UNxKerIP57ffEcZMTL94V2nc2Gpx4xjkydUmrLxSNyLTnzU0utAP3Oz7z
 gIeHP2GRDv7kNhYOnLA2D2fqC4dCliVHyGFi6NwlDRmDyGuDtV0BX8a/SeGrBmxDz/3+M0Pz+
 HnAuep1o0rfqBg0of3ekXy/Nk4gAPJOcsviDyRvfuskzy0iVyU/76k7dN/CPxwgjK//Dgmh/h
 Y/yFE241l84RYvpK6tM5Kg0lQB0Wx+XO3APpNkRqOmTFRGH7reo2XMeNvZ5xFjRKBmJ7y1ojy
 7Hak4SUMBUZrsOzA0CAIt0EgchwzfP5ur2juc0ue8TiKFwk9DjMlRjbY4EH3MKPVaKxz17mjK
 dxUM4pTj5WJixv5b933lgxdHO/q5ja+opfpq5ajP+OfhA4NKpmKE08uZ8+8/2ERzrU3FPiJfH
 p5QcHZU+qRC0eauff1C7IGUUF/zY0qKwnwNZp8cxzDbsp7YZ+unim0dXloEpXCDepd8HuRyOi
 S0tT7VGd+hwdc2S85dKV9KkmtduKB6HD8xnL/O5DU/d5lBbh7CbzP5Hr9gesCmoZYppDUDd6z
 /HqklLFAqTNykrnjELQ8kAat6vU5MDpqiScYvqoeq1iFkfbD98mVxTAda60OZw+JkM4ni0aF0
 q5nwu7YASBB7gLATXvh7u8m5vpy6Ol0g3IV5Fm5xyfZI6SzarUBdBDwcgfq/ADU+ViJmo3lPX
 GlCUMin6v4q7BrCmT7uKpib8jWbsxBWBP/qLYnpfzFql3ofVmFhZwI4PGUqZ5lBy8avZLCpMF
 tBOgnwRt7ZNs9xvKDFElTUCzcGLcEVBYc0kzP7N9UjTF6kqcqrjbc/7L1pdn2Ga/qIGxmjnaS
 vufrdVSHlIZuclADyfKIyfCbeN6afJV751YjY5V3UTRURFUaKWlf+5J6t/3rmM1Wz0djEaL/h
 5ykCvmDWiTRwOeqo+DpYLXfNx+xG2b
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

On 01.12.24 16:24, Simon Glass wrote:
> Rather than an integer, it is better to use the enum provided, when
> referring to an EFI memory-type. Update existing uses.
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

Simon, I have no clue why you keep ignoring reviews.
This is just annoying and won't lead to merging patches.

NAK

Best regards

Heinrich


> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Drop the changes to the boottime API
>
>   include/efi_loader.h             | 29 ++++++++++----------
>   lib/efi_loader/efi_boottime.c    | 12 ++++-----
>   lib/efi_loader/efi_device_path.c |  4 +--
>   lib/efi_loader/efi_memory.c      | 46 +++++++++++++++++---------------
>   4 files changed, 47 insertions(+), 44 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 3f75f2efcb6..a7228672f27 100644
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
> @@ -837,14 +838,14 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memor=
y_map_size,
>    *			actually a pointer provided as an integer. To pass in
>    *			an address, pass in (ulong)map_to_sysmem(addr)
>    * @size:		length in bytes of the memory area
> - * @memory_type:	type of memory added
> - *
> + * @mem_type:		EFI type of memory added
>    * Return:		status code
>    *
>    * This function automatically aligns the start and size of the memory=
 area
>    * to EFI_PAGE_SIZE.
>    */
> -efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
> +efi_status_t efi_add_memory_map(u64 start, u64 size,
> +				enum efi_memory_type mem_type);
>
>   /**
>    * efi_add_memory_map_pg() - add pages to the memory map
> @@ -854,13 +855,13 @@ efi_status_t efi_add_memory_map(u64 start, u64 siz=
e, int memory_type);
>    * in (ulong)map_to_sysmem(addr)
>    *
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
> @@ -919,7 +920,7 @@ struct efi_device_path *efi_dp_part_node(struct blk_=
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
> index f27b3827ed2..334a4d64b3f 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -415,9 +415,9 @@ static void EFIAPI efi_restore_tpl(efi_uintn_t old_t=
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
> @@ -426,14 +426,14 @@ static void EFIAPI efi_restore_tpl(efi_uintn_t old=
_tpl)
>    *
>    * Return: status code
>    */
> -static efi_status_t EFIAPI efi_allocate_pages_ext(int type, int memory_=
type,
> +static efi_status_t EFIAPI efi_allocate_pages_ext(int type, int mem_typ=
e,
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
> index 9d0f27dbb3e..3cece51f030 100644
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
> @@ -416,8 +417,8 @@ static efi_status_t efi_check_allocated(u64 addr, bo=
ol must_be_allocated)
>   }
>
>   efi_status_t efi_allocate_pages(enum efi_allocate_type type,
> -				enum efi_memory_type memory_type,
> -				efi_uintn_t pages, uint64_t *memory)
> +				enum efi_memory_type mem_type,
> +				efi_uintn_t pages, uint64_t *memoryp)
>   {
>   	u64 efi_addr, len;
>   	uint flags;
> @@ -425,10 +426,9 @@ efi_status_t efi_allocate_pages(enum efi_allocate_t=
ype type,
>   	phys_addr_t addr;
>
>   	/* Check import parameters */
> -	if (memory_type >=3D EFI_PERSISTENT_MEMORY_TYPE &&
> -	    memory_type <=3D 0x6FFFFFFF)
> +	if (mem_type >=3D EFI_PERSISTENT_MEMORY_TYPE && mem_type <=3D 0x6fffff=
ff)
>   		return EFI_INVALID_PARAMETER;
> -	if (!memory)
> +	if (!memoryp)
>   		return EFI_INVALID_PARAMETER;
>   	len =3D (u64)pages << EFI_PAGE_SHIFT;
>   	/* Catch possible overflow on 64bit systems */
> @@ -447,17 +447,17 @@ efi_status_t efi_allocate_pages(enum efi_allocate_=
type type,
>   		break;
>   	case EFI_ALLOCATE_MAX_ADDRESS:
>   		/* Max address */
> -		addr =3D map_to_sysmem((void *)(uintptr_t)*memory);
> +		addr =3D map_to_sysmem((void *)(uintptr_t)*memoryp);
>   		addr =3D (u64)lmb_alloc_base_flags(len, EFI_PAGE_SIZE, addr,
>   						 flags);
>   		if (!addr)
>   			return EFI_OUT_OF_RESOURCES;
>   		break;
>   	case EFI_ALLOCATE_ADDRESS:
> -		if (*memory & EFI_PAGE_MASK)
> +		if (*memoryp & EFI_PAGE_MASK)
>   			return EFI_NOT_FOUND;
>
> -		addr =3D map_to_sysmem((void *)(uintptr_t)*memory);
> +		addr =3D map_to_sysmem((void *)(uintptr_t)*memoryp);
>   		addr =3D (u64)lmb_alloc_addr_flags(addr, len, flags);
>   		if (!addr)
>   			return EFI_NOT_FOUND;
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
> @@ -477,7 +477,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_ty=
pe type,
>   		return  EFI_OUT_OF_RESOURCES;
>   	}
>
> -	*memory =3D efi_addr;
> +	*memoryp =3D efi_addr;
>
>   	return EFI_SUCCESS;
>   }
> @@ -515,7 +515,8 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uin=
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
> @@ -533,12 +534,12 @@ void *efi_alloc_aligned_pages(u64 len, int memory_=
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
> @@ -559,7 +560,8 @@ void *efi_alloc_aligned_pages(u64 len, int memory_ty=
pe, size_t align)
>   	return (void *)(uintptr_t)aligned_mem;
>   }
>
> -efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uint=
n_t size, void **buffer)
> +efi_status_t efi_allocate_pool(enum efi_memory_type mem_type, efi_uintn=
_t size,
> +			       void **buffer)
>   {
>   	efi_status_t r;
>   	u64 addr;
> @@ -575,7 +577,7 @@ efi_status_t efi_allocate_pool(enum efi_memory_type =
pool_type, efi_uintn_t size,
>   		return EFI_SUCCESS;
>   	}
>
> -	r =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, pool_type, num_pages,
> +	r =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, mem_type, num_pages,
>   			       &addr);
>   	if (r =3D=3D EFI_SUCCESS) {
>   		alloc =3D (struct efi_pool_allocation *)(uintptr_t)addr;

