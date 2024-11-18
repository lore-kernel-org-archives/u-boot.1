Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243EFD591A9
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 17:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9428489493;
	Mon, 18 Nov 2024 18:18:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QVtX3++n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CD1289493; Mon, 18 Nov 2024 18:18:19 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEBDE894A4
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 18:18:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6d41c87aec0so13614456d6.0
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 09:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731950295; x=1732555095; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z2Q8o2SEVzBUfkaPQhet8OnWh3XKHeMnNUI9V7xU8NA=;
 b=QVtX3++n5AQl2EmVB8kML5sNdKXoAGe95tJvbJ/MRc25gReKKmmEKk1uAmYweR7GJO
 ta4fpYwCbx0bOuTOeT2/Hb1NpgQmt1VliwHDTak2KI0OXRvOEfRe0vjndmaMT80PmzbV
 wVVGD3Lr31TXeSbQeV+oN8gqmTQ5Pkax0T86Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731950295; x=1732555095;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z2Q8o2SEVzBUfkaPQhet8OnWh3XKHeMnNUI9V7xU8NA=;
 b=mJiWDIYRZM4/k55639MIsvz3A50aLR3xEDnNqr7qreccGAvLhxLVtuXFtdAt/gWV0Y
 edoeF510Qf2bGN2K6BE9eDQFiMmsQoAFIsbc4I1/bVLxjDOtyHDAZuz/73/nNKdwTvM6
 YBAqQLB3nUuYo3OBj4w9ScJWsOjckwf5l0ttf1WMJiHnTBCmpM7igE+K8EpibVkCaIoC
 cnP67zBsiLxUMLk8O3tRPs7k6Ssm6HpDzQEbTBcQ+5gvm/plA69PcUrDi7yntVcc90vM
 dgEnELeUUFtw2qd/MB8mTohD7s3sHtYbQ2wS1ewmWrqvu3H+cfIJ1ZlmOuLeJa65NXJw
 xrMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoRCfz9GYvg45d7lrvXabIFg4hR/wV8m5vUDTGuajUe8pZqfgUBtDescmZWuFjqxftRl+yV3o=@lists.denx.de
X-Gm-Message-State: AOJu0Ywb+sRbhkIMUv0zkyFWkHIvKLPzNWMdpubiPFClRcayF7OCkZh6
 vgs6b4t5Uq8KM0haoMBMvM9Nnkc7jITRYutLpjgCtiTBiiouyTgOgqKSgKsCqMY=
X-Google-Smtp-Source: AGHT+IGRZ2rZoApA82XNZ/jcBcW6MWCKE2UDlwYelOsvlF8r8nBrW4Kw59m1eP/ae5Y1EtYSXOEQSQ==
X-Received: by 2002:a05:6214:2b98:b0:6d1:848b:a8ce with SMTP id
 6a1803df08f44-6d3fb847de4mr180285966d6.28.1731950294657; 
 Mon, 18 Nov 2024 09:18:14 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d40dbdfd6esm38456486d6.11.2024.11.18.09.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 09:18:14 -0800 (PST)
Date: Mon, 18 Nov 2024 11:18:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Git commit failed with mbedtls/framework
Message-ID: <20241118171811.GR3600562@bill-the-cat>
References: <CAJaLiFy2oo2fp-08qJni8srUn6RErgGgZs_A3GGPJuD0+=YsOw@mail.gmail.com>
 <CAEfUkUJOd03fc5VERRPY18LWMomEbYFRnkHSJcFLcdnPq4=8jA@mail.gmail.com>
 <CAJaLiFw134mzZk7TkJMgAppx11Xv3qZsbU-Y78XimX8jNbJtMA@mail.gmail.com>
 <CAEfUkUKp9wWhgBW2XFubhoccSGeU-CW3Y+FY+iJhfw7eVLZv_g@mail.gmail.com>
 <CAJaLiFzTjHWCw+ioPZv660yQ0XLM6+SMJh3NV=NYivbtE1Uf_Q@mail.gmail.com>
 <CAEfUkULhPuH15fDENXubhNPOQvbAjBv5f_yoeH7gjC4rhczxtA@mail.gmail.com>
 <20241118153742.GO3600562@bill-the-cat>
 <CAEfUkUJNOTCsh19VbKsHw9wWO1nn8o-OhRrAB46uhpKHO-Owsw@mail.gmail.com>
 <20241118164122.GQ3600562@bill-the-cat>
 <CAEfUkUJmSL8-XR6LUAKX=xW-mYQWNHzanRKvAVFaB2A9nA4W1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="67Pn+NzQrDZb3M4T"
Content-Disposition: inline
In-Reply-To: <CAEfUkUJmSL8-XR6LUAKX=xW-mYQWNHzanRKvAVFaB2A9nA4W1A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--67Pn+NzQrDZb3M4T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 12:16:18PM -0500, Raymond Mao wrote:
> Hi Tom,
>=20
> On Mon, 18 Nov 2024 at 11:41, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Mon, Nov 18, 2024 at 11:27:06AM -0500, Raymond Mao wrote:
> > > Hi Tom,
> > >
> > > On Mon, 18 Nov 2024 at 10:37, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > > On Mon, Nov 18, 2024 at 10:24:32AM -0500, Raymond Mao wrote:
> > > > > Hi Tony,
> > > > >
> > > > > On Sat, 16 Nov 2024 at 02:39, Tony Dinh <mibodhi@gmail.com> wrote:
> > > > >
> > > > > > Hi Raymond,
> > > > > >
> > > > > > On Fri, Nov 15, 2024 at 1:55=E2=80=AFPM Raymond Mao <
> > raymond.mao@linaro.org>
> > > > > > wrote:
> > > > > > >
> > > > > > > Hi Tony and Tom,
> > > > > > >
> > > > > > > On Fri, 15 Nov 2024 at 16:35, Tony Dinh <mibodhi@gmail.com>
> > wrote:
> > > > > > >>
> > > > > > >> Hi Tom,
> > > > > > >> Hi Raymond,
> > > > > > >>
> > > > > > >> On Fri, Nov 15, 2024 at 1:09=E2=80=AFPM Raymond Mao <
> > raymond.mao@linaro.org
> > > > >
> > > > > > wrote:
> > > > > > >> >
> > > > > > >> > Hi Tony
> > > > > > >> >
> > > > > > >> > On Fri, 15 Nov 2024 at 15:32, Tony Dinh <mibodhi@gmail.com>
> > > > wrote:
> > > > > > >> >>
> > > > > > >> >> Hi Tom,
> > > > > > >> >>
> > > > > > >> >> On Fri, Nov 15, 2024 at 11:27=E2=80=AFAM Tony Dinh <
> > mibodhi@gmail.com>
> > > > > > wrote:
> > > > > > >> >> >
> > > > > > >> >> > Hi Tom,
> > > > > > >> >> >
> > > > > > >> >> > On Fri, Nov 15, 2024 at 6:17=E2=80=AFAM Tom Rini <
> > trini@konsulko.com>
> > > > > > wrote:
> > > > > > >> >> > >
> > > > > > >> >> > > On Thu, Nov 14, 2024 at 08:26:33PM -0800, Tony Dinh
> > wrote:
> > > > > > >> >> > > > Hi Tom,
> > > > > > >> >> > > >
> > > > > > >> >> > > > I am on 2025.01-rc2, and I am trying to commit some
> > files.
> > > > The
> > > > > > error
> > > > > > >> >> > > > seems to indicate this framework directory might ne=
ed
> > some
> > > > > > >> >> > > > modification. Did I miss something?
> > > > > > >> >> > > >
> > > > > > >> >> > > > error: 'lib/mbedtls/external/mbedtls/framework' does
> > not
> > > > have
> > > > > > a commit
> > > > > > >> >> > > > checked out
> > > > > > >> >> > > > fatal: updating files failed
> > > > > > >> >> > >
> > > > > > >> >> > > That's odd. You didn't happen to try out some of the
> > previous
> > > > > > lwIP
> > > > > > >> >> > > iterations on that tree did you?
> > > > > > >> >> >
> > > > > > >> >> > No, I did not. The tree is clean with "make mrproper" a=
nd
> > on
> > > > the
> > > > > > >> >> > master branch. I just did a git pull and worked on it.
> > > > > > >> >> >
> > > > > > >> >> > I went and looked at
> > https://github.com/Mbed-TLS/mbedtls.git.
> > > > The
> > > > > > >> >> > framework directory is pointing to a specific commit.
> > > > > > >> >> > framework @ 3867faa
> > > > > > >> >> >
> > > > > > >> >> > I'll stash and repeat it on another clean tree.
> > > > > > >> >>
> > > > > > >> >> I have the same commit error on a brand new tree.
> > > > > > >> >>
> > > > > > >> > I think you are talking about the test framework of MbedTL=
S's
> > > > > > original testsuite,
> > > > > > >> > am I right?
> > > > > > >> > MbedTLS was ported into U-Boot as a git subtree and that
> > > > framework is
> > > > > > a git
> > > > > > >> > submodule of original MbedTLS repo which was not included =
in
> > the
> > > > > > porting
> > > > > > >> > of U-Boot since U-Boot has its own testsuite.
> > > > > > >>
> > > > > > >> Here is what I found.
> > > > > > >>
> > > > > > >> git clone https://github.com/u-boot/u-boot.git
> > u-boot-master-test
> > > > > > >> cd /usr/src/u-boot-master-test/
> > > > > > >> patch -p1 <
> > > > ../builds-u-boot-marvell/sheevaplug/sheevaplug_bootstd.patch
> > > > > > >> git add .
> > > > > > >> git commit . -m "arm: kirkwood: Enable bootstd and remove jf=
fs2
> > for
> > > > > > >> Sheevaplug board" -e
> > > > > > >>
> > > > > > >> The git commit above gave out this error:
> > > > > > >>
> > > > > > >> error: 'lib/mbedtls/external/mbedtls/framework' does not hav=
e a
> > > > commit
> > > > > > >> checked out
> > > > > > >> fatal: updating files failed
> > > > > > >>
> > > > > > >> So I tried to commit only the specific files, and it works O=
K.
> > > > > > >>
> > > > > > >> git commit configs/sheevaplug_defconfig
> > include/configs/sheevaplug.h
> > > > > > >> -m "arm: kirkwood: Enable bootstd and remove jffs2 for
> > Sheevaplug
> > > > > > >> board" -e
> > > > > > >> [master 47de8cff2d] arm: kirkwood: Enable bootstd and remove
> > jffs2
> > > > for
> > > > > > >> Sheevaplug board
> > > > > > >>  2 files changed, 17 insertions(+), 19 deletions(-)
> > > > > > >>
> > > > > > >> I think it must be what Raymond said above. So perhaps during
> > Tom's
> > > > PR
> > > > > > >> pull, the framework directory was created. But "git commit ."
> > does
> > > > not
> > > > > > >> like the empty lib/mbedtls/external/mbedtls/framework direct=
ory.
> > > > > > >>
> > > > > > > Under the native MbedTLS git repo, by default it has a
> > "framework"
> > > > > > pointing to
> > > > > > > its git submodule.
> > > > > > > Maybe we should mark it in the gitignore.
> > > > > >
> > > > > > I've tried .gitignore but could not make it work (my Gitfu is
> > pretty
> > > > > > lousy). Can you suggest how that should be done?
> > > > > >
> > > > > > You can use the command without the '.' : git commit -m
> > "<commit_msg>",
> > > > > this
> > > > > should work.
> > > > >
> > > > > @Tom Rini <trini@konsulko.com> Shall we remove both
> > > > > "lib/mbedtls/external/mbedtls/.gitmodules" and
> > > > > "lib/mbedtls/external/mbedtls/framework"? I can submit a patch if=
 you
> > > > agree.
> > > >
> > > > Can we do that and not make a problem for the next resync?
> > > >
> > > > Hmmm, no, this cannot be pulled back to the MbedTLS upstream so sti=
ll a
> > > problem
> > > when resync.
> > > Another option is to include that git submodule into the U-Boot proje=
ct,
> > > this needs
> > > to revert the commit of introducing the library and redo the git subt=
ree
> > > after the
> > > submodule is updated, but it does not seem to be a good choice as we
> > don't
> > > use
> > > that test framework in U-Boot at all.
> > > Right now I don't have a perfect solution, maybe we can accept using =
git
> > > commit
> > > without the '.'?
> >
> > Hmm. Maybe we just delete the .gitmodules / directory and it shouldn't
> > be too hard to deal with on updates. I have to do some small fixups with
> > the device tree ones anyhow sometimes.
> >
> > How about checking and deleting this in the subtree update script?
> Then we can skip manually doing this each time.
> I can make a patch for it if you feel fine.

Lets worry about that if it's a problem when we resync next.

--=20
Tom

--67Pn+NzQrDZb3M4T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc7ds8ACgkQFHw5/5Y0
tyxZMgv/cIKmn832ZxIwVWlpP1xQDPrD95P5pg7sRj8LpmK2KdhX25RGf4NU/oBy
2xqdesXUYeZmsyDtGmFB3aTM+UMS9TiqS1jiS0iRYNO7TOf1piWhN8kcwAYwhS7v
NnEEyyq9RmolOM/ve0f9tuR4/POjs52G+mMfQtUebpOPRjRhRxjRKkut58VvMAzL
s0xydC01Nb28Ikz1brNTpKK7pLF6vZbmeL12wvhz37JcqYzGxJ7j2/VVSME2rNVN
zxURrrJ4En50ArqsiDGodrROH/vhBu1K4PwcEfW0fp37/+BaWeHsLjuuvZPTMUGJ
lYOpDvnf/OQaZ4lfZqH1uhkkBG1SkzKiOxhWpS8dKFA56AuRnLfjKnCaQ0G1hTij
2X5qjtoNIZyNtB0pejZrHfcp1Rfpwgi9doDHNlCS1/7ZhQ+bhbkTpSj8p7SIeePN
ijEWlbldOz4BPhENrHxuY2+KRkW354vEZ+40MtiHi/B23u+ducp9p4dfMSOim+iC
O6NRxhgq
=uOf3
-----END PGP SIGNATURE-----

--67Pn+NzQrDZb3M4T--
