Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79433C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 02:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDD9787808;
	Thu, 21 Dec 2023 03:23:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="hv81y+M9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFC3787853; Thu, 21 Dec 2023 03:23:48 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE1A287786
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 03:23:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1703125426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EFWI5pszRED/8jnKkDg7lFHjmc2QtaSLNrzYN/m27DQ=;
 b=hv81y+M9Ik50fPrRrGv8vvdpZL8k5vtH38APUVVHUPw4k3pa9LyuOHe+1JvjkIfnqzDk1Q
 66f4KAWhshnIeLvTY70sAIXc/udqZyMXAaB9Ux8dQ3ZAOehBWovb+QYKoAra/N+L9v5R8x
 yqk6UH51orTWbpokwq+Z44RVLCo5wrpVc+ZI4Z++v6G1kiaIoMpP32YZifextgQd+VNWrn
 IWA85i6D6k203bFxpB9Gw3KOrcHwWoZx4UCd9vf76YzuGOEAsimdlRf+vawvN45mlcBW5W
 woAs2tecLewGfnrnJ71IaGmrKcyNgKspz2rIyySeRsubXZzAtmOKNw/Y8rpdPA==
Date: Thu, 21 Dec 2023 03:23:45 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: =?UTF-8?Q?Cs=C3=B3k=C3=A1s_Bence?= <Csokas.Bence@prolan.hu>, Sean
 Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: Passing boot logs to Linux?
In-Reply-To: <e5dfc1d7ec245897bf59ef1f14beb9cb@manjaro.org>
References: <6ae238be-3c5f-5ef6-9e18-282be9ae24c2@gmail.com>
 <16e633f9d4b1c426aaca510157479d65@manjaro.org>
 <51121aee-faca-4196-8532-719fb6ec9bdc@prolan.hu>
 <2c108e1ff92db2b74f5ccccd770872a7@manjaro.org>
 <5e0e71a5-f3c8-413e-96a3-a0b6edee928f@prolan.hu>
 <3900f4b15852d0af65635b3a794d34af@manjaro.org>
 <f22f86ec-987f-4404-8722-82270f1e8da8@prolan.hu>
 <d1350e2c5ff1da1cf10c92b1b49dec6b@manjaro.org>
 <5fd64984-4715-4880-ba27-ef78094da6cb@prolan.hu>
 <e37be8c4cfc8ed28aca43e35f752fc8b@manjaro.org>
 <ZYOMY4Bs2KDyLmka@makrotopia.org>
 <6b09b7423796689e86cf853809a8e471@manjaro.org>
 <e5dfc1d7ec245897bf59ef1f14beb9cb@manjaro.org>
Message-ID: <4df006cb773186561a13ae37f1b88947@manjaro.org>
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

On 2023-12-21 02:44, Dragan Simic wrote:
> On 2023-12-21 02:37, Dragan Simic wrote:
>> On 2023-12-21 02:03, Daniel Golle wrote:
>>> On Thu, Dec 21, 2023 at 12:55:20AM +0100, Dragan Simic wrote:
>>>> On 2023-12-21 00:27, Csókás Bence wrote:
>>>> > Not every system has eMMC/uSD, and as you said, these arguments don't
>>>> > hold for a 4 MB SPI NAND, for example, one you might find in an OpenWrt
>>>> > router for example. Whereas RAM is quite cheap nowadays.
>>>> 
>>>> I see, but I also wonder how many such OpenWrt routers are still 
>>>> used these
>>>> days, and, even more importantly, how many of them are regularly 
>>>> updated and
>>>> can be expected to actually use this new feature?
>>> 
>>> Avoid flash writes is a very important matter, even on systems with
>>> 128 MiB of SPI-NAND flash which is by far the most common setup you
>>> find on off-the-shelf plastic routers and access points nowadays.
>> 
>> I agree, writing something to the SPI chips all the time, no matter
>> how small the writes are, is a big no-no, which I already clearly
>> expressed in one of my earlier posts.
>> 
>>> Especially also as those devices often come without a local console,
>>> having U-Boot's output prepended to dmesg on boot would be a very big
>>> win.
>> 
>> I was also thinking about that, but I'm not sure it would be accepted
>> to the Linux kernel.  Maybe we can try getting that accepted later.

Maybe, but just _maybe,_ it could be possible to add a new command-line 
option to dmesg(1) that would display the last recorded console output, 
fetched from the pstore.  That _might_ get accepted to util-linux, while 
being perfectly fine from the usability standpoint.

I'm also willing to work on that, and I already contributed a few 
dmesg(1) patches to util-linux.

>>>> Please, don't get me wrong, I still support having both options 
>>>> available,
>>>> but I'm also wondering about the target demographic.
>>>> 
>>>> > > > Plus, I don't want the console subsystem to depend on any file/disk
>>>> > > > operations/drivers.
>>>> > >
>>>> > > Well, the console would still work as usual even if logging to disk
>>>> > > would fail for any reason, which is similar to the serial console
>>>> > > still
>>>> > > working if the graphical console fails.  Moreover, if the disk fails,
>>>> > > the system isn't be able to boot, so any RAM-based console logs
>>>> > > would be
>>>> > > lost in that case.  All this makes the RAM-based logging no more
>>>> > > resilient to disk failures.
>>>> >
>>>> > Correction: if disk *reads* fail, as well as writes, then the system
>>>> > will not boot. However, typical failure of Flash media is that it
>>>> > becomes read-only.
>>>> 
>>>> That's a good point, but having a read-only root filesystem usually 
>>>> also
>>>> means having a non-operational system that can only have its stored 
>>>> data
>>>> salvaged.  Unless the system is specifically crafted to survive such
>>>> scenarios, of course.
>>> 
>>> ... which holds true for any decent embedded OS, which at least 
>>> allows
>>> limited remote access and some kind of recovery even in this 
>>> situation.
>> 
>> Perhaps.  I'm more into running general-purpose Linux distributions on
>> single-board computers and derived embedded devices, which are on the
>> "thick" end of the embedded device spectrum, so to speak.
>> 
>>>> > > I still think that using disk-based pstore is a better option.  Just
>>>> > > as
>>>> > > you don't want to wear out your flash disks with 30-40 KB of data, I
>>>> > > also don't want to waste 30-40 KB of RAM.
>>>> >
>>>> > As I said, you could just unload the log after you're done processing
>>>> > it. 40 KB RAM is less, than what `sshd` uses, for instance (860k on my
>>>> > laptop, but it can probably be less, maybe even 10x less, so 80-90k?),
>>>> > so you could, in your init, process the in-RAM log, then unload it, then
>>>> > start your other services, thereby reclaiming that RAM.
>>>> 
>>>> Using pstore should have that unloading already covered, and the 
>>>> already
>>>> existing systemd service is there to perform the archiving to the 
>>>> primary
>>>> filesystem, if desired so.  It would all need to be tested in 
>>>> detail, of
>>>> course.
>>> 
>>> pstore/ramoops uses a statically assigned reserved memory region, so 
>>> in
>>> the moment you want to use that feature you loose that amount of RAM 
>>> (a
>>> few kB, so it doesn't really matter on modern systems).
>>> As in: there is *no* dynamic allocation.
>>> 
>>> Imho using pstore/ramoops (which is a more or less Linux-specific
>>> debugging feature, meant to store one or more timestamped logs of
>>> crashes) might not be the most suitable choice. I understand the
>>> advantages of using existing infrastructure, but on the other hand
>>> we don't need most of the complexity of pstore for the task.
>> 
>> Hmm, let me research all that a bit more in the next couple of days,
>> please, and I'll come back with a detailed insight.
>> 
>>> What I'd like to see is having a couple of log lines from U-Boot
>>> prepended to Linux' dmesg buffer, and for that we anyway will have to
>>> come up with a way to hand over that buffer. Another reserved-memory
>>> region would be one way, embedding the buffer as a blob into the
>>> /chosen/ section of the device tree would be another way.
>> 
>> As I already wrote above, it would be rather neat, but I'm afraid it
>> wouldn't be accepted upstream.
> 
> Sorry, I forgot this...
> 
> As I already explained in one of my earlier posts, not all devices and
> applications would benefit from having only "in-flight" console data
> available, i.e. made available through a reserved region of the RAM.
> Some devices actually need to have the recorded console outputs stored
> on their eMMC chips or microSD cards, for post-mortem analysis of the
> boot issues.
> 
> That's why we actually need both options available, and that's also
> why pstore should fit well, even if it may seem as an overkill.  I
> hope you agree;  however, I'll do more research, as already promised.
