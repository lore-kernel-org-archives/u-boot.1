Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5873AC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 23:55:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5905787858;
	Thu, 21 Dec 2023 00:55:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="QtKW9RVA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AECE287853; Thu, 21 Dec 2023 00:55:23 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0C538781A
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 00:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1703116521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Rb7sjfwS+26MflMSKUc7y1LBkauXNl952/yQNYAn1E=;
 b=QtKW9RVAdlsAFeqw2Krr+Kc4KLUbmUik9s32P0VKjrHcBH8jx+t8gwaiFqTXKgh/O6R+dO
 6on6TbBAGV/QUdkh4eLugTn9tpO1C7RgBE3blBiwvLi99NcfqaPZSJL94GitD5K7Kek041
 zI2fczXODHicxG3vsQlUFHL1Y5JbRT4y9o/yLgyeBrvyCWtrDxtuSE8ATCsAGOePTvIlNV
 E/qeYCIWWw1305s95q5KUn+pOEStj01BPbq62O+4XLTtPc6FeGThC/Vdo3uBXb3HvhC/NQ
 x2lY9xvNrwpLnYaZkw1wG+NjKrlFOFRbXw9Fo1nWkIKoKmxHoE/PJGEnkAX4PQ==
Date: Thu, 21 Dec 2023 00:55:20 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Cs=C3=B3k=C3=A1s_Bence?= <Csokas.Bence@prolan.hu>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Daniel Golle <daniel@makrotopia.org>, Mark Kettenis
 <mark.kettenis@xs4all.nl>
Subject: Re: Passing boot logs to Linux?
In-Reply-To: <5fd64984-4715-4880-ba27-ef78094da6cb@prolan.hu>
References: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
 <CAPnjgZ01=y-Kf=XmDv6UyEdPgXLp8bhZnSZDBVk1FPfBh8CdOw@mail.gmail.com>
 <6ae238be-3c5f-5ef6-9e18-282be9ae24c2@gmail.com>
 <16e633f9d4b1c426aaca510157479d65@manjaro.org>
 <51121aee-faca-4196-8532-719fb6ec9bdc@prolan.hu>
 <2c108e1ff92db2b74f5ccccd770872a7@manjaro.org>
 <5e0e71a5-f3c8-413e-96a3-a0b6edee928f@prolan.hu>
 <3900f4b15852d0af65635b3a794d34af@manjaro.org>
 <f22f86ec-987f-4404-8722-82270f1e8da8@prolan.hu>
 <d1350e2c5ff1da1cf10c92b1b49dec6b@manjaro.org>
 <5fd64984-4715-4880-ba27-ef78094da6cb@prolan.hu>
Message-ID: <e37be8c4cfc8ed28aca43e35f752fc8b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2023-12-21 00:27, Csókás Bence wrote:
> On 2023. 12. 20. 20:58, Dragan Simic wrote:
>> On 2023-12-20 20:24, Csókás Bence wrote:
>>> On 2023. 12. 20. 9:29, Dragan Simic wrote:
>>>> On 2023-12-20 08:52, Csókás Bence wrote:
>>>>> That's what I read as well. Is there support for U-boot to write 
>>>>> and
>>>>> Linux to read PStores?
>>>> 
>>>> No and yes, but U-Boot can already read pstore.  Please see
>>>> doc/usage/cmd/pstore.rst for the U-Boot part, and
>>>> Documentation/admin-guide/pstore-blk.rst for the Linux kernel part.
>>> 
>>> Irrelevant, as we only want to write out the console log to U-Boot, 
>>> and
>>> not the other way around (that's for collecting panic logs, which is
>>> already implemented).
>> 
>> Quite frankly, this is a bit confusing to me.  Why should it be
>> irrelevant, if we want to store the U-Boot console logs into the 
>> pstore,
>> and read them later in Linux?  That's exactly what you asked about, 
>> and
>> it was a good question.
> 
> Because we want to *write* PStore from U-Boot. The read being already
> implemented is not very useful, we could only re-read an 
> already-written
> console log (which is not helpful for us).

Well, it all depends on one's viewpoint.  See, even if we had no read 
support already implemented in U-Boot and wanted to just write the data, 
we'd almost surely have to implement reading as well, so the written 
stuff can be inspected in the U-Boot console.

>>>> Another benefit of using pstore would be no permanently wasted RAM 
>>>> for
>>>> the recorded console contents.  Also, having the data recorded to a
>>>> storage device also goes along with providing permanent records.
>>> 
>>> I'm positively *not gonna save boot logs to disk*, as most embedded
>>> systems have Flash-based storage media; writing to them on every boot
>>> would be devastating.
>> 
>> Writing 30-40 KB of data to an even remotely modern flash-based 
>> storage
>> media on each boot is pretty much nothing.  OTOH, writing 30-40 KB of
>> data to an SPI chip on each boot would be rather bad, but we aren't
>> going to do that for sure.
>> 
>> To put things into perspective, I'm writing this on a Pinebook Pro 
>> with
>> an eMMC chip, and it has stored many GBs of data over a few years.  
>> Even
>> high-endurance microSD cards are rather reliable in that regard.
> 
> Not every system has eMMC/uSD, and as you said, these arguments don't
> hold for a 4 MB SPI NAND, for example, one you might find in an OpenWrt
> router for example. Whereas RAM is quite cheap nowadays.

I see, but I also wonder how many such OpenWrt routers are still used 
these days, and, even more importantly, how many of them are regularly 
updated and can be expected to actually use this new feature?

Please, don't get me wrong, I still support having both options 
available, but I'm also wondering about the target demographic.

>>> Plus, I don't want the console subsystem to depend on any file/disk
>>> operations/drivers.
>> 
>> Well, the console would still work as usual even if logging to disk
>> would fail for any reason, which is similar to the serial console 
>> still
>> working if the graphical console fails.  Moreover, if the disk fails,
>> the system isn't be able to boot, so any RAM-based console logs would 
>> be
>> lost in that case.  All this makes the RAM-based logging no more
>> resilient to disk failures.
> 
> Correction: if disk *reads* fail, as well as writes, then the system
> will not boot. However, typical failure of Flash media is that it
> becomes read-only.

That's a good point, but having a read-only root filesystem usually also 
means having a non-operational system that can only have its stored data 
salvaged.  Unless the system is specifically crafted to survive such 
scenarios, of course.

>> I still think that using disk-based pstore is a better option.  Just 
>> as
>> you don't want to wear out your flash disks with 30-40 KB of data, I
>> also don't want to waste 30-40 KB of RAM.
> 
> As I said, you could just unload the log after you're done processing
> it. 40 KB RAM is less, than what `sshd` uses, for instance (860k on my
> laptop, but it can probably be less, maybe even 10x less, so 80-90k?),
> so you could, in your init, process the in-RAM log, then unload it, 
> then
> start your other services, thereby reclaiming that RAM.

Using pstore should have that unloading already covered, and the already 
existing systemd service is there to perform the archiving to the 
primary filesystem, if desired so.  It would all need to be tested in 
detail, of course.

>> Also, embedded devices such
>> as the PinePhone would benefit additionally from using disk-based
>> logging, because people often can't do anything in the field if 
>> booting
>> fails for some reason, so RAM-based logs would end up being lost,
>> preventing any post-mortem debugging later.
> 
> Post-mortem analysis could be interesting, true.

Yes, and it's often the only way to get to the bottom of the underlying 
issues, which are sometimes intermittent and can't be reproduced easily 
later.

>> Perhaps we can actually offer both options, i.e. both logging to RAM 
>> and
>> to disk, so everyone can choose what they prefer.  I'd also be fine 
>> with
>> working on such a dual approach, but it would obviously be more 
>> complex.
> 
> Perhaps that is the best option. But, as Sean has pointed out, U-Boot
> doesn't support disk-backed PStore anyways... So then, should we
> implement RAM-based PStore writing for the time being, and then maybe
> expand it later?

I'd vote for implementing both options at once, so we can reduce the 
overall amount of the required testing.  It will surely result in more 
time required for the development, but the total amount of time should 
be significantly shorter.
