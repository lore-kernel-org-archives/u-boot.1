Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F45ACDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 04:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18A7087230;
	Fri, 20 Oct 2023 06:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697775810;
	bh=I8EVaiUKC1WqPLuZLtAq6G0SIyPvhplXttMF1szYzaE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gVXJ0FETrcTmnX0I+syeWJov4Qr/V+zVVkdJSkPeGW4KXskMzWSEhVK40iFSl2WKg
	 wzVPiise/yJBBFZUobG+xJ1ETxeJuS3MsGk/yQQ9iR2W9uEaNmOHf4QKVIqERouWtJ
	 dBGX2bgEmJO4nivmVNaXNNTnk2A9PH1WrErcHyYeyN14AdeRacb90PsSR3hR2fhD3n
	 gxGdt7NTv5lGPMqMRxkHQ4oqllw1lzaRH7FH+gECY1L45eDq0bGYml5sYwJrkDUPfU
	 O05QxZKSm0/iR06Qkm9UCgWv+RvfOGCzaBkVd4s+MHrAR387R3sS59K4fcstALnhRL
	 WvMxkxT4IPEiQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CE837871F6;
 Fri, 20 Oct 2023 06:23:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697775808;
 bh=I8EVaiUKC1WqPLuZLtAq6G0SIyPvhplXttMF1szYzaE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=l6+uH+tdAp7MH6hOJEFZQ5FTSfRhlbRoItos2DFBnEhPCLmTPRk39sjSlSWrokpaC
 i7/r3CWAhTkV+LUE3XZsG1OYTOs4dT6cAJJ+YKJrsAPP6ENa9IOnbglStD56kJ0wNT
 QytHVB5YiZDXDMssekKMapIhrFI5rmNhtwLnXeRiUl4Hfel60hFvCNUUQtmsxsAcgM
 mF4nABYvQIeA9/22yPwa6BefmhBcKjhByoJJIQ97LKazMp8LRZvI4CcpUYCCDAwgP8
 CeqDluzzuFN1xA++BTMU4wTCdIjgrphUZuiX0i4kxPa6d2zdqroryZz5kHpov+Kp2y
 5fkTqGMBRIttg==
Message-ID: <db121593-6678-4069-bf11-dc67308f66c6@denx.de>
Date: Fri, 20 Oct 2023 06:23:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] configs: rockchip: Use dwc3-generic driver on RK3328
 and RK3399
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>, Nick Xie <nick@khadas.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Deepak Das <deepakdas.linux@gmail.com>, Alexandre Vicenzi <linux@alxd.me>,
 Xiaobo Tian <peterwillcn@gmail.com>, Tianling Shen <cnsztl@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: u-boot@lists.denx.de
References: <20231018223058.2081052-1-jonas@kwiboo.se>
 <20231018223058.2081052-2-jonas@kwiboo.se>
 <0799d3c2-7997-4e78-aefb-fe571ebc53a4@denx.de>
 <a755aeb3-90e8-cabc-c941-6700805017ec@kwiboo.se>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <a755aeb3-90e8-cabc-c941-6700805017ec@kwiboo.se>
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

On 10/19/23 22:39, Jonas Karlman wrote:
> On 2023-10-19 01:44, Marek Vasut wrote:
>> On 10/19/23 00:30, Jonas Karlman wrote:
>>
>> [..]
>>
>>> +++ b/configs/rock960-rk3399_defconfig
>>> @@ -50,6 +50,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>>>    CONFIG_SYS_MMC_ENV_DEV=1
>>>    CONFIG_ROCKCHIP_GPIO=y
>>>    CONFIG_SYS_I2C_ROCKCHIP=y
>>> +CONFIG_MISC=y
>>>    CONFIG_MMC_DW=y
>>>    CONFIG_MMC_DW_ROCKCHIP=y
>>>    CONFIG_MMC_SDHCI=y
>>> @@ -70,12 +71,12 @@ CONFIG_SYS_NS16550_MEM32=y
>>>    CONFIG_SYSRESET=y
>>>    CONFIG_USB=y
>>>    CONFIG_USB_XHCI_HCD=y
>>> -CONFIG_USB_XHCI_DWC3=y
>>>    CONFIG_USB_EHCI_HCD=y
>>>    CONFIG_USB_EHCI_GENERIC=y
>>>    CONFIG_USB_OHCI_HCD=y
>>>    CONFIG_USB_OHCI_GENERIC=y
>>>    CONFIG_USB_DWC3=y
>>> +CONFIG_USB_DWC3_GENERIC=y
>>
>> Why not add 'default y if ROCKCHIP' into the Kconfig instead ? This will
>> have the same effect, without requiring such massive modification of
>> config files.
> 
> Not fully sure what you mean by this and how that would reduce number of
> affected defconfig-files. The USB_XHCI_DWC3 should still be removed from
> these defconfig-files or wrong driver could be used by these boards.
> 
> Touching the defconfig-files help notify board maintainers that changes
> are happening to their boards.
> 
> There will also be a separate patch that remove the rockchip,rk3399-dwc3
> compatible from the dwc3-of-simple driver to finalize this transition to
> use dwc3-generic driver for affected rockchip boards.

It wasn't clear to me you're switching one driver to another, thanks for 
clarification.

"
Also enable DM_USB_GADGET for any board that enable
USB_DWC3_GADGET.
"

This you can do in Kconfig file, something like:
select DM_USB_GADGET if USB_DWC3_GADGET && <rockchip>
