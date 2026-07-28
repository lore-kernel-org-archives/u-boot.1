Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289A7C54F4D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 16:13:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E128A608E3;
	Tue, 28 Jul 2026 16:13:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nn1apaRXUbKD; Tue, 28 Jul 2026 16:13:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A32CF608D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785255219;
	bh=C7zmCd/yX4fnaqirMgqff9wVijFbLijDGWepeilb/1Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ROEFJ4HiDjYX/EKVhyTXkvw7JVfzAKcQ13Mq/nwh7PJf/trzTMe+s26Y1I2RC2gAu
	 MF0DaHGcksfxRXYb+yUHVFzpTBpmCMdNlvI9Kb2NhVwuuYw7s36Pmlwae8mEEPIPrn
	 GMx4N43ZxIIlAuvP6AesUiSJBQmbKEqKXbNKUOXVSuWbGjWlTQBYnwz8yhNNsDvxRv
	 rhMsi2p5vLziQBgjqR43Zqm8XGivkt7CMQcY/DYcHoIw2bl9gRMrzfhSMnn+Wu5VWQ
	 LroIX4gUZAhLqkMV3feEa9aa+T5PW/1CXtRGrWT4fa3Qt/001QZguIXv+n/saEv43Y
	 XwHjLr/nwP8zA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A32CF608D7;
	Tue, 28 Jul 2026 16:13:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E61524BF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 16:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CBF8F4033A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 16:13:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O6jic8FUqMcA for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 16:13:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 27E3840205
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 27E3840205
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 27E3840205
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 16:13:36 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c15d111ca99so3117866b.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785255215; cv=none;
 d=google.com; s=arc-20260327;
 b=KyrEJK9ipFMYjgPfcXwvPnDZZkFlEboLvfI1kfdI0fzzChX4dcZobTkVNR12mFDZFG
 5VJqxMHwkHQAUGKy21pUIJSWzGJnPEskv70KiVs2ojFsdL39M7qhmnSyS5a0ZeJQrW1m
 35t5UGWZiLY14dvekulGVePNH5RTj47asfIeDLStqPiX9GMrMAu4IXtre31S2YG3ZrTI
 mSwdAqPWnSbQsEULjaCGpuhG7LdGkczIPhGaZY40zkfNw3r6gUKfMK/Hc38iyiiw09Nd
 DSRieaPozxECQKup7qLMTd139uvR7ZIni41ull2QTJsucT4/BbXk2cO6kyTOIBvuYxIf
 gCrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=C7zmCd/yX4fnaqirMgqff9wVijFbLijDGWepeilb/1Q=;
 fh=+fVoo88OULVwFszgSUio5/2bdqohtmUXKcIXkiC8na4=;
 b=hg8ZRgBR1TJiLyL5bFWGpvtzmc1uukAgCjesDis+YqTUeXSZcWDh5ndJFPgGL0r6Vl
 lqUXbFRP1pCrIMgQyjIwh0DBKk+vRj/5GYGgzPnIoTaRPAhe8v/ISn4/t8+/DJOaX+3v
 oxoJJKruZTbqQ4cOKd9Kmihbv+lmnIlYWkemiaWGYqCUwQvHQDsOwqGxddUdLnZz5v9G
 RN9tTDRx+DQ8QTWkU+C2RJ/wFKg/8JXTRWZ0JNTAeWZ50fH4/+JISxqf4qAjvHJcnIJR
 22568nlIXuInGZcs1Q28BkR/53/BLj3qwjK8P99IWKI/43EXR4G3iqFZWsy7oiaerBuA
 4ySg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785255215; x=1785860015;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C7zmCd/yX4fnaqirMgqff9wVijFbLijDGWepeilb/1Q=;
 b=rTTX8CGnu0lMyq0WJRw7MJKrhm1uREhLcWjMBkyOGH53JMoP0m3unaSOOGza04Mn0w
 0XtkY5nFGnIU8qn9eABStFXPoHuBleP0TZBg9UxO16+X44KMS0eyo72Q7ud3nbZBRb8A
 LCzSzl2/CpEb279OJc+qJCmcZvdwzFxYRG99jhFz04JswoDtwmeancGs+NRkoLHGbCW4
 GsJKpft7kCFcJBIAETObWcOd8++aaUnZRG6iQ67DMT8Tz7UIAlCHL4+NnzPH4IAr5UU3
 CNezLB6Z9GiabQmynBfkUOXYgO2jU+lP/LsqaVFiKh0Whb1iZbRDiTQFkVKxmPuhwOSu
 GHZA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/LwHAdL4qajLIub685+hSjT9zSXLUET0oQ13JoYkEs0z/ffsDaBPEHBwqpO0/9usgEX0H/w4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy3/s9LuWH29bjDYdjKtMUJOGOxcTYZNz/9w6ZT8o5A3WhtIW3p
 MEFhC6zE3BqU8T9ME8Ehxaf4HaKTi1lwiDrhUBt78z1hA5bQc6osYEZU7w/JmOPsbm1rQ55E5DW
 OCIPiPZDHaMsw9cXJt5rCA+Zj0ieIkObjf8LgYBCNkw==
X-Gm-Gg: AR+sD11u9Umyd2s7AorCLT96jYH9ZwEpceE9aY4vw6kKkzwnFWpLsm/qoGyh6SgF9ns
 FXLn/95i7WUYOS4KkzgpQMENgyIjek3BjU/yl8lxQeK5piPoj+wtyPSpAkuqqbgIaItvcwuKIbG
 ajFpsSioGa2Z4cZy8TRykG/7GmBE96n8i21fIOFIP0qOflG5kglRz9Vd+XhZpQAvz4krQZEyd0x
 YAbFDx5RkxDw8vU/4CTKDemBchL+Nqd2xk0Zvw/Ci9No5XYGkbLdlSHuIfnHmTFSQ1QNMrvlvIW
 pLZOFDNbncsGICuR9Ax7B+aat6tvXAUR/KP3fo0y6/3gAJE9LDY7OFpr2tW59Mv9qWrbp/hc8c/
 /ky/glA==
X-Received: by 2002:a17:907:a0d6:b0:c1f:dec:d627 with SMTP id
 a640c23a62f3a-c1f7223e5eemr158524666b.39.1785255214687; Tue, 28 Jul 2026
 09:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260722-ccaione-upstream-mt8390-spl-v2-0-7aa005345711@baylibre.com>
 <20260722-ccaione-upstream-mt8390-spl-v2-4-7aa005345711@baylibre.com>
In-Reply-To: <20260722-ccaione-upstream-mt8390-spl-v2-4-7aa005345711@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Jul 2026 18:13:28 +0200
X-Gm-Features: AUfX_mz-eWe8zInkQ9AFfmGnUItk6MQRW1Nnb6tA1b7xDpJh6J35Zw_JjKppvFU
Message-ID: <CAEHHSvaVY4XB0v6qgopgdyJYNmJqDPMOexdEsFhd3Dztr21CAQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] doc: board: mediatek: document Genio 700 SPL boot
To: Carlo Caione <ccaione@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785255215; x=1785860015;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C7zmCd/yX4fnaqirMgqff9wVijFbLijDGWepeilb/1Q=;
 b=IZXSwSH2aXD7gOs7pSlGcP/TnKXLSokH1fNgBaOspVOcDMsRv3CuNeDR6WERHx8FF1
 NRLxpZsAiNAQr+6bAobbjg/n5iBY2NKXdsqx2d/Zfc9KNbVGHVBrUJBxyi2CzWAuHSti
 ipPzmz0f7bfCFBDiVjHWCuJchNIZL3KTY359y38hVCMY/oRI9MsQ3P0mB0fDzRM72UMY
 22WFGy1ScZB7TdaiRVii4C5J/9Mn/Zo8ZvA7SaitQEqW7YTN4c3Jn0NQhgOzmqsyoxd3
 hMhMLhnuLqoLKgZSR3SJWDQVvBka3oaOJQbG8QPKq91oh5rqmFmmfrXpUgoCLFxYWe2W
 j9TA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=IZXSwSH2
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Le mer. 22 juil. 2026 =C3=A0 23:36, Carlo Caione <ccaione@baylibre.com> a =
=C3=A9crit :
>
> Document the normal eMMC boot chain, external firmware prerequisites,
> binman build invocation and generated images.
>
> Also describe storage mapping, handoff details, verification steps, and
> current security and recovery limitations.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

Hi Carlo,

Thank you very much for starting this doc.
This was already requested few months ago  [1]. MediaTek, wanted to
handle this internally. Did you sync with them?

Also a lot of stuff in this documentation is quite generic, maybe it
worth refactoring a bit to share it with other Genio EVKs?

Maybe Macpaul Lin  have some feedback about this?

Cheers
Julien

[1]: https://lore.kernel.org/all/87y0lblck1.fsf@kernel.org/#t

> ---
>  board/mediatek/MAINTAINERS                  |   1 +
>  doc/board/mediatek/index.rst                |   1 +
>  doc/board/mediatek/mt8390-genio-700-evk.rst | 164 ++++++++++++++++++++++=
++++++
>  3 files changed, 166 insertions(+)
>
> diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
> index d99c6d708b2..e657c5b04d5 100644
> --- a/board/mediatek/MAINTAINERS
> +++ b/board/mediatek/MAINTAINERS
> @@ -27,6 +27,7 @@ F:    arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
>  F:     configs/mt8188.config
>  F:     configs/mt8370_genio_510_evk_defconfig
>  F:     configs/mt8390_genio_700_evk_defconfig
> +F:     doc/board/mediatek/mt8390-genio-700-evk.rst
>
>  MT8195/MT8395
>  M:     Macpaul Lin <Macpaul.Lin@mediatek.com>
> diff --git a/doc/board/mediatek/index.rst b/doc/board/mediatek/index.rst
> index c55d5aeb5c4..09038e29152 100644
> --- a/doc/board/mediatek/index.rst
> +++ b/doc/board/mediatek/index.rst
> @@ -7,3 +7,4 @@ Mediatek
>     :maxdepth: 2
>
>     mt7621
> +   mt8390-genio-700-evk
> diff --git a/doc/board/mediatek/mt8390-genio-700-evk.rst b/doc/board/medi=
atek/mt8390-genio-700-evk.rst
> new file mode 100644
> index 00000000000..2ccfa8e6f27
> --- /dev/null
> +++ b/doc/board/mediatek/mt8390-genio-700-evk.rst
> @@ -0,0 +1,164 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. Copyright (C) 2026 Baylibre SAS
> +
> +MediaTek Genio 700 EVK
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The MediaTek Genio 700 EVK is based on the MT8390 SoC and is configured =
with
> +``mt8390_genio_700_evk_defconfig``.
> +
> +Boot chain
> +----------
> +
> +The normal eMMC boot chain is::
> +
> +   BootROM
> +     -> platform DDR loader
> +     -> U-Boot SPL
> +     -> Arm Trusted Firmware-A (BL31)
> +     -> OP-TEE (BL32)
> +     -> U-Boot proper (BL33)
> +
> +The BootROM loads a MediaTek image from the eMMC boot0 hardware partitio=
n.
> +This image contains a platform DDR loader followed by U-Boot SPL. The DD=
R
> +loader initializes DRAM, copies the fixed ``CONFIG_SPL_MAX_SIZE`` byte S=
PL
> +region to ``CONFIG_SPL_TEXT_BASE`` and enters SPL at EL3 with exceptions
> +masked.
> +
> +SPL reads a FIT image from partition 1 of the eMMC user area. The FIT co=
ntains
> +Arm Trusted Firmware-A (BL31), OP-TEE (BL32), U-Boot proper (BL33) and t=
he
> +U-Boot control devicetree. SPL uses the standard FIT and Arm Trusted Fir=
mware
> +support to hand off to BL31.
> +
> +The DDR loader is a platform firmware component built separately from U-=
Boot
> +and supplied to binman as an external blob.
> +
> +Build prerequisites
> +-------------------
> +
> +The following external binaries are required:
> +
> +``ddr-loader.bin``
> +   The MediaTek DDR loader for the board. Build it with
> +   ``SPL_OFFSET=3D0x4b000``, ``SPL_SIZE`` equal to ``CONFIG_SPL_MAX_SIZE=
`` and an
> +   SPL destination and entry address matching ``CONFIG_SPL_TEXT_BASE``. =
The
> +   input may be shorter than ``0x4b000`` bytes; binman pads it with zero=
es to
> +   the offset reserved before SPL.
> +
> +``BL31``
> +   The U-Boot build variable naming the Arm Trusted Firmware-A BL31 bina=
ry
> +   built for MT8390. It is loaded and entered at ``0x54601000``.
> +
> +``TEE``
> +   The U-Boot build variable naming the OP-TEE binary. A standard OP-TEE=
 v1
> +   ``tee.bin`` image is supported. The FIT loads it at ``0x431fffe4`` an=
d
> +   enters it at ``0x43200000``.
> +
> +These binaries must match the board memory layout and its firmware secur=
ity
> +policy. Place ``ddr-loader.bin`` in a directory which can be passed to b=
inman
> +with ``BINMAN_INDIRS``.
> +
> +Building
> +--------
> +
> +For example, with the DDR loader in ``/path/to/firmware/ddr-loader.bin``=
::
> +
> +   $ export CROSS_COMPILE=3Daarch64-linux-gnu-
> +   $ export KBUILD_OUTPUT=3Dbuild
> +   $ export BL31=3D/path/to/bl31.bin
> +   $ export TEE=3D/path/to/tee.bin
> +   $ make mt8390_genio_700_evk_defconfig
> +   $ make BINMAN_INDIRS=3D/path/to/firmware
> +
> +``TEE`` must be set for both configuration and compilation. U-Boot uses =
its
> +presence during configuration to enable the support needed to preserve t=
he
> +OP-TEE reserved-memory nodes in the devicetree passed to the operating s=
ystem.
> +Do not deploy images if binman reports that it used fake or missing exte=
rnal
> +blobs.
> +
> +Building standalone binaries
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The external binaries are packaging inputs rather than U-Boot compilatio=
n
> +dependencies. To build only U-Boot proper and SPL, request their targets
> +directly::
> +
> +   $ make mt8390_genio_700_evk_defconfig
> +   $ make u-boot.bin spl/u-boot-spl.bin
> +
> +This produces ``build/u-boot.bin`` and ``build/spl/u-boot-spl.bin`` with=
out
> +building ``mtk-boot.bin`` or ``bootloaders.img``. The DDR loader and BL3=
1 are
> +not needed in this case.
> +
> +The presence of ``TEE`` during configuration enables the U-Boot support =
needed
> +to preserve the OP-TEE reserved-memory nodes. Set ``TEE`` during configu=
ration
> +if the resulting ``u-boot.bin`` will later be used in a boot chain conta=
ining
> +OP-TEE, even when the standalone target does not read the file.
> +
> +Binman produces two deployable images in the build directory:
> +
> +``mtk-boot.bin``
> +   A MediaTek eMMC image with load and entry address ``0x201000``. It co=
ntains
> +   the DDR loader, padded to ``0x4b000`` bytes, followed by U-Boot SPL p=
added
> +   to ``CONFIG_SPL_MAX_SIZE``. The fixed regions make every byte copied =
by the
> +   external loader part of the BootROM-loaded image.
> +
> +``bootloaders.img``
> +   A FIT image containing BL31, U-Boot proper, OP-TEE and the U-Boot con=
trol
> +   devicetree. Each component has a SHA-256 hash.
> +
> +Binman also creates ``mtk-boot.map`` and ``bootloaders.map``. These show=
 the
> +offset and size of every component. The FIT can be inspected with::
> +
> +   $ dumpimage -l build/bootloaders.img
> +
> +Installing
> +----------
> +
> +Use the board provisioning tools to place the images as follows:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Image                Destination
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +``mtk-boot.bin``     Start of the eMMC boot0 hardware partition
> +``bootloaders.img``  GPT partition 1 in the eMMC user area
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The standard Genio 700 partition layout names GPT partition 1
> +``bootloaders``. SPL selects the partition by number through
> +``CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION``; it does not locate it by=
 name.
> +
> +Writing an invalid image to eMMC boot0 can make the board unbootable. Pr=
eserve
> +the platform recovery path and any backup bootloader partition while tes=
ting.
> +Selection of a backup partition is not implemented by this SPL configura=
tion.
> +
> +Using Genio Tools
> +~~~~~~~~~~~~~~~~~
> +
> +Install `Genio Tools
> +<https://genio.mediatek.com/doc/iot-yocto/latest/tools/genio-tools.html>=
`_ and
> +obtain a compatible `prebuilt Genio image
> +<https://genio.mediatek.com/doc/iot-yocto/latest/sw/yocto/download.html>=
`_.
> +``genio-flash`` needs the extracted image directory for its partition me=
tadata
> +and download bootstrap. To update only the primary boot chain while reta=
ining
> +the backup bootloader partition, run::
> +
> +   $ genio-flash -P /path/to/genio-image \
> +         mmc0boot0:/absolute/path/to/build/mtk-boot.bin \
> +         bootloaders:/absolute/path/to/build/bootloaders.img
> +
> +Genio Tools uses the default bootstrap from the image directory. Keep
> +``bootloaders_b`` unchanged until the new images have been tested. Add
> +``--dry-run`` to check the selected files and partitions without accessi=
ng the
> +board.
> +
> +Limitations
> +-----------
> +
> +A successful boot prints banners from U-Boot SPL, BL31, OP-TEE and U-Boo=
t
> +proper.
> +
> +The generated images are not signed. Production signing, rollback protec=
tion
> +and provisioning are platform integration responsibilities. The images o=
nly
> +establish the firmware boot chain; operating-system boot policy remains
> +independent and uses the normal U-Boot facilities.
>
> --
> 2.55.0
>
