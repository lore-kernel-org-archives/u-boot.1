Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C3FC7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 23:40:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 738418210D;
	Tue, 24 Jun 2025 01:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DeyfUOLF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C0FA82C4C; Tue, 24 Jun 2025 01:40:47 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79AA481E13
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-736f1953673so1233210a34.0
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 16:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750722044; x=1751326844; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0sI9Q0aOvjR8Mk5syxa2+QTmIU8l9czwIbYToItyDeI=;
 b=DeyfUOLFRa4jkZGGnwes8nJLx+wtN4845794e0Wr++FrVXjBoiDBCvjdaBSoXkWurN
 H27twm4alAScJpalpDIlirOCpXdSyTRNcioBFumwPKW0Ja3ks173jeXWjF6RzdQSSUrd
 4L7SrWAiQTxzx7ren3OJZi1jkgffp8fsZ036M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750722044; x=1751326844;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0sI9Q0aOvjR8Mk5syxa2+QTmIU8l9czwIbYToItyDeI=;
 b=Nz2bFBzYAnqvjbiPkx7nqWwOCAU0j8IhovtVuCoToa4cAh/yYpjvUFlqUC5qkj6cJH
 TK5fXclOOxOAqBbVlzHN2ATm6GW7eBrNnct9m04tmrdD4KA1C7ju8Y/o2vJx8jJVges8
 oRrlkTBzL9PQ4kCxEmXtvGnvK9wzKNmUcQrBgAXSyQ2Ij6dl7dYKoy46sX44RfB2jmdi
 Apzh31j9O7oO1NXjy/vYh7qh0b2FR4dN/vYj9drJIXIvDrHRkYNUUWLnt7WOuN/PfYtz
 NpGSSrye5jCAQSREp6raqbu4IXXwN4e5yPpdRr9XYEkF9ZAt8y9LUDcmDrIFKCp0ig0B
 OOGA==
X-Gm-Message-State: AOJu0YyXeQJjp1TPn+V88EFRUAbnXE4E6GM9e9PEVLAgnCMvaOAF53+I
 /Ry9ki2LFlivpP+YfvLyUfCU4U21LdT3EzhCpKvjoZdx9s9EyfjL9WVdr0BbQrh+1uA=
X-Gm-Gg: ASbGnct5Cll669xfhYyo7C3JZu+X4kOJODGZ3wIVy102MLE7/EQaSpmuJNz/v5haMXe
 2Tv+M1OBjWx/KwnIL9MmkZZZiGRHwvk3Q7l9ak5SVTU4hfuMbRkrx7qon+pf5ESBRT5M5sgM2Vz
 lCygV0aj/rtqSybZSfRY5wZXOGKzGfzv0oc+mVzGSq9Zzqa+Qpx4J+uCwwSzRE5c6AkXC3mge94
 XV+IZTN5jibBQ+tKmCttunac3Ah9BSVuTtfusVnodYHvxVsOJi8j/R4efwAK4ngMCm7WSS7nt2V
 gZ9gRnFzucGRg/SZZop4prnl46Hu6f3hdkXVKxxCKDMMnPRxkPO0K3JgWAz/jdh2NLvtGjNtLht
 frimA0SnXofc1QPv9PUdFb6pou8R7/z5rzQ==
X-Google-Smtp-Source: AGHT+IGia4rn2AMiAxUYyI5pkmTVble4UAjlKQPr/unK5MCMAvv1o6IBJVVtVrR139CDRNTFl02POw==
X-Received: by 2002:a05:6871:80c9:b0:2eb:87a9:7fc1 with SMTP id
 586e51a60fabf-2eeee56a6d1mr8835745fac.27.1750722044059; 
 Mon, 23 Jun 2025 16:40:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ee8a8ea87bsm1863362fac.28.2025.06.23.16.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 16:40:42 -0700 (PDT)
Date: Mon, 23 Jun 2025 17:40:40 -0600
From: Tom Rini <trini@konsulko.com>
To: vtpieter@gmail.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: Re: [PATCH v2 2/3] Amend fpga Kconfig and add a new
 sandbox_fpga_defconfig
Message-ID: <20250623234040.GG4003484@bill-the-cat>
References: <20250623181222.1539194-1-vtpieter@gmail.com>
 <20250623181222.1539194-3-vtpieter@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bI0db9NfBuV2ar94"
Content-Disposition: inline
In-Reply-To: <20250623181222.1539194-3-vtpieter@gmail.com>
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


--bI0db9NfBuV2ar94
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 08:12:18PM +0200, vtpieter@gmail.com wrote:

> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
>=20
> All but the FPGA_SOCFPGA configurations are enabled because
> drivers/fpga/socfpga.c requires ARCH_SOCFPGA set for the *manager
> include macros; amend Kconfig with that dependency.
>=20
> Add a new defconfig to facilitate compiler checks on most FPGA-related
> sources.
>=20
> Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> ---
>  configs/sandbox_fpga_defconfig | 391 +++++++++++++++++++++++++++++++++
>  drivers/fpga/Kconfig           |   1 +
>  2 files changed, 392 insertions(+)
>  create mode 100644 configs/sandbox_fpga_defconfig

We should do the fix to Kconfig that you have here and then just enable
all of the drivers we can in the normal sandbox defconfig file.

--=20
Tom

--bI0db9NfBuV2ar94
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhZ5fQACgkQFHw5/5Y0
tyzBEAwAq5QByRl7zoMoPM5Ehf94Me+1cx9jGUid5vZ7KOJSNsDn1GDDN5ninTqm
jrdgvb/Yqy7Kv4A+i4+JY6Rv9CWwa1Y7bIEcYtsU267QIiUbVjnEATvwv7xpZBMZ
/THEwAAELmsFzXv+qnTti/a2Nk2ZVPy9kWLLNrQ8wB2SWqjWqxlKVE0xDf18PwCR
/jaR64iTcRiduJODaJN1mDTw1KXWhB+z7o68LoSYGYTGlO0iXLRsqBvNrC0jBlFx
gDPgEm8YgD/K94EC9zeJNIPA9IJu+h7NO3EXXOUDFddqTJ6n3EH+MpUfQl6NeOk7
U7sw4inTmvZ0zBZPI2FZWlFtvFuXp1KX76Mc5v1mVN8qkPue45Uk5isT57yW5O0s
FM8fDsI6V4YaCDPo5qk4xhfozThsBTUtClG+Vl9pw8yTy97am90CvWBluqGl/gac
xWWJof/iJdy32LCkTXJXpKCPzEUJmUUwkmPABAzh+wQ1ZHC3M+5xU+tyw8GUzrg8
uFjqSO9d
=pBPV
-----END PGP SIGNATURE-----

--bI0db9NfBuV2ar94--
