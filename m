Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA2AD6204E
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 09:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1EDD8952D;
	Tue, 19 Nov 2024 10:29:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IV5FaD6V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD02C89531; Tue, 19 Nov 2024 10:29:23 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0EE0892E6
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 10:29:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5cecbddb574so808787a12.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 01:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732008561; x=1732613361; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4AaK3mSrlTAX27BW9usxmHm0Vsu3S2Dg+Nij9cbLstQ=;
 b=IV5FaD6V5PmhHf6odkoOAz3cA7aBWwCw1MeqjJtjwoYUrOR2lPI8Qed2HAjEFSENQg
 yRoLKp8094N3zxovmdmWZN6EBfZy21OM2pzcBoFhuuwwRj+fJelCKTWwUNt+Vm5AqrTD
 vskA554b3ry+qvmEx+Gn6FJ3X0i9we9XdhcVHe393JLS9C0YjJ/gGUtI5jqJpzwYm/Rm
 jQEzVFMOVRb2tdKJiS/YBxftpaJ4tiix6rWaJWBhbkZVJCxatCn12L/0SoSRSUJLa4kS
 FhStNOooVqQnflFb/THEdK7u+5CKB/U5teGT/J+TMZYtF4Ykh4NdbJZwNWoIlOV7nwcc
 1MUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732008561; x=1732613361;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4AaK3mSrlTAX27BW9usxmHm0Vsu3S2Dg+Nij9cbLstQ=;
 b=mgPLGSR590gMjbGPZTtskzf0fttEh0OpBl5tccO4PO/TrSOz2bFLwE+v1CdFd2uyw0
 9nyZ3mwxfmVt2lrrl0bJJUrOR60Vk3g7//Zaf1ZS8Ej5TEA8lecuijqQJPHsXBD4dSsE
 Qp7vR9iLZBoZ1KYoKbJ+Kx8Gye3HKbT4wCU6kVOfrxLHsHvX7EZguCNXOWWp9Omtyjss
 7us8gPnBBKYv800DLBOyRpRSNG5xjQUaeE4V//6yWVSD2chSiDB+K0nr3RdHMTgC2Jgp
 RsSpHBAHvbnukF+l5P1ARHCms+fSzIhSJZhqiJeVu63TpoqJc4G9OGpFWfvYGqVS7Gt+
 6lbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+mtCjN+cuMRmItkqreJBY/favQ9rnFQgIEZpfLOT3IYFuy2iR3u64d6Y8wdl3yt09i3eJmYY=@lists.denx.de
X-Gm-Message-State: AOJu0YxpuhMVrhEACVuORzCRIbgOENnIEBt0Xfi6anWEYTnbr5tCp+Gt
 5nNGDjVXUm/x2WSfumrn4jpchGe2TUTPczwyKXvo2BidhqAKX58Jo3f3t2VMSIE=
X-Google-Smtp-Source: AGHT+IHMVQCHW9r392mlpAA6xsrKAAy+jL5lMCIyMhWA4GFwD0fXPXi4L9zMzmm/Y/EL1BZKtDyW1g==
X-Received: by 2002:a05:6402:1e94:b0:5ce:af48:c2cc with SMTP id
 4fb4d7f45d1cf-5cf8fcdfb82mr12548440a12.27.1732008561077; 
 Tue, 19 Nov 2024 01:29:21 -0800 (PST)
Received: from [10.100.0.2] ([194.15.111.161])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf79bb53bbsm5549085a12.48.2024.11.19.01.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 01:29:20 -0800 (PST)
Message-ID: <1ba877d0-0a25-4647-b968-4a56b315d4a5@linaro.org>
Date: Tue, 19 Nov 2024 10:29:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] net: wget: let wget_with_dns work with dns
 disabled
To: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
References: <20241118210908.51196-1-adrianox@gmail.com>
 <20241118210908.51196-2-adrianox@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241118210908.51196-2-adrianox@gmail.com>
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



On 11/18/24 22:08, Adriano Cordova wrote:
> This was marked as TODO in the code:
> -Enable use of wget_with_dns even if CMD_DNS is disabled if

Then I believe the function should be renamed. _with_dns is misleading.

> the given uri has the ip address for the http server.
> -Check for port in the uri when transforming to legacy wget
> syntax inside wget_with_dns.
> -Move the check for CMD_DNS inside wget_with_dns.
> 
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
> 
> v3: 
>  Removed console output inside efi routine.
> 
> (no changes since v2)
>  net/wget.c | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/net/wget.c b/net/wget.c
> index 3bc2522cde..1166aa5aa6 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -530,12 +530,10 @@ void wget_start(void)
>  	wget_send(TCP_SYN, 0, 0, 0);
>  }
>  
> -#if (IS_ENABLED(CONFIG_CMD_DNS))
>  int wget_with_dns(ulong dst_addr, char *uri)
>  {
>  	int ret;
> -	char *s, *host_name, *file_name, *str_copy;
> -
> +	char *s, *host_name, *file_name, *str_copy, *port;
>  	/*
>  	 * Download file using wget.
>  	 *
> @@ -550,24 +548,33 @@ int wget_with_dns(ulong dst_addr, char *uri)
>  	s = str_copy + strlen("http://");
>  	host_name = strsep(&s, "/");
>  	if (!s) {
> -		log_err("Error: invalied uri, no file path\n");
>  		ret = -EINVAL;
>  		goto out;
>  	}
>  	file_name = s;
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

You should do something with the port (or reject URLs with a non-default port).

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
>  		ret = -EINVAL;
>  		goto out;
> +#endif
>  	}
>  
>  	strlcpy(net_boot_file_name, s, sizeof(net_boot_file_name));
> @@ -581,7 +588,6 @@ out:
>  
>  	return ret < 0 ? ret : 0;
>  }
> -#endif
>  
>  /**
>   * wget_validate_uri() - validate the uri for wget

Thanks,
-- 
Jerome
