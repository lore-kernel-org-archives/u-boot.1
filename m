Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259CBD116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 19:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A090683D3D;
	Mon,  1 Dec 2025 20:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LTfjE4xJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02F5F83D4A; Mon,  1 Dec 2025 20:02:22 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F10AB83CF3
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 20:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5945510fd7aso3718775e87.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 11:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764615739; x=1765220539; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H1EL9b/oikrV4vLk+QRhH09ydEkLwKzIxSkRCUbdFqc=;
 b=LTfjE4xJp7XKTUSYAjZMLlPK7OUn22Df/brI/IOb1j5/9yg6ODEhOPP79/vjdwUEGu
 gl2eOcp0XWBo2gOM4egrmMwjPkD+eq7zu25WAHCfuvNlQvZ+j93/IN219LohiK4hulEZ
 kTmPhbYlRb/pezHz510WxCj8z0EaTL71ZaRZWqjmaAeQOagtcDVoILNuxJ1cXJn2ch43
 xiXE8HGpQn9hwX4vdpknvsWW0TQGc0ktAA4tf6X3VA3Vf6iMQmYCvKjSLyGM0WbtONWS
 LXNdKChefqW+NCJ1jslp5wyfL+3+aFH6LQNpRlRuE5Zi83FKb0lrnwx4tz+nPNhSYVWK
 yq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764615739; x=1765220539;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H1EL9b/oikrV4vLk+QRhH09ydEkLwKzIxSkRCUbdFqc=;
 b=Bg/toFs3meJfbIcS3KWtUGu9Uj3YsrQ1yrH8S5bXenXopgLVgsRV001+WryWRqbslH
 CLPUlk6AT+SXAW9smnu3OyW0PhSuQKwSb6zy9mPAg3Te/AQwSMuyMksS0DcZE74Ia6OW
 NJk1hwUO2JypHGdpvGD0vXBFB0ZreTjIOj3K7KWx8hlLtgt9iy1r5Y4H7cT6rYEQrUmq
 T+UzBPh6JuY3EjzcfCubrovBvKzWZi7ego+rE4CsgQ6jqbR9GRab5RKYz6e/8a6KTpRN
 IPGX72XfXG91EoBNo7n9lwaA4ENqspys+IcyrjUYymsCX2vHLTXYBDS3vErx7pDADmga
 qRfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzFBoiIodJ/U33R47v53Mny9zBRmjwmas6Gm/LAxYECj1rWMUB+pIyyDtPv4+xk2wxBDcpEGo=@lists.denx.de
X-Gm-Message-State: AOJu0Yw60NcsCMBCgfFFqJZkbHPDQwBKhHqSIvrv6mW/BLmCJ6Ac3JWV
 e0S0SwcTwaPuVFaqZecZspx9PEh5HoWLJ1761eONOsXtT5qboO7tT2phN4JGcKNnRG7inPq40DJ
 Et1c+1+MPJbE0Nd+XjcoOkQN4/M/rMX4=
X-Gm-Gg: ASbGncttgDtT9MUFzC6j0n3NG8x6vpaIjUczf6rrgNZ5p36ZlJtCWewHI1cmmyzERTq
 NfMi16B0xBu/YZ9f+XIEtcOMXT+XqpGuFNKWxPoibl+ChCpQ/rkPyH9FXkI32946E+6YeVy/h7E
 jF2pqWlMYGAibloZN3u5aG4aou5RdkxXTy06Is9HRAzPgTcxNWrJ2xt1W1aX2AnW8VVENG9/+CE
 R6eUBAyKRHX/WRsHnCwZs7fW0sILktqWERzBOgy1xfJkq2yBK4bjuiT8JbIJsg2xbkgdw2sYabH
 HdGv9qaHqaSU1WRU/FknVugqvA==
X-Google-Smtp-Source: AGHT+IHOCvOYUf/811Eg8bFvuQwwBOaOlGh4R+GHUjeNzfYRjwj2emK8nFP4PkanUP3sl1f78ADkNr7grQPto3b/OH8=
X-Received: by 2002:a05:6512:3e15:b0:595:81e3:1f97 with SMTP id
 2adb3069b0e04-596b5298caamr9009771e87.46.1764615738863; Mon, 01 Dec 2025
 11:02:18 -0800 (PST)
MIME-Version: 1.0
References: <20251127-imx91_frdm-v1-0-8f42646d89ad@nxp.com>
 <20251127-imx91_frdm-v1-2-8f42646d89ad@nxp.com>
In-Reply-To: <20251127-imx91_frdm-v1-2-8f42646d89ad@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 1 Dec 2025 16:02:07 -0300
X-Gm-Features: AWmQ_bmjtDSVtDA7m-o1yBJTgfztcHlBcCpSjpPO1abELUy7lLb3s75aApxhOec
Message-ID: <CAOMZO5Dxi52OzFEBWU1hnn2HfHc9EZcgmwW=p-N-+Oy+JHQBHg@mail.gmail.com>
Subject: Re: [PATCH 2/2] imx: Support i.MX91 11x11 FRDM board
To: Joseph Guo <qijian.guo@nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Adam Ford <aford173@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Nov 27, 2025 at 6:55=E2=80=AFAM Joseph Guo <qijian.guo@nxp.com> wro=
te:

> +config TARGET_IMX91_11X11_FRDM
> +       bool "imx91_11x11_frdm"
> +       select OF_BOARD_FIXUP
> +       select IMX91
> +       imply BOOTSTD_FULL
> +       imply BOOTSTD_BOOTCOMMAND

What is the plan to convert this board to OF_UPSTREAM?

Has the DTS already been submitted upstream? Please include the lore
link of the submission.

> +config IMX91_FRDM_LPDDR4
> +       bool "Using LPDDR4 Timing and PMIC voltage"
> +       default y
> +       select IMX9_LPDDR4X
> +       help
> +         Select the LPDDR4 timing and 1.1V VDDQ

There is no need for this IMX91_FRDM_LPDDR4 symbol. Please drop it.

It would make sense if there was a DDR4 version too.

> +F:     configs/imx91_11x11_frdm_defconfig
> +F:     configs/imx91_11x11_frdm_inline_ecc_defconfig

Why do we need two defconfigs for this board?

What are the pros and cons of using one versus the other?

Can't we simply use a single one?

If you really need both, then please avoid duplication by adding
including a common include to both.
