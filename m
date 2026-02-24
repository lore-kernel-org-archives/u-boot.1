Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E212EF4BB93
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 22:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E2B683642;
	Tue, 24 Feb 2026 23:24:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="nwp1PU2a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91CCE83981; Tue, 24 Feb 2026 23:24:02 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19AC882BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 23:24:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 83e3cac0-11cf-11f1-8ff1-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 83e3cac0-11cf-11f1-8ff1-005056999439;
 Tue, 24 Feb 2026 23:23:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=content-type:mime-version:subject:to:from:message-id:date;
 bh=nHmv6tr2dtV4sk0E5GWk1nnQCIH0U4kS1lwiZDDILmo=;
 b=nwp1PU2aLZkQ0Tn/mDAdN54Sq7ZQt3e6ShfN4eLHMhPb2iQ2pswKo4xJ2bGPx482BHCRs7XaIkTnn
 rPu6/QQJLC6n4F0njGJcobMlZ/eHn7rQnqZTGhWcip4gUeNwYVswk1rXZf4OI0t46+MutKbOnAmxbu
 in8wA0MBqGPa6iXppwOZhtEyu50RQfAKobbhZTF8QZmus0htQbimAxCoR+rUkX73ZTyZEg5lPj1Fv9
 XPi1a3UXrpf0EmFEzJrglvmJoy8RiLoCpuDYJf30ir1TTWLazeN62D6mxurY99XliYxFL4eOcHuDGG
 1uOCHcPfiR8QphHPEnjEdWBGUXf9row==
X-KPN-MID: 33|eDL3peFgPTz2lS5FUsQxa1Z2zlCGW4+F8wCFNL760uBxnKZF9f/yi3mmExfeIjP
 mvFr0a7Jgn03Oefi5okzbZ1xVzxU4DkIwTIg375TlLAA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|dDnSGikVUB9XLfOsde0f0/+1jjBkHWX8CJbjFSDLzr8pA57XTgkyvnBwL2MnQd0
 N2AvB6g8HVSzngSNna+qR/A==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 834d3c4f-11cf-11f1-8d40-00505699b758;
 Tue, 24 Feb 2026 23:23:59 +0100 (CET)
Date: Tue, 24 Feb 2026 23:23:58 +0100
Message-Id: <87a4wxwzk1.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Enric Balletbo i Serra <eballetbo@kernel.org>
Cc: trini@konsulko.com, ekovsky@redhat.com, mkorpershoek@kernel.org,
 tobias@eub.se, paul.henrys_ext@softathome.com,
 sjg@chromium.org, jstancek@redhat.com,
 a.fatoum@pengutronix.de, u-boot@lists.denx.de
In-Reply-To: <CALE0LRsCYT=h=X1fs_+H9WCWSeQSC2REfXRscg3eaK1=TVtNFg@mail.gmail.com>
 (message from Enric Balletbo i Serra on Tue, 24 Feb 2026 13:08:23
 +0100)
Subject: Re: [PATCH v3] Add support for OpenSSL Provider API
References: <20260120164524.253188-1-ekovsky@redhat.com>
 <87ikckmbbi.fsf@kernel.org>
 <aZc_efHFk1Q-iWvP@daedalus> <20260219172836.GN3233182@bill-the-cat>
 <CALE0LRsCYT=h=X1fs_+H9WCWSeQSC2REfXRscg3eaK1=TVtNFg@mail.gmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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

> From: Enric Balletbo i Serra <eballetbo@kernel.org>
> Date: Tue, 24 Feb 2026 13:08:23 +0100

Hi,

> Hi all,
> 
> Thanks Eddie for the effort on doing this.
> 
> On Thu, Feb 19, 2026 at 6:28 PM Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Feb 19, 2026 at 09:51:05AM -0700, Eddie Kovsky wrote:
> >
> > > On 01/29/26, Mattijs Korpershoek wrote:
> > > > Hi Eddie,
> > > >
> > > > Thank you for the patch.
> > > >
> > >
> > > Hi Mattijs
> > >
> > > Thanks for the review.
> > >
> > > > On Tue, Jan 20, 2026 at 09:45, Eddie Kovsky <ekovsky@redhat.com> wrote:
> > > >
> > > > > The Engine API has been deprecated since the release of OpenSSL 3.0. End
> > > > > users have been advised to migrate to the new Provider interface.
> > > > > Several distributions have already removed support for engines, which is
> > > > > preventing U-Boot from being compiled in those environments.
> > > > >
> > > > > Add support for the Provider API while continuing to support the existing
> > > > > Engine API on distros shipping older releases of OpenSSL.
> > > > >
> > > > > This is based on similar work contributed by Jan Stancek updating Linux
> > > > > to use the Provider interface.
> > > > >
> > > > >     commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
> > > > >     Author: Jan Stancek <jstancek@redhat.com>
> > > > >     Date:   Fri Sep 20 19:52:48 2024 +0300
> > > > >
> > > > >         sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
> > > > >
> > > > > The changes have been tested with the FIT signature verification vboot
> > > > > tests on Fedora 42 and Debian 13. All 30 tests pass with both the legacy
> > > > > Engine library installed and with the Provider API.
> > > > >
> > > > > Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
> > [snip]
> > > Sure, I can update the comment for v4.
> >
> > Since we're talking about v4, can you please make sure that for v4 it:
> > - Passes CI https://docs.u-boot.org/en/latest/develop/ci_testing.html as
> >   that will cover some non-Linux host builds.
> > - See if you can get access to a FreeBSD or OpenBSD host and make sure
> >   the tools build still works there too? I was hoping Mark would have
> >   commented / tested-by v3 because I do want to make sure the libressl
> >   case still builds. At worst case, I have a freebie Oracle VM that's
> >   FreeBSD based, so you can maybe spin one of those up as well?
> >

Sorry, I've been a bit busy the last weeks.  But I threw this on top
of today's master and built a few of my favourite targets.  There
seems to no regressions in the build experience.

> I wanted to provide some context on my testing efforts. I have
> successfully tested these patches on Fedora and CentOS Stream 10,
> where the engine support is already deprecated. These changes are
> quite important because we are currently carrying them as a downstream
> patch for some RPM packages.
> 
> Regarding testing on OpenBSD and FreeBSD ( it uses openssl 3.0 by
> default ), I tried, but I ran into some build issues that I couldn't
> quickly resolve due to my limited experience with those environments.
> Instead, I decided to test with an alpine+libressl container and can
> confirm that the build of the tools does not break with these patches
> applied, which should cover the libressl case you were concerned
> about.
> 
>    # make tools
>    # ldd tools/mkimage
>    /lib/ld-musl-x86_64.so.1 (0x7f12975f5000)
>    libssl.so.60 => /usr/lib/libssl.so.60 (0x7f12973a4000)
>    libcrypto.so.57 => /usr/lib/libcrypto.so.57 (0x7f129722a000)
>    libc.musl-x86_64.so.1 => /lib/ld-musl-x86_64.so.1 (0x7f12975f5000)
> 
>    # strings /usr/lib/libcrypto.so.57 | grep -i "libressl"
>    LibreSSL 4.2.1
>    %s/libressl.cnf
> 
> I'm happy to provide my tested-by tag if it helps move the patch
> along. Feel free to include it in v4.
> 
> Tested-by: Enric Balletbo i Serra <eballetbo@kernel.org>
> 
> Thanks,
> 
>    Enric
> 
> > Thanks!
> >
> > --
> > Tom
> 
