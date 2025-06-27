Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687A2C7EE31
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 13:59:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2AE082F33;
	Fri, 27 Jun 2025 15:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SAYHW/hC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B75A982F83; Fri, 27 Jun 2025 15:59:45 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E21A882E9A
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 15:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-72c16e658f4so1218948a34.1
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 06:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751032779; x=1751637579; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lmqwMm9oJrVzTQ+rWT2vqrfecMaxI/vFGNk+/4iU8vw=;
 b=SAYHW/hCcTw1wwgDFysoWjrJJ2wWD4e6d0np6M2EBksP31TXFKCFLbJjbqss9Ilato
 jd0o31lK3fuASyCoyF6/PNjeqYEauYvBvIkbbBMkjCR/F6R3HScWdnt7xMJKzCLQOmAf
 O+1HqdtnvNlBpfjKcDWgjeg1fjs2boWmkvJsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751032779; x=1751637579;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lmqwMm9oJrVzTQ+rWT2vqrfecMaxI/vFGNk+/4iU8vw=;
 b=BoSamHNgPs/sH3/Y6kVRVkAOCx28rTJsRIZ2QNhwP2zDBoYFjneAqxC7f+7lUEPh1H
 USO/CgNjfzhQJR3gg4WC4cpDFOhH04fjZeDKFU+t3QNVdy4HZcQvKeLPe69r5sRX/12h
 XXp7yZPH5/o3GyXP0IywIQQKgVUY+Tb/GIZ2iat53qiiIV/qfxJ7jpIy/z4sDFW2Jbhe
 z64qIxYIii+ZRPSHv7bhT0EOG+4kV0M1XI5Oki/7rlh1ShPZ3lwomEc0f+ZS8u07pHP5
 pIf73837Mdc81bI5VdKqxl0Ul/oFHdmLZ4ixK9SrjO2Rz2tB/eHPHp2Gyt7Z1TMusVv5
 h9fQ==
X-Gm-Message-State: AOJu0Yw6lMnBUCvPitSJ45Rfxf+dpKqU72MFOWzBAwDD9FDVy8CznUep
 TuZMFPcr5kU7cql6unaqajsM69vIxVzjygxjd2Ot1Oxs9h8UFR/DQkQNVrYSgdH7L0bUr5CdGf4
 qLpkFqPA=
X-Gm-Gg: ASbGncsEoenoGUNiprvDtrHuh3vEjHGnH5nwFXe4GHpoBFq9ggSOCmdrgI+poUVHER7
 RCIYgrcBRkpCH+SS10zjGxvih8MnR4JPY/GZklKUr1ywMttRpKw+ZDo4Yl/JfRbmmynxwOLMP1c
 aHgivJnsIfkgF/2K/lCZC9wwWgF0szqPbKZPd6QAdArFOIAhARGl/9kk5Ua4lJHWvkbVkPLrOPr
 TWkXkpUEpTZBIukPgC+PbY6ZNOqvr7faa+2m6GGKoGTlT8FaNqKxYneiNWL63PQ5msbHm9qqasP
 L6Tr8oa5kKFzzGgwKf+rBY2ywC57JQCo60OmB5HbpfWKI1smX+vGRUGk6yiPbv3f4x8/LeIALj6
 wo2qAPXvr02zhfnJlzSUjyU0=
X-Google-Smtp-Source: AGHT+IE1El66qFPmLJNssPSdzfhr0gnZtETAWEXSQjq8dX5nHOF9muPDwJYiSy3aW0OCiTxkbuLYHQ==
X-Received: by 2002:a05:6870:356:b0:29e:3c90:148b with SMTP id
 586e51a60fabf-2efed70b5a3mr2035717fac.26.1751032779552; 
 Fri, 27 Jun 2025 06:59:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb02ad29sm363657a34.29.2025.06.27.06.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 06:59:38 -0700 (PDT)
Date: Fri, 27 Jun 2025 07:59:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: u-boot@lists.denx.de, Dan =?iso-8859-1?Q?Hor=E1k?= <dan@danny.cz>,
 Peter Robinson <pbrobinson@gmail.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [RFC PATCH] tools: termios_linux.h: Fix build error on ppc64
Message-ID: <20250627135936.GE4003484@bill-the-cat>
References: <20250627135355.2731430-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DMOIoA+/oYENgtD1"
Content-Disposition: inline
In-Reply-To: <20250627135355.2731430-1-javierm@redhat.com>
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


--DMOIoA+/oYENgtD1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 03:53:37PM +0200, Javier Martinez Canillas wrote:

> Commit 93b55636b09f ("tools: kwboot: Allow any baudrate on Linux") added a
> tcgetattr() function to be used, instead of the libc's termios functions.
>=20
> This was done to allow using the raw TCGETS2/TCSETS2 ioctls that allow to
> support arbitrary baud rates.
>=20
> This breaks the build for PowerPC, because that architecture does not have
> a struct termios2 defined becuase the termios and ktermios are the same.
>=20
> On PowerPC, the termios ioctl() emulates the TCGETS2/TCSETS*2 ioctls with
> tcgetattr/tcsetattr using just the struct termios (that's as mentioned the
> same than what is defined as struct termios2 in other architectures).
>=20
> So there is no need to use the TCGETS2/TCSETS2 ioctls on that architecture
> and just TCGETS/TCSETS ioctls with termios as defined by PowerPC is enoug=
h.
>=20
> Fixes: 93b55636b09f ("tools: kwboot: Allow any baudrate on Linux")
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Until someone can test this very specific combination of things on a
ppc64le host, this is probably reasonable enough.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--DMOIoA+/oYENgtD1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmheo8QACgkQFHw5/5Y0
tyx4SQv/QGJP0ixuSk+xFR+vUiOJ9kxcwRx9XKbrClfO2IdpQgM0NwWqU8P+Zv9f
USzHMZ/BqP7Ft+pBEf1nfyOR9FIrs4iCHLA1QA0oK7FEma1Z5U6BAGC+s33fX2yR
5En/dFDB+BCNn8OdbUwIzVV4ZGvEGKcTQfVmWXuU/CW6OGjOuGop0ghu9+0uuvmO
A5nBHyTpMAMnqNawgctgMDvKqZ8Efo7kKq0AxO3RRqj2toXKJrsm9kkeSW7WJhUD
3dbUluOss813hTgbes3t9Bl/CEOCD9n4xzLCei2Q/6zSbKuaZxIbHRflkvsZd/bB
pSV2k7hdNvMAg0ND9vG8WqcTGxvRUQnofYDbchV/yaJh1hw4fFvLMiUIHCetgoGc
LJ6JlbTT3rMbibmi6eI4heBkI1gVjfzMNWpDhG9sY3PoqSQBJguadqap5g5sSzKe
HjnHZH+dubyjiA//4PpwkZatJ5eZfB0o6uMvAMHNH9tQEQNr6LHM+x2Q3j9ULXBH
1vYGPP6D
=WGFy
-----END PGP SIGNATURE-----

--DMOIoA+/oYENgtD1--
