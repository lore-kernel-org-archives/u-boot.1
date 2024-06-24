Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9EFC2BD05
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 08:53:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FB3D87F3B;
	Mon, 24 Jun 2024 10:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y5treJN7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BC9D88327; Mon, 24 Jun 2024 10:53:02 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DC0187F3B
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 10:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42249a4f9e4so30666685e9.2
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 01:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719219180; x=1719823980; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+wK98rWoOVKRlmtDVYJgZ9j9Q3kCjf38C5u8HTfJk4I=;
 b=Y5treJN7niAfjJ9QeD5nbf00q7qcNxWQEc4YAcUXN/vcO4anSLfwKyAvIQEUUO1CpJ
 sBBxMVbd+5YNfifmctkGW0ajeROkxY9rj6GyrcNPKGHeZP014cPzX6HfTF6Cql7TZAYI
 fpFk9rXcn6Ufl0DyPjwIDsBSyyWr3Y4MxnwOM7/1REd1toToumXOr/rTvpvPRl/ETAks
 u9byUMas2DnHajbPyThkUnudYIQlOWfpx7gES56kqOr7vbWpaTcCvxs9gwtmc2o9L/Zj
 kNONeQtJGNcEqoYFc1xOKy7laXeR+RjDpjI4h1ld5xYTIOfH+SQGVef9rjO2FrzlIxbL
 9ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719219180; x=1719823980;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+wK98rWoOVKRlmtDVYJgZ9j9Q3kCjf38C5u8HTfJk4I=;
 b=xHiC4dM5dH3vFHQTlTARbAu7/MbfQIU1CltZoUtAWwwpAHFgDgJ4w72Kw6pIiFbaV3
 42mxkVgcNKwuCvG7H2N1i1CLQpgjDTm1Fjy2GVHE8HJ1tFEuw+JFm+iVd/7yv5eQH+XB
 G1X3jLALH8SL9p5mOhD4RA3e9AMNQ8KZyUARvDPz56HFVLPunKKnvW+ZuVtPTdZ+GjKw
 tfRz6F0+j33Fy3RVjb9+bz/A/z6uMO239D7Zs9EfNoOi7/vGyaw9iAljw1ahhz/pxUY9
 ukQVDAdcc0YdMI836Yo1DyjO8rH4uCxSFbGnxIsq/ZGwIo6wZWEThyvtqe0bqC1UysTM
 dNyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJWs05aGE/bGhjfBzELbmb7Khr/DLs4zPJ2w/cVL3EAo+peyB52MTEpvOcDdCqnQbnfl9gw5zWsetUbTI3aweLjhjbKw==
X-Gm-Message-State: AOJu0Yydqvo+uh1XHf6P5ps3scCQVlewP+SqwPeN+MzzUQU8xx5bHFiw
 Ji+1RYCM8fY0L08eB3087IAan2cbZwxV2nOtI/8KYblBKFhcl1QeXdAgM8yUiBk=
X-Google-Smtp-Source: AGHT+IGlHZ3TuY2Pv33nRCop5mt0uwzLVlehW1c1CDj5ETgpUJhz+fDDfPYc80QF4o0P8KUNPsVs7w==
X-Received: by 2002:a05:600c:49a9:b0:421:8f16:16d5 with SMTP id
 5b1f17b1804b1-4248cc66687mr27937275e9.33.1719219179812; 
 Mon, 24 Jun 2024 01:52:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:4500:90e2:c2d5:54ab?
 ([2a01:e0a:3cb:7bb0:4500:90e2:c2d5:54ab])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d208b0esm164997685e9.38.2024.06.24.01.52.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 01:52:59 -0700 (PDT)
Message-ID: <f0413089-270f-4f2d-94ba-5fe41a65afe6@linaro.org>
Date: Mon, 24 Jun 2024 10:52:58 +0200
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
 <86a5javou8.fsf@udb0321960.dhcp.ti.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <86a5javou8.fsf@udb0321960.dhcp.ti.com>
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



On 6/24/24 08:26, Jon Humphreys wrote:
> Subject: [PATCH] net-lwip: Add message if not using http:// for wget
> 
> U-Boot's wget only supports http://, so give the user a clue if they don't
> use it.
> 
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  net-lwip/wget.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net-lwip/wget.c b/net-lwip/wget.c
> index 63b19b99112..6b9c953ef51 100644
> --- a/net-lwip/wget.c
> +++ b/net-lwip/wget.c
> @@ -35,8 +35,10 @@ static int parse_url(char *url, char *host, u16 *port, char **path)
>  	long lport;
>  
>  	p = strstr(url, "http://");
> -	if (!p)
> +	if (!p) {
> +		log_err("only http:// is supported\n");
>  		return -EINVAL;
> +	}
>  
>  	p += strlen("http://");
>  

I am folding that into "net-lwip: add wget command" if you don't mind.
Thanks!

-- 
Jerome
