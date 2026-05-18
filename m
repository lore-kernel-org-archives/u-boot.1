Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D3FCD4F49
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 14:49:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41A4C83EF9;
	Mon, 18 May 2026 16:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xnkbxhAi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0ED083FEE; Mon, 18 May 2026 16:49:03 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BF06803C6
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 16:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-449de065cb3so2285925f8f.2
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 07:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779115739; x=1779720539; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=6qYGRMeRPz1sgehm0Y8br3mIFwLx5wpD9Ms6JjUQuEg=;
 b=xnkbxhAijupBZ1g+mNjQpeM/Gy45GB7YJfgDtdtA6RcRjDjEDvIr+xzYwlUUA7LYjI
 zhTzNrnYaVe+qmUrgZ9AZzBgkHZNeHlXSTwp8B8ETyPQBAqVxtLahDgs3/OftWznu3Ql
 jBBK019PmSeuUg2fCvzSA9Jl2rcncJIzF4VqQeJLEFvEmz8TKnWZhKiNlleAGy1f8MF7
 vTDZ687b4Wt+0mbuOHJdl4QXwL+G/H6fO+LU+8LC0fRwrK9XaV21Na31WIrkdJ866R2Q
 e9DUlUTBJg2IslNw4phDmoRAtfpOxwSKxdxsliRt5lFqLKcxaG32QasmETSK6SbOapGT
 8CXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779115739; x=1779720539;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6qYGRMeRPz1sgehm0Y8br3mIFwLx5wpD9Ms6JjUQuEg=;
 b=qi1fiVCvGUMkk/j7smDeBfqk/ZgiR2COenHrRtLkXGGEouB9QJBKxaoouS69L/ipJV
 0iusCPvdUHt1+U/LrjNXRNMBsWTMur1JP66HfcZvNudgrq4EYFxILHlXtpYc6tS0ON8I
 gTLADnKUf3KCH2LO1mMPM2/zQDAG5L9e+4cUicHxuZhFVx0Gpo7BDZ6HqOGJW913yR20
 AoituGEQQu36Zev0Vw8zX5Qj82woaIxBRYZOk/9hTymoEZPwoj8VoWTrJLK7cEJ9n+IS
 rUydYLdly0+t+lYdh36g7Fj5Z94uUSXSR841jFv+zHJOdOpsx5srGgufTrWirNDnpF1I
 ajjQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+1Fo9ZxMp06uAgYdTw2+Ndht2hXag7jf6OT6BYMrTWIhxPUThD/2GAbLF0W/DRcpE6EUX9Cfw=@lists.denx.de
X-Gm-Message-State: AOJu0YxEY3OYN9F+llEvAjSP4m21Y1NWfFhaRUNLPNtMOQLmosxCh9ss
 887Ts+DKNHKwTxn7FE50Xw0QKj48ccKKavcrTykseB365XqFirqtd8oO5azLlV8kVGo=
X-Gm-Gg: Acq92OGtZNW8ARKsVGJOKyQb6YeTLMjqh7fhCSxKKpvgZr4jb67Gx9MNqkw/a2RuhnV
 67LaWppVroexHaRk3cmN6SZyydT8U4fV6uQP1gjE3jG94hZQPPw25EvepTCYzRb6DVsfGgZEsTR
 Q6PGJkOewzk7lyEz1Z7wHGIDKLHKjevUXAcTBLgS+g1yksiB3EgsMUitCbrmEuMG97Y4eXfkPPV
 mk3g8nBMrRRo6J4mhBW0NuvN7otIMVl1DR5I9vSvvizqy1jFbzRXLUhYgTVTba1CptJvP5mpaAx
 W262knUNXDnpOlqHdOdDoNQmn2uqQd+K1ICYqZWqbcShA+Fltq2yHPCfR47ThGKtWrt9+iAD3Sy
 G3Ydf2WN3JDFmHhFvEu7PfchoKs3ztkHK9ZgF64wf+rcy47joazvzEcA0sFVJpIisdGN+YEvHRa
 1VDONu3iDAyHVBWXYQcxJqDO/I1WlVbZPhZJkd3sUI1B6+PVWJzbdiyLJtSCziA6GO0qX9Lotym
 axFJSDKkGic4qMGzQ==
X-Received: by 2002:a05:6000:2083:b0:452:d03a:7aad with SMTP id
 ffacd0b85a97d-45e5c5daea5mr26339897f8f.36.1779115738562; 
 Mon, 18 May 2026 07:48:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1029:e3c5:362e:1250?
 ([2a01:e0a:106d:1080:1029:e3c5:362e:1250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe2464sm39445648f8f.32.2026.05.18.07.48.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 07:48:58 -0700 (PDT)
Message-ID: <005f7d8d-4b80-4553-b6b3-dc4997dded51@linaro.org>
Date: Mon, 18 May 2026 16:48:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 13/15] mach-snapdragon: support parsing memory map from
 SMEM
To: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>,
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
 <20260504-b4-modernise-smem-v2-13-c01ec2ff3886@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260504-b4-modernise-smem-v2-13-c01ec2ff3886@linaro.org>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 5/4/26 20:57, Casey Connolly wrote:
> It is possible to derive the memory map for a Qualcomm platform from the
> SMEM shared memory region. The memory map is populated by the preloader.
> 
> Introduce support for parsing this data and using it to populate
> U-Boot's memory map. Since we aren't yet sure if this will work for
> every platform, it is not yet used in all cases, if U-Boot is booted
> with an internal FDT which has the memory map defined, this will
> be used instead.
> 
> If the FDT is internal FDT with no memory map defined, then U-Boot will
> try to use SMEM. This should remove the need to define the memory map
> statically in a U-Boot overlay for boards that don't chainload.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   arch/arm/Kconfig                     |   1 +
>   arch/arm/mach-snapdragon/board.c     |  45 +++++---
>   arch/arm/mach-snapdragon/dram.c      | 172 +++++++++++++++++++++++++------
>   arch/arm/mach-snapdragon/qcom-priv.h |  17 ++-
>   arch/arm/mach-snapdragon/rampart.h   | 194 +++++++++++++++++++++++++++++++++++
>   5 files changed, 386 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a8fcfe76296c..1da0677d85b3 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1140,8 +1140,9 @@ config ARCH_SNAPDRAGON
>   	select DM_RESET
>   	select POWER_DOMAIN
>   	select GPIO_EXTRA_HEADER
>   	select OF_CONTROL
> +	select QCOM_SMEM
>   	select SPMI
>   	select BOARD_LATE_INIT
>   	select OF_BOARD
>   	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index a2d97ad77910..7610891191fd 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -29,16 +29,18 @@
>   #include <lmb.h>
>   #include <malloc.h>
>   #include <fdt_support.h>
>   #include <usb.h>
> +#include <soc/qcom/smem.h>
>   #include <sort.h>
>   #include <time.h>
>   
>   #include "qcom-priv.h"
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
>   enum qcom_boot_source qcom_boot_source __section(".data") = 0;
> +enum qcom_memmap_source qcom_memmap_source __section(".data") = 0;
>   
>   static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
>   
>   struct mm_region *mem_map = rbx_mem_map;
> @@ -109,18 +111,18 @@ int board_fdt_blob_setup(void **fdtp)
>   		      (phys_addr_t)external_fdt);
>   
>   	/* Prefer memory information from internal DT if it's present */
>   	if (internal_valid)
> -		ret = qcom_parse_memory(internal_fdt);
> +		ret = qcom_parse_memory(internal_fdt, true);
>   
>   	if (ret < 0 && external_valid) {
>   		/* No internal FDT or it lacks a proper /memory node.
>   		 * The previous bootloader handed us something, let's try that.
>   		 */
>   		if (internal_valid)
>   			debug("No memory info in internal FDT, falling back to external\n");
>   
> -		ret = qcom_parse_memory(external_fdt);
> +		ret = qcom_parse_memory(external_fdt, false);
>   	}
>   
>   	if (ret < 0)
>   		panic("No valid memory ranges found!\n");
> @@ -373,23 +375,39 @@ static void configure_env(void)
>   
>   	qcom_set_serialno();
>   }
>   
> -void qcom_show_boot_source(void)
> +static void qcom_show_boot_context(void)
>   {
> -	const char *name = "UNKNOWN";
> +	const char *boot_source = "UNKNOWN";
> +	const char *memmap_source = "UNKNOWN";
>   
>   	switch (qcom_boot_source) {
>   	case QCOM_BOOT_SOURCE_ANDROID:
> -		name = "ABL";
> +		boot_source = "ABL";
>   		break;
>   	case QCOM_BOOT_SOURCE_XBL:
> -		name = "XBL";
> +		boot_source = "XBL";
>   		break;
>   	}
>   
> -	log_info("U-Boot loaded from %s\n", name);
> -	env_set("boot_source", name);
> +	log_info("U-Boot loaded from %s\n", boot_source);
> +	env_set("boot_source", boot_source);
> +
> +	switch (qcom_memmap_source) {
> +	case QCOM_MEMMAP_SOURCE_INTERNAL_FDT:
> +		memmap_source = "INTERNAL_FDT";
> +		break;
> +	case QCOM_MEMMAP_SOURCE_EXTERNAL_FDT:
> +		memmap_source = "EXTERNAL_FDT";
> +		break;
> +	case QCOM_MEMMAP_SOURCE_SMEM:
> +		memmap_source = "SMEM";
> +		break;
> +	}
> +
> +	log_info("Memory map loaded from %s\n", memmap_source);
> +	env_set("memmap_source", memmap_source);
>   }
>   
>   void __weak qcom_late_init(void)
>   {
> @@ -458,9 +476,9 @@ int board_late_init(void)
>   
>   	configure_env();
>   	qcom_late_init();
>   
> -	qcom_show_boot_source();
> +	qcom_show_boot_context();
>   	/* Configure the dfu_string for capsule updates */
>   	qcom_configure_capsule_updates();
>   
>   	return 0;
> @@ -648,11 +666,14 @@ void enable_caches(void)
>   	gd->arch.tlb_emerg = gd->arch.tlb_addr;
>   	gd->arch.tlb_addr = tlb_addr;
>   	gd->arch.tlb_size = tlb_size;
>   
> -	/* On some boards speculative access may trigger a NOC or XPU violation so explicitly mark reserved
> -	 * regions as inacessible (PTE_TYPE_FAULT) */
> -	if (fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs404") == 0) {
> +	/*
> +	 * On some boards speculative access may trigger a NOC or XPU violation so explicitly mark
> +	 * reserved regions as inacessible (PTE_TYPE_FAULT)
> +	 */
> +	if (qcom_memmap_source == QCOM_MEMMAP_SOURCE_SMEM ||
> +	    fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs404") == 0) {
>   		carveout_start = get_timer(0);
>   		/* Takes ~20-50ms on SDM845 */
>   		configure_reserved_memory();
>   		debug("carveout time: %lums\n", get_timer(carveout_start));
> diff --git a/arch/arm/mach-snapdragon/dram.c b/arch/arm/mach-snapdragon/dram.c
> index ad73b685a935..af5f3c84882c 100644
> --- a/arch/arm/mach-snapdragon/dram.c
> +++ b/arch/arm/mach-snapdragon/dram.c
> @@ -9,8 +9,12 @@
>   #include <asm-generic/unaligned.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <sort.h>
> +#include <soc/qcom/smem.h>
> +
> +#include "qcom-priv.h"
> +#include "rampart.h"
>   
>   static struct {
>   	phys_addr_t start;
>   	phys_size_t size;
> @@ -47,8 +51,12 @@ static void qcom_configure_bi_dram(void)
>   
>   	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
>   		gd->bd->bi_dram[i].start = prevbl_ddr_banks[i].start;
>   		gd->bd->bi_dram[i].size = prevbl_ddr_banks[i].size;
> +		debug("Bank[%d]: start = %#011llx, size = %#011llx\n",
> +		      i, gd->bd->bi_dram[i].start, gd->bd->bi_dram[i].size);
> +		if (!prevbl_ddr_banks[i].size)
> +			break;
>   	}
>   }
>   
>   int dram_init_banksize(void)
> @@ -57,8 +65,124 @@ int dram_init_banksize(void)
>   
>   	return 0;
>   }
>   
> +#define entry_field(v, e, field) (v == 0 ? ((struct ram_partition_entry_v0 *)(e))->field : \
> +				 (v == 1 ? ((struct ram_partition_entry_v1 *)(e))->field : \
> +				  ((struct ram_partition_entry_v3 *)(e))->field))
> +#define entry_start(v, e) entry_field(v, e, start_address)
> +#define entry_length(v, e) entry_field(v, e, length)
> +#define entry_category(v, e) entry_field(v, e, partition_category)
> +#define entry_domain(v, e) entry_field(v, e, partition_domain)
> +#define entry_type(v, e) entry_field(v, e, partition_type)
> +
> +/* Parse memory map from SMEM, return the number of entries */
> +static int qcom_parse_memory_smem(phys_addr_t *ram_end)
> +{
> +	size_t size;
> +	int i, j = 0, ret;
> +	struct usable_ram_partition_table_header *header;
> +	u32 ver;
> +	void *entry;
> +	u32 entry_size; // Size of each RAM partition entry (version dependent)

Re-order the variables since you'll send a v3

> +
> +	ret = qcom_smem_init();
> +	if (ret) {
> +		debug("Failed to initialize SMEM: %d.\n", ret);
> +		return ret;
> +	}
> +
> +	header = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_USABLE_RAM_PARTITION_TABLE, &size);
> +	if (!header) {
> +		debug("Failed to find SMEM partition.\n");
> +		return -ENODEV;
> +	}
> +
> +	ver = header->version;
> +	debug("SMEM RAM partition table version %u. %u entries\n", ver, header->num_partitions);
> +
> +	switch (ver) {
> +	case 0:
> +		entry_size = sizeof(struct ram_partition_entry_v0);
> +		entry = ((struct usable_ram_partition_table_v0 *)header)->entries;
> +		break;
> +	case 1:
> +		entry_size = sizeof(struct ram_partition_entry_v1);
> +		entry = ((struct usable_ram_partition_table_v1 *)header)->entries;
> +		break;
> +	default:
> +		pr_warn("Unknown SMEM ram partition table version!\n");
> +	case 2:
> +	case 3:
> +		entry_size = sizeof(struct ram_partition_entry_v3);
> +		entry = ((struct usable_ram_partition_table_v3 *)header)->entries;
> +		break;
> +	}
> +
> +	debug("SMEM RAM partition entry size: %u bytes\n", entry_size);
> +
> +	/* Check validy of RAM */
> +	for (i = 0; i < header->num_partitions && j < CONFIG_NR_DRAM_BANKS; i++, entry += entry_size) {
> +		debug("Entry %d: [%#010llx - %#010llx]\n", i, entry_start(ver, entry),
> +		      (u64)entry_start(ver, entry) + entry_length(ver, entry));
> +		debug("          cat: %#04x type: %#04x domain: %#04x\n", entry_category(ver, entry),
> +		      entry_type(ver, entry), entry_domain(ver, entry));
> +
> +

Drop empty line

> +		if (entry_category(ver, entry) != RAM_PARTITION_SDRAM ||
> +		    entry_type(ver, entry) != RAM_PARTITION_SYS_MEMORY)
> +			continue;
> +		if (!entry_length(ver, entry) && !entry_start(ver, entry))
> +			break;
> +
> +		prevbl_ddr_banks[j].start = entry_start(ver, entry);
> +		prevbl_ddr_banks[j].size = entry_length(ver, entry);
> +		*ram_end = max(*ram_end, prevbl_ddr_banks[j].start + prevbl_ddr_banks[j].size);
> +		j++;
> +	}
> +
> +	if (j == CONFIG_NR_DRAM_BANKS)
> +		pr_err("SMEM: More than CONFIG_NR_DRAM_BANKS (%u) entries!", CONFIG_NR_DRAM_BANKS);
> +
> +	return j;
> +}

Undef the entry_* macros after ?

> +
> +static void qcom_parse_memory_dt(const fdt64_t *fdt, int *banks, phys_addr_t *ram_end)
> +{
> +	int offset;
> +	const fdt64_t *memory;

move this one first

> +	int memsize;
> +	int i, j;
> +
> +	*ram_end = 0;
> +
> +	offset = fdt_path_offset(fdt, "/memory");
> +	if (offset < 0)
> +		return;
> +
> +	memory = fdt_getprop(fdt, offset, "reg", &memsize);
> +	if (!memory)
> +		return;
> +
> +	*banks = min(memsize / (2 * sizeof(u64)), (ulong)CONFIG_NR_DRAM_BANKS);
> +
> +	if (memsize / sizeof(u64) > CONFIG_NR_DRAM_BANKS * 2)
> +		log_err("Provided more than the max of %d memory banks\n", CONFIG_NR_DRAM_BANKS);
> +
> +	if (*banks > CONFIG_NR_DRAM_BANKS)
> +		log_err("Provided more memory banks than we can handle\n");
> +
> +	for (i = 0, j = 0; i < *banks * 2; i += 2, j++) {
> +		prevbl_ddr_banks[j].start = get_unaligned_be64(&memory[i]);
> +		prevbl_ddr_banks[j].size = get_unaligned_be64(&memory[i + 1]);
> +		if (!prevbl_ddr_banks[j].size) {
> +			j--;
> +			continue;
> +		}
> +		*ram_end = max(*ram_end, prevbl_ddr_banks[j].start + prevbl_ddr_banks[j].size);
> +	}
> +}
> +
>   /**
>    * The generic memory parsing code in U-Boot lacks a few things that we
>    * need on Qualcomm:
>    *
> @@ -76,48 +200,36 @@ int dram_init_banksize(void)
>    * We can't use fdtdec_setup_memory_banksize() since it stores the result in
>    * gd->bd, which is not yet allocated.
>    *
>    * @fdt: FDT blob to parse /memory node from
> + * @fdt_is_internal: is the FDT one embedded into U-Boot or was it provided by a prior
> + *		     bootloader stage? This determined if we should try to rely on SMEM
> + *		     (internal FDT) or error. We currently assume that if we are passed
> + *		     an external FDT then it already has the memory map populated.
>    *
>    * Return: 0 on success or -ENODATA if /memory node is missing or incomplete
>    */
> -int qcom_parse_memory(const void *fdt)
> +int qcom_parse_memory(const void *fdt, bool fdt_is_internal)
>   {
> -	int offset;
> -	const fdt64_t *memory;
> -	int memsize;
>   	phys_addr_t ram_end = 0;
> -	int i, j, banks;
> +	int banks;
>   
> -	offset = fdt_path_offset(fdt, "/memory");
> -	if (offset < 0)
> -		return -ENODATA;
> +	qcom_memmap_source = fdt_is_internal ? QCOM_MEMMAP_SOURCE_INTERNAL_FDT
> +					     : QCOM_MEMMAP_SOURCE_EXTERNAL_FDT;
>   
> -	memory = fdt_getprop(fdt, offset, "reg", &memsize);
> -	if (!memory)
> -		return -ENODATA;
> +	qcom_parse_memory_dt(fdt, &banks, &ram_end);
>   
> -	banks = min(memsize / (2 * sizeof(u64)), (ulong)CONFIG_NR_DRAM_BANKS);
> -
> -	if (memsize / sizeof(u64) > CONFIG_NR_DRAM_BANKS * 2)
> -		log_err("Provided more than the max of %d memory banks\n", CONFIG_NR_DRAM_BANKS);
> -
> -	if (banks > CONFIG_NR_DRAM_BANKS)
> -		log_err("Provided more memory banks than we can handle\n");
> -
> -	for (i = 0, j = 0; i < banks * 2; i += 2, j++) {
> -		prevbl_ddr_banks[j].start = get_unaligned_be64(&memory[i]);
> -		prevbl_ddr_banks[j].size = get_unaligned_be64(&memory[i + 1]);
> -		if (!prevbl_ddr_banks[j].size) {
> -			j--;
> -			continue;
> -		}
> -		ram_end = max(ram_end, prevbl_ddr_banks[j].start + prevbl_ddr_banks[j].size);
> +	/*
> +	 * If using an internal FDT but the memory node is empty
> +	 * then fall back to SMEM.
> +	 */
> +	if (!prevbl_ddr_banks[0].size && fdt_is_internal) {
> +		banks = qcom_parse_memory_smem(&ram_end);
> +		if (banks < 0)
> +			panic("Couldn't find a valid memory map!\n");
> +		qcom_memmap_source = QCOM_MEMMAP_SOURCE_SMEM;
>   	}
>   
> -	if (!banks || !prevbl_ddr_banks[0].size)
> -		return -ENODATA;
> -
>   	/* Sort our RAM banks -_- */
>   	qsort(prevbl_ddr_banks, banks, sizeof(prevbl_ddr_banks[0]), ddr_bank_cmp);
>   
>   	gd->ram_base = prevbl_ddr_banks[0].start;
> diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
> index ce409314a98b..39dc8fcc76ad 100644
> --- a/arch/arm/mach-snapdragon/qcom-priv.h
> +++ b/arch/arm/mach-snapdragon/qcom-priv.h
> @@ -2,8 +2,10 @@
>   
>   #ifndef __QCOM_PRIV_H__
>   #define __QCOM_PRIV_H__
>   
> +#include <stdbool.h>
> +
>   /**
>    * enum qcom_boot_source - Track where we got loaded from.
>    * Used for capsule update logic.
>    *
> @@ -16,13 +18,26 @@ enum qcom_boot_source {
>   };
>   
>   extern enum qcom_boot_source qcom_boot_source;
>   
> +/*
> + * enum qcom_memmap_source - Track where we got the memory map from.
> + * used for debugging and validation.
> + */
> +enum qcom_memmap_source {
> +	QCOM_MEMMAP_SOURCE_INTERNAL_FDT = 1,
> +	QCOM_MEMMAP_SOURCE_EXTERNAL_FDT,
> +	QCOM_MEMMAP_SOURCE_SMEM,
> +};
> +
> +/* Set by qcom_parse_memory() */
> +extern enum qcom_memmap_source qcom_memmap_source;
> +
>   #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
>   void qcom_configure_capsule_updates(void);
>   #else
>   void qcom_configure_capsule_updates(void) {}
>   #endif /* EFI_HAVE_CAPSULE_SUPPORT */
>   
> -int qcom_parse_memory(const void *fdt);
> +int qcom_parse_memory(const void *fdt, bool fdt_is_internal);
>   
>   #endif /* __QCOM_PRIV_H__ */
> diff --git a/arch/arm/mach-snapdragon/rampart.h b/arch/arm/mach-snapdragon/rampart.h
> new file mode 100644
> index 000000000000..57f3dbb7eec0
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/rampart.h
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RAM partition table definitions
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + */
> +
> +#ifndef __QCOM_SMEM_RAMPART_H__
> +#define __QCOM_SMEM_RAMPART_H__
> +
> +#include <linux/types.h>
> +
> +#define SMEM_USABLE_RAM_PARTITION_TABLE		402
> +
> +#define RAM_PARTITION_H_MAJOR  03
> +#define RAM_PARTITION_H_MINOR  00
> +
> +/**
> + * Total length of zero filled name string. This is not a C
> + * string, as it can occupy the total number of bytes, and if
> + * it does, it does not require a zero terminator. It cannot
> + * be manipulated with standard string handling library functions.
> + */
> +#define RAM_PART_NAME_LENGTH 16
> +
> +/**
> + * Number of RAM partition entries which are usable by APPS.
> + */
> +#define RAM_NUM_PART_ENTRIES 32
> +
> +/**
> + * @name: Magic numbers
> + * Used in identifying valid RAM partition table.
> + */
> +#define RAM_PART_MAGIC1     0x9da5e0a8
> +#define RAM_PART_MAGIC2     0xaf9ec4e2
> +
> +/**
> + * RAM partition attributes.
> + */
> +enum ram_partition_attribute_t {
> +	RAM_PARTITION_READ_ONLY = 0,       /* Read-only RAM partition */
> +	RAM_PARTITION_READWRITE,           /* Read/write RAM partition */
> +};
> +
> +/**
> + * RAM partition categories.
> + */
> +enum ram_partition_category_t {
> +	RAM_PARTITION_IRAM = 4,                   /* IRAM RAM partition */
> +	RAM_PARTITION_IMEM = 5,                   /* IMEM RAM partition */
> +	RAM_PARTITION_SDRAM = 14,                  /* SDRAM type without specific bus information**/
> +};
> +
> +/**
> + * RAM Partition domains.
> + * @note: For shared RAM partition, domain value would be 0b11:\n
> + * RAM_PARTITION_APPS_DOMAIN | RAM_PARTITION_MODEM_DOMAIN.
> + */
> +enum ram_partition_domain_t {
> +	RAM_PARTITION_DEFAULT_DOMAIN = 0,  /* 0b00: No specific domain definition */
> +	RAM_PARTITION_APPS_DOMAIN = 1,     /* 0b01: APPS RAM partition */
> +	RAM_PARTITION_MODEM_DOMAIN = 2,    /* 0b10: MODEM RAM partition */
> +};
> +
> +/**
> + * RAM Partition types.
> + * @note: The RAM_PARTITION_SYS_MEMORY type represents DDR rams that are attached
> + * to the current system.
> + */
> +enum ram_partition_type_t {
> +	RAM_PARTITION_SYS_MEMORY = 1,        /* system memory */
> +	RAM_PARTITION_BOOT_REGION_MEMORY1,   /* boot loader memory 1 */
> +	RAM_PARTITION_BOOT_REGION_MEMORY2,   /* boot loader memory 2, reserved */
> +	RAM_PARTITION_APPSBL_MEMORY,         /* apps boot loader memory */
> +	RAM_PARTITION_APPS_MEMORY,           /* apps usage memory */
> +	RAM_PARTITION_TOOLS_FV_MEMORY,       /* tools usage memory */
> +	RAM_PARTITION_QUANTUM_FV_MEMORY,     /* quantum usage memory */
> +	RAM_PARTITION_QUEST_FV_MEMORY,       /* quest usage memory */
> +};
> +
> +/* Common table header between versions */
> +struct usable_ram_partition_table_header {
> +	u32 magic1;          /* Magic number to identify valid RAM partition table */
> +	u32 magic2;          /* Magic number to identify valid RAM partition table */
> +	u32 version;         /* Version number to track structure definition changes */
> +	u32 reserved1;       /* Reserved for future use */
> +
> +	u32 num_partitions;  /* Number of RAM partition table entries */
> +};
> +
> +/* Holds information for an entry in the RAM partition table */
> +struct ram_partition_entry_v3 {
> +	char name[RAM_PART_NAME_LENGTH];  /* Partition name, unused for now */
> +	u64 start_address;                /* Partition start address in RAM */
> +	u64 length;                       /* Partition length in RAM in Bytes */
> +	u32 partition_attribute;          /* Partition attribute */
> +	u32 partition_category;           /* Partition category */
> +	u32 partition_domain;             /* Partition domain */
> +	u32 partition_type;               /* Partition type */
> +	u32 num_partitions;               /* Number of partitions on device */
> +	u32 hw_info;                      /* hw information such as type and frequency */
> +	u8 highest_bank_bit;              /* Highest bit corresponding to a bank */
> +	u8 reserve0;                      /* Reserved for future use */
> +	u8 reserve1;                      /* Reserved for future use */
> +	u8 reserve2;                      /* Reserved for future use */
> +	u32 min_pasr_size;                /* Minimum PASR size in MB */
> +	u64 available_length;             /* Available Partition length in RAM in Bytes */
> +};
> +
> +/*
> + * Defines the RAM partition table structure
> + *
> + * Do not change the placement of the first four elements so that future
> + * compatibility will always be guaranteed at least for the identifiers.
> + *
> + * The other portion of the structure may be changed as necessary to accommodate
> + * new features. Be sure to increment version number if you change it.
> + */
> +struct usable_ram_partition_table_v3 {
> +	struct usable_ram_partition_table_header header;
> +
> +	u32 reserved2;       /* Added for 8 bytes alignment of header */
> +
> +	/* RAM partition table entries */
> +	struct ram_partition_entry_v3 entries[RAM_NUM_PART_ENTRIES];
> +};
> +
> +/* Version 1 structure 32 Bit - Holds information for an entry in the RAM partition table */
> +struct ram_partition_entry_v1 {
> +	char name[RAM_PART_NAME_LENGTH];  /* Partition name, unused for now */
> +	u64 start_address;                /* Partition start address in RAM */
> +	u64 length;                       /* Partition length in RAM in Bytes */
> +	u32 partition_attribute;          /* Partition attribute */
> +	u32 partition_category;           /* Partition category */
> +	u32 partition_domain;             /* Partition domain */
> +	u32 partition_type;               /* Partition type */
> +	u32 num_partitions;               /* Number of partitions on device */
> +	u32 hw_info;                      /* hw information such as type and frequency */
> +	u32 reserved4;                    /* Reserved for future use */
> +	u32 reserved5;                    /* Reserved for future use */
> +};
> +
> +/*
> + * Defines the RAM partition table structure (Version 1)
> + *
> + * Do not change the placement of the first four elements so that future
> + * compatibility will always be guaranteed at least for the identifiers.
> + *
> + * The other portion of the structure may be changed as necessary to accommodate
> + * new features. Be sure to increment version number if you change it.
> + */
> +struct usable_ram_partition_table_v1 {
> +	struct usable_ram_partition_table_header header;
> +
> +	u32 reserved2;       /* Added for 8 bytes alignment of header */
> +
> +	/* RAM partition table entries */
> +	struct ram_partition_entry_v1 entries[RAM_NUM_PART_ENTRIES];
> +};
> +
> +/* Version 0 structure 32 Bit - Holds information for an entry in the RAM partition table */
> +struct ram_partition_entry_v0 {
> +	char name[RAM_PART_NAME_LENGTH];  /* Partition name, unused for now */
> +	u32 start_address;                /* Partition start address in RAM */
> +	u32 length;                       /* Partition length in RAM in Bytes */
> +	u32 partition_attribute;          /* Partition attribute */
> +	u32 partition_category;           /* Partition category */
> +	u32 partition_domain;             /* Partition domain */
> +	u32 partition_type;               /* Partition type */
> +	u32 num_partitions;               /* Number of partitions on device */
> +	u32 reserved3;                    /* Reserved for future use */
> +	u32 reserved4;                    /* Reserved for future use */
> +	u32 reserved5;                    /* Reserved for future use */
> +};
> +
> +/*
> + * Defines the RAM partition table structure (Version 0)
> + *
> + * Do not change the placement of the first four elements so that future
> + * compatibility will always be guaranteed at least for the identifiers.
> + *
> + * The other portion of the structure may be changed as necessary to accommodate
> + * new features. Be sure to increment version number if you change it.
> + */
> +struct usable_ram_partition_table_v0 {
> +	struct usable_ram_partition_table_header header;
> +
> +	/* RAM partition table entries */
> +	struct ram_partition_entry_v0 entries[RAM_NUM_PART_ENTRIES];
> +};
> +
> +#endif // __QCOM_SMEM_RAMPART_H__
> 

Thanks,
Neil
