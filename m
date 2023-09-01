Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECEDCA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 06:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAED28669D;
	Fri,  1 Sep 2023 08:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Bhr7fW3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81B9B80750; Fri,  1 Sep 2023 08:22:47 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5ACE8669D
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 08:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693549359; x=1694154159; i=xypron.glpk@gmx.de;
 bh=j8iE1E669NvKxRP4bmtO4Rr0tGdfTci+h4ofZsCPYLo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Bhr7fW3fyIrHeuo/Bhd0td+4+u3yR/oML+0SZudK6jaLbmp0HUH6FKIwpyKDblGsfYnKVED
 XfIgxKMdYkZP+pA6M8bymeDg4mXu46mPTQvMlsy7bCfUuPxmR+pcvJkChelIB29Tx/P91zmnz
 mxFj4A5n0PWUU8QNvS+y98uUHgj6kG7r6JARbsC4NE9v07JuAj0zT8EoAIauRGudURcqRozp2
 xXpXITbU5Z51H7McubGnTN+8vW6dc+ow2x9LVoTWyk+TVMmtK2Ycu8nEWCClEB7DRJEFoVXgy
 ZGtOYmvsFTKEj6E41nU1r3JvcmN7khSWPfVUVNcywneELKq2Pszg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2Dx8-1pgBqz0yfG-013gX1; Fri, 01
 Sep 2023 08:22:39 +0200
Message-ID: <6e6d9d77-dd54-4705-bd6d-b7be6d45757e@gmx.de>
Date: Fri, 1 Sep 2023 08:23:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] fs: Fix a confusing error about overlapping
 regions
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20230901011357.2482203-1-sjg@chromium.org>
 <20230901011357.2482203-15-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230901011357.2482203-15-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mYatLFnzvr985l7cLK8z3SKYXWSAyC4k7mOTAa7B6KtW8h8Lw+o
 QLjLboTznezF1OmeOpIFhnjk2VD06b1D3TRTqFnPfLUrjt/fQMM7wqdYOeS82L9+qNg7GeS
 ecJ7bBhdwXtbdWA5mhjlajIa2MdjkCO3jW8JuNWvZY2VO8QvBnr2auPctosZvlWaJcAa9EX
 QEbbLMVwaw4XZHVgqMleA==
UI-OutboundReport: notjunk:1;M01:P0:JIRW5oNzpmg=;WD9L/ji7JyDaqz+gsjOO0IOxCn5
 vsafCyBhDS1+jZW3YdsSIZ02ETJPPJyZlEiQ++y/IdypFYRFxkgNE3xkqUCkyRjvqsHdLLS/T
 DrYGZp9fyO8MQCEC7m9zXfOJcjF9r9D/tzmJwZ3Uoj5M4JYnDqiHo5vi9yGsgL2L+zErDVgFj
 Ck2Dq54zpSd/5nw61GSRiTSdygCAW8tJCrjC/gz8Hjv/EPqTmyjewmw0lEy39ciA4tRTqIzo6
 LZoyhhYpYqorf941qE5MW0JagWBJB80yH6DUH6yLGxIVKC8J9LRb0kvGfMX0dGa6X6dmBE0jY
 fa3jiOa3uU34Ga0Iwt3qvAGfACrQeRNNRcthA/93fNNmAOtnvmfLtZcsLBXsJWLG5CbInifc/
 jG/t8OF1YgsrgGmVKWuPRvy+5l9Id+tuee3iXsbCLrPC12ilEuScMxkeJYK3S1t7wwEpJshpM
 dw2s09/BLqWZhEsmHhj6dT5aTDoAbtFdqbmNmZmJv4AzaHDsxdaDdgXEGdwovX+aSAsE2wxJ5
 8+MacHX1d2a8goQb7ow+JeXrgPAx4pUwEphJSTxflcrIMPTiL3W353y+xch/+i1m0Jdx4C3Pc
 HWERej1YtQOmSUtJze1VyQbtO6vmyu4ulIHst/uTAWnS0gxX6F1/ceQkBkJTBg7wQi3vqobZo
 tGCpqV49ycwcO4lwU/QZTnC0W+hhbhgHQto7osyyZcHjx1sssZh7XYTvkx5tDghFHuc8UrT+a
 bZXZ2C/Cac0XdoTklT4QOgoPaiKFw1b78kiqUppB++77olXxBq48CeMrgl8WpPF2CU+YCYFIr
 3nKRDKhiv+iVcsREB3i5m4mP6FP0a5jeZyJ2mEh3m6fE/7GFMekw+b6868hQ+BtTMRyiu//Ey
 pY8ln7L8fo3FxaPju+gRoyJYMlWmmA4GvvtdhbzliCACaBW4Hp+Yau7APZJ2fNd6fe42N53Zd
 bv/3C8Hn9Pb2r+cbfzhG/7hmr94=
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

On 9/1/23 03:13, Simon Glass wrote:
> When lmb runs out of space in its internal tables, it gives errors on
> every fs load operation. This is horribly confusing, as the poor user
> tries different memory regions one at a time.
>
> Use the updated API to check the error code and print a helpful message.
> Also, allow the operation to proceed.
>
> Update the tests accordingly.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   fs/fs.c        |  7 ++++++-
>   include/lmb.h  | 19 ++++++++++++++++++-
>   lib/lmb.c      | 20 +++++++++++---------
>   test/lib/lmb.c | 42 ++++++++++++++++++++----------------------
>   4 files changed, 55 insertions(+), 33 deletions(-)
>
> diff --git a/fs/fs.c b/fs/fs.c
> index 2b815b1db0fe..1a84cb410bf9 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -569,8 +569,13 @@ static int fs_read_lmb_check(const char *filename, =
ulong addr, loff_t offset,
>   	lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
>   	lmb_dump_all(&lmb);
>
> -	if (lmb_alloc_addr(&lmb, addr, read_len) =3D=3D addr)
> +	ret =3D lmb_alloc_addr(&lmb, addr, read_len, NULL);
> +	if (!ret)
>   		return 0;
> +	if (ret =3D=3D -E2BIG) {
> +		log_warning("Reservation tables exhausted: see CONFIG_LMB_USE_MAX_REG=
IONS\n");
> +		return 0;

This is dangerous:

You cannot check if a load operation will override protected memory but
still continue.

Please, return -E2BIG here.

Best regards

Heinrich

> +	}
>
>   	log_err("** Reading file would overwrite reserved memory **\n");
>   	return -ENOSPC;
> diff --git a/include/lmb.h b/include/lmb.h
> index c81716b3f1d1..f28a872c78d0 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -114,7 +114,24 @@ phys_addr_t lmb_alloc_base(struct lmb *lmb, phys_si=
ze_t size, ulong align,
>   			   phys_addr_t max_addr);
>   phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong =
align,
>   			     phys_addr_t max_addr);
> -phys_addr_t lmb_alloc_addr(struct lmb *lmb, phys_addr_t base, phys_size=
_t size);
> +
> +/**
> + * lmb_alloc_addr() - Allocate memory within a region
> + *
> + * Try to allocate a specific address range: must be in defined memory =
but not
> + * reserved
> + *
> + * @lmb:	the logical memory block struct
> + * @base:	base address of the memory region
> + * @size:	size of the memory region
> + * @addrp:	if non-NULL, returns the allocated address, on success
> + * Return:	0 if OK, -EPERM if the memory is already allocated, -E2BIG i=
f
> + * there is not enough room in the reservation tables, so
> + * CONFIG_LMB_USE_MAX_REGIONS should be increased
> + */
> +int lmb_alloc_addr(struct lmb *lmb, phys_addr_t base, phys_size_t size,
> +		   phys_addr_t *addrp);
> +
>   phys_size_t lmb_get_free_size(struct lmb *lmb, phys_addr_t addr);
>
>   /**
> diff --git a/lib/lmb.c b/lib/lmb.c
> index fd6326cbf7fe..c3d14db07e45 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -252,7 +252,7 @@ void lmb_init_and_reserve_range(struct lmb *lmb, phy=
s_addr_t base,
>    * @size:	size of the memory region to add
>    * @flags:	flags for this new memory region
>    * Returns: 0 if OK, -EBUSY if an existing enveloping region has diffe=
rent
> - * flags, -EPERM if there is an existing non-adjacent region, -ENOSPC i=
f there
> + * flags, -EPERM if there is an existing non-adjacent region, -E2BIG if=
 there
>    * is no more room in the list of regions, ekse region number that was=
 coalesced
>    * with this one
>    **/
> @@ -318,7 +318,7 @@ static int lmb_add_area_flags(struct lmb_region *rgn=
, phys_addr_t base,
>   	if (coalesced)
>   		return coalesced;
>   	if (rgn->cnt >=3D rgn->max)
> -		return -ENOSPC;
> +		return -E2BIG;
>
>   	/* Couldn't coalesce the LMB, so add it to the sorted table. */
>   	for (i =3D rgn->cnt-1; i >=3D 0; i--) {
> @@ -511,11 +511,8 @@ phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_=
size_t size, ulong align,
>   	return 0;
>   }
>
> -/*
> - * Try to allocate a specific address range: must be in defined memory =
but not
> - * reserved
> - */
> -phys_addr_t lmb_alloc_addr(struct lmb *lmb, phys_addr_t base, phys_size=
_t size)
> +int lmb_alloc_addr(struct lmb *lmb, phys_addr_t base, phys_size_t size,
> +		   phys_addr_t *addrp)
>   {
>   	int area;
>
> @@ -529,9 +526,14 @@ phys_addr_t lmb_alloc_addr(struct lmb *lmb, phys_ad=
dr_t base, phys_size_t size)
>   		if (lmb_addrs_overlap(lmb->memory.area[area].base,
>   				      lmb->memory.area[area].size,
>   				      base + size - 1, 1)) {
> +			int ret;
> +
>   			/* ok, reserve the memory */
> -			if (lmb_reserve(lmb, base, size) >=3D 0)
> -				return base;
> +			ret =3D lmb_reserve(lmb, base, size);
> +			if (ret < 0)
> +				return ret;
> +			if (addrp)
> +				*addrp =3D base;
>   		}
>   	}
>
> diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> index b665d8dcdeb4..c8dbdb3b73eb 100644
> --- a/test/lib/lmb.c
> +++ b/test/lib/lmb.c
> @@ -497,22 +497,22 @@ static int test_alloc_addr(struct unit_test_state =
*uts, const phys_addr_t ram)
>   		   alloc_addr_b, 0x10000, alloc_addr_c, 0x10000);
>
>   	/* allocate blocks */
> -	a =3D lmb_alloc_addr(&lmb, ram, alloc_addr_a - ram);
> +	ut_assertok(lmb_alloc_addr(&lmb, ram, alloc_addr_a - ram, &a));
>   	ut_asserteq(a, ram);
>   	ASSERT_LMB(&lmb, ram, ram_size, 3, ram, 0x8010000,
>   		   alloc_addr_b, 0x10000, alloc_addr_c, 0x10000);
> -	b =3D lmb_alloc_addr(&lmb, alloc_addr_a + 0x10000,
> -			   alloc_addr_b - alloc_addr_a - 0x10000);
> +	ut_assertok(lmb_alloc_addr(&lmb, alloc_addr_a + 0x10000,
> +				   alloc_addr_b - alloc_addr_a - 0x10000, &b));
>   	ut_asserteq(b, alloc_addr_a + 0x10000);
>   	ASSERT_LMB(&lmb, ram, ram_size, 2, ram, 0x10010000,
>   		   alloc_addr_c, 0x10000, 0, 0);
> -	c =3D lmb_alloc_addr(&lmb, alloc_addr_b + 0x10000,
> -			   alloc_addr_c - alloc_addr_b - 0x10000);
> +	ut_assertok(lmb_alloc_addr(&lmb, alloc_addr_b + 0x10000,
> +				   alloc_addr_c - alloc_addr_b - 0x10000, &c));
>   	ut_asserteq(c, alloc_addr_b + 0x10000);
>   	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, 0x18010000,
>   		   0, 0, 0, 0);
> -	d =3D lmb_alloc_addr(&lmb, alloc_addr_c + 0x10000,
> -			   ram_end - alloc_addr_c - 0x10000);
> +	ut_assertok(lmb_alloc_addr(&lmb, alloc_addr_c + 0x10000,
> +				   ram_end - alloc_addr_c - 0x10000, &d));
>   	ut_asserteq(d, alloc_addr_c + 0x10000);
>   	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, ram_size,
>   		   0, 0, 0, 0);
> @@ -528,7 +528,7 @@ static int test_alloc_addr(struct unit_test_state *u=
ts, const phys_addr_t ram)
>
>   	/* allocate at 3 points in free range */
>
> -	d =3D lmb_alloc_addr(&lmb, ram_end - 4, 4);
> +	ut_assertok(lmb_alloc_addr(&lmb, ram_end - 4, 4, &d));
>   	ut_asserteq(d, ram_end - 4);
>   	ASSERT_LMB(&lmb, ram, ram_size, 2, ram, 0x18010000,
>   		   d, 4, 0, 0);
> @@ -537,7 +537,7 @@ static int test_alloc_addr(struct unit_test_state *u=
ts, const phys_addr_t ram)
>   	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, 0x18010000,
>   		   0, 0, 0, 0);
>
> -	d =3D lmb_alloc_addr(&lmb, ram_end - 128, 4);
> +	ut_assertok(lmb_alloc_addr(&lmb, ram_end - 128, 4, &d));
>   	ut_asserteq(d, ram_end - 128);
>   	ASSERT_LMB(&lmb, ram, ram_size, 2, ram, 0x18010000,
>   		   d, 4, 0, 0);
> @@ -546,7 +546,7 @@ static int test_alloc_addr(struct unit_test_state *u=
ts, const phys_addr_t ram)
>   	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, 0x18010000,
>   		   0, 0, 0, 0);
>
> -	d =3D lmb_alloc_addr(&lmb, alloc_addr_c + 0x10000, 4);
> +	ut_assertok(lmb_alloc_addr(&lmb, alloc_addr_c + 0x10000, 4, &d));
>   	ut_asserteq(d, alloc_addr_c + 0x10000);
>   	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, 0x18010004,
>   		   0, 0, 0, 0);
> @@ -560,19 +560,19 @@ static int test_alloc_addr(struct unit_test_state =
*uts, const phys_addr_t ram)
>   	ut_asserteq(ret, 0);
>   	ASSERT_LMB(&lmb, ram, ram_size, 1, ram + 0x8000000, 0x10010000,
>   		   0, 0, 0, 0);
> -	d =3D lmb_alloc_addr(&lmb, ram, 4);
> +	ut_assertok(lmb_alloc_addr(&lmb, ram, 4, &d));
>   	ut_asserteq(d, ram);
>   	ASSERT_LMB(&lmb, ram, ram_size, 2, d, 4,
>   		   ram + 0x8000000, 0x10010000, 0, 0);
>
>   	/* check that allocating outside memory fails */
>   	if (ram_end !=3D 0) {
> -		ret =3D lmb_alloc_addr(&lmb, ram_end, 1);
> -		ut_asserteq(ret, 0);
> +		ut_assertok(lmb_alloc_addr(&lmb, ram_end, 1, &a));
> +		ut_asserteq(0x40000000, a);
>   	}
>   	if (ram !=3D 0) {
> -		ret =3D lmb_alloc_addr(&lmb, ram - 1, 1);
> -		ut_asserteq(ret, 0);
> +		ut_assertok(lmb_alloc_addr(&lmb, ram - 1, 1, &a));
> +		ut_asserteq(ram, a);
>   	}
>
>   	return 0;
> @@ -588,7 +588,7 @@ static int lib_test_lmb_alloc_addr(struct unit_test_=
state *uts)
>   		return ret;
>
>   	/* simulate 512 MiB RAM beginning at 1.5GiB */
> -	return test_alloc_addr(uts, 0xE0000000);
> +	return test_alloc_addr(uts, 0xe0000000);
>   }
>
>   DM_TEST(lib_test_lmb_alloc_addr, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_F=
DT);
> @@ -699,8 +699,7 @@ static int lib_test_LMB_MAX_AREAS(struct unit_test_s=
tate *uts)
>
>   	/*  error for the (CONFIG_LMB_MAX_AREAS + 1) memory regions */
>   	offset =3D ram + 2 * (CONFIG_LMB_MAX_AREAS + 1) * ram_size;
> -	ret =3D lmb_add(&lmb, offset, ram_size);
> -	ut_asserteq(ret, -1);
> +	ut_asserteq(-E2BIG, lmb_add(&lmb, offset, ram_size));
>
>   	ut_asserteq(lmb.memory.cnt, CONFIG_LMB_MAX_AREAS);
>   	ut_asserteq(lmb.reserved.cnt, 0);
> @@ -717,8 +716,7 @@ static int lib_test_LMB_MAX_AREAS(struct unit_test_s=
tate *uts)
>
>   	/*  error for the 9th reserved blocks */
>   	offset =3D ram + 2 * (CONFIG_LMB_MAX_AREAS + 1) * blk_size;
> -	ret =3D lmb_reserve(&lmb, offset, blk_size);
> -	ut_asserteq(ret, -1);
> +	ut_asserteq(-E2BIG, lmb_reserve(&lmb, offset, blk_size));
>
>   	ut_asserteq(lmb.memory.cnt, CONFIG_LMB_MAX_AREAS);
>   	ut_asserteq(lmb.reserved.cnt, CONFIG_LMB_MAX_AREAS);
> @@ -762,8 +760,8 @@ static int lib_test_lmb_flags(struct unit_test_state=
 *uts)
>   		   0, 0, 0, 0);
>
>   	/* reserve again, new flag */
> -	ret =3D lmb_reserve_flags(&lmb, 0x40010000, 0x10000, LMB_NONE);
> -	ut_asserteq(ret, -1);
> +	ut_asserteq(-EBUSY,
> +		    lmb_reserve_flags(&lmb, 0x40010000, 0x10000, LMB_NONE));
>   	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x10000,
>   		   0, 0, 0, 0);
>

