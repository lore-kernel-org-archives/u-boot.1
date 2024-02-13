Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5A9C4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 06:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F79787C8F;
	Tue, 13 Feb 2024 07:06:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="k6Fn73s+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2B3787C00; Tue, 13 Feb 2024 07:06:09 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38A17875FC
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 07:06:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-bhatia1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41D6657K022669;
 Tue, 13 Feb 2024 00:06:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707804365;
 bh=JLs1blDzBjl41ajfMZgzVDmGzut22AUvDIoCDggC7/o=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=k6Fn73s+z4NQwBuR8wXlFuFp03JHITZnk5FM93zgWcPhgz0m8pnh9aaY7Xscfj5Ur
 UVv41I22/gbGbDiUetDUY3dXwWNjxZQlA1gFU/gKP+3bohGOLWekAr5i8niVIpt3SC
 d3IRYR021dbzook4lmghWhPQjOqe9oJsnSxLjpaI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41D665tn032162
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 13 Feb 2024 00:06:05 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Feb 2024 00:06:04 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Feb 2024 00:06:04 -0600
Received: from [172.24.227.31] (uda0496377.dhcp.ti.com [172.24.227.31])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41D6619p040756;
 Tue, 13 Feb 2024 00:06:02 -0600
Message-ID: <1d341c03-14af-40fa-ae04-d1258a6652bf@ti.com>
Date: Tue, 13 Feb 2024 11:36:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: mach-k3: Refactor QoS settings
Content-Language: en-US
To: Bryan Brattlof <bb@ti.com>
CC: Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>, Nishanth Menon
 <nm@ti.com>, u-boot Mailing List <u-boot@lists.denx.de>,
 Vignesh Raghavendra <vigneshr@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Jai Luthra <j-luthra@ti.com>,
 Aniket Limaye <a-limaye@ti.com>
References: <20240212100635.879272-1-a-bhatia1@ti.com>
 <20240212152122.4gsxji44wevoyeor@bryanbrattlof.com>
From: Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20240212152122.4gsxji44wevoyeor@bryanbrattlof.com>
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

Hey Bryan!

On 12/02/24 20:51, Bryan Brattlof wrote:
> Hey Aradhya!
> 
> On February 12, 2024 thus sayeth Aradhya Bhatia:
>> Refactor common QoS code into a new common header file, and the soc
>> specific setup_qos functions into a common API.
>>
>> Rename $(soc)_qos_count and $(soc)_qos_data variables to qos_count and
>> qos_data. When QoS settings of more SoCs are added, only one pair will
>> be defined at a time, based on the config SOC_K3_$(soc).
>>
>> This refactoring has been done for 2 major purposes.
>>
>> - The auto-generated $(soc)_qos_data.c and $(soc)_qos.h files cannot
>>   have any code that is specific to any bootloader. Those files have to
>>   remain agnostic of different bootloader implementations and their
>>   header files.
>>
>> - The existing implementation was less than ideal and would have enabled
>>   multiple $(soc)_qos_count and $(soc)_qos_data variables for all SoC
>>   variants.
>>
>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>> ---
>>
>> Change Log:
>>
>>  - new in v2:
>>    - Move K3_QOS config to the r5/Kconfig.
>>
>> Previous versions:
>>
>>   - v1: https://lore.kernel.org/all/20240206085610.3226136-1-a-bhatia1@ti.com/
>>
> 
> ...
> 
>> diff --git a/arch/arm/mach-k3/r5/am62ax/Makefile 
>> b/arch/arm/mach-k3/r5/am62ax/Makefile
>> index 02a941805e9a..e4e55ce5c7dd 100644
>> --- a/arch/arm/mach-k3/r5/am62ax/Makefile
>> +++ b/arch/arm/mach-k3/r5/am62ax/Makefile
>> @@ -4,4 +4,4 @@
>>  
>>  obj-y += clk-data.o
>>  obj-y += dev-data.o
>> -obj-y += am62a_qos_data.o
>> +obj-y += am62a_qos_uboot.o
> 
> No objections from me though I am curious about the name change. Was 
> there an issue with using the original am62a_qos_data.c
> 

Yes! The previous version of the auto-generated file ($soc_qos_data.c)
was the same for u-boot and SBL, which restricted us from making u-boot
specific changes. We will now be creating 2 different files for each of
them, and the name had to be changed to reflect that.


Regards
Aradhya




