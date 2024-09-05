Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA68FCD4F5F
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 09:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49A9088C61;
	Thu,  5 Sep 2024 11:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="afxFG5BT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50F7288C6D; Thu,  5 Sep 2024 11:19:27 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 380E688C05
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 11:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4859JNnN090580;
 Thu, 5 Sep 2024 04:19:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1725527963;
 bh=38jxfDtpY2XHod9oLGSiBVl678hlQB0XtQb0Nv9YkfM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=afxFG5BTq5W5l6EehNb+Vj2doSjRQg2finlz+I+L1ZOZTHQRELJkI/i0nnEPwBUyD
 4x2ssKyWPzdTg/MyssikSQv7bHAB7O5KqZYuJ3vls2VsksajYta0+puS/X1lXwOkxF
 wyJo3aeq/85S4ma2DbRNSMyJIiRQz9TPaYm0nIRg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4859JNHu054583
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 5 Sep 2024 04:19:23 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Sep 2024 04:19:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Sep 2024 04:19:22 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4859JJPi062762;
 Thu, 5 Sep 2024 04:19:19 -0500
Message-ID: <7b4c0603-0904-486e-9bbc-feac72328479@ti.com>
Date: Thu, 5 Sep 2024 14:49:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/6] arm: dts: k3-j784s4-main: Add clock and power
 domains for MAIN_R5_2_x
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-boot@lists.denx.de>
References: <20240903114402.2155740-1-n-francis@ti.com>
 <20240903114402.2155740-4-n-francis@ti.com>
 <d3046316-e857-4c2b-ac90-6c4a076c90f1@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <d3046316-e857-4c2b-ac90-6c4a076c90f1@ti.com>
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

On 04/09/24 09:55, Kumar, Udit wrote:
> 
> On 9/3/2024 5:13 PM, Neha Malcom Francis wrote:
>> Add bootph-pre-ram as well as the clocks and power-domains for
>> MAIN_R5_2_x. This ensures that LPSC sets the appropriate power and clock
>> and allows for BIST to turn the cores on and off for running the
>> self-test at R5 SPL stage.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi 
>> b/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
>> index 5d9b0b6b59d..42dbf3083e1 100644
>> --- a/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
>> +++ b/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
>> @@ -1897,6 +1897,7 @@
>>           ranges = <0x5900000 0x00 0x5900000 0x20000>,
>>                <0x5a00000 0x00 0x5a00000 0x20000>;
>>           power-domains = <&k3_pds 338 TI_SCI_PD_EXCLUSIVE>;
>> +        bootph-pre-ram;
>>           main_r5fss2_core0: r5f@5900000 {
>>               compatible = "ti,j721s2-r5f";
>> @@ -1911,6 +1912,10 @@
>>               ti,atcm-enable = <1>;
>>               ti,btcm-enable = <1>;
>>               ti,loczrama = <1>;
>> +            clocks = <&k3_clks 343 0>;
>> +            power-domains = <&k3_pds 343 TI_SCI_PD_EXCLUSIVE>;
>> +            assigned-clocks = <&k3_clks 343 0>;
>> +            bootph-pre-ram;
>>           };
>>           main_r5fss2_core1: r5f@5a00000 {
>> @@ -1926,6 +1931,10 @@
>>               ti,atcm-enable = <1>;
>>               ti,btcm-enable = <1>;
>>               ti,loczrama = <1>;
>> +            clocks = <&k3_clks 344 0>;
>> +            power-domains = <&k3_pds 344 TI_SCI_PD_EXCLUSIVE>;
>> +            assigned-clocks = <&k3_clks 344 0>;
>> +            bootph-pre-ram;
> 
> 
> Only leaf nodes should be ok with bootph-pre-ram

Will change this, thanks!

> 
>>           };
>>       };

-- 
Thanking You
Neha Malcom Francis
