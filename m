Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2A0C2BD05
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 08:51:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE66787D07;
	Mon, 24 Jun 2024 10:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mv5mmPNf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B83DD87DEA; Mon, 24 Jun 2024 10:50:57 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE26887CFE
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 10:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42249a4f9e4so30648825e9.2
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 01:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719219055; x=1719823855; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MSGt6tT5aGf77bQwsewp2UyAIIQzZTrNXy/30CimzoI=;
 b=mv5mmPNfGZz3WkU/8lb6ag/Pz6s3vAGjRR25kO2PgxycU0xN8JHv5gfPVtFOWszBP+
 YIkZqRBR24R2+2ysq5Y9zzkxtCdzqXZQd/mtLkGcHvtZiwism5Vouw3bqnznIEGxNIfd
 yta2gSZoN16J0cXC0OwaGu+OrK5DzHSWcujiGPJ4SZ7sPwMXDE8v3jZRT0mbtDVvXPfJ
 PriiZMJLu7OUIMJG1F32L6p5ORw62B+FJcfXk8fCGg7TdM3YfF/tnqPVgoSKQPbfM36D
 xTNZb5Bfr0T3s0Lcw4HVm9D7Fn1JkS4+TF3yj2MCYa5UrCnlfak41e3GKk6D8QpzGGqc
 DU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719219055; x=1719823855;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MSGt6tT5aGf77bQwsewp2UyAIIQzZTrNXy/30CimzoI=;
 b=KH9EbFAmocbFepEkr5L45B1YD0bl3o0qi0dNULT+9tbbxlw94Yon4kPlocM1eAZ7e0
 KENr5MQ96eEk1cE2bcGqj9587MWNT6p8h8zxPkyocMGns9bU9o0a8FNdd3K7xyD8t8aJ
 d42bVh/vqukisjubjBLGUXL2ZAfAzJ2Hkbs397Rr/o3QOR6zqFTMjYRnXhf6ZptNb19j
 PlOXCTOsE1sAtjPlpW+vPzKspdC0kCUsrNeSVEBUQtIctSiyluuczGzLqh5hpM1k3cJw
 +pJYdH4GV46ymnhPtQDwXiBthQLXStjd/UZjrS1bCpoymeQu4J8d1yhR8xRBW5ARZowB
 Kknw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMXMXVoxV4lI+cvhx41CW0vTsyQJE/avvyT/Ir9EWumQ/xu9mL0ALUwQvf5dSk5prOT7lbUSLJpQVoXy+64UuZSzYLTA==
X-Gm-Message-State: AOJu0Yxmh3sM4Nnz0f4AOT2H+MtlmjE6mfguxw0w2nK6yoorzfFnTeyw
 5hTFCpFFGqfLs//cjTPJfdoqBQlSmyHs11Ruer7/hRG8/BXWXt1hRiNCzv3Sj/E=
X-Google-Smtp-Source: AGHT+IHFZgaKoFtrWfSSeVQPO/CLOlranhS9i5EaqDa16HHu+/0yBNSe5Eg20DCeqj9OYCh62114aQ==
X-Received: by 2002:a05:600c:6b19:b0:424:918c:3f5b with SMTP id
 5b1f17b1804b1-424918c6d91mr15135395e9.29.1719219055259; 
 Mon, 24 Jun 2024 01:50:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:4500:90e2:c2d5:54ab?
 ([2a01:e0a:3cb:7bb0:4500:90e2:c2d5:54ab])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42471e65fb7sm141147175e9.1.2024.06.24.01.50.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 01:50:55 -0700 (PDT)
Message-ID: <e197a0df-d152-4090-a1ec-348161fcc777@linaro.org>
Date: Mon, 24 Jun 2024 10:50:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/14] net-lwip: add wget command
To: Jon Humphreys <jhumphreysti@gmail.com>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Peter Robinson <pbrobinson@gmail.com>
References: <cover.1718638104.git.jerome.forissier@linaro.org>
 <ba84782cebf8a151ae7bd5d9abc4b313fb4334e8.1718638104.git.jerome.forissier@linaro.org>
 <86frt2vp2k.fsf@udb0321960.dhcp.ti.com>
 <86cyo6vovk.fsf@udb0321960.dhcp.ti.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <86cyo6vovk.fsf@udb0321960.dhcp.ti.com>
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



On 6/24/24 08:25, Jon Humphreys wrote:
> Subject: [PATCH] net-lwip: fixes off-by-one array access error with wget
> 
> When wget parses the url and extracts the host, it is off by one on the
> index to terminate the character array.
> 
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  net-lwip/wget.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net-lwip/wget.c b/net-lwip/wget.c
> index 069299bd469..63b19b99112 100644
> --- a/net-lwip/wget.c
> +++ b/net-lwip/wget.c
> @@ -51,7 +51,7 @@ static int parse_url(char *url, char *host, u16 *port, char **path)
>  		return -EINVAL;
>  
>  	memcpy(host, p, pp - p);
> -	host[pp - p + 1] = '\0';
> +	host[pp - p] = '\0';
>  
>  	if (*pp == ':') {
>  		/* Parse port number */

Hi Jon,

As I said previously I am ignoring this patch since I already have it in
my working tree. Thanks for reporting.

-- 
Jerome
