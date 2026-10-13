Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300C6CC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 11:04:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9F7740478;
	Tue, 13 Oct 2026 11:04:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PeVmMu0zFV5W; Tue, 13 Oct 2026 11:04:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C323A404C1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791889466;
	b=C/nSwvBBhumOKKJVae+DWn0Mls7UgyP1Oj+dMrTV7SO1W98KCKvEkIMJL9rDOyeRWBtM
	 mYzfVXtoWV3UJdgXToWIYe5gcuZ40/ZiMp6FzBBF0RMT00Z2DwpEUALkIczZVOOkC4qrQ
	 jdme4cuhuTvxpW9UiMKlemBaUvJNNSXIzy4IJDKZg9feGXljCSBDnkeSZE/4ol9G8y095
	 8639FSqD3WvRGul9l4ysx7DadIHDYwDesuNxOhWsi8H8w5pmLW5bP8TDZzzu0uXJ7o419
	 yJ4TJo/GpZPMMO107CbHFj/tA8B1y3Yb16KcsVS5dgva2Z/lnDQarYXrqRMGNpTm9qA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791889466;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jIY+aDGl0MmnU8II9adddAp2CLBAt0rAm8LHrNQlc9g=;
	b=OAFfJWgcdAy0rtWtx2f4Kuu4kbTSs/o0MF5rW3BcJWAwT6ez5ZLjDguNQkqzafxgi+pU
	 4IK3vs5GzOTaijXg1FgNkdmYezX8FBzxP3VjbDTc4SZgmTTE8JXt+QwrqJ43djd5/+jni
	 KfPDZcqir6xFkmccDI+Sj82Y/iaE1YDfNUficA+R46GBqJS3X5mZqbGU9JgPAOL3UlYFI
	 ZeokWPKv6hpP7id+ozlbTdbOUxAcne4pQGuXEoS6lpF/gJX99DTEpqYjNy8QgARwR56wI
	 NUsGV0bETuya7MQIa/KfAE8J7vYoZsIkBFJhzvj7pPhJZTy+U2f4X+4BWnCZIWtx4tw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791889466;
	bh=jIY+aDGl0MmnU8II9adddAp2CLBAt0rAm8LHrNQlc9g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mXn0c29+APQ5+RiMkQLQtFSqZI45HNRhKKCEIzWZYNjNy06SsXmcfIwiF5V0L2Y/r
	 iqGurvi1bL1GRFvng1tUL7/s1evmhZvWQyXXDOSTx/4hP5NcHhnkfHlH6q105qCFT/
	 6e/srz5t+8vjR6H1qgrMwMysdkx/ZwWSBrmFzo6cO55rlU6nsfyXaoFRAxDCmNY5Iu
	 9KIDifAVTXqUZIDQHezDzh8+yctr++cPNifX4Udm4uMAg2bH8uQCM5Arx48GkCWsPP
	 hSlpwX0e+TzIn5YQYw3QQBMA7vQauSIJhsAM1f1axOLlKJSmsrKatXIVBtBwV8Am0X
	 RSIQq2ghkKgKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C323A404C1;
	Tue, 13 Oct 2026 11:04:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5034CDE0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4194380AB5
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:04:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RegP_8BIieKn for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 11:04:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B3A91809CE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=84.16.66.171
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791889464;
 b=InvhDlI7rhBAObzL8r8KTa2tLBOIjw32tZLAg0EyA+t7NgJ6hcMSfGxhUn8TpRmPSlhK
 i/cCQwDDO15cDGLG1ShbWVmI/0cpeMLvE8DziGcrBBJUWODKTf8OpdFtQxeg0XyEZD5H+
 aUUeztNWhQtz+Me9YMjKq4DnVs+MLAYAvRbQ6z6/Zd2vGoLNj0Yxyx2LuQqAxcYCDb0TU
 +3/K81ficKHy+yoHhkAfKELFQbNJYDR7K9zG7SijwRwjqFCxcq+v3FToIc2SAddolnU3L
 0E4fzY1UPC1wMYNhTpiai73bTLElChX7J+WekUNdXnF1RrkBrLt5qPR1QkqBZSwTGDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791889464;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=jIY+aDGl0MmnU8II9adddAp2CLBAt0rAm8LHrNQlc9g=;
 b=n3Yb8RMDi5pjUAFeSjsbnuh69CAVi7kpmYBhDYUpI2U1REhfeGO2lub/7pSpAL+3qaGv
 uYubomQuhI9AFU6P75+6uc7JtiLCX0khSCEpr0R+0wK07mQmnL7xELWkVZTkBJZQbjQrX
 qNwkafBuDT4+xDtcjZJIqFYNf/fJiITuT5sdOn+UpQxV+TZQWguLc9OQtgGVeoI/XBZp7
 fFTaix3uxpfw+IDROJGf+JBZ7DtFezrnscFzrQudqNMeZdKMQnpHXi+1PyNscf16BrSjt
 p1dHNIk7/ej59UXs10rGG1c0akrF59cnfdBk1f9a9dJGvW4RntlZTn8Vlncc6Q1hLIg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=XJyz7zr+; 
 arc=none smtp.remote-ip=84.16.66.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.171;
 helo=smtp-42ab.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=XJyz7zr+
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [84.16.66.171])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B3A91809CE
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:04:22 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j3s0g3KtDz109D;
 Tue, 13 Oct 2026 13:04:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1791889459;
 bh=jIY+aDGl0MmnU8II9adddAp2CLBAt0rAm8LHrNQlc9g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XJyz7zr++R/UKu8ppXoFz6CCx82ximiOMxQy9zSpV8ap5Oj3TH6+N0j3Gc8iOITKP
 kKuTABSTnAxis8AXCiDxIshRLBbqh7vvvezIqLXNfIluDaxvwl/RIvPgELW2AmGaK0
 oOGFMZM+IByaOCDxtP1fOUFiZr0xmxhiQNWavHdrfawLl6HaULnjJhxGEFos6xIBKw
 9rdBh6SdbgwpsJqX+aXI+yfgfsuPJPnMgjUwIRTcJU+S416qfewM3lvXRYy9qydupy
 NT34/fdXXvqRioxTPyA0n53drTWPNAQiRsFWkxAFxHEWg7Fm/zk6ZwvnwVPBXzb14c
 OtkjZ/zvt1euw==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j3s0d6VzFzPmn; Tue, 13 Oct 2026 13:04:17 +0200 (CEST)
Message-ID: <4ddd7d43-d5ab-45df-8823-1833d26a793c@0leil.net>
Date: Tue, 13 Oct 2026 13:04:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] ram: rockchip: rk3568: Simplify get_info() ops
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <20260804105721.2402406-2-jonas@kwiboo.se>
 <f2a4bf52-8532-4f57-9354-1d2a3e33d875@0leil.net>
 <973f0112-e7f7-4cfa-bc01-2e0328592fad@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <973f0112-e7f7-4cfa-bc01-2e0328592fad@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Jonas,

On 10/9/26 5:47 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 10/9/2026 12:29 AM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 8/4/26 12:57 PM, Jonas Karlman wrote:
[...]
>> 1) I would really like to avoid hardcoding stuff. Did you try using
>> syscon_regmap_lookup_by_phandle(dev, "rockchip,grf"); after adding a
>> rockchip,grf = <&pmugrf>; property to the dmc node? (maybe it'd make
>> sense to name the property rockchip,pmugrf but that's a detail). I also
>> see benefit in being consistent across all drivers using the GRF when DM
>> is enabled. One issue I could foresee is that this typically will be
>> part of the TPL once we have an open DRAM init, and then we don't have
>> DM in TPL so we won't be able to read the device tree to get GRF via
>> that property. Is this your current worry?
> 
> I agree that we should avoid hardcoding stuff in general, with the CRU,
> RAM and arch_cpu_init()+board_debug_uart_init() in xPL as exceptions.
> 
> Those are that core parts that typically may be needed in xPL, where
> size and speed is important and/or DM or OF_PLATDATA may or may not be
> involved.
> 
> Resolving values from DT has been proven to be very very slow in xPL
> and pre-relocation phases, primarily due to slow API for navigating
> nodes.
> 
> I also cannot understand why we should need to waste multiple CPU cycles,
> energy and code size on resolving a fixed known constant value that
> never is going to change. So no I have not nor do I plan to try and use
> any DT lookup here ;-)
> 

OK so I'm going to push this even further. Why do we even need a driver 
for this?

I've been bothered for a long time by this DMC node not being described 
in the bindings and nobody bothering to upstream it. Now that I've 
looked a bit into it, I think except rk3288 and rk3399 (due to 
Chromebooks), they all serve no real purpose once we are out of the xPL 
stage that actually initializes the DRAM, they just report whatever size 
the DRAM controller reports, by directly reading some register.

I would essentially remove all DMC nodes whose driver do not actually do 
anything with the Device Tree, then remove the compatible from the 
driver since we don't need it to probe the RAM driver. I hope the DRAM 
driver still probes without a compatible (there for sure is some 
mechanism as DM-less TPL can probe the DRAM driver just fine for the 
SoCs for which we have an open DRAM init). Then it's clear there is no 
mix between DT and non-DT logic.
But maybe we could push even more, and delete the part of the DMC driver 
that does nothing but report the size and base of the DRAM. We can move 
this code to arch/arm/mach-rockchip/ for example with a weak function 
that we need to implement for each SoC. Then we would be left with DMC 
drivers that actually do DRAM initialization (if there's an open DRAM 
init!), and not something completely different when it's in a different 
stage. We likely would need to know when we can then call 
uclass_get_device(UCLASS_RAM,...) and expect it to work (I guess 
CONFIG_IS_ENABLED(RAM)?), e.g. in arch/arm/mach-rockchip/tpl.c and 
arch/arm/mach-rockchip/sdram.c. ram_get_info() can then be replaced with 
this new weak SoC-specific function.

Does this make sense? What do you think?

>>
>> 2) why rename to match the compatible? What really matters is that they
>> are unique across the whole U-Boot code base. I don't see really the
>> benefit, but if it scratches an itch, I could see one commit that
>> renames all Rockchip DRAM drivers to be consistently named
>> rockchip_<soc>_dmc. Not a blocker.
> 
> The rename is "for possible use with OF_PLATDATA". With OF_PLATDATA the
> driver is looked up using a DT compatible to driver name mapping.
> 

I only see very old SoCs using that. SPL_OF_PLATDATA is only enabled for 
the RK3288 Chromebooks, MK808 (rk3066) and Rock (RK3188). 
TPL_OF_PLATDATA is enabled for PX5 (RK3368), RK3288, RK3328 and RV1126 
(ok this one's not so old :) ). Do you have anything in mind related to 
OF_PLATDATA? I just read doc/develop/driver-model/of-plat.rst and the 
caveats section is scary.

> Will split the rename to a separate commit for affected drivers in this

Thanks.

[...]
>>
>> 3) What is removing probe+priv_auto helping with? We now need to call
>> rockchip_sdram_size for each call to ram_get_info(), which we only have
>> one so it's not such a big deal but it's still a bit odd to me when the
>> DRAM isn't going to change between calls (so somewhat joining Simon on
>> the caching thing that's done here before your patch)
> 
> Simons concern where mostly related to caching the base address from DT,
> not really related to caching the RAM size, if I understood correctly.
> 
> As mentioned in commit message, to simplify the driver. There is really
> no need to do an extra malloc for priv data or pre-calculate DRAM size
> at probe() time. Also to align with the RAM drivers that was added later
> i.e. rk3576, rk3528 and rk3506. And that I have prepared for rk3562,
> rv1126b, rv1106, rv1103b, rk3538 and rk3572 in [2] ;-).
> 

Separate commit please, with its own justification, but fine with me on 
the reasoning.

> On a technical side; to simplify and prepare for possible future DRAM
> init. We typically need two completely different parts from the RAM
> driver depending on what phase is running.
> 
> During DRAM init (in TPL or possible SPL for older SoCs) we only need to
> initialize DRAM and write encoded DRAM info to OS_REGx, before returning
> to BROM.
> 
> During next xPL phase and in proper we typically only need to read and
> decode the DRAM info from the same OS_REGx.
> 
> To keep the driver as simple as possible we only need to implement
> following ops to help keep the complexity low:
> 
> .probe = init DRAM in TPL and do nothing in remaining phases
> .get_info = return the decoded DRAM size
> 
> And for size constrained targets the entire driver could be replaced
> with a size optimized sdram_init() function in TPL.
> 

Circling back to what I suggested earlier in this mail, I'm not sure the 
next xPL phase/proper part of the driver really makes sense to me. It's 
like a massive overhead for what is essentially a call to one function 
with one base register address.

OK for the hardcoding of the register base address, based on the idea we 
could eventually move this out of the DMC driver (e.g. into SoC-specific 
code in arch/arm/mach-rockchip).

Cheers,
Quentin
