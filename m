Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DECC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 12:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBD4C87D0A;
	Mon, 11 Mar 2024 13:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EQ7yw5rw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A927087CBA; Mon, 11 Mar 2024 13:30:14 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DE7887D0A
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 13:30:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33e7ae72312so2457440f8f.1
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 05:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710160211; x=1710765011; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZveiGHpBhaRFxT/LzekPs27+ks8f65R6xFrk03Jkk30=;
 b=EQ7yw5rwDpZNTXh4VKmcuB3WzLeprtkK23rJfY7zu82u+sMQnm77re39p+/YKe9K6Q
 wps+Mv4dPkZ6M/fTuTSOyJqazf2ve2gBhIzz4YPpdVv63RwmL84Mzcqlf9PYbBu8QhiI
 EShIEMI3CE1BfxUU+/qpZiS4Du8ifXRa5bypwYTJf8gYmYuEP8Pc7hMjUY/rdnM+XfM7
 QN1C0FTf2VvShs/vSFhDv5YIEuc+T+Apt9hrBMPGHdxWMaxb4ZB/xqzA7/4dXR7tkab9
 FzLpEvaVJpWSB8+vJ6Eq8Bjz7B1uWFCLTov6+9aikZh+Xp92SeGrI/e05M1j0r6rOuhX
 dJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710160211; x=1710765011;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZveiGHpBhaRFxT/LzekPs27+ks8f65R6xFrk03Jkk30=;
 b=XULqFJoD3DMLa/2d+atadjIlQIVy0Ng3ElpF82zXQXqo1JLCY/YuLrfRpDZbYDJ+6T
 /7ohWND6VnsW9nDCqyUfbBqQM7dTtHMZprlylpH2Lc2a2Zz6YkG4WBAjJ2TYdyfgPW4c
 XAn2Iq8p2JBdqJMbgWUV1MBSkgsvGh23SwKy0EmWtMDKsrHHoftBFcO9k0vPYEPPImPP
 gVaHuSZLiUFAni8Q/mH/86lzF8J1lO9tfylnOx35/UCHC5z0OwHrDGIvYphz2ZdV4jRH
 HSf/bBwEGQkpauPjSMRGBqhskoo9znbNMfadey+ucoIZlj3/uQhJ01wDPj5KpRDfF32Q
 W/SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJlNOBXlqeZ6dgzju4B8LssTyUx+NWLWYNghXj5a+70ocxrXXTobNW/E/GuI/LHHY3oXlHk1ucrzMiJm8iY29wYXBNbw==
X-Gm-Message-State: AOJu0YxL+SkT4EMmplsNViZb1dfNYi40EX/pU/v/vDEojR/llymZ+M47
 myfXwBgaRuzl7H7KVIiyTfY3ehgO0kBPaov6SAS8xie8yoK0LvhZWoAdRZEYf8Y=
X-Google-Smtp-Source: AGHT+IGrMWdZWkIQoh3H124UjQ95ljX88cioiCveczkSDMdSd4Z9nbkmfVk/9kAxCWGTErRAikTlOQ==
X-Received: by 2002:a5d:6882:0:b0:33d:6301:91c5 with SMTP id
 h2-20020a5d6882000000b0033d630191c5mr4012783wru.3.1710160210812; 
 Mon, 11 Mar 2024 05:30:10 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a5d58d0000000b0033b87c2725csm6319712wrf.104.2024.03.11.05.30.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 05:30:10 -0700 (PDT)
Message-ID: <f33c26c6-0915-44e5-92b8-ee41b537cd65@linaro.org>
Date: Mon, 11 Mar 2024 12:30:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] serial_msm: Enable RS232 flow control
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org, stephan@gerhold.net
References: <20240311111027.44577-1-sumit.garg@linaro.org>
 <20240311111027.44577-4-sumit.garg@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240311111027.44577-4-sumit.garg@linaro.org>
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



On 11/03/2024 11:10, Sumit Garg wrote:
> SE HMIBSC board debug console requires RS232 flow control, so enable
> corresponding support if RS232 gpios are present.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/serial/serial_msm.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
> index eaf024a55b0..7b2a3fdb2c1 100644
> --- a/drivers/serial/serial_msm.c
> +++ b/drivers/serial/serial_msm.c
> @@ -53,10 +53,11 @@
>  #define UARTDM_TF               0x100 /* UART Transmit FIFO register */
>  #define UARTDM_RF               0x140 /* UART Receive FIFO register */
>  
> -#define UART_DM_CLK_RX_TX_BIT_RATE 0xCC
> -#define MSM_BOOT_UART_DM_8_N_1_MODE 0x34
> -#define MSM_BOOT_UART_DM_CMD_RESET_RX 0x10
> -#define MSM_BOOT_UART_DM_CMD_RESET_TX 0x20
> +#define UART_DM_CLK_RX_TX_BIT_RATE	0xCC
> +#define MSM_BOOT_UART_DM_8_N_1_MODE	0x34
> +#define MSM_BOOT_UART_DM_CMD_RESET_RX	0x10
> +#define MSM_BOOT_UART_DM_CMD_RESET_TX	0x20
> +#define MSM_UART_MR1_RX_RDY_CTL		BIT(7)
>  
>  DECLARE_GLOBAL_DATA_PTR;
>  
> @@ -182,7 +183,9 @@ static void uart_dm_init(struct msm_serial_data *priv)
>  	mdelay(5);
>  
>  	writel(priv->clk_bit_rate, priv->base + UARTDM_CSR);
> -	writel(0x0, priv->base + UARTDM_MR1);
> +
> +	/* Enable RS232 flow control to support RS232 db9 connector */
> +	writel(MSM_UART_MR1_RX_RDY_CTL, priv->base + UARTDM_MR1);
>  	writel(MSM_BOOT_UART_DM_8_N_1_MODE, priv->base + UARTDM_MR2);
>  	writel(MSM_BOOT_UART_DM_CMD_RESET_RX, priv->base + UARTDM_CR);
>  	writel(MSM_BOOT_UART_DM_CMD_RESET_TX, priv->base + UARTDM_CR);

-- 
// Caleb (they/them)
