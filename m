Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547B3D15D82
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 12:04:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C335388E75;
	Mon, 21 Oct 2024 14:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sZdEB4aq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E14D388E75; Mon, 21 Oct 2024 14:04:32 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50F2488E35
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 14:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-71806621d42so2015804a34.3
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 05:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729512269; x=1730117069; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xrCvOewunY8pK+wEUdBGiwCES5LSDl+U/+Jss2IUHkI=;
 b=sZdEB4aqDAY5lWquFyrvN7kDfNeG05oJWYwpTiW9jl8QbaS4Ux26TIX2s/gGN7Vrzk
 zMp7fNdApiWcvfDR12+4CAAPS5Ng+UHXtQBSmVNQchg29vwqrrS0hyhvN+qVRkQJpxws
 2X/QxRSDjMSWgNjG+m66Gxz4Hxevv/gz1tFd9i0UiQI5unP6R5xNX2grEuDlroKI13ml
 /KUBPf71xzSQte7iJ3t3wIYdboWI76E+D/tCHuFGZdAUkNfORciIwesmSra8effoUS+q
 KlDJKEQ8oM4HCjjgR9oOeeTvrP/U3ZWIgMtgMw0iPRUiGDoDSnrcsi5LrqoZ6Lp2NjUa
 qRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729512269; x=1730117069;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xrCvOewunY8pK+wEUdBGiwCES5LSDl+U/+Jss2IUHkI=;
 b=M1hSTOLgDFyDwC03BWnLh25A4eH6WIcxeKWAR/GmgzvqeQsVzMKhBKAdz2IYdQHjOL
 l3vXymHaHUU0PBVtUJGhNDZLJkMu/e029OW9GJ4xJn+HltIQXM7yobJ0Zz75I2t1hG3Q
 LzstHyUMjIeohvRhATxgzwGBZnWKCBrU16XB+f2dL3R3NXux8OPWmkqAbkYcfu15VIQJ
 odXNn1WmGbbwwOIESxB5wye8L5d3O6d/dALnsu/2Y0Zuh84RklfyEse6F2WLJBxD1zyA
 rnFZUCZ8UdxIoInKAGUu8FSIYAlZGn7/23dL3k1E64BbO7Mqz+lSYS/W4r1znWsULSNe
 mQqA==
X-Gm-Message-State: AOJu0YxSuBZGQ1K7Bc7Ns0/ba9VS76xqscXMxuD/ZbNrn7eJWWNH44kT
 7F354p+M0FDr/nvweIfQ3HwF5uNBBEC2BsN3IVHw4ADB19wwAtgvxSrC2S893tlkH9aH/gLDvkC
 D3DzTigBweqgI3UlNrv/wGrv9uCpPFA7fJxBTCQ==
X-Google-Smtp-Source: AGHT+IEPgNdHkcmmNWWVJBH0fAczy/80yzDKb8MBIkO2zBgQeEACPV4wdPHt+zbpPYhS8IozXhqGWjXPzGr1StC4CIQ=
X-Received: by 2002:a05:6808:1801:b0:3df:1306:c74f with SMTP id
 5614622812f47-3e602db2946mr8881774b6e.35.1729512267130; Mon, 21 Oct 2024
 05:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20241018145444.1660219-1-conor@kernel.org>
 <20241018145444.1660219-4-conor@kernel.org>
In-Reply-To: <20241018145444.1660219-4-conor@kernel.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 21 Oct 2024 17:34:16 +0530
Message-ID: <CAFA6WYMgE-qmKwaDx=88eL-HmHCYdG-Sevp=p8tH4ZDPgR=P9A@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] riscv: dts: mpfs: migrate to OF_UPSTREAM
To: Conor Dooley <conor@kernel.org>
Cc: u-boot@lists.denx.de, Conor Dooley <conor.dooley@microchip.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Cyril Jean <cyril.jean@microchip.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
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

Hi Conor,

Thanks for working on this.

On Fri, 18 Oct 2024 at 20:25, Conor Dooley <conor@kernel.org> wrote:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> The U-Boot copy of the mpfs devicetree has, in general, been neglected
> somewhat in comparison to the one in Linux. Moving to OF_UPSTREAM to
> keep both in sync should serve to eliminate that discrepancy.
>
> Additionally, moving to OF_UPSTREAM will let U-Boot automatically pick
> up the devicetree rework that is in progress at [1].
>
> Link: https://lore.kernel.org/all/20241002-private-unequal-33cfa6101338@s=
pud/ [1]
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> For obvious reasons, there's partial duplication here with Hal's work,
> since we both need the new Makefile:
> https://lore.kernel.org/all/20240930155919.111738-1-hal.feng@starfivetech=
.com/
> ---
>  arch/riscv/dts/Makefile                    |   1 -
>  arch/riscv/dts/mpfs-icicle-kit-fabric.dtsi |  71 ---
>  arch/riscv/dts/mpfs-icicle-kit-u-boot.dtsi |  14 -
>  arch/riscv/dts/mpfs-icicle-kit.dts         | 208 ---------
>  arch/riscv/dts/mpfs.dtsi                   | 511 ---------------------
>  configs/microchip_mpfs_icicle_defconfig    |   3 +-
>  dts/upstream/src/riscv/Makefile            |  13 +
>  7 files changed, 15 insertions(+), 806 deletions(-)
>  delete mode 100644 arch/riscv/dts/mpfs-icicle-kit-fabric.dtsi
>  delete mode 100644 arch/riscv/dts/mpfs-icicle-kit-u-boot.dtsi
>  delete mode 100644 arch/riscv/dts/mpfs-icicle-kit.dts
>  delete mode 100644 arch/riscv/dts/mpfs.dtsi
>  create mode 100644 dts/upstream/src/riscv/Makefile
>

<snip>

> diff --git a/dts/upstream/src/riscv/Makefile b/dts/upstream/src/riscv/Mak=
efile
> new file mode 100644
> index 00000000000..dd2ed0bdfbd
> --- /dev/null
> +++ b/dts/upstream/src/riscv/Makefile
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +include $(srctree)/scripts/Makefile.dts
> +
> +targets +=3D $(dtb-y)
> +
> +DTC_FLAGS +=3D -R 4 -p 0x1000
> +
> +PHONY +=3D dtbs
> +dtbs: $(addprefix $(obj)/, $(dtb-y))
> +       @:
> +
> +clean-files :=3D */*.dtb */*.dtbo

Many of the common Makefile bits were moved by patch [1] to
=E2=80=8Escripts/Makefile.dts. So you should rebase to the latest master
branch. Apart from that, changes look good to me.

[1] https://github.com/u-boot/u-boot/commit/d2061828a4c1b60b44cd2307b6a782a=
c2efbffbe

-Sumit

> --
> 2.45.2
>
