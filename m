Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B376AC36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 15:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1975C82A76;
	Sat,  5 Apr 2025 17:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sXW32Dn1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8595082A76; Sat,  5 Apr 2025 17:30:58 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51B6C8215B
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 17:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-601e3f2cee1so1454272eaf.2
 for <u-boot@lists.denx.de>; Sat, 05 Apr 2025 08:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743867055; x=1744471855; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qqv/68nu4sQEFuEDEoQl91HhZRTiImGsB7MnIKTA/SE=;
 b=sXW32Dn1rLetc6fIliE/hewUVjiuqgIkvmEXIMAScRjCD6eNXODe5p2QjtlzvKFMpQ
 jQUBgrFkr/UVrh7EVUZ6YYZvpVu+SJfsabog3Cz9g7TcmoGTrmMn1fxgGISY5nHzpFq9
 t+Z+n1Sh9HPYqXYhnXwL7Lhg22VhyZjNDsufg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743867055; x=1744471855;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qqv/68nu4sQEFuEDEoQl91HhZRTiImGsB7MnIKTA/SE=;
 b=OfiFhf0OVYzqLUwfCvrRQmgozFTwghJaRbTWt0bceFm4udhYD/ufZj+CWwgLSDsKDk
 nXklc4tzKrCZL4nE1BxiY1npGvNUFpOkY3tQMFZSdkJH1iPKxr0VHugJlp5x0rY7gB7c
 fIyXjOvPNuL3IhZabnT+nf5LAlz1L6CDnfxKDVouexKIg91Qg2mqsepBFvb3w02kI37w
 hSDMLmicTsXh+C44c0/Em454TO1k9/z2kXCa4o0NfAZ2/L9Nt3cd6wbxtcc+OTMJwXtQ
 6SyqeH3QPns/x35JyObqjC/fqd7oCcCTunbnI9zyFPtdCbkpaZALZKsfrjBV2x4S7Xn1
 9KeQ==
X-Gm-Message-State: AOJu0YyZqzuy2rsv2I8U4QROrZ/VQjbS8S402kVMzdBc2ZIPn6ns0Pf3
 3OIXkzPA7JTGeSH1RhbjX+qduN34VDHyKCI3rxYl/xFD0d6zkpLO4hRNK49arGE=
X-Gm-Gg: ASbGncsXPtJ/VIfXE/0fq8eb9Y3kzvfGIDazYKmuyNxzjFCaxroRzqJWvOqe0/G7aOD
 nWwuMCgERcTwd6gmOBHTKRZso1u73urcLh8jn0tEDIIU9LNP1Gk1IpZsWvIQm0RqtmBtbycFtzZ
 krMJMkk5i+xzrOB1WoGEPZaBnq/bngWbxUeYqMpoW8+Xccv9sLlrTrqlBcU7ZW+RHmH+mhN5gZq
 5bW0zjynConaQWxhZRBYX9e/C8cZKwcHDmM/JM1p55BlqMnIjEkyNzFGkq/gqS+yCM1hVEdf5eU
 VDFkYezFv9eW4JO8ZGcVnp3v14+4EMLJLuy8avfm+VgyRokzoZ6pYKSvl96t8kNkGOVl+n/qGN6
 SuXkJcA==
X-Google-Smtp-Source: AGHT+IEsYSVYqHUjOKGIyJoTsJtoa/IuBoyhQeqFCGHcL0maei3X35GsMw9Lf/i5GT19yltRC82H+Q==
X-Received: by 2002:a05:6820:221d:b0:603:f9e1:1914 with SMTP id
 006d021491bc7-6041ff5b39bmr1795428eaf.3.1743867054964; 
 Sat, 05 Apr 2025 08:30:54 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6040c4ea8dbsm1082735eaf.18.2025.04.05.08.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 08:30:53 -0700 (PDT)
Date: Sat, 5 Apr 2025 09:30:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Jeremy Compostella <jeremy.compostella@intel.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/5] arch/x86: Add 64-bit U-Boot configuration without SPL
Message-ID: <20250405153051.GA2695639@bill-the-cat>
References: <877c4mutk3.fsf@jcompost-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YFoxH0qJzIb2Sp0s"
Content-Disposition: inline
In-Reply-To: <877c4mutk3.fsf@jcompost-mobl.amr.corp.intel.com>
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


--YFoxH0qJzIb2Sp0s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 10:39:40AM -0700, Jeremy Compostella wrote:

> This commit introduces a new configuration option X86_RUN_64BIT_NO_SPL
> to allow building U-Boot as a 64-bit binary without using the SPL
> (Secondary Program Loader). The motivation is to simplify the boot
> process for certain x86-based platforms that do not require SPL, such as
> those booting directly from a 64-bit coreboot firmware.
>=20
> This update revises the `X86_RUN_64BIT` configuration to more accurately
> describe its role as "32-bit SPL followed by 64-bit U-Boot." It
> clarifies the sequence of operations during the boot process, where the
> system transitions from a 32-bit SPL (Secondary Program Loader) to the
> main 64-bit U-Boot.
>=20
> Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

For the series, applied to u-boot/next, thanks!

--=20
Tom

--YFoxH0qJzIb2Sp0s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfxTKgACgkQFHw5/5Y0
tyxmYQv+J6pw7dZd3M++xlNPV5lTI4pMIYTYVaxx65deHXxPTjyvnZyM2uVGcaXc
+TjT8bX+njfwtpJGgTkEOIjrZZ/FTpeLo+4f/uIZdDuroZ/nzeGVjzCOjcDc0vfv
DJegiZgTwBA/h9VO61/5rzBREjtaZW5fin8/+4bBv+/dqK2+xLMCnb/0ql0KZzEn
fjhUU6XgJaJ0KTcYqyetL7iNTlsgcWCBKKqLUnoDOXaPkQGKFDKcabUaO/ZxML2l
RBq2C8FbxmjStyvr/lqrEa/sJsvMiCzKV7oSeeuPHn77giFVY4N4plrueLQbKjqK
Oc4C4uBOualRAiQ9UYfy0QCuKEhn1xmtZtxAasaKyJKlYIE2sQI+EYTfXTE1lA32
Bpjjr4Ldg5gylcHnYcW+8uv2lycdZGO2eMIYleHW3Oxf0vl2B4bzj9Pw5TJQqmRw
DEtgySrw1UzVt0W//NOMN5LF7n+OXSJFJxRC2I7GYgEaCvu8uC6xpqFiQ1ip7lz9
oQJzwe3w
=pqyM
-----END PGP SIGNATURE-----

--YFoxH0qJzIb2Sp0s--
