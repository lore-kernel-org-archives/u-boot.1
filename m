Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E67C83F1D
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 15:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C8E6834B4;
	Thu, 10 Jul 2025 17:31:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n1hR4BAc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6C7283653; Thu, 10 Jul 2025 17:31:34 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2CE483423
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 17:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ae0b6532345so400619666b.1
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 08:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752161491; x=1752766291; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lx4dd4KC0haDZTNzAkepq6/UwDWJDZB/Ha1vyLGUMk8=;
 b=n1hR4BAck2RQJf87dZQEq50ZWqR5rPt8yUWLJylAoj5op7Gu7BTW+LQQpmUisRWIKv
 72OHOm9sokAhBmhz7LRxM31qj4DKpK7OIOUPTgLFVjiQSJwCgPmQWCx3KI28RPvwv5Xp
 +P+WhtTXb3V+KNxkh6Q7TkKD0TZag1x+b6Mq3ZQs8P864RV0jHUDxiEyV7Fum2Ck0UQs
 kmSepYnAT7KTuDK//db3vtZumh+cZnKY7tB1VKvd523FlRk+Ly+C43IZQIlKxnKyWP/w
 AqsK4yqi19AV7XFEKC7N3xiXsT+Hf1DogzIkraGcJTt7R3E+T3MCLJGAqNqZ7M+cktbR
 dgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752161491; x=1752766291;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lx4dd4KC0haDZTNzAkepq6/UwDWJDZB/Ha1vyLGUMk8=;
 b=HrztAIcFyrpms9pRvGPGL4ZKJ4AmkT+k7xTIDRafnbrilKiLWv6a7OpWcPTeoHQM96
 FzXy7rOuMZ0vlywpZ7BzCSdfhTMMcPIUf+VvvmApmqvO7QtveslbjlMte4xyZMGTd/LX
 7kpKBRRbak4g92ovjEsdehPRrdooWTi6RUIAT7w8eaZtk3SrOw/uEo6kAoVrKhqJlCt9
 VGsUUBs/bCk+7zfkoHrUuxYZ75fvLN8HuRzUiTTthlqrAxaoUemMa9m//7M0WzliJ8ov
 9rebVk4wmcZYSZzH3M4HUuRSm5uS44wWqP+UftUSfOpzR/i7dAN0QfH5Y1UaSI6Th3xi
 mtTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUckS/+AGwRHo80O4SUbPKVmuhSRD34CtAfP29lgaOwrxXgk0E/HvwiIugBdZBpx+5xinlL3k=@lists.denx.de
X-Gm-Message-State: AOJu0Yzu4BCbojkep74hQykB4X5KgrghzMu+yAmNVTssaB+d0rn8nvF9
 cEX/+7XAkT80gyKZdSSTAObkofRUeGXLgtVjoqNTON4A/GtAqtwFYj+fmAYQwsiOqXw=
X-Gm-Gg: ASbGncs1dwE06p9uVQVPCoQESQNZtEGXwZvoFQz2FoSBeSGj8ydKYj6YPjwlEsu1NZR
 aVI+lckZ9iz+L3rpPmyqVkrBrP0Rxp2Aepiw/hEZ6jbqv0q7G4MBZGo7ZOpiPhPEvsTRVzoCXcF
 kfnua0EJs5oTJhPo0nj5PsmVohNQmrRRyTz0sa2yAYONyulv7oD9RcNO2WKjZ95baMaLl1DVANu
 ZjvTpHmLUW/iYQ0fsYNx0S7z1245aWEW7vX4QjGxXTKly2bRM95NOrqaqvnCf5nZW3s2FZm3Upy
 GPv0mOqTER23+8XnScuoyQW22k58OWLMW9Dzu9WyRCFk2NjXWEI6u48hsb16BZzvh6DXuSjGZkK
 tq4tSHEfNqSXYIhZynjA/ul5g4ucOINuoEgrKVtVWAFi7VfXn5w==
X-Google-Smtp-Source: AGHT+IEvki2OIU52Q65BlyZ5Gm+buzP6EUIejuNNv4mFjunELh4hYujT4B1ML3z34UR3qfDMuuePuA==
X-Received: by 2002:a17:906:6a0e:b0:ad8:959c:c567 with SMTP id
 a640c23a62f3a-ae6e23472b3mr458107766b.10.1752161491103; 
 Thu, 10 Jul 2025 08:31:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:157f:442:48ff:45a9?
 ([2a01:e0a:3cb:7bb0:157f:442:48ff:45a9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e7e91dd3sm149429066b.28.2025.07.10.08.31.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 08:31:30 -0700 (PDT)
Message-ID: <ab70a1a4-4939-4d10-bc94-31db9f86804c@linaro.org>
Date: Thu, 10 Jul 2025 17:31:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: remove eth_init from net_init as it is called
 later
To: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250710150934.3833907-1-tharvey@gateworks.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250710150934.3833907-1-tharvey@gateworks.com>
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



On 7/10/25 17:09, Tim Harvey wrote:
> The call to eth_init within net_init causes the network interface to
> start, stop, start again which can cause issues with certain network
> device drivers. Remove it to make it behave like the legacy network
> path.
> 
> Fixes: 5666865decb8 ("net: lwip: fix initialization sequence before a command")
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  net/lwip/net-lwip.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> index 3918d57d7e58..d53faa39ba11 100644
> --- a/net/lwip/net-lwip.c
> +++ b/net/lwip/net-lwip.c
> @@ -285,7 +285,6 @@ int net_init(void)
>  
>  	if (!init_done) {
>  		eth_init_rings();
> -		eth_init();
>  		lwip_init();
>  		init_done = true;
>  	}

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
