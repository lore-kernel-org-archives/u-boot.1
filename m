Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB97BC54E60
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 12:44:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42E6D87F63;
	Tue, 12 Mar 2024 13:44:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="5JD6hVz0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB7EB87F64; Tue, 12 Mar 2024 13:44:01 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA8B187F60
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 13:43:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=380108150e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42CAD5Sx019102; Tue, 12 Mar 2024 13:43:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=Gq6kH2OGGP9BMy9EbfieGQfsh7zW0VtqE57mS1Kjygg=; b=5J
 D6hVz0724Eo2oaVCd5GyAtpNeAwYHc/ZnhawbXPtY89tcu8M5ALJt3z9J1fZmEDI
 RbHRaQQcivtlo5mVfBYW3vu2JJvETkK/1LyhOaaGGXT4L1jLL6FmOEJhzoY563yX
 mOSpVt5jhQdK/9G225OPLSTciRMtstUhWVEXn72a6x63EOMXm0NwAfnxGM7k4KD/
 FPb6HeTLjI/a4JYz9wzbkoHswIHuSlxFhuuefEr3rD2KBdDLCHU/Xd2thuVjdhnp
 mrEnID7eWxz/CpTDSxZkb25cpDGyfq705x7EBxU4wsooOX06g5+zAXRQkU1yEevA
 tDADqlijwVDnXWlo+ghA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wrds8n8f6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 13:43:49 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 30FD74002D;
 Tue, 12 Mar 2024 13:43:46 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 90C64267821;
 Tue, 12 Mar 2024 13:43:20 +0100 (CET)
Received: from [10.201.20.71] (10.201.20.71) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Mar
 2024 13:43:20 +0100
Message-ID: <d10d067d-ef53-490e-8383-b95f85234b6f@foss.st.com>
Date: Tue, 12 Mar 2024 13:43:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] net: dwc_eth_qos: Request clk-ck earlier in probe
 on STM32
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Christophe Roullier
 <christophe.roullier@st.com>, Joe Hershberger <joe.hershberger@ni.com>,
 "Ramon Fried" <rfried.dev@gmail.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240309021831.264018-1-marex@denx.de>
 <20240309021831.264018-10-marex@denx.de>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240309021831.264018-10-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.71]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-12_01,2023-05-22_02
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



On 3/9/24 03:11, Marek Vasut wrote:
> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Request the clk-ck earlier in probe in preparation for obtaining
> the clock rate from these clk-ck in eqos_probe_syscfg_stm32() in
> the follow up patch.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> Cc: Christophe Roullier <christophe.roullier@st.com>
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Ramon Fried <rfried.dev@gmail.com>
> Cc: u-boot@dh-electronics.com
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  drivers/net/dwc_eth_qos_stm32.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c
> index 33477925ff1..4db18130765 100644
> --- a/drivers/net/dwc_eth_qos_stm32.c
> +++ b/drivers/net/dwc_eth_qos_stm32.c
> @@ -201,6 +201,11 @@ static int eqos_probe_resources_stm32(struct udevice *dev)
>  		return -EINVAL;
>  	}
>  
> +	/* Get ETH_CLK clocks (optional) */
> +	ret = clk_get_by_name(dev, "eth-ck", &eqos->clk_ck);
> +	if (ret)
> +		dev_dbg(dev, "No phy clock provided %d", ret);
> +
>  	ret = eqos_probe_syscfg_stm32(dev, interface);
>  	if (ret)
>  		return -EINVAL;
> @@ -223,11 +228,6 @@ static int eqos_probe_resources_stm32(struct udevice *dev)
>  		goto err_probe;
>  	}
>  
> -	/*  Get ETH_CLK clocks (optional) */
> -	ret = clk_get_by_name(dev, "eth-ck", &eqos->clk_ck);
> -	if (ret)
> -		dev_warn(dev, "No phy clock provided %d\n", ret);
> -
>  	dev_dbg(dev, "%s: OK\n", __func__);
>  
>  	return 0;
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
