Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C683C61D9B
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 13:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0FD086FE9;
	Wed, 22 Nov 2023 14:52:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B5QawX+V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 309BA86FB5; Wed, 22 Nov 2023 14:52:15 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 160F3875C0
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 14:52:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5cc55b82ee5so8136557b3.2
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 05:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700661132; x=1701265932; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TE8kiZMk/Y+HhX+csX9giJQz2Pea/plaS9jjwUEqVJU=;
 b=B5QawX+Vieg9PHPeJ83jVlZjZCLewiwkGDhrpsggZZDR8d/T5sU5z/9n2/3vURZQF8
 k0jQgyhf1sP/fois7uSoSyO/BFQPFBCv6BQ/xDKIduCZIl2L83+kTCBNloxmkYlUdmIy
 /DBpaMeacwZLMxu757mmiX6O/qOpqjpiXfmjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700661132; x=1701265932;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TE8kiZMk/Y+HhX+csX9giJQz2Pea/plaS9jjwUEqVJU=;
 b=l46U7Wq7qmriIRAaMoZsf6akSy73k9QYFoAXjoK6z3je9eqcUq+eiWe9OLBmDpqbCX
 dSYi/K+o+uiXl4ef3NcA+ZFcbFe0gu+LoM7wRNJWPuj/WH94JnS0FSFaoZK6TrFotCiU
 Q91kBsM6XuL+qqFA7obLkYrkGijqfQFRnsN/YRUpgMpU79dl4TLk1tXqjxdOIB07cgGY
 iv42qWtBGLngKTt9lJhwnGRMtn50UYWLDd/jVABzUMrP159XPYk4639QvItyyaDq0wT5
 8DHiEswAVPdRdzQrMIaUV7eODuoAhrCnCB/USZTuuA+yBHlNlUmBCdE2tns12pGKd830
 H91g==
X-Gm-Message-State: AOJu0YxkvwqqpRB1Vz7qhrnh2ZiyHQl3RBuYKU9pNkrcklPId2WFfcFu
 5Tkpa/19vY9XmgXVP22i6Gmp4Q==
X-Google-Smtp-Source: AGHT+IGYoqCdne6WvLEe+2FVreVhqkjg8IeTtKqwv+NdLUv45bWSNc3RW09qTu4TsBeKOF32CR0HEg==
X-Received: by 2002:a81:a18d:0:b0:5cb:332e:ab68 with SMTP id
 y135-20020a81a18d000000b005cb332eab68mr2162364ywg.5.1700661131798; 
 Wed, 22 Nov 2023 05:52:11 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 f128-20020a0ddc86000000b005c5a65a8e0dsm3702221ywe.74.2023.11.22.05.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 05:52:11 -0800 (PST)
Date: Wed, 22 Nov 2023 08:52:09 -0500
From: Tom Rini <trini@konsulko.com>
To: Dmitry Malkin <dmitry@bedrocksystems.com>
Cc: u-boot@lists.denx.de, mbrugger@suse.com, pbrobinson@gmail.com
Subject: Re: [PATCH v2 0/3] rpi5: initial support
Message-ID: <20231122135209.GR2513409@bill-the-cat>
References: <CAKRNjQ0dsWozGo4n8g58m4cCEk3n=qx1R+L24WBgpo-iP1yo7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RgKxprMgkQFqmDeu"
Content-Disposition: inline
In-Reply-To: <CAKRNjQ0dsWozGo4n8g58m4cCEk3n=qx1R+L24WBgpo-iP1yo7A@mail.gmail.com>
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


--RgKxprMgkQFqmDeu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 11:54:07PM +0100, Dmitry Malkin wrote:

> These patches bring initial boot support for RPI5. Without it the
> latest master fails with the message:
> > DRAM:  mbox: Timeout waiting for response
> > bcm2835: Could not query ARM memory size
>=20
> With those patches and rpi_arm64_defconfig (with disabled
> CONFIG_VIDEO_BCM2835) I'm able to get a working u-boot prompt (over
> serial). FDT comes from firmware (EEPROM).
>=20
> > U-Boot 2024.01-rc3-00003
> >
> > DRAM:  1016 MiB (effective 8 GiB)
> > mbox: Header response code invalid
> > bcm2835: Could not query board revision
> > FDT model : Raspberry Pi 5 Model B Rev 1.0
> > Core:  14 devices, 7 uclasses, devicetree: board
> > MMC:
> > Loading Environment from FAT... ** Bad device specification mmc 0 **
> > In:    serial,usbkbd
> > Out:   serial,vidconsole
> > Err:   serial,vidconsole
> > Net:   No ethernet found.
> > starting USB...
> > No working controllers found
> > Hit any key to stop autoboot:  0
> > No working controllers found
> > No ethernet found.
> > No ethernet found.
> > U-Boot>
>=20
> These patches are based on v2024.01-rc3 and tested with RPI5 8GB.
>=20
> Known issues:
> * CONFIG_VIDEO_BCM2835 doesn't work.
> * MBOX get board revision (0x10002) doesn't work (the response status
> is 0x8000_0001). Looks like a number of tags doesn't work anymore
> (board/serial/MAC) but could be fetched from FW FDT.

Nice. I think it's the MMC controller that we should be able to support
with just a little more work as it's shared with rockchip, and we just
need to match the compatible, and mirror whatever tweak is also in the
rpi kernel tree for it.

--=20
Tom

--RgKxprMgkQFqmDeu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeB38ACgkQFHw5/5Y0
tyww7Av+Izfq62GbKiOo/2UtS3FyBM4SOhYB5Nsw8RH0DKrz/PSEx6Jjc5VG8J8b
ypen0eRdcWXfxSTR2ZiP5tqe2cD5Ry1bjEpTGodQR0CJtbFu8Bb1yy87G0vBL2Hm
5XXYTPZt6wcyJ3DLdS+auoFDbpTFwSiUpqFtLFZHl070K4UEB9exB+SrqY+s8y1e
rXFq6vqlceuwjuUa0MIoviTbO69x8Lx6zf51iCm+UE/Jr7eyLG6ngJPVgO8hh0Mq
l5FtE8UfqHbJ8aAN2c5YGZn/21MeXS9fgDtuB9EqIKv7XovrJDKjSvLqaX5ONZh4
Y0UI7TTe1lxkU/O9YBBqIL4TxDnQaeL5tD5Ozr31gAW8Ri+VB8vivLwBgKeFjsDO
gkawqaTkh7H6xzXIS4BaM6lKyZjX0opGUr+o6+6hEvBtJlXZ8yYmp9pQX0jvOV0W
L1VTKkmliLTR9++aCC+lw5QO9Ptzf7fnvW21p/eq1FAiGvw0Hzm5THTXcFzXaiE7
AHPvg+Ha
=6TOm
-----END PGP SIGNATURE-----

--RgKxprMgkQFqmDeu--
