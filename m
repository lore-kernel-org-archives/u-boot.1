Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A286C27C75
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:09:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61708889BA;
	Fri, 14 Jun 2024 14:09:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="bpcubfrr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A3FA889C5; Fri, 14 Jun 2024 14:09:01 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4429A880F5
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6895721e93=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45E7tBhG023276;
 Fri, 14 Jun 2024 14:08:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 bwjItYVnJBR1pXBUVXOtRFQJ1QgliNpl1+duw7KTkAg=; b=bpcubfrrF3O6T+Zk
 lP2F/tB51UIbcjeTJZDh+MB0t/3CFivYe7RnJfwqjnBj28HOcH0rRNDcCwvL95i8
 kcdmQxLgyCSps1RuWV9VWLOhNlSWK0OCR/hdZcDLBEHFG3Oj2E0/rv/TVZHZKk9y
 c51HFmHimgGNUID+HSJl41dfSVU+Owd8E5peWSi40lmi7E1Q5Q01fsC1G1bLVWtC
 iuMtfxPxo4dv7gFb9nx+KfF/eZGp4BKT+VfhoFhKX+MdGm+Fzsi2A+mgBJ+z+J0T
 xII46lsoTfnVOmFn6ldsZUYoVptxC4PGMmqRJSL9toTLBIf/fRhTsnhY24deojkZ
 lOooVg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ypub3mn3u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 14:08:57 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DB8F540044;
 Fri, 14 Jun 2024 14:08:53 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 616612138DE;
 Fri, 14 Jun 2024 14:08:45 +0200 (CEST)
Received: from [10.252.18.60] (10.252.18.60) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 14 Jun
 2024 14:08:45 +0200
Message-ID: <167fb87e-73aa-4070-8904-a6304638e431@foss.st.com>
Date: Fri, 14 Jun 2024 14:08:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] net: dwc_eth_qos: add support for phy-reset-gpios
 property
To: Heesub Shin <heesub@gmail.com>, <u-boot@lists.denx.de>
References: <20240428142406.28445-1-heesub@gmail.com>
 <20240428142406.28445-4-heesub@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240428142406.28445-4-heesub@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.18.60]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_09,2024-06-14_03,2024-05-17_01
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



On 4/28/24 16:24, Heesub Shin wrote:
> This commit adds support for a property 'phy-reset-gpios' to reset PHY
> chipset.
> 
> Signed-off-by: Heesub Shin <heesub@gmail.com>
> ---
>  drivers/net/dwc_eth_qos_stm32.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c
> index fbc08bba1d..cffaa10b70 100644
> --- a/drivers/net/dwc_eth_qos_stm32.c
> +++ b/drivers/net/dwc_eth_qos_stm32.c
> @@ -266,6 +266,12 @@ static int eqos_probe_resources_stm32(struct udevice *dev)
>  	if (ret)
>  		dev_warn(dev, "No phy clock provided %d\n", ret);
>  
> +	/* Get reset gpio pin (optional) */
> +	ret = gpio_request_by_name(dev, "phy-reset-gpios", 0,
> +				   &eqos->phy_reset_gpio, GPIOD_IS_OUT);
> +	if (ret)
> +		pr_warn("No phy reset gpio provided: %d\n", ret);
> +
>  	dev_dbg(dev, "%s: OK\n", __func__);
>  
>  	return 0;
> @@ -277,6 +283,21 @@ err_probe:
>  	return ret;
>  }
>  
> +static int eqos_start_resets_stm32(struct udevice *dev)
> +{
> +	struct eqos_priv *eqos = dev_get_priv(dev);
> +
> +	debug("%s(dev=%p):\n", __func__, dev);
> +
> +	if (dm_gpio_is_valid(&eqos->phy_reset_gpio)) {
> +		dm_gpio_set_value(&eqos->phy_reset_gpio, 1);
> +		udelay(2);
> +		dm_gpio_set_value(&eqos->phy_reset_gpio, 0);
> +	}
> +
> +	return 0;
> +}
> +
>  static int eqos_remove_resources_stm32(struct udevice *dev)
>  {
>  	dev_dbg(dev, "%s:\n", __func__);
> @@ -292,7 +313,7 @@ static struct eqos_ops eqos_stm32_ops = {
>  	.eqos_probe_resources = eqos_probe_resources_stm32,
>  	.eqos_remove_resources = eqos_remove_resources_stm32,
>  	.eqos_stop_resets = eqos_null_ops,
> -	.eqos_start_resets = eqos_null_ops,
> +	.eqos_start_resets = eqos_start_resets_stm32,
>  	.eqos_stop_clks = eqos_stop_clks_stm32,
>  	.eqos_start_clks = eqos_start_clks_stm32,
>  	.eqos_calibrate_pads = eqos_null_ops,
Applied to u-boot-stm32/next

Thanks
Patrice
