Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC90C5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 22:57:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BFFC807B1;
	Fri,  6 Jun 2025 00:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qkLAIDLI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A3DD81FEE; Fri,  6 Jun 2025 00:57:28 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DB5D8003E
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 00:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2dfe2913a4bso439317fac.1
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 15:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749164245; x=1749769045; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Lwr9InvgDkC3IS2BVHPbxoX6vELym+yw/YnhE8FjkJQ=;
 b=qkLAIDLISjB7t7OZ9U2r+B9TIehb0HFVe6f5s6sbnDNgdJNe4stetYExROMF7+rEWs
 Da8kbxryEtdojZg9vXGTnLjw67+ISOGDmAGxjI5hlqfiiBVlJSsGipvWT86YeazHrhnF
 5KkQbejHV7eGbTo06cLuyZnQUfEsVXVZgFzpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749164245; x=1749769045;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lwr9InvgDkC3IS2BVHPbxoX6vELym+yw/YnhE8FjkJQ=;
 b=nwZFl6Mqe1wgoIdIo6PuZX+uMzSk+KtgSmE5E+Ep18gOD/v819dCWZs/8qEHGEBmIJ
 cesBjYJccadKIPQL1DwOopdXtdjB/FzW5QlQ2Ky3xxB/qJBVr5C+KoyEYoBK9kP/2edR
 kkWuNVfPuV5g+J7mUNyNBHzs3ANX2PSuNXqIi8mtETyb+Y7NErUYpUSp5GnfkojjrrtL
 wAVYZzRM7vTbKz4eXpGULPThjZWjiKny0JmCr1vgCkeFOWAl9U5B7LzxQdIXmDTIamqr
 7kLCa0hO/N3bVRWEF1U3mXEfYdVxVYuSnKFubOw9dWBIquCHeLABln0XMkh4kr80YJgO
 WhsA==
X-Gm-Message-State: AOJu0YzPtlgSqb2J2DCrgl9cm03fh5ZpL0J8Q0RWGwdMk3T0nfBNFSLC
 MjRcSJMfVNY0Se83LldzoYLBibTBpsCVand4NvVtIuSDEPukKegjfB072BKnYFIfg7E=
X-Gm-Gg: ASbGncvQqy7z05un53vfTN+x6kGs+9y3q0xXdQZgCHJ9VYZlQJCOfl1HFnUBTsR6zCk
 xD6Z4y9qf74iB5XROWzzv0aRVrHbeTKZhonjZux178m0HBs3fUrtdFMrlwpd+O6YXdQvZlVX97o
 KKivLBIWkRkj3MBmrEmrEFB9IcEOb/KKQ7LdVZjMmlSShC2E5Ch+yijtnm1Ky0oSFX8W+sJk7yu
 TOY+xMvnn8718VwDOesPo4PibXwIhGz/hVAFnLxwb2oQAxNE3Y15agxd7VTUOIpTUOKS0EqVDD4
 2l7kqaswMD2SvVpkAsDh/pDwN8tGPVgxNXRKf0rVvNJ5Ut3iDKzGDDH9bVoU+nbtmw3F8Dz9FT0
 rTOddM9+MF7jFPmpqRHJlAbk=
X-Google-Smtp-Source: AGHT+IHvLejsoZuy70odI+ZcxS3hBFWhjLUr5gn9H4hkO1wUAPE/a206J0MCaLCh4T25urZcVJRoxg==
X-Received: by 2002:a05:6871:d115:b0:2c2:4e19:1cdf with SMTP id
 586e51a60fabf-2ea012f0bcamr776682fac.25.1749164244742; 
 Thu, 05 Jun 2025 15:57:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60f3e614d4csm44775eaf.3.2025.06.05.15.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 15:57:23 -0700 (PDT)
Date: Thu, 5 Jun 2025 16:57:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Aristo Chen <jj251510319013@gmail.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, carlos.lopezr4096@gmail.com,
 aristo.chen@canonical.com, quentin.schulz@cherry.de, ada@thorsis.com
Subject: Re: [PATCH v3 0/4] mkimage: validate image references in FIT
 configurations
Message-ID: <20250605225721.GA2114014@bill-the-cat>
References: <20250521062745.3458-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r+ctFwo9zFXacpz3"
Content-Disposition: inline
In-Reply-To: <20250521062745.3458-1-aristo.chen@canonical.com>
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


--r+ctFwo9zFXacpz3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 06:27:41AM +0000, Aristo Chen wrote:

> Hi all,
>=20
> I would like to apologize for the confusion caused by my v2 submission. D=
ue
> to an issue in how I sent the patches, the series did not appear correctly
> grouped on Patchwork, making it harder to follow and review.
>=20
> This series introduces a validation step in mkimage to ensure that all im=
age
> names referenced under the /configurations node of a FIT source (ITS) are
> actually defined under the /images node.
>=20
> ### Motivation
>=20
> When using mkimage to build FIT images, it's easy to mistakenly reference
> nonexistent image nodes in configurations (e.g., referencing a missing `f=
dt` or
> `firmware` node). Such issues are often not caught until runtime in U-Boo=
t.
>=20
> This series aims to catch these errors early during FIT image creation by
> validating the configuration references in mkimage itself.

This seems to introduce problems on a number of platforms such as
evb-rk3288 and so it might be worthwhile to run v4 through CI before
posting, thanks.

--=20
Tom

--r+ctFwo9zFXacpz3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhCIM4ACgkQFHw5/5Y0
tyySNwv/QH9uLEa/5DjQ6Erfr0TEEa6qx3/DlI/5qvN4v+Sm1/IyXtK3jBLz7p7y
SJYK2MFiqvSGZYobjeourdc0EMNNS7DyDgJolZa9jDpCsW+3MgXXmXwO8rGXECwC
OQtefIOFIvaPGATdy8m6pDEGd5IrBoztHcmOC1+PMWiwEnNjsPs7BgeciHHEZ1wX
jrMIlFOgtxAOYAu0ihj3JtWEpT+5jyzjgxl4gFs6HFc/QldcEIF53q8VYaZ5fviu
kaghIabWcLUiJcIChC658QoN5r2oBSGVczPuOsvLI911OsS/FrFYw61fqYulRRPF
zdCqs9jgKhcBlTR4sqUsXbB3YmrnXcoyyIxQkxKJydPIKZvDXVNCMjrzV97rHx2N
/4baPNZK/Y3s5nC8L6iejImyIEUCL6VMbFgVi1k72Efl2z1NnBGPJeRCylCB6Qaz
rvLcfzB+ThI/g3CZ06OKMZbHCHn+e5N7EFXvl4comiWuXhf/kyI6NX/j25VyEgxX
xnx1sntx
=XPkL
-----END PGP SIGNATURE-----

--r+ctFwo9zFXacpz3--
