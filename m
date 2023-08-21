Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D08EE49AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 13:40:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3A938705E;
	Mon, 21 Aug 2023 15:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692625244;
	bh=FdvrFIfh4/4H3eeMIlSi5rpGVtr1bD1SAzwwNOyQsyA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I1TFyBwABenNI9Bkfygr+jyTax7f7k77AS+5/40jyN3GOjoZYnIh2S7gR2f8hqGZc
	 K7BKBvIXUDo3zUGZRmXbSZNzxFBl7BPKsmJCJVw29XmqQ5lSYN62T7ltQvyOr/ECsG
	 zyBgHtvbKEzcSUCF9vHHbQedKGF64d7JDK0wziFFOJiZvhJlu6iLqY6ZyvF+dLtrO2
	 +psXnJqMb4GlFDDt/wGzGwj2WaL10vTJl+ki9B3gvTrz02u3N12tmI3wgd8yCq886Q
	 8svp2YgP0Gf7swM5varrCMpJiwtozUfCOKwvaUTadCfdZ6/pctdfcjxncayqueCBCv
	 MDBUZRqdukqrA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BE1218705B;
 Mon, 21 Aug 2023 15:40:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692625243;
 bh=FdvrFIfh4/4H3eeMIlSi5rpGVtr1bD1SAzwwNOyQsyA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=zZp8TlrQCEpes+PN65wOPVAgRKzmu46LTjLct2Q5CPM/sd5rhZGAxoUxD7WOpZlRZ
 +5U93oU9LHiHe/WhcW33II6BBgLsGjmLB5iO+l8QsRKwTuqqMYhP2ke8TAgn4OXvPY
 O0pqDV9UaLY7XhkNpuNBqmL8JhknpHIUidew5CYYPCXOP6abGupjunoi08j37Ghe/f
 KLBzHtr6uP0Y1f1Edm6ROycacaxNqRsDKU4UWxE+tjamxqBB9JixbSk1/kXNBAFb/3
 ZW29cnoAeESvMqf+zOpPH80uAXimdTyef1I4FENfUbYSC8aCqARusW2arOf/VlDi+m
 HKD3TabU1tmCw==
Message-ID: <d2bd9445-27a5-3424-bf92-d5e31d0acdde@denx.de>
Date: Mon, 21 Aug 2023 15:40:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 1/2] musb-new: ti-musb: Handle usb dual-role feature as
 peripheral
To: Roger Quadros <rogerq@kernel.org>, Julien Panis <jpanis@baylibre.com>,
 Tom Rini <trini@konsulko.com>, "Bin Liu [EP]" <b-liu@ti.com>,
 stephan@gerhold.net
Cc: u-boot@lists.denx.de, tony@atomide.com, vigneshr@ti.com, nm@ti.com
References: <20230621-fix_usb_ether_init-v4-0-5f4977bb7678@baylibre.com>
 <20230621-fix_usb_ether_init-v4-1-5f4977bb7678@baylibre.com>
 <20230814171801.GC3630934@bill-the-cat>
 <500449e0-0d65-44b4-aa0b-3596292f79e3@baylibre.com>
 <927fff06-3474-080a-5d9e-3624e6f39d43@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <927fff06-3474-080a-5d9e-3624e6f39d43@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/21/23 14:16, Roger Quadros wrote:
> Hi Julien,
> 
> On 21/08/2023 11:28, Julien Panis wrote:
>> On 8/14/23 19:18, Tom Rini wrote:
>>> On Thu, Jul 06, 2023 at 12:40:22PM +0200, Julien Panis wrote:
>>>
>>>> This prevents from getting some 'No USB device found' error,
>>>> in usb_ether_init() function for instance.
>>>>
>>>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>>>> Reviewed-by: Tony Lindgren <tony@atomide.com>
>>>> Reviewed-by: Nishanth Menon <nm@ti.com>
>>>> ---
>>>>    drivers/usb/musb-new/ti-musb.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
>>>> index 3be3f93dd85d..44697dc31387 100644
>>>> --- a/drivers/usb/musb-new/ti-musb.c
>>>> +++ b/drivers/usb/musb-new/ti-musb.c
>>>> @@ -302,6 +302,7 @@ static int ti_musb_wrapper_bind(struct udevice *parent)
>>>>            dr_mode = usb_get_dr_mode(node);
>>>>            switch (dr_mode) {
>>>>            case USB_DR_MODE_PERIPHERAL:
>>>> +        case USB_DR_MODE_OTG:
>>>>                /* Bind MUSB device */
>>>>                ret = device_bind_driver_to_node(parent,
>>>>                                 "ti-musb-peripheral",
>>> Julien, why don't we support OTG mode here instead?
>>>
>>
>> Roger, can this be achieved with this controller ?
> 
> The Controller supports OTG mode but I'm not sure of the u-boot driver.
> 
> Bin / Stephan might know.

Surely the controller supports both Host and Peripheral mode.
