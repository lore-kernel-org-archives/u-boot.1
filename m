Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB35C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 07:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73A5C84A35;
	Tue, 30 Jun 2026 09:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EpiuE1uw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1150084A4F; Tue, 30 Jun 2026 09:57:22 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E674384979
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 09:57:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4624a44e152so3849643f8f.2
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 00:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782806238; x=1783411038; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YkYr/o1hHkOiN7njhoTqLTeRuOeKco1Bf3xqsKBBwh4=;
 b=EpiuE1uwhx8fpKgdaoCEEb+XvCq7pMaqNkjrT2gkU3hWCsc7A59t969mncdX/aHtfy
 GR6Bo5NZD8vbNYnQlWlrp7HF4U5swa+8FgQ5q0kTM16ylpmWHLqJBy0KtuZRAqR3WYo2
 eGkXjXKczAmRujTSIVcKEJdaIzw6ICnrqcWokAC5HkVsesuWRm9X6AnuqppQ5e7PMeZU
 LFMR7xyFIE9wO8ETZ/GLVgilEZUAWF+83UA34cVjWMkn/lXbkwYa8uxGq1gAaSXJCWmw
 xKOSJj6rhXuJuoH3SLgJCqPTmZu5g81eZdo8ps8p1MGFtrbXQXSmIBK4bE15SCGJQj5k
 B9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782806238; x=1783411038;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YkYr/o1hHkOiN7njhoTqLTeRuOeKco1Bf3xqsKBBwh4=;
 b=Fav95Sf/hlBwfPc7u7o+jgIIhg2CljfNHwmg1OGJoTu6C9DLNBpKRGibVyHy7c2aZj
 /oERhu2fw4nm3XW+CD839QyuAkzPq58bJjGmK6Ol254hC3HHrQZ585L+ixblKPZM+snA
 yUWuOR4wcsi+8vgYm2EY8aD7KQvMxSjNG5RwXFCweO7Dym7F/VrHdQQykZ4JCmuvhHBx
 OQqPZe2A4URQ+AcdpjDO7d0MbnMkHkyw1ION6HEkDa13JF0tlAr2zM8d5W/VorMAN1H5
 jgLFBQSGBl/dXOPvahRnj105ebaGNCwZmWuFXAMEu930DWkON2RJ9BDfCwkXdzOjC7Md
 qhAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpEYUmJnCXtIhCbhNiNYfOTz2IxCZihgLNidxy7ThtWUs1uy43bpe1ZX99383cPW6vAbeSh8V0=@lists.denx.de
X-Gm-Message-State: AOJu0YwwOnIodHVTWl2TlxTSar1OClnbmsmglO96fOuqwZA8NJtMb0P0
 MlYjO9vK9tmSICDjhU7CjL4yqODr2JUmRyN0TkhqCSJXLzdFr3oFi+/sP/ahbJWF7D8=
X-Gm-Gg: AfdE7cmwQYA4FX/a2n5M341e9yBq4n/TbiI59FRHMWKyF7Mb36oS+ZIqqUgBzwTdRx3
 QSzNfLzEZRGd3IQcq1zRqS2AN3gv20McqKNDGkAHLRme+cjIxcSQ4w42rZqVCPE2ODM2o+382Ko
 GktbQEltaQgxniT/z8EWBuIBm/9VM87CTs1au7LNsNnhXFfE2PX46X8oRUGM2F8IzGjkn/lbdYZ
 H0j3SO0rB6ABSuyvmQL5Il+Z9DUDT+dDmZnMwwqnLoLSa5D28HSE53GzVm3a5XdEHxMZPQfagyR
 L+x8J7PHJUSwBdrzyHn8dC8SrAvZWu72Qkh5bwvudg98AYoysEq/TEkbmhd7DVYiLgqx56wYgnw
 Eyym85H835l6f3LFRsAqSb6hWtWFillxNlEOV+MyZcUx545H67hW6ogtkrdPpcNPQFTI0pAQFrg
 Sb6wIRj/PyoPqCC90VWNJXXt2q6u0BimP2WHIq2ol8TMtOo8Zm1sTGgke2BWQ=
X-Received: by 2002:a5d:5c89:0:b0:474:8aad:2f8 with SMTP id
 ffacd0b85a97d-47553028380mr3434223f8f.41.1782806238279; 
 Tue, 30 Jun 2026 00:57:18 -0700 (PDT)
Received: from [172.20.10.2] (ip-109-42-118-167.web.vodafone.de.
 [109.42.118.167]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-475641e4cdesm5503750f8f.13.2026.06.30.00.57.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 00:57:17 -0700 (PDT)
Message-ID: <c96d6396-f741-4c02-bd7f-3b001f308feb@linaro.org>
Date: Tue, 30 Jun 2026 09:57:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: msm_geni: validate RX data with IRQ status
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Stephen Boyd <swboyd@chromium.org>
References: <20260629-uart-v1-1-cbc46fe1d7d3@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260629-uart-v1-1-cbc46fe1d7d3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Balaji,

On 6/29/26 13:31, Balaji Selvanathan wrote:
> The GENI UART hardware can retain stale data in the RX FIFO.
> The msm_serial_pending() function was reporting this stale data as
> pending input, causing U-Boot to incorrectly assume a key press and
> stop at the CLI prompt instead of continuing the boot process.
> 
> Add IRQ status validation to distinguish between legitimate received
> data and stale FIFO contents. Check the Secondary IRQ status register
> for RX watermark or last flags before reporting pending data. If the
> FIFO contains data but no valid IRQ flags are set, ignore it as stale.

Taking a look here compared to the Linux polling mode driver I don't 
think this is the right way to solve this.

In qcom_geni_serial_stop_rx_fifo() in Linux after clearing the RX IRQs 
the cancel command is sent (and polled on) and then if S_RX_FIFO_LAST_EN 
is set the FIFO is drained.

So the right fix here for U-Boot would be to do something similar in 
msm_geni_serial_setup_rx(), send a cancel rather than an abort, wait for 
it to complete (or timeout), drain the fifo, and then send an abort if 
S_GENI_CMD_ACTIVE is still set to fully reset it.

so NAK, please solve this properly by fixing the init sequence.

> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>   drivers/serial/serial_msm_geni.c | 27 ++++++++++++++++++++++-----
>   1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
> index 3dca581f68f..6d30f150966 100644
> --- a/drivers/serial/serial_msm_geni.c
> +++ b/drivers/serial/serial_msm_geni.c
> @@ -424,13 +424,30 @@ static int msm_serial_getc(struct udevice *dev)
>   static int msm_serial_pending(struct udevice *dev, bool input)
>   {
>   	struct msm_serial_data *priv = dev_get_priv(dev);
> -
> -	if (input)
> -		return readl(priv->base + SE_GENI_RX_FIFO_STATUS) &
> -			   RX_FIFO_WC_MSK;
> -	else
> +	u32 rx_fifo_status, s_irq_status;
> +	int result;
> +
> +	if (input) {
> +		rx_fifo_status = readl(priv->base + SE_GENI_RX_FIFO_STATUS);
> +		result = rx_fifo_status & RX_FIFO_WC_MSK;
> +
> +		/*
> +		 * Validate RX data with IRQ status
> +		 * Only report pending data if valid RX IRQ indicators are set.

What does this mean "valid RX IRQ indicators"??? This comment is fluff, 
use better variable names (result -> word_count)
> +		 */
> +		if (result) {

if (word_count > 0)> +			s_irq_status = readl(priv->base + 
SE_GENI_S_IRQ_STATUS);
> +
> +			if (!(s_irq_status & (S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN))) {
> +				/* No valid RX IRQ, ignore stale data */
> +				return 0;
> +			}
> +		}
> +		return result;
> +	} else {
>   		return readl(priv->base + SE_GENI_TX_FIFO_STATUS) &
>   			   TX_FIFO_WC_MSK;
> +	}
>   
>   	return 0;
>   }
> 
> ---
> base-commit: 6902fb4c17faa375003124c451c2550deab5463d
> change-id: 20260629-uart-e07d893e4508
> 
> Best regards,

