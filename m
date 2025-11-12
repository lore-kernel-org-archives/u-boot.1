Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7FECD13DD
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 16:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4881483CD3;
	Wed, 12 Nov 2025 17:41:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L2+liNhe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F0AE83CDC; Wed, 12 Nov 2025 17:41:24 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64CB783B91
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 17:41:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-65363319bacso428796eaf.2
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 08:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762965681; x=1763570481; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sTQjEz1yfhXzRh184RMRjqCzdVJOVDhBqBGXK3zMBQo=;
 b=L2+liNheKo+j4wb5Im+laKPg8hVDskn9eFolON5tuTeztiCpr/VGHZlQZ2t80zuKhj
 OJgjDjYUwh5vBQem1WRsWKm4PhWNps4vd5+q0ETSKKpcSNU/XOBKUyOTKvY7Yir5ZkHL
 0ZUxHwENjAW9OWzi1+cZl278S/mS0wIyGPu8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762965681; x=1763570481;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sTQjEz1yfhXzRh184RMRjqCzdVJOVDhBqBGXK3zMBQo=;
 b=lQpN+zOH+tXdqz7FIQODmEMgPsCv8v3g8Va2RzPs2H+qU7RlJ4CqQRJsVSFAIaAmB+
 6VUgU2uprdJ2JhBJp6VR7A6bMDIjYbxRGTpDDaOARzV2LVANEfZKnQnpDUid24IyFCAS
 /QFSOWzUJ4YzKclAtzIspg1AoCXPhCV7XXynOuBigyondY1j1zM11+n/ES3n8sOvDzAj
 14CHnaZsM272CYjjSY8in9CQeNyW8o2t9NpgdyE3Qg9tU9G6/QDh5W0N28F6vHctVezy
 5oDa7oOxIiYAq6D8F/NY0ssN0+tdHqhfNF6N3cx0FfQjqPS//2cT75ptQjW3wpWHrCHi
 gDDg==
X-Gm-Message-State: AOJu0YyHCWgdmvgknoDsZHu483FQYUBjiUPqDt7Y4D5XHrHGlkwUotpf
 ZD8Z9GAo+xyesozEuiucrxuaKo5iDftz0gNFblXuezHrqP1sSbmKMxbB6+9/zrqPqjs=
X-Gm-Gg: ASbGncuEw16h+hrGhLl7IXON3HBulK4FYp1lzwgPVetXlwdMxCRpsr3WLKZFo2jMUDk
 xuUO3z0F5/C8/VO33RLRGgmVaMn29+eNsDh5+zjYmYDyAWapZq88/K8rhS8lmYWRBoVAy0U7RNr
 Dx39dUbTMhDBmDrGjYLjpdiEyWk1EFAIEZrT3G+CfoJTNjBmgagfpN7RNDVyNynaHxaVslXRWVn
 /EKElxN6ugMmUBOkdalvnnM1U7E+jZaozNOAXZ4AYE/9Zexx/9IZ2FcDmKp3lofE9cd5m57UTBh
 XWArDPOMgH3EcXDe6ZHiUNH4xM7ch0RgwdNXzcEq5MwFKtNEzjUsyUZq71ZINtM/Pujc7AhhF+W
 B+ATawAtNpMeyIRDqBvdcGMoHGrxYcJOLxqnDrFG27Y3D3orHixbshNgPx2JPaHfcKJPeNXrLkX
 0FC8vlgWozYUluit4A9qMP4W6kg3iT4FIPW0lmhRs=
X-Google-Smtp-Source: AGHT+IE+reT+Igpe32H5vqJ6IiKBQI4mR4rpFljLBEHtq8NhG3sJcM9Ekr3QdgO1YWqb9vZsiDEgUA==
X-Received: by 2002:a05:6808:1485:b0:44f:da6f:edb1 with SMTP id
 5614622812f47-450743f437dmr1800097b6e.13.1762965681112; 
 Wed, 12 Nov 2025 08:41:21 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656dc45c3a8sm5880684eaf.1.2025.11.12.08.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 08:41:20 -0800 (PST)
Date: Wed, 12 Nov 2025 10:41:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1] sync socfpga common u-boot dts
Message-ID: <20251112164118.GB6688@bill-the-cat>
References: <20251110050040.183-1-briansune@gmail.com>
 <CAN7C2SDGh+PZaP2DNOhn3=D9Stw680-7k=Tus_+2r9UQYoAOyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k5DYmAKzElJINsoN"
Content-Disposition: inline
In-Reply-To: <CAN7C2SDGh+PZaP2DNOhn3=D9Stw680-7k=Tus_+2r9UQYoAOyQ@mail.gmail.com>
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


--k5DYmAKzElJINsoN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 12:35:01AM +0800, Sune Brian wrote:
> > The dtsi for socfpga common should
> > turn on L2 and memory and no reason not
> > to do so
>=20
> Hi Tom,
>=20
> Do TIENFONG still handles patches on SoCFPGA? Seems like there are
> no action or response on all SoCFPGA related patches?

Yes, he's Tien Fong is still active, it's just that most subsystems are
fairly slow moving.

--=20
Tom

--k5DYmAKzElJINsoN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRS4pwAKCRAr4qD1Cr/k
ClKnAPwMVwEqUC7HuOvDDd3YYRk05HOhvlExlx47Hk65nMCSnQEA+1XXVcru905V
Rbti/q7x/NXe9yM0McG/8xCPGZvmDA0=
=1vwb
-----END PGP SIGNATURE-----

--k5DYmAKzElJINsoN--
