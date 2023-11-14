Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EEAC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 19:09:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69DA786F0D;
	Tue, 14 Nov 2023 20:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="DdqBEFiz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFC6886F7D; Tue, 14 Nov 2023 20:09:56 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1033086996
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 20:09:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 62888e8d-8321-11ee-91e7-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 62888e8d-8321-11ee-91e7-005056994fde;
 Tue, 14 Nov 2023 20:09:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=7CM+dAhoHXakMBNteLn9Hwtq/HhTcNU3krgD//Ue7A4=;
 b=DdqBEFiz7dwnfgG4nF19FC9/LInZALcWr2NAh3mMJNb3NlJGBNOc5SIAZ4ED6AkWUGbCUsU2NhjZk
 hSexXWkAHAr04dgnRamcwtT0cra1iSHMl/hTv53t5Pz8oKLtolj0tVSFmGJakm4tpiIUFjA1lgD5zT
 dijmQv/zO/n7xqnRkkVIV84TR/9w2MMxiyfFKkPeG8rNCSm+QoBnuQfSSHuoZBiorzE9H7Wpl5ibzn
 +KtHFLFJ86/ixUAf8im4kYzVN1klQ9G6pI/2E/2PFmBxw+87AdiqsD6ei6eSI7zu6YTy8TnOY6SJNi
 uPNGQB6md1YDo/QLbKDlDXK2zN9n+UA==
X-KPN-MID: 33|B4aD/r+MenM38bpb3KQxz6fW369cK7tMXuyqjj2CFO0EwZm5ucXJTrd64DbA1pL
 PQmCPAhFJ2AClGB4Ipz4teWelVM+zmwZCuNcl8ITVfPE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|NW0gf/6OkKWWk81MEV5aWXvsaH05+52QQTxGwURu3RvB4CsfxW0ZwIXUdr4/97z
 C3tgq/4NjVF0i98BBuOHtzg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 63906bb9-8321-11ee-ac7f-00505699b758;
 Tue, 14 Nov 2023 20:09:53 +0100 (CET)
Date: Tue, 14 Nov 2023 20:09:52 +0100
Message-Id: <877cmk9mnz.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@google.com>
Cc: trini@konsulko.com, heinrich.schuchardt@canonical.com,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de, dianders@google.com
In-Reply-To: <CAPnjgZ3Yqf3-9wjVTYh5eR_=rFuf-2eWUvZmfv=U1xDCVEWSXQ@mail.gmail.com>
 (message from Simon Glass on Fri, 3 Nov 2023 13:17:18 -0600)
Subject: Re: [PATCH v2 1/1] efi_loader: expose the device-tree file name
References: <0c1abfbc-fd2a-4dd9-8447-53e5ee32ab85@canonical.com>
 <CAPnjgZ18Utd0V7kctaqD6aZqfmNy9Qogg8dw5WaHkAar9C+Dxw@mail.gmail.com>
 <750bac2f-3bcd-4ae1-b5ed-a82e8159846b@canonical.com>
 <CAPnjgZ3KZLTHUWnnQtBsiaeRRXgHjbqdkfw6cW+_+aXZ9zpogA@mail.gmail.com>
 <ea1ba7c2-7f9c-4702-a6da-efb728771e24@canonical.com>
 <20231020162410.GK3119521@bill-the-cat>
 <CAPnjgZ0zwQ+J-17YEhAtTtLhTcK7K9=nqNNqOdNmG5bY+rFrhg@mail.gmail.com>
 <7481371f-657d-46d6-b8e7-74da7a200ee9@canonical.com>
 <CAPnjgZ3_WSS+Z2xsRTvf-7ChPN42OVLgLf8ZvGv=2FVrNuHkhA@mail.gmail.com>
 <87h6mhqri9.fsf@bloch.sibelius.xs4all.nl>
 <20231023163455.GL496310@bill-the-cat>
 <87fs21qnex.fsf@bloch.sibelius.xs4all.nl>
 <CAPnjgZ3Yqf3-9wjVTYh5eR_=rFuf-2eWUvZmfv=U1xDCVEWSXQ@mail.gmail.com>
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

> From: Simon Glass <sjg@google.com>
> Date: Fri, 3 Nov 2023 13:17:18 -0600
> 
> Hi,
> 
> On Mon, 23 Oct 2023 at 11:06, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> >
> > > Date: Mon, 23 Oct 2023 12:34:55 -0400
> > > From: Tom Rini <trini@konsulko.com>
> > >
> > > On Mon, Oct 23, 2023 at 05:37:34PM +0200, Mark Kettenis wrote:
> > > > > From: Simon Glass <sjg@google.com>
> > > > > Date: Mon, 23 Oct 2023 00:08:40 -0700
> > > > >
> > > > > > > fdt_node_check_compatible() does most of the work...then you need to
> > > > > > > check which FDT has the most specific match (i.e. latest in the string
> > > > > > > list). That handles things like board revisions, variants, etc.
> > > > > > >
> > > > > > > My concern is about adding a feature when there is already a defined
> > > > > > > spec and mechanism for this to work. What happens when we load the
> > > > > > > file and the compatible is wrong?
> > > > > > >
> > > > > > > At best, I see the filename as a hint.
> > > > > > >
> > > > > > > [Perhaps this is the wrong time to ask, but why are kernels +DT not
> > > > > > > shipped in FIT on ARM?]
> > > > > >
> > > > > > FIT is U-Boot specific. For Linux distributions it is easier to use a
> > > > > > firmware agnostic method of booting.
> > > > >
> > > > > I'd like to suggest that distros use both. Then U-Boot can work as it
> > > > > was designed and we can avoid these work-arounds.
> > > > >
> > > > > FIT is actually implemented in various other bootloaders. In fact
> > > > > perhaps grub is the only one that doesn't? I can't think of any
> > > > > others.
> > > >
> > > > Simon, please stop pushing this.  OpenBSD's bootloader does not
> > > > support FIT and we have no interest in supporting it.  Our users
> > > > expect to be able to just copy a new kernel in place and use it and
> > > > our OS upgrade procedure depends on this as well.  And this is
> > > > incompatble with FIT.  I've explained this about a dozen times to you
> > > > now.
> > >
> > > In the context of this thread, genuinely, how will OpenBSD (and the rest
> > > of the BSD families) operate? I agree U-Boot doesn't want to have to
> > > know all of the UFSes, so that means the SCT will be populated either by
> > > the DT passed to U-Boot, or the DT we were built with. Is it that since
> > > the next stage is an EFI app, it will check that variable and use that
> > > hint?
> >
> > Yes, that is exactly what I want to do.  Hopefully the DT that is
> > passed to U-Boot or that U-Boot was built with will be good enough in
> > most cases.  But when it isn't users can use the OpenBSD bootloader
> > (which is an EFI app) to load an updated DT.
> >
> > I can't speak for the other BSDs, but I think both FreeBSD and NetBSD
> > have a very similar boot mechanism.
> 
> I've been thinking about this patch a bit more, and I have grave misgivings.
> 
> I predict that if we take this, it will become an ABI from U-Boot and
> we will not be able to drop it.

Why would we want to drop it?

> Here is what I suggest instead: provide a protocol for U-Boot to
> provide the DT over EFI. Provide any information needed by U-Boot,
> such as the directory containing the files.

So you want something more complicated than a simple EFI variable?  Why?

> We already have the ability to put a DT in the system table. We
> already have a way to package DT into a FIT and allow U-Boot to select
> the correct one.

Please stop pushing FIT for use cases where it doesn't make sense.

> With something like this it will be impossible for U-Boot to boot a
> distro without using grub, etc. since it won't know what DT to use.
> This information would be held in a script somewhere which no one can
> figure out without executing it.

Huh?  U-Boot already knows the name of name of the DT filename.  It is
what we currently use in the distroboot scripts.  You are free to use
a U-Boot specific bootflow based on that if you really want to.  But
many distros (or other OSes like OpenBSD) really don't want to
maintain support for multiple boot flows.
