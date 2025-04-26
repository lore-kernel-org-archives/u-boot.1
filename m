Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4001C369CB
	for <u-boot@archiver.kernel.org>; Sat, 26 Apr 2025 17:45:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30FD081E0F;
	Sat, 26 Apr 2025 19:45:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ajTq49NZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F5EB81E14; Sat, 26 Apr 2025 19:45:00 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99251810EB
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 19:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e8be1bdb7bso5304724a12.0
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 10:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745689498; x=1746294298; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bbxITtHAcGXMiREQydyGZcJ4eVVA2TjDN/sMT0c7kME=;
 b=ajTq49NZ8ycp6weI33ka3dUdaGpkM8+uAxw61L+J7np5zB0KuBu5CUh3SfEmQdtxdZ
 X9E1RJ3JHTRJyK6JWsxNw6XROOR8t3+5dhAPyIUmsOs+KQrhA5eySaS04FUOp7jWUC2q
 wPvy3ZIvNbQcuIhPthtDdEp8vxj8juZHw2ZPwsTOvVtTD7U7NPvyizJFvLA7rU36pnNp
 +80QT/1Gwxqe8Kt9Q6Pej84M5xFBGK0y86sXUI4kq+CDrSob5IB1hhTy1JeqmZ0XbLHa
 ETqOVad5LeRUvx6lHYHG4HGhv96bJtt/Yvcb2RwYKffgkO70c5dESFgj9Tx0XO3mLVVu
 8j0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745689498; x=1746294298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bbxITtHAcGXMiREQydyGZcJ4eVVA2TjDN/sMT0c7kME=;
 b=IiYNLTrHGDAdH9ECggT878X61BJdq//jJaqVSArUoaLlbTExDdl/jRwkuNJkIxlV8T
 ABpLn42fSPlO0i921giFoB0NC9JUS2M20W/OLQqIs/zHWKLhs3wERK2xOcqAl4nCxpeK
 MbGsEk8oKaLYB3tmgLlawrmWmLyTVtViXt80l3R+evLFbFHdyLMz/H7u4NTshCjU3zFf
 wXIRFVOkh+M1Ex0lsVh2lTmUk4iRTvkS80dFhniWP8c2ou/kgLrZhKu2ShtkhoNgZe50
 lM9hAx//QqVhgrDluq9Gd4WJjkSFxGNZE9uBFyF3lSRRdqSGNGle96bqZQF0eQwStktG
 LGMg==
X-Gm-Message-State: AOJu0YzKMlnmBsyUeYMH7nZwReAAWLvOv4zpw99C9GVG7az1agGh7+Eu
 ObMqo4p+ym+gN84NjUJl6/DmZ1dv6MgFMOvGHtanTeN1yi+5XmNnFR1iZw==
X-Gm-Gg: ASbGncsQ3G/UCQYiDQD7mzutOb6CwQWmMDcaMXXpV7DJkMjuKS+Nwwm34V7yqQvQ4g6
 ZzpKiOqGUljCgIyl1NosN2Ewso0L/R+Iar38vmgRycw4kp0SsZGLInkkFwQ3417Wg2Lw8A6ergP
 Air7pOhzrmfkh3GLlVXk1ePnjII/efp4BI7qoivpxsWiM4HGznpC1IS7aSEVIG2QskbEcPrTrwY
 6wPBQS2xLVMj2uARHrHQE2r5lyy768gBb/Oqt6Oltcx3gyN5bDs5AWqsWqy4Xd1NzUVYH5VARd3
 6LBES9UgMQe8ToT8jWroaKeKJ9BKMufAQSWWRCR/QQpCllpX50OklojZj4Uj+A==
X-Google-Smtp-Source: AGHT+IEYoP+s6tFCFsfMdNf9KlXDsfO+MPR416gnEOqDraQJNtj/S0B9IjLspGmK/DThc8WDCo1SSA==
X-Received: by 2002:a05:6402:3513:b0:5ed:994c:7e75 with SMTP id
 4fb4d7f45d1cf-5f72352cedamr4762738a12.24.1745689497686; 
 Sat, 26 Apr 2025 10:44:57 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f70354638bsm2915649a12.63.2025.04.26.10.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Apr 2025 10:44:57 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] sunxi: enable MMU_PGPROT proper page table protection
Date: Sat, 26 Apr 2025 19:44:55 +0200
Message-ID: <5003571.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20250426120913.23314-1-andre.przywara@arm.com>
References: <20250426120913.23314-1-andre.przywara@arm.com>
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

Dne sobota, 26. april 2025 ob 14:09:13 Srednjeevropski poletni =C4=8Das je =
Andre Przywara napisal(a):
> Select the new MMU_PGPROT Kconfig symbol for all Allwinner board builds,
> to use a write-protected .rodata, non-executable .data and .rodata
> sections, and non-writable .text sections.
>=20
> This might trigger runtime exceptions in misbehaving drivers, which
> should then be fixed.
> Please report on the list or on IRC if bisecting ends at this patch.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
> Hi,
>=20
> I am planning on merging this ASAP, to get some exposure and use the time
> until the release for wider testing. If worst comes to the worst, we can
> revert it still before July.
>=20
> Cheers,
> Andre
>=20
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 99750072e55..f22d347d5ad 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1192,6 +1192,7 @@ config ARCH_SUNXI
>  	select DM_KEYBOARD
>  	select DM_SERIAL
>  	select DM_PMIC
> +	select MMU_PGPROT if ARM64
>  	select OF_BOARD_SETUP
>  	select OF_CONTROL
>  	select PINCTRL
>=20




