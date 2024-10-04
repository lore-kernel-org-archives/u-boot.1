Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E391CF8843
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 14:44:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 483CA88C4C;
	Fri,  4 Oct 2024 16:44:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DKy+sucI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E33CD88C7B; Fri,  4 Oct 2024 16:44:47 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF68588B86
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 16:44:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 494EigZh122556;
 Fri, 4 Oct 2024 09:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728053082;
 bh=bNio6mpLYDejKPgdfHMm6lmr31C0FI8nlqTN1eT1miQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=DKy+sucIg4zOTlYoov0nbm8S5DLAUbH032PqlT00MnVHFlYMubCVuHjJ3AyY/pf+S
 erjOvyM5ueLax3hjXI9EAcHbgiSyBRcc2RI0jUD2/RnE4SH/YfCKm0Akp+/wo9xzyv
 LYHE/XF6LUov62ysd7/39kjyd30BHYCHHnlV87gg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 494EiglL026251
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 4 Oct 2024 09:44:42 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Oct 2024 09:44:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Oct 2024 09:44:41 -0500
Received: from [10.250.151.109] ([10.250.151.109])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 494EicuS091075;
 Fri, 4 Oct 2024 09:44:38 -0500
Message-ID: <cf65599a-cdc2-4d72-b999-2f5dfcda9bff@ti.com>
Date: Fri, 4 Oct 2024 20:14:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] dma: ti: k3-udma: Move DMA channel[0] allocation to
 probe and add udma_remove()
To: Prasanth Babu Mantena <p-mantena@ti.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <n-francis@ti.com>,
 <vaishnav.a@ti.com>, <s-k6@ti.com>
References: <20241004132057.1449909-1-p-mantena@ti.com>
 <20241004132057.1449909-5-p-mantena@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20241004132057.1449909-5-p-mantena@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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


On 10/4/2024 6:50 PM, Prasanth Babu Mantena wrote:
> From: Santhosh Kumar K <s-k6@ti.com>
>
> Currently, the allocation of DMA channel[0] for memcpy is happening
> in udma_transfer() for every transfer, which leads to a huge overhead
> for each transfer, especially in case of nand page reads. So, move this

> [..]
>   
> @@ -2590,6 +2565,7 @@ static int udma_probe(struct udevice *dev)
>   	struct udevice *tmp;
>   	struct udevice *tisci_dev = NULL;
>   	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
> +	struct udma_chan *uc;
>   	ofnode navss_ofnode = ofnode_get_parent(dev_ofnode(dev));
>   
>   	ud->match_data = (void *)dev_get_driver_data(dev);
> @@ -2714,6 +2690,42 @@ static int udma_probe(struct udevice *dev)
>   
>   	uc_priv->supported = DMA_SUPPORTS_MEM_TO_MEM | DMA_SUPPORTS_MEM_TO_DEV;
>   
> +	uc = &ud->channels[0];
> +	switch (ud->match_data->type) {
> +	case DMA_TYPE_UDMA:
> +		ret = udma_alloc_chan_resources(uc);
> +		break;
> +	case DMA_TYPE_BCDMA:
> +		ret = bcdma_alloc_chan_resources(uc);
> +		break;
> +	default:
> +		return -EINVAL;

shouldn't we treat this default case as error and do some dev_err prints ?


> +	};
> +
> +	if (ret) {
> +		dev_err(dev, " Channel 0 allocation failure %d\n", ret);
> +		return ret;

No need of this ret


> +	}
> +
> +	return 0;


do 'return ret' here


> +}
> +
> +static int udma_remove(struct udevice *dev)
> +{
> +	struct udma_dev *ud = dev_get_priv(dev);
> +	struct udma_chan *uc = &ud->channels[0];
> +
> +	switch (ud->match_data->type) {
> +	case DMA_TYPE_UDMA:
> +		udma_free_chan_resources(uc);
> +		break;
> +	case DMA_TYPE_BCDMA:
> +		bcdma_free_bchan_resources(uc);
> +		break;
> +	default:
> +		return -EINVAL;

shouldn't we treat this default case as error and do some dev_err prints ?


> +	};
> +
>   	return 0;
>   }
>   
> @@ -2855,5 +2867,7 @@ U_BOOT_DRIVER(ti_edma3) = {
>   	.of_match = udma_ids,
>   	.ops	= &udma_ops,
>   	.probe	= udma_probe,
> +	.remove = udma_remove,
>   	.priv_auto	= sizeof(struct udma_dev),
> +	.flags  = DM_FLAG_OS_PREPARE,
>   };
