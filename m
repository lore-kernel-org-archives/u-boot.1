Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2797E7716D
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 03:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C25E389265;
	Thu,  5 Dec 2024 04:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jcerGiAh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CE7489335; Thu,  5 Dec 2024 04:40:55 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78CFC89241
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 04:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B53emkh1699979
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Dec 2024 21:40:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733370048;
 bh=jlPNcU5Ev5+XvNDlGtpcEnT8dTmKEoHRiKeiG6uYovY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=jcerGiAhjp2frJ/ZAk/loU2LVb7t9TKci5nKrM7GfQj7bRqA7fNNsXxjA+BL2XrAL
 9++kfXG/EMR0DGdfCzgIPJoDJu3hQqBTO0Cp97QEptan6G3hNeLkyfCQ6YNAHwluv3
 DhJRgwXzI0g5/LU2KF3+HATKsvt2eD0PatwOrAZE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B53emo4068432
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 4 Dec 2024 21:40:48 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Dec 2024 21:40:47 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Dec 2024 21:40:48 -0600
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B53eiLD007517;
 Wed, 4 Dec 2024 21:40:45 -0600
Message-ID: <53b41c46-19eb-4174-9f6b-6febfb7e8439@ti.com>
Date: Thu, 5 Dec 2024 09:10:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] ufs: core: initial cleanup and defines sync with
 Linux v6.12
To: <neil.armstrong@linaro.org>, Bhupesh Sharma <bhupesh.linux@gmail.com>
CC: <michal.simek@amd.com>, <marek.vasut+renesas@mailbox.org>,
 <bmeng.cn@gmail.com>, <venkatesh.abbarapu@amd.com>,
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
References: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
 <2015391d-5196-4860-817f-a7ef317b980c@linaro.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <2015391d-5196-4860-817f-a7ef317b980c@linaro.org>
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

Hi Neil

On 04/12/24 17:59, Neil Armstrong wrote:
> Hi,
> 
> On 20/11/2024 10:22, Neil Armstrong wrote:
>> This serie fixes the build and checkpatch warnings, and
>> does a split of the ufs.h into a separate ufshci.h which
>> helps syndhronizing the defines from Linux v6.12.
>>
>> No functional changes intended, tests on hardware
>> are welcome.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> Neil Armstrong (6):
>>        ufs: core: include missing include/ufs.h
>>        ufs: core: mark unexported functions as static
>>        ufs: core: cosmetic fixups
>>        ufs: core: move ufshci defines in a separate header
>>        ufs: core: sync unipro.h with Linux v6.12
>>        ufs: core: sync ufshci.h with Linux v6.12
> 
> Gentle ping, could you have a quick look ?
> 

Thanks for the ping, will take a look at it today.

> Thanks,
> Neil
> 
>>
>>   drivers/ufs/ufs.c    |  43 +++--
>>   drivers/ufs/ufs.h    | 335 +-----------------------------------
>>   drivers/ufs/ufshci.h | 469 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/ufs/unipro.h | 128 ++++++++------
>>   4 files changed, 571 insertions(+), 404 deletions(-)
>> ---
>> base-commit: dc1859f8d2ac3faaa5e2e1d465ec4bd8980520a5
>> change-id: 20241120-topic-ufs-cleanup-23671e3fc9e9
>>
>> Best regards,
> 

-- 
Thanking You
Neha Malcom Francis
