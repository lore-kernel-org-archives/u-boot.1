Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBCAC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 15:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7338287C86;
	Thu, 25 Jul 2024 17:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="nzat+YVS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEC6087F19; Thu, 25 Jul 2024 17:49:58 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A58787C86
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 17:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1721922594; x=1722527394; i=xypron.glpk@gmx.de;
 bh=vek8wp5XkRX/N3UnjtHPG6dBTYkX9CZ00iKbMG9V8Hk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=nzat+YVSJJjZmPxrDT86T3Qdqucvfuu2yYGL1q2++MOQ7Gql3ViiJuHOUdOzgOKn
 mPycRZLeMoT/j6aP34mrISmeP2wLGbNXQ+nVpcOrq/EflG4QfYXs5T6ymEKf4fqv4
 eKvnOnUfTS6j94wLnr3LeRDIVCjCpi0/AzRfav8v2ZBtFV/zvpTc0fxSVQOF16VRd
 YVgUDMLn/2h+Q/1pFbQiF4eHYik3jZJ4KkhbO3CrlAJm8kFAcu4Ypin9dAX7aG2wB
 iG4zTJ1+Ga/O44oIxcPcNsf3MfNA4nLL3cqW9+JWuhPryE0hLY7lE5RkYyiWztWmU
 yb1MxrBWHo8fiZhsyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.93.80]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6KYl-1sDVxz1vXV-00xF00; Thu, 25
 Jul 2024 17:49:54 +0200
Message-ID: <72e02ed6-f8c3-4caa-8ae6-2cef00a2ddd2@gmx.de>
Date: Thu, 25 Jul 2024 17:49:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] efi: Use malloc() for the EFI pool
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240725135629.3505072-1-sjg@chromium.org>
 <20240725135629.3505072-6-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240725135629.3505072-6-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+5Qe4L9UMF5g/np+RFk8gaMbEqcYvBHL7xFxkHOtHxEnK1g0XXf
 6rmOTJHWptD82+T5tehi0pQgW5NL52Nseu+1Ns9tYPyzZknLSQqvgqVNG0uOr7actEbvW7e
 +EzDLLMSNahta+GxxbkzzEbibUGUMvshAgdda/69PL1p1dOGDtr5P/dQpEbutI3iqFE+gPv
 Q1yQVnf8Vu9vyUsSYf1eA==
UI-OutboundReport: notjunk:1;M01:P0:ETEdLeHnTj8=;8y87WaFZju2o5ZTGX5jZVEdAVWy
 D8Z8wRBTcHXkeUucY28k/GbuTlTJye4MejieHZb+9folh559Gg0pL+XHcGwd7Q0nVFw3D901g
 S4ZfykXZ9CKaJV8d2z/FVuFZsUCIw7VvDkNaOB1zA/XWk8u7zF3XQfKvlbe8Qo5owXvo7AEYn
 KjEJHlEcvC+vVaxnBU1ZnoUhHh+xqMsVJkYQd+1dPRBYhiRiI/jkPeby8RU1iN4P44M+BN1Cd
 s9D9B1MpXftVuW0l+SxAV1oGqyb6gGYZKJl8qYKEwhvSppSpQnJ2b+TxOy9v0IBwa1rpbrBA8
 kyfNYpw77xOVmFxN1caug6iAxvj1hsLRwFfbnQGq3jgXKNfSU+2tVI64G/ry/JhY1galLOr9z
 XuxZ6iXRtNpcjH10NDwLULiev8tfpquYBD/RHB2EdrIrfxlYpzxegn7acvw9pP8v73YLBBbgY
 0CnaHxuSAuS/Ip9tnfaOz1O9qL1O6p84ooz8jhxfg90awDQRuncCdlE6mhBtzj1Bu1TovFaKm
 cRTsPNl2r76ERcWgwxzLrFd0eB5FKlv3BEbtAL5Jfc4px2Nwy+iQY5zJGVVYVk1COSRfK84k6
 iahk//LPOyALsRkFmsYlGI3nbj/u0DWS4cU2mvDlgqx3JOD2gAltsXas1Fc46HhWkriOJzlc5
 q4as1EThg7MG7Fkvdm244XineqZZzkXRHR3HAS1s2YQsfjbgyxOtbE2FD9QNIU9xfAlwmKQ94
 MzESzId1u2sIrPNnTv88NPPwDj2oJw3NEyJbnMTdlSsTPSkZFZFVBzSmPdrEoM7NNq6GUQOP+
 OKH1p2DtNYslwug+QODo6tmQ==
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

On 25.07.24 15:56, Simon Glass wrote:
> This API call is intended for allocating small amounts of memory,
> similar to malloc(). The current implementation rounds up to whole pages
> which can waste large amounts of memory. It also implements its own
> malloc()-style header on each block.
>
> Use U-Boot's built-in malloc() instead, to avoid these problems:
>
> - it should normally be large enough for pool allocations
> - if it isn't we can enforce a minimum size for boards which use
>    EFI_LOADER
> - the existing mechanism may create an unwatned entry in the memory map
> - it is used for most EFI allocations already
>
> One side effect is that this seems to be showing up some bugs in the
> EFI code, since the malloc() pool becomes corrupted with some tests.
> This has likely crept in due to the very large gaps between allocations
> (around 4KB), which provides a lot of leeway when the allocation size is
> too small. Work around this by increasing the size for now, until these
> (presumed) bugs are located.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   lib/efi_loader/efi_memory.c | 93 ++++++++-----------------------------
>   1 file changed, 19 insertions(+), 74 deletions(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 2945f5648c7..fabe9e3a87a 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -80,45 +80,6 @@ static LIST_HEAD(efi_mem);
>   void *efi_bounce_buffer;
>   #endif
>
> -/**
> - * struct efi_pool_allocation - memory block allocated from pool
> - *
> - * @num_pages:	number of pages allocated
> - * @checksum:	checksum
> - * @data:	allocated pool memory
> - *
> - * U-Boot services each UEFI AllocatePool() request as a separate
> - * (multiple) page allocation. We have to track the number of pages
> - * to be able to free the correct amount later.
> - *
> - * The checksum calculated in function checksum() is used in FreePool()=
 to avoid
> - * freeing memory not allocated by AllocatePool() and duplicate freeing=
.
> - *
> - * EFI requires 8 byte alignment for pool allocations, so we can
> - * prepend each allocation with these header fields.
> - */
> -struct efi_pool_allocation {
> -	u64 num_pages;
> -	u64 checksum;
> -	char data[] __aligned(ARCH_DMA_MINALIGN);
> -};
> -
> -/**
> - * checksum() - calculate checksum for memory allocated from pool
> - *
> - * @alloc:	allocation header
> - * Return:	checksum, always non-zero
> - */
> -static u64 checksum(struct efi_pool_allocation *alloc)
> -{
> -	u64 addr =3D (uintptr_t)alloc;
> -	u64 ret =3D (addr >> 32) ^ (addr << 32) ^ alloc->num_pages ^
> -		  EFI_ALLOC_POOL_MAGIC;
> -	if (!ret)
> -		++ret;
> -	return ret;
> -}
> -
>   /**
>    * efi_mem_cmp() - comparator function for sorting memory map
>    *
> @@ -681,13 +642,10 @@ void *efi_alloc_aligned_pages(u64 len, int memory_=
type, size_t align)
>    * @buffer:	allocated memory
>    * Return:	status code
>    */
> -efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uint=
n_t size, void **buffer)
> +efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uint=
n_t size,
> +			       void **buffer)
>   {
> -	efi_status_t r;
> -	u64 addr;
> -	struct efi_pool_allocation *alloc;
> -	u64 num_pages =3D efi_size_in_pages(size +
> -					  sizeof(struct efi_pool_allocation));
> +	void *ptr;
>
>   	if (!check_allowed())
>   		return EFI_UNSUPPORTED;
> @@ -700,16 +658,21 @@ efi_status_t efi_allocate_pool(enum efi_memory_typ=
e pool_type, efi_uintn_t size,
>   		return EFI_SUCCESS;
>   	}

Unfortunately this patch does not match the UEFI specification:

Two different memory types cannot reside in the same memory page. You
have to keep track of the memory type of each allocated memory page and
report it in GetMemoryMap().

The specification is available https://uefi.org/specifications.

>
> -	r =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, pool_type, num_pages,
> -			       &addr);
> -	if (r =3D=3D EFI_SUCCESS) {
> -		alloc =3D (struct efi_pool_allocation *)(uintptr_t)addr;
> -		alloc->num_pages =3D num_pages;
> -		alloc->checksum =3D checksum(alloc);
> -		*buffer =3D alloc->data;
> -	}
> +	/*
> +	 * Some tests crash on qemu_arm etc. if the correct size is allocated.
> +	 * Adding 0x10 seems to fix test_efi_selftest_device_tree
> +	 * Increasing it to 0x20 seems to fix test_efi_selftest_base except
> +	 * for riscv64 (in CI only). But 0x100 fixes CI too.
> +	 *
> +	 * This workaround can be dropped once these problems are resolved
> +	 */
> +	ptr =3D memalign(8, size + 0x100);

We were using ARCH_DMA_MINALIGN before this patch.

If we are overwriting allocated memory, we must fix that instead of
increasing size. Do you have a git tag showing the problem?

Best regards

Heinrich

> +	if (!ptr)
> +		return EFI_OUT_OF_RESOURCES;
> +
> +	*buffer =3D ptr;
>
> -	return r;
> +	return EFI_SUCCESS;
>   }
>
>   /**
> @@ -742,30 +705,12 @@ void *efi_alloc(size_t size)
>    */
>   efi_status_t efi_free_pool(void *buffer)
>   {
> -	efi_status_t ret;
> -	struct efi_pool_allocation *alloc;
> -
>   	if (!buffer)
>   		return EFI_INVALID_PARAMETER;
>
> -	ret =3D efi_check_allocated((uintptr_t)buffer, true);
> -	if (ret !=3D EFI_SUCCESS)
> -		return ret;
> -
> -	alloc =3D container_of(buffer, struct efi_pool_allocation, data);
> -
> -	/* Check that this memory was allocated by efi_allocate_pool() */
> -	if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
> -	    alloc->checksum !=3D checksum(alloc)) {
> -		printf("%s: illegal free 0x%p\n", __func__, buffer);
> -		return EFI_INVALID_PARAMETER;
> -	}
> -	/* Avoid double free */
> -	alloc->checksum =3D 0;
> -
> -	ret =3D efi_free_pages((uintptr_t)alloc, alloc->num_pages);
> +	free(buffer);
>
> -	return ret;
> +	return EFI_SUCCESS;
>   }
>
>   /**

