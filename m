Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C90FF8864
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 06:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 098A8803C6;
	Fri,  1 May 2026 08:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CqQ+/Iz8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5570580F0E; Fri,  1 May 2026 08:57:03 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABA0E80086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 08:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3102D434A8;
 Fri,  1 May 2026 06:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26DCC2BCB7;
 Fri,  1 May 2026 06:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777618619;
 bh=s40IAHFV0EIRywHqDYZbtW6E7VKA3UpLKKRPkYN1pE4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CqQ+/Iz8rjZrWXnkTYc9H2470qGW8SixL0XnNYaOFXg/I3FnK+vi0A9gAaO7LhZiR
 G5vrUVVrf8DVHoKwQ3UcofScpQGysQuScw7KCitdkJTxXCBMEnylYCZ4KYGk7WpJ4R
 d0WpWC3OppjrvymGtoyKvT14S3QUCSACE2GI/OAqaL8NEGPd4/RPVPuhiZDABC7Bzy
 2+3JPG8ixEVd+6iKTR84/tBYu7uVQddFQWk4PwAYz4u5SyyjB1LWt06bHTyNW39AEr
 bMlUJS+yZLgkgmkwUpFpyrZ3AfrOWjFF8+IzjucRWVhEq7rcvc9wMCAvFkkUufgkV8
 y/7roFhUicE7w==
Date: Fri, 1 May 2026 12:26:53 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 trini@konsulko.com, andrew.goodbody@linaro.org,
 quic_timple@quicinc.com, swboyd@chromium.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1] serial: msm-geni: configure RX watermark register
Message-ID: <afROtaRqheyt6yTq@sumit-xelite>
References: <20260421044555.368486-1-gurumoorthy.santhakumar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421044555.368486-1-gurumoorthy.santhakumar@oss.qualcomm.com>
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

On Tue, Apr 21, 2026 at 10:15:55AM +0530, Gurumoorthy Santhakumar wrote:
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
> ---
>  drivers/serial/serial_msm_geni.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

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
> -- 
> 2.34.1
> 
