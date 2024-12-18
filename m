Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABD7E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 17:40:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 300B380269;
	Wed, 18 Dec 2024 18:40:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ATeokrPE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB8D980269; Wed, 18 Dec 2024 18:40:03 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33E4480241
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:40:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b6e9317a2aso85304185a.0
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 09:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734543600; x=1735148400; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8w3tpdw0uGlTAQUT+peuz0A9wnHvOh/5MxmEaJl/yF0=;
 b=ATeokrPEe1+HXCqe2hXCcy21TgLUJhtHCqvikJZgN5n9cOwCJSL8YP24MZ/NiVlMAj
 SuKjl2kLjU94/vptyiX9ApDlVZeyDaQiF3HK0Tc5IRhrbLax9hqNn4Nnx/MiEYa/PJcm
 13+L4hGGv1VeTtlhVPSGGQAW2x+loGxnINfgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734543600; x=1735148400;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8w3tpdw0uGlTAQUT+peuz0A9wnHvOh/5MxmEaJl/yF0=;
 b=mK1yoNQTmxHr5pm6LF9QShzEESgFsvDfj2/fRV/M6hRW6XLcJPxFN87gigkvkxIiHK
 rWYHm2GUcrqiWGcA1KNHOaToG/JhLz2haAR3gakpsdOqfBifIQ/ks4uq0h2uihKr1Tv4
 rarFfPq6IuYUMU1hGbfP5ODvxL2j2zUCz5jr0YsOGNOxPjXhv1WZ4qXLa81EUmq8kcXG
 2gxNkUEO6qA/KHrTUtpkgP2TXm3DJEyi/Tjv//po9DW4jbRXV+NZw/+EbeKHxTZpMonC
 2gMoa6znYyiUqpw5JbbmoX7thbhfi2GY1IQqPpfgtIOlJDoTtDOWXtyPcm9tHqmKQe+R
 KNvQ==
X-Gm-Message-State: AOJu0YzOpiRpy6gKanBuyOTI3yKZdeunEO3mdF2sNAWejqtDn7J1XwPI
 W0tREKUkP5BvfBAgNtgdyHN6Xfgcvke/ZIGZgX2vaugMfrg5rfwMiMo2eggIkTrxSoNoFEkOwxT
 6
X-Gm-Gg: ASbGncu/n7DThOY03HpUycIDrKpsumgqU4dq9Szb/Gc+b/SgPE1ErvhGdkcL8324msZ
 cHhP1b4h//vvq2M7tEp9va3rKu6HWuk++7i8fuMOa4Z7hcY0+rJfdwb0YPGITLB7vgHloQRm8cn
 D1StVUL2C8cMgnhIrhnixWPUNx3bMOxDFajebyX334H+EP47Lx7izTMRo47fnV78z3yAXRbgHpN
 EGA59lypzkU2E5cJ17kg8uVs/FFLNvGNfwicaFfw2koI+9FMRLHwzFu
X-Google-Smtp-Source: AGHT+IHHE+Brp2B64XMZfrzNEX1QZRzRogbZgd66cIiFIXbD8tYdcdgVp82ksLb/sO3eU/kweHKM9g==
X-Received: by 2002:a05:622a:1a82:b0:466:91f3:12ca with SMTP id
 d75a77b69052e-46a3af9ea8bmr2244981cf.8.1734543600041; 
 Wed, 18 Dec 2024 09:40:00 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2e84db6sm53187251cf.54.2024.12.18.09.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 09:39:59 -0800 (PST)
Date: Wed, 18 Dec 2024 11:39:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20241217
Message-ID: <20241218173957.GK1505244@bill-the-cat>
References: <20241217105433.1419146-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6OOW6/QniDJsxWfa"
Content-Disposition: inline
In-Reply-To: <20241217105433.1419146-1-festevam@gmail.com>
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


--6OOW6/QniDJsxWfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 07:54:33AM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/next, thanks.
>=20
> The following changes since commit 8aab7730c1c26192b0e4218fbf2f6009f955cb=
88:
>=20
>   Merge patch series "Hyperflash Boot fixes for J7200/J721E" (2024-12-14 =
09:34:27 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-next-20241217
>=20
> for you to fetch changes up to 7cf57825eb4366a474ee0a13ef690d460f8c4775:
>=20
>   imx: hab: fix srktool -c usage by removing spaces (2024-12-16 14:35:58 =
-0300)
>=20
> u-boot-imx-next-20241217

Applied to u-boot/next, thanks!

--=20
Tom

--6OOW6/QniDJsxWfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdjCO0ACgkQFHw5/5Y0
tyzlsAv/X4hWUiO+OEnBKIgH1RpmYMngcjsCvYHEGec487rQSsSfdgtqRhHhlwip
sPsCq9NlmG9QlT/puysHNTRvjhBcbdBzGQJWBqI7zw0l+asJ8u/Q1ta7dkbuMDRB
8FiVGDC0HDbssmt1Ua4vfTKNX0jkxORwNzidCQwVUnxBOYRzYy/2bZFDdGGNBM5g
H38a2nMVz9jERJ6f5eC9TEdlELk28qL7Z/A2tOCmHXTg0WTgL13jLu6Z1b9c51oS
hEb9SBzHWlyL83UiHlR6ENIsxeLEH43em05TaHuw9G0HlOrgi/oEtMjgp9pA4es/
RYiNgteba6UtOu96nzRzOajxdQPsEUHa+GTox88JVAV/qBrpuls5uLxABlyi7EuT
0nb/bQ2G1czhIlUGr2R9/qSh70bA8360fPXBBKn1DcDam5tt7dFYpjXNh0w6LbJ+
iMdrMf5GtvQa5U1Dzy2ZOh+gpB1jozDwzShVNTUMAjAO5fhYE1Bpx9lD0KS6jnRE
cOZgUtYu
=Y8yG
-----END PGP SIGNATURE-----

--6OOW6/QniDJsxWfa--
