Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3334C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 15:44:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4324780F4C;
	Thu,  6 Mar 2025 16:44:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UL24n6ww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A55180F4C; Thu,  6 Mar 2025 16:44:31 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F237808A2
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 16:44:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6fda22908d9so6074047b3.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 07:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741275867; x=1741880667; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RP4l1naywvaHW66Nv1PrWMVvTCNzzFfHOJAQjUkDb2A=;
 b=UL24n6wwlYqTYmONvkVXkMMK5Kk/MCU7zO90YNzxHzm9+JWdG46UKC4oLhtq3H5M2g
 Ck03wKrBM5uPz1X/Yd7T44R2/2TNMCZd9VIe1GArA+1stDnGsyiIqkFJCpdt9bx8ZRCq
 XIpIkGN6XWAn5Itp7VFCpJ9UxOvdDlIoQI+a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741275867; x=1741880667;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RP4l1naywvaHW66Nv1PrWMVvTCNzzFfHOJAQjUkDb2A=;
 b=DV6jnmpog4Svu4nzv4kqW1zB4m0tvKBLgRnVwueI6YZLGjDs0VjxzVmZph+PX3Z9eB
 9oR6Gc27Yggs70bYepZ02p0pMDaEFcA+Usg8Ia4Nvguf+GKXZ5Xi8qEaJywNtqBtBFEq
 7PIGNCy+nFuS1oJaycSo3DKs0Tc6zhQhp1IgUfvvnDfOorNnGwumFcqIbSB6+QsflIjL
 GihxBSqGMMgSNUS+4ODfjh//ICQe2S7sStDuZPuDfXnCgYUtKbIZf0Wzf4szWwF/78fP
 yQJ6rDKKMcBfYn1NKXzU9EHkMXUFhtAOO8dr1IjuObmEQ1K4GP5zusuOKQcrSHMh3f9E
 gT3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG6/KKEtyddkqYFaTm7VbGYWA5SaWOld9QyVtwJ07FwJo7Y9J6m/KnUjBlMkXdf6uXi8mMYAM=@lists.denx.de
X-Gm-Message-State: AOJu0YwGeSRqwbon7OzSLt5ERdne7EX1AFV9zW0onIjFx6qtHri2Ih+0
 U/wAUOFXYuHKv+rGWYZmKtwZI4bjqdYgcbzTyu+ubWs33XSznAzwbiMsZVk7Rf8=
X-Gm-Gg: ASbGncua6s7nmG/uySRRiLX2SOTGKyMHwnwVYfRtBCuCyemk5Dy328HLlAxfTFiEog2
 5iF6MN2vP6zasKZEyO3IGzpNoRBr2+gYVgu5CTyx62olAx2K5jGCI+H89THablYQ+r8VqeybGCT
 ErZpsda0GLs/hUlYoHZz8EExkC+an99xNsViRQfk8VDjv14gWmtw9casEkPAARIEgrLqizCETKa
 7/IFQGQcmdxMhp8UeX33dCeoSKa59jerIJHtTZ+2/H6jef57kveU2Rp9M1T+GB6YpwPNLKML0wz
 cv0oh3ne50URNl3Pirm4i02hEzoJBOFv6JUelw3otG+tzA==
X-Google-Smtp-Source: AGHT+IEz1uIAqoBb90WAKHi5k3g4czOJVY3eaBf/UkpxrkiFH5IO+ma3ZmqowSsb8ihQsY0roLBuFg==
X-Received: by 2002:a05:690c:3384:b0:6fd:a226:fb6c with SMTP id
 00721157ae682-6fda2f7af5cmr110837157b3.17.1741275867148; 
 Thu, 06 Mar 2025 07:44:27 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6feb2a1c3d2sm3026357b3.10.2025.03.06.07.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 07:44:26 -0800 (PST)
Date: Thu, 6 Mar 2025 09:44:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Aniket Limaye <a-limaye@ti.com>
Cc: hs@denx.de, u-boot@lists.denx.de, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 virag.david003@gmail.com, marcel.ziswiler@toradex.com,
 w.egorov@phytec.de, j-keerthy@ti.com, u-kumar1@ti.com
Subject: Re: [PATCH RFC/RFT 0/3] omap24xx_i2c: Enable Repeated Start
 functionality
Message-ID: <20250306154423.GD2640854@bill-the-cat>
References: <20250304220546.866602-1-a-limaye@ti.com>
 <20250305155000.GR2640854@bill-the-cat>
 <5100f007-28c2-ed02-620f-a013e9c6ed60@denx.de>
 <24951463-008b-4864-b8e4-c426b0e36122@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q4prdqoraPcHoptk"
Content-Disposition: inline
In-Reply-To: <24951463-008b-4864-b8e4-c426b0e36122@ti.com>
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


--Q4prdqoraPcHoptk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 06:28:54PM +0530, Aniket Limaye wrote:
> Hello Tom, Heiko,
>=20
> On 06/03/25 11:15, Heiko Schocher wrote:
> > Hello Tom, Aniket,
> >=20
> > On 05.03.25 16:50, Tom Rini wrote:
> > > On Wed, Mar 05, 2025 at 03:34:08AM +0530, Aniket Limaye wrote:
> > > > This series implements Repeated Start functionality for the DM_I2C =
xfer
> > > > API (omap_i2c_xfer())
> > > >=20
> > > > First, split out the actual implementation for each individual i2c =
msg
> > > > transfer into a new function __omap24_i2c_xfer_msg() and use this to
> > > > implement omap_i2c_xfer().
> > > >=20
> > > > Then, add support for the Repeated Start condition in omap_i2c_xfer=
()
> > > > through the CONFIG_I2C_REPEATED_START option.
> > > >=20
> > > > Also add this config to Kconfig and enable it for ARCH_K3 platforms=
 by
> > > > default.
> > > >=20
> > > > Test logs (On AM68-SK with additional debug prints):
> > > > https://gist.github.com/aniket-l/8c64c5bc81246751a02836a96510df14
> > > >=20
> > > > Requesting reviews/testing on specifically the CONFIG_I2C_REPEATED_=
START
> > > > addition:
> > > > - Is the Kconfig needed or should we simply always default to not
> > > > =A0=A0 sending Stop bit? Drivers can use i2c_msg.flags to request S=
top bit
> > > > =A0=A0 for each msg, same as in the Linux Kernel i2c-omap driver[0].
> > >=20
> > > Yes, a Kconfig is needed as this driver works (as implied by the name)
> > > on so much old and differently buggy IP.
> > >=20
> > > > - If yes, Should we re-use CONFIG_I2C_REPEATED_START from the legacy
> > > > =A0=A0 implementation of the driver or define a new config
> > >=20
> > > Lets pick a new option, under the SYS_I2C_OMAP24XX namespace (and rem=
ove
> > > the legacy and unused variant).
> > >=20
>=20
> I will update the patch with the proper namespace for this config.
>=20
> The legacy one (CONFIG_I2C_REPEATED_START) was never added to Kconfig at
> all... So will just leave it be ( unless you meant remove support for it
> from the legacy driver code as well and use this new one instead? )

Yes, please remove the useless legacy code in an earlier patch to the
series, thanks.

--=20
Tom

--Q4prdqoraPcHoptk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfJwtAACgkQFHw5/5Y0
tyzr4Qv/RMcfVFD4u17VipodqdoEDoEvEaWA0HLwyH+Iqr06YQFZaV/k/8EjMX3c
v5fIMBLGBnGhbuXfXg+JJnE7qvvfwHjGtnSLJK3nB/i/P/9iXfS4sztlpwORkkbl
CSz1eYdGWSleXowcfLLXmbJCGcQIDIYOPLY1THpRed91RkCmJFYXL6QqE1+AS+3N
YmySsnILem0Kp9HhFgTaYtHcpv7Mx2GAmPGFVYH9jC7lnGzwubrBgo7k5hCyXB3V
FzXb+XeaWL/QtQnOMHH6aUAZwz0sozABc0JLW6xUefg2Oux+2yJdFlCba25w1TyI
MF2JEq9luufY7W4XcNz2YABuK2+PKw+05xPd9fky6rgM7urbEMQykfrrm/7PVLLy
Pu4S1oFCSx777t2Je0aHmhVGvs2URtihVqfbM6MEkmgnVoxrla7AlQI260pCwm9/
rGCNAvzKtdt+m/KAVnPLs7d9Yy7qUFSS1b4aXU8nU+fqwjJQvQzt8o+6az5ekn1G
QhNz7MuS
=v4F1
-----END PGP SIGNATURE-----

--Q4prdqoraPcHoptk--
