Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B67CC71135
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 06:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB92181E18;
	Mon, 16 Jun 2025 08:45:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qQeGDDnl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA9C182063; Mon, 16 Jun 2025 08:45:09 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1722781E06
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 08:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55G6ioPu3742350;
 Mon, 16 Jun 2025 01:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750056290;
 bh=MWxICYxM7x5ma3/Q9bIhDrHfw/L4p6G7/u2qtobRiKI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=qQeGDDnlY/xrZclZ3Y98/oIWYcYI53obOYIs3J4MWARQVnTIwH/TYh6oWc5hJ2KzC
 0vF3/BEBKFjmrKPve5M3pOksI+duuK6jkv3WbtVl3bAHTUMnubv6SfV1LaXzW3f4N4
 n/5LTiwoJCMusIuOT8DIlGmi1Dkpmfp/QzJCKqbQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55G6inev718057
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 16 Jun 2025 01:44:49 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 16
 Jun 2025 01:44:49 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 16 Jun 2025 01:44:49 -0500
Received: from [172.24.227.4] (hp-z2-tower.dhcp.ti.com [172.24.227.4])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55G6ihuK3801620;
 Mon, 16 Jun 2025 01:44:43 -0500
Message-ID: <b406e576-54c9-4394-9bf8-d4d171de1d22@ti.com>
Date: Mon, 16 Jun 2025 12:14:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH] spl: Add support for Device Firmware
 Upgrade (DFU) over PCIe
To: Tom Rini <trini@konsulko.com>
CC: <Oliver.Gaskell@analog.com>, <peng.fan@nxp.com>, <malysagreg@gmail.com>,
 <nathan.morrison@timesys.com>, <twoerner@gmail.com>,
 <sjg@chromium.org>, <contact@paulk.fr>, <marex@denx.de>,
 <anshuld@ti.com>, <dario.binacchi@amarulasolutions.com>,
 <jerome.forissier@linaro.org>, <michael@amarulasolutions.com>,
 <a-dutta@ti.com>, <kever.yang@rock-chips.com>, <jonas@kwiboo.se>,
 <u-boot@lists.denx.de>, <danishanwar@ti.com>, <s-vadapalli@ti.com>,
 <srk@ti.com>, Hrushikesh Salunke <h-salunke@ti.com>
References: <20250612084910.3457060-1-h-salunke@ti.com>
 <20250612171337.GP1382132@bill-the-cat>
Content-Language: en-US
From: Hrushikesh Salunke <h-salunke@ti.com>
In-Reply-To: <20250612171337.GP1382132@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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



On 12/06/25 22:43, Tom Rini wrote:
> On Thu, Jun 12, 2025 at 02:19:10PM +0530, Hrushikesh Salunke wrote:
> 
>> Introduce support for Device Firmware Upgrade (DFU) over PCIe in
>> U-Boot. Traditionally, the DFU protocol is used over USB, where a
>> device enters DFU mode and allows a host to upload firmware or binary
>> images directly via the USB interface. This is a widely adopted and
>> convenient method for updating firmware.
> 
> Interesting, glad to see this overall.
> 
>> @@ -1328,6 +1336,59 @@ config SPL_RAM_DEVICE
>>   	  be already in memory when SPL takes over, e.g. loaded by the boot
>>   	  ROM.
>>   
>> +config SPL_PCI_DFU
>> +	bool "PCIe boot support"
> 
> Needs to depend on SPL_PCI_ENDPOINT
> 

Yes, I will update this is V2.

>> +	help
>> +		This config enables support to download bootloaders over PCIe
>> +		when device is acting as an PCI endpoint.
> 
> Correct the spacing.
> 

I missed this. Will take care of it in V2.

>> +config PCI_DFU_SPL_LOAD_FIT_ADDRESS
>> +	hex "Address to load FIT image when booting via DFU over PCIe"
>> +	default 0x00
> 
> No default, and then for the rest of these options put it under if
> SPL_PCI_DFU ... endif please.
> 
>> +config PCI_DFU_VENDOR_ID
>> +	hex "PCI Vendor ID for PCI endpoint"
>> +	default 0xffff
>> +	help
>> +		PCI Vendor ID for endpoint device for DFU over PCIe. This should
>> +		be set to your assigned 16-bit PCI Vendor ID.
>> +
>> +config PCI_DFU_DEVICE_ID
>> +	hex "PCI Vendor ID for PCI endpoint"
>> +	default 0xffff
>> +	help
>> +		A 16-bit PCI Vendor ID for endpoint device for DFU over PCIe.
> 
> No defaults here.
> 
>> +config PCI_DFU_BOOT_PHASE
>> +	string "Current boot phase for PCI DFU boot"
>> +	default "none"
> 
> Nor here.
> 
>> diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
>> index 71b7a8374bb..5bb94d6b972 100644
>> --- a/common/spl/spl_ram.c
>> +++ b/common/spl/spl_ram.c
>> @@ -27,6 +27,9 @@ static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
>>   	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
>>   		addr = IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
>>   				      CONFIG_SPL_LOAD_FIT_ADDRESS);
>> +
>> +		if (spl_boot_device() == BOOT_DEVICE_PCIE)
>> +			addr = CONFIG_PCI_DFU_SPL_LOAD_FIT_ADDRESS;
> 
> Probably need an IS_ENABLED(..) here first? And possibly a few other
> places too.
> 

Thanks for the feedback. I will update the patch based on
comments and post the V2.

Regards,
Hrushikesh.
