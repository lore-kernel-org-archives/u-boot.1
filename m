Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95299C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 23:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FED481DCC;
	Sat, 29 Mar 2025 00:54:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PsXSpPM1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F08F181DED; Sat, 29 Mar 2025 00:54:01 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B28518059D
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 00:53:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3feb0db95e6so1723780b6e.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743206038; x=1743810838; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KGQtf0CXJHjsl10kuBkeN2VEo/vaYudryyRuWcbXUC8=;
 b=PsXSpPM1f2mAL5oB/CltVXs72BuXvvSWH1/jGONE3Uq2X0zznWU6UkE5P2g2qZGpxN
 HLLvWsyPmu10nSR1+IQsvuQd3LiPr8QrhlmRNveOP/cHD2gzqMN8+XRi1HcphlnVFC+a
 8Bts6jSWrcRw/LaH+CIoRmXIIg+aEuI3f9u24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743206038; x=1743810838;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KGQtf0CXJHjsl10kuBkeN2VEo/vaYudryyRuWcbXUC8=;
 b=PHSRK5UuwN8PFm4mKtiENksrilYMapofp6/cjmu59ubA8vsEf1CMig5AH3lK4Z/KMj
 qOz9ZMr0/fNbwDIkb4QqQL7QZ0I9LonqRMYJ6SLAzeb+p2ILfYd2WbHEvLuowiXe2gly
 BHztS55pIH7uBT4SJ39JqHdpnXifxYQrJOF9cN01IaRf6s6je6rjGq6evHIJOTJiu0zL
 cvLdamiw86aCTzoHE8mQ8rJS3rs519KmTq3qahSK/O4KRsx3siOVMSq8MuQFwXUn0Esv
 w7Tf70ZYqiXNGGjUj7G7FecOspDYp0CkMyGsSfcmO/hbGsUn/jSfvzxFA+1Q3tYKq967
 wAKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxZIi1JPGAzCMzGpJQv20KRqjRBgXW6izuTnDSarBGLFe5vntSMo1HaujsLqE7oiP6tPsMwd0=@lists.denx.de
X-Gm-Message-State: AOJu0YxyI2BEmmaW5THIa5fKbnFoauPz0aqetJF4IaS3xHx/3zjBuq1H
 RDixVy/OwOJ15iuNpFZWLc9kcIyN0EM5Rz+PfqrMnCERQ6RRpqtRRFBwdcgkKKY=
X-Gm-Gg: ASbGnct2TG7edPg7X0+pa08Ex39kEiBek775JbfS1X8WwHogmZLFMm25BGBAZt9P40n
 BR0PwKKshWfUKgzSSqI4uSByaJJKOUen5v/p2AmAFwu8KJQqAxtHE293g3a1M+IUQGlu+IZyHAW
 uirPJ12EuJ1ewsGdk0UMmfT0e9c84pCODLwW5jR8vV/hMWruf+6hlM05Us037mq0bff0Ja/Peim
 Av+gBChw2DS7xfTo4UJwFiWBfpy95dzRXYwlfbTgFXYMZ894K2F05+pKafV9x1/MhNBMtU270UE
 W5n6R2+wzQKuS88qbVB2gLigDRzzWDEeSgQkc4jyQMDhaNYZIDNbXU06wIH93agFTI0ROytJQwi
 zgYWutw==
X-Google-Smtp-Source: AGHT+IG8CpgNHOYkPhynRz7H4dcr6Cp5H3h+zqpL6alolFPp+HRVOBMLbEqlSAAqy7iWm5cLwHESiQ==
X-Received: by 2002:a05:6808:d4e:b0:3fa:82f6:f768 with SMTP id
 5614622812f47-3ff0f5b43b9mr707861b6e.27.1743206038244; 
 Fri, 28 Mar 2025 16:53:58 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff051aa229sm532076b6e.21.2025.03.28.16.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 16:53:57 -0700 (PDT)
Date: Fri, 28 Mar 2025 17:53:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ravi Minnikanti <rminnikanti@marvell.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 2/2] env: point fdt address to the fdt in a bloblist
Message-ID: <20250328235354.GG93000@bill-the-cat>
References: <20250327231318.2713201-1-raymond.mao@linaro.org>
 <20250327231318.2713201-2-raymond.mao@linaro.org>
 <CAFLszTiATNSdLgJ-PCEFjyTbwsgxTXg06W4Lj3Fv+zYwtKWcEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3JCa8+9mCvvrGABZ"
Content-Disposition: inline
In-Reply-To: <CAFLszTiATNSdLgJ-PCEFjyTbwsgxTXg06W4Lj3Fv+zYwtKWcEA@mail.gmail.com>
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


--3JCa8+9mCvvrGABZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 05:35:04AM -0600, Simon Glass wrote:
> Hi Raymond,
>=20
> On Thu, 27 Mar 2025 at 17:13, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Point fdt_addr to the fdt embedded in the bloblist since fdt_addr
> > is a default address for bootefi, bootm and booti to look for the
> > device tree when launching the kernel.
>=20
> I wonder if we can drop use of that environment variable at some
> point? It seems strange to set a variable to gd->fdt_addr only to use
> it later. Why not just use gd->fdt_addr ?

Doubtful. Both fdt_addr and fdt_addr_r are documented with what they are
for and we'll likely never not have those as valid use cases. While it's
possible some day that we might be able to allocate valid addresses
everywhere we would still want to expose that to the user to do as they
see fit.

--=20
Tom

--3JCa8+9mCvvrGABZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfnNpIACgkQFHw5/5Y0
tyzdhQv/Z2J8ggk+8tuXdsMjBjoe/pfN+qr1sX+aLLkFWehkHri0A6TQpnVjiCDq
rZUNyUKJpMRf4NZMIWNaEy0VSk3Er2LT+Rict3yD4UDC/ytaYDHuSAJWxndB3z05
wlIF2vdt0Rvxjyv7Rs0OjSWV7rTztBaw0Qy/QE+Or70WmRGG/YbWDMe3xY8kpFU9
lHPGEzKdGHOJhtotlb1/K7g4lmBZ8QquZpIutS3Z4v6g5PH0MZ3aQzlCUgsQCqKY
d9t7iAxO9tuTOxAmgSp6IwK8lYbGeY8f+0I0qDoGc0/Yxewc1/FAue6Mdb4GcwXd
KgC53xOb1PY0Joef2Wx19ssi/bHEvVZ/vGUsXgDlQ1S0I/wWeW+64895gorWttwv
/+i3E94pCE48USjEIPcr0sNyHPJ+5Ig+V5TSPY4QwC0th20xuC0+oXdMXjoJHTuV
LP5rIK9kZYiH+NmHd7YafCVv403liOSOvwzautsBfi+zUPwpIxm1U9fpJ14rag+e
KQD48ui2
=gLfA
-----END PGP SIGNATURE-----

--3JCa8+9mCvvrGABZ--
