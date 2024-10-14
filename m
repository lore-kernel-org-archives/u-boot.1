Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEFECF2590
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 04:17:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EDD1889EB;
	Mon, 14 Oct 2024 06:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="s+0Lyvf3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D64A88CEA; Mon, 14 Oct 2024 06:17:34 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 733EA8898B
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 06:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49E4HREM104802;
 Sun, 13 Oct 2024 23:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728879447;
 bh=UezEg57F3ccwCPtRaw72JW8PpwFoihccOJJlpciPHbI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=s+0Lyvf3ZRj/EK8HevhNCboqXoX/bLWL1jdYGLhgoCGfECUJxmwGaB5gfar3qgfVa
 wcvzFv2WXZ+r5KWlTVqoyNuTNS3+NFKY9KHOo6nVTYJTIq4dGFs+hR3PKiT8NZtOIH
 t6OfSnOsPkSaBhBpWWGJvnEj11ORhefUdZ45gVFA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49E4HRvI093226
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 13 Oct 2024 23:17:27 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 13
 Oct 2024 23:17:27 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 13 Oct 2024 23:17:27 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49E4HO1N071652;
 Sun, 13 Oct 2024 23:17:25 -0500
Message-ID: <ace473a4-6f41-4f96-8d59-2e64923bb5f4@ti.com>
Date: Mon, 14 Oct 2024 09:47:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boardf: Modify DRAM message
To: Tom Rini <trini@konsulko.com>
CC: <sjg@chromium.org>, <devarsht@ti.com>, <jonas@kwiboo.se>, <richard@nod.at>,
 <raymond.mao@linaro.org>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20241010070909.288313-1-n-francis@ti.com>
 <20241010175825.GP14210@bill-the-cat>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20241010175825.GP14210@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Tom

On 10/10/24 23:28, Tom Rini wrote:
> On Thu, Oct 10, 2024 at 12:39:09PM +0530, Neha Malcom Francis wrote:
> 
>> The message "DRAM:  2 GiB (effective 32 GiB)" can be a little confusing,
>> modify the message to show exactly what is meant:
>>
>> "DRAM:  2 GiB (available for U-Boot out of total 32 GiB)"
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   common/board_f.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/common/board_f.c b/common/board_f.c
>> index 154675d0e40..b7add8f7d3d 100644
>> --- a/common/board_f.c
>> +++ b/common/board_f.c
>> @@ -254,7 +254,7 @@ static int show_dram_config(void)
>>   
>>   	print_size(gd->ram_size, "");
>>   	if (!sizes_near(gd->ram_size, size)) {
>> -		printf(" (effective ");
>> +		printf(" (available for U-Boot out of total ");
>>   		print_size(size, ")");
>>   	}
>>   	board_add_ram_info(0);
> 
> We're growing a constant string in every build here. I would rather see
> doc/develop/memory.rst start to get updated to spell out that when we
> print "effective" here it's because we do not have the full 64bit
> address space available, only 2GiB.
> 

Agreed, maybe we can take both updation of memory.rst as well as Simon's 
suggestion of s/effective/total to clear things out.

-- 
Thanking You
Neha Malcom Francis
