Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA759F506C3
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 12:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FBF184056;
	Mon, 16 Mar 2026 13:38:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dfXyLCtc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 301E88405A; Mon, 16 Mar 2026 13:38:46 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C51F184051
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 13:38:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b96d784828bso680788266b.3
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 05:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773664723; cv=none;
 d=google.com; s=arc-20240605;
 b=lp42dfTSjwctbqvtBHpTXZeDucAH7CwaePCCLLIXkPVHb4rjFPQZkELM0Ay8baNM6U
 fRJGCEMdyXgYvrTn20GJoEAtDwx1umh89QxJqv0FLW2xai/yvZ43ebDpKciO8rDBC2ME
 iTjMTo+e1A1mlEMM/ISS3c7NVFoEtOJQRUpTn/zDVNtLOYPlFVFvUqn85o8OaScig1Gj
 TFVthVCZ9gxD6qaOzxZE2adwUKw0U/GebrziE9VFB7/c0Pa77FG61OtnzOz/vVdDc6zs
 9QZvKBLjVx2KyuO+//lcu51KrJHoA//7tACexLhHmZNuAPfimIgpc9umFkK3dQyRB/Sq
 jQtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eCKcTZ026PJyiAXsahZiaWS47mZXsrq2e/QCcD1itxs=;
 fh=A/2oasO5fn6trInxltfCIpj1ltXSOvL5UPYs13Zb4CM=;
 b=El9CBLegATdSY8P770hriuqJkPHMVjRUHhMRXunhFvCtCsYFGLdYxMxDpLZA9L1aec
 0Tq/FQGblyYsZjxip44xHIhaoQ0Bpb/qH6GPiF91vebJhWI2/+DfiCBMtCQde24xBwBO
 huN1iiUs0rgpOJ8qBYwvvRUO4d3w2ovU1FYgZfvhHF3UzKV2cvJCKEv6aOOph/Wf22Hz
 0dsMrztr7cUyBRhfQAAT9X3Jx1zoBHaatTuQgq/JlnB2hqEpLKw3LJT6uTjhI5sa7t+h
 hhI1zImrmlgosP9rqsXSupd2AW/nJntBCV6RHlmZxEN1zJI5GDzdConBZgQEHrgDwUlE
 1Bpg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773664723; x=1774269523;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eCKcTZ026PJyiAXsahZiaWS47mZXsrq2e/QCcD1itxs=;
 b=dfXyLCtcikvGXfn2hnL4+2NCs9+97x4cT0KQiS5ixTQ4MkYWWSjKZzUCihlF6/Ye/2
 eOK21GfcbZGGGBiDWcTSJAkHND24Yrap2qaNlV6MJeuIWsWeGTfqCRuEuMnuCxOXwRcN
 k0euYC0KG9ExzA26LcXnK9xbyu0WCC5M8HJWyXjspMbSzokXJfe6/jNcSjEGm/b0IFaw
 aNqqHB0FI8/qDfiCCN4OBBz5KFDenjqJS4xxG9TesXeh9NS/hDn9oghFCJ8Gj8DeacNk
 XVHU9VmzqQpWy/nkRlISNgZj1p8QQiHUFLB3hAFwCYvuoI3yLSH3chkWwBMmKQLDGWGU
 Vb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773664723; x=1774269523;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eCKcTZ026PJyiAXsahZiaWS47mZXsrq2e/QCcD1itxs=;
 b=EFl/eqUndWZQEKpR3I+9TlLwSFlxI92Oi/J1PsgTcK0jKsbAiyyQXFVjsYmMMOtOfN
 +mu2CSEoKaF+4yPWJnbMoyJsZ1hVWP3793QFteTMvJmKLft7SM4KsTFI5stKSFSi7FrH
 PQ0oPlJi7HTee82/zk/bbNbq7fnzjVjUiwnXF/1TVOr4RiZuiXHYT7QnqZiE+AxWPwe3
 3WEXVRe17q6+YvR0xI+DebLeiXxjd0Wiht3+Mwr9Ogly7+LgmZQewQpYkWhT0ce8khgp
 yu2SDaWY8EQjveYbLP4SlXY6VH+ZdaD1bH5dOOoh/+MbwLn7UTsqO1x+8bA64q2nT0gR
 BWFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYVH0vNqvhbWsOsiXM1BBXNZ6fDm9BjL6DkDdJP5AwSIGqd+wNJvcXVvvJ9oJDiFIJDAUwdeM=@lists.denx.de
X-Gm-Message-State: AOJu0YwD4D7fpXKgsXHEoFu0j0d9IcNFW2jMiVNgkeeZ6faczt3+uxCT
 +enrC2fuzpNaoAMMbX+7Bc6pywmaE6evu6mcb6fFfw2HtFk6TSdwuAq+L1KYL4mizZCepOWl69T
 Eap4xUrxIAstfPv9Qgxy6qCKe01+Gtas8rtrjjFmmaQ==
X-Gm-Gg: ATEYQzxGvO5p1KsAFK+RHK7XSoId66OZtJAPLOgD/cUi1kWs34rATBQG4+I3FrOyjf3
 RWi/e77bkv/MpAFtWYLY3hEZcitC1pIz3YeNPywysDPd+ky5k2r4vJ/2skEABpHe+J/e68phUiX
 2WZSsvbKw1rhePyuMUV57B+g45HaFhTSy6gJUuQ/HnpyiOcf9VgjF92TUPuIQ1YJlG9Ot5bQBDR
 IQLeJhJvw0DqFt1pZN92QKNdT8sHlIepWvL5ufahiVDjWTBjoxHD6e17IezcLv3aepia84HU/Sf
 obaRXYP0uZaVbVcyhuAut3VgAyps4Z2gmWRm/JXKfxrnmBibjQGr6PKC9TI3oojKXsQoeosQQtP
 9RfzT8ACxHFdhfZ4JHDuzwQI4pqw89+f6a2BD
X-Received: by 2002:a17:907:d38c:b0:b90:8016:cfe4 with SMTP id
 a640c23a62f3a-b976500f9c8mr665485966b.10.1773664723128; Mon, 16 Mar 2026
 05:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260310-mtk-mt8391-initial-support-v2-0-1dc862d58532@baylibre.com>
 <20260310-mtk-mt8391-initial-support-v2-6-1dc862d58532@baylibre.com>
In-Reply-To: <20260310-mtk-mt8391-initial-support-v2-6-1dc862d58532@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 16 Mar 2026 13:38:35 +0100
X-Gm-Features: AaiRm50uL7oaA6RMpdZaiNiMtz3rmQ6ysshobNxIUUJ7g1XCSCxjjtOKAA95_ao
Message-ID: <CAEHHSvbduE9Naebb8hk3xu+0ZEwRuO8yuh_1GUM9QFOP=BA2vQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] board: mediatek: Add Genio 520/720 EVK defconfigs
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

Le mer. 11 mars 2026 =C3=A0 01:17, David Lechner <dlechner@baylibre.com> a =
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

Hi David,
I would not put MT8189 here since there is no MT8189 EVK

> +M:     Macpaul Lin <macpaul.lin@mediatek.com>
> +S:     Maintained
> +F:     configs/mt8189.config
> +F:     configs/mt8371_genio_520_evk_defconfig
> +F:     configs/mt8391_genio_720_evk_defconfig

Any reason to have genio_520/genio720 in the defconfig name?
All other boards we are currently upstreaming don't specify it in
their defconfig name:
mt8365_evk_defconfig/mt8370_evk_defconfig/mt8390_evk_defconfig ...

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
