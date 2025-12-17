Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C45DD65C77
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 16:06:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B6EC83B32;
	Wed, 17 Dec 2025 17:06:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aezeRqqf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E737083B32; Wed, 17 Dec 2025 17:06:05 +0100 (CET)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3602483AA0
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 17:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7c750b10e14so2538417a34.2
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 08:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765987559; x=1766592359; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DmNmwsd8e/5r9Rl6W982/Ln6PNy6fCMnSBCVGatc0lU=;
 b=aezeRqqfB2YlgjWkU1JR1NtGTjE9kBt/sC9Cko5YWbXrOeJcMklkbgG4dzDJxk1Ndi
 XbktuSVY90Qlt0xOj5J2XLdpdPKGnZjvo58wi6p4Mvm9G7byoFjzLJeaiekGzJdg1bW8
 cpwLGzwKp/p0hWxLYBsLWn8e33fn9GHH4x5qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765987559; x=1766592359;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DmNmwsd8e/5r9Rl6W982/Ln6PNy6fCMnSBCVGatc0lU=;
 b=q2797/miSzf7upznrfTvkzP3bMdqZTdY/9lgSHf4TP+jX9lMfINQIsUL0HNfuHZr2l
 eC+MuoCql+2VLS59Pe98u7zrIkqPRycxvokyFWhrsugV0DIwzAj4wd9sdfgPqIkgMZWt
 UBIOaSsa8tjafAJyFpmm5K0wnnvmwElFTKsDaHZFnX13Hs9ycTzen/KQlePEE4YzXBvK
 ZN4DtC4WuctiUnPD0KlHJqphdleNV/qgsMk8EOj+YOvja73zwScpSQ7wzdA0U2mEYBUK
 Va0edFelG2vC2iUaTPSo68hHfrV8YbyDhqlxGq6ti9OhMzeDor6U0eoeQG2321jbc6PF
 sq8A==
X-Gm-Message-State: AOJu0YyItGlOeLbw11mReLBbme5hBoCEet0jT7mjwGl3A0RN2/dnRvqb
 eviwzapADyB9aULwLcDXF4OZgtnb+VKj8azODScqEJRd1tA216WMo8ahvha0ZvO7ID+0ivXhZEo
 7lds9EWc=
X-Gm-Gg: AY/fxX4EedvQ90QM9T0Jh2K0K2mSSU3V3GsQv+IaFEx9ulBbgFDjg8+v4IwAm5oIQAp
 xgt5gMpEgK66v8kHybV8rYiYZE3nC6e5aTKhx37C2wiQVENeKWO4m4+yAX89a2jPEd4cAnHQ/JQ
 RaacvOgTTtlAFZTSsxIfEBqrZdbOMgbk9rMdW8DM11FMhJ1G6KGEfsqwCwvdXPPJdeiGBuXRya0
 EFFDEZKou/I9r8s7kNiIWdfRO+7dHRWIOyZKSz+2fhVyYY0s4SKay3Bj01oZ2Y8YCOhREl3Gp4B
 rKyUAkyueR0Y0qJfnGCliIH9zO3q6D5e6k8yDIpCzercn18W6fWTmSzdMGVkkY+9rx1U+bnGU8Q
 J3a8a0vvm4LpNCr4oiWwSA1OLw9hnGUvGHC57H+nkWh2YOOLufxGGdiDDV9VAYSK2IGCspLo+Dr
 Sh+PhdvDCQReiIStA0hS/Zw0p7lQ0UXr42UWaF0n/kuVClFSHZ/A==
X-Google-Smtp-Source: AGHT+IFaIyKVmI3LIqGTNJOFceoQPZHslX4tb1dmAnXeBKbv6TdFnv5zMAP819E+PlUhgyvEoNIiGA==
X-Received: by 2002:a05:6830:2405:b0:7c7:1c77:f107 with SMTP id
 46e09a7af769-7cae8398d68mr10057288a34.34.1765987558778; 
 Wed, 17 Dec 2025 08:05:58 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb3246b3sm13388882a34.21.2025.12.17.08.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 08:05:58 -0800 (PST)
Date: Wed, 17 Dec 2025 10:05:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [GIT PULL] please pull scmi-master-2025-12-17
Message-ID: <20251217160556.GE303283@bill-the-cat>
References: <aUK3gznUWeKoLi_j@nxa18884-linux.ap.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Rf4ZyvP9Bue+vUXR"
Content-Disposition: inline
In-Reply-To: <aUK3gznUWeKoLi_j@nxa18884-linux.ap.freescale.net>
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


--Rf4ZyvP9Bue+vUXR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 10:00:35PM +0800, Peng Fan wrote:

> Hi Tom,
>=20
> Please pull scmi-master-2025-12-17 scmi clk fixes for master.
>=20
> ---------------------------------------------------------
> Fix non-CCF priv initialization in scmi_clk_gate()
> Fix typo in scmi_clk_get_attibute()
> Remove duplicated scmi_generic_protocol_version() request
> ---------------------------------------------------------
>=20
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/287=
70
>=20
> Thanks,
> Peng
>=20
> The following changes since commit 47b50fb1125c539d80ed3e7f739c02c6486e1b=
52:
>=20
>   cmd: part: Fix part argument description for `part number` (2025-12-16 =
11:14:53 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git tags/scmi=
-master-2025-12-17
>=20
> for you to fetch changes up to c3c30da46fb7aa31de428bcbb96c973493d70695:
>=20
>   clk: scmi: Remove duplicated scmi_generic_protocol_version() request (2=
025-12-17 16:36:32 +0800)
>=20
> ----------------------------------------------------------------
> Patrice Chotard (3):
>       clk: scmi: Fix typo scmi_clk_get_attibute
>       clk: scmi: Fix priv initialization in scmi_clk_gate()
>       clk: scmi: Remove duplicated scmi_generic_protocol_version() request
>=20
>  drivers/clk/clk_scmi.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)

I saw Marek had comments on at least one of these patches already, so
lets get that addressed, thanks.

--=20
Tom

--Rf4ZyvP9Bue+vUXR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaULU1gAKCRAr4qD1Cr/k
CiiGAP4/QTnLaJsLpGVQtzprCemF4Mu3V4R1Zr1R2xx5R4wshwD+PhHJf1ikq6vk
6z2nc9SfnA5SyyVmmORQ4OtRDHeUswg=
=Uu11
-----END PGP SIGNATURE-----

--Rf4ZyvP9Bue+vUXR--
