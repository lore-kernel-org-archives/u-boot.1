Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF269CD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 18:59:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34F0C88CF6;
	Mon,  2 Sep 2024 20:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725303554;
	bh=5RvF0/eNrDBy4jAAq7wcDIyoKEDnyg21O1x1h/BTBzM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0LcgGAeaI5X8B47pkaDC7Z73g/9YrgxwMBqepdCWudN0suolXBIcoEiuxrav8Okc1
	 0TufU64/oPUxT0A2/dKfwIbI128oGYYvFC9uEiORczXdq0304ZkHc+96HAuzhvcIHS
	 0OJ6yqZFdkDwFji7OAdx+1j/Ih3gUsC9V3ykHvv8snxcHmeP+2OYm3yakscFeFgwYH
	 OzxAduW2JhJIBq0OkrxeHnP9Bv6xeSzQWw1HK197FXMEIz2huXetWvChpmvGI9I3Ba
	 S6J8mqGKTEhla+GnjB6YaAFxU4orvjWMaFDkIxI/gOzbvQvXrn+PW/TbKjx71Hh3iN
	 FB0+j0AJfHUHQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 54C9088CAF;
 Mon,  2 Sep 2024 20:59:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725303552;
 bh=5RvF0/eNrDBy4jAAq7wcDIyoKEDnyg21O1x1h/BTBzM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YpSGMXoURvG1UmfrQC5bipEFWG3dxazF7TIheBzzkm3sPPC7Sihm2EEAUDGp0eGQn
 CADhptGbNYW5NpPUWxXoexG8bYPjOAw4WA21UM5o/Pe4cHuPrCDoHuRYKwRa5pGdaH
 mLu7DJSfmVkVxzX+P0k8KRY/lcicJ3U6d+1FIMNB/xVHYAIPyOZ9t+JAa6EGqECdxN
 qX6UYVwL5aU8Tka2ERCy1lLbKhjaow4mLj9bI3S1hrN8W2B8zZdDw17wh87HylGfOC
 psc0bAyasRH8nMGD5VMLZ9SLGcqgHUIg1YmNi3+nNPataJeSiBY1CwxCNcyyHK8ZLt
 anl2Zvaifs4HA==
Message-ID: <538fdc56-d06f-4cdb-8467-2439a43e1725@denx.de>
Date: Mon, 2 Sep 2024 20:58:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] usb: onboard-hub: Bail out if peer hub is already
 probed
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20240605100221.3571-1-venkatesh.abbarapu@amd.com>
 <20240605100221.3571-6-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240605100221.3571-6-venkatesh.abbarapu@amd.com>
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
> Many physical hub chips include multiple logical hubs to handle both
> USB and 

Remove the 'and' here.

> 2 and 3

USB 2.0 and USB 3.0 .

>. Both logical hubs will then match the onboard hub
> driver, which means it will end up with two driver instances trying to
> control the reset GPIO that is only present once on the physical chip.
> 
> The reference for this change is taken from
> https://lore.barebox.org/barebox/20240327165554.894805-1-l.stach@pengutronix.de/
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   common/usb_onboard_hub.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 09ce452af1b..519bad337e1 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -11,6 +11,7 @@
>   #include <common.h>
>   #include <dm.h>
>   #include <dm/device_compat.h>
> +#include <dm/uclass-internal.h>
>   #include <i2c.h>
>   #include <linux/delay.h>
>   #include <power/regulator.h>
> @@ -21,7 +22,7 @@
>   #define USB5744_CONFIG_REG_ACCESS_LSB 0x99
>   
>   struct onboard_hub {
> -	struct udevice *vdd;
> +	struct udevice *vdd, *dev;

One field per line please.

>   	struct gpio_desc *reset_gpio;
>   };
>   
> @@ -106,8 +107,18 @@ static int usb_onboard_hub_probe(struct udevice *dev)
>   	struct onboard_hub_data *data =
>   		(struct onboard_hub_data *)dev_get_driver_data(dev);
>   	struct onboard_hub *hub = dev_get_priv(dev);
> +	struct ofnode_phandle_args phandle;
> +	struct udevice *hub_dev;
>   	int ret;
>   
> +	if (!dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle)) {
> +		if (ofnode_valid(phandle.node)) {
> +			ret = uclass_find_device_by_ofnode(UCLASS_USB_HUB, phandle.node, &hub_dev);
> +			if (hub_dev && hub_dev->priv_)
> +				return 0;
> +		}
> +	}
> +

Implement .bind function of this driver, bind the correct "half" of the 
hub that you want the driver to bind to, and return -ENODEV for the 
other "half". See rpc_spi_bind() in drivers/spi/renesas_rpc_spi.c for 
example of this.
