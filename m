Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84843CDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 10:45:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12BF7878E6;
	Mon, 23 Oct 2023 12:44:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698057893;
	bh=L8RJRjga8ZHW1DzEa3FAua+3oVzrOMRAu34rRZiK5d8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NZtcLXcV9D1ADX73ghE4CKcCobjs+o2OCwSB5sg5+pvdne/ZwFbeRJUEala1pB1Oe
	 aojdKzQd1eYz8dBucpYhavwFV+JC6+8bLjxxOucIg8BqMtTUG5dIBwgQa7Ob6SyTmI
	 nnDDh0sJgkIi9TOAA86rY+fFzd497EGJAfnx6Xzionj1h5yTyDb9QNxfUgWpRuncx6
	 gfVpKKhNc4ErOnpbEfeTCVDtaTb7IV/krTAIq1TMPo8jh0CyeluQ3mPtM3IyBGXLud
	 cglMapgJef6nMKiWP1z46bYhDQ93ztDS5OpEqiZ8pPQ/ZM5HBdekyICiWFQfvOHCNN
	 +PlmhKPQ5pbUQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6001E8787D;
 Mon, 23 Oct 2023 12:44:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698057891;
 bh=L8RJRjga8ZHW1DzEa3FAua+3oVzrOMRAu34rRZiK5d8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FvBFP/3kfYo/gmTZbRkxCNT2S9l+HtpfBBCHu40S9pcbmcXTID3g9wKc1JHmKyq4U
 0BEMb3PgFatU3VJd8miAqSMeSUTqNiwzpazim7bRUV82jSj4QPzMwOzNAGFUGDwfiq
 EfsAyipk39pJL398m2S1PlxZT5+pW6/A+4NhHkpAtXLKXP04P2kbCBFWiwmCEI4E8O
 GzItRgOcgtqfQ11S7/+RlI5LGc2z9ji2nBEGUu6l5HtmLtsMtDvqkaGRTMpEqiDBvv
 djWOOMbhsHVSW090zMKAuLhP7yetoVBB3xusKKLfeImoI0zuvZ0I1Qfbr/9D2+mi3G
 vVAIUcgYRUSXg==
Message-ID: <ebe2784d-23c6-470d-a25f-8261fcf820ca@denx.de>
Date: Mon, 23 Oct 2023 11:03:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] led-uclass: honour ->label field populated by
 driver's own .bind
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>,
 pavel Machek <pavel@denx.de>
References: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
 <20231019095837.2084458-3-rasmus.villemoes@prevas.dk>
 <d4389465-e5bd-492b-8f86-7b4a93ff6016@denx.de>
 <7d38b732-e5f4-4e6a-9a5d-7837e285ba55@prevas.dk>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <7d38b732-e5f4-4e6a-9a5d-7837e285ba55@prevas.dk>
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

On 10/23/23 10:51, Rasmus Villemoes wrote:
> On 19/10/2023 15.54, Marek Vasut wrote:
>> On 10/19/23 11:58, Rasmus Villemoes wrote:
>>> If the driver's own .bind method has populated uc_plat->label, don't
>>> override that. This is necessary for an upcoming driver for ti,lp5562,
>>> where the DT binding unfortunately says to use "chan-name" and not
>>> "label".
>>>
>>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>>> ---
>>>    drivers/led/led-uclass.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
>>> index 5a5d07b9a7..0232fa84de 100644
>>> --- a/drivers/led/led-uclass.c
>>> +++ b/drivers/led/led-uclass.c
>>> @@ -71,7 +71,9 @@ static int led_post_bind(struct udevice *dev)
>>>        struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>>>        const char *default_state;
>>>    -    uc_plat->label = dev_read_string(dev, "label");
>>> +    if (!uc_plat->label)
>>> +        uc_plat->label = dev_read_string(dev, "label");
>>> +
>>
>> One thing I have to wonder about is, why does this controller have label
>> property in the top-level node , what is that used for ?
>>
>> (see Linux Documentation/devicetree/bindings/leds/leds-lp55xx.yaml)
>>
>> Reviewed-by: Marek Vasut <marex@denx.de>
> 
> Reading the linux driver, it seems that the top-level label, if any, is
> used as part of the naming for individual channels if they don't have
> individual chan-name properties:
> 
> 
>          if (pdata->led_config[chan].name) {
>                  led->cdev.name = pdata->led_config[chan].name;
>          } else {
>                  snprintf(name, sizeof(name), "%s:channel%d",
>                          pdata->label ? : chip->cl->name, chan);
>                  led->cdev.name = name;
>          }
> 
> but I think the rationale in d1188adb2dabc is a bit weak, since the only
> example also does have individual chan-name properties.
> 
> [Complete aside: At first I thought it was related to the multi-color
> LED work that has been ongoing for many many years (I think there was an
> LWN article at some point), where this could be exposed as a single
> multi-color LED, as opposed to the "traditional" three/four individual
> LEDs. In the former case, there would only be one sysfs entry, but with
> attributes exposing the multicolor functionality. I must admit I don't
> know the status of that work, when something reaches v31,
> http://archive.lwn.net:8080/linux-kernel/20200722071055.GA8984@amd/t/ ,
> it's hard to know if it ever lands, or if pieces of it has landed.]

+CC Pavel
