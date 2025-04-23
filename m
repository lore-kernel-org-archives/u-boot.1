Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF3FC369D1
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 14:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B732A82075;
	Wed, 23 Apr 2025 16:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ri1eFV0h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BA5E80F03; Wed, 23 Apr 2025 10:29:30 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D07E80BA8
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 10:29:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-54d42884842so7828187e87.2
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 01:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745396967; x=1746001767; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=86Tp9HDGpQ6Qip75ZShju/ejL1p8J736aXBEEMWZSdY=;
 b=Ri1eFV0hYzRi8nhR9wP9XKXO3XmJFxsgoPzY9DttqfLOglVpzWxnJa4HmzJGlrJCga
 99rbzzHFNeq8qEWrYtYlctHz1UiDZAEOrT4QuGBFffSrhXTM38hO+dXdpxyqE/IUfpbe
 kpIR+0Z7aDaEKW0OqInCUFfdX+pNz+1THKcQSAQvfWQJ6/yMEUC7hLGvv7yU2aLFW0LL
 AGYFQ7lyxsf74hZY5AhOfcSLv6cGWidRneyFCYryKQGlahxFqUHVSLKhqr7E/nbySR6z
 SW1J4w/7K2+WEYslBveMOZiOF1dG48Jx3aAiQdY6P9YeSjvYe7O/8WHnj1tc03/LO/Yv
 q7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745396967; x=1746001767;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=86Tp9HDGpQ6Qip75ZShju/ejL1p8J736aXBEEMWZSdY=;
 b=PreBsZn1KZWDTHSVx0pI2QZNvhCFI0FJ1nLAYS8/aXJpiZ1ipyy8ndv/PQY7sg2YXI
 nDtFLCTRDW4wuEfdd+luCg7pwtmCPA8JapmI/CM5IdF01g8PE6SMaybq5yfk9kiLQUOF
 05azOyX9W1qRRoUpnTvCQ1+KRNZ/S4ePNBNtFIM6kd9e8XOa2OqruEICtxj82IqyNapa
 i5+4Pa/Cpiuu7uo+8sil+p+jfEkzoAB2+3I31d/1GkbOyYr0JwZQuywMDNbtolNvAUUN
 Hofjyc5joyTpi1CvzVdQ5ozu822nnH1a7dYUFPmGbmdMecKc48uUpibgk9DgkDgMSV0/
 0maA==
X-Gm-Message-State: AOJu0YzvNDaM2W416hHxCj6zo4iJirxfQnKAif6bsbNs0vmwLYRmuRmM
 QIpra63QoYyXnfUtY4q8/chXqvZuRv6KhMflAyNvY60RFZkWOMG548PGZElrmngjAJF+YJIbiFu
 PKrUdlUuf/0dn0mC496bL16YKxCaciNQr7gQmkw==
X-Gm-Gg: ASbGncuGeyqVcBKi53GIf9Y3hwNKPUQ8uFDfYZUbmeExlPxv+ki/Jqd2zAoLPB5mJN+
 EZ1QZpNhJ2fry4H0fMaiajm4Kz43cOsonFO4Jkb4PvnZsFP3HqM6uCOuCWplSfMsOM7viU+1yFC
 7ZC800j0opgCDiLs7d85+O/Q==
X-Google-Smtp-Source: AGHT+IHWkooQn8ZHHQpbjQ5KfSGh14xpiPKiV9QQfwKQBUboGW/7rhBWyE/COaowaCGv/y/DELyg6+iknL8+B82XQbU=
X-Received: by 2002:a05:6512:4022:b0:549:6759:3982 with SMTP id
 2adb3069b0e04-54d6e658f33mr5624841e87.37.1745396967369; Wed, 23 Apr 2025
 01:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250422131229.415020-1-patrice.chotard@foss.st.com>
In-Reply-To: <20250422131229.415020-1-patrice.chotard@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 Apr 2025 10:29:16 +0200
X-Gm-Features: ATxdqUGL3n04T9zIzfkeS3zXpw2W5UyPXwQNVDlJl4EYzFfqqUxDugUTjuR1DHU
Message-ID: <CACRpkdZY946nqABY+4hdWJvK8gJrs-ra_iVYp-uVnMBUQvSm3A@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Enable OF_UPSTREAM for STM32 and STi platforms
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>, 
 Cheick Traore <cheick.traore@foss.st.com>, 
 Christophe Roullier <christophe.roullier@st.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dillon Min <dillon.minfei@gmail.com>, 
 Fabio Estevam <festevam@denx.de>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kamil Lulko <kamil.lulko@gmail.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Lionel Debieve <lionel.debieve@foss.st.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Matteo Lisi <matteo.lisi@engicam.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Prasad Kummari <prasad.kummari@amd.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 23 Apr 2025 16:25:16 +0200
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

On Tue, Apr 22, 2025 at 3:16=E2=80=AFPM Patrice Chotard
<patrice.chotard@foss.st.com> wrote:

> This series is enabling OF_UPSTREAM flag for STM32 MCU's, MPU's and
> STi platforms.
> For some boards, some defconfig and DT update are needed to keep the
> same functional level.
>
> The major impact concerns MPU's platform with introduction of STM32
> System Bus.

Excellent work as always Patrice,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
