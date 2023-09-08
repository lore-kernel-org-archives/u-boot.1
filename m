Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5B3EE57E4
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 08:44:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3747E865D0;
	Fri,  8 Sep 2023 10:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YtSyY5fC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24FA38664A; Fri,  8 Sep 2023 10:44:02 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D133286580
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 10:43:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3888htWB047043;
 Fri, 8 Sep 2023 03:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694162636;
 bh=svLIqQiZ4CGnoMiwJt7l5MvQ+SZg24NiBKHOSP8oJ8Q=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=YtSyY5fCbPwu2Kv1aLzCFPVZ/ow4maCJlS18Hk8MeDkJQH3D1T2lKL3+1E4strU8z
 zBFxQaff04dtQ2kCoNkMpKt2HG7jBTzLHrRsMqwuchaTSOPaqN2k3vp7nGqnNZhn1d
 wdKoBVrcpXCZ2/rS6vklvOp1hJYVdQbs6arMTAa0=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3888ht3X092571
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Sep 2023 03:43:55 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Sep 2023 03:43:55 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Sep 2023 03:43:55 -0500
Received: from [10.24.68.114] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3888hp0P011722;
 Fri, 8 Sep 2023 03:43:52 -0500
Message-ID: <e616fb55-6f38-fd88-45de-0ed5c6d1e989@ti.com>
Date: Fri, 8 Sep 2023 14:13:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 7/7] arm: dts: k3-j721e: Sync with v6.5-rc1
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <nm@ti.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <afd@ti.com>, <sinthu.raja@ti.com>, <gadiyar@ti.com>,
 <a-nandan@ti.com>, <vaishnav.a@ti.com>
References: <20230907141407.382215-1-n-francis@ti.com>
 <20230907141407.382215-8-n-francis@ti.com>
 <20230908081226.auh2dted5ums5p2e@ula0497581>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20230908081226.auh2dted5ums5p2e@ula0497581>
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

Hi Manorit

On 08/09/23 13:42, Manorit Chawdhry wrote:
> Hi Neha,
> 
> On 19:44-20230907, Neha Malcom Francis wrote:
>> Sync k3-j721e DTS with kernel.org v6.5-rc1.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   .../k3-j721e-common-proc-board-u-boot.dtsi    | 146 +--
>>   arch/arm/dts/k3-j721e-common-proc-board.dts   | 483 ++++++---
>>   arch/arm/dts/k3-j721e-main.dtsi               | 974 ++++++++++++++++--
>>   arch/arm/dts/k3-j721e-mcu-wakeup.dtsi         | 280 ++++-
>>   .../arm/dts/k3-j721e-r5-common-proc-board.dts | 302 +-----
>>   arch/arm/dts/k3-j721e-r5-sk.dts               | 522 +---------
>>   arch/arm/dts/k3-j721e-sk-u-boot.dtsi          | 177 +---
>>   arch/arm/dts/k3-j721e-sk.dts                  | 663 +++++++++---
>>   arch/arm/dts/k3-j721e-som-p0.dtsi             | 226 ++--
>>   arch/arm/dts/k3-j721e-thermal.dtsi            |  75 ++
>>   arch/arm/dts/k3-j721e.dtsi                    |  32 +-
>>   11 files changed, 2365 insertions(+), 1515 deletions(-)
>>   create mode 100644 arch/arm/dts/k3-j721e-thermal.dtsi
>>
>> diff --git a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
>> index 540c847eb3..4cca01be61 100644
>> --- a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
>> +++ b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
>> @@ -7,15 +7,7 @@
> [..]
>> -
>>   	aliases {
>> -		ethernet0 = &cpsw_port1;
>> -		spi0 = &ospi0;
>> -		spi1 = &ospi1;
>>   		remoteproc0 = &mcu_r5fss0_core0;
>>   		remoteproc1 = &mcu_r5fss0_core1;
>>   		remoteproc2 = &main_r5fss0_core0;
>> @@ -25,61 +17,49 @@
>>   		remoteproc6 = &c66_0;
>>   		remoteproc7 = &c66_1;
>>   		remoteproc8 = &c71_0;
> 
> I don't think these aliases are used anywhere, they can be removed ig.
> 

I kept them from v1 review comment by Nishanth that remoteproc aliases have not 
been taken in upstream kernel [1]

>> -		i2c0 = &wkup_i2c0;
>> -		i2c1 = &mcu_i2c0;
>> -		i2c2 = &mcu_i2c1;
>> -		i2c3 = &main_i2c0;
>>   	};
>>   };
> [..]
> 
>> diff --git a/arch/arm/dts/k3-j721e-common-proc-board.dts b/arch/arm/dts/k3-j721e-common-proc-board.dts
>> index 1b600547c0..c1cbbae761 100644
>> --- a/arch/arm/dts/k3-j721e-common-proc-board.dts
>> +++ b/arch/arm/dts/k3-j721e-common-proc-board.dts
> 
> [..]
> 
>> diff --git a/arch/arm/dts/k3-j721e-main.dtsi b/arch/arm/dts/k3-j721e-main.dtsi
>> index cf3482376c..2ded1ee1a8 100644
>> --- a/arch/arm/dts/k3-j721e-main.dtsi
>> +++ b/arch/arm/dts/k3-j721e-main.dtsi
> 
> [..]
> 
>> diff --git a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
>> index 7bb5ce775c..0452e94b6d 100644
>> --- a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
>> +++ b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
>> @@ -12,16 +12,15 @@
>   -};
>> -
>> -&wkup_uart0 {
>> +&secure_proxy_mcu {
>>   	bootph-pre-ram;
>> -	pinctrl-names = "default";
>> -	pinctrl-0 = <&wkup_uart0_pins_default>;
>>   	status = "okay";
> 
> Am not sure if this should be okay or did I break something in my series
> by not setting this as okay, will see what Nishanth has to comment
> regarding this.
> 

Looking at k3-j721e-r5-common-proc-board.dts before sync, I see that the status 
was set to okay. I will look into whether it's in use any where or not.

>>   };
>>   
>> -&wkup_gpio0 {
>> -	pinctrl-names = "default";
>> -	pinctrl-0 = <&wkup_gpio_pins_default>;
>> +&cbass_mcu_wakeup {
>> +	sysctrler: sysctrler {
>> +		bootph-pre-ram;
>> +		compatible = "ti,am654-system-controller";
>> +		mboxes= <&secure_proxy_mcu 4>, <&secure_proxy_mcu 5>;
>> +		mbox-names = "tx", "rx";
>> +	};
>>   };
>>   
>>   &mcu_uart0 {
>> -	/delete-property/ power-domains;
>> -	/delete-property/ clocks;
>> -	/delete-property/ clock-names;
>> -	pinctrl-names = "default";
>> -	pinctrl-0 = <&mcu_uart0_pins_default>;
>> -	status = "okay";
>>   	clock-frequency = <48000000>;
>>   };
>>   
>> -&main_uart0 {
>> -	pinctrl-names = "default";
>> -	pinctrl-0 = <&main_uart0_pins_default>;
>> -	status = "okay";
>> -	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
>> -};
>> -
>>   &main_sdhci0 {
>> -	/delete-property/ power-domains;
>> -	/delete-property/ assigned-clocks;
>> -	/delete-property/ assigned-clock-parents;
>> -	clock-names = "clk_xin";
>> -	clocks = <&clk_200mhz>;
>> -	ti,driver-strength-ohm = <50>;
>> -	non-removable;
>> +	clock-frequency = <200000000>;
>>   	bus-width = <8>;
> 
> This property will need to be removed too I believe.
> 

Yes I see it's not used in the U-Boot driver, will remove it.

>>   };
>>   
>>   &main_sdhci1 {
>> -	/delete-property/ power-domains;
>> -	/delete-property/ assigned-clocks;
>> -	/delete-property/ assigned-clock-parents;
>> -	pinctrl-names = "default";
>> -	pinctrl-0 = <&main_mmc1_pins_default>;
>> -	clock-names = "clk_xin";
>> -	clocks = <&clk_200mhz>;
>> -	ti,driver-strength-ohm = <50>;
>> +	clock-frequency = <19200000>;
>>   };
>>   
>>   &wkup_i2c0 {
>> @@ -293,96 +124,35 @@
>>   };
>>   
>>   &usbss0 {
>> -	/delete-property/ power-domains;
>> -	/delete-property/ assigned-clocks;
>> -	/delete-property/ assigned-clock-parents;
>> -	clocks = <&clk_19_2mhz>;
>> -	clock-names = "ref";
>> -	pinctrl-names = "default";
>> -	pinctrl-0 = <&main_usbss0_pins_default>;
>> -	ti,vbus-divider;
>> -};
>> -
> 
> [..]
>> diff --git a/arch/arm/dts/k3-j721e-r5-sk.dts b/arch/arm/dts/k3-j721e-r5-sk.dts
>> index 1cc64d07f7..f5eb29a861 100644
>> --- a/arch/arm/dts/k3-j721e-r5-sk.dts
>> +++ b/arch/arm/dts/k3-j721e-r5-sk.dts
> 
> With the above comments.
> 
> Reviewed-By: Manorit Chawdhry <m-chawdhry@ti.com>
> 

Thanks for the review!

> Regards,
> Manorit

[1] https://lore.kernel.org/lkml/20230822215042.yjaqtwhuhls57pbu@glamour/T/

-- 
Thanking You
Neha Malcom Francis
