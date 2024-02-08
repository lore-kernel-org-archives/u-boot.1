Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B350C4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 20:19:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AE3787E2B;
	Thu,  8 Feb 2024 21:18:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TDQjtds3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32AC087CE8; Thu,  8 Feb 2024 21:18:52 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D28E387CF9
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 21:18:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6002317a427so2923227b3.2
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 12:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707423528; x=1708028328; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5H9jfZaq82RHVCQ5Oq4Z6C/zwnaRYifkftCPZJX0Aec=;
 b=TDQjtds32BpHaY2KLxx7JcOmRMei/MLXcjBBIhKVkHsUy1CDRbMzuXfPXpxZvulm0T
 T69WYIbPSPqO8yFFSC2+hvp9++Ck7dVCdOqJ7R8iweN7A/iOU3fjihyaeXRoGvOLdPaz
 IFcMNEVs3i4jBsDhFS773LilIRePNApINfcQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707423528; x=1708028328;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5H9jfZaq82RHVCQ5Oq4Z6C/zwnaRYifkftCPZJX0Aec=;
 b=Ebl6BuyODPfWu2k3+h+L7z6yXKAHmhbJKgZzpyulmTn21EnmoE54oqqgYcVSAigw+Z
 NXCLEnGSeADdDXHNnL+aofjVioNzsjYPiPOQwUtPqI+kEMO9AEsrwz8ubQn0+iFpp2WE
 tSOShvBbWxZRL8h38e6nUYoyN7q3zwmcTuyLEcYAOEvczwN/hwRkZstk36JLf1vhFeGb
 tYPotcqlY4kOQ8OMdl0/lOut0Oxtxdqal05PQa6bKl8yYdzbaKv4+piKUo/YT6HUpNDp
 tjTXtFPkoNBRp0UkyrMVullwld2uz//Ge0R2dGuag1btt2zPm02/Z0q1eyaer9qTDeZC
 2ONQ==
X-Gm-Message-State: AOJu0Ywb5YUxyZF8lGGrtP4z5yV+ZeHvgYd+x1Fbv8aPoyKcMhETGg0C
 gu/kzxjXEHMKPDzD1kuBXw1asd5lcK3IUVQomUtj0mbvzCjtpWkAyfnkEAg8abs=
X-Google-Smtp-Source: AGHT+IHRj4j324JH0M0G03p3H5bAgWG8zMxBeb2UnwuRxu1M/D9sfi5pP6CetCmKfG+q6sDCYr9u8A==
X-Received: by 2002:a81:9e0b:0:b0:603:ebf7:947b with SMTP id
 m11-20020a819e0b000000b00603ebf7947bmr470867ywj.48.1707423528249; 
 Thu, 08 Feb 2024 12:18:48 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU1kTWIFoAlzcVmkjrxPmZx5afuWSoYxMzTFnppcBhgWbjcw1U3IRnYxADuBXO0P6+MYjn5Z0irWRfXfYTMl28IOaXpX1iyTvL1iZ3AlrQlgcZ49I4dCNO0aoKQHgQbdYt6SLIFpppM
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 d192-20020a814fc9000000b00604b7668cd9sm23043ywb.54.2024.02.08.12.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 12:18:46 -0800 (PST)
Date: Thu, 8 Feb 2024 15:18:44 -0500
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "U-Boot@lists.denx.de" <u-boot@lists.denx.de>,
 "mike.looijmans@topic.nl" <mike.looijmans@topic.nl>,
 "Radu-nicolae Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: Re: [GIT PULL] please pull fsl-qoriq-2024-2-8
Message-ID: <20240208201844.GK1152441@bill-the-cat>
References: <DU0PR04MB9417865338E6CCD3646DBF2288442@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pxXSM7M2YCzF+8CH"
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417865338E6CCD3646DBF2288442@DU0PR04MB9417.eurprd04.prod.outlook.com>
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


--pxXSM7M2YCzF+8CH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 11:59:32AM +0000, Peng Fan wrote:

> Hi Tom,
>=20
> Please pull fsl-qoriq-2024-2-8. Sorry for not being active in the past ti=
me, will try to
> catch up.
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--pxXSM7M2YCzF+8CH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXFNyEACgkQFHw5/5Y0
tyyDygv/WSHBVkHMilxpqQ68wzGd+V3R79U7AcAPOF4iJJLZyqqz6kVVeGJ9376i
Lzt1Ii4SqB6zvKM8uPd2m89fTp2ltuWt735CZkXWe/Fny0xnJhG7g1sjeGPAyFfy
tnh/sfreC+oA9v3CdBEdcQiCUI9VtMHUX7nZ49cufacUHr1Ajwkhn4MQfX8ZIykG
lupeRHgq4aCQFzcz/JPXVLbQnyEbnkUgBxSnE/mDcEB691LjtAwW8Lh7WXPq9/sH
6Uyd/tNwRQ0Ak2lUoCnMCdaolNfFeBohzT1J+36oxsiwEHSpTqcbpCuSZ3eZPanZ
awSYruiK8L6OMQ5aEYdn7T1fBTXiF4wsXnvrsgX/aqILKIgHmXt3ejtpeMN57CEH
I//AQCUNBtIocVkoECmjyPCC6oCfGTzHGF2BQq8Mot0D4tT8ZW8vizctNRd0i5qN
gUA9CYWm9EFpXrmw2Q6cO1hioF6tLvaXatSn0CJ1TqFOcezxGq8rhHAj/7t6AOzf
B3WzMC8f
=gXbX
-----END PGP SIGNATURE-----

--pxXSM7M2YCzF+8CH--
