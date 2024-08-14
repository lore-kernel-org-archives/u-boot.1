Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109E5C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 01:52:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52A6A883A4;
	Wed, 14 Aug 2024 03:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SsEckb29";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 114EA88671; Wed, 14 Aug 2024 03:52:13 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 250B0880A5
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 03:52:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47E1pskW019607;
 Tue, 13 Aug 2024 20:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723600314;
 bh=XSVs/awAo7eVDq0D8PjhM2uIlkMBGha030UeVEzdzV8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=SsEckb29KySwHgo9L+G43xy0Vv0Sx2wT8yLDyqMNzjvO5zrFzCMc+sw/CAKeP7/1j
 GNfvuz1vCy1bagtn0Zm4FKBkdn8/oK6gmy5qpVUouxrAWl6eKaUviR0Yya/gDgCthL
 VjxxHcsiduTAA2DE5YbxHrI35VK6jAHjTiP0kx4g=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47E1prKI129859
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 13 Aug 2024 20:51:54 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 20:51:53 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 20:51:53 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47E1pkRu027404;
 Tue, 13 Aug 2024 20:51:47 -0500
Message-ID: <8623c13f-deb8-4bc0-b202-e214185cbaa6@ti.com>
Date: Wed, 14 Aug 2024 07:21:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] arm64: dts: ti: k3-am62x-sk-common: Add
 bootph-all property in phy_gmii_sel node
To: Nishanth Menon <nm@ti.com>
CC: Michal Simek <michal.simek@amd.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, "Neha
 Malcom Francis" <n-francis@ti.com>, MD Danish Anwar <danishanwar@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Ravi Gunasekaran
 <r-gunasekaran@ti.com>, Udit Kumar <u-kumar1@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>,
 Jonas Karlman <jonas@kwiboo.se>, "Devarsh Thakkar" <devarsht@ti.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Wadim Egorov <w.egorov@phytec.de>, Dhruva Gole
 <d-gole@ti.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, "Sumit
 Garg" <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240813105400.4054657-1-c-vankar@ti.com>
 <20240813105400.4054657-11-c-vankar@ti.com>
 <20240813124718.4zpvz3ryhdexxqdr@sharpness>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <20240813124718.4zpvz3ryhdexxqdr@sharpness>
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



On 13/08/24 18:17, Nishanth Menon wrote:
> On 16:24-20240813, Chintan Vankar wrote:
>> Add missing bootph-all property for CPSW MAC's PHY node
>> phy_gmii_sel.
>>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> Link: https://lore.kernel.org/r/20240430085048.3143665-1-c-vankar@ti.com
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>>
>> [ upstream commit: ba50141137fae205a731005e70687f4a52289050 ]
>>
>> (cherry picked from commit 2bdd1743a9f6515efe7c3648a25d63b4a9ce4a10)
>> ---
>>
>> Link to v4:
>> https://lore.kernel.org/r/20240812114945.3844224-1-c-vankar@ti.com/
>>
>> Changes from v4 to v5:
>> - Updated this patch with the cherry picked patch from
>>    devicetree-rebasing repo as pointed out by Sumit.
>>
>>   dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
>> index 3c45782ab2b..96378b19c41 100644
>> --- a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
>> +++ b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
>> @@ -128,6 +128,10 @@
>>   	};
>>   };
>>   
>> +&phy_gmii_sel {
>> +	bootph-all;
>> +};
>> +
> 
> 
> If you cannot wait for upstream dt sync, why not just do this in R5-sk
> or u-boot.dtsi?
> 
> 

This node was added in "k3-am625-sk-u-boot.dtsi" till v3 of this series,
https://lore.kernel.org/all/20240705045030.1141934-11-c-vankar@ti.com/
but Tom suggested to use cherry pick since equivalent node got merged in
Linux:
https://lore.kernel.org/r/171826022268.240984.16645643062603851712.b4-ty@ti.com/
