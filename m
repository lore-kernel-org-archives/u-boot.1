Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EBCC47DD9
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 10:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 478F287D71;
	Sun, 25 Feb 2024 11:05:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MRzC1jPg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C63A687D8F; Sun, 25 Feb 2024 11:05:45 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AD8187D58
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 11:05:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matwey.kornilov@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2997a92e23bso1309428a91.3
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 02:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708855540; x=1709460340; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FA6fnyMSy/9hPi0fQn5IQbJdvuYMS8iujhvw8qpxMb0=;
 b=MRzC1jPgguYOkUJIFhOilvMbRTD+is6HjgA33ogx1U9Vd+WXrrS1/m3JF91tVjbqqY
 S9+guXBObQCdi62J1beOmBzCnfvxnTCRlpb8a6N1YpaYiLtShTh+j7l2AFOEEJEc/Qse
 3QGOgi/15sScB4YVPXah4gLVkVlF+FRzZ6K8/u+B0FUay6Ee0m8If9Q0VrGK8/2Mp/HM
 0l2kSdMr1mFiboyjTeyxoTfvqR3nE0rORQQZBylP59mZ8dwQY4MbFo6R7hJyhFxjpztM
 U33MRvCOia9wc979FXinW7hIWZSnl8y2Sq3ZgmUz+oKVuIQ8b7FdDIHfWrv6+l+48+Zz
 vhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708855540; x=1709460340;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FA6fnyMSy/9hPi0fQn5IQbJdvuYMS8iujhvw8qpxMb0=;
 b=T5sIGBcLmwzzSRS8IiNLc8Ni9mBz2KvYPj00rxDVA7htspDVaY5VTyscB7rGs1V8uc
 EjJ+3ShbjSw4eQ+3xo0z6pos3YhH9oSgHEePwj+DWAtMEiMiXULyyzoTFFNwtFkTMCL5
 hU2qpu9qqhmlzKXM7nXs6NtUXdDZB1LVTUsUPIzIjaZycF+gbLQuX1g83EsnRb62rePZ
 fFVKBX49FvggBdKGNvM+JLDFeTL+lRbNXEkOQ7m9atp97P8irLAZEEXt7xu7LZi1I99v
 kfgkkY4miyxGBEXrZn/h8HrHaEMosbFtRlymMqXcRZSgenpr/gEd9wPtBwEjOpHWqsbw
 abLQ==
X-Gm-Message-State: AOJu0YyXEISRdf2aTsoIbpEf3ZbHiiwK8Ydo5wv2SqHaqAHt/6i28xID
 NxeOwWQMfzO7devrSqtZldzeSrI2dGb1a5NPckao+ZVW7Kz3saYayJvZQEsCZWqd20gDCreobWV
 xX3ksr60aE25haQfvYmaPaPXQRsw=
X-Google-Smtp-Source: AGHT+IEQyo/82C/+1h/kV+9i0Y48xDuNuJxBpEkxz+aNC1iohya5LTYkMooXeYTRYKfSkTGDjJWR1WRZVvlfBcOrB3A=
X-Received: by 2002:a17:90a:ea04:b0:299:1c53:113f with SMTP id
 w4-20020a17090aea0400b002991c53113fmr2818854pjy.0.1708855540273; Sun, 25 Feb
 2024 02:05:40 -0800 (PST)
MIME-Version: 1.0
References: <20240224235011.290117-1-benwolsieffer@gmail.com>
In-Reply-To: <20240224235011.290117-1-benwolsieffer@gmail.com>
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Sun, 25 Feb 2024 13:05:28 +0300
Message-ID: <CAJs94Eb=O4AHo08tcVOKwws5twWVEzseTWLtGAz35v_Abrxi4w@mail.gmail.com>
Subject: Re: [PATCH] rockchip: rock64: store env in SPI flash
To: Ben Wolsieffer <benwolsieffer@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Kever Yang <kever.yang@rock-chips.com>
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

As far as I remember not all Rock64 are supplied with soldered SPI.

=D0=B2=D1=81, 25 =D1=84=D0=B5=D0=B2=D1=80. 2024=E2=80=AF=D0=B3. =D0=B2 02:5=
2, Ben Wolsieffer <benwolsieffer@gmail.com>:
>
> Currently, U-Boot attempts to store the environment in MMC 0, which
> doesn't work when an eMMC is used without an SD card. There is an SPI
> flash chip on the board, so use that instead which should work in all
> cases. Additionally, this brings the Rock64 into line with the
> RockPro64.
>
> Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
> ---
>  configs/rock64-rk3328_defconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defc=
onfig
> index 0297d09876..589e5184ca 100644
> --- a/configs/rock64-rk3328_defconfig
> +++ b/configs/rock64-rk3328_defconfig
> @@ -8,6 +8,7 @@ CONFIG_NR_DRAM_BANKS=3D1
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x300000
>  CONFIG_SF_DEFAULT_SPEED=3D20000000
> +CONFIG_ENV_SIZE=3D0x8000
>  CONFIG_ENV_OFFSET=3D0x3F8000
>  CONFIG_DEFAULT_DEVICE_TREE=3D"rk3328-rock64"
>  CONFIG_DM_RESET=3Dy
> @@ -54,7 +55,7 @@ CONFIG_SPL_OF_CONTROL=3Dy
>  CONFIG_TPL_OF_CONTROL=3Dy
>  CONFIG_OF_SPL_REMOVE_PROPS=3D"clock-names interrupt-parent assigned-cloc=
ks assigned-clock-rates assigned-clock-parents"
>  CONFIG_TPL_OF_PLATDATA=3Dy
> -CONFIG_ENV_IS_IN_MMC=3Dy
> +CONFIG_ENV_IS_IN_SPI_FLASH=3Dy
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>  CONFIG_SYS_MMC_ENV_DEV=3D1
>  CONFIG_NET_RANDOM_ETHADDR=3Dy
> --
> 2.43.2
>


--=20
With best regards,
Matwey V. Kornilov
