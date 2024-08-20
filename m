Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2603DC3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 12:13:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2423F88A41;
	Tue, 20 Aug 2024 14:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Tmdm2KfE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25AED8657F; Tue, 20 Aug 2024 14:13:02 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 211098657F
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 14:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A044D42493
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 12:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1724155979;
 bh=jRYQ8HTCue4XpAyr6qJWrkYpOx2G7bbbMpGqsy+X8iM=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Tmdm2KfER0isLF440CaYhFfINXIFNIRH4a0uIApsOlx6c0BhA07GGP/gwcse0d6Cu
 p7QilFjFO8Rmnn9xsaMMfPSKX43bFVcvW18/w1JayT7GO2ixxUtV8rmIoBDcTpNru2
 wmk8WRlFIhyP9NV2bUdt1voAiFMRMTolFBgd02tz+0qo47158bfc/K75NOAxTlGsM6
 AUneKb2TtwYWbRyVRPd6dRrsiNGgLJjfWYN0L52v9Bx/aLW+BfB1Y+OGurxfbkK7cc
 WbJhyEd4asEGN36/TXGx7JaCsb5I8a2GaJIO1WxJpV/UbJwqV9266W+Rzh5b5zd4Ay
 l4w8bS8eIIGoQ==
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52efe4c2372so6019364e87.1
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 05:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724155979; x=1724760779;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jRYQ8HTCue4XpAyr6qJWrkYpOx2G7bbbMpGqsy+X8iM=;
 b=KXxTtCb+dd08bxqL0ViWxlXizAZYdE47hSaL8FIYjS4ks8R1BTcQyMAYNMFQAXVjir
 SvZzrl+tEKbKbJ9krdtxyQT5ErWTuXKANALGi3uf/fL9ESbBrdHIuRT6Ddlcx7R7Qf9w
 Eo1E8ROjvy2DLa5n2HfDKItw4HHSoqh7SpLu0CMazZt6ogHKfzwns3bS3L69umjXWkTx
 63Z6QxVlw+rsSRlaK2Y7crymPzBRO707LqOU7aR6ivMx/GnFrW02W/Qw83gd6x6s6SMh
 5a84euIr1+D5MCZbqZOHTMdbzdMq+r5PYO5OahdLLh0yy+a2QPBWDJNE5eyQWJqXMlio
 PkxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQxkunIDK+XlLN+KAnwDFxUq4t6Xo7tLvpoZnnwmUCa2dbT1RAETwwu7jqoQyGJG7vPh7DjSA=@lists.denx.de
X-Gm-Message-State: AOJu0YwaRWrzr4agIid0sadDFMQAx/RtT7QibW2lN1tLzfDm+NN8CaBU
 XOPe9k8ItkuKKkSM6uEvcbCsGzA2IMHRB492bpwXrH4VdHr71gJ/Kkx4nUUKow9SAvgsVFIcTR4
 1t0VXqXayQpWNfI5inDtswfoxGGS3/Li14VlP42kxxwXhKPjdXci6aaLL9ecphZwn0UE=
X-Received: by 2002:a05:6512:250e:b0:533:3fc8:43ee with SMTP id
 2adb3069b0e04-5333fc848bfmr1624329e87.13.1724155978805; 
 Tue, 20 Aug 2024 05:12:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs80+MJ0FV9gMmEzirRtytrnlsYO4Cc59FP0PBTG9EjRfpb2P7sEtZwBA0//HQ7x1dxGLHfg==
X-Received: by 2002:a05:6512:250e:b0:533:3fc8:43ee with SMTP id
 2adb3069b0e04-5333fc848bfmr1624286e87.13.1724155977758; 
 Tue, 20 Aug 2024 05:12:57 -0700 (PDT)
Received: from [192.168.103.101]
 (dynamic-046-114-216-077.46.114.pool.telefonica.de. [46.114.216.77])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838cfd7fsm755665166b.77.2024.08.20.05.12.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 05:12:57 -0700 (PDT)
Message-ID: <d7363b19-5cc6-4590-adfb-0889ea3aaf5f@canonical.com>
Date: Tue, 20 Aug 2024 14:12:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] board: qemu-riscv: Override enable_caches
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, u-boot@lists.denx.de,
 Rick Chen <rick@andestech.com>
References: <20240820093800.5436-1-mchitale@ventanamicro.com>
 <20240820093800.5436-4-mchitale@ventanamicro.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240820093800.5436-4-mchitale@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 20.08.24 11:37, Mayuresh Chitale wrote:
> Define enable_caches function for the qemu-riscv board which probes for
> the cbom-block-size dt property when RISCV_ISA_ZICBOM is enabled. Also
> add flush_dcache_range and invalidate_dcache_range functions which use
> the corresponding CBO ops.
> 
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> ---
>   board/emulation/qemu-riscv/qemu-riscv.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/board/emulation/qemu-riscv/qemu-riscv.c b/board/emulation/qemu-riscv/qemu-riscv.c
> index e5193e31e3..1795d2f831 100644
> --- a/board/emulation/qemu-riscv/qemu-riscv.c
> +++ b/board/emulation/qemu-riscv/qemu-riscv.c
> @@ -14,6 +14,7 @@
>   #include <usb.h>
>   #include <virtio_types.h>
>   #include <virtio.h>
> +#include <asm/cache.h>
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> @@ -70,3 +71,18 @@ void *board_fdt_blob_setup(int *err)
>   	/* Stored the DTB address there during our init */
>   	return (void *)(ulong)gd->arch.firmware_fdt_addr;
>   }
> +
> +void enable_caches(void)
> +{
> +	riscv_zicbom_init();
> +}

Enable caches may be called multiple times. But riscv_zicbom_init() only 
needs to be called once.

> +
> +void flush_dcache_range(unsigned long start, unsigned long end)
> +{
> +	cbo_flush(start, end);
> +}
> +
> +void invalidate_dcache_range(unsigned long start, unsigned long end)
> +{
> +	cbo_inval(start, end);
> +}

The ZICBOM extension is not specific to a single board. We should not 
add this code to board files but into the central place for cache 
operations, i.e. arch/riscv/lib/cache.c.

E.g.

static int get_zicbom_block_size()
{
	if (!CONFIG_IS_ENABLED(RISCV_ISA_ZICBOM))
		return 0;
	if (zicbom_block_size)
		return zicbom_block_size;

	uclass_first_device(UCLASS_CPU, &dev);
	if (!dev) {
		log_err("Failed to get CPU device!\n");
		return 0;
	}

	if (dev_read_u32(dev, "riscv,cbom-block-size", &zicbom_block_size))
		return 0;
	
	return zicbom_block_size
}

__weak void invalidate_icache_range(unsigned long start, unsigned long end)
{
	if (CONFIG_IS_ENABLED(RISCV_ISA_ZICBOM) && get_zicbom_block_size())
		cbo_inval(start, end);
	else		
	        invalidate_icache_all();
}

Cc: Rick as one of the RISC-V maintainers.

Best regards

Heinrich

