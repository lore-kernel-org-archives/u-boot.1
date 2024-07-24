Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32718C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 14:52:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56282879AF;
	Wed, 24 Jul 2024 16:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SEb9w/g3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBC91879AF; Wed, 24 Jul 2024 16:52:09 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7B9580805
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 16:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5d569bee00aso2377557eaf.1
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721832725; x=1722437525; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=btfEtOhmhexsM61HA9O1atzXCk9Eyont1pdiFEpq8xA=;
 b=SEb9w/g3hqOyoi+/YC15WlXE2+FaoK1WwTHyxKfVFt1DAQEn5h742CjBwaggTyWNVZ
 5hF9XHGmaT1UyfPupdO0vkBAlCFnW8abRAmgz0n7zPH7Z1LVDyFo1J3H4nfls0qqS4mu
 o7Mntr4pkugVZiswuQEzdjMXMFRtya4eqVwjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721832725; x=1722437525;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=btfEtOhmhexsM61HA9O1atzXCk9Eyont1pdiFEpq8xA=;
 b=fx4rwC0M7W/k7u4QfA37Q0cRZzH8lTEfCHJn0ZdwZtbVRGMZJ1eXy4XgPkvs9r7uQd
 XzXue1qC58qOHRMuhEnThhOujnXk6R61w4hOMMAuzV+Ga7AI6BjRuvvS+zjCTgZ68FGm
 feEIyS6CQrGiaPJNc8blPasfHrioEwLlCXriKQJGLrkLpC56t1kkvmJmyDL0uNSTmp+X
 +tspCgDzJ+DW+5iamQlnsEe/mxAwQUhtHAKhB7MeJbRpRzU6ISOTsj1LoyBEed0R1Rw+
 F4Ak4j5o1VyQfw2vLQmCNg9hxnNBxw7RCc2T6SfhDcXoUmR+ygnzPtTduRG0Hj2d9sZh
 fKvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLvsOyHodBPaj4J9Zh5yn6/gD+LeqOKyUUYUGRN3uJiKhsBGFsUT7Zn0uiBp2GQc3SyNPBvQzIz45RAouH+rKJqmpAcg==
X-Gm-Message-State: AOJu0Yw8mFBqEAcFSNfMJaPNxtv4W9uR48feG89rhVw26jCGuGja9d40
 qlnr50pqjK7ROMnXjE5j64K1JrsVvT2KOtisAT4NDAod9CHi3DtRJmEwH6/e9ic=
X-Google-Smtp-Source: AGHT+IE9oPEcQxBY0IlfC8QUCaUxvBkBBLgTYo3MFXCOj0cr1rTtZYeZYuv8rSxdw8KgjRB7v/Sykw==
X-Received: by 2002:a05:6820:4b88:b0:5ce:d2e3:b18 with SMTP id
 006d021491bc7-5d5adaac07fmr75620eaf.8.1721832725231; 
 Wed, 24 Jul 2024 07:52:05 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d59ee0e77dsm345895eaf.5.2024.07.24.07.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 07:52:04 -0700 (PDT)
Date: Wed, 24 Jul 2024 08:52:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
Subject: Re: [RFC PATCH v2 38/48] lib: Kconfig: add a config symbol for
 getting lmb memory map updates
Message-ID: <20240724145201.GL989285@bill-the-cat>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-39-sughosh.ganu@linaro.org>
 <20240705195057.GP38804@bill-the-cat>
 <CAC_iWjJDwFLMaP=S=z_OMnnQb=q32QMEPoywxPWwjixMSbJ84Q@mail.gmail.com>
 <CADg8p946kVK_BfrSvEgFcvQh95MCRMBKJ+48syCnCSvrpJQ0-w@mail.gmail.com>
 <CAFLszTiYALCrgBUBJ=g_BoQtOzHGx2OhuTxCioCHdXNuJb850w@mail.gmail.com>
 <20240723142055.GG989285@bill-the-cat>
 <CAFLszTgG9WuzYp97ANm=k3iju-DH+c5A2HfgwmUznti9tQyzpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UUCdbVQLBCa3wjQg"
Content-Disposition: inline
In-Reply-To: <CAFLszTgG9WuzYp97ANm=k3iju-DH+c5A2HfgwmUznti9tQyzpw@mail.gmail.com>
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


--UUCdbVQLBCa3wjQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 08:37:14AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 23 Jul 2024 at 08:20, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Jul 23, 2024 at 01:42:59PM +0100, Simon Glass wrote:
> > > Hi Sughosh,
> > >
> > > On Mon, 22 Jul 2024 at 13:59, Sughosh Ganu <sughosh.ganu@linaro.org> =
wrote:
> > > >
> > > > On Mon, 22 Jul 2024 at 18:00, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > On Fri, 5 Jul 2024 at 22:51, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Jul 04, 2024 at 01:05:34PM +0530, Sughosh Ganu wrote:
> > > > > >
> > > > > > > Add a Kconfig symbol to enable getting updates on any memory =
map
> > > > > > > changes that might be done by the LMB module. This notificati=
on
> > > > > > > mechanism can then be used to have a synchronous view of allo=
cated and
> > > > > > > free memory.
> > > > > > >
> > > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > > ---
> > > > > > > Changes since V1:
> > > > > > > * Change the description to highlight only LMB notifications.
> > > > > > > * Add a separate line for dependencies.
> > > > > > >
> > > > > > >  lib/Kconfig | 10 ++++++++++
> > > > > > >  1 file changed, 10 insertions(+)
> > > > > > >
> > > > > > > diff --git a/lib/Kconfig b/lib/Kconfig
> > > > > > > index 7eea517b3b..b422183a0f 100644
> > > > > > > --- a/lib/Kconfig
> > > > > > > +++ b/lib/Kconfig
> > > > > > > @@ -74,6 +74,16 @@ config HAVE_PRIVATE_LIBGCC
> > > > > > >  config LIB_UUID
> > > > > > >       bool
> > > > > > >
> > > > > > > +config MEM_MAP_UPDATE_NOTIFY
> > > > > > > +     bool "Get notified of any changes to the LMB memory map"
> > > > > > > +     depends on EVENT && LMB && EFI_LOADER
> > > > > > > +     default y
> > > > > > > +     help
> > > > > > > +       Enable this option to get notification on any changes=
 to the
> > > > > > > +       memory that is allocated or freed by the LMB module. =
This will
> > > > > > > +       allow different modules that allocate memory or maint=
ain a memory
> > > > > > > +       map to have a synchronous view of available and alloc=
ated memory.
> > > > > >
> > > > > > This needs to be select'd when it's going to be used, opting ou=
t of
> > > > > > making sure memory reservations are obeyed isn't a good idea.
> > > > >
> > > > > +1 which begs the question, do we need the config option at all ?
> > > >
> > > > The config symbol can be used for removing the code for platforms
> > > > which do not support EFI ?
> > >
> > > I am still of the so-far firm opinion that this can be done once,
> > > before booting, rather than maintaining two separate tables as we go.
> >
> > Did you see the part in the thread where he explained the multiple entry
> > points that would need to be kept in sync?
>=20
> Yes, but I'm not sure what they are, nor why a shared function cannot
> be called twice from two different places.

Because we don't want to miss the third or fourth entry point down the
road. That's why going the other direction makes more sense I believe,
we won't have a future problem here because we designed with that in
mind.

--=20
Tom

--UUCdbVQLBCa3wjQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmahFQ4ACgkQFHw5/5Y0
tyzhfAv+MPH7JYJmm/22uwVo4Cx2CI8X4c02gY3rnxNRUhmVhFErI0V8mKpVJOSB
E71doxkXJCihZlO7OVNqR2lSGZWuOWnOQQ2gLFzR5rKG+Bn3Uny2iU6/9HdD2m2t
hrbfGV6mHRHoVVlBqVw5xVQVHCS9uxmJOlXYq0voL3ocr4Hpzu1Hw/RFzz6dooq0
V1JS74/lSsfCzTPbdpqQaPLzGLY292GHON2vI/iwggVgijiW7jEeF1YOWZMi7OKm
xmC1trURULBwALwDZkZMJWFQYBO7fC05CxuYFAhAepfckktYpZ3xqYqKW4NZuunw
jySC+ee0DlYsGSXPrak4iVggaMQbZIBxLk8ubd7mf8qDdiznPNc+S2QOL4IRDumE
ktJFv3XHrFc4oUc2NDJkvs86CpcseA2w1sRi+ULFourpSJlU5iHIASoav2PbTqf9
1RMLw0PE0qb7/uXVHMiCFcVXhWiEV8BctrPgn/+J2IzlkLzTSLt/i3136XA2Cbt/
/kZI7cNy
=8hp1
-----END PGP SIGNATURE-----

--UUCdbVQLBCa3wjQg--
