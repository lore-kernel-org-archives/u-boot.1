Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31347E7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 15:19:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 157E8892C6;
	Thu,  5 Dec 2024 16:19:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pa4EN6YR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 034C789506; Thu,  5 Dec 2024 16:19:31 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADBB68922D
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 16:19:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7b65f8cb347so134499185a.3
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 07:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733411967; x=1734016767; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QlaYX94CwVQebKOskmXgNMPQsSzDNQ0G6gOWL+G1frA=;
 b=Pa4EN6YRrYyGH+GPO55BecdKg0AfDurDILlVp9KkMG6T+7D2Lc3+qa4y/VMUjUaoiZ
 sY9azzn+o+fvkRuBC+ur+vzWUsECVAr4Hgzgtwy9Qj9qVNHMWoicUncAyhXSPtW9tcbn
 N/URRhFy2gTHJt+w/wg2QdCX6i60/rdNUR23c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733411967; x=1734016767;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QlaYX94CwVQebKOskmXgNMPQsSzDNQ0G6gOWL+G1frA=;
 b=rat7viztA17g09eBgHBOHnWYDteqJwusRb1//AZxZurKg2mSd6HavTUqIH/OZnVxfW
 zJMiBfIgQDN6AuR3H256oGSE5jXvErRdRTpAEuO3d5u4Pr8eyHC2oP8X2wmVfcNw0504
 iojxmTIt4L6YtTrGWQ0IEay9ElDzPMHj42TkUbrCaMSoUQe4Z/0mqsUwJVCy+O3ejztv
 JNBhBhFFBEPOTQnqJLkYUqxEPCtTULrS+RgN4/95bKeGG4gAff2/XlBG6w4SAQ8kG1zy
 7luOFcZQB7/23ECfKZeY0X1X2EMv3LrV6pMj3bJMRU7BUEboZycb8KzZDyXpZ7kRiMbr
 gDaQ==
X-Gm-Message-State: AOJu0YzB6rqp87LWQ+bKp86SDnkIZyhsmmV4J9ySJLfUd4LbiyYgqYcu
 4AocZTh7a22vlZuF9/Ei0jNCmunn/rwIt9PdSQpGwNn6EFqLIry1WHnA9DNNbBw=
X-Gm-Gg: ASbGncuj/2b18PO9GhlEQNEscPL4oJJenHSxovq4HYT3OwDfY+1a2owRTJfEKCFfLy+
 y7nL8x0gZoiII3f0uBfWtFXFfJNOF7CGODe3kUo340W34XGchl7oDbEtUYkqTTgaYk9p1BfRQCa
 g8cdGHF9EFEML9/nyGn6NwNC9IdllmouITNK3e2TMF+GeZIijZUaj7GOUxhu9G3Nq8tlPzXA6SK
 AotORfvMTfeHboXv3JGd69mE7dOgzBHsRlZUrkhxY0pdkFUUA==
X-Google-Smtp-Source: AGHT+IFksE4BqaNnkGjkgeVtJJLF9QvmSdM/3bpecC7ThRD2ZYdXeBWNqQBZM2w3jxHWJfOUAX2dbA==
X-Received: by 2002:a05:620a:8907:b0:7ac:b04e:34c6 with SMTP id
 af79cd13be357-7b6a61cb803mr1272184985a.50.1733411967539; 
 Thu, 05 Dec 2024 07:19:27 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6b5a9e5ffsm68740885a.111.2024.12.05.07.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 07:19:26 -0800 (PST)
Date: Thu, 5 Dec 2024 09:19:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: Re: [PATCH v7 08/14] efi_loader: net: set EFI bootdevice device path
 to HTTP when loaded from wget
Message-ID: <20241205151924.GL2457179@bill-the-cat>
References: <20241204030530.2099776-1-adrianox@gmail.com>
 <20241204030530.2099776-8-adrianox@gmail.com>
 <20241205013018.GA1377816@bill-the-cat>
 <38d341ba-7690-496e-bace-60604219f174@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JjVOHcfaZikjYqEE"
Content-Disposition: inline
In-Reply-To: <38d341ba-7690-496e-bace-60604219f174@gmx.de>
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


--JjVOHcfaZikjYqEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2024 at 10:00:11AM +0100, Heinrich Schuchardt wrote:
> On 05.12.24 02:30, Tom Rini wrote:
> > On Wed, Dec 04, 2024 at 12:05:23AM -0300, Adriano Cordova wrote:
> >=20
> > > Set the device path of the efi boot device to an HTTP device path
> > > (as formed by efi_dp_from_http) when the next boot stage is loaded
> > > using wget (i.e., when wget is used with wget_info.set_bootdev=3D1).
> > >=20
> > > When loaded from HTTP, the device path should account for it so that
> > > the next boot stage is aware (e.g. grub only loads its http stack if
> > > it itself was loaded from http, and it checks this from its device pa=
th).
> > >=20
> > > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> > > Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >=20
> > I know this is applied now, but after re-checking some things in one of
> > my labs, this breaks test_efi_helloworld_builtin on rpi_3 at least (and
> > possibly others). There is no output from "bootefi hello".
> >=20
>=20
> Hello Tom,
>=20
> None of the Raspberry Pi 3 related defconfigs enables bootefi hello:
>=20
> rpi_3_32b_defconfig # CONFIG_CMD_BOOTEFI_HELLO is not set
> rpi_3_defconfig # CONFIG_CMD_BOOTEFI_HELLO is not set
> rpi_3_b_plus_defconfig # CONFIG_CMD_BOOTEFI_HELLO is not set
> rpi_arm64_defconfig # CONFIG_CMD_BOOTEFI_HELLO is not set
>=20
> Which configuration have you been testing?
>=20
> Please, supply the .config and the related test log.
>=20
> I just tested pinea64-lts_defconfig with CONFIG_CMD_BOOTEFI_HELLO=3Dy and=
 get
>=20
> =3D> bootefi hello
> Card did not respond to voltage select! : -110
> Booting /MemoryMapped(0x0,0xbdfbe9b0,0xbdfc1b60)
> Hello, world!
> Running on UEFI 2.10
> Firmware vendor: Das U-Boot
> Firmware revision: 20250100
> Have device tree
> Load options: <none>
> File path: <none>
> Boot device: /MemoryMapped(0x0,0xbdfbe9b0,0xbdfc1b60)
>=20
> So there seems to be no generic problem.

For testing as much as possible, I do enable a number of additional
options (as well as building them with clang). In this case, please try
also enabling CONFIG_CMD_WGET. I've narrowed my config changes down to
adding both CONFIG_CMD_BOOTEFI_HELLO=3Dy and CONFIG_CMD_WGET=3Dy to
rpi_3_defconfig which results in:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D test session starts =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
platform linux -- Python 3.11.2, pytest-6.2.5, py-1.11.0, pluggy-0.13.0
rootdir: /home/trini/u-boot/u-boot/test/py, configfile: pytest.ini
plugins: forked-1.6.0, xdist-2.5.0
collected 478 items / 424 deselected / 54 selected

test/py/tests/test_efi_fit.py s                                          [ =
 1%]
test/py/tests/test_efi_loader.py .....F

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
_________________________ test_efi_helloworld_builtin _____________________=
_____
test/py/tests/test_efi_loader.py:208: in test_efi_helloworld_builtin
    assert expected_text in output
E   AssertionError: assert 'Hello, world' in ''
----------------------------- Captured stdout call ------------------------=
-----
U-Boot> bootefi hello
U-Boot>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D short test summary info =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
SKIPPED [1] test/py/conftest.py:620: .config feature "fit" not enabled
FAILED test/py/tests/test_efi_loader.py::test_efi_helloworld_builtin - Asse=
rt...
!!!!!!!!!!!!!!!!!!!!!!!!!! stopping after 1 failures !!!!!!!!!!!!!!!!!!!!!!=
!!!!!
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1 failed, 5 passed, 1 skipped, 424 desele=
cted in 27.01s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--=20
Tom

--JjVOHcfaZikjYqEE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdRxHcACgkQFHw5/5Y0
tyyQrAv9Etlmuc0g9wETlLb8sWbhqqcpbeDTxBRNXh2VvuSbubrcW3PpF9lAdRAX
lWZ1ckcpAQhKg8vwy01rjOt//+7+Fm7ZMeDvBJJ13IHG2VvHnjib56JeDNlvdnEV
hw92UWxhzpoEjP3Xkoiz3qZ/Ia8tpGSWSD0wNs1QKdGDIz7Jb5lCh9DlCuRXvR5+
y/R0mUWXaIwjaR/QJ78RorHMspMLgROLlktatKrNpIheGDnzzFnlm+sWgaEM4JuU
Kop275P3bnCmuqxoIdbR28Ys+f8DK1AuimRXmQvHrtcvsO3kjh1EbRDbAQUWAPrU
3/c/U9boMyGzL0YssWgfcC6k4ndObhQYTqkfMEatmiuzupuNgwsn362cy4JtSXIM
UyLLvtSdhMJxQkvYeGl2Yzk2aUTWmCT3zxdzJEKAdsk3Ty2bsvFOlGFSBBjrvoKg
LrkAl3LypF/ubQ4J5k1FhwO0c4UVfoIW2pCYyYLsTTW4bAKMibrTfzImxSEadZjY
7lzOQ6Ij
=KIRy
-----END PGP SIGNATURE-----

--JjVOHcfaZikjYqEE--
