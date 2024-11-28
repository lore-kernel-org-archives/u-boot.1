Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B245DD3B9BD
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 04:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E34AD893A3;
	Thu, 28 Nov 2024 05:51:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="A0zSnUUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A7AA893D0; Thu, 28 Nov 2024 05:51:43 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30FAE8926A
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 05:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AS4pdcn1106606
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Nov 2024 22:51:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732769499;
 bh=FWOwUn9ukwms0VNMf5oXX1nFstLk+8Nn/w8+HOt3JTg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=A0zSnUUSjVmLh3wxBG3gpSdE77Y+E5PN0A3YoQEcNE0KPz0LHSGO0XB8fQXdi3llp
 ZSEU3LZtpgo60lZK2HciZ9X+IlMpd5HEJbb/t3f981FX/3sABESzXQEA9fCyLepopn
 l39MMYRIQXm1LXr5GvOaIxAf6+iCWMS4D62z7Urk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AS4pdN2091365
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Nov 2024 22:51:39 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Nov 2024 22:51:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Nov 2024 22:51:38 -0600
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AS4pYOQ106958;
 Wed, 27 Nov 2024 22:51:35 -0600
Message-ID: <0db79f51-c510-4a57-bc3e-500898d6a7d4@ti.com>
Date: Thu, 28 Nov 2024 10:21:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm: dts: k3-j784s4-main: Add PBIST_14 node
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-boot@lists.denx.de>
References: <20241127145346.2609868-1-n-francis@ti.com>
 <20241127145346.2609868-2-n-francis@ti.com>
 <4515c566-2c7c-441b-8e31-279b64427a73@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <4515c566-2c7c-441b-8e31-279b64427a73@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Udit

On 28/11/24 09:28, Kumar, Udit wrote:
> 
> On 11/27/2024 8:23 PM, Neha Malcom Francis wrote:
>> Add DT node for PBIST_14 that is responsible for triggering the PBIST
>> self-tests for the MAIN_R5_2_x cores.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi 
>> b/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
>> index d4ac1c9872a..21e2777cd9d 100644
>> --- a/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
>> +++ b/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
>> @@ -2782,4 +2782,16 @@
>>           power-domains = <&k3_pds 269 TI_SCI_PD_EXCLUSIVE>;
>>           status = "disabled";
>>       };
>> +
>> +    bist_main14: bist@33c0000 {
>> +        compatible = "ti,j784s4-bist";
>> +        reg-names = "cfg", "ctrl_mmr";
>> +        reg = <0x00 0x033c0000 0x00 0x400>,
>> +              <0x00 0x0010c1a0 0x00 0x01c>;
>> +        clocks = <&k3_clks 237 7>;
> 
> Please go through kernel route for device tree update.
> 
> Even this is getting applied, in next kernel-u-boot sync, we will be losing this 
> node

Yes will be sending it out today, just sent this series a little ahead for reviews.

> 
> 
>> +        power-domains = <&k3_pds 237 TI_SCI_PD_EXCLUSIVE>;
>> +        bootph-pre-ram;
>> +        ti,bist-instance = <14>;
>> +        cores-under-test = <&main_r5fss2_core0>, <&main_r5fss2_core1>;
>> +    };
>>   };

-- 
Thanking You
Neha Malcom Francis
