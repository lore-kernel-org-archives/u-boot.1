Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC0FC02187
	for <u-boot@archiver.kernel.org>; Sun, 19 Jan 2025 19:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B912E800CF;
	Sun, 19 Jan 2025 20:55:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LeQS5FEi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF6AF801CF; Sun, 19 Jan 2025 20:55:27 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8842F80085
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 20:55:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43626213fffso29429955e9.1
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 11:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737316525; x=1737921325; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mjgKM0tnNEx6uy+SqNo6Fx3FuTcVLLCPMN4YCTYGGd0=;
 b=LeQS5FEi90fRlwlkVV9PY7nZOkLRup9lYZnDJuFxT3NWBSU+fZ5t61JyS4LJpo0Jtb
 r+V94cN0tZwKJXPMUFrtfp1oLFcMlh7OhHUCHA41Vt+40J1n9TmGF/n915fYEBc1J1z5
 0qr1WzTWwCLCfrm4LMR9D3DH1g4APFncSMz7HHiy9fMRce0e2f+lLzxqpqAt+Tth7+Nl
 SRpWW75X2oy3Eq+oc2NIuJGE7ap8QgTTCNbWmUbqzJcPo5NUmbB24dLCRq9cW2dbsome
 Rrmh+aCVbGKbjuGdQKtwVNEU0CtcAjUaR0oj9SL/LfCR0GMhNYt3nKFiRO4BwqB+GwLb
 Lf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737316525; x=1737921325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mjgKM0tnNEx6uy+SqNo6Fx3FuTcVLLCPMN4YCTYGGd0=;
 b=wTfWHU4tbU88SAYfKhnnD0hy8EXfUYBDNGgLXXsv0gEIzd6hwqCpBeViEcQiqly8HM
 tf5hPDAHcguDyV4ZIz5MH4p7ea8WsO+PgmyLDwcWg42cIgz5woNgA3YY5U/n4OJnr1cV
 lmSVTF+fyg+2+J4Lqg4TY+RpC+4pe44G3c7G7EVIfOtGMK2/DpfRAYm7fKdJfsbvYjk6
 U4mLXyTjc2D1xjPeZGaYd0Lrt4VnP6PuREr2Fbeca9AKCesOEc+kjCTX5UU3U/IAjc9q
 RZn2Ypnf05hu3fsxBnOuVzyanDI4bU0VBMEQ/3pNWnGshn+o1OCnGEGXVCywu4t9QF0F
 Uvhg==
X-Gm-Message-State: AOJu0YxTDRImXHq8oypXZGW5hnyRff/kdVraEpES+XXS4fTM+3UBwYhr
 mfbm7aDFfw2J5DV4fBWpy+gcUIkoJcI6Qlbg8dPEZ1oTJO8OkQiQ6gEadQ==
X-Gm-Gg: ASbGncv2/lN8NeVg0cHrutjKGUAxrNefh3/E4HCPXpQqtSP6RqkcwUxTY63fJ+6gQ4b
 saMXx4PJflPHpLZaKj0EraVmAmoRU97ErK0yEBzw2LmBl9IthuPYTHyTuHYWryy/MHpg6cKr+uN
 lj51STKqr94Xs6AHUd6t936N6vta6kLNu8AQcN/9xqQpPdJH8KLs7ZkfN0V4HYU+R2/JJfNH1D0
 DTjmzkcCXU/+oCYA9EAlpmG1AlnbWvuKF63oxUwk3kK3AfazRYIIFfLLLvpcHFwrV/Iy3+uoZQR
 Vq+v5SH3ERKpxqYKdffDK4EyZ2jdSCI7p+vg7fphttw1Vw==
X-Google-Smtp-Source: AGHT+IEJqOW54W1lRxz+JIVbZP7UU3BMUnKuWPAYJ+8VVFyg2CQZQN7BF1ufsYBuU6gKRviNXE5zrA==
X-Received: by 2002:a05:600c:cc8:b0:434:fe3c:c662 with SMTP id
 5b1f17b1804b1-438918f6027mr80369755e9.12.1737316524627; 
 Sun, 19 Jan 2025 11:55:24 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c16610a0sm113827255e9.1.2025.01.19.11.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jan 2025 11:55:24 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, linux-sunxi@lists.linux.dev,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 0/3] sunxi: switch three SoC families to OF_UPSTREAM
Date: Sun, 19 Jan 2025 20:55:23 +0100
Message-ID: <4979410.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20250119164157.23648-1-andre.przywara@arm.com>
References: <20250119164157.23648-1-andre.przywara@arm.com>
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

Dne nedelja, 19. januar 2025 ob 17:41:53 Srednjeevropski standardni =C4=8Da=
s je Andre Przywara napisal(a):
> This series converts boards with the Allwinner F1C100s/F1C200s, A10, A10s
> and A13s SoCs over to OF_UPSTREAM. The .dts and .dtsi files were
> identical between the kernel and U-Boot repository, so this is a
> no-brainer.
> However there are four boards (tablets, I guess) that do not have a .dts
> file in the kernel repository. For now I kept them using the "old
> style", so they continue working. This requires to keep a copy of the
> SoC .dtsi file, I would be grateful for any advice as how to handle this
> situation best. Ideally we would submit the DTs to the kernel, but I
> don't know how feasible this is, given their age, the missing device
> availability and their basic DT nature.

Drop them? I don't think there is much value to have them in such
poor state. If there is interest, people can first use older version of
U-Boot and then follow proper procedure for including them.

Best regards,
Jernej

>=20
> I compiled all boards with and without this series applied: the
> resulting u-boot.dtb files were always identical.
>=20
> Please have a look!
>=20
> Cheers,
> Andre
>=20
> Andre Przywara (3):
>   suniv: switch Allwinner F1Cx00 boards to OF_UPSTREAM
>   sunxi: switch Allwinner A10 boards to OF_UPSTREAM
>   sunxi: switch Allwinner A10s/A13 boards to OF_UPSTREAM
>=20
>  arch/arm/dts/Makefile                         |  48 +--
>  arch/arm/dts/sun4i-a10-a1000.dts              | 255 -------------
>  arch/arm/dts/sun4i-a10-ba10-tvbox.dts         | 151 --------
>  arch/arm/dts/sun4i-a10-chuwi-v7-cw0825.dts    | 159 --------
>  arch/arm/dts/sun4i-a10-cubieboard.dts         | 255 -------------
>  arch/arm/dts/sun4i-a10-dserve-dsrv9703c.dts   | 218 -----------
>  arch/arm/dts/sun4i-a10-gemei-g9.dts           | 192 ----------
>  arch/arm/dts/sun4i-a10-hackberry.dts          | 140 -------
>  arch/arm/dts/sun4i-a10-hyundai-a7hd.dts       | 115 ------
>  arch/arm/dts/sun4i-a10-inet1.dts              | 229 -----------
>  arch/arm/dts/sun4i-a10-inet97fv2.dts          | 203 ----------
>  arch/arm/dts/sun4i-a10-inet9f-rev03.dts       | 357 ------------------
>  .../dts/sun4i-a10-itead-iteaduino-plus.dts    | 126 -------
>  arch/arm/dts/sun4i-a10-jesurun-q5.dts         | 181 ---------
>  arch/arm/dts/sun4i-a10-marsboard.dts          | 182 ---------
>  arch/arm/dts/sun4i-a10-mini-xplus.dts         | 144 -------
>  arch/arm/dts/sun4i-a10-mk802.dts              | 144 -------
>  arch/arm/dts/sun4i-a10-mk802ii.dts            | 111 ------
>  arch/arm/dts/sun4i-a10-olinuxino-lime.dts     | 225 -----------
>  arch/arm/dts/sun4i-a10-pcduino.dts            | 200 ----------
>  arch/arm/dts/sun4i-a10-pcduino2.dts           |  67 ----
>  arch/arm/dts/sun4i-a10-pov-protab2-ips9.dts   | 206 ----------
>  arch/arm/dts/sun4i-a10-topwise-a721.dts       | 242 ------------
>  arch/arm/dts/sun5i-a10s-auxtek-t003.dts       | 137 -------
>  arch/arm/dts/sun5i-a10s-auxtek-t004.dts       | 149 --------
>  arch/arm/dts/sun5i-a10s-mk802.dts             | 127 -------
>  arch/arm/dts/sun5i-a10s-olinuxino-micro.dts   | 272 -------------
>  arch/arm/dts/sun5i-a10s-r7-tv-dongle.dts      | 118 ------
>  arch/arm/dts/sun5i-a10s-wobo-i5.dts           | 195 ----------
>  arch/arm/dts/sun5i-a10s.dtsi                  | 173 ---------
>  arch/arm/dts/sun5i-a13-difrnce-dit4350.dts    |  50 ---
>  .../dts/sun5i-a13-empire-electronix-d709.dts  | 190 ----------
>  .../dts/sun5i-a13-empire-electronix-m712.dts  |  51 ---
>  arch/arm/dts/sun5i-a13-hsg-h702.dts           | 182 ---------
>  arch/arm/dts/sun5i-a13-inet-98v-rev2.dts      |  50 ---
>  arch/arm/dts/sun5i-a13-licheepi-one.dts       | 214 -----------
>  arch/arm/dts/sun5i-a13-olinuxino-micro.dts    | 141 -------
>  arch/arm/dts/sun5i-a13-olinuxino.dts          | 247 ------------
>  .../dts/sun5i-a13-pocketbook-touch-lux-3.dts  | 258 -------------
>  arch/arm/dts/sun5i-a13-q8-tablet.dts          |  80 ----
>  arch/arm/dts/sun5i-a13-utoo-p66.dts           | 116 ------
>  arch/arm/dts/sun5i-a13.dtsi                   | 118 ------
>  arch/arm/dts/sun5i-gr8-chip-pro.dts           | 238 ------------
>  arch/arm/dts/sun5i-gr8-evb.dts                | 333 ----------------
>  arch/arm/dts/sun5i-gr8.dtsi                   | 126 -------
>  arch/arm/dts/sun5i-r8-chip.dts                | 282 --------------
>  arch/arm/dts/sun5i-r8.dtsi                    |  47 ---
>  .../dts/sun5i-reference-design-tablet.dtsi    | 194 ----------
>  arch/arm/dts/suniv-f1c100s-licheepi-nano.dts  |  73 ----
>  arch/arm/dts/suniv-f1c100s.dtsi               | 330 ----------------
>  arch/arm/dts/suniv-f1c200s-lctech-pi.dts      |  76 ----
>  arch/arm/dts/suniv-f1c200s-popstick-v1.1.dts  |  81 ----
>  arch/arm/mach-sunxi/Kconfig                   |   3 +
>  configs/A10-OLinuXino-Lime_defconfig          |   2 +-
>  configs/A10s-OLinuXino-M_defconfig            |   2 +-
>  configs/A13-OLinuXinoM_defconfig              |   2 +-
>  configs/A13-OLinuXino_defconfig               |   2 +-
>  configs/Ampe_A76_defconfig                    |   1 +
>  configs/Auxtek-T003_defconfig                 |   2 +-
>  configs/Auxtek-T004_defconfig                 |   2 +-
>  configs/CHIP_defconfig                        |   2 +-
>  configs/CHIP_pro_defconfig                    |   2 +-
>  configs/Chuwi_V7_CW0825_defconfig             |   2 +-
>  configs/Cubieboard_defconfig                  |   2 +-
>  configs/Empire_electronix_d709_defconfig      |   2 +-
>  configs/Empire_electronix_m712_defconfig      |   2 +-
>  configs/Hyundai_A7HD_defconfig                |   2 +-
>  configs/Linksprite_pcDuino_defconfig          |   2 +-
>  configs/Marsboard_A10_defconfig               |   2 +-
>  configs/Mele_A1000_defconfig                  |   2 +-
>  configs/Mini-X_defconfig                      |   2 +-
>  configs/UTOO_P66_defconfig                    |   2 +-
>  configs/Wobo_i5_defconfig                     |   2 +-
>  configs/ba10_tv_box_defconfig                 |   2 +-
>  configs/difrnce_dit4350_defconfig             |   2 +-
>  configs/dserve_dsrv9703c_defconfig            |   2 +-
>  configs/iNet_3F_defconfig                     |   1 +
>  configs/iNet_3W_defconfig                     |   1 +
>  configs/iNet_86VS_defconfig                   |   1 +
>  configs/inet1_defconfig                       |   2 +-
>  configs/inet97fv2_defconfig                   |   2 +-
>  configs/inet98v_rev2_defconfig                |   2 +-
>  configs/inet9f_rev03_defconfig                |   2 +-
>  configs/jesurun_q5_defconfig                  |   2 +-
>  configs/lctech_pi_f1c200s_defconfig           |   2 +-
>  configs/licheepi_nano_defconfig               |   2 +-
>  configs/mk802_a10s_defconfig                  |   2 +-
>  configs/mk802_defconfig                       |   2 +-
>  configs/mk802ii_defconfig                     |   2 +-
>  configs/pov_protab2_ips9_defconfig            |   2 +-
>  configs/q8_a13_tablet_defconfig               |   2 +-
>  configs/r7-tv-dongle_defconfig                |   2 +-
>  configs/sunxi_Gemei_G9_defconfig              |   2 +-
>  93 files changed, 45 insertions(+), 8832 deletions(-)
>  delete mode 100644 arch/arm/dts/sun4i-a10-a1000.dts
>  delete mode 100644 arch/arm/dts/sun4i-a10-ba10-tvbox.dts
>  delete mode 100644 arch/arm/dts/sun4i-a10-chuwi-v7-cw0825.dts
>  delete mode 100644 arch/arm/dts/sun4i-a10-cubieboard.dts
>  delete mode 100644 arch/arm/dts/sun4i-a10-dserve-dsrv9703c.dts
>  delete mode 100644 arch/arm/dts/sun4i-a10-gemei-g9.dts
>  delete mode 100644 arch/arm/dts/sun4i-a10-hackberry.dts
>  delete mode 100644 arch/arm/dts/sun4i-a10-hyundai-a7hd.dts
>  delete mode 100644 arch/arm/dts/sun4i-a10-inet1.dts
>  delete mode 100644 arch/arm/dts/sun4i-a10-inet97fv2.dts
>  delete mode 100644 arch/arm/dts/sun4i-a10-inet9f-rev03.dts
>  delete mode 100644 arch/arm/dts/sun4i-a10-itead-iteaduino-plus.dts
>  delete mode 100644 arch/arm/dts/sun4i-a10-jesurun-q5.dts
>  delete mode 100644 arch/arm/dts/sun4i-a10-marsboard.dts
>  delete mode 100644 arch/arm/dts/sun4i-a10-mini-xplus.dts
>  delete mode 100644 arch/arm/dts/sun4i-a10-mk802.dts
>  delete mode 100644 arch/arm/dts/sun4i-a10-mk802ii.dts
>  delete mode 100644 arch/arm/dts/sun4i-a10-olinuxino-lime.dts
>  delete mode 100644 arch/arm/dts/sun4i-a10-pcduino.dts
>  delete mode 100644 arch/arm/dts/sun4i-a10-pcduino2.dts
>  delete mode 100644 arch/arm/dts/sun4i-a10-pov-protab2-ips9.dts
>  delete mode 100644 arch/arm/dts/sun4i-a10-topwise-a721.dts
>  delete mode 100644 arch/arm/dts/sun5i-a10s-auxtek-t003.dts
>  delete mode 100644 arch/arm/dts/sun5i-a10s-auxtek-t004.dts
>  delete mode 100644 arch/arm/dts/sun5i-a10s-mk802.dts
>  delete mode 100644 arch/arm/dts/sun5i-a10s-olinuxino-micro.dts
>  delete mode 100644 arch/arm/dts/sun5i-a10s-r7-tv-dongle.dts
>  delete mode 100644 arch/arm/dts/sun5i-a10s-wobo-i5.dts
>  delete mode 100644 arch/arm/dts/sun5i-a10s.dtsi
>  delete mode 100644 arch/arm/dts/sun5i-a13-difrnce-dit4350.dts
>  delete mode 100644 arch/arm/dts/sun5i-a13-empire-electronix-d709.dts
>  delete mode 100644 arch/arm/dts/sun5i-a13-empire-electronix-m712.dts
>  delete mode 100644 arch/arm/dts/sun5i-a13-hsg-h702.dts
>  delete mode 100644 arch/arm/dts/sun5i-a13-inet-98v-rev2.dts
>  delete mode 100644 arch/arm/dts/sun5i-a13-licheepi-one.dts
>  delete mode 100644 arch/arm/dts/sun5i-a13-olinuxino-micro.dts
>  delete mode 100644 arch/arm/dts/sun5i-a13-olinuxino.dts
>  delete mode 100644 arch/arm/dts/sun5i-a13-pocketbook-touch-lux-3.dts
>  delete mode 100644 arch/arm/dts/sun5i-a13-q8-tablet.dts
>  delete mode 100644 arch/arm/dts/sun5i-a13-utoo-p66.dts
>  delete mode 100644 arch/arm/dts/sun5i-a13.dtsi
>  delete mode 100644 arch/arm/dts/sun5i-gr8-chip-pro.dts
>  delete mode 100644 arch/arm/dts/sun5i-gr8-evb.dts
>  delete mode 100644 arch/arm/dts/sun5i-gr8.dtsi
>  delete mode 100644 arch/arm/dts/sun5i-r8-chip.dts
>  delete mode 100644 arch/arm/dts/sun5i-r8.dtsi
>  delete mode 100644 arch/arm/dts/sun5i-reference-design-tablet.dtsi
>  delete mode 100644 arch/arm/dts/suniv-f1c100s-licheepi-nano.dts
>  delete mode 100644 arch/arm/dts/suniv-f1c100s.dtsi
>  delete mode 100644 arch/arm/dts/suniv-f1c200s-lctech-pi.dts
>  delete mode 100644 arch/arm/dts/suniv-f1c200s-popstick-v1.1.dts
>=20
>=20




