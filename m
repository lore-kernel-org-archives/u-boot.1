Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B30CD4F49
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 14:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E17E83EF9;
	Mon, 18 May 2026 16:34:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QRH5UL1z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 023A983FEE; Mon, 18 May 2026 16:34:29 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57B62803C6
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 16:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-45562c41ec7so1382780f8f.1
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 07:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779114865; x=1779719665; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=6zx9VhzLr0LQ8H0Gp4nDJV4lH9vlXbiudpMM7UsMe9c=;
 b=QRH5UL1znEU4Bc4VqSWbQfQc2E4jnFTQCFH98boV2zd9P9Wjv2pw8bNB4YRpgc5D03
 r93SPbY1s5u9W8+u8KryJ0bMosjMbUVbWq03sgiWolkzSsHl0niQBQdgOkRcqURUL2uW
 kiM8iQzAd+7cP0xEMHpXbvWrliwEJkExXoMiCPBaDWsk1EyR/NgTZbzoo4Qhxd6ZmKq8
 FajKGz3quE5g5u0yovHoT6bjiBi8WO3WpWHdwTDDijm9OTA60avZ73Cyt5IW9fimZsBy
 dN+leKSKiSqpJwcIhANE01rkHHkHa1RjPuDwiIKlMDwMTl1prRw/Dvkia9X2sPDu/NZY
 7YLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779114865; x=1779719665;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6zx9VhzLr0LQ8H0Gp4nDJV4lH9vlXbiudpMM7UsMe9c=;
 b=LVztfA5DUxuOYnqbIRRSa3lo18GwRTIGXTAcJa+aTRpLiHf+r8eQzroBBVWImOtd8J
 abEnvmGvQiTLJe+oM7RYJHNvSlLvl2+3no1or9EvdfigOAFp3q4xpFssCRXfQI3jQNtI
 Qq1b/Mxo+vjfWxQfCsQiQ6+7IfQweWBI7sco0H9bbftZTZ5gA7k1ilrPdsKdSRf8loGc
 ToTiRPkhbA0hnni0q/i9HZaUtql5JzwpJ/nVAlGisyumqBCTlv4ppKVrKmaG+BrFiOXQ
 LelstMXq3zmAwCuUckBfhuyEagjZMhgpPiFLFawZWCa/4RI+Dx3vZWZjEznoCUGd0uPg
 wuiA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ppJGXlyA6ak4W1Yno0vtTEUpKGoifIUt7iiNgvmDjtkkqYwAQDRcA9NR7g/2JaggFuzGJpeo=@lists.denx.de
X-Gm-Message-State: AOJu0YyXL9VvjAap6OlG5A4Vg2A6VEYmFCIDinD6J0aLUy58zRv7dcA2
 zEYD/WsLVL8+DMgpFsZPvAxXuzc89roCYdWDX5x3jhDqxvSUGeEtabw1ujCbkwn7cPg=
X-Gm-Gg: Acq92OERX8hJoPB49kH6/uq/sI8j61ESQ2QJSG33cWUhaY4fkkfhh7yICfbxWwa07Xw
 IoAvXkD36IbdlgiJ23ifLGvNLAhbK60rvYcUahePIhiLxqbcea67PhWOmhViCv4drQ4AdlGnfEk
 YXXlNVyBtAqTytmjRp01IiPRfvkoZ8clk/q5xmciXUCVwy44hmobGX18vo/3SqbDGe129lt2CY9
 HqnrErQ5PZVJw3cT2jDD6QT7M7DVQrqmH3n6rbSrstnkjqzuRy2Bm31TKUYCK+GChRqyrflS4JH
 Lld4Y9yff75cKhFxIlmh9MEWsi+//6rma767a9ILf+Wf3hi8u51qD/4fTnUkH0mPR17t2ftHYst
 jpKRKDiHLlFzO6My/5kmaLDGowYhptzZ5h9AiON7eSb+MyS8dXvz3/fPeis/dvh8qblzrz15Tu2
 3GH2+lyyeI0zOvUWObMLEPF+evioBXdEJV1Xb9aPDFN9PAhfPvSc2cRyFkAnTQTdm7ouw78tNX5
 PMaVF8=
X-Received: by 2002:a05:6000:200f:b0:45d:b14b:23f8 with SMTP id
 ffacd0b85a97d-45e5c5af4eamr24139330f8f.18.1779114864403; 
 Mon, 18 May 2026 07:34:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1029:e3c5:362e:1250?
 ([2a01:e0a:106d:1080:1029:e3c5:362e:1250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3b18fsm35055720f8f.11.2026.05.18.07.34.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 07:34:23 -0700 (PDT)
Message-ID: <fefec34d-4e26-4ecc-a923-a4b2193431b9@linaro.org>
Date: Mon, 18 May 2026 16:34:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 01/15] Revert "dm: SMEM (Shared memory) uclass"
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
 <20260504-b4-modernise-smem-v2-1-c01ec2ff3886@linaro.org>
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
In-Reply-To: <20260504-b4-modernise-smem-v2-1-c01ec2ff3886@linaro.org>
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
> SMEM is a highly Qualcomm specific interface, while having a dedicated
> UCLASS for it offers a nice abstraction, for things like memory layout
> parsing we need to use it before the driver model is available.
> 
> Therefore, it doesn't make sense to fit SMEM into the driver model.
> Instead let's adopt a model closer to Linux, and parse SMEM really early
> during boot (as soon as we have the FDT).
> 
> This reverts commit 7b384eccc785b596f68448b155cbda26df57fb23.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   arch/arm/Kconfig           |  1 -
>   drivers/Kconfig            |  2 --
>   drivers/Makefile           |  1 -
>   drivers/smem/Kconfig       | 25 -------------
>   drivers/smem/Makefile      |  7 ----
>   drivers/smem/smem-uclass.c | 46 ------------------------
>   include/dm/uclass-id.h     |  1 -
>   include/smem.h             | 90 ----------------------------------------------
>   8 files changed, 173 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index f624675eadf8..dadb18e0b8cd 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1141,9 +1141,8 @@ config ARCH_SNAPDRAGON
>   	select POWER_DOMAIN
>   	select GPIO_EXTRA_HEADER
>   	select MSM_SMEM
>   	select OF_CONTROL
> -	select SMEM
>   	select SPMI
>   	select BOARD_LATE_INIT
>   	select OF_BOARD
>   	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 47606ddc6c8b..aa293df37c57 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -123,10 +123,8 @@ source "drivers/scsi/Kconfig"
>   source "drivers/serial/Kconfig"
>   
>   source "drivers/sm/Kconfig"
>   
> -source "drivers/smem/Kconfig"
> -
>   source "drivers/sound/Kconfig"
>   
>   source "drivers/soc/Kconfig"
>   
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 43d0ba332818..ca3e87ffb102 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -118,9 +118,8 @@ obj-y += pwm/
>   obj-y += reset/
>   obj-y += input/
>   obj-y += iommu/
>   # SOC specific infrastructure drivers.
> -obj-y += smem/
>   obj-y += thermal/
>   obj-$(CONFIG_TEE) += tee/
>   obj-$(CONFIG_ARM_FFA_TRANSPORT) += firmware/arm-ffa/
>   obj-y += axi/
> diff --git a/drivers/smem/Kconfig b/drivers/smem/Kconfig
> deleted file mode 100644
> index e5d7dcc81b17..000000000000
> --- a/drivers/smem/Kconfig
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -menuconfig SMEM
> -	bool  "SMEM (Shared Memory mamanger) support"
> -
> -if SMEM
> -
> -config SANDBOX_SMEM
> -    bool "Sandbox Shared Memory Manager (SMEM)"
> -    depends on SANDBOX && DM
> -    help
> -      enable SMEM support for sandbox. This is an emulation of a real SMEM
> -      manager.
> -      The sandbox driver allocates a shared memory from the heap and
> -      initialzies it on start.
> -
> -config MSM_SMEM
> -    bool "Qualcomm Shared Memory Manager (SMEM)"
> -    depends on DM
> -    depends on ARCH_SNAPDRAGON || ARCH_IPQ40XX
> -    select DEVRES
> -    help
> -      Enable support for the Qualcomm Shared Memory Manager.
> -      The driver provides an interface to items in a heap shared among all
> -      processors in a Qualcomm platform.
> -
> -endif # menu "SMEM Support"
> diff --git a/drivers/smem/Makefile b/drivers/smem/Makefile
> deleted file mode 100644
> index af3e9b50883c..000000000000
> --- a/drivers/smem/Makefile
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0+
> -#
> -# Makefile for the U-Boot SMEM interface drivers
> -
> -obj-$(CONFIG_SANDBOX_SMEM) += sandbox_smem.o
> -obj-$(CONFIG_SMEM) += smem-uclass.o
> -obj-$(CONFIG_MSM_SMEM) += msm_smem.o
> diff --git a/drivers/smem/smem-uclass.c b/drivers/smem/smem-uclass.c
> deleted file mode 100644
> index 4dea5cc4bf1c..000000000000
> --- a/drivers/smem/smem-uclass.c
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Copyright (c) 2018 Ramon Fried <ramon.fried@gmail.com>
> - */
> -
> -#define LOG_CATEGORY UCLASS_SMEM
> -
> -#include <dm.h>
> -#include <smem.h>
> -
> -int smem_alloc(struct udevice *dev, unsigned int host,
> -		unsigned int item, size_t size)
> -{
> -	struct smem_ops *ops = smem_get_ops(dev);
> -
> -	if (!ops->alloc)
> -		return -ENOSYS;
> -
> -	return ops->alloc(host, item, size);
> -}
> -
> -void *smem_get(struct udevice *dev, unsigned int host,
> -		unsigned int item, size_t *size)
> -{
> -	struct smem_ops *ops = smem_get_ops(dev);
> -
> -	if (!ops->get)
> -		return NULL;
> -
> -	return ops->get(host, item, size);
> -}
> -
> -int smem_get_free_space(struct udevice *dev, unsigned int host)
> -{
> -	struct smem_ops *ops = smem_get_ops(dev);
> -
> -	if (!ops->get_free_space)
> -		return -ENOSYS;
> -
> -	return ops->get_free_space(host);
> -}
> -
> -UCLASS_DRIVER(smem) = {
> -	.id     = UCLASS_SMEM,
> -	.name       = "smem",
> -};
> diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
> index 36b5d87c304f..fe0aae2720ca 100644
> --- a/include/dm/uclass-id.h
> +++ b/include/dm/uclass-id.h
> @@ -133,9 +133,8 @@ enum uclass_id {
>   	UCLASS_SCMI_BASE,	/* Interface for SCMI Base protocol */
>   	UCLASS_SCSI,		/* SCSI device */
>   	UCLASS_SERIAL,		/* Serial UART */
>   	UCLASS_SIMPLE_BUS,	/* Bus with child devices */
> -	UCLASS_SMEM,		/* Shared memory interface */
>   	UCLASS_SOC,		/* SOC Device */
>   	UCLASS_SOUND,		/* Playing simple sounds */
>   	UCLASS_SPI,		/* SPI bus */
>   	UCLASS_SPI_FLASH,	/* SPI flash */
> diff --git a/include/smem.h b/include/smem.h
> deleted file mode 100644
> index b19c534ebc43..000000000000
> --- a/include/smem.h
> +++ /dev/null
> @@ -1,90 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * The shared memory system is an allocate-only heap structure that
> - * consists of one of more memory areas that can be accessed by the processors
> - * in the SoC.
> - *
> - * Allocation can be done globally for all processors or to an individual processor.
> - * This is controlled by the @host parameter.
> - *
> - * Allocation and management of heap can be implemented in various ways,
> - * The @item parameter should be used as an index/hash to the memory region.
> - *
> - * Copyright (c) 2018 Ramon Fried <ramon.fried@gmail.com>
> - */
> -
> -#ifndef _smemh_
> -#define _smemh_
> -
> -/* struct smem_ops: Operations for the SMEM uclass */
> -struct smem_ops {
> -	/**
> -	 * alloc() - allocate space for a smem item
> -	 *
> -	 * @host:	remote processor id, or -1 for all processors.
> -	 * @item:	smem item handle
> -	 * @size:	number of bytes to be allocated
> -	 * @return 0 if OK, -ve on error
> -	 */
> -	int (*alloc)(unsigned int host,
> -		unsigned int item, size_t size);
> -
> -	/**
> -	 * get() - Resolve ptr of size of a smem item
> -	 *
> -	 * @host:	the remote processor, of -1 for all processors.
> -	 * @item:	smem item handle
> -	 * @size:	pointer to be filled out with the size of the item
> -	 * @return	pointer on success, NULL on error
> -	 */
> -	void *(*get)(unsigned int host,
> -		unsigned int item, size_t *size);
> -
> -	/**
> -	 * get_free_space() - Get free space in smem in bytes
> -	 *
> -	 * @host:   the remote processor identifying a partition, or -1
> -	 *			for all processors.
> -	 * @return	free space, -ve on error
> -	 */
> -	int (*get_free_space)(unsigned int host);
> -};
> -
> -#define smem_get_ops(dev)	((struct smem_ops *)(dev)->driver->ops)
> -
> -/**
> - * smem_alloc() - allocate space for a smem item
> - * @host:	remote processor id, or -1
> - * @item:	smem item handle
> - * @size:	number of bytes to be allocated
> - * Return: 0 if OK, -ve on error
> - *
> - * Allocate space for a given smem item of size @size, given that the item is
> - * not yet allocated.
> - */
> -int smem_alloc(struct udevice *dev, unsigned int host, unsigned int item, size_t size);
> -
> -/**
> - * smem_get() - resolve ptr of size of a smem item
> - * @host:	the remote processor, or -1 for all processors.
> - * @item:	smem item handle
> - * @size:	pointer to be filled out with size of the item
> - * Return:	pointer on success, NULL on error
> - *
> - * Looks up smem item and returns pointer to it. Size of smem
> - * item is returned in @size.
> - */
> -void *smem_get(struct udevice *dev, unsigned int host, unsigned int item, size_t *size);
> -
> -/**
> - * smem_get_free_space() - retrieve amount of free space in a partition
> - * @host:	the remote processor identifying a partition, or -1
> - *			for all processors.
> - * Return:	size in bytes, -ve on error
> - *
> - * To be used by smem clients as a quick way to determine if any new
> - * allocations has been made.
> - */
> -int smem_get_free_space(struct udevice *dev, unsigned int host);
> -
> -#endif /* _smem_h_ */
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
