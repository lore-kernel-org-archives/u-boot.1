Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77875C624D0
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 09:08:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F73F80F3B;
	Wed,  2 Sep 2026 09:08:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mlF3b7xyRodQ; Wed,  2 Sep 2026 09:08:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788340081;
	bh=vcPBSEfuUgmyUgx+5CT6Fb3N0jPHmU6gv7p0FH2vsD8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=peivtZjWjVNsJqZ3hL9mho+D5gxstj6a4IOxr9odkSD+WJfUReiPXPUh5Uro4tyG6
	 ZE/sB5LWcBoI7kWzwEDkwLxalOtk20Jw3aemdp6KYwKkXj/U3RF0MNYIkJRIK+n6VI
	 UDceZpoNA0qWezIXYyepoUfMIYb+6DW2LKSDqBoFifvWIH9C+UEb7H5NsvCcUg+6rn
	 oJ/HgzCk1Rdpl5mpf5yEAG+aSxNPkmhvF2SL5hlDSAyckcFSDPGLnuKX9EpGOdmWit
	 bPuU0vtarBS0VPi84XpxcpVfr1u/DzK7lJFsZKIKsdyCajqa21cY5njgzwVFG5IzZW
	 JqyW20BOwQqAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3037180E7B;
	Wed,  2 Sep 2026 09:08:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 01808118
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 09:08:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DB7A0402D7
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 09:07:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WG1QX4Hnv9K9 for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 09:07:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=SL8BItYk
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1725B4023C
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 09:07:54 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c25420fe973so115113366b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 02:07:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788340072; cv=none;
 d=google.com; s=arc-20260327;
 b=KqkPlwwQe00Se5+CNaNWR2oooc+sacjBDo5L6X1LR+U3E2C20PmhNVEHs2VD3IX+l+
 4XsrwhZrtPxqnuBJ5V7SYIuW0RaWUgi/ousr8H8VBR8U47u9D267RQN9xt07DXPV4+9n
 eLdfUABHZ7RMyLo9skOu3CtD1KeDOTp7W375cfjyWOnRe3zKkLOo/fDpagK0fXVKKmCk
 oErf4xGitQLgV7YsIGwJ8eWQ2sM66JecFLI53IbQOhkmUbh7KKxGa4woCMw7OJn+NN7U
 aVbe+e5sHjZLuowqwOBWRpMb9mjTU+yi/AuYwkocUfr45DI9IE1/tfWtER/b5mL1Gg4C
 Y3RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vcPBSEfuUgmyUgx+5CT6Fb3N0jPHmU6gv7p0FH2vsD8=;
 fh=UhF5w8H4HJ/K9BROtZYai+0CkLFbD1oo1Yv4Tc3mtn0=;
 b=UNjWjEXTPyKULBzaWSSjWRCpZ7RuiaISQJsQjdlzoft0Wza4qL3Xs2GIqcR/xZ/1FE
 3xFS5I1nVL6Mt73OOdNDvCoDBPTQHYOekKwbdxUJbfo0RuiWMvPOp2irqATnuMCUFbkL
 yPAdD3PA5Jbf3ihIjED392dFb4FxLn2zXnyjrGrdRpMf+cNCqvLzsBEMlel7JYWdmJEL
 pDE8W6O0yqsAzb/f9U+TCxZYWQZU3Lzi7kk9fMt6meqS5IA4dBW/0zcmtSVOaTK50Vad
 lZmPWN+2ll/wmqyRqymkeqUH5f+1x899dbmsHDWJypV06yJUJnRTY7pD8w0ufpgxqv4j
 ZnBg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788340072; x=1788944872;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vcPBSEfuUgmyUgx+5CT6Fb3N0jPHmU6gv7p0FH2vsD8=;
 b=SL8BItYkw9azu8lZBoBGFKHOpeP6sbp5dqmYEDusd34VV1HR9AhT2aTpi0tuVG5o36
 STcNRv8W9/Tu+2WNSy1lSBr9kVCPLVI5Xoam5oAkf222bRi4IkasQoPW/Lh2kdCM+IGv
 jCI+zEVnnCma+5Y3/JTTQ0p4tgEq9wRXInR5KPw6F1ayfUVTwES/7nF2Xum4tLNBD+KS
 xvn+ocOiNQ0eV8hnuf0YD4B7QbdqilpTQQkOiUn9Myq+29YPjNQ7ms66vRmfje9pXIQ+
 QSrgtAQ6YRhLmB0tl7kFs9/hekHYhLLABvM/KGaYb5EoVbQlfqtbPYEozcA2ANmmYME4
 mPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788340072; x=1788944872;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vcPBSEfuUgmyUgx+5CT6Fb3N0jPHmU6gv7p0FH2vsD8=;
 b=GfxFj5FqkycE90Mtc5uDfmuKm/EUc+EiBgTB/MphIqXt+4rl8/17nH4gSu+YX+8R6X
 DDPvWrAN8TtZCWndgt0sAVTPY849/za4bFQFkvG+Lieg/gB4PbP/M9TrQR6CKB/xelfI
 wiu7Yprnog7fHJP83cwdACdbtmnAnorTU+uF9Hoeip5pHhAANULCQEcQMR3q/4LBj46y
 rT1cF2uggWFJ0AxlqOijzFGHPol5tGm9IQJZHIZ9wnNVT1rWKMZ20lpoVLntv/axywxv
 w8TImQnhZkhtVPdRhJA6wR6eD0/tEg3qSOoc+QzoilzIqlfxyNuHFWRtY/pePAZ9gQtl
 lvbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvvjnYwo0lYo3xG0vqFDbSN9NKMR7l7Ca9afbZrI719IBw6y36xWtUSOfTYGV9VBDE5MdNTtk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++krgNt5zUP2qyfK3tYk/WS0pO2Fhewyw/vvQUUrhtWVvK0WfzBw
 hf4S5FbvXHcUmNA+esktmic9H+jMwZs+r1p16xg/+dEKSurHeURlLAkmlNjhnQYbyuR/XAKHhX+
 HdI5+ifYJB12KCjXoMm04cdcHBXVdZk7nU62znkqpwg==
X-Gm-Gg: AYBFou3OMskGjx6BKAbhlMz0+xuECXRVY24MdVxupQdLapQBf4qpWoVzn46hWmYmZDJ
 E8JZux8ij4ryLwCfukzeCu/wfya1OpPuG+HG9O2Og6ql89grE4V2TtrN8QqD1EM4IDE4Qxo/iOZ
 McVw39lf/jqdaXRgoiTu7yapKItbYnBX8CPhurxLvQBWFEFRm7mdi/thyOqOFxrqHR9f4AbzrBN
 CExMaNcbstVzUcasNS/7F/daGiBB/Bwfv12pJ7hV8SooxeVJd3qF5CDc3gAaU7hPlk1TWjPI8Da
 D2HiC0pvNaNHbHFCaUqKc5z7nCBJptqvvbaw08Xn2+gADjLB6/mn7C2m5/KrPXDf+1te0uWe0Tu
 T6R+K8G72XVX1oomA69aQNRnLKfS4t42VtgHqCszvawE0VkVS1H5O+DGJ3ecWMrdl
X-Received: by 2002:a17:907:3f87:b0:c21:726b:34eb with SMTP id
 a640c23a62f3a-c25d54528e4mr180074866b.8.1788340072221; Wed, 02 Sep 2026
 02:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260814-mtk-genio-720-remove-ufs-defconfig-v1-1-000eb476030f@baylibre.com>
In-Reply-To: <20260814-mtk-genio-720-remove-ufs-defconfig-v1-1-000eb476030f@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 2 Sep 2026 11:07:42 +0200
X-Gm-Features: AcwNN1V908Aevd4MCChMeoPD1XvwTg0JrmYTydHpczQKIyAE5z6bvi0C3vkL_hU
Message-ID: <CAEHHSvY_kNWA1W1TONSwe-7MTHLK3wjLe18Bn0qto7+XePvBeQ@mail.gmail.com>
Subject: Re: [PATCH] configs: mediatek: remove UFS defconfigs
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Le ven. 14 ao=C3=BBt 2026 =C3=A0 23:21, David Lechner <dlechner@baylibre.co=
m> a =C3=A9crit :
>
> Remove the UFS defconfigs for Genio 520/720/1200 and enable the UFS
> options in the remaining defconfigs. This simplifies things a bit, e.g.
> it makes fewer builds to run when testing. Users can instead use the
> base defconfigs and pass DEVICE_TREE=3D to select the correct devicetree
> for the target. Or alternatively, include devicetree overlays in a FIT
> image that can be selected at runtime by the SPL.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> A bit more on the motivation behind this...
>
> As we are working on adding support for DSI displays for these that
> are removable (and there are dip switches to select different types
> of displays wired to the same pins) we need to add additional devicetree
> overlays for these EVKs. We don't want to keep adding more defconfigs
> for every permutation of the devicetree overlays. So better to go with
> a single defconfig that has everything enabled and just control what
> probes at runtime via the devicetree overlays.
> ---
>  board/mediatek/MAINTAINERS                  | 4 ----
>  configs/mt8189-ufs.config                   | 8 --------
>  configs/mt8189.config                       | 4 ++++
>  configs/mt8195.config                       | 5 +++++
>  configs/mt8371_genio_520_evk_ufs_defconfig  | 4 ----
>  configs/mt8391_genio_720_evk_ufs_defconfig  | 4 ----
>  configs/mt8395_genio_1200_evk_ufs_defconfig | 8 --------
>  7 files changed, 9 insertions(+), 28 deletions(-)
>
> diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
> index d99c6d708b2..47f91d6e81c 100644
> --- a/board/mediatek/MAINTAINERS
> +++ b/board/mediatek/MAINTAINERS
> @@ -5,12 +5,9 @@ F:     arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
>  F:     arch/arm/dts/mt8371-genio-common-u-boot.dtsi
>  F:     arch/arm/dts/mt8371-genio-common-ufs.dtso
>  F:     arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
> -F:     configs/mt8189-ufs.config
>  F:     configs/mt8189.config
>  F:     configs/mt8371_genio_520_evk_defconfig
> -F:     configs/mt8371_genio_520_evk_ufs_defconfig
>  F:     configs/mt8391_genio_720_evk_defconfig
> -F:     configs/mt8391_genio_720_evk_ufs_defconfig
>
>  MT8365 EVK
>  M:     Julien Masson <jmasson@baylibre.com>
> @@ -34,4 +31,3 @@ M:    Julien Stephan <jstephan@baylibre.com>
>  S:     Maintained
>  F:     configs/mt8195.config
>  F:     configs/mt8395_genio_1200_evk_defconfig
> -F:     configs/mt8395_genio_1200_evk_ufs_defconfig
> diff --git a/configs/mt8189-ufs.config b/configs/mt8189-ufs.config
> deleted file mode 100644
> index 8a7afb95b1b..00000000000
> --- a/configs/mt8189-ufs.config
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -#include <configs/mt8189.config>
> -
> -CONFIG_PHY=3Dy
> -CONFIG_PHY_MTK_UFS=3Dy
> -CONFIG_SCSI=3Dy
> -CONFIG_UFS=3Dy
> -CONFIG_UFS_MEDIATEK=3Dy
> -CONFIG_CMD_UFS=3Dy
> diff --git a/configs/mt8189.config b/configs/mt8189.config
> index ab56c90a17c..8db5815e9e0 100644
> --- a/configs/mt8189.config
> +++ b/configs/mt8189.config
> @@ -16,6 +16,7 @@ CONFIG_CMD_CLK=3Dy
>  CONFIG_CMD_GPIO=3Dy
>  CONFIG_CMD_GPT=3Dy
>  CONFIG_CMD_MMC=3Dy
> +CONFIG_CMD_UFS=3Dy
>  CONFIG_CMD_USB=3Dy
>  CONFIG_CMD_PMIC=3Dy
>  CONFIG_CMD_REGULATOR=3Dy
> @@ -42,6 +43,7 @@ CONFIG_DM_PMIC_MTK_PWRAP=3Dy
>  CONFIG_DM_REGULATOR=3Dy
>  CONFIG_DM_REGULATOR_FIXED=3Dy
>  CONFIG_DM_REGULATOR_MT6359=3Dy
> +CONFIG_SCSI=3Dy
>  CONFIG_BAUDRATE=3D921600
>  CONFIG_DM_SERIAL=3Dy
>  CONFIG_MTK_SERIAL=3Dy
> @@ -51,5 +53,7 @@ CONFIG_MTK_SNOR=3Dy
>  CONFIG_USB=3Dy
>  CONFIG_USB_XHCI_HCD=3Dy
>  CONFIG_USB_XHCI_MTK=3Dy
> +CONFIG_UFS=3Dy
> +CONFIG_UFS_MEDIATEK=3Dy
>  CONFIG_WDT=3Dy
>  CONFIG_WDT_MTK=3Dy
> diff --git a/configs/mt8195.config b/configs/mt8195.config
> index 03f57d46708..909b495e015 100644
> --- a/configs/mt8195.config
> +++ b/configs/mt8195.config
> @@ -13,9 +13,11 @@ CONFIG_BOOTSTD_FULL=3Dy
>  CONFIG_CMD_CLK=3Dy
>  CONFIG_CMD_GPT=3Dy
>  CONFIG_CMD_MMC=3Dy
> +CONFIG_CMD_UFS=3Dy
>  CONFIG_OF_UPSTREAM=3Dy
>  CONFIG_CLK=3Dy
>  CONFIG_MMC_MTK=3Dy
> +CONFIG_PHY=3Dy
>  CONFIG_PINCTRL=3Dy
>  CONFIG_PINCONF=3Dy
>  CONFIG_PINCTRL_MT8195=3Dy
> @@ -23,8 +25,11 @@ CONFIG_DM_PMIC=3Dy
>  CONFIG_DM_PMIC_MTK_PWRAP=3Dy
>  CONFIG_DM_REGULATOR=3Dy
>  CONFIG_DM_REGULATOR_MT6359=3Dy
> +CONFIG_SCSI=3Dy
>  CONFIG_BAUDRATE=3D921600
>  CONFIG_DM_SERIAL=3Dy
>  CONFIG_MTK_SERIAL=3Dy
> +CONFIG_UFS=3Dy
> +CONFIG_UFS_MEDIATEK=3Dy
>  CONFIG_WDT=3Dy
>  CONFIG_WDT_MTK=3Dy
> diff --git a/configs/mt8371_genio_520_evk_ufs_defconfig b/configs/mt8371_=
genio_520_evk_ufs_defconfig
> deleted file mode 100644
> index a0b365a86a2..00000000000
> --- a/configs/mt8371_genio_520_evk_ufs_defconfig
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -#include <configs/mt8189-ufs.config>
> -
> -CONFIG_DEFAULT_DEVICE_TREE=3D"mt8371-genio-520-evk-ufs"
> -CONFIG_DEFAULT_FDT_FILE=3D"mt8371-genio-520-evk-ufs"
> diff --git a/configs/mt8391_genio_720_evk_ufs_defconfig b/configs/mt8391_=
genio_720_evk_ufs_defconfig
> deleted file mode 100644
> index f1de9d5fa1e..00000000000
> --- a/configs/mt8391_genio_720_evk_ufs_defconfig
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -#include <configs/mt8189-ufs.config>
> -
> -CONFIG_DEFAULT_DEVICE_TREE=3D"mt8391-genio-720-evk-ufs"
> -CONFIG_DEFAULT_FDT_FILE=3D"mt8391-genio-720-evk-ufs"
> diff --git a/configs/mt8395_genio_1200_evk_ufs_defconfig b/configs/mt8395=
_genio_1200_evk_ufs_defconfig
> deleted file mode 100644
> index 525638f5800..00000000000
> --- a/configs/mt8395_genio_1200_evk_ufs_defconfig
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -#include <configs/mt8195.config>
> -
> -CONFIG_DEFAULT_DEVICE_TREE=3D"mediatek/mt8395-genio-1200-evk-ufs"
> -CONFIG_CMD_UFS=3Dy
> -CONFIG_PHY=3Dy
> -CONFIG_SCSI=3Dy
> -CONFIG_UFS=3Dy
> -CONFIG_UFS_MEDIATEK=3Dy
>
> ---
> base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
> change-id: 20260814-mtk-genio-720-remove-ufs-defconfig-d3e026765d4b
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Hi David,

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
