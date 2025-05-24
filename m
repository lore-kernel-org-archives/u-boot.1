Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E6BC54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 14:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C59E683443;
	Sat, 24 May 2025 16:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f1qZ1BN/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C44B383327; Sat, 24 May 2025 16:23:13 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94E4D82AE2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 16:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4033c89f2aaso611574b6e.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748096590; x=1748701390; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xjmReKXqApC8FrYJRBp6BOEhG+LC2UHEGz2rmiTvQlQ=;
 b=f1qZ1BN/qyZsioHdwFpRZjlZ+qcm6KXu03PCmezYcK3O03mpl6r4CWWKE49VI0zEOD
 wADh+4wt/E/OTMIwoStxcZhwk3KqZzhtkVq+6sldZbfEC9O8cNMAd8coaFTcMM5GoZE3
 VJ4/q7nZkBjbE0EdFCWDk7TlGeu6j6zDuMS0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748096590; x=1748701390;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xjmReKXqApC8FrYJRBp6BOEhG+LC2UHEGz2rmiTvQlQ=;
 b=cH1X2C07VN+FE6FDn5xDuBYwX6Lk8Yn3aIQ6GNw1CX9HZGQgbKg4S+hHSqveD2yf63
 X5vpg9PRGLKI1aeNdmKH5tDwPNjjzPe37wvpns4Z346sMLIG1izSpceypA43PhrzkAdW
 /L+Q9xYIY/SnmWVwMJFC6K3j6PjK9skBUrM+jWN6GzkUkYoPInaKRwKm85icpPTB6IfJ
 2bsBKuLCk/UYvxx3+dUASFEDAsxSS/5ojmy2duV808+dxUlrDMQLAWZCz0Rk/sJ68+Tq
 91D89ErwZeJsINLG5OkY2pbch96a5n7XCqGorWDPo6hSs8Kr2BlZebIkqpErfMP4ldcK
 If7w==
X-Gm-Message-State: AOJu0Yxll+WiR5UOMlOcTu6KrLn/KaYEPrAyZRlF0CahyRtZrq/uB+jh
 dMMyi5iKrqkEgCzLvr5IYJa76LqzwC9+3MjLBwo568J6bZN4PwZpAzFe4qp4YbclHQo=
X-Gm-Gg: ASbGnctROh64ejEFt7M6v1juNT+7QLLjsXrRAbBzSBcG4h+AwW0W9rwrlZAX+NYpKIV
 DClW3Pe/7VkbLJIvrBIZuGUg96VVnClqSNpWi6ectQdxi4DdaNpfMALMIyvPFT3OwxuGay3648j
 Ri7Hq2ORVkz0xC8RKvy2nwxjV+qAQDFuRTAsDALpJYnVMIBLEuPXA3bHaXOJlfE24r5czP578cS
 21xT09W45bjImnFYkIdblQ79XkKKo/4775kAE+Z4PYSpbLkB2CW1SS6r6Ndn3y1Gfk3cBHpOQ3p
 Z1kSwPcn2bezJ6dw17xQebndXPucNNXPCPuzGrgHJWpAQmq1H9TTJBsYk+NkDqV+LlQmEvJQtO6
 2u0X/QtRKRHBv
X-Google-Smtp-Source: AGHT+IFflE4s7F0e0jwZ1UviEqMhg33RLWP/Qfers8PbftNAk+VHjz3xyPzfiGwfJD2W/MOl8ZInmw==
X-Received: by 2002:a05:6808:1c09:b0:403:43d0:5119 with SMTP id
 5614622812f47-4064681f766mr1721395b6e.23.1748096590327; 
 Sat, 24 May 2025 07:23:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-404dbf2e328sm3371714b6e.37.2025.05.24.07.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 07:23:09 -0700 (PDT)
Date: Sat, 24 May 2025 08:23:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v3 0/4] tpm: Start to tidy up TPM tests
Message-ID: <20250524142307.GE100073@bill-the-cat>
References: <20250524130642.902486-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nrgqTtC8kRg0fWFH"
Content-Disposition: inline
In-Reply-To: <20250524130642.902486-1-sjg@chromium.org>
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


--nrgqTtC8kRg0fWFH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 07:06:33AM -0600, Simon Glass wrote:

> This series is a starting point only. It tries to provide some direction
> for how the TPM tests should be run on real hardware and on sandbox.
>=20
> For sandbox, things are relatively easy since the TPM is reset before
> each test. Tests should start up the TPM before doing anything. Tests
> can be run in parallel, which is fine because tests are independent.
>=20
> For real hardware, tests cannot be made independent, other than by
> resetting the board, which if the hardware is correct, resets the TPM.
> So there may be more work to do to figure that out. The approach taken
> in this series for real hardware is to have a few tests which do init,
> then have the rest of the tests assume that the init is done. Tests
> that depend on the TPM already being inited can use 'tpm autostart'
> which works OK on sandbox and real hardware.
>=20
> Changes in v3:
> - Use 'check' instead of 'test' when naming test helpers
> - Add missing tpm_self_test_full() call
> - Add new patch to skip failing tests on coral
>=20
> Changes in v2:
> - Keep test_tpm2_continue_self_test()
>=20
> Simon Glass (4):
>   tpm: sandbox: Support self-test continue in emulator
>   tpm: Convert sandbox-focussed tests to C
>   tpm: Drop unwanted special cases for sandbox
>   test: tpm: Skip failing tests on coral
>=20
>  drivers/tpm/tpm_tis_sandbox.c |  1 +
>  test/dm/tpm.c                 | 77 ++++++++++++++++++++++++++++++-
>  test/py/tests/test_tpm2.py    | 86 ++++++-----------------------------
>  3 files changed, 89 insertions(+), 75 deletions(-)
>=20
> --=20
> 2.43.0
>=20
> base-commit: e3ced530e543c9f24cbc66430abc6109ce8df015
> branch: tpm3

This is not based on mainline, please stop posting things like this.

--=20
Tom

--nrgqTtC8kRg0fWFH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgx1koACgkQFHw5/5Y0
tyzEowwAgroDB3m+8tMXcpnJ6KkrxRriRTr/8QK0TD0s0UyAC+VAr4HcvnbLXj9g
WHgGm95OLPNG6WUN216DQELITSJqdSeHOdFSlDyYc66LpsxUNyLZPR5QUWkWiOUx
PJ6If19YAwgmZ/6T2Tmndj1k0sMJGkHqJSbfqiYrKK3wPq83jIaaUZIybKxcGiFs
VdzkWjLsL0jfJXabjCq2MRbTWshL15sfQzcMjrDlkJ/21oetkucyhORj+h7Kp1VC
YW4gFI+/BHpq+NkN8rQRmPaZeYmgy/r5dQLgQcThuJrX/7Galp+PvSfjrf0IEs52
DNDlMTKcYseYSYlZ5M//f8iyqFkyqEHsU9o4q2J1ho4kM9OIQJo+OcWOkcsL/yxc
0GrBm6hUIdimRhYqj1bqW8mKgcUqye4UupZNDOtJzdAHh9UmPRpTfNW9lEW0Vsm8
5omhCw9YU33evCJFVsOj13DW5mHz5uwhkG5ck4ZvDMl+Hp4TeZEn3hA6wSRovqKi
tJ8SMTWy
=NMMB
-----END PGP SIGNATURE-----

--nrgqTtC8kRg0fWFH--
