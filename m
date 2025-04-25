Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BD3C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 12:43:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AFDC82012;
	Fri, 25 Apr 2025 14:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UdoIoZb1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5B5682045; Fri, 25 Apr 2025 14:43:35 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55C7581E14
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 14:43:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53PChASV2793954
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 07:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745584990;
 bh=87rgHRZxiI/ZlZePxxqJmbFyPe9MihN12dl2or5lLwY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=UdoIoZb1nfLcpGKDY56f9vSRXu1Ik50pqW6TTY/2kKGY7bwtIxD3puyPaCcEoB49L
 t0BiQdo2ROGAH5oIoCrFW9hYKdEt1b1iaJiGNlGZ7/5YGx9biUGoPfsh2TcT76PBER
 2xojhOH0lPET8/YB5O58DDhmvuouh2MsHn4V9+FM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53PChAHW004389
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Apr 2025 07:43:10 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Apr 2025 07:43:10 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Apr 2025 07:43:10 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53PCh7Un027462;
 Fri, 25 Apr 2025 07:43:07 -0500
Message-ID: <a8a5642a-d9cc-4918-8674-0a3285954695@ti.com>
Date: Fri, 25 Apr 2025 18:13:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Expected behavior of the go command
To: Ahmad Fatoum <a.fatoum@pengutronix.de>, Simon Glass <sjg@chromium.org>,
 Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <rick@andestech.com>,
 <mporter@konsulko.com>, Neha Malcom Francis <n-francis@ti.com>,
 <u-kumar1@ti.com>
References: <D9DXL95MTQ8I.3EUY0C6M2L4NE@ti.com>
 <CAFLszTg72Ai2V-L3MKvqDx8ROk97jiW4bvAbvFtZEAFBBp6qfQ@mail.gmail.com>
 <ad4a911f-681a-4fea-b79c-8489b47d7360@pengutronix.de>
 <5934ae86-16e8-4c97-afd6-d812fc0c5f7f@ti.com>
 <5f87ac88-5552-4c5c-ae56-01c7ef9165dd@pengutronix.de>
 <d95b1919-ea47-4d58-8349-82e0f33fed5a@ti.com>
 <842f0cba-b43e-4514-8a15-9b4c87a08104@pengutronix.de>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <842f0cba-b43e-4514-8a15-9b4c87a08104@pengutronix.de>
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

Hi Ahmad

On 4/25/2025 4:28 PM, Ahmad Fatoum wrote:
> Hi Udit,
>
> On 4/25/25 12:35, Kumar, Udit wrote:
>> On 4/25/2025 11:09 AM, Ahmad Fatoum wrote:
>>> Thinking about it, I am wondering whether U-Boot go is inherently broken,
>>> even for the jump-table use case, if caches are enabled:
>> Correct, this is what I think . Before jumping to new program go command
>> should make sure
>>
>> things are in correct order by cache flush. Kind of below
>>
>> diff --git a/cmd/boot.c b/cmd/boot.c
>> index 23496cafdf5..e6bb1d94a1c 100644
>> --- a/cmd/boot.c
>> +++ b/cmd/boot.c
>> @@ -18,6 +18,7 @@ __attribute__((weak))
>>   unsigned long do_go_exec(ulong (*entry)(int, char * const []), int argc,
>>                                   char *const argv[])
>>   {
>> +       flush_cache(...)
> yes, even with MMU left enabled, it looks like there should be an
> I-Cache invalidate and D-Cache flush/clean here[1].

Yes, correct . This should be extended with above

>
>> I see even ARM64, few board choose to over-ride default option (board/
>> xilinx/versal/board.c)
>>
>> do_go_exec does dcache_disable()
> I think __weak is a fundamental mistake and upstream boards abusing it
> to not have to fix things generally shows that.
>
>> Sorry I was not clear in previous message,
>>
>> Here OS take care of caching , irrespective of how boot is done through fit
> Yes, but with the assumption that MMU was disabled at start.
>
>> or kind of efi or other method.
> Interestingly, with EFI MMU should be left enabled. Linux even
> warns about the case that MMU was disabled when entering the stub.
>
> Cheers,
> Ahmad
>
