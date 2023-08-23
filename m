Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8497FEE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 15:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC6E386452;
	Wed, 23 Aug 2023 17:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FnciE+b4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2C4F86459; Wed, 23 Aug 2023 17:17:14 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E805786446
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 17:17:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-59209b12c50so39236437b3.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 08:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692803831; x=1693408631;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KfKsougHOqecnVis+lD2iG4+PcAvAg8NI0vzZdRxJWk=;
 b=FnciE+b4OTpaKbQqB4MaKkNz6v2mL6xVpz0AeVwR+pRajrhjuZbpjsqLUw9IOCYOnP
 YeE6Ak92QaffDAzNJirEXydR+WIogN4XI4M0kh+znpZmWuq3iBLS/v7tcmDEWj242jc0
 PVPY7f38QTdwHZdLy2HD9E+e+SjvSfp0XeDuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692803831; x=1693408631;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KfKsougHOqecnVis+lD2iG4+PcAvAg8NI0vzZdRxJWk=;
 b=ElRRpGSDXOk+2Lr0IfdvivGCJPbjbPDlRbcLv8cWvsLQ+x7NCqHCEdp8Dq+RZu67vf
 Y1c05MNya1xLJ5zrMqUdRJzswSNojrBcuHG4rTakSxZoO380lenKfdToQo6Py4F3hXdw
 p/Lx3uuSZ7ZcWirX5BuSNp42BoKpLHp3sUAt6lTwXKupZ+6Q/Ul9xmXnDt/d9KU5qJE8
 OpiITB6q5b3JePyfJQBiOUj6yR55GSkJGxCNdyvTw0iefB1QZLTB4syuEyet0b5xfpkz
 mswg+N/TOb6/efTkaq0khUOvH6CamZEUPf9kCuUkrlSSrr2Ux3j0wW3PzAOq8KmcKLBC
 W5XQ==
X-Gm-Message-State: AOJu0YyJtdbDIKe2s4NzevCEMQ25A/WD0TiQoEP0c57JVaXNwO71lNIQ
 bjyhPgHAZbBAbd9dnNbH5tOmVQ==
X-Google-Smtp-Source: AGHT+IFFSH8mjLkG452xyLWtb2Su1CQ+SHz8K/BM3WJtH7rKej/SfVVHkMuLiY/r7VmhPAQTmTKmLg==
X-Received: by 2002:a25:838d:0:b0:d5d:62b7:7e74 with SMTP id
 t13-20020a25838d000000b00d5d62b77e74mr12279551ybk.40.1692803831594; 
 Wed, 23 Aug 2023 08:17:11 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 10-20020a25030a000000b00c5ec980da48sm2880382ybd.9.2023.08.23.08.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 08:17:11 -0700 (PDT)
Date: Wed, 23 Aug 2023 11:17:09 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Bryan <bb@ti.com>,
 Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH V4 1/8] env_default: Allow CONFIG_EXTRA_ENV_TEXT to
 override CFG_EXTRA_ENV_SETTINGS
Message-ID: <20230823151709.GL3953269@bill-the-cat>
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-2-nm@ti.com>
 <20230823144253.GF3953269@bill-the-cat>
 <20230823150658.tjfr7svhuhmbx5wt@vertical>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CFy5aKhvI4ag10+v"
Content-Disposition: inline
In-Reply-To: <20230823150658.tjfr7svhuhmbx5wt@vertical>
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


--CFy5aKhvI4ag10+v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:06:58AM -0500, Nishanth Menon wrote:
> On 10:42-20230823, Tom Rini wrote:
> [...]
>=20
> > > diff --git a/include/env_default.h b/include/env_default.h
> > > index b16c22d5a28c..714dfa9e845e 100644
> > > --- a/include/env_default.h
> > > +++ b/include/env_default.h
> > > @@ -112,12 +112,12 @@ const char default_environment[] =3D {
> > >  #ifdef CONFIG_MTDPARTS_DEFAULT
> > >  	"mtdparts=3D"	CONFIG_MTDPARTS_DEFAULT		"\0"
> > >  #endif
> > > +#ifdef	CFG_EXTRA_ENV_SETTINGS
> > > +	CFG_EXTRA_ENV_SETTINGS
> > > +#endif
> > >  #ifdef CONFIG_EXTRA_ENV_TEXT
> > >  	/* This is created in the Makefile */
> > >  	CONFIG_EXTRA_ENV_TEXT
> > > -#endif
> > > -#ifdef	CFG_EXTRA_ENV_SETTINGS
> > > -	CFG_EXTRA_ENV_SETTINGS
> > >  #endif
> > >  	"\0"
> > >  #else /* CONFIG_USE_DEFAULT_ENV_FILE */
> >=20
> > The problem is that I believe we intend for CFG_EXTRA_ENV_SETTINGS to be
> > where we can override things in a more final manner.
>=20
> I am confused - if the intent is to move to text env, it should have
> priority over the extra_env settings.

If you have a text environment you really shouldn't have anything
defined.  But that restriction meant that almost nothing could be
migrated (since we didn't have the boostd stuff far enough along), so I
made it so we would at least end up merging the two.

--=20
Tom

--CFy5aKhvI4ag10+v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmIvUACgkQFHw5/5Y0
tyyYKwv6As1hhg+giJqT2Xxj/xaRYoTFyWiBGbEBF1OtWz2+5LAPlOWnGjfb7MGH
sisWHgAkV2FVYF8NxwrJKhy5x5PLtZUtg7uHXHyBeN98l89AKaESfmLy/0xlOB3i
9UPNiG3rIJtu2GnI6UQv+mL25OolEiokufZeF4Q6/qRufjsIv1Z/eg3DWpkmEiqY
Ug3Fer+VTrf+YRG8NPVgy2DVv6PpOg/RqzE5p0y0T9woZCo+xsBtaEsxU2d0i06+
sU9ctLEhZnJCG86Kdo9KXlZBtCrKOSaRDNBrfRbaQN75H00e+HKAOnoPx+DO+/qL
EEnka55OXLWibgUBcMWgpC+Q4hmAdbOB+yMmGCh3X9lVvXC2QxwwowLyQbjQJM1y
COhUhuaahinwQ5/8FJhYT/QbzXfhlCD1MJFUUJwAW5lttVIAvyeqABtWGxhJ4SRm
zyNoN4x5N5ay2Tk1WAfRdS1Q0rsKhmg3hT7yLJ9hSx6bmqJ2cRcUqFw/CoS8Vob2
sMXJyvZE
=hGO3
-----END PGP SIGNATURE-----

--CFy5aKhvI4ag10+v--
