Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108ABC27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 18:58:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9070288548;
	Fri,  7 Jun 2024 20:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xvO/M3DU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14F7B8856F; Fri,  7 Jun 2024 20:55:05 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A1B888496
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 20:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 457IsuBj002617;
 Fri, 7 Jun 2024 13:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717786496;
 bh=VvNY6Kct2yUHI5tGp38pb8+jWKjcs9AInSE8qfrDhxg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=xvO/M3DUNONw6bRZMPOQrsbr0VuzSZ2UWREvWpExYWeFPJIZXD8uRXNORTqMzcT4w
 sECGpCJwHW5Y0klJyAwEsAKh8ygAoKG5BDMXO3lvQxR3KgTGgPcCTTDcr2R22P5oMh
 to99rPvPLCNB8WbH8ZBeWF/xi1D/o23P+xqJpkz4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 457Isubx036823
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Jun 2024 13:54:56 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jun 2024 13:54:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jun 2024 13:54:56 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 457Isth3126180;
 Fri, 7 Jun 2024 13:54:55 -0500
Message-ID: <e48f5818-182c-47ab-b384-379659830d38@ti.com>
Date: Fri, 7 Jun 2024 13:54:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm: dts: k3-am642-evm-u-boot: Add remoteproc-name
 for PRU cores
To: "Anwar, Md Danish" <a0501179@ti.com>, MD Danish Anwar
 <danishanwar@ti.com>, Judith Mendez <jm@ti.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Nikhil M Jain <n-jain1@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, Siddharth
 Vadapalli <s-vadapalli@ti.com>, Simon Glass <sjg@chromium.org>, Neha Malcom
 Francis <n-francis@ti.com>, Nishanth Menon <nm@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>
References: <20240522063652.3759497-1-danishanwar@ti.com>
 <20240522063652.3759497-2-danishanwar@ti.com>
 <cb53651f-a823-41b8-81e5-c3939bd33764@ti.com>
 <5cda289f-1d14-41f6-84e3-ff1d1034be13@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <5cda289f-1d14-41f6-84e3-ff1d1034be13@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

On 5/23/24 1:33 AM, Anwar, Md Danish wrote:
> Hi Andrew,
> 
> On 5/22/2024 9:38 PM, Andrew Davis wrote:
>> On 5/22/24 1:36 AM, MD Danish Anwar wrote:
>>> Add remoteproc-name property for PRU cores.
>>>
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>> ---
>>>    arch/arm/dts/k3-am642-evm-u-boot.dtsi | 44 +++++++++++++++++++++++++++
>>>    1 file changed, 44 insertions(+)
>>>
>>> diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>>> b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>>> index 705b3baa81..25ddace74e 100644
>>> --- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>>> +++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>>> @@ -11,6 +11,50 @@
>>>        };
>>>    };
>>>    +&pru0_0 {
>>> +    remoteproc-name = "pru0_0";
>>
>> Why do we need all these? Looks like we fallback to using `dev->name` if
>> these are not set, does that not work for us here?
>>
> 
> Yes we will fallback to `dev->name` if `remoteproc-name` is not set but
> in our case two different PRU cores will have same `dev->name`. As a
> result the API rproc_name_is_unique() will return false and as a result
> the probe will fail for the PRU cores.
> 

If `dev->name` is not unique, then combine it with something that is, or
remove the requirement for the name to be unique. Right now this looks
like just a hack around a framework requirement and a driver problem.

If you really think this is something that should be solved in DT then
go convince the DT maintainers and get it into the kernel DT. We should
be reducing the deltas we carry in -u-boot.dtsi files, not adding more
workarounds.

Andrew

> Example: In k3-am64-main.dtsi, both pru0_0 [1] and pru1_0 [2] will have
> dev->name as "pru@34000" same goes for rtu and txpru as well.
> 
> 		pru0_0: pru@34000 {
> 			compatible = "ti,am642-pru";
> 			reg = <0x34000 0x3000>,
> 			      <0x22000 0x100>,
> 			      <0x22400 0x100>;
> 			reg-names = "iram", "control", "debug";
> 			firmware-name = "am64x-pru0_0-fw";
> 		};
> 
> 		pru1_0: pru@34000 {
> 			compatible = "ti,am642-pru";
> 			reg = <0x34000 0x4000>,
> 			      <0x22000 0x100>,
> 			      <0x22400 0x100>;
> 			reg-names = "iram", "control", "debug";
> 			firmware-name = "am64x-pru1_0-fw";
> 		};
> 
> To avoid this, we are setting the "remoteproc-name" property in
> -u-boot.dtsi. Same is done for AM65x as well [3].
> 
> [1]
> https://elixir.bootlin.com/u-boot/v2024.07-rc3/source/dts/upstream/src/arm64/ti/k3-am64-main.dtsi#L1276
> [2]
> https://elixir.bootlin.com/u-boot/v2024.07-rc3/source/dts/upstream/src/arm64/ti/k3-am64-main.dtsi#L1417
> [3]
> https://elixir.bootlin.com/u-boot/v2024.07-rc3/source/arch/arm/dts/k3-am654-base-board-u-boot.dtsi#L168
> 
>> Andrew
>>
>>> +};
>>> +
>>> +&rtu0_0 {
>>> +    remoteproc-name = "rtu0_0";
>>> +};
>>> +
>>> +&tx_pru0_0 {
>>> +    remoteproc-name = "tx_pru0_0";
>>> +};
>>> +
>>> +&pru0_1 {
>>> +    remoteproc-name = "pru0_1";
>>> +};
>>> +
>>> +&rtu0_1 {
>>> +    remoteproc-name = "rtu0_1";
>>> +};
>>> +
>>> +&tx_pru0_1 {
>>> +    remoteproc-name = "tx_pru0_1";
>>> +};
>>> +
>>> +&pru1_0 {
>>> +    remoteproc-name = "pru1_0";
>>> +};
>>> +
>>> +&rtu1_0 {
>>> +    remoteproc-name = "rtu1_0";
>>> +};
>>> +
>>> +&tx_pru1_0 {
>>> +    remoteproc-name = "tx_pru1_0";
>>> +};
>>> +
>>> +&pru1_1 {
>>> +    remoteproc-name = "pru1_1";
>>> +};
>>> +
>>> +&rtu1_1 {
>>> +    remoteproc-name = "rtu1_1";
>>> +};
>>> +
>>>    &main_timer0 {
>>>        clock-frequency = <200000000>;
>>>    };
> 
