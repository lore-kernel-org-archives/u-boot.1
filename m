Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAE3C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 12:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2A7082012;
	Fri, 25 Apr 2025 14:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gJD7TJ9D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D598882075; Fri, 25 Apr 2025 14:56:09 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C189E81E14
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 14:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-30effbfaf61so24181341fa.0
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 05:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745585767; x=1746190567; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CHlPgW7TZkJ0YuNi/HQdAoBD2SSXvrvcpcJOUEPcLpA=;
 b=gJD7TJ9DqkAsF8Lhl32fdtfV+I107iZEreGMJjIPzfvj39GN0iU+6OZU3hbaQ4rKGk
 +RvT+AsrRcfco11IuoccoeXMTTE9lD5Iq3dc89osL6imFNcpDnfODuFQoT0lsRNJI9G0
 MnnBRTlAAetIx6sFLz52GQglvkhkUQMxyxF1qcAK5SXGsLmfT09QeHXMUHU3IFu1Iynh
 NVvXmd4CPljEKTY++ErB+2FsIAQl4G9f9dUZvhtlNDdZ8LVlbUyj8GNiFxWZ7QD2mfNA
 DfkNIwuN6+8ZUakrI8VK4CmwQkvgGhWLZmYH+jRpguwzxON2Qh0E906m7FuTuuD27t5C
 Inrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745585767; x=1746190567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CHlPgW7TZkJ0YuNi/HQdAoBD2SSXvrvcpcJOUEPcLpA=;
 b=Wz3cE2j4Z/dC5vZelWffMFyAe59QBHse+WkHTTy0DzOu4ND1vK/ivNS+THJ3vKt5Ln
 MBOylQLD8lpBk9H6Ga3ghiwU27hOFIrEeRiEikWeoZKuzKAqyeo+EZ98sR3inOUZv4IQ
 FyhrrzUXByTbH/0J8iZN2ZOrjaGiQHX6e5CGVMkI1R6fy+nq8Pk5NC/xah2XEXgNMD8A
 ghUWIQhf+WmlgTLP6chnPXU5ZUQ5VzsjZuJtv+SLRY6hvR520HPyvXv41PerNDoEWSaH
 juJIlAEIoz9mR2Tkbrb+aq5tRJnR9oYioYFMZ1k4cUXl2w1Ncw/Kzi3KS1NyCs3880aI
 AIRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbsElis1OEkADsHdtERNhhTbCEP2/6hT4G6Swvua50g7DdL+20nvoi6XdGKKlt4JGJ5ixxT8U=@lists.denx.de
X-Gm-Message-State: AOJu0YyxKIK15E8UebL8Z6gexunH/vxepauRUyDP1vGmm+3qPmVHvquh
 uY13niWMgY80wVrow2Db4HQDD+K5+HutDIcvOPyGLPPjXrf4B0t7zsyapKBrB60gNptdmbGSrE6
 w7Cp0yQOpVGIkfMo1YxiFZwx+DnpX+Yg2
X-Gm-Gg: ASbGncvzuCobSlI+RrNjQQu6m96kh29Q0GgJYJP3CpD8WMf+YedkxTSBUy9jI3+UgZG
 cRo5Cdc3AO1ilo8seNe/iRaXXL5GN3DgqrDE7L8sRrrg1MEH3TO0tnLS2ShWtkLXTzReJ9rDupc
 TeloM1TcvXte8dU7hIdM8t9gjxFL8VClB3ziHbTrIkKN/FVOH8fl4UHw==
X-Google-Smtp-Source: AGHT+IFdu1kbZGB/9eLd7ZSQt4oZMqdgbb3yEbV0AdWrgda9S9FSMtO48yIqHZP0D6IS1jjN+7LuXtjNA/LAhsZ8FF4=
X-Received: by 2002:a05:651c:b14:b0:30c:465c:51de with SMTP id
 38308e7fff4ca-319000ef95emr5508761fa.10.1745585766648; Fri, 25 Apr 2025
 05:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250417171101.2566447-1-festevam@gmail.com>
 <5eb55cce-28b0-436a-85c4-dcf86e6c6554@denx.de>
 <CAOMZO5C_9yojvxO1NoNjtTHxD85ZcGd_cK2t-rofyY_Zxm1xcg@mail.gmail.com>
 <CAHCN7xLkDnLX5PHFNjXYn7AFXA5+S22aksgv62PpWpg80ZDQmA@mail.gmail.com>
 <d81112ad-017b-491a-b517-de828dd30c25@denx.de>
 <CAOMZO5CpQ-yv=8GhNv7=yjnA+uzzP9ZmB=P2d+xmhY1ktQJX9A@mail.gmail.com>
 <28b4bb24-4c56-4fe3-ae9b-db43c63290b1@denx.de>
 <CAOMZO5Cz1atyi0OSOrzUfSGiLb-9XdnyX-d8L7un5PuAdkBeBQ@mail.gmail.com>
 <703a0297-24b2-42f3-9fa7-62a78e38f1a2@denx.de>
 <CAOMZO5BitKDL2QRAzBuKK9rdfPsob_jdsYx86CRXJq8RjC8xoA@mail.gmail.com>
In-Reply-To: <CAOMZO5BitKDL2QRAzBuKK9rdfPsob_jdsYx86CRXJq8RjC8xoA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Apr 2025 09:55:55 -0300
X-Gm-Features: ATxdqUF71n3_gjM2wNMQyTMHRboQFGtO4gctVH0VhOu0KOmAODKU9HTCZAzQQzs
Message-ID: <CAOMZO5B6V4=5et8XpnN0-TkaCSLaiAf2sRw8C+_H97LeU17U+g@mail.gmail.com>
Subject: Re: [PATCH v2] clk: fixed-rate: Use "clock-output-names" to name
 fixed clocks
To: Marek Vasut <marex@denx.de>
Cc: Adam Ford <aford173@gmail.com>, trini@konsulko.com, lukma@denx.de, 
 seanga2@gmail.com, francesco.dolcini@toradex.com, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
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

On Thu, Apr 24, 2025 at 11:35=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:

> I haven't had a chance to debug this issue yet.

I applied this debug patch:

--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -1539,6 +1539,7 @@ static int fsl_esdhc_probe(struct udevice *dev)
        }

        priv->sdhc_clk =3D clk_get_rate(&priv->per_clk);
+       printf("****** sdhc clk is %d\n", priv->sdhc_clk);
 #else
        init_clk_usdhc(dev_seq(dev));

With the top-of-tree U-Boot, SPL calculates the wrong sdhc_clk on the
imx8mm-evk:

U-Boot SPL 2025.04-01380-ga9820e12db18-dirty (Apr 25 2025 - 09:40:45 -0300)
No pmic
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
SEC0:  RNG instantiated
Trying to boot from MMC1
****** sdhc clk is 204522251

If I revert b4734c9c333b ("clk: imx: Convert clock-osc-* back to
osc_*"), the clock is calculated correctly:

U-Boot 2025.04-01380-ga9820e12db18-dirty (Apr 25 2025 - 09:40:45 -0300)

CPU:   NXP i.MX8MMQ Rev1.0 A53 at 1200 MHz
CPU:   Consumer temperature grade (0C to 95C) at 42C
Model: FSL i.MX8MM EVK board
DRAM:  2 GiB
Core:  188 devices, 24 uclasses, devicetree: separate
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
MMC:   fsl_esdhc mmc@30b50000: no vqmmc-supply
****** sdhc clk is 200000000

If I do:

--- a/dts/upstream/src/arm64/freescale/imx8mm-evk.dtsi
+++ b/dts/upstream/src/arm64/freescale/imx8mm-evk.dtsi
@@ -614,8 +614,6 @@
 };

 &usdhc2 {
-       assigned-clocks =3D <&clk IMX8MM_CLK_USDHC2>;
-       assigned-clock-rates =3D <200000000>;
        pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
        pinctrl-0 =3D <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
        pinctrl-1 =3D <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;

Then the pause is gone, but the printed clock is incorrect:

U-Boot SPL 2025.04-01380-ga9820e12db18-dirty (Apr 25 2025 - 09:52:28 -0300)
No pmic
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
SEC0:  RNG instantiated
Trying to boot from MMC1
****** sdhc clk is 1431655607

Adam, imx8mm-beacon does not have the
assigned-clocks/assigned-clock-rates properties.

Maybe this is why you haven't observed the problem?
