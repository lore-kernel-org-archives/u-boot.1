Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42782C41535
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 21:04:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE7B2874FB;
	Thu,  9 Nov 2023 22:04:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bHrwrg0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F2A487504; Thu,  9 Nov 2023 22:04:47 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C2518749B
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 22:04:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7789a4c01easo84389585a.0
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 13:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699563883; x=1700168683; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7BVeYz10ddKEpr7z8dCwbsSQ9stbkR1LFspVF3PxAAo=;
 b=bHrwrg0jybF5UQgR6lRQvtD8AitfHym78Tggxxnt7sq4Wk8LAKu6HdTDg1rA6o8jZA
 04MBsI+ExS0hW3JnDi/iOyhDURk43mvOWRhVGUjNwSQ+9TVV5ow+eSY7w+89VdZ29CKV
 W80wKXkUCmy1vWxKOAX7lMAmF7dSQV3dxwxjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699563883; x=1700168683;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7BVeYz10ddKEpr7z8dCwbsSQ9stbkR1LFspVF3PxAAo=;
 b=CP/vw+cYU6aMcMZK6xuLVIc54gG3mGxHmHu4nYXnIMQc8zfYym0K6eNOZ9pPj51Cic
 S+0jPJvbPcDR+v7yRMj0wxrhVC1xhUI0lp/bkj20XE1P7C4l9UlbHD/3ChBL5sZsQuzt
 7TM8GYqqsI/uYZYvX+pkPJCHxQPaogVBfH9lYlcaxEnztvmRcRj3f7i8OOTY0sVLOZNy
 ubAym0DV0/9BqYshVyd3huWCWOHNs1dfjYvIcrGiSLaPcylFXFunqq+XZ+DwlexY6Hln
 7XW8eXHVorK+dMeznpU0iVppBsfGYolkbbphhVe4DLq3Fpwjyl9XMnKjM467mPk//lk5
 57eg==
X-Gm-Message-State: AOJu0Ywkkz6pEs5cD92VcmTmFnD7xcJrw6iMz0BZAufOLlBUNMDzo+mj
 xHWKGhiKh9VDyGEHh1AGJmUvIQ==
X-Google-Smtp-Source: AGHT+IHWIuXr5InrVcTv3yeFLHKWTc/Pia/q04ODRoEr8fEOuCgbCSF7SOCa63XCJJ3SJ9s9cSyqcQ==
X-Received: by 2002:a05:620a:2915:b0:775:9e64:f5be with SMTP id
 m21-20020a05620a291500b007759e64f5bemr6674264qkp.55.1699563883308; 
 Thu, 09 Nov 2023 13:04:43 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-58a3-ea36-c2a1-60cb.res6.spectrum.com.
 [2603:6081:7b00:6400:58a3:ea36:c2a1:60cb])
 by smtp.gmail.com with ESMTPSA id
 x20-20020a05620a0b5400b00767da9b6ae9sm199562qkg.11.2023.11.09.13.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 13:04:42 -0800 (PST)
Date: Thu, 9 Nov 2023 16:04:40 -0500
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Sean Edmond <seanedmond@linux.microsoft.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, joe.hershberger@ni.com,
 rfried.dev@gmail.com, sjg@chromium.org, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/3] net: Get pxe config file from dhcp option 209
Message-ID: <20231109210440.GJ6601@bill-the-cat>
References: <20231024002159.74477-1-seanedmond@linux.microsoft.com>
 <20231024002159.74477-2-seanedmond@linux.microsoft.com>
 <9a42da8f-2d82-4470-82bd-ef872e72810a@gmx.de>
 <2ed00b42-66f9-4cca-a1a0-ee594840f0d1@linux.microsoft.com>
 <30e83c4b-32be-4e85-aee8-e8b87224a487@gmx.de>
 <b058f5a6-52e2-4e0c-a193-30e884b2463a@linux.microsoft.com>
 <20231108002342.GE6601@bill-the-cat>
 <CALeDE9NBpwUXcuURx-JKsRNS4C+6OBTz8Nfi76kRY_3ZSays7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F858K8ggf+w+NPqN"
Content-Disposition: inline
In-Reply-To: <CALeDE9NBpwUXcuURx-JKsRNS4C+6OBTz8Nfi76kRY_3ZSays7g@mail.gmail.com>
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


--F858K8ggf+w+NPqN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 12:24:24PM +0000, Peter Robinson wrote:
> > > > > > > Allow dhcp server pass pxe config file full path by using opt=
ion 209
> > > > > > >
> > > > > > > Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> > > > > > > ---
> > > > > > >   cmd/Kconfig |  4 ++++
> > > > > > >   cmd/pxe.c   | 10 ++++++++++
> > > > > > >   net/bootp.c | 21 +++++++++++++++++++++
> > > > > > >   3 files changed, 35 insertions(+)
> > > > > > >
> > > > > > > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > > > > > > index 5bc0a92d57..adbb1a6187 100644
> > > > > > > --- a/cmd/Kconfig
> > > > > > > +++ b/cmd/Kconfig
> > > > > > > @@ -1826,6 +1826,10 @@ config BOOTP_PXE_CLIENTARCH
> > > > > > >       default 0x15 if ARM
> > > > > > >       default 0x0 if X86
> > > > > > >
> > > > > > > +config BOOTP_PXE_DHCP_OPTION
> > > > > > > +    bool "Request & store 'pxe_configfile' from BOOTP/DHCP s=
erver"
> > > > > > > +    depends on BOOTP_PXE
> > > > > >
> > > > > > Why should this be disabled by default?
> > > > > >
> > > > > > Do we really want a separate config variable?
> > > > > >
> > > > > I expect most won't use this option to get the file path (they'll=
 use
> > > > > the default paths as per the PXE specification).  It makes more s=
ense
> > > > > for me to keep it optional, like many of the other options?
> > > >
> > > > RFC 5701 seems to require this option. Hence we should make it defa=
ult
> > > > yes. Boards that have a build size issue can opt out.
> > >
> > > The PXELINUX specification
> > > (https://wiki.syslinux.org/wiki/index.php?title=3DPXELINUX) doesn't s=
tate that
> > > option 209 is required. In the abense of option 209, PXELINUX will tr=
y the
> > > following default configuration files (this example is provided on th=
e wiki
> > > link):
> > >  /mybootdir/pxelinux.cfg/b8945908-d6a6-41a9-611d-74a6ab80b83d
> > >  /mybootdir/pxelinux.cfg/01-88-99-aa-bb-cc-dd
> > >  /mybootdir/pxelinux.cfg/C0A8025B
> > >  /mybootdir/pxelinux.cfg/C0A8025
> > >  /mybootdir/pxelinux.cfg/C0A802
> > >  /mybootdir/pxelinux.cfg/C0A80
> > >  /mybootdir/pxelinux.cfg/C0A8
> > >  /mybootdir/pxelinux.cfg/C0A
> > >  /mybootdir/pxelinux.cfg/C0
> > >  /mybootdir/pxelinux.cfg/C
> > >  /mybootdir/pxelinux.cfg/default
> > >
> > > If 209 is requested/provided it tries the provided "config file" befo=
re the
> > > default paths.  RFC 5071 should be seen as an extension for PXELINUX =
(not a
> > > requirement).  RFC 5071 only states "The Config File Option MUST be s=
upplied
> > > by the DHCP server if it appears on the Parameter Request List".
> >
> > We also want to be careful about overall size growth on common options,
> > even if someone can opt-out. Those are usually last-ditch stop-gaps and
> > it's better to make sure we really need functionality X/Y/Z by default,
> > for everyone. Especially with all of the work going on to make HTTP(s)
> > based network installs a viable option, how much more do we want to
> > change the PXE case, for everyone. I'm personally somewhat looking for
> > the use case to be well defined for a "this must be default". Network
> > provisioning is a thing, yes, but for whom/what, and in turn how broadly
> > do we need this to be in the vast majority of our boards (since it would
> > come in via BOOT*DEFAULTS or DISTRO_DEFAULTS).
>=20
> If PXE is being enabled I think it's useful in that it means the PXE
> client can be largely stateless because it can all be provided by
> central netowork configs as opposed to either hard wiring it into
> firmware or someone having to manually set them. This is likely also
> useful from the PoV less reasons to have a shell if it can be dealt
> with in code.
>=20
> From the PoV of defaults, with or without HTTP boot, I suspect it
> probably makes sense to review whether PXE as a whole is enabled by
> default. That said a number of silicon vendors are actually actively
> removing PXE from their reference FW in favour of HTTP Boot due to
> security and a number of other reasons (easier for firewalls,
> caching/CDN, edge use cases outside of the data centre).

I guess I don't understand how frequent a use case PXE boot is, on the
types of platforms U-Boot is usually found on. Clearly, some people and
usecases use it. But I also think part of why it's default enabled
within the "distro" frameworks is because initially we didn't have
"parse extlinux.conf" entirely split from "do pxeboot" as the conf file
parsing started there. I guess just something to evaluate down the road,
and perhaps make it a regular thing to evaluate defaults and provide
some notice when we might disable features.

--=20
Tom

--F858K8ggf+w+NPqN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVNSWUACgkQFHw5/5Y0
tyyPRQwAtkHG1N1Mf+LLpHQaN+BJIeG8RAv8O2BzrXb725WvvHYk0KirwznypeMC
A/0TVwC138jZGTcyem2Bq9LJHmryYdTj2tah3NKkW0abd7WHitBkKKYNeNe4FLc+
XgaUXQbBLb1yp7cZkG1XDzpXIkjHUBh7JxTMSR1/z9MQybXgiEhd/uOte5BLSkA1
soKYCiCumIg0R6Mep+MYJXLOPauhW0XPYkqM1q+L2NDbYjFs5G9zqa3A9yV97r5Z
c57gfspmzDw2HYhdTiICAvlAmCOqAi7AngfMRi3vx28oqx5n1Qq601C5Z02RLLq/
fIsHpYWKEjoi/6dwK7BLziQ3dbQ/Vkduzt+aH9dyKxvtp1X+bEP9mZjX3etikgmr
rksybTfBLjCYBEzSQVMQh+wntWPLwSrxyIVbyMtr+vvbbBBBwKoKXSpE6fPvDJYx
S9meLJNyw35Z0pK/c5ijTV9aiUErdH3GfolzCY1RrNL7H/sPPHj8TCrGgftxI9Rg
TXEhS+MH
=f9ph
-----END PGP SIGNATURE-----

--F858K8ggf+w+NPqN--
