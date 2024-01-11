Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80596C4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 22:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A05B1878BA;
	Thu, 11 Jan 2024 23:37:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705012653;
	bh=4gUFsj6VOi1V/Z3VzqtrwmBr0z/qRJ3ctTBZiALmNHY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O+d1t0PDCrumNff4moz66OGQLclybFRdc6AGILevV4CN4LITUmSq63hSx74L8rRVa
	 iQFwVHodmIclhVer/fgJx4AeQ/8TBJj/2YMH3026fBl5zIMh8wQqjSBiWwMcGJJTn2
	 bJaJYQegyLanj/Ah/Z/vYoL0DHdB8LA6swxq63H9jjcY41AqcP615PQs+nS9H35BTT
	 4Oxaxn3u3f6Ut/vRwBPr1UFOq0M3xx9kUzs0HTJcOokzQLvaMr8r3lXbRpw6GNdsB0
	 JJ2PtacbuS+L1OGqQI/OsujVjIEUOl7tjS2+yEre5rEul7HfZQIVbtqfAsN03e3tTD
	 kwtqXawOc6nrw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 92F58807A7;
 Thu, 11 Jan 2024 23:37:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1705012652;
 bh=4gUFsj6VOi1V/Z3VzqtrwmBr0z/qRJ3ctTBZiALmNHY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fVNc8WHlWUooOizTYMinVanLOBex7Ms9VCvFkoZeMZwhKcmcJ922VROb4NWb7XH0I
 6rD4lNGtBrBl+Rxk7HpYdjLwQB1oMayEHu7iuOyMbAoTBBkIBYmxoGlrbDwhzYiEaQ
 +laacXcnitc2A2GZg7HjS4x9LxoRsC5Hede1yYwnx5rDfWxGtx20F1dB+U4fM6PG1M
 eSBZgWyhXAzcknaAic16SqJrg2Ng3DjXrqlujPSKZRyO6WPP9Nxs73mctgwyxHeT63
 cgKGfsaVFs/L7rP0eC1p8En+2dKf/OiCyXTW+6NFctNCBHySKkvzgFnSWy1ukU9Qxn
 Obk/wP8T6r2gA==
Message-ID: <b248b324-6c60-4ab9-a93c-c22e7334307e@denx.de>
Date: Thu, 11 Jan 2024 22:56:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: Integrate usb5744 & usb2244 driver support
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@xilinx.com, T Karthik Reddy <t.karthik.reddy@xilinx.com>
References: <20240111071057.2771902-1-venkatesh.abbarapu@amd.com>
 <555b6601-a091-4c66-8008-59a29ce7b38f@amd.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <555b6601-a091-4c66-8008-59a29ce7b38f@amd.com>
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

On 1/11/24 08:42, Michal Simek wrote:
> First of all I think this should be more RFC.
> 
> On 1/11/24 08:10, Venkatesh Yadav Abbarapu wrote:
>> Usb5744 & usb2244 are Microchip based usbhub and usb-2.0 based SD
>> controller devices. Integrate these devices into dwc3 driver to bind and
>> probe the respective drivers to get detected by usb controller.
>>
>> Signed-off-by: T Karthik Reddy <t.karthik.reddy@xilinx.com>
>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>> ---
>>   drivers/usb/dwc3/dwc3-generic.c | 67 ++++++++++++++++++++++++---------
>>   1 file changed, 49 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-generic.c 
>> b/drivers/usb/dwc3/dwc3-generic.c
>> index 6fb2de8a5a..a2eb2c8e24 100644
>> --- a/drivers/usb/dwc3/dwc3-generic.c
>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>> @@ -430,29 +430,49 @@ static int dwc3_glue_bind_common(struct udevice 
>> *parent, ofnode node)
>>       debug("%s: subnode name: %s\n", __func__, name);
>> +    if (!ofnode_device_is_compatible(node, "snps,dwc3")) {
>> +        if (ofnode_device_is_compatible(node,
>> +                        "microchip,usb5744"))
>> +                driver = "usb5744";
>> +        else if (ofnode_device_is_compatible
>> +            (node, "microchip,usb2244"))
>> +                driver = "usb2244";
>> +
>> +            ret = device_bind_driver_to_node(parent, driver, name,
>> +                             node, &dev);
>> +            if (ret) {
>> +                printf("Failed to bind: %s, err: %d\n",
>> +                       driver, ret);
>> +                return ret;
>> +            }
>> +    }
> 
> I don't think this is going to be accepted by Marek to have device 
> specific code in generic code.
> I did some grepping and I see that there is new CONFIG_USB_ONBOARD_HUB 
> entry.
> Don't understand why it is in common folder if this is pretty much 
> device specific. But there is a new UCLASS_USB_HUB class.
> 
> Venkatesh: it should be investigated more how it works.
> 
> Marek: IIRC you mentioned any support for companion/peer hubs.
> How do you think it should be integrated to u-boot?

See common/usb_onboard_hub.c .
