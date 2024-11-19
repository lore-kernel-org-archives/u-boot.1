Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082A0D6206A
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 10:29:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D6E28952C;
	Tue, 19 Nov 2024 11:29:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="F51sc6ka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 696F08904C; Tue, 19 Nov 2024 11:29:14 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BB5E8953A
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 11:29:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 395DC3F291
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 10:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732012151;
 bh=Wwagqt23S9Ih99ttCxo50L0OWO04y3459yA7eSVBs4Y=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=F51sc6kaG/0lVQ0hAYJaXKZREMehNc80cfVBcJHPR1ysAB4O4QTaIzD1aMFxCfLUz
 18E3YIRPT3zDS58GD1WQFXkwZsQD5XqGW9eJoelr5opgduzxem/Glfpuew8ewPRmsK
 JgBc98zmISHmkT651Vvu/PMDX4Tll389bOXfFMoQH4bBr4dfV0Fxou0taRP4davA+y
 kvZNSaQm4dHjeQJt6BDwShs+9hrfKU3soGm1XH3vdGo+/748WsCSOV6BzqdDfScoTC
 HCrgCfjrJLsO9/V20VjUMhVZOUfqzNCTZ048U0ra52nWkloxJp/Pyvc/wNB3LtNaVc
 diXmQue0kd1NQ==
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2fb50351d18so15329181fa.3
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 02:29:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732012150; x=1732616950;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wwagqt23S9Ih99ttCxo50L0OWO04y3459yA7eSVBs4Y=;
 b=Rohac0a6/og/2oxnTk5+CRuVOzaVI4y20w8jbQ8qj9S1LDF+yjk+bfYUMDpUWkSoPr
 LGJvC7kE+VJkTPPOg+Q4G5BDOFoIci0f1nuKuhAwAsEYBGJoWXU7hriv0EN1Tu2m/waB
 EEGAaM8HUUa60gwUJYCXe9IY8oDN85EVA1FOVLrrh7oOeV5A44u11jGtcLrrB+/MlSyT
 6IJ5koroyNJeIWP2fTwDE0dWd52YD+Pr1AuygU1Sji6iRmpVj+gl3BbhPAdNnUpX03I1
 hpdYJvge4RRWaiTOMtQ/n9dvQgVoQElm9AJ/FjENdEhDPEJJI+vH04rX8hvhksTnAODL
 2nwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU3cB4JNGlG+Zm3bihbA2qQZbGcR19t6ogddREbzGONg7Yj8LT43cJ0xkUVGwd7a9Gu1ty3CM=@lists.denx.de
X-Gm-Message-State: AOJu0YxEkCYm1xz/QY/EstLPdSXnRoAWuK+dw/6BSWQpKxgFxCvw9li3
 L8eo/gjxhxKN0V3/ouwe/8uHFwQahyCFAU+poUZ0MW1+VS2ca/gP6j5grmtK8RF4H6uODvW2y+I
 tfgXsF2zDYl7dCP9zDeazYaoL9CJuGclulVnRaCSB2jawuswvElliSCefs5/LgrZLNXY=
X-Received: by 2002:a05:6512:398d:b0:53d:9ff8:edcd with SMTP id
 2adb3069b0e04-53dab3b6208mr6155233e87.51.1732012150501; 
 Tue, 19 Nov 2024 02:29:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFru9INblW56oPI5mZ5fqUWV8+qG1rYjfCzsizyREPIHP9OY1QgAapXDG2lIJOKyLi94aqwZg==
X-Received: by 2002:a05:6512:398d:b0:53d:9ff8:edcd with SMTP id
 2adb3069b0e04-53dab3b6208mr6155218e87.51.1732012150055; 
 Tue, 19 Nov 2024 02:29:10 -0800 (PST)
Received: from [192.168.103.101]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3823c47f7f8sm8970607f8f.100.2024.11.19.02.29.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 02:29:09 -0800 (PST)
Message-ID: <603f96d6-b32d-4eaf-92fa-ebe57f91bfb8@canonical.com>
Date: Tue, 19 Nov 2024 11:29:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/14] efi_loader: net: set EFI bootdevice device path
 to HTTP when loaded from wget
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20241118210908.51196-1-adrianox@gmail.com>
 <20241118210908.51196-9-adrianox@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20241118210908.51196-9-adrianox@gmail.com>
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
> Set the device path of the efi boot device to an HTTP device path
> (as formed by efi_dp_from_http) when the next boot stage is loaded
> using wget (i.e., when wget is used with wget_info.set_bootdev=1).
> 
> When loaded from HTTP, the device path should account for it so that
> the next boot stage is aware (e.g. grub only loads its http stack if
> it itself was loaded from http, and it checks this from its device path).
> 
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
> 
> (no changes since v2)
> 
>   include/efi_loader.h             |  6 +++++
>   lib/efi_loader/efi_device_path.c |  2 +-
>   lib/efi_loader/efi_net.c         | 38 +++++++++++++++++++++++++++++++-
>   net/lwip/wget.c                  |  1 +
>   net/wget.c                       |  1 +
>   5 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 96b204dfc3..f49f8e6be0 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -126,6 +126,10 @@ static inline void efi_set_bootdev(const char *dev, const char *devnr,
>   #endif
>   
>   #if CONFIG_IS_ENABLED(NETDEVICES) && CONFIG_IS_ENABLED(EFI_LOADER)
> +/* Call this to update the current device path of the efi net device */
> +void efi_net_set_dp(const char *dev, const char *server);
> +/* Call this to get the current device path of the efi net device */
> +void efi_net_get_dp(void **dp);
>   void efi_net_get_addr(struct efi_ipv4_address *ip,
>   		      struct efi_ipv4_address *mask,
>   		      struct efi_ipv4_address *gw);
> @@ -133,6 +137,8 @@ void efi_net_set_addr(struct efi_ipv4_address *ip,
>   		      struct efi_ipv4_address *mask,
>   		      struct efi_ipv4_address *gw);
>   #else
> +static inline void efi_net_set_dp(const char *dev, const char *server) { }
> +static inline void efi_net_get_dp(void **dp) { }
>   static inline void efi_net_get_addr(struct efi_ipv4_address *ip,
>   				     struct efi_ipv4_address *mask,
>   				     struct efi_ipv4_address *gw) { }
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> index 9ee03062ac..5fae3fbb5a 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -1165,7 +1165,7 @@ efi_status_t efi_dp_from_name(const char *dev, const char *devnr,
>   		dp = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
>   				     (uintptr_t)image_addr, image_size);
>   	} else if (IS_ENABLED(CONFIG_NETDEVICES) && !strcmp(dev, "Net")) {
> -		dp = efi_dp_from_eth();
> +		efi_net_get_dp((void **)&dp);
>   	} else if (!strcmp(dev, "Uart")) {
>   		dp = efi_dp_from_uart();
>   	} else {
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index 3f0b571cc6..2207caf6fe 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -16,6 +16,7 @@
>    */
>   
>   #include <efi_loader.h>
> +#include <dm.h>
>   #include <malloc.h>
>   #include <vsprintf.h>
>   #include <net.h>
> @@ -31,6 +32,7 @@ static size_t *receive_lengths;
>   static int rx_packet_idx;
>   static int rx_packet_num;
>   static struct efi_net_obj *netobj;

The role of net_dp deserves a description.

> +static struct efi_device_path *net_dp;
>   
>   /*
>    * The notification function of this event is called in every timer cycle
> @@ -902,8 +904,10 @@ efi_status_t efi_net_register(void)
>   			     &netobj->net);
>   	if (r != EFI_SUCCESS)
>   		goto failure_to_add_protocol;
> +	if (!net_dp)
> +		efi_net_set_dp("Net", NULL);
>   	r = efi_add_protocol(&netobj->header, &efi_guid_device_path,
> -			     efi_dp_from_eth());
> +			     net_dp);
>   	if (r != EFI_SUCCESS)
>   		goto failure_to_add_protocol;
>   	r = efi_add_protocol(&netobj->header, &efi_pxe_base_code_protocol_guid,
> @@ -999,6 +1003,38 @@ out_of_resources:
>   	return EFI_OUT_OF_RESOURCES;
>   }
>   
> +/**
> + * efi_net_set_dp() - set device path of efi net device
> + *
> + * This gets called to update the device path when a new boot
> + * file is dowloaded
> + *
> + * @dev:	dev to set the device path from
> + * @server:	remote server address
> + */
> +void efi_net_set_dp(const char *dev, const char *server)
> +{
> +	if (!strcmp(dev, "Net"))
> +		net_dp = efi_dp_from_eth();
> +	else if (!strcmp(dev, "Http"))
> +		net_dp = efi_dp_from_http(server);
> +}
> +
> +/**
> + * efi_net_get_dp() - get device path of efi net device
> + *
> + * Produce a copy of the current device path
> + *
> + * @dp:		copy of the current device path
> + */
> +void efi_net_get_dp(void **dp)

We know that dp must point to a device-path. Please, do not use void**.

efi_device_path** should be fine.

Best regards

Heinrich

> +{
> +	if (!net_dp)
> +		efi_net_set_dp("Net", NULL);
> +	if (dp && net_dp)
> +		*dp = efi_dp_dup(net_dp);
> +}
> +
>   /**
>    * efi_net_get_addr() - get IP address information
>    *
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index 53c3b169e0..5c44e324be 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -217,6 +217,7 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
>   	print_size(rx_content_len / elapsed * 1000, "/s)\n");
>   	printf("Bytes transferred = %lu (%lx hex)\n", ctx->size, ctx->size);
>   	if (wget_info->set_bootdev) {
> +		efi_net_set_dp("Http", ctx->server_name);
>   		efi_set_bootdev("Net", "", ctx->path, map_sysmem(ctx->saved_daddr, 0),
>   				rx_content_len);
>   	}
> diff --git a/net/wget.c b/net/wget.c
> index 1166aa5aa6..a1328990d2 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -442,6 +442,7 @@ static void wget_handler(uchar *pkt, u16 dport,
>   		net_set_state(wget_loop_state);
>   		wget_info->file_size = net_boot_file_size;
>   		if (wget_info->method == WGET_HTTP_METHOD_GET && wget_info->set_bootdev) {
> +			efi_net_set_dp("Http", NULL);
>   			efi_set_bootdev("Net", "", image_url,
>   					map_sysmem(image_load_addr, 0),
>   					net_boot_file_size);

