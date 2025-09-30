Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD799CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 14:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9D97802C1;
	Tue, 30 Sep 2025 16:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="pOhuXZy7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBE6283071; Tue, 30 Sep 2025 16:49:33 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94A29800B1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 16:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: b4743d2b-9e0c-11f0-ad1a-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id b4743d2b-9e0c-11f0-ad1a-005056999439;
 Tue, 30 Sep 2025 16:49:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=3Fy8IOQUu1exGtYwiZMTfMc/Pv9liMTJXCAzsa9EEdA=;
 b=pOhuXZy7OngfMsVfn3sMoGb3HheB4lPQl/6+JVgVp5cnXkgr/7YSHqi3m06s4xXEvzkPmzZpxtgZm
 DIJSJtfqmILhORWxgJIZyFoZZMsWszAA7MppW6pBHtQdHQZw7FyVW4f6VTwmfDf/ddOTDIFju0AgdR
 0eGQkd85OGGEOQ6DQBrEkMNL5eINFt0mKcTn5PvLujoMWYxe9rFiXhaPpQtDpijVhZUAskHarXu6jU
 NHVRvJ5rr1La61xOq1h6tJH2I90JIOlPLiVogyeeXTqRw3q8ffP4QT8hEjj39iuGah6xOxzr++CoBS
 MxT/bOEaIIvz055ombcwJO+VGfpzlUA==
X-KPN-MID: 33|Rw2lXKoss6fTmzOtj0fqyhffw1QIX8ugvjl5apYRTgANG2+p0qQ2f+oeoXc6O5R
 WX7O5oNNQ+CqhuLuTpznyLPUU6g5myiW//yw4x8hktMU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|ordywnPmzCVfN1jL9mi9sl61Dj1FldKj5oACWO3DyrErJwxzWgX+gOBkOH1aPt7
 PL5Bp8ZDWhBISULHUcv6hdQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id ab6e681e-9e0c-11f0-86b9-005056998788;
 Tue, 30 Sep 2025 16:49:30 +0200 (CEST)
Date: Tue, 30 Sep 2025 16:49:30 +0200
Message-Id: <87ms6cdmh1.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: kettenis@openbsd.org, u-boot@lists.denx.de, trini@konsulko.com
In-Reply-To: <c7163cf3-b108-45a1-8b03-0a09a0429032@mailbox.org> (message from
 Marek Vasut on Tue, 30 Sep 2025 01:03:41 +0200)
Subject: Re: [PATCH v2 1/3] apple: Set up file system firmware loader
References: <20250929195241.70351-1-kettenis@openbsd.org>
 <20250929195241.70351-2-kettenis@openbsd.org>
 <c7163cf3-b108-45a1-8b03-0a09a0429032@mailbox.org>
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

> Date: Tue, 30 Sep 2025 01:03:41 +0200
> From: Marek Vasut <marek.vasut@mailbox.org>

Hi Marek,

> On 9/29/25 9:52 PM, Mark Kettenis wrote:
> > Find the appropriate EFI system partition on the internal NVMe
> > storage and set the U-Boot environment variables such that
> > the file system firmware loader can load firmware from it.
> > 
> > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > ---
> >   arch/arm/mach-apple/board.c | 59 +++++++++++++++++++++++++++++++++++++
> >   1 file changed, 59 insertions(+)
> > 
> > diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> > index 4cd8979bdc2..d8b6787c705 100644
> > --- a/arch/arm/mach-apple/board.c
> > +++ b/arch/arm/mach-apple/board.c
> > @@ -8,6 +8,8 @@
> >   #include <efi_loader.h>
> >   #include <env.h>
> >   #include <lmb.h>
> > +#include <nvme.h>
> > +#include <part.h>
> >   
> >   #include <asm/armv8/mmu.h>
> >   #include <asm/global_data.h>
> > @@ -771,6 +773,60 @@ u64 get_page_table_size(void)
> >   	return SZ_256K;
> >   }
> >   
> > +static char *asahi_esp_devpart(void)
> > +{
> Maybe try request_firmware_into_buf_via_script() instead ?
> 
> That might make this more flexible /wrt firmware location and user 
> preferences.

I'm not sure about that.  For one thing, I thought there was a push to
move away from scripts.  At least that was a major driver for
replacing distroboot with bootstd.  Granted, the motivation for that
was secure/trusted/verified boot, which is something I personally
don't care all that much about.

Writing a script that implements the logic of asahi_esp_devpart() is
also not trivial.  Especially because there are no actual working
examples of such a script in U-Boot.  At least I can't find any
definitions of the "mt7987_i2p5ge_load_pmb_firmware",
"mt7987_i2p5ge_load_dspbit_firmware" or
"mt7988_i2p5ge_load_pmb_firmware" scripts that are used by
drivers/net/phy/mediatek/mtk-2p5ge.c.  And that is currently the only
driver that uses request_firmware_into_buf_via_script().

I'd prefer to keep using request_firmware_into_buf() until there is an
actual use case that requires more flexibility.  For now I'm not aware
of any hardware besides the Apple M2 and M2 Pro machines that have an
ASMedia PCI XHCI controller that requires loading firmware.
