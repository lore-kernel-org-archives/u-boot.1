Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2F3D69113
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 14:56:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED25E89D25;
	Thu, 28 Nov 2024 15:56:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z83sjNWe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7244E89D32; Thu, 28 Nov 2024 15:56:54 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E53E89D0B
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 15:56:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9a0ec0a94fso110353466b.1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 06:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732805811; x=1733410611; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4U1KVoqrbNt/2hqFWsHu8LKKlEhRf+TXWRpVWmkEFbc=;
 b=Z83sjNWeGIxQA2a2QxHRd4VA3Y2ZwwVpze8DFsn1PeOozfnV+NSk5IIpbXeWFzAXYz
 3A4svCtSjAvRZTzvMCUKe4ZXlSNdmmL6txBFr4Z5OJnaHpvr7y2gJxeeZVufnr1ZOEGB
 rJKr4TG0hsCDAZsrJo24f+T5zXFwaCCjP5stb3AaWoPD3C/N0OlCTAKG/MCJO6pbU7n5
 SacnPyjt5PsQ1DSj8ypKLyFLASBjtKHiPV3Z12Jgn3N9t0VKZ4ho38ehzxaKqK5x/xiG
 tFvK7vCZjF2Wba582w7SS/DhZs5Re6BPngnOTv2ry6EeZo6Ri5ZBpGMhqh5UauGABQHx
 CZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732805811; x=1733410611;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4U1KVoqrbNt/2hqFWsHu8LKKlEhRf+TXWRpVWmkEFbc=;
 b=Vj/zxlYNqs2j/8HVXRuivF2O65ZF8Bd0WBi317lO7TI+S8/732wltQguENv1xETY/U
 j4R9nhqmgXFsEpMLKtr29uNeAhHaW2dWCLxo44qwwXmkuFBHM+kG9ZYUcMrEU95adIPh
 Oq2WLG3ixPtWOaKTY5iPfi9W47eomF2nYE6i+0NBQC3H1APlJm0p+cC3XISJwzPNWL9w
 6TFhl4pnl/gmWqwl7KOeol4W6LieyuJZrJwxtmOYzqwDSLXDcjYTVgHmxzGgpFzwFEHJ
 k3bQLvmP90A+FL+YmP0Fl/Lcd8iems3/PrRCdu7CwYOFgItqVhGA2n1QDOMMFrLkdwmQ
 8OsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8NYA80jahRBZgHeS9xigBGofbnq/fC9itpnZy1ReSlJ+KSnrxqJd3tjR8+OsODrAvz6KEvuU=@lists.denx.de
X-Gm-Message-State: AOJu0Yzx6cRG1dzQj+9qUWU3PwtdhGmll8rInsPufFQxUC2QmC4uXsE5
 +aOCe0mnyovJr8SboCP0fqrBHOqOJbO2vSupD59Jr/itoPfoWku3YDRuN/lYC04=
X-Gm-Gg: ASbGncsa2WnGcrp2c56hrt1tLcuQyXyVlwogEyBcmVPmDymU3Hv3pgm4sgowzAZ2SCB
 t/mghEajC7FL1zRX9rZNohsvuwI+rotDpOAqX/2MmolHxcgc7MbJL9iqGn3xkair3r1Xrt1oHii
 qTaXO5KP+dhy6Ri7MXn0NxJ8zCrRQeicOZaRz051RRB7NjT1Z7S6kKR+f6zXR/7YgRRbZ5dc0RE
 wQulqgBIyJx4iFuhaJaDE2a56oS5qbq6V/Lj4j+HbLTKWqT0rZoviFm274tBV+ZCaaUAlV2TG9p
 3/7K8JRE8UrIt1TUd8yns/uyBxhIDA==
X-Google-Smtp-Source: AGHT+IES/7m80+xcvukLTh2L8c16MMm37IQxPMp32+ISnmsFDB33GRo6SF1WzP2oY2TMSIekEe8rrg==
X-Received: by 2002:a17:906:31d2:b0:aa5:47f8:b91c with SMTP id
 a640c23a62f3a-aa580f4e2a7mr601677566b.25.1732805811563; 
 Thu, 28 Nov 2024 06:56:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:869b:f8c3:dc94:123a?
 ([2a01:e0a:3cb:7bb0:869b:f8c3:dc94:123a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa599953de1sm74184066b.182.2024.11.28.06.56.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 06:56:51 -0800 (PST)
Message-ID: <20c29b19-f147-4dc6-8fae-5d20d06fe5df@linaro.org>
Date: Thu, 28 Nov 2024 15:56:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lwip: wget: process legacy url with strncpy
To: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, trini@konsulko.com
References: <20241128143642.590143-1-adrianox@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241128143642.590143-1-adrianox@gmail.com>
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



On 11/28/24 15:36, Adriano Cordova wrote:
>     Commit 356011f ("lwip: fix code style issues") changed two strncpy calls to
>     strlcpy calls in the function net/lwip/wget.c:parse_legacy_args, but this
>     breaks the correct parsing of a legacy url. strlcpy expects the size of the
>     destination buffer, not of the amount of bytes to be copied, and it will stop
>     when the buffer ends or when a null is found, but here we want to copy a
>     specific amount of bytes and there is no null at the end of that specific
>     amount of bytes. The change is reverted here. Optionally, all the calls to
>     strlcpy(,,n) could be changed to strlcpy(,,n+1).
>     Fixes: 356011f ("lwip: fix code style issues")
> 
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>  net/lwip/wget.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index 83ae8a6d15..af48d741a4 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -180,7 +180,7 @@ static int parse_legacy_arg(char *arg, char *nurl, size_t rem)
>  
>  	if (rem < n)
>  		return -1;
> -	strlcpy(p, server, n);
> +	strncpy(p, server, n);
>  	p += n;
>  	rem -= n;
>  	if (rem < 1)
> @@ -191,7 +191,7 @@ static int parse_legacy_arg(char *arg, char *nurl, size_t rem)
>  	n = strlen(path);
>  	if (rem < n)
>  		return -1;
> -	strlcpy(p, path, n);
> +	strncpy(p, path, n);
>  	p += n;
>  	rem -= n;
>  	if (rem < 1)

I already sent the same fix as [1].

[1] https://lists.denx.de/pipermail/u-boot/2024-November/573054.html

Thanks,

-- 
Jerome
