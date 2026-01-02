Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2233EEB57A
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 08:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50EF184105;
	Fri,  2 Jan 2026 09:28:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="E6MsKyw2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 982EC84164; Fri,  2 Jan 2026 09:28:04 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BD7683FB2
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 09:28:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DB0C63F452
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 08:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767342481;
 bh=wPs0HJF5EWu5Oj6eRrn1bY/rPIQxxiYGK6O9Hx6RLTs=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=E6MsKyw2t311bYGrDIxWoCz03zjS/8WRn663FKjCFJE6RrDo9Q4NEyKj9comwu2J5
 T5+zPuD/agG4b+6ijaSUDBLVmPeodkkVGSr3bJanPM0PxiwxP/P9Shrk/uBTZSEGt7
 8jUnQ5yn0IVCFwRasADn7IGR5nwpPDXRl12VRLXboHQSWo+fDp8tdQxFokiscjftfh
 mc9awuuLEZ22VFt5wlEX930/tR6E8chxT4FS2UGHItGvqdjIqtRFCbQynl+fIGQFPx
 878CvyFRm3k37KtSqujmwbwhYg8Ws5eqB38tUefl0/908KMPt8oIs5NYBRP/SAjDFZ
 DOERl1v2/vSQHdN7oZoEdVBhoC/TqovfiMeF2LyzddpPm+gGfka8i2AKyMyobqyRQg
 ncbGhJ7Ux8+ZSqes1jYlDLTbxgeJu1StmxPP8bWGDGHtPmfLfHc0+BJE+2CMxxkfoY
 BRzI5nKEHrOA+H2XN/a98WfTZcb+RSlFXodm6qqduXcMaBVcHP0I4ak+IZFE+X0n79
 eVz+PrO3zmbg/Lh6WgUQfa/LSvZxesZVSBYGciYwq4bDTJcilL4F15bkfOC+NZSRBu
 BAh7ewaFfWMCd8R714GnAJR3Ir6eUaZhKOxtJBJqGb9Ybj0MVQYaopUMIZaUPjhQ76
 +geUeoyrV/tLIAsTiTuxSxss=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4779edba8f3so94029075e9.3
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 00:28:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767342481; x=1767947281;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wPs0HJF5EWu5Oj6eRrn1bY/rPIQxxiYGK6O9Hx6RLTs=;
 b=s9NsxVQ7yfGqdpjD80eZHRlq/Pu/zwn5HQlUdLCT3TGV35ZX7uqzxYXhdzQrq15ZB1
 QxhiFsPLQ3c/8/t4B9e6pMskBEIkWhycYllGsAnsTQvkCLK0LVlorppY0f7x0dlKlJv3
 hoMqla5Kr+Vr+IHT7Tg1IceQfFwwidcZaGjwBe/mDxsqGU1h38SqU86PwvbpFs4/nqT/
 37XHd6D3a/cAtNFLvg9KxTpR5SKeSpVO0yYEHSWLmWr8+HJiuE62nl2118p6lhRT9HvD
 EHnYuWrdHdwCoF7pLibYKl7v0Rb1rtam+AfSFlpxEJx6i5Tr6PzVP2tl5is8kUbIg6H7
 8npw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx325kj2ajImCYr+2gT47YEAniMWMsQoUvMmzSuh4rZ+UlIOADaJJrPfJt41KL18uAyT26fjM=@lists.denx.de
X-Gm-Message-State: AOJu0YxCYgiwXhCi1ik+AjNEJciFhZ5GG+nQsLfwqfRa3rXY8eyMwjqv
 hsv6m1ObQxn+h/BOtBVbwT5hVS15q98xuE2LypVNUhtpwIGW1I+PApKmv8L7KsRDAk/x+EcoIme
 vxekiMSMMNJO8M4xwBbuOfCJLF4ekPkhgGuNe1PCrarGHljAjaUFGuHMGQPSnEIsd0czFzz9C3I
 bO3lk=
X-Gm-Gg: AY/fxX5JcLmaKwaKsA1kTrS/aD7BLgF1JZ5pYDmh989axy5Tpum+fmLS0gszVcGOlO2
 /7xX6J+cCDH/ytEoAw05db+De69LtarTq37cGtxTSyu8lXM/C0LSc4nC1FCRFZIAZTse8aEQycd
 2fMrf3+8BNtcSIgyqhv31AEkf3kys9wST+Qhgeo00jj6p4hOvIctV6RxsTu6wZ8MVRIbYRV/gtX
 b1E0LJXB+/RSvBRsIazexBwZr6n/TrxIQ8VeiueAf7tfqh0Cbv5P2hZ7Ywyv5hBzT5duDN9Fz9T
 eUH+IYplZz5+kEBKZtdQ227Hg81GifMJUqVeIbnVY8ciEhaSmQ+KtfHLW+1D1nccbUGnWHBMbjw
 OGzFaawphBcFmEELUv4Jb5HZVWWrJmFYmK4LKe3zIcPs3dlppzJ4ZlY3bmftnctz1F3vXxf/5i5
 z+12mEZV0=
X-Received: by 2002:a05:600c:608f:b0:477:63b5:6f76 with SMTP id
 5b1f17b1804b1-47d19582bfcmr460941265e9.25.1767342481467; 
 Fri, 02 Jan 2026 00:28:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdcmwyvsoe+Tv2QWIt8ES8QrbFo1Y5XNt2lchGdhSAO3HYcRjAKEEhc43jQsHB071JXBU4XA==
X-Received: by 2002:a05:600c:608f:b0:477:63b5:6f76 with SMTP id
 5b1f17b1804b1-47d19582bfcmr460941155e9.25.1767342481110; 
 Fri, 02 Jan 2026 00:28:01 -0800 (PST)
Received: from [192.168.103.126]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d28a33adcsm245729455e9.18.2026.01.02.00.28.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jan 2026 00:28:00 -0800 (PST)
Message-ID: <6d9d6ef2-6aa4-4448-a0ea-73ac1ffd1890@canonical.com>
Date: Fri, 2 Jan 2026 09:27:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] rtc: goldfish: Support platform data for non-DT
 probing
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: me@ziyao.cc, daniel@0x0f.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de, alison.wang@nxp.com,
 angelo@kernel-space.org, trini@konsulko.com
References: <20260101175420.4118024-1-visitorckw@gmail.com>
 <20260101175420.4118024-4-visitorckw@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260101175420.4118024-4-visitorckw@gmail.com>
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

On 1/1/26 18:54, Kuan-Wei Chiu wrote:
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

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
> Changes in v4:
> - Fix sandbox build warning by removing incorrect pointer casting.
> - Assign plat->base directly to priv->base instead of using
>    map_sysmem() for platform data.
> 
>   drivers/rtc/goldfish_rtc.c | 13 ++++++++++---
>   include/goldfish_rtc.h     | 15 +++++++++++++++
>   2 files changed, 25 insertions(+), 3 deletions(-)
>   create mode 100644 include/goldfish_rtc.h
> 
> diff --git a/drivers/rtc/goldfish_rtc.c b/drivers/rtc/goldfish_rtc.c
> index e63a2766c76..f6316896595 100644
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
> @@ -77,12 +78,18 @@ static int goldfish_rtc_set(struct udevice *dev, const struct rtc_time *time)
>   static int goldfish_rtc_probe(struct udevice *dev)
>   {
>   	struct goldfish_rtc *priv = dev_get_priv(dev);
> +	struct goldfish_rtc_plat *plat;
>   	fdt_addr_t addr;
>   
>   	addr = dev_read_addr(dev);
> -	if (addr == FDT_ADDR_T_NONE)
> -		return -EINVAL;
> -	priv->base = map_sysmem(addr, 0x20);
> +	if (addr != FDT_ADDR_T_NONE) {
> +		priv->base = map_sysmem(addr, 0x20);
> +	} else {
> +		plat = dev_get_plat(dev);
> +		if (!plat)
> +			return -EINVAL;
> +		priv->base = plat->base;
> +	}
>   
>   	return 0;
>   }
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

