Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960BCC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 10:19:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1765B87732;
	Wed, 27 Dec 2023 11:19:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jPQ75CtG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1E9A8796E; Wed, 27 Dec 2023 11:19:41 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C22808770A
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 11:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50e7e6283bdso1451510e87.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 02:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703672379; x=1704277179; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ee1CsoNM0WDOReE7cSTtVaDRiiMF1Fow6RNehkmP5Nc=;
 b=jPQ75CtG7qgvC+edBNYV3n80yytP8VRC2GPCzOU0tuCsoTafnDM5WPOLgAFHFc7rUj
 1V3eU+lAVb8dsYp4H2Rvbknm5dMff/BHB3+SkBc/vVEoxsxtdxWW1gCwni/QSwy65Kwv
 /AS78PagVQIy+4g3MqJ0t1muh6mB1RNqU+kkcTshzYhtiybm0pwK4I8yHYWZClEWL8gr
 NnLbkAfCtu7ZUtg3Ff6pNx+s2VFg518fMRvm/YWP+inHTJfSdnULwaWRiq0FtJLvPa47
 z/g2tMcjy4DBJnOf0fx9KRRnhz1d+UYC2YK7B6KKAGqrudTZsiruxoBAlM22wcRzRuk2
 Z9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703672379; x=1704277179;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ee1CsoNM0WDOReE7cSTtVaDRiiMF1Fow6RNehkmP5Nc=;
 b=WkGjnecGBjAx3dJZ54xW5LRbHg4iY/vgyLfHAsoUOdI5JUKJLzifkduNmIjboyuMq4
 UAcAyhsJ+3BIU10OyPJiyw0l5OM1pzZ+eV4aQswfvszMXrtxnygaYY8yuQ0OOQYqh7sP
 MjCvo1I+PrmBEMAZ8+Es28lPorWwfYOBM3gudnLPO8hS6L1vEjfwOtbqKD1RcdBu63xF
 +w33LHjGc89kIaTsEIljExOp7y4ANHc+Vlo1WHUkEdZafDqkV9YQBDRqDBNnuDTIB9OG
 wSFaPxIyE0nhcRymbS2ppzpNSFFQmeKyyaHtHK4QV76n3Fs77n+NUgGKEEUpDc6uVuOS
 pbzA==
X-Gm-Message-State: AOJu0YwUhaAaCA90/GFM1dfkrurwvZymFai4IDx84Ep/HbMtMJpckfVY
 6U05H8UuzFVGsd73gzB8atKXjdqH6atDKeTOpuyCNeks8ytVOA==
X-Google-Smtp-Source: AGHT+IGcAHUZgToxqxuPLS1PF8TjMBrE7GML1sWQzlC2UvWK3GKZieXsjFazjh+MVL7/u7o622TqaBpY83uZ/wz5GHc=
X-Received: by 2002:a05:6512:3d15:b0:50e:76e0:b9b3 with SMTP id
 d21-20020a0565123d1500b0050e76e0b9b3mr941349lfv.0.1703672379053; Wed, 27 Dec
 2023 02:19:39 -0800 (PST)
MIME-Version: 1.0
References: <20231223004429.247301-1-xypron.glpk@gmx.de>
 <20231223004429.247301-5-xypron.glpk@gmx.de>
In-Reply-To: <20231223004429.247301-5-xypron.glpk@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 12:19:03 +0200
Message-ID: <CAC_iWj+iXg+rSY5PgPMzHWfsr6rDvcagsXmaS9U0f+--j2YRjQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] doc: man-page for smbios command
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
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

On Sat, 23 Dec 2023 at 02:57, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Provide a man-page for the smbios command.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  doc/usage/cmd/smbios.rst | 93 ++++++++++++++++++++++++++++++++++++++++
>  doc/usage/index.rst      |  1 +
>  2 files changed, 94 insertions(+)
>  create mode 100644 doc/usage/cmd/smbios.rst
>
> diff --git a/doc/usage/cmd/smbios.rst b/doc/usage/cmd/smbios.rst
> new file mode 100644
> index 0000000000..1ffd706d7d
> --- /dev/null
> +++ b/doc/usage/cmd/smbios.rst
> @@ -0,0 +1,93 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later:
> +
> +smbios command
> +==============
> +
> +Synopsis
> +--------
> +
> +::
> +
> +        smbios
> +
> +Description
> +-----------
> +
> +The smbios command displays information from the SMBIOS tables.
> +
> +Examples
> +--------
> +
> +The example below shows an example output of the smbios command.
> +
> +::
> +
> +    => smbios
> +    SMBIOS 2.8.0 present.
> +    8 structures occupying 81 bytes
> +    Table at 0x6d35018
> +
> +    Handle 0x0100, DMI type 1, 27 bytes at 0x6d35018
> +    System Information
> +        Manufacturer: QEMU
> +        Product Name: Standard PC (i440FX + PIIX, 1996)
> +        Version: pc-i440fx-2.5
> +        Serial Number:
> +        UUID 00000000-0000-0000-0000-000000000000
> +        Wake Up Type:
> +        Serial Number:
> +        SKU Number:
> +
> +    Handle 0x0300, DMI type 3, 22 bytes at 0x6d35069
> +    Header and Data:
> +        00000000: 03 16 00 03 01 01 02 00 00 03 03 03 02 00 00 00
> +        00000010: 00 00 00 00 00 00
> +    Strings:
> +        String 1: QEMU
> +        String 2: pc-i440fx-2.5
> +
> +    Handle 0x0400, DMI type 4, 42 bytes at 0x6d35093
> +    Header and Data:
> +        00000000: 04 2a 00 04 01 03 01 02 63 06 00 00 fd ab 81 07
> +        00000010: 03 00 00 00 d0 07 d0 07 41 01 ff ff ff ff ff ff
> +        00000020: 00 00 00 01 01 01 02 00 01 00
> +    Strings:
> +        String 1: CPU 0
> +        String 2: QEMU
> +        String 3: pc-i440fx-2.5
> +
> +    Handle 0x1000, DMI type 16, 23 bytes at 0x6d350d7
> +    Header and Data:
> +        00000000: 10 17 00 10 01 03 06 00 00 02 00 fe ff 01 00 00
> +        00000010: 00 00 00 00 00 00 00
> +
> +    Handle 0x1100, DMI type 17, 40 bytes at 0x6d350f0
> +    Header and Data:
> +        00000000: 11 28 00 11 00 10 fe ff ff ff ff ff 80 00 09 00
> +        00000010: 01 00 07 02 00 00 00 02 00 00 00 00 00 00 00 00
> +        00000020: 00 00 00 00 00 00 00 00
> +    Strings:
> +        String 1: DIMM 0
> +        String 2: QEMU
> +
> +    Handle 0x1300, DMI type 19, 31 bytes at 0x6d35125
> +    Header and Data:
> +        00000000: 13 1f 00 13 00 00 00 00 ff ff 01 00 00 10 01 00
> +        00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +
> +    Handle 0x2000, DMI type 32, 11 bytes at 0x6d35146
> +    Header and Data:
> +        00000000: 20 0b 00 20 00 00 00 00 00 00 00
> +
> +    Handle 0x7f00, DMI type 127, 4 bytes at 0x6d35153
> +    End Of Table
> +
> +Configuration
> +-------------
> +
> +The command is only available if CONFIG_CMD_SMBIOS=y.
> +
> +Return value
> +------------
> +
> +The return value $? is 0 (true) on success, 1 (false) otherwise.
> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
> index 1a626c03c2..eb2b2311f8 100644
> --- a/doc/usage/index.rst
> +++ b/doc/usage/index.rst
> @@ -102,6 +102,7 @@ Shell commands
>     cmd/size
>     cmd/sleep
>     cmd/sm
> +   cmd/smbios
>     cmd/sound
>     cmd/source
>     cmd/temperature
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
