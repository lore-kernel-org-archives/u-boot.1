Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B97CD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 19:01:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C8018484C;
	Tue,  9 Jun 2026 21:01:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HbLH2X5u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3B058488A; Tue,  9 Jun 2026 21:01:12 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 587D084704
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 21:01:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7e6fe199b81so2066083a34.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 12:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781031669; x=1781636469; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/m9o5B3TC4wY/hJEZVxOVbZbCDJxUORacP54LuDAe9M=;
 b=HbLH2X5uA30VyIu7iiNyDMGEVuFqlqeRbiZeL7OTAY3GFFtGZJfhrVzFXGoobpp86P
 1NDPk5vshJDxCIGFT7wASd6kvcjaVpE4s0bBbg9K0i2vKE58UbhaDIlmTtJIir2PmjBr
 UlHASjurwNDb6d5CwLPiHDN0mFiuxJjdoBxwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781031669; x=1781636469;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/m9o5B3TC4wY/hJEZVxOVbZbCDJxUORacP54LuDAe9M=;
 b=RO2maiTu+WMMgutxoCv/IAxwRJjxsGjoVmc73/jMUs433BAGmuZJC67JM7dQ9w0RFT
 BOZ+GBOUO70HxPqYho8EideoGKTqYQjEPhO64jd7pr0wQzrFPSkE+4wxdc2B3Dmqrukz
 wXC1/EM/rQhr42U0l9LxhVAB8yswXJF3rMAnbbU7vFw7OX6H16eQpMPuYR06zaUIgNNA
 OL1MAc2hkWLcAO8dSBXTe0sakvqoxsOuxNjqrFfeE2hA5nIUESZTRgcYzlqPrcQKO53O
 RLtw5bULHBMmvCyH3HxbSoS4GdYAl0oOftVI5Lnw3R/Q/m22dgQvGFvRFculLlJohKZE
 pW/g==
X-Gm-Message-State: AOJu0YwoHdv5phSZNRbkwVHZULbdZ+aRp+dLavYp0rw6GfMGLyKXJftQ
 iHRbD+GdNNbymT09mO0QeVinsRr6YdIkPiPYu/FCTqaVxGMK7tfVKNIwmafMt2B2Duw=
X-Gm-Gg: Acq92OHgC1u5BZJaAl/MjXTBILgEKjvAGRYWAV088+NZhj9/wyWxZKctHpNb/weUyI6
 LBiCOVyGqVEcA+ZwkC8ymKhEgsWH2tGlClZ9fXJLzX5Jc9HsY4kHJImt+fCZs1DjIT4v9oxUbtm
 S51ttc2uapxI8ly0iJH+Nj4R0y/suMF3ipCmET8Mt4+ruLeFsuWog9Ohq/DUSUYpzhCbTCOKWfE
 b6nZnae4qd2EX8VTQXMNKfbf56kKkn/OINr5k6ZpJzeLNsF375koRQo5x5jVGCAFdSop3IpNZqp
 Jqd6xFFTgioYF1ZLwylxWum90QMdi/eynbZwYeykECfeU6oDC2WcWBXz0854cPVtanCl3qBNr8X
 a9ArXYg1n/d1m+ucLt1V6A9X+HJJIQTuF/B68OTRLm7oGnu523zUMB9bloqPcU+MBGWxxL0LXj3
 DI9uTjXjP07SQ3X4yYAMkkZabhB9CAu4MqiGXBppLoxZ3AOtRc5J/amo6MIFYkoWETrFMobcUus
 EdP6I+eTK+5YX9otZCTJP3dmV9eYtIYhsNVoaAy6yJ5Ch86qqkvDA5pdUobNQ==
X-Received: by 2002:a05:6830:6d18:b0:7d7:fbe2:9725 with SMTP id
 46e09a7af769-7e70c5eaf80mr13766587a34.5.1781031668789; 
 Tue, 09 Jun 2026 12:01:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e75ef0e4sm15149945a34.12.2026.06.09.12.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:01:07 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:01:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Johan Jonker <jbx6244@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/8] Kconfig: armv7: fix typo
Message-ID: <20260609190105.GU382693@bill-the-cat>
References: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
 <1a8eb376-a20c-48ef-93a8-dfd5a2254ba4@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u3FebCHm2pOkd0bt"
Content-Disposition: inline
In-Reply-To: <1a8eb376-a20c-48ef-93a8-dfd5a2254ba4@gmail.com>
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


--u3FebCHm2pOkd0bt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2026 at 03:24:37AM +0200, Johan Jonker wrote:

> While restyling Kconfig the script checkpatch.pl gives
> this info:
>=20
> WARNING: 'suppport' may be misspelled - perhaps 'support'?
>=20
> Fix by changing 'suppport' to 'support'.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--u3FebCHm2pOkd0bt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaihi7QAKCRAr4qD1Cr/k
Cm6OAQC+JGcWH98Mx0nKBnSXvC2RmiEo/xErIEfc5ZOur2NnLAEAg0+RK/i6VBVG
ZePHPjhA7OFr3MgJYlse+6GWYWBjTAw=
=1vb0
-----END PGP SIGNATURE-----

--u3FebCHm2pOkd0bt--
