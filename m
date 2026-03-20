Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970F71099B2D
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 17:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D425383D71;
	Fri, 20 Mar 2026 18:55:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c90WCn31";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BD3783F00; Fri, 20 Mar 2026 18:55:12 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D26883CF5
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 18:55:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-7986fb839f5so24486357b3.0
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 10:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774029309; x=1774634109; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ZKxIsZk3MePZx+RnClHiZcRVbt55LdMEwlShCQI++1U=;
 b=c90WCn3134iaekRyEbtAxWqixYf3xeK+e6cN22aqxds9UnoYSxcL2Qj1gHo5q1poMG
 c4Oq0Q4s3LAzHKoOnsaBjO4rtV8cUkS+sg3E8N4G7qPNfYu3apiPCOJDR9GgP5HKjzBx
 cdVAoHYowv8Jq2ngHFaZZARWafB/oc0dtjvGf3/4UPBIbDTjKXugNAcmEL/dG8Cst93Y
 NGPUmN7dmorIR4YOAMJdcyS49a/kXJBS1z0G6AJWXjuZ2k6gY62kZ/9PY42x+WUVrqVJ
 9joPknEq4jRHelmJKXFQn0APIFhQFz3bvKSrk9PXzCWEDSsq9JFdUV6JSty4x+E0HSKw
 m80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774029309; x=1774634109;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZKxIsZk3MePZx+RnClHiZcRVbt55LdMEwlShCQI++1U=;
 b=K0m9mDWfut/UJ18MlFOA8Plat5XQTc4q7yi3EEQCpd5JOchgQQEH25XGpnr1qVKve+
 75A+JV35V80VL21QIvBYKn6V+HKA0NBXNCmIJxy43O/PfpWRfFqFCE1HHQZGv7mtrZZY
 DF4s5AFAkKMk825EQh9BUQwtCkJmJy+M8ewD0+Zj1rrPWqxD914c7Qoz3VUOAA6rLkWW
 qPkxryGdaEFFrPZlvWOHVtetFf92GuTGcvgKV+WbXBUkSHpKnMT2xp6iMWAZWX0nDyux
 X/ggnmNKsWlRiKOTW6MLPYzS2cuY5n1jBopumMsvTOwJ2vriZuI/EWe0Cp8zHaHdYgw6
 kakQ==
X-Gm-Message-State: AOJu0YyduuJlmcXYzem8FX9uHnGreS007RA7VLNUhO7CQqOc1T9mjCpm
 oUhXx+L0yUrB3nhagS8nxdAI4I1WjRIsapoLLE1y1iOmzFcePnYHIovUKuMVZRaLJYA=
X-Gm-Gg: ATEYQzx5EIwOfe7Z7n/jJehG4ehZpVBHUtGlYApL6QKWi3M6fi/ZW6GBoJUks4r4quV
 q+1nCBOx2g00lZ4gVQ1KurL/Jc28WDjHGGURWQisioKYv5hggM38IEQ0tFW1Fibd0+h+tLYgSCf
 1raJ0Q5TiF6E/lS+IIkn2Sychj/YwTpm9n1CSUGM26HQxixJD+aBKoLg89EadfDTCwzYadVbfhX
 Yqw2pkoX8+JktzF3rr+aK4nvgoAXgb0Kri955HGFu+KNj/0ljStxf1tBDC+2hmhitSzXiM/Jwo2
 ovv3BRIeN+PVUDZQxG6JQ/Ga0OghGZxNLGX85jwvoGuA8S1rJXcBWNBnN2yTdVbDW6stU1f+b+7
 hFWa1UEHvXiJBsCSZ2fIIQ0WI0L837DZCLLoWptczFvH4CsHPIcoQIg+skRhgWc2ZAm/IUA3MvI
 8loqZL5fKOXMCSX8FlYlj6fb+sT4rmdhg+FWBd+ktgmqlkGPpV2FNrYo2ay5fM9Y5sLNzW8AgCv
 vjlxN0=
X-Received: by 2002:a05:690c:c508:b0:79a:55f5:a3e5 with SMTP id
 00721157ae682-79a90acd45amr41888597b3.17.1774029308294; 
 Fri, 20 Mar 2026 10:55:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:c01d:178d:b037:2418?
 ([2a01:e0a:106d:1080:c01d:178d:b037:2418])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-79a905a2eb5sm19055187b3.42.2026.03.20.10.55.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 10:55:07 -0700 (PDT)
Message-ID: <4d07d238-42b7-439b-9369-9306ce1b64c4@linaro.org>
Date: Fri, 20 Mar 2026 18:55:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC 00/40] clk: port full Linux Common Clock Framework to
 U-Boot
To: Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
 <CAFLszTimOLhu=n5jrztE9QqbtXRDjutf_WiKLGMVe4ODJOc8wA@mail.gmail.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <CAFLszTimOLhu=n5jrztE9QqbtXRDjutf_WiKLGMVe4ODJOc8wA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 3/20/26 17:52, Simon Glass wrote:
> Hi Casey,
> 
> On Thu, 19 Mar 2026 at 14:56, Casey Connolly <casey.connolly@linaro.org> wrote:
>>
>> This RFC provides a proof of concept for using the full Linux CCF in
>> U-Boot and consequently porting full Linux clock drivers with extremely
>> minimal changes.
> 
> As a general question, what is the boot flow for the Qualcomm devices
> you are are targeting, i.e. where does U-Boot come in the chain from
> reset? Does it use xPL?
> 
>>
>> == Overview ==
>>
>> This RFC is pretty long but can be separated into a few chunks. The
>> first patches relate to Linux API compatibility and just contain small
>> self contained changes, these can go upstream regardless of CCF.
>>
>> The next group of changes prepare for importing CCF from Linux, the
>> standalone fixed clock drivers are moved to clk/basic, the existing
>> U-Boot CCF drivers are moved to clk/uccf, and struct clk_ops is renamed
>> to clk_ops_uboot.
>>
>> Additionally, clk_set_rate() is changed so that it returns a signed
>> long, since it can return negative values. This is also done to align
>> with CCF but it's a standalone improvement nonetheless.
> 
> Agreed.
> 
>>
>> The next changes import CCF from Linux 6.19 and then adjust it to
>> compile and work with U-Boot. These commits are split up mostly to
>> try and reduce the size. Finally clk-uclass is adjusted for CCF, this
>> definitely will need some additional passes to be a bit cleaner.
>>
>> With CCF done, sandbox clk-ccf driver gets a CCF_FULL port, the clk_ccf
>> tests are adjusted to pass.
> 
> Minor point - perhaps CLK_LINUX ? CCF_FULL seems cryptic to me and
> some would argue that the existing CLK_CCF is already full..
> 
>>
>> Lastly, a PoC port of Qualcomms Linux clock drivers is done, this
>> only has sm8650 clocks but they serve the desired purpose. The changes
>> necessary to the Linux drivers are mostly to deal with U-Boots driver
>> model, the actual platform specific clock drivers require essentially
>> zero changes!
>>
>> === Feedback ===
>>
>> I'd like to get feedback on the overall architecture and ideas, feel
>> free to point out any dead code or printf's I forgot about, but I'll for
>> sure do a more detailed cleanup before the next revision.
>>
>> I would definitely like to input on how to deal with clk-uclass, since
>> it's now supporting 3 different clock frameworks, but I'm now sure how
>> best to separate the code out without duplicating code.
> 
> Perhaps a justification can be expressed in terms of code size / capabilities:
> 
> Small - can boot in xPL from limited SRAM, only simple clocks
> Medium - smaller code size but still provides good access to clocks
> Large - Linux compatible, full capability but lots of code
> 
>>
>> In terms of overall architecture, CCF is a departure from the uclass
>> model that U-Boot has stuck too for so long. If this is a success then
>> I think it could make a lot of sense to make similar changes for power
>> domains and resets. I think this change offers a lot of additional
>> flexibility which has been sorely missed.
> 
> While those are separate, does this mean that there will be a
> significant delta from Linux's clock drivers on Qualcomm, or will it
> be minor?
>>
>> == Motivation ==
>>
>> There were quite a few motivating factors behind this effort which I
>> think provide useful context for this series:
>>
>> 1. Existing UCLASS_CLK support in U-Boot (even with U-Boots minimal CCF)
>>     doesn't provide a fully cohesive API nor implement the necessary
>>     functionality to support complex modern platforms without a lot of
>>     additional effort.
>>
>> 2. While trying to enable display support on Qualcomm, it became clear
>>     that U-Boots clock framework was a severe limiting factor,
>>     particularly for more complicated setups like "bonded" dual-DSI.
> 
> It seems that 1 and 2 could be merged? The question here is how much
> effort would someone want to put in. Providing an easy way to pull in
> the Linux clock driver makes sense. Some people may wish to put in
> effort to at least support the basic clocks for xPL, etc.
> 
>>
>> 3. The current state of Qualcomm clock drivers in U-Boot is pretty poor,
>>     as the old very basic driver code is being expected to support more
>>     and more complicated usecases. Clock support is generally the most
>>     complicated part of bringing up any new Qualcomm platform, so being
>>     able to properly reuse Linux drivers with the familiar API greatly
>>     reduces the amount of friction when working on U-Boot support for
>>     complicated peripherals like the display.
>>
>> Consequently, My aim with this effort was primarily to provide API
>> compatibility with Linux as much as possible, minimising the changes
>> that have to be made to clock drivers to port them from Linux, and
>> reducing the chance of introducing U-Boot specific bugs.
>>
>> === clk_ops/UCLASS_CLK ===
>>
>> CCF_FULL drivers should NOT use UCLASS_CLK, since CCF uses a totally
>> independent clock API. If the clocks are provided by another device like
>> a phy, they can simply be registered with the clk core the same way they
>> are in Linux. Standalone clock drivers should use UCLASS_NOP.
> 
> Bypassing UCLASS_CLK entirely is a big departure. It means DM can't
> track these clock devices properly - no uclass_find_device(), no
> sequence numbers, no standard device iteration.
> 

Can't we allocate struct clk as udevices subdevices of clk drivers ?

Like alloc_clk() woult create a child udevice of dev and the lookup
functions would use the uclass functions and use dm for all the
allocation and lifetime of the clk.

This is what I did for the interconnect, and it works well. You
can easily create/attach/find/iterate/remove subdevices instead
of using custom alloc and lists.

Neil

> The suggestion to do the same for power domains and resets would
> fragment driver model further.
> 
> How about having a single UCLASS_CLK_LINUX device?
> 
>>
>> Clocks must all be registered during driver probe, the CCF will ensure
>> that a given clock provider is probed (via a global ofnode -> device
>> lookup) before checking the of_providers, thus making sure the clocks
>> are registered so that the consumer can use them. There is currently no
>> special handling for cyclical dependencies.
> 
> Driver model normally registers devices during a bind step, which
> helps to remove the problem of cyclic dependencies. Is there any need
> to wait until probe()? Also, can we statically declare it, to save
> code size? Most of the definitions are static
> 
> The global ofnode -> device lookup to force probe ordering is
> reinventing what DM already does with uclass probing. This feels like
> it should integrate with DM rather than work around it.
> 
>>
>> === struct clk ===
>>
>> It's definitely debatable if it makes sense to have 3 different structs
>> for each clk (clk_hw, clk_core and clk). I do think clk_hw and clk_core
>> are justified, since clk_hw is more tied to the hardware description and
>> typically nested in a clk-specific descriptor while clk_core contains
>> the internal runtime state of the clk which should remain private to
>> CCF core.
> 
> Probably we should follow Linux, since we would start to lose the
> benefit of your series if we merged two structs.
> 
>>
>> It could make sense to merge clk and clk_core, but since struct clk is
>> public in U-Boot, where it's an opaque pointer in Linux this would be
>> a substantial effort. In Linux struct clk objects are allocated inside
>> CCF, but in U-Boot they're allocated by the driver, this would need to
>> be resolved before we investigate combining these structs.
>>
>> === Memory/perf overhead ===
>>
>> The memory and size overhead of CCF is undoubtably bigger than uCCF,
>> although I suspect the difference is less than it might seem at
>> first glance. In particular: clk_core is only ~50 bytes larger than
>> struct udevice on ARM64, and an additional 120 bytes is saved for each
>> U_BOOT_DRIVER used by uCCF.
>>
>> On the other hand, the CPU overhead is probably more significant,
>> but not an unreasonable cost to ensure correctness and propagate rate
>> changes across the clock tree.
> 
> We already struggle with slow pre-relocation performance, something I
> have never really dug into.
> 
>>
>> Just comparing the binary size of sandbox64_defconfig with uCCF vs
>> CCF_FULL, CCF_FULL results in a 135k size increase in the binary. I
>> haven't done any more detailed analysis here (still haven't got buildman
>> to play nice...).
> 
> Sandbox may overestimate the size here, not sure. Ping on irc if you
> need update with the buildman setup.
> 
>>
>> === SPL ===
>>
>> This RFC doesn't have any SPL specific support, I think this role is
>> better fulfilled by UCLASS_CLK.
>>
>> === U-Boot's old CCF port ===
>>
>> The original CCF port done for IMX platforms is vastly different in API,
>> scope, and function to CCF_FULL, to differentiate I refer to it
>> as "uCCF".
>>
>> I have kept support for this in and made it mutually exclusive with
>> CCF_FULL. uCCF drivers have been moved to drivers/clk/uccf, with the new
>> CCF port in drivers/clk/ccf.
>>
>> Included near the end of this series is a port of Sandbox's clk-ccf
>> driver from uCCF over to CCF_FULL, this might be a useful reference for
>> other drivers (although it's probably better to just adapt the Linux
>> drivers).
>>
>> === Compat shim ===
>>
>> Lastly, this series includes a compat shim which allows UCLASS_CLK
>> drivers to somewhat work with CCF, I would imagine this being useful
>> if some generic peripheral device provides a clock for example, but in
>> almost all cases I think it's better to implement a proper CCF clock
>> device. Unless there is a particular usecase for this I would probably
>> not include it in the next revision.
>>
>> == TODO/Outstanding issues ==
>>
>> * Clean up clk-uclass.c, does it make sense to somewhow split it in two?
>> * Assess test coverage, have basic sandbox tests, would like to mostly
>>    use integration tests (i.e. diff the clk summary) once more platforms
>>    are supported.
>> * pre-relocation support is currently missing, on Qualcomm at least I
>>    would prefer to completely skip FDT scanning pre-reloc, there is a
>>    patch in this series which does that. It is very non-trivial to try
>>    and handle clocks pre-reloc.
> 
> Does this mean that only serial is needed and the clock for it is
> already set up by some pre-U-Boot phase?
> 
> Regards,
> SImon

