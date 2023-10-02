Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EF0E748F0
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 16:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A86786DF6;
	Mon,  2 Oct 2023 18:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NU4AJTJK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58BA387161; Mon,  2 Oct 2023 18:14:14 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD11C8712A
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 18:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 49151B811C4;
 Mon,  2 Oct 2023 16:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A01C433C9;
 Mon,  2 Oct 2023 16:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696263251;
 bh=gV/fkLoDPIuifi08v8GVgFEYm0ZjFu7Jy0rh3e1XIx8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NU4AJTJKY1czslasX4WRQmqVzKNJqPyIzVLQkjll4hRI7uc5m4/7dVz5q2LWkVXQ/
 JOxda4EmlCCRIbB5Y31mODbvRptKQKz6BiFuAvVOvm892kWH8XjbhppHT6UTKAa4Hq
 pEZzUPaWFDb3cplC9zGKBNlOdMdFTUuyyqeQt2ZQrZCulx1e9dv/wsYWHLgUD5yBXj
 IFuvWAol29RvrhEb5IEOPyU/JuiUCWTXme0uerIL37j8zv9qfSg8rgZ1p1ADlPCBUT
 9Jb7qXqKjW7B4WZGpyPByHviEtBWVFAK3VMQoOr3opWB3x8XAdPIAPQjj2gc54ZkMY
 10a6Pp9CPNovg==
Message-ID: <2da83643-3dbc-422b-97a4-477fcf259c76@kernel.org>
Date: Mon, 2 Oct 2023 19:14:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] arm: dts: k3-am64-evm: Fix boot
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
Cc: trini@konsulko.com, vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org, 
 jonas@kwiboo.se, srk@ti.com, afd@ti.com, bb@ti.com, praneeth@ti.com,
 u-boot@lists.denx.de, massimo.pegorer+oss@gmail.com
References: <20230929134646.214781-1-rogerq@kernel.org>
 <20230929134646.214781-2-rogerq@kernel.org>
 <20231002151933.vxjpor26m6g4pgm3@compactor>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231002151933.vxjpor26m6g4pgm3@compactor>
Content-Type: text/plain; charset=UTF-8
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

Nishanth,

On 02/10/2023 18:19, Nishanth Menon wrote:
> On 16:46-20230929, Roger Quadros wrote:
>> Since commit [1] A53 u-boot proper is broken.
>> This is because nodes marked as 'bootph-pre-ram' are
>> not available at u-boot proper before relocation.
>>
>> To fix this we mark all nodes in sk-u-boot.dtsi as
>> 'bootph-all'.
>>
>> Move vtt_supply and cbass_mcu node to -r5-evm.dts as
>> it is only required for R5 SPL.
>>
>> [1]
>> 9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre-reloc after relocation")
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  arch/arm/dts/k3-am642-evm-u-boot.dtsi | 56 ++++++++++++---------------
>>  arch/arm/dts/k3-am642-r5-evm.dts      |  8 ++++
>>  2 files changed, 32 insertions(+), 32 deletions(-)
>>
>> diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>> index c85f57d40f..d06955dfbc 100644
>> --- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>> +++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>> @@ -11,109 +11,101 @@
>>  	};
>>  
>>  	memory@80000000 {
>> -		bootph-pre-ram;
>> +		bootph-all;
>>  	};
>>  };
>>  
>> -&vtt_supply {
>> -	bootph-pre-ram;
>> -};
>> -
>>  &cbass_main {
>> -	bootph-pre-ram;
>> -};
>> -
>> -&cbass_mcu {
>> -	bootph-pre-ram;
>> +	bootph-all;
>>  };
>>  
>>  &main_timer0 {
>> -	bootph-pre-ram;
>> +	bootph-all;
>>  	clock-frequency = <200000000>;
>>  };
>>  
>>  &main_conf {
>> -	bootph-pre-ram;
>> +	bootph-all;
>>  	chipid@14 {
>> -		bootph-pre-ram;
>> +		bootph-all;
>>  	};
>>  };
>>  
>>  &main_pmx0 {
>> -	bootph-pre-ram;
>> +	bootph-all;
>>  };
>>  
>>  &main_i2c0_pins_default {
>> -	bootph-pre-ram;
>> +	bootph-all;
>>  };
>>  
>>  &main_i2c0 {
>> -	bootph-pre-ram;
>> +	bootph-all;
>>  };
>>  
>>  &main_uart0_pins_default {
>> -	bootph-pre-ram;
>> +	bootph-all;
>>  };
>>  
>>  &main_uart0 {
>> -	bootph-pre-ram;
>> +	bootph-all;
>>  };
>>  
>>  &usb0 {
>>  	dr_mode="peripheral";
>> -	bootph-pre-ram;
>> +	bootph-all;
>>  };
>>  
>>  &usbss0 {
>> -	bootph-pre-ram;
>> +	bootph-all;
>>  };
>>  
>>  &main_mmc1_pins_default {
>> -	bootph-pre-ram;
>> +	bootph-all;
>>  };
>>  
>>  &main_usb0_pins_default {
>> -	bootph-pre-ram;
>> +	bootph-all;
>>  };
>>  
>>  &dmss {
>> -	bootph-pre-ram;
>> +	bootph-all;
>>  };
>>  
>>  &secure_proxy_main {
>> -	bootph-pre-ram;
>> +	bootph-all;
>>  };
>>  
>>  &dmsc {
>> -	bootph-pre-ram;
>> +	bootph-all;
>>  	k3_sysreset: sysreset-controller {
>>  		compatible = "ti,sci-sysreset";
>> -		bootph-pre-ram;
>> +		bootph-all;
>>  	};
>>  };
>>  
>>  &k3_pds {
>> -	bootph-pre-ram;
>> +	bootph-all;
>>  };
>>  
>>  &k3_clks {
>> -	bootph-pre-ram;
>> +	bootph-all;
>>  };
>>  
>>  &k3_reset {
>> -	bootph-pre-ram;
>> +	bootph-all;
>>  };
>>  
>>  &sdhci0 {
>> -	bootph-pre-ram;
>> +	bootph-all;
>>  };
>>  
>>  &sdhci1 {
>> -	bootph-pre-ram;
>> +	bootph-all;
>>  };
>>  
>>  &cpsw3g {
>> -	bootph-pre-ram;
>> +	bootph-all;
>>  };
>>  
>>  &cpsw_port2 {
>> diff --git a/arch/arm/dts/k3-am642-r5-evm.dts b/arch/arm/dts/k3-am642-r5-evm.dts
>> index 73461f8f6c..696735d8e2 100644
>> --- a/arch/arm/dts/k3-am642-r5-evm.dts
>> +++ b/arch/arm/dts/k3-am642-r5-evm.dts
>> @@ -40,6 +40,10 @@
>>  	};
>>  };
>>  
>> +&vtt_supply {
>> +	bootph-pre-ram;
>> +};
>> +
>>  &cbass_main {
>>  	sysctrler: sysctrler {
>>  		compatible = "ti,am654-system-controller";
>> @@ -53,6 +57,10 @@
>>  	bootph-pre-ram;
>>  };
>>  
>> +&cbass_mcu {
>> +	bootph-pre-ram;
>> +};
> 
> A bit superfluous, but ok - we just need this atm for esm.

Just moved it from -uboot.dtsi to -r5-evm.dts.

>> +
>>  &mcu_esm {
>>  	bootph-pre-ram;
>>  };
>> -- 
>> 2.34.1
>>
> 
> Reviewed-by: Nishanth Menon <nm@ti.com>
> 

Please see suggestion by Massimo here
https://lore.kernel.org/all/CAC928HY2rZoz6L8za+L20GAsbJCBYOe+k75L_N3aE-78smnLfg@mail.gmail.com/

Do you agree we should change this series to use bootph-some-ram instead?

-- 
cheers,
-roger
