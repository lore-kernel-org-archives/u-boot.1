Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE64CCF9F5
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 09:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A9D9838CC;
	Thu, 30 Oct 2025 10:07:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xIn8tvkQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEFAE838F8; Thu, 30 Oct 2025 10:07:39 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94B2B838BB
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 10:07:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-429a0d1c31aso492040f8f.1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 02:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761815257; x=1762420057; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=58apQIHLI5KxzD1Mbg/kJLKEjIIkDlUEFjVWiIpqEYk=;
 b=xIn8tvkQVic42gSJRaKez67WVZPD4R8L/NiU0hyGjv4S8I5Bavswj8sICh3WfumtkR
 TFJZnUdKGBAzaP2zfGnVj7l7p200DPL+yeZOuT10PDhTXp4g2In+5ArKUoG7ENT9m9v3
 VA1xpZCjI3kz9BOIh5ZmsQY6BzSMyRttJ+1QeDMScNaFiTCamiFaBVmPHE1U4EALPaLS
 SpQIofQtSR5lCmZ6A1kM3A6W5pkBezDNNc5OGe3kaaxNtny1tHinail7Agdtm5lRV01O
 cJVmCDcHYFR6KLTJKziB4YlDMy0PSYy9pIKDLBIMC3f91wAv6N+5269+68h+1YrYZb6f
 kPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761815257; x=1762420057;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=58apQIHLI5KxzD1Mbg/kJLKEjIIkDlUEFjVWiIpqEYk=;
 b=RxBHEBr68Dc4ZJhdCNYurtvCZurgoMBJclqmCZlbJ6noF4l+liH6grYPFQoLHNhRAD
 Gee4IJNIubepKYPSWiWxNF9II7IQykfZtn2Zf37ieZWNhIBJXmpDPe8fTQyWItEd8cx9
 Jp5/Pyg1r4P1n7iC5v6FmoysafAK6JK5cV2iqg1Cv+cesbGAXTX7rPFQYyccUzlzt2uF
 JHJ8xKw6yseCqcLCtpuRo1Pz9RTYOx+OFLOOOka9aTP1NMyyk+VG0f9AoBb7UpKOZqwb
 eh5IyGDU3sYGs7gLRwlixDJo2iA4iE+cDAuJmLxmEmHUWIXow+5F+sJhEKcLyK1BS+6q
 /8uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+Y5+qMjSzu9Q6/iupwiIsf5g9krcF6X50zBYkFP9b/ndFCkTwIUUGkWN9JtJOGdo0tmKp/CA=@lists.denx.de
X-Gm-Message-State: AOJu0YwzM5faiJ5npDEE8BY9WBMY+oTP0pbrKzJCVRGttq7slWSSA38X
 x6Dk7hIDT21uM8UvFlN3yV2Ty/SJKIUpAo6srdRccDk0XPUck4PM9zkUt7LB+1JFLAY=
X-Gm-Gg: ASbGncttD2lV5rzRove5WldkaNgE0NO+JXrLDxCcSQI9QPQoKcoyG62YLk5a6kt02Ig
 c6+1hpTJxevLVzhB5RiB3GAyXXMZ9j5r1k/xDirJcbokZa08Deavm0ZTJrX0WNROs/2UjDRWXvl
 5A1JaCkvv7VroCJkMkI2Gb4Gksypr28mmJbuT+1y6RrcC7WHdgo8wMhaa0sH56Mfhtc5ZqeaSjm
 fWFvbKPLz37yvC9cNQIRJKGmlHQWg6sYqR7qsZsCY8D6mUGQYjsG0uRz6IQJgBanuUh8GBqJwzW
 u56oaHMxsxI/U721Br6cdTHdV2x65W/M0W+Wmavzbb5jZkwDlGee9cW5/JacISkOv3F9ff3zk39
 8ma94ukqVbYwqHn88YPAhDmopJW9/PiNv4Guv5z9JiPwxLB+wdY2dJceWDQGUNdR/lSgCS2Hv7J
 zkmdXNrc97Mi6FdyosECWgzpVsPJjmDwKPPvZqxA8HlSdl3hUF3bvl2jw=
X-Google-Smtp-Source: AGHT+IGZBt5/g/HzMo7kAr9HRKxqK2Gdda+4Fv1GIvc+pd8jddJiuekh0t9EfCA5vCJVlax9go1Vew==
X-Received: by 2002:a05:6000:2890:b0:427:537:39e0 with SMTP id
 ffacd0b85a97d-429b4c56b39mr1994211f8f.14.1761815256952; 
 Thu, 30 Oct 2025 02:07:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:304d:21ea:1377:d0ce?
 ([2a01:e0a:3cb:7bb0:304d:21ea:1377:d0ce])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771832e857sm66301145e9.0.2025.10.30.02.07.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 02:07:36 -0700 (PDT)
Message-ID: <78845e36-a6dd-4ada-a0ea-2eb8a1dac26c@linaro.org>
Date: Thu, 30 Oct 2025 10:07:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] spl: fit: Add ability to jump to Linux via
 OpTee-OS on ARMv7a
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Janne Grunau <j@jannau.net>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20251028224335.83276-1-marek.vasut@mailbox.org>
 <20251028224335.83276-2-marek.vasut@mailbox.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251028224335.83276-2-marek.vasut@mailbox.org>
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

Hi Marek,

On 10/28/25 23:42, Marek Vasut wrote:
> Add support for jumping to Linux kernel through OpTee-OS on ARMv7a to SPL.

The proper spelling is "OP-TEE OS" (or simply "OP-TEE"). And "optee" when
mentioning a driver, subsystem or in the code (functions, variables etc.).

Thanks,
-- 
Jerome


> This is already supported on ARMv8a, this patch adds the ARMv7a support.
> Extend the SPL fitImage loader to record OpTee-OS load address and in case
> the load address is non-zero, use the same bootm-optee.S code used by the
> U-Boot fitImage jump code to start OpTee-OS first and jump to Linux next.
> 
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Janne Grunau <j@jannau.net>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Sam Edwards <cfsworks@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: Include armv7.h only on non-ARM64
> V3: No change
> ---
>  arch/arm/lib/spl.c   | 10 ++++++++++
>  common/spl/spl_fit.c | 20 ++++++++++++++++++++
>  include/spl.h        |  3 +++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/arch/arm/lib/spl.c b/arch/arm/lib/spl.c
> index 6c7d1fb5629..bce51b9cc7d 100644
> --- a/arch/arm/lib/spl.c
> +++ b/arch/arm/lib/spl.c
> @@ -16,6 +16,9 @@
>  #include <asm/global_data.h>
>  #include <linux/compiler.h>
>  #include <asm/mach-types.h>
> +#if defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
> +#include <asm/armv7.h>
> +#endif
>  
>  #ifndef CONFIG_SPL_DM
>  /* Pointer to as well as the global data structure for SPL */
> @@ -71,6 +74,13 @@ void __noreturn jump_to_image_linux(struct spl_image_info *spl_image)
>  	image_entry_arg_t image_entry =
>  		(image_entry_arg_t)(uintptr_t) spl_image->entry_point;
>  	cleanup_before_linux();
> +#if defined(CONFIG_BOOTM_OPTEE) && defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
> +	if (spl_image->optee_addr)
> +		boot_jump_linux_via_optee((void *)(spl_image->entry_point),
> +					  machid,
> +					  (u32)(spl_image->arg),
> +					  spl_image->optee_addr);
> +#endif
>  	image_entry(0, machid, spl_image->arg);
>  }
>  #endif	/* CONFIG_ARM64 */
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 746c3d2fa28..616df46e1c8 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -550,6 +550,23 @@ static int spl_fit_image_is_fpga(const void *fit, int node)
>  	return !strcmp(type, "fpga");
>  }
>  
> +static void spl_fit_image_record_arm32_optee(const void *fit, int node,
> +					     struct spl_image_info *spl_image,
> +					     struct spl_image_info *image_info)
> +{
> +#if defined(CONFIG_BOOTM_OPTEE) && defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
> +	const char *type = fdt_getprop(fit, node, FIT_TYPE_PROP, NULL);
> +
> +	if (!type)
> +		return;
> +
> +	if (strcmp(type, "tee"))
> +		return;
> +
> +	spl_image->optee_addr = image_info->load_addr;
> +#endif
> +}
> +
>  static int spl_fit_image_get_os(const void *fit, int noffset, uint8_t *os)
>  {
>  	if (!CONFIG_IS_ENABLED(FIT_IMAGE_TINY) || CONFIG_IS_ENABLED(OS_BOOT))
> @@ -903,6 +920,9 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
>  		    image_info.entry_point != FDT_ERROR)
>  			spl_image->entry_point = image_info.entry_point;
>  
> +		spl_fit_image_record_arm32_optee(ctx.fit, node, spl_image,
> +						 &image_info);
> +
>  		/* Record our loadables into the FDT */
>  		if (!CONFIG_IS_ENABLED(FIT_IMAGE_TINY) &&
>  		    xpl_get_fdt_update(info) && spl_image->fdt_addr)
> diff --git a/include/spl.h b/include/spl.h
> index cf45d411ecb..06dc28362d3 100644
> --- a/include/spl.h
> +++ b/include/spl.h
> @@ -288,6 +288,9 @@ struct spl_image_info {
>  	ulong entry_point;
>  #if CONFIG_IS_ENABLED(LOAD_FIT) || CONFIG_IS_ENABLED(LOAD_FIT_FULL)
>  	void *fdt_addr;
> +#endif
> +#if defined(CONFIG_BOOTM_OPTEE) && defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
> +	ulong optee_addr;
>  #endif
>  	u32 boot_device;
>  	u32 offset;
