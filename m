Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A20C47DDF
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 14:41:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B14ED87D1F;
	Tue, 23 Jan 2024 15:40:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="S/haZMrZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D33987D1F; Tue, 23 Jan 2024 15:40:57 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57ABE878A5
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 15:40:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NEehdk064472;
 Tue, 23 Jan 2024 08:40:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706020843;
 bh=3bQcnMZn0V/tFgJZPRpZxQi+AaFAQRLLvKZEIeiy3uI=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=S/haZMrZY/h7shNGU4VXWOgIpcI6TEIP76i9Gg9ilLJhpMsGElFEAFenbZqDYdTTJ
 GvVAjjtYBBRrKpUrkBPaW1sO9iMDeutapdSkA1xTDewJu7BjjpjJyUsZ2l/N6mMvm7
 CSHTi+UxXEHPRnYzchBZZ+zh75vUqBEz+4jOsV5c=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NEehOb128916
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 23 Jan 2024 08:40:43 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 08:40:43 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 08:40:43 -0600
Received: from [10.24.68.115] (ti.dhcp.ti.com [10.24.68.115] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NEdu0h079783; 
 Tue, 23 Jan 2024 08:40:37 -0600
Message-ID: <f3cf935a-c516-45c5-908f-fd7ea635c7b1@ti.com>
Date: Tue, 23 Jan 2024 20:10:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/16] arm: dts: Introduce am69-sk u-boot dts files
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon
 <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph
 Siemsen <ralph.siemsen@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
References: <20240119175043.3904751-1-a-nandan@ti.com>
 <20240119175043.3904751-14-a-nandan@ti.com>
 <e549c46f-af0d-43c5-b028-6a9bc5d9a1d9@kernel.org>
From: Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <e549c46f-af0d-43c5-b028-6a9bc5d9a1d9@kernel.org>
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


On 22/01/24 18:28, Roger Quadros wrote:
>
> On 19/01/2024 19:50, Apurva Nandan wrote:
>> From: Dasnavis Sabiya <sabiya.d@ti.com>
>>
>> Introduce the base dts files needed for u-boot or to augment the linux
>> dtbs for use in the u-boot-spl and u-boot binaries.
>>
>> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> ---
>>   arch/arm/dts/Makefile               |   1 +
>>   arch/arm/dts/k3-am69-r5-sk.dts      | 105 ++++++++++++++++++++++++++++
>>   arch/arm/dts/k3-am69-sk-u-boot.dtsi |  48 +++++++++++++
>>   board/ti/j784s4/MAINTAINERS         |   2 +
>>   4 files changed, 156 insertions(+)
>>   create mode 100644 arch/arm/dts/k3-am69-r5-sk.dts
>>   create mode 100644 arch/arm/dts/k3-am69-sk-u-boot.dtsi
>>
>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>> index 876802b88e..1c5a6662f6 100644
>> --- a/arch/arm/dts/Makefile
>> +++ b/arch/arm/dts/Makefile
>> @@ -1412,6 +1412,7 @@ dtb-$(CONFIG_SOC_K3_J721S2) += k3-am68-sk-base-board.dtb\
>>   			       k3-j721s2-r5-common-proc-board.dtb
>>   
>>   dtb-$(CONFIG_SOC_K3_J784S4) += k3-am69-sk.dtb \
>> +			       k3-am69-r5-sk.dtb \
>>   			       k3-j784s4-evm.dtb \
>>   			       k3-j784s4-r5-evm.dtb
>>   
>> diff --git a/arch/arm/dts/k3-am69-r5-sk.dts b/arch/arm/dts/k3-am69-r5-sk.dts
>> new file mode 100644
>> index 0000000000..d2e73bd1bf
>> --- /dev/null
>> +++ b/arch/arm/dts/k3-am69-r5-sk.dts
>> @@ -0,0 +1,105 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "k3-am69-sk.dts"
>> +#include "k3-j784s4-ddr-evm-lp4-4266.dtsi"
>> +#include "k3-j784s4-ddr.dtsi"
>> +#include "k3-am69-sk-u-boot.dtsi"
>> +
>> +/ {
>> +	chosen {
>> +		tick-timer = &mcu_timer0;
>> +	};
>> +
>> +	aliases {
>> +		remoteproc0 = &sysctrler;
>> +		remoteproc1 = &a72_0;
>> +	};
>> +
>> +	a72_0: a72@0 {
>> +		compatible = "ti,am654-rproc";
>> +		reg = <0x0 0x00a90000 0x0 0x10>;
>> +		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
>> +				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>;
>> +		resets = <&k3_reset 202 0>;
>> +		clocks = <&k3_clks 61 0>;
>> +		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
>> +		assigned-clock-parents = <&k3_clks 61 2>;
>> +		assigned-clock-rates = <200000000>, <2000000000>;
>> +		ti,sci = <&sms>;
>> +		ti,sci-proc-id = <32>;
>> +		ti,sci-host-id = <10>;
>> +		bootph-pre-ram;
>> +	};
>> +
>> +	dm_tifs: dm-tifs {
>> +		compatible = "ti,j721e-dm-sci";
>> +		ti,host-id = <3>;
>> +		ti,secure-host;
>> +		mbox-names = "rx", "tx";
>> +		mboxes= <&secure_proxy_mcu 21>, <&secure_proxy_mcu 23>;
>> +		bootph-pre-ram;
>> +	};
>> +};
>> +
>> +&mcu_timer0 {
>> +	status = "okay";
>> +	clock-frequency = <250000000>;
>> +	bootph-pre-ram;
>> +};
>> +
>> +&secure_proxy_sa3 {
>> +	status = "okay";
>> +	bootph-pre-ram;
>> +};
>> +
>> +&secure_proxy_mcu {
>> +	status = "okay";
>> +	bootph-pre-ram;
>> +};
>> +
>> +&cbass_mcu_wakeup {
>> +	sysctrler: sysctrler {
>> +		compatible = "ti,am654-system-controller";
>> +		mboxes= <&secure_proxy_mcu 4>,
>> +			<&secure_proxy_mcu 5>,
>> +			<&secure_proxy_sa3 5>;
>> +		mbox-names = "tx", "rx", "boot_notify";
>> +		bootph-pre-ram;
>> +	};
>> +};
>> +
>> +&sms {
>> +	mboxes= <&secure_proxy_mcu 8>, <&secure_proxy_mcu 6>, <&secure_proxy_mcu 5>;
>> +	mbox-names = "tx", "rx", "notify";
>> +	ti,host-id = <4>;
>> +	ti,secure-host;
>> +	bootph-pre-ram;
>> +};
>> +
>> +&wkup_uart0 {
>> +	bootph-pre-ram;
>> +	status = "okay";
> In k3-am69-sk.dts this is marked as reserved. Why do you need to enable it here?
> Maybe a comment would help readers.
Ohkay will fix.
>
>> +};
>> +
>> +&ospi0 {
>> +	reg = <0x0 0x47040000 0x0 0x100>,
>> +	      <0x0 0x50000000 0x0 0x8000000>;
>> +};
>> +
>> +&ospi1 {
>> +	reg = <0x0 0x47050000 0x0 0x100>,
>> +	      <0x0 0x58000000 0x0 0x8000000>;
>> +};
>> +
>> +&mcu_ringacc {
>> +	ti,sci = <&dm_tifs>;
>> +};
>> +
>> +&mcu_udmap {
>> +	ti,sci = <&dm_tifs>;
>> +};
>> diff --git a/arch/arm/dts/k3-am69-sk-u-boot.dtsi b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
>> new file mode 100644
>> index 0000000000..4f8c99a1e6
>> --- /dev/null
>> +++ b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
>> @@ -0,0 +1,48 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
>> + */
>> +
>> +#include "k3-j784s4-binman.dtsi"
>> +
>> +&mcu_udmap {
>> +	reg =   <0x0 0x285c0000 0x0 0x100>,
>> +		<0x0 0x284c0000 0x0 0x4000>,
>> +		<0x0 0x2a800000 0x0 0x40000>,
>> +		<0x0 0x284a0000 0x0 0x4000>,
>> +		<0x0 0x2aa00000 0x0 0x40000>,
>> +		<0x0 0x28400000 0x0 0x2000>;
>> +	reg-names = "gcfg", "rchan", "rchanrt", "tchan",
>> +		    "tchanrt", "rflow";
>> +	bootph-pre-ram;
>> +};
>> +
>> +&sms {
>> +	k3_sysreset: sysreset-controller {
>> +		compatible = "ti,sci-sysreset";
>> +		bootph-pre-ram;
>> +	};
>> +};
>> +
>> +#ifdef CONFIG_TARGET_J784S4_A72_EVM
>> +
>> +#define SPL_AM69_SK_DTB "spl/dts/k3-am69-sk.dtb"
>> +#define AM69_SK_DTB "arch/arm/dts/k3-am69-sk.dtb"
>> +
>> +&spl_j784s4_evm_dtb {
>> +	filename = SPL_AM69_SK_DTB;
>> +};
>> +
>> +&j784s4_evm_dtb {
>> +	filename = AM69_SK_DTB;
>> +};
>> +
>> +&spl_j784s4_evm_dtb_unsigned {
>> +	filename = SPL_AM69_SK_DTB;
>> +};
>> +
>> +&j784s4_evm_dtb_unsigned {
>> +	filename = AM69_SK_DTB;
>> +};
>> +
>> +#endif
>> diff --git a/board/ti/j784s4/MAINTAINERS b/board/ti/j784s4/MAINTAINERS
>> index ac6db23da5..53bc4bab03 100644
>> --- a/board/ti/j784s4/MAINTAINERS
>> +++ b/board/ti/j784s4/MAINTAINERS
>> @@ -16,3 +16,5 @@ F:	arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi
>>   
>>   AM69 SK BOARD
>>   F:	arch/arm/dts/k3-am69-sk.dts
>> +F:	arch/arm/dts/k3-am69-sk-u-boot.dtsi
>> +F:	arch/arm/dts/k3-am69-r5-sk.dts

-- 
Regards,
Apurva Nandan,
Texas Instruments.

