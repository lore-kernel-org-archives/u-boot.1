Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13488C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 12:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7FF0879BE;
	Mon, 22 Jan 2024 13:34:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Gjk3TqXo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 973ED877CC; Mon, 22 Jan 2024 11:19:26 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D66DD876B1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 11:19:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40MAJLUL104564;
 Mon, 22 Jan 2024 04:19:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705918761;
 bh=3TyDP6e2cEjyiU2zAx0EyYwhvalbLmie1LzMSojWKGQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Gjk3TqXoijPsd6xuNdEmtXxI42Qkw4yn+pwz2uZX7LYsA6238SGLAQshjGxa3p0/O
 tvQwkMb+ZVk67C+FWgcbDnL8usVtSV7buRete62IB9fga/7+eP8aJefjRtlilXTrAW
 mEHKTaG08h7Ka7/fdhrICaHTzBz9zSNrv3AmG8s0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40MAJLmJ029142
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 22 Jan 2024 04:19:21 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Jan 2024 04:19:21 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Jan 2024 04:19:21 -0600
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40MAJHCw025956;
 Mon, 22 Jan 2024 04:19:18 -0600
Message-ID: <1c0040f2-0113-4580-9af7-510d9320407b@ti.com>
Date: Mon, 22 Jan 2024 15:49:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] arm: mach-k3: am625_init: Probe AM65 CPSW NUSS
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <afd@ti.com>, <vigneshr@ti.com>, 
 <u-boot@lists.denx.de>, <dannenberg@ti.com>, <srk@ti.com>
References: <20240112064759.1801600-1-s-vadapalli@ti.com>
 <20240112064759.1801600-8-s-vadapalli@ti.com>
 <20240112123055.5h3qio3w55godccy@gallstone>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <20240112123055.5h3qio3w55godccy@gallstone>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Mon, 22 Jan 2024 13:34:40 +0100
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


On 12/01/24 18:00, Nishanth Menon wrote:
> On 12:17-20240112, Siddharth Vadapalli wrote:
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> In order to support Ethernet boot on AM62x, probe AM65 CPSW NUSS driver
>> in board_init_f().
> Why? doesn't the DM framework handle this?
Can you suggest how can we do this ?
>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>   arch/arm/mach-k3/am625_init.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
>> index 6c96e88114..b89dd206e5 100644
>> --- a/arch/arm/mach-k3/am625_init.c
>> +++ b/arch/arm/mach-k3/am625_init.c
>> @@ -209,6 +209,16 @@ void board_init_f(ulong dummy)
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
