Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E26EC71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 14:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AE1582B70;
	Thu, 12 Jun 2025 16:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cpLWCWrW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3008F82BD9; Thu, 12 Jun 2025 16:36:48 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09B3D828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 16:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2ea080f900cso192821fac.2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 07:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749739005; x=1750343805; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iJxfwX86ce3mvv2DI+VS0TQ2iPy79uTjG1A45sNjTMs=;
 b=cpLWCWrWbaApGbfBM91HTN9mgJtJXiQKtDcml5LqdQ3ey/MBb7JAlaD3TdZH6pRgkl
 uTQ2uOvC2DAf3IBzAgE3djSHuhwwbzdr6Im8af13o5wMCUR8wZRecOz6eatOTl2Db96q
 QcWdAkCV/8bPCT2Wv4Jg3iGDQw80JNIf+l8Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749739005; x=1750343805;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iJxfwX86ce3mvv2DI+VS0TQ2iPy79uTjG1A45sNjTMs=;
 b=JdK8hqp7GwmUE62R+AgRJdGPmLX9x0L9/GcAx2MRpEWAUrpykcGuXOyoShzQXSRQrF
 p9V+vFYhslCyJfSewLMQJIpSCTAVBAKs8R8cEacq2V+pmpNQE0LhHyiscBcn/fMWpXYb
 TP7rb6ldRG+Oz8RruJLoL1opNC5pAS7viUUqn+q8w56fGZI8VzAybYSlOwoM/V0a8lDB
 6vH5Wm1vrPlHCuCu4TNyyjg0PA8nRaSvkVCjOmnbXBccl/WLY4W4kqa3ns0XnQLXhmFf
 IoCAqL8SYATcU5FyLiINO+T91sikytLRmEVKp6EMQjHfCa/bjXWhYBc4gFYrFbfUORf9
 tUBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR6gLJX5Jo8ztWyDvCaB1BD7VwbDWMnTPysGSsj076zVCPxwrbiKqA8eFHSVqoaSLQiFD5LLY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1Pblufx/5wylOw8DbmsSvkFjYom+ipdlHpK58AipbcDg7fJlq
 hyqEjGXI3jUSJwWFyA99cuq7DiOaBrPdrpLolLXRCwoUT5E1rCveUwie4tKQ/LyBWm0=
X-Gm-Gg: ASbGnctlOfR19r5bCxrH3pZmgrI6VPHWtNr9R/URlKyfa4+8FCwX3Ya9Ry7HESkwDA1
 eF0nf5FSPBSpV3qlSeA9le2GW3qDydcHMpecD5wU3HiA0oxJxTBLXkKBPWE2g+JZZsdwIRDrDui
 N/rBzj+9p5uCne5R3Aeh9rAMyGSGDHv4TNnoSkCmyJcy6q1NjVmK25eFXBwpfD01pqWFArua4pG
 fcChrwFoD0WzYWXIDW0VHvP6wT4c/cvSAQprXXOVPNV4N4+20zow2bJiBL2k3eG+/tn8NdJm09T
 np6wd8THNyFUihYCg/ht2jazvDQidgSe9D3Q6kgMa7ECCvtyTINvaR7ai2+MBpcE0U/SENDh9ak
 ZCU7bxoZu9xZnt752/GsAgBbaOtvCBQGQqw==
X-Google-Smtp-Source: AGHT+IEZOE3oDlHuD8ADYuBsiz92LLvu4ZkGJWZsF7VH6teGdZ4MMC8yLq0bEVBq9hetQtD0qG3AlA==
X-Received: by 2002:a05:6870:844e:b0:2e9:9b1d:d11e with SMTP id
 586e51a60fabf-2eab43f4ae6mr2065322fac.38.1749739004671; 
 Thu, 12 Jun 2025 07:36:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2eab88aece2sm316018fac.7.2025.06.12.07.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 07:36:43 -0700 (PDT)
Date: Thu, 12 Jun 2025 08:36:41 -0600
From: Tom Rini <trini@konsulko.com>
To: frank-w@public-files.de
Cc: lucienzx159@gmail.com, ilias.apalodimas@linaro.org,
 jerome.forissier@linaro.org, marek.vasut+renesas@mailbox.org,
 paul.barker.ct@bp.renesas.com, pbrobinson@gmail.com,
 u-boot@lists.denx.de, joseph.lin@airoha.com,
 wenshin.chung@airoha.com, lucien.jheng@airoha.com,
 daniel@makrotopia.org, ericwouds@gmail.com
Subject: Re: Aw: [U-Boot, v1, 1/1] net: phy: Add the Airoha EN8811H PHY driver
Message-ID: <20250612143641.GL1382132@bill-the-cat>
References: <20250511051400.29853-1-lucienzx159@gmail.com>
 <trinity-e740c5ff-b6cd-404c-82c4-eaf0642a13a6-1749722988086@trinity-msg-rest-gmx-gmx-live-b647dc579-66mhx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uEr5xwA1um3XmV8F"
Content-Disposition: inline
In-Reply-To: <trinity-e740c5ff-b6cd-404c-82c4-eaf0642a13a6-1749722988086@trinity-msg-rest-gmx-gmx-live-b647dc579-66mhx>
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


--uEr5xwA1um3XmV8F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 10:09:48AM +0000, frank-w@public-files.de wrote:

> > Gesendet: Sonntag, 11. Mai 2025 um 07:14
> > Von: "Lucien.Jheng" <lucienzx159@gmail.com>
> > Betreff: [U-Boot, v1, 1/1] net: phy: Add the Airoha EN8811H PHY driver
> >
> > Add the driver for the Airoha EN8811H 2.5 Gigabit PHY. The PHY supports
> > 100/1000/2500 Mbps with auto negotiation only.
> >=20
> > The driver uses two firmware files, for which updated versions are adde=
d to
> > linux-firmware already.
> >=20
> > Locating the AIROHA FW within the filesystem at the designated partition
> > and path will trigger its automatic loading and writing to the PHY via =
MDIO.
> > If need board specific loading override,
> > please override the en8811h_read_fw function on board or architecture l=
evel.
> >=20
> > Linux upstream AIROHA EN8811H driver commit:
> > 71e79430117d56c409c5ea485a263bc0d8083390
> >=20
> > Based on the Linux upstream AIROHA EN8811H driver code(air_en8811h.c),
> > I have modified the relevant process to align with the U-Boot boot sequ=
ence.
> > and have validated this on Banana Pi BPI-R3 Mini.
> >=20
> > Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
> > ---
> >  drivers/net/phy/Kconfig       |  43 ++
> >  drivers/net/phy/air_en8811h.c | 852 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 895 insertions(+)
> >  create mode 100644 drivers/net/phy/air_en8811h.c
>=20
> Hi,
>=20
> is there any progress? i see no review or apply (+tom in To-header).

I'm not super thrilled at the concept of having to load firmware from a
filesystem. But since we have to do this anyways in other cases, is this
something we could be using FS_LOADER for or no?

--=20
Tom

--uEr5xwA1um3XmV8F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhK5fUACgkQFHw5/5Y0
tyxb3wv+McGjKlG2BpKkVQLhksZNPhhrbK5tZOfl/Sfn8xwE3iVY9Dg4qEbWtMx0
M9vAgKsPSdi/zfBf5wtqQ95E2QovH1sPOtYbeARWQgZTjRawzuWHTZVENjwtVDU5
sxJCjsSCbeBEnFX5OiogIcB79iYkM0+Necm47g8DRjq0Q5S1PL1dWgnoqDyJe3kY
7mjJNNXgGZ2KZx3Gj3KMP9An+ZdLEHNTAVBoV02in8AaUWAvVHbGvvHEOYC1cHMg
m4x4wAwmQMNIREXTCz4+rT58bRMwhqsXYjdybuvqRiX6Z2B3i61o3/kOSiLMvdTW
LeBVRpmSW4Uufw/B7OWK3Spso1GcoVE4IhhcmfOclBxJ7DgSNIxKfxVHhghqKyt9
gTrJwPvytgww540kI4enrzaoNaGM5NqK4Qa1qfwmsBeYJ60/BwDvoe+UUlw8Ahw9
yEIJmtCC8e+0FK0HnhjD6s+YKs7bCvH2IoiwsGHaKptTsKMz225F1P4XSLlIrH2j
3VYkPMR3
=jDc4
-----END PGP SIGNATURE-----

--uEr5xwA1um3XmV8F--
