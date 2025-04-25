Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFF7C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 16:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AAD5826AD;
	Fri, 25 Apr 2025 18:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dP8mimiZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73B4E82887; Fri, 25 Apr 2025 18:19:43 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C21C982115
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 18:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2c2ada8264aso1243362fac.2
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 09:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745597979; x=1746202779; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m1NRGgopWgNjPUtqP/5UsdG+AZFQQOGK+Uw5fOTdDfI=;
 b=dP8mimiZ8vQnXCCb2RKDemwxQvJGHDc/6qN/Duzh2tVWnz406kPB/qGZ5/vsnOq6JK
 fSvQDSEDk43g/BaNR0Oez8qo26C5Fo+8dFPJOIV09H7Wlwp/hpaajtBw59SipIkk7v1m
 lOcOD1EIkizpOKYAwxsU/poPqNSXRmGcJU8/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745597979; x=1746202779;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m1NRGgopWgNjPUtqP/5UsdG+AZFQQOGK+Uw5fOTdDfI=;
 b=QoI0TsSwyyvPS5z+AAp5s9i1tjWCT/22CyO/M6Ks5RpOVGgFcGVdkHTCx8UI4w+DZ+
 n5LoUB4nvSYAxjVPoKl0LcymPHYCSJfZXb+SeeTKUL13kgX0z7pS/GfzuokQ2Q6RDqVs
 GuaOU994t3pzDdAC3VixHD09xF0R3dDV1EYmqwaSGaEPBhPW/+LqhFfuTyRv5PEl7vpI
 EqEGS7KJW9SWFT9mQyPWnAmtKUqhukzjI4PT5uTgfEBV5ItwpWI1KqmEsXZde54TbXfT
 DqWbX9nBgdU1HK/LldtCUIXgR5v2BOpnJrsXcpvVVY6WmhZfsDEWZ24W736gLlGTZ8tO
 oF/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqJHryKXYtG6YD1ya8kGA5KgGd+f0s+OikCyohzVX7ukTWB7WQ2jzNgzRwoRGwFBX2TbJmsng=@lists.denx.de
X-Gm-Message-State: AOJu0YwmclknwXv7V449xY1wbo8ItrMR0VUo5lVzy4TcavbLfySzDVVB
 dtQXqlSThzup1csAyyVXfrS1N8rOvpVFqOFAoWzkSCD79ENlq/5Fy5hIRwd+Xsg=
X-Gm-Gg: ASbGncuKvFX+Sb0mZPW1nl8duLm38tWjHYMuUvknKIS9hIkKsNudqxsbxGSDvKwCsEo
 71y7D2orwrGYd10yeFEUlmu6xDILxblFL7/pRkmZDco81rIX5bKHexyls1+xq1ARDFN4K7IPuM9
 YDd4AjrzgCX50UuUC6pKm4+3ru6RlqrvoH1cKLFbkwK3i9Q80iuL47hvyCyb9ZDij1nEPbJ6QU5
 M3IZNTjxUUIgCauP91z/Cbk8etDRDFR1BEG56pI7YdbxUq3hsru05sBNLZxT91IY8Mi3JVVIjM2
 uLt0F+7dv4IeOm/L23BDQ2PGXWjJAc5PJ2KIbpI03h3eDORAIWcftMxGjqp/O9DXPSKnXebVrUW
 9tQ==
X-Google-Smtp-Source: AGHT+IF0DMw6mS997hLwiKeuh6vjakeb6bheIGjWuA3Eiq8X+IkmNQlgw01sjEvZeQnCR86wYZmfZQ==
X-Received: by 2002:a05:6870:d1c3:b0:2c2:c92a:5789 with SMTP id
 586e51a60fabf-2d99d71dad5mr1898820fac.5.1745597979328; 
 Fri, 25 Apr 2025 09:19:39 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d97365417asm915609fac.2.2025.04.25.09.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 09:19:38 -0700 (PDT)
Date: Fri, 25 Apr 2025 10:19:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Martin Schwan <M.Schwan@phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>
Subject: Re: [PATCH 1/2] bootstd: Add implementation for bootmeth rauc
Message-ID: <20250425161935.GV5495@bill-the-cat>
References: <20250129-wip-bootmeth-rauc-v1-0-6308e732f314@phytec.de>
 <20250129-wip-bootmeth-rauc-v1-1-6308e732f314@phytec.de>
 <CAFLszTinU=6v+3OyaH0pp8snYm9BgfVrU_+35x2Az7fVs_CfYw@mail.gmail.com>
 <4aef8b9ffd41d4e36550806f4688fc18dbddc500.camel@phytec.de>
 <CAFLszTjPHBw-F0EkQJnT4TOsxdYzGH5EtRBaeRCoKGxQQ_cw4g@mail.gmail.com>
 <20250424184923.GM5495@bill-the-cat>
 <CAFLszThPcJjhBVLvz=EkdeEP1K948cC=LyZhBk_Upk3iSWXCig@mail.gmail.com>
 <20250425143752.GU5495@bill-the-cat>
 <CAFLszTiYCObeLy+HPnpXSE3yQ20ZN-+hptoi_nYT4DXimjHFYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4a0xajoBB8nMn2tN"
Content-Disposition: inline
In-Reply-To: <CAFLszTiYCObeLy+HPnpXSE3yQ20ZN-+hptoi_nYT4DXimjHFYA@mail.gmail.com>
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


--4a0xajoBB8nMn2tN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 09:03:17AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 25 Apr 2025 at 08:37, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Apr 25, 2025 at 08:35:52AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 24 Apr 2025 at 12:49, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Apr 24, 2025 at 12:31:38PM -0600, Simon Glass wrote:
> > > > > Hi Martin,
> > > > >
> > > > > On Thu, 24 Apr 2025 at 06:43, Martin Schwan <M.Schwan@phytec.de> =
wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > thanks for the review and sorry for my delayed reply.
> > > > > >
> > > > > > On Mon, 2025-04-14 at 05:32 -0600, Simon Glass wrote:
> > > > > > > Hi Martin,
> > > > > > >
> > > > > > > On Wed, 29 Jan 2025 at 07:25, Martin Schwan <m.schwan@phytec.=
de>
> > > > > > > wrote:
> > > > > > > >
> > > > > > > > Add a bootmeth driver which supports booting A/B system wit=
h RAUC
> > > > > > > > as
> > > > > > > > their update client.
> > > > > > > >
> > > > > > > > Signed-off-by: Martin Schwan <m.schwan@phytec.de>
> > > > > > > > ---
> > > > > > > >  boot/Kconfig         |  11 ++
> > > > > > > >  boot/Makefile        |   1 +
> > > > > > > >  boot/bootmeth_rauc.c | 408
> > > > > > > > +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > > > > >  3 files changed, 420 insertions(+)
> > > > > > >
> > > > > > > This looks fine to me. Just some nits below.
> > > > > > >
> > > > >
> > > > > [..]
> > > > >
> > > > > > > > +
> > > > > > > > +       partitions =3D env_get("rauc_partitions");
> > > > > > > > +       if (!partitions)
> > > > > > > > +               return log_msg_ret("env", -ENOENT);
> > > > > > > > +       partitions_list =3D str_to_list(partitions);
> > > > > > > > +
> > > > > > > > +       slots =3D env_get("rauc_slots");
> > > > > > > > +       if (!slots)
> > > > > > > > +               return log_msg_ret("env", -ENOENT);
> > > > > > > > +       slots_list =3D str_to_list(slots);
> > > > > > > > +
> > > > > > > > +       boot_order =3D env_get("BOOT_ORDER");
> > > > > > >
> > > > > > > Environment variables should be in lower case.
> > > > > >
> > > > > > Unfortunately, we are bound to the naming RAUC uses for these
> > > > > > environment variables, which is upper case. See
> > > > > > https://rauc.readthedocs.io/en/latest/integration.html#set-up-u=
-boot-boot-script-for-rauc
> > > > >
> > > > > Can't you change it, since you are introducing new support here?
> > > > >
> > > > > If not, then you could perhaps set the env variables to lowercase=
 when
> > > > > you find uppercase variables? I suppose that would require updati=
ng
> > > > > the client to do the same thing too?
> > > > >
> > > > > It would be very confusing for a user to have upper-case variable=
s for
> > > > > some things.
> > > >
> > > > Simon, this is an unreasonable request. This is how RAUC has been
> > > > working and deployed for years and years. It would be a nightmare t=
rying
> > > > to handle migration of existing deployments for an aesthetic change.
> > >
> > > Yes, I figured. Perhaps it could support lower case in future? This is
> > > the first I have seen on RAUC in U-Boot, although I do see this file
> > > which has both lower and upper case:
> > >
> > > include/env/phytec/rauc.env
> >
> > I don't think there's any need to complicate RAUC support here (nor
> > in the future Mender nor swupdate nor any other long standing OTA
> > mechanism that might be more easily integrated via bootstd than
> > environment patching).
>=20
> Let's see what the author says. I assume that U-Boot has its own code
> in RAUC so it might not be too bad.

I mean, sure? But "should" is not "must" and I have zero desire to
make supporting existing use cases harder. That will make migration to
bootstd less attractive, not more. We don't want people to decide that
can't upstream platform X or feature Y because they've already developed
and deployed it using capitals or camel case in their environment.

--=20
Tom

--4a0xajoBB8nMn2tN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgLthQACgkQFHw5/5Y0
tyzzaQv/fbylfIyd7k0AuTIwd/47qFO4BpsASKFYhKkYOgBcigI9MA2uXfSGwcnx
FwLNkR4x9rZipwPh1nMcrBmlYxNM1bog3NU3yle2LxrHBejm1VDxOSMnhvlahCYF
Wie2/Eq6d6aJQ+8+JVFPx/+D3SxRKKWRlg2bq4OGfgoUzDwep3cibdelyWy116DP
8hxVWS5MJESeREBSakqTkai8/Q/Fd+Xg+TETv53Ex1Qj5et0z1e7wwT8fNpC3NuF
mNYqUsdbQD+AkfZzZUSYABfyWrVtA/xLv1qx3cC2bqtc/by7Pg36plAdLwznZEV+
pEKLVa/TGemSqF/KaoiCooaM00BhtMyLVPtiO6JKo3AwHJEpd2rUkRAIJ+64LZL1
rSPmcv5aq7fykK+vqVg0PDeZ0qk/Zhig6R/MBrG0Zp3cT+Hj6i7r5RdzbVaiUSsE
TpwscaqUwqiiHZCq6eA6X59E6jqYF0oPEul/VZ08pVEm3lRAiBaYtcPB+MZMjbX0
m9J6jeuo
=wyHg
-----END PGP SIGNATURE-----

--4a0xajoBB8nMn2tN--
