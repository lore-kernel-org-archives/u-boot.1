Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6CDD597B3
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 22:28:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A010989454;
	Tue, 12 Nov 2024 23:28:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cT+qp/36";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99C8D89458; Tue, 12 Nov 2024 23:28:27 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AC16893B6
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 23:28:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b152a923a3so409646385a.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731450503; x=1732055303; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mt3QhDyuyTJIJgMacFW6ke3/Y6tItLq/9APbDrWn8YI=;
 b=cT+qp/36y89lnRPyl77ftnTS4RmOhDAPWrH3SMlc34U2FcmpFhSI0O+MPlJ8bwuMh0
 POgPawbmrEHct4S7AVVMyVIA/qIeJN8286ajQkm/GzrQDktKrQq0BEyqv9rA6C4oWpfK
 usAEABpDUJMktE7/GTw4JXMbXnRaG3Q/enYnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731450503; x=1732055303;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mt3QhDyuyTJIJgMacFW6ke3/Y6tItLq/9APbDrWn8YI=;
 b=HOINV2oSc8m6ji1idyM1BAkHKqdA4iNQbAfaz6u/f3XbDATGWqhqyoAqY2976ixbwd
 LWHT6auWJ9eRbw0Jp1DhGVg+Vl5+UhcsddxmZHNjSmsoQbUmHjuFs/zkqLnC2hmYuF1z
 4ghybkAdqgYZe89lZQHJh8FrxSwodnwKHHpBF5szKQpwoyRFuehVZeHsO8kzkAZJCijw
 KurqCRCSjAgF4SbkyTIqlW0xF5ZnJKSlFhaGyuEYZdXkDSIHfulHPpUIjB2T+BuQehhe
 Ei6gNQnGHS+dZeP36U/hjgOeWBmQ/PxPMSMyan4ZroQotYMXNRtfn7w7Q5swaPV1oxTA
 JnKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/n0aDF4d9XiFVoDK/ENy5BBBq55eKn5vri1oc5gOc9uHxUSz0pGaGEDhSwNThi/tHjOwqhSo=@lists.denx.de
X-Gm-Message-State: AOJu0YyjYjjziL4dh1I+2mtxDiERPS12+hPyhfIhykulAMPWVCq39ujL
 nCp9DHzYCyphfZYtQduFU4WGwMxYYuMw/wnp6164TwJjxr8d42Hvb9G4NW/rv+Q=
X-Google-Smtp-Source: AGHT+IGBaMNBsQntR5pZ19Ksv+InKFmgqyhjkDqMyn/4i2rIfDQSnIsYY7jo+DG5x699evxit7MyRA==
X-Received: by 2002:a05:6214:450a:b0:6cb:ec7e:4fba with SMTP id
 6a1803df08f44-6d3dd05154dmr9817186d6.25.1731450502944; 
 Tue, 12 Nov 2024 14:28:22 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d3966317f3sm76747196d6.118.2024.11.12.14.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 14:28:21 -0800 (PST)
Date: Tue, 12 Nov 2024 16:28:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Heiko Schocher <hs@denx.de>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/5] fs: ext4: implement opendir, readdir, closedir
Message-ID: <20241112222817.GZ3600562@bill-the-cat>
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
 <173058992364.1044919.1983318156372551084.b4-ty@konsulko.com>
 <CAOf5uw=292JNb1g03_Hcgav4zyUckh3R1_iphHnynHVeqC82Jw@mail.gmail.com>
 <e79be8c7-2461-425f-8f7b-e24ad3884d65@gmx.de>
 <CAOf5uwmXy4qevGpYe04pYCcSJ3r20o9WXzqemDLfi6z5A041LQ@mail.gmail.com>
 <bd927540-d3f5-4eb4-babe-13910c735b40@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/julb84wdIsuAxdr"
Content-Disposition: inline
In-Reply-To: <bd927540-d3f5-4eb4-babe-13910c735b40@gmx.de>
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


--/julb84wdIsuAxdr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2024 at 10:47:38AM +0100, Heinrich Schuchardt wrote:
> On 11/7/24 10:31, Michael Nazzareno Trimarchi wrote:
> > Hi
> >=20
> > On Thu, Nov 7, 2024 at 10:27=E2=80=AFAM Heinrich Schuchardt <xypron.glp=
k@gmx.de> wrote:
> > >=20
> > > On 11/3/24 00:36, Michael Nazzareno Trimarchi wrote:
> > > > Hi Tom
> > > >=20
> > > > On Sun, Nov 3, 2024 at 12:26=E2=80=AFAM Tom Rini <trini@konsulko.co=
m> wrote:
> > > > >=20
> > > > > On Sat, 26 Oct 2024 08:40:43 +0200, Heinrich Schuchardt wrote:
> > > > >=20
> > > > > > With this series opendir, readdir, closedir are implemented for=
 ext4.
> > > > > > These functions are needed for the UEFI sub-system to interact =
with
> > > > > > the ext4 file system.
> > > > > >=20
> > > > > > To reduce code growth the functions are reused to implement the=
 ls
> > > > > > command for ext4.
> > > > > >=20
> > > > > > [...]
> > > > >=20
> > > > > Applied to local tree/v2-tidy-test-dir, thanks!
> > > > >=20
> > > > Am I sleeping?
> > > >=20
> > > > int ext4fs_opendir(const char *dirname, struct fs_dir_stream **dirs=
p) {
> > > >       struct ext4_dir_stream *dirs =3D NULL;
> > >=20
> > > Thank you for your review.
> > >=20
> > > We should not set a value that we do not use.
> > >=20
> > > >       struct ext2fs_node *dir =3D NULL;
> > > >       int ret;
> > > >=20
> > > >       *dirsp =3D NULL;
> > > >=20
> > > >       dirs =3D calloc(1, sizeof(struct ext4_dir_stream));
> > > >       if (!dirs)
> > > >           return -ENOMEM;
> > > >=20
> > > >       dirs->dirname =3D strdup(dirname);
> > > >       if (!dirs->dirname) {
> > >=20
> > > Yes this line in my code is incorrect.
> > >=20
> >=20
> > We need to use valgrind in unit test or we need some code analys to
> > automate this process.
> > We are always looking for memory leaks in uboot in exit path or we
> > need to have alloction funciton that
> > automatic free the memory when we go in error path
>=20
> Coverity probably would have reported this. But I think we only run it
> on tags.

A challenge with Coverity is that for the free plan we're limited to
basically one run per day, and there's not a good way to handle that
with CI. I am trying to get in the habit of running a scan after I push
my last merge for the day but that's (a) manual and then runs in to (b)
doesn't handle branching as I also didn't see a way for the dashboard to
handle both "master" and "next", on the free plan.

That said, if anyone out there is very good at Coverity stuff and would
like to volunteer to help organize things better, it would be much
appreciated!

--=20
Tom

--/julb84wdIsuAxdr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcz1noACgkQFHw5/5Y0
tyyb0QwAhgmDMhMLB+19kU94n8MlnfU5pl3LCH5u9H6Zu17BUmn7cxKi38psJf7y
iEwEKcIMrJ/lIZ3Ctjs0NlkxA+IkUYl4Ucapem3UzrgwWFq4IbKe/YmMbI6/VlSA
dAXy1f+S/jyCyyMNJZ3XODXbAP5sX1NFgytMi+I+sL//RFrAKP//nZKLLNrP1U4z
8RDl3XQp+Mm/250oR7kzOc+jMwpMp0rTzi3mtw9L+JFp+YbxBFdwlvc6KOnwbH0X
UVpAeouBEu6JpqE7/ivcsc+/VTwgeD2cy7kcUXj8z/3SzDU/SncFzIiCIllzoKPt
0XWdhvIEJ72ovT++81g+4j1o0ErYO9ZoYu7KkmLlOdCWsOkk4jOl3batxvNvxgfC
pQVMyp2KQF0ClyjLZECA7W2BucBSTszDU4hBe1kUIgDNhRAOXCggfPaj2w/pLtTW
M71Yo7yaX1+b9zZX6bgzHmkvmce3nIvTHpxLbwNIpvssQHtPxrhdpdEkWaXzjRk+
V1PhaOwW
=AQqA
-----END PGP SIGNATURE-----

--/julb84wdIsuAxdr--
