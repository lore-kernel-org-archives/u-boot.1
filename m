Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67533C54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 22:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD14488010;
	Mon, 18 Mar 2024 23:53:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710802381;
	bh=LgbGbwP4oQJOQjnUp0xOwAT/MsYCf/09EBAuaUtgy/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0TTADSInVxocVxJIp44jXPzoQdANA8BFypAsbk+O2ZyG1H6ARjTke8OtjHIX0N8cy
	 Qlr7XNBh5ZbJUM3xfWULap+EzOp3HywEgaxNJgwfggpvQiqd6/yLP34axGHuk8u/dY
	 6w0otn4Gl2UJyrDIElxD/7yszSUvoiVQev7PcbEm1ru0wZvRPfDT6CMrWS+1XKjPTh
	 2my4f3k0GzmvT6mMvUCHMDZ80XAmIGw7iJTYyL6WQs2WmRHO2ngcRmBG+L/cPKpote
	 NMTQ8FkNWe2f7ZicPazR6FI8SZlpcvLOFQzOUmmX8E70tbjKmkY6B6C4WxzM6cMZCC
	 Ic1J9iYdZMQ1A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E808487513;
 Mon, 18 Mar 2024 23:52:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710802379;
 bh=LgbGbwP4oQJOQjnUp0xOwAT/MsYCf/09EBAuaUtgy/s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pmj1B8wQtrWzMEKTfmLED7kBOWkOd/MJ540ClGirypKQ/OyCUt5b/qo1vayhAlOZy
 T5cahJBL9mFP3gsH0W2aw2/sXbPC36wJ3/cZOVNBORq5DD/jTOnjsGglRZWCcGZQ7T
 rju55zCW/gKL2V8dIjpFXGW9e2aX9qwgY3o0gunsOOvG+jPvJk2Pq4xDBjflA5f8RH
 qvW5r/xy8ukz4xOH+sbR3MWzNfP1sMGc/fVyG6CtpbAJ+Aoc9Q7j71ZTTjkO6w8DDC
 RUBKeimmaRoVD76pI3twNWDuIW0F/Z0patfPEYXkOFApbRVKjCwfYJ8Xf3qDHiSkoL
 N98u9V4RKb0IQ==
Message-ID: <a38661aa-06c6-43cf-a04a-2ef9757d8bf9@denx.de>
Date: Mon, 18 Mar 2024 23:52:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] usb: dwc3-generic: implement Qualcomm wrapper
Content-Language: en-US
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20240315-b4-qcom-usb-v2-0-5467ec27cb26@linaro.org>
 <20240315-b4-qcom-usb-v2-1-5467ec27cb26@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240315-b4-qcom-usb-v2-1-5467ec27cb26@linaro.org>
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

On 3/15/24 4:06 PM, Caleb Connolly wrote:
> The Qualcomm specific dwc3 wrapper isn't hugely complicated, implemented
> the missing initialisation for host and gadget mode.
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/usb/dwc3/dwc3-generic.c | 81 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 80 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index a379a0002e77..5a355dd86c60 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -424,8 +424,79 @@ enum dwc3_omap_utmi_mode {
>   struct dwc3_glue_ops ti_ops = {
>   	.glue_configure = dwc3_ti_glue_configure,
>   };
>   
> +/* USB QSCRATCH Hardware registers */
> +#define QSCRATCH_HS_PHY_CTRL 0x10
> +#define UTMI_OTG_VBUS_VALID BIT(20)
> +#define SW_SESSVLD_SEL BIT(28)
> +
> +#define QSCRATCH_SS_PHY_CTRL 0x30
> +#define LANE0_PWR_PRESENT BIT(24)
> +
> +#define QSCRATCH_GENERAL_CFG 0x08

Keep the list sorted, 0x08 goes above 0x10 ^ up there.

> +#define PIPE_UTMI_CLK_SEL BIT(0)
> +#define PIPE3_PHYSTATUS_SW BIT(3)
> +#define PIPE_UTMI_CLK_DIS BIT(8)
> +
> +#define PWR_EVNT_IRQ_STAT_REG 0x58
> +#define PWR_EVNT_LPM_IN_L2_MASK BIT(4)
> +#define PWR_EVNT_LPM_OUT_L2_MASK BIT(5)
> +
> +#define SDM845_QSCRATCH_BASE_OFFSET 0xf8800
> +#define SDM845_QSCRATCH_SIZE 0x400
> +#define SDM845_DWC3_CORE_SIZE 0xcd00

The rest looks fine, with that fixed:

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
