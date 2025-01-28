Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17472C0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 05:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E4B78186D;
	Tue, 28 Jan 2025 06:20:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NleO76Va";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DFBD81870; Tue, 28 Jan 2025 06:20:09 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06181812BB
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 06:20:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50S5K4S01131157
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2025 23:20:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738041604;
 bh=jm9Gz6A2T9Enl6f7b1+t7iCKdj0EYZqG57p3Q8va30A=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=NleO76Vavf+ve9uRwQ7iYNk7UYNcuDd9XCxexKqBm9hzsZCkhcn37/Auj6gUkz+ZH
 nKhCHoWD52ZlXaux/OzjfDM9cRJKajSEiyIQEWvi28DHPI2nUZ83GmeRzOhNSwRGqQ
 M96plUeMBaJphU94vSgDsp+geL6mc1Ewym04rT20=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50S5K4Vs049373
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Jan 2025 23:20:04 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Jan 2025 23:20:04 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Jan 2025 23:20:04 -0600
Received: from [10.249.140.248] ([10.249.140.248])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50S5K0rW115471;
 Mon, 27 Jan 2025 23:20:01 -0600
Message-ID: <08fe07d0-f3a9-4beb-8ba4-77b694d5ac35@ti.com>
Date: Tue, 28 Jan 2025 10:49:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] k3-ddr.c: Remove unwanted header files
To: Wadim Egorov <w.egorov@phytec.de>, <trini@konsulko.com>, <bb@ti.com>,
 <s-k6@ti.com>, <marek.vasut+renesas@mailbox.org>, <sabiya.d@ti.com>
CC: <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20250127142217.1757300-1-n-francis@ti.com>
 <20250127142217.1757300-2-n-francis@ti.com>
 <e9ef023d-0e23-45ab-952d-248514bb2bf4@phytec.de>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <e9ef023d-0e23-45ab-952d-248514bb2bf4@phytec.de>
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

Hi Wadim

On 28-Jan-25 10:32 AM, Wadim Egorov wrote:
> Hi Neha,
> 
> Am 27.01.25 um 21:22 schrieb Neha Malcom Francis:
>> This header file is not in use in these arch/board specific files,
>> remove them.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   arch/arm/mach-k3/k3-ddr.c | 1 -
>>   board/ti/common/k3-ddr.c  | 1 -
>>   2 files changed, 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-k3/k3-ddr.c b/arch/arm/mach-k3/k3-ddr.c
>> index 6e3e60cdc86..026381490da 100644
>> --- a/arch/arm/mach-k3/k3-ddr.c
>> +++ b/arch/arm/mach-k3/k3-ddr.c
>> @@ -5,7 +5,6 @@
>>   #include <fdt_support.h>
>>   #include <dm/uclass.h>
>> -#include <k3-ddrss.h>
> 
> k3_ddrss_ddr_fdt_fixup() is still used here and the compiler gives us a 
> implicit declaration warning.
> 

Let me take a look at that, must've missed it out; this cleanup was 
intended for the test patch that I will send out later.

> Regards,
> Wadim
> 

-- 
Thanking You
Neha Malcom Francis
