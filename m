Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D6EC5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 16:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 886B682AA7;
	Tue,  3 Jun 2025 18:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E7u19Roc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A415B82AAA; Tue,  3 Jun 2025 18:10:21 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 631E482A76
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 18:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-406e31162c6so1171341b6e.2
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 09:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748967018; x=1749571818; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6erOBOweNBxcu2j4sQGNwPRgfUuR/e4YaD0gskGly3I=;
 b=E7u19RocYqewlg8nxkL22hnT9oDLyiUOdDtJL9GdxdjX7jId36LVAvdYU+SLfOfDD6
 nPlB53cRgUA1jzmsZkzWM6EOv90KWBZho6KSKW2I/WDVQDY6MwgC5DVK1wTqP0ABcNUN
 hf59MVhlnnTh56f/V2RxkhIZMQtRl/KQ6FXd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748967018; x=1749571818;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6erOBOweNBxcu2j4sQGNwPRgfUuR/e4YaD0gskGly3I=;
 b=On4ScBuvzSHn2Bu3lWLD+nOobu5E06KyA3IaJpgM3ehYCm9n5VjJwRxPnl0IkFGP8Z
 meu125gsIXm+YQ0mYUgVH2uH5+nxniN9ohKa+mAed6d7vNnGYquHVRPlakquiJREG8H3
 X4odS4nZYjUGNnOtKPhLFldnoP+P8hDsRHSHXhxiSFOh4zm288EWuUqFWjPpM/fkYIiK
 gNKumeG525jbuTsk1YA9edD24jeLAFj3HPdoBvRgJV6BUR61EBXoII8LwaeI5sx0GV14
 6u+k6dRW8z5A5skaGuAxxe8cmfDsXcTpx3AbelvsAv7uA/ATVKDE6R/rt7jNXN6KAH+y
 87zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSwr8z2n047mTPAgROa+oijcBV9dN3aJPxoYueaClA0COc/BjQpI8fGGb4RxEkahcPpoimK+Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yzw6G4zdKLC+sCVmrRl7CSHI3VMsm8qVymtV1qjByxmciMhKYUm
 zr5IycVI1yrQiat5cRrbYEOODXRf4DX8kvXWDLdY842kYTgjpP3MS2ACTJVMUOOG4DcetO3BJjx
 CUFX3t/Q=
X-Gm-Gg: ASbGncu86Dp1l4+DgWm8j2IKRXR6Gci/TllYtsdc0M2G44hB/pj4IuvZqXtt9AnRfVs
 Q+6Mq6HgAc7kJ9p0b4RLDwotz0/ffPCS6QFgjq/DzZRHq8dQKHzb430/zYeb910g4VgVm1XrDx2
 qpZwXmhpCNr7kQs4Jr0dTAErdsWBwl/7NaCP7friiFt5birTiThQjvVBUUZJdiWw8ReEvo4eeWJ
 ti3NhoGyMJFo0AFXh3vqUUfot2SmazYv+2EYTTsEJL7FhP7ZJMNSmOZFqkHB70Is6uPT/p79L8k
 2Bh5gqZvfL411nX7zcLFL21qwPryps63ITw925sqTuwuj70kSu0Gsm1R62urpc4lqO7mv7Xhazz
 MNZ7fsrrZsiSr
X-Google-Smtp-Source: AGHT+IEJXDwcfmBqhu3eNfmWuSLDxmk1OyPwT9ZsAmgNzO220Orl3rXxA+Q4b0ZitFy+YklTYAJOog==
X-Received: by 2002:a05:6808:9bc:b0:3fa:daa:dd8e with SMTP id
 5614622812f47-4067974c755mr9551298b6e.35.1748967018048; 
 Tue, 03 Jun 2025 09:10:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678d04057sm1853150b6e.48.2025.06.03.09.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 09:10:16 -0700 (PDT)
Date: Tue, 3 Jun 2025 10:10:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH v6 2/3] common: board: make initcalls static
Message-ID: <20250603161014.GI1382132@bill-the-cat>
References: <20250404135038.2134570-1-jerome.forissier@linaro.org>
 <20250404135038.2134570-3-jerome.forissier@linaro.org>
 <CAFLszThkuPyy+Z3gt1oo7ZDPo+60tzdqwevSD2HjA7KjLeNcQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G/3fQ24g7Z63d5la"
Content-Disposition: inline
In-Reply-To: <CAFLszThkuPyy+Z3gt1oo7ZDPo+60tzdqwevSD2HjA7KjLeNcQw@mail.gmail.com>
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


--G/3fQ24g7Z63d5la
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2025 at 09:22:01AM -0600, Simon Glass wrote:
> Hi Jerome,
>=20
> On Fri, 4 Apr 2025 at 07:50, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
> >
> > Change board_init_f(), board_init_f_r() and board_init_r() to make
> > static calls instead of iterating over the init_sequence_f,
> > init_sequence_f_r and init_sequence_r arrays, respectively. This makes
> > the code a simpler (and even more so when initcall_run_list() is
> > later removed) and it reduces the binary size as well. Tested with
> > xilinx_zynqmp_kria_defconfig; bloat-o-meter results:
> >
> > - With LTO
> > add/remove: 106/196 grow/shrink: 10/28 up/down: 31548/-33829 (-2281)
> > Total: Before=3D1070471, After=3D1068190, chg -0.21%
> > - Without LTO
> > add/remove: 0/54 grow/shrink: 3/0 up/down: 2322/-2832 (-510)
> > Total: Before=3D1121723, After=3D1121213, chg -0.05%
> >
> > Execution time does not change in a noticeable way.
> >
> > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > ---
> >  arch/sh/lib/board.c         |   9 +-
> >  common/board_f.c            | 223 ++++++++++++++++----------------
> >  common/board_r.c            | 247 ++++++++++++++++++------------------
> >  include/initcall.h          |  27 ++++
> >  test/py/tests/test_trace.py |   8 +-
> >  5 files changed, 273 insertions(+), 241 deletions(-)
> >
> [..]
> > diff --git a/common/board_f.c b/common/board_f.c
> > index baf98fb8ec8..a1bb8a01be5 100644
> > --- a/common/board_f.c
> > +++ b/common/board_f.c
> [..]
> > @@ -1049,8 +1056,8 @@ void board_init_f(ulong boot_flags)
> >  /*
> >   * For now this code is only used on x86.
> >   *
> > - * init_sequence_f_r is the list of init functions which are run when
> > - * U-Boot is executing from Flash with a semi-limited 'C' environment.
> > + * Run init functions which are run when U-Boot is executing from Flas=
h with a
> > + * semi-limited 'C' environment.
> >   * The following limitations must be considered when implementing an
> >   * '_f_r' function:
> >   *  - 'static' variables are read-only
> > @@ -1063,18 +1070,16 @@ void board_init_f(ulong boot_flags)
> >   * NOTE: At present only x86 uses this route, but it is intended that
> >   * all archs will move to this when generic relocation is implemented.
> >   */
> > -static const init_fnc_t init_sequence_f_r[] =3D {
> > -#if !CONFIG_IS_ENABLED(X86_64)
> > -       init_cache_f_r,
> > +static void initcall_run_f_r(void)
> > +{
> > +#if CONFIG_IS_ENABLED(X86_64)
>=20
> This is reversing the condition, which breaks link and coral in my lab.
>=20
> > +       INITCALL(init_cache_f_r);

The most helpful thing to do here would be to post a patch correcting
the logic and providing a Fixes tag, thanks.

--=20
Tom

--G/3fQ24g7Z63d5la
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg/HmYACgkQFHw5/5Y0
tyy51Qv+OW3VqzF8cjNncsHrKqBv/YAJgv24EgZRSCwGpVrASE551++6Fri5qr+a
X2nzNPVNO2nwiLgXCUMi0HjVdcMhdlh5U9LMamOPDD/cdBi2PEiYuKU9v32ITazs
GgPkYpAM0d6YM+4ddrZBFJd03t35ho5rMdaB25vrF/jdlsJ8qZQkQGXYk0JpKTc2
iCKgng2Sc1I0uDT7hIO8mfx7sgLGiPLU2JYa1KE1UQAwrptLID9awUOx4iQKhdwu
aObchVcXUj/EqynqEe3HJCVh3otL9vW+Iie+CKTfi/lVP9AuSXXrT2SV3IC2XXUR
wc/IBXQhm1ow51UglM/AN4Gplr4Gp1mSVMxiU6RCbLysudFxpI+DIR99AwOEfZ3e
YbhQdCnH0GzbKtr+fLRpoUk87b3CIqVip8/ue5RRpRiHkRpyVEhO85JxOakLLEEk
YKY41QuVPG61PZ+eva9ry7ej86qWoJBiqkPQvQqfJGiNS1MwEDIxVTe9Dwv+tgV/
uW/EszD/
=V5pU
-----END PGP SIGNATURE-----

--G/3fQ24g7Z63d5la--
