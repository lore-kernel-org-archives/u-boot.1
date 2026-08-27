Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955AEC61DC7
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 10:03:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 503F980DFC;
	Thu, 27 Aug 2026 10:03:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CclFti-ikroB; Thu, 27 Aug 2026 10:03:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787824989;
	bh=lyHeMozmMsPwFOGz5SAqQ2gyiiwmPVWi7yyoEMM1+OM=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=drpjB4s7wFBf/JvoQQCeyS/qLSh8L5V9WF8VUllz7BY5VypEF7+PTms4i1MjTu/je
	 AXsClE3EfFaRamvF5s0QFl6c3abEw5UV0YqUKSBG/DxC7WGVQARqbk/qDdANmBP46d
	 ujizpBMR/fPrA65I27qP2KxJy7wuhWHTrLZ8CVxyPeNdtCNDAW0jnq9yErEvzJL6k6
	 9uWwMGya5//ksZWtCnQ+ZeTRRyUAU+Hm4rsZHVeGHV/AWnn1dmEaYjoJbyLEqVs2hW
	 rdE6ivc93YQuvOkX1GsKzK4MN38sEGMs3YcyypTIALO6/DcSiJTUSXKbr8FO7goqL5
	 4H8fYCW7Kb67Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B68CD80DC6;
	Thu, 27 Aug 2026 10:03:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6294E230
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 10:03:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 546BE406CD
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 10:03:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sfjBl2uUukvy for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 10:03:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=HKP1+eGr
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 286344046C
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 10:03:06 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49b8eeb3ff2so2171855e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 03:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787824985; x=1788429785;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lyHeMozmMsPwFOGz5SAqQ2gyiiwmPVWi7yyoEMM1+OM=;
 b=HKP1+eGrevoEP/pgaKjQyzfH/Gfws+MXJmXePg2RbcWm8XKYRrT9/lDAaFTYqGBF0o
 lBncY0MdV6qi9+JrjiGACmF3oI5ikyoELGdrBrXziyGngOG4Ujox9nkpNjUW7JJDrsMP
 yRdY7NnhdpLc7hJ0q1gY+7Hysap7IeehMF9ajtexqwtbRJf1mhNIqx29r0TQg1fwv0rP
 mRoRig3D1hCFIXeoupa5Sdmb0bDeB+thY7i3/dt5b2AoNVfZo+NesNQG0uQuIjOcfj++
 WQaBCOK3sjbSeEkoEAc8PqnmXUoWMmcwk4HqEEEASJRvsC3eNGTYPxrmJavlXZYzpWjD
 ADvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787824985; x=1788429785;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lyHeMozmMsPwFOGz5SAqQ2gyiiwmPVWi7yyoEMM1+OM=;
 b=iROtL9klLtVM0edYZT4ewWLsNXBqSQkDuhm03Y8gQ2H4KWjKjc7Ge8ut4w7PPOgnly
 ehzNsl1Mv4HaHqhUE0eUK1/s/bX8CSR9t8buIl/g7tX3v2hgev+S+8Q49T22iiZ6W+R0
 CA3aTsVXxoTChc0JSlchE4OFbuhGeoPZM6H6r62+UYQOxs/fvvFs9JJqaihVp6FyBYIk
 GLxjJ0MBxoGbXTI7Nk/qTYSiTdwKjxx7ZgyBSHzjiwk9sO0J06sFL01QHBU5wvOgTIpY
 PC9BxPZ/T8epRsZXrYXPE/4dhKD+rk7E5KOfi3KMfXn3CSm2AD2BuC1nGqINhINDMjIP
 UqDA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrbXQzVkwdmwK87hr7DWlqBAYLDOOn8SecRspkGp6kFWtlhvNR0CmyQ/+azUTZ9aVjTv0aY3IU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lY/rr+uPqrXyQK9l3S1tEYMcVmuBhVB0tRhmTEhhdQvv4eLfc1
 7pyqmCUYBH0YrvO4Cz1x5rYMucRLpk70MIT98Ny+52IVYNwIg4xbMJtkU/ppOpwuurE=
X-Gm-Gg: AR+sD11N3P7Mry1LwvmTjxEVL6Mt3YhAIys0ntMMw6whKrL9yeBQHtTPLWx61MiGOow
 EDeA7dF3SbKNdbhzCfURBYhauCuv2imsCD4XByZlxfSStj1z3mojBzDFvNimqHFfkw+isLqnQBH
 OFMg2MzzOuTA+jVqy0RlKGJb99u7ffBO/Y0TtqTl7FgJhvi0Vak5X4DMiSSaXixkX3oz2uzDWzV
 J6XrY26ItnirZAWbfKThdYimby24NdFhyZ9VfnqwyaE3Os2m8mTgEe7W4OA5SAYYIt2Gu8q/AhH
 i/uaUoPiPjsX+DplXT7KaU5U9rS749SBZRsMhHeIRAffNDpos+gVQEgL4ZL91zWC47nP5gTIeK0
 W/17IJWEHIQLMzkc5/a4Mgv93i5uz4JXwj+GBSvGC+EswCu5R1ZEXgQzpQg3siuAqM36EshhaX3
 S0Rn8xUwxkZMh1sVGdDz8PeaFYKoqeWklUZ72ADgLPctLYn2d+JILjo2wVyzPD/vlfTrqwA0OkB
 0xRsGRXs0zx5WOgx4mSCcFT2J/Y
X-Received: by 2002:a05:600c:c3ce:20b0:49a:b082:fccf with SMTP id
 5b1f17b1804b1-49ab08302e8mr90357935e9.5.1787824983182; 
 Thu, 27 Aug 2026 03:03:03 -0700 (PDT)
Received: from [192.168.1.37] (p5b29ea13.dip0.t-ipconnect.de. [91.41.234.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499e7170b72sm82549445e9.0.2026.08.27.03.03.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 03:03:01 -0700 (PDT)
Message-ID: <d16f8cba-4c57-4195-8f5f-787f587cb8b1@linaro.org>
Date: Thu, 27 Aug 2026 12:03:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] serial: msm_geni: Skip UART TX when no cable is
 connected
Content-Language: en-US
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 varadarajan.narayanan@oss.qualcomm.com, quentin.schulz@cherry.de,
 stefan.roese@mailbox.org, xypron.glpk@gmx.de, jbx6244@gmail.com,
 hehongbo918@gmail.com, quic_timple@quicinc.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20260827073436.4113558-1-aswin.murugan@oss.qualcomm.com>
 <20260827073436.4113558-2-aswin.murugan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260827073436.4113558-2-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Aswin,

On 27/08/2026 09:34, Aswin Murugan wrote:
> Add MSM_GENI_SERIAL_CABLE_DETECT Kconfig option and detect a
> persistent RX-line BREAK condition (no S_GP_IRQ_3 after
> S_GP_IRQ_2) to identify a disconnected debug UART cable, and
> suppress TX output in that case to avoid driving an
> unterminated line.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  drivers/serial/Kconfig           |  9 +++++++
>  drivers/serial/serial_msm_geni.c | 41 ++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index ffc58d663ff..326088c7027 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -1020,6 +1020,15 @@ config MSM_GENI_SERIAL
>  	  Driver works in FIFO mode.
>  	  Multiple baudrates supported.
>  
> +config MSM_GENI_SERIAL_CABLE_DETECT
> +	bool "Disable GENI UART TX when no cable/console is connected"
> +	depends on MSM_GENI_SERIAL
> +	default n

Please explain in the commit message why it's desirable to suppress UART
TX in this case, if it's purely for optimising boot time I'd suggest
something like

	default y if CONFIG_LOGLEVEL < 6
	default n

Then no need to set it in the defconfig.

> +	help
> +	  Detect a UART RX-line BREAK condition, which indicates that no
> +	  cable is connected to the debug UART port, and suppress UART TX
> +	  output.
> +
>  config MXS_AUART_SERIAL
>  	bool "MXS AUART"
>  	depends on DM_SERIAL
> diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
> index ff91e0018fa..8bf5f6eea26 100644
> --- a/drivers/serial/serial_msm_geni.c
> +++ b/drivers/serial/serial_msm_geni.c
> @@ -98,6 +98,7 @@ struct msm_serial_data {
>  	u32 baud;
>  	u32 oversampling;
>  	struct clk *se;
> +	bool cable_connected;
>  };
>  
>  unsigned long root_freq[] = {7372800,  14745600, 19200000, 29491200,
> @@ -298,6 +299,28 @@ static u32 qcom_geni_serial_tx_empty(u64 base)
>  	return !readl(base + SE_GENI_TX_FIFO_STATUS);
>  }
>  
> +/**
> + * qcom_geni_serial_is_cable_connected() - Check UART RX-line BREAK condition.
> + * @base:	Pointer to the concerned serial engine.
> + *
> + * A serial cable that is not connected leaves the RX line in a state that
> + * the UART hardware reports as a BREAK condition that never ends, i.e.
> + * S_GP_IRQ_2 (RX_BREAK_START) gets set without a following S_GP_IRQ_3
> + * (RX_BREAK_END). This function checks the secondary sequencer IRQ status
> + * for that pattern.
> + *
> + * Return: false, if no cable is connected, true otherwise.
> + */
> +static bool qcom_geni_serial_is_cable_connected(u64 base)
> +{
> +	u32 s_irq_status = readl(base + SE_GENI_S_IRQ_STATUS);
> +
> +	if ((s_irq_status & S_GP_IRQ_2_EN) && !(s_irq_status & S_GP_IRQ_3_EN))
> +		return false;
> +
> +	return true;
> +}
> +
>  /**
>   * geni_se_setup_s_cmd() - Setup the secondary sequencer
>   * @se:		Pointer to the concerned serial engine.
> @@ -384,6 +407,10 @@ static int msm_serial_putc(struct udevice *dev, const char ch)
>  {
>  	struct msm_serial_data *priv = dev_get_priv(dev);
>  
> +	if (CONFIG_IS_ENABLED(MSM_GENI_SERIAL_CABLE_DETECT) &&
> +	    !priv->cable_connected)
> +		return 0;
> +
>  	writel(DEF_TX_WM, priv->base + SE_GENI_TX_WATERMARK_REG);
>  	qcom_geni_serial_setup_tx(priv->base, 1);
>  
> @@ -565,6 +592,11 @@ static int msm_serial_probe(struct udevice *dev)
>  	qcom_geni_serial_start_rx(dev);
>  	qcom_geni_serial_start_tx(priv->base);
>  
> +	if (CONFIG_IS_ENABLED(MSM_GENI_SERIAL_CABLE_DETECT))
> +		priv->cable_connected = qcom_geni_serial_is_cable_connected(priv->base);
> +	else
> +		priv->cable_connected = true;
> +
>  	return 0;
>  }
>  
> @@ -615,6 +647,8 @@ static struct udevice init_dev = {
>  #error Clocks cannot be set at early debug. Change CONFIG_BAUDRATE
>  #endif
>  
> +static bool debug_uart_cable_connected = true;
> +
>  static inline void _debug_uart_init(void)
>  {
>  	phys_addr_t base = CONFIG_VAL(DEBUG_UART_BASE);
> @@ -623,12 +657,19 @@ static inline void _debug_uart_init(void)
>  	writel(DEF_RX_WM, base + SE_GENI_RX_WATERMARK_REG);
>  	geni_serial_baud(base, CLK_DIV, CONFIG_BAUDRATE);
>  	qcom_geni_serial_start_tx(base);
> +
> +	if (CONFIG_IS_ENABLED(MSM_GENI_SERIAL_CABLE_DETECT))
> +		debug_uart_cable_connected = qcom_geni_serial_is_cable_connected(base);
>  }
>  
>  static inline void _debug_uart_putc(int ch)
>  {
>  	phys_addr_t base = CONFIG_VAL(DEBUG_UART_BASE);
>  
> +	if (CONFIG_IS_ENABLED(MSM_GENI_SERIAL_CABLE_DETECT) &&
> +	    !debug_uart_cable_connected)
> +		return;
> +
>  	writel(DEF_TX_WM, base + SE_GENI_TX_WATERMARK_REG);
>  	qcom_geni_serial_setup_tx(base, 1);
>  	qcom_geni_serial_poll_bit(&init_dev, SE_GENI_M_IRQ_STATUS,

-- 
// Casey (she/her)

