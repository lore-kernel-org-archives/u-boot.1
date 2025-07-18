Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C66DC83F1A
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 15:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C21DC8367B;
	Fri, 18 Jul 2025 17:01:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h3XNWUEh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C09BE83693; Fri, 18 Jul 2025 17:01:23 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D093834D4
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 17:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2ff94cc4068so605682fac.3
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 08:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752850879; x=1753455679; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1QbvmY4CkuKz/nfZ0UzDM362/teR5IN0XZioe/VtdeM=;
 b=h3XNWUEhDSahdhTYSuLul+3kv8WtJ0hCB2B6Qcl6dxiUD7xLkpNcpBbvYdnTF/nF7d
 YbqkPA4xITtTUr6FkfbnF7UlJBZ0FWA9/ZE8G42trUD2MJ1wV+hbrV0CENemJG4PJbIO
 /5AY5xYJLI/7Q2bL2vAqfki2NFHhMGxEUyRao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752850879; x=1753455679;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1QbvmY4CkuKz/nfZ0UzDM362/teR5IN0XZioe/VtdeM=;
 b=mbR2A1qFIcRX4oyWgNAg7gpzTWyzI0Kxm+NOIWbQHxSvjfuGeNoYb77xMYpoeEd/dk
 DJEIvP1SHr+0fwHqYbaun0z3PTOLtTNJiYOui4qcngGvFvJmEDrgaabE6+ar0us9oxF6
 EO+5ig8O4WL028/PjkobmuMfhuddeE2mUoVQByX1vXvrkERbt+nHMzNifhS8mXUfz51x
 HRen0UxHofeWOS7YrLkFHpqlfw8qCX0SO/dEKnKH0ZGhNpzg1pJlS70/iyax3oX13wrD
 4DdbOmGkjxLQOaOlCUq7wT32oggdeRt5B+1J98G1h4rb2Vq/lsGSACxCPICNL6TXhO33
 LdIQ==
X-Gm-Message-State: AOJu0YyjQwAeFBxEUcupRmojCufP43oNIC2nraPOKaAc4hLBoQZvgrS/
 QV1wsujIO0lLKJLuextlvqHObte/MIAuEYhvqgjTVdK641N2npuqOvs3oA9pC+EUmN8=
X-Gm-Gg: ASbGncvCS8Z/L42IAHQ9j3a560P2UDH1IJW6QRWuJFFSAu9twXMpYcmafaUxtZeb41b
 avsPBwjYz+PNxtgRqvXt/EeKGWXrjbCDZk5u6qRJcbxqWdse4UkqVYAS5FbJLxMDMkuhOsGf/b7
 9v7U598NXjZd+7LvC0yoWl9ng1iKa+eiBdPBS7D1hKCF1VN9ozdnRwAZh0KAZSXuKF+hhRjWBh3
 EwfSgOT+CM7R9OdqEGxCmiHykq+W6sVmLDq45lj1fnHXq/IBtc0Epuh0NdvnlI5QBAxlzQbUWLQ
 DRNGv5XYdGOm95qiPKh192pBqwJDfhd5IQgXMl74Iz8yCbwL5mOujEsfzz1nrvG4QBJ+IiqwSVz
 UxMT3jPXiKjV2YE64w0rvcIf4H8u9wro5fXNDZ2kJdQ==
X-Google-Smtp-Source: AGHT+IFbtIZTwBbWyVKWiC0oUXVEqpQ0cRXg5XdnIBoVETlYnzkG34NyUFvhEpNrOznAqz+wJya2wQ==
X-Received: by 2002:a05:6870:6b09:b0:2e9:4038:83d7 with SMTP id
 586e51a60fabf-300e8d11fe3mr2346042fac.11.1752850876768; 
 Fri, 18 Jul 2025 08:01:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e8354df84sm644240a34.2.2025.07.18.08.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 08:01:15 -0700 (PDT)
Date: Fri, 18 Jul 2025 09:01:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Frank Wunderlich <linux@fw-web.de>,
 Padmarao Begari <padmarao.begari@amd.com>, dinesh.maniyam@altera.com,
 Holger Brunck <holger.brunck@hitachi-powergrids.com>
Subject: Re: Please pull u-boot-i2c master
Message-ID: <20250718150113.GU193579@bill-the-cat>
References: <06c2b16e-1e3d-7632-70be-d6df4232ff71@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2dnjUUj23ANX2bhd"
Content-Disposition: inline
In-Reply-To: <06c2b16e-1e3d-7632-70be-d6df4232ff71@denx.de>
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


--2dnjUUj23ANX2bhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 08:10:17AM +0200, Heiko Schocher wrote:

> Hello Tom,
>=20
> The following changes since commit 53bd87651e45b32efa398dd5e433d8b93d7814=
45:
>=20
>   block: sandbox: Add support for SYS_64BIT_LBA (2025-07-11 11:33:25 -060=
0)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-i2c.git i2c-for-2025.10
>=20
> for you to fetch changes up to 5e80c6757378d09950235083533e7a7c3aeae3be:
>=20
>   configs: agilex5_defconfig: Enable i3c configs for agilex5 (2025-07-16 =
09:33:54 +0200)
>=20
> ----------------------------------------------------------------
> i2c updates for v2025.10
>=20
> - i2c Kconfig updates from Tom
>   - add some driver dependencies
>   - added missing include delay.h in iproc_i2c.c
>=20
> - i2c: muxes: Add PCA9541 i2c arbitrator driver
>   from Padmarao Begari
>=20
> - pca954x: add pca9545 support
>   from Frank Wunderlich
>=20
> - cmd: i2c: fix build when CFG_SYS_I2C_NOPROBES defined with DM_I2C
>   From Holger Brunck
>=20
> - added i3c support to U-Boot and enable it for agilex5
>   board from Dinesh Maniyam

Unfortunately the i3c support leads to this in coreboot:
https://source.denx.de/u-boot/u-boot/-/jobs/1202949/raw

Which looks like coreboot just gets stuck in a loop? And in turn, that
lead me to do this locally:
commit 03e9d5f4c61cba5d8e1db81d759fefd622b3ad49
Author: Tom Rini <trini@konsulko.com>
Date:   Thu Jul 17 15:22:08 2025 -0600

    hack drop generic changes
   =20
    Signed-off-by: Tom Rini <trini@konsulko.com>

diff --git a/include/dm/device.h b/include/dm/device.h
index c5cfa18d09d6..678cd83c2716 100644
--- a/include/dm/device.h
+++ b/include/dm/device.h
@@ -169,7 +169,6 @@ enum {
  * @dma_offset: Offset between the physical address space (CPU's) and the
  *		device's bus address space
  * @iommu: IOMMU device associated with this device
- * @of_node: Associated device tree node
  */
 struct udevice {
 	const struct driver *driver;
@@ -202,7 +201,6 @@ struct udevice {
 #if CONFIG_IS_ENABLED(IOMMU)
 	struct udevice *iommu;
 #endif
-	struct device_node	*of_node;
 };
=20
 static inline int dm_udevice_size(void)

Which leads me (a) being concerned about what our coreboot support is up
to and (b) why i3c needs this generic change? And I don't just want to
see CONFIG_IS_ENABLED()'ing it, why do we have to handle the device tree
that way and is there no standard mechanism we can use?

--=20
Tom

--2dnjUUj23ANX2bhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh6YbYACgkQFHw5/5Y0
tyzLVgv45XgYagn0iBgjprKXxFghLpcVnp22wlEjvOuJ9g973gFQNWOeb48FUKAZ
YWAfLUrPX7rJsVjOEs3d0oUVaRkEiTDhLs6Q34Y9JDslasauYdFd/hawgXOte18m
paWg5IUSdX/feKvhAx45eqI4kVYI8HFBv9/REkNtte1t9Reo8H+D50Acnu4rsMlU
P208BUcUQ7/+MJODOjCM0wkxEzEl44vUax89p1iy86oHmsWiYGKijeiXlhDstBkz
y5DPpFTwx1ZpBII+1tlZKvT8Ez3SDOPCzYZPm4hgipkK31CVtPezlaRIVVGm0QnV
d83kBjvTE3SaMZUje/SAlC/gX3S1DiPvnfWyAw65JaO0dG28Zw+QqfOXR2GpgLdX
4Jldsx7e2pilrqyqietAgqFI7gOqyy+zu9TdsgG2gjmqC4LD68bwHmzsFVHLAeWB
xaGzqrjLDi46Um5P0RcMZDZT4Aw1g/q/uQ/Fou3tikffpFfGyVk8UYrN3qwESOul
ETdfCnA=
=V0Tc
-----END PGP SIGNATURE-----

--2dnjUUj23ANX2bhd--
