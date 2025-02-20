Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F527C021AA
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 01:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD07E80805;
	Thu, 20 Feb 2025 02:43:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OOcd8xm/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65AB080C98; Thu, 20 Feb 2025 02:43:54 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D4F0801DE
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 02:43:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5439e331cceso490445e87.1
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 17:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740015831; x=1740620631; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LIDY6TH8xiyLdHBldCk0t1sI6oklhWDppnS0NQe6nL8=;
 b=OOcd8xm/bLCEq43RvbteuEfUq4LE8sbM84MIVcVYkLUrDHzQZz/wc923UZsdU+c9JT
 dH4e/8ilfyuqPKTs1edVqrmN0ujXDpAxUrx7cGJdhlW51mUPC2rPBTrYPJEqlZDklR6Z
 UeJ1Q8eU6tZcTzx0Bwim8u1nZXUARMdmpXslE7h1hYxxhTBr7Ix1d/WdXO5vWstRpa7x
 nUKBh+GX/gzOKaO6HYSDLHXq39o6qeTZXclVUlSwu5G8CWaM2lUaV8Ig9ZLFy120DTqr
 dVHDmW4xsygbH6MH2t9VSm4ONPRgt/dSdmf8fXj738UYWMpJxVtK/RrCGBrV6jtvCvw9
 GSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740015831; x=1740620631;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LIDY6TH8xiyLdHBldCk0t1sI6oklhWDppnS0NQe6nL8=;
 b=NprjpAS/z7UkAeaZIcc/4jj29JW5xTwEenxh5YXH+jIFmLF5w7zgoHgArsCRKPWBlp
 YLyaZdJDv30ny8N200opi9quKEZNGB6ZIytQfexr+bl1WFOSDl5bFXhkroE91xh1GocO
 fEgUyrkw3uG6/lN3xA8QSCblp/O7DsesuYPUjJFLCjw0g7U9wwXl9CRKsWUvm3KZsElZ
 xRlWURW4DgOLPhiTh2bvIpMj0mYlu4enh94QpjpFvucOnDV9dm5FxePcBV4W52joY6sr
 Wk7HpDYBZjFtUpNIwkuKxYflbThQ0Y4n6NeUEbwVbYUvlTvqNuMGaSpHMP8PSQAw/zlc
 Z89A==
X-Gm-Message-State: AOJu0Yxj0or3A3F813YrJlH/2RlcCCd7dDhyTt4FBC+2YXgYgAzudhLJ
 uis5diqhD+dAwGW9ZiOV4i5OS0bSuGoMkxqagweOjcbKO0BVLe4347d01p4SMwKGpccxGuzNqgh
 GwW9nS0bc90xBvNR4EdLughwndxpTWiMm
X-Gm-Gg: ASbGncsAXVI2DJZaLkNzj0OBQ2ZuqpXqrNI/I6e+4d/UnMUeKso3EYyAAZEh2zNOvgM
 90ElLBUKhUADWQpoEfa0A1R5ezeLlDHbmes8gKVGFFn0+M0BEk3NHBLBR2FrbRt2uurN0/gq43q
 8LPP7Mg4Ju5tI0Q49cH0rb6DPVWB9r
X-Google-Smtp-Source: AGHT+IGO6L9arFqZFQLOhV9WVwcRUBLUNQjI+w4k2KZaellEIGiPk1c2uGN10LxIpkvZxrSYbHctqxrTJgdOnBN/TBI=
X-Received: by 2002:a05:6512:3d28:b0:545:2eca:856 with SMTP id
 2adb3069b0e04-5462eed85c8mr1979675e87.9.1740015831108; Wed, 19 Feb 2025
 17:43:51 -0800 (PST)
MIME-Version: 1.0
References: <20250213162123.69159-1-ludwig.nussel@siemens.com>
In-Reply-To: <20250213162123.69159-1-ludwig.nussel@siemens.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 19 Feb 2025 22:43:39 -0300
X-Gm-Features: AWEUYZnCUH84alWj8JonuurImCKVkkLA1T_VsKsTSr_ejqyV8iYIyAKmTEB73As
Message-ID: <CAOMZO5As9nU4Bf1Ba_pUqgv2EdUd7niMte1bua9MBhk2zVr=Dw@mail.gmail.com>
Subject: Re: [PATCH] imx: fix imx8mm_evk config
To: Ludwig Nussel <ludwig.nussel@siemens.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Peng,

On Thu, Feb 13, 2025 at 2:34=E2=80=AFPM Ludwig Nussel <ludwig.nussel@siemen=
s.com> wrote:
>
> Commit 364ba68ed1a adjusted Kconfig for imx8mn_evk instead of

You haven't tested 364ba68ed1a, have you?

> imx8mm_evk for bootstd. Therefore mm is actually left building
> without bootstd by default.
>
> Also the name of the dtb referenced mp instead of mm. IIUC
> CONFIG_DEFAULT_FDT_FILE is meant to point to the path of the dtb
> within the kernel install directory. Therefore adding freescale/ as
> subdir too.

> --- a/configs/imx8mm_evk_defconfig
> +++ b/configs/imx8mm_evk_defconfig
> @@ -25,7 +25,7 @@ CONFIG_FIT=3Dy
>  CONFIG_FIT_EXTERNAL_OFFSET=3D0x3000
>  CONFIG_SPL_LOAD_FIT=3Dy
>  CONFIG_OF_SYSTEM_SETUP=3Dy
> -CONFIG_DEFAULT_FDT_FILE=3D"imx8mp-evk.dtb"
> +CONFIG_DEFAULT_FDT_FILE=3D"freescale/imx8mm-evk.dtb"

I think this could be CONFIG_DEFAULT_FDT_FILE=3D"imx8mm-evk.dtb"

>  CONFIG_SYS_CBSIZE=3D2048
>  CONFIG_SYS_PBSIZE=3D2074
>  CONFIG_BOARD_LATE_INIT=3Dy
> diff --git a/configs/imx8mm_evk_fspi_defconfig b/configs/imx8mm_evk_fspi_=
defconfig
> index 4a8d4994b80..a06b47ac3ba 100644
> --- a/configs/imx8mm_evk_fspi_defconfig
> +++ b/configs/imx8mm_evk_fspi_defconfig
> @@ -29,7 +29,7 @@ CONFIG_FIT=3Dy
>  CONFIG_FIT_EXTERNAL_OFFSET=3D0x3000
>  CONFIG_SPL_LOAD_FIT=3Dy
>  CONFIG_OF_SYSTEM_SETUP=3Dy
> -CONFIG_DEFAULT_FDT_FILE=3D"imx8mp-evk.dtb"
> +CONFIG_DEFAULT_FDT_FILE=3D"freescale/imx8mm-evk.dtb"

Ditto.

Another error I see with 364ba68ed1a is this hunk:

--- a/configs/imx8mm_evk_fspi_defconfig
+++ b/configs/imx8mm_evk_fspi_defconfig
@@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_LEN=3D0x2000000
 CONFIG_SPL_GPIO=3Dy
 CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
 CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
+CONFIG_ENV_SOURCE_FILE=3D"imx8mn_evk"

You cannot use the environment for imx8mn_evk on imx8mm_evk_fspi.

Just remove this line, and the correct env will be used.
