Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DDACE7CE7
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 08:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD6CD89172;
	Tue,  1 Oct 2024 10:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727772580;
	bh=xs2/xf/yPbeg45FALNZSo1L4Phah289uqNUPUa/LTXw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=THBMKkdTs5kLkO7asfmDFdarfSpvqykwd9b96BaYfwXh7gS0g5aVZTbAgxUwAVP3d
	 3897yA1sIyz0KUboFQ2Uq40rILhMV3p4VgC8hxNEKJXnYWs0B8aLZVrpRz+cQ2A0vH
	 PWuOPJ8v3QX5vgYnLkWJJY9FxXBnL+XBRJEoQAK8BSRKUPq383BSuNYcYTCrB1HEt0
	 g/VFkGX3v9QInDBD9cg/+V0kUPH8tvdaVn3WFBWbp9tinMuDzVhR4lI1cEnB92w8bj
	 Ymwqt3FctWFILHPE67oI59Ss2QTVQQEpF5R0Nj/j2yUKp8W3LxR5RN6/+Mv0lKQUw/
	 Z5Wx7R1SQErLA==
Received: from [192.168.1.107] (82-131-158-173.pool.digikabel.hu
 [82.131.158.173])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1B0CA89170;
 Tue,  1 Oct 2024 10:49:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727772580;
 bh=xs2/xf/yPbeg45FALNZSo1L4Phah289uqNUPUa/LTXw=;
 h=Date:Subject:To:Cc:References:From:Reply-To:In-Reply-To:From;
 b=B1x+sfy617OaqKcFRGSkU170wYqQCRRQmaKufJrRAp02Fjemsuin8DgQ7qyy9Rrwx
 0uq2sglRqqt4MQTAPA8hF0SKnqSDLoWQW8lV+vGscN/9GYy9Wt0UyfKOg8AToH+ajN
 j451BOaNfVx1DXu7e1T520Eu3jPNFeq5O+VJVhjisDv0r5EV5zYHg280dIXMfb/ivj
 GnyUsIzur0fULrIbBga2O/+9wboOdn2qGt4AZprt2Nz58ILklRi87yQCnML2tGoOgg
 +TWDdjKT8TFO9bR+hclnhwStpJLcqophfH6qT1PHq1cumOJEfQ1Ir3Hhh8UIxAL7FZ
 cTvbcM4/CH49Q==
Message-ID: <ff13dbb5-47af-28c8-c44d-079ac475b977@denx.de>
Date: Tue, 1 Oct 2024 10:47:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 08/26] power: Add iMX8M block ctrl driver for dispmix
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 Ye Li <ye.li@nxp.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
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
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20241001102908.39b2d3a6@xps-13>
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

On 01.10.24 10:29, Miquel Raynal wrote:
> Hi Heiko,
> 
> 
>>>>> Hmm.. unfortunately ... I had applied your 2 clock patches, which
>>>>> fixed a problem with enabling parent clocks ... but they broke booting
>>>>> on a carrier which has fec ethernet! After "Net: " output the board hang...
>>>>>
>>>>> I reverted your 2 clock patches and it bootet again ... so there is
>>>>> a problem ... try to get some more time to look into...
>>>>>   
>>>>
>>>> We have a fec, but we had I think two patches more on it. I forget to
>>>> answer Marek
>>>> about them because I don't have my board now and because he is
>>>> partially right (or maybe right).
>>>> Anyway when we boot we could have and we have clocks that are enabled
>>>> by bootrom or SPL that
>>>> we need to declare as enable like PLL2/PLL3 those clocks are parts or
>>>> could be part of reparent so,
>>>> you need to have a reference counter on them that allow to not disable
>>>> during the down chain disable
>>>> and up chain enable. I think that what happens to your ethernet it's
>>>> that you disable some clock that is
>>>> critical to the board to survive. I had a patch merged by Tom that
>>>
>>> Yep, thats what I think too! If you access registers in a block for
>>> which the clock is not enabled ... it just hang...
>>>    
>>>> prints the clock name so if you enable
>>>> the debug of the clock you will find that your board stops working
>>>> during one of this reparinting.
>>>
>>> I currently work on 2024.07... will rebase if 2024.10 is out...
>>>
>>> Ah, you mean:
>>>
>>> commit a70d991212c9684e09ed80ece69ce1ff7bfd9f08
>>> Author: Michael Trimarchi <michael@amarulasolutions.com>
>>> Date:   Tue Jul 9 08:28:13 2024 +0200
>>>
>>>       clk: clk-uclass: Print clk name in clk_enable/clk_disable
>>>
>>>       Print clk name in clk_enable and clk_disable. Make sense to know
>>>       what clock get disabled/enabled before a system crash or system
>>>       hang.
>>>
>>>       Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>>>
>>> I have the same change when I debug :-P
>>>
>>> IIRC I did not see the clock names ... but I will recheck!
>>
>> I see with your patch the clock names, so fine... and see [1]
>>
>> Hmm... I am on imx8mp, and I think the changes the patchset do in
>>
>> "clk: imx8mn: Prevent clock critical path from disabling during reparent and set_rate"
>>
>> are in clk-imx8mp already ...
>>
>> Ported the patch from patchset
>>
>> "[PATCH 05/26] clk: imx8mm: Mark IMX8MM_SYS_PLL2 and IMX8MM_SYS_PLL3 as enabled"
>>
>> to imx8mp [2] and fec ethernet works again for me on imx8mp!
>>
>> Could you add this if you post a v2 ?
> 
> TBH I don't feel like the below change is the correct one, it is too
> specific. The clock core is recursive and thus should handle the
> reparenting situations gracefully.
> 
> I posted a series that is targeting the LVDS output on imx8mp. You
> should probably consider checking these patches as well if you work
> on imx8mp as well. I also had similar breakages with Ethernet which
> happened during the assigned-clocks handling. This patch, which is more
> future and platform agnostic, fixed it:
> 
> https://lore.kernel.org/u-boot/20240910101344.110633-3-miquel.raynal@bootlin.com/

Yes, I also had such a "fix" first, before seeing Darios patchset!

Damn, I did not see your patches...

regarding your patch ... I am unsure which version is the best one ...
I fear of side effects for other plattforms adding this change in
generic "drivers/clk/clk-uclass.c" file...

> My series is complimentary, even though there are some overlaps that we
> need to merge.

I try to find time to test them on my board!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
