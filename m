Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85EBC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 07:11:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24A2F839A1;
	Thu, 10 Apr 2025 09:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fTzOVuSL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE0DF839A5; Thu, 10 Apr 2025 09:11:16 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0617C8394F
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 09:11:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39c1efc457bso187962f8f.2
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 00:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744269073; x=1744873873; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gm40axamLUXAYbK4VgJ5ujHVXyS2R37tibfMnUuA7+0=;
 b=fTzOVuSLRKwQ0qhHKruuxPKr7G1ZvmgSxZgb16o01bvMwqjaQbtmvuKwDjqKNcxh1e
 dmT2aF+o4NxJBvBRrP1hZqKu65qmeDaKD7J3v3zoPmbYj61AussePYcXFLJJJo9eXXU5
 UjIPuPSRaDrpjcHDwbI+HAqa2ZlhnUafczey1GN+kWjb0/31nvES9h1h0awjmIDtidxs
 JoS2KuvsxESaooNZ2lq69ACs4mb29+zBr3qW1PNbf/69ASc1o7aJOz2XDxcJ03ViU9Po
 cX7LVrmqUOW5Fno8sM41Whold0GOXzlklS00arbzryiY6ymhG80tXlL2L/5KAYbvKHFH
 w3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744269073; x=1744873873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gm40axamLUXAYbK4VgJ5ujHVXyS2R37tibfMnUuA7+0=;
 b=d3hrdgiwdjnx0ZHpHTZdF+kBILLbhJOKKNK3o+HkuSwRSrVum1pavT3WhCVssVXJIh
 TCCbGgpZDCG5Yx9g8iY3yB/RT7KdUfpMCu/Z0eQ2PHw6HDTYEKbd0XJ460fLYLIMRVS3
 9mmaMQnihlGlLy8ERoj/VZvmpzZ7GOvikAIuL6QTe1jBrHOkdugCncoSNCx3oLH/AyvU
 gKKYuWoynUfjc4uVzAEA4fnGWo7bovjzKBzAQvtpNQ5s+qZNSfeUUEh+MpV8sTlTQfty
 l4b9jXedI3CztIckTwSMPqE/ve57TS/2uth8n2K4lbAZOwaff6JOQ0DN2GbKeSIj/cZ2
 Pe0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWjr4C+N7vtKTCu32PXdFd6CQTt585yyF6dbGkh4jPhswLlg5ZuB+b4/kZTYgGJrdeHUJV3J8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0HCIRDJr+bM4/zoUB8jZA5kh1cSJO57EAPc9o3HY0IVrk8bjy
 favu+sYPM6II+3qr370BgBbXtzlIbS+Y8NSxwREghFYqTCpGxJr0
X-Gm-Gg: ASbGncvLmt0qEoIGTakrn+XGnOUzDSiQX69uhpBahr687j6MSSGEZvTrjtgrYEnN76D
 I8pGxCBkZjfCErK+dL8f3nbLq4wuvLoqhpEuttyJD7s6yCP/L2ov2xB4Om1YjFFcCuFko5mbdVP
 cIo87H1EeAbeEzZygbf6ycGHrp0cgQFekaDbob3g0e9/bqHwdO2mmblRpu9joTqnKE6a3tQNO/x
 wWeexg32P/kccyNfBOcbCtJnvesR6AjfAavfxk2whTM/UDxa+vORfRE5z55+muBAw/ZWoG2pK+B
 SAmEONFnpuqq3tIaaa9gGtDJILU5EvasBicsEsSK2qStKUYK2Q19oxNWP2SlS0JbMuPbTsNF7ng
 ZHO2C1kGvGGwq/A+7TCriWKcd+/U=
X-Google-Smtp-Source: AGHT+IHrN6rHPw+GJiETlW6P3yjUvx/uHLNEZzXOmGW7XWou72sPe9TxazQFSE/xBl1lgbKeF+AbCA==
X-Received: by 2002:a05:6000:1ac5:b0:39c:1f19:f0c3 with SMTP id
 ffacd0b85a97d-39d8f4e2467mr1081126f8f.46.1744269073137; 
 Thu, 10 Apr 2025 00:11:13 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d893f0cebsm3863059f8f.61.2025.04.10.00.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 00:11:12 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Hans de Goede <hdegoede@redhat.com>,
 Olliver Schinagl <oliver@schinagl.nl>, Iain Paton <ipaton0@gmail.com>,
 Marcus Cooper <codekipper@gmail.com>, Stefan Mavrodiev <stefan@olimex.com>,
 Paul Kocialkowski <contact@paulk.fr>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <mripard@kernel.org>, Ian Campbell <ijc@hellion.org.uk>,
 Adam Sampson <ats@offog.org>, Zoltan Herpai <wigyori@uid0.hu>,
 Siarhei Siamashka <siarhei.siamashka@gmail.com>,
 VishnuPatekar <vishnupatekar0510@gmail.com>,
 Rask Ingemann Lambertsen <rask@formelder.dk>,
 Aleksei Mamlin <mamlinav@gmail.com>, Peter Korsgaard <peter@korsgaard.com>,
 Michal Suchanek <hramrach@gmail.com>, Icenowy Zheng <icenowy@aosc.xyz>,
 Stefan Roese <sr@denx.de>, Phil Han <pengphei@sina.com>,
 Quentin Schulz <quentin.schulz@free-electrons.com>,
 Jonas Smedegaard <dr@jones.dk>, Jaehoon Chung <jh80.chung@samsung.com>,
 Heiko Schocher <hs@denx.de>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 3/8] phy: sun4i-usb: Control supplies via the regulator
 uclass
Date: Thu, 10 Apr 2025 09:11:11 +0200
Message-ID: <2983258.e9J7NaK4W3@jernej-laptop>
In-Reply-To: <20250409002036.12212-4-andre.przywara@arm.com>
References: <20250409002036.12212-1-andre.przywara@arm.com>
 <20250409002036.12212-4-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne sreda, 9. april 2025 ob 02:20:31 Srednjeevropski poletni =C4=8Das je An=
dre Przywara napisal(a):
> From: Samuel Holland <samuel@sholland.org>
>=20
> The device tree binding for the PHY provides VBUS supplies as regulator
> references. Now that all boards have the appropriate regulator uclass
> drivers enabled, the PHY driver can switch to using them. This replaces
> direct GPIO usage, which in some cases needed a special DM-incompatible
> "virtual" GPIO from the PMIC.
>=20
> The following boards provided a value for CONFIG_USB0_VBUS_PIN, but are
> missing the "usb0_vbus-supply" property in their device tree. None of
> them have the MUSB controller enabled in host or OTG mode, so they
> should see no impact:
>  - Ainol_AW1_defconfig / sun7i-a20-ainol-aw1
>  - Ampe_A76_defconfig / sun5i-a13-ampe-a76
>  - CHIP_pro_defconfig / sun5i-gr8-chip-pro
>  - Cubieboard4_defconfig / sun9i-a80-cubieboard4
>  - Merrii_A80_Optimus_defconfig / sun9i-a80-optimus
>  - Sunchip_CX-A99_defconfig / sun9i-a80-cx-a99
>  - Yones_Toptech_BD1078_defconfig / sun7i-a20-yones-toptech-bd1078
>  - Yones_Toptech_BS1078_V2_defconfig /
>    sun6i-a31s-yones-toptech-bs1078-v2
>  - iNet_3F_defconfig / sun4i-a10-inet-3f
>  - iNet_3W_defconfig / sun4i-a10-inet-3w
>  - iNet_86VS_defconfig / sun5i-a13-inet-86vs
>  - iNet_D978_rev2_defconfig / sun8i-a33-inet-d978-rev2
>  - icnova-a20-swac_defconfig / sun7i-a20-icnova-swac
>  - sun8i_a23_evb_defconfig / sun8i-a23-evb
>=20
> Similarly, the following boards set CONFIG_USB1_VBUS_PIN, but do not
> have "usb1_vbus-supply" in their device tree. Neither of them have USB
> enabled at all, so again there should be no impact:
>  - Cubieboard4_defconfig / sun9i-a80-cubieboard4 (also for USB3)
>  - sun8i_a23_evb_defconfig / sun8i-a23-evb
>=20
> The following boards use a different pin for USB1 VBUS between their
> defconfig and their device tree. Depending on which is correct, they
> may be broken:
>  - Linksprite_pcDuino3_Nano_defconfig (PH11) /
>    sun7i-a20-pcduino3-nano (PD2)
>  - icnova-a20-swac_defconfig (PG10) / sun7i-a20-icnova-swac (PH6)
>=20
> Finally, this board has conflicting pins given for its USB2 VBUS:
>  - Lamobo_R1_defconfig (PH3) / sun7i-a20-lamobo-r1 (PH12)
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> [Andre: use regulator_set_enable_if_allowed()]
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


