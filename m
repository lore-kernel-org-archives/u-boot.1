Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82ECBD43341
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 11:21:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BA4D89177;
	Thu,  7 Nov 2024 12:20:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BEex3b8f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D0EF8920B; Thu,  7 Nov 2024 12:20:57 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EF3088FF6
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 12:20:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d3ecad390so1133466f8f.1
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 03:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730978454; x=1731583254; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i5av/cjwHs4odA/m0p8YNr4Znl4Hlqm6z1gEEdgbRXQ=;
 b=BEex3b8fgA/7jWWBxIBF7nm7ZqQBwcClH/c5HLhKstifmztdVhSRAlPR3D3947kyQ7
 2G8Wtw6r9cpdWXo/VwB3JdbdtKiWCSryBPyHsFItICQtGW7NIgVP4wOYSZW0F5cIy6Az
 IEOkHI5JmSlQk/bwDDgq9NwdwOyEOx6UwFwUiR/8ZGcKTFnRPWLUy4T4wL6JGHjLTnCy
 cOlYeY5yYKqnt6xsq7QSgBVWyoVJ1bbjqJJHYD7xTxFTsgbkcEh29x1w4RYAIWBHaBVt
 GLa17iqYbN8ousfg7HaWWxUFQAmqk/RC8CIHJSRf67k+zZF1gXlHv43+9M82DCuhjFfU
 gpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730978454; x=1731583254;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i5av/cjwHs4odA/m0p8YNr4Znl4Hlqm6z1gEEdgbRXQ=;
 b=mXhqjdSQXWTX1OISkpmaxsJE5pR84axVujsp919sDs+IlC43iBewnoa49/Z5HHcsKx
 6VERqt2LBXbvfQE0Z86S/TLe/TJ6acXm4389gWmhAIjRq7+prX1S00o5Pf+x69uakjjh
 d2UcATFFGmb5FPWdPa3G9fZqLLib8S7HEwfrC/SLAiJkKnYrLCSnq8k8JAJxvYsS0oU1
 oFCRJzij6GryEDxbvXdJWA3DAW+DH62VQ+gM3cEUAmDEFdh9kQ2EcTbsCcCOwQ2satOF
 YTQHtTdRhEZm42hxIE9zE+14N/rWYJPywmyZEsrCafNxIaKruNbq4PsnD+a5i6sVH47o
 wXHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyQy+Sn344ZQlyC/4DVsUNANy8iww23+3ekq2LBYeH0KGQvwottr6+G9QRNy2L6d6adl8695w=@lists.denx.de
X-Gm-Message-State: AOJu0YxeH7cG7BuOLxh+4pZV8o8xkcQWAmZikCZFnHv2bU3AUsZhZzkZ
 4ZAwh+M2Y9Qcz1UbnGaMp/PBriS3vl0Q1/9xQB3GGkQwCx9BTMP7JoijQTcNnBw=
X-Google-Smtp-Source: AGHT+IEq2uPbFuHU1Imj/vUzwCs9Yxh31ymMEdlURPnKynyVpGhlXqGicmJP/YfITpQcW5wcLCFuLQ==
X-Received: by 2002:a05:6000:1a8e:b0:378:8b56:4665 with SMTP id
 ffacd0b85a97d-381ef743de0mr885061f8f.24.1730978454414; 
 Thu, 07 Nov 2024 03:20:54 -0800 (PST)
Received: from [172.16.25.132] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed99a0efsm1451838f8f.58.2024.11.07.03.20.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 03:20:54 -0800 (PST)
Message-ID: <377bc757-50b2-4193-8506-729f26e6b665@linaro.org>
Date: Thu, 7 Nov 2024 11:20:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] net: Kconfig: add CONFIG_WGET symbol
To: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, xypron.glpk@gmx.de
References: <20241106130255.211041-1-adrianox@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241106130255.211041-1-adrianox@gmail.com>
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

On 11/6/24 13:02, Adriano Cordova wrote:
> Let net/wget.c and net/lwip/wget.c depend on CONFIG_WGET, and
> cmd/wget.c depend on CONFIG_CMD_WGET. This way, the wget code
> can be used regardless of whether the wget command is available.
> 
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>  cmd/Kconfig       | 5 +----
>  net/Kconfig       | 9 +++++++++
>  net/Makefile      | 2 +-
>  net/lwip/Makefile | 2 +-
>  4 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 636833646f..8f3ad94089 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2115,11 +2115,8 @@ config CMD_TFTPBOOT
>  
>  config CMD_WGET
>  	bool "wget"
> -	depends on CMD_NET
>  	default y if SANDBOX
> -	select PROT_TCP if NET
> -	select PROT_TCP_LWIP if NET_LWIP
> -	select PROT_DNS_LWIP if NET_LWIP
> +	select WGET
>  	help
>  	  wget is a simple command to download kernel, or other files,
>  	  from a http server over TCP.
> diff --git a/net/Kconfig b/net/Kconfig
> index 76ab7d91ee..b4bb68dd61 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -244,6 +244,15 @@ config NET_RANDOM_ETHADDR
>  	  generated. It will be saved to the appropriate environment variable,
>  	  too.
>  
> +config WGET
> +	bool "Enable wget"
> +	select PROT_TCP if NET
> +	select PROT_TCP_LWIP if NET_LWIP
> +	select PROT_DNS_LWIP if NET_LWIP
> +	help
> +	  Selecting this will enable wget, an interface to send HTTP requests
> +	  via the network stack.
> +
>  config TFTP_BLOCKSIZE
>  	int "TFTP block size"
>  	default 1468
> diff --git a/net/Makefile b/net/Makefile
> index 209377aeb2..7c917b318c 100644
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -29,7 +29,7 @@ obj-$(CONFIG_$(PHASE_)TCP_FUNCTION_FASTBOOT)  += fastboot_tcp.o
>  obj-$(CONFIG_CMD_WOL)  += wol.o
>  obj-$(CONFIG_PROT_UDP) += udp.o
>  obj-$(CONFIG_PROT_TCP) += tcp.o
> -obj-$(CONFIG_CMD_WGET) += wget.o
> +obj-$(CONFIG_WGET) += wget.o
>  
>  # Disable this warning as it is triggered by:
>  # sprintf(buf, index ? "foo%d" : "foo", index)
> diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> index f2558f8763..79dd6b3fb5 100644
> --- a/net/lwip/Makefile
> +++ b/net/lwip/Makefile
> @@ -5,4 +5,4 @@ obj-$(CONFIG_CMD_DHCP) += dhcp.o
>  obj-$(CONFIG_CMD_DNS) += dns.o
>  obj-$(CONFIG_CMD_PING) += ping.o
>  obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
> -obj-$(CONFIG_CMD_WGET) += wget.o
> +obj-$(CONFIG_WGET) += wget.o

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
