Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BE3D3B7CA
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 09:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 348BD8961E;
	Tue, 26 Nov 2024 10:30:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="M/Q3tLHX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E41B789650; Tue, 26 Nov 2024 10:30:43 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99FFD8932F
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 10:30:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732613437; x=1733218237; i=xypron.glpk@gmx.de;
 bh=AJfGfStYlq4Hr4ZnnqBr+IaXZe2UUOyivYK5n7+KA6Y=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=M/Q3tLHX/s2RKKQVnO79jDnIv0cvAJRm2tWHVUTD0emCJIRHXQ4KQ1wK4CdKnzYg
 s5OHFq4BW8Cv9acM4VH+usdjOlWxCpfCvkWr9hX91D2LVCTAEz1SXMdker5iqT1e1
 gxa64mEjk0jIrOjVd6uKDfoJWEEjmEEH9D/ye+XyJk3D3Gk1+do3DwOISrpfzR6Rj
 bUMT0Pi0tPaED+50AFrIaD0IfC7dU/yw9D7tEExcBi75LKZaVqfNaEZNzxDrKavXH
 92Zk3GzCHv4w5ljxgbGlJ79qmrv4fQOe+mlJ6NZaT1a+ZE3sVBLSWa24sl41U3+Bs
 OrgKgdSHik+awMSNfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMGRA-1sxmot2hVe-00W6TN; Tue, 26
 Nov 2024 10:30:37 +0100
Message-ID: <d415c887-bb0c-47e8-bfd4-d0049f596367@gmx.de>
Date: Tue, 26 Nov 2024 10:30:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] efi_loader: Move some memory-function comments to
 header
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-6-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241125204456.1525752-6-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ziotyvjIFc9rarrDE81DA0Yz43OlwwAIFOJQymU4cuFlkhoD6qf
 3LcTvnTT8ysiIK5IoGcNg7QioRrxukDFCLuG46k7U5wmgcCENb90UsEJEroENkQsWvdbuXw
 W+WGyq470yh91hPbV4j6xkkbwAlNFYiD8zi5jt9bpG10iRXXnwnNO9eejmUolhxEde75eKR
 zMjtPuTw/D9yzjGfqxMKA==
UI-OutboundReport: notjunk:1;M01:P0:pMFrISAIO+M=;TSWch+l+/4GaGA+FGkdXNOpSMtx
 6hABydDryHXIfNGfsQTVpPEulBaGjeegadPFUMbz8AAZr6XmFlLWepQdXuSiuhqdSLtwgKXNQ
 FfSN0lZVoqrFI0A1ZEa29sc9pgcKPLjm/u6pEp1jCw0XkcxJiPqvo+FK6ZDThTCwdUbS8tqpL
 +ot87Bdti2sf+F2plHz8RuiLAHkyL+/yXfLXCTv4tc3ptxVjShsDYBoMZWWpW1mFjMpiNNEKu
 dEe6h6w96ydeBtJtuRRTjzrtyPyCeFDPR5Kdg29s2ULknctvpcPK168R9aYueIBEiToVrA8Fh
 smzZ6k7FhuAByFKamlITLVbg94gI7vN1RgZTaeU8i4X0m4IRIn0lw1KrvD/GBx0BKy+3cBbEc
 IWSJT+pXleLM2MKOkOEqQUA9+eZOnxn/h8wdNv1PPc0ZAyUbiQmGK23mkhG2hTCztE732J3xB
 lt1MJzzKuiO7y2G117HpLlEIGr/HfH5Abe40lb60BtQLZB47yvmd4zPS3M+LRZh4htn6j+VZy
 lXUBgSzrvEJEYRHl3Z19ErlAawcU7UaCQ3+3J8IqMCywp9mwg6aicHiotxNiYECKDEyZgdaYb
 sHfHg31Cwy9lG8bHnmwS9mellrz+hK751K+vfmU9Nsy94FKH16f+h2iAF187sUjsj62Xcg9qz
 4/ZZVrJAMPa3M1gCeBmOcjywX9YukHJCrfvMiWQ7DzL+XxyMfDLdA3unh9LKh60FtF9F10gJx
 p77XKFOLfdNihiV0UQswEuxY+eT5Lb/zUiab3ivAJyr/Q1m8N65JtnnoAAjlQuluHh+toMucj
 yF9VuTCL+LwtFT/U0xPoDLq9duGlJa+evzPJrd+1JzsJ3KsDiCUJEA1euGXdlIs7OsS+c2tyX
 Xe7jlw5GhZRNQe63J9NrEUnqCdOrs8VrAnUaSxoowzIgoM7zctWSUPvWP
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
> Exported functions should be documented in the header file, not the
> implementation. We tend to make such updates on a piecemeal basis to
> avoid a 'flag day'. Move some comments related to memory allocation to
> follow the convention.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Please, have a look at this line in doc/

doc/api/efi.rst:78:
.. kernel-doc:: lib/efi_loader/efi_memory.c

Should we use a separate header efi_memory.h?

Best regards

Heinrich

> ---
>
>   include/efi_loader.h        | 70 ++++++++++++++++++++++++++++++++-----
>   lib/efi_loader/efi_memory.c | 62 --------------------------------
>   2 files changed, 62 insertions(+), 70 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 39809eac1bc..ff7adc1e2a2 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -758,21 +758,68 @@ efi_status_t efi_next_variable_name(efi_uintn_t *s=
ize, u16 **buf,
>    * Return:	size in pages
>    */
>   #define efi_size_in_pages(size) (((size) + EFI_PAGE_MASK) >> EFI_PAGE_=
SHIFT)
> -/* Allocate boot service data pool memory */
> +
> +/**
> + * efi_alloc() - allocate boot-services-data pool-memory
> + *
> + * Allocate memory from pool and zero it out.
> + *
> + * @size:	number of bytes to allocate
> + * Return:	pointer to allocated memory or NULL
> + */
>   void *efi_alloc(size_t len);
> -/* Allocate pages on the specified alignment */
> +
> +/**
> + * efi_alloc_aligned_pages() - allocate aligned memory pages
> + *
> + * @len:		len in bytes
> + * @memory_type:	usage type of the allocated memory
> + * @align:		alignment in bytes
> + * Return:		aligned memory or NULL
> + */
>   void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align);
> -/* More specific EFI memory allocator, called by EFI payloads */
> +
> +/**
> + * efi_allocate_pages - allocate memory pages
> + *
> + * @type:		type of allocation to be performed
> + * @memory_type:	usage type of the allocated memory
> + * @pages:		number of pages to be allocated
> + * @memory:		returns a pointer to the allocated memory
> + * Return:		status code
> + */
>   efi_status_t efi_allocate_pages(enum efi_allocate_type type,
>   				enum efi_memory_type memory_type,
>   				efi_uintn_t pages, uint64_t *memory);
> -/* EFI memory free function. */
> +
> +/**
> + * efi_free_pages() - free memory pages
> + *
> + * @memory:	start of the memory area to be freed
> + * @pages:	number of pages to be freed
> + * Return:	status code
> + */
>   efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages);
> -/* EFI memory allocator for small allocations */
> +
> +/**
> + * efi_allocate_pool - allocate memory from pool
> + *
> + * @pool_type:	type of the pool from which memory is to be allocated
> + * @size:	number of bytes to be allocated
> + * @buffer:	allocated memory
> + * Return:	status code
> + */
>   efi_status_t efi_allocate_pool(enum efi_memory_type pool_type,
>   			       efi_uintn_t size, void **buffer);
> -/* EFI pool memory free function. */
> +
> +/**
> + * efi_free_pool() - free memory from pool
> + *
> + * @buffer:	start of memory to be freed
> + * Return:	status code
> + */
>   efi_status_t efi_free_pool(void *buffer);
> +
>   /* Allocate and retrieve EFI memory map */
>   efi_status_t efi_get_memory_map_alloc(efi_uintn_t *map_size,
>   				      struct efi_mem_desc **memory_map);
> @@ -782,7 +829,14 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory=
_map_size,
>   				efi_uintn_t *map_key,
>   				efi_uintn_t *descriptor_size,
>   				uint32_t *descriptor_version);
> -/* Adds a range into the EFI memory map */
> +
> +/**
> + * efi_add_memory_map() - Add a range into the EFI memory map
> + * @start: start address, must be a multiple of EFI_PAGE_SIZE
> + * @size: Size, in bytes
> + * @memory_type: EFI type of memory added
> + * Return: status code
> + */
>   efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
>
>   /**
> @@ -791,7 +845,7 @@ efi_status_t efi_add_memory_map(u64 start, u64 size,=
 int memory_type);
>    * @start:			start address, must be a multiple of
>    *				EFI_PAGE_SIZE
>    * @pages:			number of pages to add
> - * @memory_type:		type of memory added
> + * @memory_type:		EFI type of memory added
>    * @overlap_conventional:	region may only overlap free(conventional)
>    *				memory
>    * Return:			status code
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 8b01821a993..7c8d9485094 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -257,17 +257,6 @@ static s64 efi_mem_carve_out(struct efi_mem_list *m=
ap,
>   	return EFI_CARVE_LOOP_AGAIN;
>   }
>
> -/**
> - * efi_add_memory_map_pg() - add pages to the memory map
> - *
> - * @start:			start address, must be a multiple of
> - *				EFI_PAGE_SIZE
> - * @pages:			number of pages to add
> - * @memory_type:		type of memory added
> - * @overlap_conventional:	region may only overlap free(conventional)
> - *				memory
> - * Return:			status code
> - */
>   efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
>   				   int memory_type,
>   				   bool overlap_conventional)
> @@ -381,18 +370,6 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 p=
ages,
>   	return EFI_SUCCESS;
>   }
>
> -/**
> - * efi_add_memory_map() - add memory area to the memory map
> - *
> - * @start:		start address of the memory area
> - * @size:		length in bytes of the memory area
> - * @memory_type:	type of memory added
> - *
> - * Return:		status code
> - *
> - * This function automatically aligns the start and size of the memory =
area
> - * to EFI_PAGE_SIZE.
> - */
>   efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type)
>   {
>   	u64 pages;
> @@ -438,15 +415,6 @@ static efi_status_t efi_check_allocated(u64 addr, b=
ool must_be_allocated)
>   	return EFI_NOT_FOUND;
>   }
>
> -/**
> - * efi_allocate_pages - allocate memory pages
> - *
> - * @type:		type of allocation to be performed
> - * @memory_type:	usage type of the allocated memory
> - * @pages:		number of pages to be allocated
> - * @memory:		allocated memory
> - * Return:		status code
> - */
>   efi_status_t efi_allocate_pages(enum efi_allocate_type type,
>   				enum efi_memory_type memory_type,
>   				efi_uintn_t pages, uint64_t *memory)
> @@ -554,14 +522,6 @@ efi_status_t efi_free_pages(uint64_t memory, efi_ui=
ntn_t pages)
>   	return ret;
>   }
>
> -/**
> - * efi_alloc_aligned_pages() - allocate aligned memory pages
> - *
> - * @len:		len in bytes
> - * @memory_type:	usage type of the allocated memory
> - * @align:		alignment in bytes
> - * Return:		aligned memory or NULL
> - */
>   void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
>   {
>   	u64 req_pages =3D efi_size_in_pages(len);
> @@ -606,14 +566,6 @@ void *efi_alloc_aligned_pages(u64 len, int memory_t=
ype, size_t align)
>   	return (void *)(uintptr_t)aligned_mem;
>   }
>
> -/**
> - * efi_allocate_pool - allocate memory from pool
> - *
> - * @pool_type:	type of the pool from which memory is to be allocated
> - * @size:	number of bytes to be allocated
> - * @buffer:	allocated memory
> - * Return:	status code
> - */
>   efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uin=
tn_t size, void **buffer)
>   {
>   	efi_status_t r;
> @@ -642,14 +594,6 @@ efi_status_t efi_allocate_pool(enum efi_memory_type=
 pool_type, efi_uintn_t size,
>   	return r;
>   }
>
> -/**
> - * efi_alloc() - allocate boot services data pool memory
> - *
> - * Allocate memory from pool and zero it out.
> - *
> - * @size:	number of bytes to allocate
> - * Return:	pointer to allocated memory or NULL
> - */
>   void *efi_alloc(size_t size)
>   {
>   	void *buf;
> @@ -664,12 +608,6 @@ void *efi_alloc(size_t size)
>   	return buf;
>   }
>
> -/**
> - * efi_free_pool() - free memory from pool
> - *
> - * @buffer:	start of memory to be freed
> - * Return:	status code
> - */
>   efi_status_t efi_free_pool(void *buffer)
>   {
>   	efi_status_t ret;

