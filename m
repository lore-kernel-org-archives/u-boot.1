Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F86FC4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 17:03:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56F2587CCA;
	Fri, 19 Jan 2024 18:03:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M9Hf0RT+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90A7387CCA; Fri, 19 Jan 2024 18:03:29 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F03B587CC8
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 18:03:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5ff84214fc7so10640377b3.0
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 09:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705683805; x=1706288605; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b4z6MJ8duHPdeCXEYevtV/3annvngP1C50kXSwYDa/4=;
 b=M9Hf0RT+0EX2ktet4oxkf0q6zbK6qpaleOcV7sJ6/327DdkD79Cmh11FB1FTFLOk7w
 fWqvP63tTlyad0mVkmgymJZGABNiU+63fRV9ZcCZAt9ArPf5hvPL0OmQsrK09CKz2T/y
 bMny+P3J3xvPuX431xZGIwEc/x8/KVSk5Fxa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705683805; x=1706288605;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b4z6MJ8duHPdeCXEYevtV/3annvngP1C50kXSwYDa/4=;
 b=Qz3gyC3SDgqso7/oVS3vbeIUzJXhZVDhwhpHIrC08WeRqHQRBBbUbKM0Vyn2CqJHWj
 a3qZZ4WMGKfVpcZRTo2xt+MEemMsQm7jBTjHKyIC1KHnS4rODHzoKRmxXauqfhIWkSly
 BfggotczP7Xg+w/x6NTm73E9SYKTdbNnRP9fM+NSzYnKTw+b4vMGKYP1cXOun28KvA7f
 DJXmkjMSxO1rvUbqxLUeQusrM1kgcOXeldRW0ls1a9o21GLgyWCdNekSoG9uZQ5WRu3I
 /2RX3mtK/+qcKKkjXo+a0e4gKJuJ/MCtIT0UksspB3aNlMzI+mPaTQ9QKAUycRWF6ev6
 fptA==
X-Gm-Message-State: AOJu0YyVeXfu9ifd3waNCQ+zDx1cM3FTwKj05cr1U40hdX20Pe703gcY
 ITWB+kLct/x91p2qHjkOTK9ARlu9Vu+Ywaj48Y6j1hAhE6Q6wkNBmwEAPqTh9CI=
X-Google-Smtp-Source: AGHT+IEybbibv2pI/J6OHmbDMH3kRpToA4FyHlqir7Ekp2mo/DszE4kBYTon1w9iwMlu4tJcXoMYWg==
X-Received: by 2002:a0d:f0c7:0:b0:5ff:9ef9:913e with SMTP id
 z190-20020a0df0c7000000b005ff9ef9913emr203884ywe.23.1705683804681; 
 Fri, 19 Jan 2024 09:03:24 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 ft2-20020a05690c360200b005f953b9e217sm7424532ywb.61.2024.01.19.09.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 09:03:24 -0800 (PST)
Date: Fri, 19 Jan 2024 12:03:22 -0500
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Yann Gautier <yann.gautier@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot master / v2024.04 =
 u-boot-stm32-20240119
Message-ID: <20240119170322.GN12635@bill-the-cat>
References: <fc4c4d9c-187a-4e67-9be4-9e7ab9f414c3@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xapqFvVW5SEOfOfv"
Content-Disposition: inline
In-Reply-To: <fc4c4d9c-187a-4e67-9be4-9e7ab9f414c3@foss.st.com>
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


--xapqFvVW5SEOfOfv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 05:59:07PM +0100, Patrice CHOTARD wrote:

> Hi Tom
>=20
> Please pull the STM32 related patches for u-boot/master, v2024.04: u-boot=
-stm32-20240119
>=20
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipeline=
s/19379
>=20
> The following changes since commit f7cca7ccc5117eaafcc2bde91ad1bed6fee7cf=
c3:
>=20
>   Revert "test: hush: dollar: fix bugous behavior" (2024-01-18 11:38:25 -=
0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm=
32-20240119
>=20
> for you to fetch changes up to 8a4d098bb0859b3a26c9e1100ed08d7bd1f8ed30:
>=20
>   stm32mp2: Fix CONFIG_STM32MP25X flag usage (2024-01-19 15:49:20 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--xapqFvVW5SEOfOfv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqq1oACgkQFHw5/5Y0
tyxUoQwAn5o0QPf7TUJWKHIJaJyeXTaZ5Xh6ZNhk2LPMx8toCkh4oJ+nz0ZrMXdD
ymfr3V6uxfBDznGXF5pF4RZyQVA8S2EmerlhfKACp73dD1tSm18n6DsTqarQi/MB
m8SF7RlpgFNKWL7df1pTLzMfMukB8qbLGOtuCsFQ4wtl6kdvBL/UsnLA7/lCG5cY
It9pWKkqGM3zNQlghYGbWS42ueaJgi7acTAk4w4C1jeR8R2/Om+ZtaKx/dDZteHg
N32b/kCs0YW5iCgIuhcjqpjI8/N0mlviT24vYHp+uNr5muAE13k/RwMyfe2M0R1n
q+7Vc0aoAwW47mniDNB/++g1SHPKPO0XReEJ8ncQKb0zXn2Kb+v5vh8kXFzv+BXV
A8ITr9MMwClkkvTrxxd4073QdMKtrzT9s1wlO6wnkLDsh0Ro5qXFJSnNHbzzzlEs
xDaNkMpsY/gef5paZfbclz8i5A+4FbuvJ6zPNlm3Yh6ddVwbMPyPRN5EnE0IZBL7
JrOe02zR
=mj9g
-----END PGP SIGNATURE-----

--xapqFvVW5SEOfOfv--
