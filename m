Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BB7D30CF6
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 01:28:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00983800AE;
	Wed, 14 Jan 2026 02:28:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="nXpQlu9S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C8BD802C1; Wed, 14 Jan 2026 02:28:51 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF1E58003E
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 02:28:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1768354120;
 bh=uiJmSn/o4gt9Gc6wC+r3IlGUDTc6r1ue3bzMFdzezsM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nXpQlu9SrdXZmnpvoWpardlneCfsqWfvUUEWTH+rSuWCr868/FYezUhec75kslkHF
 GKJR2hPOc0nVdGr7cmvfdoxHnLX5Qt+0jdihvkFIVxqrQv1Kx2AXDRSXA6QyAUuv3v
 gzc71nRQfrYVkbYRfiDEnOrfbEIPep6HkA0NboH4g+rHDzSvPwKAI0Y4w7heNuuMEf
 8ckSdJ/pjnRvh9mVsKKcz6wsa7HuCFGc8YiHhZfYXIRyfSQ8R5iRpjh6i/K7jyV5xA
 pJ07M5okcrn6DJs2X1hF2MQx39g5rfzushmv07Q0z4n6Und2fGBdHRw8ggjCJ+DaF1
 dMrzy7FparvcQ==
Received: from [IPV6:2605:59c0:2078:cf00:c0b6:e37b:5515:2b98] (unknown
 [IPv6:2605:59c0:2078:cf00:c0b6:e37b:5515:2b98])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id B0931B22038B;
 Wed, 14 Jan 2026 02:28:39 +0100 (CET)
Message-ID: <6066e833-2025-475b-bc40-c79c1faf79e6@freeshell.de>
Date: Tue, 13 Jan 2026 17:28:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Pull request efi-next-20251225 (for next branch)
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <1faefbf2-e8b0-4c94-85f5-025355915e0d@gmx.de>
 <8608a798-183a-4f07-bfbc-1f45ae59a6ee@cherry.de>
 <20260108210203.GW3416603@bill-the-cat>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20260108210203.GW3416603@bill-the-cat>
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

Hi all, an update follows confirming the revert of commit 4c105d2ae7b0:

On 1/8/26 13:02, Tom Rini wrote:
> On Thu, Jan 08, 2026 at 05:20:52PM +0100, Quentin Schulz wrote:
>> Hi Heinrich,
>>
>> On 12/25/25 11:13 AM, Heinrich Schuchardt wrote:
>>> Dear Tom,
>>>
>>> The following changes since commit
>>> baf076aeb32dcdd2b022405088c3288ffc160fcf:
>>>
>>>    Merge branch 'staging' of https://
>>> eur02.safelinks.protection.outlook.com/?
>>> url=https%3A%2F%2Fsource.denx.de%2Fu-boot%2Fcustodians%2Fu-boot- tegra&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cf87dd0f90d6b45f7ce7508de439e34da%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639022543931009936%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=UrWok7nyXyLT97iLd1o%2FxUIuYtwkRz7DcO8D8ogdH7Y%3D&reserved=0
>>> into next (2025-12-23 08:11:36 -0600)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://eur02.safelinks.protection.outlook.com/?
>>> url=https%3A%2F%2Fsource.denx.de%2Fu-boot%2Fcustodians%2Fu-boot- efi.git&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cf87dd0f90d6b45f7ce7508de439e34da%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639022543931023452%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=noF%2B4QWCdd9uds%2FLv5wxiCynT7PNTHKQFnDHXYn2%2BqQ%3D&reserved=0
>>> tags/efi-next-20251225
>>>
>>> for you to fetch changes up to 4c105d2ae7b0f847668ff1ef6b410f63ab4290b7:
>>>
>>>    doc: board: starfive: update jh7110 common description (2025-12-24
>>> 09:41:57 +0100)
>>>
>>> ----------------------------------------------------------------
>>> Pull request efi-next-20251225
>>>
>>> Documentation:
>>>
>>> * Update StarFive Jh7110 common description.
>>> * Describe command line options of the bdinfo command.
>>> * Describe configuration dependencies of the bdinfo command.
>>>
>>> UEFI:
>>>
>>> * Trigger capsule updates with automatically generated boot options.
>>> * In the LoadImage unit test add a check that device-paths are correctly
>>>    used.
>>> * In the variables at runtime test remove an unnecessary
>>>    __efi_runtime_data attribute.
>>>
>>> Others:
>>>
>>> * Let the bdinfo command output device-tree information even if LMB is
>>>    no used.
>>> * Add long help texts for all options of the bdinfo command.
>>>
>>> ----------------------------------------------------------------
>>> E Shattow (1):
>>>        doc: board: starfive: update jh7110 common description
>>>
>>> Heinrich Schuchardt (4):
>>>        efi_selftest: Enhance LoadImage test
>>>        efi_selftest: remove unnecessary __efi_runtime_data attribute
>>>        test: dm: clk_ccf: clean up assert statements
>>>        cmd/bdinfo: LMB and device-tree are not related
>>>
>>> Ilias Apalodimas (1):
>>>        efi_loader: Trigger capsule updates with automatically generated
>>> boot options
>>>
>>> Quentin Schulz (3):
>>>        cmd: bdinfo: provide long help with all options
>>>        doc: cmd: bdinfo: specify required dependency for some info
>>
>> In the future, can you please consider editing the commit log when you're
>> doing modifications to patches when merging them?
>>
>> Something like
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> [added symbol dependency to lmb_dump_all]
>> [removed CONFIG_LMB as symbol dependency of devicetree]
>> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>
>> ? So that there's some info about what was changed from the patch that was
>> sent to the ML and by whom?
>>
>> (Maybe ask for permission before doing this as well, or maybe we should have
>> documentation on what can be expected from maintainers to that regard? I
>> know Buildroot does this a lot (and often silently), Yocto sometimes, but
>> the kernel not too often, and it's the first time (that I know of) it
>> happens to me in U-Boot :) )
>>
>> I'm generally not a fan of my patches being silently modified before
>> merging, though here it ended up fine so thanks for sparing me the rebase+v3
>> respin I was thinking about starting to do :)
>  
> I have, over the years, sometimes added [trini: foo] and a SoB tag, and
> more recently made us of b4 making merge commits of a series trivial
> (which is great and this is yet another reminder to anyone reading that
> cover letters on series are important because they become the merge
> commit message) and dealing with both merge issues and trivially correct
> changes such as spelling or spacing fixes in the merge commit itself.
> 
> What this does speak to however is that we need to document the
> expectations here as it's clear implicit expectations have been
> violated, and that's on me in the end to make sure are clear and
> explicit. I'll write up something for doc/develop/process.rst in the
> next few days.
> 

Patch commit 4c105d2ae7b0 "doc: board: starfive: update jh7110 common
description" is reverted in commit d503633a3676. There's a discussion
ongoing about improving process documentation "doc/develop/process.rst:
Expand on the Custodian workflow":
https://lore.kernel.org/u-boot/20260109172905.1446923-1-trini@konsulko.com/

With the assistance today of Tom for the revert I consider the
mishandling resolved. Thanks, Tom!

For Heinrich, as to the content of my peer-reviewed patch if there is a
serious objection to its original format such that it needs to cycle on
the list another round or two prior to re-application then that is okay;
Let us know if another round is needed. In any case I welcome that the
patch be handled without delay as it was reviewed.

-E
