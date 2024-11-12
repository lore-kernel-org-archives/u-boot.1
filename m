Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B8BD41D55
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 05:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3310189393;
	Tue, 12 Nov 2024 06:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731391151;
	bh=cdfA8DNpt97GP5OEiu525uvp0YCppZJvSF0V7xIdIy4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MEc/WtVpY+epyGHuXDRftiEPwFEHJ56ZBDyozBXXc8uWKaJVx7Fcxdl8Kbinf8xtQ
	 Y6Nq47Q9XmWxkx9rxYuV2Jd8TZ3it8hCCu36aX+pimYpxMfvZ12tgh2f24p5Zvsih7
	 o7NrV87NgzCyQHhV0kIlOgC9oW9nPz3FV/X01WRfVrUCMROqxJXSk6qomh3OnYy8F1
	 wPJkw4iLCaZ10G+n/HnIngzYamlTrBwNrRaBgb9C6IlRa7Gi6isP2h4IZqON0lh3dl
	 rDlJVZJ5nliqPul0oC6m66dUNN+o19eKpYbhAgCvVQXb+ZKz54lwmABXeyBZdmxX7X
	 L8PO6GGY4Q8uA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 267AA89175;
 Tue, 12 Nov 2024 06:59:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731391149;
 bh=cdfA8DNpt97GP5OEiu525uvp0YCppZJvSF0V7xIdIy4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=uIhU1CgsJ/w2GIKNZjizKRQS0J5cMa5RIyn0zCvxlf+1b31NOn40/mPO3XNqIgJG7
 2zgIW7SZmHrqVk0sTwdKrX5cgW3raEODEy2KgEjBCfMdTd5WZ/9WMj3YOE2k24JDAS
 1o0HkVwQ2czpWVDbjlusD7Az0jyPxbUAOPrrLxVdAe8A4seWIKydtaE4YdyiXhdXDo
 86LERWq/qHFVB+oTpAeFeMtHPlyvbDpdeNxB83a+86O6q7ELvmTehnHEOe/ANJ9nd7
 FX1YplULvfAIQxorB6QzknURdZVUG3XxvSkoazg3goYRWv6IFfstFYrlRhfmnO2N3+
 uYLSnnQEX0Cmw==
Message-ID: <d61ab683-744d-4024-a5d3-71b372e85d02@denx.de>
Date: Tue, 12 Nov 2024 06:58:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/7] usb: onboard-hub: add support for Microchip
 USB5744
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241112050740.15343-1-venkatesh.abbarapu@amd.com>
 <20241112050740.15343-4-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241112050740.15343-4-venkatesh.abbarapu@amd.com>
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

On 11/12/24 6:07 AM, Venkatesh Yadav Abbarapu wrote:
> Add support for the Microchip USB5744 USB3.0 and USB2.0 Hub.
> The usb5744 driver trigger hub reset signal after soft reset.
> The usb5744 hub need to reset after the phy initialization,
> which toggles the gpio.
> Also update the usb2514 hub_data with the reset delay as 1us.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Reviewed-by: Marek Vasut <marex@denx.de>
> ---
>   common/usb_onboard_hub.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 827ecf9b02..1d146eccee 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -88,10 +88,26 @@ static int usb_onboard_hub_remove(struct udevice *dev)
>   	return ret;
>   }
>   
> +static const struct onboard_hub_data usb2514_data = {
> +	.reset_us = 1,
> +};
> +
> +static const struct onboard_hub_data usb5744_data = {
> +	.power_on_delay_us = 10000,
> +	.reset_us = 10000,
> +};
> +
>   static const struct udevice_id usb_onboard_hub_ids[] = {
>   	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
> -	{ .compatible = "usb424,2514" }, /* USB2514B USB 2.0 */
> -	{ }
> +	{	.compatible = "usb424,2514", /* USB2514B USB 2.0 */
> +		.data = (ulong)&usb2514_data,
This ^ hub has to be updated in 1/7 , otherwise if only 1/7 is applied 
(e.g. during bisect), this hub reset will be operated out of specification.

Also, looking at the USB2514 datasheet figure 5-3, it seems the hub 
needs t4=500us recovery time in SMBus mode. Does that mean usb2514_data 
.power_on_delay_us = 500 is missing too ?

Also, it seems t_rstio is 5us in USB5477 datasheet figure 10-4 , where 
do these 10000us figures above come from ?
