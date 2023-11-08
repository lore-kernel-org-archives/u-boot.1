Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6BCC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 10:13:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F34C2876B2;
	Wed,  8 Nov 2023 11:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vYxvIuJU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E1A1876BE; Wed,  8 Nov 2023 11:13:10 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 392658765C
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 11:13:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-yadav@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A8AD59Q002640;
 Wed, 8 Nov 2023 04:13:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699438385;
 bh=tT9o64HaHy6DiWVPsiaduhuLRj6VfVMNQDceF4Lt7lo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=vYxvIuJUzL6JCKwcFFYQQMSCYgFW/YjRYj/0lQxES71IxmSRcb/Z5ecixonDGFSOr
 tqkMP2mzCD37jJ9udwb8xlcvCgaQzSOzw+0REEu7xIUvVIm8niEVFHX3RvXMLwPzyf
 41tiQs4kz/4IitFXNC7EFb+wRMugBv0uwFzhYDms=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A8AD50e007092
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 8 Nov 2023 04:13:05 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 8
 Nov 2023 04:13:05 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 8 Nov 2023 04:13:05 -0600
Received: from [10.24.69.29] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A8AD3TS119324;
 Wed, 8 Nov 2023 04:13:04 -0600
Message-ID: <b10bac0f-ca2a-9a95-ed29-d48dd50d2fbb@ti.com>
Date: Wed, 8 Nov 2023 15:43:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/6] board: ti: am62x: Avoid overwriting reserve mem for
 AM62 SIP
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
CC: <nm@ti.com>, <u-boot@lists.denx.de>
References: <20231031132809.1524341-1-n-yadav@ti.com>
 <20231031132809.1524341-4-n-yadav@ti.com>
 <20231031135515.GK496310@bill-the-cat>
From: Nitin Yadav <n-yadav@ti.com>
In-Reply-To: <20231031135515.GK496310@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
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



On 31/10/23 19:25, Tom Rini wrote:
> On Tue, Oct 31, 2023 at 06:58:06PM +0530, Nitin Yadav wrote:
>> AM62 SIP has 512MB RAM. But the top of the RAM is reserved for
>> TF-A and OPTEE. U-Boot relocating there would cause overwriting
>> of these reserved regions. Fix this by limit U-Boot to first
>> 64MB of RAM for all boards with 512MB.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
>> ---
>>  board/ti/am62x/evm.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
>> index ad93908840..ad3e415592 100644
>> --- a/board/ti/am62x/evm.c
>> +++ b/board/ti/am62x/evm.c
>> @@ -18,6 +18,7 @@
>>  #include <asm/io.h>
>>  #include <asm/arch/hardware.h>
>>  #include <dm/uclass.h>
>> +#include <linux/sizes.h>
>>  
>>  DECLARE_GLOBAL_DATA_PTR;
>>  
>> @@ -59,6 +60,16 @@ int dram_init_banksize(void)
>>  	return fdtdec_setup_memory_banksize();
>>  }
>>  
>> +phys_size_t get_effective_memsize(void)
>> +{
>> +	/*
>> +	* Just below 512MB are TF-A and OPTEE reserve regions, thus
>> +	* SPL/U-Boot RAM has to start below that. Leave 64MB space for
>> +	* all reserved memories.
>> +	*/
>> +	return gd->ram_size == SZ_512M ? SZ_512M - SZ_64M : gd->ram_size;
>> +}
> 
> Where are TF-A and OPTEE in other cases? Are we not able to read the
> reserved memory nodes and handle this through that?
This is first Board where we have 512M of RAM, Others have 2GB of RAM.
That's why we are reserving this space.
> 

-- 
Regards,
Nitin
