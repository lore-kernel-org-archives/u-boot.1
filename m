Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E29D7832E
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 15:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1E6C88D94;
	Mon,  2 Dec 2024 16:19:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ceT5zRVb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93BE28641A; Mon,  2 Dec 2024 16:19:21 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9956088FDE
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 16:19:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2066b4005c=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2DtIL9014534;
 Mon, 2 Dec 2024 16:19:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 cPPRztb8hmM9+QhKscHfSpswTV5OhHNS4C2/8k33Mtg=; b=ceT5zRVbonYKK7LN
 RL9FV7jcOpJcXY3HVxmKZb86YOl5tvVpH5pCbKT0Z/wxF4Muickc7bIqisDw5iDG
 mEZglnnG0MF3Zd7/IPmCVAFd54IK7BIVGnmv1wF4ZN0B9uAC46u9LgjRZ9NxtgAJ
 nJP5dNS862ZijHsQ+FNL002RUU36qrRVn6P4JYdRZeqTrvVKDOmZWoGBoqdWbvKs
 W55v6nuhJ1Usf7AQ9pSl30FveZCoBaKzGNdoho9kY2HZXK0ME5LcyLnQsuZnhyun
 d1u6WJya33irw0kS2ZMvqy2U3BBCxzZmQ8d/y+YI4Jl39QgV7kiveNN/YyrV5W2d
 zFRjAw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 438ehnnu6h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Dec 2024 16:19:16 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9E69240061;
 Mon,  2 Dec 2024 16:18:10 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8658427157C;
 Mon,  2 Dec 2024 16:16:17 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 2 Dec
 2024 16:16:17 +0100
Message-ID: <b06d178a-3300-4f20-a852-bb9cf349a8b8@foss.st.com>
Date: Mon, 2 Dec 2024 16:16:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 5/5] usb: onboard-hub: Bail out if peer hub is already
 probed
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
References: <20241125041202.980-1-venkatesh.abbarapu@amd.com>
 <20241125041202.980-6-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20241125041202.980-6-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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



On 11/25/24 05:12, Venkatesh Yadav Abbarapu wrote:
> The .bind function is implemented to bind the correct
> "half" of the hub that the driver wants to bind,
> and returning -ENODEV for the other "half".
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Reviewed-by: Marek Vasut <marex@denx.de>
> ---
>  common/usb_onboard_hub.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index bf71266272..6f28036e09 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -176,6 +176,26 @@ err:
>  	return ret;
>  }
>  
> +static int usb_onboard_hub_bind(struct udevice *dev)
> +{
> +	struct ofnode_phandle_args phandle;
> +	const void *fdt = gd->fdt_blob;
> +	int ret, off;
> +
> +	ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle);
> +	if (ret)  {
> +		dev_err(dev, "peer-hub not specified\n");
> +		return ret;
> +	}
> +
> +	off = ofnode_to_offset(phandle.node);
> +	ret = fdt_node_check_compatible(fdt, off, "usb424,5744");
> +	if (!ret)
> +		return 0;
> +
> +	return -ENODEV;
> +}
> +
>  static int usb_onboard_hub_remove(struct udevice *dev)
>  {
>  	struct onboard_hub *hub = dev_get_priv(dev);
> @@ -218,6 +238,7 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
>  U_BOOT_DRIVER(usb_onboard_hub) = {
>  	.name	= "usb_onboard_hub",
>  	.id	= UCLASS_USB_HUB,
> +	.bind   = usb_onboard_hub_bind,
>  	.probe = usb_onboard_hub_probe,
>  	.remove = usb_onboard_hub_remove,
>  	.of_match = usb_onboard_hub_ids,

Hi All

This patch has been merged in v2025.01-rc3 (sha1 57e30b09fcfc88da72c310f979b35ed99a9b277c) 
and it avoids the STM32MP157c-DK2 board to boot: 

U-Boot 2025.01-rc3 (Dec 02 2024 - 16:10:28 +0100)

CPU: STM32MP157CAC Rev.B
Model: STMicroelectronics STM32MP157C-DK2 Discovery Board
Board: stm32mp1 in trusted mode (st,stm32mp157c-dk2)
Board: MB1272 Var2.0 Rev.C-01
DRAM:  512 MiB
usb_onboard_hub hub@1: peer-hub not specified
initcall failed at call c0123da5 (err=-2: No such file or directory)
### ERROR ### Please RESET the board ###

This boards embeds a "usb424,2514" hub, regarding the Documentation/devicetree/bindings/usb/microchip,usb2514.yaml, 
this kind of hub doesn't need the "peer-hub" property.

Patrice

