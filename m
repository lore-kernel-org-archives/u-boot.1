Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C808CC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 16:38:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D05E87227;
	Tue,  5 Dec 2023 17:38:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Z2l4gBQh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6430A875C8; Tue,  5 Dec 2023 17:38:37 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07133870F2
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 17:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B5GcUN0005274;
 Tue, 5 Dec 2023 10:38:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701794310;
 bh=6JuhBBhscGOWHlVy1QUgtvZoz7M40WTl3R2VsIGx+po=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Z2l4gBQhLc35ToSUV/4sHMavwMmenNYrwAu/qRqYOXP02VrfquZ6jsSLoo33uTkr4
 uJMCF14em+J3cBiC1BQv1Vfd3HW/a+XHxGSPJLvFgaTJXQBEE6xpBpEO8DK6O5voBr
 gQxEN+qdu1VCiujE27J+AbDcSjz/6VINjEP97p/k=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B5GcUcc109913
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Dec 2023 10:38:30 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Dec 2023 10:38:30 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Dec 2023 10:38:30 -0600
Received: from [10.249.36.163] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B5GcUSj074070;
 Tue, 5 Dec 2023 10:38:30 -0600
Message-ID: <bffaef81-59ef-42e5-9ae4-ba49a33fefbb@ti.com>
Date: Tue, 5 Dec 2023 10:38:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] doc: board: beagle: am62x_beagleplay: Delete SW_PRNG
 flag for OPTEE
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: Dhruva Gole <d-gole@ti.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20231201102954.47582-1-d-gole@ti.com>
 <20231201102954.47582-2-d-gole@ti.com>
 <20231204192940.yfeqv7fewj6izrpk@tightly>
 <9bed6378-56f9-4a76-98a4-3516687a6033@ti.com>
 <20231205152226.krqb3i7s3yo2zsab@extrovert>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20231205152226.krqb3i7s3yo2zsab@extrovert>
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

On 12/5/23 9:22 AM, Nishanth Menon wrote:
> On 08:46-20231205, Andrew Davis wrote:
>> On 12/4/23 1:29 PM, Nishanth Menon wrote:
>>> On 15:59-20231201, Dhruva Gole wrote:
>>>> Delete the flag CFG_WITH_SOFTWARE_PRNG as it's not necessary/ boot
>>>> requirement for this SoC
>>>>
>>>> Signed-off-by: Dhruva Gole <d-gole@ti.com>
>>>> ---
>>>>    doc/board/beagle/am62x_beagleplay.rst | 1 -
>>>>    1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/doc/board/beagle/am62x_beagleplay.rst b/doc/board/beagle/am62x_beagleplay.rst
>>>> index 7784e62b0b71..50d7d3c620d7 100644
>>>> --- a/doc/board/beagle/am62x_beagleplay.rst
>>>> +++ b/doc/board/beagle/am62x_beagleplay.rst
>>>> @@ -63,7 +63,6 @@ Set the variables corresponding to this platform:
>>>>      # we dont use any extra TFA parameters
>>>>      unset TFA_EXTRA_ARGS
>>>>      export OPTEE_PLATFORM=k3-am62x
>>>> -  export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
>>>>    .. include::  ../ti/am62x_sk.rst
>>>>        :start-after: .. am62x_evm_rst_include_start_build_steps
>>>> -- 
>>>> 2.34.1
>>>>
>>> NAK. RNG is needed to seed standard distros.
>>
>> You have this backwards, setting WITH_SOFTWARE_PRNG=y forces the SW
>> RNG, disabling the HW RNG. Without this line the HW RNG is the default.
> 
> 
> That is not the rationale with which the series was posted. I would
> prefer we use HW RNG by default. but as I understand there are a bunch
> of f/w bugs preventing us from doing so. if they are resolved, then the
> commit message argument should be that the bugs are fixed, so we can
> easily use then with f/w version x.y.z onwards.

There was a single FW bug that caused suspend/resume to fail when OP-TEE
was using the HW RNG. The HW RNG always worked, disabling it was a hack
that allowed us to still demo suspend/resume, not sure how that ended up
in this documentation.

The fact we disabled a security feature to workaround a non-security bug
shows a lack of good judgement on our part IMHO. Product security is our
top priority.

Andrew
