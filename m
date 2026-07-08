Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C391C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:24:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D1C784979;
	Wed,  8 Jul 2026 14:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xiMobH8b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D57B08497A; Wed,  8 Jul 2026 14:24:25 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CEC0843B6
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 14:24:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2cc6ae3e7f1so3875605ad.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 05:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783513462; x=1784118262; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dlYOxuX8pf2c0e6HkOiVHvCuRYZNwJl5J1d+OUIlg8Y=;
 b=xiMobH8bKBXTgUkiFzhVfx5lD5YHLjtTrAh4jAEFQLrSJOlfkR/TsZZxEdcuwXPcpO
 aNmzFRS6D9rjqrvRKHhUKEnTBPmoK/c87lmZj/rKYLs1nBYsajZGEoHc5fAi8jrCuplQ
 dVuw1XkRAD1u35ztM/pmWNdyBbfJ2lZXNNyRq3+jZR51LY+4h/a9hyT3gESD2aphp5l0
 JCKG/Db83deCck/0RWG6NBRN8yPq175KPJiUjVVQAQa8wSF+Dm8OX3SqUftMr9B8tr1s
 Ka4B1WGzlxEo1NSiX2FDrl8LysZPXw5/lXnA0h+soiwiVmp9xa9Q6Q4MAraBxDdQnNKj
 WhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783513462; x=1784118262;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dlYOxuX8pf2c0e6HkOiVHvCuRYZNwJl5J1d+OUIlg8Y=;
 b=LDtQQ4N1anuBoBL6HaigaZxC9lqNceQL3LgSzjH17D3RggBHdXdkxrEkKyIYAYMmfl
 jQe1h5a9J3+wlrYIZDYkvB+nY+STNQbDYiQf3eP8oXzbJbO7AroI5vAQvFI8SGaXcYNx
 qteirbXMkT9RIJP9ZtsXmZbU+emQYDHEmcjj+b4oKba/QbtwzDYHl9HeT4XJrnygVyRq
 tKqduwReQVhLmtNmUtPORaQ/QaxKM3d7jORlNTDDkbt3LyJiMZcHyutRQLxeciSukn8G
 sIyojqeERJ1ifnDUqlbJShg1b/YVlbjtDOZ7f3SXD4K3SfImq6RX6VabfzGhH5PnsPgr
 fVZw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ron0+GtnRNdyt4bHUnjCudZrWp9gl8nsEbHuSPWPEK8V/ZPYyTiFLHareb7IqGCzCNkYRgexvw=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+8ursBb1SN2U4jaZzKsCaVgOoYZgqOCeH9DePXIWuNwTYpa6K
 mmauQBpOUyFvEyf+VtRqe8OLldxiw+8pBsPlhAkPncOZFq2KtGPmx0GAL3FKzmLQBjQ=
X-Gm-Gg: AfdE7clpq9rWyj6MhMeWhZzDEWHn0LKvpHm84/PsIuUC446Qw8P6lEv92Dlrc9Ndkaz
 k9i7tfC4ScqVv4I9a6m9iF/OKigL8/449hsdmEEJkIvXbDm95BcBpfWGAO1O6Fzf01gEitSJGe2
 9vVtnDjMs36mwejURR/+JJGBHuOR5lksTOi0te+AAQ+GH8r0m39gLgDTpIGEfMvi47sySPytOpE
 SiykXfsqVB7PE7MB1EkvvHsxIQsyWX/x5JW+pkaC+hHHBS+w0Qqx1cCI1co3lf9rQElOFG4Ehwn
 Gyiosd3w5rXdYSW2lLWYRMk+h7x44H1sY3vEGrnWIh7mSaEWvNlkE/WYdFfXUNuOJkHWZ+VdrHE
 VThtU12sEuJdWc0rKtgh41kzCiPcP2BYgGcJa3lBUEOnYw+m6lvkkpI/f12GoKEwb744phFDj1z
 UueIh//TmyKXL4+Uc8ORTRh/ZZlcaAKB8yrpAHIQ==
X-Received: by 2002:a17:902:c94e:b0:2ca:bf8e:35fe with SMTP id
 d9443c01a7336-2ccea369f67mr25552815ad.16.1783513461677; 
 Wed, 08 Jul 2026 05:24:21 -0700 (PDT)
Received: from [192.168.45.141] ([112.212.195.74])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d5c804sm27151515ad.82.2026.07.08.05.24.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 05:24:21 -0700 (PDT)
Message-ID: <7f365f1e-75fb-4cc4-838c-d6e2f91f21ea@linaro.org>
Date: Wed, 8 Jul 2026 14:24:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] serial: msm_geni: validate RX FIFO data with IRQ
 status flags
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Stephen Boyd <swboyd@chromium.org>
References: <20260707-uart-v2-0-d38277b6c4ce@oss.qualcomm.com>
 <20260707-uart-v2-2-d38277b6c4ce@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260707-uart-v2-2-d38277b6c4ce@oss.qualcomm.com>
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

On 7/7/26 11:52, Balaji Selvanathan wrote:
> Add IRQ status validation to distinguish legitimate UART data from
> electrical noise in the RX FIFO.
> 
> When the UART cable is disconnected, the floating RX line can pick up
> noise that the GENI hardware interprets as valid data and places in
> the FIFO. So, check the RX IRQ status register for RX watermark or last
> flags before reporting pending data.

Thanks for respinning this series. Is this patch still necessary with 
the first one? Since we should no longer be in this state with noise in 
the FIFO after resetting it correctly iiuc?

Thanks,
// Casey

> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - No changes
> ---
>   drivers/serial/serial_msm_geni.c | 28 +++++++++++++++++++++-------
>   1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
> index a580dee8c8a..07d38178759 100644
> --- a/drivers/serial/serial_msm_geni.c
> +++ b/drivers/serial/serial_msm_geni.c
> @@ -483,15 +483,29 @@ static int msm_serial_getc(struct udevice *dev)
>   static int msm_serial_pending(struct udevice *dev, bool input)
>   {
>   	struct msm_serial_data *priv = dev_get_priv(dev);
> +	u32 fifo_status;
> +	u32 s_irq_status;
> +	int word_count;
>   
> -	if (input)
> -		return readl(priv->base + SE_GENI_RX_FIFO_STATUS) &
> -			   RX_FIFO_WC_MSK;
> -	else
> -		return readl(priv->base + SE_GENI_TX_FIFO_STATUS) &
> -			   TX_FIFO_WC_MSK;
> +	if (input) {
> +		fifo_status = readl(priv->base + SE_GENI_RX_FIFO_STATUS);
> +		word_count = fifo_status & RX_FIFO_WC_MSK;
>   
> -	return 0;
> +		if (word_count > 0) {
> +			/* Validate RX FIFO data with IRQ status */
> +			s_irq_status = readl(priv->base + SE_GENI_S_IRQ_STATUS);
> +
> +			if (!(s_irq_status & (S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN)))
> +				return 0;
> +		}
> +
> +		return word_count;
> +	} else {
> +		fifo_status = readl(priv->base + SE_GENI_TX_FIFO_STATUS);
> +		word_count = fifo_status & TX_FIFO_WC_MSK;
> +
> +		return word_count;
> +	}
>   }
>   
>   static const struct dm_serial_ops msm_serial_ops = {
> 

