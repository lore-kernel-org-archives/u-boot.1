Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B99C369D1
	for <u-boot@archiver.kernel.org>; Sun, 27 Apr 2025 23:49:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 918DF80F9C;
	Mon, 28 Apr 2025 01:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GyKcGT0P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEEDD80FDA; Mon, 28 Apr 2025 01:48:58 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A597680BAD
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 01:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-54e816aeca6so3990188e87.2
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 16:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745797736; x=1746402536; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hs2rIsTJgBx/GRItHk4aWbdQOCQA9fRewwp+D7mat4I=;
 b=GyKcGT0PdAWjUFHWMYtO2kYuZAU+vo0tvN5NKyxGbUXFUqcgNqFGXF8sLKNigmKUB7
 8w6aj4aMR15ynOATn5q5KDK/+/y02ubxsvFHC+xWeD4kMJaSlDca5fRgV2yGwpplsHAa
 6vyj/wVFmMDkKrbd0pqG6zMTz47yAxobaeV0FAPXv9DqyLsiMavDjqoNv+zmaY2h3LPQ
 0bEX2Xt0VDwhjWA6BfJM05AmcuVHwSRFvFHmaIao1HL1A7kMbtBokssGGqsJYBj6MTJJ
 /lomkdCQDu+fZIulnN3KqbM1ONKDSjdJfXtBw/dxIrXbSbXyzccOB1dGtkguZpl6RS4t
 QTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745797736; x=1746402536;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hs2rIsTJgBx/GRItHk4aWbdQOCQA9fRewwp+D7mat4I=;
 b=h/9uRRJAnk7xna0OSMMupKpbuhsgB8E9pallVFt96hDWXsXZ3FZAkC1ecSCR44oqrt
 1/1pzCYsWKG89TaxvYJXT4yl1QK123xwiJr8EV3GNSFllwPm5Eo3jy4YfNQ33mjMnmRv
 nXbhp8CJklXhCZa3d70WjpV3QBVZiisieya+mIQZPUdnUScff0UVbAbQ+Bkp7YT2JMxo
 CXvnP7DMrVloWjM7dKvvZ4VVySzo3PXz4cvlJjN2Ga+CKw6nKFfi8z2CS5vO9KoiNp5g
 UXZyAXVRLs9/PAEh4mA6bFtaZEN/WS4NaF2kGap/oxueCl9Z6+nE4sBteY8Z5aiRmGMJ
 7mwQ==
X-Gm-Message-State: AOJu0YzBuLHiz2b4XWq7eFhB85zT1PUQFbBXaOumU8DlnWnhN8ymFg/e
 CzZZLN/J+3GUZTCfnF8RI8FTgKvl5Uye7OBplC91onFgC4WBCUbTT036kOC/cPJx4Px/dovg6cO
 vVPJtlsTYMgQ5z11GJHsRT7IJ60w=
X-Gm-Gg: ASbGnct4ey5LFMXipD9JvaZJLk9TEwEvYMQOM5buKjzy0Zp13dJ9RUJ3AOSKTiu3agI
 Ov5UPLUuw+OrnZPP58sS7CYsQNmphKFemhwAHxpHesNNi48jKW7v8oJRwjHT9U2KeBMnJksvd+u
 lUgvlXON7DOvd/gYA64BDZHKBhtNmjLwD1TWvLu9hWcJ6CpUAxf4m0eg==
X-Google-Smtp-Source: AGHT+IGG6p0N2ePTMgam0Fe3xd80QI7u2sjLGVYvtq4JjdJZOeRX3a9zEl93OihtLs9UnGia6gxGgugsOVq5/KurgH4=
X-Received: by 2002:a05:6512:3e0c:b0:549:8ebe:b3c8 with SMTP id
 2adb3069b0e04-54e8cbcd135mr3100557e87.11.1745797735590; Sun, 27 Apr 2025
 16:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250427154002.146276-1-marex@denx.de>
In-Reply-To: <20250427154002.146276-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 27 Apr 2025 20:48:44 -0300
X-Gm-Features: ATxdqUFZWTlIGSOO8C9VCkQumGa17Se3JJ6IyVZkud2W7grPo2ciYoxDiTXnguc
Message-ID: <CAOMZO5DCEBjoVH2NCoPhuUC-M_Z_UagUX1MH0BdgC5vgkEAtug@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: Pass CCM udevice into clk_register_composite()
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Adam Ford <aford173@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, 
 Sean Anderson <seanga2@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Tom Rini <trini@konsulko.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
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

Hi Marek,

On Sun, Apr 27, 2025 at 12:40=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Pass the clock controller udevice into clk_register_composite(),
> so it can be passed further to any registered composite clocks
> and used for look up of parent clock referenced in DT "clocks"
> and "clock-names" properties by phandle and name pair.
>
> Use the clock controller udevice in imx8m_clk_mux_set_parent()
> to perform accurate look up of parent clock referenced in the
> CCM driver by name. If the clock name that is being looked up
> matches one of the names listed in the clock controller DT node
> "clock-names" array property, then the offset of the name is
> looked up in the "clocks" DT property and the phandle at that
> offset is resolved to the parent clock udevice. The test to
> determine whether a particular driver instance registered with
> clock uclass matches the parent clock is done by comparing the
> OF nodes of the clock registered with clock uclass and parent
> clock resolved from the phandle.
>
> Example:
>
> drivers/clk/imx/clk-imx8mm.c:
> static const char * const imx8mm_a53_sels[] =3D {"osc_24m", "arm_pll_out"=
, ...
>                                       _____________|
> arch/arm/dts/imx8mm.dtsi:            |
> clk: clock-controller@30380000 {     v
>         clock-names =3D "osc_32k", "osc_24m", ...
>                                    |
>                                    v
>         clocks =3D <&osc_32k>, <&osc_24m>, ...
> };          _______________________|
> ...        |
> / {        v
>         osc_24m: clock-osc-24m {
>                 compatible =3D "fixed-clock";
> ...
> };
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Adam Ford <aford173@gmail.com>

Thanks for the fix.

Reported-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Tested-by: Fabio Estevam <festevam@gmail.com>
Tested-by: Adam Ford <aford173@gmail.com> # imx8mp-beacon
