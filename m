Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC88C61D98
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 22:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 218A386F6D;
	Tue, 21 Nov 2023 23:27:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uidAxBKw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ADB2875F4; Tue, 21 Nov 2023 23:27:31 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 503E386784
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 23:27:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-77891c236fcso400080185a.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700605648; x=1701210448; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fZHmfoldiQ4QwdUwuea0MpZIvi3pfoaRVYkNAwbsSac=;
 b=uidAxBKwEtIvQeCQEEzQaYNTzj/cqcO+knuKWDULNSuiLn7ld05GSdVKc9VBnfcz10
 X3NgFhkc020ToVQyCb47AI4KGkNdaDBsDnVgSnCBeGadr5m/v3ZvxyHxOecmcEvjbMoP
 uvsE5hb3QV8vz7zEWFsLlNouTcCLWTXPK7ABI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700605648; x=1701210448;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZHmfoldiQ4QwdUwuea0MpZIvi3pfoaRVYkNAwbsSac=;
 b=vthM2x1lGCnaiCVdQx/zUBkpYc7UsLWMVCVuQnm0aHrJI6ykmpd959+FMePrJ/XrWC
 LKn9Jm2nW6Y1YWso6VQ9x/N3Sum5HGY2d6+jDvILFqjbnebbjYqGEhdff17fYdXIvl63
 V2z5IE5VKnRAGJPCNzmCdfub7xyeVRhgYoGZ0GrKqDNts3iPJNVosDRri6tBDL8pIGBS
 Mr+AJBotjypu9Rmrrvy5VlgcAitDUJgDkZcVq7JAxN23myOMsDoBqZWvFtzclK1BCp++
 yNAl0RgJDI+I8Bx+31fT4knutwVGVz4eVdDJ2Sa/s6PbVCb5NEpR1jDdrnANoNpJN446
 4igA==
X-Gm-Message-State: AOJu0YxNOf0OhWnagzOKQDkfnkXrGOrsJEAljZwiEL6nI9ON3Z5z4sCY
 nOdm2UHNv654tr/Yo+b0illE68nv5qihinGPwPc3DQ==
X-Google-Smtp-Source: AGHT+IEPRONohG3rPrWmo84vsaCHdlH4JVl6nKIfIenSuZP+/1RkLwjtrS2MzMqKC7xQbmAByLbCKg==
X-Received: by 2002:a05:620a:22fa:b0:77b:dcf9:3066 with SMTP id
 p26-20020a05620a22fa00b0077bdcf93066mr451988qki.10.1700605648064; 
 Tue, 21 Nov 2023 14:27:28 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 a23-20020a05620a103700b0077580becd52sm3956593qkk.103.2023.11.21.14.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 14:27:27 -0800 (PST)
Date: Tue, 21 Nov 2023 17:27:25 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH] test/py: mii: Add tests for mii command
Message-ID: <20231121222725.GN2513409@bill-the-cat>
References: <20231121084051.3381640-1-love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FVgpDw/Ym3PaW8pX"
Content-Disposition: inline
In-Reply-To: <20231121084051.3381640-1-love.kumar@amd.com>
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


--FVgpDw/Ym3PaW8pX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 02:10:51PM +0530, Love Kumar wrote:

> Add below test cases for mii commands:
> mii_info -To display MII PHY info
> mii_list - To list MII devices
> mii_set_device - To set MII device
> mii_read - To reads register from MII PHY address
> mii_dump - To display data from MII PHY address
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
>  test/py/tests/test_mii.py | 68 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 test/py/tests/test_mii.py
>=20
> diff --git a/test/py/tests/test_mii.py b/test/py/tests/test_mii.py
> new file mode 100644
> index 000000000000..b213df3e3f2e
> --- /dev/null
> +++ b/test/py/tests/test_mii.py
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# (C) Copyright 2023, Advanced Micro Devices, Inc.
> +
> +import pytest
> +import re
> +
> +"""
> +Note: This test doesn't rely on boardenv_* configuration value but they =
can
> +change test behavior.
> +
> +For example:
> +
> +# Setup env__mii_deive_test_skip to True if tests with ethernet PHY devi=
ces
> +# should be skipped. For example: Missing PHY device
> +env__mii_device_test_skip =3D True
> +
> +It also checks for MII PHY device exist or not, it skips the test if PHY=
 device
> +does not exist.
> +"""
> +
> +@pytest.mark.buildconfigspec("cmd_mii")
> +def test_mii_info(u_boot_console):
> +    if u_boot_console.config.env.get("env__mii_device_test_skip", False):
> +        pytest.skip("MII device test is not enabled!")
> +    expected_output =3D "PHY"
> +    output =3D u_boot_console.run_command("mii info")
> +    if not re.search(r"PHY (.+?):", output):
> +        pytest.skip("PHY device does not exist!")
> +    assert expected_output in output
> +
> +@pytest.mark.buildconfigspec("cmd_mii")
> +def test_mii_list(u_boot_console):
> +    if u_boot_console.config.env.get("env__mii_device_test_skip", False):
> +        pytest.skip("MII device test is not enabled!")
> +    expected_output =3D "Current device"
> +    output =3D u_boot_console.run_command("mii device")
> +    if not re.search(r"Current device: '(.+?)'", output):
> +        pytest.skip("PHY device does not exist!")
> +    assert expected_output in output
> +
> +@pytest.mark.buildconfigspec("cmd_mii")
> +def test_mii_set_device(u_boot_console):
> +    test_mii_list(u_boot_console)
> +    output =3D u_boot_console.run_command("mii device")
> +    eth_num =3D re.search(r"MII devices: '(.+?)'", output).groups()[0]
> +    u_boot_console.run_command(f"mii device {eth_num}")
> +    output =3D u_boot_console.run_command("echo $?")

OK, so this here breaks the next test for me:
=3D> mii device FEC0
=3D> mii info
Incorrect PHY address. Range should be 0-31
mii - MII utility commands
=2E..

But doing "mii info 0" next does work.  However, what also works if I
have not done "mii device FEC0" but just "mii device" then "mii info"
works. And if I do "mii info 0" and then "mii info" it also works,
because I assume there's some struct member being set somewhere or
similar?

So good news / bad news, the test looks good and seems to have found an
issue that needs to be resolved. The question is, does this patch work
as-is on your platforms? I suspect it does and this is just a problem on
the FEC driver as it looked OK on another platform here real quick, and
I just want to confirm.

--=20
Tom

--FVgpDw/Ym3PaW8pX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVdLs0ACgkQFHw5/5Y0
tyz4tAwAjGe2DABVU6uukZPXg6Nq3RV6T1XdHo+/EZ9whIKWPbnSV2YUwpWiU25B
H/tZhbTlQ/11SLQkXwdxum3xbqi8NCvuam04QKUSSI/cIjfoHITp8E1A8jaIIG5L
284KJje4RycnINHWPopK0OQMU7omw/a8KKYtlYRr9NJohWvV0dAiobb5wN14uP/0
N1KahXP9Dchmwz8KccT+CDzXRX/GghORsukKft52ky85PmGttLvrRBWs6j/jTofj
HdU+ZyeQypVNLZI1OhSE/IUhW8DY9qT2ve9DVMXTVOVlx0B5HEtAD0QbF6XNShuF
ohEOEHju47CeovVVhi5Bc1wvTKElxJVD1qURa0Vmaa7PI6KcqMWJMNIz5iPlfYSq
CTOWfJJl+BEKvgoXriZorwVlpP+NNWOwgc0RrnoJ3ShdKItnry50/MToYJjQEeU2
rPIKoRTYxUxVyymzrWUywBdDbBRUY+wa3FQ1MVjr3z0TYlmsbjAdDBcxXDYTi6My
xcu9JZqx
=+/TK
-----END PGP SIGNATURE-----

--FVgpDw/Ym3PaW8pX--
