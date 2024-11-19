Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84196D60D1B
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 10:14:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C97F89548;
	Tue, 19 Nov 2024 11:14:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pL9KRJeT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E3AD89548; Tue, 19 Nov 2024 11:14:41 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5648488606
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 11:14:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0611B3FA4D
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 10:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732011279;
 bh=kQXP2jqR87bTLRCSOnBjKwS9rtaOSJj03b3Rf44LXQI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=pL9KRJeTFEI8BaQpZBsQ+dr4UHWMyg7ibmnO6Hog/CeuKS/ADPt4g5oXmOWcE86dm
 lyPpAhyN/zDLtkbM6RWAzH6OGp6DXuzj46LzbGvfg155DkW614TI8SE0Kt1A6RI9FF
 A6JkTFTMq23AVf1+nCUxNYIcIpFtW7osWvGLn6y63DBHEdGwcG/NVLG2ttKn7VsrR+
 agz6JCqJ/lv3qw5VJFUaLWE1L6zY2K5ZtBkxpP5Lj73oYBvaelv7b05dbbji4HqqtS
 7Cx1SulYlJKwsFotYTqBqZ/oTFk4XfjW89BM99wSe2Y5puRiwxhWT5sietH4w3qRY2
 ROxPAsBF3EHlg==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315ad4938fso5687745e9.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 02:14:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732011277; x=1732616077;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kQXP2jqR87bTLRCSOnBjKwS9rtaOSJj03b3Rf44LXQI=;
 b=xQf5MtrvD6VjYy4OyOC6bTwOnNvSf9mzk8MTlHpNQ6M9bHU2kcpIa8jN648CbuKNf8
 +bRdGzoBiTDCT9cnxxwUiJoOMEYCByv8pPykGvMOOTeSsT34jpJmqNWtyVsIJqRa1aVl
 GBuSwO44cPVSOLK1WiUJc+swW369npElXITo43bvmK0KW0Ij6alFDG96wG3m8qRs83pu
 MfsrlNaDCepBdRtykBilALlkw0zNJRgdM+F41wODIViW5NalFbLyyCALLLV042UuDj7h
 lyATIqaFNbdULDltoemHvVDmVmn3xBISpijMg1ZTefjsZ3hZAA0/eYs3w6gv9JKpqISY
 VO5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXOM9SR61npnUSwrQf65P5naP9R+WtCCffHnXThgDiKLMGNSpVgT4If+3/DjoiHFslszA+ZV4=@lists.denx.de
X-Gm-Message-State: AOJu0YyvpbKlMT3yAHPztkvBRlzSJpuw9Gr9XDtoRuxRj5jzuPOTpoKA
 6CnpmIzwksBTuSgklvKdNyc8H6nbkU+U+CX59TKQiLaxmJzA+TnDuaUdvOdcvHrJvp0s4wnjBki
 Quof8VKUWl0jmej0Klho+y6s91llWduyqd+MTRGB/8NmilogHaa+J/ZDpZwXazQVJS0I=
X-Received: by 2002:a05:600c:138f:b0:431:5ab3:d28d with SMTP id
 5b1f17b1804b1-432df72a98bmr138530375e9.9.1732011277491; 
 Tue, 19 Nov 2024 02:14:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4RTnjXvb5EwRe9k1aEm8t+HCFC//w4dIu6Ggbl6l8dnWti41n4EOhqak0ShlEWG0RlITThA==
X-Received: by 2002:a05:600c:138f:b0:431:5ab3:d28d with SMTP id
 5b1f17b1804b1-432df72a98bmr138530205e9.9.1732011277131; 
 Tue, 19 Nov 2024 02:14:37 -0800 (PST)
Received: from [192.168.103.101]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da27ffafsm191445135e9.22.2024.11.19.02.14.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 02:14:36 -0800 (PST)
Message-ID: <d3e50c54-4d39-4930-a6f1-b29ba60bfd19@canonical.com>
Date: Tue, 19 Nov 2024 11:14:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/14] efi_loader: device_path: add support for HTTP
 device path
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
References: <20241118210908.51196-1-adrianox@gmail.com>
 <20241118210908.51196-8-adrianox@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20241118210908.51196-8-adrianox@gmail.com>
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

On 18.11.24 22:09, Adriano Cordova wrote:
> Add efi_dp_from_http to form a device path from HTTP. The
> device path is the concatenation of the device path returned
> by efi_dp_from_ipv4 together with an URI node and an END node.
> 
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
> Changes in v4:
> - Reworked an if-else
> 
> Changes in v3:
> - Moved argument checks in efi_dp_from_http to the beginning of the function
>   include/efi_loader.h             |  1 +
>   lib/efi_loader/efi_device_path.c | 52 ++++++++++++++++++++++++++++++++
>   2 files changed, 53 insertions(+)
> 
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 612bc42816..96b204dfc3 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -872,6 +872,7 @@ struct efi_device_path *efi_dp_part_node(struct blk_desc *desc, int part);
>   struct efi_device_path *efi_dp_from_file(const struct efi_device_path *dp,
>   					 const char *path);
>   struct efi_device_path *efi_dp_from_eth(void);
> +struct efi_device_path *efi_dp_from_http(const char *server);
>   struct efi_device_path *efi_dp_from_mem(uint32_t mem_type,
>   					uint64_t start_address,
>   					size_t size);
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> index cdeea4791f..9ee03062ac 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -1012,6 +1012,58 @@ struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
>   	return dp2;
>   }
>   

A function description is missing.
Please,

> +struct efi_device_path *efi_dp_from_http(const char *server)
> +{
> +	struct efi_device_path *dp1, *dp2;
> +	struct efi_device_path_uri *uridp;
> +	efi_uintn_t uridp_len;
> +	char *pos;
> +	char tmp[128];
> +	struct efi_ipv4_address ip;
> +	struct efi_ipv4_address mask;
> +
> +	if ((server && strlen("http://") + strlen(server) + 1  > sizeof(tmp)) ||
> +	    (!server && IS_ENABLED(CONFIG_NET_LWIP)))
> +		return NULL;
> +
> +	efi_net_get_addr(&ip, &mask, NULL);
> +
> +	dp1 = efi_dp_from_ipv4(&ip, &mask, NULL);

This seems to be the only usage of efi_dp_from_ipv4(). So we should make 
it static.

dp1 is expected to be NULL if we are out of memory. This error needs to 
be handled.

> +
> +	strcpy(tmp, "http://");

@Ilias:
Linaro sent a patch series for supporting https.
Will that go in after this series?

> +
> +	if (server) {
> +		memcpy(tmp + strlen("http://"), server, strlen(server) + 1);

Please, use strcat() to simplify this line.

> +	}
> +#if !IS_ENABLED(CONFIG_NET_LWIP)

Please use 'else if' instead of '#if'.

Best regards

Heinrich

> +	else {
> +		ip_to_string(net_server_ip, tmp + strlen("http://"));
> +	}
> +#endif
> +
> +	uridp_len = sizeof(struct efi_device_path) + strlen(tmp) + 1;
> +	uridp = efi_alloc(uridp_len + sizeof(END));
> +	if (!uridp) {
> +		log_err("Out of memory\n");
> +		return NULL;
> +	}
> +	uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> +	uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
> +	uridp->dp.length = uridp_len;
> +	debug("device path: setting uri device path to %s\n", tmp);
> +	memcpy(uridp->uri, tmp, strlen(tmp) + 1);
> +
> +	pos = (char *)uridp + uridp_len;
> +	memcpy(pos, &END, sizeof(END));
> +
> +	dp2 = efi_dp_concat(dp1, (const struct efi_device_path *)uridp, 0);
> +
> +	efi_free_pool(uridp);
> +	efi_free_pool(dp1);
> +
> +	return dp2;
> +}
> +
>   /* Construct a device-path for memory-mapped image */
>   struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
>   					uint64_t start_address,

