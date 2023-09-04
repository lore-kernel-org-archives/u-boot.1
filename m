Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5339C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 15:38:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62963869A0;
	Mon,  4 Sep 2023 17:37:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="El/0/rgu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D08B1869A9; Mon,  4 Sep 2023 17:37:57 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BEFA8693D
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 17:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4018af103bcso10280205e9.1
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 08:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1693841874; x=1694446674;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8L1sANvT66RDiLXKJPtotm94hmsu1KcskfTFCx7C1EU=;
 b=El/0/rgu4MJX3TNFWxZebqBuejTzWSeh8A6vXNClNMiUGl6ad7GQGJGt4Z0RwiirLc
 SS65bU6UPNqIwmoA8nUCdT/ok0mppCwbsQ/FGVNfCKHWL6ac8kTro8PNRStR+imRDfpT
 umGbjJ2dj9hZYGKls8oJlP/ARfsHC04QtJmA9N9F6PQAvGE2inUT1LIDtzzkmk8U7E9r
 DcKjCqilybe3KbkfeqRA/q60+ix5+7s6wy41HksW/yEPgxkExV7ovEkqaack78BZrMEd
 r01OhQGho4KXPyBog4S7OFmwrxEqEl8m6AIguhaAhjlS2ql64DDPNJLExCzoc7EHgvId
 F8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693841874; x=1694446674;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8L1sANvT66RDiLXKJPtotm94hmsu1KcskfTFCx7C1EU=;
 b=JsWh7NY7WJqykFfN4hCCyoCtZ9pcJCqf5sstTyrgK1AXS4vhMqiH8ynKM0WK8Bwfq6
 Ni+pcbG9N6g1fzPlckFEQAKZbxcg83zrBpnnQjx1y32xZ1KvkvKxMAP61Dt7KArKDBd4
 VHd73oKPuvr2xZZV2XRBnOCpmIwjMqmJPxRq6eIa1cMNn21Qz73z9/j4UpPIVfdB746L
 /egbtEiMg9QcDy9/nDFwGIPAX0HmvXiTSzBvXTT6FXbZGGnWAZhoRD/R11Xoq5r3wHIm
 PoFrOfMfxdXUhg/9b8icL7F884wFTXygdumcbFxQrjN+2ugdOFtuuBvzYWphWJ9B7Dqg
 FSOA==
X-Gm-Message-State: AOJu0Yw5xQgqhwRvroywDO7uEioDloTugyCE32kH8ifl7SuWQfLQub+T
 H3WbCyNKyPj0K4p+XRVhG3m0jw2CFnjk3B8A2WI=
X-Google-Smtp-Source: AGHT+IF/d3Aryzc9raeUEF+6APbAvtdS2yXUr0/PI9j2S/HxzmqZcxxjCOuog55mw5kL5bvcCSxAfw==
X-Received: by 2002:a05:600c:c6:b0:401:c717:ec6d with SMTP id
 u6-20020a05600c00c600b00401c717ec6dmr10512868wmm.15.1693841874448; 
 Mon, 04 Sep 2023 08:37:54 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 e12-20020adf9bcc000000b0031759e6b43fsm11585636wrc.39.2023.09.04.08.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 08:37:54 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Angus Ainslie <angus@akkea.ca>, Dmitrii Merkurev <dimorinny@google.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>, Kever Yang
 <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, Miquel
 Raynal <miquel.raynal@bootlin.com>, Nishanth Menon <nm@ti.com>, Patrice
 Chotard <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>, Stefan Roese
 <sr@denx.de>, kernel@puri.sm
Subject: Re: [PATCH v2 15/17] usb: gadget: ether: Use plain udevice for UDC
 controller interaction
In-Reply-To: <ecff6c3d-dcb3-3669-c22a-b8f6146e302b@denx.de>
References: <20230901095003.352930-1-marex@denx.de>
 <20230901095003.352930-15-marex@denx.de> <877cp62wyk.fsf@baylibre.com>
 <ecff6c3d-dcb3-3669-c22a-b8f6146e302b@denx.de>
Date: Mon, 04 Sep 2023 17:37:53 +0200
Message-ID: <874jka2bla.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On lun., sept. 04, 2023 at 11:10, Marek Vasut <marex@denx.de> wrote:

> On 9/4/23 09:56, Mattijs Korpershoek wrote:
>> On ven., sept. 01, 2023 at 11:50, Marek Vasut <marex@denx.de> wrote:
>> 
>>> Convert to plain udevice interaction with UDC controller
>>> device, avoid the use of UDC uclass dev_array .
>>>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> ---
>>> Cc: Angus Ainslie <angus@akkea.ca>
>>> Cc: Dmitrii Merkurev <dimorinny@google.com>
>>> Cc: Eddie Cai <eddie.cai.linux@gmail.com>
>>> Cc: Kever Yang <kever.yang@rock-chips.com>
>>> Cc: Lukasz Majewski <lukma@denx.de>
>>> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
>>> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>> Cc: Nishanth Menon <nm@ti.com>
>>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
>>> Cc: Simon Glass <sjg@chromium.org>
>>> Cc: Stefan Roese <sr@denx.de>
>>> Cc: kernel@puri.sm
>>> ---
>>> V2: Use udev->parent for UDC access
>>> ---
>>>   drivers/usb/gadget/ether.c | 20 +++++++++++---------
>>>   1 file changed, 11 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
>>> index 5ff06d3814b..11b1a6221b3 100644
>>> --- a/drivers/usb/gadget/ether.c
>>> +++ b/drivers/usb/gadget/ether.c
>>> @@ -1880,8 +1880,10 @@ static void eth_start(struct eth_dev *dev, gfp_t gfp_flags)
>>>   	}
>>>   }
>>>   
>>> -static int eth_stop(struct eth_dev *dev)
>>> +static int eth_stop(struct udevice *udev)
>>>   {
>>> +	struct ether_priv *priv = dev_get_priv(udev);
>>> +	struct eth_dev *dev = &priv->ethdev;
>>>   #ifdef RNDIS_COMPLETE_SIGNAL_DISCONNECT
>>>   	unsigned long ts;
>>>   	unsigned long timeout = CONFIG_SYS_HZ; /* 1 sec to stop RNDIS */
>>> @@ -1895,7 +1897,7 @@ static int eth_stop(struct eth_dev *dev)
>>>   		/* Wait until host receives OID_GEN_MEDIA_CONNECT_STATUS */
>>>   		ts = get_timer(0);
>>>   		while (get_timer(ts) < timeout)
>>> -			usb_gadget_handle_interrupts(0);
>>> +			dm_usb_gadget_handle_interrupts(udev->parent);
>>>   #endif
>>>   
>>>   		rndis_uninit(dev->rndis_config);
>>> @@ -2300,7 +2302,7 @@ static int usb_eth_start(struct udevice *udev)
>>>   			pr_err("The remote end did not respond in time.");
>>>   			goto fail;
>>>   		}
>>> -		usb_gadget_handle_interrupts(0);
>>> +		dm_usb_gadget_handle_interrupts(udev->parent);
>>>   	}
>>>   
>>>   	packet_received = 0;
>>> @@ -2370,7 +2372,7 @@ static int usb_eth_send(struct udevice *udev, void *packet, int length)
>>>   			printf("timeout sending packets to usb ethernet\n");
>>>   			return -1;
>>>   		}
>>> -		usb_gadget_handle_interrupts(0);
>>> +		dm_usb_gadget_handle_interrupts(udev->parent);
>>>   	}
>>>   	free(rndis_pkt);
>>>   
>>> @@ -2400,13 +2402,13 @@ static void usb_eth_stop(struct udevice *udev)
>>>   	 * 2) 'pullup' callback in your UDC driver can be improved to perform
>>>   	 * this deinitialization.
>>>   	 */
>>> -	eth_stop(dev);
>>> +	eth_stop(udev);
>>>   
>>>   	usb_gadget_disconnect(dev->gadget);
>>>   
>>>   	/* Clear pending interrupt */
>>>   	if (dev->network_started) {
>>> -		usb_gadget_handle_interrupts(0);
>>> +		dm_usb_gadget_handle_interrupts(udev->parent);
>>>   		dev->network_started = 0;
>>>   	}
>>>   }
>>> @@ -2416,7 +2418,7 @@ static int usb_eth_recv(struct udevice *dev, int flags, uchar **packetp)
>>>   	struct ether_priv *priv = dev_get_priv(dev);
>>>   	struct eth_dev *ethdev = &priv->ethdev;
>>>   
>>> -	usb_gadget_handle_interrupts(0);
>>> +	dm_usb_gadget_handle_interrupts(dev->parent);
>>>   
>>>   	if (packet_received) {
>>>   		if (ethdev->rx_req) {
>>> @@ -2467,7 +2469,7 @@ int usb_ether_init(void)
>>>   		return ret;
>>>   	}
>>>   
>>> -	return usb_gadget_initialize(0);
>>> +	return 0;
>> 
>> No udc_device_get() here?
>> 
>> This looks a little suspicious, because in the unbind() we call
>> udc_device_put().
>
> Look at how udc_device_get_by_index() is implemented and what it does, 
> compared to what usb_ether_init() does (hint: they are basically doing 
> the same thing). This udc_device_put() here is only a workaround for 
> platforms which are not using the bind command to bind USB ethernet yet.

Oh right. Thank you for explaining.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
