Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A019C30638
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 15:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56BE386B8E;
	Thu, 17 Aug 2023 17:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="atXIljOA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79A5286B67; Thu, 17 Aug 2023 17:10:26 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5032486B18
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1c4de3b9072so3237104fac.3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 08:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692285022; x=1692889822;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z9pKSM5p9OxgXDNzV6fabMjU+qzT9Q5uGtLmoOH+n2M=;
 b=atXIljOAbLUcsHxy1USPjsC4mRlLH/wYz4+Q7F9bHHuITdIC1bM9W5RB7/bzBwnZuR
 Ozoz2qVeNDRA44ccw5wmwDnKbJA16WZ7uSRppOfcQGm7B7O00oRVGSxMabqcuQYEOqTZ
 xc2Qpfl/TwY22ONi6P8u/7MVBSS5jNMM4XjzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692285022; x=1692889822;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z9pKSM5p9OxgXDNzV6fabMjU+qzT9Q5uGtLmoOH+n2M=;
 b=SarwNgN8WsZH8nE/gcSzmKtFUjeNZIci72Y8ssEcICw5DgEFPl6ijMrwSpD9EIlyDJ
 ImGGD95Ds2Cp11DBk1xGIQQKLCejLXFGIDuIyL0V7ujqoCQoTmi7HPoHx1qB1QovkGUa
 3JEBYYEVC+FDf1bVOeFoEa/YNbetxelMUt8yMO4tQT58RpBRTReWLAx1ifzFuiL0U3ya
 0oeFNgO+KL3qvIViRKnvXLNi/yEJwQszyXK2vpZHq5wh1BE+/JG/MHevBUuQtc+Us1vF
 QjzlY+giuTQsFipPrInMwelOF/ooOuQOFXIAyStxccUve6dCaVKHSMcCIvY0nbnsxqA8
 JO2Q==
X-Gm-Message-State: AOJu0YydJaeOwV+d0ri3qIUI1JXOdAe719/QoCXnOvXjGX4yTxlZKlAe
 1gduXafBwDh701pnt+Y+NDc5/VrAdEA2DRDxYcq7uQ==
X-Google-Smtp-Source: AGHT+IHx4kM9issbfCbzoDacGsyb82fI73JvtmqLGrJkGJPmOBkuy6D0wQqzDnz889ACpF2uG0uTYA==
X-Received: by 2002:a05:6871:154:b0:1c8:c37d:5e69 with SMTP id
 z20-20020a056871015400b001c8c37d5e69mr2239538oab.52.1692285021907; 
 Thu, 17 Aug 2023 08:10:21 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8f9f-218d-98ab-058b.res6.spectrum.com.
 [2603:6081:7b00:6400:8f9f:218d:98ab:58b])
 by smtp.gmail.com with ESMTPSA id
 d63-20020a0df442000000b0057042405e2csm4656118ywf.71.2023.08.17.08.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 08:10:21 -0700 (PDT)
Date: Thu, 17 Aug 2023 11:10:19 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Strange gitlab idea
Message-ID: <20230817151019.GD1515023@bill-the-cat>
References: <CAPnjgZ0Gj==Q-YOU+EoD=s3h25Waw5EYa0DEOD_comoAy_bRMw@mail.gmail.com>
 <20230813155208.GN3630934@bill-the-cat>
 <CAPnjgZ2_y3coEzTh=3Y=-w=B+qFAmxM5CbCYsKDWvCNaeO_-Kg@mail.gmail.com>
 <20230815145638.GY3630934@bill-the-cat>
 <CAPnjgZ3Tj1kwVViSfnqEcApkQ=At3pkKVVrfft6zvD4JmnbMzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CunrN4IHVnPZ06b0"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3Tj1kwVViSfnqEcApkQ=At3pkKVVrfft6zvD4JmnbMzw@mail.gmail.com>
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


--CunrN4IHVnPZ06b0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 07:41:50AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 15 Aug 2023 at 08:56, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Aug 15, 2023 at 08:44:20AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sun, 13 Aug 2023 at 09:52, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Aug 12, 2023 at 09:14:45PM -0600, Simon Glass wrote:
> > > >
> > > > > Hi Tom,
> > > > >
> > > > > I notice that the runners are not utilised much by the QEMU jobs,
> > > > > since we only run one at a time.
> > > > >
> > > > > I wonder if we could improve this, perhaps by using a different t=
ag
> > > > > for the QEMU ones and then having a machine that only runs those =
(and
> > > > > runs 40 in parallel)?
> > > > >
> > > > > In general our use of the runners seems a bit primitive, since the
> > > > > main use of parallelism is in the world builds.
> > > >
> > > > I'm honestly not sure. I think there's a few tweaks that we should =
do,
> > > > like putting the opensbi and coreboot files in to the Dockerfile lo=
gic
> > > > instead.  And maybe seeing if just like we can have a docker regist=
ry
> > > > cache, if we can setup local pypi cache too?  I'm not otherwise sure
> > > > what's taking 23 seconds or so of
> > > > https://source.denx.de/u-boot/u-boot/-/jobs/673565#L34 since the bu=
ild
> > > > and run parts aren't much.
> > > >
> > > > My first big worry about running 2 or 3 qemu jobs at the same time =
on a
> > > > host is that any wins get from a shorter queue will be lost to buil=
dman
> > > > doing "make -j$(nproc)" 2 or 3 times at once and so we build slower.
> > >
> > > Yes, perhaps.
> > >
> > > >
> > > > My second big worry is that getting the right tags on runners will =
be a
> > > > little tricky.
> > >
> > > Yes, and error-prone. Also it makes it harder to deal with broken mac=
hines.
> > >
> > > >
> > > > My third big worry (but this is something you can test easy enough =
at
> > > > least) is that running the big sandbox tests, 2 or 3 times at once =
on
> > > > the same host will get much slower. I think, but profiling would be
> > > > helpful, that those get slow due to I/O and not CPU.
> > >
> > > I suspect it would be fast enough.
> > >
> > > But actually the other problem is that I am not sure whether the jobs
> > > would have their own filesystem?
> >
> > Yes, they should be properly sandboxed.  If you want to test some of
> > these ideas, I think the best path is to just un-register temproarily
> > (comment out the token in config.toml) some of your runners and then
> > register them with just the DM tree and experiment.
>=20
> OK thanks for the idea. I tried this on tui
>=20
> I used a 'concurrent =3D 10' and it got up to a load of 70 or so every
> now and then, but mostly it was much less.
>=20
> The whole run (of just the test.py stage) took 8 minutes, with
> 'sandbox with clang test' taking the longest.
>=20
> I'm not too sure what that tells us...

Well, looking at
https://source.denx.de/u-boot/u-boot/-/pipelines/17391/builds the whole
run took 56 minutes, of which 46 minutes was on 32bit ARM world build.
And the longest test.py stage was sandbox without LTO at just under 8
minutes.  So I think trying to get more concurrency in this stage is
likely to be a wash in terms of overall CI run time.

--=20
Tom

--CunrN4IHVnPZ06b0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTeOFsACgkQFHw5/5Y0
tyzMogwAif8YIDmmuPV1YbGKvCf2OWnTF8MZIz25kstA7yoQ4jLyhp3djURtaSjE
G9scGobYBzwKdt7TDGsX6xNw0QWRg7+kM5XUYowx5J/WmfwYuGJPNYPIQWKwD09x
NR7JHu9orgxjsTGhBmiXBP2FiQ0pp6einOC+hDecYiCdiZGqjxniLI7nH1U9Wh4I
dKYpi3j0+TFAkd5Jo3pVs3QEXrhX9+19WuNhg9RwS1/TeUmqxcZP/BiBvtvZfU8/
5PsUHJxTVlalHy15DnBDByhtK3lLfrqSOicQYoZabYn5RdpadoHQiNBXLSlRKd09
ddLSeYXCjJD6xfqWQ6NGWMTtoIodsx7YNybBV8Zjwwp4eR2bkihD8m9iBKaObqoF
2rsNkwgj67576drEAFRTRrt8EseCILYT3jqDvu20+1quUbeR8wpRTpHd1gsnyJ+K
80C6mgGKf5O8yZg6rBYxpc9ak5C6TDdipP03ZmpNHrAqwL9YA54+i2R/75uzinPF
v1x2tMHD
=8ToV
-----END PGP SIGNATURE-----

--CunrN4IHVnPZ06b0--
