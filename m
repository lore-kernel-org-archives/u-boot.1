Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123ADE9370D
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 13:07:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6424D86CEF;
	Thu,  5 Oct 2023 15:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696511092;
	bh=PcvM7biSICsjKJet8IdnffMH9BApD5anNEc/xCYMFd8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V6uSl9qzPXejV1+6jBCOVH83v+GwbTZEF2haP7UCE2/VUiL9Jf9UC7g8nIRsW6bjs
	 Wn8BxdDKq6edAzxoLzJZtDaHLCfVvLxjKkpldxieq3VX2TMCDq1Ggm033ptrJk/PTa
	 wg3a8IjjHzqzr1f/ZyoJNZWnjjsBKZtMBnvcHrUBHQABdN1Oj4oudjosmWG6nxj8on
	 b45kaUQyHtbVPcwPvYvQdyMF1WH+gtpkqnrEuGIajddvTYZ25LZlLoTly4sKM/s1o4
	 Sh1Hrn/u21LlmpJjGrCbXsar3xBbhgfc1zk5BvFwAvtl7YrgLpQ1f1uqgLQMx005RH
	 umRcWBrB/E5QA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5E1E386D04;
 Thu,  5 Oct 2023 15:04:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1696511068;
 bh=PcvM7biSICsjKJet8IdnffMH9BApD5anNEc/xCYMFd8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=y+MnPprX7rRaIMH2wbqEIGcttKA9Si7cGNWs6s2JbSo5wOS3aaCLTPCBepKBmzmj/
 i+8P3afd+WoZ36fqOWR8e5CcuLcN3kr/217f6Efy2BUm9WM00ZORqHNqYFVzKMRPav
 eukGNKQVgdudURnPS6hLw3dMpt4oqLJryjdGFPI8lWBvDBK2bNRSyqfjEMOW6jUHe2
 Q5YlYYIVCeW6XIMSssDiHbgw9hDzu19luG1T8wxJroYHJHNkiwITw1yJJjQ9gczXi2
 KHOYXhEbtQH00XLs+TlfjOMlaL4pX3XaqRaQJ52DhLcMutbpYRNTrvRBOJ/b+S4Dg9
 CGquqeEwoIcZA==
Message-ID: <7bdef74c-5756-45f2-80c5-63a9f5d68b03@denx.de>
Date: Thu, 5 Oct 2023 15:04:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 2/2] usb: udc: Try to clarify an error message
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>, Lukasz Majewski
 <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de
References: <20231002134621.94786-1-miquel.raynal@bootlin.com>
 <20231002134621.94786-2-miquel.raynal@bootlin.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231002134621.94786-2-miquel.raynal@bootlin.com>
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

On 10/2/23 15:46, Miquel Raynal wrote:
> At some point when trying to use USB gadgets, two situations may arise
> and lead to a failure. Either the UDC (USB Device Controller) is not
> available at all (not described or not probed) or the UDC is already in
> use. For instance, as the USB Ethernet gadget remains bound to the UDC,
> the use of any other USB gadget (fastboot, dfu, etc) *after* will always
> fail with the "couldn't find an available UDC" error.
> 
> Let's give a more helpful message by making a difference between the two
> cases. Let's also hint people who would get this error and grep it into
> the sources a better explanation of what's wrong with their workflow.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> While doing this I really wanted to add "much more" error comments but I
> faced another reality: often the messages are there but use
> pr_err/log_err which is actually silenced by default with LOGLEVEL=3, so
> I consider this unnecessary, as decreasing the loglevel will make these
> messages appear. I would have expected errors to be displayed, but I
> understand it makes the binaries even bigger.
> 
> Resend: no change.
> 
> Changes in v2:
> * s/UDC/UDCs/. I kept the sentence as it was as the suggested form did
>    not sound well at all when there is only one UDC.
> ---
>   drivers/usb/gadget/udc/udc-core.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
> index 7f73926cb3e..8405b03462e 100644
> --- a/drivers/usb/gadget/udc/udc-core.c
> +++ b/drivers/usb/gadget/udc/udc-core.c
> @@ -323,6 +323,7 @@ err1:
>   int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
>   {
>   	struct usb_udc		*udc = NULL;
> +	unsigned int		udc_count = 0;
>   	int			ret;
>   
>   	if (!driver || !driver->bind || !driver->setup)
> @@ -330,12 +331,22 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
>   
>   	mutex_lock(&udc_lock);
>   	list_for_each_entry(udc, &udc_list, list) {
> +		udc_count++;
> +
>   		/* For now we take the first one */
>   		if (!udc->driver)
>   			goto found;
>   	}
>   
> -	printf("couldn't find an available UDC\n");
> +	if (!udc_count)
> +		printf("No UDC available in the system\n");
> +	else
> +		/* When this happens, users should 'unbind <class> <index>'
> +		 * using the output of 'dm tree' and looking at the line right
> +		 * after the USB peripheral/device controller.
> +		 */
> +		printf("All UDCs in use (%d available), use the unbind command\n",
> +		       udc_count);

Users should really use 'bind' command in the first place, to avoid this 
guesswork to which UDC (on systems with multiple UDCs) a gadget gets 
bound to, and instead bind the gadget to specific UDC they want to bind 
it to. This code should then be removed entirely.
