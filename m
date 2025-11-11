Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9FDCCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 14:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CBB283BD2;
	Tue, 11 Nov 2025 15:04:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Okx2PBRv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B60583BFE; Tue, 11 Nov 2025 15:04:44 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A175D83B8A
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 15:04:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3e37ad3d95aso2791136fac.3
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 06:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762869880; x=1763474680; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IjIGEHs6ZWEmNBAgWdqnMQrkMByNBYIklcH8kJw7OPo=;
 b=Okx2PBRvs7qpw+3dGjFpdVLCW8/gezwMGaNb0xFm16bKOVZ3XsUR4nJsVEbxt3l+qR
 3uMgajGOQnSUKhsw2FYGOhR4LLF+WAM10PvHwemXyrAxy/tlqtyzH/7ol7gSQy8q8DQx
 TR1GdHDhELvmOi50E9s7i57So0mJsOyq7KWBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762869880; x=1763474680;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IjIGEHs6ZWEmNBAgWdqnMQrkMByNBYIklcH8kJw7OPo=;
 b=qnBvGB42zRLHH8aNFyQipgfxWdZYVXNN0Io+hlVrzamp9yMetPjLe9Ba6XElOABfI9
 bWDIA8NF8RbNWClL3W19hEY/b6bRFvfLed9YGeyGLcAhkSSZs1/rKhvPOIftiQKtldOG
 GSAxbNBxopjQ84IPfw0FXjQ+YBrgdHxTFvFkjdbtsFYqtumcz1eDCKtHMBDeteUWe8Zh
 URc+RjJ+URwoSZZ6fhSeE6ygVRnvp4nBGBQjUXSodDB8HIa3MW3TnRp4Z1z1w5x9MWmb
 MCphrZ9WWJAyIW0egZ2RGeYWnijTyHfSXxWR3H5YQ94D74ZEnm9SbckzUkzOUrnpbxLC
 O9Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWImns4pynHUVSv5Llrq4ScKwFMJTFUFVviQS2OT41FJbjZU8Rx3Dr6x8fwiZy6SRQ7k+msftE=@lists.denx.de
X-Gm-Message-State: AOJu0YzkuY29al/00oUzSz9bXvUUEB2i2KUcsNBXJecxsfroqATScxGN
 gL5Ty1jfDCcwWTunEcz9+CF4fyMEpMYf+UpIFe1DoG7Wsg0Osa1KmgfhQS0Q6am5lt4=
X-Gm-Gg: ASbGncuycIZxI3lwG+OORjgzlC1hucZZO7fW4l5ASLKe8qkadWmutWOVJO6QwWGr0gr
 zBZQPty3r5OKCv+Ganu8UeqovcQ/UZFDcTmHAneG5NRJ2EC1yJKIjbp5Va8W7CAXNM2I1oBoo1K
 AilbsWVAEnfxBAzhOSvrFWb6aauCqNqH7IYsdD73oVqB4dGAD0/Mh+KuffLULHRVjuFuV/B5PST
 S3xsJGtJgzcQFcRKGVA5tc7RztmgLFr50iRL27n6GSt/Z18xvlbHU4OVU0zX9iyOvkHetnXJPS/
 ao4PXPIvH154s8IQjs9LVRWGEGWhkDlIZrla89HqRWU7k2vB0Pm1U763EhFC/EP32kvdBkfQh7W
 ps6rvzY0tGpy/RdqXv+OTxfK2W88Bym/Ra8R9U+wZ4L9r0k0ofR1e4WZVXrytqEuCOzaHA4hq7q
 mlD6HWCxtvAiWsnJGiv5SK/KCJCBZ6LyA31IQzsh4=
X-Google-Smtp-Source: AGHT+IHheNCIxibAoopM6V5ktNBS2LPqquJInMmd2Uk/zLrw6BZWmLCXWO+nNK3oVCq3NXGXJPPYHA==
X-Received: by 2002:a05:6870:6486:b0:31d:63f9:b247 with SMTP id
 586e51a60fabf-3e7c279d413mr5901459fac.25.1762869880235; 
 Tue, 11 Nov 2025 06:04:40 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e41f2583casm8031215fac.23.2025.11.11.06.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 06:04:39 -0800 (PST)
Date: Tue, 11 Nov 2025 08:04:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Frieder Schrempf <frieder@fris.de>, Stefano Babic <sbabic@nabladev.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 2/4] arm64: dts: imx8mp-kontron: Fix USB OTG role switching
Message-ID: <20251111140437.GU6688@bill-the-cat>
References: <20251111102904.157931-1-frieder@fris.de>
 <20251111102904.157931-3-frieder@fris.de>
 <CAOMZO5Do9AdqZ+j4Kpp8qU21mQ6yBNuvi614n_Q4-Uzebf16eg@mail.gmail.com>
 <ae7084f3-9df8-4e69-ad6f-5e80df9e4237@kontron.de>
 <CAOMZO5Dz0UjTrQv+kWeputL6haSMHQ+eNzYp-5F6mKS4DeJiEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UlNR+Pdc9mNQCHoE"
Content-Disposition: inline
In-Reply-To: <CAOMZO5Dz0UjTrQv+kWeputL6haSMHQ+eNzYp-5F6mKS4DeJiEA@mail.gmail.com>
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


--UlNR+Pdc9mNQCHoE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 10:14:33AM -0300, Fabio Estevam wrote:
> On Tue, Nov 11, 2025 at 9:38=E2=80=AFAM Frieder Schrempf
> <frieder.schrempf@kontron.de> wrote:
>=20
> > Both would be fine for me. If applying to dts/upstream/src is not
> > desired, even dropping this for now and waiting for the next sync would
> > be okay, I think.
>=20
> Please send a v2 that puts this change into -u-boot.dtsi and mention
> the linux-nex commit ID.

Yes, if we can't cherry-pick it from devicetree-rebasing it goes to
-u-bot.dtsi.
https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing=
-with-devicetree-rebasing

--=20
Tom

--UlNR+Pdc9mNQCHoE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRNCdQAKCRAr4qD1Cr/k
CoLTAQDym6JIhxkC0Ekaw4skbdMGBiITjTlJU5dxMXpESXUFYgD6ArxVvD5Bze9G
e5YJuN7LyTLLHEGk37XmbWZQhgpbGQs=
=OubC
-----END PGP SIGNATURE-----

--UlNR+Pdc9mNQCHoE--
