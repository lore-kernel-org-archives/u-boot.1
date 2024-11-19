Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD76D6204A
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 09:27:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59953892C6;
	Tue, 19 Nov 2024 10:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="HQMK4o8D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 449A889531; Tue, 19 Nov 2024 10:27:41 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C86188FB9
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 10:27:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F30903F182
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 09:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732008457;
 bh=3yg9gzopHCn/m5HTq7Vky/+GNFHBSHqZP2QP4ksTqbc=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=HQMK4o8D571maUZ93SxqHYEn9sY2ju65/2k7fASsKlz/3TP8YbgUbxkdKUUuuxtiS
 Iux82VD0bXuLDFp+cqPeLVLV7ZD4Jzn/1Gts7mCD9YryylLaHy3hMAEohzfZ+m3EOf
 YH3xAszCuIH1Od0Nfx+ivJgdOTmO2fDoaIgLw4Hin/eeSBWYYDURNKxsEhGxM1Zy/p
 xIAvyWOpO/j96rWkj02hmLO1vu7ZICC/Yz0CPmX+tGpsiigwRw+KuCVSs+QdGkakUg
 bOzx69zXFscjcuTAh4Yhym0Q976vXBeADGlO0tOhrhfD0ts+Pysh97tmO1jpMAHWQM
 pbD5sxwl8B3xQ==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-432d9b8503cso27146715e9.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 01:27:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732008456; x=1732613256;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3yg9gzopHCn/m5HTq7Vky/+GNFHBSHqZP2QP4ksTqbc=;
 b=maqCehugFGcq0UBWBXmXd4TGTKxQ9ozMyR7SMOiPG7clJ5kuShGdDVcLFqaGSoXBKN
 EEDmWupqXzB20dS7bJqMZOy/kvr0mf2xZqBbMtqXD08RYRUlG3PMJUEG+BN9WdO6zvb3
 MilZTgiGFsVhCKl3t9VGF45azAolPvZSJf9OxtQlJ+wOZQU/QgNPwh/BjB4LZg4y1ZlF
 dx9opcbpmPGUzVRxHNFt4lPMTlqYPWsOvhARkxIrRTX6okVK27PZ1vZlQu3cmJF2OSc4
 gBShdiu/ZEtIdzPGkVWJsSb+hoqNECs80HqFxMz1VtFP9QcLXADKLweaMvPOHYJjLH3f
 xGhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUXxEsZTdKftWp2r6scpmvaFrsPT9AIA9LaTFp6bEjkFThWAlN4ETIFwU9uvyfdHvf+t6a7Pg=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4qlyDzXHuiwZTrcsrKx1eIjZo70uOjD4F0yrs6c74wJc0glQ3
 E4rASccBhOD9woTMVPkzJSStOwN7q7bSRIrWFXItMgzyTdvEUAoQs37P3BLGKafa/RqqRbGZ7m6
 ph1Zh35aLZxtkQaOvLOiGYeRYqKjmRwE89vPAd8yyrUBIhZyByNpV+6BDCvKumb0mc2Y=
X-Received: by 2002:a7b:c45a:0:b0:42f:84ec:3e0 with SMTP id
 5b1f17b1804b1-432f57b58f4mr18454845e9.9.1732008456615; 
 Tue, 19 Nov 2024 01:27:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHErcGT/zn2MPZG36IyzGto7Kp+RO7ybYi1bU1YGnN2BvnbvzEd3Ob1jPllCfe/Dg8LIIUnQ==
X-Received: by 2002:a7b:c45a:0:b0:42f:84ec:3e0 with SMTP id
 5b1f17b1804b1-432f57b58f4mr18454665e9.9.1732008456182; 
 Tue, 19 Nov 2024 01:27:36 -0800 (PST)
Received: from [192.168.103.101]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da244cb6sm194491525e9.0.2024.11.19.01.27.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 01:27:35 -0800 (PST)
Message-ID: <9d784844-a0ae-4cba-809d-2dff06daa446@canonical.com>
Date: Tue, 19 Nov 2024 10:27:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] net: wget: let wget_with_dns work with dns
 disabled
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de
References: <20241118210908.51196-1-adrianox@gmail.com>
 <20241118210908.51196-2-adrianox@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20241118210908.51196-2-adrianox@gmail.com>
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
> This was marked as TODO in the code:
> -Enable use of wget_with_dns even if CMD_DNS is disabled if
> the given uri has the ip address for the http server.
> -Check for port in the uri when transforming to legacy wget
> syntax inside wget_with_dns.
> -Move the check for CMD_DNS inside wget_with_dns.
> 
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---

Changes in v4 are not described:

* drop console output
* avoid checking non-zero via '!= 0'.

> 
> v3:
>   Removed console output inside efi routine.
> 
> (no changes since v2)
>   net/wget.c | 36 +++++++++++++++++++++---------------
>   1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/net/wget.c b/net/wget.c
> index 3bc2522cde..1166aa5aa6 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -530,12 +530,10 @@ void wget_start(void)
>   	wget_send(TCP_SYN, 0, 0, 0);
>   }
>   
> -#if (IS_ENABLED(CONFIG_CMD_DNS))
>   int wget_with_dns(ulong dst_addr, char *uri)
>   {
>   	int ret;
> -	char *s, *host_name, *file_name, *str_copy;
> -
> +	char *s, *host_name, *file_name, *str_copy, *port;

nits:
Missing empty line.

>   	/*
>   	 * Download file using wget.
>   	 *
> @@ -550,24 +548,33 @@ int wget_with_dns(ulong dst_addr, char *uri)
>   	s = str_copy + strlen("http://");
>   	host_name = strsep(&s, "/");
>   	if (!s) {
> -		log_err("Error: invalied uri, no file path\n");
>   		ret = -EINVAL;
>   		goto out;
>   	}
>   	file_name = s;
>   
> -	/* TODO: If the given uri has ip address for the http server, skip dns */
> -	net_dns_resolve = host_name;
> -	net_dns_env_var = "httpserverip";
> -	if (net_loop(DNS) < 0) {
> -		log_err("Error: dns lookup of %s failed, check setup\n", net_dns_resolve);
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -	s = env_get("httpserverip");
> -	if (!s) {
> +	port = host_name;
> +	host_name = strsep(&port, ":");

RFC 1738 has:

login          = [ user [ ":" password ] "@" ] hostport
hostport       = host [ ":" port ]

So here variable port may point to the password. And host_name to the 
user name. We might check for '@' and bail out with an error code if it 
occurs.

You are determining the host port as a string, but I cannot see where 
you are ever using it.

In wget_send_stored() I see this line:

server_port = env_get_ulong("httpdstp", 10, SERVER_PORT) & 0xffff;

Maybe make server_port a static variable and set it here if variable 
port does not contain a number.

Best regards

Heinrich

> +
> +	if (string_to_ip(host_name).s_addr) {
> +		s = host_name;
> +	} else {
> +#if IS_ENABLED(CONFIG_CMD_DNS)
> +		net_dns_resolve = host_name;
> +		net_dns_env_var = "httpserverip";
> +		if (net_loop(DNS) < 0) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		s = env_get("httpserverip");
> +		if (!s) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +#else
>   		ret = -EINVAL;
>   		goto out;
> +#endif
>   	}
>   
>   	strlcpy(net_boot_file_name, s, sizeof(net_boot_file_name));
> @@ -581,7 +588,6 @@ out:
>   
>   	return ret < 0 ? ret : 0;
>   }
> -#endif
>   
>   /**
>    * wget_validate_uri() - validate the uri for wget

