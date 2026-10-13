Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668F5CC6B19
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 20:46:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1AE8E405DD;
	Tue, 13 Oct 2026 20:46:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j1sTdoWVU7Ld; Tue, 13 Oct 2026 20:46:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 12A3E403C5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791924413;
	b=YVJWCYsFRINdXuMmGHqneRwdtzH8gGR0/jZtyPyHau9IacSi+PkN+uns/KQDFNsvG8Vp
	 TRmoMcHVjdBuwgmM0OnTCceGwfHVNFgX/7yyYLDHKhldPWDvT1SL1r/xWtzkqDII7SAHg
	 EPk57ggewWRZGoteGEgw0Oq35CoGCINsinODTW0oKAyr4B/QQ0ZKRaK8lDXA+nq0/hnN+
	 +0aHzFHY3t/oqRxmsSKhP7mMjdHNqrwvaCZEzyic9kF91olWdhLRntrOCE+6llu5lo9ji
	 VlQ+5AFQp9aqDzUz5X+zWqESql/PnEz4k61/abw6KY6Zopf35nWGiAvsrdJLLjWLVMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791924413;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PHxadmkUfT398veVfAu74fvKFyS6VMmzo6u16RcpK1A=;
	b=AH0J/r+vVOACcvt2GdwgPQVwCmApaiaIJGfvG+YpWgZ2/8l4Vut0c0ixikHEZROwRr8b
	 G1Zd8u9tHfXrqEAIuSoH2V/JnQLHVflNSdz2juwo1EU0Z9/vqULZ9pHtWUBgiyCiC3Fqy
	 8N4XZtSmSFfKdLaGRylpm4ktnFegcqqr05mVfJU0tW+99pgR94INu2I0j7iNhsPX1heH6
	 QdAYGN1kyYShjvBJiLNNMS2pePsPa9Vb8l/DdTD2gdMpIeOESmdmmhabYclE/Yi4aKVA2
	 XwjYZpaFLylwH5pFGNgXJrFq/7ubt23xBavzmi+ohMYMhS3Yj4FKv9gMf1ad19ptWzw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791924413;
	bh=PHxadmkUfT398veVfAu74fvKFyS6VMmzo6u16RcpK1A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ph/BsJYXdjyQDwF2EL3MlbI/XclN89V7cfyv3GgCxGt5X4L+YRSeVwSOPUnUFi3HV
	 HhuBy4aX1hccTdyeyNc0Lg/zpN270KblEC73UvQMGNl0D8ytwrUhg1OLilbuoacSMj
	 wfH22xymYMu93w8oUqB3xXP6tYvKTZaQyYkrNbe1Q1lz8PwN5Mfcv+6IzWX1jZ/R4b
	 C/XMmTqFNOfEvvBQ6NtS43yWVYpyWkVKQbkNThqCy2qbdFAc8XGo9Z9nzAvPaNdmBV
	 GE763pp2z8GTpyMHXWEIg7S6jgI+1Dh/6FYS98bXoQSY114T/nV5NF12SDU9KzcIcJ
	 uSFegHOmru+wQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12A3E403C5;
	Tue, 13 Oct 2026 20:46:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BFEAF1DE
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 20:46:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5BA960705
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 20:46:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6SoH6Jpr3xce for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 20:46:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4C0D6605CF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791924410;
 b=NgtvNKnytAsFBlh5kJh3LTaj65kNNfTRlPnhfKQirQaXh/bB+WeSMEV457egemwKyyCw
 tTgLM2NWJo2pgUXAoNHJ6QKflbrhKK1Qs3P+sRt3EiCgcInboIX6LV3g0pTviEftJ8V8R
 D1G8c7LhzbbteyNFAGYCOZ/SLMPqvhRvpV1vLqKDeSruFuLX5wNKf1zB5HVcy/+tHrGQu
 DlAGAVQ5yYiFCYzBpb4RPzKJxi+0XRJVb/8LImiN6HUNED2TlVmTfS+HKCJnMYHGOEN1U
 82FRDMrBvsMFyr5eBA0trKmYer0lqbBG0nMJujrp9R+zuJE3R6mtEZz5/iiWZKDijNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791924410;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=PHxadmkUfT398veVfAu74fvKFyS6VMmzo6u16RcpK1A=;
 b=nN6gH5wY/qNB5Yt+raHq3uwHrc7XsD879oLg6nE0aqr1JiOsDH46dzzaqBhyFsKpchQw
 jL/WwmTwYthdrKoO9Fi09sHMfpSp6zBYXBAuGxVY6BBgmcqI+N/SmHfMSOUwaeUqJ++JH
 mXemjLLB3pz1qONjGCqsNU2dsvAJEQROAgNtTJaqhjIZXg4JFxKEGj3ZH7ZwiVanzaR0H
 FWfcIIqBBKzobedT1kniRD1R70vW+lPCvVXFlI634MMkWV+xKoYiM5GmsJoZpCWZvGjHy
 PshGeThkloT371xchhDmIvDgCMD5SOm0w4OqrDSFCSwJqpBDEi7tIjcIWeBgoxZAGaA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=jbFSvDen; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=6b17=ie=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=jbFSvDen
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C0D6605CF
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 20:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1791924407;
 bh=PHxadmkUfT398veVfAu74fvKFyS6VMmzo6u16RcpK1A=;
 b=jbFSvDenmhpCEEwA6lshFVBmbpQlV5tWnYJA/F8NcqZdSzaTM2O9BchIxl3oN3x98dGoV/iBm
 c6FVK/ErBy2bgA5bIx3vtPgI2bhnZkuC9Y5gfoFKSbKsi4BGJVSEOBwxz2EYq264/q4kVZrv37B
 Dw8U9+5bGa5/xJGOCM91506NsQzrbTz08Vz5THZBUSzTKWu78+ahpqX3LWDp0I3Z9WWDu7S4IUB
 Rq3Mug4b0DZ2/s7p2gfGhQVg/6fNdnf52QmO04Mvg3fmPqpzH6ByupRi9r5F3yZ+SPRzfxyEQJg
 xeqqqX5KNsTb5NsPoDj1t0yZXEkqL3gNCez1jYD7S4Wg==
X-Forward-Email-ID: 6ace98b65f44731b8f95932d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d6dd6077-dec9-404e-a48a-8231d483cbbb@kwiboo.se>
Date: Tue, 13 Oct 2026 22:46:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] ram: rockchip: rk3568: Simplify get_info() ops
To: Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <20260804105721.2402406-2-jonas@kwiboo.se>
 <f2a4bf52-8532-4f57-9354-1d2a3e33d875@0leil.net>
 <973f0112-e7f7-4cfa-bc01-2e0328592fad@kwiboo.se>
 <4ddd7d43-d5ab-45df-8823-1833d26a793c@0leil.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <4ddd7d43-d5ab-45df-8823-1833d26a793c@0leil.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Quentin,

On 10/13/2026 1:04 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 10/9/26 5:47 PM, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 10/9/2026 12:29 AM, Quentin Schulz wrote:
>>> Hi Jonas,
>>>
>>> On 8/4/26 12:57 PM, Jonas Karlman wrote:
> [...]
>>> 1) I would really like to avoid hardcoding stuff. Did you try using
>>> syscon_regmap_lookup_by_phandle(dev, "rockchip,grf"); after adding a
>>> rockchip,grf = <&pmugrf>; property to the dmc node? (maybe it'd make
>>> sense to name the property rockchip,pmugrf but that's a detail). I also
>>> see benefit in being consistent across all drivers using the GRF when DM
>>> is enabled. One issue I could foresee is that this typically will be
>>> part of the TPL once we have an open DRAM init, and then we don't have
>>> DM in TPL so we won't be able to read the device tree to get GRF via
>>> that property. Is this your current worry?
>>
>> I agree that we should avoid hardcoding stuff in general, with the CRU,
>> RAM and arch_cpu_init()+board_debug_uart_init() in xPL as exceptions.
>>
>> Those are that core parts that typically may be needed in xPL, where
>> size and speed is important and/or DM or OF_PLATDATA may or may not be
>> involved.
>>
>> Resolving values from DT has been proven to be very very slow in xPL
>> and pre-relocation phases, primarily due to slow API for navigating
>> nodes.
>>
>> I also cannot understand why we should need to waste multiple CPU cycles,
>> energy and code size on resolving a fixed known constant value that
>> never is going to change. So no I have not nor do I plan to try and use
>> any DT lookup here ;-)
>>
> 
> OK so I'm going to push this even further. Why do we even need a driver 
> for this?
> 
> I've been bothered for a long time by this DMC node not being described 
> in the bindings and nobody bothering to upstream it. Now that I've 
> looked a bit into it, I think except rk3288 and rk3399 (due to 
> Chromebooks), they all serve no real purpose once we are out of the xPL 
> stage that actually initializes the DRAM, they just report whatever size 
> the DRAM controller reports, by directly reading some register.

Correct, and to be technical the register is also only used as a way to
pass DRAM info from TPL (or vendor blob) to the next phases, for open
DRAM init we could use something else, e.g. a bloblist or similar to
pass this information along to SPL and/or U-Boot proper. However, for
vendor blob we have the register and for newer blobs we also have some
information passed as rk atags.

> I would essentially remove all DMC nodes whose driver do not actually do 
> anything with the Device Tree, then remove the compatible from the 
> driver since we don't need it to probe the RAM driver. I hope the DRAM 
> driver still probes without a compatible (there for sure is some 
> mechanism as DM-less TPL can probe the DRAM driver just fine for the 
> SoCs for which we have an open DRAM init). Then it's clear there is no 
> mix between DT and non-DT logic.
> But maybe we could push even more, and delete the part of the DMC driver 
> that does nothing but report the size and base of the DRAM. We can move 
> this code to arch/arm/mach-rockchip/ for example with a weak function 
> that we need to implement for each SoC. Then we would be left with DMC 
> drivers that actually do DRAM initialization (if there's an open DRAM 
> init!), and not something completely different when it's in a different 
> stage. We likely would need to know when we can then call 
> uclass_get_device(UCLASS_RAM,...) and expect it to work (I guess 
> CONFIG_IS_ENABLED(RAM)?), e.g. in arch/arm/mach-rockchip/tpl.c and 
> arch/arm/mach-rockchip/sdram.c. ram_get_info() can then be replaced with 
> this new weak SoC-specific function.
> 
> Does this make sense? What do you think?

For some parts it make sense, however not if we want to try and follow
driver model or want to be able to one day support multiple SoCs using
a single U-Boot proper build (using existing building blocks).

We could even fully change how xPL pass DRAM info to next phase, however
that would likely break mixing vendor DRAM init or SPL with mainline
U-Boot proper, so may not be ideal if we want to keep backward
compatibility with vendor blobs. One option could possible be to read
register in SPL and pass information to U-Boot proper using a bloblist.

For TPL only doing DRAM init I fully buy that we do not really need DM
and it is enough to call a sdram_init(), similar to what we do on PX30.
This is even the pattern I have done for bare minimal TPL testing on
RK35xx SoCs in my work-in-progress rk3562 branch. However, there the
sdram "driver" only export sdram_init() in TPL and works as the dummy
DM driver for SPL/proper.

For reading DRAM info in SPL, it could easily be a weak SoC-specific
function. However, if we dream of a shared U-Boot proper binary for
multiple SoCs, any use weak SoC-specific functions could likely make
that harder. As long as we keep board or SoC specific functions out of
U-Boot proper this is something that theoretically should be possible.
If we need to do something board/SoC specific, we could possible use
something that is matched on board/soc compatible.

If we in future end up passing DRAM info to U-Boot proper using a SoC
agnostic way, use of current read register RAM drivers would really be
completely unnecessary.

When it comes to the DMC node, we could possible instead bind the driver
to root-node or something similar, however root-node is currently not
being matched to any driver using compatible, so not sure how feasible
that would be.

Reducing complexity of the read register driver and keeping an awkward
DMC node is at least something that has been proven to work ;-)

> 
>>>
>>> 2) why rename to match the compatible? What really matters is that they
>>> are unique across the whole U-Boot code base. I don't see really the
>>> benefit, but if it scratches an itch, I could see one commit that
>>> renames all Rockchip DRAM drivers to be consistently named
>>> rockchip_<soc>_dmc. Not a blocker.
>>
>> The rename is "for possible use with OF_PLATDATA". With OF_PLATDATA the
>> driver is looked up using a DT compatible to driver name mapping.
>>
> 
> I only see very old SoCs using that. SPL_OF_PLATDATA is only enabled for 
> the RK3288 Chromebooks, MK808 (rk3066) and Rock (RK3188). 
> TPL_OF_PLATDATA is enabled for PX5 (RK3368), RK3288, RK3328 and RV1126 
> (ok this one's not so old :) ). Do you have anything in mind related to 
> OF_PLATDATA? I just read doc/develop/driver-model/of-plat.rst and the 
> caveats section is scary.

I know OF_PLATDATA is scary and I would avoid it when possible. Mostly
just want to make it possible for use in case the open TPL for RK3568
may need it, and also the driver name not matching device name and/or
compatible is bugging me ;-)

> 
>> Will split the rename to a separate commit for affected drivers in this
> 
> Thanks.
> 
> [...]
>>>
>>> 3) What is removing probe+priv_auto helping with? We now need to call
>>> rockchip_sdram_size for each call to ram_get_info(), which we only have
>>> one so it's not such a big deal but it's still a bit odd to me when the
>>> DRAM isn't going to change between calls (so somewhat joining Simon on
>>> the caching thing that's done here before your patch)
>>
>> Simons concern where mostly related to caching the base address from DT,
>> not really related to caching the RAM size, if I understood correctly.
>>
>> As mentioned in commit message, to simplify the driver. There is really
>> no need to do an extra malloc for priv data or pre-calculate DRAM size
>> at probe() time. Also to align with the RAM drivers that was added later
>> i.e. rk3576, rk3528 and rk3506. And that I have prepared for rk3562,
>> rv1126b, rv1106, rv1103b, rk3538 and rk3572 in [2] ;-).
>>
> 
> Separate commit please, with its own justification, but fine with me on 
> the reasoning.

Spiting this into following seem reasonable to me:
- ram: rockchip: <soc>: Simplify get_info() ops
- ram: rockchip: <soc>: Use a constant for the PMUGRF base
- ram: rockchip: <soc>: Rename driver to support xPL_OF_PLATDATA

> 
>> On a technical side; to simplify and prepare for possible future DRAM
>> init. We typically need two completely different parts from the RAM
>> driver depending on what phase is running.
>>
>> During DRAM init (in TPL or possible SPL for older SoCs) we only need to
>> initialize DRAM and write encoded DRAM info to OS_REGx, before returning
>> to BROM.
>>
>> During next xPL phase and in proper we typically only need to read and
>> decode the DRAM info from the same OS_REGx.
>>
>> To keep the driver as simple as possible we only need to implement
>> following ops to help keep the complexity low:
>>
>> .probe = init DRAM in TPL and do nothing in remaining phases
>> .get_info = return the decoded DRAM size
>>
>> And for size constrained targets the entire driver could be replaced
>> with a size optimized sdram_init() function in TPL.
>>
> 
> Circling back to what I suggested earlier in this mail, I'm not sure the 
> next xPL phase/proper part of the driver really makes sense to me. It's 
> like a massive overhead for what is essentially a call to one function 
> with one base register address.

I fully agree, and this is one of the reasons I really do not like
current DM lookup of a GRF/SYSCON udevice just to get the reg address to
do a simple readl(). A lot of plumbing for a very simple and
deterministic task.

With this I at least think we remove some of that unnecessary plumbing,
and we are just left with a bare minimum driver model wrapper that
likely can be stripped away in future.

> 
> OK for the hardcoding of the register base address, based on the idea we 
> could eventually move this out of the DMC driver (e.g. into SoC-specific 
> code in arch/arm/mach-rockchip).

Great, I will send a v2.

Regards,
Jonas

> 
> Cheers,
> Quentin

