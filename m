Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3867EC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 13:10:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73A5188080;
	Fri, 12 Apr 2024 15:10:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1712927437;
	bh=tkx+jf3vXzXQ4CF0z2avIO4yYlU/AtkXX3SZI/GtfHE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EtfsBgx2HJK3mJNPLVbTZkLdN7mCgbbKTrtwjyPgTCDVTkQrtPyPzq4m0Q7tox5DY
	 jUKBUxXJE10dHzqu/lgH8hFE7Olg3rXoLtBqn+i66Lotti3NjFKLRHqbvwF7ZvVQmE
	 c+EKu2Kl0imhdfle1nqtSj0qkptSNGzNRMl4nSGxozHq2lx9xNRz8WY8p4Ycfhnsn2
	 jgl8K9XhKG15mGzhmW0ZP6oeurYq5FYFF1v6KX96lvAuRuX5xi5UegW/TC7zZOtY2w
	 WoPBmsbftWCbowbAELwFL+Ru11X8v+QqvOTn0tlWAHVt76TvNdV4LA0pWgY+QyNvzB
	 iOMv2sXBKJr+g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8FFE088027;
 Fri, 12 Apr 2024 15:10:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1712927435;
 bh=tkx+jf3vXzXQ4CF0z2avIO4yYlU/AtkXX3SZI/GtfHE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tQ2UC5OAfA9jJCZ/Wj9mriMeSLbyQFnZC7Ynxn9ujRyqHl3gpWA/6CAolUTvj/uoc
 qg9Ei4DLzJHlufNJtWAyg6FiND83z+BmI5gd2tw7yFjneuZBhVNgmceXjqDt9WhSUC
 CSEdNnR9gc90CaMo/yVQFiveTFMXFe+ZfffTOvub33uJgmtkou9n+BE1NmGL40cDx4
 EHCPeQtu3rej1g0gIq85t/KIa7WEzcfcF60hbSbJp0so37Urp8E+wM+VmQ2rEKd2QO
 +SNvPIocL2tYedcf6rW9s8j1FhuCOiutViYz3xF79s27ptKOtfv4CHd4jcDQkTwAXc
 nvT5UZ4DegWaA==
Message-ID: <6a57bad0-3a24-4ba3-aad3-ac448d14022c@denx.de>
Date: Fri, 12 Apr 2024 15:06:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: musb-new: sunxi: support usage with DM_USB_GADGET
To: Aren Moynihan <aren@peacevolution.org>, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Sam Edwards <cfsworks@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
References: <20231231203930.1955090-1-aren@peacevolution.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231231203930.1955090-1-aren@peacevolution.org>
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

On 12/31/23 9:38 PM, Aren Moynihan wrote:
> Add support for building the sunxi-musb driver with DM_USB_GADGET
> including adding a separate IRQ handling function and registering the
> driver with the musb system differently.
> 
> The implementation of usb_gadget_register_driver from
> musb-new/musb_uboot.c only works when the gadget driver for the device
> has already been probed and has called musb_register. On the pinephone
> (using a allwinner a64 processor) this causes issues when trying to use
> usb gadget mode (such as from the ums command) and CONFIG_USB_ETHER is
> disabled.
> 
> The implementation of usb_gadget_register_driver provided when
> DM_USB_GADGET is enabled will probe the necessary drivers when it's
> called.
> 
> Without the patch, this is what the error condition looks like:
> => ums 0 mmc 1
> UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x3a3e000
> Controller uninitialized
> g_dnl_register: failed!, error: -6
> g_dnl_register failed
> 
> based on:
> commit 2e4865bc6486 ("musb-new: omap2430: fix compiling in DM_USB_GADGET config")
> 
> Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> ---
> I don't fully understand what's going on here. Some gadget mode drivers,
> such as usb ether (in usb_ether_init) will initialize the usb gadget
> driver, but others (ums, fastboot) don't seem to do this, or don't do it
> early enough, so they don't work.
> 
>   drivers/usb/musb-new/sunxi.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/usb/musb-new/sunxi.c b/drivers/usb/musb-new/sunxi.c
> index 91f082fe05e..9b06f49ce47 100644
> --- a/drivers/usb/musb-new/sunxi.c
> +++ b/drivers/usb/musb-new/sunxi.c
> @@ -429,6 +429,17 @@ static struct musb_hdrc_config musb_config_h3 = {
>   	.ram_bits	= SUNXI_MUSB_RAM_BITS,
>   };
>   
> +#ifdef CONFIG_DM_USB_GADGET
> +int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> +{
> +	int n = 0;

Is this used for anything?

+CC Mattijs
