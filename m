Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F74D1266A
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 20:19:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D558F83F26;
	Tue,  2 Dec 2025 21:19:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="nPhEm5qM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FDC083F2F; Tue,  2 Dec 2025 21:19:45 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADAEB83F24
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 21:19:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 78df347f-cfbc-11f0-ad1a-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 78df347f-cfbc-11f0-ad1a-005056999439;
 Tue, 02 Dec 2025 21:21:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=gntvHPZ6Pw0/rlNA5MulqkDVHxqoNSP6/dngFfwCquQ=;
 b=nPhEm5qM2+a0LLHfOdBBqgQTKzxSKzbKlFLivTAUZM23Cp4BeBbpTUX7yzOcx9Uf6bLGOPcekfr/O
 bOER2U78ASgAGRjdB6B6XOVLg8ALWt7nXoKdcTgvbM9jTKymFtusw9Ts9ATKpVXpxTCIbgCDESk0cS
 ZLJijGTd8+1DNBxY3a37E5OFsePV34J0x56Dqj0Dl+c4YU0WwshD+ipTXCvOrt1SwWZzjx4uqo3p3V
 J9yTEuLKS79sPBdgGBMqrnmGbFBOLqiNPhxpPa1CjAx/bCvFpa1FyN1IuIQ91STKRc0XA/xahuYIvo
 Kt+yZ/KMoKrVWumDz7cX2+ceUUMh4Mw==
X-KPN-MID: 33|ckmfHXwAZXLRO7OIHRnLa3NE3jusIbOau/qWRhKDE2Woo/c2QqpGud+JfZVuBAW
 ZXAI2sHdplwcOvkyJ4foRAO89jY2egtOx/XM1EnnqBh0=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|v9PcimjZMZFyQyzSYeXLr4OuSKVc1WjjgJs2TN+aC7++wHIvtWWKCuwZa5bSrFh
 UhpFxM9IkvqBssJCp4uk6Xg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 3bd9f86e-cfbc-11f0-bff1-00505699772e;
 Tue, 02 Dec 2025 21:19:41 +0100 (CET)
Date: Tue, 02 Dec 2025 21:19:41 +0100
Message-Id: <874iq8bpr6.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot-board-maintainers@lists.denx.de, trini@konsulko.com,
 u-boot@lists.denx.de, u-boot-custodians@lists.denx.de
In-Reply-To: <DAE792B8-A6F7-4725-8F1F-6D874B508B74@gmx.de> (message from
 Heinrich Schuchardt on Tue, 02 Dec 2025 21:01:26 +0100)
Subject: Re: Dropping macOS and Windows host tool builds and support in U-Boot
References: <20251202182403.GF303283@bill-the-cat>
 <878qfkbty4.fsf@bloch.sibelius.xs4all.nl>
 <20251202185222.GG303283@bill-the-cat>
 <877bv4braq.fsf@bloch.sibelius.xs4all.nl>
 <DAE792B8-A6F7-4725-8F1F-6D874B508B74@gmx.de>
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

> Date: Tue, 02 Dec 2025 21:01:26 +0100
> From: Heinrich Schuchardt <xypron.glpk@gmx.de>
> 
> Am 2. Dezember 2025 20:46:21 MEZ schrieb Mark Kettenis <mark.kettenis@xs4all.nl>:
> >> Date: Tue, 2 Dec 2025 12:52:22 -0600
> >> From: Tom Rini <trini@konsulko.com>
> >> 
> >> On Tue, Dec 02, 2025 at 07:49:07PM +0100, Mark Kettenis wrote:
> >> > > Date: Tue, 2 Dec 2025 12:24:03 -0600
> >> > > From: Tom Rini <trini@konsulko.com>
> >> > 
> >> > Hi Tom,
> >> > 
> >> > > Hey all,
> >> > > 
> >> > > I am wondering if at this point in time, anyone still builds our host
> >> > > tools (fw_printenv / fw_getenv, a few others) to run on macOS or
> >> > > Windows, natively.
> >> > > 
> >> > > I ask for two reasons. The first of which is that a reason we still have
> >> > > to support Azure (despite its slowness) for CI is it's where we have
> >> > > macOS and Windows hosts. But at this point in time there's so many ways
> >> > > to have Linux userspace running on Windows or macOS that I don't know
> >> > > that there's any value to these builds.
> >> > > 
> >> > > The second reason is more macOS specific and is that with:
> >> > > 
> >> > > commit 8fbcc0e0e839a8e25f636c76e59311033d3817b5
> >> > > Author: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> > > Date:   Thu Nov 13 12:54:51 2025 +0100
> >> > > 
> >> > >     boot: Assure FDT is always at 8-byte aligned address
> >> > >     
> >> > >     The fitImage may contain FDT at 4-byte aligned address, because alignment
> >> > >     of DT tags is 4 bytes. However, libfdt and also Linux expects DT to be at
> >> > >     8-byte aligned address. Make sure that the DTs embedded in fitImages are
> >> > >     always used from 8-byte aligned addresses. In case the DT is decompressed,
> >> > >     make sure the target buffer is 8-byte aligned. In case the DT is only
> >> > >     loaded, make sure the target buffer is 8-byte aligned too.
> >> > >     
> >> > >     Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> > > 
> >> > > Which does things we must do, we now don't build on macOS. Why? As best
> >> > > I can tell (and for a general purpose OS, is a good call), memalign(..)
> >> > > doesn't exist and you need to use posix_memalign, a not drop-in
> >> > > replacement. We could spend some time reworking the code here for that,
> >> > > but for now I've instead gone with this workaround so that CI can
> >> > > continue:
> >> > > https://lore.kernel.org/u-boot/20251202162250.2613085-1-trini@konsulko.com/
> >> > 
> >> > Are you sure about this?
> >> > 
> >> > The code in boot/image-fdt.c is part of U-Boot itself, not the host
> >> > tools.  As such it should be irrelevant whether the host OS provides
> >> > memalign() or not; U-Boot provides its own implementation.
> >> 
> >> We use parts of this code as-is (and some other less obvious files) when
> >> building host tools.
> >> 
> >> > OpenBSD doesn't have memalign() either.  But I can still build the
> >> > targets I care about on OpenBSD.
> 
> We require C11 for building U-Boot. C11 defines function aligned_alloc(). If we add that function in our U-Boot library we can rid of the #ifdef in Tom's patch.

That should work for OpenBSD.  And almost certainly for the other BSDs as well.

> >> > 
> >> > Or is this about sandbox?  Did sandbox ever work on macOS?
> >> 
> >> It's about "tools-only" build target, but also I suspect that if you try
> >> the next branch right now it'll also fail and we'll need to figure
> >> something out.
> >
> >Ah, it is only on the next branch.  Yes
> >
> >  In file included from tools/generated/boot/image-fit.c:1:
> >  In file included from ./tools/../boot/image-fit.c:38:
> >  include/malloc.h:824:20: error: conflicting types for 'sbrk'
> >    824 | extern Void_t*     sbrk(ptrdiff_t);
> >        |                    ^
> >  /usr/include/unistd.h:449:7: note: previous declaration is here
> >    449 | void    *sbrk(int);
> >        |          ^
> >  1 error generated.
> >
> >Which points out another issue with sharing code between U-Boot itself
> >and the host tools this way.
> 
> 
