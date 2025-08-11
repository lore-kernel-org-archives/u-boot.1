Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A25CA0ECD
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 15:53:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BE1E8318E;
	Mon, 11 Aug 2025 17:53:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IZvPgudR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93F8E831B4; Mon, 11 Aug 2025 17:53:30 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB46E8318E
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 17:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-455b00339c8so28813365e9.3
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 08:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754927608; x=1755532408; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VgUk8gKo2Tk3aFLtPtz7K2EzbGU5ThYw0WalZ++grkY=;
 b=IZvPgudRybjb/SlcOO/vSnuQPIE1a/85c9Fhnl3ii4MZ2PDA2MyD16W2K+OpIx7VIR
 ZYvh/oSTC9alntJbJTpKeghqkW5FJT7UNnIf3qdi5CXWgVRti4yYyZ1WOWVGaQGwUwsX
 /mxShZ9fOoZTnmST76/B16xaYdYegU60ZsgrMlMSMc0rMhdLBcrvtfJa79iKpntwJw0z
 NrHyAoQfxmXIVoURRCwo9j1pzsDy4F2Njpv/nqxYjiQm6s08QGQwSTS+ZhuMBGaZDZtA
 uT6ZiZ7SchiMMhtB6K9Xg2QoG6qG2Z9Qfgopk/ai7t8yejG71SYIFoyAGJ8bKY3LMsp3
 KtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754927608; x=1755532408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VgUk8gKo2Tk3aFLtPtz7K2EzbGU5ThYw0WalZ++grkY=;
 b=gx1IrS26M9sinbyU1KtaLmVNoRGd7TGjEhPS9/GpvkVXO0ueqgP05sMCSwVmsSIF0L
 A7IaSYiiFrMD6xdWNR3lVLQY51gVm4N4Nw/RIjOxiMt23/U/9VDVrHEluQtGrz3dNAPV
 qUSC2XUGp5tvI9fHwA+nqTbiydeMxhTLnINT88F0q8jOvoCwHCSIocfkY90FzG4IwJ9C
 mTQI2926aDxmMYr92H2uHqHRDnkpFaoI+zZRlUuQK3+eelWEwfNZkt5dcrcUOWxGUlVz
 BlaoBezT5I9Aq+mt4pUR4nujflXCAp4XAq8OakzcY+tEoGaRBX5iBIWJaxvel27M18v5
 sxSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY5IzO4WK+/dmMtZCNK0KcsgpPASHYqppmfroy6OYAPYVov1rOzLHBEUHky/tQ/u9YPrPXuTo=@lists.denx.de
X-Gm-Message-State: AOJu0Ywqa9oq1vcjRucOd8BpcSP8Q4C5YgVpjQm5tcKzVTBYhPWExK/W
 9HKAeIBZwBWODRz04ez95B3f5qaHTg174uwz+/NKtRXjmqWQEC3nB668
X-Gm-Gg: ASbGncvoCmguMdAXpESe6wmWLpudYqZ20deC4djoCprZlubcLjkiGZmmVU/GfsQ59i1
 gp6R6uzW3MbEpD4hzp0aE0hP/i/1+EttO2dphiAfsh5CbSJsGCD9xiaL17EKrsQSA64rgxJWQHz
 2L8bWebAapEu7WH/X5yd0lpzY1Pe+Ozbwrb1T8fVZTTR409yxzUFqzEykSxkx1MXpcdHV6FtOUn
 vw6gld6wHi/Ta+Rs5EvHUZHUKtwmcOlGekBWF94FaDB93XYn2e/+Gu5PecjlBZkpZy4i3Uln7VU
 2CJYIH8Uilx2xd5HWzUgV6ZrnHTV6JA2qE+zxNislJSVVvb8dUo1j7g4F3yX61kZ9S/RF7tbzFQ
 lywOiapnZ4tgkaul+bvdSgXAXmPG+TT6/w0uutzhyYkAlHXtxrojQJEaqYXvBaGnyP+4YtAyBnw
 ==
X-Google-Smtp-Source: AGHT+IHewgfdwwVGvY7L1mL3p+quhP2TXajTMwoEzj0DE47c8Kga14vtPfgOrlct5UzF5WO2j9s7Cg==
X-Received: by 2002:a05:600c:4f4f:b0:459:d494:faf9 with SMTP id
 5b1f17b1804b1-45a10ba82famr2799735e9.10.1754927608038; 
 Mon, 11 Aug 2025 08:53:28 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e584302csm281071505e9.7.2025.08.11.08.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 08:53:27 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de,
 Andre Przywara <andre.przywara@arm.com>
Cc: Sunil Mohan Adapa <sunil@medhas.org>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH 0/2] sunxi: A64: enable AXP driver support
Date: Mon, 11 Aug 2025 17:53:26 +0200
Message-ID: <1831526.VLH7GnMWUR@jernej-laptop>
In-Reply-To: <20250507005325.15612-1-andre.przywara@arm.com>
References: <20250507005325.15612-1-andre.przywara@arm.com>
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

Dne sreda, 7. maj 2025 ob 02:53:23 Srednjeevropski poletni =C4=8Das je Andr=
e Przywara napisal(a):
> Hi,
>=20
> this series enables the build of the AXP driver in U-Boot proper for all
> boards using the Allwinner A64 SoC. So far some static PMIC rail setup
> was done by TF-A, but this was rather static (enabling too many) and
> increases the code size of the rather limited BL31 build.
>=20
> Do this for the A64 only first, since this uses RSB consistently, while
> the H6 boards are undergoing a transition to use I2C.

What is status of this? Unfortunatelly I don't have time to test currently,
but it would be nice to have this in.

Best regards,
Jernej

>=20
> Please have a look and test!
>=20
> Cheers,
> Andre
>=20
> Andre Przywara (2):
>   sunxi: A64: enable DRIVEVBUS support for respective boards
>   sunxi: A64: enable AXP drivers
>=20
>  arch/arm/Kconfig                     | 1 +
>  arch/arm/mach-sunxi/Kconfig          | 3 +++
>  configs/a64-olinuxino-emmc_defconfig | 1 +
>  configs/a64-olinuxino_defconfig      | 1 +
>  configs/amarula_a64_relic_defconfig  | 1 +
>  configs/bananapi_m64_defconfig       | 1 +
>  configs/orangepi_win_defconfig       | 1 +
>  configs/pinetab_defconfig            | 1 +
>  8 files changed, 10 insertions(+)
>=20
>=20




