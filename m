Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865D8C5B549
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 08:07:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8BC282B34;
	Fri, 30 May 2025 10:07:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Uaxd2Ush";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94A528312C; Fri, 30 May 2025 10:07:00 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D2BD82A9E
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 10:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a4bdee0bf7so992492f8f.1
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 01:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748592418; x=1749197218; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vf9wse5kz7RzD/ol8ok8o0o4VtLw87Fot+IaVocnlB8=;
 b=Uaxd2UshTCucB2Mtg0IOWU9It15RGUwn8hcN0vBYQoh7rBdOs+E6R/H5PNweNUBKGb
 5vT4LH6tx8Z5IcrXPlxwOEk3Nlk1yjMFegIdGSsq8j7IzWGGIu8PlgUmEaDRVBEqgkca
 /uWUQ7r3asgVINNzJT++NiXZrjEoO8qZeXognMaIRfZ/VHN4vo0tAipoJc9zv9jvdBgT
 pvrodGRxQDuWTuXtnkTPYBI3oEp+/UmB9Cou+vflLInGQkRaDhVcEWb9K+Cx6gtgF2Et
 wFwlG76jpljHoQngPHvU9KDnPNiguxa7MqoyW5+puzmOS7uo16S9YlHrHsNbl9eZCyQ0
 gmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748592418; x=1749197218;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vf9wse5kz7RzD/ol8ok8o0o4VtLw87Fot+IaVocnlB8=;
 b=qDFVJalZ9pZ6iZH+HLy77ZqVInos+exZNfiqO0phkUhBFFry6KpGchC2RqCTFh7xNn
 kAnVCzRd9Og+40rCdVEuikZCY7iS8TuwFqBUCNiC/YMyHSDH3k/TE394NURydRZNJ5Kb
 xdx47+O2R5BfUCmijZz+u2L6XtorY7X6qQYwJ3xtV8GdlobS2WnEfYg5cnOR5VubvqPm
 iCi6eBZRLyzZh9tKzAp73ZM+ZXpeNCdkQaUaz84ioUsZCdVMKt0P8RpiRjiNw+YWIAN9
 jnZaycOWKmfFAitOWCQghNoZ3gIHznhdv8DDImW2EewCpzyoamUVtEHtuQg5hfFxtTZ9
 plqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVIFLlQnULDmBcOylZPl+C3gVSvaah5ibqZTOtpz5ofSuEimGhBWWw8BjSL0F3Wl/dX9hVClA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw76XyLB1R0UfY687xBgOo/UK6o34ZvDk//46jw9FOxjhXtvvF+
 2nDVfNOChgHUoyUgxmytRRPRWjfZo4/0TulWnLCSB7LFGTupOHCHBp5+VSS1yhKkNFsRdRo3DWR
 UfxVe
X-Gm-Gg: ASbGncv/VKkKdIkb7y/4xsCr7Xp9Mt9HKsvm3dHSt3ydXfT3H1ohTr7qokqJk4tEQHw
 r7EnnXgVGayINextpNO3ZVIK31CEl1CjzFKiFDHH4TdovR6XkVk8b8nGpATxsPnPOLaSH1DvrGe
 A8Gjo9URsQfFU5amhgl6e3E0K5tcjTCeHERMdiewANG2cgw+j+QEMW0b+5Fjfr70/6xjSo4L/bQ
 M3+Jo2aBxc9pFavOgsJAai2DudNbMTper+7xGj1O8u30juHfLqNQeTrcesRCE66huDPVGzQ8HXn
 FKVqN0ZNo3WDcHEicWBGR3DojRLrCHUBl9r6Y9V6Zx7/IXVLLYk1Tg8QEuiDfxzla2f/0ns0OqZ
 p1gLp3LrNmF32bEkWi+P6fxLyay7gQZA=
X-Google-Smtp-Source: AGHT+IF71mrJc4859zN1qN07AKEIyYq0trNGiEAUyqA7spFgZAZAev0DfvB2XInjt7x4McF74v/XfQ==
X-Received: by 2002:a5d:64c9:0:b0:3a4:e60b:7c63 with SMTP id
 ffacd0b85a97d-3a4f89e2a49mr957971f8f.42.1748592417958; 
 Fri, 30 May 2025 01:06:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:7f33:7a3a:e910:a0c4?
 ([2a01:e0a:3cb:7bb0:7f33:7a3a:e910:a0c4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00972f3sm4184409f8f.69.2025.05.30.01.06.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 May 2025 01:06:56 -0700 (PDT)
Message-ID: <6f445bd3-463b-4c9e-af07-17cba289b345@linaro.org>
Date: Fri, 30 May 2025 10:06:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] net: lwip: wget: initialize dns if a hostname is used
 in a URL
To: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250529214910.984024-1-tharvey@gateworks.com>
 <20250529214910.984024-5-tharvey@gateworks.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250529214910.984024-5-tharvey@gateworks.com>
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
> Initialize dns servers if a hostname (vs ipaddr) is used in a URL.
> Otherwise the wget will fail without displaying an error due to
> dns_gethostbyname failing silently when no DNS servers are set unless
> you have previously performed a 'dns <arg>' command.

Ha! I think I did not notice this issue because I always used DHCP,
which populates the DNS servers internally in the lwIP stack.
That sounds reasonable.

> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  net/lwip/wget.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index ea1113e18b11..76401991bde6 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -460,6 +460,10 @@ int wget_do_request(ulong dst_addr, char *uri)
>  	if (!netif)
>  		return -1;
>  
> +	/* if URL with hostname init dns */
> +	if (!ipaddr_aton(ctx.server_name, NULL) && net_lwip_dns_init())
> +		return CMD_RET_FAILURE;
> +
>  	memset(&conn, 0, sizeof(conn));
>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
>  	if (is_https) {

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
