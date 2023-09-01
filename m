Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE02CA0FE4
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 15:03:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C546847C8;
	Fri,  1 Sep 2023 17:03:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=steffen.cc header.i=@steffen.cc header.b="LVLcGDEg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54584847D3; Fri,  1 Sep 2023 17:03:39 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F66583F7A
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 17:03:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lists@steffen.cc
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Rch9x0w5gz9stf;
 Fri,  1 Sep 2023 17:03:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1693580613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cM7lcq/UXFbc6thZaBv2VFdC/f/P6zOzBRZx6xdwmSI=;
 b=LVLcGDEge6EHGMWc0P8CzTyEXoWo4Hvy3fSvQNANOPbUqKxREu648xq/HU7io8JQg2eQnB
 gH7//40weNG3i8B/2d5WU/cDVUVnIyta6PViSHw3V3cXRymcW/kZ6NOlEi5169s2uWHzHo
 sowFj0S4uLT9Y1BZWKl7wgqwB3LkzDPL5bM5RMaNYpuZFAmN3pGO0XM4VF97VPxfHymUi2
 8C2H4hSPSThBjtD0s+7z/EoYjdff+tAGJgFd+HbQ6TZ5Y46P2P3ekknFnvnX5ztU7giTa1
 Yc40ebRQALDnHxFh0Cbu2tKG8U0ugRfn12eHGZt2uYf6rQfClpn6HB0sPRU37A==
Message-ID: <15d4153e-a01c-4ba6-a5ed-9bc93a600a35@steffen.cc>
Date: Fri, 1 Sep 2023 17:03:31 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 4/5] xilinx: zynqmp: add Beckhoff CX8200
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Cc: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
References: <20230830140349.10801-1-lists@steffen.cc>
 <20230830140349.10801-5-lists@steffen.cc>
 <ec8f243c-0084-b512-fe72-551e959e9103@amd.com>
 <4c458e6a-05e7-489c-ba3d-8d139024ddb1@steffen.cc>
 <b7172191-ed03-e585-a2c0-bbebe3b7c6af@amd.com>
From: Steffen Dirkwinkel <lists@steffen.cc>
In-Reply-To: <b7172191-ed03-e585-a2c0-bbebe3b7c6af@amd.com>
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



Am 01.09.23 um 13:16 schrieb Michal Simek:
> 
> 
> On 9/1/23 11:00, Steffen Dirkwinkel wrote:
>>
>>
>> Am 01.09.23 um 09:36 schrieb Michal Simek:
>>>
>>>
>>> On 8/30/23 16:03, Steffen Dirkwinkel wrote:
>>>> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
>>>>
>>>> This adds support for the Beckhoff CX8200 series of industrial 
>>>> embedded PCs.
>>>> There is some information about the device and features here:
>>>> https://www.beckhoff.com/en-en/products/ipc/embedded-pcs/cx8200-arm-cortex-a53/
>>>>
>>>> Currently supported/tested:
>>>> - Boot from microSD
>>>> - Ethernet
>>>> - USB
>>>> - rtc / rtc eeprom
>>>> - tpm access
>>>> - uart
>>>>
>>>> Open points:
>>>> - adding the psgtr usb phy doesn't work in linux (failed to get pll
>>>>    lock)
>>>> - fpga loading currently only as u-boot script or pre launch cmd (type
>>>>    may be stored in eeprom of rtc so this could be made generic)
>>>>
>>>> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
>>>> ---
>>>>
>>>>   arch/arm/dts/Makefile                         |    1 +
>>>>   arch/arm/dts/zynqmp-beckhoff-cx8200.dts       |  247 +++
>>>>   .../zynqmp-beckhoff-cx8200/psu_init_gpl.c     | 1960 
>>>> +++++++++++++++++
>>>>   configs/xilinx_zynqmp_virt_defconfig          |    2 +-
>>>>   4 files changed, 2209 insertions(+), 1 deletion(-)
>>>>   create mode 100644 arch/arm/dts/zynqmp-beckhoff-cx8200.dts
>>>>   create mode 100644 
>>>> board/xilinx/zynqmp/zynqmp-beckhoff-cx8200/psu_init_gpl.c
>>>
>>> First of all xilinx folder is not the right location because 
>>> Xilinx/AMD is not manufacturer of this board.
>>
>> Yeah, sorry. I saw the avnet board and copied that.
>>
>>>
>>> Second I am normally pushing back on adding these custom boards 
>>> because it just increase time for maintaining.
>>> Your last commit was in 2019 but at least you have some commits that 
>>> I can trust that you would maintain your board for some time.
>>
>> Our last board [1] only had linux/u-boot support as an afterthought. 
>> Customers had to buy a special option to set the right boot fuses, so 
>> most devices don’t boot u-boot.
>> With this board and a second similar zynqmp board (CX9240 [2]) we’ll 
>> have u-boot as default (and probably only) bootloader, so we’ll be
>> more active. We can also set two of us as maintainers and it would be 
>> fine to drop the boards if nobody responds.
>> We generally support these industrial boards for long time frames and 
>> would like to stay close to mainline instead of maintaining forks.
>>
>> The alternative would be to have a downstream u-boot repository on 
>> github or somewhere. We’ll still likely have something there for build 
>> scripts / firmware builds / integration, but don’t plan to really 
>> diverge from upstream u-boot.
>>
>> The main advantage of being in upstream u-boot would be that we can 
>> trigger internal CI on upstream changes. We can still do that and 
>> apply patches, but even simple patches like adding files to a makefile 
>> may fail to apply and will need fixing.
>>
>>
>>>
>>> My biggest question is in what category is your board unique that it 
>>> should be added it to the tree?
>>
>> Currently the board isn’t really unique. I guess we’d be the only 
>> users of the rtc with eeprom and there might be something needed for 
>> loading the correct fpga file based on eeprom (this might be done in 
>> linux / userspace or even u-boot script though)
>>
>> [1] 
>> https://www.beckhoff.com/en-en/products/ipc/embedded-pcs/cx9020-arm-cortex-a8/cx9020.html#tab_productdetails_1
>> [2] 
>> https://www.beckhoff.com/en-en/products/ipc/embedded-pcs/cx9240-arm-cortex-a53/cx9240.html
> 
> Regarding board itself.
> It is DTB - we use OF_SEPARATE/OF_BOARD it means building is easy. I 
> expect you have pretty much something in PL that's why your DT is bigger 
> if you don't use DT overlays but for fixed design there is actually no 
> reason to use it.
> 
> psu_init_gpl. You are adding it to specific folder which match 
> DEVICE_TREE variable when you use it. You can actually just copy it to 
> board/xilinx/zynqmp/ folder and it will be pick up for your build.
> 
> xilinx_zynqmp_virt_defconfig - you likely don't want to use this in your 
> product because there are things enabled which you don't use on your 
> board. That's why you should tune it for your usage.
> 
> regs.init - that's for boot.bin generation with SPL - BOOT_INIT_FILE 
> should be used and it can't be wired via generic defconfig anyway.
> 
> That pretty much leads to the state that make no sense for you to use 
> xilinx_zynqmp_virt_defconfig.

There are things in the defconfig we don't need, but size hasn't really 
been an issue, since we boot from relatively large sdcards. We might 
still do separate config for all our boards though.

We currently build virt_defconfig and set BOOT_INIT_FILE, 
PMUFW_INIT_FILE and ZYNQMP_SPL_PM_CFG_OBJ_FILE. If we ship this firmware 
somewhere (similar to linux-firmware?) we could set fixed paths for that 
and make rebuilding u-boot simpler. I've found reproducing images for 
zynqmp devboards with and without using petalinux and the xilinx fsbl to 
be quite annoying on the first try and this could be simpler if one just 
wants to support generic arm64 distros.

> 
> I think we are still supporting defconfig fragments which is the way how 
> to maintain your board to be close to mainline as possible.
> 
> And fdt_addr change. I think this is for me the most problematic part 
> which should be solved. Pretty much all these variables should be moved 
> out and that's what we started to work on. But it will take some time to 
> get there.
> 

I agree, I can also work on that, but it will likely be in October since 
I'm on vacation for most of September. Maybe one of our other developers 
will work on it instead.

> Definitely there shouldn't be a problem to merge that rtc driver and I 
> would prefer if you can stay with your board out of upstream and try to 
> maintain it via your build scripts only. And let me know if we can 
> improve/fix something to be able to do it in long term. But pretty much 
> all things should be in place already to do it without pain. At least I 
> would like you to try it and see if there is any major blocker which we 
> can try to fix.

I don't really understand why the board shouldn't be upstream, once it 
is just a dts file + psu_init_gpl + regs. There really isn't much to 
maintain there that wouldn't also break out of tree.

We might be different from most other out of tree zynqmp users, since we 
usually also offer to sell hardware without our software and users would 
then either download an image from us or build their own u-boot + linux 
and only download the fpga bitstreams. I expect most people would look 
at upstream u-boot and linux before looking for our downstream repositories.

We can and will of course start with a downstream repository, I just 
don't understand why real (non-devboard) hardware should be out of tree.

Thanks,
Steffen


> 
> Thanks,
> Michal
> 
