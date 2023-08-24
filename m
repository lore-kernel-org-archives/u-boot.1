Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89474C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 08:29:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1DFD86565;
	Thu, 24 Aug 2023 10:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="DDeQMkIq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B5DB8656B; Thu, 24 Aug 2023 10:29:43 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ADC28655D
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 10:29:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ba1e9b1fa9so99991701fa.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692865780; x=1693470580; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+8NGLfL/EvmOHG1VB53KAlBY7RKyMRZSSNElLhNpxlQ=;
 b=DDeQMkIqajClHCoZp6Vf8z7nKW9K/aM3kbv6Xn0wabU+qVpPcoSNUh7eQ+roPIshRZ
 C7WNWvwB149Fsksi/PZngyurGtOFyQRvwOy7A6D6AIE+AX0K/clRWkWwIQ5UkRTFaXA0
 V0AhaRW0WBV9DfHUtgC2PbV7ijBtsnq3nCLkSzAggrikT0765RU1lAE/aZ5rqrp+3Kd0
 if1ZlqySt83EscqheGK+956pumylkmoUYOK2Lm6LcxwfwQxy9NCQVhMtL5g2UltLCG4b
 U/ZjWfwdKMAkb1BrMTI05u4LtqEHBYu88v0QRLc2pAWpiOpUhHUHlIUv/lyK317Y1xo0
 4vJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692865780; x=1693470580;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+8NGLfL/EvmOHG1VB53KAlBY7RKyMRZSSNElLhNpxlQ=;
 b=EyJmOCd1CRVLtH3hnNKYF7ibRc+8s3I2qDyPThXacoShiR3ikU6Pn3ybN2+bKRXtHg
 +GzzwsOoPWQFCn06xDd8UM1SUbmYYc+rpkR43ZEfBm4eNyTusFMIDeQ1TAlxn7TL7Mbi
 SzfhoVq2YcCWmoE+/r6w3sLIjtVOncvaVAR/kXPT4rif9Y8AhBD8WiVcTTewzZxuhodH
 EUaOLjRnoA95w6WwB4KseqhqAD6uA8xGz/yhG0k42ajwB3v9GN4QtnZLh3Y8O+jKXeU4
 /zkH7UI9fdpSkmPx/huBSSfjsLRSJcw6lwqSdO73x4nwyxip16gDf0lOmyzHGfDsEOaS
 mvPQ==
X-Gm-Message-State: AOJu0YxNzXwfnHC+25XLopGhMEzQ3djFyHtoXcZU7S2yoIrh9NoPI7pT
 wnUqNGZY3lICKIvfiMKTs9bBhg==
X-Google-Smtp-Source: AGHT+IF/0AN3RMf8SGMhRKKCvI6WK8wCj2LwYbRVnNGrPid3VgLGJH+ie5sj3Qc134jsjnZGq5dxOQ==
X-Received: by 2002:a2e:984b:0:b0:2b9:e0bf:fc58 with SMTP id
 e11-20020a2e984b000000b002b9e0bffc58mr11743681ljj.13.1692865779638; 
 Thu, 24 Aug 2023 01:29:39 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 2-20020a05600c248200b003fee567235bsm1606794wms.1.2023.08.24.01.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 01:29:39 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@google.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V5 07/17] include: env: ti: ti_armv7_common.env: Rename
 to ti_common.env
In-Reply-To: <20230824031101.3460411-8-nm@ti.com>
References: <20230824031101.3460411-1-nm@ti.com>
 <20230824031101.3460411-8-nm@ti.com>
Date: Thu, 24 Aug 2023 10:29:37 +0200
Message-ID: <87cyzcrgge.fsf@baylibre.com>
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

On mer., ao=C3=BBt 23, 2023 at 22:10, Nishanth Menon <nm@ti.com> wrote:

> ti_armv7_common does not make any more sense as it is used by armv7
> and armv8 TI based platforms.
>
> Reported-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> New patch review comment from:
> https://lore.kernel.org/all/20230823144257.GG3953269@bill-the-cat/
>
> ti_common.h does'nt need any header file support if we switch to
> bootstd.
>
>  board/siemens/iot2050/iot2050.env                     | 2 +-
>  board/ti/am62ax/am62ax.env                            | 2 +-
>  board/ti/am62x/am62x.env                              | 2 +-
>  board/ti/am64x/am64x.env                              | 2 +-
>  board/ti/am65x/am65x.env                              | 2 +-
>  board/ti/j721e/j721e.env                              | 2 +-
>  board/ti/j721s2/j721s2.env                            | 2 +-
>  board/ti/ks2_evm/k2e_evm.env                          | 2 +-
>  board/ti/ks2_evm/k2g_evm.env                          | 2 +-
>  board/ti/ks2_evm/k2hk_evm.env                         | 2 +-
>  board/ti/ks2_evm/k2l_evm.env                          | 2 +-
>  include/env/ti/{ti_armv7_common.env =3D> ti_common.env} | 0
>  12 files changed, 11 insertions(+), 11 deletions(-)
>  rename include/env/ti/{ti_armv7_common.env =3D> ti_common.env} (100%)
>
> diff --git a/board/siemens/iot2050/iot2050.env b/board/siemens/iot2050/io=
t2050.env
> index caa9f80e3fca..8bbd7abe98f0 100644
> --- a/board/siemens/iot2050/iot2050.env
> +++ b/board/siemens/iot2050/iot2050.env
> @@ -6,7 +6,7 @@
>   *   Jan Kiszka <jan.kiszka@siemens.com>
>   */
>=20=20
> -#include <env/ti/ti_armv7_common.env>
> +#include <env/ti/ti_common.env>
>=20=20
>  usb_pgood_delay=3D900
>=20=20
> diff --git a/board/ti/am62ax/am62ax.env b/board/ti/am62ax/am62ax.env
> index 3f7c333fa404..bfed7f360844 100644
> --- a/board/ti/am62ax/am62ax.env
> +++ b/board/ti/am62ax/am62ax.env
> @@ -1,4 +1,4 @@
> -#include <env/ti/ti_armv7_common.env>
> +#include <env/ti/ti_common.env>
>  #include <env/ti/mmc.env>
>=20=20
>  default_device_tree=3Dti/k3-am62a7-sk.dtb
> diff --git a/board/ti/am62x/am62x.env b/board/ti/am62x/am62x.env
> index 1cf56dbd8128..1ef948df83d7 100644
> --- a/board/ti/am62x/am62x.env
> +++ b/board/ti/am62x/am62x.env
> @@ -1,4 +1,4 @@
> -#include <env/ti/ti_armv7_common.env>
> +#include <env/ti/ti_common.env>
>  #include <env/ti/mmc.env>
>=20=20
>  default_device_tree=3Dti/k3-am625-sk.dtb
> diff --git a/board/ti/am64x/am64x.env b/board/ti/am64x/am64x.env
> index 1567907fcbdc..68e42222b7f1 100644
> --- a/board/ti/am64x/am64x.env
> +++ b/board/ti/am64x/am64x.env
> @@ -1,4 +1,4 @@
> -#include <env/ti/ti_armv7_common.env>
> +#include <env/ti/ti_common.env>
>  #include <env/ti/mmc.env>
>  #include <env/ti/k3_dfu.env>
>=20=20
> diff --git a/board/ti/am65x/am65x.env b/board/ti/am65x/am65x.env
> index 755bff2707c8..286b9c300c05 100644
> --- a/board/ti/am65x/am65x.env
> +++ b/board/ti/am65x/am65x.env
> @@ -1,4 +1,4 @@
> -#include <env/ti/ti_armv7_common.env>
> +#include <env/ti/ti_common.env>
>  #include <env/ti/mmc.env>
>  #include <env/ti/k3_dfu.env>
>  #if CONFIG_CMD_REMOTEPROC
> diff --git a/board/ti/j721e/j721e.env b/board/ti/j721e/j721e.env
> index 2f2fb0591279..8cc8232fc131 100644
> --- a/board/ti/j721e/j721e.env
> +++ b/board/ti/j721e/j721e.env
> @@ -1,4 +1,4 @@
> -#include <env/ti/ti_armv7_common.env>
> +#include <env/ti/ti_common.env>
>  #include <env/ti/mmc.env>
>  #include <env/ti/ufs.env>
>  #include <env/ti/k3_dfu.env>
> diff --git a/board/ti/j721s2/j721s2.env b/board/ti/j721s2/j721s2.env
> index 6825b1469854..64e3d9da85f0 100644
> --- a/board/ti/j721s2/j721s2.env
> +++ b/board/ti/j721s2/j721s2.env
> @@ -1,4 +1,4 @@
> -#include <env/ti/ti_armv7_common.env>
> +#include <env/ti/ti_common.env>
>  #include <env/ti/mmc.env>
>  #include <env/ti/ufs.env>
>  #include <env/ti/k3_dfu.env>
> diff --git a/board/ti/ks2_evm/k2e_evm.env b/board/ti/ks2_evm/k2e_evm.env
> index a145db53e5fa..3dbb7934c59a 100644
> --- a/board/ti/ks2_evm/k2e_evm.env
> +++ b/board/ti/ks2_evm/k2e_evm.env
> @@ -1,4 +1,4 @@
> -#include <env/ti/ti_armv7_common.env>
> +#include <env/ti/ti_common.env>
>  #include <env/ti/ti_armv7_keystone2.env>
>=20=20
>  findfdt=3Dsetenv fdtfile ${name_fdt}
> diff --git a/board/ti/ks2_evm/k2g_evm.env b/board/ti/ks2_evm/k2g_evm.env
> index 4f4941dd0907..2b500fc6edf6 100644
> --- a/board/ti/ks2_evm/k2g_evm.env
> +++ b/board/ti/ks2_evm/k2g_evm.env
> @@ -1,4 +1,4 @@
> -#include <env/ti/ti_armv7_common.env>
> +#include <env/ti/ti_common.env>
>  #include <env/ti/ti_armv7_keystone2.env>
>  #include <env/ti/mmc.env>
>=20=20
> diff --git a/board/ti/ks2_evm/k2hk_evm.env b/board/ti/ks2_evm/k2hk_evm.env
> index 0714a51090ef..9991b76f8fcc 100644
> --- a/board/ti/ks2_evm/k2hk_evm.env
> +++ b/board/ti/ks2_evm/k2hk_evm.env
> @@ -1,4 +1,4 @@
> -#include <env/ti/ti_armv7_common.env>
> +#include <env/ti/ti_common.env>
>  #include <env/ti/ti_armv7_keystone2.env>
>=20=20
>  findfdt=3Dsetenv fdtfile ${name_fdt}
> diff --git a/board/ti/ks2_evm/k2l_evm.env b/board/ti/ks2_evm/k2l_evm.env
> index e8a803a4ed76..4e2debca4bde 100644
> --- a/board/ti/ks2_evm/k2l_evm.env
> +++ b/board/ti/ks2_evm/k2l_evm.env
> @@ -1,4 +1,4 @@
> -#include <env/ti/ti_armv7_common.env>
> +#include <env/ti/ti_common.env>
>  #include <env/ti/ti_armv7_keystone2.env>
>=20=20
>  findfdt=3Dsetenv fdtfile ${name_fdt}
> diff --git a/include/env/ti/ti_armv7_common.env b/include/env/ti/ti_commo=
n.env
> similarity index 100%
> rename from include/env/ti/ti_armv7_common.env
> rename to include/env/ti/ti_common.env
> --=20
> 2.40.0
