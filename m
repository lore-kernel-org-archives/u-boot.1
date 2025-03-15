Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD538C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 21:48:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0C92809A4;
	Sat, 15 Mar 2025 22:48:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y2yOPzaE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A63EE80C93; Sat, 15 Mar 2025 22:48:01 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87A518058A
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 22:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7c54a9d3fcaso336952185a.2
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 14:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742075277; x=1742680077; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F+GXQthhFvRF/s5PUKO7POoJTZ/xo+th+v+Y6qa4mg0=;
 b=Y2yOPzaEzpRaMt68TyeK7BaEbfknC9w2wIqUfhNePe1je1H8ducKhvk2EndKcZ35za
 +pYXtLHWi6wEEOMNHUQxwZP79ptsCH1NacSKuAC/bY0ew4MosbfVi1NYJNLI8mIZeqdt
 gVFRmYPegQhcVfGRzINQ3LZ7qL0GwVoQ+G5Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742075277; x=1742680077;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F+GXQthhFvRF/s5PUKO7POoJTZ/xo+th+v+Y6qa4mg0=;
 b=thbiuNldCYqEXNFI5CCZT4FoG0D53CtT/UYVyTlnA2r/VEH0UCf1gTvnUNyUcnPF4Q
 uNENcw2D5kqImkW1+9FTVBafmGPz97x0kouJ2px7oxss47H14f4Ep4JubIpOfEjRxLb3
 jwPuF4KcI1SbzDM5SL4fKukcR+PIVDOEaovpsbePFiE/TRAWf65oF3/FcZjjFKZLhdEv
 mft5GJcBWLzlLRg+zYWn/t1ne1+qlnVK+zSEOwHSkJ7nqnbM/ZjcUX8d34P7Jy7efTIg
 38g4wTJzm6NkgqKLozeYKOEUP/OlWyG0UlAhJoHI25lCJVLvNEJfptWY44vpRL9DFMmV
 K6/A==
X-Gm-Message-State: AOJu0Yyt2vL3+7/YDhNT6Vy6mt3Y7BA8Ev8AOnUGjt1bQUmlLRQ3Vkjf
 7mkvbxxYtzgBggEoAuFZZ4NUvMxVoPnIWyeZDA3K0y0cUh/kOVzJBe21gP1mLSs=
X-Gm-Gg: ASbGncuUZGRFuEsACmRcXmoy/XQi5VS1ypUJBpS3yIRr8GesvGg2wtd1Tn0cXO3EYS/
 IwACZuirwKQSH86AkyFymPc20X9s9I5mu//dK7j8q1UhlKitl5o3abZr7/ooUp76zYnJ5jWlOJO
 4ALWEUzd0RycrjYVrkTnQAfVi6iNSRwp61f6kUHqJtOOW8hS7Ypop54hQzrn7VQw2GkIzB5s2FK
 Z6yEBcthvq8HiAZHqlSCfBVh1NYfcpIWd8HDMm9HCpF5nGjjA6uMswou/3sAAe/TzIPxZN6mXLY
 lkeZ6XrS8NoguuqPmBd5VbCaBXjZp4U1Elq6jkeyBaZKL0j7+IXd+qri
X-Google-Smtp-Source: AGHT+IHo0Ty7u7x1eDd3OCL89PJecvT6OgXkoslZaMqQrXgtFYE8cIB5TC1rmlB+hgt03/ugq3VLyQ==
X-Received: by 2002:a05:620a:4091:b0:7c5:53ab:a745 with SMTP id
 af79cd13be357-7c57c8fb0e7mr1341695485a.36.1742075277216; 
 Sat, 15 Mar 2025 14:47:57 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573da455dsm411828885a.115.2025.03.15.14.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 14:47:55 -0700 (PDT)
Date: Sat, 15 Mar 2025 15:47:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Brandon Maier <brandon.maier@collins.com>
Subject: Re: [PATCH 2/2] u_boot_pylib: Clean up pylint warnings in gitutil.py
Message-ID: <20250315214752.GK2640854@bill-the-cat>
References: <20250209212714.2317040-1-sjg@chromium.org>
 <20250209212714.2317040-2-sjg@chromium.org>
 <20250217192316.GW1233568@bill-the-cat>
 <CAFLszTjXnz7coW9_MSLxWVH+Ea5bdka8oYByG4LQtTUNpije7g@mail.gmail.com>
 <20250314153615.GR2640854@bill-the-cat>
 <CAFLszThguOxcC2nR467Qc9U+VdO91F48mhPuv7d6DDF7WKbyqQ@mail.gmail.com>
 <20250315152314.GJ2640854@bill-the-cat>
 <CAFLszTitxR9CnQZdSdS8mvxEncRQ8Xn77ZAbHTjKuHnvtneCZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5o6RpHH0F6QzEZ2M"
Content-Disposition: inline
In-Reply-To: <CAFLszTitxR9CnQZdSdS8mvxEncRQ8Xn77ZAbHTjKuHnvtneCZA@mail.gmail.com>
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


--5o6RpHH0F6QzEZ2M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 03:50:55PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 15 Mar 2025 at 15:23, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Mar 15, 2025 at 02:48:18PM +0000, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 14 Mar 2025 at 15:36, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Mar 14, 2025 at 02:45:27PM +0000, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 17 Feb 2025 at 19:23, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sun, Feb 09, 2025 at 02:26:01PM -0700, Simon Glass wrote:
> > > > > >
> > > > > > > Reduce the number of warnings in this file.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > >  tools/buildman/func_test.py   |   4 +-
> > > > > > >  tools/u_boot_pylib/gitutil.py | 240 ++++++++++++++++++------=
----------
> > > > > > >  2 files changed, 128 insertions(+), 116 deletions(-)
> > > > > >
> > > > > > As I think these all were warnings from whatever other linting =
you had
> > > > > > mentioned in another thread, I deferred this patch as it also d=
oesn't
> > > > > > cleanly apply.
> > > > >
> > > > > Some of it, yes. But most of it is fixing things that we should f=
ix.
> > > >
> > > > To be clear, to the extent any of it was pylint problems, they've n=
ow
> > > > been addressed as we've moved to pylint 3.3.4.
> > >
> > > Actually, I don't know about those problems, but that's fine.
> > >
> > > >
> > > > > This is going to open up a significant diff for patman, unfortuna=
tely,
> > > > > just as I am adding new features for series management. So please
> > > > > consider applying it. I can rebase if you like?
> > > >
> > > > Yes, that's fine, please just explain what's showing the warnings or
> > > > otherwise update the commit message.
> > >
> > > Before:
> > >
> > > ************* Module u_boot_pylib.gitutil
> > > tools/u_boot_pylib/gitutil.py:1:0: C0114: Missing module docstring
> > > (missing-module-docstring)
> > > tools/u_boot_pylib/gitutil.py:13:0: C0103: Constant name
> > > "use_no_decorate" doesn't conform to UPPER_CASE naming style
> > > (invalid-name)
> > > tools/u_boot_pylib/gitutil.py:40:19: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:65:20: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:72:25: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:64:12: W0612: Unused variable 'msg'
> > > (unused-variable)
> > > tools/u_boot_pylib/gitutil.py:114:21: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:121:25: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:122:17: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:139:41: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:141:40: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:146:4: R1705: Unnecessary "elif" after
> > > "return", remove the leading "el" from "elif" (no-else-return)
> > > tools/u_boot_pylib/gitutil.py:151:15: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:153:25: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:171:11: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:189:21: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:243:22: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:255:22: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:272:22: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:305:22: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:317:22: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:320:0: R0913: Too many arguments (6/5)
> > > (too-many-arguments)
> > > tools/u_boot_pylib/gitutil.py:320:0: R0917: Too many positional
> > > arguments (6/5) (too-many-positional-arguments)
> > > tools/u_boot_pylib/gitutil.py:345:16: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:347:12: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:353:4: R1705: Unnecessary "else" after
> > > "return", remove the "else" and de-indent the code inside it
> > > (no-else-return)
> > > tools/u_boot_pylib/gitutil.py:402:16: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:416:7: R1714: Consider merging these
> > > comparisons with 'in' by using 'suppresscc in ('all', 'cccmd')'. Use a
> > > set instead if elements are hashable. (consider-using-in)
> > > tools/u_boot_pylib/gitutil.py:420:15: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:433:0: R0913: Too many arguments (12/5)
> > > (too-many-arguments)
> > > tools/u_boot_pylib/gitutil.py:433:0: R0917: Too many positional
> > > arguments (12/5) (too-many-positional-arguments)
> > > tools/u_boot_pylib/gitutil.py:433:0: R0914: Too many local variables
> > > (17/15) (too-many-locals)
> > > tools/u_boot_pylib/gitutil.py:512:19: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:514:19: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:520:24: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:433:0: R1710: Either all return
> > > statements in a function should return an expression, or none of them
> > > should. (inconsistent-return-statements)
> > > tools/u_boot_pylib/gitutil.py:435:36: W0613: Unused argument
> > > 'get_maintainer_script' (unused-argument)
> > > tools/u_boot_pylib/gitutil.py:592:14: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:593:8: R1720: Unnecessary "else" after
> > > "raise", remove the "else" and de-indent the code inside it
> > > (no-else-raise)
> > > tools/u_boot_pylib/gitutil.py:601:18: C0209: Formatting a regular
> > > string which could be an f-string (consider-using-f-string)
> > > tools/u_boot_pylib/gitutil.py:682:4: W0603: Using the global statement
> > > (global-statement)
> > >
> > > ------------------------------------------------------------------
> > > Your code has been rated at 8.41/10 (previous run: 8.37/10, +0.04)
> > >
> > >
> > > After:
> > >
> > > ************* Module u_boot_pylib.gitutil
> > > tools/u_boot_pylib/gitutil.py:1:0: C0114: Missing module docstring
> > > (missing-module-docstring)
> > > tools/u_boot_pylib/gitutil.py:325:0: R0913: Too many arguments (6/5)
> > > (too-many-arguments)
> > > tools/u_boot_pylib/gitutil.py:325:0: R0917: Too many positional
> > > arguments (6/5) (too-many-positional-arguments)
> > > tools/u_boot_pylib/gitutil.py:439:0: R0913: Too many arguments (11/5)
> > > (too-many-arguments)
> > > tools/u_boot_pylib/gitutil.py:439:0: R0917: Too many positional
> > > arguments (11/5) (too-many-positional-arguments)
> > > tools/u_boot_pylib/gitutil.py:439:0: R0914: Too many local variables
> > > (16/15) (too-many-locals)
> > > tools/u_boot_pylib/gitutil.py:694:4: W0603: Using the global statement
> > > (global-statement)
> > >
> > > ------------------------------------------------------------------
> > > Your code has been rated at 9.73/10 (previous run: 8.41/10, +1.32)
> >
> > And it's not clear where these warnings come from or why they matter or
> > how to check things further.
>=20
> Quite a few of them have been there for a while, but most of them are
> coming from newer versions of pylint, where people come up with new
> warnings. The f-string thing is the main one, since that feature was
> not available when the code was written, but now you get a warning if
> you don't use it, because Python.

OK. But pylint_err isn't complaining.

> > > The patch is here:
> > >
> > > https://patchwork.ozlabs.org/project/uboot/patch/20250209212714.23170=
40-2-sjg@chromium.org/
> > >
> > > It looks like it will apply for you, if first you accept my PR.
> >
> > It does, but I'm still not thrilled with the commit message.
>=20
> I could do a new one with the info above if you like. We are going to
> have this all over the place...

Are we going to have to? If it's not an error I don't know how much
effort *needs* to be put in to it.

So yes, please provide a much clearer commit message for this patch.
Nothing is complaining until you ask a tool to give a complaint report,
so it's not nearly as obviously critical as "CI fails now" or "Everyone
gets spammed by python when using buildman".

--=20
Tom

--5o6RpHH0F6QzEZ2M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfV9YAACgkQFHw5/5Y0
tyy5rwwAm3SxaSUdhS44y8ne3F00ADFV7SKMyIUxabqkNXihDFgK4jef0bq097dq
3QWNwpW8FgLP8LyvY4r7KuO1AigUcubizBK9NnuYMHg8oTP2PEIztlUd6ol46zew
Jz/GTYeFSoo4PiyPVzelFjb6EZVWWxCItWN3Ah/g1D9Y+n0e9wuAnYUPUBxJrN97
y2KceazaSjVuzg5aK7VKoBIG04DVB3cE9U313fcrFQY7K6OeE7/A075eYtIVoaqE
mQ9Z86N8tl/9FrPHDt8q6/k9wh+ESFpBpnSkXEcKOCbHW1ejOQFKg4O1Qx/W28z9
K4tStOswl4CcKH+SyUbmcJxxCvnZR0x26GjH0CWpJKDOEnJEiSfFFR7FDpYUTHMu
/BsUbrD9WYqljBqGFZAvEi+599Ehltg4R4nJy4L7NRkp1/oO+U35jWUJQC6NV2t1
FU1AJq+JpI3wcNKQVczXrF2fKnrCGUfoTxtHWht6/F77KG3JK3KEVeTfJ6gefuwG
qmc/hmAp
=cg9s
-----END PGP SIGNATURE-----

--5o6RpHH0F6QzEZ2M--
