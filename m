Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0B3CD4F5F
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 09:19:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0403B88C20;
	Thu,  5 Sep 2024 11:19:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fFYce73w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFE8388C24; Thu,  5 Sep 2024 11:19:01 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5EAF88C05
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 11:18:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4859IwGl090534;
 Thu, 5 Sep 2024 04:18:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1725527938;
 bh=ek6n7CX8hLV62clS5pLWxqRhduVvJtfCQqf+tsxqu6Q=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=fFYce73waZLn5UT1OCJblpztzuflamaG0mHySqzPXuiLaQfMsdLokv8/vyzKfgCSQ
 ub2rRuK3qA9qavf2zHNlOv+IXvCvaeMlXk/Ppi56f4KLRuXCP7kuf11cNfqoY3IUih
 VNWJnuiiR+zSfsJATo0+ueUZHfX6xql3/OGlYAeY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4859IwLP056150;
 Thu, 5 Sep 2024 04:18:58 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Sep 2024 04:18:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Sep 2024 04:18:57 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4859Irw4062339;
 Thu, 5 Sep 2024 04:18:54 -0500
Message-ID: <eb6b62e3-a087-4e9a-a0e0-6552635a7ded@ti.com>
Date: Thu, 5 Sep 2024 14:48:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/6] arm: dts: k3-j784s4-main: Add PBIST_14 node
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-boot@lists.denx.de>
References: <20240903114402.2155740-1-n-francis@ti.com>
 <20240903114402.2155740-3-n-francis@ti.com>
 <c5b230ea-a2f1-4502-a315-789a63b23d86@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <c5b230ea-a2f1-4502-a315-789a63b23d86@ti.com>
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

Hi Udit

On 04/09/24 09:52, Kumar, Udit wrote:
> 
> On 9/3/2024 5:13 PM, Neha Malcom Francis wrote:
>> Add DT node for PBIST_14 that is responsible for triggering the BIST
>> self-tests for the MAIN_R5_2_x cores.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi 
>> b/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
>> index 6a4554c6c9c..5d9b0b6b59d 100644
>> --- a/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
>> +++ b/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
>> @@ -2255,4 +2255,14 @@
>>                */
>>           };
>>       };
>> +
>> +    bist_mcu14: bist@33c0000 {
> 
> Name shouldn't be mcu, if this is included in main .
> 
> Also consider to put this is kernel as well.

Thanks for catching this! Will change it, and yes once the properties needed 
(based on this RFC review) is decided DTS patch will be sent to kernel first.

> 
> 
>> +        compatible = "ti,j784s4-bist";
>> +        reg = <0x00 0x033c0000 0x00 0x400>;
>> +        clocks = <&k3_clks 237 7>;
>> +        power-domains = <&k3_pds 237 TI_SCI_PD_EXCLUSIVE>;
>> +        bootph-pre-ram;
>> +        ti,bist-instance = <14>;
>> +        cores-under-test = <&main_r5fss2_core0>, <&main_r5fss2_core1>;
>> +    };
>>   };

-- 
Thanking You
Neha Malcom Francis
