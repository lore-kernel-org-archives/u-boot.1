Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2850C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 18:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 906C886F1F;
	Fri, 17 Nov 2023 19:43:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wbDL81Hv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEB6D86F1F; Fri, 17 Nov 2023 19:43:19 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27B4686EA3
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 19:43:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AHIh3t4100152;
 Fri, 17 Nov 2023 12:43:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700246583;
 bh=YSkVW6uszasyolRewkSV4kIabZYg/jdK8CRdimGpduc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=wbDL81Hvw5IRYZ9nDHe+Gsa5pI14a8Nnw9mCIUmnK7XsR9XrXOSov5oifdU6eKFTh
 pNzPldnnLpm3ZDkLXnMMPDGUAkmHJ4tgoJmsA0hguiKQ5RoZPUX7qZfAXeUdZnX9Ax
 n1LWCjwUB8s++GY9vXDbTPafsNJFEhJlW7KnEiYY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AHIh3Av126212
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 17 Nov 2023 12:43:03 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 17
 Nov 2023 12:43:03 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 17 Nov 2023 12:43:03 -0600
Received: from [10.250.36.5] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AHIh2ot025776;
 Fri, 17 Nov 2023 12:43:02 -0600
Message-ID: <335167c2-4f59-4190-80a4-d27c036ba8a9@ti.com>
Date: Fri, 17 Nov 2023 12:43:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] board: ti: Add j721e_beagleboneai64_* config
 fragments and env file
Content-Language: en-US
To: Romain Naour <romain.naour@smile.fr>, Nishanth Menon <nm@ti.com>
CC: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sinthu Raja <sinthu.raja@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Reid Tonking <reidt@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, <u-boot@lists.denx.de>
References: <20231103003805.2420005-1-nm@ti.com>
 <20231103003805.2420005-15-nm@ti.com>
 <f0f4b6af-9831-4231-8316-1e0b0dd2dab2@ti.com>
 <20231103190629.flhz4cr5wyjyym2g@remix>
 <ee1eec62-c7ca-450c-959f-f83d5b71f8ca@ti.com>
 <e65bb379-d4e4-4c05-9855-b69443886ebd@smile.fr>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <e65bb379-d4e4-4c05-9855-b69443886ebd@smile.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

On 11/17/23 8:27 AM, Romain Naour wrote:
> Hello Andrew, All,
> 
> Le 03/11/2023 à 20:20, Andrew Davis a écrit :
>> On 11/3/23 2:06 PM, Nishanth Menon wrote:
>>> On 13:51-20231103, Andrew Davis wrote:
>>>> On 11/2/23 7:38 PM, Nishanth Menon wrote:
>>>>> Add defconfig fragments for J721E based BeagleBone AI-64 and
>>>>> corresponding customized environment.
>>>>>
>>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>>> ---
>>>>>     board/ti/j721e/beagleboneai64.env        | 19 ++++++++
>>>>>     board/ti/j721e/beagleboneai64_a72.config | 55 ++++++++++++++++++++++++
>>>>>     board/ti/j721e/beagleboneai64_r5.config  | 19 ++++++++
>>>>
>>>> Beagle boards are not TI boards, add the board support to board/beagle/
>>>
>>> Huh, why bring in commercials and organization changes here? am335x
>>> and am62 are under the TI umbrella.
>>>
>>
>> The SoCs used are yes, the boards are not, we only make our EVM/SK
>> line of boards in house.
>>
>> We did AM335x wrong, in board/ti/am335x/board.c we tried to support
>> like 11 different boards in one file. And while it might have made adding
>> our own extra EVMs easier, it only made things less clear for folks trying
>> to add their own AM335x based boards[0].
>>
>> We don't integrate support for any other board partner like this. Our
>> friends over at Toradex or Phytec are currently upstreaming boards based
>> on K3 SoCs and in doing so have shown us some areas we can improve.
>>
>> We focus on these little short-cuts to make adding our EVMs (or boards
>> that look like our EVMs) easy. But that only leads to extra work and
>> code duplication for external boards.
>>
>> If something is actually common to the SoC then lets move it to
>> arch/arm/mach-k3/j721e. Tricks like board-variants.c only hide the
>> issue and doesn't help folks wanting to add their boards based on our
>> SoCs to their board/<vendor>/ directory.
> 
> I'm starting a new custom board bring-up based on a j721e SoC (without any SOM)
> and adding a now board variant from the u-boot provided in the TI SDK (based on
> 2023.04) is far from easy for the reasons mentioned above (extra work and code
> duplication for external boards).
> 
> Also the build break for j7200/j721e SoC as soon as CONFIG_TARGET_J721E_A72_EVM
> and CONFIG_TARGET_J7200_A72_EVM are undefined:
> 

The issue is we didn't properly split J7200 support from J721e and now that
there are differences between the two, the only way we have to check which
is which is to check the TARGET board, not the SOC (as there is no SOC_K3_J7200,
but we are working on that [0]). So currently adding new J721E/J7200 TARGET
boards breaks things :(

> https://source.denx.de/u-boot/u-boot/-/blob/v2023.10/arch/arm/mach-k3/arm64-mmu.c?ref_type=tags#L71
> 
> I always wonder if I should work on top of EVMs board or create a new
> board/<vendor>/ directory for customer boards.
> 

New board/<vendor>/ would be preferred, we do things in our EVM board/ti/
dir that are specific to our EVMs, and there will be more churn, etc..

If adding a new board/<vendor>/ for our SoCs is difficult just let us know,
we are working several issues to make it more easy going forward and guiding
feedback always helps.

Andrew

[0] https://lore.kernel.org/all/20231106165044.xrmlxoyfbnkmpb5v@revolt/

> Best regards,
> Romain
> 
>>
>> Andrew
>>
>> [0] See "Software Design" https://jaycarlson.net/embedded-linux/#am335x
>>
>>> $ git grep beagle board/|cut -d ':' -f1|sort -u
>>> board/ti/am335x/board.c
>>> board/ti/am335x/board.h
>>> board/ti/am57xx/board.c
>>> board/ti/am62x/beagleplay_a53.config
>>> board/ti/am62x/beagleplay_r5.config
>>> board/ti/am62x/MAINTAINERS
>>> board/ti/beagle/beagle.c
>>> board/ti/beagle/Kconfig
>>> board/ti/beagle/led.c
>>> board/ti/beagle/MAINTAINERS
>>> board/ti/beagle/Makefile
>>> board/ti/j721e/beagleboneai64_a72.config
>>> board/ti/j721e/beagleboneai64_r5.config
>>> board/ti/j721e/MAINTAINERS
>>> board/timll/devkit8000/README
>>>
> 
