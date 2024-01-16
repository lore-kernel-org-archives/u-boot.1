Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3212DC47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 22:05:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E5058772E;
	Tue, 16 Jan 2024 23:04:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rKZuN2gM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FE06877B0; Tue, 16 Jan 2024 23:04:57 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B83D086F80
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 23:04:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5ff6245c1deso3164847b3.1
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 14:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705442693; x=1706047493; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s8/1MUbydGXbhud+FRjdMg41aA89juLF0SaNcQ4/oMU=;
 b=rKZuN2gMq5+Bn4Lwu2wLF9Th8V9lhlltBdscDseoUYCAOyVe1Xtfr6Sg35OPymgfVV
 edallUSeodnRBlBQ4aI9k4QKg7jNonL2WYI/rgN+EaYeIcB13MVAis+L939r9o9YDY48
 KOBsUeT7qL+Uxi0pdNsgj1gsHjCiT9PYTFzC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705442693; x=1706047493;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s8/1MUbydGXbhud+FRjdMg41aA89juLF0SaNcQ4/oMU=;
 b=lQ1yjiuuJ9x6RfhJ32ypcsQpXI9S0+/ofw1bd2SuWtbM8F0R3KjCNQJ6sk1NTzCTWN
 o1bT0UGhI8Ue8S0phf5JqbbobLTSKowsA3ElaZf7RdIh0CCfDxgvKbLiCtQXfxC/LlHW
 ryVyVd/+QgjWJFgpMvf1A+8QWPpLmmB/EqzpIVtt4D52/w5Mq0UXvMv1fps4y3L+yDPa
 PRPPk8390Z9ENikgILUuIi0J6UoRynqnkmBdGKqHkE+ZT5mxxOpGV3lluv9oqRfpPe2T
 7ZNEMJXUHMCgI2vJ5P0/DeLup/C67IrMDdKFrH9J5t6vk1jUDfaADjg3esqaAFgxvayd
 g5XQ==
X-Gm-Message-State: AOJu0YzAmOWgiico62d7mEH3niBNoX2qgWYRoQ0C1+/V6FO6HJsnFMPB
 1Rj/oBUQ2WaBXGnXuiaFCEp3RwsOMToJKQ==
X-Google-Smtp-Source: AGHT+IG7pRfHM3c/dNGA3opIe8FGRnAdFN7GBYuelyRVAd5VXz2gWX3+F1HDsFl2KkhGgHgq8xznrg==
X-Received: by 2002:a05:690c:805:b0:5ff:329c:299 with SMTP id
 bx5-20020a05690c080500b005ff329c0299mr3207725ywb.78.1705442693230; 
 Tue, 16 Jan 2024 14:04:53 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 i17-20020a819111000000b005ff55dc76e9sm791729ywg.14.2024.01.16.14.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 14:04:52 -0800 (PST)
Date: Tue, 16 Jan 2024 17:04:50 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 5/5] test: unit test for smbios command
Message-ID: <20240116220450.GA1204271@bill-the-cat>
References: <20231223004429.247301-1-xypron.glpk@gmx.de>
 <20231223004429.247301-6-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z+ynFSzzXmRPMumA"
Content-Disposition: inline
In-Reply-To: <20231223004429.247301-6-xypron.glpk@gmx.de>
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


--z+ynFSzzXmRPMumA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 01:44:29AM +0100, Heinrich Schuchardt wrote:

> Provide a unit test for the smbios command.
>=20
> Provide different test functions for QEMU, sandbox, and other systems.
>=20
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  test/py/tests/test_smbios.py | 47 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 test/py/tests/test_smbios.py
>=20
> --
> 2.43.0
>=20
> diff --git a/test/py/tests/test_smbios.py b/test/py/tests/test_smbios.py
> new file mode 100644
> index 0000000000..86d8d07539
> --- /dev/null
> +++ b/test/py/tests/test_smbios.py
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +"""Test smbios command"""
> +
> +import pytest
> +
> +@pytest.mark.buildconfigspec('cmd_smbios')
> +@pytest.mark.notbuildconfigspec('qfw_smbios')
> +@pytest.mark.notbuildconfigspec('sandbox')
> +def test_cmd_smbios(u_boot_console):
> +    """Run the smbios command"""
> +    output =3D u_boot_console.run_command('smbios')
> +    assert 'DMI type 0,' in output
> +    assert 'String 1: U-Boot' in output
> +    assert 'DMI type 1,' in output
> +    assert 'DMI type 2,' in output
> +    assert 'DMI type 3,' in output
> +    assert 'DMI type 4,' in output
> +    assert 'DMI type 127,' in output
> +
> +@pytest.mark.buildconfigspec('cmd_smbios')
> +@pytest.mark.buildconfigspec('qfw_smbios')
> +@pytest.mark.notbuildconfigspec('sandbox')
> +# TODO:
> +# QEMU v8.2.0 lacks SMBIOS support for RISC-V
> +# Once support is available in our Docker image we can remove the constr=
aint.
> +@pytest.mark.notbuildconfigspec('riscv')
> +def test_cmd_smbios_qemu(u_boot_console):
> +    """Run the smbios command on QEMU"""
> +    output =3D u_boot_console.run_command('smbios')
> +    assert 'DMI type 1,' in output
> +    assert 'Manufacturer: QEMU' in output
> +    assert 'DMI type 127,' in output
> +
> +@pytest.mark.buildconfigspec('cmd_smbios')
> +@pytest.mark.buildconfigspec('sandbox')
> +def test_cmd_smbios_sandbox(u_boot_console):
> +    """Run the smbios command on the sandbox"""
> +    output =3D u_boot_console.run_command('smbios')
> +    assert 'DMI type 0,' in output
> +    assert 'String 1: U-Boot' in output
> +    assert 'DMI type 1,' in output
> +    assert 'Manufacturer: sandbox' in output
> +    assert 'DMI type 2,' in output
> +    assert 'DMI type 3,' in output
> +    assert 'DMI type 4,' in output
> +    assert 'DMI type 127,' in output

This fails on coreboot:
https://source.denx.de/u-boot/u-boot/-/jobs/771654

--=20
Tom

--z+ynFSzzXmRPMumA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWm/X8ACgkQFHw5/5Y0
tyy3PgwAlBpgtQqUOCs6UWSQvMYcPjZxRw+hbyeEn0pCpe8hdoHGcokEPUrpHrSb
Bw4wIgvF6HBXxCCcD6B8odAJugsHqUpyli0wvX+MVg2WYiyabMcJ2wJNLWYh9T+J
9bl6k0mjQ6zaF9SL1O0YBwaHI4nDWme6pDiLlVdwavV0SxBL3JsN7vXnZEjQpPFO
2ZHU2uFc+zrxUNmYUAyszoVI4zfC883+i2NvhNTGJ5iIXXG4IRPrjb+BFZhAVRRf
9pOs9MCHra7QGpvJfBawN+Yh9rqED8Cv2nbp1p8uGOhdZVbwSaBNK6qrRSaYNQDj
zBdwHOzT6kP5X3AfvoSdmFBG0Fej/Yj01vIGQnP1TqKFhfDSmwARcVxDQoxQ6fVx
yAR4dP+jrOawnY32L7Cgvf9dXIkdQTclskVbcfkqv7K/bEcjLwOpUDDZMTcRWtb9
GvMYWLIoq8y/oaVbfDmXkOFboa3pQMsSBPypR+/aZ7DvugTu+blHZURXi/JKV4w8
ohQV4oEw
=30hz
-----END PGP SIGNATURE-----

--z+ynFSzzXmRPMumA--
