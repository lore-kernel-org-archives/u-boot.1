Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C9CC021AB
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 17:52:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F03680843;
	Mon, 17 Feb 2025 18:52:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KK+2spsz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CDFD80BAD; Mon, 17 Feb 2025 18:52:17 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E18A8083C
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 18:52:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-220e6028214so74267525ad.0
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 09:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739814734; x=1740419534; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JvOHCobO9QU9ljiO3lRhVrI6gS1SfDyZ6YXDZ3CQG80=;
 b=KK+2spszKu4ZtjDIa62p9tjHQBni/SrzdBmlg4WjBBV4RWAnr8/3U5HRWimrFflm7E
 a4XWX7wIITEwtTyJgWbjzFNexAL9dl8tp04TSHQOehTJamBOEcwrum9sA0O2VeCFQKRW
 N2cUtcfcLLHYYX5roOaVS6xDSB02XhNkV0XWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739814734; x=1740419534;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JvOHCobO9QU9ljiO3lRhVrI6gS1SfDyZ6YXDZ3CQG80=;
 b=jYybPlcLY124lubjJVJaB2qB2psSzyxMdxqrSGd+4wWTe3UwjPowCabRC4gnKHGQSj
 fm1aaS4ZgWAjHdy9zEmF8d18afGMV4IApFqbEzyy1rC+W0/t72AY2RizhldfoHgweoik
 RMhWrRxzq53lBysOtERfdK4jV19O7l+Dp2e9qAKlMquUT9qVZQoLwjhIJimgdL6MRFrx
 0+lvITY4l1dCKL3tIsWpSyZ2GDXi8Q1M2dCb8DIEwP9okpOrEbZValq8RVWGup6fNJ8D
 pG5PmgI8IKbCKjhPTAWH0q1TSJw2uCnip6WDRIDLJFTb/NO47ZzNas52hXSOnB2vBEK6
 VyxQ==
X-Gm-Message-State: AOJu0Yy0qGq+nWVgL71uw97lix6b7p+mSEK2rvYrkDYIIteMpS4hKwoV
 X8KO8gi4WXkDbvm3X0KLOSK1tZeXc79T3RGBFhYw+4q5J1+v313RGZCeLNABy+W5LjXDjoWwqO7
 L
X-Gm-Gg: ASbGnctXfoDaSSY1UgmQHdODXoh/mQNAQORpmV6G1YJivZSEnXpsjSgaXCbXuuvldda
 qSgH+aWeUUgCqhbm9hqfWjxpZM4QnYf2BCJ8/wnOqtbLrux/lf0dg0RYS5nk85ZYl7HRZAIRlW1
 gkyLt8DnSc91r9qEtTBwc5BDCWWSuALUwr4utlIPjy1AnUPSLJXgcZMzdjfwpogQAKbYe+8pHJi
 E7I1EguvXdC3sOhJZfIOcKHHkfpffdomkg3Tc9a/LiqGlPdxCi7oeKf+wDU+TeF4mHGDHOREe5t
 idArNcV2f8LXBw==
X-Google-Smtp-Source: AGHT+IGuL+3+DXXrgIHDtbF+bEszkg6pKJnXo2xIH3vQWWoR9ry28QbamrmrMXjdiSxxYw1vqGK4Zw==
X-Received: by 2002:a05:6a00:99a:b0:730:75b1:720a with SMTP id
 d2e1a72fcca58-7326193a539mr16398603b3a.23.1739814733752; 
 Mon, 17 Feb 2025 09:52:13 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326be5e5absm4020611b3a.25.2025.02.17.09.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 09:52:12 -0800 (PST)
Date: Mon, 17 Feb 2025 11:52:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v2 28/28] test: Add a test for booting Ubuntu 24.04
Message-ID: <20250217175210.GR1233568@bill-the-cat>
References: <20250216204421.3560012-1-sjg@chromium.org>
 <20250216204421.3560012-29-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d4Op6VXp/ZswT7P1"
Content-Disposition: inline
In-Reply-To: <20250216204421.3560012-29-sjg@chromium.org>
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


--d4Op6VXp/ZswT7P1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 01:44:13PM -0700, Simon Glass wrote:
> Now that U-Boot can boot this quickly, using kvm, add a test that the
> installer starts up correctly.
>=20
> Use the qemu-x86_64 board in the SJG lab.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v2:
> - Add more patches to support booting with kvm
> - Add new patch with a test for booting Ubuntu 24.04
>=20
>  .gitlab-ci.yml               |  5 ++++
>  test/py/tests/test_distro.py | 53 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>  create mode 100644 test/py/tests/test_distro.py
>=20
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 8c49d5b0a79..ec799e97c10 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -745,3 +745,8 @@ zybo:
>    variables:
>      ROLE: zybo
>    <<: *lab_dfn
> +
> +qemu-x86_64:
> +  variables:
> +    ROLE: qemu-x86_64
> +  <<: *lab_dfn

I'm not sure why this is in your lab stanza, rather than the normal
test.py QEMU stanza.

> diff --git a/test/py/tests/test_distro.py b/test/py/tests/test_distro.py
> new file mode 100644
> index 00000000000..51eec45cecc
> --- /dev/null
> +++ b/test/py/tests/test_distro.py
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright 2025 Canonical Ltd.
> +# Written by Simon Glass <simon.glass@canonical.com>
> +
> +import pytest
> +
> +DOWN =3D '\x1b\x5b\x42\x0d'
> +
> +# Enable early console so that the test can see if something goes wrong
> +CONSOLE =3D 'earlycon=3Duart8250,io,0x3f8 console=3Duart8250,io,0x3f8'
> +
> +@pytest.mark.boardspec('qemu-x86_64')
> +@pytest.mark.role('qemu-x86_64')
> +def test_distro(ubman):
> +    """Test that of-platdata can be generated and used in sandbox"""
> +    with ubman.log.section('boot'):
> +        ubman.run_command('boot', wait_for_prompt=3DFalse)
> +
> +    with ubman.log.section('Grub'):
> +        # Wait for grub to come up and offset a menu
> +        ubman.p.expect(['Try or Install Ubuntu'])
> +
> +        # Press 'e' to edit the command line
> +        ubman.run_command('e', wait_for_prompt=3DFalse, send_nl=3DFalse)
> +
> +        # Wait until we see the editor appear
> +        ubman.p.expect(['/casper/initrd'])
> +
> +        # Go down to the 'linux' line
> +        ubman.send(DOWN * 3)
> +
> +        # Go to end of line
> +        ubman.ctrl('E')
> +
> +        # Backspace to remove 'quiet splash'
> +        ubman.send('\b' * len('quiet splash'))
> +
> +        # Send our noisy console
> +        ubman.send(CONSOLE)
> +
> +        # Tell grub to boot
> +        ubman.ctrl('X')
> +        ubman.p.expect(['Booting a command list'])
> +
> +    with ubman.log.section('Linux'):
> +        # Linux should start immediately
> +        ubman.p.expect(['Linux version'])
> +
> +    with ubman.log.section('Ubuntu'):
> +        # Shortly later, we should see this banner
> +        ubman.p.expect(['Welcome to .*Ubuntu 24.04.1 LTS.*!'])
> +
> +    ubman.restart_uboot()

And this seems very inflexible. Please see
test/py/tests/test_net_boot.py for an example of how to have this be
configurable and work on arbitrary platforms. What I assume is tricky is
that the "role" part here is where you have a special disk image being
passed. That too could be dealt with in u-boot-test-hooks in a few ways,
and the images pre-fetched to the CI container. And if this was
configurable similar to the example I noted above, it could check real
hardware too.

--=20
Tom

--d4Op6VXp/ZswT7P1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmezd0oACgkQFHw5/5Y0
tyxcSQv+PPJUsELiff1Z7EMuhpapSByo0b7Ahvi/hJ6Tx+LgSWaowuABm3HT9dra
o1078IpSVh3Ro7K6RwlBLe09XrP3TWBhYb58MSCS5iqBBi7JB92hopMl9uFYq/45
T8n/KvqFcdqxJHlmPq9zBMWeMFLEGxhDC378/LgKGLbEFDd4MqdnmtdiGBviFaTz
5SJg+KivJklTT+9pxNO8B44Nbg8AAa5W0/WAq2bQBhI/zsoyXyUwvc8QKKTyVT/m
hBIzB7Han8l4h37o09rxw2arvFrs+PhtIoUpjUyCqnRXIU+A6P9qu9iW0qA0+RlX
eYdr+XrP8vyF61VLbOIlxXrPD3kYAhoYooWkilAbRnjOVL+bWLZAsAwlcNaIwtw3
Hjlh5w5sC9WSoy87nHekfcctFmNZUbk6td+2NNKQ7Jztr/zHsDuEVkG8qVbCWsaS
BB9eSsamMnaBADF/a1mWNOwsDaU2fGSUi5IjebXk+CJhM5phzrnCXdLXZAJaPjG8
k9ukHGtu
=AoFa
-----END PGP SIGNATURE-----

--d4Op6VXp/ZswT7P1--
