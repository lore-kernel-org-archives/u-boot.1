Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C3DC021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 21:16:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C1058056B;
	Fri, 21 Feb 2025 22:16:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D065RaoM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA776806FE; Fri, 21 Feb 2025 22:16:21 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79D77800C1
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 22:16:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-220c8f38febso56773005ad.2
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 13:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740172578; x=1740777378; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NCUQRwXkxiVoih+e/bLE/ayXuBwo2gdPpbvq74CFFEo=;
 b=D065RaoMbI5gxVwzezPdBX93CRqVkCTkvm8fVr+P+ODszKWQiQVVaVa7+3IDfhnFJ7
 Gq6ROwbEzq2WUF1tBKcSMncbAaZuJ8nnwaYFUSbfpJfl87/YISA7OJSrD08PeVs2LpnF
 H+gFt2jRQ+MDRo+w/evQ44vTP1AEiWQfZ73Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740172578; x=1740777378;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NCUQRwXkxiVoih+e/bLE/ayXuBwo2gdPpbvq74CFFEo=;
 b=RPyShBJ8JQGt23iERFq9VAEBDYcGKECEa08HY5x1opgF9SgzZjE84dcETNQ+EuoUeH
 wE1E0JdVtEh2UQ/XaCyYdzU9JUOUhCwift7wzthphfhsFV+jj3kqKzpAyDKeZZfcO3yC
 pyf6bQAA0ENrNIeF1rdwwhp1Dg+PefSydYfjYxIxsv9Wgf3WWrEai+dtA7wDywb0RtRy
 63n29hXPgok8RxNdnAgL56EA0dnNGvYENTj1UqzU1Y3vu76JToKymHk9QO6MwI2nxQWG
 NNWWB0X0rasUircfVxkZViaBZ+eecVoDiGC+cmnpbEbKRFlflTgAv1/HgPoSmfweC+Bz
 o2Ow==
X-Gm-Message-State: AOJu0Ywz+U+LDpRjI6PmZRNegplUVAoRZvYweWhEhGBJ/I0V5kqzPOPt
 rnwEuPLn9//gA1EFQLjJAcq/PF8fXgttuBdyv9Hdh2NXQfPqhVfJo1B2zGxWqL8=
X-Gm-Gg: ASbGncvCTT6XA4uv7grtzv2ck1T6Bn0EkA71W5WkvYtG0DATZnZykH1R0q6iUgE0qNX
 VRmkK8J0vB3T7YZbAww0Mb05cv/MmIaTwC36+VjXThoot4Xvo25uhq80lkVO1er09qlhVV9exPI
 3KHUO5uzQJWw9nvdmfCOPWwBATP2wnXu+FSDQyXhr9Q2dZsge4+mV0Q3Q/1akT2Ww+yWL1EzZC0
 75QvORCiBA+rQYJ0Wh3+YgYSJOU74kuA12+ucKlcdnk/YY/zX6coQaqpZwk37q/+ug7MbME2clZ
 9OytYNvqZcFJIDIY2PAZXuzA
X-Google-Smtp-Source: AGHT+IEB2z6yPTII5y/nwyx1RbtjM4o+dMX4wOScGM49jpMhkEZbNkWBW1SFMBqEEEXRAThptZxj+A==
X-Received: by 2002:a17:903:983:b0:21f:14c1:d58e with SMTP id
 d9443c01a7336-2219ff8279dmr82200795ad.1.1740172577969; 
 Fri, 21 Feb 2025 13:16:17 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220eaded823sm128664485ad.191.2025.02.21.13.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 13:16:17 -0800 (PST)
Date: Fri, 21 Feb 2025 15:16:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [u-boot-test-hooks PATCH 2/2] labgrid-sjg: Add systemd scripts
Message-ID: <20250221211614.GT1233568@bill-the-cat>
References: <20250221204329.677953-1-sjg@chromium.org>
 <20250221204329.677953-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qfMnEwX9xkjeUN6O"
Content-Disposition: inline
In-Reply-To: <20250221204329.677953-2-sjg@chromium.org>
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


--qfMnEwX9xkjeUN6O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 01:43:02PM -0700, Simon Glass wrote:

> Add example scripts to start the coordinator and exporter.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  labgrid-sjg/labgrid-coordinator.service | 14 ++++++++++++++
>  labgrid-sjg/labgrid-exporter.service    | 22 ++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 labgrid-sjg/labgrid-coordinator.service
>  create mode 100644 labgrid-sjg/labgrid-exporter.service

Since these look like system wide scripts, is there a reason to not
enable linger via loginctl for 'labgrid' and have these be user services
directly?

--=20
Tom

--qfMnEwX9xkjeUN6O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme47RoACgkQFHw5/5Y0
tywK3AwApCjAdCI42rznVcRJ52ud8tHubATlHdbii+p9XPmNRZdgikbibanMwpHE
AgWEOfx5rHwG+Z1dty6bqOQNgb8QC4zfKv/FlWbbU9ob2c3sTmdixdIqzHSQD0DK
sPzTknU2MNmPkJsw1A3epHVuFJknERfzc35Nrcx0kZGyD6i/Ttkah2zBgpOrwIPB
q5SE3Shp2IDHAXSId0eUyriY/uJWsF4gBF/eWjyvgR8YIJK1WUQcMsVKRlMG/pix
CA7xmgMNg99PbKd+DRv7Oe870Rp1rdgnlPOfeNJXrxNSbi4WEtY+bFBtGi/vQWpP
3R+WSu/KeuOKRhbdcVlVTIINXVcUy8W37xlcGv8FCbKLK8w0lwVW3G41zc/JHjk3
VlBE3KL/1NlAUwRQlQCldTmUNWoua2XJ6z3lCXhsGZBKEs9qFosUkKZOrWwwY5Ml
jVzAw3ExVW2NoLawppTsRp9vXrYOaz1V3hMqdRuvb1oToEWqFM957GMvae2Rr+v4
mtzUyTi4
=AMM+
-----END PGP SIGNATURE-----

--qfMnEwX9xkjeUN6O--
