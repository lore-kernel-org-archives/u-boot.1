Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C24CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 14:40:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0E0784119;
	Mon, 18 May 2026 16:40:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mcziB1Ii";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 259AA8469D; Mon, 18 May 2026 16:40:34 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E961683EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 16:40:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so24438155e9.2
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 07:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779115231; x=1779720031; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=iTRF/ikWe3o30B/RqXUqldpdudOHAdXxalR3rtDfdzM=;
 b=mcziB1IiJ8kvBAXskGrgdQ5wKBpXfFSyoaPeQ8TLRpq8MTqexpqWhkb17vTiYh6vOP
 BaJEg/WET8Oh0xRndgY1Jpo5VCoDbovdeyjjTMva2KcKW5t/33/PbaAzNELRqaqtDkQ3
 htY3xs4QrEEmHuxNzKKU3gAA9ABTAtsHggyrFLX/33brjwVBww3D9uQXjYKDJDAnWvbV
 fFjKZE7xBb8D2A9gAJ/oIhy0ZZmx2T+pWpL5TIJyZLHf3ymFLUG8JsQqlOytBT1jB3nx
 NtfWP/wy7Xua51dgqu1nY7WAXzcNa5RlzvTmtJ0HrTgjvzEiLfsDCQ4GfLggga0QxqE/
 jGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779115231; x=1779720031;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iTRF/ikWe3o30B/RqXUqldpdudOHAdXxalR3rtDfdzM=;
 b=QVHpAnURf32P4RT+k+MoyEO0LE3OnHqDVWM9+Iec2MByWHWc2Qn2sJlXMWrER3kmDc
 12sPBiscb5TcsHp3rsqbO6xQt+K3C8t7svpQb3Xw+i99wk23z7Rlb4rRVm7IeZANnXI3
 jUH1YNSN8LUoNobtDfspfQBjXbeIBsZvff+MU8aL8eCstX0gZ2euQPeYt0ZHlGEb09Go
 hy18YO1jPIJMM7y/nq4zIM1fyXpvQNplFdDO71Q+W9NKhCNsiem/0gsTQhoLwwiOPxyx
 DQq31QcW9GMrI6BmJB7M+G3Ga7k8IliWwkHgesdn6ZlvEP0YoVdXmLNq7cpPugKx4gQ1
 l/7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8iIo7Bfv6FBgvicp/FOxEo3ECraJb9CvuWqARK2dIhFcyvMVYWrD4LXS+kvd2XcATRY+lC12k=@lists.denx.de
X-Gm-Message-State: AOJu0YwHT8Ob4FUXzn9JzstHFAeSCJaDJE+rupz7PfCjlIUI0J8KY0Bn
 yD8QNByqEbVWEoPwe6+XUwiPzKHK/Ixs0az8Qf9LmzUSmd+a1Y+sGyl7cvSPcPxTRDo=
X-Gm-Gg: Acq92OHXygwKiOpdiDeAaETJBRuXnwOnmlWF+ZADS3WxILISQ8c7k10MoXjIo7CFkBC
 20d8nR03KE9dGmx6Jf8Aschqj1DM23a7jTRGeMcDEIKOr2PQ/RqKgDgQm31DKngEw9FY7yirm8W
 4kAuM+I3FAWaG3BMit5ovwQtQWKC6se23Dh7Dn3ZYcGH7oB8PW2vT2ERwXWpxqpcwBc7SsT8UvO
 GW6t1GuKufd8FhrKj4cYmDlhMgpp4AfZPBsF4lA/bT6AigvkRGuGAvkXn72L4IciHy/aqjQcJtk
 aa+Y6UBny/CUsjrHDGrhWfXqQWWy8QC0XA4IU0kYocpE86OAvm1GkW8AKHG6dJvrvUm1QUOHg6/
 bB9Q0kXBICcFAIevSvfTlKHiK2sxgZRizDdapyvTFEraDxpB/bWIqhYlhF3EblC+VO+YfEBnqsA
 xuIHnbf6wvs60g/KHh2r+19AqCd/OBfd6b7jA0yCeI6goaM9M2ggCh1LoDGw4UM8/dmPw2LB/hD
 bYkStg4OPTWrJMp5Q==
X-Received: by 2002:a05:600c:3b07:b0:489:1a3a:9e45 with SMTP id
 5b1f17b1804b1-48fe651e127mr232418525e9.26.1779115231081; 
 Mon, 18 May 2026 07:40:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1029:e3c5:362e:1250?
 ([2a01:e0a:106d:1080:1029:e3c5:362e:1250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe7da11sm82476885e9.32.2026.05.18.07.40.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 07:40:30 -0700 (PDT)
Message-ID: <28f18f24-ed15-43ab-bd9b-ca61282521ea@linaro.org>
Date: Mon, 18 May 2026 16:40:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 12/15] mach-snapdragon: move memory parsing to its own
 file
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
 <20260504-b4-modernise-smem-v2-12-c01ec2ff3886@linaro.org>
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
In-Reply-To: <20260504-b4-modernise-smem-v2-12-c01ec2ff3886@linaro.org>
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
> This code is getting a bit complicated, split it out to try and keep
> things a bit better organised as we're going to be supporting populating
> the memory layout from various other sources.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   arch/arm/mach-snapdragon/Makefile    |   2 +-
>   arch/arm/mach-snapdragon/board.c     | 115 -------------------------------
>   arch/arm/mach-snapdragon/dram.c      | 127 +++++++++++++++++++++++++++++++++++
>   arch/arm/mach-snapdragon/qcom-priv.h |   2 +
>   4 files changed, 130 insertions(+), 116 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
> index 343e825c6fdd..e481e4f26e5c 100644
> --- a/arch/arm/mach-snapdragon/Makefile
> +++ b/arch/arm/mach-snapdragon/Makefile
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   #
>   # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>   
> -obj-y += board.o
> +obj-y += board.o dram.o
>   obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
>   obj-$(CONFIG_OF_LIVE) += of_fixup.o
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index e12d3d00caa4..a2d97ad77910 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -42,123 +42,8 @@ enum qcom_boot_source qcom_boot_source __section(".data") = 0;
>   static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
>   
>   struct mm_region *mem_map = rbx_mem_map;
>   
> -static struct {
> -	phys_addr_t start;
> -	phys_size_t size;
> -} prevbl_ddr_banks[CONFIG_NR_DRAM_BANKS] __section(".data") = { 0 };
> -
> -int dram_init(void)
> -{
> -	/*
> -	 * gd->ram_base / ram_size have been setup already
> -	 * in qcom_parse_memory().
> -	 */
> -	return 0;
> -}
> -
> -static int ddr_bank_cmp(const void *v1, const void *v2)
> -{
> -	const struct {
> -		phys_addr_t start;
> -		phys_size_t size;
> -	} *res1 = v1, *res2 = v2;
> -
> -	if (!res1->size)
> -		return 1;
> -	if (!res2->size)
> -		return -1;
> -
> -	return (res1->start >> 24) - (res2->start >> 24);
> -}
> -
> -/* This has to be done post-relocation since gd->bd isn't preserved */
> -static void qcom_configure_bi_dram(void)
> -{
> -	int i;
> -
> -	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> -		gd->bd->bi_dram[i].start = prevbl_ddr_banks[i].start;
> -		gd->bd->bi_dram[i].size = prevbl_ddr_banks[i].size;
> -	}
> -}
> -
> -int dram_init_banksize(void)
> -{
> -	qcom_configure_bi_dram();
> -
> -	return 0;
> -}
> -
> -/**
> - * The generic memory parsing code in U-Boot lacks a few things that we
> - * need on Qualcomm:
> - *
> - * 1. It sets gd->ram_size and gd->ram_base to represent a single memory block
> - * 2. setup_dest_addr() later relocates U-Boot to ram_base + ram_size, the end
> - *    of that first memory block.
> - *
> - * This results in all memory beyond U-Boot being unusable in Linux when booting
> - * with EFI.
> - *
> - * Since the ranges in the memory node may be out of order, the only way for us
> - * to correctly determine the relocation address for U-Boot is to parse all
> - * memory regions and find the highest valid address.
> - *
> - * We can't use fdtdec_setup_memory_banksize() since it stores the result in
> - * gd->bd, which is not yet allocated.
> - *
> - * @fdt: FDT blob to parse /memory node from
> - *
> - * Return: 0 on success or -ENODATA if /memory node is missing or incomplete
> - */
> -static int qcom_parse_memory(const void *fdt)
> -{
> -	int offset;
> -	const fdt64_t *memory;
> -	int memsize;
> -	phys_addr_t ram_end = 0;
> -	int i, j, banks;
> -
> -	offset = fdt_path_offset(fdt, "/memory");
> -	if (offset < 0)
> -		return -ENODATA;
> -
> -	memory = fdt_getprop(fdt, offset, "reg", &memsize);
> -	if (!memory)
> -		return -ENODATA;
> -
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
> -	}
> -
> -	if (!banks || !prevbl_ddr_banks[0].size)
> -		return -ENODATA;
> -
> -	/* Sort our RAM banks -_- */
> -	qsort(prevbl_ddr_banks, banks, sizeof(prevbl_ddr_banks[0]), ddr_bank_cmp);
> -
> -	gd->ram_base = prevbl_ddr_banks[0].start;
> -	gd->ram_size = ram_end - gd->ram_base;
> -
> -	return 0;
> -}
> -
>   static void show_psci_version(void)
>   {
>   	struct arm_smccc_res res;
>   
> diff --git a/arch/arm/mach-snapdragon/dram.c b/arch/arm/mach-snapdragon/dram.c
> new file mode 100644
> index 000000000000..ad73b685a935
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/dram.c
> @@ -0,0 +1,127 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Memory layout parsing for Qualcomm.
> + */
> +
> +#define LOG_CATEGORY LOGC_BOARD
> +#define pr_fmt(fmt) "QCOM-DRAM: " fmt
> +
> +#include <asm-generic/unaligned.h>
> +#include <dm.h>
> +#include <log.h>
> +#include <sort.h>
> +
> +static struct {
> +	phys_addr_t start;
> +	phys_size_t size;
> +} prevbl_ddr_banks[CONFIG_NR_DRAM_BANKS] __section(".data") = { 0 };
> +
> +int dram_init(void)
> +{
> +	/*
> +	 * gd->ram_base / ram_size have been setup already
> +	 * in qcom_parse_memory().
> +	 */
> +	return 0;
> +}
> +
> +static int ddr_bank_cmp(const void *v1, const void *v2)
> +{
> +	const struct {
> +		phys_addr_t start;
> +		phys_size_t size;
> +	} *res1 = v1, *res2 = v2;
> +
> +	if (!res1->size)
> +		return 1;
> +	if (!res2->size)
> +		return -1;
> +
> +	return (res1->start >> 24) - (res2->start >> 24);
> +}
> +
> +/* This has to be done post-relocation since gd->bd isn't preserved */
> +static void qcom_configure_bi_dram(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> +		gd->bd->bi_dram[i].start = prevbl_ddr_banks[i].start;
> +		gd->bd->bi_dram[i].size = prevbl_ddr_banks[i].size;
> +	}
> +}
> +
> +int dram_init_banksize(void)
> +{
> +	qcom_configure_bi_dram();
> +
> +	return 0;
> +}
> +
> +/**
> + * The generic memory parsing code in U-Boot lacks a few things that we
> + * need on Qualcomm:
> + *
> + * 1. It sets gd->ram_size and gd->ram_base to represent a single memory block
> + * 2. setup_dest_addr() later relocates U-Boot to ram_base + ram_size, the end
> + *    of that first memory block.
> + *
> + * This results in all memory beyond U-Boot being unusable in Linux when booting
> + * with EFI.
> + *
> + * Since the ranges in the memory node may be out of order, the only way for us
> + * to correctly determine the relocation address for U-Boot is to parse all
> + * memory regions and find the highest valid address.
> + *
> + * We can't use fdtdec_setup_memory_banksize() since it stores the result in
> + * gd->bd, which is not yet allocated.
> + *
> + * @fdt: FDT blob to parse /memory node from
> + *
> + * Return: 0 on success or -ENODATA if /memory node is missing or incomplete
> + */
> +int qcom_parse_memory(const void *fdt)
> +{
> +	int offset;
> +	const fdt64_t *memory;
> +	int memsize;
> +	phys_addr_t ram_end = 0;
> +	int i, j, banks;
> +
> +	offset = fdt_path_offset(fdt, "/memory");
> +	if (offset < 0)
> +		return -ENODATA;
> +
> +	memory = fdt_getprop(fdt, offset, "reg", &memsize);
> +	if (!memory)
> +		return -ENODATA;
> +
> +	banks = min(memsize / (2 * sizeof(u64)), (ulong)CONFIG_NR_DRAM_BANKS);
> +
> +	if (memsize / sizeof(u64) > CONFIG_NR_DRAM_BANKS * 2)
> +		log_err("Provided more than the max of %d memory banks\n", CONFIG_NR_DRAM_BANKS);
> +
> +	if (banks > CONFIG_NR_DRAM_BANKS)
> +		log_err("Provided more memory banks than we can handle\n");
> +
> +	for (i = 0, j = 0; i < banks * 2; i += 2, j++) {
> +		prevbl_ddr_banks[j].start = get_unaligned_be64(&memory[i]);
> +		prevbl_ddr_banks[j].size = get_unaligned_be64(&memory[i + 1]);
> +		if (!prevbl_ddr_banks[j].size) {
> +			j--;
> +			continue;
> +		}
> +		ram_end = max(ram_end, prevbl_ddr_banks[j].start + prevbl_ddr_banks[j].size);
> +	}
> +
> +	if (!banks || !prevbl_ddr_banks[0].size)
> +		return -ENODATA;
> +
> +	/* Sort our RAM banks -_- */
> +	qsort(prevbl_ddr_banks, banks, sizeof(prevbl_ddr_banks[0]), ddr_bank_cmp);
> +
> +	gd->ram_base = prevbl_ddr_banks[0].start;
> +	gd->ram_size = ram_end - gd->ram_base;
> +
> +	return 0;
> +}
> diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
> index b8bf574e8bbb..ce409314a98b 100644
> --- a/arch/arm/mach-snapdragon/qcom-priv.h
> +++ b/arch/arm/mach-snapdragon/qcom-priv.h
> @@ -22,5 +22,7 @@ void qcom_configure_capsule_updates(void);
>   #else
>   void qcom_configure_capsule_updates(void) {}
>   #endif /* EFI_HAVE_CAPSULE_SUPPORT */
>   
> +int qcom_parse_memory(const void *fdt);
> +
>   #endif /* __QCOM_PRIV_H__ */
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
