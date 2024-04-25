Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E136C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 12:36:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC92588ED9;
	Thu, 25 Apr 2024 14:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mwuMwt66";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9880D88ED9; Thu, 25 Apr 2024 14:36:49 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6904488F20
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 14:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PCaUhi045718;
 Thu, 25 Apr 2024 07:36:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714048591;
 bh=na/By50spNC+DDh7jV5/koy1tse4pGSzkNIQCLL6+NE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=mwuMwt665bULny+mStw0oitfWb+AeSvm1pvMGBzUwI73BEuSrsAiP3RVErbpDrslm
 EUQfKmeoOIB9bdxbI64c2U745ztIctkx4XgVJX55IK8LGfpTunmBdhU/8RsEauDtsV
 trf12+pSi+ozQj4CmdffG1YI3GkFvN/kKDzFZmm0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PCaUbS013809
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 25 Apr 2024 07:36:30 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 07:36:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 07:36:30 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PCaN3S092539;
 Thu, 25 Apr 2024 07:36:23 -0500
Message-ID: <e3785fad-fb0d-4cf8-8787-0a91e6b52332@ti.com>
Date: Thu, 25 Apr 2024 18:06:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] arch: arm: dts: k3-am62-sk-u-boot: Add missing
 "bootph-all" property to phy_gmii_sel node
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 MD Danish Anwar <danishanwar@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng@tinylab.org>,
 Sean Anderson <seanga2@gmail.com>, "Kishon
 Vijay Abraham I" <kishon@ti.com>, Nikhil M Jain <n-jain1@ti.com>, Wadim
 Egorov <w.egorov@phytec.de>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Dhruva Gole <d-gole@ti.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Andrew Davis <afd@ti.com>, Maxime Ripard
 <mripard@kernel.org>, Neha Malcom Francis <n-francis@ti.com>, Simon Glass
 <sjg@chromium.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
References: <20240425120822.2048012-1-c-vankar@ti.com>
 <20240425120822.2048012-11-c-vankar@ti.com>
 <5ac873d5-e485-47d3-b5de-f537c1fb88b1@kernel.org>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <5ac873d5-e485-47d3-b5de-f537c1fb88b1@kernel.org>
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



On 25/04/24 18:01, Roger Quadros wrote:
> 
> 
> On 25/04/2024 15:08, Chintan Vankar wrote:
>> Add "bootph-all" property to CPSW MAC's PHY node phy_gmii_sel.
>>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>
>> Changes from v1 to v2:
>> - This patch is newly added in this series to enable CPSW MAC's PHY
>>    node "phy_gmii_sel". As per discussion at here:
>>    https://lore.kernel.org/r/20240112130127.rvvrhz7p4vmlyalh@smother/
>>    changes made by this patch can be dropped in the future when the
>>    DT-Sync is performed with am62-main.dtsi containing this change in
>>    the Linux DT which will match U-Boot's DT.
> 
> I don't think bootph-all exists in am62-main.dtsi. It should come from
> board.dts
> 

Yes, I am having the same discussion at here:
https://lore.kernel.org/all/c13ac165-7cbd-4e53-914e-8c6bc28250e3@ti.com/

>>
>>   arch/arm/dts/k3-am625-sk-u-boot.dtsi | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
>> index fa778b0ff4..e9a1afde95 100644
>> --- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
>> +++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
>> @@ -46,3 +46,7 @@
>>   &cpsw_port2 {
>>   	status = "disabled";
>>   };
>> +
>> +&phy_gmii_sel {
>> +	bootph-all;
>> +};
> 
