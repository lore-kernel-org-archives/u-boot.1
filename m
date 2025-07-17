Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC1BC83F1B
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 07:00:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ED5B83394;
	Thu, 17 Jul 2025 09:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XUeX4Tqt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 265A08338D; Thu, 17 Jul 2025 08:03:31 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDE9C83314
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 08:03:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=g-praveen@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56H63MVA2667494;
 Thu, 17 Jul 2025 01:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752732202;
 bh=i3Sz+64Xe7KDGH+23D8sF97WdunooGq6dUkJE2U9alw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=XUeX4Tqtzi2HGeTAyPZo9qpcUCTDxNB2Kxb9T4gdA4ImOodQnWHnPcyubbhOp5O1Q
 nqebHl4RHfYn70p13BBsQRBuUENhZ3b1TD93dPNXbkagdaSafHy5CatH8sHRGHV1Oo
 xo/Rg2msIaqeRh5L5wFRqNPc4OiiCF6Cn6W4jD0o=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56H63Mqa2581791
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 17 Jul 2025 01:03:22 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 17
 Jul 2025 01:03:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 17 Jul 2025 01:03:22 -0500
Received: from [10.24.69.200]
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56H63JRk1671780;
 Thu, 17 Jul 2025 01:03:19 -0500
Message-ID: <b4fc5581-09f5-4969-aa34-738ef3a88842@ti.com>
Date: Thu, 17 Jul 2025 11:33:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configs: KASLR OPTEE RNG support for K3 devices
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Bryan Brattlof <bb@ti.com>, <trini@konsulko.com>,
 <rayagonda.kokatanur@broadcom.com>, <casey.connolly@linaro.org>,
 <sjg@chromium.org>, <u-boot@lists.denx.de>, <j-keerthy@ti.com>,
 Gokul Praveen <g-praveen@ti.com>
References: <20250710095922.144361-1-g-praveen@ti.com>
 <20250710141718.fx7cqeh2f2eibwkm@bryanbrattlof.com>
 <51e00bdb-374a-4e35-a230-58427aeaead7@ti.com>
 <20250711121741.jyo6gonfhoswbxvb@bryanbrattlof.com>
 <8b8a0e73-39e5-436e-8458-9bc511daa880@ti.com>
 <20250717041745.bcxjwlkg7y3yjojm@uda0497581-HP>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <20250717041745.bcxjwlkg7y3yjojm@uda0497581-HP>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Thu, 17 Jul 2025 09:00:07 +0200
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

Thank you Manorit and Bryan.

On 17/07/25 09:47, Manorit Chawdhry wrote:
> Hi Gokul,
> 
> On 18:17-20250716, Gokul Praveen wrote:
>> Hi Bryan,
>>
>> On 11/07/25 17:47, Bryan Brattlof wrote:
>>> On July 11, 2025 thus sayeth Gokul Praveen:
>>>> Hi Bryan,
>>>>
>>>> On 10/07/25 19:47, Bryan Brattlof wrote:
>>>>> On July 10, 2025 thus sayeth Gokul:
>>>>>> From: Gokul Praveen <g-praveen@ti.com>
>>>>>>
>>>>>> KASLR, or Kernel Address Space Layout Randomization, is a security
>>>>>> feature in the Linux kernel that randomizes the memory location
>>>>>> where the kernel is loaded during boot.
>>>>>>
>>>>>> OP-TEE RNG is a Random Number Generator (RNG) component within the
>>>>>> Open Portable Trusted Execution Environment (OP-TEE) which provides
>>>>>> a random number to U-BOOT and U-BOOT provides this random number
>>>>>> as seed value to the LINUX kernel for KASLR.
>>>>>>
>>>>>> Add KASLR OPTEE RNG support across K3 devices by enabling the required
>>>>>> configs.
>>>>>>
>>>>>> Signed-off-by: Gokul Praveen <g-praveen@ti.com>
>>>>>> ---
>>>>>> v2<==> v1
>>>>>> ===========
>>>>>> * Added 'if' condition for configs to avoid enabling this feature
>>>>>>      in R5.
>>>>>
>>>>> Works for me.
>>>>>
>>>>> Reviewed-by: Bryan Brattlof <bb@ti.com>
>>>>>
>>>>>>
>>>>>> Boot logs Link :
>>>>>>
>>>>>> https://gist.github.com/GokulPraveen2001/44aa8c0962438c12ffc55e6ed67742e5
>>>>>
>>>>> Just curious are you enabling the kaslrseed command for this build? It
>>>>> looks like you're using TI's evil vendor scripts but I assumed the
>>>>> kaslrseed command was disabled.
>>>>
>>>> Can you elaborate more on this,Bryan?
>>>>
>>>> Actually, we are not using the kaslrseed device tree property. Is that what
>>>> you meant,Bryan?
>>>
>>> Everything in this boot log is tagged as dirty. So I'm just trying to
>>> ensure I've got everything setup correctly.
>>>
>>> I was curious what you are doing to generate the line:
>>>
>>>      KASLR SEED OPTEE SET SUCCESSFULLY
>>>
>>> before we jump to the kernel.
>>
>> I have also updated the boot logs in the gist link provided to the one
>> without debug prints and without the dirty tag as well, Bryan.
>>
> 
> Thanks for the update, giving my r-by again as well as I think you did
> some changes.
> 
> Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>
> 
> Regards,
> Manorit
> 
>> Regards
>> Gokul

Regards
Gokul
