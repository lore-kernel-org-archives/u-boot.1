Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA98C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 14:33:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50EF28750C;
	Sun, 29 Oct 2023 15:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e2qIOVoi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 671B18764E; Sun, 29 Oct 2023 15:33:40 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40D6587172
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 15:33:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-d852b28ec3bso2950157276.2
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 07:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698590017; x=1699194817; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yaI+M2fDAzsfBfDthaoIfiZaSfXHwMsc+csus2qx0bs=;
 b=e2qIOVoilf2VMaj0F/O0oAekXh0lSh9xhkoMt8x9owpyL3zRIS6Q7N8CUmjLa7AbrE
 erEXBveBM4pX3LlFlC6dnYmJ3Z0yaeLJxt/t+dy+mY7vYzKPvwrvQvcuz7g5fRyo0DFX
 EZbxhZpHewDIprwEqVjcuupScMbD4T/9wVmU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698590017; x=1699194817;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yaI+M2fDAzsfBfDthaoIfiZaSfXHwMsc+csus2qx0bs=;
 b=oe/EoM8xoAvunrUBLZ0DduDceSHiK6iTAXK2IzbWv0b+uYrSosxxW3K3vvlS4zOH/t
 kYh+Q3VfB88YUHRC2bdThMVtbsRlJJpuikX9AJRqKF43HEnYkLvjfCO6lG5W1BmiaU5q
 wVufj88CJr+vUaZfKqf/VcYC8keTn7Ak7EHs2u00cqaLmUk9OtV1j1oY6M+dei/oWSRn
 16BVhAx/r0ORGxkQmX44QWtmUxbCG3t4Et8GELwNM7f9/ASNP5jYaMzXTCmC80Eims7T
 ban9ez43pvlBU5cSRqnTt2eSju4JR5dFT/lJcZ9E8GMKnSzxLgnwZ+ynxXkrbpl0hRGf
 zcvQ==
X-Gm-Message-State: AOJu0YzduNxJdNhIkwOGugOarqaz5pL9DlPjNX/2FlUjnwMUHFqG5/nf
 GpobTvHKzpLL5P+BXS72vVvA3g==
X-Google-Smtp-Source: AGHT+IHGNEfjBFx0PtumJtGm4o+gYk9UpIi/+WRUuwFaMSpm4EtpxaMGxUSaauSrB08fsQ4ie5D5lQ==
X-Received: by 2002:a25:cfc2:0:b0:da0:c746:386c with SMTP id
 f185-20020a25cfc2000000b00da0c746386cmr7062448ybg.51.1698590016901; 
 Sun, 29 Oct 2023 07:33:36 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 px1-20020a056214050100b00655e428604esm2564939qvb.137.2023.10.29.07.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 07:33:36 -0700 (PDT)
Date: Sun, 29 Oct 2023 10:33:34 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 2/3] tpm: Convert sandbox-focussed tests to C
Message-ID: <20231029143334.GS496310@bill-the-cat>
References: <20231029042817.3938657-1-sjg@chromium.org>
 <20231029172813.2.I8ff77e0c1288f6a4da564e9454eb223f72809839@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rypkj4e+DO8uRT3+"
Content-Disposition: inline
In-Reply-To: <20231029172813.2.I8ff77e0c1288f6a4da564e9454eb223f72809839@changeid>
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


--rypkj4e+DO8uRT3+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2023 at 05:28:13PM +1300, Simon Glass wrote:

> Some of the Python tests are a pain because they don't reset the TPM
> state before each test. Driver model tests do this, so convert the
> tests to C.
>=20
> This means that these tests won't run on real hardware, but we have
> tests which do TPM init, so there is still enough coverage.
>=20
> Rename and update the Python tpm_init test to use 'tpm autostart',
> since this deals with starting up ready for the tests below.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

I worry that we're removing maybe a few too many of the tests we can be
used on real HW (and QEMU, another real use case) in favor of just
testing them on sandbox. We can certainly have parallel sandbox-only
test paths.

[snip]
> @@ -92,46 +79,6 @@ def tpm2_sandbox_init(u_boot_console):
>      if skip_test:
>          pytest.skip('skip TPM device test')
> =20
> -@pytest.mark.buildconfigspec('cmd_tpm_v2')
> -def test_tpm2_sandbox_self_test_full(u_boot_console):
> -    """Execute a TPM2_SelfTest (full) command.
> -
> -    Ask the TPM to perform all self tests to also enable full capabiliti=
es.
> -    """
> -    if is_sandbox(u_boot_console):
> -        u_boot_console.restart_uboot()
> -        u_boot_console.run_command('tpm2 init')
> -        output =3D u_boot_console.run_command('echo $?')
> -        assert output.endswith('0')
> -
> -        u_boot_console.run_command('tpm2 startup TPM2_SU_CLEAR')
> -        output =3D u_boot_console.run_command('echo $?')
> -        assert output.endswith('0')
> -
> -    skip_test =3D u_boot_console.config.env.get('env__tpm_device_test_sk=
ip', False)
> -    if skip_test:
> -        pytest.skip('skip TPM device test')
> -    u_boot_console.run_command('tpm2 self_test full')
> -    output =3D u_boot_console.run_command('echo $?')
> -    assert output.endswith('0')
> -
> -@pytest.mark.buildconfigspec('cmd_tpm_v2')
> -def test_tpm2_continue_self_test(u_boot_console):
> -    """Execute a TPM2_SelfTest (continued) command.
> -
> -    Ask the TPM to finish its self tests (alternative to the full test) =
in order
> -    to enter a fully operational state.
> -    """
> -
> -    skip_test =3D u_boot_console.config.env.get('env__tpm_device_test_sk=
ip', False)
> -    if skip_test:
> -        pytest.skip('skip TPM device test')
> -    if is_sandbox(u_boot_console):
> -        tpm2_sandbox_init(u_boot_console)
> -    u_boot_console.run_command('tpm2 self_test continue')
> -    output =3D u_boot_console.run_command('echo $?')
> -    assert output.endswith('0')
> -

I would think these are useful cases to check outside of sandbox. But
I'll let Ilias chime in as I'm just assuming.

--=20
Tom

--rypkj4e+DO8uRT3+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU+bToACgkQFHw5/5Y0
tyzuVAv7BSJzBQDYc3weWZtnKhIatT0MsXlKa+LXOIFWTlzIx0awlxvVhRpW1CKe
wVT08wFu9HJID8tSHl2nHU7D1erPIRSoDE7r0NvDIpGkgXqj843b37ztY5FSjDmd
Y92P8SQmESOUIDmn96NTwPx5do+KYa7RfRWtYKEnUEs2HRNLYVoCZqQ7w0Ca9FOK
UBST6mpEWjvBe/IkNyLCu4vCDH8Zd1GpHLo5HFyann4GLa1ke4KrbzFuOP+fsZWl
WIArNoJIaSzlq6bqC8n7oYSmm5qoaowOLZx+c5ZeXMOURXmnCO2Fg0J1+860XSPF
olbkX0clq6t83l2fBMEH0T7Qto5q3Ntyujp2I0YvmXUaL/7q/GEeVTZjQFkOlees
Dj87ckEhR9gy/98Pt0Xp+ScNj88Qe0V/9sIWNVKY6mj3Djq758a0fquNb/EaI6Ok
ChZKYPDHFf8WLYvzkR5acqzwURlmVyfz8fVq/8ghLwxpQ6sWQC9/tRPp1fVtIKvJ
0DdGNw+E
=CqYo
-----END PGP SIGNATURE-----

--rypkj4e+DO8uRT3+--
