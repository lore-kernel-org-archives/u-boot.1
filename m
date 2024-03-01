Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FBBC5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 14:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F2E687DCC;
	Fri,  1 Mar 2024 15:53:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YGaEzLn8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0125D88147; Fri,  1 Mar 2024 15:53:35 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4ECA87D31
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 15:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-607e54b6cf5so15507767b3.0
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 06:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709304811; x=1709909611; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U/zyJBChe8CTTWhEP6TesClfdCRv6Th8qXLDI3VudQc=;
 b=YGaEzLn8/Kgs3ia+kI2fJ4Y5nNIsYNLYDjtd+FkvAFOLUUdzqOgo2egdP53dDN8Pj7
 VoG5nRhraiRSIQBO5Tcc4fZx/wTY0TEulDG6hjQuGbTmUbsRuNNEOX2WB2qrWRmsQF5k
 CcPUqdhZ7mDA4nvmWjcTMWDXprrmP20/4ibHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709304811; x=1709909611;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U/zyJBChe8CTTWhEP6TesClfdCRv6Th8qXLDI3VudQc=;
 b=v35qA4gT8Cxct4lGbjUIE/RaPmtY/yw+1lyE2Yo9Pqm7onW/2YqjUg5RQaka055eGN
 2+WDFQJszcuO+0QOs+TMiw2r4bB8GKjelMr48jEIbtbOEFqtJa2HMj2/YgR/f6mRiEaE
 0FW5kzcRGC99K5emEEp6Iz+bzWX/W0v59dfyaEt5L8UusoAOeN6FpYY9YwYP+nrnpMEe
 rQw17DYh0XkqPb7pVVlzK2ToazWiPmF6VsAfO4DDnZSnYE6WnGn6dsbYIdSoGTfCslmq
 MUdwhgnx7GY0ZN/onYxYl1Tt2EbpneJzNshxJqJXjNRvi9t6Bm6X4z231KCUtYhZ5607
 ClJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8Izpz5xglsQgk3nmpRmduC2cTdrXhfTiNlNYkYJH1FZ+G6VGPJPuWBbSuVjufIlFPxr6KQzwXj0BXMX/0aB+0FXOWLg==
X-Gm-Message-State: AOJu0YxIN5r8hv7FW3K3xsQQN6+yQUOXbeiAHWQwTioujRtKIlNkUG/x
 nYIKXPEsA+f2PkoD/qjgdcvGGEysXWON6K8luKDEuXKNPMCxdOE2DV10d0jlGXk=
X-Google-Smtp-Source: AGHT+IHdLYBvfx81XtAs/g2W9U3nUJk7gju0vwf8AD/YbxgIP58szvxT+3RgHLn5TMuWAR/jxSGjSw==
X-Received: by 2002:a05:690c:fce:b0:609:72a8:13b8 with SMTP id
 dg14-20020a05690c0fce00b0060972a813b8mr1449829ywb.1.1709304811497; 
 Fri, 01 Mar 2024 06:53:31 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 j14-20020a81ec0e000000b006098d0face4sm19282ywm.25.2024.03.01.06.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 06:53:30 -0800 (PST)
Date: Fri, 1 Mar 2024 09:53:28 -0500
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] test: dm: add button_cmd test
Message-ID: <20240301145328.GZ3040305@bill-the-cat>
References: <20240214170357.4091708-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hby99150cRQGImIM"
Content-Disposition: inline
In-Reply-To: <20240214170357.4091708-1-caleb.connolly@linaro.org>
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


--hby99150cRQGImIM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 05:03:46PM +0000, Caleb Connolly wrote:

> Add a test for the button_cmd feature. This validates that commands can
> be mapped to two buttons, that the correct command runs based on which
> button is pressed, that only 1 command is run, and that no command runs
> if button_cmd_0_name is wrong or unset.
>=20
> CONFIG_BUTTON is now enabled automatically and was removed when running
> save_defconfig.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Locally this fails:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
______________________________ test_ut[ut_dm_dm_test_button_cmd] __________=
____________________
test/py/u_boot_spawn.py:195: in expect
    c =3D os.read(self.fd, 1024).decode(errors=3D'replace')
E   OSError: [Errno 5] Input/output error

During handling of the above exception, another exception occurred:
test/py/tests/test_ut.py:509: in test_ut
    output =3D u_boot_console.run_command('ut ' + ut_subtest)
test/py/u_boot_console_base.py:266: in run_command
    m =3D self.p.expect([self.prompt_compiled] + self.bad_patterns)
test/py/u_boot_spawn.py:204: in expect
    raise ValueError('U-Boot exited with %s' % info)
E   ValueError: U-Boot exited with signal 11 (SIGSEGV)
------------------------------------ Captured stdout call -----------------=
--------------------
=3D> ut dm dm_test_button_cmd
Test: dm_test_button_cmd: button.c
BTN 'button1'> env set test_button_cmds_0 PASS
BTN 'button1'> env set test_button_cmds_0 PASS
BTN 'button2'> env set test_button_cmds_1 PASS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D short test summary info =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
FAILED test/py/tests/test_ut.py::test_ut[ut_dm_dm_test_button_cmd] - ValueE=
rror: U-Boot exit...

On top of current master.

--=20
Tom

--hby99150cRQGImIM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXh6+YACgkQFHw5/5Y0
tyy8swwAqDDez3ZK/SSQysL290U5SkvJeuKg4LzDsyiycPV9kpVJNEvAPzHFKM+Q
D339EfcE7nkTOTrgveFknds8szzmtphxaaFb3fISr6LUufk0UHWuaZBfXcz47txN
NQb4/UF37EN+6d5E1SSwxb1YPJK7CaIi2XLWsBVwXstmv8GGnPsil6CKs/hAnXsh
OIjNJH1cxGGkd38qV4eTom8P6IEzkeKSXCLsIElmEAdc8aKo3UAFji3aiLdCmwv7
SWBg5rWRt6JobQPBWkQS6mZbUfivpQzxGIVSD8GRDIj9hnzqWmh2agoYoOQ/QcSZ
A0OfOI5yC4atSyGIBdschD6g49AZQ55Qog3z634TFTQe6GmIZD8bBspyz1fQpHsq
1licPdpmZbxOuILyo304Y/IbWl2Hy9iDIl6WOemjOU9HsLBjQF9gBBtsJ2MfH//Z
nB7Vp+y//ZYtL9nbsYPtGIjfZ94v+8WHwngl3y7WaE8ETSV9D8sI6JtI6e+s/eha
bzNrS+tl
=BMlx
-----END PGP SIGNATURE-----

--hby99150cRQGImIM--
