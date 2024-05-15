Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9072C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 09:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBA3F88013;
	Wed, 15 May 2024 11:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="J0qD5Kem";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9978088076; Wed, 15 May 2024 11:39:25 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E333C87DB0
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 11:39:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=71b8=MS=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1715765955;
 bh=O4QvhocsYbypPSb7IzIyA/S/Q6Kf/WxlrwEZzZ27QkI=;
 b=J0qD5Kem/P8RdduYYPqh9Lm+LiOyY/p0NL2e6N5MQYMir16AZ7Gm/fMs0hdnxlE/OZuqupdTj
 nXzgulOYxyu+yVx6tq13UsXohW4zNg0HQtnUPnZJYYi5K37v6YmqP0PWjwmnB9TorAXk1Koo+0e
 Iiepc+jQKz8PvBvFXR0veGP+8HWfelwvT9ckziVb8tygmDaHbENyGfgQpd7Hyac/cH0bsgOd3Xv
 KjHgCiD29+qH+Kynlr0tSACDsJr7fwGPc8+eI8i7ecX0BBufqVjtf/eh38lh1iHK9hnhQtrqS5+
 6lx0SbpAM2qnD8xBuipy4ZtvkosMs/3uwPjDMm/AVbEw==
Message-ID: <e26ab5cc-2b2d-4e96-a073-819a935f435a@kwiboo.se>
Date: Wed, 15 May 2024 11:39:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Squashed 'dts/upstream/' changes from
 b35b9bd1d4ee..7e08733c96c8
To: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240514164236.516595-1-trini@konsulko.com>
 <b12a9b07-2c92-4651-b6ba-3aff6ecc9219@kwiboo.se>
 <CAFA6WYPsicMrtrDg7T8m=4-vg-QAPUY1D5E=_T8gZYgT=o2b4Q@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFA6WYPsicMrtrDg7T8m=4-vg-QAPUY1D5E=_T8gZYgT=o2b4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 664482c1eb0b49d3b1862f5b
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

Hi Sumit,

On 2024-05-15 10:49, Sumit Garg wrote:
> Hi Jonas,
> 
> On Wed, 15 May 2024 at 13:11, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Tom,
>>
>> On 2024-05-14 18:42, Tom Rini wrote:>
>>> git-subtree-dir: dts/upstream
>>> git-subtree-split: 7e08733c96c84eb323f47e9b248c924e2ac6272a
>>> ---
>>> This moves OF_UPSTREAM to be tracking the v6.9 release and is for the
>>> -next branch. To test these changes yourself locally, either use my
>>> "WIP/14May2024-next" branch or run:
>>> ./dts/update-dts-subtree.sh pull v6.9-dts
>>> yourself locally. I intend to wait a few days to apply this to -next, to
>>> give people time to test.
>>>
>>
>> There are currently more boards/SoCs that use OF_UPSTREAM in master
>> branch than in next branch, a few Rockchip SoCs and other boards/SoCs.
> 
> Glad to see more OF_UPSTREAM adoption.
> 
>> Next dts/upstream sync will probably be good to do together with a merge
>> of master into next :-)
> 
> I don't have any particular opinion here and rather leave it upto Tom
> how he would like to merge stuff.
> 
>>
>> Also what is the expected sync cadence of dts/upstream? Linux v6.10 will
>> probably be released shortly after U-Boot v2024.07. So will next sync be
>> to v6.10-dts if that happens in the U-Boot merge window or do we expect
>> 2024.10 to use v6.9 DTs if the v6.10 release gets delayed and miss the
>> U-Boot merge window?
>>
>> Linux kernel typically have all major DT changes in -rc1 and fixes in
>> later -rcX, so for next branch I would suggest an early sync to a
>> v6.10-rcX-dts tag, and then sync to the final v6.10-dts tag once v6.10
>> gets released. That should give more time for testing, migration and
>> cleanup using v6.10 DTs in time for a 2024.10 release.
> 
> I can see the reasoning for an aggressive DT syncing approach, it has
> been brought up in the past too. And the major reason for the current
> moderate sync approach [1] is to limit any DT ABI breakages for
> U-Boot, we are even prone to breakages with syncs against major Linux
> kernel releases (eg. v6.10-dts etc.). It has been a long time
> discussion topic where we have been advocating about requirements for
> DT ABI stability [2].
> 
> So having DT syncs done during the merge window will shorten the
> testing window for developers/maintainers. And more syncs means a
> multiplicative factor for testing. However, time will tell with more
> and more platforms adopting OF_UPSTREAM, if there are any real DT ABI
> breakages seen in the future. But surely if they are very rare then I
> am open to adopting aggressive DT sync approaches.

I agree that syncing multiple rcX tags may not be that helpful, but an
approach where maybe rc1, rc2 or rc3 and then the final tag is merged or
something similar. At least when we can foresee when next Linux version
will be released close to an U-Boot release. At least early in U-Boot
release cycle know what Linux version dts/upstream will be targeted.

My main concern is how to best handle new boards and features/drivers.
E.g. for Rockchip the RK3588 SoC is under active development, new boards
and features/drivers are actively added/fixed in upstream Linux.

New Rockchip boards have typically been added after board DT have been
merged into linux maintainer tree. Now if we wait until merge window to
do a dts/upstream sync, the result may be that it may take up to three
U-Boot releases until a new board is easily added using dts/upstream.

Another approach could be that we add new boards using !OF_UPSTREAM once
they are merged into linux maintainer tree. And then migrate the board
to use OF_UPSTREAM once the board finally ends up in dts/upstream.

But that can also be problematic when board .dts-file start referencing
nodes/symbols not yet added in the soc .dts-file in dts/upstream.
Adding the "missing" but maintainer merged soc nodes to the soc
u-boot.dtsi could be one way to work around such issue.

Anyway, some guidance, predictability and earlier sync related to
dts/upstream would be much appreciated :-)

Regards,
Jonas

> 
> [1] https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing
> [2] https://www.mail-archive.com/boot-architecture@lists.linaro.org/msg02162.html
> 
> -Sumit
> 
>>
>> Regards,
>> Jonas

