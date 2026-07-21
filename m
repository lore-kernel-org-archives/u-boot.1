Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF24C44515
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 00:38:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA1C76077A;
	Tue, 21 Jul 2026 00:38:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f0pRzo3jRE_r; Tue, 21 Jul 2026 00:38:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C5A1B6076D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784594317;
	bh=DUMhpJcH0KSZf5J9+hKkgxSM0vK8TRCHaSrFcBxyoKE=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=z37j/jub/sSljS51/BySSjUzYZ6nBN8aF0TQTAsgJhA0tUxzJW5WWNwVUqb+foQsV
	 9v1N5n7hCgDKtqgW3gzwBL7O2Df//MQe9w93HSB7YYglKRqhdMmXcMrlPu0/dt1342
	 bQY43m8u/lWTZud83ARQAn5gan2m6cPrAE5TMXWVxyCxZJagRBm9nEkjfhn6u2zAiQ
	 pgbevznH93THKjsL+Ki2AoyUyXftlBFtb/zZNWt+0fI537vP2UpbnnFQpjVIDe4Y30
	 RR+H73mmkttslpfh6PWjNcYFGRDZeoLZ+FnyIEEhVz34VjzXpcMje1pKPnt3qu//mx
	 o81bBth7r4ANA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5A1B6076D;
	Tue, 21 Jul 2026 00:38:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F3228EB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 00:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D8D3B4065E
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 00:38:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K6zf6SCfNtQf for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 00:38:34 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 858EB40782
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 858EB40782
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 858EB40782
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 00:38:32 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B996844F6; Tue, 21 Jul 2026 02:38:31 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CECA82991
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 02:38:28 +0200 (CEST)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6a38e51ae95so3254504eaf.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 17:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784594307; x=1785199107;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DUMhpJcH0KSZf5J9+hKkgxSM0vK8TRCHaSrFcBxyoKE=;
 b=o+n5dP2hDjIMhawKU+QmEl83tqTP8zdM2ua9WvthTEApr/cHNU3+hhaHlABbUGDuCz
 oLJvF4HhJy2HkKhGwNTB0TxcTa7acDspADKvBql60JvnBke3ZrjKECRt4Kf8+s94GLAd
 PpUSoRkCyWNG4CLiNFZWD6xVNZ9PZtjbZwZ2WIKzRu7n0rIwxhXB8IdtT693dsCzA4cs
 pDecTJj6NLh4CXf2RTIMsSO2pVUAnbrZee1dULGr7JvqIf2iVIuC4OMt3CSKLj/JKPhX
 hoy9/QMXlMyk7eBP7VWKRvaFnsO3YdDmEVHlFB+EbZx91Tiz4EFeAVBCdBZelubKH5L/
 KCZw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr1YMUBUhI3xIM5VB5a52A2/70JrCmaVC7YWa2gST1M34LCGkR5vUa3syomT3YSdoxB39XTxsA=@lists.denx.de
X-Gm-Message-State: AOJu0Yzy1dch9xzgQlvDTRKpn0kW4CMGQOxIg/Eqy0CNCAY8Y6EFotoA
 biYlk6zkQtZJgbCGkOJ67AYNIV1lcD4U90+Y5/45dCeWLp4xg7wplmLrl193K5mvTdM=
X-Gm-Gg: AfdE7ck4VKIzj6S5L8gLrEz5Pe/hJNrWZbm7E74zXdzr7LVIUHbpHtTgqqa6VznIz4s
 uO/IlXHAR9MWap7B0OjrXAFyT51mJd1r+AaI4xvMH7HHB4gzFONJvs5UFQZBZn0ygSfCScc1W41
 hzL4VUCiS/oynugJRxff8MtlMa/r4z/Uiu2IrjbDT6nxSY7gVOy1+4d0502aj7FeoACw6EX2ysW
 acYqUVW2OY4azffTt698mqLcDfvsPbldfiDLu4DstESJ1sU5giSHrVK4vUe52ERJVFz7oztsJG1
 WN44OAZdjcX2O3ERctxHz8PfAF7abQcE0Mnmo2AsvwIyOcX4WGlK14N+FKjxyk2rzPAqkE/ymtj
 iqhBciEQ8dNgIMj/GobM6zULMXsHmAgwQWwrqqQ//4DxuLUTfuQv9C+bTTJ5q16fGDNhaELgUbo
 I7WfxYBb/3uXToI+CUP4Pk8mXJdJrEUVoMqKcIdHHYquVxjNc0gOGK
X-Received: by 2002:a05:6820:81c9:b0:69e:2cb4:2ed8 with SMTP id
 006d021491bc7-6a5367e83d3mr8247007eaf.26.1784594306919; 
 Mon, 20 Jul 2026 17:38:26 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:8ce6:b98e:1126:f7f0?
 ([2600:8803:e7e4:500:8ce6:b98e:1126:f7f0])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a516c03f36sm9491991eaf.7.2026.07.20.17.38.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 17:38:26 -0700 (PDT)
Message-ID: <7ec5f838-e62c-4a35-afaa-8320901cd8d3@baylibre.com>
Date: Mon, 20 Jul 2026 19:38:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] doc: board: mediatek: document Genio 700 SPL boot
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>
References: <20260718-ccaione-upstream-mt8390-spl-v1-0-1256b6dfda3f@baylibre.com>
 <20260718-ccaione-upstream-mt8390-spl-v1-4-1256b6dfda3f@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260718-ccaione-upstream-mt8390-spl-v1-4-1256b6dfda3f@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784594307; x=1785199107; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DUMhpJcH0KSZf5J9+hKkgxSM0vK8TRCHaSrFcBxyoKE=;
 b=K7SHz/w4nfoNsrIgVn1PqMQTzJ0fSZ9LZRDtxsfo4+Jookhpkk2CnXEDV9F0ROtjGI
 nzfqzcD0I5rAhKUCEfEjChx79A97yIQNZbn9q0rAA+mI0kDFewI/oN9mNuhy1Q5tZZPA
 12msTgktdhIsYhTd2MPw4hgSpbWbc3TcNaEFxyGZ+tVTsGceT8Xd/bAhF9EZ1bvjEYN5
 uGNPQ+AGMStSOUo8fUMWQ5MGRFT7m40QSmAfWh+mdT3EKJ7iSu14gnC534HUxLTwMvUK
 ci7AkQdBfKWGDVnrQauJfYE7ECcCFS0E1Ah84mNeT5H0NAtGyBf8CusgVt1txOr1WL2n
 Sn7A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=K7SHz/w4
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dlechner@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="K7SHz/w4"; 
 dkim-atps=neutral
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
From: David Lechner via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: David Lechner <dlechner@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/18/26 11:16 AM, Carlo Caione wrote:
> Document the normal eMMC boot chain, external firmware prerequisites,
> binman build invocation and generated images.
> 
> Also describe storage mapping, handoff details, verification steps, and
> current security and recovery limitations.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  MAINTAINERS                                 |   1 +
>  board/mediatek/MAINTAINERS                  |   1 +
>  doc/board/mediatek/index.rst                |   1 +
>  doc/board/mediatek/mt8390-genio-700-evk.rst | 168 ++++++++++++++++++++++++++++
>  4 files changed, 171 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e5b2a2e373c..116a7fe3423 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -421,6 +421,7 @@ F:	arch/arm/dts/mt*
>  F:	arch/arm/mach-mediatek/
>  F:	arch/arm/include/asm/arch-mediatek/
>  F:	board/mediatek/
> +F:	doc/board/mediatek/

This is no longer needed since [1].

[1]: https://lore.kernel.org/u-boot/20260617024105.152655-1-marek.vasut+renesas@mailbox.org/

I can fix up when applying if nothing else comes up.

>  F:	doc/device-tree-bindings/phy/phy-mtk-*
>  F:	doc/device-tree-bindings/usb/mediatek,*
>  F:	doc/README.mediatek
> diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
> index efd38d52338..bcf5fe66a1e 100644
> --- a/board/mediatek/MAINTAINERS
> +++ b/board/mediatek/MAINTAINERS
> @@ -26,6 +26,7 @@ F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
>  F:	configs/mt8188.config
>  F:	configs/mt8370_genio_510_evk_defconfig
>  F:	configs/mt8390_genio_700_evk_defconfig
> +F:	doc/board/mediatek/mt8390-genio-700-evk.rst
>  
>  MT8195/MT8395
>  M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
> diff --git a/doc/board/mediatek/index.rst b/doc/board/mediatek/index.rst
> index c55d5aeb5c4..09038e29152 100644
> --- a/doc/board/mediatek/index.rst
> +++ b/doc/board/mediatek/index.rst
> @@ -7,3 +7,4 @@ Mediatek
>     :maxdepth: 2
>  
>     mt7621
> +   mt8390-genio-700-evk
> diff --git a/doc/board/mediatek/mt8390-genio-700-evk.rst b/doc/board/mediatek/mt8390-genio-700-evk.rst
> new file mode 100644
> index 00000000000..152e5e35fa5
> --- /dev/null
> +++ b/doc/board/mediatek/mt8390-genio-700-evk.rst
> @@ -0,0 +1,168 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. Copyright (C) 2026 Baylibre SAS
> +
> +MediaTek Genio 700 EVK
> +======================
> +
> +The MediaTek Genio 700 EVK is based on the MT8390 product, which uses the
> +MT8188 SoC. The board is configured with

This doesn't sound right. It is based on MT8390 SoC. It is DT compatible with
MT8188, but I don't think that is worth mentioning here.

> +``mt8390_genio_700_evk_defconfig``.
> +
> +Boot chain
> +----------
> +
> +The normal eMMC boot chain is::
> +
> +   BootROM
> +     -> external DDR loader

What does "external" mean in this context? Proprietary?

> +     -> U-Boot SPL
> +     -> Arm Trusted Firmware-A BL31

Put BL31 in () to be consistent.

> +     -> OP-TEE (BL32)
> +     -> U-Boot proper (BL33)
> +
> +The BootROM loads a MediaTek image from the eMMC boot0 hardware partition.
> +This image contains an external DDR loader followed by U-Boot SPL. The DDR
> +loader initializes DRAM, copies the fixed ``CONFIG_SPL_MAX_SIZE`` byte SPL
> +region to ``CONFIG_SPL_TEXT_BASE`` and enters SPL at EL3 with exceptions
> +masked.
> +
> +SPL reads a FIT image from partition 1 of the eMMC user area. The FIT contains
> +BL31, OP-TEE, U-Boot proper and the U-Boot control devicetree. SPL uses the

Inconsistent use of BL31 and application names.

> +standard FIT and Arm Trusted Firmware handoff code to start the remaining

s/handoff/hands off/

> +stages.
> +
> +The external DDR loader is a platform firmware component and is not built by
> +U-Boot.
> +
> +Build prerequisites
> +-------------------
> +
> +The following external binaries are required:
> +
> +``ddr-loader.bin``
> +   The MediaTek DDR loader for the board. The input may be shorter than
> +   ``0x4b000`` bytes; binman pads it with zeroes to the offset reserved before
> +   SPL. It must have been built with ``SPL_OFFSET=0x4b000``,

Inconsistent formatting. Should be ...

``SPL``
  It must ...

?

> +   ``SPL_SIZE=CONFIG_SPL_MAX_SIZE`` and an SPL destination and entry address
> +   matching ``CONFIG_SPL_TEXT_BASE``.
> +
> +``BL31``

Why is this BL31 instead of TF-A?

> +   The path to the TF-A BL31 binary built for MT8188/MT8390. It is loaded and
> +   entered at ``0x54601000``.
> +
> +``TEE``
> +   The path to the OP-TEE binary. A standard OP-TEE v1 ``tee.bin`` image is
> +   supported. The FIT loads it at ``0x431fffe4`` and enters it at
> +   ``0x43200000``.
> +
> +These binaries must match the board memory layout and its firmware security
> +policy. Place ``ddr-loader.bin`` in a directory which can be passed to binman
> +with ``BINMAN_INDIRS``.
> +
> +Building
> +--------
> +
> +For example, with the DDR loader in ``/path/to/firmware/ddr-loader.bin``::
> +
> +   $ export CROSS_COMPILE=aarch64-linux-gnu-
> +   $ export BL31=/path/to/bl31.bin
> +   $ export TEE=/path/to/tee.bin
> +   $ make O=build TEE="$TEE" mt8390_genio_700_evk_defconfig

Isn't it redundant to have TEE="$TEE" since it was exported above?

> +   $ make O=build BINMAN_INDIRS=/path/to/firmware \
> +         BL31="$BL31" TEE="$TEE"

Same here for BL31 and TEE.

> +
> +``TEE`` must be set for both configuration and compilation. U-Boot uses its
> +presence during configuration to enable the support needed to preserve the
> +OP-TEE reserved-memory nodes in the devicetree passed to the operating system.
> +Do not deploy images if binman reports that it used fake or missing external
> +blobs.
> +
> +Building standalone binaries
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The external binaries are packaging inputs rather than U-Boot compilation
> +dependencies. To build only U-Boot proper and SPL, request their targets
> +directly::
> +
> +   $ make O=build mt8390_genio_700_evk_defconfig
> +   $ make O=build u-boot.bin spl/u-boot-spl.bin

Do we really need O=build in all of the examples?

> +
> +This produces ``build/u-boot.bin`` and ``build/spl/u-boot-spl.bin`` without
> +building ``mtk-boot.bin`` or ``bootloaders.img``. The DDR loader and BL31 are
> +not needed in this case.
> +
> +The presence of ``TEE`` during configuration enables the U-Boot support needed
> +to preserve the OP-TEE reserved-memory nodes. Set ``TEE`` during configuration
> +if the resulting ``u-boot.bin`` will later be used in a boot chain containing
> +OP-TEE, even when the standalone target does not read the file.
> +
> +A complete build without the external binaries can instead be requested with::
> +
> +   $ make O=build BINMAN_ALLOW_MISSING=1
> +
> +The standalone binaries from such a build remain usable, but the packaged
> +images contain fake external blobs and must not be deployed.

How is it usable if it can't be deployed?

> +
> +Binman produces two deployable images in the build directory:
> +
> +``mtk-boot.bin``
> +   A MediaTek eMMC image with load and entry address ``0x201000``. It contains
> +   the DDR loader, padded to ``0x4b000`` bytes, followed by U-Boot SPL padded
> +   to ``CONFIG_SPL_MAX_SIZE``. The fixed regions make every byte copied by the
> +   external loader part of the BootROM-loaded image.
> +
> +``bootloaders.img``
> +   A FIT image containing BL31, U-Boot proper, OP-TEE and the U-Boot control
> +   devicetree. Each component has a SHA-256 hash.
> +
> +Binman also creates ``mtk-boot.map`` and ``bootloaders.map``. These show the
> +offset and size of every component. The FIT can be inspected with::
> +
> +   $ dumpimage -l build/bootloaders.img
> +
> +Installing
> +----------
> +
> +Use the board provisioning tools to place the images as follows:
> +
> +===================  ================================================
> +Image                Destination
> +===================  ================================================
> +``mtk-boot.bin``     Start of the eMMC boot0 hardware partition
> +``bootloaders.img``  GPT partition 1 in the eMMC user area
> +===================  ================================================
> +
> +The standard Genio 700 partition layout names GPT partition 1
> +``bootloaders``. SPL selects the partition by number through
> +``CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION``; it does not locate it by name.
> +
> +Writing an invalid image to eMMC boot0 can make the board unbootable. Preserve
> +the platform recovery path and any backup bootloader partition while testing.
> +Selection of a backup partition is not implemented by this SPL configuration.
> +
> +Using Genio Tools
> +~~~~~~~~~~~~~~~~~

Probably deserves an external link on where to get genio-tools and pre-build
images.

> +
> +``genio-flash`` needs a Genio image directory containing the partition
> +metadata and a compatible download bootstrap. To update only the primary boot
> +chain while retaining the backup bootloader partition, run::
> +
> +   $ genio-flash -P /path/to/genio-image \
> +         mmc0boot0:/absolute/path/to/build/mtk-boot.bin \
> +         bootloaders:/absolute/path/to/build/bootloaders.img
> +
> +Genio Tools uses the default bootstrap from the image directory. Keep
> +``bootloaders_b`` unchanged until the new images have been tested. Add
> +``--dry-run`` to check the selected files and partitions without accessing the
> +board.
> +
> +Limitations
> +-----------
> +
> +A successful boot prints banners from U-Boot SPL, BL31, OP-TEE and U-Boot
> +proper.
> +
> +The generated images are not signed. Production signing, rollback protection
> +and provisioning are platform integration responsibilities. The images only
> +establish the firmware boot chain; operating-system boot policy remains
> +independent and uses the normal U-Boot facilities.
> 

