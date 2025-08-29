Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE20CA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 15:22:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93DC483695;
	Fri, 29 Aug 2025 17:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="zQNDPbyk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25C0483695; Fri, 29 Aug 2025 17:22:49 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9782D83689
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 17:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57TFMikR1780810;
 Fri, 29 Aug 2025 10:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756480964;
 bh=gRAnr/h/7zCL8I5xEEcoDtjsNAMBZ++53IqtB23O/hg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=zQNDPbykc5pvn+4vgXtpOz9gpMH+Azdx8RCLcqyhXdIYfNzVer+cyQcU0ZFsXXw/e
 LYbrT2l5FqPKZ4DF3cm2mjltPGTjdZ11jRiMDKCnVTrP776b7EeP/ka6kFrh9zUGEz
 p9d1+u0DfzNqcz6+IMv4YCijcBawJijWBqXTmpWc=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57TFMiuW3737161
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 29 Aug 2025 10:22:44 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 29
 Aug 2025 10:22:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 29 Aug 2025 10:22:44 -0500
Received: from [10.249.139.51] ([10.249.139.51])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57TFMet32546339;
 Fri, 29 Aug 2025 10:22:41 -0500
Message-ID: <105705f8-48ca-45ba-af34-b3955df29279@ti.com>
Date: Fri, 29 Aug 2025 20:52:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] Revert "remoteproc: Tighten some remoteproc driver
 dependencies"
To: Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>,
 <jm@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20250829053451.3615976-1-b-padhi@ti.com>
 <20250829053451.3615976-2-b-padhi@ti.com>
 <2937fb1b-1f40-4edc-af4a-e02946b5bf8f@ti.com>
 <20250829145652.GV124814@bill-the-cat>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <20250829145652.GV124814@bill-the-cat>
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

Hi Tom, Andrew,

On 8/29/2025 8:26 PM, Tom Rini wrote:
> On Fri, Aug 29, 2025 at 09:32:00AM -0500, Andrew Davis wrote:
>> On 8/29/25 12:34 AM, Beleswar Padhi wrote:
>>> This reverts commit 548ae9d1a537464254afac63f802179a24c645d6.
>>>
>>> The IPU remote processor is only present in TI OMAP SoCs. Remove the
>>> ARCH_K3 dependency from Kconfig. This driver builds just fine without
>>> ARCH_K3 config.
>>>
>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>> ---
>>>    drivers/remoteproc/Kconfig | 1 -
>>>    1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>>> index e9f19a69433..a3ecea05e20 100644
>>> --- a/drivers/remoteproc/Kconfig
>>> +++ b/drivers/remoteproc/Kconfig
>>> @@ -125,7 +125,6 @@ config REMOTEPROC_TI_PRU
>>>    config REMOTEPROC_TI_IPU
>>>    	bool "Support for TI's K3 based IPU remoteproc driver"
>>>    	select REMOTEPROC
>>> -	depends on ARCH_K3
>> The original commit seems to indicate there are some platforms
>> were this does not build, maybe depend on ARCH_OMAP2PLUS
> Yes, it fails to build on sandbox. If REMOTEPROC_TI_IPU only supports
> OMAP SoCs and not K3 SoCs then the prompt text, and perhaps help text
> (not in this patch context so I can't see) need to be fixed.


Thanks, got it. This should depend on ARCH_OMAP2PLUS then. Will address
in revision.

Thanks,
Beleswar

> The driver
> isn't enabled anywhere today, so I don't know that it even compiles,
> actually. So it should probably get enabled somewhere, too.
>
