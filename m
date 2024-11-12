Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEC5D597B6
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 23:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99180894CD;
	Wed, 13 Nov 2024 00:11:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Cinpsaru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BECA7894C0; Wed, 13 Nov 2024 00:11:28 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 685D688C0F
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 00:11:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e35e0543b07so1228617276.2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731453085; x=1732057885; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8zOqp+Zrd0jEFIOJ4/ERJzZtr9pRRoGiSvrGI6iV3Dc=;
 b=CinpsarumI00dT0CHaVbVcRunQJKqsjvPgBFQBdiWMPApvNEv2qPChJU/BlS5xSZza
 E5NFgGX5fxugIIuzuxu8Jqsg87SGVg6pPsQOmUwk687Xd4ubHr3ZWBlXgRbCtAUUyMXU
 BJYJO0RNsIxVpLvr/dW940cibC8DefUEtDP6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731453085; x=1732057885;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8zOqp+Zrd0jEFIOJ4/ERJzZtr9pRRoGiSvrGI6iV3Dc=;
 b=YiPYdvwDk+U/GgjFY/cjFxraZ865tgnu84fQO0SyzNYEHWC0QRqmU4zwv9D1XrFUOW
 mz3aVWq4GhzPltF0k2hfLCXBmKw14baHBNGvzCPw97j2MBMHwSMSNJHAUnoViLS7Ao0P
 ltbsKaKMrEYfohT1SWOHYkIzJkVnYy3SKyS7UoMp/xZMao6+buwFM+MriU37dPmKOS0P
 xDc+5zeb4HUATBF5iU045mARYsjiYxcL8khebEbZhCi7C3VfDmDG40U+sFVJNMGlYXol
 UjiNs7XSYoPY/GVdEz7c8TudC9MEU0LP55rgHMyLgwO/o7AjAXogiw5atV6H9sNv3Lpa
 yveQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPDJoxCqTlR38G82aTj9jOza7/04NDMzmZxdwR0f++o1JdUmIDdCMKSmaylmSGzr5hP0OZGZY=@lists.denx.de
X-Gm-Message-State: AOJu0YxMeT+eAibUFo+mOACEMb5pJg2YkdpIM5tEKMMZL1E69gSrazaC
 J0HnxdulR1IDFue28wRf2mim6WpMzumW2eDxHdlWBlp/efn+ZwGmrmIH3Mrv6LeRY9NfkNeTzyt
 WQrI=
X-Google-Smtp-Source: AGHT+IHXx4vljpGm7Ohr9Akc+vxfJLCeQQlcVHqtWgQR9xtZ+mzNSIUvhrrDIKf7FFK0TyXRH02l1A==
X-Received: by 2002:a05:690c:6a0b:b0:6e7:e22b:fb7a with SMTP id
 00721157ae682-6eca4666828mr49021297b3.18.1731453085269; 
 Tue, 12 Nov 2024 15:11:25 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d3966310b7sm76926596d6.112.2024.11.12.15.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 15:11:24 -0800 (PST)
Date: Tue, 12 Nov 2024 17:11:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 3/9] docker: Support building for multiple architectures
Message-ID: <20241112231121.GD3600562@bill-the-cat>
References: <20241112141105.640189-1-sjg@chromium.org>
 <20241112141105.640189-4-sjg@chromium.org>
 <5604ea68-5b31-461a-a4a2-22da37e64dac@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w+ir41qT7Y985cdP"
Content-Disposition: inline
In-Reply-To: <5604ea68-5b31-461a-a4a2-22da37e64dac@gmx.de>
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


--w+ir41qT7Y985cdP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 04:08:17PM +0100, Heinrich Schuchardt wrote:
> On 12.11.24 15:10, Simon Glass wrote:
> > Add instructions on how to build the file for multiple architectures.
> > Add a message indicating what is happening.
> >=20
> > Update the documentation as well. Drop the 'sudo' since these should not
> > be needed if Docker is correctly configured.
>=20
> Please, explain what you mean by correctly configured.
>=20
> By default Ubuntu requires sudo to execute docker.
>=20
> https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-a=
s-a-non-root-user
> teaches us:
>=20
> "The docker group grants root-level privileges to the user. For details
> on how this impacts security in your system, see Docker Daemon Attack
> Surface."
>=20
> So adding a user to the docker group may not be the best idea.
>=20
> Installing Docker in rootless mode is possible
> (https://docs.docker.com/engine/security/rootless/) but as said it is
> not necessarily the distro default.

Yes, please drop this patch as we expect to handle things in the
broadest possible way, so not assuming that the user is in the docker
group.

--=20
Tom

--w+ir41qT7Y985cdP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcz4JkACgkQFHw5/5Y0
tyyyHwv/ZS2Xw6H/yo+20EPG9LVgqBkM9OHu66vBx+gPcHtiwVRnuFSpm/FyopYF
/lmGrgIScG7MmSwKxtcGTEGEvcyTtD8PvGIfr9KC0L8itEZx05WKPqly1NxFh6ob
+gppVrhlzolQbhhPMcWubSpUnS7C/dWOO0BpKo49RlcC0smeOJKhWp8smnvXXUgj
d4VMEQed6hpC8wdYqEYOYkuaa5G3VkEK0gUXLyJlnqQvc4ZjBvENdcR1/PmMiznh
k0obnYrAVUUJLRYd7zZCEyT5HRDBragA7u5YB8wBB+Q4kusjfy31OebOuHvDBsFH
anC0XzGilkHeVVKbHLjmHFtNSylKMK8lKfb9tsR3DMuj8PD1fAfQ81GZrETJWiu6
CRjPTPwMETvZNcG6Ys/sKDBi0NVar6cShKkeNmsGeNcxTW2AGj2LDkKEfO0fUHtC
LeMygN8BvXp5pHig/UxjZryFCAi/OAOp5tQwb+geL1L+p7m2JO8PBr1BKnsSbXr8
myJOqW1B
=mmHi
-----END PGP SIGNATURE-----

--w+ir41qT7Y985cdP--
