Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAA0C27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:56:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7108287DEA;
	Thu,  6 Jun 2024 18:56:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lWt2ANh+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0005881EA; Thu,  6 Jun 2024 18:56:40 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC884846D1
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 18:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6f94086e1ccso701336a34.0
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 09:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717692997; x=1718297797; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sqbZUFvGaXIaRrX3DcbCkKlJMadjIJDa9xDGrEUUO5c=;
 b=lWt2ANh+oIKLRWUMKNlwq6I+lViyrJsNVsG1jpgHoT4pr802g/5tdDDUKeq5syB3RE
 nF0ujtc25zUyfgf70sbPGtOO9506c/6YZ9K1j5wk1zh9r7HcB6pWZ9Gvz1Wp6kzmxwo+
 HBPWj0DYzG1vH6ExJ84VmtmV/Wuvkz4eWn15I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717692997; x=1718297797;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqbZUFvGaXIaRrX3DcbCkKlJMadjIJDa9xDGrEUUO5c=;
 b=PnJGhSRMjNyE7vOju/X7iKg+3uFcV5XCPVUJojAjxCmuSfUGyDTO3EjO5Zj/unit/o
 kxglIO8Fe5mjH2nDzjm1LpVKL2AbvzK+J+wk3JUiEdUdMm8bWbVOfxoMTH7dpqNyAudK
 a+wrjIExivvXSDkAlmoN8pSJGJG45CdPJgVQSGE5rl4Jmqm5U2oBjO91ldc9mvUQ2eZ6
 GYqeeoaUAd6zi3tbE4nW/BgU5eC4oUGRKtqGyJ/ieDQoeTQqwCtAKO1CZd4nV493RSlZ
 OCQi+kYdQQGH5L5sR3XII/VZUgZBFOvZni95exY7/FMZVgSXsR++KD9ZSHDg0D5Dd6UJ
 Xwtg==
X-Gm-Message-State: AOJu0Yxy8TBklOjkLadIzcaktoiyQWqv8Ou7nlan1lj2BbhvdKNiESmr
 cNr2Yq+mhF50dsz9zqCnMKBvJDBFvphkiOP4qe0JSEX06PpIMkIZbiZ/c1oFeHQ=
X-Google-Smtp-Source: AGHT+IEQexlF5pDqz8XI6+/1lkWaKeQ5ICiF9AiEXdLpmNYTQWFOgAaWzKqEMiM2bm25/VCa8QLE9w==
X-Received: by 2002:a05:6830:56:b0:6f8:d126:77ae with SMTP id
 46e09a7af769-6f95721ad89mr573a34.10.1717692997349; 
 Thu, 06 Jun 2024 09:56:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f94dc70cbbsm329591a34.9.2024.06.06.09.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 09:56:36 -0700 (PDT)
Date: Thu, 6 Jun 2024 10:56:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH v3 00/12] Introduce the lwIP network stack
Message-ID: <20240606165634.GB68077@bill-the-cat>
References: <cover.1717680809.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a5UPMq+Yr39Wg0Ni"
Content-Disposition: inline
In-Reply-To: <cover.1717680809.git.jerome.forissier@linaro.org>
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


--a5UPMq+Yr39Wg0Ni
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 03:35:55PM +0200, Jerome Forissier wrote:

> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> library for the network stack" [1]. The goal is to introduce the lwIP TCP=
/IP
> stack [2] [3] as an alternative to the current implementation in net/,
> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
> reasons for doing so are:
> - Make the support of HTTPS in the wget command easier. Javier T. (CC'd)
> has some additional lwIP and Mbed TLS patches to do so. With that it
> becomes possible to fetch and launch a distro installer such as Debian
> etc. using a secure, authenticated connection directly from the U-Boot
> shell. Several use cases:
>   * Authentication: prevent MITM attack (third party replacing the
> binary with a different one)
>   * Confidentiality: prevent third parties from grabbing a copy of the
> image as it is being downloaded
>   * Allow connection to servers that do not support plain HTTP anymore
> (this is becoming more and more common on the Internet these days)
> - Possibly benefit from additional features implemented in lwIP
> - Less code to maintain in U-Boot

Alright, on Pi 3, I think we have more "output changed, test fails"
problems:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
_____________________________________ test_efi_fit_launch _________________=
____________________
test/py/tests/test_efi_fit.py:452: in test_efi_fit_launch
    launch_efi(False, False)
test/py/tests/test_efi_fit.py:394: in launch_efi
    net_set_up =3D net_dhcp()
test/py/tests/test_efi_fit.py:178: in net_dhcp
    assert 'DHCP client bound to address ' in output
E   AssertionError: assert 'DHCP client bound to address ' in 'Waiting for =
Ethernet connection... done.\r\neth0: smsc95xx_eth b8:27:eb:fc:64:a6 active'
------------------------------------ Captured stdout call -----------------=
--------------------
U-Boot> usb start
U-Boot> U-Boot> setenv autoload no
U-Boot> U-Boot> dhcp
Waiting for Ethernet connection... done.
eth0: smsc95xx_eth b8:27:eb:fc:64:a6 active
U-Boot>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D short test summary info =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

I'm going to skip that set of tests and see how far we get but I suspect
it'll keep failing on DHCP output being different.

--=20
Tom

--a5UPMq+Yr39Wg0Ni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZh6j8ACgkQFHw5/5Y0
tyycIgwAm9zHVD6pe8NCL9m+34DkTEn13KdZ/5IpTmzgFdf1UX7oTQNk5R2WWSSz
xnDdAD2VNcIGPY9TizSvbqWaa6oj01QdbfA7qOXHxOVRBQdaMLjMfQK8h1RlDL+e
V/OtEP0VOZz+Kh6x/G2myM+Ot2jLnEcGnwHRoCkv7V/XRbuJA3jDRzsLuI83A1nr
u7s5OPRvbTjpap+marsFTDm68/R0R6JGdXUTHammsL6q0FlbLdbhELLZGGMxN9ba
jMwPgkhzFaew/BY5sM/BSF1A/PhgRqAZjgY9hdSIl+00s+eSny29UUWYHlv9NDOd
1bp7Er6dg6CRvwAopFMvwlBkxaODKLOYTLagnh7upzkKLcFpRxCdj1pBTRKA8LKP
ofSUwwzuBW3HnvhIiYqILmSM3uLCm8w4FRfMFDbFq4shcsiIlrDA+3X+HUIr4vZZ
GDti+DkyeB20x+ofTewg3blBbFKFS2TDHIBYVaNrCM+NWfCSqp6A2juyazZSHjyU
zI7AWXHx
=H3Fc
-----END PGP SIGNATURE-----

--a5UPMq+Yr39Wg0Ni--
