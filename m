Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E94EE3F2F
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 14:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBE4F85E44;
	Fri, 15 Sep 2023 16:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="J0872cH2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D161D864A2; Fri, 15 Sep 2023 16:43:25 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81F838071F
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 16:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38FEhKYL025433;
 Fri, 15 Sep 2023 09:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694789000;
 bh=YPNxeNzD5Bml8Ykxfk/JiCtWzRcxx5CgvY1xitTJp/8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=J0872cH24CV8YOHYr4R/RgZk/gBwFekhKT0Opj+Pg5itfgxAjzVxj+cWsUJd5LtSq
 GhoxYCOUPjyo6MOKdGDrwnhus/a4UM19f+04yKzKym2WIGT97s3Au9x9LQpinfB4/o
 iI3ybLrgogRYLlxA/WL0Ze9VDrkyWKynp0NwkiWU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38FEhKXc010030
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 15 Sep 2023 09:43:20 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Sep 2023 09:43:20 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Sep 2023 09:43:20 -0500
Received: from [10.250.38.120] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38FEhK3V014130;
 Fri, 15 Sep 2023 09:43:20 -0500
Message-ID: <f3cd9168-3a1d-6f10-0f4e-85202a1da78e@ti.com>
Date: Fri, 15 Sep 2023 09:43:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] Makefile: Force regeneration of env.txt
To: Simon Glass <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
References: <20230905180959.392276-1-afd@ti.com>
 <7ef8bf43-f84d-a76c-afa0-f87a55d57c84@ti.com>
 <CAPnjgZ0+JaYX5sA=bYwiG_+F43t9torPqrbwkfgM9m1EeijbuQ@mail.gmail.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <CAPnjgZ0+JaYX5sA=bYwiG_+F43t9torPqrbwkfgM9m1EeijbuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

On 9/10/23 5:36 PM, Simon Glass wrote:
> Hi Andrew,
> 
> On Tue, 5 Sept 2023 at 12:15, Andrew Davis <afd@ti.com> wrote:
>>
>> On 9/5/23 1:09 PM, Andrew Davis wrote:
>>> If the source .env file changes to one that is also older than
>>> the generated env.txt file then it is not regenerated. This means
>>> when switching board configs we do not regenerate the env. This
>>> can be tested easily with:
>>>
>>> $ make j721e_evm_a72_defconfig
>>> $ make # this may fail to complete but that is okay for this test
>>> $ make am64x_evm_a53_defconfig
>>> $ make
>>> $ vim include/generated/env.txt
>>>
>>> Note this is still the J721e env not the AM64 config as expected.
>>>
>>> There is probably a better way to detect if the dependency name changed,
>>> but that may involve extra files and hashing contents, so let's just
>>> force it for now.
>>>
>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>> ---
>>
>> This is basically a revert of:
>> 36fc832927eb ("Makefile: Fix incorrect FORCE deps on env rules")
>>
>> But without changing the `include/generated/env.in` rule. The more
>> I think about it, that should also be changed to forced as right
>> now any changes to include/config.h or other kconfig options are
>> not reflected in the env.in file after updates.
>>
>> That rule should depend on the generated config file so that any
>> change in kconfig variables will cause it to regenerate, that
>> might be what we need for this target instead of FORCE.
> 
> 
> 
>>
>> Andrew
>>
>>>    Makefile | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index 9be24c4ec61..d195590d4b0 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -1830,7 +1830,7 @@ quiet_cmd_envc = ENVC    $@
>>>                touch $@ ; \
>>>        fi
>>>
>>> -include/generated/env.txt: $(wildcard $(ENV_FILE))
>>> +include/generated/env.txt: $(wildcard $(ENV_FILE)) FORCE
>>>        $(call cmd,envc)
> 
> I thought that FORCE was only for if_changed - see makefiles.rst.txt
> 
> Could it depend on autoconf.h instead?
> 

That works, sending v2, thanks!

Andrew

>>>
>>>    # Write out the resulting environment, converted to a C string
> 
> Regards,
> Simon
