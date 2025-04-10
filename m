Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3F2C369A2
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 07:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16A9883957;
	Thu, 10 Apr 2025 09:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bm2A7p9F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20C3883989; Thu, 10 Apr 2025 09:04:42 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 000548394F
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 09:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39c0dfba946so174568f8f.3
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 00:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744268679; x=1744873479; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cs98PbtKPUYAWZfSTgmbNp3F14K46Gf5P6JEqg+5eQ8=;
 b=Bm2A7p9FVhlEhgitRR6Dtt/Adjv3tb364eWPNDtbhCxQRMv3aVWybDpr2+XXfRkHzf
 eHy02HCczMVUB2UnasMpjyRYV049MQieNF4gNY8/l07B6ipOBEhej1IDtx+mjMVylN43
 4GUWT+BRYmdoc15OgX24TudluW/zE0go4vmn/6k4b9vK9UDW1HYrFu/x7p7iwD0YbbhN
 tl92VhsN0yLiQeVehjQaJvc4iAKCrPd22deA1qwooNLF0pmYLbn3gXXdt5DTHD8/f26s
 tjbcE6D+0AW8YI3xnXuL476IC83dx8hPjSbpcJowkFl5BUMbAAsXwJcwYoiya2vpkekV
 lPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744268679; x=1744873479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cs98PbtKPUYAWZfSTgmbNp3F14K46Gf5P6JEqg+5eQ8=;
 b=ZEePCeveeTf300Sh5+rY8jzCGwRQUmQAEpHtAPFtExz4+09qWLPNbM51f8BXCpfzbz
 7GG7kEnl7IjvQ184ZxGdW7kYx0ForxFntTSzLTPdCItKJIy9JW3R4Ek8WIApAi+JhiwU
 pYD21he3lg5dkq+donQW1fgQugia6UKH7JAsvccgkuG7COx472xzGQEgMSdZNJ1lrtp+
 aHGivOo6mLXsyyopRUfpK5EqpBEvOOHaHMuPo2F0LWR4d9f8yBPK63Ic1R2TOnCq+y1C
 c+FpRtRMZ9NC04+fdpgcfght79PDklorkB329Atw83bS2+feuo7eqNkcRojXL2PVmSu5
 kUNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5pEWVTdHNosqB1bjEHHpi7SYIWjyw0hKSx63dvyruDaYs/9GdUpho63/3Z0fkF63IYTETKfs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2MpCf0Qg+7Gj8RltHrUlWbBEPIbI/vvrI34tMooDJ8wqLjsVR
 YP2ez1eQy4/JnfT/HjYzDTVmdNCnQEQeCDMl0LofiNvSonj9v8po
X-Gm-Gg: ASbGncsPpA5QjVLft85uv4IpA5IEiGGlSDgouL7lfNEdAIrIQmeidovtWxVuYuPS5k6
 clN4A5RRF2znwAISSJ8zAUXQTYEFyhsZpkfzkog8zhPo4YU/fhFa7PluT434w6zhkGUdVuab+CO
 xpEedonM2POzya6qUz+tIh6u/7Q+UFc5pIux/r0ElpHqkVDyUuFVu7EtmiIkX8HzWRE5MroaSRj
 LPlXmrswnh/Ir2+FAx/m3SNxBmY2TNi12Tqx5lKOg58QwyFRZc9yDm22h6JA/QLSanHnZBVH6NU
 NzrA0flBbg7ivW6Y21Hk/qgA3Mkxgd7DJlniPw7J1AaA4D8cZ2UKA6YVBeOpf6TvIuhFXz6ocp3
 ksfSEg1xMe4BXxNUX
X-Google-Smtp-Source: AGHT+IGF2p/7HAB8hJNNMWrRdkyWilShhbGY7rgseLQ/K9F69kSeo0JAu823ulBpxf6QI/Fua+I0wQ==
X-Received: by 2002:a05:6000:430b:b0:391:4bfd:6d5 with SMTP id
 ffacd0b85a97d-39d8f4f1a9emr1172471f8f.52.1744268679185; 
 Thu, 10 Apr 2025 00:04:39 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f207c90b4sm45451145e9.38.2025.04.10.00.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 00:04:38 -0700 (PDT)
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
Subject: Re: [PATCH v2 1/8] power: regulator: Add a driver for the AXP PMIC
 drivevbus
Date: Thu, 10 Apr 2025 09:04:35 +0200
Message-ID: <4971028.GXAFRqVoOG@jernej-laptop>
In-Reply-To: <20250409002036.12212-2-andre.przywara@arm.com>
References: <20250409002036.12212-1-andre.przywara@arm.com>
 <20250409002036.12212-2-andre.przywara@arm.com>
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

Dne sreda, 9. april 2025 ob 02:20:29 Srednjeevropski poletni =C4=8Das je An=
dre Przywara napisal(a):
> From: Samuel Holland <samuel@sholland.org>
>=20
> AXP PMICs have a pin which can either report the USB VBUS state, or
> driving a regulator that supplies USB VBUS. Add a regulator driver for
> controlling this pin. The selection between input and output is done via
> the x-powers,drive-vbus-en pin on the PMIC (parent) node.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Would it be less error prone to auto enable Kconfig option when compatible
AXP device is enabled? That way defconfigs could be smaller. Driver is pret=
ty
small anyway.

In any case:
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


