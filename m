Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC72FC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 07:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D75E839A8;
	Thu, 10 Apr 2025 09:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a2M/baJ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D80D2839A9; Thu, 10 Apr 2025 09:12:13 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0F2D8394F
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 09:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso5389675e9.3
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 00:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744269131; x=1744873931; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Clts/wYS0ZRWVezUHusTmN2QW1kP2sDx1vh3amQGmYI=;
 b=a2M/baJ3L5tmZJwza8Y8Ool9JIyw1rI/mufnNN6r5KSavkJAuWH3uxphs/pU4lL5/A
 fHBVDGvJ6JrcKsEuUtAW4p7fvFwCaI3wjebuI9CybWzty5r31sxTIN96FJ3MWpbRZuv4
 lkUyYLplQGZZGf87TBYfhdn/x/7HAhxLMvQdZGYYP84CLMTbFC5NED5ZPOkhKXRrfAvE
 p0YumQQIWxxQHcJQQ9e84ylTby7AVHSKxmnWN0gfZcS8PZVMNDPG0swoTtXgjn+rglWZ
 ZcohZu7DVD17VaTS4+PkvXS5glo+imTW6TVYJteQ2WW+yU3F6deddFGE2y/U+iSa2flg
 G3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744269131; x=1744873931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Clts/wYS0ZRWVezUHusTmN2QW1kP2sDx1vh3amQGmYI=;
 b=QeIkDfWaK6XfyaUTCcKPzQb/btuvk7AlgxafD8SvprrWQMWN4CbsbHzcFmggU7MUbw
 ZL4m2g4BfPKOlwY4nzfy70VAWPApjCSwMvFfe8cIMdRkb4XU28J2yefokDeg0hC3DxWi
 NzBwmo9dx6R2/Mhw2F1esXv44XUBR5ieqjpdR82umKyfeKEH1Rd8KGOM5j6FPvI3ZDGy
 7UnQiZr83YeGdb2D4R+rm0cMG0HLUL30qplMyVcDf/tdBykBprZes7TWhzdrN1hgWpKr
 YZdokJnxxOQK++yIqjdFywxuxAIiAlsHsFAseuZB/jaHlZ2brdquXaD2qMj56C5PvAlg
 F0aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrfKbseQHaaCmF9TDm/A9t8J59DevstHV/FrNBfAcX9K0ZpaWkatuW1ljHqqJK59s9l2K8SDw=@lists.denx.de
X-Gm-Message-State: AOJu0YxTk3S43t1VnX7GukOB7ubR5TojmIAe6N5jZ6WGFTFMVItm4p5L
 r6FRtVo6Dp9Je/4KpCVhZ3lgoxhbUyxe2xLrEtPoDTgxaBX9eyCx
X-Gm-Gg: ASbGncvxdyyV3bMdLP/nQXVkIC9bSWArANbkHQRSCAtn+ODuFhwSsqfRA5ZzldUY0GO
 DU/lpFA9IyFsjzPAjFicWmLfHOZxJ+zjLhnSN/ZT7VmA6SENlBUJP8UvMhYnKFejH+aIsElmFV5
 bTMKZ51iLYZlxd/UnSjNvyrpE88EK+F0C8/Q0PPYvWngKpTV8Wh53wksqYlY6Mb2M3lQ3XeAE7c
 MhQycmfmLQ06nhYuEykI7FLCsp1lqfNrDI9+hfHzJsgY1YuHaGheM+aFlfz9d2u6ZLsytxE46RA
 LgYsn35SBKU5uxRHTfqfH7UHccaJyqRP56qSYIhNgLZ1Ta/s2QdKg93ce5O75IWWlKMcg79rtpW
 0v9PBgYbc/mLDPIFc
X-Google-Smtp-Source: AGHT+IHEX9C9BG244eF2d9mgLMuGw0QUZWfe3dHedU1PfZIWjGiY7BHoncQgqzNfC1LnCJ7AMUfL4Q==
X-Received: by 2002:a05:600c:458b:b0:43c:fad6:fa5a with SMTP id
 5b1f17b1804b1-43f2ff9bfb0mr8081525e9.24.1744269131156; 
 Thu, 10 Apr 2025 00:12:11 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f207c8fb4sm44426355e9.35.2025.04.10.00.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 00:12:10 -0700 (PDT)
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
Subject: Re: [PATCH v2 4/8] sunxi: Remove obsolete USBx_VBUS_PIN Kconfig
 symbols
Date: Thu, 10 Apr 2025 09:12:07 +0200
Message-ID: <3349527.44csPzL39Z@jernej-laptop>
In-Reply-To: <20250409002036.12212-5-andre.przywara@arm.com>
References: <20250409002036.12212-1-andre.przywara@arm.com>
 <20250409002036.12212-5-andre.przywara@arm.com>
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

Dne sreda, 9. april 2025 ob 02:20:32 Srednjeevropski poletni =C4=8Das je An=
dre Przywara napisal(a):
> From: Samuel Holland <samuel@sholland.org>
>=20
> Now that the USB PHY driver uses the device tree to get VBUS supply
> regulators, these Kconfig symbols are unused. Remove them.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


