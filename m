Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1DBC4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 12:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFEB088F15;
	Thu, 25 Apr 2024 14:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GH9JX6DY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 321D488F15; Thu, 25 Apr 2024 14:59:57 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D71ED887B4
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 14:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PCxgOj038302;
 Thu, 25 Apr 2024 07:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714049982;
 bh=f7wMjEzxT7oe0gdfJQLyJ0rXk9HsoQYUj9c8LfnDaEs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=GH9JX6DYiIguXr50eU5H6IC7XqVDkOWQpKWxiTIevHwcFsmBsJSVTI9Nm93xwA8Te
 2FO85b0e6dAolvmDJpWUEInsl3cEoLBQpfIJHczsk3aCpFT8BsHawOaaVSlmnj4Bit
 /1Q+4bSblebd/DEiidbmuvyvdCeUzMwQwwUQD6jk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PCxgOi069533
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 25 Apr 2024 07:59:42 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 07:59:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 07:59:41 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PCxYRq017760;
 Thu, 25 Apr 2024 07:59:35 -0500
Message-ID: <29092012-e708-4676-99e3-cd8ef64cd701@ti.com>
Date: Thu, 25 Apr 2024 18:29:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] arm: mach-k3: am625_init: Probe AM65 CPSW NUSS
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
 <20240425120822.2048012-7-c-vankar@ti.com>
 <84312b9f-7b30-4da1-91a0-067e94cb420a@kernel.org>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <84312b9f-7b30-4da1-91a0-067e94cb420a@kernel.org>
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



On 25/04/24 17:57, Roger Quadros wrote:
> 
> 
> On 25/04/2024 15:08, Chintan Vankar wrote:
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> In order to support Ethernet boot on AM62x, probe AM65 CPSW NUSS
>> driver in board_init_f().
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>
>> Link to v1:
>> https://lore.kernel.org/r/20240112064759.1801600-8-s-vadapalli@ti.com/
>>
>> Changes from v1 to v2:
>> - No changes.
>>
>>   arch/arm/mach-k3/am625_init.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
>> index 668f9a51ef..9bf61b1e83 100644
>> --- a/arch/arm/mach-k3/am625_init.c
>> +++ b/arch/arm/mach-k3/am625_init.c
>> @@ -277,6 +277,16 @@ void board_init_f(ulong dummy)
>>   		if (ret)
>>   			panic("DRAM init failed: %d\n", ret);
>>   	}
>> +
>> +	if (IS_ENABLED(CONFIG_SPL_ETH) && IS_ENABLED(CONFIG_TI_AM65_CPSW_NUSS) &&
>> +	    spl_boot_device() == BOOT_DEVICE_ETHERNET) {
>> +		struct udevice *cpswdev;
>> +
>> +		if (uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(am65_cpsw_nuss),
>> +						&cpswdev))
>> +			printf("Failed to probe am65_cpsw_nuss driver\n");
>> +	}
>> +
> 
> This looks like a HACK.
> The network driver should be probed only when the networking feature is actually required.
> 

Driver is probed only when the condition above
"spl_boot_device() == BOOT_DEVICE_ETHERNET" is true, which says Boot
device is Ethernet, and here we are booting with Ethernet so driver is
getting probed.

>>   	spl_enable_cache();
>>   
>>   	fixup_a53_cpu_freq_by_speed_grade();
> 
