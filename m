Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4FDFC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 03:29:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DC8687045;
	Thu,  9 Nov 2023 04:29:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Wv78Rq5q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D39487090; Thu,  9 Nov 2023 04:29:41 +0100 (CET)
Received: from mail-m12737.qiye.163.com (mail-m12737.qiye.163.com
 [115.236.127.37])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42D0186EA3
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 04:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Wv78Rq5qR4IHm8MzkQLgZ/yKPX1MmUCYq60rY+pnpGnfdK+CvjP/abgk/W8yS9pqe6TO0vu3gsnJeCQ0zeX6lE3g9DU64D+qmyk3FxeRiuNZ/2ojWZoNVEyubo+55Rqum2uYG9REcK81r6bjuYCVzgRVediZfpZj/6OFQ0LUKyk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=HqVZIka8H7hshg7c/9p7o1XLJP2ryYiQ/e+f1cFzVKs=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 85D514002F6;
 Thu,  9 Nov 2023 11:29:21 +0800 (CST)
Message-ID: <915c92ad-d6e0-4b75-b7c0-a5d3f9041ef7@rock-chips.com>
Date: Thu, 9 Nov 2023 11:29:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] configs: rockchip: Use dwc3-generic driver on RK3328
 and RK3399
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>, Nick Xie <nick@khadas.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Deepak Das <deepakdas.linux@gmail.com>, Alexandre Vicenzi <linux@alxd.me>,
 Xiaobo Tian <peterwillcn@gmail.com>, Tianling Shen <cnsztl@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 =?UTF-8?B?546L5piO5oiQ?= <frank.wang@rock-chips.com>
Cc: u-boot@lists.denx.de
References: <20231018223058.2081052-1-jonas@kwiboo.se>
 <20231018223058.2081052-2-jonas@kwiboo.se>
 <0799d3c2-7997-4e78-aefb-fe571ebc53a4@denx.de>
 <a755aeb3-90e8-cabc-c941-6700805017ec@kwiboo.se>
 <db121593-6678-4069-bf11-dc67308f66c6@denx.de>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <db121593-6678-4069-bf11-dc67308f66c6@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkkeT1ZIHksZSB5DHksfHU9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8bb22096442eb3kusn85d514002f6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mio6ESo4Qzw9LQgeNQtJPDhD
 NjlPCz9VSlVKTUJCTktLTk1JTkNPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTEhDNwY+
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

Hi Jonas, Marek,

On 2023/10/20 12:23, Marek Vasut wrote:
> On 10/19/23 22:39, Jonas Karlman wrote:
>> On 2023-10-19 01:44, Marek Vasut wrote:
>>> On 10/19/23 00:30, Jonas Karlman wrote:
>>>
>>> [..]
>>>
>>>> +++ b/configs/rock960-rk3399_defconfig
>>>> @@ -50,6 +50,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>>>>    CONFIG_SYS_MMC_ENV_DEV=1
>>>>    CONFIG_ROCKCHIP_GPIO=y
>>>>    CONFIG_SYS_I2C_ROCKCHIP=y
>>>> +CONFIG_MISC=y
>>>>    CONFIG_MMC_DW=y
>>>>    CONFIG_MMC_DW_ROCKCHIP=y
>>>>    CONFIG_MMC_SDHCI=y
>>>> @@ -70,12 +71,12 @@ CONFIG_SYS_NS16550_MEM32=y
>>>>    CONFIG_SYSRESET=y
>>>>    CONFIG_USB=y
>>>>    CONFIG_USB_XHCI_HCD=y
>>>> -CONFIG_USB_XHCI_DWC3=y
>>>>    CONFIG_USB_EHCI_HCD=y
>>>>    CONFIG_USB_EHCI_GENERIC=y
>>>>    CONFIG_USB_OHCI_HCD=y
>>>>    CONFIG_USB_OHCI_GENERIC=y
>>>>    CONFIG_USB_DWC3=y
>>>> +CONFIG_USB_DWC3_GENERIC=y
>>>
>>> Why not add 'default y if ROCKCHIP' into the Kconfig instead ? This 
>>> will
>>> have the same effect, without requiring such massive modification of
>>> config files.
>>
>> Not fully sure what you mean by this and how that would reduce number of
>> affected defconfig-files. The USB_XHCI_DWC3 should still be removed from
>> these defconfig-files or wrong driver could be used by these boards.
>>
>> Touching the defconfig-files help notify board maintainers that changes
>> are happening to their boards.

This patch including remove old Kconfig option and add new option, just 
move to

enable generic driver option in Kconfig file instead of defconfig file.

>>
>> There will also be a separate patch that remove the rockchip,rk3399-dwc3
>> compatible from the dwc3-of-simple driver to finalize this transition to
>> use dwc3-generic driver for affected rockchip boards.
>
> It wasn't clear to me you're switching one driver to another, thanks 
> for clarification.
>
> "
> Also enable DM_USB_GADGET for any board that enable
> USB_DWC3_GADGET.
> "
>
> This you can do in Kconfig file, something like:
> select DM_USB_GADGET if USB_DWC3_GADGET && <rockchip>

Not all the rockchip socs have usb dwc3 controller, so make this change 
in SoC level will be better.


Thanks,

- Kever

