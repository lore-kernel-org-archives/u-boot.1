Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABB7C0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 14:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A3E98685D;
	Tue, 15 Aug 2023 16:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jBydxB3/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21F5286874; Tue, 15 Aug 2023 16:56:45 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4649867F0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 16:56:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-56ce156bd37so3918513eaf.3
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 07:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692111400; x=1692716200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+lAsnTW8FBccjJ/qmlf9q599Nq3mRm+7OorULZjjUAg=;
 b=jBydxB3/D+FueoagLmij5/VqhZAAjrEgja7Na50LnLiDVmgWKugYyTEmHYwB0SHUdJ
 t9E96faZ2PGKVYfSbauQxXSGks6qz3Om6PzqzZWyUytab0XRbef0lTIDloQze0BcvvLn
 rW+uzfw01h9cGts2ylTAPE/Lpi9S0aG2L/1Eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692111400; x=1692716200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lAsnTW8FBccjJ/qmlf9q599Nq3mRm+7OorULZjjUAg=;
 b=C2n9uSkRunKSBznimiPqczwvzlX5JuMYg31Q3S+WmkqAOgF6/weLRj8+KoG/MWYaWZ
 O4m1dPoh9c1RRa4t6HEC0r3AUFZu8eGz+4s0QDnBzNJJQhs6+Gu0LcvgKZ6sDzsRSHV+
 Gcr/gaQON4fBtdIF6qhky7vw5NI+NZchwyKy6pJvlqrYgcVggbG6xYlkL2ZAIurVjWfg
 /oLSzHNkbEQuZZ5f1AxerWvNyDFotCvsDX8chmc1HfjSdjHu0oIUsw9iOSIc6UHQLiaD
 +EFT4GuJqdr0f0pGDVTEblrG+MKdjgznWeOHYQ/deC2784ET7w/4vSqJRAQDVAedR2gs
 QsTw==
X-Gm-Message-State: AOJu0Yxz6nKpYE77bXgTrgaVEfezgc/axsSnaWhmsG4lkcOAeW1ykgVO
 Q6cDdDYr7jgaQLuD2k/E1wfTPR5DV11rufor4g4iIA==
X-Google-Smtp-Source: AGHT+IHggBg4Rd1wYX1PHnrMGk0SfKvPe/OYbowRu0kSf3oZI9cL2NC4qgvY5dW8TkDtJm1XJo2+3w==
X-Received: by 2002:a05:6871:28e:b0:1c1:19ae:7b23 with SMTP id
 i14-20020a056871028e00b001c119ae7b23mr13823797oae.55.1692111400514; 
 Tue, 15 Aug 2023 07:56:40 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-14d5-2a24-c47a-465f.res6.spectrum.com.
 [2603:6081:7b00:6400:14d5:2a24:c47a:465f])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a818406000000b00583d5c6de1dsm3431960ywf.17.2023.08.15.07.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:56:40 -0700 (PDT)
Date: Tue, 15 Aug 2023 10:56:38 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Strange gitlab idea
Message-ID: <20230815145638.GY3630934@bill-the-cat>
References: <CAPnjgZ0Gj==Q-YOU+EoD=s3h25Waw5EYa0DEOD_comoAy_bRMw@mail.gmail.com>
 <20230813155208.GN3630934@bill-the-cat>
 <CAPnjgZ2_y3coEzTh=3Y=-w=B+qFAmxM5CbCYsKDWvCNaeO_-Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="L/ZFHzKhKU6Vyt0p"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2_y3coEzTh=3Y=-w=B+qFAmxM5CbCYsKDWvCNaeO_-Kg@mail.gmail.com>
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


--L/ZFHzKhKU6Vyt0p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 08:44:20AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 13 Aug 2023 at 09:52, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Aug 12, 2023 at 09:14:45PM -0600, Simon Glass wrote:
> >
> > > Hi Tom,
> > >
> > > I notice that the runners are not utilised much by the QEMU jobs,
> > > since we only run one at a time.
> > >
> > > I wonder if we could improve this, perhaps by using a different tag
> > > for the QEMU ones and then having a machine that only runs those (and
> > > runs 40 in parallel)?
> > >
> > > In general our use of the runners seems a bit primitive, since the
> > > main use of parallelism is in the world builds.
> >
> > I'm honestly not sure. I think there's a few tweaks that we should do,
> > like putting the opensbi and coreboot files in to the Dockerfile logic
> > instead.  And maybe seeing if just like we can have a docker registry
> > cache, if we can setup local pypi cache too?  I'm not otherwise sure
> > what's taking 23 seconds or so of
> > https://source.denx.de/u-boot/u-boot/-/jobs/673565#L34 since the build
> > and run parts aren't much.
> >
> > My first big worry about running 2 or 3 qemu jobs at the same time on a
> > host is that any wins get from a shorter queue will be lost to buildman
> > doing "make -j$(nproc)" 2 or 3 times at once and so we build slower.
>=20
> Yes, perhaps.
>=20
> >
> > My second big worry is that getting the right tags on runners will be a
> > little tricky.
>=20
> Yes, and error-prone. Also it makes it harder to deal with broken machine=
s.
>=20
> >
> > My third big worry (but this is something you can test easy enough at
> > least) is that running the big sandbox tests, 2 or 3 times at once on
> > the same host will get much slower. I think, but profiling would be
> > helpful, that those get slow due to I/O and not CPU.
>=20
> I suspect it would be fast enough.
>=20
> But actually the other problem is that I am not sure whether the jobs
> would have their own filesystem?

Yes, they should be properly sandboxed.  If you want to test some of
these ideas, I think the best path is to just un-register temproarily
(comment out the token in config.toml) some of your runners and then
register them with just the DM tree and experiment.

--=20
Tom

--L/ZFHzKhKU6Vyt0p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTbkiYACgkQFHw5/5Y0
tywTLAv8Ca8qhbzjT6Or/S8nCRUS90biVIr6TZCLjTls1Wjw3YStShdg03pHX/ig
bCChq4mT7bTrJM8FuetVua65MJxzvqupNnSxWYKt3mUW5Wz/6uvkKVVfTWwXrWh/
/qbMcueIOCmzLJJOI9xaT+Bcj+Nv/0oC4fVIZa+5Wg2+YdC96rgDl7/qtgN3B3Cj
fgOqbJ7eYE/G1pfBCpZQizczqwTErdag3LTyaE1RbjTvMoKHER1qXhlwVdsKO7Gw
GS7/VWCQ+ysHKyTQQAUH84mKM9kyUcz3N5BQjw0XKhuH5GYcO5fCKah422MFoFo9
A4m9F/d7RNvzA+TDH0Y9ZWSm6Wk3HMzARo91XmLMGUC1w4QlgAWNThUTfAUg/cr9
lPV9VMmvtgdQ1M63EWajz2MGr/tC8G7jdTIR+tQyhqFlsKRq75fsZMBu6izi6hoo
hUs6O4/jtCwtT3dznMhXkJHkyrQvrJ9VMEzw3rdeD0e6OTWl8xDrw8lrCT7/LkpR
Vsg2GGPc
=1Zuk
-----END PGP SIGNATURE-----

--L/ZFHzKhKU6Vyt0p--
