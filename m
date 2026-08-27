Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F83FC61DC7
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 12:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D31CE60796;
	Thu, 27 Aug 2026 12:35:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2LeK1skmNHeG; Thu, 27 Aug 2026 12:35:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787834108;
	bh=saDyWOvRtFEiWyIHmraR9LqDJvE2mdIhpSe/m9AKfvI=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=bUWR8mm38n9PYOIDyLS+9+ri8CEg2s7t2aBzejj076J/++OJcatmCOIKyqXmZ0mRV
	 1872DMfSAICuz+/pcDTR57CusQWSuntIAnSdK4/l03APpHcemPazlPyjJzInIYBLPZ
	 XDit/ptosD+Idekqc9PXp/gutVYuHUgkYyLy6Ny4gifljIJUHkG5z6vYvAfGjosJr3
	 riE6gtBnl8wm01X9JQUUUgjXEsb6EVPvvgFR3tALySotODsiRLzNJQjQh+wR7VPw0m
	 xX1IC3G1byz6/AGwYClwc5BJDyVIQiZCyWUVWHPt/YBSybIh6D5PcR7043eVF5hM/J
	 t+4Tmvtkg7VDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06B4960785;
	Thu, 27 Aug 2026 12:35:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A7F421DB1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8DB3140301
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:35:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EOkbq4DAYtOb for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 12:35:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=qIMl/Mdm
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D687402E1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:35:04 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47fecbb7000so985556f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 05:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787834103; x=1788438903;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=saDyWOvRtFEiWyIHmraR9LqDJvE2mdIhpSe/m9AKfvI=;
 b=qIMl/MdmfxjvSikH6i7JPBlzcSNwjnUJdHpLmskpr8NTwA7KdkcjJEv73VbzSxQBm9
 nIYxFbjpXoKGMZJHWdpvTv8zJuqTttrtmLXOW1nxJydBVM69eCYoIIY8r1fVjma29yCC
 bGifpItr3pY+wsJJESquJQXPN8jGh5O8H7w4Iqf8rASy1gZ1PcdUCmUk54FPDBE/B3YW
 A5Qvpp5ru/Xpt91za64RPb2KfvD0rFTSQle2wUKbEUJllqy29KBFacitCbOnoGBJ7Cgd
 tU23rKdgeiW9g8M7G3hY+DEkqSut3Un5qYVBJHYHKZZFhFNBXmoMgrMsvt5cxaq5abkV
 C8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787834103; x=1788438903;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=saDyWOvRtFEiWyIHmraR9LqDJvE2mdIhpSe/m9AKfvI=;
 b=gLOt57HlYhUV6fUMafc8UnTJcm9anZGJ4LQtVSLayxuVJZyfWZhn0YHBxA0QCWkQD/
 pBp7oUu7ECa+smXRAu+ft+RnrB+ilCppDqgzaX2u6DXw6I8CYfH35N4wvg375qftgtC6
 IXPmF3vsSv31WX9gt4Pr7sMR6pOxDeen+chPb7URxZlAcZ8Wz+sgtJP5LKjkNm9WR+Kg
 /EIM5ZoV0Gban+0zz1m00I+koozVY3cNqEdlQLoR6JBOcM5GB2E4HhsizyxKRnSmGzBx
 ZC5WUK51c0F9Mni5SpLhD4dG3dtPxjYd+eWUElt7D5ASi/U+Gu+hylXf5tS78B90tF1k
 bCFg==
X-Forwarded-Encrypted: i=1;
 AHgh+RolaMjUKPV+FWjBq2g0oAwExuIm/Ybb7R/ZVhRGW1wIFWL7mPNMxnSlXgqNCFDsACotwx3f1Gw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lvhtMt6GudpDTMWwXqfk/ilZp0I74mW9rTSZeL/Qd0rwMfi7a0
 PZn+IitNj2u5HATcLi+rHZ4JXIy9VUtCj/l6VtHH/1PqHNqAHIqfQL37rnsXjAFKl6s=
X-Gm-Gg: AR+sD13A+ynMQguePQ78z5hHY65H3NZXgHtet7QceUS/4l42XCULaHngjyZXUsG6hdW
 qhNt95QEN2IA0B9PnmJCYcFxNyk6uliHDk1Nfo204sYzPGFNCzwoICO9eLIX6CbE2n6pkZv+J0f
 efOeDl1zqD7rLHTfO+YxZc8X0OikntZ62qZNV+Q3ug8AfpQdAyZ0z3qIft7GI3o38q+xGkH29ic
 J3okExEPGXmESKGWMxrxkTUNeMkOkTtE+evwK2j7PR6scqgV5p+4VOjElGS/Jd2TLV484OXRCH2
 iCeSEXYs9AATx8ACTHGOGieTlmJP5MeEgsu3zr4KSFcpXBpyPrr7jFMDZc1vwzJ9wDt6MNWsybz
 Tybm5rHfnuELwzv+909qp3BqBfGgq0EGMzFeggWbIUfLacJKsFg8xDDhINJx2GeQgf9+EV0YBTi
 UVvp0FZehiBRS9/BROE6Kah9/hpeWhq4ZovZoOafr2UZaYy/9daleU3Ooxk60buyarBslon7A4q
 VqjUQ++ucgAk4FnlpBByd/xDt5Aq40qT70EdMQROo8NHJARTwdwS/y9
X-Received: by 2002:a05:6000:430a:b0:482:e658:bb8e with SMTP id
 ffacd0b85a97d-482e658bdf2mr16596497f8f.12.1787834102711; 
 Thu, 27 Aug 2026 05:35:02 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18?
 ([2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e279ecaesm9136454f8f.6.2026.08.27.05.34.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 05:35:01 -0700 (PDT)
Message-ID: <186b189c-3aaf-4024-80cc-c4eda0b8878c@linaro.org>
Date: Thu, 27 Aug 2026 14:34:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/2] serial: msm_geni: Skip UART TX when no cable is
 connected
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 casey.connolly@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 varadarajan.narayanan@oss.qualcomm.com, quentin.schulz@cherry.de,
 stefan.roese@mailbox.org, xypron.glpk@gmx.de, jbx6244@gmail.com,
 hehongbo918@gmail.com, quic_timple@quicinc.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20260827073436.4113558-1-aswin.murugan@oss.qualcomm.com>
 <20260827073436.4113558-2-aswin.murugan@oss.qualcomm.com>
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
In-Reply-To: <20260827073436.4113558-2-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/27/26 09:34, Aswin Murugan wrote:
> Add MSM_GENI_SERIAL_CABLE_DETECT Kconfig option and detect a
> persistent RX-line BREAK condition (no S_GP_IRQ_3 after
> S_GP_IRQ_2) to identify a disconnected debug UART cable, and
> suppress TX output in that case to avoid driving an
> unterminated line.

Or maybe we can just reduce the log level to the minimal in case
we still have TX connected to something ?

Neil

> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>   drivers/serial/Kconfig           |  9 +++++++
>   drivers/serial/serial_msm_geni.c | 41 ++++++++++++++++++++++++++++++++
>   2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index ffc58d663ff..326088c7027 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -1020,6 +1020,15 @@ config MSM_GENI_SERIAL
>   	  Driver works in FIFO mode.
>   	  Multiple baudrates supported.
>   
> +config MSM_GENI_SERIAL_CABLE_DETECT
> +	bool "Disable GENI UART TX when no cable/console is connected"
> +	depends on MSM_GENI_SERIAL
> +	default n
> +	help
> +	  Detect a UART RX-line BREAK condition, which indicates that no
> +	  cable is connected to the debug UART port, and suppress UART TX
> +	  output.
> +
>   config MXS_AUART_SERIAL
>   	bool "MXS AUART"
>   	depends on DM_SERIAL
> diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
> index ff91e0018fa..8bf5f6eea26 100644
> --- a/drivers/serial/serial_msm_geni.c
> +++ b/drivers/serial/serial_msm_geni.c
> @@ -98,6 +98,7 @@ struct msm_serial_data {
>   	u32 baud;
>   	u32 oversampling;
>   	struct clk *se;
> +	bool cable_connected;
>   };
>   
>   unsigned long root_freq[] = {7372800,  14745600, 19200000, 29491200,
> @@ -298,6 +299,28 @@ static u32 qcom_geni_serial_tx_empty(u64 base)
>   	return !readl(base + SE_GENI_TX_FIFO_STATUS);
>   }
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
>   /**
>    * geni_se_setup_s_cmd() - Setup the secondary sequencer
>    * @se:		Pointer to the concerned serial engine.
> @@ -384,6 +407,10 @@ static int msm_serial_putc(struct udevice *dev, const char ch)
>   {
>   	struct msm_serial_data *priv = dev_get_priv(dev);
>   
> +	if (CONFIG_IS_ENABLED(MSM_GENI_SERIAL_CABLE_DETECT) &&
> +	    !priv->cable_connected)
> +		return 0;
> +
>   	writel(DEF_TX_WM, priv->base + SE_GENI_TX_WATERMARK_REG);
>   	qcom_geni_serial_setup_tx(priv->base, 1);
>   
> @@ -565,6 +592,11 @@ static int msm_serial_probe(struct udevice *dev)
>   	qcom_geni_serial_start_rx(dev);
>   	qcom_geni_serial_start_tx(priv->base);
>   
> +	if (CONFIG_IS_ENABLED(MSM_GENI_SERIAL_CABLE_DETECT))
> +		priv->cable_connected = qcom_geni_serial_is_cable_connected(priv->base);
> +	else
> +		priv->cable_connected = true;
> +
>   	return 0;
>   }
>   
> @@ -615,6 +647,8 @@ static struct udevice init_dev = {
>   #error Clocks cannot be set at early debug. Change CONFIG_BAUDRATE
>   #endif
>   
> +static bool debug_uart_cable_connected = true;
> +
>   static inline void _debug_uart_init(void)
>   {
>   	phys_addr_t base = CONFIG_VAL(DEBUG_UART_BASE);
> @@ -623,12 +657,19 @@ static inline void _debug_uart_init(void)
>   	writel(DEF_RX_WM, base + SE_GENI_RX_WATERMARK_REG);
>   	geni_serial_baud(base, CLK_DIV, CONFIG_BAUDRATE);
>   	qcom_geni_serial_start_tx(base);
> +
> +	if (CONFIG_IS_ENABLED(MSM_GENI_SERIAL_CABLE_DETECT))
> +		debug_uart_cable_connected = qcom_geni_serial_is_cable_connected(base);
>   }
>   
>   static inline void _debug_uart_putc(int ch)
>   {
>   	phys_addr_t base = CONFIG_VAL(DEBUG_UART_BASE);
>   
> +	if (CONFIG_IS_ENABLED(MSM_GENI_SERIAL_CABLE_DETECT) &&
> +	    !debug_uart_cable_connected)
> +		return;
> +
>   	writel(DEF_TX_WM, base + SE_GENI_TX_WATERMARK_REG);
>   	qcom_geni_serial_setup_tx(base, 1);
>   	qcom_geni_serial_poll_bit(&init_dev, SE_GENI_M_IRQ_STATUS,

