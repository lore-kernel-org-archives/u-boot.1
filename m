Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF02CA100E
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 15:47:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBE11832EB;
	Tue,  2 Sep 2025 17:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fhMl8PQ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4B16828A2; Tue,  2 Sep 2025 17:47:03 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D93BB8331F
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 17:47:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-74595f3852cso115816a34.0
 for <u-boot@lists.denx.de>; Tue, 02 Sep 2025 08:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756828019; x=1757432819; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Yi3hVq/m6DCXYWZAHtO6daWhoRlpsysTAOVORzaegpo=;
 b=fhMl8PQ/8CQU5eT4BV8MGx4HIH5BHCI1PQbrNODUZwBkU4EslQ9KRqTvVcTNmCvVH6
 fl/sPJ7s7HwGajMr42EqIJa37z6HBI/wEUZoHnqOyywwI1fys7lAtj8NcxEfhJlwAtfQ
 bbkdHSapW3We3G441ly2KpLkCxT2hwQRZrNFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756828019; x=1757432819;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yi3hVq/m6DCXYWZAHtO6daWhoRlpsysTAOVORzaegpo=;
 b=dR3OciBAMR2c10KXRx6NLHPF8yTy2l3QMcLtYawmg11ugpprMvviFvSJ7V/VeUWk9L
 tImAoq6b5/XGpOcLv7SVlTBlSUv6NL3xcxrqd714ZjV1A80+3T0AEtHwPmfAicStB+w2
 XGcuQm55R4NdiOeG/AVqo4qVKYBzEGth32hmzxVzClvmWPppxTlP0B8LjXFDMFerogeg
 X+e1XOSYcVWC2NYMrr8wknOBCFVze+3ctwBeAOdUa+DGrh4C1/Thy4Tq0TBYL12nuclQ
 U2vMqjKCJMb29MzHIDwxY8OnWj+y9iKnPQxPS5ZMOw9DGwmN99hvdrF+Vbua7aOxvusy
 T4Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYfpz9XHq1sUgE/7r8cyV5/NEuXbrDz0o0TDCc9CkJPa9jpasGz2Alw5hZxWKrWomIGLbXgO4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8+/DXlKElVPNcrKLwZXJMM/UR0wYlbKKezJCfT6ERcMBZH33Y
 sduyURsUWAA3myo+4zNAvAhBbtlUjZnSZpo2Ox8tMGapaCEWq1UxyGgMr4ucnBMMG+Y=
X-Gm-Gg: ASbGnctOldYvGZpOP+pV3ouF+a70Yr2BQaE4+d8a7IVk731TXT9tiWvnM8VmN23ugUr
 nneTTKNE8Al2Y3+huoRv8GZmlkzdXmMhMKoLs8mhIypaCCEt5HH9Hiw3fR3llbhJb4gBOxzM5VZ
 IyH9zjoetdXwK1rO1EfXN8mB/mNd/nCrXhwvQtAdiBMN4upy0ZpIFXeDYSgAr/qciGcjYyPWrE4
 wNgjB0HI5U8oXhwnHfl97fdtYedeBKlj6F1tZouhJThKTSCAlSK9L6j4s4hXX9wAxMLvbz0gYB3
 2YCOyDR9rVh7hZtTN+aT9Tk3xcFf2EcWLbbkbZGnGr3vWIwbxBZAWM9XibUd3hoYIM2XLt8oe+1
 aegf4lZiNBv/8DBYYQTliZXbNe0MbQFJdiB97ENO4rnMJ+4m7j//8bdytlGcmjd6HSqA=
X-Google-Smtp-Source: AGHT+IGP1gb752fIYh8UrHZu0TI7mGTS3cPX58kuiBIQiH21KH0wWM/kVUMxeuPloD9Ww0t32i8WyA==
X-Received: by 2002:a05:6808:244e:b0:437:dd39:a1b2 with SMTP id
 5614622812f47-437f7cbd5eemr5779005b6e.10.1756828019340; 
 Tue, 02 Sep 2025 08:46:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-319b5fcbbe3sm554122fac.21.2025.09.02.08.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 08:46:58 -0700 (PDT)
Date: Tue, 2 Sep 2025 09:46:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Anurag Dutta <a-dutta@ti.com>
Cc: n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3 2/3] configs: j721e_evm_r5: Enable HBMC and MUX_MMIO
 at SPL
Message-ID: <20250902154656.GE124814@bill-the-cat>
References: <20250902102000.1388848-1-a-dutta@ti.com>
 <20250902102000.1388848-3-a-dutta@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KjZS+68Xn31ZiY2o"
Content-Disposition: inline
In-Reply-To: <20250902102000.1388848-3-a-dutta@ti.com>
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


--KjZS+68Xn31ZiY2o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2025 at 03:49:59PM +0530, Anurag Dutta wrote:

> Commit 0e198ff1a911 ("configs: Resync with savedefconfig") removed
> the necessary configs required to boot HyperFlash successfully, due to
> missing Kconfig dependencies. Now that the Kconfig dependencies have
> been added, re-enable the HBMC and MUX_MMIO configs in the SPL stage.
>=20
> Fixes: 0e198ff1a911 ("configs: Resync with savedefconfig")
> Signed-off-by: Anurag Dutta <a-dutta@ti.com>

Please note that this means it never worked to start with.
"savedefconfig" does the equivalent of "make foo_defconfig" and then
uses the output. So those symbols were missing in the output normally.
We can keep the fixes tag, and I'll apply this for v2025.10 soon, but I
want to clarify the problem.

--=20
Tom

--KjZS+68Xn31ZiY2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLcRaAAKCRAr4qD1Cr/k
ChL8AP4sf21dJe/Ep2Xsrz6YyxddatFVDnBNitFF2ldeQqM6zgD/SyFJwyKlSMuY
MXZgCqw0NSpEfm0AKVLlPWkY64OR8Qo=
=3zdz
-----END PGP SIGNATURE-----

--KjZS+68Xn31ZiY2o--
