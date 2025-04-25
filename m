Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9B8C369D1
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 04:35:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C80CE809D4;
	Fri, 25 Apr 2025 06:35:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dGjEJXp3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18EB1810EB; Fri, 25 Apr 2025 06:35:23 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53AA58059A
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 06:35:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53P4ZBKQ2038096
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Apr 2025 23:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745555711;
 bh=cyBiVuFb4CMYHY1nsTSTOl6uja9bUOml6Cx7U2Bqx0c=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=dGjEJXp3JNX3AQn4QnnfoowmV1tGGTBPw+pPzoZLboKjLQMhAKV3ghXvHxfvhCfnJ
 ySmudS/xXebOK3xibRF8P8GVkqAzXwXs//n6wDZ19CLwUgMpilk64QfY63ay6lqawN
 N1zZ1HCd8enOIp0sRqw5mpvTbKOr+L9CGNq+ZsH4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53P4ZBQT108015
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Apr 2025 23:35:11 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Apr 2025 23:35:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Apr 2025 23:35:11 -0500
Received: from [172.24.19.195] (lt5cd2489kgj.dhcp.ti.com [172.24.19.195])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53P4Z7KL109035;
 Thu, 24 Apr 2025 23:35:08 -0500
Message-ID: <5934ae86-16e8-4c97-afd6-d812fc0c5f7f@ti.com>
Date: Fri, 25 Apr 2025 10:05:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Expected behavior of the go command
To: Ahmad Fatoum <a.fatoum@pengutronix.de>, Simon Glass <sjg@chromium.org>,
 Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <rick@andestech.com>,
 <mporter@konsulko.com>, <u-kumar1@ti.com>
References: <D9DXL95MTQ8I.3EUY0C6M2L4NE@ti.com>
 <CAFLszTg72Ai2V-L3MKvqDx8ROk97jiW4bvAbvFtZEAFBBp6qfQ@mail.gmail.com>
 <ad4a911f-681a-4fea-b79c-8489b47d7360@pengutronix.de>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <ad4a911f-681a-4fea-b79c-8489b47d7360@pengutronix.de>
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


On 4/23/2025 7:52 PM, Ahmad Fatoum wrote:
> Hi,
>
> On 4/23/25 14:28, Simon Glass wrote:
>> Hi Anshul,
>>
>> On Wed, 23 Apr 2025 at 04:04, Anshul Dalal <anshuld@ti.com> wrote:
>>> Hi all,
>>>
>>> I was trying to understand how the go command is expected to work when
>>> used to load custom OSes. My use case requires getting a proprietary OS
>>> to boot using the go command on a TI K3 platform. The OS expects caches
>>> to be flushed and the mmu to be disabled before we jump to it.
>>>
>>> The go command (do_go func in cmd/boot.c) calls the do_go_exec function
>>> underneath which does not seem to have a consistent implementation
>>> across various architectures.
>>>
>>> In RISC-V the implementation (arch/riscv/lib/boot.c:10) calls
>>> cleanup_before_linux before jumping to the loaded binary. This behaviour
>>> would enable the direct use of the go command for booting a custom OS
>>> (like in my use case). Though no such generic implementation exists for
>>> ARM64.
>>>
>>> I was wondering why we have the call to cleanup_before_linux for RISCV
>>> and not ARM64?
>>>
>>> Also, is booting a custom OS using the go command a supported use-case?
>>> If yes, it might be better to rename the function to be more generic
>>> like cleanup_before_os from *_linux and call it for each invocation of
>>> the go command.
>> Yes it is supposed to do what you say. You could rationalise the code
>> a bit, so that all archs do a similar thing, or perhaps just RISC-V
>> and ARM for now.
> I ran into issues with go too trying to start barebox and I always
> assumed that go is rather meant to start programs that call back into
> U-Boot using the jump table mechanism. In that case, you likely don't
> want to turn off caches.
>
> What I settled on is having the barebox build generate a FIT image that
> can be used from U-Boot, barebox, coreboot ...etc.
>
> Maybe the same would be also suitable for you? Alternatively, you could
> compile your custom OS as an ELF image and boot that properly as if it
> were a kernel. Both ways would also allow you to specify a load address
> if your OS is not relocatable and pass along arguments.
>
> I went with the FIT route for barebox, because we can now ship device
> trees for all enabled boards in the same FIT image alongside one generic
> second stage barebox with DT support. If you want to support different
> boards with your OS image that might be of interest to you as well.

Sorry for novice question.

But trying to understand how FIT fixes problem for you .

at the end, its a jump command to OS/other code be it through u-boot go 
or fit way.


In case OS/other code handles caches, then should not be an issue. But 
this put requirement on next stage to take care of caches [0]


[0] : 
https://github.com/torvalds/linux/blob/master/arch/arm64/kernel/head.S#L105


>
> Cheers,
> Ahmad
>
>> Regards,
>> Simon
>>
