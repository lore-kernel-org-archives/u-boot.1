Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD650C4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 17:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EE3B871DF;
	Fri,  1 Dec 2023 18:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="b0hRc7+H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0621D87209; Fri,  1 Dec 2023 18:33:06 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1758870A0
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 18:33:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B1HWloq122664;
 Fri, 1 Dec 2023 11:32:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701451967;
 bh=o/EQ257VTpd6rYFnyXvBvpgU2i+KiPrJd4EhSfWGP8I=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=b0hRc7+HVyxJ9cAJV5UK+g7S0jnSFOktwWoxkK/jGQcEBHpKe37pdz8il9UPBtgHB
 EBoghIuxKTeviv5eg0PER2dzDCRgyyJ2hmm8YeIBpHy21GVj7AlTPg1+GkSFpnPEIR
 MtETCZ87tWUwspQUDPd4R9eYuUKDS+Mq25haxUDQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B1HWls5001159
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Dec 2023 11:32:47 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Dec 2023 11:32:47 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Dec 2023 11:32:47 -0600
Received: from [10.249.139.5] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B1HWMIk056591;
 Fri, 1 Dec 2023 11:32:24 -0600
Message-ID: <1c30e6d9-5e14-48ba-8866-393d2d9432be@ti.com>
Date: Fri, 1 Dec 2023 23:02:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/17] arm: mach-k3: Add basic support for J784S4 SoC
 definition
Content-Language: en-US
To: Francesco Dolcini <francesco@dolcini.it>, Bryan Brattlof <bb@ti.com>
CC: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, Andrew Davis
 <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Nishanth Menon <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Roger Quadros <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
References: <20231130115552.3580995-1-a-nandan@ti.com>
 <20231130115552.3580995-5-a-nandan@ti.com>
 <20231201163755.p5tmttmjyo7pnnk3@bryanbrattlof.com>
 <ZWoS8OxLZYSsjbbO@francesco-nb.int.toradex.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <ZWoS8OxLZYSsjbbO@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Apurva

On 01-Dec-23 10:38 PM, Francesco Dolcini wrote:
> On Fri, Dec 01, 2023 at 10:37:55AM -0600, Bryan Brattlof wrote:
>> On November 30, 2023 thus sayeth Apurva Nandan:
>>> Add J784S4 initialization files for initial SPL boot.
>>>
>>> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
>>> [ add firewall configurations and change the R5 MCU scratchpad ]
>>> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
>>> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
>>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>>> ---
>>>   arch/arm/mach-k3/Kconfig                      |  16 +-
>>>   arch/arm/mach-k3/Makefile                     |   2 +
>>>   arch/arm/mach-k3/arm64-mmu.c                  |  52 +++
>>>   arch/arm/mach-k3/include/mach/hardware.h      |   4 +
>>>   .../mach-k3/include/mach/j784s4_hardware.h    |  60 ++++
>>>   arch/arm/mach-k3/include/mach/j784s4_spl.h    |  47 +++
>>>   arch/arm/mach-k3/include/mach/spl.h           |   4 +
>>>   arch/arm/mach-k3/j784s4_fdt.c                 |  15 +
>>>   arch/arm/mach-k3/j784s4_init.c                | 338 ++++++++++++++++++
>>>   arch/arm/mach-k3/r5/Makefile                  |   1 +
>>>   10 files changed, 532 insertions(+), 7 deletions(-)
>>>   create mode 100644 arch/arm/mach-k3/include/mach/j784s4_hardware.h
>>>   create mode 100644 arch/arm/mach-k3/include/mach/j784s4_spl.h
>>>   create mode 100644 arch/arm/mach-k3/j784s4_fdt.c
>>>   create mode 100644 arch/arm/mach-k3/j784s4_init.c
>>>
>>
>> ...
>>
>>> +	if (IS_ENABLED(CONFIG_TARGET_J784S4_R5_EVM)) {
>>> +		ret = uclass_get_device_by_name(UCLASS_MISC, "msmc", &dev);
>>> +		if (ret)
>>> +			panic("Probe of msmc failed: %d\n", ret);
>>> +
>>> +		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
>>> +		if (ret)
>>> +			panic("DRAM 0 init failed: %d\n", ret);
>>> +
>>> +		ret = uclass_next_device_err(&dev);
>>> +		if (ret)
>>> +			panic("DRAM 1 init failed: %d\n", ret);
>>> +
>>> +		ret = uclass_next_device_err(&dev);
>>> +		if (ret)
>>> +			panic("DRAM 2 init failed: %d\n", ret);
>>> +
>>> +		ret = uclass_next_device_err(&dev);
>>> +		if (ret)
>>> +			panic("DRAM 3 init failed: %d\n", ret);
>>> +	}
>>
>> I don't know if this is is the right approach. I can see situations
>> where people will not have all these controllers utilized or would want
>> to artificially remove them for some reason.
> 
> Not sure on the exact implication, but yes, you should expect customers
> (like myself/my company) integrating the SoC into some board to not
> necessarily use all the functionalities, memory controller included.
> 
> Francesco
> 

I think you can make use of uclass_next_device_err() and a while loop to 
handle this according to the device tree.

-- 
Thanking You
Neha Malcom Francis
