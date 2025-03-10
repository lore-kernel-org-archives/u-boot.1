Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819F9C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 14:31:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DF548164E;
	Mon, 10 Mar 2025 15:31:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V+GlHwFb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64DF4816AF; Mon, 10 Mar 2025 15:31:28 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 382798144F
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 15:31:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22398e09e39so77237725ad.3
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 07:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741617084; x=1742221884; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SleB3rh5VhEIZSOJp12ZAAwRDE8QJN2PBZM9Fis45/Y=;
 b=V+GlHwFbGbXmQJd+71uab0m67+LgQO+a1p0Bbn9pJcx3harpknK29v7Hk1pX3dydkO
 Mj0KEEmPT5G3ryYEt9HuGVaRLO70wRgKfh/yG41aU0mGdX7LjSfykUIGLXsJJiWGBbm9
 UPZfaRPhkfdRn5/idnqbxbZvJi0XDBaa5G5pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741617084; x=1742221884;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SleB3rh5VhEIZSOJp12ZAAwRDE8QJN2PBZM9Fis45/Y=;
 b=bB7sj11GsBVy/FF6oV+ApIGByz+5mN85j2N8ewsb6TQGhbxLYiexKNsi4zyJYBJfd3
 9RhLR57ZNe55lDAiwjl1wQmaXcBm+AxMLuA+zOMKzbE9tj3ZIhF7G7w74CnXMzXyG2Re
 AZ18tzoW5VYz14Od484rbX9f7c67NLqvEspUGZ2phq9EaUcHSPcCMDkiXR8mbFSdaheL
 ejj2AdPrLBv93qPMHjuU56sp7EEguC8Yoq3H/2LB+LO235I8EZTve3YbSIjiYrYVWXQo
 V21YphTXHmLy2vaKmKSlZzkAGFmj9M59lxnl4rjEThFHl4ctbX37OYnPOEXQ+oYwAn0U
 JIDg==
X-Gm-Message-State: AOJu0YzaI30tzPGGmYySEj5PEgo3lyqGe9dWlQQ2F4nZphfrKDS0E0qS
 s2y8Bv1Zp2N/dSJNA1AWciea0uQautTZO2JDQ++s4ICyjc5ui3v2kNdnOLgUrw0=
X-Gm-Gg: ASbGnctXezggFyft7/8gAF2ATubOEEgo3KBOym9fqYFvyehg7cf85LXDtb/puu/trCz
 ikqJxk9d/cg8rAvx7ta+Vujsomxqhk8UW+alR5HHutdfFlnsjDxZtf7igs4oBICDN4b0ekPoiwo
 +GP8i4pRCOg02RSlIKULDlRnDiPheDp3WExol97AyhtIkN+d7yMnRcH+L3rWJWuOsfl58V7dK0v
 uX0ikkWzkmQvzq/jOL5BjjSy4GxqhHkUWe1oCPAq3iObdiWeCI+b7j5lmiH4LGYCZbh1XbgZsDK
 DWxWXFpAdq4a6VBmhrLTE3h8bVijuwmpRPkYq28vI2iTjA==
X-Google-Smtp-Source: AGHT+IGg03eIXIuXbBePD7VJzRuqwB9+Y9iWmAjdkyD+upsRykUES+UUYxMrKoE1b1wzDrow3Q4OXw==
X-Received: by 2002:a05:6a00:23cb:b0:736:55ec:ea8b with SMTP id
 d2e1a72fcca58-736e1b3e670mr4022582b3a.24.1741617083590; 
 Mon, 10 Mar 2025 07:31:23 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736aacb3200sm6945114b3a.131.2025.03.10.07.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 07:31:23 -0700 (PDT)
Date: Mon, 10 Mar 2025 08:31:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 02/12] cmd: fs: Add generic rm implementation
Message-ID: <20250310143120.GD2640854@bill-the-cat>
References: <20250308201533.1315951-1-marex@denx.de>
 <20250308201533.1315951-3-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a0C9AxxMMVfQ9OAe"
Content-Disposition: inline
In-Reply-To: <20250308201533.1315951-3-marex@denx.de>
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


--a0C9AxxMMVfQ9OAe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 08, 2025 at 09:12:06PM +0100, Marek Vasut wrote:

> Add generic implementation of the 'rm' command to delete files
> from filesystems using the generic filesystem API.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--a0C9AxxMMVfQ9OAe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfO97gACgkQFHw5/5Y0
tyz3iQwAuBb0zIRheFO1FzcylLb0yc6I/BNdkgHUdw0I49AXPw7AYSmt+tlwj5wq
eOz2x1hJ72N/RhfHSdCGMYnGzx6vp3wNd3DesJlhfETMgSQ7mWyLmUkcHPJgs5Ua
YmFtJvjzi8FiEZdzSZCyd20o/z3H+GOiRncfjfr6boMpzSM/8caqc3IMFEaDkURI
Q63WCFyJeDaR0hlxp2WhumaGI4YC4t+RsAEUNmibaIPFa3QjCjluU27NGEmL7aeO
ma8fqGKUwvu9LIYFZXLUcT4vb930T8CfA2ug58EWeMd5M5vKh5HYyPj1oGUpMNoq
1ppdTC4JMFyp97k6qrzK30pLM/+sIAMSgCDFfsfuP0Q8NR+vnG2N0j1adcqcfRSZ
eu28LUD2JG6BJkQu9jGaKNV3i6T8m+8f2/vc1UV15O6Swm+j1Kb4kYpj31w81i91
JS4vvDb+asubY7JInYRjoIwUXvI09Bm4kQ6OBLjYQeIZXvfQCcL8mD01BWt8/RjZ
D4jh5qzc
=Kg4O
-----END PGP SIGNATURE-----

--a0C9AxxMMVfQ9OAe--
