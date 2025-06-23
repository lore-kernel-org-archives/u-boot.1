Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743CCC7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 15:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB72E82E25;
	Mon, 23 Jun 2025 17:13:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ot4km7eq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5027782E27; Mon, 23 Jun 2025 17:13:43 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D81C82E05
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 17:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7387f21daadso2627748a34.0
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 08:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750691619; x=1751296419; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vE99pxhAzKl+IRULCqcNJW9BfBiYXWj7Ea+Xo3mza7g=;
 b=ot4km7eq6jbi9e3X6JLhUQ9f6KfUYAXR3nRPNwAAo/aaYgrOqySehSy2IZ0qPD0Rmx
 u9AiwUltWYkzOZF3/rkZWJuvK3RpQte/pvHKtlrbA7CUuMJ/1PMv31qaX6t9gkNwbetz
 /RCJKGU6lujRLLtKx5J0535XYVsKUAVDsR04Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750691619; x=1751296419;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vE99pxhAzKl+IRULCqcNJW9BfBiYXWj7Ea+Xo3mza7g=;
 b=S/YmQDylEU0K4PQgcM2Bizxz+irgmvwiJ/QOwenbEuKUVrHdDq1Ka4vREmw1xLpDu3
 Fk1dsGE7pWt3EVLMX/+IWpUS5u0QdkaZr2uM2/nnWYefa/0ppJFHOce2guvUglEs3dnv
 ga2Npbd0NlMexDRLkAOaHXUN/yirsQBRUH3+1nQUrT6MSRZg17Mnf18M6zNJsZ42Aqu0
 UN7q+gAhKXGO7IqHLbHVkWdyXWT8C4iMnjL53TCz2PtMglEaMrupVYzGOxUltMpZGr67
 CzzX3peHvsHRDmkQrpmqM2twgKdKMJnyy3qpcgP5yFcJzDI28Mif4tACklp33ZR+wx0f
 7Lgg==
X-Gm-Message-State: AOJu0YyFEKojz2F4ZOkjiQu4fu6BQGUfeayL2XzzfAoZxXCoL9bKpn6s
 lU5jQ+QxxFluwhfpqWzYO9uFrm5sWGx8mo3Q/dEPdERfMuMLX9xKJ1yMXO19B3fcu1VXqnjAYhb
 egnPTR+Y=
X-Gm-Gg: ASbGncvr/svvkg0gfzXfSdc8QmU7AW4vRyPsOnwPS9SzDd4V7DqQQNBRrSBBy90vtp4
 0F1iXtP71i+dfHWT67U7tBvNrVN2pzERTokHRvSDB6LdEPca4uowRC6cml3GcFDQIsLBtpnXM5D
 P45FxtHSv+Poi/R61a4G4+IPL8u9Qzre6rmYNHC7qMHLOYgozALTyCo37QyRvG2C02NeuIM7hjo
 LMcYgYq52LjjHQqmR9xXCzdLDdDhkDxHfThDbZo8/ul1Jf1RQa5Gq50Oe4ISLOVoAY5dN/ICDO3
 qErrJZsHYkjFmuO1YTZrJ+RFJxr8Y/BWtczXwJqWqmeQjtHmPs2sJFnt1nkwyffIcntXlWpmegS
 xkol9CkYmbK2m1CGgiEXoX94=
X-Google-Smtp-Source: AGHT+IHDIGcN2vHAM5buQx7DanSE4SDhPqRkj4X9h5ZKN0mrfVG8oiXAHPw7uSZ6rRyKTieyqt2/GQ==
X-Received: by 2002:a05:6871:d201:b0:2e8:755d:b4e9 with SMTP id
 586e51a60fabf-2ef2a6e896cmr8531123fac.1.1750691618717; 
 Mon, 23 Jun 2025 08:13:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ee8a8ea930sm1687116fac.23.2025.06.23.08.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 08:13:37 -0700 (PDT)
Date: Mon, 23 Jun 2025 09:13:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Rolf Eike Beer <eb@emlix.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de
Subject: Re: Was plain U-Boot affected by CVE-2023-39902?
Message-ID: <20250623151335.GD4003484@bill-the-cat>
References: <5896532.DvuYhMxLoT@devpool92.emlix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Pco4ECID49/MM5/W"
Content-Disposition: inline
In-Reply-To: <5896532.DvuYhMxLoT@devpool92.emlix.com>
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


--Pco4ECID49/MM5/W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 09:35:25AM +0200, Rolf Eike Beer wrote:
> Hi all,
>=20
> for entirely unrelated reasons I came accross CVE-2023-39902:
>=20
> > A software vulnerability has been identified in the U-Boot Secondary Pr=
ogram
> > Loader (SPL) before 2023.07 on select NXP i.MX 8M family processors. Un=
der
> > certain conditions, a crafted Flattened Image Tree (FIT) format structu=
re
> > can be used to overwrite SPL memory, allowing unauthenticated software =
to
> > execute on the target, leading to privilege escalation.
>=20
> This links to https://community.nxp.com/t5/i-MX-Security/U-Boot-Secondary=
-Program-Loader-Authentication-Vulnerability-CVE/ta-p/1736196, which links =
4=20
> patches. The relevant one seems to me https://github.com/nxp-imx/uboot-im=
x/
> commit/0746cfd931de8f7591d263ff60dd806ffe23c093, and for my limited=20
> understanding the actual fix is the first hunk.
>=20
> A similar change has been made in 6039e0edc8540bd2a ("imx: hab: Simplify =
the=20
> mechanism"), so I wonder if this is just an unnoticed instance of the ver=
y=20
> same bug?
>=20
> Opinions?

Lets add the iMX folks..

--=20
Tom

--Pco4ECID49/MM5/W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhZbx8ACgkQFHw5/5Y0
tyy0jQv/RDtQHzBfkPkr2UeY0jmiA1BLhclSNSWFishy72EAa/khJAkaz7RdHmwN
QkPGb9pVbu7F32AID4VmxWkg8T90fIEWkd9B4GMnf54ih/bXdS6r3Xb3HOhQ7EEp
fVgT+L+TLA/5pu+hToIj4Sj8jvmesykLUK9r7mWcyyxfTie/3EQWT1yG8UuSzkjg
OpGUrzlUBYEXm/juH3nZu0Er6Yb4XkaOq9KOwIhKqdoLVnGWkQCsJnRwQUj5pqd+
4GZNizmpboUnSCxtaC/6sE9hodyT51sFa3223PVMplwt6IVr1ynkJSJKcFMUi7ZJ
lFVlxa8E5ZlKNZn6dXbmgioLWMreM5JoOW8UNGKpY71aUH7Zd0T6xhb8FB/R8Ukd
gpWX0TzsYGUrRmSO3G0PVIQjUk5Q17uapSWwicqXkUWrw+YNgImn8aRaRPluU2kA
LjLVC6Erj7FnyZpOLL09cz7rmNKDUAGSQSRMWmRM8y/Xl8QpTpM+EUzADEkqcBFG
aIZb4JtH
=XouK
-----END PGP SIGNATURE-----

--Pco4ECID49/MM5/W--
