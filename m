Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F625D3C537
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 04:51:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AB5F89214;
	Fri, 18 Oct 2024 06:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DVLGqlWS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C543789229; Fri, 18 Oct 2024 06:51:52 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D719891A4
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 06:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49I4plbt102374;
 Thu, 17 Oct 2024 23:51:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729227107;
 bh=mBAcVXcEfJW0UUzGZw8Ct4hblaUDx8teOyu4/TUKCNc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=DVLGqlWSNDO58d5mFgxDlxr7Iypdd8Db44tNPZtCqkYcXt2BTp00992+pKwjijMKF
 OEPpDYD7vQ1YekAuzBx7mUF/7lcLQLPlYr7n0HXXbFZ5YL7MgNxK1+VR+6u1T7TCyy
 Inc6ay11o69r6Dt9max0byc+CmgE06RNEEHw8584=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49I4plcS021174
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Oct 2024 23:51:47 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Oct 2024 23:51:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Oct 2024 23:51:47 -0500
Received: from [172.24.227.91] (psdkl-workstation0.dhcp.ti.com [172.24.227.91])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49I4pjM0065977;
 Thu, 17 Oct 2024 23:51:45 -0500
Message-ID: <1edf9e5d-f66e-4e8f-ba34-a06cd309dc9c@ti.com>
Date: Fri, 18 Oct 2024 10:21:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] DONOTMERGE: For testing only
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <reidt@ti.com>,
 <m-chawdhry@ti.com>, <nm@ti.com>
References: <20241017062911.2241167-1-a-limaye@ti.com>
 <20241017062911.2241167-7-a-limaye@ti.com>
 <20241017175448.GO4959@bill-the-cat>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <20241017175448.GO4959@bill-the-cat>
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



On 17/10/24 23:24, Tom Rini wrote:
> On Thu, Oct 17, 2024 at 11:59:13AM +0530, Aniket Limaye wrote:
> 
>> From: Reid Tonking <reidt@ti.com>
>>
>> This just provides some useful print outs and the proper config to
>> test the functionality. For J7200 boards that do not have efuse
>> burned in, the hardcoded 760000 is needed in the vd_data, since
>> it would be populated otherwise
>>
>> Signed-off-by: Reid Tonking <reidt@ti.com>
>> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> 
> I can usually remember to use "b4 shazam -P ..." to omit these patches,
> but it's generally best to not include them and either mark the whole
> series as RFC instead if anyone else is likely to use them, thanks.
> 

That makes sense. Got it, will remember to do that in the future.

Thanks,
Aniket

