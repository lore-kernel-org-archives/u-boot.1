Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B55C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 18:56:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D137B8070C;
	Thu, 27 Mar 2025 19:56:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r+b+0NG/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE224809A4; Thu, 27 Mar 2025 19:56:10 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4020806FC
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 19:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39ac9aea656so1111696f8f.3
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 11:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743101768; x=1743706568; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=buKvuZ2xW4Cy4X8f0Hiy9NhdRbYkVQzmrHusdwePfDY=;
 b=r+b+0NG/hALiZeUHvwF5XFsAZAeDU/H1uk2y/aD/0/8ysVM1raldHkWroelcLCIIZh
 OvsIjbXYuF6Hw81wLOml7jWMhjgDA5TalYJgcFXCQbQgPj1xGkjCOJZwkjrPvFM7rn7j
 sy9NS+gA4mnfVTRK6dnRIb5ReiPp1Zq0BaEI554EfyXGxvcrb52UGUzglx5VEumysUid
 /L4BpgsFDp23wGPzsOlFVeccfsJg78kgVAyYtU7w5Xk2PERUpTRgTFGe6MevrHbHX+aA
 D4YPuqucRW1fz0L34KNjdssX63t1z5ie8h69djD5/HtJbDGL16sIrhEhdpRUopk8p/wL
 NvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743101768; x=1743706568;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=buKvuZ2xW4Cy4X8f0Hiy9NhdRbYkVQzmrHusdwePfDY=;
 b=S1dmIqytwKrtx0bsmeC5dSDVrWNcNNyOedzjG6D9x0xX2nP4yR/grbwfc8i260hdZ1
 wDHrGewgvncM+BAaQoQwOT61uqfKf0Xb2EuqGfaQMB25+XbOVNJ04Jo6I0K4pkLph+vj
 GeWuEcWNIGWfHIsNSrwOEA2FyO7HT/ECWtP7GiUf6qzZfRWtZXSqwRtv3Q5pLko+LSRA
 qq3p82ORS0RWguRGN65Eq6BPRUnyMIprPuP54qpv1NSGLc3c0Q3weNiYzS59ck+feOYB
 5c8JcOfM/gQAQk9FwUh5MuBG5jailvALzoZkrLLjfA5T2+A3jXTJiVcb1QGKRYCou27n
 CN2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX610nDYZVkF4n12L0J2ZwWwWMy2lJzmmIq13LnjMmWI3OMiZJ+1BjWpma5XC3EFNH7gaFNskg=@lists.denx.de
X-Gm-Message-State: AOJu0YzrPnR39wHpQFzYReYf7J9kK9HKudf1T8K19k3hulH81ja7DbG5
 bFhmhW98ikQDSfTEsRCGHwfjn1EWINbyw5/LS8p9og6GTdgktWR3oayOjFRjfmg=
X-Gm-Gg: ASbGncsT6LufdVyMbvsQNz88alruV/I5HMHtN67sq4dt1J2FXEOrVcsXHwVp0YUIREy
 Lmop26V+JxNa15p3yIWjn+De78o9It8lfjHY5ZoMdqA1fLVKrUcBMELkLoA7L/1DmU8H8w2Ckd/
 EJXCNlfyf2Q9mgjfU3J4gLKQXq8uc5WC+n72iNzeDYf2NUgpcoHPIjvPgteUeockW8+OHGSbp4O
 wKEo4dyMtF+QA8ORvmMqtQHkpjfqJ5beOS9bBZOkKYsZ/ZsAIMQJuONmy0E7UarBNhqwSW07jLL
 2xa+spnxzXJ/aI025klJClmER6i5ANwh/WqvAA/t9HnBOoEoS7I14IHby0dnzdxaKsubm+ZSQFY
 =
X-Google-Smtp-Source: AGHT+IG4jTclixru6jEm6Mp+/Gm3NmFlby1cw/pkFZRY1LUukuIpWTu1VGIvv+4+LcsapQ/byrpVig==
X-Received: by 2002:a05:6000:18a8:b0:391:4559:876a with SMTP id
 ffacd0b85a97d-39ad1794cd7mr4675535f8f.46.1743101768100; 
 Thu, 27 Mar 2025 11:56:08 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82dede2csm45951605e9.5.2025.03.27.11.56.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 11:56:07 -0700 (PDT)
Message-ID: <3ebe03fa-d8cb-4c32-8106-2163f94f2aa4@linaro.org>
Date: Thu, 27 Mar 2025 19:56:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] mach-snapdragon: Support booting as a coreboot
 payload
To: Stephen Boyd <swboyd@chromium.org>, u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
References: <20250226221607.1283592-1-swboyd@chromium.org>
 <20250226221607.1283592-14-swboyd@chromium.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250226221607.1283592-14-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 2/26/25 23:15, Stephen Boyd wrote:
> Coreboot sets up the DRAM, CPU, and devices before booting a payload,
> meaning we can parse the coreboot tables at boot for memory info when
> running as a payload. Use the memory descriptors from coreboot if the
> tables are present so that Snapdragon SoCs can run U-boot as a coreboot
> payload.
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/mach-snapdragon/board.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 2ef936aab757..cb3df1c2adec 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -14,6 +14,7 @@
>   #include <asm/io.h>
>   #include <asm/psci.h>
>   #include <asm/system.h>
> +#include <cb_sysinfo.h>
>   #include <dm/device.h>
>   #include <dm/pinctrl.h>
>   #include <dm/uclass-internal.h>
> @@ -48,6 +49,10 @@ static struct {
>   
>   int dram_init(void)
>   {
> +#ifdef CONFIG_SYS_COREBOOT
> +	if (gd->arch.coreboot_table)
> +		return coreboot_dram_init();
> +#endif
>   	/*
>   	 * gd->ram_base / ram_size have been setup already
>   	 * in qcom_parse_memory().
> @@ -81,8 +86,21 @@ static void qcom_configure_bi_dram(void)
>   	}
>   }
>   
> +phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> +{
> +#ifdef CONFIG_SYS_COREBOOT
> +	if (gd->arch.coreboot_table)
> +		return coreboot_board_get_usable_ram_top(total_size);
> +#endif
> +	return gd->ram_top;
> +}
> +
>   int dram_init_banksize(void)
>   {
> +#ifdef CONFIG_SYS_COREBOOT
> +	if (gd->arch.coreboot_table)
> +		return coreboot_dram_init_banksize();
> +#endif
>   	qcom_configure_bi_dram();
>   
>   	return 0;

-- 
Caleb (they/them)

