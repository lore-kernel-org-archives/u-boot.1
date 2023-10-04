Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D250FE7C4E8
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33A1E8769B;
	Wed,  4 Oct 2023 20:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BuBrslu4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A64298768E; Wed,  4 Oct 2023 20:02:51 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BC748769E
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 20:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 394I2WQ5123873;
 Wed, 4 Oct 2023 13:02:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696442552;
 bh=YosF1vhzx4Jd6Vt+vzTkogN27AYNSKvm57Wh9tusyzE=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=BuBrslu4sWLbuZCa+of7GHObU6hopKSadAYKjF30Xr5YNBzq3mwY6mB96mlp1t913
 tebOd9GQfmji4Vs+/DO0J03Fh66dElRDlgIUogWFv1FU6pSzPWi5hi/GsFzpDqOC4p
 1+z71A5KDeDG0EbRKLQ2GcsGwpcjARjp+T0BcCTo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 394I2WLc129968
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 4 Oct 2023 13:02:32 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Oct 2023 13:02:31 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Oct 2023 13:02:31 -0500
Received: from [10.24.69.34] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 394I2Omm009718;
 Wed, 4 Oct 2023 13:02:25 -0500
Message-ID: <f9943f9f-e712-63ca-58ae-67107153eb60@ti.com>
Date: Wed, 4 Oct 2023 23:32:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 10/16] arm: dts: Introduce j784s4 u-boot dts files
Content-Language: en-US
To: Jerome Forissier <jerome.forissier@linaro.org>, Hari Nagalla
 <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neha Malcom
 Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Andrew Davis
 <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Nishanth Menon <nm@ti.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jayesh
 Choudhary <j-choudhary@ti.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
References: <20231001165545.494212-1-a-nandan@ti.com>
 <20231001165545.494212-11-a-nandan@ti.com>
 <83cb83de-f771-1054-98ed-0e322fc775a2@linaro.org>
From: Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <83cb83de-f771-1054-98ed-0e322fc775a2@linaro.org>
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


On 02/10/23 19:34, Jerome Forissier wrote:
> Hello Apurva,
>
> On 10/1/23 18:55, Apurva Nandan wrote:
>> Introduce the base dts files needed for u-boot or to augment the linux
>> dtbs for use in the u-boot-spl and u-boot binaries.
>>
>> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
>> [ add binman and ddr dtsi files ]
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
>> ---
>>   arch/arm/dts/Makefile                        |    2 +
>>   arch/arm/dts/k3-j784s4-binman.dtsi           |  505 +
>>   arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi | 8757 +++++++++++++++++
>>   arch/arm/dts/k3-j784s4-ddr.dtsi              | 8858 ++++++++++++++++++
>>   arch/arm/dts/k3-j784s4-evm-u-boot.dtsi       |   25 +
>>   arch/arm/dts/k3-j784s4-r5-evm.dts            |  105 +
>>   6 files changed, 18252 insertions(+)
>>   create mode 100644 arch/arm/dts/k3-j784s4-binman.dtsi
>>   create mode 100644 arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi
>>   create mode 100644 arch/arm/dts/k3-j784s4-ddr.dtsi
>>   create mode 100644 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
>>   create mode 100644 arch/arm/dts/k3-j784s4-r5-evm.dts
>>
>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>> index 85fd5b1157..21cfebff58 100644
>> --- a/arch/arm/dts/Makefile
>> +++ b/arch/arm/dts/Makefile
>> @@ -1327,6 +1327,8 @@ dtb-$(CONFIG_SOC_K3_J721S2) += k3-am68-sk-base-board.dtb\
>>   			       k3-am68-sk-r5-base-board.dtb\
>>   			       k3-j721s2-common-proc-board.dtb\
>>   			       k3-j721s2-r5-common-proc-board.dtb
>> +dtb-$(CONFIG_SOC_K3_J784S4) += k3-j784s4-evm.dtb\
>> +			       k3-j784s4-r5-evm.dtb
>>   dtb-$(CONFIG_SOC_K3_AM642) += k3-am642-evm.dtb \
>>   			      k3-am642-r5-evm.dtb \
>>   			      k3-am642-sk.dtb \
>> diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
>> new file mode 100644
>> index 0000000000..f9b191424c
>> --- /dev/null
>> +++ b/arch/arm/dts/k3-j784s4-binman.dtsi
>> @@ -0,0 +1,505 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
>> + */
> <snip>
>
>> +&binman {
>> +	ti-spl_unsigned {
>> +		filename = "tispl.bin_unsigned";
>> +		pad-byte = <0xff>;
>> +
>> +		fit {
>> +			description = "Configuration to load ATF and SPL";
>> +			#address-cells = <1>;
>> +
>> +			images {
>> +
>> +				atf {
>> +					description = "ARM Trusted Firmware";
>> +					type = "firmware";
>> +					arch = "arm64";
>> +					compression = "none";
>> +					os = "arm-trusted-firmware";
>> +					load = <CONFIG_K3_ATF_LOAD_ADDR>;
>> +					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
>> +
>> +					atf-bl31 {
>> +						filename = "bl31.bin";
>> +					};
>> +				};
>> +
>> +				tee {
>> +					description = "OPTEE";
> The official spelling is "OP-TEE".
>
>> +					type = "tee";
>> +					arch = "arm64";
>> +					compression = "none";
>> +					os = "tee";
>> +					load = <0x9e800000>;
>> +					entry = <0x9e800000>;
>> +
>> +					tee-os {
>> +						filename = "tee-pager_v2.bin";
> Since OP-TEE 3.21.0 this could/should be replaced with tee-raw.bin. Although tee-pager_v2.bin is still produced unconditionally (even when the "pager" feature is disabled in OP-TEE) it might not be the case in the future, and the name is somewhat misleading when pager is disabled anyways (which is clearly the case here since tee-pageable_v2.bin is not used).
>
> Thanks,
Okay will fix it

-- 
Regards,
Apurva Nandan,
Texas Instruments.

