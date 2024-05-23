Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEEBC25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 06:33:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9CCE88311;
	Thu, 23 May 2024 08:33:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QCqciCVK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18D6988519; Thu, 23 May 2024 08:33:38 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B740881A9
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 08:33:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44N6XTtd024759;
 Thu, 23 May 2024 01:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716446009;
 bh=wc2ZHSLX1WBoB8B9NBwy/0IupjldUDHQsMURQWRVgWw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=QCqciCVKhw8uGlv8VWh4dsY2tmqzGW+aT3Cz1K/wU0agJI8YZje+JYv9oaoLzYavJ
 8TkM+z3FhuGWQ5Perjtb+2L0qGPdFlmmVRrlPtU/m34s4oZY2DsyRlB1rhRGHVpvAV
 zvSEpe3YBbIiDdGUMF4YkYDkQKQRv66i1XcIHvqI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44N6XT4M130022
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 23 May 2024 01:33:29 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 May 2024 01:33:29 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 May 2024 01:33:29 -0500
Received: from [10.249.135.225] ([10.249.135.225])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44N6XOML032311;
 Thu, 23 May 2024 01:33:25 -0500
Message-ID: <5cda289f-1d14-41f6-84e3-ff1d1034be13@ti.com>
Date: Thu, 23 May 2024 12:03:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm: dts: k3-am642-evm-u-boot: Add remoteproc-name
 for PRU cores
To: Andrew Davis <afd@ti.com>, MD Danish Anwar <danishanwar@ti.com>, Judith
 Mendez <jm@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nikhil M Jain
 <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Jonathan Humphreys
 <j-humphreys@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, Simon Glass
 <sjg@chromium.org>, Neha Malcom Francis <n-francis@ti.com>, Nishanth Menon
 <nm@ti.com>, Roger Quadros <rogerq@kernel.org>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>
References: <20240522063652.3759497-1-danishanwar@ti.com>
 <20240522063652.3759497-2-danishanwar@ti.com>
 <cb53651f-a823-41b8-81e5-c3939bd33764@ti.com>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <cb53651f-a823-41b8-81e5-c3939bd33764@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Andrew,

On 5/22/2024 9:38 PM, Andrew Davis wrote:
> On 5/22/24 1:36 AM, MD Danish Anwar wrote:
>> Add remoteproc-name property for PRU cores.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>   arch/arm/dts/k3-am642-evm-u-boot.dtsi | 44 +++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>> b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>> index 705b3baa81..25ddace74e 100644
>> --- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>> +++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>> @@ -11,6 +11,50 @@
>>       };
>>   };
>>   +&pru0_0 {
>> +    remoteproc-name = "pru0_0";
> 
> Why do we need all these? Looks like we fallback to using `dev->name` if
> these are not set, does that not work for us here?
> 

Yes we will fallback to `dev->name` if `remoteproc-name` is not set but
in our case two different PRU cores will have same `dev->name`. As a
result the API rproc_name_is_unique() will return false and as a result
the probe will fail for the PRU cores.

Example: In k3-am64-main.dtsi, both pru0_0 [1] and pru1_0 [2] will have
dev->name as "pru@34000" same goes for rtu and txpru as well.

		pru0_0: pru@34000 {
			compatible = "ti,am642-pru";
			reg = <0x34000 0x3000>,
			      <0x22000 0x100>,
			      <0x22400 0x100>;
			reg-names = "iram", "control", "debug";
			firmware-name = "am64x-pru0_0-fw";
		};

		pru1_0: pru@34000 {
			compatible = "ti,am642-pru";
			reg = <0x34000 0x4000>,
			      <0x22000 0x100>,
			      <0x22400 0x100>;
			reg-names = "iram", "control", "debug";
			firmware-name = "am64x-pru1_0-fw";
		};

To avoid this, we are setting the "remoteproc-name" property in
-u-boot.dtsi. Same is done for AM65x as well [3].

[1]
https://elixir.bootlin.com/u-boot/v2024.07-rc3/source/dts/upstream/src/arm64/ti/k3-am64-main.dtsi#L1276
[2]
https://elixir.bootlin.com/u-boot/v2024.07-rc3/source/dts/upstream/src/arm64/ti/k3-am64-main.dtsi#L1417
[3]
https://elixir.bootlin.com/u-boot/v2024.07-rc3/source/arch/arm/dts/k3-am654-base-board-u-boot.dtsi#L168

> Andrew
> 
>> +};
>> +
>> +&rtu0_0 {
>> +    remoteproc-name = "rtu0_0";
>> +};
>> +
>> +&tx_pru0_0 {
>> +    remoteproc-name = "tx_pru0_0";
>> +};
>> +
>> +&pru0_1 {
>> +    remoteproc-name = "pru0_1";
>> +};
>> +
>> +&rtu0_1 {
>> +    remoteproc-name = "rtu0_1";
>> +};
>> +
>> +&tx_pru0_1 {
>> +    remoteproc-name = "tx_pru0_1";
>> +};
>> +
>> +&pru1_0 {
>> +    remoteproc-name = "pru1_0";
>> +};
>> +
>> +&rtu1_0 {
>> +    remoteproc-name = "rtu1_0";
>> +};
>> +
>> +&tx_pru1_0 {
>> +    remoteproc-name = "tx_pru1_0";
>> +};
>> +
>> +&pru1_1 {
>> +    remoteproc-name = "pru1_1";
>> +};
>> +
>> +&rtu1_1 {
>> +    remoteproc-name = "rtu1_1";
>> +};
>> +
>>   &main_timer0 {
>>       clock-frequency = <200000000>;
>>   };

-- 
Thanks and Regards,
Md Danish Anwar
