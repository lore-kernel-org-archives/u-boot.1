Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE30C48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 15:21:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4764787C9E;
	Tue,  6 Feb 2024 16:21:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UzjN0wRQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A114B87C8D; Tue,  6 Feb 2024 16:02:09 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A12F787BB5
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 16:02:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=resch.max@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40ff0bb8592so3131485e9.2
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 07:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707231727; x=1707836527; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=7j8/dxU61Skb131Uls87rSGKz6uAu1+2UkMfv6GX7yg=;
 b=UzjN0wRQ1MSUpX33x93pkPNntgbB+YJoFAp2lfl//JH1VOUmJYHGKdBgoLX8co7fTu
 f+3hKTrbutX2nwh9uT4HGGYX+pytrbdE6ie9+B6gmxxfynOMrwofZxg6vaUojXuQ64UL
 kAZgbBzdsqdMcnnz6KZR1KdQUF6bKMm1gM5gIRjU0m9YbeuqDWZcJZIdYrKWkpouXAjn
 1mVTfjsIAO9U2kKi1hCjGUmD/4YSvltPmPnPin5BpNfwJEzRUZ7gcwwCMgppWI9WDRk1
 q2EX0tBHDqw+FU7r4t4WqMcWxtECFukBj7CbbuTIutdwyyBV94SPUYlDWKcO/p3ZvVvs
 Eftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707231727; x=1707836527;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7j8/dxU61Skb131Uls87rSGKz6uAu1+2UkMfv6GX7yg=;
 b=hNzP9DsZFOPfgKHA0my52+P4sZsS21ybmbBQSMWUVrVUI4Jkrj89wFof53nQ3imMhc
 e3HLeU5NKiTBTrJydL2NOlo6zMSi5nbVpOO0b+i3I9k5IuQLVaDEbEuUg2FGSfd4Lz1l
 2sCVkdK0uLIkqwNMAdvXM18GEzmEwrUniaBxRwnWzJuTwqlJ2ZeZX9R3w9DGwqgy13dh
 g/E1wWsIE/EUwXIuPtK6epMSui329TDhsizMzT0cg1KVrVIX2h1KCrqZfPstKNzIads4
 QC305SD466kvCSPNsg9RIz5Uho2P56E3L7CThyZoVuS1aUQJfCvceZhs9xWXYUiOENEf
 k2qw==
X-Gm-Message-State: AOJu0Yw4Jcg558yEXfv7QIZrnp+yac+VLwKNoQB2lKlgVx74/ZIqjEDE
 EFTANnZ9AXXjqO0varjRNOLb/tMzrnt2tkSKpj4Q+dkQ8p04nFhk
X-Google-Smtp-Source: AGHT+IHCSYoTjJ0LwEGaxY8VehcL/kryEZUsHpFhS14pYPE5pyvYA8/xdMHh6PYYwDdylLoRStASDw==
X-Received: by 2002:adf:ee4a:0:b0:33b:3c9b:683e with SMTP id
 w10-20020adfee4a000000b0033b3c9b683emr1524928wro.64.1707231726320; 
 Tue, 06 Feb 2024 07:02:06 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXlj39dR6qkMJQBSY5XIrmHVA12ejh/qMb5QSHGnDouJgq6ZiL8zBjCro+3A053XpY+/jnP2QBWtJms
Received: from ?IPV6:2001:871:223:e70f:e9c:a60d:14e1:3a09?
 ([2001:871:223:e70f:e9c:a60d:14e1:3a09])
 by smtp.googlemail.com with ESMTPSA id
 f1-20020a0560001b0100b0033aedaea1b2sm2317618wrz.30.2024.02.06.07.02.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 07:02:05 -0800 (PST)
Message-ID: <d8016f44-9670-472b-b15d-d35e198d1f10@gmail.com>
Date: Tue, 6 Feb 2024 16:02:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rng: Add Turris Mox rWTM RNG driver
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de, sr@denx.de
References: <20240121201737.671340-1-resch.max@gmail.com>
 <20240205124014.6f7b1957@dellmb>
Content-Language: de-AT, en-US-large
From: Max Resch <resch.max@gmail.com>
Autocrypt: addr=resch.max@gmail.com; keydata=
 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
In-Reply-To: <20240205124014.6f7b1957@dellmb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 06 Feb 2024 16:21:15 +0100
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

Hi there Marek,

Am 05/02/2024 um 12.40 schrieb Marek Behún:
> Hello Max,
> 
> Out of curiousity, what is your use case for having these random
> numbers on this platform in U-Boot?

I use 2 EspressoBin (Armada 3720) as routers, both of them use the 
TurrisMox firmware. RNG enables the EFI RNG protocol which inturn allows 
systemd-boot to populate the Linux RNG EFI seed config table which 
enables ealy initialization of the kernel prng.
The kernel also then allows the use of KASLR. When the kernel is booted 
up a module is available to interface with the Firmware to use the RNG 
directly.

Also, I'm not sure if this should be part of the patch, this could be 
enabled on some default configurations for the Armada 3700.

-- Max

> Below are a few more things to change and then you I'll give my
> Reviewed-by tag.
> 
> On Sun, 21 Jan 2024 21:17:16 +0100
> Max Resch <resch.max@gmail.com> wrote:
> 
>> A RNG driver for Armada 3720 boards running the Turris Mox rWTM firmware
>> from CZ.NIC in the secure processor.
>>
>> Signed-off-by: Max Resch <resch.max@gmail.com>
>> ---
>>
>> Changes in v2:
>>   - Removed ring buffer implementation
>>
>>   drivers/rng/Kconfig           |   8 +++
>>   drivers/rng/Makefile          |   1 +
>>   drivers/rng/turris_rwtm_rng.c | 122 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 131 insertions(+)
>>   create mode 100644 drivers/rng/turris_rwtm_rng.c
>>
>> diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
>> index a89c899568..cd72852a47 100644
>> --- a/drivers/rng/Kconfig
>> +++ b/drivers/rng/Kconfig
>> @@ -105,4 +105,12 @@ config RNG_JH7110
>>   	help
>>   	  Enable True Random Number Generator in StarFive JH7110 SoCs.
>>   
>> +config RNG_TURRIS_RWTM
>> +	bool "Turris Mox TRNG in Secure Processor"
>> +	depends on DM_RNG && ARMADA_3700
>> +	help
>> +	  Use TRNG in Turris Mox Secure Processor Firmware. Can be used
>> +	  on other Armada-3700 devices (like EspressoBin) if Secure
>> +	  Firmware from CZ.NIC is used.
>> +
>>   endif
>> diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
>> index 7e64c4cdfc..ecae1a3da3 100644
>> --- a/drivers/rng/Makefile
>> +++ b/drivers/rng/Makefile
>> @@ -17,3 +17,4 @@ obj-$(CONFIG_RNG_SMCCC_TRNG) += smccc_trng.o
>>   obj-$(CONFIG_RNG_ARM_RNDR) += arm_rndr.o
>>   obj-$(CONFIG_TPM_RNG) += tpm_rng.o
>>   obj-$(CONFIG_RNG_JH7110) += jh7110_rng.o
>> +obj-$(CONFIG_RNG_TURRIS_RWTM) += turris_rwtm_rng.o
>> diff --git a/drivers/rng/turris_rwtm_rng.c b/drivers/rng/turris_rwtm_rng.c
>> new file mode 100644
>> index 0000000000..143fe0b47f
>> --- /dev/null
>> +++ b/drivers/rng/turris_rwtm_rng.c
>> @@ -0,0 +1,122 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
>> +/*
>> + * Copyright (c) 2024, Max Resch
>> + */
>> +
>> +#include <dm.h>
>> +#include <malloc.h>
>> +#include <rng.h>
>> +#include <asm/dma-mapping.h>
>> +#include <asm/types.h>
>> +#include <mach/mbox.h>
>> +
>> +/* size of entropy buffer */
>> +#define RNG_BUFFER_SIZE	128U
>> +
>> +struct turris_rwtm_rng_priv {
>> +	phys_addr_t buffer;
>> +};
>> +
>> +static int turris_rwtm_rng_fill_entropy(phys_addr_t entropy, size_t size)
>> +{
>> +	u32 args[3] = { 1, (u32)entropy, size };
>> +	int ret;
>> +
>> +	/* flush data cache */
>> +	flush_dcache_range(entropy, entropy + size);
>> +
>> +	/*
>> +	 * get entropy
>> +	 * args[0] = 1 copies BYTES array in args[1] of length args[2]
>> +	 */
>> +	ret = mbox_do_cmd(MBOX_CMD_GET_RANDOM, args, 3, NULL, 0);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* invalidate data cache */
>> +	invalidate_dcache_range(entropy, entropy + size);
>> +
>> +	return 0;
>> +}
>> +
>> +static int turris_rwtm_rng_random_read(struct udevice *dev, void *data, size_t count)
>> +{
>> +	phys_addr_t p;
>> +	size_t size;
>> +	int ret;
>> +
>> +	p = ((struct turris_rwtm_rng_priv *)dev_get_priv(dev))->buffer;
> 
> Please declare
> 
>    struct turris_rwtm_rng_priv *priv = dev_get_priv(dev);
>    phys_addr_t phys;
>    size_t size;
>    int ret;
> 
> and then do
> 
>    phys = priv->buffer;
> 
>> +	while (count) {
>> +		size = min_t(size_t, RNG_BUFFER_SIZE, count);
>> +
>> +		ret = turris_rwtm_rng_fill_entropy(p, size);
>> +
>> +		memcpy(data, (void *)p, size);
>> +		count -= size;
>> +		data = (u8 *)data + size;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int turris_rwtm_rng_probe(struct udevice *dev)
>> +{
>> +	struct turris_rwtm_rng_priv *priv;
> 
>    = dev_get_priv(dev);
> 
>> +	u32 args[] = { 0 };
>> +	int ret;
>> +
>> +	/*
>> +	 * check if the random command is supported
>> +	 * args[0] = 0 would copy 16 DWORDS entropy to out but we ignore them
>> +	 */
>> +	ret = mbox_do_cmd(MBOX_CMD_GET_RANDOM, args, ARRAY_SIZE(args), NULL, 0);
>> +
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* entropy buffer */
>> +	priv = (struct turris_rwtm_rng_priv *)dev_get_priv(dev);
> no need here, do it at the beginning
> 
> 
>> +	priv->buffer = 0;
>> +
>> +	/* buffer address need to be aligned */
>> +	dma_alloc_coherent(RNG_BUFFER_SIZE, (unsigned long *)&priv->buffer);
>> +	if (!priv->buffer)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
>> +
>> +static int turris_rwtm_rng_remove(struct udevice *dev)
>> +{
>> +	phys_addr_t p;
> rename this to phys, and please do it as I described above.
> 
>> +
>> +	p = ((struct turris_rwtm_rng_priv *)dev_get_priv(dev))->buffer;
>> +	dma_free_coherent((void *)p);
>> +
>> +	return 0;
> 
> Marek
