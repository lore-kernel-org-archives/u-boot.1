Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4D1C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 10:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D026082CEA;
	Mon,  7 Apr 2025 12:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d4L/p/C1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0958082DED; Mon,  7 Apr 2025 12:50:24 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0101082CE7
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 12:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ac34257295dso855937566b.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 03:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744023021; x=1744627821; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sieBWciMu51vYGFrzi93jSsb5BXSkPCuKJf064hC79k=;
 b=d4L/p/C1chBs8D/F5YwUYZKIAb8M0WGC9pFntweGRwPXolAysnv0wBs33f/Q5UmAh+
 YXtHwGPnScTP0JGIrUHktCDLQh0WpPUNIgtIUx2lb43LY3rtgjcZ2jznyNlV8AwS3KWT
 yTcMk5ssjJHmcqvamI/hO8zexudzPhkXeK2KY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744023021; x=1744627821;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sieBWciMu51vYGFrzi93jSsb5BXSkPCuKJf064hC79k=;
 b=mZgr2rEFbWSOQuRdyNp4Y5FhtmC2QhK7hF6PyCaB/6mltMGYR4an9sxkqSE68zxfxl
 jb57Eq3MuAvTEXvYG+APVqM72sippKga4Frocsp7zPFkL2DtQwYvCFb38Gdz1BO2dBNI
 4CR0CUpO+bLxuSPQTsXjlLPW9tG8OGz+Z3G9FalczCdKfY5gy0D/uAp/Koo7lDS3d5S5
 WiG0q+b3YG+CsqxolHbOr/Xy3HgOOonYyUC5rzWDZoki/Hku1MK/oKDz0EYi+BJkE4+W
 syzmZayRzWk10PwKgRS7Zv7JERElPdO5n/pFrCLJ/sOg+9BQDeDqBGArSTEGxSvaLJ/D
 84tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBfoJFg6DqH5YImwTWu6DuIayePLA7m7VDduCAsneUN+PHlwRQ6WNgTGTvvkETFy0mSkIgXXI=@lists.denx.de
X-Gm-Message-State: AOJu0YwhH7wswyayMMQzYKiQsAGpbXVoQvV9UPHrwa8DZTmrs4bsR+Lv
 km+jDjf7loNbDAd06wJZ/84Xw2AABUTmD1nBxxwP7syWKmV7EVyrxLdcEd1kIzgPIxw/puThX1E
 +s9aZZ/EtMp6lUuf2Ox7XDgvTMD1esRPyDQ8b
X-Gm-Gg: ASbGncvzbRDiHjaGflZ0x2fJcq9c9OD+RfxEBtnj1NywoGyWzU6993Db43dgS8lquip
 9E7aSop0KefnE+o2yrKWaSLPCFkv2FKXn4eu8+GDYpsm0TN5STpf2koEsM7DAXAN+1qL7Bi722G
 2N7XZWvVHlvox1gvnvqo0H7UGwBSw=
X-Google-Smtp-Source: AGHT+IGfee/eUYFAM+G+t3C7W1Ri232soxXxl6aZlWxxnXbbEzO+Vt84yljqQM1nxq6OjP/V/20vo2iB54oFwOPYcAI=
X-Received: by 2002:a17:907:6d24:b0:abf:d4a9:a096 with SMTP id
 a640c23a62f3a-ac7d6e3d174mr954259366b.37.1744023021196; Mon, 07 Apr 2025
 03:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250407033744.4025-1-ziyao@disroot.org>
 <20250407033744.4025-2-ziyao@disroot.org>
In-Reply-To: <20250407033744.4025-2-ziyao@disroot.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Apr 2025 22:50:07 +1200
X-Gm-Features: ATxdqUEkvGBLtGTMlaY2fk9Ke3vABeBTRPh50pAZhymESJXaUEC9gc-fah_6ymY
Message-ID: <CAFLszTjmabVKuHF8Ym1OENiiBZrSTd2vVjWvHcQkb552qAuhwg@mail.gmail.com>
Subject: Re: [PATCH 1/2] spl: riscv: Disable SPL_BINMAN_UBOOT_SYMBOLS by
 default
To: Yao Zi <ziyao@disroot.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>, 
 Trevor Woerner <twoerner@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marex@denx.de>, Paul Kocialkowski <contact@paulk.fr>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Lukas Funke <lukas.funke@weidmueller.com>, u-boot@lists.denx.de
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

Hi Yao,

On Mon, 7 Apr 2025 at 15:38, Yao Zi <ziyao@disroot.org> wrote:
>
> The default binman configuration of RISC-V wraps proper U-Boot into a
> FIT image instead of shipping a plain image, thus there's no
> "u_boot_any" entry by default. Let's disable the option to prevent
> binman from looking for a plain proper U-Boot image, failing the build
> with message like
>
>   Section '/binman/spl-img': Symbol '_binman_u_boot_any_prop_size'
>      in entry '/binman/spl-img/mkimage/u-boot-spl/u-boot-spl-nodtb':
>        Entry 'u-boot-any' not found in list (u-boot-spl-nodtb,
>        u-boot-spl-dtb,u-boot-spl,mkimage,spl-img)

Do you know where the symbol is being referenced? This sounds like a bug to me.

It is likely to be spl_get_image_pos(), perhaps called from
spl_set_header_raw_uboot().

If you are using FIT that function should not be called.

>
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  common/spl/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 7d6780936d1..356ddab38de 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -214,6 +214,8 @@ config SPL_BINMAN_UBOOT_SYMBOLS
>         bool "Declare binman symbols for U-Boot phases in SPL"
>         depends on SPL_BINMAN_SYMBOLS
>         default n if ARCH_IMX8M || ARCH_IMX8ULP || ARCH_IMX9
> +       # A FIT image is created with default binman configuration of RISC-V
> +       default n if RISCV
>         default y
>         help
>           This enables use of symbols in SPL which refer to U-Boot phases,
> --
> 2.49.0
>

Regards,
Simon
