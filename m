Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1BDC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 05:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C4DA88261;
	Tue, 21 May 2024 07:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ci6JyU32";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7507E886EF; Tue, 21 May 2024 07:36:34 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0786088233
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 07:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44L5aJ6x049414;
 Tue, 21 May 2024 00:36:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716269779;
 bh=1X+7glWRIHD/Q0jk1Y1YSVtCi7R3YxOCpEAmzaP3mZc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Ci6JyU32f4YeqL0uyb9m1o8efPz64Nn0YoHulJEdFvhnE1fBTFUmP/U1VZIVGSWQR
 2fKXpgc093vaJdLVpYBM/RQGL/lTa9dl5Z3/2Fk8HuTeVkyxW8ccaqV8LoBa/2MKlF
 k1ochF7Wv0tc4zMSArR+1+l8wCKe9d1X3qfS0PQ8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44L5aJhV011767
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 21 May 2024 00:36:19 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 21
 May 2024 00:36:19 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 21 May 2024 00:36:18 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44L5aB4X037745;
 Tue, 21 May 2024 00:36:12 -0500
Message-ID: <a9c7dae8-eb83-4d43-b81c-91b67dc2cef7@ti.com>
Date: Tue, 21 May 2024 11:06:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] arch: arm: dts: k3-am62-sk-u-boot: Add missing
 "bootph-all" property to phy_gmii_sel node
To: Roger Quadros <rogerq@kernel.org>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 MD Danish Anwar <danishanwar@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng@tinylab.org>,
 Sean Anderson <seanga2@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, Joao Paulo
 Goncalves <joao.goncalves@toradex.com>, Mattijs Korpershoek
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
 <e3785fad-fb0d-4cf8-8787-0a91e6b52332@ti.com>
 <e9911fd1-6a69-448d-9347-7d188ec46c74@ti.com>
 <864a0203-409a-4db9-8248-14d04a6e71fc@kernel.org>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <864a0203-409a-4db9-8248-14d04a6e71fc@kernel.org>
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



On 20/05/24 17:43, Roger Quadros wrote:
> 
> 
> On 20/05/2024 09:04, Chintan Vankar wrote:
>>
>>
>> On 25/04/24 18:06, Chintan Vankar wrote:
>>>
>>>
>>> On 25/04/24 18:01, Roger Quadros wrote:
>>>>
>>>>
>>>> On 25/04/2024 15:08, Chintan Vankar wrote:
>>>>> Add "bootph-all" property to CPSW MAC's PHY node phy_gmii_sel.
>>>>>
>>>>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>>>>> ---
>>>>>
>>>>> Changes from v1 to v2:
>>>>> - This patch is newly added in this series to enable CPSW MAC's PHY
>>>>>     node "phy_gmii_sel". As per discussion at here:
>>>>>     https://lore.kernel.org/r/20240112130127.rvvrhz7p4vmlyalh@smother/
>>>>>     changes made by this patch can be dropped in the future when the
>>>>>     DT-Sync is performed with am62-main.dtsi containing this change in
>>>>>     the Linux DT which will match U-Boot's DT.
>>>>
>>>> I don't think bootph-all exists in am62-main.dtsi. It should come from
>>>> board.dts
>>>>
>>>
>>> Yes, I am having the same discussion at here:
>>> https://lore.kernel.org/all/c13ac165-7cbd-4e53-914e-8c6bc28250e3@ti.com/
>>>
>>
>> Since I have posted patch which adds bootph-all property to
>> "k3-am62x-sk-common.dtsi" at here:
>> https://lore.kernel.org/r/20240430085048.3143665-1-c-vankar@ti.com/
>> and it has no open comments and this series
>> also does not have any open comments, so can it be merged ?
> 
> Since bootph-all is being added to k3-am62x-sk-common.dtsi don't you have to drop patch 10
> from this series?
> 

Yes you are correct, but that patch is not merged yet.

>>
>>>>>
>>>>>    arch/arm/dts/k3-am625-sk-u-boot.dtsi | 4 ++++
>>>>>    1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
>>>>> index fa778b0ff4..e9a1afde95 100644
>>>>> --- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
>>>>> +++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
>>>>> @@ -46,3 +46,7 @@
>>>>>    &cpsw_port2 {
>>>>>        status = "disabled";
>>>>>    };
>>>>> +
>>>>> +&phy_gmii_sel {
>>>>> +    bootph-all;
>>>>> +};
>>>>
> 
