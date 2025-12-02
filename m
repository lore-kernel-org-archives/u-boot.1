Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E9AD1266C
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 19:46:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1549983EE2;
	Tue,  2 Dec 2025 20:46:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="oVtrhL7Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9131583F14; Tue,  2 Dec 2025 20:46:25 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10AEB83EDF
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 20:46:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: d1105f98-cfb7-11f0-ad1a-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id d1105f98-cfb7-11f0-ad1a-005056999439;
 Tue, 02 Dec 2025 20:48:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=/T4OgYgm15KYxmDgOZiBHW/Yvdbzmb7jAycPTa/ia2c=;
 b=oVtrhL7YO3wlwuJcPhfVxIuxql2U/lTkvJseyhsVFqwo88pEGRe8eOf/uyaar+TJF3cZTXuql7TF9
 yrKQmKz5kG7jfEuU2wFX/6ngqTqi75rfdHy+rc/Ozvc6T7gQHSulyp5BC4FLxo/Xk7RZl/824/tlhy
 kQXkPaWDaWfLb0FChXobalKelIOYIgo8IoRCLKx/Yo0pKoumgq1qmV4JedGSJO0tDLBHUOK/da4ybh
 B2gOoNI8kG+dpOQbz8w2yK/OALQk2OkvIZUikNDv49mcMAUpUxA7ewQrOetj4RvgHPNTc+o/VRSxtw
 CcLaJS9FRXx/I9tuuzabzhSv5G6sd/g==
X-KPN-MID: 33|RtYoigxYae4xXEBalYaayfVAnL+aQ1B3i1G0qhAhaNx9dd2jgC+TsD5zTYzlVsv
 RGNmh5zB6LvpN0jLSridRYmzevHp8S4ElX/8+Ex039/E=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|6pTKX/eUzsB6q0s04+3cKDYDJPbSLENhXl7sQcbl3CPv2AEt7kCBXYK3jsBv51/
 FGwKqMAcZ2cCJojg+OUs5uA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 9424256c-cfb7-11f0-9bf6-00505699d6e5;
 Tue, 02 Dec 2025 20:46:22 +0100 (CET)
Date: Tue, 02 Dec 2025 20:46:21 +0100
Message-Id: <877bv4braq.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de,
 u-boot-board-maintainers@lists.denx.de
In-Reply-To: <20251202185222.GG303283@bill-the-cat> (message from Tom Rini on
 Tue, 2 Dec 2025 12:52:22 -0600)
Subject: Re: Dropping macOS and Windows host tool builds and support in U-Boot
References: <20251202182403.GF303283@bill-the-cat>
 <878qfkbty4.fsf@bloch.sibelius.xs4all.nl>
 <20251202185222.GG303283@bill-the-cat>
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

> Date: Tue, 2 Dec 2025 12:52:22 -0600
> From: Tom Rini <trini@konsulko.com>
> 
> On Tue, Dec 02, 2025 at 07:49:07PM +0100, Mark Kettenis wrote:
> > > Date: Tue, 2 Dec 2025 12:24:03 -0600
> > > From: Tom Rini <trini@konsulko.com>
> > 
> > Hi Tom,
> > 
> > > Hey all,
> > > 
> > > I am wondering if at this point in time, anyone still builds our host
> > > tools (fw_printenv / fw_getenv, a few others) to run on macOS or
> > > Windows, natively.
> > > 
> > > I ask for two reasons. The first of which is that a reason we still have
> > > to support Azure (despite its slowness) for CI is it's where we have
> > > macOS and Windows hosts. But at this point in time there's so many ways
> > > to have Linux userspace running on Windows or macOS that I don't know
> > > that there's any value to these builds.
> > > 
> > > The second reason is more macOS specific and is that with:
> > > 
> > > commit 8fbcc0e0e839a8e25f636c76e59311033d3817b5
> > > Author: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > Date:   Thu Nov 13 12:54:51 2025 +0100
> > > 
> > >     boot: Assure FDT is always at 8-byte aligned address
> > >     
> > >     The fitImage may contain FDT at 4-byte aligned address, because alignment
> > >     of DT tags is 4 bytes. However, libfdt and also Linux expects DT to be at
> > >     8-byte aligned address. Make sure that the DTs embedded in fitImages are
> > >     always used from 8-byte aligned addresses. In case the DT is decompressed,
> > >     make sure the target buffer is 8-byte aligned. In case the DT is only
> > >     loaded, make sure the target buffer is 8-byte aligned too.
> > >     
> > >     Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > 
> > > Which does things we must do, we now don't build on macOS. Why? As best
> > > I can tell (and for a general purpose OS, is a good call), memalign(..)
> > > doesn't exist and you need to use posix_memalign, a not drop-in
> > > replacement. We could spend some time reworking the code here for that,
> > > but for now I've instead gone with this workaround so that CI can
> > > continue:
> > > https://lore.kernel.org/u-boot/20251202162250.2613085-1-trini@konsulko.com/
> > 
> > Are you sure about this?
> > 
> > The code in boot/image-fdt.c is part of U-Boot itself, not the host
> > tools.  As such it should be irrelevant whether the host OS provides
> > memalign() or not; U-Boot provides its own implementation.
> 
> We use parts of this code as-is (and some other less obvious files) when
> building host tools.
> 
> > OpenBSD doesn't have memalign() either.  But I can still build the
> > targets I care about on OpenBSD.
> > 
> > Or is this about sandbox?  Did sandbox ever work on macOS?
> 
> It's about "tools-only" build target, but also I suspect that if you try
> the next branch right now it'll also fail and we'll need to figure
> something out.

Ah, it is only on the next branch.  Yes

  In file included from tools/generated/boot/image-fit.c:1:
  In file included from ./tools/../boot/image-fit.c:38:
  include/malloc.h:824:20: error: conflicting types for 'sbrk'
    824 | extern Void_t*     sbrk(ptrdiff_t);
        |                    ^
  /usr/include/unistd.h:449:7: note: previous declaration is here
    449 | void    *sbrk(int);
        |          ^
  1 error generated.

Which points out another issue with sharing code between U-Boot itself
and the host tools this way.
