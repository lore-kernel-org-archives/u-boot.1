Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BAECAC597
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 18:09:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E0B183496;
	Mon, 15 Sep 2025 20:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XmHYlR8b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 901FA8349B; Mon, 15 Sep 2025 20:09:21 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5490D8344E
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 20:09:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58FI9GfO1096654;
 Mon, 15 Sep 2025 13:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757959757;
 bh=+LzQWVtlux8VNNyPCCpDTPbQJZS1CLkQGsQGGImLVxA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=XmHYlR8bvYgDEoOksr4AXzCrarGbDwVft9Z2ZxvkOBmSMIk+O0PLql0cvnqOnUFF5
 eVMmIyQvWOEfuT8FUx32wi5YA+TfkkQ/IPynMYrLY7Hp/HtgCBgzoTIk51nSjKPVS9
 +fvNY/NnBiG/E7IwRzG6UC4OJ/vjIT1LckHTMMJA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58FI9GmA925097
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 15 Sep 2025 13:09:16 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 15
 Sep 2025 13:09:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Sep 2025 13:09:16 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58FI9Gj6050760;
 Mon, 15 Sep 2025 13:09:16 -0500
Message-ID: <7d85c88f-8582-4f87-b1c4-e97772e4aa68@ti.com>
Date: Mon, 15 Sep 2025 13:09:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm: mach-k3: Fix MMC macros
To: Wadim Egorov <w.egorov@phytec.de>, Tom Rini <trini@konsulko.com>
CC: Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 "Vaishnav Achath" <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, "Moteen Shah" <m-shah@ti.com>,
 Andrew Davis <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
References: <20250910214514.1848847-1-jm@ti.com>
 <20250910214514.1848847-2-jm@ti.com>
 <b48c05f5-c8ae-4353-aabc-7217dad18d4a@phytec.de>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <b48c05f5-c8ae-4353-aabc-7217dad18d4a@phytec.de>
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

On 9/15/25 9:22 AM, Wadim Egorov wrote:
> Hi Judith,
> 
> On 9/11/25 12:45 AM, Judith Mendez wrote:
>> For all K3 SoC's eMMC boot and MMCSD boot modes are supported. The macros
>> however, mix MMC device with the two bootmodes. Decouple the two types
>> of macros so that bootmodes can be identified with:
>> - BOOT_DEVICE_MMCSD
>> - BOOT_DEVICE_EMMC
>> according to devstat parsed boot mode values and on-board devices can be
>> identified with:
>> - BOOT_DEVICE_MMC1
>> - BOOT_DEVICE_MMC2
>> - BOOT_DEVICE_MMC2_2
>> according to arbitrary numbers mainly used to differentiate between eMMC
>> and SD card.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
> 
> <snip>
> 
>> +++ b/arch/arm/mach-k3/include/mach/am62_spl.h
>> @@ -17,7 +17,7 @@
>>   #define BOOT_DEVICE_ETHERNET_RMII    0x05
>>   #define BOOT_DEVICE_I2C            0x06
>>   #define BOOT_DEVICE_UART        0x07
>> -#define BOOT_DEVICE_MMC            0x08
>> +#define BOOT_DEVICE_MMCSD            0x08
>>   #define BOOT_DEVICE_EMMC        0x09
>>   #define BOOT_DEVICE_USB            0x2A
>> @@ -29,16 +29,16 @@
>>   /* U-Boot used aliases */
>>   #define BOOT_DEVICE_ETHERNET        0x04
>> -#define BOOT_DEVICE_MMC2        0x08
>> -#define BOOT_DEVICE_MMC1        0x09
>> +#define BOOT_DEVICE_MMC1        0xFF0
>> +#define BOOT_DEVICE_MMC2        0xFF1
> 
> How did you end up using 0xFF0? Is it simply to make the difference 
> between modes more clear? It probably does not matter because it is a u- 
> boot-only representation.


Yes to differentiate. So it it does not matter then why does it matter
to change to 0xFF0? My opinion here is that switching to 0xFF0 helps\
when debugging.

This method is the same way we were doing with BOOT_DEVICE_MMC2_2 which
also had an arbitrary number because the macro is required by u-boot.

But now::
BOOT_DEVICE_MMC2 -> 0xFF0 instead of using MMCSD boot value
BOOT_DEVICE_MMC1 -> 0xFF1 instead of using eMMC boot value
and just modified:
BOOT_DEVICE_MMC2_2 -> 0xFF2 instead of 0xFF or other arbitrary numbers.

~ Judith

