Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268F6C10F1A
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 02:02:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65D65882DB;
	Wed,  8 May 2024 04:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715133763;
	bh=6Qk9OnTjMt7jzdyhPf3BL/RB9if9uD4hEGKrB8YyVmM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BURwhD3yZZccMMatlmS7UoKXy2rKLJOwJExM6C+HNiFKhac/uKjTaB6rq25ZWTzeZ
	 TkiGtf8Vo9CRHXV2RyMeXZAI+zwSGUxcoh0gF7AsD6mWuUnAye6IJMqk1NDAp4spNv
	 Ov5xWcTQk9AMBSMfb2fsTbasudc6kfiFN0NpyvK0GhSiKuha5T805D6SUAnYvwV/LK
	 O8DTScyd//h35rjih4vAbEsAnUDlcB1vvQYXIVaZwmZWnM01iwSUHDrCdQIcSwPSJV
	 Stu9SuebkNLPz3a02NtRYRC5sCq4AGnld/bVjT5VwPbhkmK3YDFAuB4V9HRzYgz+nG
	 afrqYOLZW0xqQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D7F0188423;
 Wed,  8 May 2024 04:02:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715133762;
 bh=6Qk9OnTjMt7jzdyhPf3BL/RB9if9uD4hEGKrB8YyVmM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SrhGlpCxdnrnkbKAArBw+GFBbuY7bhlOzliOcvh8GBZQB7+FwOAbDymiVn8qazo2r
 DPHPlpf6K7XNRK8vSTo/7SV70m28PA8SSmUpdmca3keaOjV+tfCvt1mFV8LgfRAlza
 ZeGFvbvl5IAhcAjHYcBmfmhVOeYh33ND3102IbNWUaXVaCi/5oOhgq8CTq5gGasYPZ
 eZ9nJzXXF4TXQp+GKCxRiWeq+cm+bRI58e0Hw6TPRnWeZfQC9Sr+iMmdTq1yd33wmO
 VmMtKtPhtADrLXcC0dqoFjF7G9VFMGtXRCwmJX7VoG5rzHdZFpHXcZK1QDXW+fumpg
 Ba7yUW9laDnww==
Message-ID: <e9205e96-720a-48da-abd0-2fae5e31e155@denx.de>
Date: Wed, 8 May 2024 03:27:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] usb: cdns3: Set USB PHY mode in cdns3_probe()
To: Minda Chen <minda.chen@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
References: <20240504150358.19600-1-minda.chen@starfivetech.com>
 <20240504150358.19600-2-minda.chen@starfivetech.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240504150358.19600-2-minda.chen@starfivetech.com>
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

On 5/4/24 5:03 PM, Minda Chen wrote:
> USB PHY maybe need to set PHY mode in different USB
> dr mode. So translate to generic PHY mode and call
> generic_phy_set_mode().
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>   drivers/usb/cdns3/core.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index 12a741c6ea..c1a61471f9 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -321,6 +321,7 @@ static int cdns3_probe(struct cdns3 *cdns)
>   {
>   	struct udevice *dev = cdns->dev;
>   	int ret;
> +	int mode = PHY_MODE_INVALID;

Please swap ret and mode to keep this list sorted.

>   	cdns->xhci_regs = dev_remap_addr_name(dev, "xhci");
>   	if (!cdns->xhci_regs)
> @@ -372,6 +373,22 @@ static int cdns3_probe(struct cdns3 *cdns)
>   	if (ret)
>   		return ret;
>   
> +	if (cdns->dr_mode == USB_DR_MODE_HOST)
> +		mode = PHY_MODE_USB_HOST;
> +	else if (cdns->dr_mode == USB_DR_MODE_PERIPHERAL)
> +		mode = PHY_MODE_USB_DEVICE;
> +	else if (cdns->dr_mode == USB_DR_MODE_OTG)
> +		mode = PHY_MODE_USB_OTG;
> +
> +	if (mode != PHY_MODE_INVALID) {

Better invert the condition this way to reduce indent:

if (mode == PHY_MODE_INVALID) {
   dev_err(...report the error...);
   return ret;
}

ret = generic_phy_set...

> +		ret = generic_phy_set_mode(&cdns->usb2_phy, mode, 0);
> +		if (ret)
> +			return ret;
> +		ret = generic_phy_set_mode(&cdns->usb3_phy, mode, 0);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	dev_dbg(dev, "Cadence USB3 core: probe succeed\n");
>   
>   	return 0;

