Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B53C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 08:27:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 391D48854A;
	Thu, 27 Jun 2024 10:27:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA062884F1; Thu, 27 Jun 2024 10:27:09 +0200 (CEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA4D1880A5;
 Thu, 27 Jun 2024 10:27:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4W8sB3336bz9vDc;
 Thu, 27 Jun 2024 10:27:07 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 55l0N00L8XJA; Thu, 27 Jun 2024 10:27:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4W8s5y6Y7Hz9vGn;
 Thu, 27 Jun 2024 10:23:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DD1528B776;
 Thu, 27 Jun 2024 10:23:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id PywFNG0zTyCw; Thu, 27 Jun 2024 10:23:34 +0200 (CEST)
Received: from [192.168.232.179] (unknown [192.168.232.179])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4DFC48B763;
 Thu, 27 Jun 2024 10:23:34 +0200 (CEST)
Message-ID: <9bf49364-e95f-486a-9642-66953657e4aa@csgroup.eu>
Date: Thu, 27 Jun 2024 10:23:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] U-Boot v2024.07-rc5 released
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Michal Simek <michal.simek@amd.com>,
 "u-boot-custodians@lists.denx.de" <u-boot-custodians@lists.denx.de>,
 "u-boot-board-maintainers@lists.denx.de"
 <u-boot-board-maintainers@lists.denx.de>
References: <20240624193035.GK38804@bill-the-cat>
 <e396268c-e106-4bb8-a40d-e0582e556c6b@cs-soprasteria.com>
 <20240625151929.GS38804@bill-the-cat>
 <7b87013a-23b6-419f-a163-2e9f4c44b200@csgroup.eu>
 <20240626150113.GX38804@bill-the-cat>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240626150113.GX38804@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



Le 26/06/2024 à 17:01, Tom Rini a écrit :
> On Tue, Jun 25, 2024 at 09:20:54PM +0200, Christophe Leroy wrote:
>>
>>
>> Le 25/06/2024 à 17:19, Tom Rini a écrit :
>>> On Tue, Jun 25, 2024 at 03:12:38PM +0000, LEROY Christophe wrote:
>>>> Hi All,
>>>>
>>>> Le 24/06/2024 à 21:30, Tom Rini a écrit :
>>>>> Hey all,
>>>>>
>>>>> Well, once again I need to check my calender reminders since, whoops,
>>>>> I'm a week late. That said, looking at the list of changes in this
>>>>> slightly elongated period, I think it's OK. At this point we're a week
>>>>> out from the release, so it's time for clear and obvious regression
>>>>> fixes. Ideally ones introduced this release cycle so there's less
>>>>> chances of unintended side-effects.
>>>>>
>>>>> In terms of a changelog,
>>>>> git log --merges v2024.07-rc4..v2024.07-rc5
>>>>> contains what I've pulled but as always, better PR messages and tags
>>>>> will provide better results here.
>>>>>
>>>>> With that, the final release is planned for Monday, July 1st, 2024.
>>>>> Thanks all!
>>>>>
>>>>
>>>> For your information, I have started testing v2024.07 on my powerpc
>>>> boards in operational condition and I have a major problem : U-boot
>>>> doesn't get the Linux kernel started before the watchdog fires. I have
>>>> to disable watchdog to get it running.
>>>>
>>>> This problem doesn't occur with v2024.04.
>>>>
>>>> I bisected it to commit 340fdf1303dc ("zlib: Port fix for CVE-2016-9841
>>>> to U-Boot") and I also confirm that v2024.07-rc5 works well with that
>>>> commit reverted on top of it.
>>>>
>>>> Any idea of what is going wrong with that commit ?
>>>
>>> Are you able to check the zlib performance before/after that commit?
>>>
>>
>> Indeed there's a huge difference.
>>
>> Before : 12298074 timebase ticks to decompress kernel
>> After :  17145906 ticks, that is 40% more time.
>>
>> But behind that, we also need to understand why the watchdog is not kept
>> alive during that time.
> 
> That is odd, I would have expected it to have been kept alive.
> 

I digged into it a bit more and really that commit 340fdf1303dc ("zlib: 
Port fix for CVE-2016-9841 to U-Boot") is the issue. The watchdog is 
still kept alive, but not fast enough. On powerpc 8xx, the CPU watchdog 
has a timeout of slightly more than 1s, so it must be kept alive very often.

schedule() is called in inflate() just before calling inflate_fast(), 
which worked until now because the maximum time spent in inflate_fast() 
was about 300ms. With the above commit, more than 1s is spent in 
inflate_fast() , for the problematic block the time spent inside 
inflate_fast() is multiplied by almost 4.

The problem is that the commit does more than what it says and removes
an important optimisation that is using halfwords instead of bytes for 
the copy.

I'm going to send shortly a patch to partially revert that commit. But 
if you feel it is better to revert the commit completely and provide a 
fix in next cycle, it is ok as well, up to you but I think it is 
important to get that fixed for v2024.07.

I'm also sending a fix on the setup of 8xx watchdog, but that has almost 
no impact in reality and doesn't fix the problem.

Thanks
Christophe
