Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D6DC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 13:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07F93870F8;
	Thu,  9 Nov 2023 14:37:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gGg61CDB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FC9187168; Thu,  9 Nov 2023 14:37:28 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E28C870BE
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 14:37:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-41cd1fe4645so5113761cf.0
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 05:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699537045; x=1700141845; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=acJizsRTfCQIRb8t1QdDAxetltLK4B6lZrRbfpbBeIc=;
 b=gGg61CDBHYnCZywAi7DfW1HD1SfM5soWmPlUpVbg2kyJJ2EkfW95nF1MBydlUlEChe
 SmnIe3jxRjA+Uk2LX6rKLb03w7uzQvLxVyUrHc/uRG5EzfTD7gqma3wKyfqJutGgbcKZ
 GwOzwR0j63FSZUJaFQ81QC62pVH/FQYXs0O0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699537045; x=1700141845;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=acJizsRTfCQIRb8t1QdDAxetltLK4B6lZrRbfpbBeIc=;
 b=FEi5ojUm4Vdpy+yvtpkx40JNV93U7DtHahHeH/XcKOex2HM4Ds4lgwtuKbB8AHmLbt
 OTAMcoN0BqrRPlMdPP7sSP4WhxyWWwmpc9Xh9m6GjCD3LVBx6NWPvXJ7xvy8xWLvbWPl
 +Vr6J0xqfskOVHDT/WDODGUDwpJ9XChh29vR2s11MVBa1xgoolXaHjopnyoc5lICr+a+
 v8vEKD0sUUV0oV1za4QMErxeJ9GfmgtIFTT0Mckd8ick+hZzO7O45FTaKD7JTCo8TJRM
 n6rKsOlzGPYPBMsiHUKEZdJT+zvsYdncgHqdFrDlZJHj+eaCVzykS/1KmWnuaHyg5XLf
 8Jtw==
X-Gm-Message-State: AOJu0YzaR0PaoYRo7Dh2S147nGqjg4TyAjs4kHiBNWhZufj6kyr1oSXa
 fJalU3kXCv1KnoT04aIP6lNEKQ==
X-Google-Smtp-Source: AGHT+IEvWRki+EasRDlnR+HPDnJCHO+tYRsPZFTpYTEgp0c6fi/ld8Hb8y8EsXUK4VFSKM7yqmItLg==
X-Received: by 2002:a05:622a:190e:b0:41c:c3ad:922d with SMTP id
 w14-20020a05622a190e00b0041cc3ad922dmr5089106qtc.52.1699537044797; 
 Thu, 09 Nov 2023 05:37:24 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-58a3-ea36-c2a1-60cb.res6.spectrum.com.
 [2603:6081:7b00:6400:58a3:ea36:c2a1:60cb])
 by smtp.gmail.com with ESMTPSA id
 jt56-20020a05622aa03800b0041cb8732d57sm1940111qtb.38.2023.11.09.05.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 05:37:24 -0800 (PST)
Date: Thu, 9 Nov 2023 08:37:22 -0500
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Francis Laniel <francis.laniel@amarulasolutions.com>, u-boot@lists.denx.de,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v11 00/24] Modernize U-Boot shell
Message-ID: <20231109133722.GB6601@bill-the-cat>
References: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
 <CALeDE9PChRKwgZfTR6-fuOR7pThzDynj44UvPVVw3P19_wGujA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S5C6k2lEoiPbONqD"
Content-Disposition: inline
In-Reply-To: <CALeDE9PChRKwgZfTR6-fuOR7pThzDynj44UvPVVw3P19_wGujA@mail.gmail.com>
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


--S5C6k2lEoiPbONqD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 12:14:28PM +0000, Peter Robinson wrote:
> On Wed, Nov 8, 2023 at 12:49=E2=80=AFAM Francis Laniel
> <francis.laniel@amarulasolutions.com> wrote:
> >
> > Hi.
> >
> >
> > During 2021 summer, Sean Anderson wrote a contribution to add a new she=
ll, based
> > on LIL, to U-Boot [1, 2].
> > While one of the goals of this contribution was to address the fact act=
ual
> > U-Boot shell, which is based on Busybox hush, is old there was a discus=
sion
> > about adding a new shell versus updating the actual one [3, 4].
> >
> > So, in this series, with Harald Seiler, we updated the actual U-Boot sh=
ell to
> > reflect what is currently in Busybox source code.
> > Basically, this contribution is about taking a snapshot of Busybox shel=
l/hush.c
> > file (as it exists in commit 37460f5da) and adapt it to suit U-Boot nee=
ds.
> >
> > This contribution was written to be as backward-compatible as possible =
to avoid
> > breaking the existing.
> > So, the 2021 hush flavor offers the same as the actual, that is to say:
> > 1. Variable expansion.
> > 2. Instruction lists (;, && and ||).
> > 3. If, then and else.
> > 4. Loops (for, while and until).
> > No new features offered by Busybox hush were implemented (e.g. function=
s).
> >
> > It is possible to change the parser at runtime using the "cli" command:
> > =3D> cli print
> > old
> > =3D> cli set 2021
> > =3D> cli print
> > 2021
> > =3D> cli set old
> > The default parser is the old one.
> > Note that to use both parser, you would need to set both CONFIG_HUSH_20=
21_PARSER
> > and CONFIG_HUSH_OLD_PARSER.
> >
> > In terms of testing, new unit tests were added to ut to ensure the new =
behavior
> > is the same as the old one and it does not add regression.
> > Nonetheless, if old behavior was buggy and fixed upstream, the fix is t=
hen added
> > to U-Boot [5].
> > In sandbox, all of these tests pass smoothly:
> > =3D> printenv board
> > board=3Dsandbox
> > =3D> ut hush
> > Running 20 hush tests
> > ...
> > Failures: 0
> > =3D> parser set 2021
> > =3D> ut hush
> > Running 20 hush tests
> > ...
> > Failures: 0
> >
> > Thanks to the effort of Harald Seiler, I was successful booting a board:
> > =3D> printenv fdtfile
> > fdtfile=3Damlogic/meson-gxl-s905x-libretech-cc.dtb
> > =3D> cli get
> > old
> > =3D> boot
> > ...
> > root@lepotato:~#
> > root@lepotato:~# reboot
> > ...
> > =3D> cli set 2021
> > =3D> cli get
> > 2021
> > =3D> printenv fdtfile
> > fdtfile=3Damlogic/meson-gxl-s905x-libretech-cc.dtb
> > =3D> boot
> > ...
> > root@lepotato:~#
> >
> > I had to not use CONFIG_HUSH_2021_PARSER for the keymile board.
> > Indeed, the keymile board family is the only set of boards to call
> > get_local_var(), set_local_var() and unset_local_var().
> > Sadly, these functions are static in this contribution.
> > I could have change all of them to introduce code like this:
> > *_local_var(/*...*/)
> > {
> >         if (gd->flags & GD_FLG_HUSH_OLD_PARSER)
> >                 return *_local_var_old(/*...*/);
> >         if (gd->flags & GD_FLG_HUSH_2021_PARSER)
> >                 return *_local_var_2021(/*...*/);
> > }
> > But this would have mean renaming all old hush functions calls and I di=
d not
> > want to change the old hush particularly to avoid breaking things.
> > Instead, I change the keymile board to use environment variable instead=
 of local
> > ones.
> > I think this particularities can be addressed in future works.
> >
> > I also had to enable CONFIG_LTO for kirkwoord sheevaplug and phytec bk4=
r1, so
> > they do not hit their limits.

Note that v11 only enables LTO on sheevaplug, out of this list. And a
quick test right now shows that it's not needed either. And I'm putting
out some general feedback now as well so that v12 can go in to -next.

And I did throw this at my hardware lab and eveything boots and tests
run as normal.

> With nearly 15K lines of code added and the above limits being reached
> how much does this increase the size of a binary if it's selected?
> Those sorts of details are useful in these cover letters. Also of the
> 13k lines in cli_hush_upstream.c how much of that functionality is
> actually used in U-Boot? You mention functions are not, while I
> understand adding it straight from busybox has it's advantages for
> easier rebasing, if it's also pulling in a lot of code that is never
> used there's also detractions to adding 13k lines of code.

To repeat myself from last night,
https://gist.github.com/trini/53d9a3d59c797ecdbb3aec8edbbb9a12 is my
world build, before/after on current next. The gains are between 4172
bytes on the high side (r8a77980_v3hsk and family, which enable LTO and
seems like a size loss in this case) with 3500-3800 bytes being average
for aarch64. On arc it's only 2300-2500 bytes. 32bit ARM is similar to
aarch64 with the outliers being the platforms which enable unit tests so
have new tests too. On 32bit ARM, LTO is a clear win as those platforms
tend to grow by only 2200-2400 bytes. I'll note MIPS grows by almost
5000 bytes in some cases and PowerPC is in the mid 4000s. Everything
else is within those smaller bounds. All in all, since we're talking
about 13+ years I think of code progress all at once, these are quite
acceptable numbers and we wouldn't have noticed if it had been a yearly
resync instead, over time.

In terms of functionality out of 13k lines of code, it's trickier to
say. One could use the tool whose name evades me that just removes
unreachable due to defines code to see how much of the busybox.c file we
use. It wouldn't be something to commit as that would make resync a
nightmare (and we don't do it today). But I can say from looking at the
map files, we aren't compiling anything to then discard, so there's no
extra code being built that we don't need. Perhaps an audit of some of
the structs is in order, but upstream has done a good job already it
looks like in terms of keeping functionality isolated like that.

I do suspect we might have a few places where there's !__U_BOOT__ tests
being added that we can avoid by disabling features, or maybe don't need
since the feature flag is already off, and I might play with that in a
bit.

But overall, I think the argument for why lwip is good also applies
here. We're better off tracking a well known and updated upstream than
staying off in the weeds on our own.

--=20
Tom

--S5C6k2lEoiPbONqD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVM4IsACgkQFHw5/5Y0
tyyGVwwAqBE+LZULW/8ke/YU9qtE1U7moJTu0rhTBBfP52/ylCM1bMUhsHGsfQV3
PL3lkjd+EJOkaeR+CP14Oup0dqfQHz3wG1EIQ7ZyHAqIqWQJez6FznkPuOwMJwGy
n8i/75BquwTpWutGMoi6mEB9ql/apW8cAtRYIhWbmUa11kGprkd59bsySVS6txeR
7cFeqTkJMs31ZVqcoXA6BKTkBam/l7Gr+IJx9zUBdMtWwqJB1NDNAFuohmdwp+91
4q5g2hHvlJ3Wg+6C4uI6R+Bt/hdpU0pFT5YdwEGmz8oxVhUgFUjupoyCwR2s5S4v
SUChqjKrQ4JMuMs9zj82ALPNcqTtfgNVvjsdyGxfq5E7ApgZnPSGu88jRZyETaEh
+q3RRBrAEyUp5BZpdBldglwkGfO6aJKilFMq/S5FPsklV2H1BILt+KfjKBsE7E8s
iaWSBPmAIqaWAoe6gng8hDgJO5mZJRTT8mpZsBYb28Jq4s0evL1ww/Gz4CvVjtEd
SF+RetXc
=Oq5N
-----END PGP SIGNATURE-----

--S5C6k2lEoiPbONqD--
