Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D260C3DA70
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 01:56:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 532B7886CC;
	Tue, 23 Jul 2024 03:55:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qy+9ShW/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F50488677; Tue, 23 Jul 2024 03:55:51 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B38C388669
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 03:55:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5ce74defe42so2759969eaf.0
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 18:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721699746; x=1722304546; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P7oVNEOcHRZQDjj9mdD5+NDw3fMmXFsvQCsQVxylnho=;
 b=Qy+9ShW/0Ajo1hqtgBSKrddFwei3sqfGtrBdTjobQLxPzsxzIWeIxUw8T2br/LxnuR
 pojqUzS+NlzyfQ5+O9I8YobM7vR9gaHn1283KKDhIEI+NZEY4FGJu0rJmcxxU1+l6qUo
 iJNPWMuJSELRMk8NT5oGlk7myYPn0axf4cFWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721699746; x=1722304546;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P7oVNEOcHRZQDjj9mdD5+NDw3fMmXFsvQCsQVxylnho=;
 b=BE3qe8iI0M7D1Kjari+eIK8iCp2fponZJp9nc78YbtA0jRWBkAJemLtdXoRBDXqbGJ
 iGAckAcAk6MK3iY0KMBYfWN1AfGFC73o5N7dnm47pCcbLMeCjeRZYEzT2C9JPq+AbAWb
 rIKkhadyMQxKjB11Tw8xpPap4AVDOSucjPdAYQJL1f0TfQA58hgIVjkv8/19+/+UxzmL
 /Wv3KCiO+PIR1UnbNlisvNUh2+f2kOKsZgyFbZGAIuZ0ep/y1Tz6Dj+xmdT/VUB7D3xK
 iQ5KMXCqE5jmNGyY6uqWYb4XyEA8KkRzfLedS/w05P6grnW3AQ08MasLrnt6mUjSTYNH
 Oarw==
X-Gm-Message-State: AOJu0YwzkYWagdF0GKxVHjOVpw2RSpqiVt1jlujnhdgqt8qbOXlQphC+
 mhVx8CMAAMFG+cSjIIah/50+ILEaua/TpV3aNeBmlmdvHEKOPYLPEgDr2dHF4yo=
X-Google-Smtp-Source: AGHT+IEOsWz4y5d9cF8GSomO5vCz0QSYoJ1StKHyQDN3bDG3EI/4uhbfSRaBDc500qDxf1bJU96hrw==
X-Received: by 2002:a05:6820:2003:b0:5c4:1476:f6af with SMTP id
 006d021491bc7-5d564f76e7fmr11046544eaf.3.1721699746216; 
 Mon, 22 Jul 2024 18:55:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d55aad0503sm1637725eaf.30.2024.07.22.18.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 18:55:45 -0700 (PDT)
Date: Mon, 22 Jul 2024 19:55:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20240722
Message-ID: <20240723015543.GD989285@bill-the-cat>
References: <20240722210244.2294039-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eGGZs5Z7UXmDm65i"
Content-Disposition: inline
In-Reply-To: <20240722210244.2294039-1-festevam@gmail.com>
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


--eGGZs5Z7UXmDm65i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 06:02:44PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/master, thanks.
>=20
> The following changes since commit 5024a96db8ea6ff2e814f4599af9e5faf09296=
b7:
>=20
>   Subtree merge tag 'v6.10-dts' of devicetree-rebasing repo [1] into dts/=
upstream (2024-07-20 11:15:22 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20240722
>=20
> for you to fetch changes up to a9c962941e119017eb9d5985c5c214d9711c9433:
>=20
>   kontron-sl-mx6ul: switch to DM_SERIAL (2024-07-22 17:55:35 -0300)
>=20
> u-boot-imx-master-20240722

Applied to u-boot/master, thanks!

--=20
Tom

--eGGZs5Z7UXmDm65i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmafDZ8ACgkQFHw5/5Y0
tywKZgwAqsGpFhsfEypt/FZ62iF5lVgxjA+seSD6ZTS901ayO3yKlyOVLx9oRjyI
JYeCG2WSd+Ys4tQcwN9LzB0twCkICYlHm7w/X4924piKCk/lHeUBq9DyF+1FDLpx
xgjYL8YhOJyQrEusbiK0Rm7XjXLra1sBR58jz5AZ7RJugqZmgS40EBGQwWwwAfTP
8g96CgtSXT2cf8uSexENWEf9T7nxXKtDT4/CyYHcRJNztYJzSkT/7NzWpkyuLaFC
R6XuJ+gtB0JRNyhXmO3UYyuFDaoqHl0lrH5ZGiNq7QAn0MvsnzLJ7NWhsIA/eiym
VV6oV67xPHMyTQraJJExC/1b43dgXRGTZehPJPi9e0ScpjcBCLchZsTuj8Iw8K4v
csf+lXKXcjdR2+2Wu/QZT6l7QdbTsaRd9fUoBVJT2kmxT4anOWPLX+bwMPB5Quyz
I10TDtzxVNhAABbfDvXDAoDNOwdasSpe55s8kHDdig8oVKgZkFsLsdW3oIIKfCbT
mgYuy0ab
=zHOf
-----END PGP SIGNATURE-----

--eGGZs5Z7UXmDm65i--
