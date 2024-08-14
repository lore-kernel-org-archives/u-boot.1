Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BD8C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 14:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 784EF88967;
	Wed, 14 Aug 2024 16:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ji8zIMxK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C2C18899D; Wed, 14 Aug 2024 16:32:07 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47AB587C69
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 16:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47EEVr2Z020129;
 Wed, 14 Aug 2024 09:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723645914;
 bh=YswKVuMHqKohJwxuADfMV9kZSc79jlWP5y1URCCD0Ak=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Ji8zIMxKdHX4pIE5cC0/2vjwSXR5r3xXoaXidtaDRRsuehvLfdixILg9NyQEsS6Ke
 HrdjzraduJR4kzeeGSFWOnKiXNtBjRY1nyvpfYqCOBw+KrpW4MddnxOCvWL98Osrpj
 Qsu7MkFr2ubl6iu+sJuKblqmp0eSaMmVrQsPZzRg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47EEVrgX089922
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 14 Aug 2024 09:31:53 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 09:31:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 09:31:53 -0500
Received: from [128.247.81.8] (ula0226330.dhcp.ti.com [128.247.81.8] (may be
 forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47EEVrdu030325;
 Wed, 14 Aug 2024 09:31:53 -0500
Message-ID: <494a323a-0777-4935-9a83-578c73b310cc@ti.com>
Date: Wed, 14 Aug 2024 09:31:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/10] arm: mach-k3: am62x: am625_init: Probe AM65 CPSW
 NUSS
To: Chintan Vankar <c-vankar@ti.com>, Michal Simek <michal.simek@amd.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, Neha Malcom Francis
 <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>, MD Danish Anwar
 <danishanwar@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>, "Matthias
 Schiffer" <matthias.schiffer@ew.tq-group.com>, Andreas Dannenberg
 <dannenberg@ti.com>, Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar
 <devarsht@ti.com>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Kishon Vijay Abraham I <kishon@ti.com>, "Joao Paulo
 Goncalves" <joao.goncalves@toradex.com>, Wadim Egorov <w.egorov@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Dhruva Gole <d-gole@ti.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Nishanth Menon <nm@ti.com>, Sumit Garg
 <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
References: <20240812113621.3840652-1-c-vankar@ti.com>
 <20240812114856.3843785-1-c-vankar@ti.com>
 <2d9d9eae-1bdb-44e8-976b-72ec5bc67aab@ti.com>
 <30d6c971-3002-48ed-aeab-f01021d4a404@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <30d6c971-3002-48ed-aeab-f01021d4a404@ti.com>
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

On 8/14/24 12:17 AM, Chintan Vankar wrote:
> 
> 
> On 13/08/24 23:57, Andrew Davis wrote:
>> On 8/12/24 6:48 AM, Chintan Vankar wrote:
>>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>>
>>> In order to support Ethernet boot on AM62x, probe AM65 CPSW NUSS
>>> driver in board_init_f().
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>>> ---
>>>
>>> Link to v4:
>>> https://lore.kernel.org/r/20240705045030.1141934-7-c-vankar@ti.com/
>>>
>>> Changes from v3 to v4:
>>> - No changes.
>>>
>>>   arch/arm/mach-k3/am62x/am625_init.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
>>> index 72a752d38e..0182c153a6 100644
>>> --- a/arch/arm/mach-k3/am62x/am625_init.c
>>> +++ b/arch/arm/mach-k3/am62x/am625_init.c
>>> @@ -280,6 +280,16 @@ void board_init_f(ulong dummy)
>>>           if (ret)
>>>               panic("DRAM init failed: %d\n", ret);
>>>       }
>>> +
>>> +    if (IS_ENABLED(CONFIG_SPL_ETH) && IS_ENABLED(CONFIG_TI_AM65_CPSW_NUSS) &&
>>> +        spl_boot_device() == BOOT_DEVICE_ETHERNET) {
>>> +        struct udevice *cpswdev;
>>> +
>>> +        if (uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(am65_cpsw_nuss),
>>> +                        &cpswdev))
>>> +            printf("Failed to probe am65_cpsw_nuss driver\n");
>>> +    }
>>> +
>>>       spl_enable_cache();
>>
>> Any reason you added this before enabling caches?
>>
>> Andrew
>>
> 
> There is no specific reason for it, I can probe CPSW driver after
> enabling cache also.
> 

Let's do that then. We enable caches right after enabling DRAM to keep
the amount of non-cached DDR accesses low.

Andrew

>>>       fixup_a53_cpu_freq_by_speed_grade();
