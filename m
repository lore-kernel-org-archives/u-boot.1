Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74511E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 06:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB6CF894AD;
	Sun,  8 Dec 2024 07:57:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bFLII1J8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D7A988E5C; Sun,  8 Dec 2024 07:57:48 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24367894AD
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 07:57:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6eff5f99de4so9785337b3.1
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 22:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733641065; x=1734245865; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pRIcJ29rR+5D+irQt3YSG92EEPRS679lv42/h8A5gR0=;
 b=bFLII1J8vWKsJi0/Npfi+HGAG8SYX++bTBiCUyJb83CQigjMQpz9/xS7Ucxwp1QxpV
 m6kHR1S3Dn+ovjaMQTCbtS5Op+KJfJ2YCtqPcopjpxrlSPmRUSPNUO6ScyiAMwiykiDh
 Z5IvRf6ziQ9IHDPTdgI2WJ4JQ5hW6l+uNJpJNBbtDmpFQCtFeLpFmkmpxPHAqim50xG1
 7Pm34IKyx+4of1DCv4kdTNWtmE/CjVfcy3jyRr4mz4BWp3A9wsGdGqu66zw1yhojQcPi
 M4Zj/IjycZIwd8FL2bhiamCu08DwH48EndE27jwSP9uV46I5/w5pMzbLrZG1s3vVLXYP
 7nUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733641065; x=1734245865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pRIcJ29rR+5D+irQt3YSG92EEPRS679lv42/h8A5gR0=;
 b=IjXwi34MccL6e5X+PvoUwy0vfMTRJd1pZ4+uUeqo7Rq1AS5Lhp+YvgxNZAh0WoQB0j
 EINuWg80LkixdyFElakNlBWuFKGRDz45qnPe8e7O5NF/8iprjTZdUri2yINwFBcvoPEv
 zew91/L+JQiZi1UnCrrw6AhLoH2O8PtqJkPCLk7uN+DzAmkGBkNjSVcRsArOTHgm7CbO
 Mq7T/9JGHpdxymFuX7qogmtyzxEgtSrp27R3itK3C6BYmig3HmR/LL+r3/1Kp+ieMDsN
 F3hO5v4dFe70tMRT88X45npHR+e7x1SaxO5vHaysVQay4bRb0dfF2JpK6W22V2RJWnbw
 1wwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoraVRSXXlHKoRlE9diG5d6qWdH/X0KGUnr5IY/bsfyOPsNZ6fcjTJ7ILxTFV+8RNvUCqs0vQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzOYT4RKgq959Ps7j+1FatSFIjQB3uMfob3TvGj0qyCxnrueFBE
 1dGykM4nCMxpPMLDBmQR3GY+BjB2c7WKi04MWn/ciX9rPT4tnO73g5vOEBbfJTB7kV4lRW8TvQ4
 qhcYTX7r1+d5SfWBbTV6PwJ/+drJQiOW9s7zcOA==
X-Gm-Gg: ASbGncuiY+ZnDBsnlziPIBpkivBhPTb96ED0ppvK9bL1D0djr5E253XV84wCz3G0yQ2
 ezWstOCYnaMIjmUP2E2JKeSrnc/id08o=
X-Google-Smtp-Source: AGHT+IHQM3REE4OaKZGypuegNvIhjT1ON95tbsvR2ra0D9mNz2OZFM07+oFAPjPTmnPGsGYnBr2KIuf7rh+PuFXnLRU=
X-Received: by 2002:a05:690c:64c1:b0:6ef:8122:282f with SMTP id
 00721157ae682-6efe3c0dbecmr82310597b3.24.1733641064856; Sat, 07 Dec 2024
 22:57:44 -0800 (PST)
MIME-Version: 1.0
References: <20241208002121.31887-1-semen.protsenko@linaro.org>
 <20241208002121.31887-6-semen.protsenko@linaro.org>
In-Reply-To: <20241208002121.31887-6-semen.protsenko@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 8 Dec 2024 08:57:08 +0200
Message-ID: <CAC_iWjKb1N9H3GdkZixbTmwncFj+nhjQKVtRSJdpfbnz49QTtA@mail.gmail.com>
Subject: Re: [PATCH 5/6] lmb: Improve kernel-doc comments
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

There was a discussion recently on whether this should be in the .h or .c

But I don't really mind as long as we have a common policy

On Sun, 8 Dec 2024 at 02:21, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Fix warnings from kernel-doc script. Improve and unify overall style of
> kernel-doc comments in lmb source files. Move all kernel-doc comments
> for public functions into the header, as recommended in U-Boot
> documentation, which also takes care of existing duplication. While at
> it, do a bit of cosmetic cleanups as well.
>
> No functional change.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  include/lmb.h | 125 ++++++++++++++++++++++++++++++--------------------
>  lib/lmb.c     |  55 ----------------------
>  2 files changed, 74 insertions(+), 106 deletions(-)
>
> diff --git a/include/lmb.h b/include/lmb.h
> index f221f0cce8f7..03d5fac6aa79 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -1,6 +1,13 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Logical memory blocks.
> + *
> + * Copyright (C) 2001 Peter Bergner, IBM Corp.
> + */
> +
>  #ifndef _LINUX_LMB_H
>  #define _LINUX_LMB_H
> +
>  #ifdef __KERNEL__
>
>  #include <alist.h>
> @@ -8,21 +15,15 @@
>  #include <asm/u-boot.h>
>  #include <linux/bitops.h>
>
> -/*
> - * Logical memory blocks.
> - *
> - * Copyright (C) 2001 Peter Bergner, IBM Corp.
> - */
> -
> -#define LMB_ALLOC_ANYWHERE      0
> -#define LMB_ALIST_INITIAL_SIZE  4
> +#define LMB_ALLOC_ANYWHERE     0
> +#define LMB_ALIST_INITIAL_SIZE 4
>
>  /**
> - * enum lmb_flags - definition of memory region attributes
> - * @LMB_NONE: no special request
> - * @LMB_NOMAP: don't add to mmu configuration
> - * @LMB_NOOVERWRITE: the memory region cannot be overwritten/re-reserved
> - * @LMB_NONOTIFY: do not notify other modules of changes to this memory region
> + * enum lmb_flags - Definition of memory region attributes
> + * @LMB_NONE: No special request
> + * @LMB_NOMAP: Don't add to MMU configuration
> + * @LMB_NOOVERWRITE: The memory region cannot be overwritten/re-reserved
> + * @LMB_NONOTIFY: Do not notify other modules of changes to this memory region
>   */
>  enum lmb_flags {
>         LMB_NONE                = 0,
> @@ -32,11 +33,10 @@ enum lmb_flags {
>  };
>
>  /**
> - * struct lmb_region - Description of one region.
> - *
> - * @base:      Base address of the region.
> - * @size:      Size of the region
> - * @flags:     memory region attributes
> + * struct lmb_region - Description of one region
> + * @base: Base address of the region
> + * @size: Size of the region
> + * @flags: Memory region attributes
>   */
>  struct lmb_region {
>         phys_addr_t base;
> @@ -46,10 +46,9 @@ struct lmb_region {
>
>  /**
>   * struct lmb - The LMB structure
> - *
> - * @free_mem:  List of free memory regions
> - * @used_mem:  List of used/reserved memory regions
> - * @test:      Is structure being used for LMB tests
> + * @free_mem: List of free memory regions
> + * @used_mem: List of used/reserved memory regions
> + * @test: Is structure being used for LMB tests
>   */
>  struct lmb {
>         struct alist free_mem;
> @@ -58,51 +57,77 @@ struct lmb {
>  };
>
>  /**
> - * lmb_init() - Initialise the LMB module
> + * lmb_init() - Initialise the LMB module.
> + *
> + * Return: 0 on success, negative error code on failure.
>   *
>   * Initialise the LMB lists needed for keeping the memory map. There
> - * are two lists, in form of alloced list data structure. One for the
> + * are two lists, in form of allocated list data structure. One for the
>   * available memory, and one for the used memory. Initialise the two
>   * lists as part of board init. Add memory to the available memory
>   * list and reserve common areas by adding them to the used memory
>   * list.
> - *
> - * Return: 0 on success, -ve on error
>   */
>  int lmb_init(void);
>
>  /**
> - * lmb_add_memory() - Add memory range for LMB allocations
> + * lmb_add_memory() - Add memory range for LMB allocations.
>   *
>   * Add the entire available memory range to the pool of memory that
>   * can be used by the LMB module for allocations.
> - *
> - * Return: None
>   */
>  void lmb_add_memory(void);
>
>  long lmb_add(phys_addr_t base, phys_size_t size);
> -long lmb_reserve(phys_addr_t base, phys_size_t size);
> +
>  /**
> - * lmb_reserve_flags - Reserve one region with a specific flags bitfield.
> + * lmb_reserve() - Reserve a memory region (with no special flags)
> + * @base: Base address of the memory region
> + * @size: Size of the memory region
>   *
> - * @base:      base address of the memory region
> - * @size:      size of the memory region
> - * @flags:     flags for the memory region
> - * Return:     0 if OK, > 0 for coalesced region or a negative error code.
> + * Return: 0 on success, negative error code on failure.
> + */
> +long lmb_reserve(phys_addr_t base, phys_size_t size);
> +
> +/**
> + * lmb_reserve_flags() - Reserve one region with a specific flags bitfield
> + * @base: Base address of the memory region
> + * @size: Size of the memory region
> + * @flags: Flags for the memory region
> + *
> + * Return:
> + * * %0                - Added successfully, or it's already added (only if LMB_NONE)
> + * * %-EEXIST  - The region is already added, and flags != LMB_NONE
> + * * %-1       - Failure
>   */
>  long lmb_reserve_flags(phys_addr_t base, phys_size_t size,
>                        enum lmb_flags flags);
> +
>  phys_addr_t lmb_alloc(phys_size_t size, ulong align);
>  phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr);
>  phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size);
>  phys_size_t lmb_get_free_size(phys_addr_t addr);
>
> +/**
> + * lmb_alloc_base_flags() - Allocate specified memory region with specified
> + *                         attributes
> + * @size: Size of the region requested
> + * @align: Alignment of the memory region requested
> + * @max_addr: Maximum address of the requested region
> + * @flags: Memory region attributes to be set
> + *
> + * Allocate a region of memory with the attributes specified through the
> + * parameter. The max_addr parameter is used to specify the maximum address
> + * below which the requested region should be allocated.
> + *
> + * Return: Base address on success, 0 on error.
> + */
>  phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
>                                  phys_addr_t max_addr, uint flags);
>
>  /**
> - * lmb_alloc_addr_flags() - Allocate specified memory address with specified attributes
> + * lmb_alloc_addr_flags() - Allocate specified memory address with specified
> + *                         attributes
>   * @base: Base Address requested
>   * @size: Size of the region requested
>   * @flags: Memory region attributes to be set
> @@ -111,20 +136,21 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
>   * parameter. The base parameter is used to specify the base address
>   * of the requested region.
>   *
> - * Return: base address on success, 0 on error
> + * Return: Base address on success, 0 on error.
>   */
>  phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
>                                  uint flags);
>
>  /**
> - * lmb_is_reserved_flags() - test if address is in reserved region with flag bits set
> + * lmb_is_reserved_flags() - Test if address is in reserved region with flag
> + *                          bits set
> + * @addr: Address to be tested
> + * @flags: Bitmap with bits to be tested
>   *
>   * The function checks if a reserved region comprising @addr exists which has
>   * all flag bits set which are set in @flags.
>   *
> - * @addr:      address to be tested
> - * @flags:     bitmap with bits to be tested
> - * Return:     1 if matching reservation exists, 0 otherwise
> + * Return: 1 if matching reservation exists, 0 otherwise.
>   */
>  int lmb_is_reserved_flags(phys_addr_t addr, int flags);
>
> @@ -134,9 +160,7 @@ int lmb_is_reserved_flags(phys_addr_t addr, int flags);
>   * @size: Size of the region to be freed
>   * @flags: Memory region attributes
>   *
> - * Free up a region of memory.
> - *
> - * Return: 0 if successful, -1 on failure
> + * Return: 0 on success, negative error code on failure.
>   */
>  long lmb_free_flags(phys_addr_t base, phys_size_t size, uint flags);
>
> @@ -160,7 +184,7 @@ static inline int lmb_read_check(phys_addr_t addr, phys_size_t len)
>   * io_lmb_setup() - Initialize LMB struct
>   * @io_lmb: IO LMB to initialize
>   *
> - * Returns: 0 on success, negative error code on failure
> + * Return: 0 on success, negative error code on failure.
>   */
>  int io_lmb_setup(struct lmb *io_lmb);
>
> @@ -178,12 +202,13 @@ void io_lmb_teardown(struct lmb *io_lmb);
>   *
>   * Add the IOVA space [base, base + size] to be managed by io_lmb.
>   *
> - * Returns: 0 if the region addition was successful, -1 on failure
> + * Return: 0 on success, negative error code on failure.
>   */
>  long io_lmb_add(struct lmb *io_lmb, phys_addr_t base, phys_size_t size);
>
>  /**
> - * io_lmb_alloc() - Allocate specified IO memory address with specified alignment
> + * io_lmb_alloc() - Allocate specified IO memory address with specified
> + *                 alignment
>   * @io_lmb: LMB to alloc from
>   * @size: Size of the region requested
>   * @align: Required address and size alignment
> @@ -191,7 +216,7 @@ long io_lmb_add(struct lmb *io_lmb, phys_addr_t base, phys_size_t size);
>   * Allocate a region of IO memory. The base parameter is used to specify the
>   * base address of the requested region.
>   *
> - * Return: base IO address on success, 0 on error
> + * Return: Base IO address on success, 0 on error.
>   */
>  phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong align);
>
> @@ -201,9 +226,7 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong align);
>   * @base: Base Address of region to be freed
>   * @size: Size of the region to be freed
>   *
> - * Free up a region of IOVA space.
> - *
> - * Return: 0 if successful, -1 on failure
> + * Return: 0 on success, negative error code on failure.
>   */
>  long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size);
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 8c1c9b0f67c8..eee3bd37d446 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -609,14 +609,6 @@ static __maybe_unused void lmb_reserve_common_spl(void)
>         }
>  }
>
> -/**
> - * lmb_add_memory() - Add memory range for LMB allocations
> - *
> - * Add the entire available memory range to the pool of memory that
> - * can be used by the LMB module for allocations.
> - *
> - * Return: None
> - */
>  void lmb_add_memory(void)
>  {
>         int i;
> @@ -673,16 +665,6 @@ long lmb_add(phys_addr_t base, phys_size_t size)
>         return lmb_map_update_notify(base, size, MAP_OP_ADD, LMB_NONE);
>  }
>
> -/**
> - * lmb_free_flags() - Free up a region of memory
> - * @base: Base Address of region to be freed
> - * @size: Size of the region to be freed
> - * @flags: Memory region attributes
> - *
> - * Free up a region of memory.
> - *
> - * Return: 0 if successful, negative error code on failure
> - */
>  long lmb_free_flags(phys_addr_t base, phys_size_t size,
>                     uint flags)
>  {
> @@ -790,19 +772,6 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
>         return alloc;
>  }
>
> -/**
> - * lmb_alloc_base_flags() - Allocate specified memory region with specified attributes
> - * @size: Size of the region requested
> - * @align: Alignment of the memory region requested
> - * @max_addr: Maximum address of the requested region
> - * @flags: Memory region attributes to be set
> - *
> - * Allocate a region of memory with the attributes specified through the
> - * parameter. The max_addr parameter is used to specify the maximum address
> - * below which the requested region should be allocated.
> - *
> - * Return: base address on success, 0 on error
> - */
>  phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
>                                  phys_addr_t max_addr, uint flags)
>  {
> @@ -851,18 +820,6 @@ phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
>         return _lmb_alloc_addr(base, size, LMB_NONE);
>  }
>
> -/**
> - * lmb_alloc_addr_flags() - Allocate specified memory address with specified attributes
> - * @base: Base Address requested
> - * @size: Size of the region requested
> - * @flags: Memory region attributes to be set
> - *
> - * Allocate a region of memory with the attributes specified through the
> - * parameter. The base parameter is used to specify the base address
> - * of the requested region.
> - *
> - * Return: base address on success, 0 on error
> - */
>  phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
>                                  uint flags)
>  {
> @@ -935,18 +892,6 @@ static int lmb_setup(bool test)
>         return 0;
>  }
>
> -/**
> - * lmb_init() - Initialise the LMB module
> - *
> - * Initialise the LMB lists needed for keeping the memory map. There
> - * are two lists, in form of alloced list data structure. One for the
> - * available memory, and one for the used memory. Initialise the two
> - * lists as part of board init. Add memory to the available memory
> - * list and reserve common areas by adding them to the used memory
> - * list.
> - *
> - * Return: 0 on success, -ve on error
> - */
>  int lmb_init(void)
>  {
>         int ret;
> --
> 2.39.5
>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
