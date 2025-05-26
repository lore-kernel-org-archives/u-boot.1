Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBCAC54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 18:49:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D48B82E67;
	Mon, 26 May 2025 20:49:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="loffFupB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5994282F14; Mon, 26 May 2025 20:27:41 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1A8E82E25
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 20:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-604f0d27c24so1051586eaf.2
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 11:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748284057; x=1748888857; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hB84sQQG79nBpFRPkrny+VomS6UyA7yHlCe8opZL6Ek=;
 b=loffFupBloha41Dn9L0bcg8CzAx8DIXskU4f4bS7PA+WjzoomP/Jt6YgWlxsOjFG+C
 OKsn99ixZVgXslAkBlnLQiXEBhzM+Jn3hjvlZeqQ3O5S1zSrHquk+UJoXoIl+NDP9fmB
 autdknJztBvF16Akp5vSxG8/qlpNqMwklrFus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748284057; x=1748888857;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hB84sQQG79nBpFRPkrny+VomS6UyA7yHlCe8opZL6Ek=;
 b=NIP2+EfX2Y5qePI+0Z2SwKbrrCDaePwEGe1QcuibwgDDekyD52eY8ySK+ZU6CworrX
 TDc/2XmtCtHNr26rg/UjRb0ROWWvP6tB6zmgMPXVON0NlSYogJb6JYp4QfbRGWmf28/t
 rgBAXI/FOWZinU5kCGJFttsgGhbbwX0p2cXe8pPnDWx8MMlwIzAJJgGnCP31D2mcPqdM
 peGQE3Nec7wM8tooASEtiE7Kg87eSwP2PR6aQBmGHwoHhNDVK94unr2oMbXhaYHZ0dX5
 vfR6yGJiIqFs70iS8E+pYQ9j+E1R5jOFvP/PQyloKAccJn40HGYTf3zCTRbO/BGU6JI0
 4jfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDSeXJanrO4jFYy7Xpft33c4g49Vfj2P6hk5uhgGYaa1pt8JFP9mpO/db9k5Uh89zV/r0XRz4=@lists.denx.de
X-Gm-Message-State: AOJu0YwHWf4cvWCrRl+n7oQjBfki2ZiEELZbi0azqQnTb/GBgDADTgJE
 UlwjDUvWCuK7Drab9hWb3LqdpYi5QtK3d236rpHJy6iWkKZhokZG/s7wgejkVb3sP0U=
X-Gm-Gg: ASbGnctWq028bHXFRlOyabkH4ZzaNuFlgCqxqdaOkkCMGNtAAKFgSoX+yjxOJmAorrJ
 JJPnrhWuMPhP6VSo8ho/afpYYVER4YAGSwvhtj1guuHiW3fsxBmml76Af1/caqQ23kqhXkRv5G7
 bK5+ZbfdkqoUyLEr3wq7BOEIr6ZHwE0stL4CR1oZ4nhzeToh/vGIo+rtFCOC86cZIs8tkS67X/d
 VvNYTYjahw7FU3W9/X+t53EvVsAB5Ei6AH7p0mfjgQ5KyORrR3qva5FIn5gNEvJncAt9znapbWB
 LG692qw1Sx11Qe3oS9pbJvSEGaNDiBkn0Lgb9qwcaeVi2m0D4GQfYH2o3c+EH9R8AxLrij8a2M5
 mae59blca3vAJ
X-Google-Smtp-Source: AGHT+IHYpYO5+Ow2bbH6aFzvuQkHgYqW3oTrXfp3NSi20mXR4j8/hDoxABJMC6Kwn2zyFzVuv4q9rQ==
X-Received: by 2002:a05:6870:9617:b0:2c2:5ac3:4344 with SMTP id
 586e51a60fabf-2e861e19c40mr5212906fac.15.1748284057443; 
 Mon, 26 May 2025 11:27:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c060e1d8sm4962874fac.4.2025.05.26.11.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 11:27:36 -0700 (PDT)
Date: Mon, 26 May 2025 12:27:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, xypron.glpk@gmx.de,
 adrianox@gmail.com, bmeng.cn@gmail.com, caleb.connolly@linaro.org,
 christian@kohlschutter.com, daniel@makrotopia.org,
 ddrokosov@salutedevices.com, eajames@linux.ibm.com,
 francesco.dolcini@toradex.com, hiago.franco@toradex.com,
 ilias.apalodimas@linaro.org, jdanisevskis@aurora.tech, j@jannau.net,
 jeremy.compostella@intel.com, jerome.forissier@linaro.org,
 maks.mishinfz@gmail.com, marek.vasut+renesas@mailbox.org,
 marex@denx.de, mgarrett@aurora.tech, mkorpershoek@baylibre.com,
 michal.simek@amd.com, moritzf@google.com, Oliver.Gaskell@analog.com,
 patrick.delaunay@foss.st.com, patrick.rudolph@9elements.com,
 pkochanowski@sii.pl, pbrobinson@gmail.com,
 philippe.reynes@softathome.com, quentin.schulz@cherry.de,
 raymond.mao@linaro.org, semen.protsenko@linaro.org,
 sebastian.reichel@collabora.com, sughosh.ganu@linaro.org,
 tharvey@gateworks.com, vincent.stehle@arm.com,
 weijie.gao@mediatek.com, ziyao@disroot.org, u-boot@lists.denx.de
Subject: Re: [PATCH 00/10] efi: Move some efi-loader code into a new shared dir
Message-ID: <20250526182732.GB100073@bill-the-cat>
References: <20250523130651.1329593-1-sjg@chromium.org>
 <3b23fc9d-345f-4945-b89d-153a18f5828d@gmx.de>
 <CAFLszTjofbRtjXxfR6MmnHP0hYcpg+pgLKLYDXN2KxLZ2rNPHQ@mail.gmail.com>
 <20250523164909.GV100073@bill-the-cat>
 <8734cv45fr.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszTgiPDQxESZ763G6AmZNSriB1W-OSGEEAtcn769oHep-EQ@mail.gmail.com>
 <20250523221729.GY100073@bill-the-cat>
 <CAFLszTiAdFTemZ9gJr8JCMO2EK2+ihsrKF0UxBHJhC7Fec6=Tg@mail.gmail.com>
 <20250524144116.GL100073@bill-the-cat>
 <CAFLszTh52tgBEiPvese17ugmzxKoyBVcOpV70hCc+mSEGwo=Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pEEdnER1IKxelXqe"
Content-Disposition: inline
In-Reply-To: <CAFLszTh52tgBEiPvese17ugmzxKoyBVcOpV70hCc+mSEGwo=Dw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Mon, 26 May 2025 20:49:40 +0200
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


--pEEdnER1IKxelXqe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 04:35:03PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 24 May 2025 at 15:41, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, May 24, 2025 at 03:20:17PM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 23 May 2025 at 23:17, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, May 23, 2025 at 09:23:15PM +0100, Simon Glass wrote:
> > > > > Hi Mark, Tom,
> > > > >
> > > > > On Fri, 23 May 2025 at 18:12, Mark Kettenis <mark.kettenis@xs4all=
=2Enl> wrote:
> > > > > >
> > > > > > > Date: Fri, 23 May 2025 10:49:09 -0600
> > > > > > > From: Tom Rini <trini@konsulko.com>
> > > > > > >
> > > > > > > On Fri, May 23, 2025 at 05:36:52PM +0100, Simon Glass wrote:
> > > > > > > > Hi Heinrich,
> > > > > > > >
> > > > > > > > On Fri, May 23, 2025, 15:19 Heinrich Schuchardt <xypron.glp=
k@gmx.de> wrote:
> > > > > > > > >
> > > > > > > > > On 23.05.25 15:06, Simon Glass wrote:
> > > > > > > > > > Some functions provided in lib/efi_loader are actually =
useful for the
> > > > > > > > > > app as well. This series refactors the Kconfig and dire=
ctories a little
> > > > > > > > > > so that code is easier to share.
> > > > > > > > > >
> > > > > > > > > > As a starting point, it moves some filename and device-=
path functions to
> > > > > > > > > > the new directory.
> > > > > > > > > >
> > > > > > > > > > The next step would be to move device-path code over, b=
ut this will need
> > > > > > > > > > some discussion.
> > > > > > > > >
> > > > > > > > > Hello Simon,
> > > > > > > > >
> > > > > > > > > Overall the ideas in this series look fine to me. But thi=
s series does
> > > > > > > > > not apply to origin/next.
> > > > > > > > >
> > > > > > > > > Applying: efi_loader: Separate device path into its own h=
eader
> > > > > > > > > Patch failed at 0001 efi_loader: Separate device path int=
o its own header
> > > > > > > > > error: patch failed: cmd/efidebug.c:8
> > > > > > > > > error: cmd/efidebug.c: patch does not apply
> > > > > > > > > error: patch failed: include/efi_loader.h:967
> > > > > > > > > error: include/efi_loader.h: patch does not apply
> > > > > > > > > error: patch failed: lib/efi_loader/efi_bootmgr.c:12
> > > > > > > > > error: lib/efi_loader/efi_bootmgr.c: patch does not apply
> > > > > > > > > error: patch failed: lib/efi_loader/efi_device_path.c:10
> > > > > > > > > error: lib/efi_loader/efi_device_path.c: patch does not a=
pply
> > > > > > > > > error: patch failed: lib/efi_loader/efi_helper.c:6
> > > > > > > > > error: lib/efi_loader/efi_helper.c: patch does not apply
> > > > > > > > >
> > > > > > > > > Please, resend the series based on origin/next.
> > > > > > > > >
> > > > > > > > > Patches that are not based on upstream U-Boot cannot be r=
eviewed via
> > > > > > > > > this mailing list.
> > > > > > > >
> > > > > > > > The app is quite behind in Tom's tree due to rejected serie=
s.
> > > > > > >
> > > > > > > It was not "Rejected", it was "Changes Requested", please stop
> > > > > > > mis-representing things.
> > > > > > >
> > > > > > > > In fact
> > > > > > > > the app is pretty limited on x86 and there is no Arm app at=
 all.
> > > > > > > >
> > > > > > > > My current plan is to move forward and eventually Tom might=
 take it
> > > > > > > > via a pull request.
> > > > > > > >
> > > > > > > > Do you have any other ideas?
> > > > > > > >
> > > > > > > > Perhaps this is something we could put on the agenda for a =
future call.
> > > > > > >
> > > > > > > There's nothing to discuss in a future call as step one is "p=
ost patches
> > > > > > > against mainline".
> > > > > >
> > > > > > I agree with Tom here.  I did look at some of the patches in th=
is
> > > > > > series and now that I've learnt it doesn't even apply on top of
> > > > > > mainline it feels like I've wasted my time.
> > > > >
> > > > > There is a base commit in the cover letter, so you could look at =
that
> > > > > if you like.
> > > >
> > > > Yes, it's on a commit that's not in mainline. No one wants to look =
at
> > > > your personal tree.
> > > >
> > > >
> > > > > I plan to apply this series at some point, so any review is not a
> > > > > waste of time. I do respond to review feedback.
> > > >
> > > > And since it's not based on mainline, this is why people have told =
you
> > > > they don't want to review your changes. Since you aren't working on
> > > > mainline it's unclear if it will ever be in mainline.
> > >
> > > From my side I would suggest that you avoid bringing up this point on
> > > each patch. It doesn't seem to be working towards resolution. I am
> > > doing what I need to, for now, for the project to make progress.
> >
> > No, you're hindering the project with your insistence on posting patches
> > for your personal tree. I am trying to make it clear to the casual
> > developers of the project that it is your personal tree and not
> > mainline.
> >
> > > > Since this series in fact looks to be addressing some of the feedba=
ck
> > > > that was provided to one of the series you applied yourself (the ot=
her
> > > > being part of Casey's RFC), it would be much more effective to star=
t on
> > > > the next branch now with the leg work on factoring the common EFI t=
hings
> > > > to be usable by EFI_APP and EFI_LOADER. This would lead to being ab=
le to
> > > > rebase other work on top of it and reduce the delta between your tr=
ee
> > > > and mainline. That's the only way it will get in to mainline.
> > >
> > > Yes I am acting on the feedback provided to Matthew's series and will
> > > get there in the end.
> > >
> > > More generally, there is a substantial amount of work needed on the
> > > EFI app and unfortunately this requires refactoring the EFI-loader
> > > code to avoid duplication. Honestly, I'm not even sure that I want to
> > > take that on, since my ability to get things into lib/efi_loader is
> > > pretty limited and it is seldom an enjoyable experience. I am pleased
> > > to see that the ANSI patch [1] is now in your tree, though, so thank
> > > you for that.
> > >
> > > Re the app, I would very much like to send a PR at some point, but
> > > there are other EFI patches not applied, so it is not trivial.
> > >
> > > I'm working with Heinrich on this and agreed with him that I'll take
> > > another look...
> >
> > If you intend to get things in to mainline, you MUST stop posting things
> > against your personal tree. You are making everything harder than it
> > needs to be. You do not have some special exemption from the normal
> > process. Iterative development on top of mainline, not some feature
> > branch that branched off ages ago.
>=20
> So how about:
> - let me speed up your CI

We last left this argument at you saying it was too much work to
demonstrate speeding up CI on source.denx.de in u-boot-dm and me
not being able to see that as a serious point because it's something
like a dozen mouse clicks at most.

> - accept some of the things that you've previously rejected

That's probably going to continue to be a No because it's not like
people flipped a coin and went with "Nope, lets reject this". People
said you're wrong or going in the wrong direction and you disagree.

> In general, I think it would really help if you could adopt a more
> incremental approach to development. It would also help if we could
> discuss things every now and then, instead of all this email.

I don't know if you're being serious with this statement. I don't think
you can be serious with this statement. Doing things incremental would
mean doing them slowly, and in small reviewable chunks and 30-40-50 part
series followed by more of the same.

And there's a regularly scheduled community call every two weeks. I
would really only ask that someone other than you or I on the call take
the notes for any of these topics, just so it's clear later that any
misrepresentation is accidental.

--=20
Tom

--pEEdnER1IKxelXqe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg0spAACgkQFHw5/5Y0
tyxWMwv9EAnV7CcKe6iuOgH8CV+A6CrPUjp4avWE1cOtf0c9JT2SsdH1h5c/ca14
jcjNcZfNxWKKvESBq6CdRXFbpQDoIvzgTQ/sA5HeKwo0Srx7hYAHfQBi9QgjkIQH
PJvPP2X7k0VOr40enO35Y4rZMrvdkSdTvPXBf0YMzJ9yYEBmYdKkjVT6ivX7GR+9
PPrUx0SFf6V/okAlVphdvhNewpQ8SHx03HbvLDkoISYe5EUBNK1IiiO92HqNaig+
CXInj/VAXjFKMNKjNWTHIoDcRzGulmvML8geG0/gItaVkML6l4t8jkaS9o/TVg+p
DIu1ia+koN4pfJrsQfejM+ugxzgGNvUgev+2gy/qwKXY5fvuITQcc2y1dliHB45u
OAG4e0peqWp8pqVyAGr4CVKaB11r6PDd2IbTNzrIHSJT+FlLSY3daA7F9i9mxmrM
hdSHyHDc11dIpY8AbQ/wgl7XE6kk+ASH5E12JZs9sGCHbq7Y4VPqBOG2obvKBQvW
nWCv3kbX
=RZps
-----END PGP SIGNATURE-----

--pEEdnER1IKxelXqe--
