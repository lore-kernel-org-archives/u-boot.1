Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE419C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 01:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45C66806E8;
	Wed, 15 Jan 2025 02:13:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qKCJgZbh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF3AA806D6; Wed, 15 Jan 2025 02:13:50 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 903D58070D
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:13:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6df83fd01cbso25967266d6.2
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736903627; x=1737508427; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vSrpwzK421dAYRF2Jx0pbSrMpK7TfoTS1i0sXOJ/Pr4=;
 b=qKCJgZbhJsL4pV841oCtSpBIVjtHTTtRDNM9K8+9yDd0JkOshuUnvV8d8nFS2PpdOF
 +V9a5KiSzZUhessSCvGy6MxxK+g8+mPjJmnuEyY4PgVApj8M/BGfwNvgtyH6vQtKUANx
 GHPNIgw63edis0M/8fUqm6dHG/zBPwPL97XUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736903627; x=1737508427;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vSrpwzK421dAYRF2Jx0pbSrMpK7TfoTS1i0sXOJ/Pr4=;
 b=WUatKfwoyUx7ObEOvfCZYL7Sbn/aJNxroVL3Ziq24yOklzis/0nxarnG5HK2oOSUeH
 AlK5vSH5vzyHP1bayED3BSIPhVoSQDPldB78eM36JPow9h7IIOpG2RwN7UMn+zXco0Cv
 aqJYAMslfBT+gUOkXEi/JKaP8ediEweavLaWxi58UVQxiMd0Iqpj8+vBPsltUnS1+qWZ
 diHllTc0mdsqM7UCkUmIeCv0uMl9BY1+RjtzutUDlCzP/hCAUjVVjwJHyu0GTHdB1u01
 INkjvn6R/IcL4IIiBc5asV/zbna8cNJlAtPAuzB9u2FzyFfLeFqgETOpAEC4yMpNv1tv
 y7EQ==
X-Gm-Message-State: AOJu0YymFgwc1xE3c+fa+pBy0DpmU6AtDALlLMvdSaFU9v20kkGp3kuJ
 4+D325GKWsoE/IFWjggLSySkMx+hUFAonCp2p2MvepMKAujLxZEhLCXZpLmlR1g=
X-Gm-Gg: ASbGncvOlNGA1L1SujzUt0EuZfipUPe9Ooe/pNQvD6rQNzb2CcXoUPaxzrvXMF0IH6o
 vPGE77T3KR5GUwDwOBJcye4G1gPRpBEhN+B5wlGFi1ENoFu9hbp92FX2Cp+2r0IvRgjJMo/boj8
 3d7h5jhddZLcgfop5qnu6mQIBAHHRa2tlv0VrDSnR4wJu63iB1NKF5OsuNxwGQ5m5PZA5/+W/V0
 Ce5YxRnFsKW1fmv/8uQLoy1CVmqxTaVnW13ur82gAq0Q0+kyp9kzQ==
X-Google-Smtp-Source: AGHT+IEiNYLfl1sK7MZHC/HxLwYeKeG7RkR8uI2WQNrU/lBWSnshTCOsZvCH253PzrQIhgIpbVEIqw==
X-Received: by 2002:a05:6214:130b:b0:6d8:9815:92e2 with SMTP id
 6a1803df08f44-6df9b1ef95cmr424951656d6.15.1736903627387; 
 Tue, 14 Jan 2025 17:13:47 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad85f736sm59513196d6.24.2025.01.14.17.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 17:13:46 -0800 (PST)
Date: Tue, 14 Jan 2025 19:13:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 2/3] image: Add support for starting TFA BL31 as fitImage
 loadables
Message-ID: <20250115011342.GS3476@bill-the-cat>
References: <20250112223755.179959-1-marek.vasut+renesas@mailbox.org>
 <20250112223755.179959-2-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UBCbc8dAuPCmxwUv"
Content-Disposition: inline
In-Reply-To: <20250112223755.179959-2-marek.vasut+renesas@mailbox.org>
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


--UBCbc8dAuPCmxwUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2025 at 11:36:58PM +0100, Marek Vasut wrote:

> Add support for starting TFA from U-Boot running in EL3 as part of
> fitImage boot, so the user can start U-Boot in the highest privilege
> level on the platform, bundle TFA, Linux, DT into a single fitImage
> and boot such a bundle as a whole.
>=20
> There are two main benefits of this approach. First is the ability
> to run U-Boot in EL3, where it has unrestricted access to the entire
> system and can act as a useful debug tool, as it was always intended
> to be used. Second is the ability to easily and safely update of any
> component in the fitImage, be it TFA, Linux or DT.
>=20
> The boot process is similar to regular Linux with DT fitImage boot
> process, except the TFA has to be bundled into the fitImage. For the
> bundling instructions, see below. The TFA is started as a 'loadables'
> with custom U_BOOT_FIT_LOADABLE_HANDLER and armv8_switch_to_el2_prep()
> handling implemented in board code, and performing the handoff and
> boot in case the TFA was loaded.
>=20
> The loadables handler is optional and meant to set up any sort of
> handoff structures used by the TFA BL31 or perform any other setup
> that is needed by the blob. The custom armv8_switch_to_el2_prep()
> has to implement the jump to TFA BL31 with return to U-Boot just
> before booting the Linux kernel.
>=20
> Example fitImage image and configuration section:
>=20
> /dts-v1/;
>=20
> / {
>     description =3D "Linux kernel with FDT blob and TFA BL31";
>=20
>     images {
>         kernel-1 { ... };
>         fdt-1 { ... };
>         atf-1 {                  /* This is the TFA BL31 image */
>             description =3D "TFA BL31";
>             data =3D /incbin/("../build/plat/release/bl31.bin");
>             type =3D "tfa-bl31";
>             arch =3D "arm64";
>             os =3D "arm-trusted-firmware";
>             compression =3D "none";
>             load =3D <0x46400000>;
>             entry =3D <0x46400000>;
>         };
>     };
>=20
>     configurations {
>         default =3D "conf-1";
>         conf-1 {
>             description =3D "Boot Linux";
>             kernel =3D "kernel-1";
>             fdt =3D "fdt-1";
>             loadables =3D "atf-1"; /* This is the TFA BL31 loadable */
>         };
>     };
> };
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--UBCbc8dAuPCmxwUv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeHC8YACgkQFHw5/5Y0
tyyGLQwAjA3enSudTPCAh5yZooilBNfaFzSowVRVS3nhwOf+VWrPLqX/GPuiO/X3
eVinCtgOxxYZw5XSEWaQrfRX0fCgvgTBfZ1t1W0+kmgwp9g+A7KBDTCJ3igzJU61
L4rdskd691PUW6YeF7pakp3pec4cwMf204gONQ0SaJDSRZzsz+y1FG6d10Q3oBi9
kzqowAt4Q7k2WoRmN8zcj3RfuvsJdKD6mg+VL1xJkv0SR3NQOvTTQtH+yLp1hrd1
6miCGodMwQvbyTObwUcc7uTwFfMPhladTbxsUA2Z92/cHgHIAbP0OGSrYKhawvAI
DIlKo+5nVYDJGVKWFQ/nijfOAhsN182e79z2prrF3mWNZMdtQhl0BvZfI58N3Ple
LaGtVBMVX8aQP/ky+Wnml6TxTf2iT4vTwUgBf3WaDFcPG9DizDG4Lx2BQecDXpeL
M2VqzGks3JrS7K37NrfqJX+rCvjI6kihsyxEp9LJxE4axMJX43/zjw0CJk7/fLh4
6fSC1Aso
=zXGq
-----END PGP SIGNATURE-----

--UBCbc8dAuPCmxwUv--
