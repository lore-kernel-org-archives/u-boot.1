Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9804CC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 04:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1157089115;
	Fri, 26 Apr 2024 06:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714104211;
	bh=FUIxyQ2U9o8GvOD3Zh23jpiHA5uvO+FSsa4LR1uoIr4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mKFgKfyv5ZcpeCezPCmGvcEN4mOZ9D8L7+hL21kdw2h6pratHtUtXLk83ccCaqpFk
	 mxnIAkSdW2yg/vxDt2WohmPq8Xnr1BwSJdqUS5Ql8AQVNEXFkFCt/1niSOEe0kTtyJ
	 cjKHBvxGrcmE8a/zjPf8r/24AdEQtQn3soUEewjD81usAhKtnzYKEsBvKaj4NKWYy6
	 zt3ddffdyKrjv7qP5L9R2KOSaSewNjNSXJ7kV7W4CdtCoVuTP8EfrjMZql2Fooq6Jj
	 +a+1wO7E4S589qy35k1CBNblbUXuXX8WVvly540ms1zUZMb6/R7fvBey+rsZYEdzSQ
	 58v6FME/9NTfg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 136C68911A;
 Fri, 26 Apr 2024 06:03:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714104209;
 bh=FUIxyQ2U9o8GvOD3Zh23jpiHA5uvO+FSsa4LR1uoIr4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=T3P9rJqUo9Y5WOGGB7te1HrwRHnheAvyaSXIg3JkTmkI3ouFv1qXPb+01Bn8rkBum
 Z9DilCAxxB/Rt6CexHwca+YWZUkr2s/c+fkXaiVAgRfJbLnRTdoSqOlCaMym+v0k76
 1Dcab2AUHfpCp3XVQXcpK2anqL/t+4BSnepgXlepQ4fmj8NTwMS+WCP5TIuysd8G4z
 h6BNap62O3aU9BIngFzgzWNty/5J7vVBBXOc3E2dsUfINGZJr6FrZy3L2T1T9geEtp
 6j6XkKk0G2hJor+qzLLBhndj9SwizleMmsM8+xEOunx9jFgeWXoEFoU48HXqPqejZT
 KGu+uuIEmgxXw==
Message-ID: <94a75eb9-950c-41f0-b9fc-c7d95ecec6c6@denx.de>
Date: Fri, 26 Apr 2024 06:03:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] crypto/fsl: Introduce SPL_FSL_CAAM_RNG
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Angelo Dureghello <angelo@kernel-space.org>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek
 <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20240425230314.497203-1-marex@denx.de>
 <20240425230314.497203-2-marex@denx.de>
 <CAJ+vNU3ndKTXr5XBOd9b2aQF7WmBPARJ70Fsuab1rmnaQsEZiQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAJ+vNU3ndKTXr5XBOd9b2aQF7WmBPARJ70Fsuab1rmnaQsEZiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 4/26/24 2:16 AM, Tim Harvey wrote:

>> diff --git a/drivers/crypto/fsl/Makefile b/drivers/crypto/fsl/Makefile
>> index 7a2543e16cc..4fbce519a0b 100644
>> --- a/drivers/crypto/fsl/Makefile
>> +++ b/drivers/crypto/fsl/Makefile
>> @@ -6,6 +6,6 @@ obj-y += sec.o
>>   obj-$(CONFIG_FSL_CAAM) += jr.o fsl_hash.o jobdesc.o error.o
>>   obj-$(CONFIG_CMD_BLOB)$(CONFIG_IMX_CAAM_DEK_ENCAP) += fsl_blob.o
>>   obj-$(CONFIG_RSA_FREESCALE_EXP) += fsl_rsa.o
>> -obj-$(CONFIG_FSL_CAAM_RNG) += rng.o
>> +obj-$(CONFIG_$(SPL_TPL_)FSL_CAAM_RNG) += rng.o
>>   obj-$(CONFIG_FSL_DCP_RNG) += dcp_rng.o
>>   obj-$(CONFIG_FSL_MFGPROT) += fsl_mfgprot.o
>> --
>> 2.43.0
>>
> 
> Marek,

Hi,

> Thanks - this series does solve the issue I am seeing in the SPL when
> enabling DM_RNG. Is this going to cause an issue for people who expect
> it to be currently enabled and now have to manually enable it?

That's a good question. If I do '$ git grep FSL_CAAM_RNG' , there seem 
to be no users, so I don't think we need to worry here, right ?

With SPL_DM_RNG i.e. 1/3 I am a bit more concerned. But, looking at the 
users that enable DM_RNG, I am not seeing any obvious ones that would 
require SPL_DM_RNG too. What do you think ?
