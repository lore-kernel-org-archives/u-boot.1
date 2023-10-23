Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DB0C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 07:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 052A587897;
	Mon, 23 Oct 2023 09:06:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bGb6p0nO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C242878A5; Mon, 23 Oct 2023 09:06:44 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2E99874BD
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39N76bbo047449;
 Mon, 23 Oct 2023 02:06:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698044797;
 bh=2eo/Ifd7kLcW2nnWbJC1w2hc1x0rjzoKD02IpAALbVU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=bGb6p0nOpoALuVnaqUfE0y/pHUhCKOeLUscCTOhsw0ra1pNLgqq0SKdVNTaf/jI5A
 keNtuiKgNhGuvAmjsVA8x3xU/X8kfKy1Lyqpilmp4MuIcoa9hbgDE5BaTWGP1AvF7j
 NIxKafzJPjTz8l4FEyYngb7pHbIDV7Ro77wM76Wg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39N76blu007175
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 23 Oct 2023 02:06:37 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 23
 Oct 2023 02:06:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 23 Oct 2023 02:06:36 -0500
Received: from [172.24.227.36] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39N76YVx017935;
 Mon, 23 Oct 2023 02:06:35 -0500
Message-ID: <303b9e75-31c4-41a3-b96f-762c66cd839f@ti.com>
Date: Mon, 23 Oct 2023 12:36:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] binman: openssl: x509: ti_secure_rom: Add support
 for bootcore_opts
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
CC: <trini@konsulko.com>, <alpernebiyasak@gmail.com>, <u-boot@lists.denx.de>, 
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <a-nandan@ti.com>
References: <20231006100737.343745-1-n-francis@ti.com>
 <20231006100737.343745-2-n-francis@ti.com>
 <CAPnjgZ2RAwdZxZMccwcLL5QLs-HyBcx6B=LLKfVSjSb0qpjGxg@mail.gmail.com>
 <c052dc27-e919-4f62-a104-4412954e7032@ti.com>
 <CAPnjgZ2RvujUiVrhpb-v7Z94JTyP=1e6ptc=mC7A6rVF9NZxdQ@mail.gmail.com>
 <cf363bf1-68ed-4fa9-8ac5-24326f774cac@ti.com>
 <CAPnjgZ0X_DMjaPkxKLHigugPVdj4hnLpsOUuNL9MudJRd4a3_g@mail.gmail.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <CAPnjgZ0X_DMjaPkxKLHigugPVdj4hnLpsOUuNL9MudJRd4a3_g@mail.gmail.com>
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

Hi Simon

On 19/10/23 19:25, Simon Glass wrote:
> Hi Neha,
> 
> On Tue, 17 Oct 2023 at 23:20, Neha Malcom Francis <n-francis@ti.com> wrote:
>>
>> Hi Simon
>>
>> On 18/10/23 09:03, Simon Glass wrote:
>>> Hi Neha,
>>>
>>> On Tue, 17 Oct 2023 at 03:58, Neha Malcom Francis <n-francis@ti.com> wrote:
>>>>
>>>> Hi Simon
>>>>
>>>> On 08/10/23 04:39, Simon Glass wrote:
>>>>> Hi Neha,
>>>>>
>>>>> On Fri, 6 Oct 2023 at 04:07, Neha Malcom Francis <n-francis@ti.com> wrote:
>>>>>>
>>>>>> According to the TRMs of K3 platform of devices, the ROM boot image
>>>>>> format specifies a "Core Options Field" that provides the capability to
>>>>>> set the boot core in lockstep when set to 0 or to split mode when set
>>>>>> to 2. Add support for providing the same from the binman DTS. Also
>>>>>> modify existing test case for ensuring future coverage.
>>>>>>
>>>>>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>>>>>> ---
>>>>>> Link to J721E TRM: https://www.ti.com/lit/zip/spruil1
>>>>>> Section 4.5.4.1 Boot Info
>>>>>>
>>>>>> Changes in v3:
>>>>>>            - updated function comments
>>>>>>            - removed inconsistency in setting bootcore_opts to 32
>>>>>>
>>>>>> Changes in v2:
>>>>>>            - included TRM link in commit message
>>>>>>
>>>>>>     tools/binman/btool/openssl.py           |  6 ++++--
>>>>>>     tools/binman/entries.rst                |  1 +
>>>>>>     tools/binman/etype/ti_secure_rom.py     | 11 +++++++++--
>>>>>>     tools/binman/etype/x509_cert.py         |  3 ++-
>>>>>>     tools/binman/test/297_ti_secure_rom.dts |  1 +
>>>>>>     5 files changed, 17 insertions(+), 5 deletions(-)
>>>>>>
>>>>
>>>> [...]
>>>>
>>>>>> diff --git a/tools/binman/test/297_ti_secure_rom.dts b/tools/binman/test/297_ti_secure_rom.dts
>>>>>> index d1313769f4..1a3eca9425 100644
>>>>>> --- a/tools/binman/test/297_ti_secure_rom.dts
>>>>>> +++ b/tools/binman/test/297_ti_secure_rom.dts
>>>>>> @@ -9,6 +9,7 @@
>>>>>>            binman {
>>>>>>                    ti-secure-rom {
>>>>>>                            content = <&unsecure_binary>;
>>>>>> +                       core-opts = <2>;
>>>>>
>>>>> here ^
>>>>>
>>>>> Do you think there could be a binding file in dt-bindings/ for this value?
>>>>>
>>>>
>>>> Sorry for getting back to this patch so late, but wanted to ask about this. I
>>>> had seen a last version of getting the binman compatible in dt-bindings but I
>>>> don't see it merged. Not sure where I would add this property in.
>>>
>>> Yes it is difficult to do anything genuinely new.
>>>
>>> I am anticipating something like compatible = "ti,secure-rom"
>>>
>>> so I suppose you could create a header file with suitable values for
>>> this property.
>>>
>>> On the other hand, you could wait until there is progress with the bindings.
>>>
>>>
>>
>> I can try adding a header file for now, but follow up question; shouldn't it be
>> added to arch/arm/dts rather than include/dt-bindings? There was traction by DT
>> maintainers to move all such constants not directly used by the driver (in this
>> case binman) to arch/arm/dts? [1] If you mean to use these constants in binman,
>> will need to see how we can do that.
> 
> You can put the constant in the .dtsi and #include your binding file.
> But if you hit problems, let's worry about it later.
> 

I'm a little confused on what has to be done regarding the binding ATM, so I'll 
stick to waiting for some progress with the binman bindings and then tackle it.

>>
>>>>
>>>>>>                    };
>>>>>>                    unsecure_binary: blob-ext {
>>>>>>                            filename = "ti_unsecure.bin";
>>>>>> --
>>>>>> 2.34.1
>>>>>>
>>> Regards,
>>> Simon
>>
>> [1] https://lore.kernel.org/all/c4d53e9c-dac0-8ccc-dc86-faada324beba@linaro.org/
> Regards,
> Simon

-- 
Thanking You
Neha Malcom Francis
