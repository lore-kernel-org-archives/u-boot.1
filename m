Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B0ECEDD93
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 14:08:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB2F983C5E;
	Tue, 18 Nov 2025 15:08:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qefl/XRU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E135283D5D; Tue, 18 Nov 2025 15:08:11 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAD6D83B95
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:08:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-3d47192e99bso4300764fac.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 06:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763474888; x=1764079688; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=40Qk1U3gFD2RUVRZzE1Z35Uzl37N4mSpgyBfqiSFKNw=;
 b=qefl/XRUlOz10u+VRqsu2He63glzWn0brex0qyaYcd2iqBpES49nLYvKznk2TIFisD
 vnJfBUdObVe6bJ6BvfP/nFsdmjPrNPi3kzMnVYVbdKiUzLNXG+EVvYXdeLKg5mG/R4dO
 tKfWGSAp79kgN5PHLAxOiJp9GW08lXAS9YtRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763474888; x=1764079688;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=40Qk1U3gFD2RUVRZzE1Z35Uzl37N4mSpgyBfqiSFKNw=;
 b=wcReksZF/4acjCfdqAnMUytW5hkhqdi/eYq3Poc9lC4i1axocdT3yOZeas8f+TMqdP
 8BceUeJc+fpIGWOpO1ohON3Li2rcIIMouD3NdlKo/fXURs6tF61vc+LieU3xdsUUImbP
 C+jusgXX6qdNZbdgt5uVmQyx0t7qemYOsynmN9YWrH41EmhHttYgi6/9kE9qoRIYPxPs
 mivEmu+aWBOvMyhnAMDHgtVtFTrnA20snBEzCkVqu9h+cFPmew1ueOV5jckmUQOs9eZp
 aa86Q0NTHVCmXwt5oeKAbvxLgXYN7Q0QxJdusCNLjPD9QYW9C8i06rkdl6QGh/jRlprl
 73WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOEd00XrPFav7Dbwm59TpNMV36Le+e16bZ28Rhrl826psUX4HzLmO3h54uMVfu3pgoLCM9T0g=@lists.denx.de
X-Gm-Message-State: AOJu0YyAeUzlPexB/Xt24Ys0QP20/5fmzqtZWwnSm+LXdeHbZTd8JEmq
 dnY/ygIRRg3PZPoYegnfkJwNNNELid27e7Rp9n4bFxL0A3fTt7qpCE0SNDXrJh7qrKk=
X-Gm-Gg: ASbGncsj3LD+hXuygiOH0klAtHMyxQfJN5m0Lc9hQcdVRTHw58F+GC/c/LTyksai/Mr
 GfVDuuaaDnwJ9U/1DfYaaEgSjmL5Nqe2SMXEl1urUnVrlmNDYc9qsF2+0hL2Yu6QB2Nuzot42TZ
 s9t34gbY6eTzW8R+Nl7TGjKnjdLIyUKNe5hjnFiz3zjMtXmG+39pMCRpo6zO6Ttf4aebKahI77v
 XmcddiiJ6LapcsB/Jp++GuzBt4WfsqyEYFPCKCCyGymX7euwyQSnG/YHnlQK54xdbMQqmaLrLBY
 kHVUC9LRmMUy0DKTNmyBuv5iKg3uUg7CGNGEok7AzLZpnl9rghnPz4YM/RripccgkSmQ2WVy+cl
 wnxu0OiY3jTcuyJ48CttHcJozUGog1MuQ3JASVPsZqbYqsILy5T89dqi+VRdmj0qXnsDvyI41iA
 691KShZrZzvrIplOnMitBMdOSBRUCivFcPuaGNC0Qx0KF15jn7udR8HY5G4aiq+2/askohRtI=
X-Google-Smtp-Source: AGHT+IE3yLDS6TCYyPExKk5v/ChC6HGaS3viOBfgQbgCdA2q2iUcNc/f+DO6YHyCjObIiNGNtkd4Vw==
X-Received: by 2002:a05:6870:2492:b0:3d1:a15c:f06a with SMTP id
 586e51a60fabf-3ec60916b21mr1798062fac.0.1763474888368; 
 Tue, 18 Nov 2025 06:08:08 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e851ff9dfesm6984645fac.2.2025.11.18.06.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 06:08:07 -0800 (PST)
Date: Tue, 18 Nov 2025 08:08:04 -0600
From: Tom Rini <trini@konsulko.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: Maarten Brock <Maarten.Brock@sttls.nl>, u-boot@lists.denx.de,
 Kory Maincent <kory.maincent@bootlin.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Liya Huang <1425075683@qq.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Sukrut Bellary <sbellary@baylibre.com>
Subject: Re: [PATCH 08/15] dm: core: Support multiple drivers with same
 compatibles
Message-ID: <20251118140804.GR2125796@bill-the-cat>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
 <20251118-topic-am33-evm-oftree-v2026-01-v1-8-91ce13c661e2@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RlbJX2xcXFnc6y1R"
Content-Disposition: inline
In-Reply-To: <20251118-topic-am33-evm-oftree-v2026-01-v1-8-91ce13c661e2@baylibre.com>
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


--RlbJX2xcXFnc6y1R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 11:40:28AM +0100, Markus Schneider-Pargmann (TI.com=
) wrote:

> Currently once a driver matched the compatible string of a device, other
> drivers are ignored. If the first matching driver returns -ENODEV, no
> other possibly matching drivers are iterated with that compatible of the
> device. Instead the next compatible in the list of compatibles is
> selected, assuming only one driver matches one compatible at a time.
>=20
> To be able to use the bind function to return -ENODEV and continue
> matching other drivers with the same compatible, move the for loop a bit
> to continue the for loop after -ENODEV was returned.
>=20
> This is required for ti-musb-host and ti-musb-peripheral which both
> match on the same device but differ based on the dr_mode DT property.
> Depending on this property, the driver is either UCLASS_USB or
> UCLASS_USB_GADGET_GENERIc. By checking the DT property in the bind
> function and returning -ENODEV the other driver can probe instead.
>=20
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>  drivers/core/lists.c | 62 +++++++++++++++++++++++++++-------------------=
------
>  1 file changed, 32 insertions(+), 30 deletions(-)

This seems like a big generic change (with potential performance
impact?) for a rather specific case. I assume the linux kernel simply
doesn't have this issue by handling OTG differently. So is there some
other way we can handle this here?

--=20
Tom

--RlbJX2xcXFnc6y1R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRx9xAAKCRAr4qD1Cr/k
CiIkAP9vxrSR4jS6vcdzklselWbJutQLWnfeccqK4NoPFGYUygEA4Y4z4Oz18dX9
FJ01w61aMiNBRDdtUJ+iTmgRLI7cPwI=
=O1lN
-----END PGP SIGNATURE-----

--RlbJX2xcXFnc6y1R--
