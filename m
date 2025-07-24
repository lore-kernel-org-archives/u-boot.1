Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D33C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 18:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AACEC838DF;
	Thu, 24 Jul 2025 20:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dcMDuGzT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36D95838E7; Thu, 24 Jul 2025 20:54:14 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A82D83844
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 20:54:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-73e82d2ec21so686283a34.2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 11:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753383250; x=1753988050; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PVWsN/A2zfvV6A4YksVx+LsY5KUjgVKSCU4pCG7Botw=;
 b=dcMDuGzTLgnjiJm3q0vN1ajfO0kPLOIXrMUXR2ctMzmVRs5aEEOV198MKsfUzl3fzn
 F/M6AwPRmfBNLzUevUymQdXUvLUJbkMeD6L7oQsg/euncHYXn9Kvn74UmvsYSZ6HZ+Wl
 WmtUEyXAWdN7T6YSVxFu2FRSakrjTft+BzaSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753383250; x=1753988050;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVWsN/A2zfvV6A4YksVx+LsY5KUjgVKSCU4pCG7Botw=;
 b=DNAmUmC497ObmWxNRvn2DphEVdaj7f7itTuRSV6cGbjwsbPk4sVr7bvg3svzxQPMRt
 ngHGzm81NvyCWKrZ4csZl3XDn2ciQnH1lHTe4Kn4O+/REVuylP5YwrkyXU95O0p+dpLo
 UNDnD9z4M7qcY8I0my1t2T4qD2WUHSr4VpycT8leie/21MjhyKzzi6pSBXAtl4a/nAhP
 WXb0VMag5YqDV6HxfpUzqJU9+I07PrIBLVccLd8UYwT8t2sWO1alsoRPpUeZyP/jzAam
 wkUq9ciqy6BWJGej0b6pDOLIBQqZ1BYDaHyJHtaRHAjP2H5zidqpjMK1PN8Jn3SnqegO
 gnNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFhnMwg5FvZG1qNjtEXxF8STUPM6MEpwgFvIQ3m4yn5HQT5Dxs3a4BesCXzVq7Zv2Yvjv+QoU=@lists.denx.de
X-Gm-Message-State: AOJu0Yyl4q6ZisQI/gIql1cxbQgo2VZH+swIsLQVU5xzeXW96eK/sYZr
 l443G8+PXLoCA3Z/p/3Nq2c4VdgAWgfl/gW9cxOEveBFovTrow8pjB3j4/jb0rvTfWpdCN1n9Oe
 1irqxlpY=
X-Gm-Gg: ASbGncsyuQzxpHI3dkcSTOmgVVjJ9qdbuCHT6pg7yk5M5S1gpUMNGwkW0WmK/68Jtba
 MUpLtdINSP4rjUnabMbcNg2ArWC3eqOtZ/mFxjmUe3RnVAFSI8P+CgDDpiwFYNDUqmJyZdk0UmH
 3peC62434JLIZrPahHcdxaojg0wq+xsIDYUd5yBPk4tiyCwDnMt6L/5W00wi5gK43UJnZTjNN6L
 9CjsM09oa2BoJIsZA3tv3+HeqpP4IIk5pbF3MxmHnBgNiM0+8wMSczzfzr+Qp0RlCSJ1S3pQA9v
 PAzpXBnrTdQb/UvLGFKf/v0+TStA8hC6Sf0KrVRlYaaDNrzA5/YY+wgo8gQAQukFwrtZpDkDhxs
 +VcK6LZ2lx+n0J9EaRQTsHXJoMud59PcmnVK+qSJJqYJzHzsqNT8pjFNt
X-Google-Smtp-Source: AGHT+IGXj4csGCFOITWcbjb+fAqaM+sG9pARilHhiG2gZ+6Ibr3zSyGERy7N0rJhrQSj3BIsAmVo/w==
X-Received: by 2002:a05:6830:3741:b0:73e:5def:537 with SMTP id
 46e09a7af769-7408898cf54mr7676588a34.21.1753383250199; 
 Thu, 24 Jul 2025 11:54:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7412d2eb6c4sm363528a34.43.2025.07.24.11.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 11:54:09 -0700 (PDT)
Date: Thu, 24 Jul 2025 12:54:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: Eoin Dickson <Eoin.Dickson@microchip.com>, u-boot@lists.denx.de,
 rick@andestech.com, Conor.Dooley@microchip.com,
 Jamie.Gibbons@microchip.com, Praveen.Kumar@microchip.com,
 Cyril.Jean@microchip.com, jagan@amarulasolutions.com
Subject: Re: [PATCH v3 1/2] gpio: add PolarFire SoC GPIO and Core GPIO driver
Message-ID: <20250724185407.GA1808768@bill-the-cat>
References: <20250708130121.1769247-1-Eoin.Dickson@microchip.com>
 <20250708130121.1769247-2-Eoin.Dickson@microchip.com>
 <aHiMY22VV6ib7JzI@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hsNJLLOZPlyvyUdY"
Content-Disposition: inline
In-Reply-To: <aHiMY22VV6ib7JzI@swlinux02>
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


--hsNJLLOZPlyvyUdY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 01:38:43PM +0800, Leo Liang wrote:
> On Tue, Jul 08, 2025 at 06:31:20PM +0530, Eoin Dickson wrote:
> > From: Eoin Dickson <eoin.dickson@microchip.com>
> >=20
> > This driver adds GPIO support for PolarFire SoC family, this is required
> > to add sd card support on the Beagle-V-Fire as it uses GPIO chip selects
> >=20
> > Signed-off-by: Eoin Dickson <eoin.dickson@microchip.com>
> > ---
> >  drivers/gpio/Kconfig     |   5 +
> >  drivers/gpio/Makefile    |   1 +
> >  drivers/gpio/mpfs_gpio.c | 198 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 204 insertions(+)
> >  create mode 100644 drivers/gpio/mpfs_gpio.c
>=20
> Acked-by: Leo Yu-Chi Liang <ycliang@andestech.com>

Nothing enables this driver today. Enabling it on sandbox gives:
/home/trini/work/u-boot/u-boot/drivers/gpio/mpfs_gpio.c: In function =E2=80=
=98mchp_gpio_probe=E2=80=99:
/home/trini/work/u-boot/u-boot/drivers/gpio/mpfs_gpio.c:139:20: error: assi=
gnment to =E2=80=98const struct mpfs_gpio_reg_offsets *=E2=80=99 from =E2=
=80=98ulong=E2=80=99 {aka =E2=80=98long unsigned int=E2=80=99} makes pointe=
r from integer without a cast [-Werror=3Dint-conversion]
  139 |         plat->regs =3D dev_get_driver_data(dev);
      |                    ^
/home/trini/work/u-boot/u-boot/drivers/gpio/mpfs_gpio.c: At top level:
/home/trini/work/u-boot/u-boot/drivers/gpio/mpfs_gpio.c:163:25: error: init=
ialization of =E2=80=98long unsigned int=E2=80=99 from =E2=80=98const struc=
t mpfs_gpio_reg_offsets *=E2=80=99 makes integer from pointer without a cas=
t [-Werror=3Dint-conversion]
  163 |                 .data =3D &mpfs_reg_offsets,
      |                         ^
/home/trini/work/u-boot/u-boot/drivers/gpio/mpfs_gpio.c:163:25: note: (near=
 initialization for =E2=80=98mchp_gpio_match[0].data=E2=80=99)
/home/trini/work/u-boot/u-boot/drivers/gpio/mpfs_gpio.c:166:25: error: init=
ialization of =E2=80=98long unsigned int=E2=80=99 from =E2=80=98const struc=
t mpfs_gpio_reg_offsets *=E2=80=99 makes integer from pointer without a cas=
t [-Werror=3Dint-conversion]
  166 |                 .data =3D &coregpio_reg_offsets,
      |                         ^
/home/trini/work/u-boot/u-boot/drivers/gpio/mpfs_gpio.c:166:25: note: (near=
 initialization for =E2=80=98mchp_gpio_match[1].data=E2=80=99)
/home/trini/work/u-boot/u-boot/drivers/gpio/mpfs_gpio.c:174:35: error: init=
ialization of =E2=80=98int (*)(struct udevice *, unsigned int)=E2=80=99 fro=
m incompatible pointer type =E2=80=98_Bool (*)(struct udevice *, u32)=E2=80=
=99 {aka =E2=80=98_Bool (*)(struct udevice *, unsigned int)=E2=80=99} [-Wer=
ror=3Dincompatible-pointer-types]
  174 |         .get_value              =3D mchp_gpio_get_value,
      |                                   ^~~~~~~~~~~~~~~~~~~
/home/trini/work/u-boot/u-boot/drivers/gpio/mpfs_gpio.c:174:35: note: (near=
 initialization for =E2=80=98mchp_gpio_ops.get_value=E2=80=99)
cc1: all warnings being treated as errors

Please fix, thanks.

--=20
Tom

--hsNJLLOZPlyvyUdY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIKBSwAKCRAr4qD1Cr/k
Ci46AP9WmlgrX8yEDJ92qg+04s9BYgVjX14zW3tG53UidQjWFQD/RjO1kr98pC9z
h+g3PvKRkBf7w4L5qxWCed/qOHGvnw8=
=Ytks
-----END PGP SIGNATURE-----

--hsNJLLOZPlyvyUdY--
