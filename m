Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A052AC54E67
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 18:08:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD03287D4F;
	Tue, 26 Mar 2024 19:08:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZDiYKd6g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 508F687D50; Tue, 26 Mar 2024 19:08:15 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BD8E8751B
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 19:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-29f8403166aso966645a91.1
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 11:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711476492; x=1712081292; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eMKxrVRjEvlTAywiohLLisucldx4Td2OvwcEbHydKpI=;
 b=ZDiYKd6gh85Vg0LudYvqyh5+CR71Jumv57qOSslcKDavI23MMU+NAc13ACO2Cn9g13
 vRoYZAwBvvZ1fzJC/b0ApSMYLrepTf9nyI49+s+ApgpDKg3TiYLFSx6vXQ5yhVjVMDBT
 pWYdjRqAvtxudi03jCuWtcv2yk8vjToB4gd1OKsiTMLkq3FDi0ncl21NHpOpAhG8l91U
 Khz0paD0UEiu0I4KvET5nHS5LH2lw7F7Op5b5awVNikaJaipAAG4ebGntkmiPJCW37rz
 O8Mfq4nDtyK7ojrqn+dmEt+Pv3xcTg8iYeYQCpLZTAQanBapSJ0kwIDaZu03F0YZxTGO
 /gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711476492; x=1712081292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eMKxrVRjEvlTAywiohLLisucldx4Td2OvwcEbHydKpI=;
 b=jfBrXufTTVKjsQvIofTe2V7fc4FfS2lKy8Hkzf0XqsaO8xIrm9bsgB8ZFc6ELpg+r8
 Lbl5iK3b9BxKBRN43f2ynjKF3D0qGzZ3Rht8eoamc5BqfJJ1NLEOYCfAQlmh3bDGWLv3
 Qu7FUJEOmzHWXxNR4JMoSlbHsNpZk+foxkhFnOtpLpQxTq5G7M5Ou+NtjamK8MFsB3vl
 JdIUtJOXVlM+sfUwn+IgwYRcdsuTo5pItSAbwpJA/IbVhEvEt3VJ5odp38qlA6/vxT1v
 szBNQDLbMlpzeJTQbR+QhNr1yYAlcGGrAgCdpVJJWGZ045vaCSozjBiEYV2tYxx7krXK
 WBPQ==
X-Gm-Message-State: AOJu0YwipLorX4PeLE1Aj9O7rEq+irBItL3QtyqwIhnzl9ouJDuu37jN
 KsOx5D2Ya+jBlLEIE2mx7xZgz0Mtw8bGhPgCp3dkKGbsDXEajF67LGTWlidXjzu8EXT9PJDyAYK
 RgzAGxqPQwD97Ph+kXrGPx+wE5uU=
X-Google-Smtp-Source: AGHT+IHChEeXgy7JMNsqQBm4KvDWJzKdnVDkjine6j2eFKQ+1tIMkWA4f/uQvvfWFtutWiuXeXSmVpaJmvX4TG89+r4=
X-Received: by 2002:a17:90a:9f8b:b0:29b:fab2:8a24 with SMTP id
 o11-20020a17090a9f8b00b0029bfab28a24mr9375086pjp.3.1711476491633; Tue, 26 Mar
 2024 11:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAH9NwWe1qEo5r0UmdRh9CqFxmJYfHRU1YxoW8b8vTQwDB-227A@mail.gmail.com>
 <CAOMZO5BUibOAqqdtJtjrGwgciJ984ayUu0nPVdLkR_YLOh9bHQ@mail.gmail.com>
 <CAH9NwWdfcOM-q-EBVeZBs7-PRkr87M+pn-dYTzMW5bW7KRTo8g@mail.gmail.com>
In-Reply-To: <CAH9NwWdfcOM-q-EBVeZBs7-PRkr87M+pn-dYTzMW5bW7KRTo8g@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 26 Mar 2024 15:08:00 -0300
Message-ID: <CAOMZO5C4L2ka3-0xnycwVOfmu2CGqg5b-h1zKERHsah4Mvg9rw@mail.gmail.com>
Subject: Re: mx6cuboxi: failes to detect model
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, jonas@kwiboo.se,
 josua@solid-run.com, 
 Simon Glass <sjg@chromium.org>, Baruch Siach <baruch@tkos.co.il>
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

On Tue, Mar 26, 2024 at 1:11=E2=80=AFPM Christian Gmeiner
<christian.gmeiner@gmail.com> wrote:

> It got better but the model is (still) wrong:
>
> U-Boot 2024.04-rc5-dirty (Mar 26 2024 - 17:03:41 +0100)
>
> CPU:   Freescale i.MX6Q rev1.3 996 MHz (running at 792 MHz)
> CPU:   Extended Commercial temperature grade (-20C to 105C) at 20C
> Reset cause: POR
> Model: SolidRun HummingBoard2 Dual/Quad (1.5som+emmc)
> Board: MX6 HummingBoard2
> DRAM:  2 GiB
> Core:  82 devices, 17 uclasses, devicetree: fit
> MMC:   FSL_SDHC: 1, FSL_SDHC: 2
> Loading Environment from MMC... *** Warning - bad CRC, using default envi=
ronment

It seems to me that there is a mix of DM GPIO and non-DM GPIO.

Does the change below help?

--- a/board/solidrun/mx6cuboxi/mx6cuboxi.c
+++ b/board/solidrun/mx6cuboxi/mx6cuboxi.c
@@ -336,20 +336,16 @@ static enum board_type board_type(void)
         * HB             1     1    x
         */

-       gpio_direction_input(IMX_GPIO_NR(2, 8));
-       val3 =3D gpio_get_value(IMX_GPIO_NR(2, 8));
+       val3 =3D !!dm_gpio_get_value(&(board_detect_desc[0]));

        if (val3 =3D=3D 0)
                return HUMMINGBOARD2;

-       gpio_direction_input(IMX_GPIO_NR(3, 4));
-       val2 =3D gpio_get_value(IMX_GPIO_NR(3, 4));
+       val2 =3D !!dm_gpio_get_value(&(board_detect_desc[1]));

        if (val2 =3D=3D 0)
                return HUMMINGBOARD;
-
-       gpio_direction_input(IMX_GPIO_NR(4, 9));
-       val1 =3D gpio_get_value(IMX_GPIO_NR(4, 9));
+       val1 =3D !!dm_gpio_get_value(&(board_detect_desc[2]));

        if (val1 =3D=3D 0) {
                return CUBOXI;
