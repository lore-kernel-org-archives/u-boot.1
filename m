Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686A2CCD193
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 21:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7A348006D;
	Thu, 23 Oct 2025 23:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QV4u9/Wp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 483F08003E; Thu, 23 Oct 2025 23:29:06 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2082C8006D
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 23:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c2766675adso819681a34.1
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 14:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761254943; x=1761859743; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eZTtW7s2C54IJwr/+yKWt9hcy7AreQVu8mbOQJHJGfM=;
 b=QV4u9/WpaeL02VABpdlORR6nb4fp0/oXtCOoOdOmfQgoRUmN11yhU2obEX7Nuj/duk
 FaE+jB5BNm4Z06zvZgAvx4Lkl/Yh7m279sU25qAudYKMSPW6IbW2omTuqXW+IAcXiHqf
 9xacjknMVwK2ORHE2F7n2/10bkd1roD1fmIVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761254943; x=1761859743;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eZTtW7s2C54IJwr/+yKWt9hcy7AreQVu8mbOQJHJGfM=;
 b=ovzZcV7fnPl+sVbVOuJvHxUxoTUBFQxJOSUfW5Rn3RXThYOA5fUoW1I9IUdiGx1u7I
 2D4ft4MoxxllmSUSvn+nHx0LyhwVWuWPHtaCohSrHP15sZNfhwMEAzphnY5pIU87DBii
 OOTao9bKgnsiKzUXFgZqVRwlyPwJRX0xYtucqZGYBhMK0yjVDNtmOuZN3MoE8ArfZCn0
 ABhmjZcsgDO5W0aV2QQBiSeDt7EAbIKDpMAyR91V1XbOVqrOFGE/sR2taQ5Y9gdycHS9
 z0ZTibm030dT8lfecuKQKCgTy6Nk19XLNfczNaBxSlJ2pic84WBu+CM1sib0+sDcSSSa
 Aprg==
X-Gm-Message-State: AOJu0YyIAkrvhzhuy7ByYEGU5W5yosA6vrSmnOvVEapoN/xg42c2lMLx
 tfB4rKhzI9rlTTFWAX6avkix2ynjQU4qCocbQAVaxd7Ba1/nf+HiAtUkQn6eZvVh09M=
X-Gm-Gg: ASbGncs7Yhcw7RwPAyGxAmNh/EP7E4ICq3+JhnlBAP6aOoINqd1gc9gFXfvAdO/ORZd
 jj2FbQXKovS0/s9l8R5G6ZjX4bA8BXfCLRS/pVj5481Ii5QWigTza7Rxn+SVUaEjT3cQQclstwa
 lVOgdUWksJMv5deGaC4FxPr1yupeK5I3H5BIy3H2qfEQbavfLJaq82YsKiBoXir2huQuETK+S68
 ApwbmnMw58G1sXlxvfkhflUszop7Y66JQ1cnQhyWT4jgwu35ftVwPBMs9yaMeNtIfrEDY69lHLb
 NW9NW475RgJN5oKTcKcSPJ8mzKJL3ukn7boaZB4fSTeqdS7QbRYRxuMordEnI/eC3HpjZgkORkd
 MO7v4aCDC6baB2nU8hsgZMzApv5aeGocDYB4ZHYJtCDpU3BhgQCvd24Ku9B2A+us6rNSmVa4P07
 bP+G0NT2dRUgquL+UeOYorzkg6C4GE+nbN68gWPLuJfGkP5O6yKg==
X-Google-Smtp-Source: AGHT+IFczXnDtH0o3JBz7QVt+/ZxXPlifoXAfr8VrN9+TOhtd2ohRtvPnmG5UjQaz0/pydKpPS18cA==
X-Received: by 2002:a05:6808:1889:b0:43c:afd4:646d with SMTP id
 5614622812f47-443a2ed23f8mr10357648b6e.14.1761254942742; 
 Thu, 23 Oct 2025 14:29:02 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44bd44f8ee9sm745105b6e.24.2025.10.23.14.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 14:29:01 -0700 (PDT)
Date: Thu, 23 Oct 2025 15:28:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Kory Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH] python: Add a top-level requirements.txt file
Message-ID: <20251023212859.GN6688@bill-the-cat>
References: <20251023174059.1962529-1-trini@konsulko.com>
 <5226195D-CE22-424F-AB0F-6238DD3F685E@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TKMyq1+T1b6FvY/S"
Content-Disposition: inline
In-Reply-To: <5226195D-CE22-424F-AB0F-6238DD3F685E@gmx.de>
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


--TKMyq1+T1b6FvY/S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 07:50:36PM +0100, Heinrich Schuchardt wrote:
> Am 23. Oktober 2025 18:40:59 GMT+01:00 schrieb Tom Rini <trini@konsulko.c=
om>:
> >A frequently reported problem is that someone misses a required python
> >package when doing a specific task within U-Boot. This is in turn
> >because each of our requirements.txt files only lists their direct
> >dependencies. It is not always clear that another tool has its own
> >requirements and thus something else fails. Solve this by having a top
> >level requirements.txt file for the project which in turn installs all
> >of our other project requirements.txt files.
> >
> >Signed-off-by: Tom Rini <trini@konsulko.com>
> >---
> >Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >Cc: Simon Glass <sjg@chromium.org>
> >Cc: Kory Maincent <kory.maincent@bootlin.com>
> >
> >As Kory is the most recent person to hit this, cc'ing them. I think this
> >is the right path forward and if agreed, I'll update documentation in a
> >follow-up.
> >---
> > requirements.txt | 8 ++++++++
> > 1 file changed, 8 insertions(+)
> > create mode 100644 requirements.txt
> >
> >diff --git a/requirements.txt b/requirements.txt
> >new file mode 100644
> >index 000000000000..0fd08b9da17b
> >--- /dev/null
> >+++ b/requirements.txt
> >@@ -0,0 +1,8 @@
> >+# For ease of use, this is all requirements files for all portions
> >+# of U-Boot
> >+-r doc/sphinx/requirements.txt
> >+-r tools/u_boot_pylib/requirements.txt
> >+-r tools/buildman/requirements.txt
> >+-r tools/binman/requirements.txt
> >+-r tools/patman/requirements.txt
> >+-r test/py/requirements.txt
>=20
> These individual files may require different versions of the same package.

They may not, that would break creating our containers for CI.

> Either the individual files should be feature complete for each CI
> step, or we should move to a single requirements file.

This would be even further against python best practices than we already
have been.

--=20
Tom

--TKMyq1+T1b6FvY/S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPqeGAAKCRAr4qD1Cr/k
CmKKAP0TIDDl4nFguphlpxxDyvXL739GrO6/QndYP8xzrV5PRAD/XVW3DxTBc8Kn
F1lfHWqnKBbUnRXGHNirD/NJIgTgHAU=
=tEcD
-----END PGP SIGNATURE-----

--TKMyq1+T1b6FvY/S--
