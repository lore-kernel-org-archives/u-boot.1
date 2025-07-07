Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5EAC83030
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 19:59:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FCA98320C;
	Mon,  7 Jul 2025 21:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SN/ekMph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A6AA831E4; Mon,  7 Jul 2025 21:59:20 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 816A9831A4
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 21:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4067ac8f6cdso2583790b6e.2
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 12:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751918356; x=1752523156; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p0aLP1WqfF5AZD4LP06qdua2zr4rzKHaB1HcXjTZYxA=;
 b=SN/ekMphftUyvQrX2uhMm++19mo7XmRIwvfX8xZACRw8y5dre0wL3qEsMS4y/m3Jqo
 bADfaRN5Fi8vMU27CIEVmF6oGrxnTVq3knln508vRlHaKka25KNp0qK8+ew/rdxkFJws
 /ewNa6OjxtqTXPsU1LBelSqkY31XHSgm1ckVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751918356; x=1752523156;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p0aLP1WqfF5AZD4LP06qdua2zr4rzKHaB1HcXjTZYxA=;
 b=qKSyz/sjtWgi/U2gJSVWjHdwr6q+9RgmbFE8Mf4PWKgh7ABnx/Dv/UZHovkERjGOIu
 y1fwanNxrzGRKwrZ41ykPrb44/B+ElvgSjZzhuumtFP/2EnfLlzN3gcLM4jOXDXGuFQ1
 50XScfwjIBCU+4+9U+J1iAlwivB5sVtzI88AkZO5viY7NOKIDvPgVtAxWldz8AbMAIIx
 /iYuvDJRotm4W574RolGPVvf1lkiKAdfWj3KQCAd6M+ss1bDQg1XD6mbPMbU3YpH1VsU
 ypTF7y49RYvHqx6/MhpZ9Pto6oxEJd0flPHpFM/nRkO57sNAeCIZEawe+ogVGVm9UwOO
 qnqg==
X-Gm-Message-State: AOJu0YztWlFrZLoDxKjig6xSW9V9mlzqkS3HVb0yUWNqLxsQMSVLrShA
 d3spoomjItHUWKxxh/G3GDXDSF/a0hDbbw2svZly7Csqw0nDQCcoxjaIS/cPvLOjVhmudRqWXCY
 MYQargq0=
X-Gm-Gg: ASbGncvnGWdkB+VfqouATNVesLda9TaOnDsvWIuTeM+gPalz17HtiQwPiXGwu2gc31w
 i+N3yJbhZhvHVW8LoZAKDdBj3/kAynrJ7LAlSNHZ7+FxqHTHElZRIdhzyoYvdTMAVutOE9gwQ6c
 DWCdN9AV2fhhN8d7Jvn0imuSCCbvZJHHV+xuDb1qrJxKel8fRcwLq+oq9UY4Mz60a97c9FQhszG
 uaa3ppUXTbFx3VSsr2gqyWu/XZYHSvQShSiUOgl1smlHKBNNOXJCmnXF3uq+VEK7/WcXhlLR7sZ
 4FprQG3zCa/0UNW0QkzA5Bhg63kGUWJ962n29ydVFLMv/3da7JV6RW7DYjbcCVrdgjUzdz+YOJT
 0lY+xNitHaS/AM8g0JVt3
X-Google-Smtp-Source: AGHT+IFXDKV2rk/W3EH1Yu1dGIKbaqf4nNxMHJSVTUyDbrdb/iXOe0XzoIq7AkIidzmXt4Ca2evmag==
X-Received: by 2002:a05:6808:244d:b0:406:6d79:49e3 with SMTP id
 5614622812f47-40d073f4be3mr9754911b6e.34.1751918356120; 
 Mon, 07 Jul 2025 12:59:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40d02a442d3sm1418370b6e.13.2025.07.07.12.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 12:59:15 -0700 (PDT)
Date: Mon, 7 Jul 2025 13:59:13 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2025.07 released
Message-ID: <20250707195913.GR6424@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iPpfVZGxphPZ7Y2i"
Content-Disposition: inline
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


--iPpfVZGxphPZ7Y2i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and so here is v2025.07. I will be merging the next
branch back to master shortly and pushing that out as well.

As this is a full release, and not just a release candidate I'm hoping
for a few more people to read this and then read what I'm linking to as
well. For the overall health of the project, and the community, I'm
hoping to find a few people within the community that can help with
overall organization and management. I would like to long term be able
to move us to being under the Software Freedom Conservancy umbrella and
that in turn means having a organizational structure that's not just a
single person. I've put more details in the email here:
https://lore.kernel.org/u-boot/20250602222738.GC100073@bill-the-cat/

Next up, I want to remind everyone that we'll have our regularly
scheduled community meeting tomorrow.  The meeting details itself are:
https://meet.google.com/btj-wgcg-euw
July 8th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

A high level changelog from v2025.04 until now is:
- Inspired by barebox "bthreads" we now have "uthreads".
- We have exFAT support now.
- General improvements, updates and new support in the following
  architectures / SoCs: Apple M1/2, i.MX8/9, sunxi, STM32, StarFive, TI
  K3, Rockchip RK3528 and RK3576 (and general improvements to older
  chips), MIPS Boston platforms, SoCFPGA, Atmel sama9x60 and sama5d2,
  Raspberry Pi, AMD/Xilinx (Versal, Versal Gen 2, ZynqMP), Marvell
  platforms, assorted Tegra platforms, Qualcomm platforms, Rensas R-Car
  and likely more I've missed.
- Once again a number of improvements within the EFI loader subsytem
- A number of cleanups and improvements in the networking, DFU, MMC,
  i2c, SCSI and other subsystems. Also a few series addressing more
  general code quality and cleanups.
- Additional testing within CI on more (QEMU) platforms.

And I'm sure there's things I've missed.

With all of that said, we're on our usual cycle of 3 weeks for -rc1,
which will be July 28th and then every other week for -rc tags until the
release of v2025.10 on October 6th.

Thanks all!

--=20
Tom

--iPpfVZGxphPZ7Y2i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhsJxEACgkQFHw5/5Y0
tywBzAwAoHvJ3wkhpnJjFuTNAkWhovFndoCHrybSnxHsQCx1uWNcs+mseehFYigC
e1/GHWCEGgMslImoNXC94ekCtUKhwhKgh5+Sq65CEMFT4sg8Cl11Rao3nrdlzQzP
NztK4ZXJ57KBfeLTLctCVFgxabCVTx5g2IOWoLZgKFvQ/g0dq9IUjSPUYc+ehLOM
SP9PS9SIAjQdCNr/wb9rpMgIlDyEXXclvtqGIUMuJy7iGg2uHi3ExDvQdgtfvizt
atq4lVIMJ3JS/o5yydTiAnNNNejVZaP3wz+9C8cDV/qr1kwJayblALCMIeqYLIJp
8m4HMZxWOCUINDAoJGGifNl72Fx8TNVCfNAZxmTFG/Z6EbZRA1QWvspuGk5zIVM5
3o6n4d6YKQuOPuHYg2zxXjIyqV12D4UryC7Nr4EKYaxeo9skvVHrSZ1FW2PCp9fo
fkH3/ajmtcIJzN97eU19eUavHD11ydNyfKnj3mwVTWQEEMMpSO6YjjIJnGwnJg33
/7Ea9Ybu
=kVjl
-----END PGP SIGNATURE-----

--iPpfVZGxphPZ7Y2i--
