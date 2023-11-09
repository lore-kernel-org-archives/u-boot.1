Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730CEC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 09:34:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E85E286053;
	Thu,  9 Nov 2023 10:34:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="IUXAj/UF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D578087190; Thu,  9 Nov 2023 10:34:20 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02A97842D0
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 10:34:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d4ad=GW=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1699522432;
 bh=FOVHk2yAsF7xYZvBoPDiqVsQB9nIOKx1Y/Jp5dDnWkE=;
 b=IUXAj/UFi3Y9b/nMn85Z6Sjkd8+rN9V1iCGJT1ZahS8s1bRo57NX9S1Pkstna6k8W1YJCBohm
 fiR+5DHkSKX1huJAMuqUWX+oFeQytWUPqd/aE0FQ2ERAjKKwneheIO8c9y3ssMKCUhR7GQQwWno
 EWzIzdZJwByVVAzgqUAKUGbzCCESIinr3IZWt1rwMYrEvWmaIwP1HjYrIMe2nrH59V8/DB9H5LF
 3tMc3LlQ6wVaii/z+9+ftd5ohjLjnAgicDgWi8S9kW8FWgMX5M00avS7RhdNmO2VMcMqoUY1Sw3
 E83y2NVX2xkby9kiPpQbn5miwmBa0zUPq+O2tuumE6eA==
Message-ID: <0caf81e2-5524-4f12-b837-a2070739c613@kwiboo.se>
Date: Thu, 9 Nov 2023 10:33:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] configs: rockchip: Use dwc3-generic driver on RK3328
 and RK3399
Content-Language: en-US
To: Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>, Nick Xie <nick@khadas.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Deepak Das <deepakdas.linux@gmail.com>,
 Alexandre Vicenzi <linux@alxd.me>, Xiaobo Tian <peterwillcn@gmail.com>,
 Tianling Shen <cnsztl@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 "=?UTF-8?B?546L5piO5oiQ?=" <frank.wang@rock-chips.com>
Cc: u-boot@lists.denx.de
References: <20231018223058.2081052-1-jonas@kwiboo.se>
 <20231018223058.2081052-2-jonas@kwiboo.se>
 <0799d3c2-7997-4e78-aefb-fe571ebc53a4@denx.de>
 <a755aeb3-90e8-cabc-c941-6700805017ec@kwiboo.se>
 <db121593-6678-4069-bf11-dc67308f66c6@denx.de>
 <915c92ad-d6e0-4b75-b7c0-a5d3f9041ef7@rock-chips.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <915c92ad-d6e0-4b75-b7c0-a5d3f9041ef7@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 654ca77fe702e43be5cb4fd6
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

On 2023-11-09 04:29, Kever Yang wrote:
> Hi Jonas, Marek,
> 
> On 2023/10/20 12:23, Marek Vasut wrote:
>> On 10/19/23 22:39, Jonas Karlman wrote:
>>> On 2023-10-19 01:44, Marek Vasut wrote:
>>>> On 10/19/23 00:30, Jonas Karlman wrote:
>>>>
>>>> [..]
>>>>
>>>>> +++ b/configs/rock960-rk3399_defconfig
>>>>> @@ -50,6 +50,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>>>>>    CONFIG_SYS_MMC_ENV_DEV=1
>>>>>    CONFIG_ROCKCHIP_GPIO=y
>>>>>    CONFIG_SYS_I2C_ROCKCHIP=y
>>>>> +CONFIG_MISC=y
>>>>>    CONFIG_MMC_DW=y
>>>>>    CONFIG_MMC_DW_ROCKCHIP=y
>>>>>    CONFIG_MMC_SDHCI=y
>>>>> @@ -70,12 +71,12 @@ CONFIG_SYS_NS16550_MEM32=y
>>>>>    CONFIG_SYSRESET=y
>>>>>    CONFIG_USB=y
>>>>>    CONFIG_USB_XHCI_HCD=y
>>>>> -CONFIG_USB_XHCI_DWC3=y
>>>>>    CONFIG_USB_EHCI_HCD=y
>>>>>    CONFIG_USB_EHCI_GENERIC=y
>>>>>    CONFIG_USB_OHCI_HCD=y
>>>>>    CONFIG_USB_OHCI_GENERIC=y
>>>>>    CONFIG_USB_DWC3=y
>>>>> +CONFIG_USB_DWC3_GENERIC=y
>>>>
>>>> Why not add 'default y if ROCKCHIP' into the Kconfig instead ? This 
>>>> will
>>>> have the same effect, without requiring such massive modification of
>>>> config files.
>>>
>>> Not fully sure what you mean by this and how that would reduce number of
>>> affected defconfig-files. The USB_XHCI_DWC3 should still be removed from
>>> these defconfig-files or wrong driver could be used by these boards.
>>>
>>> Touching the defconfig-files help notify board maintainers that changes
>>> are happening to their boards.
> 
> This patch including remove old Kconfig option and add new option, just 
> move to
> 
> enable generic driver option in Kconfig file instead of defconfig file.
> 
>>>
>>> There will also be a separate patch that remove the rockchip,rk3399-dwc3
>>> compatible from the dwc3-of-simple driver to finalize this transition to
>>> use dwc3-generic driver for affected rockchip boards.
>>
>> It wasn't clear to me you're switching one driver to another, thanks 
>> for clarification.
>>
>> "
>> Also enable DM_USB_GADGET for any board that enable
>> USB_DWC3_GADGET.
>> "
>>
>> This you can do in Kconfig file, something like:
>> select DM_USB_GADGET if USB_DWC3_GADGET && <rockchip>
> 
> Not all the rockchip socs have usb dwc3 controller, so make this change 
> in SoC level will be better.
> 

I will try to send out a v2 of this later this weekend.

Regards,
Jonas

> 
> Thanks,
> 
> - Kever
> 

