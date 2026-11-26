Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B109A606A321
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o/5MHoQD;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=UBVaxvk5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ECFA960ACD;
	Thu, 26 Nov 2026 21:13:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id luxFNl9g1vSx; Thu, 26 Nov 2026 21:13:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E637260A8F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795727616;
	b=kayE7Ct3DD2aFE3TxZQ2L6VZ3EIDum6m4JE9DU5nKs8hN4I7zn+b6pAIJmvOrkgOKnou
	 cow++vA8xYr5d8YIWvJ+MiI46qrTnQVdZxPZkyn7ykk8eGAeS3dTWK7wYZ5ZLea8EykLP
	 LFHOTgxQqLCnm8XaswZhcU/u7HP838ULDMhXHjjH3Zowhyf2Z8q4J43IvyfLzBv0UxnQb
	 vh8NG3tuZPZ/16683clQxluUf0u5biB0aui15fM73R7Tftdj4wYlV6hL/i2f0jZIIw65c
	 zIzOOz9X2n4hUwpiZaeu+t4VYId5lvhplXo3140bgfRLELe/qC6DjM8FH6+6PtAofDA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795727616;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ALnQdkaSa6PfnhRzTD4SnnJd5bTtR+RlyWIDVlCFD54=;
	b=alMxmIrAQ4b8bCv0beU8mDwgeqI5KP9KqWoI9vmwuVRX89/hYu5SEmeznF5VurgvzqL3
	 1bQG3MuBSj8fZ2l1GPs7VZhH40xIGm6ZY405mZyR/C2Mhbg/UyCzd8Tlqne76+bbH5kXG
	 uBGB2Hv5J6DtLi5JvmUfFnnjG3be3jUwsYli1v2LOYQGP2e/2Ff5l01/+CQ+EONMx3TeN
	 L5dmuh344o+rbht3NJAFE/+YBFD4877VjRo8DlKY6aVQeWHxUCgPc6Dfb/Bh009eBKxVN
	 tvXwiBtYsjV29pHaCvbo3qXuutduBv90fga/Zu7fDYuVu46iGlzK+4rKEzxWOBXo92w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795727616;
	bh=ALnQdkaSa6PfnhRzTD4SnnJd5bTtR+RlyWIDVlCFD54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o/5MHoQDpWs8Xd9IEMJ6ChH89KbttArJI7z0HimlcOLUMnw0O9lOaHQsAlnjhsf2d
	 1f9Ufv4ItADHc1685ef4YVNNJ9bzmr3+UgxZzOW+rH/WlLxrtPlkZYdDn8PfjRNR1H
	 1g4/OQjyWEaR2f5+CkviUZCPGutFT7iOUrK/F8t/wFHx70WHLtztKejv0tNhya6wX7
	 ikm/8u415Rt4NrVoTIpCoeLgUX8JmetaVJ5/d/Qr/F0kJJNq/EnNG/HIZD7BnytTYy
	 6giEHglhuGIL9B5QZXjXZV8o4AleHCw78j+Fj9TNESUI+WSI1yIGose+VOUqPNObty
	 mMcmloDWRIwyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E637260A8F;
	Thu, 26 Nov 2026 21:13:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 85EB9266
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 21:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6C6AA4054A
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 21:13:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MAiNXaaHx4VS for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 21:13:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E37AD400CB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b135"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b135; helo=mail-yx1-xb135.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=UBVaxvk5
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E37AD400CB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 21:13:32 +0000 (UTC)
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-679a2b5fe87so6855260d50.3
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795727611; x=1796332411;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ALnQdkaSa6PfnhRzTD4SnnJd5bTtR+RlyWIDVlCFD54=;
 b=UBVaxvk5mXkzE/0mkKuUMq0WdEXWaJXPoohcnQHerenBP4YHwwbORLCrDCc4IRyLPf
 dGoH1krSanuu0YNWmUxbyijnkGFIoDp+CnaWE4xYTs9JlbERDXMA4ntHG3MVxMQb8KgA
 0+9FB+z7RAPgcLfrPh753OtPGFRCk/lZdXcC650IrGQf+HY4MsAgtQ8ttLw7xy8SR6K7
 D0CIv51+5/s2R9Hc5Nd8Mz4OzBoh5gcVCdOShCDSg2jP/fZPqbA6IkiOR1KKn/VLCk2E
 mhtW3vC+8o2N1uNLlmwHsOSK+oWHSceco10dJJ41lVX9XSSOsndCZuSRxBeSQx3JA8G2
 3GEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795727611; x=1796332411;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ALnQdkaSa6PfnhRzTD4SnnJd5bTtR+RlyWIDVlCFD54=;
 b=f1r3mLBX7cfpcbyrp4hl+kFNKwZ+/+oDGN6OhlZT7YzG13lrQruxp/fH9gl/o2r5sL
 Q5c8J066xuNTgPdDDz9vV+1SExpNF/2DFC9DPfSm+iaGZFZafa+VI52uOQZcrBtuZzTO
 C+KfflyVvVlhMTAbpgJ9u/94ET3QoVl9VwD4GzKAsVyv31WNYqbPIZb03hoNYOQ5QVTS
 DWCD3T0c7ewf5UQxPuZsDEG8DBOiKUPcPVWqe/rpSLs4q0DHS0MzPBhuf7mBMsFqNeL7
 6D3RrA23kLaBKFd7f/1QCYxli3YwRWMckw9syIjjV2LgclxwYXgsCwsakuSjAzCb3SO3
 +eOg==
X-Gm-Message-State: APuU4Z9ubiXWeHPAy37GKSk7r635rMoP54pMo2YFDk4bS++aXpkeXEdH
 gdzPcW0ZNtOnWxXxA4pKeI1Vsl5S/y98LxsboWPQ6Tv82aPjvV5J4cvu5PlxTyeWxAU=
X-Gm-Gg: AZFdTZdC7OFqTugSq0sEFVBJyV3JtZNFpr+fOCTJgr5EiNxv8kOLfQDL3qFFFDlWwLp
 dUJqCyeuBWy7OF4AeP4hN8xacJRocbsnknGs77UU9p0t9l67z3nUO3gpVI9HRosMRtcdGDYFuFb
 w+YlTLymDlV/GaKEeEFNBQaApgcsfj/lzjmHMOGP7ctLFlVndvyuQb86UJSYqzd1Nypk6SXcljs
 tp/7mnyKu2UFGJon52ax9z0vQbWlUrBYupqZDYTMnxWS2rYa425olw84mtf9Md4Ps2SN8QlO0Am
 mY5iB3i2AdWnYE0tmWaVv2cD7ju6/8+2+F/zh+JiDxMN0TphXQ5/I5J4dhO352YNKXUlA8Gqsbm
 kihYBpCExQEAMdbKkZzVSfWR4DVUgVOZLUfxpYLqDB7B4MtZRMCadH7MIMfeEzDfldBJ+IgEp8+
 U9iCDbLmIAOSmo7KuwsLDFex+9CmlOEcspfrGTyRe4nqfUw1aGYYYryB95QCuTvaTg8OimRX04g
 MzXphGG3YFJeYqEIzdsYG1GtqFBgy1meV+Ta0O2oHWsWnnivVIuwDu93dvvut+3w8mcdPzvytSf
 99tAyBTrPDCZE1lB3Pl2SWYgXSsjjpIeq8UopzNH/NCRTSVWAveKfxrgMBK7f4SWSYujo/eV+Q=
 =
X-Received: by 2002:a05:690e:b8a:b0:679:9715:a918 with SMTP id
 956f58d0204a3-67df42cff51mr7529026d50.8.1795727611210; 
 Thu, 26 Nov 2026 13:13:31 -0800 (PST)
Received: from toolbox ([2600:1700:220:59e0:e60f:6607:b877:913c])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67df335b3aesm10376500d50.12.2026.11.26.13.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 13:13:30 -0800 (PST)
Date: Thu, 26 Nov 2026 15:13:07 -0600
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>, 
 u-boot-spacemit@groups.io, Tom Rini <trini@konsulko.com>,
 Yixun Lan <dlan@kernel.org>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 E Shattow <e@freeshell.de>, 
 Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>
Subject: Re: [PATCH 2/5] riscv: spacemit: k3: Add SPL initialization support
Message-ID: <zfl63cgj44hzx23ozxkd43uwvv74wfiuhu6bf6o6su6skzns6u@fp2udqudxmhy>
References: <20261106-k3-ddr-v1-0-1e60e1d78020@pigmoral.tech>
 <20261106-k3-ddr-v1-2-1e60e1d78020@pigmoral.tech>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106-k3-ddr-v1-2-1e60e1d78020@pigmoral.tech>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 12:40:40AM +0800, Junhui Liu wrote:
> Add SPL initialization support for SpacemiT K3. Enable instruction and
> data caches and cache snooping during early hart initialization, and
> provide the timer configuration needed for M-mode execution.
> 
> Initialize I2C and read the DDR part number from the board's TLV EEPROM.
> Populate the RAM driver's platform data before probing it to initialize
> DRAM. Set up the DRAM PMA boundary and record the RAM base and size in
> global data.
> 
> Loading the next boot stage is not yet supported.
> 
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  arch/riscv/cpu/k3/Kconfig            |   6 +-
>  arch/riscv/cpu/k3/Makefile           |   1 +
>  arch/riscv/cpu/k3/spl.c              |  52 ++++++++++++++
>  arch/riscv/include/asm/arch-k3/csr.h |  20 ++++++
>  arch/riscv/include/asm/arch-k3/spl.h |  11 +++
>  board/spacemit/k3/Makefile           |   5 ++
>  board/spacemit/k3/spl.c              | 127 +++++++++++++++++++++++++++++++++++
>  include/configs/spacemit-k3.h        |   3 +
>  8 files changed, 224 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/cpu/k3/Kconfig b/arch/riscv/cpu/k3/Kconfig
> index 5474ac11243..dee79644b87 100644
> --- a/arch/riscv/cpu/k3/Kconfig
> +++ b/arch/riscv/cpu/k3/Kconfig
> @@ -9,10 +9,14 @@ config SPACEMIT_K3
>  	select BINMAN
>  	select ARCH_EARLY_INIT_R
>  	select SYS_CACHE_SHIFT_6
> +	select SUPPORT_SPL
>  	imply CPU
>  	imply CPU_RISCV
> -	imply RISCV_TIMER if RISCV_SMODE
> +	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
> +	imply RISCV_ACLINT if RISCV_MMODE
> +	imply SPL_RISCV_ACLINT if SPL_RISCV_MMODE
>  	imply CMD_CPU
> +	imply SPL_CPU
>  	imply OF_UPSTREAM
>  
>  endif
> diff --git a/arch/riscv/cpu/k3/Makefile b/arch/riscv/cpu/k3/Makefile
> index fba4e4b0a3f..6afe6caac69 100644
> --- a/arch/riscv/cpu/k3/Makefile
> +++ b/arch/riscv/cpu/k3/Makefile
> @@ -3,3 +3,4 @@
>  # Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
>  
>  obj-y += dram.o
> +obj-$(CONFIG_XPL_BUILD) += spl.o
> diff --git a/arch/riscv/cpu/k3/spl.c b/arch/riscv/cpu/k3/spl.c
> new file mode 100644
> index 00000000000..e8ee32e37fd
> --- /dev/null
> +++ b/arch/riscv/cpu/k3/spl.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
> + */
> +
> +#include <asm/arch/csr.h>
> +#include <asm/arch/spl.h>
> +#include <asm/csr.h>
> +#include <asm/global_data.h>
> +#include <dm.h>
> +#include <ram.h>
> +
> +#define K3_DRAM_UPPER_LIMIT_ADDR	0x1100000000ULL
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +static void setup_dram_pma(void)
> +{
> +	csr_write(CSR_X100_PMAADDR8, K3_DRAM_UPPER_LIMIT_ADDR >> 2);
> +	asm volatile("sfence.vma zero, zero" ::: "memory");
> +}
> +
> +int spl_dram_init(void)
> +{
> +	struct ram_info info;
> +	struct udevice *dev;
> +	int ret;
> +
> +	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
> +	if (ret) {
> +		printf("DRAM init failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	setup_dram_pma();
> +
> +	ret = ram_get_info(dev, &info);
> +	if (ret)
> +		return ret;
> +
> +	gd->ram_base = info.base;
> +	gd->ram_size = info.size;
> +
> +	return 0;
> +}
> +
> +void harts_early_init(void)
> +{
> +	csr_set(CSR_X100_CACHE_CTL, CSR_X100_CACHE_CTL_ICACHE_EN |
> +				    CSR_X100_CACHE_CTL_DCACHE_EN);
> +	csr_set(CSR_X100_SNOOP_CTL, CSR_X100_SNOOP_CTL_EN);
> +}
> diff --git a/arch/riscv/include/asm/arch-k3/csr.h b/arch/riscv/include/asm/arch-k3/csr.h
> new file mode 100644
> index 00000000000..a6c3e6af9f5
> --- /dev/null
> +++ b/arch/riscv/include/asm/arch-k3/csr.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
> + */
> +
> +#ifndef _ASM_ARCH_K3_CSR_H_
> +#define _ASM_ARCH_K3_CSR_H_
> +
> +#include <linux/bitops.h>
> +
> +#define CSR_X100_CACHE_CTL		0x7c0
> +#define  CSR_X100_CACHE_CTL_ICACHE_EN	BIT(1)
> +#define  CSR_X100_CACHE_CTL_DCACHE_EN	BIT(0)
> +
> +#define CSR_X100_SNOOP_CTL		0x7f0
> +#define  CSR_X100_SNOOP_CTL_EN		BIT(0)
> +
> +#define CSR_X100_PMAADDR8		0x7e8
> +
> +#endif /* _ASM_ARCH_K3_CSR_H_ */
> diff --git a/arch/riscv/include/asm/arch-k3/spl.h b/arch/riscv/include/asm/arch-k3/spl.h
> new file mode 100644
> index 00000000000..7dda93cfda8
> --- /dev/null
> +++ b/arch/riscv/include/asm/arch-k3/spl.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
> + */
> +
> +#ifndef _ASM_ARCH_K3_SPL_H_
> +#define _ASM_ARCH_K3_SPL_H_
> +
> +int spl_dram_init(void);
> +
> +#endif /* _ASM_ARCH_K3_SPL_H_ */
> diff --git a/board/spacemit/k3/Makefile b/board/spacemit/k3/Makefile
> new file mode 100644
> index 00000000000..67f30a40e6c
> --- /dev/null
> +++ b/board/spacemit/k3/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
> +
> +obj-$(CONFIG_SPL_BUILD) += spl.o
> diff --git a/board/spacemit/k3/spl.c b/board/spacemit/k3/spl.c
> new file mode 100644
> index 00000000000..4798e5c9ebc
> --- /dev/null
> +++ b/board/spacemit/k3/spl.c
> @@ -0,0 +1,127 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
> + */
> +
> +#include <asm/arch/spl.h>
> +#include <asm/global_data.h>
> +#include <asm/io.h>
> +#include <display_options.h>
> +#include <dm/device.h>
> +#include <dm/uclass.h>
> +#include <errno.h>
> +#include <linux/delay.h>
> +#include <linux/string.h>
> +#include <soc/spacemit/k3-ddr.h>
> +#include <spl.h>
> +#include <tlv_eeprom.h>
> +
> +#define MUX_MODE5		5
> +#define EDGE_NONE		BIT(6)
> +#define PULL_UP			(6 << 13)
> +#define I2C_PIN_CONFIG(x)	((x) | EDGE_NONE | PULL_UP)
> +
> +#define MFP_GPIO_46		0xd401e0b8
> +#define MFP_GPIO_47		0xd401e0bc
> +
> +#define K3_TLV_CODE_DDR_PART_NUMBER	0x45
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +static void i2c_early_init(void)
> +{
> +	struct udevice *bus;
> +
> +	/* EEPROM uses I2C2 on GPIO46 and GPIO47. */
> +	writel(I2C_PIN_CONFIG(MUX_MODE5), (void __iomem *)MFP_GPIO_46);
> +	writel(I2C_PIN_CONFIG(MUX_MODE5), (void __iomem *)MFP_GPIO_47);
> +
> +	udelay(100);
> +
> +	uclass_first_device(UCLASS_I2C, &bus);
> +	while (bus) {
> +		uclass_next_device(&bus);
> +		if (!bus)
> +			break;
> +	}
> +}
> +
> +static int read_ddr_part_number(char *part, size_t part_size)
> +{
> +	struct tlvinfo_header *header;
> +	u8 contents[TLV_INFO_MAX_LEN];
> +	struct tlvinfo_tlv *entry;
> +	u8 *end;
> +	int ret;
> +
> +	ret = read_tlvinfo_tlv_eeprom(contents, &header, &entry, 0);
> +	if (ret)
> +		return ret;
> +
> +	end = (u8 *)(header + 1) + be16_to_cpu(header->totallen);
> +
> +	while ((u8 *)entry + sizeof(*entry) <= end) {
> +		if ((u8 *)entry + sizeof(*entry) + entry->length > end)
> +			return -EINVAL;
> +
> +		if (entry->type == TLV_CODE_CRC_32)
> +			break;
> +
> +		if (entry->type == K3_TLV_CODE_DDR_PART_NUMBER) {
> +			if (!entry->length || entry->length >= part_size)
> +				return -EINVAL;
> +
> +			memcpy(part, entry->value, entry->length);
> +			part[entry->length] = '\0';
> +
> +			return 0;
> +		}
> +
> +		entry = (void *)(entry->value + entry->length);
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +static int setup_ddr_plat(void)
> +{
> +	struct k3_ddr_plat *plat;
> +	struct udevice *dev;
> +
> +	dev = uclass_try_first_device(UCLASS_RAM);
> +	if (!dev)
> +		return -ENODEV;
> +
> +	if (!device_is_compatible(dev, "spacemit,k3-ddrc"))
> +		return -ENODEV;
> +
> +	plat = dev_get_plat(dev);
> +
> +	return read_ddr_part_number(plat->part_number, sizeof(plat->part_number));

Add some kind of fallback here in case we can't read the value from EEPROM. You could use the smallest supported value (4G)? The vendor U-Boot SPL seems to have a fallback, so this should too.

Regards
Anirudh Srinivasan
