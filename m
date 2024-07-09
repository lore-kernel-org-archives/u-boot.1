Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B072C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 06:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6F09884D2;
	Tue,  9 Jul 2024 08:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Bsh5GZt9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93C33884D0; Tue,  9 Jul 2024 08:59:46 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D47C187B77
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 08:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4696xO3L035275;
 Tue, 9 Jul 2024 01:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720508364;
 bh=VQvGunPuVX0aW1E6xDT0xp54Mh902Vw5sRBe857vhe0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Bsh5GZt9IZ5w5M8Vn7HFlcF39VgjCsLVxAOKegmyFh3bk7ANNR904IbHLAH/hSm2j
 To8j0Tarx1uohV/WczD364OAie1m2irTIjU6id2PxHQlzvOfpoEazdJvE5HJgQZzsO
 rfTojl9N8yiIC2LEl/qDkWLBsMcUmiQ9RM3UWSf0=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4696xOAT128605
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Jul 2024 01:59:24 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jul 2024 01:59:24 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jul 2024 01:59:24 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4696xGeo004310;
 Tue, 9 Jul 2024 01:59:16 -0500
Message-ID: <e6b94491-f186-42f8-ba54-11651811db31@ti.com>
Date: Tue, 9 Jul 2024 12:29:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] configs: am62: Add configs for enabling ETHBOOT
 in R5SPL
To: Tom Rini <trini@konsulko.com>
CC: Michal Simek <michal.simek@amd.com>, Bryan Brattlof <bb@ti.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>, MD Danish Anwar
 <danishanwar@ti.com>, Udit Kumar <u-kumar1@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>, "Sean
 Anderson" <seanga2@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 "Nikhil M Jain" <n-jain1@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Wadim Egorov <w.egorov@phytec.de>, Sjoerd
 Simons <sjoerd@collabora.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Dhruva Gole <d-gole@ti.com>, "Simon
 Glass" <sjg@chromium.org>, Roger Quadros <rogerq@kernel.org>, Maxime Ripard
 <mripard@kernel.org>, Nishanth Menon <nm@ti.com>,
 <srk@ti.com>, <u-boot@lists.denx.de>
References: <20240705045030.1141934-1-c-vankar@ti.com>
 <20240705045030.1141934-8-c-vankar@ti.com>
 <20240705153721.GF38804@bill-the-cat>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <20240705153721.GF38804@bill-the-cat>
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



On 05/07/24 21:07, Tom Rini wrote:
> On Fri, Jul 05, 2024 at 10:20:27AM +0530, Chintan Vankar wrote:
> 
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> Add configs for enabling ETHBOOT in R5SPL.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>
>> Link to v2:
>> https://lore.kernel.org/r/20240425120822.2048012-8-c-vankar@ti.com/
>>
>> Changes from v2 to v3:
>> - No changes.
>>
>>   configs/am62x_evm_r5_ethboot_defconfig | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>   create mode 100644 configs/am62x_evm_r5_ethboot_defconfig
>>
>> diff --git a/configs/am62x_evm_r5_ethboot_defconfig b/configs/am62x_evm_r5_ethboot_defconfig
>> new file mode 100644
>> index 0000000000..7b1932b215
>> --- /dev/null
>> +++ b/configs/am62x_evm_r5_ethboot_defconfig
>> @@ -0,0 +1,20 @@
>> +#include<configs/am62x_evm_r5_defconfig>
>> +
>> +CONFIG_SPL_GPIO=y
> 
> You need a few other options set in order for buildman to work in this
> case, please look at the other #include users.
> 

Are you referring to include "configs/k3_efi_capsule.config" ?
