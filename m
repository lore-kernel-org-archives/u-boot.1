Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA26CF31BF
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 05:48:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE38989147;
	Thu,  3 Oct 2024 07:47:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SgCxtGPT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57559890EB; Thu,  3 Oct 2024 07:47:58 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D42F58914E
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 07:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vaishnav.a@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4935ln7P110082;
 Thu, 3 Oct 2024 00:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1727934469;
 bh=S+n1id8yI7w5EkWtuui5xiblNqCvYLHzsb2FgU5B4y0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=SgCxtGPTv4HhAYEIXriVmEPR/37NuqIcq0+GrLBf2uIYmgSElmMVBNaR4B3oXs8qK
 3JqT8dVXu0yrr8QgLnK2Vev4fTnDrAZEXUpvF5mD3/Nj2pxQniAHQajyxM2DqokSNb
 vqsrgJrfBtpPkpUGViZxAfpxjmTtO5RyrV59Qe90=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4935ln17021763
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 3 Oct 2024 00:47:49 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Oct 2024 00:47:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Oct 2024 00:47:49 -0500
Received: from [10.24.69.142] ([10.24.69.142])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4935lk8j062946;
 Thu, 3 Oct 2024 00:47:47 -0500
Message-ID: <f54cfd49-2fdd-46a1-ab21-07e8fd5d95e7@ti.com>
Date: Thu, 3 Oct 2024 11:17:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] lmb: rework logic to validate load address for
 network commands
To: Sughosh Ganu <sughosh.ganu@linaro.org>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Ramon Fried
 <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, Praneeth
 Bajjuri <praneeth@ti.com>, "Kumar, Udit" <u-kumar1@ti.com>
References: <20240916152025.75789-1-sughosh.ganu@linaro.org>
 <172688637179.2451825.4736403690225486599.b4-ty@konsulko.com>
 <d08bf82d-b26b-4cc5-8448-229f001fc0a6@ti.com>
 <CADg8p96pCAudQ5mECN3JJA_LP4PdV5ct2wDwHRZUv3twm-iHwA@mail.gmail.com>
Content-Language: en-US
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <CADg8p96pCAudQ5mECN3JJA_LP4PdV5ct2wDwHRZUv3twm-iHwA@mail.gmail.com>
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

Hi Sughosh, Tom,

On 01/10/24 14:19, Sughosh Ganu wrote:
> On Tue, 1 Oct 2024 at 11:37, Vaishnav Achath <vaishnav.a@ti.com> wrote:
>>
>> Hi Tom,
>>
>> On 21/09/24 08:09, Tom Rini wrote:
>>> On Mon, 16 Sep 2024 20:50:23 +0530, Sughosh Ganu wrote:
>>>
>>>> Rework the logic to verify the load address so that address re-use is
>>>> not an issue.
>>>>
>>>>
>>>> Note: To be applied on next, on top of
>>>> https://patchwork.ozlabs.org/project/uboot/patch/20240913073251.2286529-2-prasad.kummari@amd.com/
>>>>
>>>> [...]
>>>
>>> Applied to u-boot/next, thanks!
>>
>> Can these fixes be applied to master also as the failures are seen now
>> in master as well?
> 
> The lmb patch series has not made it to master yet. How are you seeing
> these issues on the master branch when the lmb scope is local ?
> 
> -sughosh
> 

Sorry this was a confusion from my end, please ignore my previous 
comment, master does not have any issue related to this.

Thanks and Regards,
Vaishnav

>>
>> Thanks and Regards,
>> Vaishnav
>>
>>>
