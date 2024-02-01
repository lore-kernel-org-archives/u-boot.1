Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354BEC47DDF
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 09:34:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4987F87BFC;
	Thu,  1 Feb 2024 10:34:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gCYtmqvX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0752087BDC; Thu,  1 Feb 2024 10:34:29 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BBCE87C00
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 10:34:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40faf6788d1so10489575e9.0
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 01:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706780065; x=1707384865;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=FWnjM2d6X3XBQCsvd2no/ATyci7OmAXZv/TBmAnMUp8=;
 b=gCYtmqvXp9KP55+b5etnxCEuSSJ3yMxZIFA3HSV2lGVRhcMFrdicZ6K0Kc2nps/vC7
 tWWNDxXNmFZiXJiF/EmPOX7ph9MD6OBoinxdPGDUEboDE5IkjzeGh2udIo0lpXoRr8wK
 kONtzxUiyD3N2G57eccBrVGgnvYFN2+tZ7x6nHiwg6uusYMJMTkfj0JgJIGEFZTqpbqL
 YeEljgB/4I4mM3vUK//lN8VV3w32d+GpDjWCpythVsOcxpWejAXNJVgdp35VL2qM4KTt
 hH1NJI1tE5OJA0rSReXU2mH2mCQuHHwFw8A64tbbwM1PP5YPgBhDEBrgfZcC36hpuHp7
 +Ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706780065; x=1707384865;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FWnjM2d6X3XBQCsvd2no/ATyci7OmAXZv/TBmAnMUp8=;
 b=IyeB5zr9JhxothyEsjgT+o+wEkAJCGyJnSKHirTGmGtkkAUfnWAGn0tX6IXML6C7+u
 vFbVPFDfC87dAlLuFbx46PXIuTYg3QL8mkwzPLjX1TUYH/l4C6VmaU4/j02AwZfTAF6i
 +8tUHq51/vg3ihfrmTgWIJr06+8dOKmQd9AtYCSuoZyqLKY04eMUB85W3Zx+g7rpo2YC
 pj0wrMiriaXe6CvJqJAONo1v7AvFr+QSzCh1cIlJq//bKN9pAH++ZRk1dKgtT12JyVuK
 F2I64se+GXBzFxsn5636bn73rA8BVcpxxjHy97gtF1eu6jo1CXEqqT20bQ2Bsy/RROzh
 Mxsg==
X-Gm-Message-State: AOJu0Yxz9DgGsJS90n9eFx3ezbQBFgVVOINOUZja1B7DOwzLKJkKKVqs
 wCrZz82JWbs9jS2tjUSD0z5/0QyAd5YKrWCzLb8KAlOSYTNsrNQGSEooj1qipkc=
X-Google-Smtp-Source: AGHT+IFlNID8znGpaqcjM1bdMTXRNqnRMSchR4A/pQAtPk3DU03FvtEZBJUgHRsMVoVTEWFA5cYqOA==
X-Received: by 2002:adf:f58b:0:b0:33a:f601:fa69 with SMTP id
 f11-20020adff58b000000b0033af601fa69mr3652718wro.5.1706780065353; 
 Thu, 01 Feb 2024 01:34:25 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUm5nJcSLhvv2yFehHv4q3T7/c0Zp5TVusUUp/ulwIxyP4SxYiqAcfrE80SyEczQs7sOEPtAz8Z6/q5TaELAKIQHWNR8BrYfqlkf0SSTMojrkREVN+0s/DtLz25qLPhTDAVSxvUDphvyvgp9dB5GtSiNdsdx37tOkZ0ybq7ZYNOWYtEyvZ3jqFwR/bWivse8EP8QA==
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 y7-20020a5d6147000000b0033b0d2ba3a1sm2348472wrt.63.2024.02.01.01.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 01:34:24 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Caleb
 Connolly <caleb.connolly@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/5] usb: dwc3-generic: implement Qualcomm wrapper
In-Reply-To: <20240131-b4-qcom-usb-v1-1-6438b2a2285e@linaro.org>
References: <20240131-b4-qcom-usb-v1-0-6438b2a2285e@linaro.org>
 <20240131-b4-qcom-usb-v1-1-6438b2a2285e@linaro.org>
Date: Thu, 01 Feb 2024 10:34:23 +0100
Message-ID: <87h6ismstc.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Caleb,

Thank you for the patch.

On mer., janv. 31, 2024 at 14:57, Caleb Connolly <caleb.connolly@linaro.org> wrote:

> The Qualcomm specific dwc3 wrapper isn't hugely complicated, implemented
> the missing initialisation for host and gadget mode.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/usb/dwc3/dwc3-generic.c | 99 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 98 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 48da621ba966..1119cdecd26d 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -419,6 +419,99 @@ struct dwc3_glue_ops ti_ops = {
>  	.glue_configure = dwc3_ti_glue_configure,
>  };
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
> +static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
> +{
> +	u32 reg;
> +
> +	reg = readl(base + offset);
> +	reg |= val;
> +	writel(reg, base + offset);

Why can't we use the setbits() macro here?
see: arch/arm/include/asm/io.h

> +
> +	/* ensure that above write is through */
> +	readl(base + offset);
> +}
> +
> +static inline void dwc3_qcom_clrbits(void __iomem *base, u32 offset, u32 val)
> +{
> +	u32 reg;
> +
> +	reg = readl(base + offset);
> +	reg &= ~val;
> +	writel(reg, base + offset);

Same question for clrbits()

> +
> +	/* ensure that above write is through */
> +	readl(base + offset);
> +}
> +
> +static void dwc3_qcom_vbus_override_enable(void __iomem *qscratch_base, bool enable)
> +{
> +	if (enable) {
> +		dwc3_qcom_setbits(qscratch_base, QSCRATCH_SS_PHY_CTRL,
> +				  LANE0_PWR_PRESENT);
> +		dwc3_qcom_setbits(qscratch_base, QSCRATCH_HS_PHY_CTRL,
> +				  UTMI_OTG_VBUS_VALID | SW_SESSVLD_SEL);
> +	} else {
> +		dwc3_qcom_clrbits(qscratch_base, QSCRATCH_SS_PHY_CTRL,
> +				  LANE0_PWR_PRESENT);
> +		dwc3_qcom_clrbits(qscratch_base, QSCRATCH_HS_PHY_CTRL,
> +				  UTMI_OTG_VBUS_VALID | SW_SESSVLD_SEL);
> +	}
> +}
> +
> +/* For controllers running without superspeed PHYs */
> +static void dwc3_qcom_select_utmi_clk(void __iomem *qscratch_base)
> +{
> +	/* Configure dwc3 to use UTMI clock as PIPE clock not present */
> +	dwc3_qcom_setbits(qscratch_base, QSCRATCH_GENERAL_CFG,
> +			  PIPE_UTMI_CLK_DIS);
> +
> +	udelay(500);
> +
> +	dwc3_qcom_setbits(qscratch_base, QSCRATCH_GENERAL_CFG,
> +			  PIPE_UTMI_CLK_SEL | PIPE3_PHYSTATUS_SW);
> +
> +	udelay(500);
> +
> +	dwc3_qcom_clrbits(qscratch_base, QSCRATCH_GENERAL_CFG,
> +			  PIPE_UTMI_CLK_DIS);
> +}
> +
> +static void dwc3_qcom_glue_configure(struct udevice *dev, int index,
> +				     enum usb_dr_mode mode)
> +{
> +	void __iomem *qscratch_base = (void __iomem *)dev_read_addr(dev);
> +
> +	if (dev_read_bool(dev, "qcom,select-utmi-as-pipe-clk"))
> +		dwc3_qcom_select_utmi_clk(qscratch_base);
> +
> +	if (mode != USB_DR_MODE_HOST)
> +		dwc3_qcom_vbus_override_enable(qscratch_base, true);
> +}
> +
> +struct dwc3_glue_ops qcom_ops = {
> +	.glue_configure = dwc3_qcom_glue_configure,
> +};
> +
>  static int dwc3_rk_glue_get_ctrl_dev(struct udevice *dev, ofnode *node)
>  {
>  	*node = dev_ofnode(dev);
> @@ -506,6 +599,10 @@ static int dwc3_glue_reset_init(struct udevice *dev,
>  	else if (ret)
>  		return ret;
>  
> +	if (device_is_compatible(dev, "qcom,dwc3")) {
> +		reset_assert_bulk(&glue->resets);

Any reason for not doing error handling on reset_assert_bulk() like it's
done below ?

> +		udelay(500);
> +	}
>  	ret = reset_deassert_bulk(&glue->resets);
>  	if (ret) {
>  		reset_release_bulk(&glue->resets);
> @@ -623,7 +720,7 @@ static const struct udevice_id dwc3_glue_ids[] = {
>  	{ .compatible = "rockchip,rk3399-dwc3" },
>  	{ .compatible = "rockchip,rk3568-dwc3", .data = (ulong)&rk_ops },
>  	{ .compatible = "rockchip,rk3588-dwc3", .data = (ulong)&rk_ops },
> -	{ .compatible = "qcom,dwc3" },
> +	{ .compatible = "qcom,dwc3", .data = (ulong)&qcom_ops },
>  	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
>  	{ .compatible = "fsl,imx8mq-dwc3" },
>  	{ .compatible = "intel,tangier-dwc3" },
>
> -- 
> 2.43.0
