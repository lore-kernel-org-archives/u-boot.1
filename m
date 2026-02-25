Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F89FFD377B
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 17:30:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B883283DEA;
	Wed, 25 Feb 2026 18:30:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NL1/zKug";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 621EB83E61; Wed, 25 Feb 2026 18:30:48 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4533C83D8A
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 18:30:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d4c3896e32so3054108a34.0
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 09:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772040645; x=1772645445; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0SXeypbAaIX9OEDE3RMtxfXJlTl9KOBBRGt0SOzeGp8=;
 b=NL1/zKugtAT2+Fh+MJmrgUX0AYRPPbKUBIATNlQCpUyviPUh05642IzIG6o2pdIuqE
 ZFE9wGNV44feJsGbJy5ADMSW/lvTZnNUMBmwg2QwdNRd0Gm7P46tpV+V/6CdZnOKdY4I
 G69CHqv6ALxoOpzO27IOO0Y/HdZqa/61X3LY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772040645; x=1772645445;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0SXeypbAaIX9OEDE3RMtxfXJlTl9KOBBRGt0SOzeGp8=;
 b=tytwekafHHAzS3hxL/E/89imn/hZCK2ndmKpX7Bs1pG37vw2ZTdRZF2nRLvT6Bz5ky
 bzHMX//9+FXodoKk+Qdd7gdLkaNRFoQBXvr6WOVo6XDrIIw/McW2dJq7LQuHPIJZ5uyS
 zeEq5lGocbr0w+tv8ZEGq92MFKoJ1AWXH93yeJd/8qypkVZ1vaxJgnwTPOW2Ff2Bf+Lj
 vzGXLTsKuLkWnNARQyrXbOGKXEl43qUarxaGs0jJv9NFjfuKguNzPuwOFhsxXOi2rx0l
 EQobFnWPOe5K+4NfrJ7N2ymLcKgSDtgXvQYfBIpKW+G986tS1K9I5UI82nOGQG9R9wv5
 8giQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEqPcXg3Grum2jLvBHZ4zliF/VxSjXZDJWKX3JLHDbcUadoGU8H4r1OCDP6tfOp5pNWwMaXXA=@lists.denx.de
X-Gm-Message-State: AOJu0YwvgLrJ8fDQgugnxhkUUnvQe8rvZqScpIuOkIQXZErIn7fhJniX
 xf7ccwuwqoICe2I40ohtR++7t+Pu7r6McfxaYpYF85EJpPja8AVef03vM0TRrMjiVMk=
X-Gm-Gg: ATEYQzzp5VGGUUOgdBkSq6dWfSg0BArzHNf1M88VIgmxQ+C+qIVXD6TOfFNZqZe3a7H
 Cn06lWgPcPzY96xTc6szRZkDKH5JDRFzeqwa2SpJ4FxO6OMXXK4ZeKEpTH4YU9uB/BKWp4/7Jwc
 1LdosJSXSCMy+UWvpSYEuxdmFgkhbcrQ0HH7K9MWpig25TbEgxRRdPdkLTOuv+bTpFJRTxHKg+y
 ei8xAgPKgcpad6Y7pGHxM1N/hoK1fsHUDwIQSyZW7NjQHexnn/u3rcFmDsFm+Gyu4UeblvFA1YR
 bt5dR+p5FhuNSnKhX0PXlYgcNXIBgaPeZni6Gxmkmbks3KVv1O+G9mTrJyxa3EZa906EiCqhzj3
 ILpRTdF0RZBN7AeFJc2k+ReEzc6wi5VSAIFJM1039MdaTjCE3ihxsCKYWelDCqZxZE0lYT6LgOf
 9OXdlQHV+joTU+9mEMy3AUPJSo89UgRIRckkQtO+a2emGiVZhUTLlHlWs/798qwGB+52IFtLVJ6
 FSWvC0P7yxAR1O4eE7Il57l701ewTw0cbXuT+UGEVjIEkz3CF96cuccdQ3d6g==
X-Received: by 2002:a05:6830:3592:b0:7c7:58e9:8e16 with SMTP id
 46e09a7af769-7d52c219986mr10587378a34.14.1772040644909; 
 Wed, 25 Feb 2026 09:30:44 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d0725dbsm12544571a34.29.2026.02.25.09.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 09:30:44 -0800 (PST)
Date: Wed, 25 Feb 2026 11:30:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] arm: exynos: don't imply non-existent CONFIG_KEYBOARD
Message-ID: <20260225173042.GT1593142@bill-the-cat>
References: <20260225100023.46116-1-heinrich.schuchardt@canonical.com>
 <20260225143736.GD1593142@bill-the-cat>
 <2e092562-6c0a-46e0-8cd7-5d5226d304a2@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="odt3qYnUmAICwIbj"
Content-Disposition: inline
In-Reply-To: <2e092562-6c0a-46e0-8cd7-5d5226d304a2@canonical.com>
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


--odt3qYnUmAICwIbj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 06:26:24PM +0100, Heinrich Schuchardt wrote:
> On 2/25/26 15:37, Tom Rini wrote:
> > On Wed, Feb 25, 2026 at 11:00:23AM +0100, Heinrich Schuchardt wrote:
> >=20
> > > Symbol CONFIG_KEYBOARD does not exist.
> > > Don't imply it.
> > >=20
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >   arch/arm/mach-exynos/Kconfig | 1 -
> > >   1 file changed, 1 deletion(-)
> > >=20
> > > diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kcon=
fig
> > > index b084b7284aa..06448e875ef 100644
> > > --- a/arch/arm/mach-exynos/Kconfig
> > > +++ b/arch/arm/mach-exynos/Kconfig
> > > @@ -34,7 +34,6 @@ config ARCH_EXYNOS5
> > >   	imply CMD_HASH
> > >   	imply CRC32_VERIFY
> > >   	imply HASH_VERIFY
> > > -	imply KEYBOARD
> > >   	imply USB_ETHER_ASIX
> > >   	imply USB_ETHER_RTL8152
> > >   	imply USB_ETHER_SMSC95XX
> >=20
> > Should this be DM_KEYBOARD ? I'm not sure about USB_KEYBOARD instead,
> > but it looks like USB_KEYBOARD should be a depends on, not selects
> > DM_KEYBOARD, too.
> >=20
>=20
> ARCH_EXYNOS5 depends on ARCH_EXYNOS.
> ARCH_EXYNOS selects DM_KEYBOARD.

Ah, I missed the 5 at the end in the patch context, sorry. Yes, we can
just drop the "imply KEYBOARD" line.

--=20
Tom

--odt3qYnUmAICwIbj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ8xwQAKCRAr4qD1Cr/k
CutEAQDLysq9fbBQGnI46j/LQLgeGG7pr2TVUDmSUazGqO1xuAD/YVt5Wozr8OfC
Kwn5YUMyK1ngEwcB4JYrra97ttQuJQQ=
=KMF2
-----END PGP SIGNATURE-----

--odt3qYnUmAICwIbj--
