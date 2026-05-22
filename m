Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB49CD5BB1
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 13:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DA4384859;
	Fri, 22 May 2026 15:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R4xvZBcI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3EF884859; Fri, 22 May 2026 15:10:13 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEB0F846F1
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 15:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-45e7c636e74so4040562f8f.0
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 06:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779455408; x=1780060208; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=534CmwyOdwM5l32otQ4MIdBRgJ3ezGll2nTzM5XhatM=;
 b=R4xvZBcISwzTwUiajb+67DPveiAkKl+TXRcjozR0yDaH501ul57z8mNKedmcEmDXfo
 6YR8iro9xrGQfE9lw5o4XIp//y4GVRxBU8XKi/7xWMZSVYexsvF+eq36N5D0jkQn6EIB
 rSu/ijjUstbKXeakdbPisqzDsCUdF1Cc/tkeK/H3Ta1vKiYCbauEpYU2rUXLoltcXozp
 o/Ta9v9MyqbOReXsraCP5e+lTPYFf9VdU0iWyA6R2BpQ+9BuYRmdHdzaQtYr7hkok6Dn
 ZFYPLuGkncbfgGvDjJmhpsEeqHcdGCbLytMdwOOqJUJmfHK7hZf+bO+PBW9XzG1e1hx6
 6qYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779455408; x=1780060208;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=534CmwyOdwM5l32otQ4MIdBRgJ3ezGll2nTzM5XhatM=;
 b=pGq3EW6xbjKii9KBs0AuS1t62Z3WPGJdAMoh37Gy8SfaXVIUABzbCcrMfBxwMo1H5y
 76tKrP944rr/tuLO/5ANaRbxa0pLNfmw2WheC5bT5EARt5Fm6bpWltSc+p9ig2tBVr5A
 zF6hEnZ3UAXUC3/M0N5J6Mp9/m2rj5sRM+khkWCDUJzjs0B02/6A3ZUGQXzHCDiqd6zE
 Vrbu+y9yuNuFBMH1Wug+RhGtYwpDdq6r8xEDbKGh5QL+DSdjlFbms1bjnGX6IsR3kpYw
 eoxWh08teI5QIxfuWMrLirbIK6PI4nZnVPei5loQgaKOsOCqXkDTVYGjmromPJoivQOw
 ZoJQ==
X-Gm-Message-State: AOJu0Yyx97px/RSJ73S/ED5r0DUem4mTme4aKv7q3cFFcpeuLK37gNXm
 qiU9m/a1yU2UOazD+h6tmgHnhZKmm6+16Wy/TDaRq8MSnw8526TWiC7SimZeJGgdD9PGpK2Dec3
 li+0Wyzs=
X-Gm-Gg: Acq92OH/91pKyFeFdMLuPGRDStqIjbl/KWwdHqYKsuPzZn6MHGat7O99atMPk4var0P
 9nyCI27ymSkuc/MeD2Kb4/fibGDBT4EB47KovKhLahLPCRXnA/sVQ9lf4xqW0j7D91od+zsR0nI
 ScKK19uIplyKIHe5+41n7jqHs25JwCKKA+dGTafZLzpVK2YeVLbuxkOhDW1V8rTuzLxOdla2q0V
 61Ywnk9EjH4jYTRRHGSADWPmKb3eyk4qPAKr4H2pRaZxFThC4zeMRiigyYg1zIJOKJv+0cU36gB
 nfOHueFwwf88z+9OM383zJCeWa9gik4KlqDwjfxIaN2bSde55R3JxSyFu7l5K4u5FWRRHRyJJgZ
 7viRYnz2209uakrWpHs589HsQP4a95Rl0sTzCfNklJxVTJ2B3yrbmX8vlB/BAYGR1cCPP6mzBFr
 zC+ZVZZnrcjaHUxWJav0C3PBmWqK27MMzcfJj2T0sFp5mDrA6Pesx7COerZczUeEm5yw==
X-Received: by 2002:a5d:5e84:0:b0:45e:6550:9557 with SMTP id
 ffacd0b85a97d-45eb38af95dmr5618515f8f.31.1779455407799; 
 Fri, 22 May 2026 06:10:07 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d5e484sm4091306f8f.30.2026.05.22.06.10.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 06:10:06 -0700 (PDT)
Message-ID: <504b47b9-c43d-408c-aaa9-4979e3b1b7b1@linaro.org>
Date: Fri, 22 May 2026 15:10:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board/qualcomm: use bootflow for default boot
Content-Language: en-US
To: "Ricardo de Araujo (Salveti)" <ricardo.salveti@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, sumit.garg@kernel.org
References: <20260514205759.3553253-1-ricardo.salveti@oss.qualcomm.com>
 <ae4eec1e-1c5b-42d3-a26f-3911b1a2839d@linaro.org>
 <CAA_5yov+8_G2FUQ-QrKBtykt_vwZPdU-KGEzzmguYBJsUveqeQ@mail.gmail.com>
 <e13fe55d-1f43-4c07-a92a-045b0db9cf38@linaro.org>
 <CAA_5yosVpB6L6yN8gBAnMmxV7uSNjvyKtxeBV7ELGF+z18aibw@mail.gmail.com>
 <7b61004a-6166-4566-869b-7157e5563ff3@linaro.org>
 <CAA_5yova4YXN5GssCtZ-dYd94K9Ms6yqkA7zZepbtK0OxsW-3A@mail.gmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <CAA_5yova4YXN5GssCtZ-dYd94K9Ms6yqkA7zZepbtK0OxsW-3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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



On 21/05/2026 19:07, Ricardo de Araujo (Salveti) wrote:
> On Thu, May 21, 2026 at 12:32 PM Casey Connolly
> <casey.connolly@linaro.org> wrote:
>> On 20/05/2026 18:32, Ricardo de Araujo (Salveti) wrote:
>>> On Wed, May 20, 2026 at 12:08 PM Casey Connolly
>>> <casey.connolly@linaro.org> wrote:
>>>> On 18/05/2026 21:15, Ricardo de Araujo (Salveti) wrote:
>>>>> On Mon, May 18, 2026 at 4:59 AM Casey Connolly
>>>>> <casey.connolly@linaro.org> wrote:
>>>>>>
>>>>>> Hi Ricardo,
>>>>>>
>>>>>> On 14/05/2026 22:57, Ricardo Salveti wrote:
>>>>>>> The Qualcomm default environment currently boots only with
>>>>>>> 'bootefi bootmgr'. This bypasses the standard boot flow used to
>>>>>>> discover extlinux and script boot entries, which are commonly used
>>>>>>> for FIT-based Linux boots.
>>>>>>
>>>>>> We intentionally don't support these alternative boot methods upstream
>>>>>> as they aren't standardised or supported by typical distros. There are
>>>>>> also plenty of inconsistencies in Linux userspace depending on if SMBIOS
>>>>>> (DMI data) is provide or not as well as EFI runtime services.
>>>>>>
>>>>>> Could you explain a bit more why you want to support extlinux and custom
>>>>>> scripts?
>>>>>
>>>>> My main use case is for the target to automatically find and load fit
>>>>> images by default (based on the config used), which is a quite common
>>>>> use case for embedded distributions and products (see that it is also
>>>>> enabled by default on several other platforms in u-boot).
>>>>
>>>> That's understandable, and yeah I'm aware that embedded distros have and
>>>> continue to use this approach. I'm kinda wary of (and should have
>>>> disabled) bootflow, the code for it is a challenge to understand and it
>>>> has caused me headaches in the past. But aside from that, the default
>>>> environments we ship upstream are the ones that are actively maintained
>>>> and used, for qcom that's EFI.
>>>>
>>>> I'd love it if we /did/ actually directly have users of upstream U-Boot,
>>>> but as it stands today anyone shipping it will be making some
>>>> customisations to it.
>>>
>>> We expect to have meta-qcom and u-boot upstream supporting both FIT
>>> and EFI-based boots, the end user can decide which one to use, and
>>> that is why bootflow is useful here.
>>
>> If the idea is to have qcom docs suggest using upstream u-boot directly,
>> I'd propose submitting a config fragment and a custom .env for the
>> dragonwing platforms.
>>
>> I'd also strongly recommend against bootflow, you can just chain
>> commands together "bootefi bootmgr; bootm ..." to implement fallbacks.
> 
> Would it be fine to change the patch to add bootflow after "bootefi
> bootmgr" then?

If anything I'd rather disable bootflow entirely by default. How do you
actually load the FIT image to boot? Is it combined with extlinux?

> 
>>> I agree that EFI is more suitable for generic distributions, but we
>>> expect that some embedded products will leverage FIT directly, and
>>> disable EFI entirely (e.g. faster boot, reduced complexity, etc).
>>
>> I'd expect those products to fork U-Boot already and/or send specific
>> support for their board configuration upstream.
> 
> They will probably all reuse qcom_defconfig, which uses
> board/qualcomm/default.env, and that is why I wanted to have bootflow
> available there by default.

Do you have a list of boards? I don't think any of the Dragonwing boards
use qcom_defconfig currently, maybe they #include it? they also will
need CONFIG_QCOM_GENERATE_MBN once the MBN support is merged, so even if
we can get it down to a single config for all of them (which would be
awesome!) I don't think it should be qcom_defconfig. The need for
supporting non-EFI boot methods is additional justification for that.

> 
>>> Since FIT is already widely known and used in u-boot, I think it is
>>> good to also support it by default here.
>>
>> Appeals to popularity go directly against the point from my last email,
>> booting without EFI might be justified for your product but that doesn't
>> mean the /reference/ Qualcomm env in upstream U-Boot should support it.
>>
>> The reference env upstream is there primarily for testing.
> 
> I would say this is more a personal preference, my thinking was having
> both enabled and available by default to facilitate the life of every
> developer/user.

The community devs over in the #u-boot-qcom IRC channel are also focused
on EFI as far as I'm aware. To a large degree yes it's personal
preference, when there are no technical reasons justifying a change then
that's typically what it boils down to.

I'm strongly in favour of having Qualcomms dev boards be well supported
upstream to the point where there's no need to have a fork and users can
just run upstream, I'm very glad that ya'll are working towards that
goal. I'm also glad that there has been communication and discussion
about how to architecture some parts of this so that it can land
upstream and you don't have to make breaking changes later.

I think part of what we're running up against here is that
qcom_defconfig and the default environment don't really have a defined
scope with regards to what platforms and configurations are supported.
I'll share my thoughts here and maybe we can build on that?

To me it should be a maximally compatible baseline *horizontally* that
runs on as many platforms as possible with as many universal features as
possible (e.g. capsule updates, fastboot, usb, networking...) while
being minimally *deep*.

So the image it creates requires different post-processing for every
different platform/board (be that building an Android boot image or
baking it into an MBN). The image can boot with EFI and gets you to a
working system but it won't handle PXE boot or expose a UI that can be
navigated with volume keys on a phone. It doesn't support every
filesystem or have secureboot, and so on.

If you want additional features to support a specific board or usecase
more deeply (like emitting .mbn files directly, booting in a
non-standard way, storing the u-boot env on a partition) then you have
to make some changes to the build configuration.

Attempting to enable/use bootflow in the most generic qcom_defconfig
might improve things for the platforms/configurations you care about but
it's also a level of vertical integration that does have an impact on
other platforms that use the same configuration.

To pick an arbitrary example, bootflow has an "Android" boot method,
it's quite possible that on some dev boards or phones U-Boot might then
attempt to boot Android from one of the boot partitions, this could
result in the device booting to a broken state, infinitely booting
U-Boot (if it's chainloaded), crashing, crashlooping, maybe U-Boot tries
to update the slot status and touches something on the misc partition
that makes ABL crashloop and potentially hard bricks a phone (since many
vendors don't provide signed firehose or even a way to access EDL) so
someones perfectly fine device becomes landfill.

I don't know how likely any of those outcomes are, but given how
crash-heavy all of the non-EFI boot paths are I'd really rather not
tempt fate.

Hence, I'd feel much more comfortable if we all worked to minimise
unnecessary scope, having board/usecase specific configurations is
absolutely the best way to do that and as a bonus make it much easier to
justify a lot of quality of life improvements that only make sense in
specific cases.

That's why I would much rather see a dragonwing defconfig and default
environment where we don't have to worry about some change breaking
someone else with a completely different setup.

> 
> Thanks,
> 
> Ricardo

-- 
// Casey (she/her)

