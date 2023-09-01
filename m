Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1092ACA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 09:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A098863DD;
	Fri,  1 Sep 2023 11:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=steffen.cc header.i=@steffen.cc header.b="rb5jsaLc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 721C58669D; Fri,  1 Sep 2023 11:00:37 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 588F2863DD
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 11:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lists@steffen.cc
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RcX733N7pz9sr4;
 Fri,  1 Sep 2023 11:00:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1693558831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zBIFHbqA3Y77X4OATwXNMldQFrhpY/zF//yeHK8H7xo=;
 b=rb5jsaLczMigo0mZfzuPLwF8g4dCdPQM864f0Dn38JvdyAMuDiLz0BuGR3ObJ0iD0n3Pul
 xDY+Z3Vwmh033Lx1HCSf0tuY8d3wWxGPTWUfURdBqeb+7VOe2OJD9hVW26afRESSYtRPNi
 3IlnYnI6wPt2RlhUi8t1dyzVjZBmbLbxqjgWQLdRRGavCw9B6yr0RZiKdEyHexGm7ugvNC
 mPeYgR6oK32bwEMcGJr328jUw/zHw1wP0d+InN3JXTteIwvDrY4JwxalyX/LLdghVhM28G
 0u/+Xm+nHd567QADelW5MgpeMxfHDuuNv8PiZUybDnClarLoUf/OMH0cR6vIzQ==
Message-ID: <4c458e6a-05e7-489c-ba3d-8d139024ddb1@steffen.cc>
Date: Fri, 1 Sep 2023 11:00:29 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 4/5] xilinx: zynqmp: add Beckhoff CX8200
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Cc: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
References: <20230830140349.10801-1-lists@steffen.cc>
 <20230830140349.10801-5-lists@steffen.cc>
 <ec8f243c-0084-b512-fe72-551e959e9103@amd.com>
Content-Language: , en-US
From: Steffen Dirkwinkel <lists@steffen.cc>
In-Reply-To: <ec8f243c-0084-b512-fe72-551e959e9103@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4RcX733N7pz9sr4
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



Am 01.09.23 um 09:36 schrieb Michal Simek:
> 
> 
> On 8/30/23 16:03, Steffen Dirkwinkel wrote:
>> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
>>
>> This adds support for the Beckhoff CX8200 series of industrial 
>> embedded PCs.
>> There is some information about the device and features here:
>> https://www.beckhoff.com/en-en/products/ipc/embedded-pcs/cx8200-arm-cortex-a53/
>>
>> Currently supported/tested:
>> - Boot from microSD
>> - Ethernet
>> - USB
>> - rtc / rtc eeprom
>> - tpm access
>> - uart
>>
>> Open points:
>> - adding the psgtr usb phy doesn't work in linux (failed to get pll
>>    lock)
>> - fpga loading currently only as u-boot script or pre launch cmd (type
>>    may be stored in eeprom of rtc so this could be made generic)
>>
>> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
>> ---
>>
>>   arch/arm/dts/Makefile                         |    1 +
>>   arch/arm/dts/zynqmp-beckhoff-cx8200.dts       |  247 +++
>>   .../zynqmp-beckhoff-cx8200/psu_init_gpl.c     | 1960 +++++++++++++++++
>>   configs/xilinx_zynqmp_virt_defconfig          |    2 +-
>>   4 files changed, 2209 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/arm/dts/zynqmp-beckhoff-cx8200.dts
>>   create mode 100644 
>> board/xilinx/zynqmp/zynqmp-beckhoff-cx8200/psu_init_gpl.c
> 
> First of all xilinx folder is not the right location because Xilinx/AMD 
> is not manufacturer of this board.

Yeah, sorry. I saw the avnet board and copied that.

> 
> Second I am normally pushing back on adding these custom boards because 
> it just increase time for maintaining.
> Your last commit was in 2019 but at least you have some commits that I 
> can trust that you would maintain your board for some time.

Our last board [1] only had linux/u-boot support as an afterthought. 
Customers had to buy a special option to set the right boot fuses, so 
most devices don’t boot u-boot.
With this board and a second similar zynqmp board (CX9240 [2]) we’ll 
have u-boot as default (and probably only) bootloader, so we’ll be
more active. We can also set two of us as maintainers and it would be 
fine to drop the boards if nobody responds.
We generally support these industrial boards for long time frames and 
would like to stay close to mainline instead of maintaining forks.

The alternative would be to have a downstream u-boot repository on 
github or somewhere. We’ll still likely have something there for build 
scripts / firmware builds / integration, but don’t plan to really 
diverge from upstream u-boot.

The main advantage of being in upstream u-boot would be that we can 
trigger internal CI on upstream changes. We can still do that and apply 
patches, but even simple patches like adding files to a makefile may 
fail to apply and will need fixing.


> 
> My biggest question is in what category is your board unique that it 
> should be added it to the tree?

Currently the board isn’t really unique. I guess we’d be the only users 
of the rtc with eeprom and there might be something needed for loading 
the correct fpga file based on eeprom (this might be done in linux / 
userspace or even u-boot script though)

[1] 
https://www.beckhoff.com/en-en/products/ipc/embedded-pcs/cx9020-arm-cortex-a8/cx9020.html#tab_productdetails_1
[2] 
https://www.beckhoff.com/en-en/products/ipc/embedded-pcs/cx9240-arm-cortex-a53/cx9240.html

> 
> Thanks,
> Michal
