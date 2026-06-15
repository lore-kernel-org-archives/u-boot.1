Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CFFCD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 23:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94BA3848DC;
	Tue, 16 Jun 2026 01:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d5cQHav3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 967F7846B0; Mon, 15 Jun 2026 18:33:37 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AA3284105
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 18:33:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7e8f690f53aso388808a34.1
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781541214; x=1782146014; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T8wS0/HKJGQkTJ6YDLw1x6urtv0L+Kqj1320dKXqCJA=;
 b=d5cQHav3e5i8mI5p43hhADKzzvvx1groLl+jW3ebPGq8c5lJ0I2rJ3pnJN45kFlUsz
 35oVOLiaZhGCeiuZg2nZ+Yqk7WNR+KF5i+WMS3zj1UWTMOSEghidHN9Fw1Wo9n5tC+oX
 HfjB+BQnsWJlI1myTHnwoI5LZmb/TqTV9qpAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781541214; x=1782146014;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T8wS0/HKJGQkTJ6YDLw1x6urtv0L+Kqj1320dKXqCJA=;
 b=oOq7QveU3XYGlPrOEMBrx+W7iPW05tQPIFnuMJI79d70t6NDpPUIilTFy96pC9tp9P
 HgMtkBvGwgMPSWzZnNd6vgSCvtj+t5SDvjmoC8I+4R49smc52sb0rYyCeCybZ+CSuG8p
 8MnyEh6Lo35jYLvQJ0mdYO4UtdUbEG6MtESRQ1XQqYpSlDSaZnK1eR2JliRP/vqVcIZe
 fBmngiUK75qbDZ1+Sh+cPWgme+5HmpwhjtF/3HKq8nfjuRa5bdZdgiyzZbJrGDwes7iM
 JktzPy6aDbrTvWQYkzDDW+qG9q0DL56fHM8ZGLIcbcuRlsAPgtxvK8gxHqQx/65wTQdY
 2n7w==
X-Gm-Message-State: AOJu0YxT1clBlaMb6LnrbxLBKMYwF0gK1fmBC3d//CCSovypswIiigqG
 5U8E/YCGfUCZspQzmA9FAjxwlkO5ltZgO8ORq4409HcpPw+TIZD83N5m4g9OnGnZqgU=
X-Gm-Gg: Acq92OGYxhVOx+WK3Gy+1Nqn4bdW4tT1tWleu/e+gRvwl2Z46n+pR6Oca7l3kHEnkOB
 Nl/UtYLrnUQxM2kyKBA021jmb6EsPHtT2cOR2yppB1nLRk1bQEZgXSMM0eIetSjRs9C+x6UmWNA
 ZEuHsamaHPqHwsMPWBLCylPoCkC8alYO53c6xIpe273pPJa4sra79UhBN1v6zW2V6mU4/fumxFm
 8REm54CeoN46YMs3SEdjU+Q7tSINh21fk+g0zawRgDrpifzAdzC0r7k/Nc9HgUOO9q7HLN/c4Sy
 MbTeroFNcGhyT1YuRu/7I4KQzODwicaXCzqpmZWgFiJGmPGCeK9J48/Qf50UzbEVM5UyInzEdLr
 5CE09AkG7fIi+8krEnm8lD/S8K1HlqQ6BOit5GS+6GtuVJ/THeKRcIS2M0ZddA1SDFCmOZ8uJ/G
 DsHIdOzVa9l5CJzlZKUvx58p9UqkzqjgqYUWXu2qezyKYLqklYdP+4NY9Wd3VbuunYlLcpyCAVD
 AFAsFtolqn2QFtkBC+8/flDo8WTnPm4N5XZiWI05WLJL4hfESw=
X-Received: by 2002:a05:6808:2229:b0:479:e9d2:26a3 with SMTP id
 5614622812f47-4872f407344mr9404317b6e.19.1781541213810; 
 Mon, 15 Jun 2026 09:33:33 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4875dda608fsm2961906b6e.3.2026.06.15.09.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 09:33:33 -0700 (PDT)
Date: Mon, 15 Jun 2026 10:33:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>, Andrew Davis <afd@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Javier Tia <floss@jetm.me>, Rasmus Villemoes <ravi@prevas.dk>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Dhruva Gole <d-gole@ti.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Michal Simek <michal.simek@amd.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 David Wronek <david.wronek@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Yao Zi <me@ziyao.cc>,
 Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v3 10/14] lib: update charset.o build rule to use SPL_UFS
Message-ID: <20260615163329.GC382693@bill-the-cat>
References: <20260615-spl_ufs-v3-0-360bceb29596@oss.qualcomm.com>
 <20260615-spl_ufs-v3-10-360bceb29596@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K3+kQ5oRcYrab5bd"
Content-Disposition: inline
In-Reply-To: <20260615-spl_ufs-v3-10-360bceb29596@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 16 Jun 2026 01:14:20 +0200
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


--K3+kQ5oRcYrab5bd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 12:30:06PM +0530, Balaji Selvanathan wrote:

> Update lib/Makefile to reference CONFIG_$(PHASE_)UFS instead of
> CONFIG_$(PHASE_)UFS_SUPPORT for the charset.o build rule, following
> the rename of SPL_UFS_SUPPORT to SPL_UFS.
>=20
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--K3+kQ5oRcYrab5bd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajApWAAKCRAr4qD1Cr/k
CqMGAQDcE0xLCxCweguz1/zrml2qq5GcEf6OhHZTHvhwpdjEPAEA7tjqRnWLkbiI
Ony7FUaK/gfp0VJPZ6Ir3/YCmGEJAQ8=
=87jj
-----END PGP SIGNATURE-----

--K3+kQ5oRcYrab5bd--
