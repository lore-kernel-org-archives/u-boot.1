Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BFDCD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 18:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7701A88CEA;
	Mon,  2 Sep 2024 20:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725303552;
	bh=7cGcmGh6ZH6pXoiRrtf/IjdAfldFmsb8/6W6bGHmX2s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CirEiD4+PT+cftbG1NQTgruUwOS0GlmIyf3PKdAHXkBASrVOfFIBBnSbwFNAMJX6z
	 gnTUzVLhqsBdVhgU2e3ao22cJMQmiux5lLtytuYI5lKsnY4Jg6qetnFxqSJjDLpiCg
	 knkGOKSxjfdjeel42vDEVs2pN8d51xOSsO19ROUa+Dk/eDdTajeqLeK/vfEhmQdaz+
	 gOBhz9DKU/6ohLGKQUtQkaz+z0K/u9AKLeNbkSwlteyoyHcMzymBnc4O12xyT+uayV
	 LrR2pITgDGupzC1Suatm1ONWYbh1v8W6a4L4cdsHfmWOgEDOGw2rlHXv5U1pH0dZDA
	 ZbpOzW/1qojaA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2C68A887D1;
 Mon,  2 Sep 2024 20:59:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725303551;
 bh=7cGcmGh6ZH6pXoiRrtf/IjdAfldFmsb8/6W6bGHmX2s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fNhL9HZ416yqGp7NQJ8FLUG6JFzO6BMt7IdstgTvlKFitbVCoyyV6do0j/8UNs2bT
 wT15aNu0R/A8/dw9acRBBV8aiP0UW7DVv0CkTBrrrq+Bny41Nx3avCW6V3+PH7IYlI
 rpKv2nyoT3mTXBFKdnIzAmQxg1f5937BZf6lM/luvH6qHdx556SKkkWSMAc6V4UDI9
 pzoG/O+Ck8R49OOAkcfk5do301GfWH1c4wD9Wz09rhe/Kwl9vqRGSSiXinI/6OH0cO
 jJdvX+TbE3SLTTH08MfjXMXsFZi8sbZpFblJuD1vzZkIifWZHe7vktgjou6oTtGDUE
 DGwtzpJApBh+A==
Message-ID: <79cadc15-2d38-4665-bf44-5a66bfc2a324@denx.de>
Date: Mon, 2 Sep 2024 20:46:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] usb: onboard-hub: add support for Microchip USB5744
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20240605100221.3571-1-venkatesh.abbarapu@amd.com>
 <20240605100221.3571-4-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240605100221.3571-4-venkatesh.abbarapu@amd.com>
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

On 6/5/24 12:02 PM, Venkatesh Yadav Abbarapu wrote:
> Add support for the Microchip USB5744 USB3.0 and USB2.0 Hub.
> The usb5744 driver trigger hub reset signal after soft reset.
> The usb5744 hub need to reset after the phy initialization,
> which toggles the gpio.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   common/usb_onboard_hub.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 0cfaa90fce3..50870285995 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -88,11 +88,21 @@ static const struct onboard_hub_data usb2514_data = {
>   	/* TBD */
>   };
>   
> +static const struct onboard_hub_data usb5744_data = {
> +	.reset_us = 10000,
> +};
> +
>   static const struct udevice_id usb_onboard_hub_ids[] = {
>   	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
>   	{
>   		.compatible = "usb424,2514", /* USB2514B USB 2.0 */
>   		.data = (ulong)&usb2514_data,
> +	}, {
> +		.compatible = "usb424,5744", /* USB5744 USB 3.0 */
> +		.data = (ulong)&usb5744_data,
> +	}, {
> +		.compatible = "usb424,2744", /* USB2744 USB 2.0 */
> +		.data = (ulong)&usb5744_data,
>   	}

Keep the list sorted.
