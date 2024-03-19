Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35FAC54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 14:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F591880A6;
	Tue, 19 Mar 2024 15:18:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710857913;
	bh=tT5A7GJFKeusyYh2wtcd0HqHuH0ynhHGR5zcsu3KTag=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OdMFtQ+le4DA4KMnCcjJJUvoMDH9En+MpZK55fFKznkGkQfl8nkFPGCEEpxwk/H/B
	 xhF1BCQzVHUIqvzkNbakS32gEWHMe7bqBeSOJpN2WUy0v+Sx6kzw/1+NITn2GWUTLb
	 5wgDmUt9OqFdGvlwp71i8IFg35BrS9BrVDJVd/ljksNF178VdM9e3wovtidEDyWSjv
	 19HI5JFmacL+AvL7QdsIJ13uTwC6WkLwoIEcVE6LWpg6nAw+w4tKE1SEFukGVDKZvt
	 5Jg03TB/c4sMbwQUrj9dI76B7CoJpGTLQBdcF+a8Td+FXWeeQu2BT8COrnQmBzYwO3
	 0qY/1dSTqAyPg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8004088064;
 Tue, 19 Mar 2024 15:18:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710857909;
 bh=tT5A7GJFKeusyYh2wtcd0HqHuH0ynhHGR5zcsu3KTag=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=dfi7TN1mJZYmZZj0AmGL0dTcaoN/ytUQp0Le2MaPTv55eQ/Ni0R2BqNk2V8T+FlbS
 hDL96kYg9Wsl+dg105YxUsgE35hgqjlHXScmsRHILTw+5qtyC1slYw028GnIaJYw6W
 43MJHQN5XHMkVswyYMafgbuCTwR/5YZHLXL+1BCfzEq0toGY9e5yy/cAD4kS96sz2V
 lVR5++eylREa6OSwkbX3WuekX2IRVPryW5OVA9OIwrB3EW2PBb422DYuJ8qqrLOG/w
 tgz6Ca8wzAZn5rRiH8Akp2aRvIhqGmB+jLWk4mXseSybMDdCpxeJND86FztYGHT2jz
 6YX9j0UVd5vtw==
Message-ID: <32150e9d-0816-4b73-9964-bb285f251de7@denx.de>
Date: Tue, 19 Mar 2024 14:58:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] configs: imx93-phyboard-segin: Add USB support.
Content-Language: en-US
To: Wadim Egorov <w.egorov@phytec.de>, Mathieu Othacehe <othacehe@gnu.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Shiji Yang <yangshiji66@outlook.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Stefano Babic <sbabic@denx.de>,
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Yannic Moog <y.moog@phytec.de>,
 Primoz Fiser <primoz.fiser@norik.com>,
 Christoph Stoidner <c.stoidner@phytec.de>
Cc: u-boot@lists.denx.de
References: <20240318171637.12664-1-othacehe@gnu.org>
 <20240318171637.12664-3-othacehe@gnu.org>
 <ae1e53d1-cedc-4ef8-be42-b9d807640b55@denx.de>
 <7e5fd344-774e-4b45-8bad-5054d9b3a7b4@phytec.de>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <7e5fd344-774e-4b45-8bad-5054d9b3a7b4@phytec.de>
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

On 3/19/24 9:39 AM, Wadim Egorov wrote:
> 
> Am 18.03.24 um 22:48 schrieb Marek Vasut:
>> On 3/18/24 6:16 PM, Mathieu Othacehe wrote:
>>> Enable the `usb` command and some USB drivers.
>>>
>>> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
>>> ---
>>>   configs/imx93-phyboard-segin_defconfig | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/configs/imx93-phyboard-segin_defconfig 
>>> b/configs/imx93-phyboard-segin_defconfig
>>> index 24f9bd553aa..5acb987b817 100644
>>> --- a/configs/imx93-phyboard-segin_defconfig
>>> +++ b/configs/imx93-phyboard-segin_defconfig
>>> @@ -23,6 +23,7 @@ CONFIG_SPL_STACK=0x20519dd0
>>>   CONFIG_SPL=y
>>>   CONFIG_ENV_OFFSET_REDUND=0x720000
>>>   CONFIG_CMD_DEKBLOB=y
>>> +CONFIG_CMD_USB=y
>>>   CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
>>>   CONFIG_SYS_LOAD_ADDR=0x80400000
>>>   CONFIG_SYS_MEMTEST_START=0x80000000
>>> @@ -132,6 +133,13 @@ CONFIG_SPL_SYSRESET=y
>>>   CONFIG_SYSRESET_WATCHDOG=y
>>>   CONFIG_DM_THERMAL=y
>>>   CONFIG_IMX_TMU=y
>>> +CONFIG_USB=y
>>> +CONFIG_USB_EHCI_HCD=y
>>> +CONFIG_USB_GADGET=y
>>> +CONFIG_USB_GADGET_MANUFACTURER="FSL"
>>> +CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
>>> +CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
>>
>> Shouldn't this by Phytec or similar USB IDs ?
> AFAIK, PHYTEC does not have its own IDs registered yet. So the freescale 
> IDs should be fine.

Manufacturer can still be Phytec , can it not ?
