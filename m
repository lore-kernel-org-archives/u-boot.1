Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35EAD75BB2
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 04:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BDC289634;
	Thu, 21 Nov 2024 05:18:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732162721;
	bh=2u9pW5UjD6tGMdOmjTOKEcQrkL/qMsnDMgpXgWc9YXc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uUCTcXnCqIB5J+dDxQRoZ3bCqYw1Su+38cLJZ+HU2GnZfpJJRybgWgcSL+QITD33N
	 0Qw1iCMA3KZEK1eUxcqW38Thijl+FUMPMPlAx2EvOWJblCrOW80b4A0iOoczkDUJ5w
	 rlYGiq4kj2TNlRe3fL6cThZUPQW0ESi7H8OLtboHNgwO1/o9AUy17vpGx/A9EDJPz1
	 B7YqPkc7o5qtdKrbuTxyMC96GVk9ITcba+cMO73Wj2VFgFoDuDknHc8tMEfZbsMmsB
	 kmtWnJCBWUqgk+2n0eueKfxgTvAFzzulnLZp1UhWVRUsVvy+P8c1rSh6p9+VSljQp4
	 MtjEZ4oUhEpDg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CABED89625;
 Thu, 21 Nov 2024 05:18:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732162719;
 bh=2u9pW5UjD6tGMdOmjTOKEcQrkL/qMsnDMgpXgWc9YXc=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=EBKF0wQdOfe2T6s7epHfKmW7Ih3fa/OHuwc5o7ab6Dtxyoow5tL7/60z9TFqY6xh9
 BiwYx/yYmbZgqQIL0c0/aP8Y87Xh9XLrbATJHdxQhRTLdD6RP40Z/Qmf3+6buRfiVO
 OXdyjDF+4Pnf9dxckkoUELr2i+lqcOS+0y7KtL4Y3FN/GfVSY8I8pYMD0zKbaMFFsg
 TfiSuiBQnuNuTSGWcbk23MnsVwd6cZVHi1QsxSnWwzYhFzxlgzZUH2zV8QgAx2WP+g
 NPTqN+M0Kdu16b0gX1neKXYQvsx+EytE/F7ceyOCD/SfBXpOwOuSKuf4uwbw0Zs7ew
 NFEqp2IEzpevg==
Message-ID: <0accf15d-a9da-4713-a6d0-dfeef38d919f@denx.de>
Date: Thu, 21 Nov 2024 05:18:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v3 3/3] common: Move autoprobe out to board init
To: Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Svyatoslav <clamor95@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20241120153642.861633-1-sjg@chromium.org>
 <20241120153642.861633-4-sjg@chromium.org>
 <460f478d-62cc-4f17-8d52-00d2e1e83485@linaro.org>
 <CAFLszTjzZQ=Uaw+wjHUeP86SaHppYBMa3ZPSpFAoBwG9jJfEZw@mail.gmail.com>
 <7af74c01-1307-4be1-9603-8902d57d1137@linaro.org>
Content-Language: en-US
In-Reply-To: <7af74c01-1307-4be1-9603-8902d57d1137@linaro.org>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 11/20/24 5:55 PM, Caleb Connolly wrote:
> 
> 
> On 20/11/2024 17:03, Simon Glass wrote:
>> Hi Caleb,
>>
>> On Wed, 20 Nov 2024 at 08:51, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>
>>> Hi Simon, Marex,
>>>
>>> On 20/11/2024 16:36, Simon Glass wrote:
>>>> Rather than doing autoprobe within the driver model code, move it out to
>>>> the board-init code. This makes it clear that it is a separate step from
>>>> binding devices.
>>>>
>>>> For now this is always done twice, before and after relocation, but we
>>>> should discuss whether it might be possible to drop the post-relocation
>>>> probe.
>>>>
>>>> For boards with SPL, the autoprobe is still done there as well.
>>>>
>>>> Note that with this change, autoprobe happens after the
>>>> EVT_DM_POST_INIT_R/F events are sent, rather than before.
>>>>
>>>> Link: https://lore.kernel.org/u-boot/20240626235717.272219-1-marex@denx.de/
>>>>
>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>> ---
>>>
>>> [...]
>>>
>>>> +For some platforms, certain devices must be probed to get the platform into
>>>> +a working state. To help with this, drivers marked with DM_FLAG_PROBE_AFTER_BIND
>>>
>>> I've found the documentation around this flag lacking, and the
>>> implementation confusing. Here you say /drivers/ with this flag (which
>>> would imply I can add it to the U_BOOT_DRIVER() definition, but further
>>> below the function doc says /device/ with this flag.
>>>
>>> In practise, it seems like the flag has to be added to the device in the
>>> bind() function, and adding it to the driver definition doesn't work
>>> (this left me scrataching my head for a while). The commit message
>>> adding it explains this and it seems like the idea was to have a way to
>>> trigger probing a device from the .bind() callback.
>>>
>>> I don't think I'm the only one confused by this, since grepping for it
>>> reveals two watchdog drivers which set this on their U_BOOT_DRIVER()
>>> definition.
>>>
>>> I can only see one driver that ever enables this flag conditionally,
>>> that's the ARM PSCI driver. Every other user sets it unconditionally in
>>> the .bind() callback.
>>>
>>> Would it make sense to rework this into a driver flag?
>>>
>>> Otherwise, could you document this behaviour more explicitly in this series?
>>
>> I agree with you and I very-much want to document this better.
>>
>> The original patch[1] came with no documentation nor tests. It was
>> applied within 5 days, after Sean raised exactly the same objections
>> that I have with this feature. Those objections were overruled and the
>> patch was applied anyway.
>>
>> So here I am trying to clean this up.
> 
> Ok, good to hear. Then it would be great if at least the comment above
> the flag definition could be made more explicit (that it must be applied
> to a device not a driver).
>>
>> As to the driver thing, my main concern is that it is too easy for
>> people to add the flag, causing a large slowdown in U-Boot's
>> pre-relocation startup speed. Perhaps the solution to that could be to
>> enable bootstage everywhere and report the time in the banner?
> 
> I'm not sure what the problem is here. You're worried that people will
> set this flag when it isn't needed? This ought to be handled during
> review of the driver in question.
> 
> Certainly I don't think making features more obscure will point people
> towards better solution, more likely they'll just get frustrated,
> particularly when this flag actually IS the correct solution as is the
> case for many drivers.

The flag is per-device , see e.g. c438866b1674 ("led: Mark device 
instance with DM_FLAG_PROBE_AFTER_BIND") .

It was long needed for exactly that use case -- probe things like LEDs 
when they need to be preconfigured somehow.
