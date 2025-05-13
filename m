Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC802C3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 11:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0CBC8091A;
	Tue, 13 May 2025 13:35:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tcHlGvdt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D171080AE0; Tue, 13 May 2025 13:35:36 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75983800C1
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 13:35:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-441d1ed82dbso58707225e9.0
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 04:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747136134; x=1747740934; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SS5Jxe0/GlCbpDuhriWKS/quxnT02iwPt5liboe0+VE=;
 b=tcHlGvdtURbL6SCmcLuOAlk9PbaKYWtqmq3SET7xdU/qZ4+NotDoeT4ofyNvfFAvxh
 SMM+qVrQUciszMpS6Tcw9GbHavzuqbS1ZKK6MjIWQZ9/t2SUp9tEc1MY4I04yd8X7vl3
 LvOI578O3mQi3xdVWIT9UKNQETQeyptP8QgO5tlKtSaBHnQkGXotCVkoRKogZINFADJV
 mtFGIgfTNAkN+Wlx8yoSkZvamZUdori4QEcWnHM1t/siPKxzkU1XbbiYgYpwQLeSIB2Z
 jsZV7wfXyZCn5D399W4MNj3Y9uZNEFpcO5UoOW0DbSv/Lkvb5dOdVlbE8PP8cB69mfiw
 1COg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747136134; x=1747740934;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SS5Jxe0/GlCbpDuhriWKS/quxnT02iwPt5liboe0+VE=;
 b=DCbJ3WRbdVLnnJhDGoqYOddmmr76SaSyfupdXHJmsTF5gI/8/u18+LV2rbhxjVHpd0
 w7biI7IuS2cm0v44pKQUA0ubfvYTKs6mXxLEzbldSRrq2lrCmDbm5Z+SFQOMZ6ff/fF/
 8pDqC5O7GscM/woZ+CbX2F+zIhWnKfugcawCT028Jqp9oJXCiu5gfC1Lqh3rnM+xsSGe
 J93dC2euRZZHcShzlDAcBl1K51mLjgHwDC5ke26UL/C1+1Im2bXe+sL5eIPczsDjNDzA
 RUSa7LVEk43Rko/z3wH+CPE6/dm08UlQUReDzVRBhWaQAlcT5Z55IaExw0XTojA7snfY
 HoLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDlZwqyI3SxirJ0C2gM0zIbwWhjGY+QuMbDgtd8hItnn/Dj/v1TSsvjt8NhVcRNwoou6z9uDo=@lists.denx.de
X-Gm-Message-State: AOJu0YwOwVvLnWraj8MHM2/7moHl+qH/U0xk/a/4bdaaL6FwV/ywTGRx
 MFtmu6c2YoENaO3OjbX2L4yzOOCTqJbsnd5l+/ID9fpAXLy25nMf0WZWMXpz+8U=
X-Gm-Gg: ASbGncswneE4G9wk8Vr1VVSUvN5ogBFj6TVBOjmPRs6a3l69o0YGsoUatmbmy/7/VBD
 MEMA8DUV8Sq+dA/zEvhiUzZIBrq9kuwyQbnTWfola3h+HovGAGku/WIEGqM6R+0Q+dgmt5wu4Pd
 ZLwpx5VGXe1Q/JCSKndvUmF30oLf0ZtR1kfWtZoVqGVdCPrrRwnYsX+/6NcQnpa7rCpd/lBp42C
 FdjJGTE0I/no+J6JQ/1+M9mzdTxHLOs2yf70GDYGXc8Vrx3PJ8uj4kpK45STIXQkpGwac/Av1LE
 3yA2WP45w8IYQ9wGSU7CHQUDq49ctEDhRW5Q06oSd2ZIEN06HHN+ItiGSHsD/yCk
X-Google-Smtp-Source: AGHT+IFNzroVkux8cQTT8PB1un19LJnQDX6OspMCN9ggyJKUViL1JdpVQZ13A03ZndOq4OrshRudYw==
X-Received: by 2002:a05:600c:8708:b0:441:a715:664a with SMTP id
 5b1f17b1804b1-442d6dd9d8cmr125769165e9.20.1747136133902; 
 Tue, 13 May 2025 04:35:33 -0700 (PDT)
Received: from [192.168.7.94] ([212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57ddfc9sm15708292f8f.5.2025.05.13.04.35.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 04:35:33 -0700 (PDT)
Message-ID: <b323478f-bf9c-490b-9e28-0da114a4d2a4@linaro.org>
Date: Tue, 13 May 2025 13:35:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: tftp: time out if there is no reply from server
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 U-Boot mailing list <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250428092418.2606467-1-jerome.forissier@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250428092418.2606467-1-jerome.forissier@linaro.org>
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

Hi Heinrich,

On 4/28/25 11:24, Jerome Forissier wrote:
> When there is no reply from the TFTP server, do_tftpb() should
> eventually time out. Add a 10 second timer for that purpose.
> 
> Reported-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
> 
>  net/lwip/tftp.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Does this fix the stalling issue you mentioned in [1]?

[1] https://lists.denx.de/pipermail/u-boot/2025-April/587583.html

Thanks,
-- 
Jerome

> 
> diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
> index 4f9b2049187..4f88924e47e 100644
> --- a/net/lwip/tftp.c
> +++ b/net/lwip/tftp.c
> @@ -15,6 +15,8 @@
>  #include <time.h>
>  
>  #define PROGRESS_PRINT_STEP_BYTES (10 * 1024)
> +/* Max time to wait for first data packet from server */
> +#define NO_RSP_TIMEOUT_MS 10000
>  
>  enum done_state {
>  	NOT_DONE = 0,
> @@ -106,6 +108,17 @@ static const struct tftp_context tftp_context = {
>  	tftp_error
>  };
>  
> +static void no_response(void *arg)
> +{
> +	struct tftp_ctx *ctx = (struct tftp_ctx *)arg;
> +
> +	if (ctx->size)
> +		return;
> +
> +	printf("Timeout!\n");
> +	ctx->done = FAILURE;
> +}
> +
>  static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
>  		     ip_addr_t srvip, uint16_t srvport)
>  {
> @@ -150,6 +163,7 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
>  		return -1;
>  	}
>  
> +	sys_timeout(NO_RSP_TIMEOUT_MS, no_response, &ctx);
>  	while (!ctx.done) {
>  		net_lwip_rx(udev, netif);
>  		sys_check_timeouts();
> @@ -159,6 +173,7 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
>  			break;
>  		}
>  	}
> +	sys_untimeout(no_response, (void *)&ctx);
>  
>  	tftp_cleanup();
>  
