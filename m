Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA58CC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 20:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 252AC88A04;
	Fri, 14 Jun 2024 22:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sfXbCMMC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF65488A08; Fri, 14 Jun 2024 22:30:29 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9716B88176
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 22:30:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6f980c89db8so1394182a34.1
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 13:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718397026; x=1719001826; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wQi9tnm8TNsCUMjJWccAbOBXKAJxxOxdPdIN2vO4Hdc=;
 b=sfXbCMMCNikEnx9EtukFdk1btjtgydFC/RAQqxxlyky3TCT60kqQ0nQ6WdmgoGHAwt
 ZCieNjc6S4dRpCY35C29tP2edO0Kk1NyEd3st/zHRo0xwt8MOaTVY1yHZaQz8ktPsFL5
 g7WZFrZTO8JBCT8YwSf9bLQPUEp+XD8Dqwkrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718397026; x=1719001826;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQi9tnm8TNsCUMjJWccAbOBXKAJxxOxdPdIN2vO4Hdc=;
 b=V/Z2mw9hKwLT/tYHLbuwxXTy6k9uN4drF5+eyjVWjKD7c5BZYSknvu0dhw5hRm7v1H
 uuyY3Rtj1G1Cl75a5mkcv+2U4XtRl0qeW8TmJfNMhFh9VLBXyMYsvN5MZDDS9ImirJuQ
 kc+c6pymg2vX3gc6pjMeWdJ2HRJVh0YLFRZhwiq/5PjZtEAOq0L8X21lEUjBq2Xt3DF4
 l05g9IJl/1Awd+cvQx/1KzuaoHhBOEPKsDiEv3DJ134H5RcnyM6LK5T6eApsh/W+H5Nm
 H+qjGEEkvAPjQVPJ0aVYTa/CU5B8GeCm4PhX7lVUNLfcH29EjPbrQ3KHlZhQ9469mpF1
 NY9g==
X-Gm-Message-State: AOJu0Yz0HO9GP2lBvWQXDfpwAsCY2qlBRjKMAzZdd7BAJ2ZmKKYhU9AS
 XlyoEDDv4K2ra1ATKRZHLJ8sQCGGvk9KJpX9UYEdmoDaDrIfrK4I/IsFYQmTiFk=
X-Google-Smtp-Source: AGHT+IGr33qbvfvuDUnKhdh6hdQvOovKghkaog611GrhpclX3R8UxRK9PgDOV57ZnSqbuEjpFV8HZw==
X-Received: by 2002:a05:6871:14a:b0:24c:b0ca:9650 with SMTP id
 586e51a60fabf-258428b6fe0mr4371502fac.1.1718397026115; 
 Fri, 14 Jun 2024 13:30:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567a94a1d4sm1137510fac.1.2024.06.14.13.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 13:30:25 -0700 (PDT)
Date: Fri, 14 Jun 2024 14:30:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH 1/2] net: phy: Turn default auto-negotiation timeout into
 Kconfig symbol
Message-ID: <20240614203022.GS68077@bill-the-cat>
References: <20240531164733.192105-1-marek.vasut+renesas@mailbox.org>
 <171837686047.2655592.885719495890320459.b4-ty@konsulko.com>
 <663b950b-11cc-4598-bf6c-75644d613859@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m4Xzi+itj2AQWavZ"
Content-Disposition: inline
In-Reply-To: <663b950b-11cc-4598-bf6c-75644d613859@mailbox.org>
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


--m4Xzi+itj2AQWavZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 10:26:20PM +0200, Marek Vasut wrote:
> On 6/14/24 4:54 PM, Tom Rini wrote:
> > On Fri, 31 May 2024 18:47:16 +0200, Marek Vasut wrote:
> >=20
> > > Let users configure default auto-negotiation timeout via Kconfig
> > > instead of specifying it in board configuration headers. This is
> > > the first step toward converting this to Kconfig fully, so far the
> > > legacy PHY_ANEG_TIMEOUT in configuration headers takes precedence.
> > >=20
> > >=20
> >=20
> > Applied to u-boot/master, thanks!
>=20
> next, right ?


Yes, next, sigh, b4 was a bit funny on all of those patches since I was
in "master" not "next" at the time.

--=20
Tom

--m4Xzi+itj2AQWavZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZsqFsACgkQFHw5/5Y0
tyyGnQv8CfwM8dmh5LRYFNa+veMdwWVi2sqJgl9+YS2fcEognf0nEmE/li4qWIOm
e1yAJTGWVmrAPrVfzxGH67NZX3VXii+aCYBrGV/JqpGepLmVYGoKrE6AzVbORNJD
EjmsxfDJs+OAxoPdO7OFmm/oRDN/CGuDNGCAFoCUdhpazaU5FCn9QevvcVJrgOay
pUjXJrRSNRLt/qwtuStDbd0YV+CrdnDgf8P+K/s8fRcpH+MXrNn6LHesTvkbPXL8
NoXSghr6gB/OnFH9BmfRjQcC6uiD8uXWxjsABuPdwRS6lD1mnpfm4lnJ6pVYAlCE
FQTMc8hBG9v66gM1fWF4atmIEYTXhoLRz7srs6FQuZq8dxL9ozqwJpyAlWnVAGJ6
YGHuuFo3XRxU/Il09sPznWI8DaccXeuTRttT7OaqHLpI2DkMe0zKc8I5B6JRBVm6
FzqecJX0ZPx8rChPz656tWmUyzTVfCpB/Su9u6UselLso2iB2Jb/cndskUUs9XxO
6UxUujYW
=qceU
-----END PGP SIGNATURE-----

--m4Xzi+itj2AQWavZ--
