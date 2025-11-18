Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27967CEDDB0
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 15:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B52F83B95;
	Tue, 18 Nov 2025 16:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0UM6C0+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1909983C62; Tue, 18 Nov 2025 16:01:13 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1846B83BD2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 16:01:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47789cd2083so38869465e9.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 07:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763478070; x=1764082870;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aH8nu66dJbAH90bvSUg1tc4LWaDii36f10BYYBW27Uo=;
 b=0UM6C0+z+KyY/4PDeWdGZkkr4X3lmKvu9X8B9lRxzwbiEoiE3BuGEWAhS6d1n8iRb5
 L9Flrxk7MbZXNmMnpGNZTSSPxFr7BF5fDf1FKHV/ld5AIItexjYPDFtbRyT6JdFIQ41g
 aM3az61JT1YQwjbaLyOsNnGVHV9Q90MuMcVRG4UvSzQSek/5/pTc7yQaUvDK7g//ZvDb
 H7477+6TVoaKsUpV7dde76jG34bS5yxBzXi4Q6VFZrhEu0IQ06jcvOx2XuJc5vDlSIMP
 fWOvxHU6xFbI7sZNQQZatmYTZIVDdb+nIryQCq52TNS430j0PKK+WMioXoWSBNOo29Mo
 ongg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763478070; x=1764082870;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aH8nu66dJbAH90bvSUg1tc4LWaDii36f10BYYBW27Uo=;
 b=Cv+VlJ8vxC1r1HDH2YlCxZ5iBwWwL4eacqREiSjLoE8KBKC7n1ZxTNb0W6bB2nlV54
 vF1C5gOvTFb+NZX3OeI8du3hZ6bsfkGnh6hkRamFrGoj9JASLpa727D+8WJG+OhEvCFH
 RH4T1e4ewtcxyH0IygE8MRPLQw+mNtZ/+08zkf2WR69nTwPlpX/LJ6IsUuDie7Pf9Xps
 kq1mecJlUOeezm07+kIldzB8r7/bOyz9Ygg6zDtotgxMTp6dwEHgEhYjU9VsKW8U2dqZ
 unqkVDPh+VprfxA8/TdYHUGaapxGcyi/EpSpNPu7TF9516wiFMu4MFDtTM7q5Edg3Cn7
 gUOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhWtfm/BEI4Tfcs3RttUKny8PKRoV9pt9q1D/F1oYrC916Nuph/Ti4b9dNEfoAK9Mu65j8zWY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8QxbmY8ADa4Tw3GZanKxWT1LIT9qe82+JwvA6rosovmZOKEzn
 GFKcwihR+XalDzUl5lYPgj6NWSuQZ+Ftuf0fw4ops6G8QgK59r5xZ495Meafj2HPdYM=
X-Gm-Gg: ASbGncv+f+YJDq6xPJvzceLPmDfSxDdD8lnGjC9xXPSX5d8Do5oAyBgi2xNnXaUCdDK
 SgdSJuygQ8CGSS4apdmeJtutZJCuGlcUEjkqwv44JtSCDuvEDTUc/ex8TosWIZ+O70FXxpP8ii4
 1GC4T+ONGUQ/Ke0PiuzUVR7fDeZMLtNKbocq+6EYCGOWewaB0dTLdVuzD31GP4p7ZqL6kBsNfJS
 E713NRdyHlJ1ZijGMqYYBJbCc616e48nGPAoUr/W4OqMzyg0n5rOvci2yJWogNUv+z7Y1ZOwI87
 nkb+FfU1Td6s3y+5teeK3tlPba9Lu9x/sogFSgPMe/OG0l9WX9Xraraa7DHc8JMjX/NJjwWZUoT
 opy6mong0IdwxOyB0HOk++tJ3PjN94idRfk8L4C/aLBT+kCyfJjnTGgHvfTUSLg5YYXrVjQ==
X-Google-Smtp-Source: AGHT+IEopo46wKK/hDbpdFnlqI24OGSjhftRyrYVpaLDUEHXnEhMesP6lnWWabWHbzWYZLwXgLgimg==
X-Received: by 2002:a05:600c:4513:b0:477:2f7c:314f with SMTP id
 5b1f17b1804b1-4778fe5c820mr182204795e9.10.1763478068810; 
 Tue, 18 Nov 2025 07:01:08 -0800 (PST)
Received: from localhost ([62.246.248.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779b509a5esm192937475e9.2.2025.11.18.07.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 07:01:06 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=e5afe2ed95da5cae6bd900b20fbb284448fceea12c0e2f15bf672270b6b3;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 18 Nov 2025 16:01:00 +0100
Message-Id: <DEBWSSW3JNPJ.1YYA39OACM9HN@baylibre.com>
Cc: "Maarten Brock" <Maarten.Brock@sttls.nl>, <u-boot@lists.denx.de>, "Tom
 Rini" <trini@konsulko.com>, "Rasmus Villemoes" <ravi@prevas.dk>, "Rayagonda
 Kokatanur" <rayagonda.kokatanur@broadcom.com>, "Tien Fong Chee"
 <tien.fong.chee@altera.com>, "Alif Zakuan Yuslaimi"
 <alif.zakuan.yuslaimi@altera.com>, "Casey Connolly"
 <casey.connolly@linaro.org>, "Tingting Meng" <tingting.meng@altera.com>,
 "Peng Fan" <peng.fan@nxp.com>, "Quentin Schulz" <quentin.schulz@cherry.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, "Liya Huang"
 <1425075683@qq.com>, "Marek Vasut" <marek.vasut+renesas@mailbox.org>,
 "Romain Gantois" <romain.gantois@bootlin.com>, "Simon Glass"
 <sjg@chromium.org>, "Jaehoon Chung" <jh80.chung@samsung.com>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Marek Vasut" <marex@denx.de>,
 "Mattijs Korpershoek" <mkorpershoek@kernel.org>, "Andrew Goodbody"
 <andrew.goodbody@linaro.org>, "Anatolij Gustschin"
 <ag.dev.uboot@gmail.com>, "Sukrut Bellary" <sbellary@baylibre.com>
Subject: Re: [PATCH 02/15] arm: dts: am335x-evm: Add backlight to the panel
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Kory Maincent" <kory.maincent@bootlin.com>, "Markus Schneider-Pargmann
 (TI.com)" <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
 <20251118-topic-am33-evm-oftree-v2026-01-v1-2-91ce13c661e2@baylibre.com>
 <20251118151444.0634411b@kmaincent-XPS-13-7390>
In-Reply-To: <20251118151444.0634411b@kmaincent-XPS-13-7390>
X-Mailman-Approved-At: Tue, 18 Nov 2025 16:24:05 +0100
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

--e5afe2ed95da5cae6bd900b20fbb284448fceea12c0e2f15bf672270b6b3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Kory,

On Tue Nov 18, 2025 at 3:14 PM CET, Kory Maincent wrote:
> On Tue, 18 Nov 2025 11:40:22 +0100
> "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com> wrote:
>
>> Add backlight phandle reference to panel node. Without this reference,
>> the display driver cannot control backlight, leaving the panel dark.
>
> What is the point of modifying this devicetree as it will be replaced by =
the
> Linux upstream devicetree at the last patch of your series?

My idea was to first fix the current setup to have something to compare
with before changing the full devicetree. I think it is useful to have
this for reference in the history. This also makes bisecting work
across the upstream devicetree changes without loss of functionality.

Best
Markus

--e5afe2ed95da5cae6bd900b20fbb284448fceea12c0e2f15bf672270b6b3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaRyKLBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlOL
wAD+PA4Ab+y9CroMRRtAQ0f86OtRBSUdJaz2mp6AcJB7zAkBAJumVqd9SBLR9QBe
ezJ8pMqOm/u5xqsgr+70fo73ENcK
=xjMP
-----END PGP SIGNATURE-----

--e5afe2ed95da5cae6bd900b20fbb284448fceea12c0e2f15bf672270b6b3--
