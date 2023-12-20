Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE28EC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 19:58:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 567F887824;
	Wed, 20 Dec 2023 20:58:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="J74HVrTm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B844187828; Wed, 20 Dec 2023 20:58:28 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D953B87808
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 20:58:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1703102301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RF2+hbMteVMaM0xel87rjxlWs6P2SWLb6UVXPXGqSUw=;
 b=J74HVrTmeI3jiOiM3kEK6Thttz+0Ua3o3nb9ECEDEdxMbskmgXAETtsk79STGV3XyDgeDZ
 DUmzrHItCkt8QrT10lXLqAZNd95vF5T7mBVZQ9gfCpaUiiE5jPwlGBdyTy2h4v0l2Ks0RL
 imp5VumKQpMKRmQ5fLlT2cvQ9qnLeqUfKn4Gq4cC1KRdF/QoRqRHBsS0fadlwgyXRXBRCF
 oJOv12bwPBU95LL0BkbM53NOP2I4Ag20x+OydWnMcHaAfGM/0B7V7fPX3dPrGS2RjLgppW
 m/4PKGPemHFDxLXtp/IxrqdXuVZ29oCudglfZd/90pt1ktBzncsiS8P9fRPIqg==
Date: Wed, 20 Dec 2023 20:58:18 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Cs=C3=B3k=C3=A1s_Bence?= <Csokas.Bence@prolan.hu>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Daniel Golle <daniel@makrotopia.org>, Mark Kettenis
 <mark.kettenis@xs4all.nl>
Subject: Re: Passing boot logs to Linux?
In-Reply-To: <f22f86ec-987f-4404-8722-82270f1e8da8@prolan.hu>
References: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
 <CAPnjgZ01=y-Kf=XmDv6UyEdPgXLp8bhZnSZDBVk1FPfBh8CdOw@mail.gmail.com>
 <6ae238be-3c5f-5ef6-9e18-282be9ae24c2@gmail.com>
 <16e633f9d4b1c426aaca510157479d65@manjaro.org>
 <51121aee-faca-4196-8532-719fb6ec9bdc@prolan.hu>
 <2c108e1ff92db2b74f5ccccd770872a7@manjaro.org>
 <5e0e71a5-f3c8-413e-96a3-a0b6edee928f@prolan.hu>
 <3900f4b15852d0af65635b3a794d34af@manjaro.org>
 <f22f86ec-987f-4404-8722-82270f1e8da8@prolan.hu>
Message-ID: <d1350e2c5ff1da1cf10c92b1b49dec6b@manjaro.org>
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

On 2023-12-20 20:24, Csókás Bence wrote:
> On 2023. 12. 20. 9:29, Dragan Simic wrote:
>> On 2023-12-20 08:52, Csókás Bence wrote:
>>> On 2023. 12. 20. 8:09, Dragan Simic wrote:
>>>> On 2023-12-20 07:49, Csókás Bence wrote:
>>>>> I don't think that would be a huge problem, Linux userspace can 
>>>>> filter
>>>>> ANSI control codes if it wants to. For now, I'd like a 
>>>>> byte-for-byte
>>>>> copy of the console, as-is, presented to Linux.
>>>> 
>>>> But wouldn't recording the control sequences as-is actually be 
>>>> pretty
>>>> much useless?  For example, some user can spend a few minutes
>>>> scrolling through the boot menu, which would produce a fair amount 
>>>> of
>>>> nearly useless recorded data.
>>>> 
>>>> Moreover, if I'm not wrong, viewing or parsing such as-is data would
>>>> actually require replaying the control sequences, to reproduce the
>>>> actual console contents as it was recorded, which would be quite
>>>> cumbersome.
>>> 
>>> It *is* useless, but most of the times the user won't be scrolling at
>>> all anyways, that's why I don't think these few extra bytes would be 
>>> a
>>> problem.
>> 
>> Quite frankly, when it comes to computing in general, taking the "ah, 
>> it
>> probably won't happen" approach isn't the best thing to do.  We should
>> aim toward covering properly even the edge cases, if you agree.
> 
> You're absolutely right; however, I did not say "it won't happen", I
> said that Linux userspace can go deal with it if it happens, and if it
> wants to. And that in my opinion, the best course of action for U-Boot
> is to record *everything* (as it does now), and then userspace can
> decide to filter it for eg. ANSI codes. But I think it's best to keep
> the U-Boot code dead simple, and also supply the most data to 
> userspace.

Hmm, maybe you're right, but I'd have to think a bit more about it.  I'd 
also have to go through the relevant parts of the U-Boot source code in 
detail.

>>> That's what I read as well. Is there support for U-boot to write and
>>> Linux to read PStores?
>> 
>> No and yes, but U-Boot can already read pstore.  Please see
>> doc/usage/cmd/pstore.rst for the U-Boot part, and
>> Documentation/admin-guide/pstore-blk.rst for the Linux kernel part.
> 
> Irrelevant, as we only want to write out the console log to U-Boot, and
> not the other way around (that's for collecting panic logs, which is
> already implemented).

Quite frankly, this is a bit confusing to me.  Why should it be 
irrelevant, if we want to store the U-Boot console logs into the pstore, 
and read them later in Linux?  That's exactly what you asked about, and 
it was a good question.

>> Another benefit of using pstore would be no permanently wasted RAM for
>> the recorded console contents.  Also, having the data recorded to a
>> storage device also goes along with providing permanent records.
> 
> I'm positively *not gonna save boot logs to disk*, as most embedded
> systems have Flash-based storage media; writing to them on every boot
> would be devastating.

Writing 30-40 KB of data to an even remotely modern flash-based storage 
media on each boot is pretty much nothing.  OTOH, writing 30-40 KB of 
data to an SPI chip on each boot would be rather bad, but we aren't 
going to do that for sure.

To put things into perspective, I'm writing this on a Pinebook Pro with 
an eMMC chip, and it has stored many GBs of data over a few years.  Even 
high-endurance microSD cards are rather reliable in that regard.

> Plus, I don't want the console subsystem to depend on any file/disk
> operations/drivers.

Well, the console would still work as usual even if logging to disk 
would fail for any reason, which is similar to the serial console still 
working if the graphical console fails.  Moreover, if the disk fails, 
the system isn't be able to boot, so any RAM-based console logs would be 
lost in that case.  All this makes the RAM-based logging no more 
resilient to disk failures.

> Therefore, it will be necessary to permanently keep the logs in-memory,
> regardless of whether we use the PStore format or something else. 
> Unless
> Linux wants to copy it elsewhere (which probably will be memory
> anyways). But maybe we could offer some option in the Linux driver to
> release the logs, along with the associated memory region...

I still think that using disk-based pstore is a better option.  Just as 
you don't want to wear out your flash disks with 30-40 KB of data, I 
also don't want to waste 30-40 KB of RAM.  Also, embedded devices such 
as the PinePhone would benefit additionally from using disk-based 
logging, because people often can't do anything in the field if booting 
fails for some reason, so RAM-based logs would end up being lost, 
preventing any post-mortem debugging later.

Perhaps we can actually offer both options, i.e. both logging to RAM and 
to disk, so everyone can choose what they prefer.  I'd also be fine with 
working on such a dual approach, but it would obviously be more complex.

> All in all, I'm all for using pre-existing standard interfaces instead
> of inventing something new and custom, but as I see it now, PStore just
> cannot do what we want here. If any of you think otherwise, feel free 
> to
> try to convince me further, or even guide me on how to use PStores.

Well, please don't get me wrong, but pstore and disk-based logging can't 
do what _you_ want.  I already provided above some examples of why I'd 
find it useful.

> Here's what I would want:
> * writing already supported in U-Boot
> * pure in-memory solution
> * minimal overhead to the console subsystem

I understand your position, but I'd appreciate if you'd also try to 
understand my position that I described above.
