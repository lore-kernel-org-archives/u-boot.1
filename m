Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9C1D49221
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 13:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8168489432;
	Mon, 18 Nov 2024 14:34:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731936884;
	bh=6CI/eEezPvdDZji/pRTPMAcxDOawz2N2tpakEcySNdg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WbJmFpsU2eciTeBmDvVAdZPRovE+PRS/8FcYbdwBP4oGYJQEdf0oCC3n2sBaj4EXz
	 jut+UVfVla+ylv2IoMdYtAZR1sYFNjWBDPq0B/D+XKQr8wNPVbMzbwG6wdZopJq0SH
	 VH7gmoWDcEGh7+1BjOZFdTTwof9758mhBTJi6ns+5/L4R8oALDzobUyF4qMPI5AEml
	 WGQS7Sv9tvedj0ncAj7r2mX1GOPp70SH9syvwS4jJ3aJY/x3Gk7nI1bKsOZN9D71QB
	 7p0pmh8Gx9o4QK/mZ4NW5pDdDxH89m70Yj0d1/AGH17itKxN+DM8qfMmmo4qMXuPW1
	 aFkPtUbxakPlQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 853F489373;
 Mon, 18 Nov 2024 14:34:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731936882;
 bh=6CI/eEezPvdDZji/pRTPMAcxDOawz2N2tpakEcySNdg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JsnFK8PK/AB6ZRUG7HxZU2fFJosiRHJLPBMqEY/O/m2oW1p+pAw6/s/FYrr1nk6gb
 OvmnJ4WHzSRaLkj8XWoYhoxSQ+TkOu4HbhELAW16/5n77MPtNqW/CRNb3yiyzmZNB3
 VB4n7yNYStoNDJjIFMxoEQgburfIuNotGWxibqmuGOiR4CJxoVfkp/k6sPHKynEgPQ
 XFu0t/fUAhHGA00vXUWdjNlLd2a6rotBT//raE/j7J9r+4OLANXlc+MzKOd+VoZ1rx
 J1m2QH+gpnH4WhKtK4f6Zi5wi139j2iSPNB2VxVLlfrYxy6kEDEQoqelciDSfXiIPT
 zu0utQHySw5Mg==
Message-ID: <f32d7e41-60dd-48ea-8700-a9545d02bfe9@denx.de>
Date: Mon, 18 Nov 2024 14:18:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 3/7] usb: onboard-hub: add support for Microchip
 USB5744
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241118100747.30121-1-venkatesh.abbarapu@amd.com>
 <20241118100747.30121-4-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241118100747.30121-4-venkatesh.abbarapu@amd.com>
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

On 11/18/24 11:07 AM, Venkatesh Yadav Abbarapu wrote:
> Add support for the Microchip USB5744 USB3.0 and USB2.0 Hub.
> The usb5744 driver trigger hub reset signal after soft reset.
> The usb5744 hub need to reset after the phy initialization,
> which toggles the gpio.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Reviewed-by: Marek Vasut <marex@denx.de>
> ---
>   common/usb_onboard_hub.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 812e7749de..4860de5323 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -93,10 +93,21 @@ static const struct onboard_hub_data usb2514_data = {
>   	.reset_us = 1,
>   };
>   
> +static const struct onboard_hub_data usb5744_data = {
> +	.power_on_delay_us = 1000,
> +	.reset_us = 5,
> +};
> +
>   static const struct udevice_id usb_onboard_hub_ids[] = {
>   	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
>   	{	.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
>   		.data = (ulong)&usb2514_data,
> +	}, {
> +		.compatible = "usb424,2744",	/* USB2744 USB 2.0 */
> +		.data = (ulong)&usb5744_data,
> +	}, {
> +		.compatible = "usb424,5744",	/* USB5744 USB 3.0 */
> +		.data = (ulong)&usb5744_data,
>   	}
>   };
Let's finish the ongoing discussion in

Re: [PATCH v11 3/7] usb: onboard-hub: add support for Microchip USB5744

In the meantime, no need to send new versions of the series.

I retract my RB on this patch until the discussion is concluded too.
