Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6F6C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 18:13:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1937180312;
	Thu, 16 Jan 2025 19:13:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QE25Qvdg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D10358069D; Thu, 16 Jan 2025 19:13:00 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FA1D8022B
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 19:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6dfbc45355bso16905606d6.2
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 10:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737051177; x=1737655977; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1cwBNdn4EFveaMbXBCN0LCWKVkKABqiCaYNgSEx50l0=;
 b=QE25QvdgrrzEvQMOg1+T7SUbqvmA8XAlCDTZnS18cUp0PSAqK7ZPauNjdUNTY+rVFI
 tgVU6ej95A2livA3L10/db9Yma6zlYRyZosRC8fDw1inTg2B2ynrv03zcCEwevlT/QjP
 RK+E+5nkH/2lF+owlHq49BVYDkSC/hcY1g8IM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737051177; x=1737655977;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1cwBNdn4EFveaMbXBCN0LCWKVkKABqiCaYNgSEx50l0=;
 b=ZacG3YeuK9YYHnjn8DF7Y4SD4ILnaDDPwKqhJiX7lVLGYB7NSgCvGc382GWwPT4r/S
 dgxuQMThWNFMUuYk/ZOdgQtZgmMQ6HSrZ60eiY/kDrKgDThPppTnlG3VIRWTji64p5kf
 JeVTAY3Hxe0TrGCiiE8IpAGEFwlHr48cmP8GkHhfu6jM1ICJur3OJiZDi1FM98hdpXJF
 /E747BCLoUqnFMDJjULexwZjxencS81hieN7Ou6goFj84g3L3/wuNUG7of1/6P5zmhyS
 9nEvqhQ4j6eCOfpSKV/Qhw6r0kg8Ee4bniia2lDAiRrXVAe/W0YO9pu+3QEgszZMLX7+
 zeVg==
X-Gm-Message-State: AOJu0Yx24gRc6ROXaFC8FBAwLbPFAyaJHrjA9Zmegk4fb5WNS10JFC/p
 NJC1KBFbSU9kfASe4gweBed+Y4aA2KJgqP580m6v+R3ZfwflAcAv8+U75Xnh2bkfV1XoZjOgGj5
 zYVw=
X-Gm-Gg: ASbGnctcrQE0vW6QF/EqV4D1+WzZAQdFSQ2fP+m+D3FQ+MltlRe+GMKAaKq447znzHa
 bSIlkzIV6K/8YdjA9Lvk2xcq0e1J+93BcPoMseQxI1LeM/mY01KoeZHZMCUkLK8YNdZ6aoGHrea
 2dvhc1fX769b+1UG8zvwQUnrdEHO//UVGzGMUxGcLLL6PWjCReJdyx8dmR+BWgaHcpZxjUgz0By
 ry2QwDYp0yYhsDwD93gKj1GKeSyopbmxI9CLpzywLxa8BBQTjnTGw==
X-Google-Smtp-Source: AGHT+IFQfTPGeFzKRoWqJlc59vdHaJhAQlLt3gnY474mpmpyFhgAmpAfgYuzTXuQ6UeegkB+H0vIRg==
X-Received: by 2002:a05:6214:1bc7:b0:6d8:846b:cd8d with SMTP id
 6a1803df08f44-6df9b2ff367mr426784666d6.30.1737051177220; 
 Thu, 16 Jan 2025 10:12:57 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afcd3806sm2306406d6.85.2025.01.16.10.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 10:12:56 -0800 (PST)
Date: Thu, 16 Jan 2025 12:12:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20250116
Message-ID: <20250116181253.GI3476@bill-the-cat>
References: <20250116143706.2011606-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JaYcj+57XCjlfnqW"
Content-Disposition: inline
In-Reply-To: <20250116143706.2011606-1-festevam@gmail.com>
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


--JaYcj+57XCjlfnqW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 11:37:06AM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/master, thanks.
>=20
> The following changes since commit 178f6ecb21fe12ada74a9a1a08093c812b15ee=
a5:
>=20
>   Merge patch series "bootstd: Support recording images" (2025-01-15 19:2=
7:14 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20250116
>=20
> for you to fetch changes up to 985268107d4c0389d154126aa74c1d21706a7ce8:
>=20
>   imx: fdt: fix cooling-device property corruption (2025-01-16 10:16:47 -=
0300)
>=20
> u-boot-imx-master-20250116

Applied to u-boot/master, thanks!

--=20
Tom

--JaYcj+57XCjlfnqW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeJTB8ACgkQFHw5/5Y0
tyzCIAwAhNotoLdvDT4iF4SD4avlxZHu6RUryeptZ09L0DHwvJqkQwotS2Py0tNk
LWGPoIITTD7EPOjffSDOcRRbqKFxuehi8fC/cMIuWJhXBCycUTaP/Z8CTt8k78S6
w3rXwTOC1+MvJcZZzr8lWU8UrQYuVFMIKzw5fmoxvJfR3FZkK/TzrHO+94p9V0vt
Hv3I0ddtD5AdBidFKbOXzhc0aLCjI6zB+1mijbYBszfaWMJP/5PdpXI+EWC0MVjb
KkUdz6eRXKgKL9ihzL/d0IV5h2U5qNG8szMnNbdT+shyYhl5J9ljhJIT1LOoR/s9
TGI7iWje1xK9/fAVCSY7lPrR+QNM7LvkkM6M76O5qcvD9FlaAcRbbJWqyLORCWbg
vRbAtCFsXhs5MXo8RPa39MS75z6qk8OOeTGlzjNITNeUjioYDEdVlBKZYBLGWT4y
eIy83H+OekmnUtqT9LYlL4u0pYc0QAwwZDnF5vP+mRjB3C1QV8YaYFzIYSyXt2YG
n6X8tzM2
=g5nn
-----END PGP SIGNATURE-----

--JaYcj+57XCjlfnqW--
