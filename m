Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337BDC02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 17:07:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A734580BAA;
	Thu,  6 Feb 2025 18:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pwU7I3vk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB88580BAB; Thu,  6 Feb 2025 18:07:33 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3610480A55
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 18:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21f4500a5c3so12421345ad.3
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 09:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738861650; x=1739466450; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SdKDKMkLqvaSx5mQ02MMYMEUfuJdZllaLAW3eUvRbiE=;
 b=pwU7I3vkUtBrbYHeUQWOd0vXitSoDvobY0JyFe/KroRlxYFu8mSF6+exsRb5bmso1F
 Fk5JhXUK/tVXS7BkV11GSnsdvPh+HY9aMDEkl7kOyfU2FaDX/u0dsCFcqKFSqemnMu3/
 MV+19acLxSnB+iVIaeUzd41n0HSe9gOCD3hao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738861650; x=1739466450;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SdKDKMkLqvaSx5mQ02MMYMEUfuJdZllaLAW3eUvRbiE=;
 b=jjUGkikDmPjzjHTzyxTyoY74LgEAhiVW+9GTaWlm67IbqUtn/kMskF4Zb4qQwQUSdZ
 sKu2UOWhZgIpXyghvXq0q6TzVvohRQBGNSr+77sL9Ewl351ROHKBUJuJ2e7C/64k6QHa
 y6cb8LnH9gnsEWDl9T5QSWr+zLpVUxmQucx2+2bi8B9VgEtZJTcA9cPUClrKjxIGEe1g
 mTjoRc20gGE9Lt+hLTYzuCzm+RXuTA4UKDgcuaq4mIR6z2T2w+PYeghpHAq9AxkshzkR
 scEs51VLvs6qgU+JtLuvSej2aESPSElf+Skpzawa+5K8Pd7xdZHhRlfha9/b98mFnd7H
 J+Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH7SxZIPyH4uO82WNAzqsPNWckvLcqrbFxXl8Wix6bAUNsdaYsuh34vgSwws2AZmjnFW0DxBA=@lists.denx.de
X-Gm-Message-State: AOJu0Yyf+DK6PEOvi+tWQ5paeawKV0e9APeUG2+Hti9xMJTj1qXd6sBz
 C2/uJoS430VoKJK473T6KH0hU0IUW135nwSEHmWpqfAkQFPx/W33ug9xMvf/SuQ=
X-Gm-Gg: ASbGncvxlgcvmIil+LcWbM+8qWqoLHU1OB8xrF5RqJtfP7r6RyOeaaMlITBb+7jkB2l
 rQsuM7R+NYhzb1L2SiCAtMvABSOre35k8+dwfQEmoJTlQIb20LTs+f8cEqMbYimaAelDgXHnYxG
 KfXGjADwyU/ZvEhZG44CLQrqjVypnlo8deC00MqRol9Pa5mv1HoqY2KwkX8tmX2mR9lMe1FlM4q
 GiWlvQk2xKp+2367z/AckpeIolvUJigoxbL+CZ4PXDqa4qXrpmLv3AqmLetLMQtJpOdkZcS3spq
 YrzI7RqoxKQRDIQ=
X-Google-Smtp-Source: AGHT+IFq/p40oSRGCePVhN49eyiQghzzmoFnZt5N+LwCONJKCkB1FjgamdVmwsfcmhQk6z+5OdbWHQ==
X-Received: by 2002:a05:6a00:3a19:b0:71e:13ac:d835 with SMTP id
 d2e1a72fcca58-730351393eamr11571610b3a.11.1738861649609; 
 Thu, 06 Feb 2025 09:07:29 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048a9d4b4sm1596901b3a.19.2025.02.06.09.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 09:07:29 -0800 (PST)
Date: Thu, 6 Feb 2025 11:07:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: w.egorov@phytec.de, ggiordano@phytec.com, joe.hershberger@ni.com,
 u-boot@lists.denx.de, nm@ti.com, d-gole@ti.com, n-francis@ti.com,
 nmorrisson@phytec.com, m.otto@phytec.de, bb@ti.com,
 upstream@lists.phytec.de
Subject: Re: [PATCH 00/10] phyCORE-AM62x/AM64x: Add RAUC and Secure Boot
Message-ID: <20250206170725.GF1233568@bill-the-cat>
References: <20250205080146.1944928-1-d.schultz@phytec.de>
 <20250205145136.GU1233568@bill-the-cat>
 <4f5235ac-c85d-4183-94c1-17650ccad9c1@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XBV+g9JmvMI9zO4g"
Content-Disposition: inline
In-Reply-To: <4f5235ac-c85d-4183-94c1-17650ccad9c1@phytec.de>
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


--XBV+g9JmvMI9zO4g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 11:41:14AM +0100, Daniel Schultz wrote:
> Hi,
>=20
> On 05.02.25 15:51, Tom Rini wrote:
> > On Wed, Feb 05, 2025 at 12:01:36AM -0800, Daniel Schultz wrote:
> >=20
> > > This patch series adds support to boot PHYTEC's reference distros for
> > > RAUC and Secure Boot.
> > >=20
> > > It adds a new Kconfig entry to embed the RAUC boot logic into the K3 =
MMC
> > > boot logic. The boot flow itself got extended to run the raucinit fun=
ction.
> > >=20
> > > It also adds Kconfig entries to pass private keys from an external lo=
cation
> > > to U-Boot to sign bootloader images. An additional config entries all=
ows to
> > > enable FIT image, because our Secure Boot implementation uses fitimag=
es
> > > instead of normal images.
> > First, does CI pass with this series? Second, is this also based on the
> > RAUC support to bootstd series? Thanks.
>=20
> I just ran the CI tests and they pass:
> https://github.com/u-boot/u-boot/pull/739

Thanks. I was concerned that with keys and such we might run in to a
failure to build in CI.

> This is what we have for quite some time to boot RAUC or Secure Boot with
> our downstream U-Boot. It's not really nice but working... Martin started=
 to
> work on bootstd implementation after we implemented that. Our plan is get
> the current boot flow upstream and switch completely to bootstd later this
> year. Afterwards, we would mark the current boot flow as legacy.

How challenging for your plans would it be to not upstream the legacy
path here and just build on the bootstd method entirely? I can certainly
see why you need to support the legacy model commercially but if we can
avoid adding it and intending to replace it in the community that would
make a lower burden here long term. Thanks!

--=20
Tom

--XBV+g9JmvMI9zO4g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmek7EkACgkQFHw5/5Y0
tyz5oAv9ECr3TdvwPTZGppzE5H5ie6j32SjPBSinNY+eB1i6UnmT6qFghmrLNV6K
b/smXlWp/CBWXC5kH6gd5IK6x/xQ8DsTsvVjn9gWXu8+l3WKdPXpazvs4uTUWOHE
Rpc1y46VKxMfe2++fayzicfClkqrGr0cROWy/OWjbQfEyuhRuz1Xh4B60TTqfM0G
dLvoJXc6A0QUgpbApzke8eENC8cVbapY/qGsADFycEGqn6aZTB6L0/NAjMEkLksw
kj2lC3Ig8JeQO6Y/jvtnbuqXaJeDo3mzEfKWTmOTRLHy/lVPNPvYAbyNmNgAWwWD
eWj5hOEb06ZkGEAitjThueVdtWAvsdDBNFFxuCizEBk8vZj7NrMAFJ34uQxqf3M4
FNrfe6l7vaB4QH846qw8BDOk87WxmGe0RXJCQIxhUmxXmh7xacHOh5XP2U4ZRGYO
6gWMQZuzFCFPW3AkkbOLNwspHokFTDpppBLXONKElI6NukEuKWIZIb3C4oQf7euU
lz/8SX4N
=p2LQ
-----END PGP SIGNATURE-----

--XBV+g9JmvMI9zO4g--
