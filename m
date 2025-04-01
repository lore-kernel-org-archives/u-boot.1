Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA0CC36008
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 04:09:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25A448171B;
	Tue,  1 Apr 2025 06:09:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dvoz5gN4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09190817C4; Tue,  1 Apr 2025 06:09:07 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F3D680FDA
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 06:09:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 531491GG3500113
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 31 Mar 2025 23:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1743480541;
 bh=aZoZ1juJXECzez3Gp5UOuAiLCZUEPJhsOCMFGghESS4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=dvoz5gN43YmEQyoLahD++Cg6ofyd7Bc+O5NEhatkC71sPjn13hIPT3Ex/fkLhDIMx
 5sSO2RF2FVIgtnOipw38VPgOXgC69YytBXGIWK/x+TAupdIl1w4G8Vkx8PQ2B4f5VB
 AeGskPSZW6yiRZ08jNQcP2FncqyUpPIclj93d/x0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 531491I5093138;
 Mon, 31 Mar 2025 23:09:01 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Mar 2025 23:09:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Mar 2025 23:09:01 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53148v4D105106;
 Mon, 31 Mar 2025 23:08:58 -0500
Message-ID: <a79d5a2b-1a19-437e-b181-3d6c3bb7b35c@ti.com>
Date: Tue, 1 Apr 2025 09:38:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] DONOTMERGE: arm: dts: k3-j784s4-main: Add PBIST_14
 node
To: Nishanth Menon <nm@ti.com>
CC: <trini@konsulko.com>, <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, 
 <hnagalla@ti.com>, <j-choudhary@ti.com>, <bb@ti.com>,
 <vigneshr@ti.com>, <j-keerthy@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
References: <20250328123127.497971-1-n-francis@ti.com>
 <20250328123127.497971-4-n-francis@ti.com>
 <20250328141847.s333bjjqmzfi5dkj@remarry>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250328141847.s333bjjqmzfi5dkj@remarry>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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

On 28/03/25 19:48, Nishanth Menon wrote:
> On 18:01-20250328, Neha Malcom Francis wrote:
>> Add DT node for PBIST_14 that is responsible for triggering the PBIST
>> self-tests for the MAIN_R5_2_x cores.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>> Linux dt-binding patch
>> https://lore.kernel.org/all/20250328111439.374748-1-n-francis@ti.com/
> 
> Please hold off till the binding is closed out with Krystoff.
> 

Yes will do

>>
>> Changes since v2:
>> - s/ti,bist-instance/ti,bist-under-test
>>
>>  dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi b/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
>> index 0160fe0da98..1a26f5e4ace 100644
>> --- a/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
>> +++ b/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
>> @@ -113,6 +113,17 @@
>>  			status = "disabled";
>>  		};
>>  	};
>> +
>> +	bist_main14: bist@33c0000 {
>> +		compatible = "ti,j784s4-bist";
>> +		reg = <0x00 0x033c0000 0x00 0x400>,
>> +		      <0x00 0x0010c1a0 0x00 0x01c>;
>> +		reg-names = "cfg", "ctrl_mmr";
>> +		clocks = <&k3_clks 237 7>;
>> +		power-domains = <&k3_pds 237 TI_SCI_PD_EXCLUSIVE>;
>> +		bootph-pre-ram;
>> +		ti,bist-under-test = <343>, <344>, <365>, <366>;
>> +	};
>>  };
>>  
>>  &scm_conf {
>> -- 
>> 2.34.1
>>
> 

-- 
Thanking You
Neha Malcom Francis
