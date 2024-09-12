Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBD9EED631
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 17:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD35689090;
	Thu, 12 Sep 2024 19:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jwr7FkH2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC147890A1; Thu, 12 Sep 2024 19:44:45 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BCCC88D7B
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 19:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6c3f12d3930so9772126d6.3
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 10:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726163082; x=1726767882; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wWbNOuiCLihl7n/A7q/BQSMwxEQDFCEnRPq5J8riP8s=;
 b=Jwr7FkH2SjeF0eiQPAwhkHWHt3S670pann0szNERgOIJQ8lWAoy0vSH9H5v/mxWHTi
 VSIkzzfMDRg/6u8L56QZ8xotoKnbULJ71bda4vJIi2EvDlfRzTgP4GkUZwRn0FlkLHWc
 Wy29HQW1ouqkBdOzOKje9JGNHcl0jkvyz3fH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726163082; x=1726767882;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWbNOuiCLihl7n/A7q/BQSMwxEQDFCEnRPq5J8riP8s=;
 b=Fctasch2uN8EyKSOldf4gig3PUL4rtppwqOK9LcpYYdMKDMIuGzEz2DFv1UEDJoln/
 IjwydGHHYcWQYP/Imrd31o00aZkroAR8rTjfnFNli9gtp/v9F/n/y35QRrhA9nucOk2L
 /QU3uTV/N8Mmlf+U+kQuiFPrVt3almQ27EjY/xy1dbWXx4rYUBKWKK2kABspgPtWvzPI
 24Yx4M2HdHYU6XgoVjucrMvrfU7A4J+LggWf8idHJRgsepO2r3b3VPyTNeM1ZJ8roXOb
 3ssurp6RcgeBSwdgqoREmkdZEIw4GCxiI705OQD5pg2EDx4i0bSRXwOchI0sG124CmED
 tDrg==
X-Gm-Message-State: AOJu0YyHm6biAbOQ/98z6PpYQYui3S1OGY7CzFULQ+6hRKPekxtVWDqm
 pD1OOpgDsgmFP+t1GAeKbScG7apCO/7iBpUF5NuKTyNeRDZ2Fp25xwXhSgrgpS+ZR1E4o2FjVJB
 my94=
X-Google-Smtp-Source: AGHT+IEq8zT5Mj1areKYYChrG9HzhmbDHoF9rPQboZSe7wEE685QIr3l2ga7eok/4UdrBATJZW3YwA==
X-Received: by 2002:a05:6214:2b96:b0:6c3:668b:b0e4 with SMTP id
 6a1803df08f44-6c5736cba60mr57244486d6.39.1726163081989; 
 Thu, 12 Sep 2024 10:44:41 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534786f4csm56272276d6.145.2024.09.12.10.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 10:44:41 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:44:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20240911
Message-ID: <20240912174438.GR4252@bill-the-cat>
References: <20240911232521.1124639-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JDPmPH9R392rVYHR"
Content-Disposition: inline
In-Reply-To: <20240911232521.1124639-1-festevam@gmail.com>
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


--JDPmPH9R392rVYHR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 08:25:21PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/next, thanks.
>=20
> The following changes since commit 78d898eec080b02059c8dc09318b8761044fea=
85:
>=20
>   Merge patch series "phycore-am62/4: Add more boot sources" (2024-09-10 =
14:56:12 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-next-20240911
>=20
> for you to fetch changes up to 5748aa1e372d2db3db6bf3e863f4571bf2ffedb9:
>=20
>   pwm: imx: Don't drop the enable bit once set (2024-09-11 17:02:36 -0300)
>=20
> u-boot-imx-next-20240911

Applied to u-boot/next, thanks!

--=20
Tom

--JDPmPH9R392rVYHR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbjKH8ACgkQFHw5/5Y0
tywPsQv+JrZU3Wa99Nzs4UUMnNlLrR2QpSQFtVRLDbCVV1Ljlp+m8SQG664oMx5X
ZS6LS25WH7YezFz7M9YzMYcGnUKeSvYlRbjj83haWDaTdh3IDyawpUzW6ZZgbmsB
8pAxSsRysk9zDGtHA+w8k50Wygvjqgj/aF8Yn2SuJpa+rLWWEEyVW9AjhGEbl5qu
lBsU4J0wAgrpX3LEqyqElB1j1T3qH3ELkt/yTcRpeMUG2M9yPyPoVcR7a1w7mSn5
tP+HYJsyDS88ZHzjw/hgxrhdMa9+4PaqvT63LOfr4IH8RI9IfnpTUgUa6LEgb+Jx
4/l+wxzKSLl7uaoLnZxxGUc/Bfedf8HLvuPuYQqHNfFCVQeiO+V75sO/7y3wXdXV
FLwEMwPqSYXsklpkDzxPGynLlFrlEUBkBaUBXhs1q6ruXi6LDzAsTAP6rDFgjwUJ
mhXnjvSJxhu8luC1O2lvhhdzhxVJnf+ORBSr2lWvJIPyi3/qScIKq7CIarqUcfIR
0tN2sQ54
=JzrZ
-----END PGP SIGNATURE-----

--JDPmPH9R392rVYHR--
