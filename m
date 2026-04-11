Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CB8F3ED40
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 13:26:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C25A784213;
	Sat, 11 Apr 2026 15:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jihm7xW8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F24AD8416F; Sat, 11 Apr 2026 15:18:36 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F51A84118
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 15:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b9c745e18a0so240954366b.1
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 06:18:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775913514; cv=none;
 d=google.com; s=arc-20240605;
 b=k5eV5+nl88Rv5p9ysS+70057iEcMP8zCUN1yT4TpDo2dmTwjdRJwcfWAhygdc6eYHJ
 nIE7+Qs38MFqdbDO84dDwKpS4yVQf8G8WAFtE2i3FJb83RKpydbk1KcXn/0oRuf8VW2H
 IdHd4LrrXVyiWpuBeGggRniEwgTWyLzfarJo+pke+LyYlZuKFUUuMTOR6kFLvt19B6yl
 drIyIwP7B0pILEd++gGE1BhUd2seRKu3m9rAJY4jRKgFH3d6/OqI85Aakrb8m8oj4PVs
 W01BwmXNO0vluyNZXnoku2mpxMuY+1g9N+sqFWS8JIgjgyseLMX+YVvnwDl+2X32wMt4
 MnlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=o4jd5X4F4Ql6GsfVr01Y5o/XB8JdfKfkesDEuQ8USl0=;
 fh=L/BQ/gD2GH7IVfNMorT43f9vmswcCMmsK7BCCAZgy8g=;
 b=V/BRM1CYcj5+nZ7nGK1DV6VY2Gz7kp5vEfPnV5JW6EnU/DaX10+Hm6oHZQF/iwXZs6
 nL23p7ZpMN52LzZFm95idIVIFgGKWXurF5CR6Tc91kiqpzwsDaRoPyM7D05DImsOpQmU
 AcibY4/4TZCmZzNEL//N6CjvdS/zbUHyw/aG8o3iO1NBFJOl3Do0p5zT5qM6oygbw2WI
 w0dgkGpNZHrCEXPo+nJSrqADHy163G8jZjBhxO4B/0PVP6LuaCVfMJ4Q3oJrAJuz2XIM
 BmCGckkIBZ8GCE3lZnvYSw2DUwvXaPQk4jPx9m6hjxa4BGuzRcHhvwYRk9wGYWQNco6I
 rQbg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775913514; x=1776518314; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o4jd5X4F4Ql6GsfVr01Y5o/XB8JdfKfkesDEuQ8USl0=;
 b=jihm7xW8NhP0ZxrA97yFnueJPVicPEHvqkTo1P2+OHekh6EIr3jq/JbBDTWqthQsu7
 CGJLa0RCq98x2KFm2APbB5wOF35MeoJlY4GUNh62obsiM/Fl+34KY98gxQWUcCD5hCO5
 tY8Gv5UljzOUDpJncGNMdtLcw7qn6qnX/6eV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775913514; x=1776518314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o4jd5X4F4Ql6GsfVr01Y5o/XB8JdfKfkesDEuQ8USl0=;
 b=Own0fTOv1KVYZBOkHdPxcvVhYV3gaEsYIGK7LNusKgxa4BAsFZv34CiwmswrRqt3tB
 u5YQcu2jfKdqqdJJstNxOXukEzJpVWr0Cv6PdL8EQGB1Lf/WdtmSS0bzthAaVtELYC7w
 jeFB1HxZda4OltKQQq5cu7kx9IZTdjH6HpMR076VFNbIPcqkLZoiVzHagJB4GeBxq7IF
 AGixSuWh3I6N7kbaUdPkI1mR8yJOih7D7mkL9cb1ifwlIcBtwj5+Qn5J0bwyBnw7XIkc
 F/yUDmPTLsP8frKu0WOjGV00ZgJzfw7d83PxmUmE2hzJ88ughUj2Iaw3ifNFBZYRQd09
 L25w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMoshF4qQL0sGVdA7VTJfFRVuFMJDYDskp2K/kjuUxRm38zBfwKthhiAogVoQLM8ES2FR0kxg=@lists.denx.de
X-Gm-Message-State: AOJu0YxiGUVsP151Juvsk1xRb1+XJzo5Ls7f5+9jwPYq2ek0Yxe2wbf7
 MIR69jod+jOA/Yx/163wPLsH4IHR/gI0gjqUeMJEf1Ylhr6fXksmOPJFmq18RXk+yHYFBZpve6R
 MVa+XOXraqyOMk3LCng8qVJbqS0LUC94BSc4HjLW6
X-Gm-Gg: AeBDietmaozsYmoLAK/88AABZO77vlX8sSMUbxPU6BIEGZLqxwiOAPdyuqbS+CcqBxw
 fnkNIUsnCaamtLMHv3LXeldDs7h8xpO2HWkLUovaGrhW5m0/Oc+rvxCBEZk8g0CWUYnziTktdO2
 zVyv4TsLs604LExKuZv4bzDexDor1fh44d0VRdVLynvNiPxYyHeghzqYStUf/TeDBEmEnVq5dd5
 ztf+Dd49ErMSJiix1xIValEXg0Y7gzxu9ljSqNR8I91l5vlrCVwsoKrNF9A68M6kWDM7xhG7k7Z
 ZDR/TA==
X-Received: by 2002:a17:907:d7c6:b0:b9d:6a04:beb0 with SMTP id
 a640c23a62f3a-b9d6a04bf1fmr390818066b.4.1775913513873; Sat, 11 Apr 2026
 06:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 07:18:19 -0600
X-Gm-Features: AQROBzC7EuRYxYMQ0a6_gAocYuhw5dnCAybIMLbrkiRWPwpypR_nabEE-27VwJ0
Message-ID: <CAFLszTi5K5iqeCw9XthrCPALti4Z5sMFaBx6rOE38PsQQx_93g@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Qualcomm IPQ5210 SoC bringup
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, 
 tien.fong.chee@altera.com, anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, 
 tingting.meng@altera.com, alice.guo@nxp.com, quentin.schulz@cherry.de, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, mkorpershoek@kernel.org, 
 h-salunke@ti.com, alchark@gmail.com, dario.binacchi@amarulasolutions.com, 
 ye.li@nxp.com, andre.przywara@arm.com, afd@ti.com, dinesh.maniyam@altera.com, 
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com, 
 aswin.murugan@oss.qualcomm.com, luca.weiss@fairphone.com, 
 adrian@mainlining.org, justin@tidylabs.net, n-francis@ti.com, wens@kernel.org, 
 jamie.gibbons@microchip.com, david.wronek@mainlining.org, 
 alexeymin@postmarketos.org, james.hilliard1@gmail.com, 
 michael@amarulasolutions.com, richard.genoud@bootlin.com, 
 philip.molloy@analog.com, sughosh.ganu@arm.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 11 Apr 2026 15:25:15 +0200
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

Hi Varadarajan,

On Fri, 10 Apr 2026 at 06:54, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
>
> Add pinctrl, clock drivers and SPL to support the IPPQ5210 SoC in U-Boot.
>
> The relevant DT files are available in linux-next [1].
>
> Working features, as tested on RDP504:
>         * Serial console
>         * UART
>         * MMC
>         * Boot sequence transitions from Boot ROM to U-Boot SPL, proprietary
>           binaries (a.k.a QCLib) load and execute as appropriate and eventual
>           jump to U-Boot.
>         * The QCLib handles
>                 - DDR initialization
>                 - Clock setup
>
> 1 - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq5210.dtsi
>     https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts
>     https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/clock/qcom,ipq5210-gcc.h
>     https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/reset/qcom,ipq5210-gcc.h
>
> v2:     - Add QCOM_GENI_MINICORE config option
>         - Move minicore register settings to separate file and include
>           if QCOM_GENI_MINICORE is enabled
>         - Remove bootph-all from override dts and moved them to kernel
>           DT - https://lore.kernel.org/linux-arm-msm/20260409-add_bootph-v1-1-cb2b5093f7d7@oss.qualcomm.com/T/#u
>
> v1: https://lore.kernel.org/u-boot/20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com/
>
> Varadarajan Narayanan (9):
>   dts: ipq5210-rdp504-u-boot: add override dtsi
>   doc: board/qualcomm: Update RDP build instructions
>   clk/qcom: add initial clock driver for ipq5210
>   pinctrl: qcom: Add ipq5210 pinctrl driver
>   misc: qcom_geni: Add minicore support
>   spl: Include SMEM driver in SPL
>   mach-snapdragon: Add initial support for IPQ5210 SPL
>   mach-snapdragon: Add commands to create wrapper ELF
>   configs: add qcom_ipq5210_mmc_defconfig
>
>  arch/arm/Kconfig                              |   5 +-
>  arch/arm/dts/ipq5210-rdp504-u-boot.dtsi       |  15 +
>  arch/arm/mach-snapdragon/Kconfig              |   6 +
>  arch/arm/mach-snapdragon/Makefile             |   3 +
>  .../mach-snapdragon/ipq5210-spl-wrap-elf.lds  |  14 +
>  arch/arm/mach-snapdragon/spl.c                | 701 ++++++++++++++++++
>  common/spl/Kconfig                            |   8 +
>  configs/qcom_ipq5210_mmc_defconfig            | 106 +++
>  doc/board/qualcomm/rdp.rst                    |  69 ++
>  drivers/Makefile                              |   1 +
>  drivers/clk/qcom/Kconfig                      |   8 +
>  drivers/clk/qcom/Makefile                     |   1 +
>  drivers/clk/qcom/clock-ipq5210.c              |  97 +++
>  drivers/misc/Kconfig                          |   6 +
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/qcom_geni-minicore.c             | 102 +++
>  drivers/misc/qcom_geni.c                      |  90 ++-
>  drivers/pinctrl/qcom/Kconfig                  |   8 +
>  drivers/pinctrl/qcom/Makefile                 |   1 +
>  drivers/pinctrl/qcom/pinctrl-ipq5210.c        | 349 +++++++++
>  include/smem.h                                |   3 +
>  include/soc/qcom/geni-se.h                    |   2 +
>  include/soc/qcom/qup-fw-load.h                |  15 +
>  scripts/Makefile.xpl                          |  21 +
>  24 files changed, 1618 insertions(+), 14 deletions(-)
>  create mode 100644 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
>  create mode 100644 arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds
>  create mode 100644 arch/arm/mach-snapdragon/spl.c
>  create mode 100644 configs/qcom_ipq5210_mmc_defconfig
>  create mode 100644 drivers/clk/qcom/clock-ipq5210.c
>  create mode 100644 drivers/misc/qcom_geni-minicore.c
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq5210.c
>
> --
> 2.34.1
>

> Add pinctrl, clock drivers and SPL to support the IPPQ5210 SoC in U-Boot.

Should that be IPQ5210 ?

How about splitting up patch 7 a bit as it has quite a lot in it.

Is CONFIG_SPL_WRAPPER_ELF intended to be a generic feature or just
something for this particular SoC?

Regards,
Simon
