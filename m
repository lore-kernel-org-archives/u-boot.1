Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A06E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 21:34:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEF31800C2;
	Thu,  9 Jan 2025 22:34:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=post.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=post.cz header.i=@post.cz header.b="VYZsprFe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1518F801F5; Thu,  9 Jan 2025 16:31:03 +0100 (CET)
Received: from mxd-1-4e9.seznam.cz (mxd-1-4e9.seznam.cz
 [IPv6:2a02:598:128:8a00::1000:4e9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D48DE8005B
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:30:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=post.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Frantisek.Rysanek@post.cz
Received: from email.seznam.cz by smtpc-mxd-c7c46c5cc-8fwks
 (smtpc-mxd-c7c46c5cc-8fwks [2a02:598:128:8a00::1000:4e9])
 id 23b1e8fef40a519b2319f639; Thu, 09 Jan 2025 16:30:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=post.cz;
 s=szn20221014; t=1736436658;
 bh=nT7Djj4SLZws9oRVp6cjK9Wp4JT+hEVHsKPhFPnHLHU=;
 h=From:To:Date:MIME-Version:Subject:CC:Message-ID:Content-type:
 Content-transfer-encoding;
 b=VYZsprFeWmo1YcJ3UKPBKmefbQ/QQAT2dea3yRhJjCSJE3fAwG/Shf3mjCrUm6oc8
 BWMZbErsv5jOSZbAvL+0/+IAib1e2RogKEhDvB7+I3bHhl31CtjzwQFGH0kPHhXg0z
 8ZRFBNUYUsgXm6uOwS7eKPCHUnAKf/LmCSpTKDQzXRweqOW6SvQj63RKZ3zvDgYolK
 oTCoeIDIsnJruSIycT8LSjj4q3NKYigGpMMxKygxRkQu01gcsGvl8U67Eb8H9gHBZ1
 La3w/FAMrjLhq5YlNIEKvQYeanfN6sxLkdMX918sikGJa5nlk8LGvlk/8AITQeqJtN
 ThZEmhQj2IIog==
Received: from [192.168.100.10] (250.68.pool1.tetanet.cz [109.202.68.250])
 by smtpd-relay-f4944d456-f7mc7 (szn-email-smtpd/2.0.27) with ESMTPA
 id d26d521b-c40e-447c-945e-3079ba81bbd4;
 Thu, 09 Jan 2025 16:30:56 +0100
From: "Frantisek Rysanek" <Frantisek.Rysanek@post.cz>
To: "Syslinux" <syslinux-bounces@syslinux.org>
Date: Thu, 09 Jan 2025 16:30:53 +0100
MIME-Version: 1.0
Subject: Re: [syslinux] Purpose of 'localboot'
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Message-ID: <677FEBAD.16689.1CC4743B@Frantisek.Rysanek.post.cz>
Priority: normal
In-reply-to: <CAFLszTiT59PBvpxtpwMXcX3f-dbAfkZ=2xW=bHm6LrGAAe_TrQ@mail.gmail.com>
References: <CAFLszTiT59PBvpxtpwMXcX3f-dbAfkZ=2xW=bHm6LrGAAe_TrQ@mail.gmail.com>
X-mailer: Pegasus Mail for Windows (4.81.1154)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Mailman-Approved-At: Thu, 09 Jan 2025 22:34:34 +0100
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

> Hi,
> 
> The documentation on this feature[1] doesn't quite explain how the
> system should actually do a localboot. Is this for BIOS / x86 only?
> There was a recent discussion about this on the U-Boot mailing
> list[2].
> 
> Is someone able to help with how / if this should be implemented in
> U-Boot?
> 
> Regards,
> Simon
>

I feel that you actually understand the whole point :-)

Syslinux is a bootloader for the PC's - those have a BIOS and 
nowadays a Bios Boot Sequence (BBS). And, a specific member of the 
syslinux family (package) is pxelinux, which loads from the LAN.

The "local" boot means, that while the PC is trying to boot, in a 
particular step of the BIOS Boot Sequence (= the order of bootable 
devices) it has loaded PXElinux, and now the user has a choice, 
either to chainload some "payload" (e.g. the Linux kernel + initrd or 
some such via TFTP), or to hand over to the next entry in the "BIOS 
Boot Sequence" - effectively by calling an "iret" at the top-level 
function called by its respective BBS entry, which is effectively a 
software interrupt... which will end up trying another boot media, 
the next one up in the BBS.

Yes this is specific to machines having a BIOS.

Not sure about UEFI, the bootloader loading mechanism is different, 
but Syslinux never quite got there with UEFI, so I believe this point 
is moot.
I haven't actually tried this with iPXE, there doesn't seem to be an 
explicit keyword for this. Possibly if you "let the ipxe boot script 
fall off the end" or by calling an exit... or possibly not.
https://www.google.com/search?q=UEFI+exit+ipxe+and+try+the+next+boot+e
ntry%3F

Now compare that to uBoot. Who typically has just a single purpose in 
life, and a single option what to boot: the one kernel and initrd, 
typically from a NAND flash MTD (or sometimes NOR flash for that 
matter). You can possibly break normal boot and try loading something 
via TFTP...

Frank

