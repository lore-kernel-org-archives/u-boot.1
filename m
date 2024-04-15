Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF49C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 11:46:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E3D387E83;
	Mon, 15 Apr 2024 13:46:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CELCw3zp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7005F87F1F; Mon, 15 Apr 2024 13:46:26 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6819987D5F
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 13:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-415515178ceso18357925e9.0
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 04:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713181584; x=1713786384; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8fHGISDwRPgUkmTxKX2Wes4bgkolLMOZv67ltyRaWQk=;
 b=CELCw3zpg+XaRQWIW+76rdE9HImwwhYT1/8TdKpFqgdapSdQTo2BXwIw0S6PADLVbY
 KQjqfp/bTZLatZ0n2R9H4lNTIB5JtS7nzzBJlcQGZ7KDM/lEi20osCYwwf2KY6SUxVCf
 1JhjLULSqtgKU5a03XwXsYODkTCYXeDEZwNZp/vO77lma0bJyNY1t0POH6Nfabm24fxb
 nWs1O/J9kwgMetjRCUfhLT18ruN7OYmPheVBubYaZ4rT0J/2ghpBdRWcp+yxd4eLb1dl
 wWh5IXYJ6oMM1gC16ugEpeyNbXW3NNnDaA9to1jugnKAOt+GPAkaJVOhf3DQG8fqNeBU
 A3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713181584; x=1713786384;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8fHGISDwRPgUkmTxKX2Wes4bgkolLMOZv67ltyRaWQk=;
 b=n+YkdV798z5PuUFJOg6L97wxcL0XVg29hyH8YdIZSaVzYslX9bfapFpSToWUkKqx3E
 lfqYNDjfF0f3la67PFBNjfgp+VvNQ0xT4Yma+/A2N/gWf0mfbWR8kA+kL0xhEnd6Pgjn
 dfaQlS17IAoh1d/YMIZg2AgK538U6UZ6YbKe+4xUsG18jDh7/lQFukw6dMy8hyCuKxfA
 5flg6SZXwbcsl2v+6btAepKQhSMRwOvnzEmJLGJhwPp7KjlZKh0d36hlzcL04kL7rA+f
 c6y/GqpGh/gq3H6pytF/3hjOA08pe0t+U67QgBPCpAetW42V6x/5i+iTAKU04UYS+5o1
 7VYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSMzbeheM+vxlDrP++73704fYoAbBAEJ7i9vSv7+XgE0DBfuZ2hzmzNTF2vW3LEc8gpzs27SxE1psYbx28zru3hrynkQ==
X-Gm-Message-State: AOJu0YyFosBYQHrpR2XOYbR/UQUAFlDDhR/G6eKNYd1hOvumVl+BQ2DO
 1UWVBrXeuMyoi8LfJPki8bos6BgrKs2NmfUfctZs2nFYmMcNkF4371HWK3kqafc=
X-Google-Smtp-Source: AGHT+IGg/kxRGAODgrgy3+g6evGWYwkM+nlSZ9i52JKWX6o89FMdpty5Gsc5Z+edH9P+z0NlBwbAMw==
X-Received: by 2002:a05:600c:5489:b0:418:af0:3b4a with SMTP id
 iv9-20020a05600c548900b004180af03b4amr6024111wmb.14.1713181583829; 
 Mon, 15 Apr 2024 04:46:23 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bd24-20020a05600c1f1800b00418673b3ca0sm2912972wmb.5.2024.04.15.04.46.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 04:46:23 -0700 (PDT)
Message-ID: <13b88782-4bf8-4800-8eb2-0617dd30083b@linaro.org>
Date: Mon, 15 Apr 2024 12:46:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] serial: msm_serial: set .clk_bit_rate in debug UART
Content-Language: en-US
To: Robert Marko <robert.marko@sartura.hr>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, sjg@chromium.org,
 bmeng.cn@gmail.com, marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de
References: <20240415105028.432404-1-robert.marko@sartura.hr>
 <20240415105028.432404-3-robert.marko@sartura.hr>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240415105028.432404-3-robert.marko@sartura.hr>
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



On 15/04/2024 11:49, Robert Marko wrote:
> Currently, .clk_bit_rate is not being set in init_serial_data for debug
> UART, but its then used uart_dm_init() and this breaks debug UART on
> IPQ40xx.
> 
> So, lets populate .clk_bit_rate for debug UART as well.
> IPQ40xx requires special value of 0xff, so set it if ARCH_IPQ40XX is
> selected, otherwise default to the same value that regular DM UART
> will use.

Ah, I have a patch lying around to configure this automatically, but
didn't get around to sending it. Could you give it a test on your IPQ
board if I send it your way?

Kind regards,
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  drivers/serial/serial_msm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
> index 8044d38518..80069f5cfb 100644
> --- a/drivers/serial/serial_msm.c
> +++ b/drivers/serial/serial_msm.c
> @@ -242,6 +242,11 @@ U_BOOT_DRIVER(serial_msm) = {
>  
>  static struct msm_serial_data init_serial_data = {
>  	.base = CONFIG_VAL(DEBUG_UART_BASE),
> +#ifdef CONFIG_ARCH_IPQ40XX
> +	.clk_bit_rate = 0xff,
> +#else
> +	.clk_bit_rate = UART_DM_CLK_RX_TX_BIT_RATE,
> +#endif
>  };
>  
>  #include <debug_uart.h>

-- 
// Caleb (they/them)
