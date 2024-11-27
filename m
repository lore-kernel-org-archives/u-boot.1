Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775BED6ACD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 13:52:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C11BE895C6;
	Wed, 27 Nov 2024 14:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="N+Uaz4pp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89C69895C6; Wed, 27 Nov 2024 14:52:47 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78F74890CE
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 14:52:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: e00c132f-acc6-11ef-93fe-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id e00c132f-acc6-11ef-93fe-005056994fde;
 Wed, 27 Nov 2024 14:52:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=OBnZLPgheUpsRD4maRPx6huW3Ck5QIhnyhM768SCjUM=;
 b=N+Uaz4ppWDhylw8vVgV29o8XWKn9srHnE7K9m7MkruYopexpAcj7OhQXcM4SfgX1nxVVPpE/RlA78
 fwfRQPdyPupkpnHo8KKVhUFzkMOlkKNeOp9L6S0T02j638kDRhAbTWxpb5mTcMLEVtInjmyNab+n0k
 JHdTKpUagd8cga1fWIJXSO9cyUSSN1q+CtKmRjET6Hy55VsyprECbl3KREfzYadz6wZwtFceYL/0P+
 iwp6lGVT3PySSxaWakzO135+/kZato4EwjTkBpwSXZBDZGhUOn6oPZ8F3SSuczOOWHH6/1DbD6xdox
 0ovQSRzTHEFTi0YTwxeFnRM7lHFNNhw==
X-KPN-MID: 33|k1Q/5aUcIaMsLMp9Zp/0qd+3SIs0oSkGXm0OScKLCUcRBX8ZApEGQm2ZfvG5m3l
 6jzN8K0RIs+1qGBSF8xvopAft31xhsvfTCJWQuqaS1+k=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Axu5dDIKivMyZOth4f3EfwkDOGGutB24t5hphHVrDJM2XL6D2CM2wTAgVHwmbte
 fAqR4myYnnbrvmtxU1K9Beg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id e066a090-acc6-11ef-b675-00505699b758;
 Wed, 27 Nov 2024 14:52:44 +0100 (CET)
Date: Wed, 27 Nov 2024 14:52:43 +0100
Message-Id: <87h67szsus.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, akashi.tkhro@gmail.com,
 caleb.connolly@linaro.org, j@jannau.net,
 marek.vasut+renesas@mailbox.org, kettenis@openbsd.org,
 kojima.masahisa@socionext.com, moritzf@google.com,
 pwildt@google.com, sughosh.ganu@linaro.org,
 vincent.stehle@arm.com, u-boot@lists.denx.de
In-Reply-To: <CAFLszThDb-dCiGUqDdZmTMAgU7X6P0Zya3ovUgPibPKJQMasVg@mail.gmail.com>
 (message from Simon Glass on Wed, 27 Nov 2024 06:08:10 -0700)
Subject: Re: [PATCH 00/13] efi: Tidy up confusion between pointers and
 addresses
References: <20241125204456.1525752-1-sjg@chromium.org>
 <a6ba9ebe-9d52-4b2d-bb62-02c4f0ea86fb@gmx.de>
 <CAFLszThf3aSwi1yhaQP9Ns7wTNjKH8XicAqUU6vy5gej5GP+CQ@mail.gmail.com>
 <20241126160817.GS3600562@bill-the-cat>
 <CAFLszThDb-dCiGUqDdZmTMAgU7X6P0Zya3ovUgPibPKJQMasVg@mail.gmail.com>
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
> Date: Wed, 27 Nov 2024 06:08:10 -0700

Hi Simon,

> Hi Tom,
> 
> On Tue, 26 Nov 2024 at 09:08, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Nov 26, 2024 at 08:39:05AM -0700, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Tue, 26 Nov 2024 at 02:10, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > >
> > > > On 25.11.24 21:44, Simon Glass wrote:
> > > > > The EFI-loader implementation converts things back and forth between
> > > > > addresses and pointers, with not much consistency in how this is done.
> > > > >
> > > > > Within most of U-Boot a pointer is a void * and an address is a ulong
> > > >
> > > > No. It is phys_addr_t that was introduced to handle the sandbox's
> > > > virtual addresses.
> > > >
> > > > And we should keep this sandbox stuff out of the EFI code. They are only
> > > > needed for the command line interface.
> > >
> > > No. My statement is correct and long predates sandbox. U-Boot has
> > > always used ulong. Using an address is generally much easier than a
> > > pointer, so I believe this design decision was (and remains) a good
> > > one. I certainly would not support changing it. The phys_addr_t type
> > > has nothing to do with sandbox.
> >
> > At the high level, I think parts of the problem are that when U-Boot
> > went from 32bit architectures to 36bit architectures (assorted PowerPC
> > Freescale parts) to 64bit architectures that no, we didn't make some
> > concious and consistent statement that "ulong is for address (except
> > when it's not). If you look at the linux kernel, phys_addr_t is physical
> > addresses, ulong is virtual addresses.
> >
> > And so phys_addr_t was introduced, iirc, for PowerPC where we had a
> > 32bit architecture with 36bit addresses and had to deal with that.
> 
> OK, thanks.
> 
> I'm a bit unsure what to do here...but am leaning towards having a
> separate struct for the memory areas in struct efi_mem_list, rather
> than using the same efi_mem_desc. Then I can have one use addresses
> and the other pointers.

That does not make sense to me.  Why would you want to use pointers to
manage what is effectively a memory address map?
