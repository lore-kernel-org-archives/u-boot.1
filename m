Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72813C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 07:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAFBA82D2B;
	Wed, 21 May 2025 09:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fHhWvJqh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A719282D33; Wed, 21 May 2025 09:42:05 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DF7E82BD6
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 09:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6023cf146d3so581507a12.3
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 00:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747813322; x=1748418122; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+tuQ7eVKXHnClWAxGG5MSReo0f/SUMjRFv2IJLTb8E=;
 b=fHhWvJqh5pDYaSxUox9Vhi1ZHoPTAZT0f4VH36S4fVG0uXaJEf9aE1rRcVntEFVFNS
 D+Vqvnxt7TLVkiXiInUIcPg33c+uE/NwqyzaAA1RK73CZbC10OZwfNuIMXQvMEh1UxYW
 mgYmwwL9EzlsZmBAtJe/Ivq5C8DKUaskdMR+Db6EOg7QYeC4dKBNLsw8go0xydEz5Dnn
 /1M34/rzqO29wO4uDOG+EuMq9O2eNv8Ah56Q1wTeF7KKeCmlD0ex5rolnuTWJOnHH/p6
 3fUmWLiJ7KGZV/c8ZNf058WxhO9Zdh1JT0bUMUJWjWR0M3WiDfYjWfMlaukvC/CtRjXr
 w/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747813322; x=1748418122;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2+tuQ7eVKXHnClWAxGG5MSReo0f/SUMjRFv2IJLTb8E=;
 b=k6uPveAr4TK58wJLoOWKSfWQiVE/1+VUSi8wqrGm9M2fx6PjvOh4MWU3vwZcC21LpT
 SA+NSzO6JW7qO/BQDsf9qdChMNhG35FiFD6t7p92pv3Bj1LJrqkecr8MQIU3I86Dsuk+
 agWCPNyY2zSgmTNIWk/ZBJxl2k4z1Ul6Y8z4d8QnN66iq6/VjfmQ6q2Uf48iaeXCXB26
 8rs2CqhIATBUErminbelEpe/ea8YRKmwE5Z1oWb60BUDkRyyk7qhFZdLLs4x8KugNLca
 XgssgrIoKYubyKs/LA60zs6tZG/s6JY4g4ZfhRIagVn/l+DRzxNF1ASce5hTy8TIhtYU
 X8hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0XuiFbSsHierGNrW/hz+yYPtJ3EoMb0zW9Ed5FcdJDF+Ipc7xUHTz77y7pB4aNQnEMGx6hEE=@lists.denx.de
X-Gm-Message-State: AOJu0YyMFWW1sZ/bEdFCEy8V4Ua0XFH9+snyH/5XJaWh6mWx4YhsPL42
 9T527qjkA1RWQkoWq1gXnRsA1jSdNSHXhvYNaC0gLwrNItYcQj8PbMAHqtydY7ep8X0=
X-Gm-Gg: ASbGnctmNU79KftpZyieBg9BVSRHVya8i7lCry30DsDrQSQA76JAJzR3/hFiEHoukQN
 hM6G0rxhEBCcZnLVZKmLrCfxNS15pIrkiuzamm8UZ0VJnJUbAVdO2gz2Ye2oaPHn/8prs86oGhf
 lgIV9mMjql10wrTXs5lumpNKlFLhcYQvMug6egdZMvQdBqzpaW1X6QaTrpOzCZp/yUPvN0Yibp5
 8cpEtrlWB4HTETPoYErf9C59bG7RzOfswyF2d/nDRWasZjj2m3N8Gdz5PU2665eNHSodQ0dzuN5
 oSDl/pTGszxTunUqAWphTKM+z7miVYeM0A+oqIm6NZHDUDCCYlSMILTn6io=
X-Google-Smtp-Source: AGHT+IFmkmC6sooHjuQSe+G0DSK10Y5li9T+0ZALcTW/FKT9xGFS99styVTBU7e5HaD+qKKulzr+HQ==
X-Received: by 2002:a05:6402:2108:b0:5fa:b131:f009 with SMTP id
 4fb4d7f45d1cf-6007e825a98mr17017307a12.0.1747813322303; 
 Wed, 21 May 2025 00:42:02 -0700 (PDT)
Received: from localhost ([46.198.180.244]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6005ac33d7asm8426524a12.52.2025.05.21.00.42.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 00:42:01 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 May 2025 10:42:00 +0300
Message-Id: <DA1O42PPJ4WR.312SLWIZFARW0@linaro.org>
Cc: "Tom Rini" <trini@konsulko.com>, "Casey Connolly"
 <casey.connolly@linaro.org>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Mark Kettenis" <kettenis@openbsd.org>, "Weijie Gao"
 <weijie.gao@mediatek.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Simon Glass" <sjg@chromium.org>
Subject: Re: [PATCH v2 4/5] lmb: use a single function to free up memory
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Sughosh Ganu" <sughosh.ganu@linaro.org>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.20.0
References: <20250520120606.173228-1-sughosh.ganu@linaro.org>
 <20250520120606.173228-5-sughosh.ganu@linaro.org>
In-Reply-To: <20250520120606.173228-5-sughosh.ganu@linaro.org>
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

Hi Sughosh,

On Tue May 20, 2025 at 3:06 PM EEST, Sughosh Ganu wrote:
> There is no need to have two separate API's for freeing up memory. Use
> a single API lmb_free() to achieve this.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
> Changes since V1: None
>
>  boot/image-fdt.c            |  2 +-
>  cmd/load.c                  |  2 +-
>  include/lmb.h               |  6 ++---
>  lib/efi_loader/efi_memory.c |  6 ++---
>  lib/lmb.c                   |  8 +-----
>  test/lib/lmb.c              | 49 +++++++++++++++++++------------------
>  6 files changed, 33 insertions(+), 40 deletions(-)
>
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index ff27a31ae2e..1a6db149021 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -691,7 +691,7 @@ int image_setup_libfdt(struct bootm_headers *images, =
void *blob, bool lmb)
>
>  	/* Delete the old LMB reservation */
>  	if (CONFIG_IS_ENABLED(LMB) && lmb)
> -		lmb_free(map_to_sysmem(blob), fdt_totalsize(blob));
> +		lmb_free(map_to_sysmem(blob), fdt_totalsize(blob), LMB_NONE);
>
>  	ret =3D fdt_shrink_to_minimum(blob, 0);
>  	if (ret < 0)
> diff --git a/cmd/load.c b/cmd/load.c
> index 569716607ff..9d94a884087 100644
> --- a/cmd/load.c
> +++ b/cmd/load.c
> @@ -191,7 +191,7 @@ static ulong load_serial(long offset)
>  			dst =3D map_sysmem(store_addr, binlen);
>  			memcpy(dst, binbuf, binlen);
>  			unmap_sysmem(dst);
> -			lmb_free(store_addr, binlen);
> +			lmb_free(store_addr, binlen, LMB_NONE);
>  		    }
>  		    if ((store_addr) < start_addr)
>  			start_addr =3D store_addr;
> diff --git a/include/lmb.h b/include/lmb.h
> index 29345d1fa50..c869744c99f 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -142,16 +142,14 @@ phys_size_t lmb_get_free_size(phys_addr_t addr);
>  int lmb_is_reserved_flags(phys_addr_t addr, int flags);
>
>  /**
> - * lmb_free_flags() - Free up a region of memory
> + * lmb_free() - Free up a region of memory
>   * @base: Base Address of region to be freed
>   * @size: Size of the region to be freed
>   * @flags: Memory region attributes
>   *
>   * Return: 0 on success, negative error code on failure.
>   */
> -long lmb_free_flags(phys_addr_t base, phys_size_t size, uint flags);
> -
> -long lmb_free(phys_addr_t base, phys_size_t size);
> +long lmb_free(phys_addr_t base, phys_size_t size, u32 flags);
>
>  void lmb_dump_all(void);
>  void lmb_dump_all_force(void);
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 73e1eef5011..fd6aee21d36 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -508,7 +508,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_typ=
e type,
>  	ret =3D efi_update_memory_map(efi_addr, pages, memory_type, true, false=
);
>  	if (ret !=3D EFI_SUCCESS) {
>  		/* Map would overlap, bail out */
> -		lmb_free_flags(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
> +		lmb_free(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
>  		unmap_sysmem((void *)(uintptr_t)efi_addr);
>  		return  EFI_OUT_OF_RESOURCES;
>  	}
> @@ -548,8 +548,8 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uint=
n_t pages)
>  	 * been mapped with map_sysmem() from efi_allocate_pages(). Convert
>  	 * it back to an address LMB understands
>  	 */
> -	status =3D lmb_free_flags(map_to_sysmem((void *)(uintptr_t)memory), len=
,
> -				LMB_NOOVERWRITE);
> +	status =3D lmb_free(map_to_sysmem((void *)(uintptr_t)memory), len,
> +			  LMB_NOOVERWRITE);
>  	if (status)
>  		return EFI_NOT_FOUND;
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 4f3cf345984..c9526c3c578 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -655,8 +655,7 @@ long lmb_add(phys_addr_t base, phys_size_t size)
>  	return lmb_map_update_notify(base, size, LMB_MAP_OP_ADD, LMB_NONE);
>  }
>
> -long lmb_free_flags(phys_addr_t base, phys_size_t size,
> -		    uint flags)
> +long lmb_free(phys_addr_t base, phys_size_t size, u32 flags)
>  {
>  	long ret;
>
> @@ -667,11 +666,6 @@ long lmb_free_flags(phys_addr_t base, phys_size_t si=
ze,
>  	return lmb_map_update_notify(base, size, LMB_MAP_OP_FREE, flags);
>  }
>
> -long lmb_free(phys_addr_t base, phys_size_t size)
> -{
> -	return lmb_free_flags(base, size, LMB_NONE);
> -}
> -
>  static int _lmb_alloc_base(phys_size_t size, ulong align,
>  			   phys_addr_t *addr, u32 flags)
>  {
> diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> index 8ce19efc854..94a335a4bb8 100644
> --- a/test/lib/lmb.c
> +++ b/test/lib/lmb.c
> @@ -182,7 +182,7 @@ static int test_multi_alloc(struct unit_test_state *u=
ts, const phys_addr_t ram,
>  	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
>  		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 8, 0, 0);
>
> -	ret =3D lmb_free(a, 4);
> +	ret =3D lmb_free(a, 4, LMB_NONE);
>  	ut_asserteq(ret, 0);
>  	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
>  		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 4, 0, 0);
> @@ -191,12 +191,12 @@ static int test_multi_alloc(struct unit_test_state =
*uts, const phys_addr_t ram,
>  	ut_asserteq(a, a2);
>  	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
>  		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 8, 0, 0);
> -	ret =3D lmb_free(a2, 4);
> +	ret =3D lmb_free(a2, 4, LMB_NONE);
>  	ut_asserteq(ret, 0);
>  	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
>  		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 4, 0, 0);
>
> -	ret =3D lmb_free(b, 4);
> +	ret =3D lmb_free(b, 4, LMB_NONE);
>  	ut_asserteq(ret, 0);
>  	ASSERT_LMB(mem_lst, used_lst, 0, 0, 3,
>  		   alloc_64k_addr - 8, 4, alloc_64k_addr, 0x10000,
> @@ -206,17 +206,17 @@ static int test_multi_alloc(struct unit_test_state =
*uts, const phys_addr_t ram,
>  	ut_asserteq(b, b2);
>  	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
>  		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 4, 0, 0);
> -	ret =3D lmb_free(b2, 4);
> +	ret =3D lmb_free(b2, 4, LMB_NONE);
>  	ut_asserteq(ret, 0);
>  	ASSERT_LMB(mem_lst, used_lst, 0, 0, 3,
>  		   alloc_64k_addr - 8, 4, alloc_64k_addr, 0x10000,
>  		   ram_end - 8, 4);
>
> -	ret =3D lmb_free(c, 4);
> +	ret =3D lmb_free(c, 4, LMB_NONE);
>  	ut_asserteq(ret, 0);
>  	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
>  		   alloc_64k_addr - 8, 4, alloc_64k_addr, 0x10000, 0, 0);
> -	ret =3D lmb_free(d, 4);
> +	ret =3D lmb_free(d, 4, LMB_NONE);
>  	ut_asserteq(ret, 0);
>  	ASSERT_LMB(mem_lst, used_lst, 0, 0, 1, alloc_64k_addr, 0x10000,
>  		   0, 0, 0, 0);
> @@ -320,7 +320,7 @@ static int test_bigblock(struct unit_test_state *uts,=
 const phys_addr_t ram)
>  	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, a,
>  		   big_block_size + 0x10000, 0, 0, 0, 0);
>
> -	ret =3D lmb_free(a, big_block_size);
> +	ret =3D lmb_free(a, big_block_size, LMB_NONE);
>  	ut_asserteq(ret, 0);
>  	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, alloc_64k_addr, 0x10000=
,
>  		   0, 0, 0, 0);
> @@ -392,12 +392,12 @@ static int test_noreserved(struct unit_test_state *=
uts, const phys_addr_t ram,
>  			   - alloc_size_aligned, alloc_size, 0, 0);
>  	}
>  	/* and free them */
> -	ret =3D lmb_free(b, alloc_size);
> +	ret =3D lmb_free(b, alloc_size, LMB_NONE);
>  	ut_asserteq(ret, 0);
>  	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1,
>  		   ram + ram_size - alloc_size_aligned,
>  		   alloc_size, 0, 0, 0, 0);
> -	ret =3D lmb_free(a, alloc_size);
> +	ret =3D lmb_free(a, alloc_size, LMB_NONE);
>  	ut_asserteq(ret, 0);
>  	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
>
> @@ -408,7 +408,7 @@ static int test_noreserved(struct unit_test_state *ut=
s, const phys_addr_t ram,
>  		   ram + ram_size - alloc_size_aligned,
>  		   alloc_size, 0, 0, 0, 0);
>  	/* and free it */
> -	ret =3D lmb_free(b, alloc_size);
> +	ret =3D lmb_free(b, alloc_size, LMB_NONE);
>  	ut_asserteq(ret, 0);
>  	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
>
> @@ -476,12 +476,12 @@ static int lib_test_lmb_at_0(struct unit_test_state=
 *uts)
>  	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, a, ram_size - 4,
>  		   0, 0, 0, 0);
>  	/* check that this was an error by freeing b */
> -	ret =3D lmb_free(b, 4);
> +	ret =3D lmb_free(b, 4, LMB_NONE);
>  	ut_asserteq(ret, -1);
>  	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, a, ram_size - 4,
>  		   0, 0, 0, 0);
>
> -	ret =3D lmb_free(a, ram_size - 4);
> +	ret =3D lmb_free(a, ram_size - 4, LMB_NONE);
>  	ut_asserteq(ret, 0);
>  	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
>
> @@ -612,7 +612,7 @@ static int test_alloc_addr(struct unit_test_state *ut=
s, const phys_addr_t ram)
>  	ut_asserteq(b, 0);
>  	b =3D lmb_alloc_addr(alloc_addr_a, 0x2000, LMB_NONE);
>  	ut_asserteq(b, 0);
> -	ret =3D lmb_free(alloc_addr_a, 0x2000);
> +	ret =3D lmb_free(alloc_addr_a, 0x2000, LMB_NONE);
>  	ut_asserteq(ret, 0);
>  	b =3D lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
>  	ut_asserteq(b, 0);
> @@ -620,7 +620,7 @@ static int test_alloc_addr(struct unit_test_state *ut=
s, const phys_addr_t ram)
>  	ut_asserteq(b, -EEXIST);
>  	b =3D lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
>  	ut_asserteq(b, -EEXIST);
> -	ret =3D lmb_free(alloc_addr_a, 0x1000);
> +	ret =3D lmb_free(alloc_addr_a, 0x1000, LMB_NONE);
>  	ut_asserteq(ret, 0);
>
>  	/*
> @@ -642,9 +642,9 @@ static int test_alloc_addr(struct unit_test_state *ut=
s, const phys_addr_t ram)
>  	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, alloc_addr_a, 0x1000,
>  		   alloc_addr_a + 0x4000, 0x1000, 0, 0);
>
> -	ret =3D lmb_free(alloc_addr_a, 0x1000);
> +	ret =3D lmb_free(alloc_addr_a, 0x1000, LMB_NONE);
>  	ut_asserteq(ret, 0);
> -	ret =3D lmb_free(alloc_addr_a + 0x4000, 0x1000);
> +	ret =3D lmb_free(alloc_addr_a + 0x4000, 0x1000, LMB_NOOVERWRITE);
>  	ut_asserteq(ret, 0);
>
>  	/*
> @@ -667,7 +667,7 @@ static int test_alloc_addr(struct unit_test_state *ut=
s, const phys_addr_t ram)
>  	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, alloc_addr_a, 0x6000,
>  		   0, 0, 0, 0);
>
> -	ret =3D lmb_free(alloc_addr_a, 0x6000);
> +	ret =3D lmb_free(alloc_addr_a, 0x6000, LMB_NONE);
>  	ut_asserteq(ret, 0);
>
>  	/*
> @@ -689,9 +689,9 @@ static int test_alloc_addr(struct unit_test_state *ut=
s, const phys_addr_t ram)
>  	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, alloc_addr_a, 0x1000,
>  		   alloc_addr_a + 0x4000, 0x1000, 0, 0);
>
> -	ret =3D lmb_free(alloc_addr_a, 0x1000);
> +	ret =3D lmb_free(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
>  	ut_asserteq(ret, 0);
> -	ret =3D lmb_free(alloc_addr_a + 0x4000, 0x1000);
> +	ret =3D lmb_free(alloc_addr_a + 0x4000, 0x1000, LMB_NOOVERWRITE);
>  	ut_asserteq(ret, 0);
>
>  	/*  reserve 3 blocks */
> @@ -732,7 +732,8 @@ static int test_alloc_addr(struct unit_test_state *ut=
s, const phys_addr_t ram)
>  		   0, 0, 0, 0);
>
>  	/* free thge allocation from d */
> -	ret =3D lmb_free(alloc_addr_c + 0x10000, ram_end - alloc_addr_c - 0x100=
00);
> +	ret =3D lmb_free(alloc_addr_c + 0x10000, ram_end - alloc_addr_c - 0x100=
00,
> +		       LMB_NONE);
>  	ut_asserteq(ret, 0);
>
>  	/* allocate at 3 points in free range */
> @@ -741,7 +742,7 @@ static int test_alloc_addr(struct unit_test_state *ut=
s, const phys_addr_t ram)
>  	ut_asserteq(d, 0);
>  	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 0x18010000,
>  		   ram_end - 4, 4, 0, 0);
> -	ret =3D lmb_free(ram_end - 4, 4);
> +	ret =3D lmb_free(ram_end - 4, 4, LMB_NONE);
>  	ut_asserteq(ret, 0);
>  	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
>  		   0, 0, 0, 0);
> @@ -750,7 +751,7 @@ static int test_alloc_addr(struct unit_test_state *ut=
s, const phys_addr_t ram)
>  	ut_asserteq(d, 0);
>  	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 0x18010000,
>  		   ram_end - 128, 4, 0, 0);
> -	ret =3D lmb_free(ram_end - 128, 4);
> +	ret =3D lmb_free(ram_end - 128, 4, LMB_NONE);
>  	ut_asserteq(ret, 0);
>  	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
>  		   0, 0, 0, 0);
> @@ -759,13 +760,13 @@ static int test_alloc_addr(struct unit_test_state *=
uts, const phys_addr_t ram)
>  	ut_asserteq(d, 0);
>  	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010004,
>  		   0, 0, 0, 0);
> -	ret =3D lmb_free(alloc_addr_c + 0x10000, 4);
> +	ret =3D lmb_free(alloc_addr_c + 0x10000, 4, LMB_NONE);
>  	ut_asserteq(ret, 0);
>  	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
>  		   0, 0, 0, 0);
>
>  	/* allocate at the bottom a was assigned to ram at the top */
> -	ret =3D lmb_free(ram, alloc_addr_a - ram);
> +	ret =3D lmb_free(ram, alloc_addr_a - ram, LMB_NONE);
>  	ut_asserteq(ret, 0);
>  	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram + 0x8000000,
>  		   0x10010000, 0, 0, 0, 0);

