Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C29CC27C40
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 20:49:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A368287642;
	Wed, 22 Nov 2023 21:49:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z4KDNC60";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C112D87627; Wed, 22 Nov 2023 21:49:11 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24B628763E
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5c8c8f731aaso2254657b3.0
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 12:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700686148; x=1701290948; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZMCo0FQOgUKavjQFdh8UhspyioalLH5Ut90BIob80nw=;
 b=Z4KDNC60o6XDXfr40FhEq1cQx4EO0osaCejycVCG7sK3EIut76LLcVlbazp754aN2/
 UMNH0+NLZNndUfVmOmVp/drEi5h/b55x8NwC1GdkeSBLGcvzarA+1xFHZp8PyGQygXsa
 mV05IZjKfF5Gij9G+yhNZGcJO9iSwO5eN1vLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700686148; x=1701290948;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZMCo0FQOgUKavjQFdh8UhspyioalLH5Ut90BIob80nw=;
 b=epR4USHqNrAv8Uhhd37TAkB5YmZCUJtVI9P9SaAKTzpH6flNny3X3VkRB6Xc1/e20G
 ziGhWAcGRYY2pDhZJw2zeXst4s7rHDmMO5p8zjbpkXv1zuUMbpHSNCfjJGZvph6nK69C
 jXvkdFACIFdjVMPhFfyUurCBe18gGmKvac2TcM+YsS1CnVnDWF7jNVP3IgVCnYqz817L
 jGV8cEI2MD6Xj9cZYfnHKjz0C0ALiVMKs6xQ89jCI4G38qBEkwx3sRvz+mSxH/1mV6bN
 Ze+Kwh0awpjZjqyA4ftBh/xi6cqCWV/4sAnqTcXiqLD6ZZ0hGmSd0hb7SZ57+Nwyt1aU
 xwRA==
X-Gm-Message-State: AOJu0YwaMLVF7iqlmBEm6/bhPpyho2k0wCNc6UpicX8rE27pYyl77Plg
 cNXaR4hT+tN60nN5T0htzI0p/A==
X-Google-Smtp-Source: AGHT+IG7O46CSTn1k8/ZKeP7orLNKtjuuFxaeaiRfpMc6oDYwGnaO/1EEaoUpd99d4pLmMWYSHct6g==
X-Received: by 2002:a0d:e289:0:b0:59f:b0d9:5df2 with SMTP id
 l131-20020a0de289000000b0059fb0d95df2mr1162223ywe.0.1700686147874; 
 Wed, 22 Nov 2023 12:49:07 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 t67-20020a0dd146000000b005ca4acaf181sm90580ywd.32.2023.11.22.12.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 12:49:07 -0800 (PST)
Date: Wed, 22 Nov 2023 15:49:05 -0500
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 Simon Glass <sjg@chromium.org>, Bryan Brattlof <bb@ti.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Le Jin <le.jin@siemens.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/7] board: ti: Add dependency from TARGET selection to SOC
Message-ID: <20231122204905.GY2513409@bill-the-cat>
References: <20231101203530.80359-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kTzOTceF37RUrYdU"
Content-Disposition: inline
In-Reply-To: <20231101203530.80359-1-afd@ti.com>
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


--kTzOTceF37RUrYdU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 03:35:24PM -0500, Andrew Davis wrote:

> Currently the K3 selection for TARGET boards does not depend on the SoC
> for which it is based. This leds to the odd ability to select for instance
> both SOC_K3_AM625 and TARGET_J721E_A72_EVM.
>=20
> To fix this the target choice should depend on the matching SOC config.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

For the series, applied to u-boot/next, thanks!

--=20
Tom

--kTzOTceF37RUrYdU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeaUEACgkQFHw5/5Y0
tywyXQv/eQYepfhHGZ5KOHPKmahmlXWF6TGqb0CvrfurFnkmSDCMTHHtaCbDlk2+
UujYaHT7mDn/5rLscYJCQvWfsk/niwkUPaj67GMmLrpkksjXzze/jvFP2hBFe8JI
rhzIW2vbhUI5SSK76uC2me8HPMTPNcZQtE+PC83Ef3zn6mJfc17xw8FFUGss0pj5
4v4YtGHeoztB8v9FH2nb2Tl2LKY9PTCLLKAaDW0pDIj9+9EnJTXf1qON+Pn1ZesW
MATMNI8IqEbhgLchtMN4QiiJkPjQI/z6Fcwba4Q3VdSqSqxz9vosrZ4NxGhHK8rg
MR5D/7DCWuVB6wP990kwxJ4qxTxOhYuY0ACajzp4UN0IpKEkimJu3B9nBwEha61m
93Gv0TzT5R/RTQRMJv3Y/6+P1nDlq0wqymlFkfJMHA1tFS8XcITcCpxQW3dGpB6s
yfDaJHndn+1qfQTJGf8QwTXrGd0KXQQt1tfy5ELk90+vPIOI8OxPFqwRMzlIU2we
5aYYW5Gk
=RppE
-----END PGP SIGNATURE-----

--kTzOTceF37RUrYdU--
