Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D8CF42100
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 17:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17C608407D;
	Wed, 15 Apr 2026 19:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="KcwzAl/z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 320688407E; Wed, 15 Apr 2026 19:41:35 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2904383B99
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 19:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43d73352cf2so3410157f8f.1
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 10:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776274892; x=1776879692;
 darn=lists.denx.de; 
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lFIFCoEAxf+/kb5lIsqiWy9ErWMfh14wncOZ5T+v7Kg=;
 b=KcwzAl/zpMdeCR9/7VZ1AIniHBq9dyKjIuIP59/D774ldgb2M3wVJIszUDxq5egsSH
 zNEqkQimc7pLFo+LeTqFXM1yZf66Odd2wyVfuNq3UXytCuijQ4CVsJkvw5qfP1LN7D69
 Zg2MHLzVpUT/W9wG6R8PqXmUXHa8HxDo2VHtfEUL8wXLYCe1d2/4QymBnXXDCNOP8R5c
 gwQYuwcnmVrBzZwlZAUYj1pHelwBbEjt41hmXdcDh2bqduwuAUOj9hiHZoEqpeIbjc4T
 WA30ipLi4Wz3eWhhxcBZKeUgtqxFBdF8XwJWoMLGKK4FS5q45DxYAhLwBLcG5cCDAYKR
 l2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776274892; x=1776879692;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lFIFCoEAxf+/kb5lIsqiWy9ErWMfh14wncOZ5T+v7Kg=;
 b=P98y65hfTD5Mgnzqa2cvfUw0JrkqNCe1jlvkIU21aIT4gXMl5uMxFNeYXZ7vBsMb69
 o/40PzHaxbF9pF4J30R5xBXdALTEq1HQWQSSzF81zyTVO8Tx0df8e35AVLaR//ev/tss
 7mEeLwrh8uXFHAxDcqed02IPrKxLRdnrN1WT3UxvRM+TNvNXIdztd/arml2gFWpgoz4E
 7DaItqi22+fu/mKy/JYFmEUu5YFwGPixYZMh1SnoYVia0nkl9J4MjU0bvST29zR9FO68
 1ukuR7EoebI1vyTdw3ui0X3Tnz5c+bXEamzIhXh8Hos+y7zOvu2BS+cxx6wAMIVgKs3J
 hGoA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8XRVQAKvANSlVtxwUdqmEBV+kCwxtvrCa33lYANRNoeyj2UZ4z0NAinqXhG/zkYp54ogC2iSE=@lists.denx.de
X-Gm-Message-State: AOJu0Yxif8MjgP6ErBIB9g9Y1QzztLrgzW4NKq1eOht5STZkzp7hylip
 16B65o3YOse1deS7asT81moXCtKECJp/vwm/ApGyppzSnZe1iFmVbbJut6kfDH4gwYg=
X-Gm-Gg: AeBDiev2KGOcwrDCmKn/2zDhVxfBJHGcdm4gcEYtfInqaYv60N/3F7ZXMEoo4dTGvMS
 525r/EeHSyLZI80virmLr6SJ1ah/ll9QTIkcHz1NHsutqBp+cneSQ3xIVoZ2XMbahrEgr3xw+yt
 l3GFzCPHw2BbIb+E4tho8IRbv6b47X+pa9gq2VXNXm9cOu1kdtMRba3fbMwj6RrMwooUzAGKfuJ
 nJAfoaPngPkatxw3RR7JbvhHBjybaaEEHPriu+P/16RFSxKXZfLJnu1gt0d9+YJMD0K96a144s1
 2yI/SiogkIbEJJ6o8AxlzfZ9HB1pBHEaq9R5vW8MR2aRc32b9DQbVFhs8L4A/A+z4itwIjN6kLY
 AdNdH/i5CPh/rxQXhk/+rod/USbbeYfIDTICjodctxolaZk7mi1MX3gMnSl4nx1E55ab6tdIt91
 j5Ml1qgGkNUba8hC/Z4iKRtTtpuA==
X-Received: by 2002:a05:6000:1868:b0:43e:a6f3:b763 with SMTP id
 ffacd0b85a97d-43ea6f3c6f1mr11466265f8f.44.1776274892303; 
 Wed, 15 Apr 2026 10:41:32 -0700 (PDT)
Received: from localhost ([62.246.35.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead33d670sm7192180f8f.2.2026.04.15.10.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 10:41:31 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=3e4a5a188711abd4e5d6892a5136ab66dfb9ab39cd2f4f10159092321e08;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 15 Apr 2026 19:40:39 +0200
Message-Id: <DHTWVNZDGRNE.298B3FBIY40SU@baylibre.com>
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Andrew Davis" <afd@ti.com>, "Markus Schneider-Pargmann (TI)"
 <msp@baylibre.com>, <u-boot@lists.denx.de>, "Marc Murphy"
 <marc.murphy@sancloud.com>
Cc: "Tom Rini" <trini@konsulko.com>, "Rasmus Villemoes" <ravi@prevas.dk>,
 "Kory Maincent" <kory.maincent@bootlin.com>, "Marek Vasut"
 <marek.vasut+renesas@mailbox.org>, "Romain Gantois"
 <romain.gantois@bootlin.com>, "Parvathi Pudi" <parvathi@couthit.com>,
 "Basharath Hussain Khaja" <basharath@couthit.com>, "Paul Barker"
 <paul.barker@sancloud.com>, "Simon Glass" <sjg@chromium.org>, "Anshul
 Dalal" <anshuld@ti.com>, "Michael Trimarchi"
 <michael@amarulasolutions.com>, "Patrick Delaunay"
 <patrick.delaunay@foss.st.com>, "Patrice Chotard"
 <patrice.chotard@foss.st.com>, "Svyatoslav Ryhel" <clamor95@gmail.com>,
 "Tien Fong Chee" <tien.fong.chee@altera.com>, "Frieder Schrempf"
 <frieder.schrempf@kontron.de>, "Johan Jonker" <jbx6244@gmail.com>, "Brian
 Sune" <briansune@gmail.com>, "Hai Pham" <hai.pham.ud@renesas.com>,
 "Bernhard Messerklinger" <bernhard.messerklinger@at.abb.com>, "Emanuele
 Ghidoli" <emanuele.ghidoli@toradex.com>, "Parth Pancholi"
 <parth.pancholi@toradex.com>, =?utf-8?q?Jonas_Schw=C3=B6bel?=
 <jonasschwoebel@yahoo.de>, "Paul Kocialkowski" <contact@paulk.fr>
Subject: Re: [PATCH v6 12/14] arm: dts: am335x-bonegreen-eco-u-boot: Add
 include of bone-common
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
 <20260415-topic-am33-evm-oftree-v2026-01-v6-12-94cde349bb01@baylibre.com>
 <b1b81d6c-384f-4623-bdcc-1c24c6d910ce@ti.com>
In-Reply-To: <b1b81d6c-384f-4623-bdcc-1c24c6d910ce@ti.com>
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

--3e4a5a188711abd4e5d6892a5136ab66dfb9ab39cd2f4f10159092321e08
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Apr 15, 2026 at 7:11 PM CEST, Andrew Davis wrote:
> On 4/15/26 11:02 AM, Markus Schneider-Pargmann (TI) wrote:
>> am335x-bonegreen-eco is the only bone that does not have a -u-boot.dtsi
>> file yet. The added include for am335x-bone-common-u-boot.dtsi adds the
>> needed tick-timer definition.
>>=20
>> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
>> ---
>
> This one could be squashed into patch [7/14] where you do the same
> for all the others bone boards.

Indeed, thank you!

Will be done in the next version.

Best
Markus

--3e4a5a188711abd4e5d6892a5136ab66dfb9ab39cd2f4f10159092321e08
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCad/NlxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlPs
6wEA9/Y30MVO4PQRPkV5nSXXUCFmfF6cU7ypBRTJ4KAkQM8BAM1AoEtm5yZ5G+oI
lgYxt+rHcyQGLbHTeCYJaQVa+vkA
=sMp8
-----END PGP SIGNATURE-----

--3e4a5a188711abd4e5d6892a5136ab66dfb9ab39cd2f4f10159092321e08--
