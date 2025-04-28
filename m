Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8107CC36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 06:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD4DE820B7;
	Mon, 28 Apr 2025 08:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="zPnJdTn1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE40A82103; Mon, 28 Apr 2025 08:25:47 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1895780FDA
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 08:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53S6PhEk2697600
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Apr 2025 01:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745821543;
 bh=y2Rcnl19fYFFGqFr4SYige5dUN1JmK4RIFfXi9ru9Lo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=zPnJdTn1eK6jgclMP3cu6epjZiA3Mui6gTa7wzldCVDINr0RxtvjhxvNKbLalo0Qj
 pwsSJ6tjp1Ftl58Y5YmLE9WF5krydE4PX3LN2zG2IuX07/2s5X7e6GyWQjY3U+GpC+
 jYzzuM4ngDa73+eZSdsVme8nlrjWIs+fds75IyoQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53S6PhOP001964
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Apr 2025 01:25:43 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Apr 2025 01:25:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Apr 2025 01:25:42 -0500
Received: from [172.24.227.151] (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53S6Pegt005757;
 Mon, 28 Apr 2025 01:25:40 -0500
Message-ID: <b6bc14fc-c823-4376-939f-2c0e6b120a2c@ti.com>
Date: Mon, 28 Apr 2025 11:55:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm: dts: k3-binman: Add template for packing HSM
 firmware
To: Andrew Davis <afd@ti.com>, <trini@konsulko.com>
CC: <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20250422095430.363792-1-b-padhi@ti.com>
 <20250422095430.363792-3-b-padhi@ti.com>
 <061dd508-b350-4f47-badb-ab773496be9e@ti.com>
 <f562754c-d466-4be2-8478-585891e006e7@ti.com>
 <124e562b-e131-4440-969d-def5fc8b294d@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <124e562b-e131-4440-969d-def5fc8b294d@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Andrew,

On 24/04/25 21:25, Andrew Davis wrote:
> On 4/24/25 12:21 AM, Beleswar Prasad Padhi wrote:
>> Hi Andrew,
>>
>> On 22/04/25 20:04, Andrew Davis wrote:
>>> On 4/22/25 4:54 AM, Beleswar Padhi wrote:
>>>> The HSM M4 core needs to be booted at R5 SPL stage so that it can be
>>>> used for further Authentication and security services. Therefore, the
>>>> firmware for the HSM core needs to be packed in tispl.bin fit image so
>>>> that it can be used by R5 SPL to boot the HSM core.
>>>>
>>>> Add a template for packing the HSM firmware in tispl.bin. The size of
>>>> HSM firmware is padded upto 256 KB. The HSM binaries are unloaded at a
>>>> temporary DDR address.
>>>>
>>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>>> ---
>>>>    arch/arm/dts/k3-binman.dtsi | 11 +++++++++++
>>>>    1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
>>>> index 5163161b94d..c2b8388b06e 100644
>>>> --- a/arch/arm/dts/k3-binman.dtsi
>>>> +++ b/arch/arm/dts/k3-binman.dtsi
>>>> @@ -297,6 +297,17 @@
>>>>                        };
>>>>                    };
>>>>    +#ifdef CONFIG_K3_HSM_FW
>>>> +                hsm {
>>>> +                    description = "HSM binary";
>>>> +                    type = "standalone";
>>>> +                    compression = "none";
>>>> +                    os = "hsm";
>>>> +                    load = <0x82000000>;
>>>> +                    entry = <0x82000000>;
>>>
>>> These addresses might already be in use. Why do you need an `entry`
>>> address here?
>>
>>
>> SPL parses the FIT image and assigns the `image_start` based on this `entry` address.
>>
>> https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/mach-k3/r5/common.c?ref_type=heads#L317
>> https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/mach-k3/r5/common.c?ref_type=heads#L165
>>
>
> And that `image_start` only matters for images we will be starting, what
> does it do in this case? HSM is a remote core, and the actual start address
> is not 0x82000000, that is the load address, it does not run from there.
>
> The only place `image_start` for HSM is used in is in code you add in
> patch [4/4], and you use it to populate `hsm_image_addr`. That is
> the load address, not the start address.


You are correct. Thanks, will remove this in revision.

>
>>
>>> Or a `load` address?, if one isn't given then U-Boot
>>> should pick a safe spot for you, or even do the operation in-place.
>>
>>
>> Looks like that's not the case. When I skipped `load` section, U-Boot complains with following error:
>>
>
> This works for other images, maybe it is not functional for SPL I'm not
> sure, if not that is a bug and should be fixed.


Hmm, it looks like this is supported for other FIT images:
https://source.denx.de/u-boot/u-boot/-/blob/master/boot/image-fit.c?ref_type=heads#L2266


>
> Looking over the code, I see no reason you need to copy it to another
> location before working on the image. It is an extra copy before it is
> copied by rproc to the real final location.


Well you are right. I will take a stab at adding this optional loadaddr support in SPL images.

Thanks,
Beleswar

>
> Andrew
>
>
>> ```
>> U-Boot SPL 2025.04-01182-gaa96051c7f78-dirty (Apr 24 2025 - 10:42:17 +0530)
>> SYSFW ABI: 4.0 (firmware rev 0x000b '11.0.9--v11.00.09+ (Fancy Rat)')
>> Initialized 4 DRAM controllers
>> SPL initial stack usage: 13456 bytes
>> Trying to boot from MMC2
>> Skipping authentication on GP device
>> Can't load hsm: No load address and no buffer
>> spl_load_simple_fit: can't load image loadables index 0 (ret = -105)
>> spl_load_image_fat: error reading image tispl.bin, err - -105
>> spl_load_image_ext: ext4fs mount err - 0
>> Error: -2
>> SPL: failed to boot from all boot devices
>> ### ERROR ### Please RESET the board ###
>> ```
>>
>> Thanks,
>> Beleswar
>>
>>>
>>> Andrew
>>>
>>>> +                };
>>>> +#endif
>>>> +
>>>>                    dm {
>>>>                        description = "DM binary";
>>>>                        type = "firmware";
