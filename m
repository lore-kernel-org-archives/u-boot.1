Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D82BC0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAE0F80834;
	Sun,  9 Feb 2025 22:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="jJzPTmSL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BD5C8091A; Sun,  9 Feb 2025 22:40:20 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BA4A80821
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:40:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e522=VB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739137215;
 bh=3ww2jnrOCn0wzk2a4OGTslFgy/Tr2i/kr20soOyE/tk=;
 b=jJzPTmSLokcaFWP7CWpjRBL5q+D8pB5k9rViOEVWbB6oD6g/H/7yuI5XxV1T7sooMYl0tTIdP
 tkC8P0pRcc7WQbyPzDkzNWVbmqt2rr1t7YENmq7G4dmRLfuOllbL2rfDKBjiTv8NzlUzOfre51K
 LY7YsZYVtmzZ3oND9GNa3ld/5431VNoOjPQfGYzlBcR8VqB8VxnN2X8g0wk/LXA0UMi5/h7swNE
 z6Pzp1F03s/kRnSNYvt6jL6Cd/6pWNwa4rKfK0MrQCsvczjtw61HcU92JW5cz56DfP7jcAiKrez
 vyCjkuZMUMlOB/u99adF9j0yU31BMJHvano6YdhGF2rQ==
X-Forward-Email-ID: 67a920bb1fe61e2e0689d96d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <9f366f7e-f1ba-464c-9d3f-79beaf3db52a@kwiboo.se>
Date: Sun, 9 Feb 2025 22:40:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] rockchip: rk3399-gru: Include binman generated FIT
 in u-boot.rom image
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <20241212235735.164272-7-jonas@kwiboo.se>
 <8a6bb542-aeda-4d74-bdcc-8eace71eaf62@cherry.de>
 <c3cd2190-096b-4f5d-a5cc-481cc44fa11c@kwiboo.se>
 <CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com>
 <20250209164945.GN1233568@bill-the-cat>
 <CAFLszTjFDzM18Nzacj+z7E+PaGwmF5+PcP=T2vFA=Eg1+AdpsA@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszTjFDzM18Nzacj+z7E+PaGwmF5+PcP=T2vFA=Eg1+AdpsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 2025-02-09 21:14, Simon Glass wrote:
> Hi Tom,
> 
> On Sun, 9 Feb 2025 at 09:49, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Sun, Feb 09, 2025 at 07:27:37AM -0700, Simon Glass wrote:
>>> Hi Jonas,
>>>
>>> On Fri, 20 Dec 2024 at 09:50, Jonas Karlman <jonas@kwiboo.se> wrote:
>>>>
>>>> Hi Quentin and Simon,
>>>>
>>>> On 2024-12-13 15:30, Quentin Schulz wrote:
>>>>> Hi Jonas,
>>>>>
>>>>> On 12/13/24 12:57 AM, Jonas Karlman wrote:
>>>>>> The u-boot.rom image contain u-boot.img FIT instead of the FIT generated
>>>>>> by binman for the u-boot-rockchip.bin image.
>>>>>>
>>>>>> Change to include the binman generated FIT for the u-boot.rom image.
>>>>>>
>>>>>> This change result in TF-A being included and the use sha256 instead of
>>>>>> crc32 checksum in the u-boot.rom FIT.
>>>>>>
>>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>>>
>>>>> IIRC Simon was fine with removing u-boot.rom support for RK3399 when I
>>>>> asked months (probably years?) ago, if that hasn't changed, maybe we
>>>>> should now.
>>>>
>>>> Good to know and fully agree, we should try to remove it now.
>>>>
>>>> I did a compare between u-boot-rockchip-spi.bin and u-boot.rom and after
>>>> this series they are now identical for the full size of
>>>> u-boot-rockchip-spi.bin.
>>>>
>>>> However, the u-boot.rom also has a copy of ~u-boot.bin and a fdtmap
>>>> starting at 0x300000. I have no idea if they are used for anything,
>>>> if they are it is probably not for bare metal booting (TPL+SPL).
>>>
>>> I'm not sure about the extra u-boot.bin, but the fdtmap is so that
>>> 'binman ls -i xxx' works.
>>>
>>>>
>>>> Regards,
>>>> Jonas
>>>>
>>>>>
>>>>> Especially since the only RK3399 with CONGIG_HAS_ROM set are Bob and Kevin.
>>>>>
>>>>> @Simon, you said you tested the patch series on them, with which image
>>>>> did you do that? Are you still fine with removing the u-boot.rom for RK3399?
>>>
>>> Yes that's fine.
>>>
>>> Basically all my testing is in my lab now, which you should be able to
>>> use with gitlab.
>>
>> I really wish you would use the community gitlab instance and not
>> encourage people to use your personal instance instead.
> 
> I wish I didn't need one and anyway, that wasn't what I said. Jonas
> has u-boot-rockchip, I believe, so should be able to push things and
> run on my lab.

For clarity, I only have my personal tree, named u-boot-rockchip, at
GitHub, and do not have any tree at https://source.denx.de/u-boot/

Regards,
Jonas

> 
> Perhaps the problem is that it's too complicated? If you could find a
> way to allow this change in, people could just click the button and
> may be more likely to use it?
> 
> .lab_template: &lab_dfn
>   stage: sjg-lab
>   rules:
>     - if: $SJG_LAB == "1"
>       when: always
>     - if: $SJG_LAB != "1"
>       when: manual
>       allow_failure: true
>   tags: [ 'lab' ]
> 
> Regards,
> Simon

