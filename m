Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B987FD6A25D
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 00:14:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6E01890CE;
	Fri, 15 Nov 2024 01:14:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uYgd/IHU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83FB58920B; Fri, 15 Nov 2024 01:14:08 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56C4E8852D
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 01:14:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6d3f2aa7632so1279956d6.2
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 16:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731629645; x=1732234445; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jVl3frt7JJvaGoZpVj9nVZRFo9ZUFNgp3w5TRVpUxl4=;
 b=uYgd/IHUryb9urQRQG3LRkzkhq57lQiVbmCcWXhx0loMsDdmzudqeJYZG7E/grH9OM
 Lha+GxCIchI4Sv8mEkyf5bbAD5FMj/x8RCgAJ0lVwgIK0Ih5L3GfhLvYzUu8QEvjl5ff
 8XzOuvTyMJgbt64YsxDDAbToSUURi47REV3C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731629645; x=1732234445;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jVl3frt7JJvaGoZpVj9nVZRFo9ZUFNgp3w5TRVpUxl4=;
 b=AdswJ3X1v2nEZYHY0/OGqaAMXJxNUNn7AxpWz4ySLL+N3j9jZiGGhj2as/1coFSRYQ
 IiUJNyNwzkeDccfalF3fDFu0oZMf8oQ4hzmllZkx8g9009NfSjFsi1PoRKGeXj9lpUdS
 xqDfODrzQQvPXxsjFXA0GweZsizf1bgq+3wZbxm2ZNZ29FMaetUNq9XFYezB7e1nZeHe
 p0ZHJNWD1aPg8PW+OOiKejYH5jyJRwojxba+ZRKCQdIXynC8sgeGj/Jm/xgIxANHf/C5
 laKOoNkIj+INOmTIgRUE3Cgu64sEKdeYwIiGAteuBeDKIhRyNG4WR87BiJI3rZuwp9tJ
 4vCA==
X-Gm-Message-State: AOJu0YzxT8UmD6UDdb85qQzmX7VjsoLhpQW+wtcOu2L+LKVFfmP2YYv+
 EHp7gKBjvZXRVh0RDgFGlIzqojyMV0/Pbd/h+ZQMMpPR+Ww04MinNQwB9cTEQFg=
X-Google-Smtp-Source: AGHT+IHd68WhzcIAKjpxusuNPkyQIp1BoJ7ysAMUYa/8wtyrW0MS8c/NuaYs+Z0Qnem+s7WRzNELyg==
X-Received: by 2002:a05:6214:4282:b0:6cb:be8f:a6b1 with SMTP id
 6a1803df08f44-6d3fb80c416mr8560646d6.25.1731629645181; 
 Thu, 14 Nov 2024 16:14:05 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d3ee773269sm11504846d6.4.2024.11.14.16.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 16:14:04 -0800 (PST)
Date: Thu, 14 Nov 2024 18:14:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Yasuharu Shibata <yasuharu.shibata@gmail.com>
Subject: Re: [PATCH] test/cmd/wget.c: move net_test_wget() to the cmd test
 suite
Message-ID: <20241115001400.GO3600562@bill-the-cat>
References: <20241105120653.99438-1-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xImupIkxtan7W3ec"
Content-Disposition: inline
In-Reply-To: <20241105120653.99438-1-jerome.forissier@linaro.org>
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


--xImupIkxtan7W3ec
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 01:06:53PM +0100, Jerome Forissier wrote:

> Since net_test_wget() is testing a command and is in test/cmd it
> should be in the 'cmd' test suite, not 'lib'.
>=20
> Reported-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  test/cmd/wget.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

This leads to a sequencing error in tests:
------------------------------------ Captured stdout call -----------------=
--------------------
=3D> ut dm dm_test_eth_act
Test: dm_test_eth_act: eth.c

Error: eth@10002000 No valid MAC address found.

Error: eth@10002000 No valid MAC address found.

Error: eth@10002000 No valid MAC address found.

Error: eth@10002000 No valid MAC address found.

Error: eth@10002000 No valid MAC address found.

Error: eth@10004000 No valid MAC address found.

Error: eth@10002000 No valid MAC address found.

Error: eth@10004000 No valid MAC address found.

Error: eth@10002000 No valid MAC address found.

Error: eth@10002000 No valid MAC address found.
test/dm/eth.c:284, dm_test_eth_act(): -ENODEV =3D=3D net_loop(PING): Expect=
ed 0xffffffed (-19), got 0xffffffea (-22)
Test: dm_test_eth_act: eth.c (flat tree)
test/dm/eth.c:273, dm_test_eth_act(): addr =3D NULL: Expected non-null, got=
 NULL
Test 'dm_test_eth_act' failed 2 times
Failures: 2
=3D>

Where it's fine when run by itself, but fails in CI/etc when running all
unit tests.

--=20
Tom

--xImupIkxtan7W3ec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc2kkAACgkQFHw5/5Y0
tyx0/wv/QRu720thRdeu18sxGuYHG6cO6grgInXRCCqOmh0vW9soZ5wfWlUYYr4B
h7+plXD75BXPM4wuTdE4pl+jpShA1/R4MWueZrPuwfWKcOBGroE1m7jZCBcnWoKC
ZUm0YKTSJF1c8uMDqbkb9JZjvtkpeDF5CCOjEw/ALy6SOYEJS5i5G/bBrG2gwimn
ccq/mudyOtDtQAduxwQl+iNEmempiIalT8UD0BqwuCSjkiihsHthD4Iqxc3AYuPi
IC9DqoyILrGNpfNj2efrpLkhhQxu5+0RNi2D/dej2oxQhl2Lm9OUg2av5qWPq4mJ
KE6OXbAnsvFHSGSPq6WSvV0D1DgqDieIfkPmJOYVUv+TWldl5Pz1nrF/YrApdl6U
LnzdyER3WtGvrLLCYSikZ7ofeg28i6L37xGh3gPaz8GhO1U56gGcUgAKlJTxz6ZU
Mnq86brWn+lqUVhH0+AzM112ijExrkgeqwNC4Lded0c7TRrjwrU97h/oMk603DAk
bqHE36QB
=Pv9a
-----END PGP SIGNATURE-----

--xImupIkxtan7W3ec--
