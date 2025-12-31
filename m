Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12202EE6428
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 12:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F8F683F8A;
	Wed, 31 Dec 2025 13:12:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SKm2SEZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C30583F8F; Wed, 31 Dec 2025 13:12:51 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16A6583F6D
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 13:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BBEED3F85F
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 12:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767183168;
 bh=ZXU0qn4u3VbQOjqFleXg2vCUjeIqffKpaezQIJ15w7I=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=SKm2SEZTcLX30ryKFFl6XTwt4fwR7dAVtRvq8TuR4F78I1xleBWcYMoV/wWgsR7XI
 NzddtrLQlhX3vPWNYORAdoxBlqwQCDPcUU+qX3CKrjUEBbmi5VqjB1AR6av6b4B8we
 fnUApXr0HjwThr9DGIMwt84jMHDeUdzEvPFNc5Oj58RmEI6snY4M3zbDF47jDjH5YH
 FgS8CSi40zFtmzXGYSUmXrKs+DKpEqeocoQQeEXKIafQIrlbsF83Aj036QTNdSIruY
 BMFSm/sgAc1wwi2bt7VAhqj3eW8fUPIaY6rbEgLlI00AjFVat4wKUJkdgoOT78vuRA
 msnFrOepcU39PUBjI4VraFkFIz5aftbi7zrYTFSImzsXH7m3ZvolGMJAq5vzTogq33
 oPu5Ve/7jRCMaw33txmzJ3i5SHR7tMI0GBi1E2cZKoCgt3OyA6LQl3qVO04UKiVujQ
 KsaQMOoU14aicVoh2vged4FpgBLznYF9cYAxyzShXp7nkxtZk1GP92uMq7nMqaXmM3
 /z3oeseT/V1fneXuF2GgvSVlgvg85qOmf2buLGbTwouTqPZs7fPxt0qbzDqps9GmS4
 xDAwfadl5R/Fk/NT/rzZZtqqa3CfTr4Uw3ibxrkEEnhwR8ZEII1cApqieVV27aCtQb
 QUUysfSn4eYtjyJG3oMNTBGk=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477563e531cso72255475e9.1
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 04:12:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767183168; x=1767787968;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZXU0qn4u3VbQOjqFleXg2vCUjeIqffKpaezQIJ15w7I=;
 b=UMRxx5SznfnAG2lgpdJRjOR/PQfBDEoVnvZm2/Gr0J8ycxD6CCy1XzXpcF3UfAkST+
 g/KXm0xjwwvwOZzYI+JI7Km+TQnPOGP8Y+CTpxY2A7SPo/q2KAOBq0NFy/Emm9QOsp7e
 ezbd0RoULeT8TFZxXL4LOHBfqqIE8k5YdturEp+0rktk1cWDPjlu+krimBsya9oK04Uf
 +IMcvb3VUH7Nbp9jCohu2TvOnoKmblpUKGYBq0yioOjbm/Ih4GXa0rt5qe6tJsce9OWY
 /Y/FTvhTveeqgxJ/xJM/Sv7lKU1cwZigeSipmjrOkBP3s/e8kwMn5Oj33wN5Dey9q5/p
 CHaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt8PxFFpxnujZ1vZ9D0US9SCjZGdjavoAPxwrZADK6iTvP67B/qjTIgmpezFzFllmcbd/yja4=@lists.denx.de
X-Gm-Message-State: AOJu0YwOpm9msHLhAtdFuz9ha54AZa4Yy+r18E9RnDa9ueDMiBZfvOS/
 +G7peKqPM4W03rxtxuE4s8+kIGn7cF9O8HOtsXBmaLJyqSWS8D7vLdCq8LkCkLKNAm+ywoLn8Mw
 fj7ZRoeDrenLhXudzDM561mohcGE9S4spS54q40XU4I46lt37OOUPN6WnSVpGMf+iczd+MlR0mk
 odSvA=
X-Gm-Gg: AY/fxX6XYrg82kXAEu/zhu5Nor3XfrRCWjdCzaBiwviDAYcrUEyCxnlUm6bKnDRRUdg
 WvtMT4EsqhZLpd4yuiREkxTWaYhnlhMqwGFkJjGdN/zsNS+RuMv1XSKVNts+zgZP7gHRmCOyO+M
 HA7epiaY4cqLAl3aw4G6NfRni8UYf2n8AtnAbRxZJbpY0UZJmaAS5ZwZiUstAlGLF/MAM97ijgy
 Pobh8XAVhx96qxa61SgB2BYXdgp1FQfNMCbu9iIw6q9wobKKjTyZd6QqtCRQb6xh+m5TfynTeMo
 KCNE0z7f6RRR2aQLHk/RahheSNPdcouv2PIUZQLF5WxkFjlAa3o1Gy0DhnmRM7o+Il88ZUCLVuv
 6QsFRQ973okdhzNy4pgFw//Is1uKFHhhnp942owQ1eMblGk99QOTBkJfMuCVBzgSSCw==
X-Received: by 2002:a05:600c:4706:b0:477:9b35:3e49 with SMTP id
 5b1f17b1804b1-47d195495e1mr424464715e9.3.1767183168277; 
 Wed, 31 Dec 2025 04:12:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLYc/zpjC/TCT1frhdG5rIQWm8wJOb8NAF1O4SuCkdkSbsOeE7R6X9xQRZOZQBL4+dub3w8w==
X-Received: by 2002:a05:600c:4706:b0:477:9b35:3e49 with SMTP id
 5b1f17b1804b1-47d195495e1mr424464385e9.3.1767183167721; 
 Wed, 31 Dec 2025 04:12:47 -0800 (PST)
Received: from [192.168.103.126]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa64cesm73965829f8f.35.2025.12.31.04.12.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Dec 2025 04:12:47 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <3983ea9a-e965-472f-aced-d74f27ed95e0@gmx.de>
Date: Wed, 31 Dec 2025 13:12:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] rtc: goldfish: Support platform data for non-DT
 probing
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: me@ziyao.cc, daniel@0x0f.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de, alison.wang@nxp.com,
 angelo@kernel-space.org, trini@konsulko.com
References: <20251230160112.3045527-1-visitorckw@gmail.com>
 <20251230160112.3045527-4-visitorckw@gmail.com>
Content-Language: en-US
In-Reply-To: <20251230160112.3045527-4-visitorckw@gmail.com>
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

On 12/30/25 17:01, Kuan-Wei Chiu wrote:
> Currently, the Goldfish RTC driver exclusively relies on device tree
> to retrieve the base address, failing immediately if dev_read_addr()
> returns FDT_ADDR_T_NONE. This restriction prevents the driver from
> being used on platforms that instantiate devices via U_BOOT_DRVINFO()
> instead of device tree, such as the QEMU m68k virt machine.
> 
> Add support for platform data to address this limitation. Update the
> probe function to fall back to retrieving the base address from
> struct goldfish_rtc_plat if the device tree address is unavailable.
> Introduce a new header file include/goldfish_rtc.h to define the
> platform data structure.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Changes in v3:
> - New patch.
> 
> It appears there is no specific maintainer listed for this driver?
> 
>   drivers/rtc/goldfish_rtc.c | 10 ++++++++--
>   include/goldfish_rtc.h     | 15 +++++++++++++++
>   2 files changed, 23 insertions(+), 2 deletions(-)
>   create mode 100644 include/goldfish_rtc.h
> 
> diff --git a/drivers/rtc/goldfish_rtc.c b/drivers/rtc/goldfish_rtc.c
> index e63a2766c76..900daabccb9 100644
> --- a/drivers/rtc/goldfish_rtc.c
> +++ b/drivers/rtc/goldfish_rtc.c
> @@ -9,6 +9,7 @@
>   
>   #include <div64.h>
>   #include <dm.h>
> +#include <goldfish_rtc.h>
>   #include <mapmem.h>
>   #include <rtc.h>
>   #include <linux/io.h>
> @@ -77,11 +78,16 @@ static int goldfish_rtc_set(struct udevice *dev, const struct rtc_time *time)
>   static int goldfish_rtc_probe(struct udevice *dev)
>   {
>   	struct goldfish_rtc *priv = dev_get_priv(dev);
> +	struct goldfish_rtc_plat *plat;
>   	fdt_addr_t addr;
>   
>   	addr = dev_read_addr(dev);
> -	if (addr == FDT_ADDR_T_NONE)
> -		return -EINVAL;
> +	if (addr == FDT_ADDR_T_NONE) {
> +		plat = dev_get_plat(dev);
> +		if (!plat)
> +			return -EINVAL;
> +		addr = (fdt_addr_t)plat->base;

addr is not a pointer, it is an address in the sandbox virtual memory 
address space. This is why map_sysmem() is used below.

The suggested code fails to build on sandbox_defconfig with the driver 
enabled:

drivers/rtc/goldfish_rtc.c: In function ‘goldfish_rtc_probe’:
drivers/rtc/goldfish_rtc.c:89:24: warning: cast from pointer to integer 
of different size [-Wpointer-to-int-cast]
    89 |                 addr = (fdt_addr_t)plat->base;
       |

Please, use

	priv->base = plat->base;

If plat->base is NULL, please, throw -EINVAL.

Best regards

Heinrich

> +	}
>   	priv->base = map_sysmem(addr, 0x20);
>   
>   	return 0;
> diff --git a/include/goldfish_rtc.h b/include/goldfish_rtc.h
> new file mode 100644
> index 00000000000..bb113a0bd79
> --- /dev/null
> +++ b/include/goldfish_rtc.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> + */
> +
> +#ifndef _GOLDFISH_RTC_H_
> +#define _GOLDFISH_RTC_H_
> +
> +#include <linux/types.h>
> +
> +struct goldfish_rtc_plat {
> +	void __iomem *base;
> +};
> +
> +#endif /* _GOLDFISH_RTC_H_ */

