Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67102C47DB3
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 14:14:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25B0187D03;
	Wed, 31 Jan 2024 15:14:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TyPSZbLP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4431F87C26; Wed, 31 Jan 2024 15:14:30 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF2A387CE2
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 15:14:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3be9e11ee59so753717b6e.1
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 06:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706710466; x=1707315266; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fOgyu7/2MlezZ47XmY0/uWMCO13xDaXQ15yPfpB4CJU=;
 b=TyPSZbLPv+rqXyLaPHaXHmoR3xxGRIjBrIolzR7k07xzd4CjWu8RwanXKom0rPROx2
 iggkTUZgcLXZ4maPLS/fD9SK8w3Vlp1Tm8MC9gx/PBtsrv7q9sqVlYVrCVSDZwAnyk3z
 yFn7H8upSIF8y41+bmtyc21vrcu6YtoqOJ1hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706710466; x=1707315266;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fOgyu7/2MlezZ47XmY0/uWMCO13xDaXQ15yPfpB4CJU=;
 b=wEJtQ67+13iezMcA7awPwiL2RzWldb4No8gYlfZxzfl0T29xnwpCGQsPKVoezUxygE
 31ksmqDuxHV6A5UbWS65B8S+6j3hkR/iCF2dv9TcguK1KbFXoU6z0X//knO82V6OnliN
 FDB73OIdlfU64FLQ9mtGSI27KwFO0iIS7zUNKYqHqUfcM6+Xq1CCc8hCeMrCExKl3puP
 wBIUZXEQddALirrfVTPoMrYFTGP2E6HloFntLqvhdKmB1eBHt4Ojv+UkRNJ4KiILHREc
 rzKm5Fbsm+N/BFDhxHaQOYLgjidNDM9cvoWlgX/8B8aaQlm6rEu/fsa7agN4NQ/+o9Ly
 NM7A==
X-Gm-Message-State: AOJu0YynTViel7lE2WplZrm82bk68bCXhlF36EJ7r4NMDTlFBo2l8ozY
 RfjoR9624nJOq9SOZxP0FRZVUIi23BZ2vnbIBh9US4IyFzz9FI8/GtXAm1lzu2ym23Wx/pC/SQq
 N
X-Google-Smtp-Source: AGHT+IEGasmAeNaf50yU89xZ+7B31qItp2o+EhxTD7YJFBPRVmuBASfdHeekgCnzVzFFCrnieyP5DA==
X-Received: by 2002:a05:6808:1521:b0:3be:48e6:10cd with SMTP id
 u33-20020a056808152100b003be48e610cdmr1879117oiw.50.1706710466128; 
 Wed, 31 Jan 2024 06:14:26 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 i11-20020a05622a08cb00b0042a9d64396esm3659561qte.74.2024.01.31.06.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 06:14:25 -0800 (PST)
Date: Wed, 31 Jan 2024 09:14:24 -0500
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20240131141424.GV1152441@bill-the-cat>
References: <ZbofLkNaJVFNIbj5@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UhZ2z/6Spp+aICw8"
Content-Disposition: inline
In-Reply-To: <ZbofLkNaJVFNIbj5@swlinux02>
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


--UhZ2z/6Spp+aICw8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 06:21:34PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit 28760ce8640ff6266bd1c1c568a4a231576f39=
19:
>=20
>   Merge tag 'clk-2024.04-rc2' of https://source.denx.de/u-boot/custodians=
/u-boot-clk (2024-01-30 07:54:28 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
>=20
> for you to fetch changes up to 6882255ac3107c58e1153311df8a8270087f8cb3:
>=20
>   riscv: dts: starfive: add regulator device (2024-01-31 16:52:53 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/19505

Applied to u-boot/master, thanks!

--=20
Tom

--UhZ2z/6Spp+aICw8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW6Vb8ACgkQFHw5/5Y0
tyz4nQwAsbpxjoXBlMiN4SwDQL9WF+rx9SijGFf6dcmL12Fs3YTYITePtXi5cNG+
3sIQ4OoJ3NwMIkjU1DCweVXiPJY+xxFtwTPiYPMs/3hbgcTzDmOGE1VQBcqTwo94
ZT0GK4/2HlVsW/A5MzTFPKbU8g4QRffFTVXqw6rj71qxLYQPOkodFnw1noJ+FxyA
9nRVLa5DijU62TAlpqoKMTXt+8p3s0wAocaT+Nf/ZU+/PB1yOEPBClbMFQRtgFu7
/GGgj9ECaZ0jfAz1h+TwHAd/qtTbNEAtC50AiVcVEZ2wT3qDFGxZezBYvJ7DPifF
SRxFQ7hPIFoN+rIjIp+htQoYNqz3BVzmPbosRCYAN8OhU8/Fsy4njdRlxP8zZr1B
Oa/dB3OC7vN8Of82V8XFHINr/Eb93HDLt/Ms6qRpRzttc31eabp+tOCWoZegt6g0
lURF+oow2YL2zdrNwF3NiNA4bSxdaL7cx9TMyXG2MxpuKM7TFRrI3oK+HJntGdEL
ki6rtK+G
=YJuG
-----END PGP SIGNATURE-----

--UhZ2z/6Spp+aICw8--
