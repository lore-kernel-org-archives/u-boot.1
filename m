Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE4BC282D3
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 03:56:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCCA080F56;
	Wed,  5 Mar 2025 04:56:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741146969;
	bh=6FqyqRL/SUYBmSYbKcS9ptn/jKN4jgrw2fL0s5iyr/8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B9t7pfr9ugbZErsRGqfqCr8GH+EuRwgZeZeI1RiUQOnWUJls6ElPWQxQyhNXcJqPS
	 u+KAPukh12Ym4vHHs9tmabIb0qIS3IMYAK3a8Tp3On+CuYftWVfViOVVfEEAv7GXko
	 gWk64w+ub6xln/VGnrNXxFBOdzchJGrfUdG4/rJ24SvZkKvtNlAwdJS3uvKo34fKQG
	 ofDBhLA1f4S3GAScp1vC3qhonQLvWMU0jroRPKv3HzCtlAwaw3bGizKC2LM27foeCH
	 C4NtGIm8GIpQuXVWOG9/CkHTR6DNWK9V968byCGOZrnD4aNCOEfwUyU9YWT03orEwg
	 QzsTt3xvy14xw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F174807D9; Wed,  5 Mar 2025 04:56:08 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86349807D9
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 04:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="MXzAptR9"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CA85D10381917; Wed,  5 Mar 2025 04:56:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741146965; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=6FqyqRL/SUYBmSYbKcS9ptn/jKN4jgrw2fL0s5iyr/8=;
 b=MXzAptR9X2pyirrChNf+0JdeNd0V46k4X7+Wq2iNcjR2g6A2byI98V27OuYnRQy2G4zoAm
 SEIRD9p/aHqIHLwhRbexV9jcwSN/6M4+N5Dy0URQYmUACdbgpqjd90hIy7ZXPh28i2uoEH
 ICcCwOquyosho99ZzGDsh1RR4IXmXvGFyuWOT9uoiUgn1GXaIX8865lnCH/W6Rkm6EWzR0
 zuMHkuLDwnz6ZqdtY13mHoUF1xzGhVQCgL6auz+j0hGeg0NySTxHwAWnz8JuBwbdrRWHso
 77ZMUYzMqXfVp9uzICM4jQLylw22C1rYvR1603YdgyHDZAX13sQgg74Dp4msNA==
Message-ID: <64eb3e33-d018-4f11-b82a-fb2043678375@denx.de>
Date: Wed, 5 Mar 2025 01:55:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/setlocalversion: Reinstate .scmversion support
To: Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250302183128.326418-1-marex@denx.de> <87tt895etl.fsf@prevas.dk>
 <4ef833aa-49b3-4af8-b77b-4b3f3f6b184e@denx.de>
 <20250304144249.GY2640854@bill-the-cat> <87ldtk5vm0.fsf@prevas.dk>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <87ldtk5vm0.fsf@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 3/4/25 10:33 PM, Rasmus Villemoes wrote:
> On Tue, Mar 04 2025, Tom Rini <trini@konsulko.com> wrote:
> 
>> On Tue, Mar 04, 2025 at 03:28:17PM +0100, Marek Vasut wrote:
>>> On 3/4/25 10:24 AM, Rasmus Villemoes wrote:
>>>> On Sun, Mar 02 2025, Marek Vasut <marex@denx.de> wrote:
>>>>
>>>>> The .scmversion is used by oe-core to append U-Boot version string.
>>>>>
>>>>> LOCALVERSION is not fully compatible replacement as it adds trailing
>>>>> "-dirty" string at the end of version string in case the U-Boot git
>>>>> tree contains uncommitted changes. This behavior itself is correct.
>>>>> However, OE builds do clone U-Boot sources from git and may apply
>>>>> additional patches on top, which are not tracked in U-Boot git tree,
>>>>> but rather in the OE metalayer git tree, which leads to the addition
>>>>> of "-dirty" string as well.
>>>>>
>>>>
>>>> ... which is then _also_ correct, no?
>>>
>>> No
>>>
>>>> It means that U-Boot is built from
>>>> v2024.10-321-gabcd1234 plus some entirely unknown additional patches,
>>>
>>> This is not true, the patches are known and tracked in the OE layers.
>>>
>>> They are not uncommited ad-hoc local changes.
> 
> Perhaps, but the resulting binary has no indication of what those
> patches are or whether they are indeed under some external revision
> control.

Whatever indication vendors might need can be inserted via 
UBOOT_LOCALVERSION . That indication is up to vendors , not up to 
oe-core to decide.

>>>>> The .scmversion used by oe-core used to replace the version string
>>>>> suffix fully, including the "-dirty" string. Reinstate support for
>>>>> the .scmversion to let OE core do exactly that as it used to do it.
>>>>
>>>> No, please don't. Let's not let this script deviate from upstream linux
>>>> again, and let's instead try to fix the bug in oe-core
>>>
>>> There is no bug in oe-core.
>>>
>>> U-Boot commit Fixes: 5c02350fa03d ("scripts/setlocalversion: sync with linux
>>> v6.9") introduced breaking change, the removal of .scmversion support . This
>>> patch fixes it. It is as simple as that.
> 
> Huh? Since when isn't adapting to changes in the upstream project the
> responsibility of distros and downstream meta-build systems?

Adapting is fine, breaking change like this is not.

The aforementioned commit removed functionality on which other projects 
depend, that is a bug, sorry.

OE-core can be adapted to whatever new mechanism, but it should be 
adapted first and then the .scmversion can be removed from U-Boot once 
most users converted over, not the other way around.

>>>> that (ab)uses
>>>> this legacy .scmversion file. The fundamental bug is that oe-core
>>>> creates these .scmversion files unconditionally, even if they end up
>>>> empty, making CONFIG_LOCALVERSION_AUTO completely useless. I have long
>>>> since worked around those bugs in my own u-boot and linux recipes, but
>>>> I'd much rather be able to eventually drop those workarounds.
>>>>
>>>> Why doesn't doing what kernel.bbclass has done,
>>>>
>>>> export LOCALVERSION = "${UBOOT_LOCALVERSION}"
>>> U-Boot and Linux builds in OE-core work differently.
>>>
>>> Linux uses SCC to apply patches onto a git tree (i.e. it behaves like "git
>>> am *patch") and therefore the "-dirty" suffix is not added.
>>>
>>> U-Boot recipe uses plain bitbake do_patch to apply patches, and therefore
>>> the build tree is effectively dirty and the "-dirty" suffix is added. The
>>> .scmversion overrides the dirty suffix.
> 
> I certainly don't; our u-boot and linux recipes both point at some
> specific SRCREV, with any necessary patches maintained in a git repo. No
> patches "maintained" in bitbake metadata.

This kind of setup usually fails when some of the random git repos that 
is poorly mirrored or not mirrored at all goes away. Then someone tries 
to build the metalayer and they cannot access the sources anymore, fail.

That is why bundling patches into the OE BSP layers is much better, if 
the user has local clone of the layer, and they depend only on well 
mirrored repositories, even if some random downstream git repository 
goes away, it is unlikely they wouldn't be able to clone upstream 
projects from somewhere and apply patches from the BSP layer on top.

>> Yes, but that's Rasmus' point isn't it?
>> 0592671fbba8c96df043d537d1f6415492de886e (v2025.01 hash) in oe-core
>> isn't the same as in mainline because there's patches on top and it's
>> non-obvious.
> 
> Exactly. When I have some customer device and need to debug some U-Boot
> or linux problem, I want the U-Boot banner/uname -r to tell me exactly
> what revision that was built from.

That is exactly what UBOOT_LOCALVERSION is for , yes. And that 
UBOOT_LOCALVERSION functionality is currently broken and this patch 
fixes it .

> That's why the .scmversion munging in
> oe-core has always bugged me (because they've always added an _empty_
> file, making CONFIG_LOCALVERSION_AUTO useless), and as I've said I've
> had workarounds for that in place forever.

This is a separate topic, OE-core can be fixed, but existing 
functionality should not be broken.

> I strongly prefer to keep the setlocalversion script in sync with linux
> as far as possible (there's a '| tr ...' due to U-Boot not being catched
> up with all of kbuild) and not have to remember to forward-port patches
> when re-syncing, but I'll defer to Tom now.
If this script is already out of sync, then extra four lines which are 
well documented won't make it much worse.
