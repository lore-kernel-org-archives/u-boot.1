Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2CEC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 18:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B08BA80A52;
	Fri, 24 Jan 2025 19:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EVRhQjS9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8193780A52; Fri, 24 Jan 2025 19:23:39 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA6FD80ADB
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 19:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b6f75f61f9so335578985a.0
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 10:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737743015; x=1738347815; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ykRWoHyBw/bYP1W1gbULZ5QK+fCTjDTrTZljZe99/0M=;
 b=EVRhQjS97XTcaR0uv1gAvWLclZA8srOVO4dD9/gGRGX7OpKudrSzOcnJhs44Gx7o9N
 4aXPtgRz7rwh3OwUQMhL9S9s4F2Dta03tkEttGFsVapQopTnNhrrHAtNlyrQUubUBlgX
 9KbTg/k5xHfYb5YlJRxNW2y4K4vkTDGj8SlAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737743015; x=1738347815;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ykRWoHyBw/bYP1W1gbULZ5QK+fCTjDTrTZljZe99/0M=;
 b=PS9YeiAZdMbPiWuAYaBKilEu/kTFxKtZ6WqWN5znqS509EZmoeAyRqDnldISh9AEaV
 DdTseaIdCm3P2YTnP+dKtcanbjo1BZNOuZJz32xKxqTgd/Qqdzk9Rnu8jJzDh9tU/Owp
 YN1X8AjuTOeQawRBqmI9mIxCrGHoegRcUHk4aSpSkh7iREieiyuBH8K9GQomTQ4jsUhr
 lFE8ZjZ5d3a9fu8PHKbdDS107DNdx+6BRaJTkcgGuwtqWIacSz5F/FH9myKui0DdS3Nv
 gojbXvrLwD2NG8+007MJmqJJuNevteS8zshEymcbVBTNxtMzxH+TffG1zF+4wWGexUL3
 oWbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnnyCEv9wpNZifBl3dgWHUhiwoBMTkuzGskksw/DSurW2npowYtvPY6XXzJ+L+BsVNu6NkGeY=@lists.denx.de
X-Gm-Message-State: AOJu0YwkscP81KIlWrKF9+LcIHrYP8EIfc5K1NiRN4F10eHD7MxW2pfG
 WqSOwTcZDhZrVE3kX2WayxOZyqOhDgipJtwCAqrPH8/BvFIKFWMHmtXFKmHrlroG88EyoAIzLSl
 F
X-Gm-Gg: ASbGnct1PshqFhG1bFaGulXk/e3wQU14pADi316qKhE2sQc4dZqeoabMud1pRYzOcP2
 K7HS8mfYk9M8tyrcDopfxM6oNXBZN3tryGBm9l0/rw6GnR6j8gWhciJppOmD/c+yrRAgKJWrE7n
 Zj3yekr/ySeyefGHmHixhduR3N44xkjyvdfTKT40SsV6/gNc1e6VjwxwSalPzQABmAPROB54qqV
 NGcBDtVvCEXs7ci4YgKFmoInraY+XotXHEKPJ5p9fn6owKl+cJilihfDhzYnXUHMn/yePdr/40v
 VKUD
X-Google-Smtp-Source: AGHT+IGXMU98l4LCs6vrqyw2euflUsNJQLrFi4BF0CVvuKlJ7ifT83TQVJ2vKzdjc7pPsJEFCq/xsg==
X-Received: by 2002:a05:620a:2b94:b0:7b6:6d4e:40c5 with SMTP id
 af79cd13be357-7be63202652mr5023398585a.21.1737743014749; 
 Fri, 24 Jan 2025 10:23:34 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9af0d131sm116963885a.104.2025.01.24.10.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 10:23:33 -0800 (PST)
Date: Fri, 24 Jan 2025 12:23:30 -0600
From: Tom Rini <trini@konsulko.com>
To: ZHANG Yuntian <yt@radxa.com>
Cc: Tony Dinh <mibodhi@gmail.com>, Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Git commit failed with mbedtls/framework
Message-ID: <20250124182330.GQ60249@bill-the-cat>
References: <CAJaLiFw134mzZk7TkJMgAppx11Xv3qZsbU-Y78XimX8jNbJtMA@mail.gmail.com>
 <CAEfUkUKp9wWhgBW2XFubhoccSGeU-CW3Y+FY+iJhfw7eVLZv_g@mail.gmail.com>
 <CAJaLiFzTjHWCw+ioPZv660yQ0XLM6+SMJh3NV=NYivbtE1Uf_Q@mail.gmail.com>
 <CAEfUkULhPuH15fDENXubhNPOQvbAjBv5f_yoeH7gjC4rhczxtA@mail.gmail.com>
 <20241118153742.GO3600562@bill-the-cat>
 <CAEfUkUJNOTCsh19VbKsHw9wWO1nn8o-OhRrAB46uhpKHO-Owsw@mail.gmail.com>
 <20241118164122.GQ3600562@bill-the-cat>
 <CAEfUkUJmSL8-XR6LUAKX=xW-mYQWNHzanRKvAVFaB2A9nA4W1A@mail.gmail.com>
 <20241118171811.GR3600562@bill-the-cat>
 <8823CB36AD9BEA6D+3c5f1842-bbaf-4dfa-96a6-d6d53b61ed10@radxa.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Vjb94751VtfS5VDx"
Content-Disposition: inline
In-Reply-To: <8823CB36AD9BEA6D+3c5f1842-bbaf-4dfa-96a6-d6d53b61ed10@radxa.com>
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


--Vjb94751VtfS5VDx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 02:05:28PM +0800, ZHANG Yuntian wrote:
> Hi Tom,
>=20
> On 2024/11/19 01:18, Tom Rini wrote:
> > On Mon, Nov 18, 2024 at 12:16:18PM -0500, Raymond Mao wrote:
> > > Hi Tom,
> > >=20
> > > On Mon, 18 Nov 2024 at 11:41, Tom Rini <trini@konsulko.com> wrote:
> > >=20
> > > > On Mon, Nov 18, 2024 at 11:27:06AM -0500, Raymond Mao wrote:
> > > > > Hi Tom,
> > > > >=20
> > > > > On Mon, 18 Nov 2024 at 10:37, Tom Rini <trini@konsulko.com> wrote:
> > > > >=20
> > > > > > On Mon, Nov 18, 2024 at 10:24:32AM -0500, Raymond Mao wrote:
> > > > > > > Hi Tony,
> > > > > > >=20
> > > > > > > On Sat, 16 Nov 2024 at 02:39, Tony Dinh <mibodhi@gmail.com> w=
rote:
> > > > > > >=20
> > > > > > > > Hi Raymond,
> > > > > > > >=20
> > > > > > > > On Fri, Nov 15, 2024 at 1:55=E2=80=AFPM Raymond Mao <
> > > > raymond.mao@linaro.org>
> > > > > > > > wrote:
> > > > > > > > >=20
> > > > > > > > > Hi Tony and Tom,
> > > > > > > > >=20
> > > > > > > > > On Fri, 15 Nov 2024 at 16:35, Tony Dinh <mibodhi@gmail.co=
m>
> > > > wrote:
> > > > > > > > > >=20
> > > > > > > > > > Hi Tom,
> > > > > > > > > > Hi Raymond,
> > > > > > > > > >=20
> > > > > > > > > > On Fri, Nov 15, 2024 at 1:09=E2=80=AFPM Raymond Mao <
> > > > raymond.mao@linaro.org
> > > > > > >=20
> > > > > > > > wrote:
> > > > > > > > > > >=20
> > > > > > > > > > > Hi Tony
> > > > > > > > > > >=20
> > > > > > > > > > > On Fri, 15 Nov 2024 at 15:32, Tony Dinh <mibodhi@gmai=
l.com>
> > > > > > wrote:
> > > > > > > > > > > >=20
> > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > >=20
> > > > > > > > > > > > On Fri, Nov 15, 2024 at 11:27=E2=80=AFAM Tony Dinh <
> > > > mibodhi@gmail.com>
> > > > > > > > wrote:
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > On Fri, Nov 15, 2024 at 6:17=E2=80=AFAM Tom Rini <
> > > > trini@konsulko.com>
> > > > > > > > wrote:
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > On Thu, Nov 14, 2024 at 08:26:33PM -0800, Tony =
Dinh
> > > > wrote:
> > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > I am on 2025.01-rc2, and I am trying to commi=
t some
> > > > files.
> > > > > > The
> > > > > > > > error
> > > > > > > > > > > > > > > seems to indicate this framework directory mi=
ght need
> > > > some
> > > > > > > > > > > > > > > modification. Did I miss something?
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > error: 'lib/mbedtls/external/mbedtls/framewor=
k' does
> > > > not
> > > > > > have
> > > > > > > > a commit
> > > > > > > > > > > > > > > checked out
> > > > > > > > > > > > > > > fatal: updating files failed
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > That's odd. You didn't happen to try out some o=
f the
> > > > previous
> > > > > > > > lwIP
> > > > > > > > > > > > > > iterations on that tree did you?
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > No, I did not. The tree is clean with "make mrpro=
per" and
> > > > on
> > > > > > the
> > > > > > > > > > > > > master branch. I just did a git pull and worked o=
n it.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > I went and looked at
> > > > https://github.com/Mbed-TLS/mbedtls.git.
> > > > > > The
> > > > > > > > > > > > > framework directory is pointing to a specific com=
mit.
> > > > > > > > > > > > > framework @ 3867faa
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > I'll stash and repeat it on another clean tree.
> > > > > > > > > > > >=20
> > > > > > > > > > > > I have the same commit error on a brand new tree.
> > > > > > > > > > > >=20
> > > > > > > > > > > I think you are talking about the test framework of M=
bedTLS's
> > > > > > > > original testsuite,
> > > > > > > > > > > am I right?
> > > > > > > > > > > MbedTLS was ported into U-Boot as a git subtree and t=
hat
> > > > > > framework is
> > > > > > > > a git
> > > > > > > > > > > submodule of original MbedTLS repo which was not incl=
uded in
> > > > the
> > > > > > > > porting
> > > > > > > > > > > of U-Boot since U-Boot has its own testsuite.
> > > > > > > > > >=20
> > > > > > > > > > Here is what I found.
> > > > > > > > > >=20
> > > > > > > > > > git clone https://github.com/u-boot/u-boot.git
> > > > u-boot-master-test
> > > > > > > > > > cd /usr/src/u-boot-master-test/
> > > > > > > > > > patch -p1 <
> > > > > > ../builds-u-boot-marvell/sheevaplug/sheevaplug_bootstd.patch
> > > > > > > > > > git add .
> > > > > > > > > > git commit . -m "arm: kirkwood: Enable bootstd and remo=
ve jffs2
> > > > for
> > > > > > > > > > Sheevaplug board" -e
> > > > > > > > > >=20
> > > > > > > > > > The git commit above gave out this error:
> > > > > > > > > >=20
> > > > > > > > > > error: 'lib/mbedtls/external/mbedtls/framework' does no=
t have a
> > > > > > commit
> > > > > > > > > > checked out
> > > > > > > > > > fatal: updating files failed
> > > > > > > > > >=20
> > > > > > > > > > So I tried to commit only the specific files, and it wo=
rks OK.
> > > > > > > > > >=20
> > > > > > > > > > git commit configs/sheevaplug_defconfig
> > > > include/configs/sheevaplug.h
> > > > > > > > > > -m "arm: kirkwood: Enable bootstd and remove jffs2 for
> > > > Sheevaplug
> > > > > > > > > > board" -e
> > > > > > > > > > [master 47de8cff2d] arm: kirkwood: Enable bootstd and r=
emove
> > > > jffs2
> > > > > > for
> > > > > > > > > > Sheevaplug board
> > > > > > > > > >   2 files changed, 17 insertions(+), 19 deletions(-)
> > > > > > > > > >=20
> > > > > > > > > > I think it must be what Raymond said above. So perhaps =
during
> > > > Tom's
> > > > > > PR
> > > > > > > > > > pull, the framework directory was created. But "git com=
mit ."
> > > > does
> > > > > > not
> > > > > > > > > > like the empty lib/mbedtls/external/mbedtls/framework d=
irectory.
> > > > > > > > > >=20
> > > > > > > > > Under the native MbedTLS git repo, by default it has a
> > > > "framework"
> > > > > > > > pointing to
> > > > > > > > > its git submodule.
> > > > > > > > > Maybe we should mark it in the gitignore.
> > > > > > > >=20
> > > > > > > > I've tried .gitignore but could not make it work (my Gitfu =
is
> > > > pretty
> > > > > > > > lousy). Can you suggest how that should be done?
> > > > > > > >=20
> > > > > > > > You can use the command without the '.' : git commit -m
> > > > "<commit_msg>",
> > > > > > > this
> > > > > > > should work.
> > > > > > >=20
> > > > > > > @Tom Rini <trini@konsulko.com> Shall we remove both
> > > > > > > "lib/mbedtls/external/mbedtls/.gitmodules" and
> > > > > > > "lib/mbedtls/external/mbedtls/framework"? I can submit a patc=
h if you
> > > > > > agree.
> > > > > >=20
> > > > > > Can we do that and not make a problem for the next resync?
> > > > > >=20
> > > > > > Hmmm, no, this cannot be pulled back to the MbedTLS upstream so=
 still a
> > > > > problem
> > > > > when resync.
> > > > > Another option is to include that git submodule into the U-Boot p=
roject,
> > > > > this needs
> > > > > to revert the commit of introducing the library and redo the git =
subtree
> > > > > after the
> > > > > submodule is updated, but it does not seem to be a good choice as=
 we
> > > > don't
> > > > > use
> > > > > that test framework in U-Boot at all.
> > > > > Right now I don't have a perfect solution, maybe we can accept us=
ing git
> > > > > commit
> > > > > without the '.'?
> > > >=20
> > > > Hmm. Maybe we just delete the .gitmodules / directory and it should=
n't
> > > > be too hard to deal with on updates. I have to do some small fixups=
 with
> > > > the device tree ones anyhow sometimes.
> > > >=20
> > > > How about checking and deleting this in the subtree update script?
> > > Then we can skip manually doing this each time.
> > > I can make a patch for it if you feel fine.
> >=20
> > Lets worry about that if it's a problem when we resync next.
>=20
> I'm currently working with Jonas Karlman's Rockchip fork[1] which is based
> on a416d9e680718de1c76c4196e1db77e3ca07662f. The fork is included as a git
> submodule so we can provide distro packaging[2] that are unrelated to
> U-Boot. We build our package with GitHub Action, and this issue currently
> blocks us from checking out the code at all with the following workflow
> snippet:
>=20
>       - name: Checkout
>         uses: actions/checkout@v4
>         with:
>           submodules: recursive
>=20
> Related error logs are here:
>=20
> |> Fetching submodules
>   /usr/bin/git submodule sync --recursive
>   /usr/bin/git -c protocol.version=3D2 submodule update --init --force
> --recursive
>   Submodule 'src/rkbin' (https://github.com/rockchip-linux/rkbin.git)
> registered for path 'src/rkbin'
>   Submodule 'src/u-boot' (https://github.com/Kwiboo/u-boot-rockchip.git)
> registered for path 'src/u-boot'
>   Cloning into '/home/runner/work/u-boot-kwiboo/u-boot-kwiboo/src/rkbin'.=
=2E.
>   Cloning into '/home/runner/work/u-boot-kwiboo/u-boot-kwiboo/src/u-boot'=
=2E..
>   Submodule path 'src/rkbin': checked out
> '0f8ac860f0479da56a1decae207ddc99e289f2e2'
>   Submodule path 'src/u-boot': checked out
> 'f3231571f4f9c3f72dcb6458aaa2de2462c605df'
>   Error: fatal: No url found for submodule path
> 'src/u-boot/lib/mbedtls/external/mbedtls/framework' in .gitmodules
>   Error: fatal: Failed to recurse into submodule path 'src/u-boot'
>   Error: The process '/usr/bin/git' failed with exit code 128
>=20
> This issue potentially breaks all projects who include the recent U-Boot =
as
> a git submodule in their GitHub Workflow.
>=20
> 1: https://github.com/Kwiboo/u-boot-rockchip/tree/rk3528-2025.04-wip
> 2: https://github.com/radxa-pkg/u-boot-kwiboo/actions

What if instead of "submodules: recursive" you use a run statement?
https://github.com/marketplace/actions/checkout-submodules

--=20
Tom

--Vjb94751VtfS5VDx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeT2psACgkQFHw5/5Y0
tywWxgv/SUszrO/83EFtYiniI5fUhnC6swIUqhk2mJCA0VJpcDpXaw+zlZtrwxO2
2EscuiBlWHerAOnvwrEC0f0QVs8galraAlOaoybWmPDofh10kB3+crIZ42yH9/nR
zamuXrqxNnbK3me2mlfch/7Jnerek4gp/5kC6EhHRCdz/AceVDL5uR419zRtVyq2
Kb79VwsOhh/WRjkrJfqI9WYHqwldpt7P9WyKGjus81b4jBnuquUFbyflMJ+ZkUbv
fUyUhRhA9/tw2aNZMlWqCqxC+3CRLUYFUgZ6gTsY9AuyOU8n/1TmsYqFI/a2avvd
9L2ethoaEj/DKq1pftwuvBv8hmfMZ4xAaxlKPaMTPd81T+XWcgBPYCzRKgA+ggBZ
etv+V+An9vNaC7rrzPcrhr8J8cJCC0MqJqQcZp6qkTy4dUp0pMACr0J9j+ogBusL
ltFFSirCGKXbLilwuYBctVEzmBrQ6aBRgiq2jAeEJDhrAzgYVdXSse3Km4TFkmPJ
SeG80Fk5
=zrNc
-----END PGP SIGNATURE-----

--Vjb94751VtfS5VDx--
