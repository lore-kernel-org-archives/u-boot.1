Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FAFD2E9E4
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 12:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 840EE8936B;
	Mon, 11 Nov 2024 13:54:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731329651;
	bh=DdA3LQzuTkzgFF2mrk0CnX/snWYVoWJRQl7O8WH7nbU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q7OjzKeUG0j96U4NOuvl9yIOLcx6BWbU/Qzwz8HnoWVPU+nw5qkvSQUA2+uhXz3ha
	 norDETwzUEeN9WaXu84kO3Uw49sGX+SEWOh2vXBIXhsNk6mt3iBdIeLzubMwzOL7aL
	 IvWWDuhfV0zMhlHrIydXqT3INaRIlYehfhFqJuKt9wmUjh+Ok68TBKvw1qNiLdtlhB
	 8jnyN2sRhAzCaU/pJGE11oo1I9aSqeH6RvqnDj05dV+2psRCNW9b5WoKKmmIlZJT53
	 my0gY+L1flipJn8O6+9S+/9X+bMmvc1wmCgGot4YSW8iBTnQ4AK7j2L3rgCo4fXUuU
	 BlUeZL7VSSJaA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BAA2889189;
 Mon, 11 Nov 2024 13:54:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731329651;
 bh=DdA3LQzuTkzgFF2mrk0CnX/snWYVoWJRQl7O8WH7nbU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=L8+I/5SqZ8ofAf/nHGWXtcJneZvUkGNqahdF6AxsSZWonANy4h3XPCC2aCSct5gke
 H8sDANlPNEIJxCPhGgddj8F2fTbf4d2hlDw4WB/Rsxv9meDA9fSv6Pj8JNcxmLEwBj
 Oje4GTLitl666u7wIDFWvTQA13Zin2uDzTGXH4tUJibZnGlm+Z4HoeofMwaG5QQYEx
 pGXWd/rWkgka6LIrAjhNPlPGFLCPlHLd06sm0fmSiaApdUHsY1cOf2pWOKnNlQdeL6
 0j2ZH9xXpnN0K1lagaSrT4WELN1r+2GYc7nLg60Ti3p8cZwOETQxo2mHE28LJ+qY18
 vExBwuwA7nmpQ==
Message-ID: <33e22746-20fc-4956-a4c9-ef6723af33e0@denx.de>
Date: Mon, 11 Nov 2024 13:14:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/7] usb: onboard-hub: add support for Microchip
 USB5744
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241108035959.19970-1-venkatesh.abbarapu@amd.com>
 <20241108035959.19970-4-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241108035959.19970-4-venkatesh.abbarapu@amd.com>
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

On 11/8/24 4:59 AM, Venkatesh Yadav Abbarapu wrote:
> Add support for the Microchip USB5744 USB3.0 and USB2.0 Hub.
> The usb5744 driver trigger hub reset signal after soft reset.
> The usb5744 hub need to reset after the phy initialization,
> which toggles the gpio.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Reviewed-by: Marek Vasut <marex@denx.de>
> ---
>   common/usb_onboard_hub.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 827ecf9b02..e604c86d8a 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -88,10 +88,21 @@ static int usb_onboard_hub_remove(struct udevice *dev)
>   	return ret;
>   }
>   
> +static const struct onboard_hub_data usb5744_data = {
> +	.power_on_delay_us = 10000,
> +	.reset_us = 10000,
> +};
> +
>   static const struct udevice_id usb_onboard_hub_ids[] = {
>   	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
> -	{ .compatible = "usb424,2514" }, /* USB2514B USB 2.0 */
> -	{ }
> +	{	.compatible = "usb424,2514" /* USB2514B USB 2.0 */

Does this hub need any power_on_delay_us / reset_us delay too ?
Probably yes ? If so, please add the delay in 1/7 , otherwise there will 
be a fast reset pulse on the reset GPIO line which the hub may either 
not recognize, or worse, may make the hub latch up.

> +	}, {
> +		.compatible = "usb424,2744", /* USB2744 USB 2.0 */
> +		.data = (ulong)&usb5744_data,
> +	}, {
> +		.compatible = "usb424,5744", /* USB5744 USB 3.0 */
> +		.data = (ulong)&usb5744_data,
> +	}
