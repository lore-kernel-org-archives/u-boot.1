Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7689ACF259D
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 04:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6D8988E50;
	Mon, 14 Oct 2024 06:15:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TYDmRIcx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A60288D9E; Mon, 14 Oct 2024 06:15:52 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0509088CEA
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 06:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49E4FfiP104215;
 Sun, 13 Oct 2024 23:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728879341;
 bh=TC/eam9XhodsQeecglIZJX/8Io01oKV0KbDNGuUfh0Q=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=TYDmRIcxthVQ79gcsjPl/P92HDtCz3y8hmKpRtxyEKMbbJ2X/jPAAnrT1bW8cszPA
 H+65EUj2mCVkze3aEMgt+iXQnoxiAhaV9J5JfKBHTAtZ9robixMOmaVWhP5J6weix4
 l8edF+mbsINs0zlvPKAD99XAuRbB21XuySeEZ6ns=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49E4Ff9q000425
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 13 Oct 2024 23:15:41 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 13
 Oct 2024 23:15:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 13 Oct 2024 23:15:41 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49E4FcXI009532;
 Sun, 13 Oct 2024 23:15:39 -0500
Message-ID: <3ca45cee-8ac9-4970-8025-472f72903e62@ti.com>
Date: Mon, 14 Oct 2024 09:45:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boardf: Modify DRAM message
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>
CC: <sjg@chromium.org>, <devarsht@ti.com>, <jonas@kwiboo.se>, <richard@nod.at>,
 <raymond.mao@linaro.org>, <u-boot@lists.denx.de>
References: <20241010070909.288313-1-n-francis@ti.com>
 <3170149c-2e82-48f3-8477-e82acf6c58dd@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <3170149c-2e82-48f3-8477-e82acf6c58dd@ti.com>
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

Hi Udit

On 10/10/24 21:25, Kumar, Udit wrote:
> 
> On 10/10/2024 12:39 PM, Neha Malcom Francis wrote:
>> The message "DRAM:  2 GiB (effective 32 GiB)" can be a little confusing,
>> modify the message to show exactly what is meant:
>>
>> "DRAM:  2 GiB (available for U-Boot out of total 32 GiB)"
> 
> 
> Still confusing for me atleast :) can this be
> 
> "DRAM: 2 GiB available for U-Boot, out of total 32 GiB"
> 

According to Tom, growing this string is not a good option; I agree as well, we 
can choose a different approach.

> 
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   common/board_f.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/common/board_f.c b/common/board_f.c
>> index 154675d0e40..b7add8f7d3d 100644
>> --- a/common/board_f.c
>> +++ b/common/board_f.c
>> @@ -254,7 +254,7 @@ static int show_dram_config(void)
>>       print_size(gd->ram_size, "");
>>       if (!sizes_near(gd->ram_size, size)) {
>> -        printf(" (effective ");
>> +        printf(" (available for U-Boot out of total ");
>>           print_size(size, ")");
>>       }
>>       board_add_ram_info(0);

-- 
Thanking You
Neha Malcom Francis
