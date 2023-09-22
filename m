Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719ABE7D0A1
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 00:49:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 175FB85C98;
	Fri, 22 Sep 2023 02:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="jW14c4op";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2F378608A; Fri, 22 Sep 2023 02:49:08 +0200 (CEST)
Received: from mail-m118217.qiye.163.com (mail-m118217.qiye.163.com
 [115.236.118.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F44D85894
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 02:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=jW14c4op703nYkgQChJBDV1coVrOOiAl4vFEB0Dyc1YZxBt/6X5gzei8xxfQYGpQ2vAKlx71sLUEQ+GQrpvCB/IkO9kNWqaI+XK+hykK7F0VWfsuiMNwx8cvLQYiqEfq6M3nAPT2bsEtdfbUCeZJk87oXoHo7Ohwxk4/YkLwYqk=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=JKlsKxA3K94Y0McQncX1mBfijgozop6xdi0SPXNaQx0=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by mail-m11875.qiye.163.com (Hmail) with ESMTPA id 04EAF2810DD;
 Fri, 22 Sep 2023 08:48:47 +0800 (CST)
Message-ID: <259c11ad-3957-f6ad-a001-c73d8f91fdac@rock-chips.com>
Date: Fri, 22 Sep 2023 08:48:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 00/10] rockchip: rk3588: add support for DFU in SPL
Content-Language: en-US
To: Eugen Hristev <eugen.hristev@collabora.com>, u-boot@lists.denx.de
Cc: marex@denx.de, jonas@kwiboo.se, jagan@edgeble.ai, kernel@collabora.com
References: <20230801072811.10354-1-eugen.hristev@collabora.com>
 <1800682c-9c1b-c242-b15e-4cc9126e4619@collabora.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <1800682c-9c1b-c242-b15e-4cc9126e4619@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHkMYVhlPHktPT00aQ0xMHlUTARMWGhIXJBQOD1
 lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8aba5c56e82eb1kusn04eaf2810dd
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OlE6Fio5TDw6TTlRShUVES1K
 OEpPCjFVSlVKTUJOSE9ITElDQkxOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU5LS0s3Bg++
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


On 2023/9/21 22:47, Eugen Hristev wrote:
> On 8/1/23 10:28, Eugen Hristev wrote:
>> This series adds support for DFU in SPL for rockchip rk3588 on rock5b
>> board.
>>
>> Namely, when SPL is loaded via rockusb (thus via USB), having the
>> `same-as-spl` boot order item, after having detected that it was loaded
>> from USB, it will lookup the gadget USB node in DT and boot via DFU.
>>
>> Some changes were required namely:
>> - DFU needs environment, hence adding environment variables into DFU
>> - added bootph-all to nodes such that they are available in SPL
>> - insert gadget into boot order
>>
>> I had to port one patch for DWC3 from Linux, and include in this series
>> the patches that are floating from Venkatesh that fixup the DWC3
>> (https://marc.info/?l=u-boot&m=168351919807081&w=2 )
>>
>> I know that Marek NAKed them and I am fine with it, I am not trying to
>> sneak in any patches, they are not to be merged, also this patch
>> `usb: dwc3: Increase DWC3 controller halt timeout` is in the same bucket
>> so Marek you can NAK this one as well, no problem, I am just sending out
>> all the series so maybe the rockchip part for the gadget can be 
>> picked up
>> and if people want to use the DFU SPL gadget can also manually pick the
>> DWC3 patches. The branch with all the patches is available here :
>>
>> https://gitlab.collabora.com/hardware-enablement/rockchip-3588/u-boot
>>
>> Thanks!
>>
>> Changes in v2:
>> - rebased on latest upstream which caused a change in the config patch.
>>
>>
>> Eugen Hristev (7):
>>    rockchip: allow env defines for SPL build
>>    usb: dwc3: Increase DWC3 controller halt timeout
>>    ARM: dts: rockchip: rk3588-rock-5b-u-boot: add bootph-all to gadget
>>      nodes
>>    ARM: mach-rockchip: spl-boot-order: add possibility to DFU
>>    ARM: mach-rockchip: rk3588: add gadget device to the boot order
>>    rockchip: rk3588: prepare env for DFU
>>    configs: rockchip: rock5b-rk3588: enable DFU and related configs
>>
>> Venkatesh Yadav Abbarapu (3):
>>    usb: dwc3: core: improve reset sequence
>>    usb: dwc3: gadget: Don't send unintended link state change
>>    usb: dwc3: core: Only handle soft-reset in DCTL
>>
>>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi |  6 +++++
>>   arch/arm/mach-rockchip/rk3588/rk3588.c  |  1 +
>>   arch/arm/mach-rockchip/spl-boot-order.c |  3 +++
>>   configs/rock5b-rk3588_defconfig         | 18 +++++++++++---
>>   drivers/usb/dwc3/core.c                 | 32 +++++++++++++++----------
>>   drivers/usb/dwc3/gadget.c               | 20 +++++++---------
>>   drivers/usb/dwc3/gadget.h               | 14 +++++++++++
>>   include/configs/rk3588_common.h         |  9 ++++++-
>>   include/configs/rockchip-common.h       |  4 ----
>>   9 files changed, 76 insertions(+), 31 deletions(-)
>>
>
>
> Hello Kever,
>
> I see in patchwork this series is marked as 'Changes requested'.
> Do you wish to tell me which are the changes you requested, as I did 
> not see anything in your replies.
> I am interested to see the patches related to rockchip (not the DWC3), 
> if it's fine for you to merge them.

Hi Eugen,

     For rockchip platform part is fine to me, but as a patchset, the 
dwc3 part is NAKed by Marek, so patch set

not able to merge.

     If rockchip part can work without dwc3 change, you can send a 
separate patch set for it, so that I can merge it.


Thanks,

- Kever

>
> Thanks,
> Eugen
