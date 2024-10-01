Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD08CE7CF8
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 08:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B257189174;
	Tue,  1 Oct 2024 10:59:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727773170;
	bh=Ta7GWvnM3VyTr9lSmH+XcduuwTShNOKgj/OlGw8DfiM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=kb6GIlOWJegYegXi8jkYd3Mu5+5me6UDkbiq6usqEiqY9009IRtGox0ocL3VA3Nim
	 LBkAzxjL0USGcFMvHaAf04QbPw6oMQoeU6pDwJrIn1bOOTVyZyjsXkbl8CMu9sYU4F
	 QMn2xGqzuhvC/odkVLzmAkJjf3wnnLpNpWb4XO2kfm1Ua16lfmxChinzAcEdBovC8T
	 UEQTZD5Q31oK8BjH8oXNtT0gKXwbCR5F4bqZ+LmbMkv+oHMkmeWlMlv2kBlkI/6Rv1
	 2f3dXiWac1stXXemzoYPb9328rQPVX8mTX1nFkKyCmmNlHGBoc4oz6XECsRQHTagp6
	 L4RuP6flxdyzA==
Received: from [192.168.1.107] (82-131-158-173.pool.digikabel.hu
 [82.131.158.173])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3B23D8914D;
 Tue,  1 Oct 2024 10:59:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727773169;
 bh=Ta7GWvnM3VyTr9lSmH+XcduuwTShNOKgj/OlGw8DfiM=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=PviCnKMCS+NBX7djErkghiEOUAkF0SfJWUAnXokE98UhTGMdRFo3ACF7UFHNkem4J
 LUpwEeNXxAjg8qDrtj41RHKJ3vL5SsA/d2yHpgvL4KbgX346fSIsPwwxv+c+vS4bzA
 KADykEKRq/rzx1sfdKEzUhD9vEAMTjojxJd/PkL2UfbjShEldQOgtP6QvqRw3ojIQN
 3JdZ8Xp8geUy7jez5WEhPs8Sjll8JD71dUcvWRWdw0zoQSv4+7ex6PO39Y4HeRnCD/
 Xe6yrOXA0pAIecmegxPDT3KUGBhBZ495dCAnu/1h8Alcb7o86c2NNLM6sjexVUs3kU
 QN4eD4bhxIMMA==
Message-ID: <a91171dd-a2f2-8df7-5b11-4a35a227ef2e@denx.de>
Date: Tue, 1 Oct 2024 10:57:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 08/26] power: Add iMX8M block ctrl driver for dispmix
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>,
 linux-amarula@amarulasolutions.com, Ye Li <ye.li@nxp.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
 <20240913095622.72377-9-dario.binacchi@amarulasolutions.com>
 <beecebba-79f5-e21d-3062-287c2dbb04e9@denx.de>
 <CABGWkvqOzc3cGM_aKVurv1XbAbeHXE77xwq_uAmSuZMgjCoevQ@mail.gmail.com>
 <ebb734bd-bdf7-ffd2-d676-7eb6011466a3@denx.de>
 <CAOf5uwm13jyOb0M9Xvx_bO1RpXhDcWqKBC-4fhZGo61Q5cjnjw@mail.gmail.com>
 <3cb57821-30f0-6aa0-2dec-313381b1350a@denx.de>
 <9ce14505-6c37-f2e8-4b5d-44f1a55f0393@denx.de>
 <20241001102908.39b2d3a6@xps-13>
 <CAOf5uwn8vhozjtMqXmWL=3Jaf05UhV7cnGn15Ywj07-PmwW_9w@mail.gmail.com>
 <20241001105057.2992e124@xps-13>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20241001105057.2992e124@xps-13>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Miquel,

On 01.10.24 10:50, Miquel Raynal wrote:
> Hi Michael,
> 
> michael@amarulasolutions.com wrote on Tue, 1 Oct 2024 10:33:56 +0200:
> 
>> Hi Miguel
>>
>> On Tue, Oct 1, 2024 at 10:29 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>>>
>>> Hi Heiko,
>>>
>>>   
>>>>>>> Hmm.. unfortunately ... I had applied your 2 clock patches, which
>>>>>>> fixed a problem with enabling parent clocks ... but they broke booting
>>>>>>> on a carrier which has fec ethernet! After "Net: " output the board hang...
>>>>>>>
>>>>>>> I reverted your 2 clock patches and it bootet again ... so there is
>>>>>>> a problem ... try to get some more time to look into...
>>>>>>>   
>>>>>>
>>>>>> We have a fec, but we had I think two patches more on it. I forget to
>>>>>> answer Marek
>>>>>> about them because I don't have my board now and because he is
>>>>>> partially right (or maybe right).
>>>>>> Anyway when we boot we could have and we have clocks that are enabled
>>>>>> by bootrom or SPL that
>>>>>> we need to declare as enable like PLL2/PLL3 those clocks are parts or
>>>>>> could be part of reparent so,
>>>>>> you need to have a reference counter on them that allow to not disable
>>>>>> during the down chain disable
>>>>>> and up chain enable. I think that what happens to your ethernet it's
>>>>>> that you disable some clock that is
>>>>>> critical to the board to survive. I had a patch merged by Tom that
>>>>>
>>>>> Yep, thats what I think too! If you access registers in a block for
>>>>> which the clock is not enabled ... it just hang...
>>>>>   
>>>>>> prints the clock name so if you enable
>>>>>> the debug of the clock you will find that your board stops working
>>>>>> during one of this reparinting.
>>>>>
>>>>> I currently work on 2024.07... will rebase if 2024.10 is out...
>>>>>
>>>>> Ah, you mean:
>>>>>
>>>>> commit a70d991212c9684e09ed80ece69ce1ff7bfd9f08
>>>>> Author: Michael Trimarchi <michael@amarulasolutions.com>
>>>>> Date:   Tue Jul 9 08:28:13 2024 +0200
>>>>>
>>>>>       clk: clk-uclass: Print clk name in clk_enable/clk_disable
>>>>>
>>>>>       Print clk name in clk_enable and clk_disable. Make sense to know
>>>>>       what clock get disabled/enabled before a system crash or system
>>>>>       hang.
>>>>>
>>>>>       Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>>>>>
>>>>> I have the same change when I debug :-P
>>>>>
>>>>> IIRC I did not see the clock names ... but I will recheck!
>>>>
>>>> I see with your patch the clock names, so fine... and see [1]
>>>>
>>>> Hmm... I am on imx8mp, and I think the changes the patchset do in
>>>>
>>>> "clk: imx8mn: Prevent clock critical path from disabling during reparent and set_rate"
>>>>
>>>> are in clk-imx8mp already ...
>>>>
>>>> Ported the patch from patchset
>>>>
>>>> "[PATCH 05/26] clk: imx8mm: Mark IMX8MM_SYS_PLL2 and IMX8MM_SYS_PLL3 as enabled"
>>>>
>>>> to imx8mp [2] and fec ethernet works again for me on imx8mp!
>>>>
>>>> Could you add this if you post a v2 ?
>>>
>>> TBH I don't feel like the below change is the correct one, it is too
>>> specific. The clock core is recursive and thus should handle the
>>> reparenting situations gracefully.
>>>
>>> I posted a series that is targeting the LVDS output on imx8mp. You
>>> should probably consider checking these patches as well if you work
>>> on imx8mp as well. I also had similar breakages with Ethernet which
>>> happened during the assigned-clocks handling. This patch, which is more
>>> future and platform agnostic, fixed it:
>>>
>>> https://lore.kernel.org/u-boot/20240910101344.110633-3-miquel.raynal@bootlin.com/
>>>   
>>
>> The clock patches are not specific at all. You need to have it working
>> for the parent for each component.
> 
> The diff shown by Heiko is explicitly enabling PLLs by naming them in
> the iMX driver. This is not the correct approach. The problem of
> having non-enabled new parents is global. Parent clocks should be
> enabled before changing muxes, and this should be enforced
> by the clock core/uclass, not the SoC drivers.

Okay, valid argument.

> 
>> This is a standard way to do it and nothing magic compared to other
>> implementations.
> 
> No, naming PLLs explicitly is not the correct approach.
> 
>> I don't see
>> in your series any addressing or reparent clock or take in account
>> that a clock should be enable before
>> reparenting.
> 
> That's exactly the link above, whose diff is pasted here for reference:
> 
> @@ -595,6 +595,10 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
>   	if (!ops->set_parent)
>   		return -ENOSYS;
>   
> +	ret = clk_enable(parent);
> +	if (ret)
> +		return ret;

As I said before, I had *exact* the same patch and thought I made a big
hack :-P

But I wonder ... if this a generic "problem", why nobody had yet problems
with it...

Thanks!

bye,
Heiko

>>> My series is complimentary, even though there are some overlaps that we
>>> need to merge.
>>
>> The only collision I can see from your series is that you re-write the
>> imx approach of power domain.
>> Can you please expand here a bit your point?
> 
> Well, that's what I'd call an overlap :) There are also similar changes
> in the clock core IIRC. Well, there is a bit of merging that needs to
> happen I guess, but if you don't think there is any then my series can
> enter as-is (once the comments addressed, ofc).
> 
> Thanks,
> Miquèl
> 

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
