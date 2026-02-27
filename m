Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A2DFEFB56
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 14:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68CAE83E88;
	Fri, 27 Feb 2026 15:50:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C0ov+eKi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9908C83E8E; Fri, 27 Feb 2026 15:50:34 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BDEA83E76
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 15:50:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-464bc03efd8so799466b6e.2
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 06:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772203831; x=1772808631; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=htlb5FTGsrD04CIaEwN5BttPGjlNDVSZK7DNVvRlb6o=;
 b=C0ov+eKiVGYPOe+X1Fhlq69QbH0fLHa3gRCM/LEsX7UZ++fKi1GauGjTj2NXfsCjrO
 20AHriXHFITtcGD5tBu9kZqo1JvvY9dOQG+1T7BjSX1wFDLYjMYh8Y7BdX8061V8/SpE
 Rj0O44Tkz6sWZzoRgNgzejV41T4xQDqGBNstg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772203831; x=1772808631;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=htlb5FTGsrD04CIaEwN5BttPGjlNDVSZK7DNVvRlb6o=;
 b=PdckPnldMyVRfuJlZKIn+6OB/gwz8jBYc5Ip3tSNmJpEnfaHU5xxRUScuwJKnWUGwa
 cc2GhknyEVqxxb0tl7yfrgx5BqqIG7ZlrP3aYMzAUuqBFE9omOeN2NiX2boNp+b0UQzP
 4+ml8I3kyOLCgofQQLMWjG1UDES/rvvbpusqwMamjaRCIrwy/nOiZl4ZrVMudj03Tt1g
 O1f4OJoBwCBaYCIqvE/9fFFcAA/pf+/OWHKlyrYVnh2ZVOxsV0IRhaC4OVrn/ix07Gbe
 iScrhXQ05RyoKTQ2UaQqyxGI7iCb8ZPWxd2Fd0tJ+1M5yYZXaYvRo4moVs0q/YYqIWQn
 oe8g==
X-Gm-Message-State: AOJu0Yxqc2/PQk8cKClVFRg6JpyqhivnLTh84/6NbzwrhjSZ6DN3y/JD
 OOmWVKbn/XgrdweKJawlgSD45qlbML++Q1GJh9K90Lnq0THC4qpg+SKRzDgQQNhoyYh3CEaL/Rd
 T0rBJOCA=
X-Gm-Gg: ATEYQzwXRmY1HWnCK8lUlgwjldWZ9FFSkjBJNlD2gVK2t3D9LNdOM8d4K8RDlYxUdru
 uRSY8Quom36ZC2jA5znnEtR5pv6wFYvqISoc0Hy/f4a7Gqzto5E4szWOsHnInx+rhRqh11Gf2BZ
 BGvCk1wwKS5cavwwu0lFvMjXc1JJ4/GvY8cmEi/J3Q4fA6hlD7nrKu79vtPClQDjmgG/Rf21xVf
 zK8/v+psGhgkLu7d4YYcJOFWjsqrOdEmco3aenxbBYBa1um8T8fjaH/qyKDYAkkpdvMej01fWvx
 Ox6EzN6snqId/l4MgXQKt4UpHV7BNzW/5Vpki8VHLqiRSKSYKODZ2AIgZDHf0ceYppFZ3N+0R+q
 eO/be4PFI9GdaTe84nfe3pZMlCfT6DP3TxoJnLyF2TWJXVACQXo9pHESj/IFKx2ixHAZG/4K9kg
 D5+HD1/6zLeSKauZviRA6w2myo94PcSeaC2RYMqgc8QZWLYjaQ/Lg0xhZIpyC5SjykF5HIZOgGk
 wqw6P4dJAVStZ9n6twIwpUQoFEP2JHibQg1iso/B1RtjJvFMdU=
X-Received: by 2002:a05:6808:4f4a:b0:45f:2042:8fbe with SMTP id
 5614622812f47-464bec2bd6cmr1772937b6e.13.1772203830955; 
 Fri, 27 Feb 2026 06:50:30 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb59be78sm2199268b6e.13.2026.02.27.06.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 06:50:30 -0800 (PST)
Date: Fri, 27 Feb 2026 08:50:28 -0600
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] kconfig/[mn]conf: handle backspace (^H) key
Message-ID: <20260227145028.GS1593142@bill-the-cat>
References: <20260227-kfconfig-backspace-v1-1-b8467ef50ebc@armadeus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HhZVb3sQp9uE+nSI"
Content-Disposition: inline
In-Reply-To: <20260227-kfconfig-backspace-v1-1-b8467ef50ebc@armadeus.com>
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


--HhZVb3sQp9uE+nSI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 03:48:26PM +0100, S=E9bastien Szymanski wrote:

> This is in the mainline kernel since v5.1-rc3:
> 9c38f1f04408 ("kconfig/[mn]conf: handle backspace (^H) key")
>=20
> Quoting the commit's log:
>=20
> "
> Backspace is not working on some terminal emulators which do not send the
> key code defined by terminfo. Terminals either send '^H' (8) or '^?' (127=
).
> But currently only '^?' is handled. Let's also handle '^H' for those
> terminals.
> "
>=20
> Signed-off-by: S=E9bastien Szymanski <sebastien.szymanski@armadeus.com>

My only concern here is that we're unintentionally behind on re-syncing
scripts/kconfig/ with the Linux kernel, and so unless this is critical
I'd like to defer this in favour of a full re-sync (at least up to 6.1
which is where the kbuild side is up to currently).

--=20
Tom

--HhZVb3sQp9uE+nSI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaGvNAAKCRAr4qD1Cr/k
CkMXAQDND780667KPMpYne8y0KZJNmoTs3aRCWn5Py6hQ2hQRQD/eSFUt7C/PoJa
uKQwdLiTrsi1sK4qO1qtYApdj12tFws=
=SoF7
-----END PGP SIGNATURE-----

--HhZVb3sQp9uE+nSI--
