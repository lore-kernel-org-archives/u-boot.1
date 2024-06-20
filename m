Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA61EC27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 05:30:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 144C1884CD;
	Thu, 20 Jun 2024 07:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="JudUHWcq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 430D688501; Thu, 20 Jun 2024 07:30:51 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1C6D8840F
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 07:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1718861448; x=1721453448;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5TAUf0rzGpHRiuc3NG8kO+STB/dY2i/wo+BvshJUivI=;
 b=JudUHWcq+zLYicVZcuiLBtf/85pHyJJu33HJ5w/D8xG91+7G8iJ3o6vZ2HS0ASA0
 nF6NI4gMT8XNWchgyl41eBi+hA5MBtcHiACeLUPPlaSD89oNi28iI8hg7HXxU3rT
 cjFL+5LGrEAgMjOrQYHsv3Zn2+4Xt9yOHxUgsCQZ6EI=;
X-AuditID: ac14000a-03251700000021bc-a3-6673be88bcff
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 70.62.08636.88EB3766;
 Thu, 20 Jun 2024 07:30:48 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 20 Jun
 2024 07:30:47 +0200
Message-ID: <0f41cd97-6876-43b8-a79a-9b047ae7485b@phytec.de>
Date: Thu, 20 Jun 2024 07:30:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] arm: mach-k3: Add default ATF location for AM62/AM62a
To: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>, Dhruva Gole
 <d-gole@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, <u-boot@lists.denx.de>, Robert Nelson
 <robertcnelson@gmail.com>
References: <20240214163009.983034-1-afd@ti.com>
 <20240214163009.983034-2-afd@ti.com> <20240619114916.72icpumb2tumsnbt@dhruva>
 <20240619182005.yfkvf6ongwijorzz@dividable>
 <59c391a7-c6fe-4b04-891a-c6905ef29f20@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <59c391a7-c6fe-4b04-891a-c6905ef29f20@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42JZI8nAo9uxrzjNYNccUYv3pyayW7Ss9bA4
 eaOV3eLNj7NMFu+XfGS0+LZlG6PF1Emb2S3e7u1kt/h/9gO7A6fH7IaLLB47Z91l93h1YBW7
 x9k7Oxg9jt/YzhTAGsVlk5Kak1mWWqRvl8CVsf7uGpaCXTIV2/7eZ21g/CvWxcjJISFgIvHl
 2CbGLkYuDiGBJUwS505eZgZJCAncZZQ4c9sDxOYVsJG4evASK4jNIqAqcX92AyNEXFDi5Mwn
 LCC2qIC8xP1bM9hBbGEBP4k7Cz+D2SICERKfnrYxgSxgFrjOKLH0/BtmiG33GCVuHDrOBlLF
 LCAucevJfCYQm01AXeLOhm9g2zgFrCT+TIaIMwtYSCx+c5AdwpaXaN46G+pSeYkXl5azQLwj
 LzHt3GtmCDtUYuuX7UwTGIVnITl2FpJ1s5CMnYVk7AJGllWMQrmZydmpRZnZegUZlSWpyXop
 qZsYQXElwsC1g7FvjschRiYOxkOMEhzMSiK8z7uK0oR4UxIrq1KL8uOLSnNSiw8xSnOwKInz
 ru4IThUSSE8sSc1OTS1ILYLJMnFwSjUwzjdTm3SuSumBOcO+vcd8d/2yFZ/7c0GLVKfA3Rcz
 T/JI/PTocDi+/cKDs2eFMk9UMbKvtFdnvm/nLZUesDC1bYO2RfuJVi0Gw6Z915ZrTj8uaHvT
 cOajNv2WMGs2k6qnL9Z///PwlHn0VQbVF/E1e39YL8iZYLvRpyJ/s5+Ia62CtXr1njVLlFiK
 MxINtZiLihMB9VI31ZkCAAA=
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



Am 19.06.24 um 22:02 schrieb Andrew Davis:
> On 6/19/24 1:20 PM, Nishanth Menon wrote:
>> On 17:19-20240619, Dhruva Gole wrote:
>>> Hi,
>>>
>>> On Feb 14, 2024 at 10:30:04 -0600, Andrew Davis wrote:
>>>> There is a default ATF load address that is used for devices that have
>>>> ATF running in SRAM. For AM62 and AM62a, ATF runs from DRAM. Instead
>>>> of having to override the address in every defconfig, make add a
>>>> default for these ATF in DRAM devices.
>>>>
>>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>>> ---
>>>>   arch/arm/mach-k3/Kconfig               | 5 +++--
>>>>   configs/am62ax_evm_a53_defconfig       | 1 -
>>>>   configs/am62x_beagleplay_a53_defconfig | 1 -
>>>>   configs/am62x_evm_a53_defconfig        | 1 -
>>>>   configs/phycore_am62x_a53_defconfig    | 1 -
>>>>   configs/verdin-am62_a53_defconfig      | 1 -
>>>>   6 files changed, 3 insertions(+), 7 deletions(-)
>>>>
>>>
>>> Beagleplay stops booting completely with latest U-boot so I did a little
>>> bisect and it seems like reverting this patch helps.
>>>
>>> I am not sure what other implications there are of reverting this so I
>>> don't suggest immediately dropping it, however some hints around what's
>>> missing on beagleplay vs other platforms would be helpful.
>>>
>>> Because other platforms based off the same SoC don't seem to be
>>> affected.
>>
>> Grumble... I had to rediscover this in parallel as well - Thanks Dhruva.
>> mkimage -l tispl.bin and comparing with kernel log of reserved mem
>> had me completely confused.
>>
>> a) Memory maps are already notorious to manage on complex heterogenous
>>    systems. From beagle perspective, we have no need to go and monkey
>>    with DT defined memory map and DT should be the default and modifying
> 
> Your DT source file is wrong, ATF is at 0x8000_0000 (or any address one
> wants to put in K3_ATF_LOAD_ADDR). DT doesn't "define" hardware, it 
> "describes"
> it. ATF's location is dynamic and configurable, it doesn't belong in DT.
> 
> You have two options, either go update your DT, then update it again every
> time ATF moves. *OR* simply turn on OF_SYSTEM_SETUP and let U-Boot add the
> correct location reserved memory node for you.
> 
> Then you can also drop out the reserved-node from the DT template file.
> Only U-Boot knows where ATF is really placed in RAM, so U-Boot must add
> this info to DT.

I think it is a good idea to remove the nodes from the device tree or at 
least mark them as "templates" and note that they are actually provided 
by the bootloader to make it less confusing.

> 
>>    DT should be explicitly called out with a log (instead of done
>>    "transparently") - so instead of CONFIG_K3_OPTEE_LOAD_ADDR default
>>    being forced from u-boot, it should be made optional, where when
>>    defined, it can overide the dt definition or some variant of that.
>>
>> b) Looks like
>>     https://lore.kernel.org/u-boot/20240214163009.983034-4-afd@ti.com/
>>     missed beagleplay? and we were in for a surprise there - i dont want
> 
> This was the only miss, OF_SYSTEM_SETUP didn't get added to the beagleplay
> config. Bryan just sent the fix for that now. I'll go look for a way to
> make this common across the whole SoC family so we don't again miss any
> new boards.
> 
> Andrew
> 
>>     to switch from default dts for beagleplay to something different just
>>     because of simplicity for users to know exactly the carveouts and
>>     with other s/w starting up on uC, dts is our "canonical truth".
>>
