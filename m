Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F020C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 16:21:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5D6E88684;
	Thu, 18 Apr 2024 18:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="Qay3ewfY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24E6A8868E; Thu, 18 Apr 2024 18:21:44 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D48D788684
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 18:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-51aa6a8e49aso444147e87.3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 09:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1713457301; x=1714062101; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oUT6DInHOvCyGludsap3NvxtijXHz7Q9hndVLTIyirI=;
 b=Qay3ewfY+1wmMn4n3Np0sA7OzGKdxEUJUpQ/ffg5qOEIQbHD9UFy5DWa8oKMy1zbSF
 +Makecttfl7DQdb3K0z0mvZ/AqFCzVXILQjBlqKIvxZzTm0AALG7nDWxTwn2VtIRXOIh
 v+mUnSf1WmaH60mLyykpEkOlYzqqZDj/2o5omxyhGClh5fLFaU/VfMRAGrEb3CrpdQCT
 DKA+tRJdbQOD4HP+glcSDaTrFwTVswsjrHV+Jcw7lmN7qBNTvhovy85L32Ra9ZKxhGIk
 Ynp2gpkLoORU3lOrVTcjSIseXa7ioeDmH74+9MrT5E3xdI34fLOhdmvRpUiTxx2Sl6RX
 vvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713457301; x=1714062101;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oUT6DInHOvCyGludsap3NvxtijXHz7Q9hndVLTIyirI=;
 b=DuSzVsET3CBL8o945nnZP2dd57dWDDp4J/UtN4idD19I7l9/Hoe90rPF+c1TpFRw1c
 XLmdSoGKNSz6rVQVusyCuCd3dHkb19mOQhhyKbi8J+OkQskMH14Ovo/l1O6l2htBwwG3
 T51cv1f5XxBPZKIXRbyMoW8b/OcKI91wYiZmHMMaWcTmGtJwZd5Qz52DuTpGnR+6a9CC
 di2nE+v5FgXU6+ZOOrbBDDAPUUZdDl4bQj1mJcfdNobFwdaPOtLx2qrskD4/l7vUQo3u
 ohf7AUBrpYSAJx3BmCm0XNc+q5AnnMUPfPYT0cctOxB6sH92aARAcJCxO1hlnKF2HwFk
 KUWg==
X-Gm-Message-State: AOJu0Yyoy9hoqYe1YVDNivd/g4WQ5m0NWzWdbgt95TVMcWCglhIYhB1m
 lyUL0BCdv8WgvsRu/UJGeYoTO05mozuLPwRLQpYFw3QywdFNL8+cgEgeIXnmhCg7Sz1nSz2tYKN
 S2N0RHiq/bqduoOALAbj4mOBuas+5Cag9BbMY3JD86v3w96dtYpE=
X-Google-Smtp-Source: AGHT+IEZw4UTvYwWDRYuqK8TNfs+3FPDgzrdc3elYNo+atJ0jA53zaECSyXXqGwLXHzHfCiMBl1AM9yPmlQLLpG0MqY=
X-Received: by 2002:a19:644c:0:b0:515:c91a:f4e2 with SMTP id
 b12-20020a19644c000000b00515c91af4e2mr1799750lfj.24.1713457300953; Thu, 18
 Apr 2024 09:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240120003610.124981-1-marex@denx.de>
In-Reply-To: <20240120003610.124981-1-marex@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 18 Apr 2024 09:21:29 -0700
Message-ID: <CAJ+vNU31BNnThbDDrvaThPy01roPTGXYWJbp4wbJeD-K0gjpzQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Enable kaslrseed command on DH i.MX8M Plus DHCOM
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>,
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com
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

On Fri, Jan 19, 2024 at 4:36=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Linux 6.6.y with KASLR enabled would print the following message on boot:
> "
> KASLR disabled due to lack of seed
> "
> Enable the 'kaslrseed' command so a random number seed can be pulled
> from CAAM and inserted into the /chosen node 'kaslr-seed' property of
> Linux kernel DT before boot, thus letting KASLR work properly.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Fabio Estevam <festevam@denx.de>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: u-boot@dh-electronics.com
> ---
>  configs/imx8mp_dhcom_pdk2_defconfig | 2 ++
>  configs/imx8mp_dhcom_pdk3_defconfig | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/configs/imx8mp_dhcom_pdk2_defconfig b/configs/imx8mp_dhcom_p=
dk2_defconfig
> index 4f907ce00d0..23fb6272ad5 100644
> --- a/configs/imx8mp_dhcom_pdk2_defconfig
> +++ b/configs/imx8mp_dhcom_pdk2_defconfig
> @@ -117,6 +117,7 @@ CONFIG_CMD_BOOTCOUNT=3Dy
>  CONFIG_CMD_CACHE=3Dy
>  CONFIG_CMD_TIME=3Dy
>  CONFIG_CMD_GETTIME=3Dy
> +CONFIG_CMD_KASLRSEED=3Dy
>  CONFIG_CMD_SYSBOOT=3Dy
>  CONFIG_CMD_UUID=3Dy
>  CONFIG_CMD_PMIC=3Dy
> @@ -223,6 +224,7 @@ CONFIG_DM_REGULATOR_PCA9450=3Dy
>  CONFIG_SPL_DM_REGULATOR_PCA9450=3Dy
>  CONFIG_DM_REGULATOR_FIXED=3Dy
>  CONFIG_DM_REGULATOR_GPIO=3Dy
> +CONFIG_DM_RNG=3Dy
>  CONFIG_DM_RTC=3Dy
>  CONFIG_RTC_M41T62=3Dy
>  CONFIG_CONS_INDEX=3D2
> diff --git a/configs/imx8mp_dhcom_pdk3_defconfig b/configs/imx8mp_dhcom_p=
dk3_defconfig
> index 9972e2d96b6..0d47c12b1f9 100644
> --- a/configs/imx8mp_dhcom_pdk3_defconfig
> +++ b/configs/imx8mp_dhcom_pdk3_defconfig
> @@ -119,6 +119,7 @@ CONFIG_CMD_BOOTCOUNT=3Dy
>  CONFIG_CMD_CACHE=3Dy
>  CONFIG_CMD_TIME=3Dy
>  CONFIG_CMD_GETTIME=3Dy
> +CONFIG_CMD_KASLRSEED=3Dy
>  CONFIG_CMD_SYSBOOT=3Dy
>  CONFIG_CMD_UUID=3Dy
>  CONFIG_CMD_PMIC=3Dy
> @@ -228,6 +229,7 @@ CONFIG_DM_REGULATOR_PCA9450=3Dy
>  CONFIG_SPL_DM_REGULATOR_PCA9450=3Dy
>  CONFIG_DM_REGULATOR_FIXED=3Dy
>  CONFIG_DM_REGULATOR_GPIO=3Dy
> +CONFIG_DM_RNG=3Dy
>  CONFIG_DM_RTC=3Dy
>  CONFIG_RTC_M41T62=3Dy
>  CONFIG_CONS_INDEX=3D2
> --
> 2.43.0
>

Hi Marek,

Sorry to respond to an old thread but I ran across this when enabling
KALSR on my boards.

I have noticed when you enable DM_RNG on IMX8M that SPL fails to bind
the driver:
Couldn't bind rng driver (-96)
SEC0:  RNG instantiated

sec_init failed!

Didn't you encounter this as well? It seems to me that we may need to
add the ability to disable DM_RNG in the SPL unless I'm missing
something.

Best Regards,

Tim
