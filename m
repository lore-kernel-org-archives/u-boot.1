Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55498606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 21:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y0I7x+pW;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=cpdPjumd
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2AE188116C;
	Thu, 26 Nov 2026 21:50:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kss9uAIlTWpU; Thu, 26 Nov 2026 21:50:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A409F81178
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795729837;
	b=oHziA39Oa2m+X2eLhxap1Ay0hIdlfksmZn1PncPwn2d8DAR1xNSF8pyWlTowTFnjZ2s7
	 xQ3zQ101Ajd6VM0ZCDAqpphhzOkt4wTYy5FmKZ7DsUlwhrvoVwUyC5YN9OsJfP3ZpflEr
	 gByiz0iE0/sQKZq/3i7eLazvVAAiUtJWcbioVZVTk6SXYGe9/NvChXstFq8YhcD3rdO8K
	 E8bwtWodLer9U7KQhY39jz7JRd35cvbij0NK9VTk6628CUR4svJKb56jqAGxZe6l9GQX1
	 X764RdxsVsZO19/cDDevVvdGrFLO27ts1IgRIxV90G4FY9oIWY6xEJprmCSU3aXUotg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795729837;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XcJX572uqucKhji1wsnvqOUdXoqHUQXtxlsDQNrd5bE=;
	b=PFvtUXQPI4jO8B5YuPx40yBb6KxcuVoHQ5BrL55stMw5TJkfcteia4UHvwrRRtOc4Jjh
	 gLB/EZW6yy14iAyCGyXktaLBycB0+ozoDtqvgM959KDosF5t89mQte6nRRdAXij7ol5Bj
	 PxD44fk0Uxziy6THyIBqTm36ovphpziBl/cBF7UdlgmxzzNwpFgyKj3++vq+7IROEiWij
	 J6LXkTAM4NVdq6AiK47gIk/frTreQOY72UxtKweWbC3nqvOvltOOSkiDbZIzRCSwCglh7
	 hPGeym2UCu8x8nhgPRCoRYEHjGxeeUoXoKeRBE4CJWh+mWerSEhIafjQO91SFNHdhdw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795729837;
	bh=XcJX572uqucKhji1wsnvqOUdXoqHUQXtxlsDQNrd5bE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y0I7x+pW53yoyKbhbaX4Ujug00ZaQrv67lTgBGNvV7Y8mctJnNSlrH6Z4+YHcoLvM
	 oduLlGbQ69eHTsSozL1HEXEYwqsQoBk9UMMY0HhSPtwVkI+nzSC/VtQuvLDk2TLVWl
	 LM6lM2K0vIOcDhmlC2MGSUlF4xELCgINAK4u3pxydRKrQNv1aLet+X9PXfs5gkGbw4
	 Un9a5kNWK64p/exTU9mAtGDQtzP279tcgCX4uyaRv7EPA3rwlBQoCBv2KmYbLngZLF
	 yyWL0Rg/EwG1V3reRQVMxjGEpU2EmKRUSM1fj4ORThoonNaRVUqhQOA5QdgUl3bIeJ
	 cuh4QZCBKLWkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A409F81178;
	Thu, 26 Nov 2026 21:50:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C9361AB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 21:50:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F28F7408D4
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 21:50:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4eKM03abFZGI for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 21:50:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6C53240863
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=cpdPjumd
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6C53240863
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 21:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1795729796;
 bh=XcJX572uqucKhji1wsnvqOUdXoqHUQXtxlsDQNrd5bE=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=cpdPjumdduTAwPEqkSwIGjR7Gy9yPI7fIRhU/OM0mfC5LScrPk2zB8zXL0K/uhD5F
 RDixEN1vs9G+dOIqOUuFjxiGAMN66IwD7LKXeU/svaGG6nPMQbkanQFW5qnIMCVhaJ
 oNsJddd3k7mFUB3l/t2u9mj/rOZCuCZ79PysA/SQm+ecnFYuDgzIhNtff7T9Nd6UFo
 JF4Qj/Sl5x7D7ButsSfLiZFUyh35JGHTL8PGKlIFMrpsT9zDLUHAd7OaZh/a1sijYg
 X9zU8fZxaws3MnMy7y9KmYD9u58r6/Ut/nnD3W1AdpRLe9oOi0m79J0bc9MI8ZMLbd
 RZC0UwNcukWyg==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 9BBFDB2203D9;
 Thu, 26 Nov 2026 22:49:54 +0100 (CET)
Message-ID: <66fd5d05-aa24-4031-8d7a-52b547b5be80@freeshell.de>
Date: Thu, 26 Nov 2026 13:49:52 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] riscv: spacemit: k3: Add SPL initialization support
From: E Shattow <e@freeshell.de>
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 u-boot-spacemit@groups.io, Tom Rini <trini@konsulko.com>,
 Yixun Lan <dlan@kernel.org>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>
References: <20261106-k3-ddr-v1-0-1e60e1d78020@pigmoral.tech>
 <20261106-k3-ddr-v1-2-1e60e1d78020@pigmoral.tech>
 <zfl63cgj44hzx23ozxkd43uwvv74wfiuhu6bf6o6su6skzns6u@fp2udqudxmhy>
 <589eed22-6a01-40be-afd1-536662e8c30d@freeshell.de>
Content-Language: en-US
In-Reply-To: <589eed22-6a01-40be-afd1-536662e8c30d@freeshell.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Postscript and correction,

On 11/26/26 13:20, E Shattow wrote:
> On 11/26/26 13:13, Anirudh Srinivasan wrote:
>> On Fri, Nov 06, 2026 at 12:40:40AM +0800, Junhui Liu wrote:
>>> Add SPL initialization support for SpacemiT K3. Enable instruction and
>>> data caches and cache snooping during early hart initialization, and
>>> provide the timer configuration needed for M-mode execution.
>>>
>>> Initialize I2C and read the DDR part number from the board's TLV EEPROM.
>>> Populate the RAM driver's platform data before probing it to initialize
>>> DRAM. Set up the DRAM PMA boundary and record the RAM base and size in
>>> global data.
>>>
>>> Loading the next boot stage is not yet supported.
>>>
>>> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
>>> ---
>>>  arch/riscv/cpu/k3/Kconfig            |   6 +-
>>>  arch/riscv/cpu/k3/Makefile           |   1 +
>>>  arch/riscv/cpu/k3/spl.c              |  52 ++++++++++++++
>>>  arch/riscv/include/asm/arch-k3/csr.h |  20 ++++++
>>>  arch/riscv/include/asm/arch-k3/spl.h |  11 +++
>>>  board/spacemit/k3/Makefile           |   5 ++
>>>  board/spacemit/k3/spl.c              | 127 +++++++++++++++++++++++++++++++++++
>>>  include/configs/spacemit-k3.h        |   3 +
>>>  8 files changed, 224 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/cpu/k3/Kconfig b/arch/riscv/cpu/k3/Kconfig
>>> index 5474ac11243..dee79644b87 100644
>>> --- a/arch/riscv/cpu/k3/Kconfig
>>> +++ b/arch/riscv/cpu/k3/Kconfig
>>> @@ -9,10 +9,14 @@ config SPACEMIT_K3
>>>  	select BINMAN
>>>  	select ARCH_EARLY_INIT_R
>>>  	select SYS_CACHE_SHIFT_6
>>> +	select SUPPORT_SPL
>>>  	imply CPU
>>>  	imply CPU_RISCV
>>> -	imply RISCV_TIMER if RISCV_SMODE
>>> +	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
>>> +	imply RISCV_ACLINT if RISCV_MMODE
>>> +	imply SPL_RISCV_ACLINT if SPL_RISCV_MMODE
>>>  	imply CMD_CPU
>>> +	imply SPL_CPU
>>>  	imply OF_UPSTREAM
>>>  
>>>  endif
>>> diff --git a/arch/riscv/cpu/k3/Makefile b/arch/riscv/cpu/k3/Makefile
>>> index fba4e4b0a3f..6afe6caac69 100644
>>> --- a/arch/riscv/cpu/k3/Makefile
>>> +++ b/arch/riscv/cpu/k3/Makefile
>>> @@ -3,3 +3,4 @@
>>>  # Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
>>>  
>>>  obj-y += dram.o
>>> +obj-$(CONFIG_XPL_BUILD) += spl.o
>>> diff --git a/arch/riscv/cpu/k3/spl.c b/arch/riscv/cpu/k3/spl.c
>>> new file mode 100644
>>> index 00000000000..e8ee32e37fd
>>> --- /dev/null
>>> +++ b/arch/riscv/cpu/k3/spl.c
>>> @@ -0,0 +1,52 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
>>> + */
>>> +
>>> +#include <asm/arch/csr.h>
>>> +#include <asm/arch/spl.h>
>>> +#include <asm/csr.h>
>>> +#include <asm/global_data.h>
>>> +#include <dm.h>
>>> +#include <ram.h>
>>> +
>>> +#define K3_DRAM_UPPER_LIMIT_ADDR	0x1100000000ULL
>>> +
>>> +DECLARE_GLOBAL_DATA_PTR;
>>> +
>>> +static void setup_dram_pma(void)
>>> +{
>>> +	csr_write(CSR_X100_PMAADDR8, K3_DRAM_UPPER_LIMIT_ADDR >> 2);
>>> +	asm volatile("sfence.vma zero, zero" ::: "memory");
>>> +}
>>> +
>>> +int spl_dram_init(void)
>>> +{
>>> +	struct ram_info info;
>>> +	struct udevice *dev;
>>> +	int ret;
>>> +
>>> +	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
>>> +	if (ret) {
>>> +		printf("DRAM init failed: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	setup_dram_pma();
>>> +
>>> +	ret = ram_get_info(dev, &info);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	gd->ram_base = info.base;
>>> +	gd->ram_size = info.size;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +void harts_early_init(void)
>>> +{
>>> +	csr_set(CSR_X100_CACHE_CTL, CSR_X100_CACHE_CTL_ICACHE_EN |
>>> +				    CSR_X100_CACHE_CTL_DCACHE_EN);
>>> +	csr_set(CSR_X100_SNOOP_CTL, CSR_X100_SNOOP_CTL_EN);
>>> +}
>>> diff --git a/arch/riscv/include/asm/arch-k3/csr.h b/arch/riscv/include/asm/arch-k3/csr.h
>>> new file mode 100644
>>> index 00000000000..a6c3e6af9f5
>>> --- /dev/null
>>> +++ b/arch/riscv/include/asm/arch-k3/csr.h
>>> @@ -0,0 +1,20 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>> +/*
>>> + * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
>>> + */
>>> +
>>> +#ifndef _ASM_ARCH_K3_CSR_H_
>>> +#define _ASM_ARCH_K3_CSR_H_
>>> +
>>> +#include <linux/bitops.h>
>>> +
>>> +#define CSR_X100_CACHE_CTL		0x7c0
>>> +#define  CSR_X100_CACHE_CTL_ICACHE_EN	BIT(1)
>>> +#define  CSR_X100_CACHE_CTL_DCACHE_EN	BIT(0)
>>> +
>>> +#define CSR_X100_SNOOP_CTL		0x7f0
>>> +#define  CSR_X100_SNOOP_CTL_EN		BIT(0)
>>> +
>>> +#define CSR_X100_PMAADDR8		0x7e8
>>> +
>>> +#endif /* _ASM_ARCH_K3_CSR_H_ */
>>> diff --git a/arch/riscv/include/asm/arch-k3/spl.h b/arch/riscv/include/asm/arch-k3/spl.h
>>> new file mode 100644
>>> index 00000000000..7dda93cfda8
>>> --- /dev/null
>>> +++ b/arch/riscv/include/asm/arch-k3/spl.h
>>> @@ -0,0 +1,11 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>> +/*
>>> + * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
>>> + */
>>> +
>>> +#ifndef _ASM_ARCH_K3_SPL_H_
>>> +#define _ASM_ARCH_K3_SPL_H_
>>> +
>>> +int spl_dram_init(void);
>>> +
>>> +#endif /* _ASM_ARCH_K3_SPL_H_ */
>>> diff --git a/board/spacemit/k3/Makefile b/board/spacemit/k3/Makefile
>>> new file mode 100644
>>> index 00000000000..67f30a40e6c
>>> --- /dev/null
>>> +++ b/board/spacemit/k3/Makefile
>>> @@ -0,0 +1,5 @@
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +#
>>> +# Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
>>> +
>>> +obj-$(CONFIG_SPL_BUILD) += spl.o
>>> diff --git a/board/spacemit/k3/spl.c b/board/spacemit/k3/spl.c
>>> new file mode 100644
>>> index 00000000000..4798e5c9ebc
>>> --- /dev/null
>>> +++ b/board/spacemit/k3/spl.c
>>> @@ -0,0 +1,127 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
>>> + */
>>> +
>>> +#include <asm/arch/spl.h>
>>> +#include <asm/global_data.h>
>>> +#include <asm/io.h>
>>> +#include <display_options.h>
>>> +#include <dm/device.h>
>>> +#include <dm/uclass.h>
>>> +#include <errno.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/string.h>
>>> +#include <soc/spacemit/k3-ddr.h>
>>> +#include <spl.h>
>>> +#include <tlv_eeprom.h>
>>> +
>>> +#define MUX_MODE5		5
>>> +#define EDGE_NONE		BIT(6)
>>> +#define PULL_UP			(6 << 13)
>>> +#define I2C_PIN_CONFIG(x)	((x) | EDGE_NONE | PULL_UP)
>>> +
>>> +#define MFP_GPIO_46		0xd401e0b8
>>> +#define MFP_GPIO_47		0xd401e0bc
>>> +
>>> +#define K3_TLV_CODE_DDR_PART_NUMBER	0x45
>>> +
>>> +DECLARE_GLOBAL_DATA_PTR;
>>> +
>>> +static void i2c_early_init(void)
>>> +{
>>> +	struct udevice *bus;
>>> +
>>> +	/* EEPROM uses I2C2 on GPIO46 and GPIO47. */
>>> +	writel(I2C_PIN_CONFIG(MUX_MODE5), (void __iomem *)MFP_GPIO_46);
>>> +	writel(I2C_PIN_CONFIG(MUX_MODE5), (void __iomem *)MFP_GPIO_47);
>>> +
>>> +	udelay(100);
>>> +
>>> +	uclass_first_device(UCLASS_I2C, &bus);
>>> +	while (bus) {
>>> +		uclass_next_device(&bus);
>>> +		if (!bus)
>>> +			break;
>>> +	}
>>> +}
>>> +
>>> +static int read_ddr_part_number(char *part, size_t part_size)
>>> +{
>>> +	struct tlvinfo_header *header;
>>> +	u8 contents[TLV_INFO_MAX_LEN];
>>> +	struct tlvinfo_tlv *entry;
>>> +	u8 *end;
>>> +	int ret;
>>> +
>>> +	ret = read_tlvinfo_tlv_eeprom(contents, &header, &entry, 0);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	end = (u8 *)(header + 1) + be16_to_cpu(header->totallen);
>>> +
>>> +	while ((u8 *)entry + sizeof(*entry) <= end) {
>>> +		if ((u8 *)entry + sizeof(*entry) + entry->length > end)
>>> +			return -EINVAL;
>>> +
>>> +		if (entry->type == TLV_CODE_CRC_32)
>>> +			break;
>>> +
>>> +		if (entry->type == K3_TLV_CODE_DDR_PART_NUMBER) {
>>> +			if (!entry->length || entry->length >= part_size)
>>> +				return -EINVAL;
>>> +
>>> +			memcpy(part, entry->value, entry->length);
>>> +			part[entry->length] = '\0';
>>> +
>>> +			return 0;
>>> +		}
>>> +
>>> +		entry = (void *)(entry->value + entry->length);
>>> +	}
>>> +
>>> +	return -ENOENT;
>>> +}
>>> +
>>> +static int setup_ddr_plat(void)
>>> +{
>>> +	struct k3_ddr_plat *plat;
>>> +	struct udevice *dev;
>>> +
>>> +	dev = uclass_try_first_device(UCLASS_RAM);
>>> +	if (!dev)
>>> +		return -ENODEV;
>>> +
>>> +	if (!device_is_compatible(dev, "spacemit,k3-ddrc"))
>>> +		return -ENODEV;
>>> +
>>> +	plat = dev_get_plat(dev);
>>> +
>>> +	return read_ddr_part_number(plat->part_number, sizeof(plat->part_number));
>>
>> Add some kind of fallback here in case we can't read the value from EEPROM. You could use the smallest supported value (4G)? The vendor U-Boot SPL seems to have a fallback, so this should too.
>>
>> Regards
>> Anirudh Srinivasan
> 
> Currently the smallest DRAM sizes for shipping products I know of are 8G
> for the Pico-ITX and CoM260. I don't know of any product that has 4G as
> the DRAM size;  one complication for 4G DRAM size as a fallback is that
> the default "addr"-named variables go past 5GiB range so that would fail.
> 
> -E

Postscript: I forget this technical detail (thanks Anirudh for reminder
off-list) the K3 SoC has +4GiB addressing offset for actual DRAM
address. Disregard my concern about "addr" environment variables.

-E
