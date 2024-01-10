Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8ACC4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 14:13:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 877CF87A7B;
	Wed, 10 Jan 2024 15:13:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oAhXGPVP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DFF287A7B; Wed, 10 Jan 2024 15:12:59 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86D8F87A79
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 15:12:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50ec948ad31so2784453e87.2
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 06:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704895976; x=1705500776; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q5cZxNrnMm+kLFMjeuoJp2kdfzQ5cYAOZlFEYVQw1p0=;
 b=oAhXGPVPr6EbC3cxx/3P0Vs8p2M/6uxSMZxpnuDvKc1YuQr2fYdvoRsgPptdp7AUKS
 L6XbWtDvPLh+ZeoQwHhopVbldJWHEzZmzIuTWKuFiPoXX4STuzR+v8Z9jUuxzk5uisvW
 1RbJqF3XfUfXzCKqsa2g9dHryDbhBiNmbUqZuNfUTppteYHIBPRjFBR2v2wQWOFrRVdS
 Z+qovlL5hFihlrtdE1auyP/gdkW037EuM1uRiQ/767oxMv99YpxNxLEv9S5wr0pglVI4
 sT3pPYPvnPeOgX+a6ccCI88j1TyHubNPRKrPct0xHByS5rz4iZhaiJVyKWupooOxrF5l
 38Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704895976; x=1705500776;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q5cZxNrnMm+kLFMjeuoJp2kdfzQ5cYAOZlFEYVQw1p0=;
 b=R3qOgI4CXYmesvyLsgHJG8vhBo8mSqx3n1UDJf1785gExVrJNdHUd3O58j3fwUjojH
 F8GphxDmcUhoy9JGRsEukme+wwgIaVee0yi1zWDQlLBvt9hob2UJVZErNXF3PAKBCh59
 8PuFAPE9DaU7G2fNzwfPSZoCPLiRkk9j6g8y5Hw0AFGsbQmvdwGbPlapa3RB8YdHiw+J
 GGRAjIT34Dd9gJIdxkO3AhQNk2YPqQzzNFZeCKY5h6xZ1Wkb6QdGj9m7rtDm2ve+72b2
 ZSHTLHRaG9gHSGWc5U2C6ZHXx6JG3wogbO3IZA2LvrE56vVF+/w7C33qgpbdp9WCI5fZ
 Efow==
X-Gm-Message-State: AOJu0YywBAyG8iNzb+FaziKJQcMVLoeoqTCg2pYRQUP9Rvlca559SP+A
 SwP6UuaL7LgbFTcWlWqLZ87r4t5LpOEEbPSjfS0hhItlAsu7EA==
X-Google-Smtp-Source: AGHT+IFntPMM/zfuU2xmU+0P/S5+kQY+wzd4H8VoC+2mVLEY3lcuvOk83fP8pQAo0lduy8wSipa7kSmw5YljngoKUqs=
X-Received: by 2002:ac2:5938:0:b0:50e:40bf:e0a4 with SMTP id
 v24-20020ac25938000000b0050e40bfe0a4mr381528lfi.132.1704895975884; Wed, 10
 Jan 2024 06:12:55 -0800 (PST)
MIME-Version: 1.0
References: <20240102221237.1007090-1-raymond.mao@linaro.org>
 <20240102221237.1007090-9-raymond.mao@linaro.org>
In-Reply-To: <20240102221237.1007090-9-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 10 Jan 2024 16:12:19 +0200
Message-ID: <CAC_iWjL9zbNWDFk4x=Q3=PVe-zjv441Y52-npjWYW3Pni8PKLg@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] fdt: update the document and Kconfig description
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Nikhil M Jain <n-jain1@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Shiji Yang <yangshiji66@outlook.com>,
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
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

I think this isn't needed anymore after
https://lore.kernel.org/u-boot/CAC_iWjJ6=NjqwcFzVvV4DzMWy5nY_QAeD=vfQrRSjodLbVqroQ@mail.gmail.com/


On Wed, 3 Jan 2024 at 00:14, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Update the document and Kconfig to describe the behavior of board
> specific custom functions when CONFIG_OF_BOARD is defined.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v4
> - Refine the description.
>
>  doc/develop/devicetree/control.rst | 6 +++---
>  dts/Kconfig                        | 7 +++++--
>  2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
> index cbb65c9b17..2b968a6b01 100644
> --- a/doc/develop/devicetree/control.rst
> +++ b/doc/develop/devicetree/control.rst
> @@ -104,9 +104,9 @@ in u-boot.bin so you can still just flash u-boot.bin onto your board. If you are
>  using CONFIG_SPL_FRAMEWORK, then u-boot.img will be built to include the device
>  tree binary.
>
> -If CONFIG_OF_BOARD is defined, a board-specific routine will provide the
> -devicetree at runtime, for example if an earlier bootloader stage creates
> -it and passes it to U-Boot.
> +If CONFIG_OF_BOARD is defined, arch-specific routine and board-specific routine
> +will provide the bloblist and devicetree respectively at runtime, for example if
> +an earlier bootloader stage creates it and passes it to U-Boot.
>
>  If CONFIG_SANDBOX is defined, then it will be read from a file on
>  startup. Use the -d flag to U-Boot to specify the file to read, -D for the
> diff --git a/dts/Kconfig b/dts/Kconfig
> index 00c0aeff89..ac6e1752bb 100644
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -110,8 +110,11 @@ config OF_BOARD
>         default y if SANDBOX || OF_HAS_PRIOR_STAGE
>         help
>           If this option is enabled, the device tree is provided at runtime by
> -         a custom function called board_fdt_blob_setup(). The board must
> -         implement this function if it wishes to provide special behaviour.
> +         a board custom function called board_fdt_blob_setup().
> +         If this option is enabled, bloblist is provided at runtime by an
> +         arch custom function called xferlist_from_boot_arg().
> +         An arch or board must implement these functions if it wishes to
> +         provide special behaviours.
>
>           With this option, the device tree build by U-Boot may be overridden or
>           ignored. See OF_HAS_PRIOR_STAGE.
> --
> 2.25.1
>
