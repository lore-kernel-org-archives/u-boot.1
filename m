Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B62ACD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 23:47:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3F72846E2;
	Thu, 28 May 2026 01:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IR3BY/WF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB49D84704; Thu, 28 May 2026 01:47:21 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A833C846D1
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 01:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-69d8b7aeeecso1815727eaf.1
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 16:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779925638; x=1780530438; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7RwwHBRlBZO84Dipnj5ZRiUnQvM88Uo39nksTzatorY=;
 b=IR3BY/WFeicpQaocsfdNhkyLAdIIW+DtsgTxy22n6TY8xhoF0/nEoflsvr9oQK2/Em
 LawFlrFKhIOmCXdN5TV9bPkUSzMjmlA68VggcUHV4cYH8iphzVpFpflK463KrFCy0c3U
 85/0Fx4gt7WO2g6hAlizacqwbo3fSIiY/e3FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779925638; x=1780530438;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7RwwHBRlBZO84Dipnj5ZRiUnQvM88Uo39nksTzatorY=;
 b=VZmD1a9Cbd4u1p4RtK5JKArOn2ykzbKus0WB0qyIe7s3IvDK3V3Onlel6f86Mr1fEe
 SFdZ9LR5Y5GslS/w3of64KMVGjZjLxDWo5VazKldWo5msNqcMiHxlnlsy+o6vj2qNOoC
 euKU9DplHENWDFmoMMjm206DGq17MMslk69yZFhW5Uib4tFBsxsuEzvrub6hqIP5xrA/
 65OhdStYUjs107gd/TsOLHT1VtOgfrFp1SNJ1BOd6akqPSfGEbhPYuY8BwsXno4TmBne
 I8wu/ynjAs3jCghtA8isCMlxj9ObnmpQ38RHarJI6u0pBSrUAJVW0SpPk2LjD7t3qSwf
 5Khg==
X-Gm-Message-State: AOJu0YzvqQVAolM4Mb5GZfWaGzmW06x/jBKJs41UvC3GSC5kB26J7er1
 RseEbBE4ABsENEOdb9yKSoh7e/HGuk6MojAXiq3G4ynXgO+BItsADpXa2DuGc/XCKF4=
X-Gm-Gg: Acq92OGuuidtS1K99LnK0zBJ/55mkU6BZquatMqRivb/t9RtDoX258enQEogHxPUi40
 4/k91MpYrgxRCLCAkXYI1PJQprz1tK3Cw4bzLbqRo5EnIR5+3pFFKG5+vrokHypihP05UBTfU3F
 4mIEdlxgjFdNsGZ6KBYJnzc1+gcRKf78CKSuvToYlvbus+7XQDN2klPNqDl7YnvEpyc0a9WM+Q6
 MKjJ9rrXbkehKl9X/3k/mrcB4Ei4nWn9xnPM5IaMyDErfWGlBZf/2y2UfVYosZbkJXoXVgivbV2
 ywTQzq2SGC+szDr/cEhTlTCTa3RSenMCGy2zkzjjl4oB/PaqiSANu6DnotJM4t3cELnQBhZMkXA
 5FkEtoi3Zubkurn4oljDrwdaqYhsIyFe6GYJknCp9ZJqKPiu1grsV2GQp51+8tzXfNHrNjDlgYf
 fA7ZTQPwZ8dynL77Szk4+D+F2sWIPTWM2Tn5oJLL4X4kujuF8mfJk+q/x3sYM4/Zkl3pMDTbL+S
 rronP/MoX1vqaE3hkZR4dmXG3q6oW0dh0nX8XSJS5OIGxXzg10JruHW
X-Received: by 2002:a05:6820:c3c3:20b0:69d:50f5:eb0a with SMTP id
 006d021491bc7-69d7eb50134mr9035030eaf.20.1779925638418; 
 Wed, 27 May 2026 16:47:18 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d83700d55sm8782515eaf.4.2026.05.27.16.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 16:47:17 -0700 (PDT)
Date: Wed, 27 May 2026 17:47:15 -0600
From: Tom Rini <trini@konsulko.com>
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org
Subject: Re: [PATCH v2 6/6] tests: reset: add cold/warm reset types
Message-ID: <20260527234715.GC93986@bill-the-cat>
References: <20260527231306.1714741-1-dmukhin@ford.com>
 <20260527231306.1714741-7-dmukhin@ford.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Zuf2upE4dzGtLWKy"
Content-Disposition: inline
In-Reply-To: <20260527231306.1714741-7-dmukhin@ford.com>
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


--Zuf2upE4dzGtLWKy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 04:13:06PM -0700, dmukhin@ford.com wrote:
> From: Denis Mukhin <dmukhin@ford.com>=20
>=20
> Extend reset tests to cover both -c/-w reset command flags.
> Make sure sandbox reset tests are passing.
>=20
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> ---
> Changes since v1:
> - new patch
>=20
> Test for sandbox:
> ./test/py/test.py --bd sandbox --build -k test_reset -v
> ---
>  test/py/tests/test_reset.py        | 8 ++++----
>  test/py/u_boot_boardenv_sandbox.py | 3 +++
>  2 files changed, 7 insertions(+), 4 deletions(-)
>  create mode 100644 test/py/u_boot_boardenv_sandbox.py

I'm not surprised to see we could put a u_boot_boardenv file there, but,
that's not where it should be really. I think for now we can just keep
the reset test on the list of tests not running on sandbox and address
putting a u_boot_boardenv_sandbox.py file in the u-boot-test-hooks
repository as a follow-up.

--=20
Tom

--Zuf2upE4dzGtLWKy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaheCfwAKCRAr4qD1Cr/k
CjgkAQDTPb7S8vE17ZR/GdQB0ORajt2GSULeCpvI8FGnJ7sYggD9H5SPae1gBfLR
vYhMGjHlEjlULR+570Dhu8HVXqQL7AY=
=mFtf
-----END PGP SIGNATURE-----

--Zuf2upE4dzGtLWKy--
