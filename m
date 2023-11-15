Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4134BC07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 05:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AAA086EE5;
	Wed, 15 Nov 2023 06:37:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700026649;
	bh=7ph56KhiiNFoA3GehhV+zRMJCGOilbtCySg1lno3lAE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MU9TvoQgfxQAFOllhQTzoLBkiS7DeKT7z+mkp2lqO8ovMSFgV3w/mS5FQE0iRC7/l
	 zVwXQS/N9lppOwBNHqKUW/DYHYatVZvpJgDrvzYYyAEFXRrr4vn6BHBDs73Dq6lN1I
	 FTB/fQXARNg3p81us4zQMCfKnBYWxRcKp2tPMke9JlVBFNFAYM9HwuYM+iOypqP3f/
	 qPgKr1nqzOlvunN01RQJ3oyKLcguA9F0CXfy8vFRqaCqiM5WulHilh18LFFaFUs6+Y
	 8CGC9r0ggTeI6pC74dzKIC8vNfNtPPifoX701YQBptTOp0HiILWvAZ04Bpyu7n/J+g
	 rpKKorj6Z1dMA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 13C1286C3B;
 Wed, 15 Nov 2023 06:37:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700026647;
 bh=7ph56KhiiNFoA3GehhV+zRMJCGOilbtCySg1lno3lAE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=i4kasT+I4mt4y0v9jywBY7Rdha/1be1O4drd4f5ly8qf+m41fuz4ehpvdd4IjuH3n
 Z2zY4DDTaUbEIupdpE1XX8PgSOGauxaA7jf4b1PY42txrUI5jFF5hzf9OSggp5Xf95
 4J9UVbqEpNXjiFx07PZbvxnOZXnarAPLtncccimCVgYMvptAEBVARUMFr4uKiFAP89
 II9Nut3lNR3VnaGy3YBXurb/x46CpTBCEWV5unDJy1EkJgMLLUTbCUwyD9hOq814tC
 xlaHxojchctAhfEE6INLFuav3iRcBV+RtqOXwEifSLM3DPHF60yTlzYTMFbUxWBo0/
 EbR/v2U3jbNPg==
Message-ID: <9a11d59b-0e41-4e26-b474-ad743725bfa5@denx.de>
Date: Wed, 15 Nov 2023 06:37:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] led-uclass: honour ->label field populated by
 driver's own .bind
Content-Language: en-US
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>,
 pavel Machek <pavel@denx.de>
References: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
 <20231019095837.2084458-3-rasmus.villemoes@prevas.dk>
 <d4389465-e5bd-492b-8f86-7b4a93ff6016@denx.de>
 <7d38b732-e5f4-4e6a-9a5d-7837e285ba55@prevas.dk>
 <ebe2784d-23c6-470d-a25f-8261fcf820ca@denx.de>
 <CAH9NwWfEPeXhmxM6MMmVfS3XJoTT3Qod8-Z3rsuUzyOGwO5-eg@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAH9NwWfEPeXhmxM6MMmVfS3XJoTT3Qod8-Z3rsuUzyOGwO5-eg@mail.gmail.com>
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

On 11/14/23 13:11, Christian Gmeiner wrote:
> ping
> 
> Am Mo., 23. Okt. 2023 um 12:45 Uhr schrieb Marek Vasut <marex@denx.de>:
>>
>> On 10/23/23 10:51, Rasmus Villemoes wrote:
>>> On 19/10/2023 15.54, Marek Vasut wrote:
>>>> On 10/19/23 11:58, Rasmus Villemoes wrote:
>>>>> If the driver's own .bind method has populated uc_plat->label, don't
>>>>> override that. This is necessary for an upcoming driver for ti,lp5562,
>>>>> where the DT binding unfortunately says to use "chan-name" and not
>>>>> "label".
>>>>>
>>>>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>>>>> ---
>>>>>     drivers/led/led-uclass.c | 4 +++-
>>>>>     1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
>>>>> index 5a5d07b9a7..0232fa84de 100644
>>>>> --- a/drivers/led/led-uclass.c
>>>>> +++ b/drivers/led/led-uclass.c
>>>>> @@ -71,7 +71,9 @@ static int led_post_bind(struct udevice *dev)
>>>>>         struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>>>>>         const char *default_state;
>>>>>     -    uc_plat->label = dev_read_string(dev, "label");
>>>>> +    if (!uc_plat->label)
>>>>> +        uc_plat->label = dev_read_string(dev, "label");
>>>>> +
>>>>
>>>> One thing I have to wonder about is, why does this controller have label
>>>> property in the top-level node , what is that used for ?
>>>>
>>>> (see Linux Documentation/devicetree/bindings/leds/leds-lp55xx.yaml)
>>>>
>>>> Reviewed-by: Marek Vasut <marex@denx.de>
>>>
>>> Reading the linux driver, it seems that the top-level label, if any, is
>>> used as part of the naming for individual channels if they don't have
>>> individual chan-name properties:
>>>
>>>
>>>           if (pdata->led_config[chan].name) {
>>>                   led->cdev.name = pdata->led_config[chan].name;
>>>           } else {
>>>                   snprintf(name, sizeof(name), "%s:channel%d",
>>>                           pdata->label ? : chip->cl->name, chan);
>>>                   led->cdev.name = name;
>>>           }
>>>
>>> but I think the rationale in d1188adb2dabc is a bit weak, since the only
>>> example also does have individual chan-name properties.
>>>
>>> [Complete aside: At first I thought it was related to the multi-color
>>> LED work that has been ongoing for many many years (I think there was an
>>> LWN article at some point), where this could be exposed as a single
>>> multi-color LED, as opposed to the "traditional" three/four individual
>>> LEDs. In the former case, there would only be one sysfs entry, but with
>>> attributes exposing the multicolor functionality. I must admit I don't
>>> know the status of that work, when something reaches v31,
>>> http://archive.lwn.net:8080/linux-kernel/20200722071055.GA8984@amd/t/ ,
>>> it's hard to know if it ever lands, or if pieces of it has landed.]
>>
>> +CC Pavel

I think you want to coordinate the effort with Rasmus here .
