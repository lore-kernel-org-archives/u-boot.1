Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F14D70DE7
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 17:20:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24F9E893DA;
	Thu, 28 Nov 2024 18:20:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oFEAgpzp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EF17893DA; Thu, 28 Nov 2024 18:20:33 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A10A38939D
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 18:20:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4ASHKKmo044962;
 Thu, 28 Nov 2024 11:20:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732814420;
 bh=SpYW8ilD9sUFhPhZTuFJ846TGvbKcsK8qUrBbKeM3hQ=;
 h=Date:CC:Subject:To:References:From:In-Reply-To;
 b=oFEAgpzpP9u9LY6VBadn5qoDb6nZoeIdEAPrjB2HFHmLjoTXHLU99MZHRA1TqD/Fh
 z1e/GtBqTaRqmFRkyF979uJKkzE2wz6cRIiAevlWvSAO5pAXd4hoALc9ZKREIsjFZa
 qCDGgMQ7ym8ciUJtjSat6vD7umtm8Q70NYT68EJE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ASHKJAg108546
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 28 Nov 2024 11:20:19 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Nov 2024 11:20:19 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Nov 2024 11:20:19 -0600
Received: from [10.249.131.218] ([10.249.131.218])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ASHKCgw108355;
 Thu, 28 Nov 2024 11:20:13 -0600
Message-ID: <252751ec-2000-43bd-a9e3-fc0b53362baf@ti.com>
Date: Thu, 28 Nov 2024 22:50:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <s-vadapalli@ti.com>, <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH 1/2] usb: dwc3-generic: set "mode" based on caller of
 dwc3_generic_probe()
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, <vigneshr@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <marex@denx.de>, <hnagalla@ti.com>,
 <mkorpershoek@baylibre.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <jan.kiszka@siemens.com>,
 <jonas@kwiboo.se>, <j-humphreys@ti.com>, <nm@ti.com>,
 <devarsht@ti.com>, <ilias.apalodimas@linaro.org>
References: <20241126120322.1760862-1-s-vadapalli@ti.com>
 <20241126120322.1760862-2-s-vadapalli@ti.com>
 <f4c4cb82-0e8c-49a1-aff0-2c539f15047d@kernel.org>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <f4c4cb82-0e8c-49a1-aff0-2c539f15047d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hello Roger,

On 28-11-2024 18:40, Roger Quadros wrote:
> 
> 
> On 26/11/2024 14:03, Siddharth Vadapalli wrote:
>> There are only two callers of "dwc3_generic_probe()", namely:
>> 1. dwc3_generic_peripheral_probe()
>> 2. dwc3_generic_host_probe()
>> Currently, the "mode" is set based on the device-tree node of the
>> platform device. Also, the DWC3 core doesn't support updating the "mode"
>> dynamically at runtime if it is set to "OTG", i.e. "OTG" is treated as a
>> separate mode in itself, rather than being treated as a mode which should
>> eventually lead to "host"/"peripheral".
>>
>> Given that the callers of "dwc3_generic_probe()" clarify the expected
>> "mode" of the USB Controller, use that "mode" instead of the one
>> specified in the device-tree. This shall allow the USB Controller to
>> function both as a "Host" and as a "Peripheral" when the "mode" is "otg"
>> in the device-tree, based on the caller of "dwc3_generic_probe()".
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>  drivers/usb/dwc3/dwc3-generic.c | 9 +++++----
> 
> TI AM62a is not even using this driver so how did you test this?
> Did I miss a DT patch?

USB DFU boot utilizes this driver when the "dr_mode" is set to "otg" in
the device-tree for AM62A. This driver is invoked both for the host and
device commands corresponding to USB. I came up with this patch while
trying to enable USB DFU boot on AM62A with "dr_mode" as "otg" in the
device-tree. Additionally, USB DFU boot works on AM62A with the change
made by this patch and it doesn't work without this change. I have
traced the call sequence to see that the driver is probed and have come
up with the change performed in this patch on the basis of this observation.

> 
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
>> index 2ab41cbae45..55e62b35c61 100644
>> --- a/drivers/usb/dwc3/dwc3-generic.c
>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>> @@ -51,7 +51,8 @@ struct dwc3_generic_host_priv {
>>  };
>>  
>>  static int dwc3_generic_probe(struct udevice *dev,
>> -			      struct dwc3_generic_priv *priv)
>> +			      struct dwc3_generic_priv *priv,
>> +			      enum usb_dr_mode mode)
>>  {
>>  	int rc;
>>  	struct dwc3_generic_plat *plat = dev_get_plat(dev);
>> @@ -62,7 +63,7 @@ static int dwc3_generic_probe(struct udevice *dev,
>>  
>>  	dwc3->dev = dev;
>>  	dwc3->maximum_speed = plat->maximum_speed;
>> -	dwc3->dr_mode = plat->dr_mode;
>> +	dwc3->dr_mode = mode;
> 
> if platform supported mode was "host" only or "peripheral" only
> then you shouldn't we prevent from using the other role?

Yes, but that check doesn't exist prior to this patch either. Platform
could support only "host" mode as specified by "dr_mode", but if the
user runs a command for device mode it will lead to
"dwc3_generic_peripheral_probe" in this driver. On the other hand, if
the check does exist outside this driver, then it doesn't have to be
checked within "dwc3_generic_probe". There are only two callers of
"dwc3_generic_probe", both of which are in this driver, and both of
which unconditionally invoke "dwc3_generic_probe".

However, I agree that having a check here will help. I will update this
patch to add the check to confirm if there is a conflict with what the
platform supports, though this doesn't seem to be the case with the
existing code.
> 
> In u-boot shell, if user starts Host driver first and then starts peripheral driver
> how does it work?
> Did you test this case?

I didn't test the case where both are used. I validated that peripheral
mode works across various stages of boot with "otg" mode via USB DFU
boot. This isn't the case without this patch.

If we forget the reason that this patch is introduced and take a moment
to analyze the existing code prior to this patch, we see that:
1. Both dwc3_generic_peripheral_probe() and dwc3_generic_host_probe()
invoke dwc3_generic_probe().
2. dwc3_generic_probe() sets the role based on the role specified in the
device-tree and not what the caller wants the role to be.
This seems to be strange to me considering that dwc3_generic_probe()
simply proceeds to configure without comparing the role supported by the
platform with the role requested by the caller.

So even if we entirely forget the "otg" fix being attempted by this
patch, the same patch is fixing something else i.e. ensuring that
dwc3_generic_probe() does what the caller wants it to do by using the
role that the caller expects. Isn't it incorrect that the existing code
might end up with:
a) Caller being dwc3_generic_host_probe() with dr_mode being set to
"peripheral" within dwc3_generic_probe() based on the device-tree and
proceeding to configure the controller.
b) Caller being dwc3_generic_peripheral_probe() with dr_mode being set
to "host" within dwc3_generic_probe() based on the device-tree and
proceeding to configure the controller.
Shouldn't this inconsistency be fixed? This patch fixes that by setting
dr_mode to what the caller expects. However, based on your suggestion, I
agree that there should have been a check within dwc3_generic_probe() to
ensure that the platform supports what the caller is requesting. I will
update this patch by adding the check.

Please let me know what you think.

[...]

-- 
Regards,
Siddharth.
