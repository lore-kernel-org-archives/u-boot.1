Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A98C369D5
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 10:36:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4D9C82063;
	Fri, 25 Apr 2025 12:35:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Cyz2/UXF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BBC381F6B; Fri, 25 Apr 2025 12:35:57 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2A0F81F0D
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 12:35:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53PAZi4U2151663
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 05:35:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745577344;
 bh=SwcdZVs4l0SBvbInBQmOOPQRN6vxL5UxFO6yZFSpdbQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Cyz2/UXFQby5FJ1Ejnx7ZJIDYOWyn/bqTPdTFzNvoMaWC8ClZjNkftYf2Qn4SMnep
 B1g6/2+ErBBHCPRQjbKU8Je3+PGvib2RQBYfV4ab88xepxZRAvo7AOzq9y6zjbwInm
 Ht1H6bjVjpsiwT/7FJPDnQS4gh4QA05PCJLPE7ew=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53PAZiE1083969
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Apr 2025 05:35:44 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Apr 2025 05:35:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Apr 2025 05:35:43 -0500
Received: from [172.24.19.195] (lt5cd2489kgj.dhcp.ti.com [172.24.19.195])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53PAZeB6032526;
 Fri, 25 Apr 2025 05:35:41 -0500
Message-ID: <d95b1919-ea47-4d58-8349-82e0f33fed5a@ti.com>
Date: Fri, 25 Apr 2025 16:05:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Expected behavior of the go command
To: Ahmad Fatoum <a.fatoum@pengutronix.de>, Simon Glass <sjg@chromium.org>,
 Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <rick@andestech.com>,
 <mporter@konsulko.com>, <u-kumar1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>
References: <D9DXL95MTQ8I.3EUY0C6M2L4NE@ti.com>
 <CAFLszTg72Ai2V-L3MKvqDx8ROk97jiW4bvAbvFtZEAFBBp6qfQ@mail.gmail.com>
 <ad4a911f-681a-4fea-b79c-8489b47d7360@pengutronix.de>
 <5934ae86-16e8-4c97-afd6-d812fc0c5f7f@ti.com>
 <5f87ac88-5552-4c5c-ae56-01c7ef9165dd@pengutronix.de>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <5f87ac88-5552-4c5c-ae56-01c7ef9165dd@pengutronix.de>
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

Thanks Ahmad

On 4/25/2025 11:09 AM, Ahmad Fatoum wrote:
> Hi Udit,
>
> On 25.04.25 06:35, Kumar, Udit wrote:
>> On 4/23/2025 7:52 PM, Ahmad Fatoum wrote:
>>> I went with the FIT route for barebox, because we can now ship device
>>> trees for all enabled boards in the same FIT image alongside one generic
>>> second stage barebox with DT support. If you want to support different
>>> boards with your OS image that might be of interest to you as well.
>> Sorry for novice question.
>>
>> But trying to understand how FIT fixes problem for you .
>>
>> at the end, its a jump command to OS/other code be it through u-boot go or fit way.
> The difference is whether, prior to the jump, the caches are flushed and the MMU
> is disabled and U-Boot's go does neither.
>
> Thinking about it, I am wondering whether U-Boot go is inherently broken,
> even for the jump-table use case, if caches are enabled:

Correct, this is what I think . Before jumping to new program go command 
should make sure

things are in correct order by cache flush. Kind of below

diff --git a/cmd/boot.c b/cmd/boot.c
index 23496cafdf5..e6bb1d94a1c 100644
--- a/cmd/boot.c
+++ b/cmd/boot.c
@@ -18,6 +18,7 @@ __attribute__((weak))
  unsigned long do_go_exec(ulong (*entry)(int, char * const []), int argc,
                                  char *const argv[])
  {
+       flush_cache(...)
         return entry (argc, argv);
  }


I see even ARM64, few board choose to over-ride default option 
(board/xilinx/versal/board.c)

do_go_exec does dcache_disable()



> Because go doesn't do any cache maintenance, what guarantee do we have
> that the I-Cache actually reflects the data that was freshly loaded?

correct , depends upon address etc , it may or may not work


> It might only work because the region you go to happens to not be resident
> in the I-Cache yet...
>
> FWIW, barebox go does cache maintenance and disables the MMU, which
> is why I mistakenly thought U-Boot's go would behave similarly.
> barebox didn't inherit the jump table mechanism.
>
>> In case OS/other code handles caches, then should not be an issue.
>> But this put requirement on next stage to take care of caches [0]
> In the fit case, MMU is disabled and so the next stage is free to
> not do any cache maintenance if it doesn't need to enable the MMU.
> Linux and barebox want to use the MMU/caches by default, so that's
> why they have to do cache maintenance.

Sorry I was not clear in previous message,

Here OS take care of caching , irrespective of how boot is done through fit

or kind of efi or other method.


> If they assume MMU is disabled on startup, it follows the lines in
> the cache are stale and unimportant and then memory corruption
> occurs once they are discarded.
>
> Cheers,
> Ahmad
>
>>
>> [0] : https://github.com/torvalds/linux/blob/master/arch/arm64/kernel/head.S#L105
>>
>>
>>> Cheers,
>>> Ahmad
>>>
>>>> Regards,
>>>> Simon
>>>>
>
