Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46A1C369A2
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 07:20:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38670839BE;
	Thu, 10 Apr 2025 09:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BFsHYW34";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89C5D839C1; Thu, 10 Apr 2025 09:20:19 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92B5F8209C
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 09:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so334367f8f.2
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 00:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744269617; x=1744874417; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fxWEedt3fMr2+s19ndrV/m3BR+qDLQD+2272oybXZ+M=;
 b=BFsHYW34YOHupl1XYBXCT1iJSnKOxgvrXT2aRtoRwbrLxJ8Te+ItD63gXoHb+4IhnQ
 pVYBtAWosZz/0uXHie4eQLdctM5SJKVG5Rc0v36bGQJlhtN8YYdsEoVnqtjLu/h51w/m
 uJBvQo+nc+Iy7i56Pe4yzfomdFl5TQM4H+22O7kH7OzsaOUI3aF7l2BD1BSPrnSx1gQb
 Y1ovdr+eWCeV2BIbBAa7S4qjAwhmINbLkNM3h19i60l0gqqdjwm+QOvRcbLrskcc76sk
 uK4vgchjjcE3I/9VdVWObw+34Ltr534O3v6l0jJLe7Hk/vRwlE2zKhOUon5D+q/3ShMw
 IOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744269617; x=1744874417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fxWEedt3fMr2+s19ndrV/m3BR+qDLQD+2272oybXZ+M=;
 b=qBBVFYwseqL7QSWbvx4HAVJQWwDYeD0fvBsNWz/NPl50trNzFrsaw8Q2ime25JrILH
 7azTmrqaxFiqT9QzIpTrhYyvnsFBF1Z3wpgrBiTHSBV17kiTgwrHCRGABeFxZv98+rAy
 6PPAg2CLg8tZELBa5pp+BZ4cc77tv6LWEkIQT3ZUXKbeP/jVKxPW8VTuMg2HUcun2lUJ
 q+ckyHCFKvy7FG2uCOm1YzEygGE1MuwLHdFArk0i2n+yxPLmWftorFFxXQE3+0LJ1Sx+
 z70jx60b60rXhD9IIK+U/Se9muLAbOyQZa7itA7Fcb+M6hdBrhyqxeoLvsSOPpC8LNj8
 tXAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3RM7ukrLirUgCufPqbA1F2aWRNGD8Ga8v5UIGrYG9+RXUIJVXJiRNNfVODvou7KtUnq/bPmo=@lists.denx.de
X-Gm-Message-State: AOJu0YxTqCdoWQ3kgf0t4eeo4D/0//qdMxyZic+a0BiPjwy1E9s8RiKj
 yQmvnk/QkQWTQIazbreV9DbOfVBNXVS+9JCnVM2Zzluc/bCsYkXs
X-Gm-Gg: ASbGncv7LIk4/b3GljRx8HjQBmAqH2eXhAHs1BBhM+OSSMMuKgOFTbqNxLcgOnaiYNT
 0Vfe0Pw2Y8IWGC85ZYYBh5HMG5RjSlJNzfGALe799dzy+Gf57u+bn76eVoL2HG0UrkOAodPwYSs
 VZWhdoekEX24j3wvvhu0ZvP9k/cFejPUdWpHXgPn87hKYrG9A3piYnQBEBn9nA1p9ACk10p9hrl
 TyYbYVxuWRInY1ekV853oxEgO/DegEV/gRLEHsF53NCwuWpfLIhra0ZU5Y/sW0xyBmY9GOsv9VB
 0gl9bCmZOj78p7jEpd4kfnnZhQLuZSPmH12xa4kAfZ0zv3CFSxWgd1/tVBsDqcbzW+FSNW4W5kX
 MkWJAFwRbfe+YPMM0lLKDOmVVtjE=
X-Google-Smtp-Source: AGHT+IGcbG9TTzv88SGGmYonUe5BWCB8tFfVJ/XyJ88KQjsTrUUWfslLGtbCYo5HW3Bwq+n1rTOsQw==
X-Received: by 2002:a5d:64e3:0:b0:391:3f4f:a172 with SMTP id
 ffacd0b85a97d-39d8f4e8e14mr989437f8f.49.1744269616992; 
 Thu, 10 Apr 2025 00:20:16 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d89389ed6sm3804553f8f.41.2025.04.10.00.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 00:20:16 -0700 (PDT)
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
Subject: Re: [PATCH v2 8/8] sunxi: Kconfig: Remove obsolete USBx_* pin symbols
Date: Thu, 10 Apr 2025 09:20:14 +0200
Message-ID: <3620418.iIbC2pHGDl@jernej-laptop>
In-Reply-To: <20250409002036.12212-9-andre.przywara@arm.com>
References: <20250409002036.12212-1-andre.przywara@arm.com>
 <20250409002036.12212-9-andre.przywara@arm.com>
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

Dne sreda, 9. april 2025 ob 02:20:36 Srednjeevropski poletni =C4=8Das je An=
dre Przywara napisal(a):
> Now that the USB PHY driver uses the device tree to get the VBUS detect
> and USB ID GPIOs, these Kconfig symbols are unused. Remove them from
> their Kconfig definition, and also from all defconfig files.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


