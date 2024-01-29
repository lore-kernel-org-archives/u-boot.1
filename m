Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4CCC47DB3
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 17:54:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4C4F87C13;
	Mon, 29 Jan 2024 18:54:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Dgz1cQ63";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F1D187CAD; Mon, 29 Jan 2024 18:54:50 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6748187BDF
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 18:54:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5ff7a098ab8so29332787b3.3
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 09:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706550887; x=1707155687; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tV1GRPQ1oK1cNZajPRNuHSzs/3wdymn5YwYsdchb5PU=;
 b=Dgz1cQ63Ck+UGSYIO7Q6c8cb4vf7CE4tNjw2fm5ZM2p2FKcTSjxFlZvfKIEaIt5+hm
 z1MkFDzVhS2Y1fDSbCR/cbkKHLAwGAFkp06qenbn/r07OpZM8TuHxBkx+XO73KLIrZq1
 H+/UYFHML7B5zDJ3BS3Uo47FqHcSSSWACrCpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706550887; x=1707155687;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tV1GRPQ1oK1cNZajPRNuHSzs/3wdymn5YwYsdchb5PU=;
 b=dGbVO5WcylVjYCjTuBiYgtgwxNZieDdQ3nG7U3jGh7mj2reGpA4NHsELWTdA264ZuP
 DQv/Tnpj1+HRp6qoTVkYD9XTSaqXt43qtqPkyKEwuXjsjkMRvBXfqD9Qe1vXSOvBM4vi
 PTLBK/I3WEYbHiXEz5NFLvEIStT8bLcCLSHkJUHr5jETWBhXvSB+P+gndNqEo3/hSKF5
 QKrblVT3cmuYUPu6SUI1neXK5KGWtCdhKTm7zYp4Heb8iB+H2PIz0f1A3sZuaAYmUpJE
 8/pDEw70Gu3VgBICltXYyxfppxgZEbAHFnmCIhfAlyH1nyTOl83EKLX0fMu57xs8gBUJ
 SxfQ==
X-Gm-Message-State: AOJu0Yy00RU1CFwgIr/k0KdT+x9+URWDwftZJOrApbS7LgFVUkM+rF0X
 azjOeqMaLGqzlCsQC/YDDD7LmipX0pguEMibzVWhR7J3rPd/APFt/gec+cLnXPrnNQ6eTDEToa0
 l
X-Google-Smtp-Source: AGHT+IFbi/xDTg+IYA2GCSFSdl0SL+k+R7EuG2owgZeg48xbUMY/BwQaXP/sG7JSFOX3c2sA7CCnXA==
X-Received: by 2002:a81:c14a:0:b0:5ff:6ca0:4b19 with SMTP id
 e10-20020a81c14a000000b005ff6ca04b19mr5407001ywl.31.1706550887206; 
 Mon, 29 Jan 2024 09:54:47 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 ez10-20020a05690c308a00b005ff9154001fsm1990215ywb.140.2024.01.29.09.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 09:54:46 -0800 (PST)
Date: Mon, 29 Jan 2024 12:54:45 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH] test/py: spi: Add tests for SPI flash device
Message-ID: <20240129175445.GB1152441@bill-the-cat>
References: <b769de202357f13b1fcf43de81a3c5a36d3fc610.1705674984.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tXjbjaO6URGg5+lz"
Content-Disposition: inline
In-Reply-To: <b769de202357f13b1fcf43de81a3c5a36d3fc610.1705674984.git.love.kumar@amd.com>
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


--tXjbjaO6URGg5+lz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 08:06:54PM +0530, Love Kumar wrote:

> Add test cases for sf commands to verify various SPI flash operations
> such as erase, write and read. It also adds qspi lock unlock cases.
> This test relies on boardenv_* configurations to run it for different
> SPI flash family such as single SPI, QSPI, and OSPI.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
>  test/py/tests/test_spi.py | 626 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 626 insertions(+)
>  create mode 100644 test/py/tests/test_spi.py

This has a number of pylint errors:
test/py/tests/test_spi.py:253:4: E1120: No value for argument 'erase_size' =
in function call (no-value-for-parameter)
test/py/tests/test_spi.py:253:4: E1120: No value for argument 'total_size' =
in function call (no-value-for-parameter)
test/py/tests/test_spi.py:376:46: E0602: Undefined variable 'erase_size' (u=
ndefined-variable)
test/py/tests/test_spi.py:381:24: E0602: Undefined variable 'erase_size' (u=
ndefined-variable)
test/py/tests/test_spi.py:385:47: E0602: Undefined variable 'erase_size' (u=
ndefined-variable)
test/py/tests/test_spi.py:389:39: E0602: Undefined variable 'erase_size' (u=
ndefined-variable)
test/py/tests/test_spi.py:419:77: E0602: Undefined variable 'erase_size' (u=
ndefined-variable)
test/py/tests/test_spi.py:420:19: E0602: Undefined variable 'erase_size' (u=
ndefined-variable)
test/py/tests/test_spi.py:422:12: E0602: Undefined variable 'erase_size' (u=
ndefined-variable)
test/py/tests/test_spi.py:422:68: E0602: Undefined variable 'erase_size' (u=
ndefined-variable)
test/py/tests/test_spi.py:425:25: E0602: Undefined variable 'erase_size' (u=
ndefined-variable)
test/py/tests/test_spi.py:447:56: E0602: Undefined variable 'erase_size' (u=
ndefined-variable)
test/py/tests/test_spi.py:449:25: E0602: Undefined variable 'erase_size' (u=
ndefined-variable)
test/py/tests/test_spi.py:451:16: E0602: Undefined variable 'erase_size' (u=
ndefined-variable)
test/py/tests/test_spi.py:451:78: E0602: Undefined variable 'erase_size' (u=
ndefined-variable)
test/py/tests/test_spi.py:454:31: E0602: Undefined variable 'erase_size' (u=
ndefined-variable)
test/py/tests/test_spi.py:479:77: E0602: Undefined variable 'erase_size' (u=
ndefined-variable)
test/py/tests/test_spi.py:480:19: E0602: Undefined variable 'erase_size' (u=
ndefined-variable)
test/py/tests/test_spi.py:482:12: E0602: Undefined variable 'erase_size' (u=
ndefined-variable)
test/py/tests/test_spi.py:482:68: E0602: Undefined variable 'erase_size' (u=
ndefined-variable)
test/py/tests/test_spi.py:485:25: E0602: Undefined variable 'erase_size' (u=
ndefined-variable)

Please see .azure-pipelines for how to run pylint, if needed.

--=20
Tom

--tXjbjaO6URGg5+lz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW35mIACgkQFHw5/5Y0
tywSIQwAjTauRpDwgpkzqVQ2kGFOMqGhfwt7wDlpmXXl4HKWu1vCpCit4XUKgyx+
OW81Ki3X64TVdMMDIiOH03+xfFIerFVj7Dg9EHxMAZFg7z5+nFzhi5Ul/TFJWW6P
vEkCsgLJfhuK48/a1Uim7l77fxAFxUnSyMJGDmG4ENL4gca8o38boNUTPXJFm4fY
DuxReun1ag8bbfFsS9W2BLLQA48ic1QOBYZiOZsMr4Gnv5kB1lndJmkGnnlI4q8o
0igRHim5PZC/zhpXxiVXywVJ26Lhqa04spXcMELqRq0ZVdZ3SC7lbXI6WQVAUJR2
DQ4aUSjGzgfx/XGlDJXqpGA2+VZRPcFM5Gji2rYCRFEIEvK9WuqzLBRwCLwJld5M
hBOVDvbVVrBTwQeH2S0GtUIRnJERZO4rT+k9RIGvrOr3rQgvsVMxP0drpDals0Cr
4zK/z/WuMH40veuNwnKaFcKJxm7rg4hPfDenFgaxwEC9U6yAQjPqhCL4G3JOTRkj
2lDwf/l4
=iYOH
-----END PGP SIGNATURE-----

--tXjbjaO6URGg5+lz--
