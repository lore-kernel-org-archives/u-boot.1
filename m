Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D80CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 09:01:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F75F86BDB;
	Tue, 17 Oct 2023 11:01:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697533264;
	bh=XZHcrdqH7o/4Ue8CaXofD1Fhd8GArxuOkM4zkN82nY0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cJP1c/xftK7g+A1IT3G7Bua9Kqw96nHHlWaTzK1G6XZEWlhIlw11bc4qocD/VTmJR
	 U2vKnbKUs9Kc3Akerc6oNnh06vs47IXIp/SG0GmhR/950bJMHSXaQ7Q8m7AU8JDUwj
	 Mfq0ZUPm2cUrZfwoolPWBlxQh+haq7pYtD0la87k102KkpatEckE3xwWvqjO1gbApt
	 o6KVEa5RKqKRpxVqyXDPHF5tzNzMU72LcgRJ9E6yBqIBCZ5TKJOvJDpfbrjLSP1AwK
	 Sr0giA5ppB0z5LJrhGymR6v9dg8O5rXO1i0aeAU4jAeTExiOJ+ZNSTq8h3PI/CcRro
	 Hypy8JAIV7R0g==
Received: from [IPV6:2001:a61:6040:2801:bd34:f5b2:1872:b520] (unknown
 [IPv6:2001:a61:6040:2801:bd34:f5b2:1872:b520])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: sbabic@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3BAF684FEB;
 Tue, 17 Oct 2023 11:01:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697533263;
 bh=XZHcrdqH7o/4Ue8CaXofD1Fhd8GArxuOkM4zkN82nY0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ccb/IhV4HFRSy8XZ7EdmlpX13+R6GN6TdEVnEKASuj1KFjC90ZbNfsA8ASs/deTW7
 dzubCk6KRSmbPkfZeH3thnbV90X629f5GbT6PKUj58SbBD0lkTYoyv7g6vnvRcaxQp
 FmuTbasZtO6jfUQxx04qmJlhGOgiGu3tk1v4YGQZVlnG2+Zhc3hdXRytZFFyAbVgli
 ZQbGLYe0DmXyCfECItZQ/3dcXFZVmvHVuOTaos/+I6cF0P7gCgu9LyZRR03fhJesQS
 qBMegt0BpnpLiw6MA+SKraMPElkrjvMtIbwn/ZUtIayq/uh7OX5wiLq3G9AUp4dPH7
 uZsQSTJchx65g==
Message-ID: <11a47881-0609-43ce-b037-46b3f7f8ded4@denx.de>
Date: Tue, 17 Oct 2023 11:01:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] net: dwc_eth_qos: add i.MX93 support
Content-Language: de-DE
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 Stefano Babic <sbabic@denx.de>, u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
References: <20230727083336.15301-1-sebastien.szymanski@armadeus.com>
 <20230727083336.15301-2-sebastien.szymanski@armadeus.com>
 <d52e94bb-1da4-41af-a329-4b49799f17c2@denx.de>
 <ae19a0c8-76f5-4202-b8f0-8ee6fb9aa762@armadeus.com>
From: Stefano Babic <sbabic@denx.de>
In-Reply-To: <ae19a0c8-76f5-4202-b8f0-8ee6fb9aa762@armadeus.com>
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

On 17.10.23 10:50, Sébastien Szymanski wrote:
> Hi Stefano,
> 
> On 10/16/23 16:22, Stefano Babic wrote:
>> Hi Sebastian,
>>
>> On 27.07.23 10:33, Sébastien Szymanski wrote:
>>> Add support for DWC EQoS MAC on i.MX93.
>>>
>>> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
>>> ---
>>>   drivers/net/dwc_eth_qos.c     | 4 ++++
>>>   drivers/net/dwc_eth_qos_imx.c | 3 +++
>>>   2 files changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
>>> index 1e92bd9ca9c0..f70f8afe5831 100644
>>> --- a/drivers/net/dwc_eth_qos.c
>>> +++ b/drivers/net/dwc_eth_qos.c
>>> @@ -1717,6 +1717,10 @@ static const struct udevice_id eqos_ids[] = {
>>>           .compatible = "nxp,imx8mp-dwmac-eqos",
>>>           .data = (ulong)&eqos_imx_config
>>>       },
>>> +    {
>>> +        .compatible = "nxp,imx93-dwmac-eqos",
>>> +        .data = (ulong)&eqos_imx_config
>>> +    },
>>>   #endif
>>>   #if IS_ENABLED(CONFIG_DWC_ETH_QOS_QCOM)
>>> diff --git a/drivers/net/dwc_eth_qos_imx.c 
>>> b/drivers/net/dwc_eth_qos_imx.c
>>> index 60f3f3f5a10f..e3f55dd98173 100644
>>> --- a/drivers/net/dwc_eth_qos_imx.c
>>> +++ b/drivers/net/dwc_eth_qos_imx.c
>>> @@ -181,6 +181,9 @@ static int eqos_set_tx_clk_speed_imx(struct 
>>> udevice *dev)
>>>       ulong rate;
>>>       int ret;
>>> +    if (device_is_compatible(dev, "nxp,imx93-dwmac-eqos"))
>>> +        return 0;
>>> +
>>>       debug("%s(dev=%p):\n", __func__, dev);
>>>       if (eqos->phy->interface == PHY_INTERFACE_MODE_RMII)
>>
>> Your series breaks Rockchip's boards. For example:
>>
>> +aarch64-linux-ld.bfd: 
>> drivers/net/dwc_eth_qos.o:(.rodata.eqos_ids+0x28): undefined reference 
>> to `eqos_imx_config'
>> +make[1]: *** [Makefile:1765: u-boot] Error 1
>> +make: *** [Makefile:177: sub-make] Error 2
>>     aarch64:  w+   rock-4c-plus-rk3399
>>
>> But it is just an example, quite all boards are broken. Please check 
>> this and repost, thanks !
> 
> https://source.denx.de/u-boot/custodians/u-boot-imx/-/blob/99807515b8eeff11487a278c956ed1893d54e61e/drivers/net/dwc_eth_qos.c#L1720
> 
> That's because, for some reason, the "nxp,imx93-dwmac-eqos" ended up in 
> the if CONFIG_DWC_ETH_QOS_ROCKCHIP / def statement... I'll send a v2.
> 
> Also, I am confused: why did I receive mails saying other patches of 
> this series have been applied ?

This is my mistake, I forget to drop the series from the list when I 
removed from my tree, sorry for that.

I will wait for V2.

Regards,
Stefano

> 
> Regards,
> 
>>
>> Best regards,
>> Stefano
>>
> 

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================

