Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8587C4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 20:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB1EC87C0A;
	Tue,  6 Feb 2024 21:36:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1707251795;
	bh=DQ9Rgfhha30B5DIzH5uXK1QMYkun7uPzZJ5/KShtoqk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RiWTiB6RRhKXI86ebEIIrIz0/CqE0XaInA8jkXsgUiTOpQgpbHdjyAQ3QPJ5oyAM6
	 KBheyqe1Fsjog36bpX0buI9EFTsJm5doIZCfCPYXIyby0cPPhoWrgUSZj83WdbsI0l
	 INdlzAPzrVsEBkPNqB47GaFn2Dqm7KU8gQk3VCP3Bluxsc9y3NTD5KmYhcXyManjtm
	 CE/XYPpZIYB1SuW8QsZ4EJzebpEeXxh2qXJAYTq9rT1Gj0CHvRV+EUyvJ2LkxxXc/+
	 5cWCenvJ05svp1xvlgjTamEBsNWtg2e8dXB6e+oFdCJMQyRVprYTQI+CIrm4OnLMz3
	 qakehon83R3YA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B921A877FB;
 Tue,  6 Feb 2024 21:36:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1707251794;
 bh=DQ9Rgfhha30B5DIzH5uXK1QMYkun7uPzZJ5/KShtoqk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=PoW1LrIzrze5RFDx2GONCBfz1d13er7b7mVIRLkkzNiayHptQA4YAUAtGv3/IdBem
 LLFlFlGCEuHWrKd73kllWdVshaj7HA2rz+v4KSrri+qyAI0tpn4vnXmyDX+lgTg/qL
 DSyg8kqDiRCLbKMIPJ+sBv5WOem7lPJmJ8P7U/q5ifJzwy7CAyg72vVtRxN+1mc/Q7
 PpttrUYWORRGgt0qzNVTFnAdNv2sk/45/5IOjOL0uRH4Fe1vN4Myc0QxW7zYnQFrQz
 CEwABFTZ75IT0UOJkYMO9OZI+UfyXXroel2iBY6ZKWhKFH/VH3A6zjkyszzvB3zXfj
 wuDondoA5Ex4g==
Message-ID: <ee020a2c-4f84-4fae-97a0-f12f3157d3ad@denx.de>
Date: Tue, 6 Feb 2024 21:36:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] usb: dwc3-generic: implement Qualcomm wrapper
Content-Language: en-US
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20240131-b4-qcom-usb-v1-0-6438b2a2285e@linaro.org>
 <20240131-b4-qcom-usb-v1-1-6438b2a2285e@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240131-b4-qcom-usb-v1-1-6438b2a2285e@linaro.org>
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

On 1/31/24 15:57, Caleb Connolly wrote:
> The Qualcomm specific dwc3 wrapper isn't hugely complicated, implemented
> the missing initialisation for host and gadget mode.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/usb/dwc3/dwc3-generic.c | 99 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 98 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 48da621ba966..1119cdecd26d 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -419,6 +419,99 @@ struct dwc3_glue_ops ti_ops = {
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

Newline here please

> +static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
> +{
> +	u32 reg;
> +
> +	reg = readl(base + offset);
> +	reg |= val;
> +	writel(reg, base + offset);

Use setbits_le32() .

> +	/* ensure that above write is through */
> +	readl(base + offset);

Is this needed ?

> +}
> +
> +static inline void dwc3_qcom_clrbits(void __iomem *base, u32 offset, u32 val)
> +{
> +	u32 reg;
> +
> +	reg = readl(base + offset);
> +	reg &= ~val;
> +	writel(reg, base + offset);

clrbits_le32()

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

Isn't there some possibility to poll for completion instead of fixed 
delay ? If so, use wait_for_bit or some such .

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

Can this be NULL ? If yes, add check for != NULL .

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
>   static int dwc3_rk_glue_get_ctrl_dev(struct udevice *dev, ofnode *node)
>   {
>   	*node = dev_ofnode(dev);
> @@ -506,6 +599,10 @@ static int dwc3_glue_reset_init(struct udevice *dev,
>   	else if (ret)
>   		return ret;
>   
> +	if (device_is_compatible(dev, "qcom,dwc3")) {
> +		reset_assert_bulk(&glue->resets);
> +		udelay(500);

Why this delay here ?

[...]
