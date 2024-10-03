Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD069CF34B0
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 14:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CE4688DB8;
	Thu,  3 Oct 2024 16:39:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QvC/DPeS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6536D88DB8; Thu,  3 Oct 2024 16:39:46 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5973888B2
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 16:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7a99e8d5df1so106904885a.2
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 07:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727966383; x=1728571183; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vueclIcO804lRIh5Xr1Z40NG/LOjoRQGIJe4B+0i8zc=;
 b=QvC/DPeSvhpEAk+65dn38wZiZT/dq9RCL+nSpsscKcOWhTMi5Rf+J928jcZUCO0wsQ
 jjg83aTGXEJ2zAduX9ZsNE2ytK3eeVm5zHmMQ3ia/auW4BN6lkr/JnP337ccyruA12wq
 EDrBaRby2ZZ5srhB+0+HcSKeui2ASFyLMJhjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727966383; x=1728571183;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vueclIcO804lRIh5Xr1Z40NG/LOjoRQGIJe4B+0i8zc=;
 b=ZHlcU4c4vYAGDWeHM/ewtadd2qS25+9+iW7ichtCJLgMsskKPJZxh33Kf/HrlxOC4f
 36DZyG7cyTml8k/Nmdklul57RpCi1VtdteDkeurDMa2YLzTE0JtLPf1v1j/rfdpKw3u0
 7nOBmc+4d0WYmlW264E/LS9aJUnyt4sISIB3XdkxN98IKFcEt+3nITNGNHIPgjExplgi
 1O828UDLq4t7fK1slKftDjSjRMU1xote+LvhmYXmKKsjOitA6y092CKUUj7FFAcRp4MJ
 hMbexO8npiwcfrnrTphDxkHRQlBt6vgEbNqIW7jjDKTzRhlKmZbwp/tWkxkH8XsIA68P
 DAjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUYiEtoa6OzzB4uNejilYoYQg7fbiDKsV7oB7iwg01unj3n0FZL0/wn4H2enxmiVc8lGfqATA=@lists.denx.de
X-Gm-Message-State: AOJu0YyDc33EFtfmmZQuQNKt+2/9gHR83olC+uGIVlN/IV+8mvXwiokn
 ZtYZFgshYUunfWUpQ2GdGhE3nELxs30RKmALa3dvuUiumNKHnt27o7Y8S9Bm4zY=
X-Google-Smtp-Source: AGHT+IGe4RZ/e4uzIGKiOukrO9o8mtgYMlLe0mW6Umk0VfC6yzY+za0ar5xkCQFURZvTvEpzt6RuHw==
X-Received: by 2002:a05:620a:460f:b0:7a9:d0ec:2d8f with SMTP id
 af79cd13be357-7ae626c298emr1133694985a.24.1727966382685; 
 Thu, 03 Oct 2024 07:39:42 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae6b3d4261sm55522885a.96.2024.10.03.07.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 07:39:41 -0700 (PDT)
Date: Thu, 3 Oct 2024 08:39:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Martyn Welch <martyn.welch@collabora.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/4] boot: pxe_utils: Add fallback support
Message-ID: <20241003143939.GT4737@bill-the-cat>
References: <20241002132633.246942-1-martyn.welch@collabora.com>
 <20241002191638.GQ4737@bill-the-cat>
 <1024259d3b2e3ed5d6828c12bac32630e2361c04.camel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lN6VxpDtH92vIgKZ"
Content-Disposition: inline
In-Reply-To: <1024259d3b2e3ed5d6828c12bac32630e2361c04.camel@collabora.com>
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


--lN6VxpDtH92vIgKZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2024 at 10:00:33AM +0100, Martyn Welch wrote:
> On Wed, 2024-10-02 at 13:16 -0600, Tom Rini wrote:
> > On Wed, Oct 02, 2024 at 02:26:30PM +0100, Martyn Welch wrote:
> > > When configured correctly, we can detect when boot fails after the
> > > boot
> > > process has been handed over to the kernel through the use of U-
> > > Boot's
> > > bootcount support. In some instances, such as when we are
> > > performing
> > > atomic updates via a system such as OSTree, it is desirable to
> > > provide a
> > > fallback option so that we can return to a previous (hopefully
> > > working)
> > > state.
> > >=20
> > > Add a "fallback" option to the supported extlinux configuration
> > > options
> > > that points to a label like "default" so that we can utilise this
> > > in
> > > later commits.
> > >=20
> > > Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> >=20
> > Is "fallback" part of the nominal extlinux specification?
> >=20
>=20
> When looking at options to implement this functionality, I did spend
> some time looking for an extlinux specification. The best I could find
> was:
>=20
> https://wiki.syslinux.org/wiki/index.php
>=20
> Putting aside the difference in syntax from that used by the syslinux
> project, of the 22 keywords currently supported by U-Boot, only 13 of
> them are mentioned there (surprisingly the syslinux documentation
> doesn't include "title" as an option).
>=20
> I'd come to the conclusion that U-Boot already provides a greatly
> extended version of the syntax, made suitable for booting in a wider
> variety of instances than catered for by the syslinux project.
>=20
> Though I admit, I could have missed another better source to
> documentation. Is that the one you're thinking of or is there a better
> one?

I was thinking of https://systemd.io/BOOT_LOADER_SPECIFICATION/ which is
now https://uapi-group.org/specifications/specs/boot_loader_specification/
and only has 11 keywords. So, yeah, I guess this is another place where
we'll keep doing what's needed to make things more useful and see what
happens down the road. I'm fine with what's being added in this series.
Thanks!

--=20
Tom

--lN6VxpDtH92vIgKZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb+rKQACgkQFHw5/5Y0
tyzFDwwArQILzDS7F0UQXRLwMdskchkvIPW5jS28PoIARXac26FWRk22N6pTrWSL
ltNaBuapwmaQNhRjnqD1XHz/ZLpEyOod/rTV9Avz7EcD//OoVVFGhIgrSU/9MoWD
wHICgbFZdd+oluFWenEayLkXV5xgbkzJ7dXXTAvGw+sg9TqayTw9vgcMDyXfBUXG
eHeHrRurMWm20tJ8sZ/jBUDYu5GTksRwJMZpvq72YD/8/eicp+v88OElWHVsgaUO
H+JkqKiDE9f9OFG+rh2uVeCy7j9a9LhAFD5NZOvjjauo85csdmDIHRjCHZLN0mK7
N1I1xEe7B9zzo1oet8iXzDgA8TuDQq6Pl9dgv4XXzwGjYWg4PgOVS9SIJIN510bi
Wj4EAfYW2+qczBl2iV2FpT4MwmP9lHAkEjSDjCikJGR2thHZYxioxWD/m0M2F8ye
YblrTCxYmOl24K8hACwn8tSiy+mB9yPWHbAr/DxIQiwPKLx9Tnwvp2SqpVb22oyH
7HikLt4c
=dsA3
-----END PGP SIGNATURE-----

--lN6VxpDtH92vIgKZ--
