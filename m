Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D38C0219E
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 16:52:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96E9480548;
	Mon, 10 Feb 2025 17:52:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PaFmNPjt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE3E5805D7; Mon, 10 Feb 2025 17:52:21 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A87898001F
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 17:52:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6f74b78df93so40476477b3.0
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 08:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739206337; x=1739811137; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0Dkie86At6qX0Q5Z6KczC0E0jGJNHW1GcXWvZO0Mw30=;
 b=PaFmNPjtkJMdxrEZZixwjubAmsFpgfDx5DAab6T7uyNku1G0EaXtRH8Kj5PTq5sqXe
 1SOx6M2AD574d703k53Y0peeeluik2TjwzMfNDyqvRFp3MYWwKLMdiDNiiDCCNwCM/cE
 2ICyD1t6PIO8Q9NwaexOcRJi6mw3h+99Aowyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739206337; x=1739811137;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Dkie86At6qX0Q5Z6KczC0E0jGJNHW1GcXWvZO0Mw30=;
 b=WtlZygdToiiB8wsVnDAydRTVy8ucHhLLHK50ZANm8NtKdQFY/P+rznI4sRCNRO+8re
 h3A6sO8CNhD9bHrgGg0Dqsy5LPwHkicx6PXWgrSr36cCoWwgbupu+CFW9Yi0893jyr5g
 FzhkGDxLfHfu/ERutL2s32MRE71eR7JPdflVweWqRUn/hHMwG0DZLhVuI8YKwQL6vydA
 XFLI/oU5Nhn55JT0QoyHB23P2oZbAd/i3HYtn0V9qgD523A/5DIJ19f5V++e0WcuCRcr
 jlKseGwAx+l45zHveoRK1LCxZcVHqgNNjWhhlnRhxzHEm6+P1zjGYUrkjYuFwaTRQ+b7
 iFcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWueOLnEOzhqn6XCTkYPbk4YTt3F+J2BoByeRnQWBYrtyg8mhiAUnRBkj6BrhynlAh1maKXGy8=@lists.denx.de
X-Gm-Message-State: AOJu0YyiHYVLsG9Mtgb8itzfyzNxz+d5eidqxqa5FNvgI5orlaD1P7j1
 gfe2SNEEOLm5qXglwcBPXjM70q++QpssLtPps6u3mdumpXrHXZ4n0JG5xVg6BG8=
X-Gm-Gg: ASbGncuJGB/I337+dRMSwYj3GJnGIM9XL05mm9RvNDLGIKeMhqsOO5JLgrTuCCaYU65
 n6l6XQJiNus1xGEmjPEN3t+GZo/C7tJaWdtflpJKRg4O5jMYVo75GOW/Gb4VP7VoTeFUmJI2uxJ
 9CY/z7WlW1apdGJ38li3NmOjDoqmtc5gFNDrmAaUt44UctKYAgJt7daSU8TnlLCXXbKBEDz5mp4
 UuY6yQ5RBSyqClW58ZWDi0tFpqK3uT1hlDDCpUpri1Xm1RgSH+sbFITY2BRt8FMtQkJabQHmcnq
 y4hVmSroQ3M3WbA=
X-Google-Smtp-Source: AGHT+IHCCyq/M938c5VbWRn668CQWgnqhYc2eFWr/hVM1VpSiGm6QvsyrwDwa9FTSB1/26+3engbfA==
X-Received: by 2002:a05:690c:61c8:b0:6f9:9891:7a7f with SMTP id
 00721157ae682-6f9b29e575dmr127164067b3.25.1739206337430; 
 Mon, 10 Feb 2025 08:52:17 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99fd1bb4dsm17395437b3.30.2025.02.10.08.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:52:16 -0800 (PST)
Date: Mon, 10 Feb 2025 10:52:14 -0600
From: Tom Rini <trini@konsulko.com>
To: ZHANG Yuntian <yt@radxa.com>
Cc: Tony Dinh <mibodhi@gmail.com>, Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Git commit failed with mbedtls/framework
Message-ID: <20250210165214.GO1233568@bill-the-cat>
References: <20241118153742.GO3600562@bill-the-cat>
 <CAEfUkUJNOTCsh19VbKsHw9wWO1nn8o-OhRrAB46uhpKHO-Owsw@mail.gmail.com>
 <20241118164122.GQ3600562@bill-the-cat>
 <CAEfUkUJmSL8-XR6LUAKX=xW-mYQWNHzanRKvAVFaB2A9nA4W1A@mail.gmail.com>
 <20241118171811.GR3600562@bill-the-cat>
 <8823CB36AD9BEA6D+3c5f1842-bbaf-4dfa-96a6-d6d53b61ed10@radxa.com>
 <20250124182330.GQ60249@bill-the-cat>
 <8B2016527B9BCFBA+ca2da5a3-e889-4191-b951-88656d1043ab@radxa.com>
 <20250126155909.GA1233568@bill-the-cat>
 <26569898C3197239+f0d7baf9-994e-4954-9281-7013e08865fb@radxa.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aosReJQnCRja/TLs"
Content-Disposition: inline
In-Reply-To: <26569898C3197239+f0d7baf9-994e-4954-9281-7013e08865fb@radxa.com>
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


--aosReJQnCRja/TLs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 10:11:06AM +0800, ZHANG Yuntian wrote:
> Hi Tom,
>=20
> On 2025/1/26 23:59, Tom Rini wrote:
> > On Sun, Jan 26, 2025 at 03:13:46PM +0800, ZHANG Yuntian wrote:
> > > Hi Tom,
> > >=20
> > > On 2025/1/25 02:23, Tom Rini wrote:
> > > > On Fri, Jan 24, 2025 at 02:05:28PM +0800, ZHANG Yuntian wrote:
> > > > > Hi Tom,
> > > > >=20
> > > > > On 2024/11/19 01:18, Tom Rini wrote:
> > > > > > On Mon, Nov 18, 2024 at 12:16:18PM -0500, Raymond Mao wrote:
> > > > > > > Hi Tom,
> > > > > > >=20
> > > > > > > On Mon, 18 Nov 2024 at 11:41, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > >=20
> > > > > > > > On Mon, Nov 18, 2024 at 11:27:06AM -0500, Raymond Mao wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >=20
> > > > > > > > > On Mon, 18 Nov 2024 at 10:37, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > >=20
> > > > > > > > > > On Mon, Nov 18, 2024 at 10:24:32AM -0500, Raymond Mao w=
rote:
> > > > > > > > > > > Hi Tony,
> > > > > > > > > > >=20
> > > > > > > > > > > On Sat, 16 Nov 2024 at 02:39, Tony Dinh <mibodhi@gmai=
l.com> wrote:
> > > > > > > > > > >=20
> > > > > > > > > > > > Hi Raymond,
> > > > > > > > > > > >=20
> > > > > > > > > > > > On Fri, Nov 15, 2024 at 1:55=E2=80=AFPM Raymond Mao=
 <
> > > > > > > > raymond.mao@linaro.org>
> > > > > > > > > > > > wrote:
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Hi Tony and Tom,
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > On Fri, 15 Nov 2024 at 16:35, Tony Dinh <mibodhi@=
gmail.com>
> > > > > > > > wrote:
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > Hi Raymond,
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > On Fri, Nov 15, 2024 at 1:09=E2=80=AFPM Raymond=
 Mao <
> > > > > > > > raymond.mao@linaro.org
> > > > > > > > > > >=20
> > > > > > > > > > > > wrote:
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > Hi Tony
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > On Fri, 15 Nov 2024 at 15:32, Tony Dinh <mibo=
dhi@gmail.com>
> > > > > > > > > > wrote:
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > On Fri, Nov 15, 2024 at 11:27=E2=80=AFAM To=
ny Dinh <
> > > > > > > > mibodhi@gmail.com>
> > > > > > > > > > > > wrote:
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > On Fri, Nov 15, 2024 at 6:17=E2=80=AFAM T=
om Rini <
> > > > > > > > trini@konsulko.com>
> > > > > > > > > > > > wrote:
> > > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > > On Thu, Nov 14, 2024 at 08:26:33PM -080=
0, Tony Dinh
> > > > > > > > wrote:
> > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > > > I am on 2025.01-rc2, and I am trying =
to commit some
> > > > > > > > files.
> > > > > > > > > > The
> > > > > > > > > > > > error
> > > > > > > > > > > > > > > > > > > seems to indicate this framework dire=
ctory might need
> > > > > > > > some
> > > > > > > > > > > > > > > > > > > modification. Did I miss something?
> > > > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > > > error: 'lib/mbedtls/external/mbedtls/=
framework' does
> > > > > > > > not
> > > > > > > > > > have
> > > > > > > > > > > > a commit
> > > > > > > > > > > > > > > > > > > checked out
> > > > > > > > > > > > > > > > > > > fatal: updating files failed
> > > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > > That's odd. You didn't happen to try ou=
t some of the
> > > > > > > > previous
> > > > > > > > > > > > lwIP
> > > > > > > > > > > > > > > > > > iterations on that tree did you?
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > No, I did not. The tree is clean with "ma=
ke mrproper" and
> > > > > > > > on
> > > > > > > > > > the
> > > > > > > > > > > > > > > > > master branch. I just did a git pull and =
worked on it.
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > I went and looked at
> > > > > > > > https://github.com/Mbed-TLS/mbedtls.git.
> > > > > > > > > > The
> > > > > > > > > > > > > > > > > framework directory is pointing to a spec=
ific commit.
> > > > > > > > > > > > > > > > > framework @ 3867faa
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > I'll stash and repeat it on another clean=
 tree.
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > I have the same commit error on a brand new=
 tree.
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > I think you are talking about the test framew=
ork of MbedTLS's
> > > > > > > > > > > > original testsuite,
> > > > > > > > > > > > > > > am I right?
> > > > > > > > > > > > > > > MbedTLS was ported into U-Boot as a git subtr=
ee and that
> > > > > > > > > > framework is
> > > > > > > > > > > > a git
> > > > > > > > > > > > > > > submodule of original MbedTLS repo which was =
not included in
> > > > > > > > the
> > > > > > > > > > > > porting
> > > > > > > > > > > > > > > of U-Boot since U-Boot has its own testsuite.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Here is what I found.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > git clone https://github.com/u-boot/u-boot.git
> > > > > > > > u-boot-master-test
> > > > > > > > > > > > > > cd /usr/src/u-boot-master-test/
> > > > > > > > > > > > > > patch -p1 <
> > > > > > > > > > ../builds-u-boot-marvell/sheevaplug/sheevaplug_bootstd.=
patch
> > > > > > > > > > > > > > git add .
> > > > > > > > > > > > > > git commit . -m "arm: kirkwood: Enable bootstd =
and remove jffs2
> > > > > > > > for
> > > > > > > > > > > > > > Sheevaplug board" -e
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > The git commit above gave out this error:
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > error: 'lib/mbedtls/external/mbedtls/framework'=
 does not have a
> > > > > > > > > > commit
> > > > > > > > > > > > > > checked out
> > > > > > > > > > > > > > fatal: updating files failed
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > So I tried to commit only the specific files, a=
nd it works OK.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > git commit configs/sheevaplug_defconfig
> > > > > > > > include/configs/sheevaplug.h
> > > > > > > > > > > > > > -m "arm: kirkwood: Enable bootstd and remove jf=
fs2 for
> > > > > > > > Sheevaplug
> > > > > > > > > > > > > > board" -e
> > > > > > > > > > > > > > [master 47de8cff2d] arm: kirkwood: Enable boots=
td and remove
> > > > > > > > jffs2
> > > > > > > > > > for
> > > > > > > > > > > > > > Sheevaplug board
> > > > > > > > > > > > > >     2 files changed, 17 insertions(+), 19 delet=
ions(-)
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > I think it must be what Raymond said above. So =
perhaps during
> > > > > > > > Tom's
> > > > > > > > > > PR
> > > > > > > > > > > > > > pull, the framework directory was created. But =
"git commit ."
> > > > > > > > does
> > > > > > > > > > not
> > > > > > > > > > > > > > like the empty lib/mbedtls/external/mbedtls/fra=
mework directory.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > Under the native MbedTLS git repo, by default it =
has a
> > > > > > > > "framework"
> > > > > > > > > > > > pointing to
> > > > > > > > > > > > > its git submodule.
> > > > > > > > > > > > > Maybe we should mark it in the gitignore.
> > > > > > > > > > > >=20
> > > > > > > > > > > > I've tried .gitignore but could not make it work (m=
y Gitfu is
> > > > > > > > pretty
> > > > > > > > > > > > lousy). Can you suggest how that should be done?
> > > > > > > > > > > >=20
> > > > > > > > > > > > You can use the command without the '.' : git commi=
t -m
> > > > > > > > "<commit_msg>",
> > > > > > > > > > > this
> > > > > > > > > > > should work.
> > > > > > > > > > >=20
> > > > > > > > > > > @Tom Rini <trini@konsulko.com> Shall we remove both
> > > > > > > > > > > "lib/mbedtls/external/mbedtls/.gitmodules" and
> > > > > > > > > > > "lib/mbedtls/external/mbedtls/framework"? I can submi=
t a patch if you
> > > > > > > > > > agree.
> > > > > > > > > >=20
> > > > > > > > > > Can we do that and not make a problem for the next resy=
nc?
> > > > > > > > > >=20
> > > > > > > > > > Hmmm, no, this cannot be pulled back to the MbedTLS ups=
tream so still a
> > > > > > > > > problem
> > > > > > > > > when resync.
> > > > > > > > > Another option is to include that git submodule into the =
U-Boot project,
> > > > > > > > > this needs
> > > > > > > > > to revert the commit of introducing the library and redo =
the git subtree
> > > > > > > > > after the
> > > > > > > > > submodule is updated, but it does not seem to be a good c=
hoice as we
> > > > > > > > don't
> > > > > > > > > use
> > > > > > > > > that test framework in U-Boot at all.
> > > > > > > > > Right now I don't have a perfect solution, maybe we can a=
ccept using git
> > > > > > > > > commit
> > > > > > > > > without the '.'?
> > > > > > > >=20
> > > > > > > > Hmm. Maybe we just delete the .gitmodules / directory and i=
t shouldn't
> > > > > > > > be too hard to deal with on updates. I have to do some smal=
l fixups with
> > > > > > > > the device tree ones anyhow sometimes.
> > > > > > > >=20
> > > > > > > > How about checking and deleting this in the subtree update =
script?
> > > > > > > Then we can skip manually doing this each time.
> > > > > > > I can make a patch for it if you feel fine.
>=20
> Is it possible for us to reconsider this option? I'm not aware of any
> obvious reasons for rejection here.
>=20
> I really want to explore all possible solutions before declare this as
> won't fix in documents.

I guess yes, please submit a patch that removes the .gitmodules file and
directory, sorry for the delay, thanks.

--=20
Tom

--aosReJQnCRja/TLs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqLrYACgkQFHw5/5Y0
tyxaSQv7B8Wx18mrwQd9eab7m6ZHqoSLBI2reqY8EUDxGyFudfLKh+0QgfBnXuUd
xJuJWd5C6amQWRzA6gZ6znyMeGd85ouc5YEYHhI4n1BE0gzubus6y2pXjSnRxuUN
viDWGYvVUTUTJPJjoWrIGDBFY8TY/D7BWvrqqZjYFuiswVDWQYly4rpeiS4zu9JM
g9k+KOkby576xjWWbDuCDjvLKoWo3NCEb49HcCWNdCMSOleDNH9iSpH3QKGKfmcV
dG5S4ZZHrIovRCKYPTYUMYsxkCqEXiPd9syiPSWEVQrKetxqRDf7WJW1+BwWEk+q
h7HdhlBfCb5oq2Wdh78o8JhJErT9NrLxtLQrOYTMJzejzcSweL888exG6fMBWLrK
5WyjLs8xV69h4vowPBZAxvEZT7qP48YiSndwVRQeluI5cIR11S40KNKGq9BpdYC3
pQEHqz00ivaFEafRZmFCUUF2mBwnE5Xhe8uEWIh8MuN0vhEdPdMRHYM+WnHvIqHD
cN2PhvGb
=MNeP
-----END PGP SIGNATURE-----

--aosReJQnCRja/TLs--
