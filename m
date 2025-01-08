Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F116BE77199
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 15:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AC73806C6;
	Wed,  8 Jan 2025 16:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d5IYr6dL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4F56800D7; Wed,  8 Jan 2025 10:41:21 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FA318001F
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 10:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d3d0205bd5so282838a12.3
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 01:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736329278; x=1736934078; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jTU/QL/kmVPywzzOaDDuqkw7auXTxVn1mK1/neiCQIM=;
 b=d5IYr6dLKF1KngA3PIroKWc+G8SAxf8pR7zNJ8a2APs+CADBvzD1BUh+9f1WUKRYtC
 AeGVlsdClIrkBnCXEvfiOST1isWQnwoY44+7Hhzu8T+z3z83X7zBOqdQkrX5kCiEIhRn
 cZ9h5ee/mnG+O0seT4Ri64ZoSIchv7MaKPhNloz76eqTq1BiJ3wzoOzUQBPUA3xVEHX1
 7+7mTErCh5RTrM3VT1QV2vy/fQuoH8Zfa1QOQlnj1HTDUX/32JkET90nUdFiYL/uW0k1
 oWoGO8JXWqXtlacCPY9d94uDH2ccGPrNeMVr0/8kUNLskmSmGbNODnjuasvXc2WrbpMA
 VYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736329278; x=1736934078;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jTU/QL/kmVPywzzOaDDuqkw7auXTxVn1mK1/neiCQIM=;
 b=bf0pj8YgIpf5q+8IkYHZhPETi5T6tSmbDThWQKdyaK9FD3esww7jtcZ+/7Z4JOg2EN
 +2RlX0fRvbM52cSk/WEeOUd0N6jwI46A34pBTrpXyztBp156u93S5QHq7IdbgOIEVhUJ
 yk9E6xMNQS9XSKv5FrIuDF6WmxsFkfOro8krNbA0hjIcOrQn+koiq00tworl1GlgZkU/
 +SQ/prDtjpBNjm25114Bl/i0L87AZlIXO/jxAwFWJQ9Q5VCR2yBw6xcEoYFOeM4RTIsb
 eZF/8Owe10E1wNJ3hl9Z1uzwsDDHNpaPxeAV5z0xkLK6Z9v7Uc9WV6VG5DzVcLPluPv9
 MEdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5VslIgfPV0rPwFwjCiGYyNM4LoGqJaxe+3CL1kI94k/I08hE1mvKaoCKQ3IOMYrPYBLwgf18=@lists.denx.de
X-Gm-Message-State: AOJu0Yzc8BLOD1Armlt6VOB+vL8uExLgKx2aG9gP2Jp4vumwFiCotpfp
 KcobqsMcZycju2NOLqOBnvx9yf6NOKBCIM0uncaek/kU/6eTzFpSo1/8u+W85b4=
X-Gm-Gg: ASbGncvDaB+BH05WKBGCUjDlcw9tMrTK1Zh9Iu725BD8ZXopxS8v39xjQo68zZmRbZ4
 aZrY8o19H2VIpfED9HbbDEnqu7ogzhFVwC3d+Jj/Ke1yfL/2tdqtM/0JRrhI/V5M90ddIVQTU7m
 +zXSnTQ+knlhc4XSwlQPXe80hQOvxdDH/LfdAk2hOnGSIDwwjn/ywoTVxOe4D3GvBYukVn2a9ld
 4BhclKvmc4KifTuQb824Qt3yEPoOdd0XPOuFYkp1jfmex3pqK6V7+9qEwqE99BEull+
X-Google-Smtp-Source: AGHT+IFsTu9bp/uo3w31kRck3BNHk3BRAnYCC/O5AC7s/PghCqkmnC583l9WG02Kix30MLQKaPn3/A==
X-Received: by 2002:a05:6402:3208:b0:5d6:66cf:2a3a with SMTP id
 4fb4d7f45d1cf-5d972e1691dmr1697533a12.17.1736329278357; 
 Wed, 08 Jan 2025 01:41:18 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef30:7505:d47e:5219:b65a])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80676f074sm25900998a12.25.2025.01.08.01.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 01:41:17 -0800 (PST)
Date: Wed, 8 Jan 2025 10:41:15 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Mario Six <mario.six@gdsys.cc>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH 13/15] mach-snapdragon: support parsing memory map from
 SMEM
Message-ID: <Z35IO3ZGJ7Y1jRJ6@linaro.org>
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
 <20241124-b4-modernise-smem-v1-13-b7852c11b67c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124-b4-modernise-smem-v1-13-b7852c11b67c@linaro.org>
X-Mailman-Approved-At: Wed, 08 Jan 2025 16:49:18 +0100
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

On Sun, Nov 24, 2024 at 08:17:55PM +0100, Caleb Connolly wrote:
> It is possible to derive the memory map for a Qualcomm platform from the
> SMEM shared memory region. The memory map is populated by the preloader.
> 
> Introduce support for parsing this data and using it to populate
> U-Boot's memory map. Since we aren't yet sure if this will work for
> every platform, it is not yet used in all cases, if U-Boot is booted
> with an internal FDT which has the memory map defined, this will
> be used instead.
> 
> If the FDT comes from ABL, or we're using an internal FDT with no memory
> map defined, then U-Boot will try to use SMEM. This should remove the
> need to define the memory map statically in a U-Boot overlay DT for most
> boards.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/board.c     |   2 +-
>  arch/arm/mach-snapdragon/dram.c      | 106 +++++++++++++++++++++++++++++++++--
>  arch/arm/mach-snapdragon/qcom-priv.h |   4 +-
>  3 files changed, 106 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 8d171957b852..269d39e4f6e1 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -85,9 +85,9 @@ void *board_fdt_blob_setup(int *err)
>  	/*
>  	 * Parse the /memory node while we're here,
>  	 * this makes it easy to do other things early.
>  	 */
> -	qcom_parse_memory();
> +	qcom_parse_memory(internal_valid);
>  
>  	return (void *)gd->fdt_blob;
>  }
>  
> diff --git a/arch/arm/mach-snapdragon/dram.c b/arch/arm/mach-snapdragon/dram.c
> index c4c60039cb4c..ef226e000858 100644
> --- a/arch/arm/mach-snapdragon/dram.c
> +++ b/arch/arm/mach-snapdragon/dram.c
> @@ -9,14 +9,47 @@
>  #include <asm-generic/unaligned.h>
>  #include <dm.h>
>  #include <log.h>
>  #include <sort.h>
> +#include <soc/qcom/smem.h>
> +
> +#define SMEM_USABLE_RAM_PARTITION_TABLE 402
> +#define RAM_PART_NAME_LENGTH            16
> +#define RAM_NUM_PART_ENTRIES            32
> +#define CATEGORY_SDRAM 0x0E
> +#define TYPE_SYSMEM 0x01
>  
>  static struct {
>  	phys_addr_t start;
>  	phys_size_t size;
>  } prevbl_ddr_banks[CONFIG_NR_DRAM_BANKS] __section(".data") = { 0 };
>  
> +struct smem_ram_ptable_hdr {
> +	u32 magic[2];
> +	u32 version;
> +	u32 reserved;
> +	u32 len;
> +} __packed;
> +
> +struct smem_ram_ptn {
> +	char name[RAM_PART_NAME_LENGTH];
> +	u64 start;
> +	u64 size;
> +	u32 attr;
> +	u32 category;
> +	u32 domain;
> +	u32 type;
> +	u32 num_partitions;
> +	u32 reserved[3];
> +	u32 reserved2[2]; /* The struct grew by 8 bytes at some point */
> +} __packed;

This looks like smem_ram_ptn_v2, as defined in LK:
https://github.com/msm8916-mainline/lk2nd/blob/5e6f1adcb1c070e28a70dc1f3d807ce9538f61c5/platform/msm_shared/smem.h#L620-L660

We need to add a check for smem_ram_ptable_hdr->version and handle the
older structs as well. DB410c has version 1, which is missing the 8
bytes noted in the comment above. This makes it misbehave quite badly...

If I drop the u32 reserved2[2] above it works well though, and correctly
handles variants of DB410c with 2 GiB instead of 1 GiB RAM.

Perhaps it's enough to handle _v1 and _v2 for now. v0 has 32-bit
start/size fields on old SoCs, not sure if anyone is trying to run
U-Boot on these at the moment.

Thanks,
Stephan
