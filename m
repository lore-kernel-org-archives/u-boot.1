Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBCBC369A2
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 07:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D30583990;
	Thu, 10 Apr 2025 09:08:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZzrbcJAd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF47B83993; Thu, 10 Apr 2025 09:08:11 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A47A88394F
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 09:08:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso190258f8f.2
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 00:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744268889; x=1744873689; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptTZDuqe+Ue6zawOowkWrw2iEKl9O/8eehXqOQSRR/k=;
 b=ZzrbcJAdfEyHgL7CsC1J4eWvRKR7m5eugehh9Ry0vzXPJ6S9hmX3Pe5/h/k/xGVOjD
 zMErf184q9RhTnribCUBSTrg/55PScOeGUHG4kzfWqmQKiFDjRHuSVbOBYUkW41i4rar
 OfOVSgyEOIjvcp2Qg/5FRe1pedcOaJ1rH4Lbz6KV4ROgtN67OMh5wsQiNFkBA8DEz0Tg
 crlpPYHVRo3NnjwGcbxl3tuaO4jZN6J/txjGKK9w89dCspH48nT4cqtw0ntgVyy+LrML
 dSJVTc93kG5WvNIKy32Aodn1qZyg2WXX4y1o/CHXMhGZCVHHVkOldZ6OIegmL9cHRcud
 Qf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744268889; x=1744873689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ptTZDuqe+Ue6zawOowkWrw2iEKl9O/8eehXqOQSRR/k=;
 b=WRyZte55Mt1lPLI4Mws39SPGTj7orRUyeiH9/4N9htlnAEouR2TXZv/PEU2RaaIKyY
 KBwnZ7YVvQ52/ta+/ZhVyyHzjX/CnfKK3kkXsmvKcr9lNSVT5uIX2uDRJor75MNdsqXW
 YIpI/WsGsaq7Is87kRbPdVhnczr0cb50p3Ek3WmfiOnFH9cxVhWDyBnUeg4fObBaUO4n
 51MXItdMhVqu2kcryajdr0HCKUsq1Yh7g8BBpPCkdC7yNnMLfGXWjcj3AqwJQJOcimcr
 IlBUqr5gsAR4vd5nmNKLpxuxkbptqYII8lixJyM+B9xaf3K66oxAVRhZJaQfO+lsden7
 g+XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhjQsCN/5U0DCgQUgwFtX1OZ2V7SVDIv8HUyVQtXMlw0szqBISTWFwtN2nOdbjQCSbzCCQOSo=@lists.denx.de
X-Gm-Message-State: AOJu0Yzg/c5UTO9ugSnjTSJtrXp5BE7xNLo7rgCbm0X7TAmCBhQ8xIT2
 AR3si7Gpv5OblnHwLJFToj8huoqqrtMFLrhfgG1m9B8v3EL+4WFp
X-Gm-Gg: ASbGnct6DnBWmRQs+DqurdghXxPwyz8HOnp8giim0QpF9edvDkAXy8hfjAPwVq/9QHD
 lPYZ+9Atg7ONzGzL2AG5/PNNeyoPiewAKNPYbiFW6cUZxViogQEBkB00SzuPhPsYIf55TSOaGmv
 t/nN7+siCI76bhg8rnFTxBDQxPlTX7u07bH5IUGdvAV8i/ZC1MGeAVjpnga8OUAmTpJmrSDCPPY
 ycsri0glRs8g7Xa51AF3xkR+Iz5zogc+NcLzdixLptjaCPLODxvyjFxYiBQ7eLsxJCCW1XtSLoh
 rkZwKtdYUCfenmjK3inN6W+qXGntjSBFzgACrI6nIXZ2R9GOZvzM4BopHnM/2cTiDSbk7gd4cpJ
 OC4RVtMurAHFG6SLt
X-Google-Smtp-Source: AGHT+IF69rFKiLAue57LGW6Wvgn5FhfEnmst8cQIjw2EQ/sFrv9dpfPc7N8s1M8wiVU2AsItROJUcg==
X-Received: by 2002:a05:6000:40c7:b0:399:7f44:5c74 with SMTP id
 ffacd0b85a97d-39d8f4fabcamr1109573f8f.55.1744268889013; 
 Thu, 10 Apr 2025 00:08:09 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d893773b6sm3846928f8f.27.2025.04.10.00.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 00:08:08 -0700 (PDT)
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
Subject: Re: [PATCH v2 2/8] sunxi: Enable PMIC drivevbus regulator support for
 USB supplies
Date: Thu, 10 Apr 2025 09:08:06 +0200
Message-ID: <2217953.irdbgypaU6@jernej-laptop>
In-Reply-To: <20250409002036.12212-3-andre.przywara@arm.com>
References: <20250409002036.12212-1-andre.przywara@arm.com>
 <20250409002036.12212-3-andre.przywara@arm.com>
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

Dne sreda, 9. april 2025 ob 02:20:30 Srednjeevropski poletni =C4=8Das je An=
dre Przywara napisal(a):
> From: Samuel Holland <samuel@sholland.org>
>=20
> On many boards, the USB ports are powered by the PMIC's "drivevbus"
> regulator. In preparation for switching the USB PHY driver to use the
> regulator uclass instead of a virtual GPIO pin, ensure these boards
> have AXP PMIC regulator support enabled.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>


Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


