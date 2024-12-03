Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEB0E64AB6
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 14:51:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A76C894EE;
	Tue,  3 Dec 2024 15:51:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="zShNbFI4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1BB7894F0; Tue,  3 Dec 2024 15:51:47 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 921F888EA3
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 15:51:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2067566437=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3C3UFj017760
 for <u-boot@lists.denx.de>; Tue, 3 Dec 2024 15:51:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 CrLrc272jZBL6ueO1p8BbdAZYBLJBSZQJ7YgWlDmTZc=; b=zShNbFI4adhZyUaJ
 2u/NyeKppDaokLHgJlWvRemSgNQqtmwX5osVHzb/wFp3tsNEDu6y3fEb8Iaa4XHV
 bT5mQL+0gCm+5CugMgKadux4jNxK9JSUqtzCgDF+/Smrc2iwO9NjhY78TWXIlksh
 /CdtDaaHOdjFdXwoIgEO7As5OoJoiwEzSxSdCZRtirjey2KzkceQAz5m6ml0Ace9
 jyXuxcPfDAf7Lqnf++L7PJD8ikixxMD4T9jzGMAYNNVn78CD8u9y6aLqasdEbW3U
 hgYYXElUlXfUP2+NqWCeUzPX/lfgrSep9zkGRkK4BbqlAQ9y7I6nH+kGHHJHrYNy
 USW98w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 437tx25qf9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:51:45 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 629124002D
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 15:51:11 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C5851214632
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 15:51:06 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 3 Dec
 2024 15:51:06 +0100
Message-ID: <6e1ec873-12e2-4d71-9d3b-1c2b0d2308fa@foss.st.com>
Date: Tue, 3 Dec 2024 15:51:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: onboard-hub: Update the bind function based on
 "peer_hub" property
To: <u-boot@lists.denx.de>
References: <20241203044950.119197-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20241203044950.119197-1-venkatesh.abbarapu@amd.com>
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



On 12/3/24 05:49, Venkatesh Yadav Abbarapu wrote:
> Add the bool variable "peer_hub" and set this only for the
> hubs which have the "peer-hub" property in their DT nodes.
> Skip the bind function for usb hubs which don't have "peer-hub"
> property.
> 
> Fixes: 57e30b09fc ("usb: onboard-hub: Bail out if peer hub is already probed")
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>  common/usb_onboard_hub.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 6f28036e09..0a8fac38ee 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -26,6 +26,7 @@ struct onboard_hub {
>  
>  struct onboard_hub_data {
>  	unsigned long reset_us;
> +	bool peer_hub;
>  	unsigned long power_on_delay_us;
>  	int (*init)(struct udevice *dev);
>  };
> @@ -178,10 +179,15 @@ err:
>  
>  static int usb_onboard_hub_bind(struct udevice *dev)
>  {
> +	struct onboard_hub_data *data =
> +		(struct onboard_hub_data *)dev_get_driver_data(dev);
>  	struct ofnode_phandle_args phandle;
>  	const void *fdt = gd->fdt_blob;
>  	int ret, off;
>  
> +	if (!data->peer_hub)
> +		return 0;
> +
>  	ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle);
>  	if (ret)  {
>  		dev_err(dev, "peer-hub not specified\n");
> @@ -212,12 +218,14 @@ static int usb_onboard_hub_remove(struct udevice *dev)
>  }
>  
>  static const struct onboard_hub_data usb2514_data = {
> +	.peer_hub = false,
>  	.power_on_delay_us = 500,
>  	.reset_us = 1,
>  };
>  
>  static const struct onboard_hub_data usb5744_data = {
>  	.init = usb5744_i2c_init,
> +	.peer_hub = true,
>  	.power_on_delay_us = 1000,
>  	.reset_us = 5,
>  };

Tested on STM32MP157c-DK2 board

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
