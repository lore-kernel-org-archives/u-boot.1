Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4CFC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 20:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B54BB82E37;
	Mon, 14 Jul 2025 22:33:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E/D10hMt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F17882E52; Mon, 14 Jul 2025 22:33:46 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62E6E82CEA
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 22:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ae36e88a5daso947904066b.1
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 13:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752525224; x=1753130024; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YIr7nSApctQmtkcX+Oe2HFZaJeNvMgrtEdkDk2XeIpw=;
 b=E/D10hMtX11R3ng1/29Bt6v81JZK2SPdECeb2geiDzh1/tT/WfsadPFEdy5ZqGqsRe
 0WFs81JXEc46fBLlkR44PlSYD1vAKQ6qutMGMM778S37OGgi+/o8zzmnEXwFKd+BOH13
 nrUmh887GxwG2kORzEqAiN/cuPuK4QjU0KAgc9AUjGZwIqlYjZ70ph1VEH8rFti4E7Kp
 abn3vVGjaC010RgbrNJJUt2Af4fSU2xS5URMM8SEFrjmjlScceco1uwGqrHK0Pg7zrZh
 vH8i9fyC8j2GxbCmkjelhcPTOyGL/WUT12c1wmtDSb+8vQq9y7Ln8nsyvZZoFqpJvbBg
 3vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752525224; x=1753130024;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YIr7nSApctQmtkcX+Oe2HFZaJeNvMgrtEdkDk2XeIpw=;
 b=ab/gOu9PStCDfpaABDhgHLjP9hpU2JR2Q6kmoUjfbWCiaN+48YDDXu7eZtkgY6LUYJ
 mmWaTSkpyJCbHgtVff88SETj8HpTMDTlM9fjcIwDl63yK9565bzAU6Ld6tqbkkf5aTwd
 1ItvYWo4BqerGfvrfB5qZDVX0V2p4bn5v+Qy0u1PR2ilpAmTwP/9R0jzIkK66aTS07kL
 bVSCYfQ037+bwYSvYhDixW0r2TCBMlBgM4lcy5GXKiVRgcUP4aG5xLgsaD/iq57oKIKL
 NFAaPxgPSB0EFNSK+LhT+qSuoYwHj0msv7XmIkr7Vq8ZmsV17sEWQqMuPhEIJkdCel7p
 Y/ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqMKH/78ddnolYYjfTpWyos60ac9hPyXm9GhMhRcuo4BFanp/HJKd+vLESFKeu8VDl7aI9+k0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2NXZGKHCtGU/OLIgUgoTrdAG5B9JcyqkAVow84ivf+L+bWIRm
 AJzxNpgBVgqOYuKBiwgtVZv4BKriT5qfOabcLkas6iKZQIjmsgWS9WwEX+R4Suqgw8w=
X-Gm-Gg: ASbGnctn+RclkCkalzV6UcuaxarKnYKo8E4KRISCM4B9zZ3XkIQPRcL23uraxp0hIW+
 F1OIGbOgLalpZPAL+xhMXb1ZWn3y5/pNxOHFPWlqC/xY/qu9ek+IWp66mwRWAHrvzIDjHrQCE3D
 EuTGzE6b9acohOaXsXlITEbFHBItoA0RWzAnh+4EYbB7XZZUSUn+77lBUQS7KXXCC+ZkI27jHLi
 ZgrxePUsS6n3KrPLePgMKeolAdnK+I4lnsE0r1YBFccxOxCfYdMVBfF/Tq5J4VKQlOJe2b5f7CT
 Il1fsfh3jDGAMyQATvlLF2E24pNRQ/2AF0Os8dx8SyopE3bv+LRHu7SQOmpBV8WJL7SOTP3Ffte
 rZMAilspCAQH+O2rGtHBJOyyJac+a9Q==
X-Google-Smtp-Source: AGHT+IFNQ8r/oymYBKqhOSm+RoSsI0FRZw62Fg71OGqgGYZWcyZrzy52mil8YLJpun/qRGDj8yzLOQ==
X-Received: by 2002:a17:907:60cb:b0:ae0:685b:5e9f with SMTP id
 a640c23a62f3a-ae6fbe14a42mr1544648366b.3.1752525223831; 
 Mon, 14 Jul 2025 13:33:43 -0700 (PDT)
Received: from [192.168.0.33] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e7eec2b1sm889287766b.68.2025.07.14.13.33.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 13:33:43 -0700 (PDT)
Message-ID: <0c6dc75a-1252-4236-a322-61def9b17775@linaro.org>
Date: Mon, 14 Jul 2025 23:33:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: atmel_qspi: fix race condition in transfer
 completion check
To: Ramin Moussavi <lordrasmus@gmail.com>, u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Alexander Dahl <ada@thorsis.com>
References: <20250713160826.108821-1-lordrasmus@gmail.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250713160826.108821-1-lordrasmus@gmail.com>
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

Hello Ramin,

Thank you for your patch.

Can you please change the subject to have "spi: atmel_qspi: ..."

On 7/13/25 19:08, Ramin Moussavi wrote:
> In atmel_qspi_transfer(), the status register is polled with:
> 
>   imr = QSPI_SR_INSTRE | QSPI_SR_CSR;
>   return readl_poll_timeout(aq->regs + QSPI_SR, sr,
>                             (sr & imr) == imr,
>                             ATMEL_QSPI_TIMEOUT);
> 
> However, this is racy: QSPI_SR_INSTRE can be set before QSPI_SR_CSR,
> and will then be cleared by the read. If that happens, the condition
> "(sr & imr) == imr" can never be true, and the function times out.
> 
> This race condition is avoided in at91bootstrap by accumulating the
> status bits across reads until both bits have been observed:
> 
>   /* Poll INSTruction End and Chip Select Rise flags. */
>   imr = (QSPI_SR_INSTRE | QSPI_SR_CSR);
>   sr = 0;
>   do {
>     udelay(1);
>     sr |= qspi_readl(qspi, QSPI_SR) & imr;
>   } while ((--timeout) && (sr != imr));
> 
> Update U-Boot's atmel_qspi_transfer() to use the same pattern,
> ensuring that both flags are observed even if they are not set
> simultaneously.
> 
> Signed-off-by: Ramin Seyed-Mousavi <lordrasmus@gmail.com>
> ---
>  drivers/spi/atmel-quadspi.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index 8aa7a83aef4..fba32876f8f 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -616,6 +616,8 @@ static int atmel_qspi_transfer(struct atmel_qspi *aq,
>  			       const struct spi_mem_op *op, u32 offset)
>  {
>  	u32 sr, imr;
> +	uint32_t val = 0;
> +	unsigned long timeout;
>  
>  	/* Skip to the final steps if there is no data */
>  	if (op->data.nbytes) {
> @@ -636,8 +638,19 @@ static int atmel_qspi_transfer(struct atmel_qspi *aq,
>  
>  	/* Poll INSTruction End and Chip Select Rise flags. */
>  	imr = QSPI_SR_INSTRE | QSPI_SR_CSR;
> -	return readl_poll_timeout(aq->regs + QSPI_SR, sr, (sr & imr) == imr,
> -				  ATMEL_QSPI_TIMEOUT);
> +
> +	timeout = timer_get_us() + ATMEL_QSPI_TIMEOUT;
> +	while(1){

There is a missing space, can you please run checkpatch tool and fix the
warnings given ?

> +		val |= readl( aq->regs + QSPI_SR ) & imr;
> +		if( ( val & imr ) == imr ){

Remove unnecessary brackets please, also spacing is odd

> +			return 0;
> +		}
> +
> +		if ( time_after(timer_get_us(), timeout)) {
Same here
> +			return -ETIMEDOUT;
> +		}
> +	}
> +
>  }
>  
>  static int atmel_qspi_sama7g5_set_cfg(struct atmel_qspi *aq,


Eugen
