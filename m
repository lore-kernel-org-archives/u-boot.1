Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821BC1061B0E
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 15:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA09B83E7A;
	Mon, 30 Mar 2026 17:21:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="G3OK4mIv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C574983E7A; Mon, 30 Mar 2026 17:21:48 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA6F283D17
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 17:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b9961e4f71bso698474566b.3
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 08:21:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774884106; cv=none;
 d=google.com; s=arc-20240605;
 b=M0bz+DcZ7cHTI2GnHjMTtCxYLwC5ajNVR8BZfT36kJKW9NmTHy6S4nrdE/tkKohqE/
 MmKnC6O9REyLyIkaQCO9CGHQjZ6oO+MkunRXBjeKUkMr6v87mFsBiM6C+z7YcZKdSJ7d
 6ysgAaQRWx3AdGUdMwDW98LIAgtZJkcM1ktb1UYbnfIH1wVzT2AmJCPN4lBrNDJ/8zAS
 74KpfewtXXFDdQbPqoxKXhpaXNu7tiC2yJICvQxdWvz8L4qrxw4yYjrMgUyzHs1p6W0T
 vteYWhAmI1cJtViO3gRyTsAfnMnuGz2gnNu1yOhmMsJ2zKSNjBOWfvlJh3/ujBT+28ky
 IpjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=riO+Dt53DucUt1qytl3ECamKLsVsDWdlYRr+EHnffoI=;
 fh=fba2SQzP6fDLfoDN11Sca5vqPv3lYL737kwYAw7MLFY=;
 b=femJsFAt8bafm+OmYKQY8BXUMFTnLCuQJyJLOKjTbOnafpKdRt4yOkFpl77mxqd273
 Hu+G+RYJO/mBG5VzDa0VfPoUgRnoEsqAs1UJ0S3z2B80USH6SIR9vC3O6Q4B/RhdHchF
 bS/MZhEqnUUY3RkbPA5mUj3ivuLDnBhOVp1f0t8F5frivIMFw197ANtoApLMCCjtBQwx
 xY35b0i4/cW/lmBf6QnOumXQF8mk101QHg1nqND1ya84kPenCc8nx2Q6TYKqzhrWQaAW
 JOQDbvadzwsVEOieUToD7rMoR4n/gFnmRePcQ6eTP7BvQSIjwULx/ffikmBYamdeMGIs
 s0zA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774884106; x=1775488906;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=riO+Dt53DucUt1qytl3ECamKLsVsDWdlYRr+EHnffoI=;
 b=G3OK4mIvstbG9caBmjGYLIAQn8JieYdfExGJof19FwoHcvyKBoB4l2Qd8ZW/GVkxEi
 8nq2qlp2cDCBBYO+uGvXYmJtUCHKrLVOFJTNVa5wDx1llDdp2VX4hkVB+ZQI59nlCMUK
 DndKf1XjymmFnF2qunYdx/quskBDGWFN6YBm5xuB4rLqEdqpbb3GFvs3ZYEzRDXQdkYU
 A0ctcsSfF8aetHRZuqgZFMZPC+vd2gjquznRXGaoEiNDtYXpu+4IPUiypEgmcAwEBM4g
 xCvO32rjeLEFxUWMh1h3MLBcYz9gPAYJhpmyciW0L/0R6ny+T4/6x7g5g053Pm09LZar
 k08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774884106; x=1775488906;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=riO+Dt53DucUt1qytl3ECamKLsVsDWdlYRr+EHnffoI=;
 b=X/pMN3jCykoFJQxxr6aHK0rbzrUgmvmVXH7lyo5eqIV9kV184700Gsxcu330QCgn7r
 uDzZxOvv7h9Zp76F+xauzaQqoS8LXgDzUCvZ3Vh1QIBWDtBsDtIZonMClaYXJjxEWm1v
 z1/hDFe0XgyLX3tzDdGzpnOQ5iK+EGnaa/5h7ceNrYMW+qkEbG1+nBDxKxRPy5cejiw/
 wZlERtVWIPwE0sH6cJYI9Ml/ThMC69j3TgtJFMhfICTCpzqvLQxcNZRVj9UAkCJxPnJD
 dKuKK1UJc8QAx/TlFbas3xbDhOLWc7jr3IVoXAedWhQQE0KHzjp4aXwSyDP6Bssp6nLa
 qbhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxxJyOu1dg8K41Yuf9E7kAiCblMFBGQ+rBZcHgyc6oMQ4M86fblJjV5yacbCHOvP38zZkpwQ4=@lists.denx.de
X-Gm-Message-State: AOJu0YxY/0kOFgd9Jc+qV/XtlWzd2YAY0emSEdKPTnVI2+vhkcWiF3Fh
 NY36zGeKunSthlikURHivBSRz0Wk2PdmUo07Xc/03wIzY5wJWhaZbOJ/xPzeykC74JupzTYZyMQ
 NY9ntqUf9TNsApk6tDVfCXIrEhf7h5ZC1J4UZ2MkAZQ==
X-Gm-Gg: ATEYQzzLK1FukiQyv55UQ6Tl8+mZMhRWf9DFcnsxGPm7giXaiCW3cSDDVBqwJ0Si4pG
 dw2SNgy3ymiEQMz0muPui+tLgEjWkxU7F0CDSi0QjFmKicvrz9LqEy47UYrLLKZZZ3+bsHRmc0H
 jZSf1bn7/B8CPbO0kXN60fgEtWn2Py+wuUjeV3bkO/N/klDgexDUvukS5UuWeRGZ/HQt+DdiWcO
 X7OUV46FEjpTBB3l/gld/7yvtXTgtz/MEY6mb9pZJ7d5mebbEF9MUsfGcFr/LnfQC4HHooXQKUJ
 z/uOUALLf58059QUputbsjTQp2eOhUVNMorAtCCPhnO35hCsHoPdDM/QiR5nZn+8gwPGmJE2gmf
 JP9u2zsSKrGJsKEkgOfrGR0Slgw==
X-Received: by 2002:a17:907:2d20:b0:b98:4b8:103a with SMTP id
 a640c23a62f3a-b9b507c4512mr821132366b.37.1774884105828; Mon, 30 Mar 2026
 08:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260323-mtk-mt8391-initial-support-v3-0-19dd92f4543f@baylibre.com>
 <20260323-mtk-mt8391-initial-support-v3-6-19dd92f4543f@baylibre.com>
In-Reply-To: <20260323-mtk-mt8391-initial-support-v3-6-19dd92f4543f@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 30 Mar 2026 17:21:39 +0200
X-Gm-Features: AQROBzB_8lDdboIOKUj7ZmW4IfhBY6N7dmqWRe9hG7WCbrD8WPn1wKnqOtxxEn4
Message-ID: <CAEHHSvanPwLr8GyUrCO1Pmo=PuS1Ymy1wmzdwXZeGW2KBiTagA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] board: mediatek: Add Genio 520/720 EVK defconfigs
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.denx.de, Chris-QJ Chen <chris-qj.chen@mediatek.com>
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

Le lun. 23 mars 2026 =C3=A0 21:18, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> From: Chris-QJ Chen <chris-qj.chen@mediatek.com>
>
> Add basic defconfigs for Genio 520 and 720 EVKs.
>
> Signed-off-by: Chris-QJ Chen <chris-qj.chen@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  board/mediatek/MAINTAINERS             |  7 +++++++
>  configs/mt8189.config                  | 34 ++++++++++++++++++++++++++++=
++++++
>  configs/mt8371_genio_520_evk_defconfig |  4 ++++
>  configs/mt8391_genio_720_evk_defconfig |  4 ++++
>  4 files changed, 49 insertions(+)
>
> diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
> index 446a9e8e53c..4f371592059 100644
> --- a/board/mediatek/MAINTAINERS
> +++ b/board/mediatek/MAINTAINERS
> @@ -1,3 +1,10 @@
> +MT8189/MT8371/MT8391 EVK
> +M:     Macpaul Lin <macpaul.lin@mediatek.com>

Don't you want to add yourself here? Since you have all the boards to test.=
.

Other than that, for the whole series:

Reviewed-by: Julien Stephan <jstephan@baylibre.com>

Thanks
Julien

> +S:     Maintained
> +F:     configs/mt8189.config
> +F:     configs/mt8371_genio_520_evk_defconfig
> +F:     configs/mt8391_genio_720_evk_defconfig
> +
>  MT8365 EVK
>  M:     Julien Masson <jmasson@baylibre.com>
>  S:     Maintained
> diff --git a/configs/mt8189.config b/configs/mt8189.config
> new file mode 100644
> index 00000000000..966d05d1a03
> --- /dev/null
> +++ b/configs/mt8189.config
> @@ -0,0 +1,34 @@
> +CONFIG_ARM=3Dy
> +CONFIG_COUNTER_FREQUENCY=3D13000000
> +CONFIG_POSITION_INDEPENDENT=3Dy
> +CONFIG_ARCH_MEDIATEK=3Dy
> +CONFIG_TEXT_BASE=3D0x4c000000
> +CONFIG_NR_DRAM_BANKS=3D1
> +CONFIG_OF_LIBFDT_OVERLAY=3Dy
> +CONFIG_TARGET_MT8189=3Dy
> +CONFIG_MTK_MEM_MAP_DDR_SIZE=3D0x200000000
> +CONFIG_SYS_LOAD_ADDR=3D0x4c000000
> +CONFIG_FIT=3Dy
> +CONFIG_BOOTSTD_FULL=3Dy
> +# CONFIG_BOARD_INIT is not set
> +CONFIG_CMD_CLK=3Dy
> +CONFIG_CMD_GPT=3Dy
> +CONFIG_CMD_MMC=3Dy
> +CONFIG_CMD_PMIC=3Dy
> +CONFIG_CMD_REGULATOR=3Dy
> +CONFIG_CLK=3Dy
> +# CONFIG_MMC_QUIRKS is not set
> +CONFIG_MMC_HS200_SUPPORT=3Dy
> +CONFIG_MMC_MTK=3Dy
> +CONFIG_PINCTRL=3Dy
> +CONFIG_PINCONF=3Dy
> +CONFIG_PINCTRL_MT8189=3Dy
> +CONFIG_DM_PMIC=3Dy
> +CONFIG_DM_PMIC_MTK_PWRAP=3Dy
> +CONFIG_DM_REGULATOR=3Dy
> +CONFIG_DM_REGULATOR_MT6359=3Dy
> +CONFIG_BAUDRATE=3D921600
> +CONFIG_DM_SERIAL=3Dy
> +CONFIG_MTK_SERIAL=3Dy
> +CONFIG_WDT=3Dy
> +CONFIG_WDT_MTK=3Dy
> diff --git a/configs/mt8371_genio_520_evk_defconfig b/configs/mt8371_geni=
o_520_evk_defconfig
> new file mode 100644
> index 00000000000..9a5e68e48ee
> --- /dev/null
> +++ b/configs/mt8371_genio_520_evk_defconfig
> @@ -0,0 +1,4 @@
> +#include <configs/mt8189.config>
> +
> +CONFIG_DEFAULT_DEVICE_TREE=3D"mt8371-genio-520-evk"
> +CONFIG_DEFAULT_FDT_FILE=3D"mt8371-genio-520-evk"
> diff --git a/configs/mt8391_genio_720_evk_defconfig b/configs/mt8391_geni=
o_720_evk_defconfig
> new file mode 100644
> index 00000000000..3fcd08be50a
> --- /dev/null
> +++ b/configs/mt8391_genio_720_evk_defconfig
> @@ -0,0 +1,4 @@
> +#include <configs/mt8189.config>
> +
> +CONFIG_DEFAULT_DEVICE_TREE=3D"mt8391-genio-720-evk"
> +CONFIG_DEFAULT_FDT_FILE=3D"mt8391-genio-720-evk"
>
> --
> 2.43.0
>
