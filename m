Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132B3CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 08:50:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9FA686CFE;
	Tue, 17 Oct 2023 10:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA57586D18; Tue, 17 Oct 2023 10:50:44 +0200 (CEST)
Received: from 20.mo581.mail-out.ovh.net (20.mo581.mail-out.ovh.net
 [46.105.49.208])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFBFA86C91
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 10:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director5.ghost.mail-out.ovh.net (unknown [10.109.143.210])
 by mo581.mail-out.ovh.net (Postfix) with ESMTP id 4FF0A27278
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 08:50:42 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-q88f2 (unknown [10.110.103.155])
 by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id E3D891FE56;
 Tue, 17 Oct 2023 08:50:41 +0000 (UTC)
Received: from armadeus.com ([37.59.142.95])
 by ghost-submission-6684bf9d7b-q88f2 with ESMTPSA
 id SDFvMuFKLmXXYAAA9nsdYg
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Tue, 17 Oct 2023 08:50:41 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G00137d18ed1-a4cb-4006-8d9b-f9a1666a9eb0,
 E8A557B56471F6228A10BFFFE8FF761D83F94D6C)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 92.148.253.243
Message-ID: <ae19a0c8-76f5-4202-b8f0-8ee6fb9aa762@armadeus.com>
Date: Tue, 17 Oct 2023 10:50:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] net: dwc_eth_qos: add i.MX93 support
Content-Language: en-US
To: Stefano Babic <sbabic@denx.de>, u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
References: <20230727083336.15301-1-sebastien.szymanski@armadeus.com>
 <20230727083336.15301-2-sebastien.szymanski@armadeus.com>
 <d52e94bb-1da4-41af-a329-4b49799f17c2@denx.de>
From: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Autocrypt: addr=sebastien.szymanski@armadeus.com; keydata=
 xsBNBFNfZLEBCACv1lqSePHJNpRgcnER+3emy+Arjz84zFax3XkogjY/e3ZneihIgWrVKe5M
 ql16pX4KTkzNgMUKz4bG/XwT3kjcrXshxFLlg7KrHMl287C+W+QOUjnjVeRi/su+SPmjz8VD
 yr11h+ZkVLAWhS+uQJ93jy1NwG8M4t1kBLAVHHD5Vw4FJ+3ouaVYIp1X1Cr8bVKQw33Q1aTd
 ro0kMBb96B9vNu7ciJZ3gvlaBzUEKOgNnq9KaywuLnqrqr4HUIn5JuxZjCjJzt9kTAKcTfp2
 cJM8qpp+2FF5qtbkse9fZ6M64qozgOPr9Tk4Amf9fZEUQ6UNw14mmBZuXSzoHe75gI7TABEB
 AAHNN1PDqWJhc3RpZW4gU1pZTUFOU0tJIDxzZWJhc3RpZW4uc3p5bWFuc2tpQGFybWFkZXVz
 LmNvbT7CwJAEEwEIADoCGyMHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgBYhBJwGygpYm/1C
 /GCmwbCaKeiBMmTiBQJdhIHLAAoJELCaKeiBMmTixXIH/2W3kbzRG0UF81jtRRnp0H83rjDT
 v0H+8fgFMRL/7HCJ1QPArkfRJlM2wlJkN+ChP09CCarYfUEHfRCHlTb7At6Yyrz1jziD7ZwX
 8IWHYRXnZkY5eZc5DsiUgq6JH49kt+GPzK8UVP9MTa6zkBpPCUf7LzZ4pD3FihdkT52BU3gI
 d9P49fSI0TYySlb/VKn815aOhvwEr7+Dh3mZUjSh7saofbRmVUOr7p+R3MvvGI19/IJZjeOE
 ZWliODDOt6HnBOtoGSXMcNIFF6snH52D5N5gY88njZjTwhgGGUBix1bsgf/EY0v4R5itZBXB
 B/Ze4Tm++YHaB75hZK6PQu/YRv7OwE0EU19ksQEIALo7jhXddrXBTRu5SAjelV53jyHBJTX/
 vN4nL/VbbW/saca+NJjDSxx5DBmotZbQdWIyZiSIjU/xnTREvtDrl6ZeSsKWd7ZqiuiY4fSR
 zwuQp9rd0yqRuxesrWeyJB1zCSdEvLyKASERt+nxkOA+IzJ4y1qLtvnWr+SL1AXgTMw+Tkyw
 KIDCRWHTIYas11ldGj82gOIpYeXnapeNLHfT4EQwg0NeWYHynJxAQWiX5aPlw0uSpAQSsBXQ
 FIe3fpoveMSnXK+PG2BBOzexYv7r4S70a6sF9sgTTPpfKqUaqqC+u1+bUX6alTAKhGKJywaF
 6ViqLlgY8PfwohSyAlqlTRMAEQEAAcLAdgQYAQgAIAIbDBYhBJwGygpYm/1C/GCmwbCaKeiB
 MmTiBQJdhIHSAAoJELCaKeiBMmTitU8IAK7NQM3fEwaF5XaKtepYWsVka44CD8A9e4r7NVK9
 ugirKvXirIxBSDmN/Db862NmVpITsZ6ERNSNZLm/7k55N+TexKYiFZeU7G92TEfAM6qPElvx
 DLEcrkNMq9r08YZeUloacsq31AL5fK4LW+xdvXudkdiKRMJsdTpmff3x5kIziGOHjwFP9wve
 ZgEH52gpbRsP8Whx/Z2lNX/BBRmFM8OnEXFsjjqDzYThdxTq85wGPpkgvvUGyPNRD7TpbB1C
 pajOUUkPxgj5LKt77HD1afeZNudWhgcdkbtT5PMQTT0WY6wvMEj9S1+bGPeXRGWLYB7gHQ+L
 JNoSD7Kz6Y9qnKo=
In-Reply-To: <d52e94bb-1da4-41af-a329-4b49799f17c2@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5395875307247561523
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuforsggrshhtihgvnhcuufiihihmrghnshhkihcuoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqnecuggftrfgrthhtvghrnhepiefhgeffudetiedvheeuffelieetffevueekgffgffekffehveehvdegheejkedtnecuffhomhgrihhnpeguvghngidruggvnecukfhppeduvdejrddtrddtrddupdelvddrudegkedrvdehfedrvdegfedpfeejrdehledrudegvddrleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoshgvsggrshhtihgvnhdrshiihihmrghnshhkihesrghrmhgruggvuhhsrdgtohhmqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdpoffvtefjohhsthepmhhoheekuddpmhhouggvpehsmhhtphhouhht
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

Hi Stefano,

On 10/16/23 16:22, Stefano Babic wrote:
> Hi Sebastian,
> 
> On 27.07.23 10:33, Sébastien Szymanski wrote:
>> Add support for DWC EQoS MAC on i.MX93.
>>
>> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
>> ---
>>   drivers/net/dwc_eth_qos.c     | 4 ++++
>>   drivers/net/dwc_eth_qos_imx.c | 3 +++
>>   2 files changed, 7 insertions(+)
>>
>> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
>> index 1e92bd9ca9c0..f70f8afe5831 100644
>> --- a/drivers/net/dwc_eth_qos.c
>> +++ b/drivers/net/dwc_eth_qos.c
>> @@ -1717,6 +1717,10 @@ static const struct udevice_id eqos_ids[] = {
>>           .compatible = "nxp,imx8mp-dwmac-eqos",
>>           .data = (ulong)&eqos_imx_config
>>       },
>> +    {
>> +        .compatible = "nxp,imx93-dwmac-eqos",
>> +        .data = (ulong)&eqos_imx_config
>> +    },
>>   #endif
>>   #if IS_ENABLED(CONFIG_DWC_ETH_QOS_QCOM)
>> diff --git a/drivers/net/dwc_eth_qos_imx.c 
>> b/drivers/net/dwc_eth_qos_imx.c
>> index 60f3f3f5a10f..e3f55dd98173 100644
>> --- a/drivers/net/dwc_eth_qos_imx.c
>> +++ b/drivers/net/dwc_eth_qos_imx.c
>> @@ -181,6 +181,9 @@ static int eqos_set_tx_clk_speed_imx(struct 
>> udevice *dev)
>>       ulong rate;
>>       int ret;
>> +    if (device_is_compatible(dev, "nxp,imx93-dwmac-eqos"))
>> +        return 0;
>> +
>>       debug("%s(dev=%p):\n", __func__, dev);
>>       if (eqos->phy->interface == PHY_INTERFACE_MODE_RMII)
> 
> Your series breaks Rockchip's boards. For example:
> 
> +aarch64-linux-ld.bfd: 
> drivers/net/dwc_eth_qos.o:(.rodata.eqos_ids+0x28): undefined reference 
> to `eqos_imx_config'
> +make[1]: *** [Makefile:1765: u-boot] Error 1
> +make: *** [Makefile:177: sub-make] Error 2
>     aarch64:  w+   rock-4c-plus-rk3399
> 
> But it is just an example, quite all boards are broken. Please check 
> this and repost, thanks !

https://source.denx.de/u-boot/custodians/u-boot-imx/-/blob/99807515b8eeff11487a278c956ed1893d54e61e/drivers/net/dwc_eth_qos.c#L1720

That's because, for some reason, the "nxp,imx93-dwmac-eqos" ended up in 
the if CONFIG_DWC_ETH_QOS_ROCKCHIP / def statement... I'll send a v2.

Also, I am confused: why did I receive mails saying other patches of 
this series have been applied ?

Regards,

> 
> Best regards,
> Stefano
> 

-- 
Sébastien Szymanski, Armadeus Systems
Software engineer

