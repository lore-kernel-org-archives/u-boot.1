Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F357F36C49
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 07:50:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AD3B839D5;
	Mon, 20 Apr 2026 09:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NNoF7cTx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 147C98426E; Mon, 20 Apr 2026 09:50:42 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD6C383693
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 09:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43fde5b81a1so1938478f8f.0
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 00:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776671438; x=1777276238; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=QYhtai5h1bxCDwjBGSdAwDeBGUYQ0+3ppZKjOcPc3pU=;
 b=NNoF7cTxUoFtSJM7V7XjmNg5EoEKt2QCMFPw0Z5ByD3VicpK8yW5djXpDT0xxzT8wZ
 Vm1CcMM/Y68yJbKazFamSCzw41aCPzjNhjJd7YTxE4eoPuGFKHMBXW9bDp+4Kxgu721b
 9qAavy56lznVmB7nf9qvbgjQURpK4stckmYvfAmErLsoC98gJUcNQQ/mVB3yj+MYms9A
 32y5AvaEvWKjmMidZQ4dK07PHmtxaWN/ha/yTQzK0Jns/hPAlZPHhX2zQngXrxaFnN7o
 IdB3d84u1vsmgaoJv136Ha1OYF5J3yLC6kpUCShx6NcTR/rfS0JyERIyT2SIzCmADdTc
 ixqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776671438; x=1777276238;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QYhtai5h1bxCDwjBGSdAwDeBGUYQ0+3ppZKjOcPc3pU=;
 b=rfiBExCZzsObiapZ/gBXaxOFv4/Y4BLhCvKZGiT3P/d19acBi+4dGOO88H1ZroMJS8
 5nk8nQxlVLtr2H62sHCEuQFdgeHozt6vTqq2Lyz9Xyxj32rx/whoTQpmNKJS2U+AoxHl
 I21327lGkBvIY+TdeT6HJp0ZtCf3KD4RfYGmOqmGhd6REqUg4bfnx5HghjV43FHGT9/n
 SQa80ySVZPY1iGaCl48NBVWOjXVcBC0ig1LKpipv5Xvp6dbi7Q09iiZ8FUs8BAjSkozQ
 3wg79npscFcA9/0gUZNhEU4IcfxfFXPtSK51uhhC7jRnmd/6OTo/Vbanx5Sqckq75SB0
 aY5A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/BwKpwRJWgqYwUcjPDWiADu9Jg9Ag2kjLKn7+Nvgds2bYfAV7hRLAYyzZ9Rl8mJuIXFiB2gv4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5e8sBzcltXo/1GJMpgaZaWHOqMLIqwepZzP6M0o4lNZDkg9Oa
 76ImqKEqxNWS4wry2deVsJ0clAvWPM0YNLegRZ8+p9Zf1Fum1wJJlMu4r5myAQvjLhE=
X-Gm-Gg: AeBDieusBKS2/D3Rj/ZBN1TQY2IoAUUWS0qtJkyLp0qhVwkKyzMYx8DCaG4fTCJGOlO
 /0nFeLgSPOApdDrEtIQu+HQNZ9uJ0NP/v5dDC4P9Xqf2Fpu3Z6wrNVGaHsC9zQWC4oCVZLOk348
 elZZomtx7+OiqHEc2X0vxWG1vEDVkak4bpnN+wQNKY9GbwYD8TaU/EB4/N+BfJlkygK5sbyq8pm
 fmjWWUsNm59d08TtcvCgZv1XPutjM8G+LIjcBl4BYxQd+Fqxl/wohnnCegVngQT84PLMSz+u5p2
 NkEr9kCc7YA8mggX6k4MmitYE6knRb4I53t0k27H5or5RklRLvJ74HjU45rZ5EY0jAETc5wefRr
 YIcPz7GDa6ln+/5vBHDbGBIV1q46CN1Q+nrrCQmzwzIiVhPqJMLehptqmT3jtqo6Js/CqFmrXXu
 /gx3PL2q1gGqcRxfS0rfFX44JHCQipr+FYeIpl5d/rFDvO6Tkr8GyoqSVT/hMfCpK5pRAOMUxtA
 DXdwYicjrWjxFqzrg==
X-Received: by 2002:a5d:5f47:0:b0:439:b55d:b0e5 with SMTP id
 ffacd0b85a97d-43fe3dfbfdfmr19289227f8f.28.1776671437919; 
 Mon, 20 Apr 2026 00:50:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:8290:9fd8:8af0:67dc?
 ([2a01:e0a:106d:1080:8290:9fd8:8af0:67dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d525sm26101654f8f.31.2026.04.20.00.50.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 00:50:37 -0700 (PDT)
Message-ID: <7ee17361-2edc-42ab-a56d-20167f3bd02b@linaro.org>
Date: Mon, 20 Apr 2026 09:50:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] mach-snapdragon: Add KVM hypervisor support
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 casey.connolly@linaro.org, sumit.garg@kernel.org, sughosh.ganu@arm.com,
 gchan9527@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260419173829.1074404-1-aswin.murugan@oss.qualcomm.com>
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
In-Reply-To: <20260419173829.1074404-1-aswin.murugan@oss.qualcomm.com>
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

Hi,

On 4/19/26 19:38, Aswin Murugan wrote:
> Enable Linux KVM virtualization on Snapdragon SoCs.
> 
> Introduce CONFIG_QCOM_KVM_SUPPORT to select KVM or Gunyah
> hypervisor modes at build time.

Please stop using KVW when disabling Gunyah, KVM is a possible hypervisor when running EL2,
but is completely optional. I know internally you refer to KVM when not using Gunyah,
but this make 0 sense at all to user this term when writing patches on the mailing-list.

Just rewrite like this: add support for disabling Gunyah or add support for booting into EL2

> 
> qcom-priv.h:
>   - Add TrustZone SMC interface definitions and parameter IDs
>   - Define hypervisor boot types (GUNYAH=0, KVM=1)
>   - Add TCR_EL2 bit field definitions for memory config
> 
> board.c:
>   - Add qcom_configure_kvm_hypervisor() with EL-aware logic
>   - EL2: Perform direct SMC call for hypervisor setup
>   - EL1: Save context, disable caches, run SMC, restore state,
>     reconfigure TCR_EL2, re-enable caches
>   - Add qcom_configure_gunyah_hypervisor() for standard flow
>   - Add SCM service availability checks

No need to to a summary of the patch, if it changes to much stuff (which seems to be the case here)
just split it into multiple small changes, and explain WHY instead of WHAT in the commit message.

> 
> Default mode remains Gunyah. Enable CONFIG_QCOM_KVM_SUPPORT to
> select KVM for Linux.

Neil

> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>   arch/arm/mach-snapdragon/Kconfig     |   7 ++
>   arch/arm/mach-snapdragon/board.c     | 154 +++++++++++++++++++++++++++
>   arch/arm/mach-snapdragon/qcom-priv.h |  31 ++++++
>   3 files changed, 192 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index d3de8693b5a..2e5676945ca 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -42,4 +42,11 @@ config SYS_CONFIG_NAME
>   	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
>   	  will be used for board configuration.
>   
> +config QCOM_KVM_SUPPORT
> +	bool "Enable KVM support for Qualcomm platforms"
> +	depends on ARM64
> +	help
> +	  This configures the hypervisor interface during boot to support
> +	  KVM virtualization instead of the default Gunyah hypervisor.
> +
>   endif
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 5fb3240acc5..2926dd8ccc0 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -510,6 +510,154 @@ void __weak qcom_late_init(void)
>   {
>   }
>   
> +/**
> + * qcom_configure_kvm_hypervisor() - Configure hypervisor for KVM guest mode
> + *
> + * Configures the hypervisor for KVM operation:
> + * - EL2 path: Direct SMC call
> + * - EL1 path: Save context, disable caches, SMC call, restore context
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int qcom_configure_kvm_hypervisor(void)
> +{
> +	struct arm_smccc_res res;
> +	u64 current_el;
> +
> +	asm volatile("mrs %0, CurrentEL" : "=r" (current_el));
> +	current_el = (current_el >> 2) & 0x3;
> +
> +	log_info("Configuring hypervisor for KVM (EL%llu)\n", current_el);
> +
> +	arm_smccc_smc(TZ_INFO_IS_SVC_AVAILABLE_ID,
> +		      TZ_INFO_IS_SVC_AVAILABLE_ID_PARAM_ID,
> +		      TZ_CONFIGURE_MILESTONE_SERVICE_ID,
> +		      0, 0, 0, 0, 0, &res);
> +
> +	if (res.a0 != 0)
> +		log_debug("KVM milestone service not available (0x%lx)\n", res.a0);
> +
> +	if (current_el == 2) {
> +		log_debug("At EL2\n");
> +
> +		arm_smccc_smc(TZ_CONFIGURE_MILESTONE_SERVICE_ID,
> +			      TZ_CONFIGURE_MILESTONE_SERVICE_PARAM_ID,
> +			      0, 0, QCOM_HYP_BOOT_TYPE_KVM,
> +			      0, 0, 0, &res);
> +
> +		if (res.a0 != 0) {
> +			log_err("Hypervisor configuration failed: 0x%lx\n", res.a0);
> +			return -EIO;
> +		}
> +
> +		log_info("KVM hypervisor configured\n");
> +		return 0;
> +	}
> +
> +	log_debug("At EL1, saving register context\n");
> +
> +	u64 ttbr0_el1, tcr_el1, tcr_el2, mair_el1;
> +	u64 t0sz, phys_addr_size;
> +
> +	/* Save EL1 system register context */
> +	asm volatile("mrs %0, ttbr0_el1" : "=r" (ttbr0_el1));
> +	asm volatile("mrs %0, tcr_el1" : "=r" (tcr_el1));
> +	asm volatile("mrs %0, mair_el1" : "=r" (mair_el1));
> +
> +	t0sz = tcr_el1 & TCR_T0SZ_MASK;
> +	phys_addr_size = tcr_el1 & TCR_PS_MASK;
> +
> +	log_debug("Saved context: TTBR0=0x%llx TCR=0x%llx MAIR=0x%llx\n",
> +		  ttbr0_el1, tcr_el1, mair_el1);
> +
> +	icache_disable();
> +	dcache_disable();
> +
> +	arm_smccc_smc(TZ_CONFIGURE_MILESTONE_SERVICE_ID,
> +		      TZ_CONFIGURE_MILESTONE_SERVICE_PARAM_ID,
> +		      0, 0, QCOM_HYP_BOOT_TYPE_KVM,
> +		      0, 0, 0, &res);
> +
> +	if (res.a0 != 0) {
> +		log_err("Hypervisor configuration failed: 0x%lx\n", res.a0);
> +		icache_enable();
> +		dcache_enable();
> +		return -EIO;
> +	}
> +
> +	asm volatile("mrs %0, CurrentEL" : "=r" (current_el));
> +	current_el = (current_el >> 2) & 0x3;
> +
> +	asm volatile("msr ttbr0_el1, %0" : : "r" (ttbr0_el1));
> +	asm volatile("isb");
> +
> +	if (current_el != 2) {
> +		log_debug("No EL2 transition, skipping TCR_EL2 config\n");
> +		icache_enable();
> +		dcache_enable();
> +		log_warning("KVM hypervisor configuration failed\n");
> +		return 0;
> +	}
> +
> +	/* Read current TCR_EL2 and reconfigure it */
> +	asm volatile("mrs %0, tcr_el2" : "=r" (tcr_el2));
> +
> +	tcr_el2 &= ~(TCR_T0SZ_MASK | (0x7UL << 16));
> +	tcr_el2 |= t0sz | (phys_addr_size >> TCR_PS_SHIFT);
> +
> +	tcr_el2 &= ~TCR_SH_ORGN_IRGN_MASK;
> +	tcr_el2 |= TCR_SH_INNER_SHAREABLE |
> +		   TCR_ORGN_WRITE_BACK_ALLOC |
> +		   TCR_IRGN_WRITE_BACK_ALLOC;
> +
> +	asm volatile("msr tcr_el2, %0" : : "r" (tcr_el2));
> +	asm volatile("msr mair_el1, %0" : : "r" (mair_el1));
> +	asm volatile("isb");
> +
> +	icache_enable();
> +	dcache_enable();
> +
> +	log_info("KVM hypervisor configured\n");
> +	return 0;
> +}
> +
> +/**
> + * qcom_configure_gunyah_hypervisor() - Configure hypervisor for Gunyah mode
> + *
> + * Configures the hypervisor for standard Gunyah operation.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int qcom_configure_gunyah_hypervisor(void)
> +{
> +	struct arm_smccc_res res;
> +
> +	log_info("Configuring hypervisor for Gunyah mode\n");
> +
> +	arm_smccc_smc(TZ_INFO_IS_SVC_AVAILABLE_ID,
> +		      TZ_INFO_IS_SVC_AVAILABLE_ID_PARAM_ID,
> +		      TZ_CONFIGURE_MILESTONE_SERVICE_ID,
> +		      0, 0, 0, 0, 0, &res);
> +
> +	if (res.a0 != 0) {
> +		log_debug("Hypervisor milestone service not available (0x%lx)\n", res.a0);
> +		return 0;
> +	}
> +
> +	arm_smccc_smc(TZ_CONFIGURE_MILESTONE_SERVICE_ID,
> +		      TZ_CONFIGURE_MILESTONE_SERVICE_PARAM_ID,
> +		      0, 0, QCOM_HYP_BOOT_TYPE_GUNYAH,
> +		      0, 0, 0, &res);
> +
> +	if (res.a0 != 0) {
> +		log_err("Hypervisor configuration failed: 0x%lx\n", res.a0);
> +		return -EIO;
> +	}
> +
> +	log_info("Gunyah hypervisor configured\n");
> +	return 0;
> +}
> +
>   #define KERNEL_COMP_SIZE	SZ_64M
> arch/arm/mach-snapdragon/Kconfig #ifdef CONFIG_FASTBOOT_BUF_SIZE
>   #define FASTBOOT_BUF_SIZE CONFIG_FASTBOOT_BUF_SIZE
> @@ -570,6 +718,12 @@ int board_late_init(void)
>   	qcom_late_init();
>   
>   	qcom_show_boot_source();
> +
> +	if (IS_ENABLED(CONFIG_QCOM_KVM_SUPPORT))
> +		qcom_configure_kvm_hypervisor();
> +	else
> +		qcom_configure_gunyah_hypervisor();
> +
>   	/* Configure the dfu_string for capsule updates */
>   	qcom_configure_capsule_updates();
>   
> diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
> index b8bf574e8bb..a5d9dec6aa7 100644
> --- a/arch/arm/mach-snapdragon/qcom-priv.h
> +++ b/arch/arm/mach-snapdragon/qcom-priv.h
> @@ -17,6 +17,37 @@ enum qcom_boot_source {
>   
>   extern enum qcom_boot_source qcom_boot_source;
>   
> +/* TrustZone SMC definitions */
> +#define TZ_SYSCALL_CREATE_SMC_ID(o, s, f) \
> +	((u32)((((o) & 0x3f) << 24) | (((s) & 0xff) << 8) | ((f) & 0xff)))
> +
> +#define TZ_OWNER_SIP				2
> +#define TZ_SVC_BOOT				1
> +#define TZ_SVC_INFO				6
> +#define TZ_BOOT_CMD_KVM_MILESTONE		0x21
> +#define TZ_INFO_IS_SVC_AVAILABLE_CMD		0x01
> +
> +#define TZ_CONFIGURE_MILESTONE_SERVICE_ID \
> +	TZ_SYSCALL_CREATE_SMC_ID(TZ_OWNER_SIP, TZ_SVC_BOOT, TZ_BOOT_CMD_KVM_MILESTONE)
> +#define TZ_CONFIGURE_MILESTONE_SERVICE_PARAM_ID		0x23
> +
> +#define TZ_INFO_IS_SVC_AVAILABLE_ID \
> +	TZ_SYSCALL_CREATE_SMC_ID(TZ_OWNER_SIP, TZ_SVC_INFO, TZ_INFO_IS_SVC_AVAILABLE_CMD)
> +#define TZ_INFO_IS_SVC_AVAILABLE_ID_PARAM_ID		0x1
> +
> +/* Hypervisor boot types */
> +#define QCOM_HYP_BOOT_TYPE_GUNYAH		0
> +#define QCOM_HYP_BOOT_TYPE_KVM			1
> +
> +/* TCR_EL2 bit field definitions */
> +#define TCR_T0SZ_MASK				0x1FUL
> +#define TCR_PS_MASK				(0x7UL << 32)
> +#define TCR_PS_SHIFT				16
> +#define TCR_SH_ORGN_IRGN_MASK			0x3F00UL
> +#define TCR_SH_INNER_SHAREABLE			(3UL << 12)
> +#define TCR_ORGN_WRITE_BACK_ALLOC		BIT(10)
> +#define TCR_IRGN_WRITE_BACK_ALLOC		BIT(8)
> +
>   #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
>   void qcom_configure_capsule_updates(void);
>   #else

