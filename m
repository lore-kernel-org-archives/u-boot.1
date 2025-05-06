Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE1AC3ABBE
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 17:18:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3E69820EB;
	Tue,  6 May 2025 19:18:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cPheiSnC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB350820F6; Tue,  6 May 2025 19:18:14 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96AB780BAE
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 19:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 546HI51H560449
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 May 2025 12:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746551885;
 bh=v+lUFrkx+VZY8mOJ5Ieu+Ks9MfaHo9mbAiMnkgVNwD4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=cPheiSnCUzkR/Ly6wutZtFwd4xH/yaUbvsc+BXrGCPpFjStDFLDHZcGGZb19FJhGQ
 79KV9Nl9V5oeAIxE18gOty238VSrX5vzBA2G54AuCwJqpQ7z5YfHf4E401Ddob5c4S
 fYaART+byE4CP7CH7Wql4lMno+OoiqWj/bg1oQS0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 546HI5BY027968
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 May 2025 12:18:05 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 May 2025 12:18:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 May 2025 12:18:04 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 546HHvne119816;
 Tue, 6 May 2025 12:17:58 -0500
Message-ID: <40b2ddc2-fe5b-4515-8772-2a2f9f35b5d7@ti.com>
Date: Tue, 6 May 2025 22:47:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Add support to boot TI K3 HSM M4 core
To: Andrew Davis <afd@ti.com>, Beleswar Prasad Padhi <b-padhi@ti.com>,
 <trini@konsulko.com>
CC: <sjg@chromium.org>, <xypron.glpk@gmx.de>, <cfsworks@gmail.com>,
 <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>, <jm@ti.com>,
 <m-chawdhry@ti.com>, <kamlesh@ti.com>, <bb@ti.com>,
 <j-humphreys@ti.com>, <s-k6@ti.com>, <j-choudhary@ti.com>,
 <d-gole@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>
References: <20250506104202.16741-1-b-padhi@ti.com>
 <41a042ec-d2ec-48ee-be15-a6f88895e977@ti.com>
 <b643bfa3-5607-4d9e-95bd-cfab9d7a6ca5@ti.com>
 <3ffaf965-503f-4c08-b914-3d4014cdf72a@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <3ffaf965-503f-4c08-b914-3d4014cdf72a@ti.com>
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


On 5/6/2025 8:38 PM, Andrew Davis wrote:
> On 5/6/25 9:51 AM, Beleswar Prasad Padhi wrote:
>> Hi Andrew,
>>
>> On 5/6/2025 4:38 PM, Andrew Davis wrote:
>>> On 5/6/25 5:41 AM, Beleswar Padhi wrote:
>>>> Some TI K3 SoCs like J721S2, and J784S4 have a HSM (High Security
>>>> Module) M4F core in the Wakeup Voltage Domain which could be used to
>>>> run secure services like Authentication. Boot flow for HSM M4 core is
>>>> different than the general purpose M4F cores, and is as below:
>>>>
>>>
>>> The below flow looks exactly like the general purpose M4F cores..
>>> Why is the HSM core treated differently and this loader not made into
>>> a normal remote proc driver?
>>
>>
>> Not exactly, HSM core is treated differently because of following 
>> exceptions:
>> 1. Device operations for HSM core (like reset/reset release) are not 
>> handled by DM. TIFS handles that with proc_boot_ctrl TI-SCI calls.
>
> This could be added to the commit message then.
>
>> 2. The HSM firmware is not an ELF image. So we can't use rproc elf 
>> loader with it. Manual memcpy has to be done.
>>
>
> Why is the HSM firmware not an ELF image?


HSM firmwares are loaded by TIFS (in non-GP) flow, and TIFS does not 
have elf parser.



>
>> All of that can still be accounted in the existing M4 rproc driver, 
>> but it will be a lot of if-else checks, which I don't prefer. Let me 
>> know if you prefer that way.
>>
>
> I'm not a fan of if-else checks either, just trying to get an idea
> of how many would really be needed. Judging from the below commit
> I'd agree keeping it here would be the cleaner option for now.
>
> Andrew
>
>> Patch having HSM support in M4 remoteproc driver:
>> https://gist.github.com/3V3RYONE/a15a5c6933bbc83278da9860c25ec21c
>>
>>>
>>> Andrew
>>>
>>>> 1. Request control of HSM M4F remote processor.
>>>> 2. Assert Reset on the HSM M4F remote processor.
>>>> 3. Request Secure Entity to Authenticate and Load HSM firmware into
>>>>     core's internal SRAM memory region. For GP device, load the 
>>>> firmware
>>>>     manually into core's SRAM region.
>>>> 4. Deassert Reset on the HSM M4F remote processor.
>>>> 5. Release control of HSM M4F remote processor.
>>>>
>>>> This series adds support to boot HSM M4 core from R5 SPL stage. The 
>>>> HSM
>>>> firmware is packed inside the tispl.bin fit image. The firmware is
>>>> unpacked into a temporary DDR address which is then used to load HSM
>>>> core. The configs to boot HSM M4 core are disabled by default.
>>>>
>>>> v2: Changelog:
>>>> [Andrew]:
>>>>   1. Added support in SPL to load FIT images with no 'load' property.
>>>>   2. Removed 'default = n' in CONFIG option.
>>>>   3. Used __maybe_unused to decrease preprocessing.
>>>>   4. Better error messages with error code.
>>>> [Udit]:
>>>>   1. Added 'HSM' entries in enum at the last.
>>>>   2. Added error condition in if-elseif-else ladder.
>>>>   3. Hang System boot when HSM failed to boot properly.
>>>>
>>>> Link to v1:
>>>> https://lore.kernel.org/all/20250422095430.363792-1-b-padhi@ti.com/
>>>>
>>>> Test logs after enabling HSM boot configs:
>>>> https://gist.github.com/3V3RYONE/ad33683652c8c49e4fedab49f0493e79
>>>>
>>>> Beleswar Padhi (7):
>>>>    arm: mach-k3: Add config option for booting HSM core
>>>>    spl: Use FIT data address as fallback when 'load' property is 
>>>> absent
>>>>    arm: dts: k3-binman: Add template for packing HSM firmware
>>>>    arm: dts: k3-{j721s2/j784s4}-binman: Pack HSM firmware inside
>>>>      tispl.bin
>>>>    arm: mach-k3: Use FIT image data addr as fallback if 'load' prop is
>>>>      missing
>>>>    arm: mach-k3: Explicitly identify TIFSSTUB images when discarding
>>>>      buffers
>>>>    arm: mach-k3: r5: common: Add support to boot HSM M4 core
>>>>
>>>>   arch/arm/dts/k3-binman.dtsi        |   9 +++
>>>>   arch/arm/dts/k3-j721s2-binman.dtsi |  12 ++++
>>>>   arch/arm/dts/k3-j784s4-binman.dtsi |  14 ++++
>>>>   arch/arm/mach-k3/Kconfig           |   7 ++
>>>>   arch/arm/mach-k3/r5/common.c       | 111 
>>>> +++++++++++++++++++++++++++--
>>>>   common/spl/spl_fit.c               |  16 ++++-
>>>>   6 files changed, 164 insertions(+), 5 deletions(-)
>>>>
