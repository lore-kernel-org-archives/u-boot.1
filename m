Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56203CD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 13:35:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1CBD848FC;
	Tue,  5 May 2026 15:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OC/PD4oO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1424484910; Tue,  5 May 2026 15:35:32 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B755848B9
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 15:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-44985f4ab0fso2403301f8f.0
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 06:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777988128; x=1778592928; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vhwxTyPPGrAP1ch3Lg5KOb7W2cvRcduhmOe3lOhcJ60=;
 b=OC/PD4oOLPpIReweOvwD9i0SAW9+ce926MRF0zi9+/358UnM4QOPRu0tp4t3pyUUMG
 2G7lPdMAPdsvi1rEiVhBHUP1rAWdlnTu6WeUwOe7FdTMJSD8yd6qVgBYZf8hn+XRLoqb
 MQMxx6vTz2bU9t5T740NbY3JsO5Tmlt1PT/3rKQybvFYXj9Pf/Cr/fjnFBVEaHl+DupK
 HA3anBSSxWalq5vIu2CfoHujsvGfg7DN/Inl1cxZ/kkQHvXkaqrTvURkAp2tmaNcs4l7
 wJRotvngNHNSQVtEX/n2tKXvhvH/W2f8bLH9ZbMgmVsj94cicu3hwYC5X9dXGU+qloF+
 Bwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777988128; x=1778592928;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vhwxTyPPGrAP1ch3Lg5KOb7W2cvRcduhmOe3lOhcJ60=;
 b=ZuKWgEKpJcZ3ADIdTpj9iEkF3bc80jR00V3+AvI8qu9N4TjUwuBwIcpA7Kxis7L6Ef
 7SbPAU0l45zGs9KLjmHiJf1bRvsruMLZnEq8Rx/YjDdKhkudSCSXcLnBYg8/3LZU6QzQ
 HvlzVZMEx0KGuY425G1HAW8NE4Wxhrx0onE1FgJ9LKpyiv2Tg/48p9koS7ftMerCZAtX
 eoSBHHq2wBEJTQcM8HwvAmqtEOUwevQg3jB502wpKCnYcSk8pGNE/9TSbRlhj8y8lX8A
 TZ8Fsz+smXHQ7+v+P5uSeKb10K2kTrejpT6oQwnZF9SfJEvBog7BxjTi8iEhTeKPjrto
 H1FA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9R0J+rBWMPjiY6/EUfm8hdKXEs5QEE/Hy0xgJALKa9SEjs6WYKgRtyn0Q5R20KaIvTiVZHzlo=@lists.denx.de
X-Gm-Message-State: AOJu0YzJiXm8lUT4Qa2kvW4e/lkMKhdsRHbeCwvhUapiOY+KxMmiZeoH
 1c4E6GuQMG/TTS7T9u3aUVVzRZHr9LaTqdeeQo8PXImXmBYy7wSDuEKkpxZtgvwuufE=
X-Gm-Gg: AeBDiesm9jJNh2xtdCjvTuAHQsZaEQmK5XC8pMerSVtzITaUfuVMQY3amuyapUkriLr
 qDMenJI5UPWbqBQIOjeaH6h+AsP0pmdFayCzlmZpgpb5VKEbi31JZISRhzfPrBC4AT0rg0E7+6H
 xZWFbut4arVLTOlvufd6FL63CerxEAe7ovNlOOOdNTa3GrI1k/urt9kOr19q9yuzQpBTlJy07Ag
 EXJnpCl1juxm9fs/1qrJy57ubSUWxtAl/JPIeX5d6rQU+aDk3YPGho28C+/dUqFeEzy3jT8xsQl
 zw9a741vUcgQEGBupSJxNhDICeOw7ITc1SDub/afWmECWOhzwreZfWWhQzO3+KdCyCW21d4RM7Z
 nkw4TRhAUixfVr6Fj5ENrXlZMKq911yMgjgMmrGECFJSuavmwMlfvvHbjSUrSvCV4gGlbSgFh81
 TKDKQ5jDg9SlrQVihsIqSqrurQ3C9SpQLjzaPCu2Lm/AYcymRkn5qJFf7LGvs+e5Dnd/HBJrnte
 8tb
X-Received: by 2002:a5d:5850:0:b0:43d:7cb5:43b2 with SMTP id
 ffacd0b85a97d-45003fc6940mr5605931f8f.15.1777988128354; 
 Tue, 05 May 2026 06:35:28 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960022sm4700437f8f.26.2026.05.05.06.35.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 06:35:27 -0700 (PDT)
Message-ID: <5889bb65-c317-4911-8ecb-e356b6d1192f@linaro.org>
Date: Tue, 5 May 2026 15:35:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] serial: msm-geni: configure RX watermark register
Content-Language: en-US
To: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 andrew.goodbody@linaro.org, quic_timple@quicinc.com, swboyd@chromium.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260421044555.368486-1-gurumoorthy.santhakumar@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260421044555.368486-1-gurumoorthy.santhakumar@oss.qualcomm.com>
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



On 21/04/2026 06:45, Gurumoorthy Santhakumar wrote:
> From: Timple Raj M <quic_timple@quicinc.com>
> 
> The SE_GENI_RX_WATERMARK_REG was not being programmed in the RX
> setup paths. Set it to DEF_RX_WM (2) in qcom_geni_serial_start_rx(),
> msm_geni_serial_setup_rx() and _debug_uart_init() to align with the
> Linux kernel driver behaviour.
> 
> Without this, the RX FIFO watermark interrupt threshold is left at
> its hardware reset value, which may differ from the expected value
> and can cause RX data loss or missed watermark interrupts.
> 
> Link: https://lore.kernel.org/all/20200227132223.864425794@linuxfoundation.org/
> Signed-off-by: Timple Raj M <quic_timple@quicinc.com>
> Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>

Reviewed-by: Csey Connolly <casey.connolly@linaro.org>

> ---
>  drivers/serial/serial_msm_geni.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
> index 3dca581f68f..ae4015e0fdc 100644
> --- a/drivers/serial/serial_msm_geni.c
> +++ b/drivers/serial/serial_msm_geni.c
> @@ -55,6 +55,7 @@
>  #define SE_UART_RX_PARITY_CFG	0x2a8
>  
>  #define DEF_TX_WM	2
> +#define DEF_RX_WM	2
>  /* GENI_FORCE_DEFAULT_REG fields */
>  
>  #define UART_START_READ	0x1
> @@ -345,6 +346,7 @@ static void qcom_geni_serial_start_rx(struct udevice *dev)
>  
>  	geni_se_setup_s_cmd(priv->base, UART_START_READ, 0);
>  
> +	writel(DEF_RX_WM, priv->base + SE_GENI_RX_WATERMARK_REG);
>  	setbits_le32(priv->base + SE_GENI_S_IRQ_EN, S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN);
>  	setbits_le32(priv->base + SE_GENI_M_IRQ_EN, M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN);
>  }
> @@ -373,6 +375,7 @@ static void msm_geni_serial_setup_rx(struct udevice *dev)
>  
>  	geni_se_setup_s_cmd(priv->base, UART_START_READ, 0);
>  
> +	writel(DEF_RX_WM, priv->base + SE_GENI_RX_WATERMARK_REG);
>  	setbits_le32(priv->base + SE_GENI_S_IRQ_EN, S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN);
>  	setbits_le32(priv->base + SE_GENI_M_IRQ_EN, M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN);
>  }
> @@ -616,6 +619,7 @@ static inline void _debug_uart_init(void)
>  	phys_addr_t base = CONFIG_VAL(DEBUG_UART_BASE);
>  
>  	geni_serial_init(&init_dev);
> +	writel(DEF_RX_WM, base + SE_GENI_RX_WATERMARK_REG);
>  	geni_serial_baud(base, CLK_DIV, CONFIG_BAUDRATE);
>  	qcom_geni_serial_start_tx(base);
>  }

-- 
// Casey (she/her)

