Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC563CD343D
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 15:12:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6320B88C30;
	Tue,  3 Sep 2024 17:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SemoXHDP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF02B88C1D; Tue,  3 Sep 2024 17:12:02 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70C6488B4B
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 17:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-457cfc2106aso13008291cf.2
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 08:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725376319; x=1725981119; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4+aGJBuITHRa6avGZWY/7IhLoECTTi0X7vYciA8hPSQ=;
 b=SemoXHDPq0oddciRJG5V6hl/fLw3nvJzweKs74ZKnZjaAKFQfYAkqA5qevBcKhVI8J
 kJk1Dgl0LZxF4F3/QpBNJMRwrY+SyZ73QIn1YrgH1LOOOS1eeb4ei6j1eyhjBB8bK6BX
 Kmsm/IOxdy+2JSK3LWE3WhSt2N0+VxFN1eckw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725376319; x=1725981119;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+aGJBuITHRa6avGZWY/7IhLoECTTi0X7vYciA8hPSQ=;
 b=MeOi728WqfVck5MCIELpLLoaPSICWRFRNPF1wNaQk4k96beqlKKPlng/z5RKNjMvnF
 RIv5SV6vP+KyaBSkDWO1t7GEK1VnSCtwrnul6ORPxY19gWTNxQOwF0B2CBv+E4of5Eyb
 jp4AoTcFrqqgrZoE0+DkSAD4u24hNzkcKCAckxb/Pr4o+m/WBERKmsArW5eZKaXywa9p
 4nympaTo43Yzx5ndeEmq0Jwf6UMF9zvB64Usc/ZL0i9OeiEFoKfuCiNdAiCXKhitU0hd
 THBL58hlzGqyqVS6unLuGz3OR26BGJi3HZZS99uk/uJ1LKFxs8IUHl1V1aywogpv4aVv
 yOlg==
X-Gm-Message-State: AOJu0YxhfJRUXfsEbp88U12PRenKwQwBQAeIFeyXG0GCrvASMpAmN9sb
 U6AAETFRoVvk9tXDfupqSooX/WSN1sSryru8R2tcLe+EazkAaC7J+rM96qPRT2k=
X-Google-Smtp-Source: AGHT+IGg90R2EGT2+ZMmSwmQFKdIuedVzJ+rMFeZpHo+2SqxfHhUQWNce6WIYC6Y5eWp0w3yWjzW9Q==
X-Received: by 2002:a05:622a:5a13:b0:456:4613:70b2 with SMTP id
 d75a77b69052e-4570540997fmr175461571cf.49.1725376319067; 
 Tue, 03 Sep 2024 08:11:59 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45682d9592asm50815991cf.83.2024.09.03.08.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 08:11:58 -0700 (PDT)
Date: Tue, 3 Sep 2024 09:11:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20240902
Message-ID: <20240903151155.GI2479150@bill-the-cat>
References: <20240902174118.908571-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="snS/uiPLGPUXLnak"
Content-Disposition: inline
In-Reply-To: <20240902174118.908571-1-festevam@gmail.com>
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


--snS/uiPLGPUXLnak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2024 at 02:41:18PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/next, thanks.
>=20
> The following changes since commit e83ced1a24095de66e526bd6c10f0f24584baa=
ee:
>=20
>   bootstage: Fix unstash of records from SPL (2024-08-28 10:07:59 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-next-20240902
>=20
> for you to fetch changes up to d1349097222b5a3264f614b3e4fe672e0df26435:
>=20
>   ARM: imx: Wrap i.MX config options in MACH_IMX (2024-09-02 13:23:36 -03=
00)
>=20
> u-boot-imx-next-20240902

Applied to u-boot/next, thanks!

--=20
Tom

--snS/uiPLGPUXLnak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbXJzsACgkQFHw5/5Y0
tyyGVwv/b2V01mBIcFyi4yxvDluPG6BXhhzJnsQ3UxrP07Pg1zoIGy4r/fJHb28d
wDwMmFFAGZpRV/EWCEOivNNDqn5jsnagC2DjkSi6DyuhDexMOboCUzn7qqkmnmuZ
ZAMBKZtCufpnNdNEAZa3Y2mp6AAH9FkpauxKA4vLTU7W8mYP1TSavOECCUUKSFPv
A0y4yoDRlXPqmxPAx09BwSDU22txjxu9D/TSgLcivZrH9rquStiGd3Tj3VpsXquZ
lZxUCJSwAuBVA5+bXIDuJxvfh9tvXcSHDFXR3XG4fIp42LVl61cDVu8C0O5jHWcr
Qa7nv2UG+oJNM8NYnxjGlT4dl85Q+VdGOt5aT3Il/58Oqh1braFqmOJ9NwbETwsR
r+8bL+F4PN35mWy501rFFaUKj5g9VHhu8BwrxDYJ9nVhgb0CVvkMxn5uFJsMRzZr
KnysqMrw3sIcmoqiJd0We+d7uJggY3Aml774JjCgxmYne6LRnWZI09Nzbdg4egCg
fFVGiHtu
=bTvi
-----END PGP SIGNATURE-----

--snS/uiPLGPUXLnak--
