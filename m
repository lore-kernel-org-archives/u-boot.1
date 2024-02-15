Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0BDC4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 09:52:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BED0A87D8A;
	Thu, 15 Feb 2024 10:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2b8woBM4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DCA287D8D; Thu, 15 Feb 2024 10:52:47 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 772D386F67
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 10:52:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-511831801f3so643438e87.2
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 01:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707990760; x=1708595560;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=esi11F10u8VYNKaneoQU7pDsJZAbeqxkQU04nsaSjzY=;
 b=2b8woBM4cDKEZy80yFF4gIKCMiKZbHi2+yA/13yLxVGiFHiiunXN6j9TQY0TnwSMNC
 Y1P41pEgfWX72Za7cPeoOOqep4FFth5VgDi9t1N5A5eFkUNTe1T2u8Yoz/WNC7o4sATW
 41OVPIrQSi0NVSIgbdghWSC8sh9Tv27MlRDo18XkTPe8s9uAP0b0qjADTNsQ5B7ro9r2
 nVx5HQeWNrAtlR2InBKGJf2IhvFKzc5s2MLmV6et2VGGknNAMIONBNJOw++qJyR1qP96
 S3jFiJjItRSQ9kAwwc9JwSL2q8bF2kK+2eRDsxWg0KLcSi2umbeijAb+6Z9M9q/FIXcw
 MaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707990760; x=1708595560;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=esi11F10u8VYNKaneoQU7pDsJZAbeqxkQU04nsaSjzY=;
 b=tL1gIhFqGz3NAaOUZuhR8LS3PCiwrPN/WQClsleye5i4BGxbjO5DesW9sRz7KVeXJW
 htC2Ew9aS1U7iPlXMNayzsMejLvqygpPKiHLeU99BaoE6kLtk0insfs7AxbSwXtE8iKt
 CDDciMveSmc4NKiJm643KzeP4ytW/Q62dYML4jjXQC3dR3r11KJBjNThccuvIKF5gW9K
 lSbYsSV5bkug5dqvZfVDXQKSNYU8rg+NBXggeGLw2lQOPDXVUvoU8Zjpb17G6VeE5ySd
 zujiaZxctQd8imLK0cPzjC4rUoOTv+WeWJPNOgs7ok/kFabc2p/yWXZ8WXRTVMohjC3F
 U8mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJJiG+7KwMafWus5A3zHExFtRjqeQd40W5oE3UBphJoauUIcXWbEzFNYg5I3d2OmwM3RBflrXw57maAAXwCaTSv9mHCA==
X-Gm-Message-State: AOJu0Yz7VFr/JprD5I6hUtm37/bWX3K+jBjzw94XH/J3ojoGaXvBvtAv
 2jRnn0TOlQgI/CYCktvxHrKevC8LZGA9DDXTf8z4EOX5Lbctw1WWZTq4IjSeL3E=
X-Google-Smtp-Source: AGHT+IHuBA9BO6h/dlOG4G0KJcMKwAsUkwSZRfzbNnZeyh/wkscoEx1BZvo7B7GYONhRBy6S1rWKXQ==
X-Received: by 2002:ac2:528c:0:b0:512:55c8:da19 with SMTP id
 q12-20020ac2528c000000b0051255c8da19mr968580lfm.46.1707990758684; 
 Thu, 15 Feb 2024 01:52:38 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 u9-20020a056000038900b0033b728190c1sm1273834wrf.79.2024.02.15.01.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 01:52:38 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@foundries.io>, u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, AKASHI Takahiro
 <takahiro.akashi@linaro.org>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Bin Meng <bmeng@tinylab.org>, Francis
 Laniel <francis.laniel@amarulasolutions.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Miquel Raynal <miquel.raynal@bootlin.com>, Roger
 Knecht <rknecht@pm.me>, Sean Edmond <seanedmond@microsoft.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 3/5] cmd: optee_rpmb: build cmd for sandbox
In-Reply-To: <20240214183444.493629-4-igor.opaniuk@gmail.com>
References: <20240214183444.493629-1-igor.opaniuk@gmail.com>
 <20240214183444.493629-4-igor.opaniuk@gmail.com>
Date: Thu, 15 Feb 2024 10:52:37 +0100
Message-ID: <87y1bmxdei.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Igor,

Thank you for the patch.

On mer., f=C3=A9vr. 14, 2024 at 19:34, Igor Opaniuk <igor.opaniuk@foundries=
.io> wrote:

> Support CMD_OPTEE_RPMB for SANDBOX configurations.
> Test:
>
> $ ./u-boot -d arch/sandbox/dts/test.dtb
> ...
> =3D> optee_rpmb write_pvalue test_variable test_value
> Wrote 11 bytes
> =3D> optee_rpmb read_pvalue test_variable 11
> Read 11 bytes, value =3D test_value
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on sandbox

> ---
>
>  cmd/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index a86b5705174..8ad8c0c542c 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1370,7 +1370,9 @@ config CMD_CLONE
>=20=20
>  config CMD_OPTEE_RPMB
>  	bool "Enable read/write support on RPMB via OPTEE"
> -	depends on SUPPORT_EMMC_RPMB && OPTEE
> +	depends on (SUPPORT_EMMC_RPMB && OPTEE) || SANDBOX_TEE
> +	default y if SANDBOX_TEE
> +	select OPTEE_TA_AVB if SANDBOX_TEE
>  	help
>  	  Enable the commands for reading, writing persistent named values
>  	  in the Replay Protection Memory Block partition in eMMC by
> --=20
> 2.34.1
