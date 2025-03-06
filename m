Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8980C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 15:55:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4850781253;
	Thu,  6 Mar 2025 16:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TrO2BiLi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA03B81253; Thu,  6 Mar 2025 16:55:48 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96B2B811C1
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 16:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-30bcb48b0a4so5817931fa.2
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 07:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741276509; x=1741881309; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=at0X4GHQByYRk8VzUVaL3Lpzr/VYMpN4rgDXu2FFb5g=;
 b=TrO2BiLiIyGYTlqDB8s+azcG0tlebhlF6esNKDNVjmOfvS7/lYx1ttaoT6cLkO9xfa
 q9yPZZzJohKMvrnWRXvRn2MbGcMSnHM4dB7FDHkOSK4HkhLt1CzPi4O4FpTJoTB91/K8
 v/XnEsiJwpaivu659MnjE3vRvvCbHPq7FMKZBQWahRotlikiZ62XieAoxBj7uZZ3UvM4
 /tVNmzRHSZk14MQm0xkfP1dMoTqo6MyPEVfruq38LpOZkLVK3P0GCEs0qcIyONhBV1Tf
 y4xH9zIVCLUDivCBU64X0q9riXKaWeOu2a0EYf/vq3xY6eJOlKTsS3tURlSVw1Qbvgkz
 93kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276509; x=1741881309;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=at0X4GHQByYRk8VzUVaL3Lpzr/VYMpN4rgDXu2FFb5g=;
 b=CESQL/k4DL1UXLeUxzmfjZIalI4hsmKmdQQrxIp/TL/l7EP2nhgvQXAK10bs9pg5nn
 WmDRrc1DhZy4zqOU5m1adW8mnoq/BcHzhC7lYO3zKEv5zPuh5Jcjx5boT1SUnagf8XDf
 Mu1sv3ZMvrLkT6cvYbgRMOPwLUP70SDF5PNm7MA3Li3dV1TCdWRjEmjpek+EEwvWhVXR
 GCHfUUXy55BkXdkI1WeBZWI3QQ892/J+M87i1i1NYt/lduYCT4ncBAolrhPIsNjy7xVI
 BcM8d3CCunLMzFIV+pa9XNEqxp5G8OLRXu7GXajbwO4B8zcBHFDNGmBhQ7Yiw364akoU
 Ft1Q==
X-Gm-Message-State: AOJu0YzCcQzN34XKL7hE+uMw2CBudC8UliyMXy16rT371diHmL8WspdH
 A2frPD2XAXx7F0nd3oG2ozmBQAOvNi0uW76gj4fRhdJTkMk9oJHR4cEPyLySsmtCjYMa+qO3GCi
 jguPGRaBXL9Ibg6pkMlG1WXCwAzA=
X-Gm-Gg: ASbGnctsaFY70oZDhBkKsdbxXcL2bSEBYFFTtCsRJUdVPY3Of+cKJgnOD/79Xwv3TQ1
 IjUZCtBxbbOkeSsA4cZGxnZy1axC52+4EoA3arXaD3ZCAUhXCNstmY+f6agX2nqS6L+wW7Aw/CO
 N9YQjjkNQi1wwfVZyu14IjHhTfdl3PuHpgsVyp/+jx5g6vM8P6LOcm8w9u
X-Google-Smtp-Source: AGHT+IG7l1cEFdkZv5IcYuri6wRfCQQjmidbI0H/IbGA0lCgIRtoUoIao6iYwisYxpIOKkNyJu7TnfG6fvU+Vt01Yl8=
X-Received: by 2002:a05:651c:150b:b0:30b:cc6a:ffd0 with SMTP id
 38308e7fff4ca-30bd7a1e43bmr28241081fa.2.1741276508651; Thu, 06 Mar 2025
 07:55:08 -0800 (PST)
MIME-Version: 1.0
References: <20250302165249.267992-1-aford173@gmail.com>
 <20250302165249.267992-6-aford173@gmail.com>
In-Reply-To: <20250302165249.267992-6-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 6 Mar 2025 12:54:57 -0300
X-Gm-Features: AQ5f1Josw_AJVrgg9SaHxRMmNPNWUPN7pTrpYzCZNZOjGxeBbK5H3U5fufK9Opw
Message-ID: <CAOMZO5CWobDv_wqmjJxzo1Ekb-UbtGfxoLtHo7ZKmjPSuHy+1w@mail.gmail.com>
Subject: Re: [PATCH 05/10] serial: mxc: Support bulk enabling clocks
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Tim Harvey <tharvey@gateworks.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Peter Robinson <pbrobinson@gmail.com>
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

On Sun, Mar 2, 2025 at 1:53=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:

> @@ -312,7 +313,17 @@ int mxc_serial_setbrg(struct udevice *dev, int baudr=
ate)
>  static int mxc_serial_probe(struct udevice *dev)
>  {
>         struct mxc_serial_plat *plat =3D dev_get_plat(dev);
> +       int ret;
>
> +#if CONFIG_IS_ENABLED(CLK_CCF)
> +       ret =3D clk_get_bulk(dev, &plat->clks);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D clk_enable_bulk(&plat->clks);
> +       if (ret)
> +               return ret;
> +#endif

CI fails when building a target with CLK_CCF disabled:

   aarch64:  +   imx8mp_evk
+drivers/serial/serial_mxc.c: In function 'mxc_serial_probe':
+drivers/serial/serial_mxc.c:316:13: error: unused variable 'ret'
[-Werror=3Dunused-variable]
+  316 |         int ret;
+      |             ^~~
+cc1: all warnings being treated as errors
+make[4]: *** [scripts/Makefile.build:257:
spl/drivers/serial/serial_mxc.o] Error 1
+make[3]: *** [scripts/Makefile.build:398: spl/drivers/serial] Error 2
+make[2]: *** [scripts/Makefile.xpl:550: spl/drivers] Error 2
+make[1]: *** [Makefile:2117: spl/u-boot-spl] Error 2
+make: *** [Makefile:177: sub-make] Error 2

Please fix and resend.
