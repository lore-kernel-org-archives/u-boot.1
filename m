Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D458AD715EE
	for <u-boot@archiver.kernel.org>; Sat, 24 Jan 2026 16:05:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1265D83B32;
	Sat, 24 Jan 2026 17:05:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AlXWEglB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D806F83B63; Sat, 24 Jan 2026 17:05:31 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8F8183A36
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 17:05:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7cfe2a6bf81so1029149a34.0
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 08:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769270727; x=1769875527; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4ZmaNtqvQfUjgf+RneFtoy+WZxS9SqLWHNmqY3VZsn4=;
 b=AlXWEglBnQKL8/6ToRv6R9oGZi90elE1bMTTKYAOIAZoLsk2sUX9UL27mD4Uc9Qf9V
 eCiLQf17/fHkALRsbKqqKRGt6QJjLzDimVOU04RB5dD2zHnANi42tih3yFBkJG/t0u3e
 mRlS/7mIgKVtnjr0KGpIdp0dAcRmqNreNxJ8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769270727; x=1769875527;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ZmaNtqvQfUjgf+RneFtoy+WZxS9SqLWHNmqY3VZsn4=;
 b=pTfQrM0VkQoDqY9mJYYlBQUhK92L35+RCMq0PGgBHsBJS9N9fbQaHZexufkH8CHe6G
 9W0ZmaaYpFsRs7l0BBU3jtUMxi9/c9tRKSU3L1ctgbs1KfBg/VPzdasrjAFBroc0ULNI
 DZihvVp5K4lJ3u+zMtCoyeZP9xHKHF4ttOFx91AcWj6ZDw1Y0LHQUnicc3mfABaHr+0I
 ATsZYwQRySWf0mTn8XT8QKviKAV/Mo15sK+LBGwJ8ADNXHJOXd9TXyHDDiw35AmhqMhn
 KCYXIkuO9gkkK5X1AQNkah3iW+z1WobjOnkVwz1Wf1kdL4P91G+rcb0Umi2SdN50IbPH
 lMPg==
X-Gm-Message-State: AOJu0YzbahFBZEpyklnQfWvI9HjwfCk247PYq9xyfhK5dWXLCvsrVC/p
 fkKHqSTbYv1/BKlqMBM7tkhO4gNmrZ+ACcc0g22JeKZbLDg5HscPcakdNiMmRp2/N5Q=
X-Gm-Gg: AZuq6aLq4NOQoieFOFv0GbJ3RZtL8xdZpru3LxCAyFiXg3ftADYuhWjbiwAEuCytNtd
 5iSPKEvqt4+31Mkrh912h1dijOcvFtXgZtsQjDsKiaJgDGfAlYPMG6FwtcnOKaLHqesWaoiOiTH
 KAAZ3tuLHZ7yRHeFL4R6bnvPwct7OXPLrmv4GHeTPoltPwgDf+QRtHd0DUwv6swxNlQ90TcZ9LW
 nFnXQxCpLt6jW6MO6FdYXUwUIxX9HPyO1TQweI9ybdmKqi/KuDKBTg3dDZho0viQ/dhHX/WoLx7
 unhQQElEsnKxev1f8eq+MZ+sC2NHYgS3rTIhSPLZSB2rBuXx5eYYHccFHjEy6DuAqr2TER5nJNO
 GJ3kmC5CMg/APDzitzjtr0s+ylEZmzWMGLZYUCuiyCBjSWzY61qgGrFrvVL6T/TLCzrPs9j7+5T
 q+DKcU0Hdgz9njh+9DxTJ3H3UVGuCVxHjjRIhij71B0LxYy5XcH4RefBpputUilfn+Uti1y4+mI
 O1XOqB5n1ucCzBoYPuasoqGMDwwCdVnahws7q4=
X-Received: by 2002:a05:6830:6a85:b0:7cf:d119:8c1a with SMTP id
 46e09a7af769-7d15a5d78eamr3244028a34.7.1769270727379; 
 Sat, 24 Jan 2026 08:05:27 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-408af7ff54dsm3627003fac.1.2026.01.24.08.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jan 2026 08:05:26 -0800 (PST)
Date: Sat, 24 Jan 2026 10:05:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] dts: add exynos arm64 vendor support for
 OF_UPSTREAM_BUILD_VENDOR
Message-ID: <20260124160524.GP3416603@bill-the-cat>
References: <20260123-dts-exynos-vendor-v1-1-479e72170257@disroot.org>
 <20260123182003.GN3416603@bill-the-cat>
 <DFWMTYEQKEJ7.2KB7GXDI6E0P8@disroot.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8r3W+9aG7q2RxAZi"
Content-Disposition: inline
In-Reply-To: <DFWMTYEQKEJ7.2KB7GXDI6E0P8@disroot.org>
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


--8r3W+9aG7q2RxAZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 24, 2026 at 12:44:17PM +0530, Kaustabh Chakraborty wrote:
> On 2026-01-23 12:20 -06:00, Tom Rini wrote:
> > On Fri, Jan 23, 2026 at 11:41:41PM +0530, Kaustabh Chakraborty wrote:
> >
> >> Set OF_UPSTREAM_BUILD_VENDOR to build all devicetrees in "exynos/" for
> >> Exynos-based 64-bit ARM platforms (32-bit ARM uses "samsung/").
> >>=20
> >> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> >> ---
> >>  dts/Kconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >>=20
> >> diff --git a/dts/Kconfig b/dts/Kconfig
> >> index 870f75ad3ec..e0f6f03a343 100644
> >> --- a/dts/Kconfig
> >> +++ b/dts/Kconfig
> >> @@ -124,6 +124,7 @@ config OF_UPSTREAM_VENDOR
> >>  	default "marvell" if ARCH_MVEBU || ARCH_KIRKWOOD
> >>  	default "xilinx" if ARCH_VERSAL || ARCH_ZYNQ
> >>  	default "nvidia" if ARCH_TEGRA
> >> +	default "exynos" if ARCH_EXYNOS && ARCH_ARM64
> >>  	help
> >>  	  Select the vendor to build all devicetree files for.
> >
> > Two things. First, it's "ARM64" and not "ARCH_ARM64". Second, since we
> > know what the 32bit one is and it's not the same, we might as well do
> > both while we're here?
>=20
> Sure, I can add it. However "samsung/" in ARM also includes pre-Exynos
> SoCs, I assume that's not a problem here.

Yes, that's fine, we can always add on the other targets later.

--=20
Tom

--8r3W+9aG7q2RxAZi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXTtwAAKCRAr4qD1Cr/k
CpicAP9LiGweZCcz3wu7KgwLh6YXGkn6wSunGsOAU5ojT39opgEAkxJdn285Oq5+
NkUYpoTZneyEyrzTZcpx18mNYKcLFwo=
=Dmbu
-----END PGP SIGNATURE-----

--8r3W+9aG7q2RxAZi--
