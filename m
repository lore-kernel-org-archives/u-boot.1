Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A36C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 16:09:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2F0281026;
	Tue, 18 Mar 2025 17:09:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="yxtJXK/2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED458810F4; Tue, 18 Mar 2025 17:09:08 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC541800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 17:09:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-vm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52IG92c62632832
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Mar 2025 11:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742314142;
 bh=c1LhO+m+KiV6Za+MUpDSie1t1u8YnJaIvTditCXeGj0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=yxtJXK/2DzNu82yOHC2Ya2gwP1ky7oxudMEG6pA6L02Qj31km2k+FFG45qCxBImMG
 EHhrV81v9INb2cIzstnfGVmB5Y9Xd1M8kOrethC4hU4IgK5J5+To7LWpH4tajRmDgk
 AJVM4Dfq9lYQ2xHNJ/NOke70l5PselQ5fimn5Qk4=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52IG92nQ041773
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 18 Mar 2025 11:09:02 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Mar 2025 11:09:02 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Mar 2025 11:09:02 -0500
Received: from [10.24.69.179] ([10.24.69.179])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52IG90M7042632;
 Tue, 18 Mar 2025 11:09:00 -0500
Message-ID: <e78678b0-3f56-831f-fda7-eac3a0eae31b@ti.com>
Date: Tue, 18 Mar 2025 21:38:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXTERNAL] Re: [RFC PATCH v3 1/5] cmd: fuse: Remove custom string
 functions
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>
References: <20250318105047.256022-1-h-vm@ti.com>
 <20250318105047.256022-2-h-vm@ti.com> <20250318140932.GY2640854@bill-the-cat>
From: Harsha Vardhan V M <h-vm@ti.com>
In-Reply-To: <20250318140932.GY2640854@bill-the-cat>
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



On 18/03/25 19:39, Tom Rini wrote:
> On Tue, Mar 18, 2025 at 04:20:43PM +0530, Harsha Vardhan V M wrote:
> 
>> Remove custom string functions and replace them with normal string
>> functions. Remove the custom strtou32 and replace it with
>> simple_strtoul.
>>
>> Signed-off-by: Harsha Vardhan V M <h-vm@ti.com>
> [snip]
>> @@ -54,14 +43,18 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
>>   	argc -= 2 + confirmed;
>>   	argv += 2 + confirmed;
>>   
>> -	if (argc < 2 || strtou32(argv[0], 0, &bank) ||
>> -			strtou32(argv[1], 0, &word))
>> +	if (argc < 2)
>>   		return CMD_RET_USAGE;
>>   
>> +	bank = (u32)simple_strtoul(argv[0], NULL, 0);
> 
> Do we really need these casts?
> 

Not really, Just added them to make it explicit.
I can remove the casts if that's preferred.

Thanks,
Harsha
