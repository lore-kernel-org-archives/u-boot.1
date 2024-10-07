Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A5ECFB43F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 12:02:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E730188B39;
	Mon,  7 Oct 2024 14:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iKKsLDHK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4A1688CFD; Mon,  7 Oct 2024 14:02:42 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F13288B39
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 14:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 064525C5A64;
 Mon,  7 Oct 2024 12:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08701C4CECF;
 Mon,  7 Oct 2024 12:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1728302558;
 bh=p+6CxIA4QOiM4h7t7t++AQVuQM6kgXCAVEWplCWeDf0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=iKKsLDHKvGICu0fCUF+m1JFc7GTQItwjQofNHGl2q6OGgS32I2BGeJf9WFUD1FRYL
 a2fX5PPFbR0EoxwOsr4qLotlSjK3rj0cbNwKLbsnxPSeUUBLEDClLxM9zX41Lo9zaI
 1+4T+TCK1ek4iT7/YMB0pm+JJEvj3zEZC3XqaD4xDkbB5PZ/9pqVEevFQPZ5JqElcO
 IWQ8RKANuG9HFElqXAa6io1ute2iMP1cNKyoUCaKKFoRDJJTwQe+ilNbBDMCYmb8cE
 9LNIipbSGq+tbxylTAKBaF9rna3ZYkxKG2LaExkFskei43CYpuju9blfFhGHmk/mar
 5HdC+nJKXtkFA==
Message-ID: <edcf5ebf-d0d1-4722-b61e-016cadb12e63@kernel.org>
Date: Mon, 7 Oct 2024 15:02:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: cdns3: Fix cdns3_ep_config() by setting
 ep.maxpacket
To: Siddharth Vadapalli <s-vadapalli@ti.com>, trini@konsulko.com,
 lukma@denx.de, mkorpershoek@baylibre.com, marex@denx.de, vigneshr@ti.com
Cc: u-boot@lists.denx.de, srk@ti.com
References: <20241007104239.1624430-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241007104239.1624430-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
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



On 07/10/2024 13:42, Siddharth Vadapalli wrote:
> The function cdns3_ep_config() calculates the maximum packet size based
> on the Endpoint Type and the Gadget Speed and stores it in the variable
> "max_packet_size". This value is then programmed in the USB Controller
> for the corresponding Endpoint. This may result in a mismatch between
> the maximum packet size programmed in the USB controller and the maximum
> packet size seen by the UDC Core via "maxpacket" member of "struct usb_ep".
> Additionally, since TD_SIZE is calculated in cdns3_ep_run_transfer() on the
> basis of the maximum packet size stored in the "maxpacket" member of
> "struct usb_ep", it may lead to an incorrect value of TD_SIZE when compared
> with what the USB controller actually expects (max_packet_size).
> 
> Fix this by using usb_ep_set_maxpacket_limit().
> 
> Fixes: 7e91f6ccdc84 ("usb: Add Cadence USB3 host and gadget driver")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> dd4d130c8e clk: renesas: rcar-gen3: Fix SSCG caching replacement with MDSEL/PE caching
> of the master branch of U-Boot.
> 
> Patch has been tested on AM642-EVM.
> 
> Regards,
> Siddharth.
> 
>  drivers/usb/cdns3/gadget.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> index ac7e469469..b0b08768d9 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -1637,6 +1637,14 @@ void cdns3_ep_config(struct cdns3_endpoint *priv_ep)
>  	else
>  		priv_ep->trb_burst_size = 16;
>  
> +	/*
> +	 * The Endpoint is configured to handle a maximum packet size of
> +	 * max_packet_size. Hence, set priv_ep->endpoint.maxpacket to
> +	 * max_packet_size. This is necessary to ensure that the TD_SIZE
> +	 * is calculated correctly in cdns3_ep_run_transfer().
> +	 */
> +	usb_ep_set_maxpacket_limit(&priv_ep->endpoint, max_packet_size);
> +

from include/linux/usb/gadget.h

 * struct usb_ep - device side representation of USB endpoint
...
 * @maxpacket:The maximum packet size used on this endpoint.  The initial
 *      value can sometimes be reduced (hardware allowing), according to
 *      the endpoint descriptor used to configure the endpoint.
 * @maxpacket_limit:The maximum packet size value which can be handled by this
 *      endpoint. It's set once by UDC driver when endpoint is initialized, and
 *      should not be changed. Should not be confused with maxpacket.

What you want to change is ep->maxpacket and not ep->maxpacket_limit as that is
fixed for a particular UDC.

how about?
	priv-ep->endpoint.maxpacket = max_packet_size;


>  	ret = cdns3_ep_onchip_buffer_reserve(priv_dev, buffering + 1,
>  					     !!priv_ep->dir);
>  	if (ret) {

-- 
cheers,
-roger
