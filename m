Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312E9C3ABA3
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 07:41:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93CF580F03;
	Fri,  2 May 2025 09:41:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pclmcyAV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81DF2812BC; Fri,  2 May 2025 09:41:47 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65EF58070C
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 09:41:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5f6fb95f431so5177815a12.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 00:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746171705; x=1746776505; darn=lists.denx.de;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zi613CTEV7GYgRKcCXUspkd2pBHtab73C0IAfEVsy0M=;
 b=pclmcyAVFzyXWLsigZOINa4oegmKNp0iV8duEcItRAdBWxducPkMIkndncHDcUh4xZ
 r8Vz6ZPMKP8pHYlZcSDp9hf95gffMznuOt3tdHj4HN4bz6JAe2GO4VVhuKFVQRX+qEr5
 gZRyG8D0yvHmz98nuqz3n8ZpraLH4qCg4nddRMQGlVLZ+uJQLfXBDol+KpSmxha0VvOz
 5oqCu8XtmF7jXu5PXvOYJB73mvwofmt2GIKzHEBiRs7glA8q9NSteoa+HawGv8DEK9PX
 ROHXxkTnSGD6wI2SXaFpmSJ3OJUxmskJwIII5EbvYRfWES03CBZG37/6YMxozUXjXhRH
 BHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746171705; x=1746776505;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Zi613CTEV7GYgRKcCXUspkd2pBHtab73C0IAfEVsy0M=;
 b=vmDavRU4K5xKOiSCxUA6Laloz9ycm3/5HxuZVMpcXrMQExs6jYzaSVJiMvnSBJVM8f
 +ls6UDBeTDdLzNTUSudTeWkA/RxZoAzrpTNM2ntopCaRr4OBJQNJj/172GL9gcunTnl6
 moiYxl8CwrNb/Or+OceWcHq3Y5GMG1/3bO/RBvNuUpgZZTda1EP2wc3o/PpMrP69jQ8v
 YWHQsj5Ns15EhCKd8zozM/ItcKoKU4b6UhZvw/hWhyikbegl2vI6rBYuQGJZpr9oBtEm
 X0ySf7I4GVWt/vZjwo/7pJkLNy2YmBVdncAYXROHyztMHL+EtH0IleIuPNC4T5V+KenN
 YXBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGkwFPoATrCiNhDKDqIP2Z+/OUb7vILmabanAnbk4eDP70XD1YsectT1hxTZeF/4i/a0IrmY8=@lists.denx.de
X-Gm-Message-State: AOJu0YzGB4DrWuBXQk8ieIhdAtBkMgIvdODRX807vwvrtgUfYuGIPw/d
 MpAZwEDLVnFgwx8d5bDlP5jGFiBwuGRmZ8Ciwlm30KODByFuBId/ZvIYTzj7tBo=
X-Gm-Gg: ASbGncuwi7jcNwFewcn9aFcgjsCmrM12LEdkyBQrOs2eOrP8Z8YTqWD+5jM4JiclZdq
 SmHqDf/FKliM4Y9IZInD0YdZbkGjVI00QTyZLj7QcPesIlE+0gAaTk0G+YUANIlOpJ7vgYcok/r
 I4QJ18WsLCklPXdIigjYtLiSrgs+UMwMKecs3b8EAEmFnCr/TLsUR1Fmv42RStqFexrYs7MHz6U
 2PKAidz8kG6oeXBSEWBDRP23gthHABCro3UNMuDULhIc9z8n3LLps8rlSOx8TPNYPRc7Q/z9Gpz
 JMGh0JPLhhUt+sCm+oO3NVFtmFiA8P0qCG4fs070V799g9cP
X-Google-Smtp-Source: AGHT+IEQrVAWAb/EzCKJSMbRPa7KONVLs46fFsBryO78pIWYAw//xJHdqhC/i8znMhZEiRC8mGo+JA==
X-Received: by 2002:a05:6402:5216:b0:5f6:22ca:8aae with SMTP id
 4fb4d7f45d1cf-5f919836912mr4475468a12.2.1746171704736; 
 Fri, 02 May 2025 00:41:44 -0700 (PDT)
Received: from localhost ([46.198.180.244]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa777c7309sm826601a12.19.2025.05.02.00.41.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 00:41:43 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 May 2025 10:41:41 +0300
Message-Id: <D9LI7HGHRKRX.3NLD3DXDAG4@linaro.org>
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Sughosh Ganu" <sughosh.ganu@linaro.org>, <u-boot@lists.denx.de>
Cc: "Tom Rini" <trini@konsulko.com>, "Casey Connolly"
 <casey.connolly@linaro.org>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Mark Kettenis" <kettenis@openbsd.org>, "Weijie Gao"
 <weijie.gao@mediatek.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Simon Glass" <sjg@chromium.org>
Subject: Re: [PATCH 2/5] lmb: replace the lmb_alloc() and lmb_alloc_base()
 API's
X-Mailer: aerc 0.20.0
References: <20250501120239.199829-1-sughosh.ganu@linaro.org>
 <20250501120239.199829-3-sughosh.ganu@linaro.org>
In-Reply-To: <20250501120239.199829-3-sughosh.ganu@linaro.org>
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

On Thu May 1, 2025 at 3:02 PM EEST, Sughosh Ganu wrote:
> There currently are two API's for requesting memory from the LMB
> module, lmb_alloc() and lmb_alloc_base(). The function which does the
> actual allocation is the same. Use the earlier introduced API
> lmb_allocate_mem() for both types of allocation requests.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  arch/arm/mach-apple/board.c      | 27 ++++++++++++++-----
>  arch/arm/mach-snapdragon/board.c | 13 ++++++++-
>  boot/bootm.c                     |  6 +++--
>  boot/image-board.c               | 45 ++++++++++++++++++--------------
>  boot/image-fdt.c                 | 32 +++++++++++++++++------
>  include/lmb.h                    | 22 +++-------------
>  lib/efi_loader/efi_memory.c      | 14 +++++-----
>  lib/lmb.c                        | 30 ++++++++++-----------
>  test/lib/lmb.c                   | 26 ++++++++++++++++++
>  9 files changed, 138 insertions(+), 77 deletions(-)
>
> diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> index 2644a04a622..f0eab5df1ef 100644
> --- a/arch/arm/mach-apple/board.c
> +++ b/arch/arm/mach-apple/board.c
> @@ -772,6 +772,19 @@ u64 get_page_table_size(void)
>
>  #define KERNEL_COMP_SIZE	SZ_128M
>
> +static phys_addr_t lmb_alloc(phys_size_t size)
> +{
> +	int ret;
> +	phys_addr_t addr;
> +
> +	/* All memory regions allocated with a 2MiB alignment */
> +	ret =3D lmb_allocate_mem(LMB_MEM_ALLOC_ANY, SZ_2M, &addr, size, LMB_NON=
E);
> +	if (ret)
> +		return 0;
> +
> +	return addr;
> +}
> +
>  int board_late_init(void)
>  {
>  	u32 status =3D 0;
> @@ -779,15 +792,15 @@ int board_late_init(void)
>  	/* somewhat based on the Linux Kernel boot requirements:
>  	 * align by 2M and maximal FDT size 2M
>  	 */
> -	status |=3D env_set_hex("loadaddr", lmb_alloc(SZ_1G, SZ_2M));
> -	status |=3D env_set_hex("fdt_addr_r", lmb_alloc(SZ_2M, SZ_2M));
> -	status |=3D env_set_hex("kernel_addr_r", lmb_alloc(SZ_128M, SZ_2M));
> -	status |=3D env_set_hex("ramdisk_addr_r", lmb_alloc(SZ_1G, SZ_2M));
> +	status |=3D env_set_hex("loadaddr", lmb_alloc(SZ_1G));

env_set_hex() expects a ulong, which might end up causing problems for some=
 archs, but I don't think
that's a problem of this patchset. It's something that has to be fixed in a=
 the wider codebase

> +	status |=3D env_set_hex("fdt_addr_r", lmb_alloc(SZ_2M));
> +	status |=3D env_set_hex("kernel_addr_r", lmb_alloc(SZ_128M));
>  					 rd_len, LMB_NONE);
>  		} else {
>  			if (initrd_high)
> -				*initrd_start =3D
> -					(ulong)lmb_alloc_base(rd_len,
> -								    0x1000,
> -								    initrd_high,
> -								    LMB_NONE);
> +				err =3D lmb_allocate_mem(LMB_MEM_ALLOC_MAX,
> +						       0x1000, &initrd_high,
> +						       rd_len, LMB_NONE);
>  			else
> -				*initrd_start =3D (ulong)lmb_alloc(rd_len,
> -								 0x1000);
> +				err =3D lmb_allocate_mem(LMB_MEM_ALLOC_ANY,
> +						       0x1000, &initrd_high,
> +						       rd_len, LMB_NONE);

You are now calling the same function, put LMB_MEM_ALLOC_ANY/LMB_MEM_ALLOC_=
MAX in a variable instead
and make the if smaller

[...]

> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index 6585813de00..b8e1b0f35bb 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -198,15 +198,27 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *o=
f_size)
>  			of_start =3D (void *)(uintptr_t)addr;
>  			disable_relocation =3D 1;
>  		} else if (desired_addr) {
> -			addr =3D lmb_alloc_base(of_len, 0x1000, desired_addr,
> -					      LMB_NONE);
> +			addr =3D desired_addr;
> +			err =3D lmb_allocate_mem(LMB_MEM_ALLOC_MAX, 0x1000, &addr,

Is this LMB_MEM_ALLOC_MAX or LMB_MEM_ALLOC_ADDR?

> +					       of_len, LMB_NONE);
> +
> +			if (err) {
> +				puts("Failed using fdt_high value for Device Tree");
> +				goto error;
> +			}
> +
>  			of_start =3D map_sysmem(addr, of_len);
>  	} else {
> @@ -228,11 +240,15 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *o=
f_size)
>
>  	switch (type) {
> +	case LMB_MEM_ALLOC_ANY:
> +		*addr =3D LMB_ALLOC_ANYWHERE;
> +		ret =3D _lmb_alloc_base(size, align, addr, flags);
> +		break;
> +	case LMB_MEM_ALLOC_MAX:
> +		ret =3D _lmb_alloc_base(size, align, addr, flags);
> +		break;

You can make this a fallthrough
case LMB_MEM_ALLOC_ANY:
    *addr =3D LMB_ALLOC_ANYWHERE;
case LMB_MEM_ALLOC_MAX:
  ret =3D _lmb_alloc_base(size, align, addr, flags);
  break;

>  	case LMB_MEM_ALLOC_ADDR:
>  		ret =3D _lmb_alloc_addr(*addr, size, flags);
>  		break;
> diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> index f80115570e7..8ce19efc854 100644
> --- a/test/lib/lmb.c
> +++ b/test/lib/lmb.c
> @@ -82,6 +82,32 @@ static int lmb_reserve(phys_addr_t addr, phys_size_t s=
ize, u32 flags)
>  	return 0;
>  }
>
> +static phys_addr_t lmb_alloc(phys_size_t size, ulong align)
> +{
> +	int err;
> +	phys_addr_t addr;
> +
> +	err =3D lmb_allocate_mem(LMB_MEM_ALLOC_ANY, align, &addr, size, LMB_NON=
E);
> +	if (err)
> +		return 0;
> +
> +	return addr;
> +}
> +
> +static phys_addr_t lmb_alloc_base(phys_size_t size, ulong align,
> +				  phys_addr_t max_addr, u32 flags)
> +{
> +	int err;
> +	phys_addr_t addr;
> +
> +	addr =3D max_addr;
> +	err =3D lmb_allocate_mem(LMB_MEM_ALLOC_MAX, align, &addr, size, flags);
> +	if (err)
> +		return 0;
> +
> +	return addr;
> +}
> +
>  #define lmb_alloc_addr(addr, size, flags) lmb_reserve(addr, size, flags)
>
>  static int test_multi_alloc(struct unit_test_state *uts, const phys_addr=
_t ram,

Thanks
/Ilias
