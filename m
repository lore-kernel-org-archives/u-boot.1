Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD44E9B250
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 12:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 779BD83DEA;
	Tue, 24 Feb 2026 13:08:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ld9BNaP6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA68F83E13; Tue, 24 Feb 2026 13:08:39 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35D7583BC9
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 13:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eballetbo@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4E24143C7C
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 12:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB0AC19422
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 12:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771934915;
 bh=MJkxj73xkxGxxhsnrmkH2PrIC031RqKXLHQlFdKpHCQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Ld9BNaP67ShELSGW0W46FSOS3nDFr6vlcrmtWPad66ZE55SFexwg64g/+/aAzzVni
 C1ubrADgxVQF6HnXihHmuDtUX0AH+z1UKyCqKMIqd12CukxQdDmKvtMTqb+xDj1len
 qshhpf2a3mfJwLMnB+JVEopZxpYTWEklacTlFCljtR+Vk5UF+cL9eUJ8UczgA7Y07T
 ZBtvj+Va0ahDcEGR18VDc2AMGBwgErVva2zrLySGabO7/hmfsVfkDsGACcVkslfJaU
 gyEHqRyh+jUw4ekbBgbVxJFXLLI23srvFKAcw3tfVnRJsH0MKVr4+zKrwWbmJ3e5ip
 5bRYvwAM6T5pw==
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7d18d72c034so816075a34.3
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 04:08:35 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX4rm/j0iamoo/fc9cKJ2s031Sy7J6uGqTBqnQM1Y332JtysfB9fbpVnPI+WlO//NHEZI+4odI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9z1KrTC79Eej0vqHNScgAWchHIMPbQ5PEmhWvfES53FoUw1/l
 hDS1z+/wGbs+a89GsOQCDLOUqIcPyT/jF4uNawORGgeKNSZ6f0JoRlbBki61fHoPjDUHEOo5/Ud
 fpyEonpR4rnh0EhG4SLqMf9bg0m/yeXORPTANtuUJfQ==
X-Received: by 2002:a05:6830:91c:b0:7cf:d117:88c4 with SMTP id
 46e09a7af769-7d52bf51beemr6428073a34.6.1771934914259; Tue, 24 Feb 2026
 04:08:34 -0800 (PST)
MIME-Version: 1.0
References: <20260120164524.253188-1-ekovsky@redhat.com>
 <87ikckmbbi.fsf@kernel.org>
 <aZc_efHFk1Q-iWvP@daedalus> <20260219172836.GN3233182@bill-the-cat>
In-Reply-To: <20260219172836.GN3233182@bill-the-cat>
From: Enric Balletbo i Serra <eballetbo@kernel.org>
Date: Tue, 24 Feb 2026 13:08:23 +0100
X-Gmail-Original-Message-ID: <CALE0LRsCYT=h=X1fs_+H9WCWSeQSC2REfXRscg3eaK1=TVtNFg@mail.gmail.com>
X-Gm-Features: AaiRm50yIz0xk4X2yHUI1xvyHjYJH5WDdTWxHM4XNBvcgJaXjSnDauBWP4VOqag
Message-ID: <CALE0LRsCYT=h=X1fs_+H9WCWSeQSC2REfXRscg3eaK1=TVtNFg@mail.gmail.com>
Subject: Re: [PATCH v3] Add support for OpenSSL Provider API
To: Tom Rini <trini@konsulko.com>
Cc: Eddie Kovsky <ekovsky@redhat.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tobias Olausson <tobias@eub.se>, Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 a.fatoum@pengutronix.de, mark.kettenis@xs4all.nl, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi all,

Thanks Eddie for the effort on doing this.

On Thu, Feb 19, 2026 at 6:28=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Feb 19, 2026 at 09:51:05AM -0700, Eddie Kovsky wrote:
>
> > On 01/29/26, Mattijs Korpershoek wrote:
> > > Hi Eddie,
> > >
> > > Thank you for the patch.
> > >
> >
> > Hi Mattijs
> >
> > Thanks for the review.
> >
> > > On Tue, Jan 20, 2026 at 09:45, Eddie Kovsky <ekovsky@redhat.com> wrot=
e:
> > >
> > > > The Engine API has been deprecated since the release of OpenSSL 3.0=
. End
> > > > users have been advised to migrate to the new Provider interface.
> > > > Several distributions have already removed support for engines, whi=
ch is
> > > > preventing U-Boot from being compiled in those environments.
> > > >
> > > > Add support for the Provider API while continuing to support the ex=
isting
> > > > Engine API on distros shipping older releases of OpenSSL.
> > > >
> > > > This is based on similar work contributed by Jan Stancek updating L=
inux
> > > > to use the Provider interface.
> > > >
> > > >     commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
> > > >     Author: Jan Stancek <jstancek@redhat.com>
> > > >     Date:   Fri Sep 20 19:52:48 2024 +0300
> > > >
> > > >         sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJ=
OR >=3D 3
> > > >
> > > > The changes have been tested with the FIT signature verification vb=
oot
> > > > tests on Fedora 42 and Debian 13. All 30 tests pass with both the l=
egacy
> > > > Engine library installed and with the Provider API.
> > > >
> > > > Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
> [snip]
> > Sure, I can update the comment for v4.
>
> Since we're talking about v4, can you please make sure that for v4 it:
> - Passes CI https://docs.u-boot.org/en/latest/develop/ci_testing.html as
>   that will cover some non-Linux host builds.
> - See if you can get access to a FreeBSD or OpenBSD host and make sure
>   the tools build still works there too? I was hoping Mark would have
>   commented / tested-by v3 because I do want to make sure the libressl
>   case still builds. At worst case, I have a freebie Oracle VM that's
>   FreeBSD based, so you can maybe spin one of those up as well?
>

I wanted to provide some context on my testing efforts. I have
successfully tested these patches on Fedora and CentOS Stream 10,
where the engine support is already deprecated. These changes are
quite important because we are currently carrying them as a downstream
patch for some RPM packages.

Regarding testing on OpenBSD and FreeBSD ( it uses openssl 3.0 by
default ), I tried, but I ran into some build issues that I couldn't
quickly resolve due to my limited experience with those environments.
Instead, I decided to test with an alpine+libressl container and can
confirm that the build of the tools does not break with these patches
applied, which should cover the libressl case you were concerned
about.

   # make tools
   # ldd tools/mkimage
   /lib/ld-musl-x86_64.so.1 (0x7f12975f5000)
   libssl.so.60 =3D> /usr/lib/libssl.so.60 (0x7f12973a4000)
   libcrypto.so.57 =3D> /usr/lib/libcrypto.so.57 (0x7f129722a000)
   libc.musl-x86_64.so.1 =3D> /lib/ld-musl-x86_64.so.1 (0x7f12975f5000)

   # strings /usr/lib/libcrypto.so.57 | grep -i "libressl"
   LibreSSL 4.2.1
   %s/libressl.cnf

I'm happy to provide my tested-by tag if it helps move the patch
along. Feel free to include it in v4.

Tested-by: Enric Balletbo i Serra <eballetbo@kernel.org>

Thanks,

   Enric

> Thanks!
>
> --
> Tom
