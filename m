Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBBACD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 12:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7ACE8394E;
	Mon, 11 May 2026 14:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PnwcGfe6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43A6583CD3; Mon, 11 May 2026 14:25:39 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D94580F0E
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 14:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6746d0b2b4aso6356724a12.3
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 05:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778502336; x=1779107136; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cX7icWrFVuqZdOwJah+2ILwQekpj6CKeA7nOkVAWBO4=;
 b=PnwcGfe6UdwabeU4bJr6W9A6S6NMQOLy/0LCQToFo83XLrYSalPeKMylhXEvcMM0gG
 G15G4TL3TFygjYJM1pvqNQVy4oDlrjmYSZNXdJNCPy7+7Fa4mdjiBAzTcHptLk/qTfB0
 6iQ44IkpNL5+xWJiFV2H3WDHVRjN7G+0EbwwDaJ+LxzfAPoOq4PWykBv464mysZhyNIM
 N1NtwqSA6SqWi4dADT5F/wWtIpixZZvI6zkWBvOs6d+5ZzIod05hFlUITRKIhHbCq6lA
 naG4ZDh+sUmucKB6SlFkH+zJplJoDnV7y5OOJAFJ5vq08cDfL0HzbHpb0ZBNe2MJmKU6
 Vg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778502336; x=1779107136;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cX7icWrFVuqZdOwJah+2ILwQekpj6CKeA7nOkVAWBO4=;
 b=YMg6U7mVl2bbhcqWmuafT+x+nTrDWrJMRSdc/nYOCxUDzck9r998dG1m8t37MJ50Wx
 lFqleurQ+KXq+OCqCvPPAGrwebrXIkCThLFAvl89/bnm/5JisrHE40wDq887XEhA6lvQ
 TSDB6mDMRKx2cLu/u/nVH92xjXJaaCpkDVcnhbyUUPYhxBtQ4/MVtptKoFPa6yI5BWoQ
 eId+YGxmiNwsMcQcrkRs63HiRmhRxmDRCqYlGUGdl1XfBnmP5Fm+f1rIbcr3v5ByiYAR
 cEGvo1upkRsCtHMQ3KJ65il4qxeXPOLNTqbyoBFGUc9cBhRh3Fvd6hJz2EqdAqPQseVn
 bJNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ82L77PkGPdQKeAzDv4SX4gQcL1544nsVj5f9TV44QEaaMdB5WMtnNEmn9rdZcdKj+OkvVWUrU=@lists.denx.de
X-Gm-Message-State: AOJu0YzUtLzwAlGxKSIGGGrY93LdpyrZJu5XnWyJm3nm//DIJ3GIOb00
 BXnS0eSlMIyRIqQ5zO/QwivsJrm992aeQKMCZ365nrLPf9ZoudvrCudW6F3/nJD3q6w=
X-Gm-Gg: Acq92OGZfgNFixBRRcMFRvHFmZDYk2C7tpQ1iAQLXrplSZiBkX9rZcmswgmuCKUbcFV
 izAx0bpNl385uBsRp6hO8/UZW9l3KoZztnzBKGVrrS9ZrwxgF6GQrkHHaIm43TLzQF97idZMDq7
 gvCPrRQx+YCeyYqH6p0csNyrXp8xhhs9KCoCuFhaz4pS8Sx/nEPBYm2HGKTamT/T7wpH11RzPpC
 nHy0gp7uvVFQ7plQmjykaChCJ+B9u4VXqe3Tl5jhbri83tx0QyWauj5M7Lpiud7GATS1TuKFX0j
 KmvYuNjwKTVnzUytcSEbUg4ANc7VT+6AqXBxz3d1lM+FNwq6ZCp4Z9/YI3GnqWsGQLpLlzJWqU3
 Kxr/7KbrSqP7PhUV6CUQtLnA8MIOhLzgU0Zbq1CZSI7sRss1WrA87hWbgXoqYSk4MN7avYD317m
 cWnHPNzwRaoXtY177N2wHtHMqSjsberHh9JNVDk/vrLO2CfbWvHoSP+XJ/KqrUXIVEvV3iXZtU3
 V5O
X-Received: by 2002:a05:6402:3057:b0:67b:7a8f:3e2c with SMTP id
 4fb4d7f45d1cf-67d6489e199mr10065836a12.25.1778502336276; 
 Mon, 11 May 2026 05:25:36 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67ef0e1a221sm3718254a12.24.2026.05.11.05.25.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 05:25:35 -0700 (PDT)
Message-ID: <33394674-5978-4967-8583-bf292ebfd9fb@linaro.org>
Date: Mon, 11 May 2026 14:25:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] armv8: mmu: Extend mmu_map_region() to allow uncached
 mappings
Content-Language: en-US
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Cc: trini@konsulko.com, neil.armstrong@linaro.org,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260508072806.2421694-1-sumit.garg@kernel.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260508072806.2421694-1-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Sumit,

On 08/05/2026 09:28, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> On Qcom platforms, cmd-db region is required to be mapped as uncached
> region especially when executing at EL2. Otherwise an xPU violation
> can be triggered due to cache operations as descibed by a similar fix
> for the kernel here:

Nice, I've run into this one before and it was pretty annoying.

It feels less than ideal to have more bool properties here, maybe we
could get something like pgprot_set_attrs()? actually is there a reason
that function wouldn't work in this case?

Kind regards,

> 
> Commit f9bb896eab22 ("soc: qcom: cmd-db: Map shared memory as WC, not WB")
> 
> So, let's map CMD-DB region as uncached to avoid any issues while
> booting U-Boot in EL2 mode.
> 
> Fixes: a9cbf76e4dd3 ("soc: qcom: cmd-db: map cmd-db region")
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  arch/arm/cpu/armv8/cache_v8.c | 11 ++++++++---
>  arch/arm/include/asm/system.h |  3 ++-
>  drivers/soc/qcom/cmd-db.c     |  2 +-
>  3 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 39479df7b21..05e90e1eb32 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -388,13 +388,18 @@ static void map_range(u64 virt, u64 phys, u64 size, int level,
>  	}
>  }
>  
> -void mmu_map_region(phys_addr_t addr, u64 size, bool emergency)
> +void mmu_map_region(phys_addr_t addr, u64 size, bool cached, bool emergency)
>  {
>  	u64 va_bits;
>  	int level = 0;
> -	u64 attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_SHARE;
> +	u64 attrs;
>  
> -	attrs |= PTE_TYPE_BLOCK | PTE_BLOCK_AF;
> +	if (cached)
> +		attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL);
> +	else
> +		attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC);
> +
> +	attrs |= PTE_BLOCK_INNER_SHARE | PTE_TYPE_BLOCK | PTE_BLOCK_AF;
>  
>  	get_tcr(NULL, &va_bits);
>  	if (va_bits < 39)
> diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> index 5ed6833c155..52ab86112fb 100644
> --- a/arch/arm/include/asm/system.h
> +++ b/arch/arm/include/asm/system.h
> @@ -306,9 +306,10 @@ void flush_l3_cache(void);
>   *
>   * @start: Start address of the region
>   * @size: Size of the region
> + * @cached: Map memory as cacheable or not
>   * @emerg: Also map the region in the emergency table
>   */
> -void mmu_map_region(phys_addr_t start, u64 size, bool emerg);
> +void mmu_map_region(phys_addr_t start, u64 size, bool cached, bool emerg);
>  
>  /**
>   * mmu_change_region_attr() - change a mapped region attributes
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> index d0a6047b8a6..61e15783123 100644
> --- a/drivers/soc/qcom/cmd-db.c
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -248,7 +248,7 @@ static int cmd_db_bind(struct udevice *dev)
>  	}
>  
>  	/* On SM8550/SM8650 and newer SoCs cmd-db might not be mapped */
> -	mmu_map_region((phys_addr_t)base, (phys_size_t)size, false);
> +	mmu_map_region((phys_addr_t)base, (phys_size_t)size, false, false);
>  
>  	cmd_db_header = base;
>  	if (!cmd_db_magic_matches(cmd_db_header)) {

-- 
// Casey (she/her)

