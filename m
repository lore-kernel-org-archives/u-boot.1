Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18C1C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 07:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2808F82A5C;
	Thu, 10 Apr 2025 09:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ARi7cUet";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8D97831B4; Thu, 10 Apr 2025 09:17:32 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D098B8209C
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 09:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so3809705e9.1
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 00:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744269450; x=1744874250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vj4dRFeIPg69IJI563j/AOt0mSXQ1SnlTmdMvO+wPSM=;
 b=ARi7cUetGqDYpDSk1s1cP+aDBJUtKYypTYDB0288UQmWP1nDWsGJghjV5dyPMzXvpq
 jUYvpSAAzrTRfkJEZsTBWOps//aNV6tjp3rqPJ+G2vz8Bjf1uuLrZ2RcwrSeuEPzOtWi
 t0HyQWkcosZ+80JByptPI17k6SwY5v8WG6CF7Y6+mZJKYF5rVSrZ73OrQxI2eCDfcU5a
 OfHnIuDONBYHE6Bz6qp7saalRWXbxB/oE+wqX5PTZ8jTQ9DmAOmBHeNoz2yfTnC8A4vg
 wmqphxXHObnnPNCv2m0k/LZVQxfioxeHr2n9mvrRHP+gJXIZXBDDsE9wPP6EDJ+gCACw
 RkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744269450; x=1744874250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vj4dRFeIPg69IJI563j/AOt0mSXQ1SnlTmdMvO+wPSM=;
 b=OlyKDiA6GxoJafzmeS0xKiciyH1nogG6kYBj028ezPq8ipq8opGpKnDCGpbrBExJKh
 0hjuQ2zHxbgRczouFoKsGqGCBTGBYl/ocu+Ox5SY2OtNMYGCI3vltAkFvvMXS5XGCknO
 DUOG54ktsUGbk+dw0PHztumTk4/hWFfe3ko53Al+RZnRsQM5ZZdCglsrii7oHwnNIFpo
 VW3/MrdbTNGChus2OKmXgDungkqMKFkgn6UAO5uJER4POegHx7mTMeO0grRSu6OcdPii
 I4N0P8l6x6z/Vv67WIoQQN9nfjfDmeCjEmyZ9Y0cJMPNdIY3RDQ5ygGRbOZmEv2rkDdr
 tBjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiyTn4Zmyv5UFgJzxwY8xyC77fi7yAKw/yybBLNW1Fh9e6vIRr9V+Eo3wSuGfkZT5iYEYPprA=@lists.denx.de
X-Gm-Message-State: AOJu0YzWRR7Aik4zyKyg21teo0EOQX6dBT051OxkB+D9ZD89UW77rRtw
 axVnbs9q1ngQsFUAslF19eOPwWoj059ZnmA/SWH+zoIgORqbgG6l
X-Gm-Gg: ASbGncsgE2YGvmiUawwy42yAXfnYDu/bd4g10idGtHszn9XOjEYjJAm+np/8EFE5jCx
 Tk5ixANXop+BmNxfcYV/ahXSh8dTNhTeJQTtyhs2sF3IPUv45YPYhycRvK5NOMB7czlz8QjlXB7
 OKhNeGpYj+XeLywhGamsWIiLH/kgRtRa1wLN3P18q8AFmjffUNNNRlRqRipkxBAxAS6cMsjqlwQ
 b8gNwv/mhsDjBrA0iUxTqDWP+POEnhsqV4GUoo0lTh0r4rpZvZFbr5uWexziOymiDd4FnPER8/u
 PcS5kVvqbDx8K1aCgCIWfON6sjliZ/uHVuiWlqTOC+rw07jiYMDoK6XJedinTeJQ06L0DFpbekY
 es8XqzAldIq1uba8q
X-Google-Smtp-Source: AGHT+IFJZFrovX0zOi8eNh8UCyt+flT0nIpcr3x+ML9B9tU0pU/GcNFYha0+y0JFspALUbRQw8rnsA==
X-Received: by 2002:a5d:5846:0:b0:391:29f:4f87 with SMTP id
 ffacd0b85a97d-39d8fda76d9mr862373f8f.49.1744269450220; 
 Thu, 10 Apr 2025 00:17:30 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d893611fbsm3828556f8f.20.2025.04.10.00.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 00:17:29 -0700 (PDT)
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
Subject: Re: [PATCH v2 5/8] gpio: axp: Remove virtual VBUS enable GPIO
Date: Thu, 10 Apr 2025 09:17:26 +0200
Message-ID: <10637391.nUPlyArG6x@jernej-laptop>
In-Reply-To: <20250409002036.12212-6-andre.przywara@arm.com>
References: <20250409002036.12212-1-andre.przywara@arm.com>
 <20250409002036.12212-6-andre.przywara@arm.com>
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

Dne sreda, 9. april 2025 ob 02:20:33 Srednjeevropski poletni =C4=8Das je An=
dre Przywara napisal(a):
> From: Samuel Holland <samuel@sholland.org>
>=20
> Now that this functionality is modeled using the device tree and
> regulator uclass, the named GPIO is not referenced anywhere. Remove
> it, along with the rest of the support for AXP virtual GPIOs.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


