Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04682C77B7C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 22:24:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FAB982CFA;
	Thu, 26 Jun 2025 00:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zajv+4el";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA09F82D21; Thu, 26 Jun 2025 00:24:54 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C933582C4C
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 00:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-40af40aeef6so130695b6e.3
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 15:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750890286; x=1751495086; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=242wBCZtRol1W72PrQoFYGrK0pvYugAWcPOUxt7WkpE=;
 b=Zajv+4elB/7SIod9ytbidU5RiNSO154BKfpl5pbjN0pfecCwRs50N/QDKG4UKI1kf3
 XL6tEE1iRtD+g6vcp4VYInXZ0ix+go+D6ijLmg74toVOHIKYtq63vsXDjaXr03bB5zrp
 9UeXItx+HwOxBwk9jgdKnCWVA9sb1QYwR5W3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750890286; x=1751495086;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=242wBCZtRol1W72PrQoFYGrK0pvYugAWcPOUxt7WkpE=;
 b=bXLwWclTujk4MBjjRGk6+uLHxlq398E6ofjjwlBa+y8npbXr75Lwepf1z+oBA+TZdK
 7WTn2t5GO2RmEF3jyR7liWPFIHN0Nvs4rAVTXhw+vWWELLeHkkSWZrbL5cAjgEAug5GM
 lBZr6gJu7MdOm8JnTbquZNMSO1L/ncCCBJC5U1Hqi5GLo88Nnf3AwEi+Evohd6YGX8p6
 4HPhp7vY5926SFpIwVMF5ZpkM8tQXfqkoCL1BIulWn3a/lL8u1GG8VQqjg9ww3R61Oq4
 dJUlqc0UwDqqgsKrMooXz6fXvxqAKWKXPPtTK1iFXKrzqSLmnALQnvDawH5Q4KQVUn/k
 AuRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlasd0u/Mc28Ap6x2yNihLfFZRk0kUZxvuf2IkZwRuLWc+2PMU+W+y6gGkk7LtIeWOJ00m1GI=@lists.denx.de
X-Gm-Message-State: AOJu0YxjGWJt1p12Rnm3C3VxneyU6gvxeEtbnuCqiVwAwHKQbTu6d/RN
 iCm31t1o7Gp5z0MhpwP7QwrHbp7z/O38vv8qmIKAvBqHckbZebzwqXa1t/G8z7ZHrVE=
X-Gm-Gg: ASbGncvZYEo53XxZNH2pmnJJbS2jCbMiz4WSGQEf0lFmsqaPt6xu9qtnHbRDTnv/E0h
 Lpm0pLHvzVB8d0Un0/lddtBLEKGq/RSzKZwOva9BmnURBxMbnj82vHkI4mUyiU5MucfWq57RYyW
 UqVZPviLK2ENJTJOS7QK+coTYyYQKiUsssy3AHF/4zrKsGe2mLlHQ4R5lGqHS7wQD+FXCHqTgZk
 /qih2FPLy/a11JelZmc3wJLu/QwsUkilsMvynmTqXdZbe4lTZQ2+FIib201w9yx55xWTaYV/qzh
 Pvxxbpc/NBSdAZ3YqS778xWko+VCizYfKZQqAC4TZQLIQxAARVudLGHR4natHZwsEqI8+fkoWdP
 abUybBQtHxBNTUiqWVHeG6+4=
X-Google-Smtp-Source: AGHT+IFKhy7kdCZFFwHuglEYhVbrEcUQ3GOk42iz8zFUouMpzjh3PLzUvpYNI2RG2RFUZs8jJ8FbGQ==
X-Received: by 2002:a05:6871:331d:b0:2d9:45b7:8ffc with SMTP id
 586e51a60fabf-2efb21357fcmr3229894fac.3.1750890286442; 
 Wed, 25 Jun 2025 15:24:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea6d88sm33069fac.6.2025.06.25.15.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 15:24:45 -0700 (PDT)
Date: Wed, 25 Jun 2025 16:24:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Alicja Michalska <alicja.michalska@9elements.com>
Cc: lukma@denx.de, seanga2@gmail.com, ryder.lee@mediatek.com,
 weijie.gao@mediatek.com, chunfeng.yun@mediatek.com,
 GSS_MTK_Uboot_upstream@mediatek.com, u-boot@lists.denx.de
Subject: Re: [PATCH] drivers: clk: mtk: Decouple MediaTek clock drivers from
 SoC
Message-ID: <20250625222443.GA1516460@bill-the-cat>
References: <20250608010758.1662149-1-alicja.michalska@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="symjuSIGkxjybLiW"
Content-Disposition: inline
In-Reply-To: <20250608010758.1662149-1-alicja.michalska@9elements.com>
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


--symjuSIGkxjybLiW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 08, 2025 at 03:07:58AM +0200, Alicja Michalska wrote:

> As a part of ongoing coreboot/U-Boot payload work on modern ARM64
> Chromebooks, we need to decouple MediaTek's clock driver from depending
> on SoC targets.
>=20
> This patch essentially mimicks behaviour of Qualcomm clock drivers in
> U-Boot, allowing us to pick them independently if we're building for
> coreboot target.
>=20
> Choosing CONFIG_TARGET_$SOC will still automatically enable the clock
> driver for desired target, avoiding breakage.
>=20
> Signed-off-by: Alicja Michalska <alicja.michalska@9elements.com>

This breaks mt7629_rfb, please fix, thanks.

--=20
Tom

--symjuSIGkxjybLiW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhcdygACgkQFHw5/5Y0
tywb/Av/XNBx+2SxQZlyMq8nkKpNrkEN9goygLPmPnNC4+b0/sdxRrJVLUxJRdw5
IVtDLalW8Is5Y0CIXIovYTUMW2Bun3Ly28SxpdcL7jAMI0WvUPOJ9vEywYP3s4As
LMN+t4NfwgiIoKkMsnzhCkNkxj6Wxy+aZI75TyaPB1GzsFjT0xvpjkR2UZCEx8EZ
WrjiVtR109u+xraz7PQ95Oa0mGSS1+r3Cd+zqSwsctFkuhvNjXEL4Eps+FC07S1a
28tD7dURPTpum8KEy2i2IPS7UE2Ifwx0Z0VCcNrEx56iW5YEO0B43djvOGIqYHgR
elr1sFUn3Oo3A8mQ3ZAWVYK9zHY2xxkzTj7bRt1LCTCpign3rn0w0t71mGQFAwqM
uaZgwI8qrbPwvHgtg6MjEU/1U8cLyrDvaqtaZQOx2vYC2nvpcYobrB2c0SR0mV5N
Zjqn23emyPiTMarT0NAgLj72f9tG1Olu+Ea3gTewQtm6hZDqgMwxz4PNPjQRvGzF
thdd6PT7
=H4Cq
-----END PGP SIGNATURE-----

--symjuSIGkxjybLiW--
