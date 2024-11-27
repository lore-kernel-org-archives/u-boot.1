Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570DAD6ACCE
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 13:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD75D8962C;
	Wed, 27 Nov 2024 14:23:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="kahMHJXC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 865C08958D; Wed, 27 Nov 2024 14:23:42 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BF6088E4B
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 14:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: cfc4291f-acc2-11ef-93fe-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id cfc4291f-acc2-11ef-93fe-005056994fde;
 Wed, 27 Nov 2024 14:23:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=O6NQdXS0UhNA4r7vNxy7Eh0HRGwFo8hDFUlcdHsLyvk=;
 b=kahMHJXC738yOgALm4BOODeJg7GWoN35Q2F1jdF6P4hHXKef58+X7kQ1hJY9LhRSSAYYPaPgFndTy
 PU0yb4rOvDjdbh+hgVMTzZ6NUYCNWigsVHEwcm/cLB3EPIXhitJV99ZXTxP5JY3MinKgGh3Hzo7VXA
 sSijo8cC7XTTvFlauJUYJ8wlsOkpbZK1pH/zhBorKJN0RbEXLgLvotgXd5leSxA5nEyIOlVmHCLjtM
 A5ps+/wJWhc1VfZy0qQRom689rK7ciijixDs6mwYJ/tHTcMpcT61Rx3FkqJgccVTKU4xzqO3F9/G57
 2vJD78x97Pff1qgcSMwpB5UlaPOSNaQ==
X-KPN-MID: 33|Gl8gaLPHgo10ubqEBWaV9QHo0vdp/SEWeLWzXnRztppxpAbAEr+ESpBgsm5zZb9
 Fyt3+OQ9CMTAO/kSFoIGCBLPCTCCSWcjlhDYDLQhWrUo=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|6fOXqcY3JkMhdGx7se0oBYC5mmPKcrBMCwr5qKIYsysMaBCnMB8aDP31vmORABq
 SodiRNR1FPIS2PbIXZjgszw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id d01d82ad-acc2-11ef-b675-00505699b758;
 Wed, 27 Nov 2024 14:23:39 +0100 (CET)
Date: Wed, 27 Nov 2024 14:23:38 +0100
Message-Id: <87iks8zu79.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 akashi.tkhro@gmail.com, caleb.connolly@linaro.org,
 j@jannau.net, marek.vasut+renesas@mailbox.org,
 moritzf@google.com, pwildt@google.com,
 sughosh.ganu@linaro.org, trini@konsulko.com,
 vincent.stehle@arm.com, u-boot@lists.denx.de
In-Reply-To: <CAFLszTjWgWZ6VZg8ZQOd2RVrX-+vGy1NuwaBZ+8vwGJ2R83wqw@mail.gmail.com>
 (message from Simon Glass on Wed, 27 Nov 2024 06:07:05 -0700)
Subject: Re: [PATCH 06/13] efi_loader: Use the enum for memory type
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-7-sjg@chromium.org>
 <5976a08e-a242-4665-85e6-410f48776229@gmx.de>
 <CAFLszThWDNCNhZ6wAaG3omKpT-ZEDkK-R1W-9DWyMuth8Vd55Q@mail.gmail.com>
 <CAFLszTjWgWZ6VZg8ZQOd2RVrX-+vGy1NuwaBZ+8vwGJ2R83wqw@mail.gmail.com>
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

> From: Simon Glass <sjg@chromium.org>
> Date: Wed, 27 Nov 2024 06:07:05 -0700
> 
> Hi Heinrich,
> 
> On Tue, 26 Nov 2024 at 08:37, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Heinrich,
> >
> > On Tue, 26 Nov 2024 at 02:44, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 25.11.24 21:44, Simon Glass wrote:
> > > > Rather than an integer, it is better to use the enum provided, when
> > > > referring to an EFI memory-type. Update existing uses.
> > >
> > > The C standard provides no definition of the size of the integer used to
> > > implement enums. It could use u8, u16, u32, or u64.
> > >
> > > As EFI applications may be compiled using a different compiler we need
> > > to control the width used for passing parameters in the API interface.
> > >
> > > We should have used u32 instead of int here. We could use a typedef for
> > > more verbosity though that is frowned upon in U-Boot.
> >
> > Yes, the ext function is debatable. The rest seem OK to me, though, as
> > they are internal functions, See also [1].
> 
> Hmm, but the spec uses enum, so arguably this patch is more correct?

Only as a way to define the constants.  The actual interfaces that use
the constants use UINT32, which would indeed be u32 in Linux land as
Heinrich suggests.

So no, the patch isn't correct.

> > >
> > > Best regards
> > >
> > > Heinrich
> > >
> > > >
> > > > Call the value 'mem_type' consistently. Fix up one instance of
> > > > upper-case hex.
> > > >
> > > > Fix up the calls in struct efi_boot_services so that they use the same
> > > > enum, adding the missing parameter names and enum efi_allocate_type.
> > > >
> > > > While we are here, rename the 'memory' parameter to 'memoryp' so that it
> > > > is clear it is a return value.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >   include/efi_api.h                |  6 ++++--
> > > >   include/efi_loader.h             | 28 ++++++++++++++-------------
> > > >   lib/efi_loader/efi_boottime.c    | 13 +++++++------
> > > >   lib/efi_loader/efi_device_path.c |  4 ++--
> > > >   lib/efi_loader/efi_memory.c      | 33 ++++++++++++++++----------------
> > > >   5 files changed, 45 insertions(+), 39 deletions(-)
> > > >
> >
> > Regards,
> > SImon
> >
> > [1] https://stackoverflow.com/questions/4879286/specifying-size-of-enum-type-in-c/4879350#4879350
> 
> Regards,
> Simon
> 
