Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D479C83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 09:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC640868D7;
	Mon,  4 Sep 2023 11:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693818644;
	bh=qzd0uvtDnnP/dGImTiOMJMb4Osm+KkvOq74o0E7yV84=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wsoHqWfaQSsPythy4vE8G0UWCLi5q1Kyhm4lcybdJ3tm/YdDxo/ZJP967EK3kkhqN
	 +6oaBmCimNk8aeJ2ozEFHsquPITaRxoDr6QeaBMvrgVOXwRcop73dq0X7GrzaeXOWp
	 RQx8Si1xeFmDj1ttzb1Ue7ELrVxV11QFvd5ILc3HXOKngWd0ZJgJcyTZ1UL0/3+w/b
	 WqQFVrlckKb/hcHiWj5mHE0H5NC5hZbnnHvjHWVbA0nRfyqMRXK95JFbeCqsOTqxmt
	 67/VnNhq2qsLvuRQv8pOtV9LlIeTqctpqXCcYtUfJ9azHZDRskWc1WHHYJPpC+SfqS
	 pKQj+9y59u70A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D7EBE86380;
 Mon,  4 Sep 2023 11:10:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693818643;
 bh=qzd0uvtDnnP/dGImTiOMJMb4Osm+KkvOq74o0E7yV84=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ibSqXtn6Ix8T0KYHOc6a3KKJ7KHmTvBSVllEkJK1efc/NohJNnAvTQGqJaHUGZtIL
 8pHKvbqRPz0MqRLBkydVu9ZBx2DIxnwcGwOdSJuq0gRd7oCugVzugN4tUOMCse8UdU
 XHf6hPYKpnaMmPlLrs/sfNIYhe8/rxIeE+7ejRdKyx3qIx+iz75/CWDTkZA7rAUVVQ
 yTezqoEOMOYXCrhcro45usvVvKiA1B742mT5xLNwYwDE1Sqxj6E8hia13DqNqPqEyo
 Qi/s2f28t8CTvYXiB7mMve/U9Kuk5WUu+Etk65CwUochv+UHVkRPJ2471o2m1ZxEFD
 ABOghVWadqsUg==
Message-ID: <ecff6c3d-dcb3-3669-c22a-b8f6146e302b@denx.de>
Date: Mon, 4 Sep 2023 11:10:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 15/17] usb: gadget: ether: Use plain udevice for UDC
 controller interaction
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Cc: Angus Ainslie <angus@akkea.ca>, Dmitrii Merkurev <dimorinny@google.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>, Kever Yang
 <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, kernel@puri.sm
References: <20230901095003.352930-1-marex@denx.de>
 <20230901095003.352930-15-marex@denx.de> <877cp62wyk.fsf@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <877cp62wyk.fsf@baylibre.com>
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

On 9/4/23 09:56, Mattijs Korpershoek wrote:
> On ven., sept. 01, 2023 at 11:50, Marek Vasut <marex@denx.de> wrote:
> 
>> Convert to plain udevice interaction with UDC controller
>> device, avoid the use of UDC uclass dev_array .
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Angus Ainslie <angus@akkea.ca>
>> Cc: Dmitrii Merkurev <dimorinny@google.com>
>> Cc: Eddie Cai <eddie.cai.linux@gmail.com>
>> Cc: Kever Yang <kever.yang@rock-chips.com>
>> Cc: Lukasz Majewski <lukma@denx.de>
>> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
>> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> Cc: Nishanth Menon <nm@ti.com>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Stefan Roese <sr@denx.de>
>> Cc: kernel@puri.sm
>> ---
>> V2: Use udev->parent for UDC access
>> ---
>>   drivers/usb/gadget/ether.c | 20 +++++++++++---------
>>   1 file changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
>> index 5ff06d3814b..11b1a6221b3 100644
>> --- a/drivers/usb/gadget/ether.c
>> +++ b/drivers/usb/gadget/ether.c
>> @@ -1880,8 +1880,10 @@ static void eth_start(struct eth_dev *dev, gfp_t gfp_flags)
>>   	}
>>   }
>>   
>> -static int eth_stop(struct eth_dev *dev)
>> +static int eth_stop(struct udevice *udev)
>>   {
>> +	struct ether_priv *priv = dev_get_priv(udev);
>> +	struct eth_dev *dev = &priv->ethdev;
>>   #ifdef RNDIS_COMPLETE_SIGNAL_DISCONNECT
>>   	unsigned long ts;
>>   	unsigned long timeout = CONFIG_SYS_HZ; /* 1 sec to stop RNDIS */
>> @@ -1895,7 +1897,7 @@ static int eth_stop(struct eth_dev *dev)
>>   		/* Wait until host receives OID_GEN_MEDIA_CONNECT_STATUS */
>>   		ts = get_timer(0);
>>   		while (get_timer(ts) < timeout)
>> -			usb_gadget_handle_interrupts(0);
>> +			dm_usb_gadget_handle_interrupts(udev->parent);
>>   #endif
>>   
>>   		rndis_uninit(dev->rndis_config);
>> @@ -2300,7 +2302,7 @@ static int usb_eth_start(struct udevice *udev)
>>   			pr_err("The remote end did not respond in time.");
>>   			goto fail;
>>   		}
>> -		usb_gadget_handle_interrupts(0);
>> +		dm_usb_gadget_handle_interrupts(udev->parent);
>>   	}
>>   
>>   	packet_received = 0;
>> @@ -2370,7 +2372,7 @@ static int usb_eth_send(struct udevice *udev, void *packet, int length)
>>   			printf("timeout sending packets to usb ethernet\n");
>>   			return -1;
>>   		}
>> -		usb_gadget_handle_interrupts(0);
>> +		dm_usb_gadget_handle_interrupts(udev->parent);
>>   	}
>>   	free(rndis_pkt);
>>   
>> @@ -2400,13 +2402,13 @@ static void usb_eth_stop(struct udevice *udev)
>>   	 * 2) 'pullup' callback in your UDC driver can be improved to perform
>>   	 * this deinitialization.
>>   	 */
>> -	eth_stop(dev);
>> +	eth_stop(udev);
>>   
>>   	usb_gadget_disconnect(dev->gadget);
>>   
>>   	/* Clear pending interrupt */
>>   	if (dev->network_started) {
>> -		usb_gadget_handle_interrupts(0);
>> +		dm_usb_gadget_handle_interrupts(udev->parent);
>>   		dev->network_started = 0;
>>   	}
>>   }
>> @@ -2416,7 +2418,7 @@ static int usb_eth_recv(struct udevice *dev, int flags, uchar **packetp)
>>   	struct ether_priv *priv = dev_get_priv(dev);
>>   	struct eth_dev *ethdev = &priv->ethdev;
>>   
>> -	usb_gadget_handle_interrupts(0);
>> +	dm_usb_gadget_handle_interrupts(dev->parent);
>>   
>>   	if (packet_received) {
>>   		if (ethdev->rx_req) {
>> @@ -2467,7 +2469,7 @@ int usb_ether_init(void)
>>   		return ret;
>>   	}
>>   
>> -	return usb_gadget_initialize(0);
>> +	return 0;
> 
> No udc_device_get() here?
> 
> This looks a little suspicious, because in the unbind() we call
> udc_device_put().

Look at how udc_device_get_by_index() is implemented and what it does, 
compared to what usb_ether_init() does (hint: they are basically doing 
the same thing). This udc_device_put() here is only a workaround for 
platforms which are not using the bind command to bind USB ethernet yet.
