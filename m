Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E046C77B7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 09:42:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA9E782D17;
	Tue, 24 Jun 2025 11:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jNQok5R3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 051D482D21; Tue, 24 Jun 2025 11:42:00 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBEA882C84
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 11:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-adeaa4f3d07so1012411066b.0
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 02:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750758117; x=1751362917; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=9fJGA7QRDaz0ZuBSUa0TVOM2T94H6wEcavbLG4IP6u4=;
 b=jNQok5R3pMhIKCBhiqLy2UbohfGt2sJFCqLSuJWmS0gT8StlvMbpnAbmdbl9UBimTM
 baEXX/CEMSSuvR+EIvTe3/hUTR9/RNfqD6EvJUkr2AKpvmQ1xUU4N+LZSsDqxe4kKUwy
 ZCQ5t7QCfjmVSXa5YLTSj668Sdb8SAE+lLv3kpJR++tNTZHo5KNtJkOfgYhPfkHIzCzC
 3Xc60f8+FQa9CncgzPq4nWBm3Q5AxAP9AEnm/rLDoBHHLmqGkb5LKO3w3Ph7Fu/jaZvl
 gMbhQ4eEiZsGOBiAkS3GNOMV9Kih5XqnozvoDT8xOueZ6OK+KwEf9yrf70Srt6mSsIRI
 kh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750758117; x=1751362917;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9fJGA7QRDaz0ZuBSUa0TVOM2T94H6wEcavbLG4IP6u4=;
 b=mgVVduM28ZMZP1Hv7JRvC8RDdeRMXVwW+JM3NOKeYVuDASLyr+5KInFDgzrxXvzXKl
 RdUGOvcw6mC6NFm0ZN9IxMoMEyexNb1Xv/CO6EaNdxjGpCzLdQJKPg5Ek50ZvtaYrorH
 yZ1RToTHt7urvyNz5rr00WUQukXK0o1lH9egD+co2uA2Xcmd09UYuXE6A/xXghhDcYHI
 bnOq4agGJ4Q/Ot1ArMWUElmTZ1b5Gk14YNn3nqpvBqZI3bTUmJ1bcHZZqd/1cysIRQQy
 OKJGfg5PJvXHQ0Z0c+FDS3oUILCTF3vFrYVUazqrB8JbSWq6qDHVJXPP38BQ6UxnuLd+
 vRIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt2122ffpwQsDNNYrF767u/x0b9wnc6uENqYhNVnInSi57LBT0lWRSISWwhuQmthy/wdNI3+U=@lists.denx.de
X-Gm-Message-State: AOJu0YyB6vjnQ9F3F3KwSJO1VVbuOUk+ABsdtM7jG1eSsfB+6ZyAtSCu
 cHwOzGns0tYpbYWOBpBpzkJwnTMKw978mx645qRp+LnhWBcYcnT5GSo5Va3r5hgyYEw=
X-Gm-Gg: ASbGncs10mcoShHeemIuza4MKRwW4UKC2/0cWjGPZKpJUxdgvfyiubTN7XfYjmh645X
 EOsD1P8JRX8dyJLDDtDdmWyfPgDAQkJbV3tymwEs/V0Su37HhtQ0SA/dT8hUEslOZdswI9OWpwV
 OpnL9bI9+JvKGa4ua1g9/jCSxjeTzcbgYyS3o9UuTmdzjKdwnN82zADGGD4UAw/FqOCoJWOflvH
 GjAI85j4EotHsnojOd/jFjPXiePQlrys3ooareMGYL1QToOPSJAeX2sNRSCHDfaT9Wg0wZiH10d
 bfAIUJwTznb4UtIYw3PP+7WWyrIUmchOkDBMmN0PViqao7oTvehABRmTRX0aO0LXMiPgZyQMW2u
 +rHn+OMW4PU+B2bWErSV+wOMwVSaXVITwynOrxZ+U1+3rEVDnZw==
X-Google-Smtp-Source: AGHT+IFGhmgI27LR6o8Kbdr3jCx3vj6g++PdJdarh2XQgIHy9dwDcNVEiJjjFj0vM6uJsNay4mGsoQ==
X-Received: by 2002:a17:907:86ac:b0:ad8:9645:798c with SMTP id
 a640c23a62f3a-ae057f6943emr1358691666b.51.1750758117101; 
 Tue, 24 Jun 2025 02:41:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:6fea:600c:ca20:f54a?
 ([2a01:e0a:3d9:2080:6fea:600c:ca20:f54a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae0540815c2sm863682466b.94.2025.06.24.02.41.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 02:41:56 -0700 (PDT)
Message-ID: <f85b7592-1a14-4233-9908-b8f42ffad7de@linaro.org>
Date: Tue, 24 Jun 2025 11:41:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 10/10] serial: msm: Use single character mode
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250624-db410c-autoboot-fixes-v1-0-d96c97ae41d1@linaro.org>
 <20250624-db410c-autoboot-fixes-v1-10-d96c97ae41d1@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20250624-db410c-autoboot-fixes-v1-10-d96c97ae41d1@linaro.org>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 24/06/2025 10:45, Stephan Gerhold wrote:
> The UART DM controller supports different channel data packing modes,
> either the 4-character packing mode (where 32-bit are read/written at once)
> or the single-character mode (where only a single character is read/written
> at a time). The 4-character mode can be more efficient, but the
> single-character mode is much easier to implement.
> 
> At the moment, serial_msm uses the 4-character mode. Since the
> dm_serial_ops operate on one character at the time, the code goes through
> quite some hoops in order to break this down to single characters. This
> code is prone to race conditions (e.g. priv->chars_cnt is read from the
> registers, then a command is issued, what if another char came in
> inbetween?). It also seems to cause another subtle issue with autoboot:
> 
> Unlike the previous autoboot failures that happened when UART was
> disconnected, this problem occurs when UART is connected and open in a
> terminal: For EFI boot, the console size is queried in efi_console.c
> query_console_serial() by sending an ANSI escape code via UART. For some
> reason, with the current driver we get yet another 0x00 byte (UART break
> event?) when reading the reply from serial input. Because of that, reading
> the console size fails in efi_console.c, the actual reply remains in the
> UART buffer, and later the boot flow aborts because it detects input after
> printing a prompt.
> 
> Rather than trying to fix the issue in the current complicated approach,
> switch the driver to use the single-character mode. This is simple and
> straightforward to implement without race conditions:
> 
>   - We write one character at a time to UARTDM_TF, as long as the TX FIFO
>     has space available (TX_READY). To flush the console before starting
>     Linux, we wait for TX_EMPTY.
> 
>   - We read one character at a time from UARTDM_RF and strip off the
>     additional error information (assuming there is something in the
>     RX FIFO, as indicated by RX_READY).
> 
> In this mode, querying the serial console size works and autoboot is no
> longer interrupted. The overall code is also much shorter.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   drivers/serial/serial_msm.c | 102 +++++++-------------------------------------
>   1 file changed, 16 insertions(+), 86 deletions(-)
> 
> diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
> index 2c08a84b02773663f3c3a11eddaaa7a8bab2b4a1..18d15b7b15b3aeb2e8fd1da1aa49967d55c943ab 100644
> --- a/drivers/serial/serial_msm.c
> +++ b/drivers/serial/serial_msm.c
> @@ -21,13 +21,9 @@
>   
>   /* Serial registers - this driver works in uartdm mode*/
>   
> -#define UARTDM_DMRX             0x34 /* Max RX transfer length */
> -#define UARTDM_DMEN             0x3C /* DMA/data-packing mode */
> -#define UARTDM_NCF_TX           0x40 /* Number of chars to TX */
> +#define UARTDM_DMEN			0x3C /* DMA/data-packing mode */
> +#define UARTDM_DMEN_TXRX_SC_ENABLE	(BIT(4) | BIT(5))
>   
> -#define UARTDM_RXFS             0x50 /* RX channel status register */
> -#define UARTDM_RXFS_BUF_SHIFT   0x7  /* Number of bytes in the packing buffer */
> -#define UARTDM_RXFS_BUF_MASK    0x7
>   #define UARTDM_MR1				 0x00
>   #define UARTDM_MR1_RX_RDY_CTL			 BIT(7)
>   #define UARTDM_MR2				 0x04
> @@ -45,118 +41,56 @@
>   #define UARTDM_CSR				 0xA0
>   
>   #define UARTDM_SR                0xA4 /* Status register */
> -#define UARTDM_SR_RX_READY       (1 << 0) /* Word is the receiver FIFO */
> +#define UARTDM_SR_RX_READY       (1 << 0) /* Receiver FIFO has data */
> +#define UARTDM_SR_TX_READY       (1 << 2) /* Transmitter FIFO has space */
>   #define UARTDM_SR_TX_EMPTY       (1 << 3) /* Transmitter underrun */
> -#define UARTDM_SR_UART_OVERRUN   (1 << 4) /* Receive overrun */
>   
>   #define UARTDM_CR                         0xA8 /* Command register */
>   #define UARTDM_CR_RX_ENABLE               (1 << 0) /* Enable receiver */
>   #define UARTDM_CR_TX_ENABLE               (1 << 2) /* Enable transmitter */
>   #define UARTDM_CR_CMD_RESET_RX            (1 << 4) /* Reset receiver */
>   #define UARTDM_CR_CMD_RESET_TX            (2 << 4) /* Reset transmitter */
> -#define UARTDM_CR_CMD_RESET_ERR           (3 << 4) /* Clear overrun error */
> -#define UARTDM_CR_CMD_RESET_STALE_INT     (8 << 4) /* Clears stale irq */
> -#define UARTDM_CR_CMD_RESET_TX_READY      (3 << 8) /* Clears TX Ready irq*/
> -#define UARTDM_CR_CMD_FORCE_STALE         (4 << 8) /* Causes stale event */
> -#define UARTDM_CR_CMD_STALE_EVENT_DISABLE (6 << 8) /* Disable stale event */
> -
> -#define UARTDM_IMR                0xB0 /* Interrupt mask register */
> -#define UARTDM_ISR                0xB4 /* Interrupt status register */
> -#define UARTDM_ISR_TX_READY       0x80 /* TX FIFO empty */
>   
>   #define UARTDM_TF               0x100 /* UART Transmit FIFO register */
>   #define UARTDM_RF               0x140 /* UART Receive FIFO register */
> +#define UARTDM_RF_CHAR          0xff /* higher bits contain error information */
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
>   struct msm_serial_data {
>   	phys_addr_t base;
> -	unsigned chars_cnt; /* number of buffered chars */
> -	uint32_t chars_buf; /* buffered chars */
>   	uint32_t clk_rate; /* core clock rate */
>   };
>   
> -static int msm_serial_fetch(struct udevice *dev)
> -{
> -	struct msm_serial_data *priv = dev_get_priv(dev);
> -	unsigned sr;
> -
> -	if (priv->chars_cnt)
> -		return priv->chars_cnt;
> -
> -	/* Clear error in case of buffer overrun */
> -	if (readl(priv->base + UARTDM_SR) & UARTDM_SR_UART_OVERRUN)
> -		writel(UARTDM_CR_CMD_RESET_ERR, priv->base + UARTDM_CR);
> -
> -	/* We need to fetch new character */
> -	sr = readl(priv->base + UARTDM_SR);
> -
> -	if (sr & UARTDM_SR_RX_READY) {
> -		/* There are at least 4 bytes in fifo */
> -		priv->chars_buf = readl(priv->base + UARTDM_RF);
> -		priv->chars_cnt = 4;
> -	} else {
> -		/* Check if there is anything in fifo */
> -		priv->chars_cnt = readl(priv->base + UARTDM_RXFS);
> -		/* Extract number of characters in UART packing buffer*/
> -		priv->chars_cnt = (priv->chars_cnt >>
> -				   UARTDM_RXFS_BUF_SHIFT) &
> -				  UARTDM_RXFS_BUF_MASK;
> -		if (!priv->chars_cnt)
> -			return 0;
> -
> -		/* There is at least one charcter, move it to fifo */
> -		writel(UARTDM_CR_CMD_FORCE_STALE,
> -		       priv->base + UARTDM_CR);
> -
> -		priv->chars_buf = readl(priv->base + UARTDM_RF);
> -		writel(UARTDM_CR_CMD_RESET_STALE_INT,
> -		       priv->base + UARTDM_CR);
> -		writel(0x7, priv->base + UARTDM_DMRX);
> -	}
> -
> -	return priv->chars_cnt;
> -}
> -
>   static int msm_serial_getc(struct udevice *dev)
>   {
>   	struct msm_serial_data *priv = dev_get_priv(dev);
> -	char c;
>   
> -	if (!msm_serial_fetch(dev))
> +	if (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_RX_READY))
>   		return -EAGAIN;
>   
> -	c = priv->chars_buf & 0xFF;
> -	priv->chars_buf >>= 8;
> -	priv->chars_cnt--;
> -
> -	return c;
> +	return readl(priv->base + UARTDM_RF) & UARTDM_RF_CHAR;
>   }
>   
>   static int msm_serial_putc(struct udevice *dev, const char ch)
>   {
>   	struct msm_serial_data *priv = dev_get_priv(dev);
>   
> -	if (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_EMPTY) &&
> -	    !(readl(priv->base + UARTDM_ISR) & UARTDM_ISR_TX_READY))
> +	if (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_READY))
>   		return -EAGAIN;
>   
> -	writel(UARTDM_CR_CMD_RESET_TX_READY, priv->base + UARTDM_CR);
> -
> -	writel(1, priv->base + UARTDM_NCF_TX);
>   	writel(ch, priv->base + UARTDM_TF);
> -
>   	return 0;
>   }
>   
>   static int msm_serial_pending(struct udevice *dev, bool input)
>   {
> -	if (input) {
> -		if (msm_serial_fetch(dev))
> -			return 1;
> -	}
> +	struct msm_serial_data *priv = dev_get_priv(dev);
>   
> -	return 0;
> +	if (input)
> +		return !!(readl(priv->base + UARTDM_SR) & UARTDM_SR_RX_READY);
> +	else
> +		return !(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_EMPTY);
>   }
>   
>   static const struct dm_serial_ops msm_serial_ops = {
> @@ -222,8 +156,8 @@ static void uart_dm_init(struct msm_serial_data *priv)
>   	writel(UARTDM_MR1_RX_RDY_CTL, priv->base + UARTDM_MR1);
>   	writel(UARTDM_MR2_8_N_1_MODE, priv->base + UARTDM_MR2);
>   
> -	/* Make sure BAM/single character mode is disabled */
> -	writel(0x0, priv->base + UARTDM_DMEN);
> +	/* Enable single character mode */
> +	writel(UARTDM_DMEN_TXRX_SC_ENABLE, priv->base + UARTDM_DMEN);
>   
>   	writel(UARTDM_CR_CMD_RESET_RX, priv->base + UARTDM_CR);
>   	writel(UARTDM_CR_CMD_RESET_TX, priv->base + UARTDM_CR);
> @@ -320,13 +254,9 @@ static inline void _debug_uart_putc(int ch)
>   {
>   	struct msm_serial_data *priv = &init_serial_data;
>   
> -	while (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_EMPTY) &&
> -	       !(readl(priv->base + UARTDM_ISR) & UARTDM_ISR_TX_READY))
> +	while (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_READY))
>   		;
>   
> -	writel(UARTDM_CR_CMD_RESET_TX_READY, priv->base + UARTDM_CR);
> -
> -	writel(1, priv->base + UARTDM_NCF_TX);
>   	writel(ch, priv->base + UARTDM_TF);
>   }
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
