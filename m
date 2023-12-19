Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DAAC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:22:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30C80876CF;
	Tue, 19 Dec 2023 17:22:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nf5XJYc5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EB1B877D9; Tue, 19 Dec 2023 17:22:09 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D1C687775
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:22:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40d22d3e751so5677925e9.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703002926; x=1703607726; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xfKRXsMRMxYuKp/6ao5NVo6ddSGFnoYx1GAIdpY/eqk=;
 b=nf5XJYc5JQKrD35zAiftvSb6wYlYUR07a6PAH1vp/uO+jgX6Q7HBNF96pX1eNV9OjG
 fusGiiJZx69+6GtU90RjNgXOpJeEMsJqNrA/s4Q+xRyeDm0edrRTrO+Mi6xWcBpmR5CI
 Idn2GLhHv5XpnlgBCMXZy0CV4DOErxxRn8yNejNhQb+ksKwQLZ6XhTw8WsLCm+V8UMeY
 MFIqNs4RJ90T7v8UBGID6PRxPceXf7grEWsEHIjEp/d1wuPPx5EHe4aWqvD32f1JfHxL
 TCueHtoImiHObXVz8Rx+zjAxyLLw4zO7ssqY4dUQAC2kCKc7ThMkgQwOpCRfxOpByEt9
 8q6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703002926; x=1703607726;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xfKRXsMRMxYuKp/6ao5NVo6ddSGFnoYx1GAIdpY/eqk=;
 b=Dkc1+Em+x40MMm9iOPHDmgVKWfRIkyNfP+QQ3ceBKrvDopCtV0JQ5NihzyRTlBWwAV
 e0Wgt7darSYmi5B8jzRwKW1mroUluVaQr7odqDsdnQlA4BJL4UTwfaqPHP0erjekbp9U
 UgaaNkRAEXK31NSuiWjdyCC+pezt/y+8Rr3JumCO/eahFpOu95tEE3+bZCQ76rvQI8qM
 ivKgKdj1vaTO2KJPOV5jgCB6mFAbXzOCr7c4qCi76KyDH/2CzGc8FgXY44wgAJ1sslbY
 5BUZjMWGfQKGkukgnY4acn/DgGBjy9Xnzuy9Fr7o1k0Nsx84p9iMlZW9le2qhIYg7+aM
 CNVA==
X-Gm-Message-State: AOJu0Yxciy8ERl8/kvA66bUDtvpoQKXqB3hScrKsbXxdkIXnlN16Wt/F
 hxJF82dzLXsK2XRDOhstZGeT4A==
X-Google-Smtp-Source: AGHT+IHovgljYx18d2dKN4wX97VbkXd531F4k6HoFIOAWYCy6eth35SHqNK+KbR1tAODRlPTCt2RSg==
X-Received: by 2002:a05:600c:6988:b0:40b:5e4a:233e with SMTP id
 fp8-20020a05600c698800b0040b5e4a233emr735531wmb.64.1703002926487; 
 Tue, 19 Dec 2023 08:22:06 -0800 (PST)
Received: from [192.168.1.83] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 f18-20020adffcd2000000b0033660aabe76sm8745564wrs.39.2023.12.19.08.22.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Dec 2023 08:22:05 -0800 (PST)
Message-ID: <0bce65e8-18d8-482a-8cd6-9b1d3a54ea7a@linaro.org>
Date: Tue, 19 Dec 2023 16:22:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/32] mach-snapdragon: dynamic load addresses
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <20231219-b4-qcom-common-target-v2-16-b6dd9704219e@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-16-b6dd9704219e@linaro.org>
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



On 19/12/2023 16:04, Caleb Connolly wrote:
> Heavily inspired by Apple board code. Use the LMB allocator to configure
> load addresses at runtime, and implement a lookup table for selecting a
> devicetree.
> 
> As some Qualcomm RBx boards have different RAM capacities and base
> addresses, it isn't possible to hardcode these regions.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/Kconfig                                 |  1 +
>  arch/arm/mach-snapdragon/board.c                 | 35 ++++++++++++++++++++++++
>  board/qualcomm/dragonboard410c/dragonboard410c.c |  2 +-
>  3 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e814910cb495..5ed9cbf378fa 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1075,6 +1075,7 @@ config ARCH_SNAPDRAGON
>  	select OF_SEPARATE
>  	select SMEM
>  	select SPMI
> +	select BOARD_LATE_INIT
>  	select OF_BOARD
>  	select SAVE_PREV_BL_FDT_ADDR
>  	select LINUX_KERNEL_IMAGE_HEADER
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index bf9b57682178..b00f536d38b4 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -20,6 +20,7 @@
>  #include <linux/bug.h>
>  #include <linux/psci.h>
>  #include <linux/sizes.h>
> +#include <lmb.h>
>  #include <malloc.h>
>  
>  DECLARE_GLOBAL_DATA_PTR;
> @@ -112,6 +113,40 @@ int board_init(void)
>  	return 0;
>  }
>  
> +void __weak qcom_late_init(void)
> +{
> +}
> +
> +#define KERNEL_COMP_SIZE	SZ_64M
> +#define SZ_96M			(SZ_64M + SZ_32M)

This patch should have been adjusted to use SZ_128M, I already confirmed
this to work on all boards. Somehow the old version crept in.
> +
> +#define addr_alloc(lmb, size) lmb_alloc(lmb, size, SZ_2M)
> +
> +/* Stolen from arch/arm/mach-apple/board.c */
> +int board_late_init(void)
> +{
> +	struct lmb lmb;
> +	u32 status = 0;
> +
> +	lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
> +
> +	/* We need to be fairly conservative here as we support boards with just 1G of TOTAL RAM */
> +	status |= env_set_hex("kernel_addr_r", addr_alloc(&lmb, SZ_128M));
> +	status |= env_set_hex("ramdisk_addr_r", addr_alloc(&lmb, SZ_96M));
> +	status |= env_set_hex("kernel_comp_addr_r", addr_alloc(&lmb, KERNEL_COMP_SIZE));
> +	status |= env_set_hex("kernel_comp_size", KERNEL_COMP_SIZE);
> +	status |= env_set_hex("scriptaddr", addr_alloc(&lmb, SZ_4M));
> +	status |= env_set_hex("pxefile_addr_r", addr_alloc(&lmb, SZ_4M));
> +	status |= env_set_hex("fdt_addr_r", addr_alloc(&lmb, SZ_2M));
> +
> +	if (status)
> +		log_warning("%s: Failed to set run time variables\n", __func__);
> +
> +	qcom_late_init();
> +
> +	return 0;
> +}
> +
>  static void build_mem_map(void)
>  {
>  	int i;
> diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
> index e403ecf0ad7c..2a502c7c2841 100644
> --- a/board/qualcomm/dragonboard410c/dragonboard410c.c
> +++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
> @@ -77,7 +77,7 @@ int misc_init_r(void)
>  	return 0;
>  }
>  
> -int board_late_init(void)
> +int qcom_late_init(void)
>  {
>  	char serial[16];
>  
> 

-- 
// Caleb (they/them)
