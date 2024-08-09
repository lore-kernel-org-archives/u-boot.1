Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD38C52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 16:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7239E88B07;
	Fri,  9 Aug 2024 18:33:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="qCMMMmai";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C0CC889B8; Fri,  9 Aug 2024 18:33:44 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EF5288A2F
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 18:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1723221220; x=1723826020; i=xypron.glpk@gmx.de;
 bh=kNzGWl29sldY1UEzH8DQYpG4SzK3IyUdGLseAkUxZUc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qCMMMmaidAhhhsN3cCHKrJLksovslFeLWZZzHfdmxIbLOn4q1Ej9c4z17m1BtRNb
 jRoDiTGAuOiwIqeRkutt3pI7Se14xqrBcLujojx9+I3ho4wbcQ3swUDY9VvfbXOlg
 mCYMNFwmpMOnpKXZPQEpjmsKunySVL3kYIBbSXQT4Ja03J/YYJzA81hJ55oUDMw0a
 xMC3Bt0/BZxXlUk1mHy5NK4mUWy+GxR5DcEBkW9Qrs81ieQc/irIqg3/7tCObuhjO
 dA9CcRBu+jS+DyFP1e0uc0By0byo6AWzWmyARAgh5Jg2w70ULoPWNkO+qw6/IC+Ln
 V0r5f2ptrp2M6dbSBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([178.202.41.98]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXp5a-1shwiW1cey-00Xpcz; Fri, 09
 Aug 2024 18:33:40 +0200
Message-ID: <81a85e93-5712-4262-9f68-cd6a93624beb@gmx.de>
Date: Fri, 9 Aug 2024 18:33:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] efi: Allow use of malloc() for the EFI pool
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240801173637.1071068-1-sjg@chromium.org>
 <20240801173637.1071068-2-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240801173637.1071068-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qRLaI1oMiAD13Ux+wKJxsAsSDmiielmEVJX2vd768/ku3/p4GwP
 88PWIWKLTdF8+w/PdSWIGYUSnqo7IWVI4lDzE/CtOJv0BMGIo4IHKzt1Z+wHcVhvqdjT4g+
 wcin+L1pWo8GCGhBPR3bqMfqIH2Z+XFFnBIaoL4PNP3lHrmXZhoPPiseXd1pFmoibY0RT11
 +AljWkoFDK/YEiUqAYALQ==
UI-OutboundReport: notjunk:1;M01:P0:/11Dnd+uSeA=;/esz1Amfl5QX38ua7kfvzSJgfd+
 8+8yI7U4yepLyAl98oEwRzJLBEP6GU+iAhXMyvxyRbkw71kciATrCpuY1onsdta+APEWRM9SW
 mcR9KyHZF8drOdPJNZhHu6IYr2WK5dzAQdGUHgJKWufs1KtCw1NgYPVK5KXWbN6hKTFPhsxLY
 evN3TKvEOGRJAN7cTvLbCcdbLcHMhvBPKIKspuZjN2gNVVfPpKERLAXZt62fFFOk2MCjvS0fF
 WSfSSV0y69h4ontnxd07tgADb9ZHVDatVx8GKSEWTWiq07l7vR8TGPMMTBA9aj7dqS6cXRp5D
 Zz/VcGtuvoZf6oJBch4iUFcrlXr+BgHZPA+zpYjsARNL61N3gEIAJo1+npPSGN0hNYRHjK6qi
 nGKx0027nWMG2U3l7ITO50NF1lnPIsqaNUoqIFai4Y+0X1UtLiu7oBxZvOjTeIfOjDTVCLSob
 v6Bm0gSDZ9DLg2ks/xH6PZzQPapECmDHR6M1U50dooPW0qvZhlkGweMckE9snY4x/5bm7ETQx
 uFgNsr6snxe5MCPubiiIEmutY4MxUN66Vgj6I48IilnlsaiGegq19Pcw6gRnhKQgyn76jY7fk
 sT1N+pGLTRZvfhlbWreYMeZDEr0KOfz8/AD4Uh2vKWYaZU4lcCTZX3kAIb1k0VdpwDGWDgFG7
 I0B1njaxmBZbHYCFfJtmPmZC2DXJpft87cB40hozLtRY8RmoZcsS4c8DK0lObDX86gGFGoJG8
 GldReGNPUFZ6qsfERHcIMfJRVvqLngg8QSJ3AXzDHwoIQxJyAIeCzjHj/04frW7KcW4cTF8pR
 MumT2De2wkZo8RS8zQVzvpNQ==
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

On 01.08.24 19:36, Simon Glass wrote:
> This API call is intended for allocating small amounts of memory,
> similar to malloc(). The current implementation rounds up to whole pages
> which can waste large amounts of memory. It also implements its own
> malloc()-style header on each block.
>
> For certain allocations (those of type EFI_BOOT_SERVICES_DATA) we can
> use U-Boot's built-in malloc() instead, at least until the app starts.
> This avoids poluting the memory space with blocks of data which may
> interfere with boot scripts, etc.
>
> Once the app has started, there is no advantage to using malloc(), since
> it doesn't matter what memory is used: everything is under control of
> the EFI subsystem. Also, using malloc() after the app starts might
> result in running of memory, since U-Boot's malloc() space is typically
> quite small.
>
> In fact, malloc() is already used for most EFI-related allocations, so
> the impact of this change is fairly small.
>
> One side effect is that this seems to be showing up some bugs in the
> EFI code, since the malloc() pool becomes corrupted when running some of
> the tests.
>
> This has likely crept in due to the very large gaps between allocations
> (around 4KB), which provides a lot of leeway when the allocation size is
> too small. Work around this by increasing the size for now, until these
> (presumed) bugs are located.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   common/dlmalloc.c            |   7 +++
>   include/efi_loader.h         |  18 ++++++
>   include/malloc.h             |   7 +++
>   lib/efi_loader/efi_bootbin.c |   2 +
>   lib/efi_loader/efi_memory.c  | 110 ++++++++++++++++++++++++++---------
>   5 files changed, 117 insertions(+), 27 deletions(-)
>
> diff --git a/common/dlmalloc.c b/common/dlmalloc.c
> index 62e8557daa7..0bc77395035 100644
> --- a/common/dlmalloc.c
> +++ b/common/dlmalloc.c
> @@ -613,6 +613,13 @@ void mem_malloc_init(ulong start, ulong size)
>   #endif
>   }
>
> +bool malloc_check_in_range(void *ptr)
> +{
> +	ulong val =3D (ulong)ptr;
> +
> +	return val >=3D mem_malloc_start && val < mem_malloc_end;
> +}
> +
>   /* field-extraction macros */
>
>   #define first(b) ((b)->fd)
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index f84852e384f..31899bef99e 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -796,6 +796,24 @@ int efi_disk_probe(void *ctx, struct event *event);
>   int efi_disk_remove(void *ctx, struct event *event);
>   /* Called by board init to initialize the EFI memory map */
>   int efi_memory_init(void);
> +
> +/**
> + * enum efi_alloc_flags - controls EFI memory allocation
> + *
> + * @EFIAF_USE_MALLOC: Use malloc() pool for pool allocations of type
> + *	EFI_BOOT_SERVICES_DATA, otherwise use page allocation
> + */
> +enum efi_alloc_flags {
> +	EFIAF_USE_MALLOC	=3D BIT(0),
> +};
> +
> +/**
> + * efi_set_alloc() - Set behaviour of EFI memory allocation
> + *
> + * @flags: new value for allocation flags (see enum efi_alloc_flags)
> + */
> +void efi_set_alloc(int flags);
> +
>   /* Adds new or overrides configuration table entry to the system table=
 */
>   efi_status_t efi_install_configuration_table(const efi_guid_t *guid, v=
oid *table);
>   /* Sets up a loaded image */
> diff --git a/include/malloc.h b/include/malloc.h
> index 07d3e90a855..a64f117e2f2 100644
> --- a/include/malloc.h
> +++ b/include/malloc.h
> @@ -983,6 +983,13 @@ extern ulong mem_malloc_brk;
>
>   void mem_malloc_init(ulong start, ulong size);
>
> +/**
> + * malloc_check_in_range() - Check if a pointer is within the malloc() =
region
> + *
> + * Return: true if within malloc() region
> + */
> +bool malloc_check_in_range(void *ptr);
> +
>   #ifdef __cplusplus
>   };  /* end of extern "C" */
>   #endif
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index a87006b3c0e..5bb0fdcf75d 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -201,6 +201,8 @@ efi_status_t efi_binary_run(void *image, size_t size=
, void *fdt)
>   {
>   	efi_status_t ret;
>
> +	efi_set_alloc(0);
> +
>   	/* Initialize EFI drivers */
>   	ret =3D efi_init_obj_list();
>   	if (ret !=3D EFI_SUCCESS) {
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index c6f1dd09456..3c3d05eef94 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -24,6 +24,14 @@ DECLARE_GLOBAL_DATA_PTR;
>   /* Magic number identifying memory allocated from pool */
>   #define EFI_ALLOC_POOL_MAGIC 0x1fe67ddf6491caa2
>
> +/* Flags controlling EFI memory-allocation - see enum efi_alloc_flags *=
/
> +static int alloc_flags;
> +
> +void efi_set_alloc(int flags)
> +{
> +	alloc_flags =3D flags;
> +}
> +
>   efi_uintn_t efi_memory_map_key;
>
>   struct efi_mem_list {
> @@ -57,8 +65,12 @@ void *efi_bounce_buffer;
>    * The checksum calculated in function checksum() is used in FreePool(=
) to avoid
>    * freeing memory not allocated by AllocatePool() and duplicate freein=
g.
>    *
> - * EFI requires 8 byte alignment for pool allocations, so we can
> - * prepend each allocation with these header fields.
> + * EFI requires 8-byte alignment for pool allocations, so we can prepen=
d each
> + * allocation with these header fields.
> + *
> + * Note that before the EFI app is booted, EFI_BOOT_SERVICES_DATA alloc=
ations
> + * are served using malloc(), bypassing this struct. This helps to avoi=
d memory
> + * fragmentation, since efi_allocate_pages() uses any pages it likes.
>    */
>   struct efi_pool_allocation {
>   	u64 num_pages;
> @@ -631,18 +643,19 @@ void *efi_alloc_aligned_pages(u64 len, int memory_=
type, size_t align)
>   /**
>    * efi_allocate_pool - allocate memory from pool
>    *
> + * This uses malloc() for EFI_BOOT_SERVICES_DATA allocations if EFIAF_U=
SE_MALLOC
> + * is enabled
> + *
>    * @pool_type:	type of the pool from which memory is to be allocated
>    * @size:	number of bytes to be allocated
>    * @buffer:	allocated memory
>    * Return:	status code
>    */
> -efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uint=
n_t size, void **buffer)
> +efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uint=
n_t size,
> +			       void **buffer)
>   {
>   	efi_status_t r;
>   	u64 addr;
> -	struct efi_pool_allocation *alloc;
> -	u64 num_pages =3D efi_size_in_pages(size +
> -					  sizeof(struct efi_pool_allocation));
>
>   	if (!buffer)
>   		return EFI_INVALID_PARAMETER;
> @@ -652,13 +665,43 @@ efi_status_t efi_allocate_pool(enum efi_memory_typ=
e pool_type, efi_uintn_t size,
>   		return EFI_SUCCESS;
>   	}
>
> -	r =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, pool_type, num_pages,
> -			       &addr);
> -	if (r =3D=3D EFI_SUCCESS) {
> -		alloc =3D (struct efi_pool_allocation *)(uintptr_t)addr;
> -		alloc->num_pages =3D num_pages;
> -		alloc->checksum =3D checksum(alloc);
> -		*buffer =3D alloc->data;
> +	if ((alloc_flags & EFIAF_USE_MALLOC) &&
> +	    pool_type =3D=3D EFI_BOOT_SERVICES_DATA) {
> +		void *ptr;
> +
> +		/*
> +		 * Some tests crash on qemu_arm etc. if the correct size is
> +		 * allocated.
> +		 * Adding 0x10 seems to fix test_efi_selftest_device_tree
> +		 * Increasing it to 0x20 seems to fix test_efi_selftest_base
> +		 * except * for riscv64 (in CI only). But 0x100 fixes CI too.
> +		 *
> +		 * This workaround can be dropped once these problems are
> +		 * resolved
> +		 */
> +		ptr =3D memalign(8, size + 0x100);

We don't want voodoo code. Please, analyze what is going on.

The allocations were cache line size aligned (0x40) because our
file-system drivers rely on it.

> +		if (!ptr)
> +			return EFI_OUT_OF_RESOURCES;

This will not work for allocating more memory than is in the malloc pool
as pointed out in a previous review comment. The malloc pool is 2 MiB or
less.

An EFI program can reasonable expect that the largest chunk of
unallocated conventional memory reported in the memory map can be
allocated with AllocatePool().

How will this code allocate 6 GiB on a 16 GiB board?

We should not have different code paths depending on the EFI memory type.

A reasonable solution would be a single memory allocator replacing
malloc(), LMB(), and the EFI memory management which is aware of EFI
memory types.

Best regards

Heinrich

> +
> +		*buffer =3D ptr;
> +		r =3D EFI_SUCCESS;
> +		log_debug("EFI pool: malloc(%zx) =3D %p\n", size, ptr);
> +	} else {
> +		u64 num_pages =3D efi_size_in_pages(size +
> +					sizeof(struct efi_pool_allocation));
> +
> +		r =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, pool_type,
> +				       num_pages, &addr);
> +		if (r =3D=3D EFI_SUCCESS) {
> +			struct efi_pool_allocation *alloc;
> +
> +			alloc =3D (struct efi_pool_allocation *)(uintptr_t)addr;
> +			alloc->num_pages =3D num_pages;
> +			alloc->checksum =3D checksum(alloc);
> +			*buffer =3D alloc->data;
> +			log_debug("EFI pool: pages alloc(%zx) type %d =3D %p\n",
> +				  size, pool_type, *buffer);
> +		}
>   	}
>
>   	return r;
> @@ -695,27 +738,37 @@ void *efi_alloc(size_t size)
>   efi_status_t efi_free_pool(void *buffer)
>   {
>   	efi_status_t ret;
> -	struct efi_pool_allocation *alloc;
>
>   	if (!buffer)
>   		return EFI_INVALID_PARAMETER;
>
> -	ret =3D efi_check_allocated((uintptr_t)buffer, true);
> -	if (ret !=3D EFI_SUCCESS)
> -		return ret;
> +	if (malloc_check_in_range(buffer)) {
> +		log_debug("EFI pool: free(%p)\n", buffer);
> +		free(buffer);
> +		ret =3D EFI_SUCCESS;
> +	} else {
> +		struct efi_pool_allocation *alloc;
>
> -	alloc =3D container_of(buffer, struct efi_pool_allocation, data);
> +		ret =3D efi_check_allocated((uintptr_t)buffer, true);
> +		if (ret !=3D EFI_SUCCESS)
> +			return ret;
>
> -	/* Check that this memory was allocated by efi_allocate_pool() */
> -	if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
> -	    alloc->checksum !=3D checksum(alloc)) {
> -		printf("%s: illegal free 0x%p\n", __func__, buffer);
> -		return EFI_INVALID_PARAMETER;
> -	}
> -	/* Avoid double free */
> -	alloc->checksum =3D 0;
> +		alloc =3D container_of(buffer, struct efi_pool_allocation, data);
>
> -	ret =3D efi_free_pages((uintptr_t)alloc, alloc->num_pages);
> +		/*
> +		 * Check that this memory was allocated by efi_allocate_pool()
> +		 */
> +		if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
> +		    alloc->checksum !=3D checksum(alloc)) {
> +			printf("%s: illegal free 0x%p\n", __func__, buffer);
> +			return EFI_INVALID_PARAMETER;
> +		}
> +		/* Avoid double free */
> +		alloc->checksum =3D 0;
> +
> +		ret =3D efi_free_pages((uintptr_t)alloc, alloc->num_pages);
> +		log_debug("EFI pool: pages free(%p)\n", buffer);
> +	}
>
>   	return ret;
>   }
> @@ -935,6 +988,9 @@ static void add_u_boot_and_runtime(void)
>
>   int efi_memory_init(void)
>   {
> +	/* use malloc() pool where possible */
> +	efi_set_alloc(EFIAF_USE_MALLOC);
> +
>   	efi_add_known_memory();
>
>   	add_u_boot_and_runtime();

