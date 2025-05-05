Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27B5C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 20:55:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25EAA82102;
	Mon,  5 May 2025 22:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kNK4ZQp5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 843688210A; Mon,  5 May 2025 22:55:05 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1AF6820EB
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 22:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 545Kt0oG872270
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 May 2025 15:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746478500;
 bh=qO6d/cyuHoeucg1hI9vP0sdwGNy6XUt2EWp0XsHyF+c=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=kNK4ZQp55C1KSGYva2VfmSbNZLcYOxjIWEWKEuiJSfnPP0yxg43GdYAVFggCJpRA+
 DQfPyS2inbuYYKW/4uq1xy9JApqCWTmpssi4DXnGymm62ueGFelZH2Hcj5FLIeIV+O
 rk4J0Om0CywV+7xdqPI/IIYvJlCKYfOF25BiTumA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 545Ksxpx054731
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 5 May 2025 15:55:00 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 May 2025 15:54:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 May 2025 15:54:59 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 545KsxcE016768;
 Mon, 5 May 2025 15:54:59 -0500
Message-ID: <534da8dc-f7bf-4ef3-b94d-3254a38b26a4@ti.com>
Date: Mon, 5 May 2025 15:54:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: k3-am62a-*-binman: Update ti-dm blob
To: Bryan Brattlof <bb@ti.com>, Daniel Schultz <d.schultz@phytec.de>
CC: <trini@konsulko.com>, <d-gole@ti.com>, <vibhore@ti.com>, <kamlesh@ti.com>, 
 <nm@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>
References: <20250502143414.2841260-1-d.schultz@phytec.de>
 <20250502155509.z57ec4dhcdsy6fsz@bryanbrattlof.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250502155509.z57ec4dhcdsy6fsz@bryanbrattlof.com>
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

On 5/2/25 10:55 AM, Bryan Brattlof wrote:
> On May  2, 2025 thus sayeth Daniel Schultz:
>> With [1], TI changed the Device Manager for the AM62Ax to an EdgeAI
>> based firmware. Update all binman device-tree files to match the

It wasn't changed, this is a new firmware that does new things,
the other firmware still exists.

>> latest firmware name.
>>
>> 1: https://git.ti.com/cgit/arago-project/meta-ti/commit/?h=scarthgap&id=430bab80d46ed921e4d4dc8ecaad8a4903b514c3
>>
>> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
>> ---
>>   arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 2 +-
>>   arch/arm/dts/k3-am62a-sk-binman.dtsi          | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
>> index 325702ed6e0..aa4caaeae33 100644
>> --- a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
>> +++ b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
>> @@ -167,7 +167,7 @@
>>   	ti-dm {
>>   		filename = "ti-dm.bin";
>>   		blob-ext {
>> -			filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
>> +			filename = "ti-dm/am62axx/dm_edgeai_mcu1_0_release_strip.out";
>>   			optional;
>>   		};
>>   	};
>> diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
>> index 2a8c260387b..dc6e8523172 100644
>> --- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
>> +++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
>> @@ -151,7 +151,7 @@
>>   	ti-dm {
>>   		filename = "ti-dm.bin";
>>   		blob-ext {
>> -			filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
>> +			filename = "ti-dm/am62axx/dm_edgeai_mcu1_0_release_strip.out";
> 
> I've had to ask around internally to what's actually being changed in
> this different firmware blob. I think there are probably more changes
> that need to happen before we can make this switch unfortunately
> 

That's right, this new EdgeAI firmware doesn't play nice with upstream Linux or
U-boot. It uses several carveouts in DDR which are not announced in its resource table
nor elf linker sections. To use it without it trashing your memory space you would
need these added[0]. There are also modification only in our vendor kernel that
are needed to make the rest of the EdgeAI stack functional.

So this firmware shouldn't be the default in upstream Linux/U-Boot yet*. If your
kernel is a downstream of our vendor kernel you can select this alternative
firmware at U-Boot build command line with `TI_DM=ti-dm/am62axx/dm_edgeai..`.

I say "yet" above as we would like it to be the default in the future, the
AM62A device is made specifically for AI tasks that the firmware helps enable.
But there is still some cleanup to do in that firmware to solve the above
issues first.

Andrew

[0] https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/arch/arm64/boot/dts/ti/k3-am62a7-sk-edgeai.dtso?h=ti-linux-6.12.y-cicd

> ~Bryan
