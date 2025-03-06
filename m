Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1174C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:28:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40C948056A;
	Thu,  6 Mar 2025 17:28:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=os-cillation.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=os-cillation.de header.i=@os-cillation.de header.b="OunLAKcn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C514180756; Thu,  6 Mar 2025 17:28:40 +0100 (CET)
Received: from os-cillation.de (mx.os-c.de [213.165.83.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D417180017
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=os-cillation.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hd@os-cillation.de
Received: from core2024.osc.gmbh (p578a635d.dip0.t-ipconnect.de [87.138.99.93])
 by os-cillation.de (Postfix) with ESMTPSA id 0A70BC0259;
 Thu,  6 Mar 2025 17:28:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=os-cillation.de;
 s=202409; t=1741278515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fAvbP1+u+AqaenklWYZWKWbtE1BFPua9TDFtjENeGUo=;
 b=OunLAKcn8bdcNG9VJedzuR3E4t8f1XK6+qPAhEJVWFtoqCW41F3tRl/s4f8Cx2X3SzvYyw
 jGfbeGYQBX3pD8s+Oijoo5Mp6z02c6CyJlWOS3/Bl7KNruyzIcYgiYC6PV8mooeNqAX+3d
 WfrZFcfq7ywY94ZyU5IEvAhDpZQSKRj9TeMjgdhilcj7JdJJG8HhSmSnfly+K4jH+ezYz4
 /kfQ553OJPlw6d3nswJTBAnBC7xVvjwylT7NhDrZEGHHMqVwIBQywwX5S6KSbwKTpcPlK2
 8SyclepSU5lfzq/rtwcqdFT52+6LJPChNk1xRpB+pMKtqtJfk+uKZFh8c1axUw==
Authentication-Results: os-cillation.de;
 auth=pass smtp.auth=os-c@schweissgut.net smtp.mailfrom=hd@os-cillation.de
Received: from [192.168.3.45] (hd2022.osc.gmbh [192.168.3.45])
 by core2024.osc.gmbh (Postfix) with ESMTPSA id 9FF222003AB;
 Thu,  6 Mar 2025 17:28:34 +0100 (CET)
Message-ID: <edbda604-e8f8-4f4c-b506-2dfb528fe10d@os-cillation.de>
Date: Thu, 6 Mar 2025 17:28:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Makefile.lib: Set xPL build related defines for DTB
 build
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Oliver Graute <oliver.graute@kococonnector.com>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Jonathan Humphreys <j-humphreys@ti.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Prasad Kummari <prasad.kummari@amd.com>
References: <20250305183544.40525-1-hd@os-cillation.de>
 <20250305183544.40525-3-hd@os-cillation.de>
 <33908f3c-b8d2-4beb-8caa-d6ff7cc3317c@cherry.de>
Content-Language: en-US
From: Hendrik Donner <hd@os-cillation.de>
Autocrypt: addr=hd@os-cillation.de; keydata=
 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 li+2
In-Reply-To: <33908f3c-b8d2-4beb-8caa-d6ff7cc3317c@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


Hello,

On 06.03.25 11:18, Quentin Schulz wrote:
> Hi Hendrik,
> 
> On 3/5/25 7:35 PM, Hendrik Donner wrote:
>> [You don't often get email from hd@os-cillation.de. Learn why this is 
>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> The CONFIG_*PL_BUILD defines are currently not defined when
>> preprocessing the dts files, leading to build problems with binman. Set
>> the defines based on the related CONFIG_*PL values.
>>
>> Tested-by: Oliver Graute <oliver.graute@kococonnector.com>
> 
> Please have this person publicly answer they tested it instead of having 
> it already in the v1 of the patch, too easy to impersonate someone and 
> give a false sense of trust into a patch that may not actually have been 
> tested.
> 
>> Signed-off-by: Hendrik Donner <hd@os-cillation.de>
>> ---
>>   scripts/Makefile.lib | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>> index 54403040f00..dd2c6363224 100644
>> --- a/scripts/Makefile.lib
>> +++ b/scripts/Makefile.lib
>> @@ -217,6 +217,16 @@ dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp - 
>> nostdinc                    \
>>                   - 
>> D__ASSEMBLY__                                          \
>>                   -undef -D__DTS__
>>
>> +ifeq ($(CONFIG_SPL),y)
>> +dtc_cpp_flags += -DCONFIG_XPL_BUILD  -DCONFIG_SPL_BUILD
>> +endif
>> +ifeq ($(CONFIG_TPL),y)
>> +dtc_cpp_flags += -DCONFIG_XPL_BUILD  -DCONFIG_TPL_BUILD
>> +endif
>> +ifeq ($(CONFIG_VPL),y)
>> +dtc_cpp_flags += -DCONFIG_XPL_BUILD  -DCONFIG_VPL_BUILD
>> +endif
>> +
> 
> You don't actually explain what you're trying to fix here and why this 
> fixes it?
> 
> Why would you need those symbols for the DT?
> 

well they are already in use in tree ([1], [2]), which breaks the build.

The history of both files is that the guards were introduced as
CONFIG_SPL, which builds, to CONFIG_SPL_BUILD, which should break the
build, haven't tested, and somewhat recently to CONFIG_XPL_BUILD,
which is when i noticed that it breaks the build for me.

Now the guards are around SPL specific nodes, so i didn't question it.
My understanding was that those are needed not necessarily during the
SPL phase, but only if SPL is defined at all.

If i understand you correctly none of it should have been introduced
like that in the first place?

I noticed it's broken in the uboot CI run too, but since the boards
need firmware blobs the CI build is erroring out in the first place, so
i guess no one noticed.

> For removing nodes in xPL, you can use one of the bootph- properties.
> 
> The DT is supposed to represent the HW, so having a different DT between 
> stages is very likely wrong. Note that having a subset of the full DT in 
> xPL stages is a bit of an exception here, for size purposes (usually 
> because of limited SRAM) or boot time purposes (you don't need to enable 
> everything in the DT in the first stage after BootROM simply to init 
> UART and DRAM :) ).
> 
> As for binman, why would it even need to be run during the xPL build 
> stages? Can you provide more context on this?
> 
> We have some big nasty ifdefery in arch/arm/dts/rockchip-u-boot.dtsi for 
> example, which has some logic on whether some symbols are defined, but 
> they are defined regardless of the stage and I assume binman gets run 
> only once, and not in xPL build phase? Is this something not applicable 
> for (I assume that's the user of that) imx8?

The arch/arm/dts/rockchip-u-boot.dtsi ifdefery is based directly on
CONFIG_SPL, not CONFIG_SPL_BUILD nor CONFIG_XPL_BUILD, so maybe the 2
dtsi i mentioned should have kept using CONFIG_SPL in the first place.

So move those back to using CONFIG_SPL?

Regards,
Hendrik

[1] 
https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/imx8qm-u-boot.dtsi#L13
[2] 
https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/imx8qxp-u-boot.dtsi#L13

> 
> Cheers,
> Quentin

