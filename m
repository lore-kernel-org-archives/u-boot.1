Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F73C25B45
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 17:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C268686F90;
	Mon, 23 Oct 2023 19:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="GMY7SKyO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AF7586F46; Mon, 23 Oct 2023 19:06:02 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84CDE86F90
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 19:06:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 69917556-71c6-11ee-90ec-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 69917556-71c6-11ee-90ec-00505699b430;
 Mon, 23 Oct 2023 19:05:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=5jzGx5u3ts6OzkhkgUAt/ar8yPQ9xyfFJEMzG+3ZgIA=;
 b=GMY7SKyO/A9+O7bN7kg82mG6/F2RlI3dLbPNfnB+1bTm8I0gvkmad7Y1jaZhxkMp0g0A/VXDaT42c
 D1JVBAfBegkiOxngnMbQqqF4+2FWUXKjYB/hAiA3ZpNVq/dGHZHQAdpYxLehsxYtpJiw+9HXK50FMm
 ozYmiWdZn3tj7/ocnpGzEJ1n1B31bZbBJ2dc5NqTHUBvTWRNEDUxkgYdkMabprTZtuy1m97+8k2Bs4
 b8LWaICF/yG1znzL5UC3naKCghZBehw22Y0b3otWp5UL9GRxgDL3F7Ko4/pPYGxM/n9N65eB/n2F5y
 z/kH/XInDm2YQZaOEhmtNEiOx8N3s7w==
X-KPN-MID: 33|oQUYTOBhcvVh1MVBNX6b8YBzLaN9LvdUCyO9cEuk6OPMcgQJnxQdzlPDqJB9TE6
 CXK9FCbK2EdfkB0gdtoPC6Di4o0mF2GDpwHSq+7ImNuE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|o0wF2ujyh7UyHjJs8SckL651mGHApXI2oik6dS3yNxLBiKYn1hPqe4Y5kc2ffgB
 S7j4JHmQCawBLfMA+TVWgjw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 6fe712e4-71c6-11ee-ad2d-005056998788;
 Mon, 23 Oct 2023 19:05:59 +0200 (CEST)
Date: Mon, 23 Oct 2023 19:05:58 +0200
Message-Id: <87fs21qnex.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Tom Rini <trini@konsulko.com>
Cc: sjg@google.com, heinrich.schuchardt@canonical.com,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de, dianders@google.com
In-Reply-To: <20231023163455.GL496310@bill-the-cat> (message from Tom Rini on
 Mon, 23 Oct 2023 12:34:55 -0400)
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

> Date: Mon, 23 Oct 2023 12:34:55 -0400
> From: Tom Rini <trini@konsulko.com>
> 
> On Mon, Oct 23, 2023 at 05:37:34PM +0200, Mark Kettenis wrote:
> > > From: Simon Glass <sjg@google.com>
> > > Date: Mon, 23 Oct 2023 00:08:40 -0700
> > > 
> > > > > fdt_node_check_compatible() does most of the work...then you need to
> > > > > check which FDT has the most specific match (i.e. latest in the string
> > > > > list). That handles things like board revisions, variants, etc.
> > > > >
> > > > > My concern is about adding a feature when there is already a defined
> > > > > spec and mechanism for this to work. What happens when we load the
> > > > > file and the compatible is wrong?
> > > > >
> > > > > At best, I see the filename as a hint.
> > > > >
> > > > > [Perhaps this is the wrong time to ask, but why are kernels +DT not
> > > > > shipped in FIT on ARM?]
> > > >
> > > > FIT is U-Boot specific. For Linux distributions it is easier to use a
> > > > firmware agnostic method of booting.
> > > 
> > > I'd like to suggest that distros use both. Then U-Boot can work as it
> > > was designed and we can avoid these work-arounds.
> > > 
> > > FIT is actually implemented in various other bootloaders. In fact
> > > perhaps grub is the only one that doesn't? I can't think of any
> > > others.
> > 
> > Simon, please stop pushing this.  OpenBSD's bootloader does not
> > support FIT and we have no interest in supporting it.  Our users
> > expect to be able to just copy a new kernel in place and use it and
> > our OS upgrade procedure depends on this as well.  And this is
> > incompatble with FIT.  I've explained this about a dozen times to you
> > now.
> 
> In the context of this thread, genuinely, how will OpenBSD (and the rest
> of the BSD families) operate? I agree U-Boot doesn't want to have to
> know all of the UFSes, so that means the SCT will be populated either by
> the DT passed to U-Boot, or the DT we were built with. Is it that since
> the next stage is an EFI app, it will check that variable and use that
> hint?

Yes, that is exactly what I want to do.  Hopefully the DT that is
passed to U-Boot or that U-Boot was built with will be good enough in
most cases.  But when it isn't users can use the OpenBSD bootloader
(which is an EFI app) to load an updated DT.

I can't speak for the other BSDs, but I think both FreeBSD and NetBSD
have a very similar boot mechanism.

Cheers,

Mark
