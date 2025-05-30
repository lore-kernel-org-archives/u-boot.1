Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3ABFC5B549
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 08:07:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 363198312C;
	Fri, 30 May 2025 10:07:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WJdCp1FA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50B70831F5; Fri, 30 May 2025 10:07:19 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A0E882A9E
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 10:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-450cea01b9cso7503195e9.0
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 01:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748592437; x=1749197237; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8EFtPsOmgZ0ouAFwmoR0Ul4h3Dey+dka+hKlTZ1Bk5c=;
 b=WJdCp1FAIQiWwUB8MFKn37w20ZzlUytRtkG8xWnuSm3yxsmBaltc5CNkHA0RH0WuJl
 dw2DcH0cGCRi7kBqjtZCl7ORAULBtGrtgjnXYg9BC0mLsECNtsF01XgVwX9UHsemmqU1
 gIEcBzdjBziGFGpLDT5GMC9XdVFJ00/v7A84guuwbbdHwTiIlaIbZEBOMyyCgEohyURr
 gdFqZMkUXJuy7/vK9wBM1ZdQww52B7zRVZ8uISOnkaIkr2ghlnNfjc1WNO5l2N7GYi8m
 gydInY4e+BYD0aRrc+Vcq+Boug3bXIMoKP2PA/q2Ya/8S9te8jja7LHYqDRZ7dWrMjJp
 jZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748592437; x=1749197237;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8EFtPsOmgZ0ouAFwmoR0Ul4h3Dey+dka+hKlTZ1Bk5c=;
 b=irAqT5mnASkPVEDTPeNJmn7xl+wid6Zo89raR5b4jiNl1OzRDfbzLwuCdvGPB3frkS
 Qx5hXcWwVwfHNRxVG70R4MvpHBA60QcKXZiHuZBdgyOipe2K1CBV546PYwtAs449r0R8
 uSecswiqDnQQU8k+d3zsCpBVUzOFNltm1rM7HOpJaQ8TY17yPMvT4sJMHpfYvgCWp3Zd
 X58Tq8CqloTVSRKFZgdfNJuSmjVkfveaBTkX7zMEU75zWugEDtxNJ/WozKK+vbJul2cN
 DhKID6vL6X5FKlOJCqfPqKu73LdOOSCjdf69HZ2Gdau6tuYMAmzeJWGcIolvZibDcQxG
 cXvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0I1bgn56H9DxB+OvonJah+9HXnj1CIqn+lhdwxWs0crZ0OAa+aC1R+6FaO5Ed56S2OD2bDqs=@lists.denx.de
X-Gm-Message-State: AOJu0YzS5BJqrtrv44W3H8XT8vRuVKOQijEOhA7uvveJtCn9TWlNNkyJ
 jqzl0z8qN5q5gB/6QkuGImlT++1YRtOeHI9iX98W1Y0YqdpjoIsrvKvZ3ee0Va+NrN5qRhuPIv1
 msQfk
X-Gm-Gg: ASbGncs5UrtwdK5ScmNkkI5eFdEtl3gtStmnDNNDb/YYJH4FvyZKPaMX89z4rKS7e9D
 ljeJ7APscwSjxe1qWObPQcHu1fDK5zGSpxZnKczNxSpDJQYWNOga4ChEFfwJ37zL6RFxLyTPIrr
 HvtB9zrn9RefNXEjFP5cIfscd8W/BlzLCylCXPQ04fYr1N2Oh6b/xbVfuMzjOkxgIacl/NTIxxu
 yvwK8/yyNkB7UrJtTjQHeO4aEOQ1ECXgR1GtsMaEZy6d5+AYDOmx075kl1TQRx90yiCHudVe/JN
 v3WKnt5XS1TOjOQFAWbzAOugnJiLHPWhve0pu9aKu8RkrsdsR+fmAczwJ/JxO/3i1VEgGKrnOOH
 PiNCvbnmCQDpl/+2OWztXLmdoR7GrCdfkMHeiX7U3sA==
X-Google-Smtp-Source: AGHT+IHniH/NUnmIXHvIfCbIVKyQKoKMZq7TUfHrGpHokaHsqUAGROPQqDwyqMBEYwttpZ1C27vfXg==
X-Received: by 2002:a5d:5849:0:b0:3a4:f6fe:524b with SMTP id
 ffacd0b85a97d-3a4f89a7b69mr919915f8f.20.1748592436649; 
 Fri, 30 May 2025 01:07:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:7f33:7a3a:e910:a0c4?
 ([2a01:e0a:3cb:7bb0:7f33:7a3a:e910:a0c4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fc1adesm10897275e9.33.2025.05.30.01.07.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 May 2025 01:07:14 -0700 (PDT)
Message-ID: <6df31094-e2a7-4b58-9717-6864964d72a8@linaro.org>
Date: Fri, 30 May 2025 10:07:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] net: lwip: move dns init to common function
To: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250529214910.984024-1-tharvey@gateworks.com>
 <20250529214910.984024-4-tharvey@gateworks.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250529214910.984024-4-tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8
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



On 5/29/25 23:49, Tim Harvey wrote:
> move the dns init including setting the dns servers from env vars to a
> common function as other commands that support hostname lookups will
> need this.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  include/net-lwip.h  |  1 +
>  net/lwip/dns.c      | 20 +-------------------
>  net/lwip/net-lwip.c | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+), 19 deletions(-)
> 
> diff --git a/include/net-lwip.h b/include/net-lwip.h
> index b762956e8fda..6b5eb1990fbf 100644
> --- a/include/net-lwip.h
> +++ b/include/net-lwip.h
> @@ -17,6 +17,7 @@ static inline int eth_is_on_demand_init(void)
>  
>  int eth_init_state_only(void); /* Set active state */
>  
> +int net_lwip_dns_init(void);
>  int net_lwip_eth_start(void);
>  struct netif *net_lwip_new_netif(struct udevice *udev);
>  struct netif *net_lwip_new_netif_noip(struct udevice *udev);
> diff --git a/net/lwip/dns.c b/net/lwip/dns.c
> index 19172ac959ac..ff1903f7191a 100644
> --- a/net/lwip/dns.c
> +++ b/net/lwip/dns.c
> @@ -44,12 +44,9 @@ static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
>  static int dns_loop(struct udevice *udev, const char *name, const char *var)
>  {
>  	struct dns_cb_arg dns_cb_arg = { };
> -	bool has_server = false;
>  	struct netif *netif;
>  	ip_addr_t ipaddr;
> -	ip_addr_t ns;
>  	ulong start;
> -	char *nsenv;
>  	int ret;
>  
>  	dns_cb_arg.var = var;
> @@ -58,22 +55,7 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
>  	if (!netif)
>  		return CMD_RET_FAILURE;
>  
> -	dns_init();
> -
> -	nsenv = env_get("dnsip");
> -	if (nsenv && ipaddr_aton(nsenv, &ns)) {
> -		dns_setserver(0, &ns);
> -		has_server = true;
> -	}
> -
> -	nsenv = env_get("dnsip2");
> -	if (nsenv && ipaddr_aton(nsenv, &ns)) {
> -		dns_setserver(1, &ns);
> -		has_server = true;
> -	}
> -
> -	if (!has_server) {
> -		log_err("No valid name server (dnsip/dnsip2)\n");
> +	if (net_lwip_dns_init()) {
>  		net_lwip_remove_netif(netif);
>  		return CMD_RET_FAILURE;
>  	}
> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> index e8d4cc542ed8..23dccfef8993 100644
> --- a/net/lwip/net-lwip.c
> +++ b/net/lwip/net-lwip.c
> @@ -7,6 +7,7 @@
>  #include <dm/uclass.h>
>  #include <hexdump.h>
>  #include <lwip/ip4_addr.h>
> +#include <lwip/dns.h>
>  #include <lwip/err.h>
>  #include <lwip/netif.h>
>  #include <lwip/pbuf.h>
> @@ -139,6 +140,35 @@ static int get_udev_ipv4_info(struct udevice *dev, ip4_addr_t *ip,
>  	return 0;
>  }
>  
> +/*
> + * Initialize DNS via env
> + */
> +int net_lwip_dns_init(void)
> +{
> +	bool has_server = false;
> +	ip_addr_t ns;
> +	char *nsenv;
> +
> +	nsenv = env_get("dnsip");
> +	if (nsenv && ipaddr_aton(nsenv, &ns)) {
> +		dns_setserver(0, &ns);
> +		has_server = true;
> +	}
> +
> +	nsenv = env_get("dnsip2");
> +	if (nsenv && ipaddr_aton(nsenv, &ns)) {
> +		dns_setserver(1, &ns);
> +		has_server = true;
> +	}
> +
> +	if (!has_server) {
> +		log_err("No valid name server (dnsip/dnsip2)\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Initialize the network stack if needed and start the current device if valid
>   */

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
