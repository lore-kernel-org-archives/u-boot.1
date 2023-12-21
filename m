Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F4AC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 01:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D022D86FF7;
	Thu, 21 Dec 2023 02:03:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE62B87687; Thu, 21 Dec 2023 02:03:54 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C87386DD1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 02:03:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.96.2) (envelope-from <daniel@makrotopia.org>)
 id 1rG7TQ-0003TL-2Z; Thu, 21 Dec 2023 01:03:41 +0000
Date: Thu, 21 Dec 2023 01:03:36 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: =?iso-8859-1?B?Q3Pza+Fz?= Bence <Csokas.Bence@prolan.hu>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: Passing boot logs to Linux?
Message-ID: <ZYOMY4Bs2KDyLmka@makrotopia.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e37be8c4cfc8ed28aca43e35f752fc8b@manjaro.org>
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

On Thu, Dec 21, 2023 at 12:55:20AM +0100, Dragan Simic wrote:
> On 2023-12-21 00:27, Csókás Bence wrote:
> > Not every system has eMMC/uSD, and as you said, these arguments don't
> > hold for a 4 MB SPI NAND, for example, one you might find in an OpenWrt
> > router for example. Whereas RAM is quite cheap nowadays.
> 
> I see, but I also wonder how many such OpenWrt routers are still used these
> days, and, even more importantly, how many of them are regularly updated and
> can be expected to actually use this new feature?

Avoid flash writes is a very important matter, even on systems with
128 MiB of SPI-NAND flash which is by far the most common setup you
find on off-the-shelf plastic routers and access points nowadays.

Especially also as those devices often come without a local console,
having U-Boot's output prepended to dmesg on boot would be a very big
win.

> 
> Please, don't get me wrong, I still support having both options available,
> but I'm also wondering about the target demographic.
> 
> > > > Plus, I don't want the console subsystem to depend on any file/disk
> > > > operations/drivers.
> > > 
> > > Well, the console would still work as usual even if logging to disk
> > > would fail for any reason, which is similar to the serial console
> > > still
> > > working if the graphical console fails.  Moreover, if the disk fails,
> > > the system isn't be able to boot, so any RAM-based console logs
> > > would be
> > > lost in that case.  All this makes the RAM-based logging no more
> > > resilient to disk failures.
> > 
> > Correction: if disk *reads* fail, as well as writes, then the system
> > will not boot. However, typical failure of Flash media is that it
> > becomes read-only.
> 
> That's a good point, but having a read-only root filesystem usually also
> means having a non-operational system that can only have its stored data
> salvaged.  Unless the system is specifically crafted to survive such
> scenarios, of course.

... which holds true for any decent embedded OS, which at least allows
limited remote access and some kind of recovery even in this situation.

> 
> > > I still think that using disk-based pstore is a better option.  Just
> > > as
> > > you don't want to wear out your flash disks with 30-40 KB of data, I
> > > also don't want to waste 30-40 KB of RAM.
> > 
> > As I said, you could just unload the log after you're done processing
> > it. 40 KB RAM is less, than what `sshd` uses, for instance (860k on my
> > laptop, but it can probably be less, maybe even 10x less, so 80-90k?),
> > so you could, in your init, process the in-RAM log, then unload it, then
> > start your other services, thereby reclaiming that RAM.
> 
> Using pstore should have that unloading already covered, and the already
> existing systemd service is there to perform the archiving to the primary
> filesystem, if desired so.  It would all need to be tested in detail, of
> course.

pstore/ramoops uses a statically assigned reserved memory region, so in
the moment you want to use that feature you loose that amount of RAM (a
few kB, so it doesn't really matter on modern systems).
As in: there is *no* dynamic allocation.

Imho using pstore/ramoops (which is a more or less Linux-specific
debugging feature, meant to store one or more timestamped logs of
crashes) might not be the most suitable choice. I understand the
advantages of using existing infrastructure, but on the other hand
we don't need most of the complexity of pstore for the task.

What I'd like to see is having a couple of log lines from U-Boot
prepended to Linux' dmesg buffer, and for that we anyway will have to
come up with a way to hand over that buffer. Another reserved-memory
region would be one way, embedding the buffer as a blob into the
/chosen/ section of the device tree would be another way.
