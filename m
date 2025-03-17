Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE01C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 13:40:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 408E580107;
	Mon, 17 Mar 2025 14:40:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UtjRi8k+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F01C28081A; Mon, 17 Mar 2025 14:40:52 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AF40800C2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 14:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6f6c90b51c3so46353177b3.2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 06:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742218849; x=1742823649; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pIx5JiR+YVtHktzHkoD5zmbZZ49JO+m/OIDKv5tp6vQ=;
 b=UtjRi8k+oAFTPOm9jdWvkWjgLRNAaFuTZ2XH6DRphyWIxgjgBqCCEYZ88u0/S8A9sk
 Ue4dy20w72WvHsQ+nUziRYJyenqdV9vOgFSCmKDJVotyGEfL5i/867TC1gOoBlMYmz3F
 xCNFO948vPFXVN33Q+pob0TF2MVNkzvvTe7Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742218849; x=1742823649;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pIx5JiR+YVtHktzHkoD5zmbZZ49JO+m/OIDKv5tp6vQ=;
 b=YFqm8u3dRaVrlIZ8ltNfgFEs10EUIU/oKElylqTSa+Xbq73zuUjFTQ9ss07FXJIPdd
 ol7nEcSyN06qvyCbUtW26xPb5LxdoavPUbxpjQ5fO/2uNMe0cwD7ROhCns7mbzvUctzG
 e7WAlw0jBHylVnEU1st1EitoJgBxmmlERsx8TJ1RQhmJMltLqgj6bdAShKobHYDCqfXx
 W4pg6l/jle3dyHLZT0lIUZLfiW9OjVnBdAsGFZEt4fAoKmqqgK1rCRNsNTKSnJ/+9lo+
 q2TBzz14d7kauvdhzz1m9ON6Y5AD+6KgasLYY2aahP9WDfpDtdZPDDFLVnzc63i7Rxra
 2QdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvc2P6SxN4ngVMSfuVrOD4mZ+g0t049Q9bB+ffCJsLojChbjCI44nsWiLFTKohlJWuG2Gbrto=@lists.denx.de
X-Gm-Message-State: AOJu0YyJC/rnNB8BHS/KtYOGcqk4mICdMsYVAojCMEfx2akjENaBMstf
 RCoYnJjOz4b7+O1cD0Jl5TZozMXFvvCffb8ep42txePZUNgUbn6mYb2P4M4GDcc=
X-Gm-Gg: ASbGncs6T6OS22bZTFcbUZ8+tINiYyjUCV+Mgp7KkKR8YoRoeuXJGvJksDMFBkokW+f
 /UHLLjt9WeNXTFa5wAU2skPOJH8FZxmWsUqlFWTTiTnzx/66cPtTQV6PpjnSkTK7kQmHgLZ2LuX
 vBMby9MKwnTkTUtFNsXuiaaDsVWONVcaSj/ZLWac9pNyvCMQIG/8ES2ayeSilHSsUdcILi5Z6uk
 OP5WKdJ3q2xPl90NXtAMuUUaqEAN3uowL9QppnJky8Fs+xv5SXFWOJw9ff4Y87uZ7cLEf2ilYBr
 f+JVmu1cjGVf3dn0BZrW7IGNpXzKqplW6a0gSLxaKJtX
X-Google-Smtp-Source: AGHT+IFWFXtiN0oBGGCEVMT6hcS12EZ6xNGDk46NxULfE8aB8pHGtv7T0Tw+TbB5nGB4HwC29pPssw==
X-Received: by 2002:a05:690c:9a91:b0:6fd:3367:d743 with SMTP id
 00721157ae682-6ff45f606cbmr155708287b3.14.1742218848939; 
 Mon, 17 Mar 2025 06:40:48 -0700 (PDT)
Received: from bill-the-cat ([187.192.128.10])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6ff32cb5a08sm21515547b3.97.2025.03.17.06.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 06:40:48 -0700 (PDT)
Date: Mon, 17 Mar 2025 07:40:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Hendrik Donner <hd@os-cillation.de>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] imx8qxp: Do not use CONFIG_XPL_BUILD in device tree
Message-ID: <20250317134045.GL2640854@bill-the-cat>
References: <2849ff05-ef67-4471-aece-422daa57040f@cherry.de>
 <20250314200832.154758-1-hd@os-cillation.de>
 <20250314200832.154758-2-hd@os-cillation.de>
 <CAOMZO5BEhVGq7JGOcL_hsNAe8Qf84tKkFY1_+mm18dk7842p3g@mail.gmail.com>
 <a872429d-7ba5-4936-b496-c80af4444d4e@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r9GpRz0+4U+ao/28"
Content-Disposition: inline
In-Reply-To: <a872429d-7ba5-4936-b496-c80af4444d4e@cherry.de>
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


--r9GpRz0+4U+ao/28
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 12:10:04PM +0100, Quentin Schulz wrote:
> Hi Fabio,
>=20
> On 3/15/25 12:58 PM, Fabio Estevam wrote:
> > Hi Hendrik,
> >=20
> > On Fri, Mar 14, 2025 at 5:09=E2=80=AFPM Hendrik Donner <hd@os-cillation=
=2Ede> wrote:
> > >=20
> > > In c9713c155127 the device tree was moved
> > > from CONFIG_SPL to CONFIG_SPL_BUILD and later to CONFIG_XPL_BUILD, but
> > > the CONFIG_xPL_BUILD defines are never set for device trees, breaking
> > > the build. Move the guards back to CONFIG_SPL.
> >=20
> > Please provide details about the "breaking the build". Which target
>=20
> The nodes will simply never be added, because CONFIG_XPL_BUILD (or
> CONFIG_SPL_BUILD) simply aren't passed to dtc.
>=20
> So essentially, this is equivalent to dead/noop code.
>=20
> > fails to build currently?
> >=20
> > After applying this series, the previous build failures return:
> >=20
>=20
> Yes, it was never fixed, just silenced by never building it.
>=20
> See https://lore.kernel.org/u-boot/2849ff05-ef67-4471-aece-422daa57040f@c=
herry.de/

It sounds to me like imx8/9 and faking external blobs isn't being
handled correctly at this time. Along with needing to make use of
making use of CONFIG_BUILD_TARGET so that "make all" will build the
right binary (when the right external blobs exist).

--=20
Tom

--r9GpRz0+4U+ao/28
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfYJlkACgkQFHw5/5Y0
tyxgIQv+LZMChu0f45Ziu9yYMnGrGwQKEMKPFMhS0BlXjdyCireS0fvBHqyzfPHM
l5Znjst6MWwmANhio8p+0vNS0JRJId/Ghc7am64eYMqAAr2cw8PviM8G2E0D6eYG
ShPeYNibLIuk4pIFiRNvIen7KpKad+C9JBvxvBHx0rjuFt3t7T+eCg/0lx/zyGyy
33hE4OwN+dJkTt+fEGsgfcqTNogNxo34i1vlezJpHHLTd6GOGtUVMD0hOLZUEgE1
woqwrNr7ujYDQVCLkrIHJ7qGaAK7FY1ji6YC2cV3XTuhik9wUv28Bcdj3lSbsFbz
BfBULbcEnLxdKmN85vc2ncJASAg3ABpcMqrzk8LhKCB4i/tN2JLtTmNcpSBIyQfA
3XbUkc/Q3A7EabGFZIrydr3UUeAkjknVD8U12evfsJTcsTR3LYwuryU5gwo2fCSE
exV9uIfrVJJ/CBZa+be8mUHcnZl/fv/8JZlMi40KWXKtYIBG1VGbsJjne1zyVsae
HsNUzCNM
=2t4Y
-----END PGP SIGNATURE-----

--r9GpRz0+4U+ao/28--
