Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BB7C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 13:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 098F287077;
	Sat,  4 Nov 2023 14:57:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V/Fh0Czn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 091018703A; Sat,  4 Nov 2023 14:57:11 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7811687049
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 14:57:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-41e58a33ec9so17744481cf.1
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 06:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699106223; x=1699711023; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6Eqlm2SwJhbGwzuRwfCsTr4NHmqO2ILtI9ofBA4aqBU=;
 b=V/Fh0CznI75DiT4C7/xIYH+sBt8cQ008KwwXh4FcaAO0z87ygnjZTVNlErcqnnzwMX
 a/HsL7rWygdbaMsvwvVflxYCCAxpotnMRxasDKwoC02iafPuVaCwa5TFINwUd9P/ijXf
 EuJXD0oVP6A5PjT5+I5EBAzPcE6GiRfXFj9qE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699106223; x=1699711023;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Eqlm2SwJhbGwzuRwfCsTr4NHmqO2ILtI9ofBA4aqBU=;
 b=E417kqxqPAYEzdcJlY0YokIs+aqHITuU5u0RgT2kE9VwOdc6gGw7a3d9Ry9S7rjTI+
 LJ+klwPN7ZrHxTdcPZuaVhjeo7c8fM+eV+WtFhKZkKAw+qDPGNLqpHiOb93OxHc7zhB6
 Be0r45sTI83J/tQZdxAMy8xraOVMTacGYcNS7lDb1+jfF8VAaxZ1GjvU3zLgzd7o79uq
 nX3O0vgeKuiWul+1noinADIkSOfuISXRDDoGmrx6dcJ2sSzDNpfjnAKGAEESZycA1wic
 AUzvGKJkcQHVHtOjdPVrzUOoRm/PZPdiv2ycWovKEUKV7gBWqd3fg+ojs8EYMzmTk5Fd
 p6WQ==
X-Gm-Message-State: AOJu0YxXVaZAhVtQSZhhh868UdVP7MnYuvySGkPwsu1USb1N5/hwFd1S
 Zk67UwnSzqjbwx6hvQgwKAZu1Q==
X-Google-Smtp-Source: AGHT+IEtfHLeGCdBiOhBuhvrutYG2Z7N/gABjKAl6C2nSRcFq4rRheiqJ7lSmBzpOB42ja+kq/OyWQ==
X-Received: by 2002:ac8:57cb:0:b0:419:50d0:cf5a with SMTP id
 w11-20020ac857cb000000b0041950d0cf5amr31787611qta.2.1699106222916; 
 Sat, 04 Nov 2023 06:57:02 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 p16-20020ac87410000000b00419732075b4sm1629376qtq.84.2023.11.04.06.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Nov 2023 06:57:02 -0700 (PDT)
Date: Sat, 4 Nov 2023 09:57:00 -0400
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20231103
Message-ID: <20231104135700.GW496310@bill-the-cat>
References: <87v8ajm044.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V5DJFytZHg7+Zga9"
Content-Disposition: inline
In-Reply-To: <87v8ajm044.fsf@baylibre.com>
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


--V5DJFytZHg7+Zga9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2023 at 02:34:35PM +0100, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Here is my first pull request of u-boot-dfu which includes:
>=20
> - Fix CRC chunk size in fastboot
> - Make size optional for dfu on mmc
>=20
> The CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pi=
pelines/18433
>=20
> Thanks,
> Mattijs
>=20
> The following changes since commit cbba1b7766bd93d74e28202c46e69095ac1376=
0b:
>=20
>   Merge branch '2023-10-30-assorted-general-updates' (2023-10-30 16:01:54=
 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-20231103
>=20
> for you to fetch changes up to 60d904a494c6e89c323bc13fa9348869e07e86d3:
>=20
>   dfu: mmc: Add support for exposing whole mmc device (2023-10-31 14:53:0=
5 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--V5DJFytZHg7+Zga9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVGTaMACgkQFHw5/5Y0
tywQswv/anISYXv8gZnMsga4W16xhm0nsZPGiFn1rqmzv/NJwxo6CibWmIBJXQfe
r75orRS9aYd3uuEUDbwHD91shlFYimOS0ETkE5BmdNhVQRAcJCsddg+ENsrwsLHE
J3O6H9LpcQ9ckbYX7R6/WFvdoNruJ3Ad4kPN2INn9YEEqQmoNNg+knd5BJYPKHza
IftCFTul6fMQVuG1xnzTomqtop1i5r5wE69sBqMUWIG93W+LixCDoSeHLRnZogO4
VaGnMmXNebd8RC1I2tSchxXhp4IXvsYYpnnk8pb20+z4/duj6HfyCjk2A4F3gKbv
YPX0gD0DkZSHs+jBppTDUY/7ifsXDiXPaqosUOyIoAL6rGWHxUTtOBwl3GRB0LdF
DAv0C07qc7VFtxFB9G6qEHG1LyF8DJxuybmZKsQoErDnUJ1hjGK8DpiSthbsWPpT
LinxpKb5kR2O2QgbUmWgifvKHxcPoQ3ssgjq/7DXyeaATcy3q72pH+a6ODe038AZ
CjXSuA13
=VH8j
-----END PGP SIGNATURE-----

--V5DJFytZHg7+Zga9--
