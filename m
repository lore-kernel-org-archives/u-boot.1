Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05ECBC36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 17:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68AFC81E5B;
	Tue,  1 Apr 2025 19:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="GNt0bcp5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9602381ECD; Tue,  1 Apr 2025 19:27:21 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D8EA81703
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 19:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=64a0=WU=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1743528437;
 bh=2mNE+bDo3mPJeH0Yl1bssrLHxTPAqzwa39fw0fLDjGI=;
 b=GNt0bcp5L5l/lbxcSkVLXWeaTMKivjltgCVBhH76vK+c9HhrfpdiAHGT6GIDaw7KqxSlDwW2A
 dvTs7+/dE83tKz2gVfW1XnRXKzhYJW8EaKyWSub6VOSak5hT92Q/w22bVNr5Y3eT0lWFAhywZMQ
 HA0ToTCRRPn4jltuNMBvWBEbTS/rAm2l89IjVlUQFlD2DWmM1526FHp+JBSNOI/9b5swMYl7+hS
 HTlXEHSwc8Rvb9xlR99CbCoY0AZimdu8sOOmka8tqDwf1ZDFebDn71AL4XlXOdVI2Kc79HAIrAr
 NDVXAp8aBKdwP/Uh9O5pjmQfAM9HWbPqJJn6pPhoBTug==
X-Forward-Email-ID: 67ec21f100d8331c283c99e6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <4916425a-8021-4bbc-b24f-a9d780ce0ac6@kwiboo.se>
Date: Tue, 1 Apr 2025 19:27:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/31] rockchip: Provide a VPL phase on rk3399
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Dragan Simic <dsimic@manjaro.org>, Greg Malysa <greg.malysa@timesys.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 huang lin <hl@rock-chips.com>
References: <20250328153522.3555472-1-sjg@chromium.org>
 <20250328153522.3555472-20-sjg@chromium.org>
 <6721d34c-83eb-44d9-9be5-a4f8346481e3@kwiboo.se>
 <CAFLszTiEwMqyhwJ6NvkhpE3cOw7z+VHmhqMdHcPVGyr6rK4yEA@mail.gmail.com>
 <99333ff1-f794-410b-aade-fd73450d5a1f@kwiboo.se>
 <CAFLszTiwdr_E-O=UoVGfTTyjsJ_t9LvSPGD2v2cTKp=fhLgW5Q@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszTiwdr_E-O=UoVGfTTyjsJ_t9LvSPGD2v2cTKp=fhLgW5Q@mail.gmail.com>
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

Hi Simon,

On 2025-04-01 17:42, Simon Glass wrote:
> Hi Jonas,
> 
> On Sun, 30 Mar 2025 at 05:46, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Simon,
>>
>> On 2025-03-29 00:40, Simon Glass wrote:
>>> Hi Tom,
>>>
>>> On Fri, 28 Mar 2025 at 10:16, Jonas Karlman <jonas@kwiboo.se> wrote:
>>>>
>>>> Hi Simon,
>>>>
>>>> On 2025-03-28 16:34, Simon Glass wrote:
>>>>> Add support for this new phase, which runs after TPL. It determines the
>>>>> state of the machine, then selects which SPL image to use. SDRAM init is
>>>>> then done in SPL, so that it is updatable.
>>>>>
>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>> ---
>>>>>
>>>>> (no changes since v2)
>>>>>
>>>>> Changes in v2:
>>>>> - Rewrite help for VPL_ROCKCHIP_COMMON_BOARD
>>>>> - Skip spl-boot-order.c for VPL (rather than modifying it)
>>>>>
>>>>>  arch/arm/include/asm/spl.h               |   1 +
>>>>>  arch/arm/mach-rockchip/Kconfig           |  25 +++++-
>>>>>  arch/arm/mach-rockchip/Makefile          |  11 ++-
>>>>>  arch/arm/mach-rockchip/rk3399/Kconfig    |   9 ++
>>>>>  arch/arm/mach-rockchip/spl.c             |   3 +
>>>>>  arch/arm/mach-rockchip/tpl.c             |   2 +-
>>>>>  arch/arm/mach-rockchip/u-boot-vpl-v8.lds | 107 +++++++++++++++++++++++
>>>>>  arch/arm/mach-rockchip/vpl.c             |  53 +++++++++++
>>>>>  common/spl/Kconfig                       |   1 +
>>>>>  9 files changed, 205 insertions(+), 7 deletions(-)
>>>>>  create mode 100644 arch/arm/mach-rockchip/u-boot-vpl-v8.lds
>>>>>  create mode 100644 arch/arm/mach-rockchip/vpl.c
>>>>>
>>>>
>>>> This patch and therefore this series does not apply to the next branch.
>>>>
>>>> Are there any depends that are missing or are you only testing based on
>>>> your own fork?
>>>
>>> Until we are ready to apply things, yes I am using the sjg tree. See
>>> the tags in the cover letters of patches I send. For this one it is:
>>>
>>> base-commit: 3f76d803db9b500f43bc534465945a8d2836bb3e
>>> branch: vbi3
>>
>> This base-commit does not even exist in your vbi3 branch :-/
> 
> Are you sure? The base commit works fine for me:
> 
> $ pe 3f76d803db9b500f43bc534465945a8d2836bb3e
> 3f76d803db9 (ci/master) Merge branch 'ci' into 'master'
> d07049b9f28 (el/ci) arm: Support a separate stack for VPL
> abfff044f26 spl: Use CONFIG_VAL() to obtain the SPL stack
> 7a032a125f5 spl: Add an SPL_HAVE_INIT_STACK option
> 8d319b22019 tpl: Rename TPL_NEEDS_SEPARATE_STACK to TPL_HAVE_INIT_STACK
> 794124b3258 Merge branch 'ci' into 'master'
> 
> The branch name is a local branch, not necessarily pushed anywhere. Is
> there some better terminology that I should use there? Perhaps
> 'local-branch' ?

Probably, I did a git fetch of you public vbi3 branch:

  git fetch https://sjg.u-boot.org/u-boot/u-boot.git vbi3

And that did not include 3f76d803db9b500f43bc534465945a8d2836bb3e:

  fatal: bad object 3f76d803db9b500f43bc534465945a8d2836bb3e

So yes, if you keep a public branch with same name as you say in your
patches, I would expect it to be somewhat up to date.

> 
>>
>>>
>>> So no, there is nothing else that this series depends on and if you
>>> can review it I can send a PR for Tom for -next one all necessary
>>> changes are made.
>>
>> Sorry, this does not help, my main concern is testing that this does not
>> break or affect anything for the remaining Rockchip boards. Something
>> that is hard to test and validate when patches do not even apply to any
>> of the mainline master or next branches.
>>
>> Sending patches based on a tree that has diverged with around 677 files
>> changed, 20072 insertions(+), 17023 deletions(-), if my git fu is
>> correct, and then expect us to test based on this diverged tree does not
>> help with gaining confidence in this series.
>>
>> I can understand keeping a personal tree that will diverge at times,
>> i.e. my personal tree has ~120-150 patches on top of mainline master.
>> However, I always try to keep my work-in-progress branches rebased on
>> top of master or next.
>>
>> For v4, please send a series based on mainline master or next branch,
>> as stated in "General Patch Submission Rules" [1] in the U-Boot docs.
>>
>> If the series has some depends, I suggest you also publish a branch
>> to a public repo with any limited depends applied on top of master or
>> next along with the patches in your series.
> 
> For now I am going to wait until you pick up your clean-up of part of
> my series. Then I can pull that in any try to send the final VBE
> series again.

I sent out a "rockchip: binman: Use a template for FIT and other
improvements" series [2] that picked up some of your rockchip binman
image related patches.

[2] https://patchwork.ozlabs.org/cover/2066701/

> 
> I haven't had any rockchip patches rejected, so we should be able to
> resolve this.

They have not been properly reviewed (or tested) yet, as they have never
applied cleanly on any mainline tree, with repeated requests to fix that.

For me to review something, I want to be able to run the code, and run it
on a code base as close as possible to where it intends to be merged.

E.g. v1 was broken and had hidden depends that you had applied to your
personal tree, and only later was sent out and now merged into mainline.

I have some other concerns to validate, but have waited on a version
that can be applied before continuing a review. Please consider this a
NAK until it can properly be tested (i.e. reviewed) using a branch with
a minimal diff to mainline master or next.

Regards,
Jonas

> 
>>
>> [1] https://docs.u-boot.org/en/latest/develop/sending_patches.html
> 
> Regards,
> Simon

