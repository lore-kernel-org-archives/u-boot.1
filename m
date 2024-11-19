Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCFCD62067
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 09:50:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A650589390;
	Tue, 19 Nov 2024 10:50:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="wB6ZQQqA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3428A89532; Tue, 19 Nov 2024 10:50:41 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C8EA8924B
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 10:50:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C6B333F18D
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 09:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732009838;
 bh=zMQsalxq10bYdistzym4KyLSfp6CeXodRiT0kX+267o=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=wB6ZQQqArMQoE9Ms3eNJcjFQG/vvZCsdr8+3kAbQ6K85zlxARSFuzr+MtALCyyNLB
 9LIbp8FTN/BU9UggdYBFWkQdctu2f5sZOQntM0/RKgWIwXbyKrkc2pa9xUInLYL+8h
 3N5MpjV/+b1yIXkSqGUAP/6+HCq3JSHXFbzuJq59sgDI419blzjfDcZg+TinIiVPap
 ghzwNI1QU5zBDRsNcQjEB2CNH1moKTD5w5NilvgXJJ/s5hewolLotSvwVhJkcUcvgH
 f1jUQExiltCatjPg7SR0Z8mlIm1IUNwfE0hNSAQ+b8ALulr+CzDK0Z84cNL3O9zfx2
 u4mjEwBqofQSQ==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4317391101aso21839685e9.2
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 01:50:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732009838; x=1732614638;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zMQsalxq10bYdistzym4KyLSfp6CeXodRiT0kX+267o=;
 b=OWoAX/iQTwTBjhpd6cjFOHcR+caKLil6vb2mWXKgy9eccD28sufjTDaTsvpBAq7wjz
 BWJZpnMuhceoGumLTxZOHbQKS2H0sX9jZseg62OFevwfkLFClmiAMzHXTRpBtaa53yLC
 3ESpNrAmhG++L+TCQruuiEc4zBXP5/2bTD1W5mOzBiTUnudmAzcuH0oqU10ng2D9/gER
 3+HK8D95cfX5Ae3ucVZTwX4VtrEcugH6byS972v0OX8SwZITG8vGsyQdq2P+5nOKndcR
 GwZrWtZ09x6Y+2LDeNbKX8lk2JoWNP62ajlZlOUEQBvvWN/tfUFtP6RzqqrwKtZIebkQ
 G5aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzQRblSXnUg44POfTsKHl+5LmfeNLYWXw0uHj2M0fBb+A7AHPfovkwXhvl6dgjsQaS+cn19qU=@lists.denx.de
X-Gm-Message-State: AOJu0YyrYwA/qddjoaDb/taay6oUo889zEL2Q6bG+IGJ/S9TGOdpA8Mo
 9eqBFz+t8zMGYzwzxxHV834uShHrDf5r4ijTW+ROA5uTc0yRdagNwf8nzYSQJsntVcU6mxTDPij
 w8zhhBhxHg3kU3ATq/cQGTZf8dEgx4qWeOm1bIlqp17eG7QiOscr7bylgdC370P7GB8M=
X-Received: by 2002:a05:600c:1ca9:b0:431:4a5a:f09a with SMTP id
 5b1f17b1804b1-432df77b483mr124945325e9.24.1732009838435; 
 Tue, 19 Nov 2024 01:50:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYlyYvdt9ec72XboVV+s+hw/puQoX3RzM2aCRo/suAQL8daiC+z3vUJDY+g82S3stKfN0hSw==
X-Received: by 2002:a05:600c:1ca9:b0:431:4a5a:f09a with SMTP id
 5b1f17b1804b1-432df77b483mr124945105e9.24.1732009838081; 
 Tue, 19 Nov 2024 01:50:38 -0800 (PST)
Received: from [192.168.103.101]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-382435f6986sm7054174f8f.42.2024.11.19.01.50.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 01:50:37 -0800 (PST)
Message-ID: <eed3b936-a54d-4881-8f2e-534bcef34535@canonical.com>
Date: Tue, 19 Nov 2024 10:50:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/14] efi_loader: device_path: add efi_dp_from_ipv4
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de
References: <20241118210908.51196-1-adrianox@gmail.com>
 <20241118210908.51196-4-adrianox@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20241118210908.51196-4-adrianox@gmail.com>
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

On 18.11.24 22:08, Adriano Cordova wrote:
> Add efi_dp_from_ipv4 to form a device path from an ipv4 address.
> 
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
> 
> Changes in v4:
> - Fixed memcpy mistake
> 
> Changes in v3:
> - Removed some unnecessary void* casts.
> - Changed sizeof(struct efi_device_path_ipv4) to sizeof(*ipv4dp)
>    in efi_dp_from_ipv4.
>    
>   lib/efi_loader/efi_device_path.c | 38 ++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> index ee387e1dfd..cdeea4791f 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -974,6 +974,44 @@ struct efi_device_path __maybe_unused *efi_dp_from_eth(void)
>   	return start;
>   }
>   

A function description is missing.

> +struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
> +					 struct efi_ipv4_address *mask,
> +					 struct efi_ipv4_address *srv)
> +{
> +	struct efi_device_path *dp1, *dp2;
> +	efi_uintn_t ipv4dp_len;
> +	struct efi_device_path_ipv4 *ipv4dp;
> +	char *pos;
> +
> +	ipv4dp_len = sizeof(*ipv4dp);
> +	ipv4dp = efi_alloc(ipv4dp_len + sizeof(END));

ipv4dp is a small structure and is freed below.
Allocating it on the stack would reduce the code size.

> +	if (!ipv4dp) {
> +		log_err("Out of memory\n");

Writing messages inside a protocol implementation should be avoided.

> +		return NULL;
> +	}
> +
> +	ipv4dp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> +	ipv4dp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_IPV4;
> +	ipv4dp->dp.length = ipv4dp_len;
> +	ipv4dp->protocol = 6;
> +	if (ip)
> +		memcpy(&ipv4dp->local_ip_address, ip, sizeof(*ip));
> +	if (mask)
> +		memcpy(&ipv4dp->subnet_mask, mask, sizeof(*mask));
> +	if (srv)
> +		memcpy(&ipv4dp->remote_ip_address, srv, sizeof(*srv));
> +	pos = (void *)(uintptr_t)ipv4dp + ipv4dp_len;

Here you

1 - convert ipv4dp to uintptr_t
2 - convert the uintptr_t value to void *
3 - add an offset to the void * value

In the C standard adding an offset to a void * value results in 
undefined behavior. Unfortunately U-Boot code uses it a lot.

pos = (char *)ipv4dp + ipv4dp_len;

is all it takes to have a defined behavior here.

Best regards

Heinrich

> +	memcpy(pos, &END, sizeof(END));
> +
> +	dp1 = efi_dp_from_eth();
> +	dp2 = efi_dp_concat(dp1, (const struct efi_device_path *)ipv4dp, 0);
> +
> +	efi_free_pool(ipv4dp);
> +	efi_free_pool(dp1);
> +
> +	return dp2;
> +}
> +
>   /* Construct a device-path for memory-mapped image */
>   struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
>   					uint64_t start_address,

