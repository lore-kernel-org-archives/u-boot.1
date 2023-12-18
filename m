Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1E2C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 17:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03DB78718A;
	Mon, 18 Dec 2023 18:02:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E206871A6; Mon, 18 Dec 2023 18:02:04 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3BD1F870DF
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 18:02:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CD062F4;
 Mon, 18 Dec 2023 09:02:46 -0800 (PST)
Received: from e130802.arm.com (unknown [10.57.4.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B21803F5A1;
 Mon, 18 Dec 2023 09:02:00 -0800 (PST)
Date: Mon, 18 Dec 2023 17:01:56 +0000
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: u-boot@lists.denx.de, nd@arm.com
Subject: Re: Adding EFI runtime support to the Arm's FF-A bus
Message-ID: <20231218170156.GA319765@e130802.arm.com>
References: <20231214155346.GB295924@e130802.arm.com>
 <87ttok689d.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttok689d.fsf@bloch.sibelius.xs4all.nl>
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

Hi Mark,

On Thu, Dec 14, 2023 at 05:47:42PM +0100, Mark Kettenis wrote:
> > Date: Thu, 14 Dec 2023 15:53:46 +0000
> > From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> 
> Hi Abdellatif,
> 
> > Hi guys,
> > 
> > I'd like to ask for advice regarding adding EFI RT support to the Arm's FF-A bus
> > in U-Boot.
> > 
> > The objective is to enable the FF-A messaging APIs in EFI RT to be
> > used for comms with the secure world. This will help getting/setting
> > EFI variables through FF-A.
> > 
> > The existing FF-A APIs in U-Boot call the DM APIs (which are not available at RT).
> > 
> > Two possible solutions:
> > 
> > 1/ having the entire U-Boot in RT space (as Simon stated in this discussion[1])
> 
> I don't think this is a terribly good idea.  With this approach orders
> of magnitude more code will be present in kernel address space one the
> OS kernel is running and calling into the EFI runtime.  Including code
> that may access hardware devices that are now under OS control.  It
> will be nigh impossible to audit all that code and make sure that only
> a safe subset of it gets called.  So...
> 
> > 
> > 2/ Create an RT variant for the FF-A APIs needed.
> >       These RT variant don't call the DM APIs
> >       (e.g: ffa_mm_communicate_runtime, ffa_sync_send_receive_runtime, ...)
> > 
> > What do you recommend please ?
> 
> ...this is what I would recommend.  Preferably in a way that refactors
> the code such that the low-level functionality is shared between the
> DM and non-DM APIs.

That's my preferred solution, thanks.

Cheers,
Abdellatif
