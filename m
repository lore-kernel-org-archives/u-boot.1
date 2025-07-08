Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E154C83F0A
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 11:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4AC083123;
	Tue,  8 Jul 2025 13:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k9241V2L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA11A832FE; Tue,  8 Jul 2025 13:38:09 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8055830B4
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 13:38:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-556373661aaso3823310e87.2
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 04:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751974687; x=1752579487; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3JkHUKhzIBWte3IRirHirhkH/NRAGHhOSPiSyWPbD0A=;
 b=k9241V2L5INBUuoEqVHkhESzSt6BSZc/i+Lr8TTm8cIkedLtUo+Ltdc/U9LRCdTvCG
 Lsjap6JmnUo5qeWeydBGEjkTLniymFdBcis3FeiA4UFveCqB4SY86xCrtRfWAMnyRlWe
 bjMpdCYFGafJmeqOHzLY/3wptaWjl3eO4i8S3wMpk3YJK/WHm1deLB4mN4dTVxiPINu0
 UIZNEHPZqJfPBuNxY/9sNbr6iA4dJUJ14XHY8jcTl1Qeu+j0WWHbS9LcOYlYJv2Ovhbd
 aNK/yuufDB32kFU1MZpNQRV3ikgAS3+nKUAXRk69qahESL54fJVpHgkrqWTwkq0yB6Wo
 XU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751974687; x=1752579487;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3JkHUKhzIBWte3IRirHirhkH/NRAGHhOSPiSyWPbD0A=;
 b=G2IGVX6L9ajpGgxiyrQad9vcbMY/HYkw8p+Kl3k+R+Rka2Q18uXown47LSs8d1Tdvb
 OWamYcfkFKR5LXNGZ6OoA2WMxVn+fezI3vnwYTKhuUDeEeoKVX47X3mLSibn+ibwIeys
 D3UwMEVCcqjDavD5V5igpJJ70Z1bQqDR1mkVoCuv3dleGw4vcohpKSpL0jcqP4uKvk6+
 Gkt9CxytQ3sHh9/TfNyJpaxubVLJMrw8N0bLvHBBax8aTkWHpgqDaNVXgHz+6dYpRPD8
 mehVBzsIV3dOEGj5T2LGh8+4lVcIMef+f+DbI2budar1g0t+pUS36eora5QOQqGOHO7Z
 OMJg==
X-Gm-Message-State: AOJu0Yxtzx8gqLznwSwXYFxGY6e6hkRTM7YPdNkqIllVhEYcrBGB5F86
 OtUgAotkWpAjf6UfRlIv1zdhn3nBXrxLSW5U7MLWUt04nYWUoSs94+w6CMfIFcRVIV4JURYrl12
 zwNUJn/qya46/yCpeMxlEeA1kN+R2gTU=
X-Gm-Gg: ASbGncsBeDhwzmzxG2m0Szl2N0GtINyWLgJb1zhlQlb6iov7FDX47PqhkgKm1ydQ0z8
 o6qwdrsXJpktuLhzIzpJCvx8xGvCaJlHNR7TvLikLvl9nNZbn40cBlbf/IyRrbct8r3X3ZZihhX
 s3plxy3lwXbkZG+6QB69or17hVEA5H0FKR482RyHpIsE7GCmeuQqJEdH8/hpu7a/2XAKmk6SPcg
 oE=
X-Google-Smtp-Source: AGHT+IEkXwhLRU58StKBk92T4v/kQENFCHvakJMraY3bsJcV1hxGHnVKZTaviDupDIMs0M0ASHvMjBZr5D7yRClW/Zs=
X-Received: by 2002:a2e:b88f:0:b0:32b:7614:5745 with SMTP id
 38308e7fff4ca-32f39b1f90cmr7613621fa.20.1751974686705; Tue, 08 Jul 2025
 04:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5Ag7CmRBhpvOB5btNvHiAMayBoxSYMoBJXbV3-w1ET7jA@mail.gmail.com>
 <072c3a1f-7501-891c-b2b7-a55ea47be0f4@denx.de>
 <CAOMZO5A_7Ruaq9mE=owPctK-6uDu56kaBkqth-Vngr_CvAMHKQ@mail.gmail.com>
 <6bea1e46-e5ce-d3aa-369c-b6fd7b0b116c@denx.de>
In-Reply-To: <6bea1e46-e5ce-d3aa-369c-b6fd7b0b116c@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 8 Jul 2025 08:37:53 -0300
X-Gm-Features: Ac12FXzZddf6RrV5qeGbtd15MbB14UawV61-vcWIja-jgXuJ4Pjtr59Dw_eWPg4
Message-ID: <CAOMZO5Bsdx__qUGmwkYAAKTCbYcBVC2wExsV8o5c5mf9_N8CvQ@mail.gmail.com>
Subject: Re: i.MX6UL: Adding bootcount support
To: hs@denx.de
Cc: U-Boot-Denx <u-boot@lists.denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Schrempf Frieder <frieder.schrempf@kontron.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>
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

Hi Heiko,

On Tue, Jul 8, 2025 at 12:49=E2=80=AFAM Heiko Schocher <hs@denx.de> wrote:

> Ah, looked into RM of imx6ul ... it has also a SRC_GPR2 with the same
> comment as imx6ull has ... uff... why does this not work for you than?
>
> Try with md and mw and make soft resets (not power off/on !)

Thanks for your help. It works now with the changes below:

diff --git a/arch/arm/dts/imx6ul-14x14-evk.dtsi
b/arch/arm/dts/imx6ul-14x14-evk.dtsi
index 1a18c41ce385..0239a153080c 100644
--- a/arch/arm/dts/imx6ul-14x14-evk.dtsi
+++ b/arch/arm/dts/imx6ul-14x14-evk.dtsi
@@ -384,7 +384,6 @@
 &wdog1 {
        pinctrl-names =3D "default";
        pinctrl-0 =3D <&pinctrl_wdog>;
-       fsl,ext-reset-output;
 };

 &iomuxc {
diff --git a/configs/mx6ul_14x14_evk_defconfig
b/configs/mx6ul_14x14_evk_defconfig
index 0e35e5e6af57..4a6a35346759 100644
--- a/configs/mx6ul_14x14_evk_defconfig
+++ b/configs/mx6ul_14x14_evk_defconfig
@@ -110,3 +110,7 @@ CONFIG_SPLASH_SCREEN=3Dy
 CONFIG_SPLASH_SCREEN_ALIGN=3Dy
 CONFIG_BMP_16BPP=3Dy
 CONFIG_IMX_WATCHDOG=3Dy
+CONFIG_BOOTCOUNT_BOOTLIMIT=3D3
+CONFIG_SYS_BOOTCOUNT_ADDR=3D0x20d8024
+CONFIG_SYS_BOOTCOUNT_SINGLEWORD=3Dy
+CONFIG_BOOTCOUNT_LIMIT=3Dy

Thanks,

Fabio Estevam
